import { Text, Field, Image, Link, RichText, ImageField, LinkField } from '@sitecore-jss/sitecore-jss-nextjs';
import { StyleguideComponentProps } from 'lib/component-props';

type BasicSpotProps = StyleguideComponentProps & {
  fields: {
    heading: Field<string>;
    image: ImageField
    link: LinkField;
    bodytext: Field<string>;
  };
};

const BasicSpot = (props: BasicSpotProps): JSX.Element => (
  <div style={{ float: "left", height: "600px", marginBottom: "24px" }} className="g-round-card__wrap col-md-4 col-sm-6 col-xs-12">
    <div className="g-round-card ">
      <div className="g-round-card__inner">
        <div className="g-round-card__content">
          <Text tag="p" className="g-round-card__heading" field={props?.fields?.heading} />
          <Image style={{ height: "305px" }} field={props?.fields?.image} />
          <RichText style={{ fontSize: "1.6rem", marginLeft: "22px", marginRight: "22px" }} field={props?.fields?.bodytext} />
          <span className="g-round-card__foot">
            <Link style={{ color: "Red" }} field={props?.fields?.link}  />
            {/* <a style={{ color: "Red" }} href={props?.fields?.link?.value.href}>Read more</a> */}
          </span>
        </div>
      </div>
    </div>
  </div>
);

export default BasicSpot;
