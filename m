Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDE025AF39
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 17:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIBPf3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 11:35:29 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:15506 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728355AbgIBPfX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Sep 2020 11:35:23 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 082FPnoJ020796;
        Wed, 2 Sep 2020 08:35:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=81jSOJg3QDYrAGJn+a/ce2+gJr2zkVnTGeDbftGswTc=;
 b=DKmaFxn0laJPsurr4iJaiwPvlGpaMReOePb5OpzbUWdDeW9ctG9yfWTscATbM8fdXWV2
 rVsPsIZlsUvkIU7YMceoU8sgqDhYTavHkzvgqGBoS8fKQqnMfOcAv8GNr31b9LteEzpk
 zjZnbxRUrls3wLucpUkWbng3Ry+PlxxrRtzUG193MfzcJqjCB9MmvrXOCf+dGads0jp1
 zib3ExuCBlgD2fa0Ag1MTG5Z3rKFe4WhwV/LbzauBwKKkYC839nXREt+afiBD3uwGPrY
 mOzW2f5e+23zq5pSHMgeYNvHJzfSJSFySTLgD1FqZxHDtPwcpnXcwiKXT4915J4t42kF iA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 337phq75du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 08:35:19 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Sep
 2020 08:35:18 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Sep
 2020 08:35:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 2 Sep 2020 08:35:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2a6q6KZPM8Wf0GgqgkTurCGNyK4NEKhtLCWZwJ+4O20bLMxqB+VkVZlMqgd6jALgnj/2pmw4nISUF8c9GGaZcms5wHu2uAgX5Ea7lx9sfUvMgUR8fcsr0I4xX086YffVbCjomXYCjDAhgPHxSyxfKmpaS7BYoPFbE1edW3QhHNC+I4Te4GACY2DTaJtWT9MJwqCpEfQizPsVkSXMArBXcQLHCEVmtdA8YxCtde8g5eTagTVvKPUk3eS5LYEED/pb/Qfqaxgg5T+yzcAPUsz83l0H02Qs/CCONz3/nwJqOhZmIC1iXYgvxw11LgMOmfy3vvCxXnXGLsXiKVZmuFCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81jSOJg3QDYrAGJn+a/ce2+gJr2zkVnTGeDbftGswTc=;
 b=fOoHwt/8ANODmjVKYHuR6h4rjqQtpwB98rN2mcJtvORgzbTWPh62RBw7oTbkI3wZfGrblUwjoSrcOON4gXccGH6wMk0OIUIbA7zqsQ2kJUZGhisnRjkiJBdcKFO1DtmCsP1D9VMZXAH0qRGQHMBC2d1ZujUiqw9KRrU0ZhiQx6on4+K8sDjiNdEVAuNEs36UEwHel5+XA8sprJUzxrrq3+xdll4vWHbjfS0AHTKTCpsqLbPphtdXdT78fnc0LpCut+pX/pHCoGxuzw3jcANNcMulRO6LHUJOhl/8eANg4q4hwm0TswzhRF/GDx3/o7wL8itUPI+f/4zxQ4GsJb47vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81jSOJg3QDYrAGJn+a/ce2+gJr2zkVnTGeDbftGswTc=;
 b=ChsTifVPrWe+5k+ilhAFP6VV6+O/2xZBYJsgBaWJcrRFjq+6wSGdjiJE7KA9m40olSab97MOVWcuTt8xLmSBbaL/6tFKHDaeTMbfEk1K8vBwHolfDM4uf/R7R0SEbct9u24QgZ89lksfpuPDQ3p5F5q86G5PBDyk50RwjoG7Rz4=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3296.namprd18.prod.outlook.com (10.255.237.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Wed, 2 Sep 2020 15:35:15 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::649c:380b:2191:867c]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::649c:380b:2191:867c%5]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 15:35:15 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Ariel Elior <aelior@marvell.com>,
        "Doug Ledford" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] [PATCH 08/14] RDMA/qedr: Use ib_umem_num_dma_blocks()
 instead of ib_umem_page_count()
Thread-Topic: [EXT] [PATCH 08/14] RDMA/qedr: Use ib_umem_num_dma_blocks()
 instead of ib_umem_page_count()
