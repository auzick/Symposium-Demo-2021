import { Text, Field, Link, RichText, ImageField, LinkField } from '@sitecore-jss/sitecore-jss-nextjs';
import { StyleguideComponentProps } from 'lib/component-props';

type BasicSpotProps = StyleguideComponentProps & {
  fields: {
    heading: Field<string>;
    link: LinkField;
    bodytext: Field<string>;
  };
};

const BasicSpot = (props: BasicSpotProps): JSX.Element => (
  <div style={{ float: "left", height: "600px", marginBottom: "24px" }} className="g-round-card__wrap col-md-6 col-sm-6 col-xs-12">
    <div
      className="g-round-card "
      style={{  border: "solid 1px black", paddingTop: "22px", paddingBottom: "22px" }}
    >
      <div className="g-round-card__inner">
        <div className="g-round-card__content">
          <Text tag="h2" style={{ marginLeft: "22px", marginRight: "22px" }} className="g-round-card__heading" field={props?.fields?.heading} />
          <RichText style={{ fontSize: "1.6rem", marginLeft: "22px", marginRight: "22px" }} field={props?.fields?.bodytext} />
          <span className="g-round-card__foot">
            <Link style={{ color: "Red", marginLeft: "22px", marginBottom:"4px" }} field={props?.fields?.link}  />
            {/* <a style={{ color: "Red" }} href={props?.fields?.link?.value.href}>Read more</a> */}
          </span>
        </div>
      </div>
    </div>
  </div>
);

export default BasicSpot;
