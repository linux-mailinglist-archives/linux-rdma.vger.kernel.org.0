Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABC1258A1E
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Sep 2020 10:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgIAINA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 04:13:00 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:35156 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726020AbgIAIM7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Sep 2020 04:12:59 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0818B901013420;
        Tue, 1 Sep 2020 01:12:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=4oO/WKX5EO0h1pzSmmVlQ0lPrMU0tX+xKuCqw5haIZs=;
 b=DNvwCh1nKrkJJ07sTburCLA368FEBqw5D6G7KtbchhDduENx86l/nzY1S/FUgaKQXCvK
 NlCxqc5lkNTVKT0Dsxz8lHSEqQizyQ3AwI5zAq1eB0hF/4m+qM2+S340msM8XzaI0kJH
 IhP6l5rYfAgsldNjcaEWfZRUKHxqaXtno1xrlJrFfgMw3Lnl5EkOdKxftoZ17QfMMk4/
 xsXps5MrcC1l7qRxXmAz7nNPYxntKTv3Am3G6Dcj8qcWvYxUEqvkbyQ4pH4GbtdlDp4N
 JwZCfby2JygGBAoeLowjZy6plFqGvWnzSIZ2bdUBiFo5rJAPSWKSiRLio5p63jzv+QCK Eg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 337phpxrw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 01:12:54 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Sep
 2020 01:12:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 1 Sep 2020 01:12:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oI3SYCns+LgJN2bwNjBTw80z5KTDBLwv6JGq36raSa9wXTDvvtlxTX6mWIAL1+X9gSdkmMO9XtIUsf1FqQOdLQe1HB9RP2+ILFLG/oHXX6gCh6kwaE8YdEbtOwfipy2uI4aUNVIW4/npr3C5uhoxFknpMsUvyi+65lJm/zJRwO4+inUCspaRORZZw0NqruI4y88b9e5VRNWvb+kTzMdA1MpYUgDweqpryXnBamDsyVS2S2qMQR7x0ZsMvbNaOnzhmFOrYAwAbta+tNgjvt/IJvRyym7ziD10bGIymRjxjkSjfnrnDdftRLfgzbXY5V9CF8LbU9mFD+mFwn/mBP3pRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oO/WKX5EO0h1pzSmmVlQ0lPrMU0tX+xKuCqw5haIZs=;
 b=SfhqgmIDmuf8L32sumPrhQxOI9844XPlnRWALj+JZKpQh3t2V35Y8k+rc8NQN8kRGSff6E5fbWqmo+i8H4myx+Cq9Dqzx5Plzu3DocJ/L73yhteDglHy2evoIDf7WXWXONtgFb2E3DVvmz4JE+jqKfbdg/9HAxr0Pa2AD+jV7MQUojn0mogisXTJ3jjYcnRk+jra24RxW+elfNUAmtn2Gwjw/OtxTox6vSJgNyCUYG1YuNrPksoHOD589iA6CIa5Qf1TNgQnT2fgLY92dfha/XjOGMKf16b5cjWf5pJzoPvmpvSTfqQUs5+CaHWykwEnSoDtXjhL2h59r39fahFMCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oO/WKX5EO0h1pzSmmVlQ0lPrMU0tX+xKuCqw5haIZs=;
 b=UMfHbdzjfCWCMlT0o80DAchz8HjrvXk7WVTd14Qe3b24t2AjEx4Vl/rD0Gjp8NDdkU5ggp+mJ+gRp5io9KBGvuNPb463ItZ+C4vqvtYxGxYnJh/qrhChS8DHiKvsE2g7hh4+ElyukBYdjQVTBJa/MHW7j0IP7OtDIx31R2y8yxE=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (2603:10b6:208:163::15)
 by MN2PR18MB3575.namprd18.prod.outlook.com (2603:10b6:208:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Tue, 1 Sep
 2020 08:12:50 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::649c:380b:2191:867c]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::649c:380b:2191:867c%5]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 08:12:50 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Kamal Heib <kamalheib1@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: RE: [EXT] [PATCH for-next] RDMA/qedr: Fix reported max_pkeys
