Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B30269EB8
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Sep 2020 08:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgIOGmB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Sep 2020 02:42:01 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:35356 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726033AbgIOGl6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Sep 2020 02:41:58 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08F6efLj015297;
        Mon, 14 Sep 2020 23:41:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=3dXLFC54b4sW8rG3UbE4/d7UfadNpTH2A9mCDC2GaPQ=;
 b=CkjzDYNuzPfZHzQernB75YR8QQI6E+rwaYsJhRt8/8bK2KA9R/xRAlG5kj4mpDVvkt18
 JEmpCiNBOqI2SLgzGUWG8CGaf6HA/68ygkX9FGT119iHyrnpcfopOTrN7CzH2aw2TG+1
 AeZhUXZ8gkWXHxwdJpbfkIS++EgsXeWIWg4fTmsp5U6qzYpZrijqEmc/OijFaJujwaSk
 UZ30gldexEPPuq6JFjlrkXDvUjvWFGRoYYcrqHh2KoxW1kl+Mqfm+queHmxlZefV2A7f
 vPL2DCyGuz3PUzQN7iMjJeysuBEJFEfOmbIe6NxrFSdIa6S5zex0lVdGoQdtIFaqD+z7 ZA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 33gwumyq9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 23:41:53 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 14 Sep
 2020 23:41:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 14 Sep 2020 23:41:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1ayUPAdUWAsREC4w9s/3CoUOU8wvV4cr3xM5VPaAXo4Ag5JwDNbecqzFkaYTSRoRI1wb/jj41eGjVsxaJ9pRkiaLSFMDItwLeriZI4lOi7WxHk3STOyY7iGgARjqxjDek674JNtt+TIyIEOIJFP29Ot22U0bYVEc6RKSQho/08SeW5JvPGBzd8rw+Cc82sDXCEzG0SDtzQBwqz4HuDBVPsUHXN8bAVwApcp8JkUlZuk3cjplQc5ZFHfjB7lDYLDSMIGkbd+MuBU5S1g9KPDiLAmGMX+8YcaLcvoiB5CGzNvo9Z+rgqyxP/OWJou3mYqF/ERuhe2sacq67uC3cxe3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dXLFC54b4sW8rG3UbE4/d7UfadNpTH2A9mCDC2GaPQ=;
 b=kIQ1mkBkfiiFAClzvou9Y01H0sSGPIRX4hhDp/XosB1T1L1X/5hutNc5DEfq/L2Z9I5+xRwE5qImOKh0B8UYJUCRdL6bJSXSg4ROWpBQDz09hZC+ZT2tzIK5AP2O4XQZZAIrogmrZwxhkjsODAhlChgQ+W0QbVLWMpRtVRH5u69R2lWQuYPNOQ11jPHGyNzjwD8LxPzpRCwqP0UCfzjCpE6scYYP+PLenkDm1N21CM2mJkVAvTNsgvY53aWr1AY1Rdaif3NPc7dY37PnvL5VtzZefLnyWb8i4G3UMPZ1ShLNVP5PJs3oUh4bNPJjDp/sMHS0TScGKz3cUYg1e21Usw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dXLFC54b4sW8rG3UbE4/d7UfadNpTH2A9mCDC2GaPQ=;
 b=QUzQ72Ua7EJdsT82mPcvyuyvvvq+z0v6HUX2IwhX4DgG2v0MRS9pBWfMuhKXr7/Usso0FvY1aNa51id66oVtHin0+dY5lZWiu74FApLlLro4IWR/Da/o15vqZzvZmmYQvYpOspv7DQ/drv4Pw5lWADrL3tgHScZSEN+h2cVpEkY=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (2603:10b6:208:163::15)
 by BL0PR18MB2193.namprd18.prod.outlook.com (2603:10b6:207:4b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Tue, 15 Sep
 2020 06:41:51 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::b0d9:d41f:16e6:afca]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::b0d9:d41f:16e6:afca%3]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 06:41:51 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
CC:     "takafumi@sslab.ics.keio.ac.jp" <takafumi@sslab.ics.keio.ac.jp>,
        "Ariel Elior" <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        Yuval Bason <yuval.bason@cavium.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH v3] qedr: fix resource leak in qedr_create_qp