Thread-Index: AQHWgMIiv+kVijlTrEGH0j3PLv5q3qlVe3VA
Date:   Wed, 2 Sep 2020 15:35:15 +0000
Message-ID: <MN2PR18MB3182BA7DDC1543D2BA38F55BA12F0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <8-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
In-Reply-To: <8-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [46.116.57.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 790d5f3f-0066-4e0d-0cf5-08d84f55ca51
x-ms-traffictypediagnostic: MN2PR18MB3296:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3296E66F183EE1AF73963261A12F0@MN2PR18MB3296.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UsMAG5DfcUva0I3Crytm5vfBwb/uESc8JCbRguW/J7qOQHMDJSfOtCy/oHApzoPiZuR2w/qEOxdCrD8152aaNSD5J6UaDE1bJz9w0hE7egj/PkXNc97iYaTkUajtPHV7y78po3e4BquPYvOwKUBRDV73ArgKTtvHyMwnMxCB3plJTXAz2cJPhdX1x9+3tJdgt6F5uTYpzCLJpOyBgYNInYjzu05FKBYSMerdmubL52k7ecwx5yh6qD10JBzqYkTxwtW0F51AhfymSLtpS8w/EQTp8YnFXTnpubjhiOYWTDB6w+iPCAys0lRCdvJvunn9h901a/8vf75wPAF4fXP1jg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB3182.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(366004)(39850400004)(346002)(7696005)(66446008)(76116006)(66476007)(86362001)(66556008)(64756008)(66946007)(478600001)(2906002)(5660300002)(52536014)(33656002)(8676002)(26005)(110136005)(186003)(9686003)(55016002)(83380400001)(8936002)(53546011)(6506007)(316002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: pp52is74mdOnRQ05VdsdY9shWA1z3EsRBBwlc+WkdCtSVxwQ4OlE/1k6VuG9GtVwhsfJ1R5Hcv/yNnuCon3Uet9TgXnG+hUPuJepoCKdd6NbsWqy+9j48OJaMwPOAkPJG3cjU3Q17P5U3dm/sLJSFfnhqzuZpfLmQnJ2AoVVUTsbPv1qbT0XbnfKhPbdFyQJZvXgRTFI3uHiEMeNXBij1jiPyPhAJ+AWa5yN+hJMHRK5owoqoepx+dAL3RclbXlZTIm+ZZc8losb3RVJ82PT0+4l97MwK/ggYU5brnaXuURq6j4SDLYdlUgm/1OZ/9SULdZoGLbR7BNg/1fZotL/m5E+ppvwti3oIntuhJI4yTwrb3v/KRZuuWEbSOPNLveMTDy6Jd631xtYkHU3m+ooOOaP24HND/E/y85GOuiK/vZgcYq7/Fvshyi8eR1ouGtcTfBxxfJx6KIktSR9HKSXKvKqq/zqR8x3aOTmy03ZJ9VHb9a4cIMKz3cWJ35mAuI6IEf8NipQ+Vq8/ZKtPWckdfAWcSA6Ey9ZyYVftG9h2Oit4jZ/yZdelM1nEbOBC2QdupRjt/eD0hGXm+kfSkDgb8prwIsTrZqqAifvAGfAJ54rKihPJe6BCNVX6PE8mmmrraI/wAMoICIa7iCde/GYqg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB3182.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790d5f3f-0066-4e0d-0cf5-08d84f55ca51
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 15:35:15.6160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qkg9KzMzVN1e3uj3eqDjiGKAgFDpruwzMTpcvdwo9Te+AA0hblTxYrdhDEFy0HkMG+Hxz6NDcwFQNX9XtvibNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3296
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_09:2020-09-02,2020-09-02 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, September 2, 2020 3:44 AM
> To: Ariel Elior <aelior@marvell.com>; Doug Ledford <dledford@redhat.com>;
> linux-rdma@vger.kernel.org; Michal Kalderon <mkalderon@marvell.com>
> Subject: [EXT] [PATCH 08/14] RDMA/qedr: Use
> ib_umem_num_dma_blocks() instead of ib_umem_page_count()
>=20
> The length of the list populated by qedr_populate_pbls() should be
> calculated using ib_umem_num_blocks() with the same size/shift passed to
> qedr_populate_pbls().
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/qedr/verbs.c
> b/drivers/infiniband/hw/qedr/verbs.c
> index cbb49168d9f7ed..278b48443aedba 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -783,9 +783,7 @@ static inline int qedr_init_user_queue(struct ib_udat=
a
> *udata,
>  		return PTR_ERR(q->umem);
>  	}
>=20
> -	fw_pages =3D ib_umem_page_count(q->umem) <<
> -	    (PAGE_SHIFT - FW_PAGE_SHIFT);
> -
> +	fw_pages =3D ib_umem_num_dma_blocks(q->umem, 1 <<
> FW_PAGE_SHIFT);
>  	rc =3D qedr_prepare_pbl_tbl(dev, &q->pbl_info, fw_pages, 0);
>  	if (rc)
>  		goto err0;
> @@ -2852,7 +2850,8 @@ struct ib_mr *qedr_reg_user_mr(struct ib_pd
> *ibpd, u64 start, u64 len,
>  		goto err0;
>  	}
>=20
> -	rc =3D init_mr_info(dev, &mr->info, ib_umem_page_count(mr-
> >umem), 1);
> +	rc =3D init_mr_info(dev, &mr->info,
> +			  ib_umem_num_dma_blocks(mr->umem,
> PAGE_SIZE), 1);
>  	if (rc)
>  		goto err1;
>=20
> --
> 2.28.0

Thanks,=A0

Acked-by: Michal Kalderon=A0<michal.kalderon@marvell.com>