Thread-Topic: [EXT] [PATCH for-next] RDMA/qedr: Fix reported max_pkeys
Thread-Index: AQHWfHzhghsbTrCCfEai8BclyORF5qlTdjiw
Date:   Tue, 1 Sep 2020 08:12:50 +0000
Message-ID: <MN2PR18MB31824D6FD218DFC662AA24A1A12E0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20200827141655.406185-1-kamalheib1@gmail.com>
In-Reply-To: <20200827141655.406185-1-kamalheib1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [93.173.216.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: faa69003-ce20-4d5d-782f-08d84e4ed1d6
x-ms-traffictypediagnostic: MN2PR18MB3575:
x-microsoft-antispam-prvs: <MN2PR18MB3575230524FD8362062078C8A12E0@MN2PR18MB3575.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9vBtekMJOHm29Rtmf+CL1H07qqrg/T6aNsjETwSyfQvoQMv6BYUa3ewMK8GPqamLxg7Rip/Xs+DLC3SZMvn7KqFeyzp0TuvXXlOtvIsshDi26VMKB3G0+7bphm2DEhnq6yo+HhVIO0w6qICswgXet/1OS0jK5JFVStTlN+fgCkhmMHoVx28U+yDEMz4ecqaSKQ84VPa7fg6rq57e2PP4ASzz3dDdQC+s6h9+KhqkiWoIX6vuVCjWToACITmbb58w1X6Hm6H/wg9jN2tzm1+q3r+J7P7NsV7+Y17MwJjhHkERuEVJ4g7Ut+Gb53+ljiCuRZ6trTAQb8oJcgH09o5fLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB3182.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(186003)(4326008)(26005)(52536014)(86362001)(6506007)(71200400001)(5660300002)(2906002)(9686003)(8936002)(66556008)(316002)(110136005)(83380400001)(64756008)(33656002)(54906003)(478600001)(66476007)(76116006)(66446008)(55016002)(7696005)(8676002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: tGGVvL1soosAv4YPK8ot/d/WNwP/eSK59Bk38z822LSZzzDLqBnc5SUJsAF66L/E/5F/4UHQx2i28HeuXJ7u+i1r5BHQDxt33eRBC69BXU4zQIe3n4gT0v5xvLn8NVX2TA+bRZb3CJ9f5AZR/ttYhmohG5iBYG+hNWzm1AfWDF5eHy/HGq1DsqrecvFKE2FhpG7HFs3eCUBfOfdv5ah83agHZqvuY1QjCFhRyZx5VAikKCMidEAXWm/oFb4JdQTtfDok0JySlNwPHe6H0dDPQfLcJYqPsw8tsY9JW3hGCBRw7d/o8LbQssi1j60ahvUuz/GoO3Z0wHg7S1SY+uXk5lcOpCV+GCDOpri/bYi1usOwLICHZSMlhiZalhWnmxBy66ZFraJX4DhOiBXHlZRfRPEGZeo0udz5LN+5u2EYoVkL9QxU6AvR/tAhcRagy+Zngooylldw7u6uUhXd/CLSFGBvQFEEdk+ZlE8DWkqTR2HmQ63SMVV7zqbTDC1G9vcpLXpu0a4Yx0TrDZwSMTlmbtppMOSkUId4o1nzV8LxN0aPflW9ypDk61JsaFHJm5pte2Jp1i23q7oPZFFxfTOI0oJfNWjira+t3CUzSXrKv+7PAGCldBktZJHOL9lNqRxXuGUPICOZeFuKtYCNeSRW/Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB3182.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa69003-ce20-4d5d-782f-08d84e4ed1d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 08:12:50.6485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jhRaPDS9m7FxFIkt7yT56JkfHQ0ySwx30SCAsB7HuA6Ap2vZNWTIrGSs3bY4AGhrXrcdayB2fjEMKl7JyaU7zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3575
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-01_04:2020-09-01,2020-09-01 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Kamal Heib <kamalheib1@gmail.com>
> Sent: Thursday, August 27, 2020 5:17 PM
>=20
> ----------------------------------------------------------------------
> As qedr driver supports both RoCE and iWarp, make sure to set the
> max_pkeys only when running in RoCE mode.
>=20
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/qedr/verbs.c         | 2 +-
>  drivers/net/ethernet/qlogic/qed/qed_rdma.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/qedr/verbs.c
> b/drivers/infiniband/hw/qedr/verbs.c
> index 4ce4e2eef6cc..1d1d5628bfc7 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -157,7 +157,7 @@ int qedr_query_device(struct ib_device *ibdev,
>=20
>  	attr->local_ca_ack_delay =3D qattr->dev_ack_delay;
>  	attr->max_fast_reg_page_list_len =3D qattr->max_mr / 8;
> -	attr->max_pkeys =3D QEDR_ROCE_PKEY_MAX;
> +	attr->max_pkeys =3D qattr->max_pkey;
>  	attr->max_ah =3D qattr->max_ah;
>=20
>  	return 0;
> diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.c
> b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
> index a4bcde522cdf..03894584415d 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_rdma.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
> @@ -504,7 +504,8 @@ static void qed_rdma_init_devinfo(struct qed_hwfn
> *p_hwfn,
>  	dev->max_mw =3D 0;
>  	dev->max_mr_mw_fmr_pbl =3D (PAGE_SIZE / 8) * (PAGE_SIZE / 8);
>  	dev->max_mr_mw_fmr_size =3D dev->max_mr_mw_fmr_pbl *
> PAGE_SIZE;
> -	dev->max_pkey =3D QED_RDMA_MAX_P_KEY;
> +	if (QED_IS_ROCE_PERSONALITY(p_hwfn))
> +		dev->max_pkey =3D QED_RDMA_MAX_P_KEY;
>=20
>  	dev->max_srq =3D p_hwfn->p_rdma_info->num_srqs;
>  	dev->max_srq_wr =3D QED_RDMA_MAX_SRQ_WQE_ELEM;
> --
> 2.26.2

Thanks,=A0

Acked-by: Michal Kalderon=A0<michal.kalderon@marvell.com>