Thread-Topic: [EXT] [PATCH v3] qedr: fix resource leak in qedr_create_qp
Thread-Index: AQHWiDpkaTjQLSAW0EKfdzH4wvIvh6lpRgvw
Date:   Tue, 15 Sep 2020 06:41:50 +0000
Message-ID: <MN2PR18MB3182462A13AED5F457796841A1200@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <AEYrHjmsd4Sp2R54y55pVL3CXr1KXedoBnTEczCBkpE9+SsFNg@mail.gmail.com>
 <20200911125159.4577-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
In-Reply-To: <20200911125159.4577-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sslab.ics.keio.ac.jp; dkim=none (message not signed)
 header.d=none;sslab.ics.keio.ac.jp; dmarc=none action=none
 header.from=marvell.com;
x-originating-ip: [46.116.37.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6dff315-cbc9-4dfd-d012-08d859426d65
x-ms-traffictypediagnostic: BL0PR18MB2193:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR18MB2193F8D78240FC0CA2F9E5F6A1200@BL0PR18MB2193.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v6qK2Rbz3IVtQuYNlEDp5gFqAGdp4hR//Ghx/mlKkj+yqxPC6UdTQeRa01RFH8OtFmDxl8sFSQeL8XPsmukJLIBPsp4aRbFyYZf31cn6ih/GBXFh4hnFeFyHyPI1fIEaFeT/NkNnsxgtzrduE8iKqYLEFQkds1Dz/8+PzuSugnIIB7rZW63pIuEa8pOF2OjTsxNIV/599y4oosGsLNHMuM20899gb+WNG+JBRE7XoxjOIIIj2j8gRH1c+A+wKH7+jx9TvRF2cS3nxZCczYjkumUNjsVkXchSVLDbnkCWIU0sPmyLm1DEE5UQ5GEaoP3B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB3182.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(376002)(346002)(366004)(396003)(2906002)(6506007)(76116006)(186003)(26005)(478600001)(4326008)(33656002)(83380400001)(9686003)(7696005)(55016002)(71200400001)(64756008)(66946007)(86362001)(8676002)(66476007)(5660300002)(66446008)(316002)(54906003)(8936002)(66556008)(6916009)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 0U1xRA0Dzepsn8KUmbCq6zQZ2ZvleVWBk9YaP0FERF8kQTDMTSj5jUBsnK1MPhvuVinyPM7GP8j8jAB7Q7xwWZ7yQ0lrwdFAoAy+vc1ZEPouMx5A1qbfog8VwbcbAMzxV3+gCryWgsRFWdCxG/08gdbItYjl06eii0Pk99si5jL/VVudE4eFp+sWyYkAqDvh3LAdmdR1yTKLoWFj32L2REV9/VHpDMdBOzBwrZokxTzRBfKb6+N3e+L4xOyxoPu6nOtPTF2Kc/6Tih3EzYba+Ry9lmTYsv/4T1ZVSF40y9fwh77s9JXKQo74J57xfIwQ4iVzIE9eWJIgoUA+5Dn/FYPTwb8yh06GS8FuhSgONhzn7VTWD6htmE/lVdu7mLnVogqOvzFAqdk2q3ZRVi6XNFfVfpWkSE6+fyVVJELB5aqdj4PgeuQSETyW1MeB7QgukY/d9ROw6ZgF9ien6PS8Ogv/rIOvDS/GOlXasjpioO4oqmJiAWoRW1808n7U42zYXG7IbW81qfimx9oKLmWzR3U0hC77sVRQBLIKod8NPq4Q2qva1LusmZXR7c+8qavc1w8DcrX2Cpjd0zm9KcWREjBpDItwEkiZe/iAvtU6Lix2PRTRvunF7dVG7JPuxnYCAsCExIqtBQGi+NFOSUiuvw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB3182.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6dff315-cbc9-4dfd-d012-08d859426d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 06:41:50.8948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zr9UtZRdIm6zvltDFW1QBngFjRqbmdmzoDVVB7nz2lMNVYhyy2+3PseNDpu3wBVNPS57IS1Dn010jXOcrxGvoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR18MB2193
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_04:2020-09-15,2020-09-15 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
> Sent: Friday, September 11, 2020 3:52 PM
> When xa_insert() fails, the acquired resource in qedr_create_qp should al=
so
> be freed. However, current implementation does not handle the error.
>=20
> Fix this by adding a new goto label that calls qedr_free_qp_resources.
>=20
> Fixes: 1212767e23bb ("qedr: Add wrapping generic structure for qpidr and
> adjust idr routines.")
> Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
> ---
> changelog(v3): Fix linebreak of the fix tag
> changelog(v2): Change numbered labels to descriptive labels
>=20
>  drivers/infiniband/hw/qedr/verbs.c | 52 ++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/qedr/verbs.c
> b/drivers/infiniband/hw/qedr/verbs.c
> index b49bef94637e..3b4c84f67023 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -2112,6 +2112,28 @@ static int qedr_create_kernel_qp(struct qedr_dev
> *dev,
>  	return rc;
>  }
>=20
> +static int qedr_free_qp_resources(struct qedr_dev *dev, struct qedr_qp
> *qp,
> +				  struct ib_udata *udata)
> +{
> +	struct qedr_ucontext *ctx =3D
> +		rdma_udata_to_drv_context(udata, struct qedr_ucontext,
> +					  ibucontext);
> +	int rc;
> +
> +	if (qp->qp_type !=3D IB_QPT_GSI) {
> +		rc =3D dev->ops->rdma_destroy_qp(dev->rdma_ctx, qp-
> >qed_qp);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	if (qp->create_type =3D=3D QEDR_QP_CREATE_USER)
> +		qedr_cleanup_user(dev, ctx, qp);
> +	else
> +		qedr_cleanup_kernel(dev, qp);
> +
> +	return 0;
> +}
> +
>  struct ib_qp *qedr_create_qp(struct ib_pd *ibpd,
>  			     struct ib_qp_init_attr *attrs,
>  			     struct ib_udata *udata)
> @@ -2158,19 +2180,21 @@ struct ib_qp *qedr_create_qp(struct ib_pd
> *ibpd,
>  		rc =3D qedr_create_kernel_qp(dev, qp, ibpd, attrs);
>=20
>  	if (rc)
> -		goto err;
> +		goto out_free_qp;
>=20
>  	qp->ibqp.qp_num =3D qp->qp_id;
>=20
>  	if (rdma_protocol_iwarp(&dev->ibdev, 1)) {
>  		rc =3D xa_insert(&dev->qps, qp->qp_id, qp, GFP_KERNEL);
>  		if (rc)
> -			goto err;
> +			goto out_free_qp_resources;
>  	}
>=20
>  	return &qp->ibqp;
>=20
> -err:
> +out_free_qp_resources:
> +	qedr_free_qp_resources(dev, qp, udata);
> +out_free_qp:
>  	kfree(qp);
>=20
>  	return ERR_PTR(-EFAULT);
> @@ -2671,28 +2695,6 @@ int qedr_query_qp(struct ib_qp *ibqp,
>  	return rc;
>  }
>=20
> -static int qedr_free_qp_resources(struct qedr_dev *dev, struct qedr_qp
> *qp,
> -				  struct ib_udata *udata)
> -{
> -	struct qedr_ucontext *ctx =3D
> -		rdma_udata_to_drv_context(udata, struct qedr_ucontext,
> -					  ibucontext);
> -	int rc;
> -
> -	if (qp->qp_type !=3D IB_QPT_GSI) {
> -		rc =3D dev->ops->rdma_destroy_qp(dev->rdma_ctx, qp-
> >qed_qp);
> -		if (rc)
> -			return rc;
> -	}
> -
> -	if (qp->create_type =3D=3D QEDR_QP_CREATE_USER)
> -		qedr_cleanup_user(dev, ctx, qp);
> -	else
> -		qedr_cleanup_kernel(dev, qp);
> -
> -	return 0;
> -}
> -
>  int qedr_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)  {
>  	struct qedr_qp *qp =3D get_qedr_qp(ibqp);
> --
> 2.17.1

Thanks,=A0

Acked-by: Michal Kalderon=A0<michal.kalderon@marvell.com>


