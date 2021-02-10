Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FB2316302
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Feb 2021 10:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhBJJ6V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Feb 2021 04:58:21 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:27054 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230165AbhBJJ4R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 10 Feb 2021 04:56:17 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11A9eLbF004798;
        Wed, 10 Feb 2021 01:55:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=KsmHl9yc9Q2Fpi6gJOMUaXdMCFwAwvH9N9tdnLdCz3c=;
 b=GdGqobP6XqHn6+MzSFw0JLfJBWIFEHPiMOoqcE08dYhXebzP4SxmMKHYtV5TGclr/fmN
 0162d4HrHQ3qDVfjUGRH05+flB3w+mlI9qtfmpqNPy1D9lWrgaGtWeoHy6+kZ2t5tv44
 6TWoTMZpLhVsq9sV7S0wDdNEw1zpUOCpzfOtdVpjU5Dsx2S2r2jlXFWyrJdVATwblfDY
 WRjKIZnz76C2oEuL+llTxnVV76NjOH2m0120unQfgswueQzV9Jf1LOjaf7VImIqUP8s3
 DjV7LzYDO2RD4yt9FxoGPvl47rdzeAqeTvgHPS4dN+wXo2wEDWDH/NyplZn+XVv/RQjY Hg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 36hsbrkgta-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 01:55:32 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 01:55:30 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 01:55:30 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 10 Feb 2021 01:55:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNhiXrTE/FmXMFbl+ac560NHa3xxrdNSBJ0aVNbqjZnLIpb2Qc0dOSNWh95iQVw98LdutvCKECQVz3SxKoPpwR7W9VTit2gTqFyMJ4u642GR/KfqAyLjJLBX3QQkqe+G0ydahxa5dX93a2BFVPbDNObvoDAPRmtKa6OFhGWXLsga0PJn3la6ZQzKbbZRMOUDHrTVPQLiSJ8mk5qh+zYZyMLU8c1Ik8ESC3CXM5Kn9kqzCRlzqFgsU9yWRFdNJPaVgFTMWZd3eGMNlg6h2CuPq14JPmewTU+7ijlXxDvVL4K5EQBpsm3qe7SHC5MFhnYM6kfhvx/GtsMGJxKMecE4Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsmHl9yc9Q2Fpi6gJOMUaXdMCFwAwvH9N9tdnLdCz3c=;
 b=moh52OQf4KOOS3Gs8CdnOso1/iqOBj9ALYRYVaUksUGEV1gy5TOxtctoNxFVfqkpvroJQzOrge7C9LM2y2xR0a5RgAs9KR0V0eHIjvgWAwinyBDps5Barsia0vbYt2qKgZkjyWna4GZD7LvhFatUrHZo9lDRZJA3wYWyzccu17wKkIhp/I+hqO+pNNHe4izUbQ9O0krNe30zNnyhfiW6ANmeE6TW8y9WNZxpBnnZixxL1BZiKzmbTRJLfs4IUtAWuHRj6uWoYFzVu525zq9NyuDXRD0sMCAFjb10ZDmqrcvS7yTpGhcoEijAFKhwgP0vu4GVjRfMDmOsVWH0c4PnHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsmHl9yc9Q2Fpi6gJOMUaXdMCFwAwvH9N9tdnLdCz3c=;
 b=WPbame+P7MhgeM0h6SSXWWYE4FebIc1z2WgqQJkvn+qwLcsfu9ezYs7rA1rKvs1JKaE73rnUrDu3LjEOtp4ESXVWPYID/E2s11IJknDFklaCaD6CIoF/9B1sloylVmfWckWn2XqVDFhnkEsO0Oxl6F0vsbU/B7DOgWlosEVeWmQ=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (2603:10b6:208:163::15)
 by MN2PR18MB3357.namprd18.prod.outlook.com (2603:10b6:208:167::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Wed, 10 Feb
 2021 09:55:29 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::e1a5:c2b3:1ec2:deac]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::e1a5:c2b3:1ec2:deac%3]) with mapi id 15.20.3846.025; Wed, 10 Feb 2021
 09:55:29 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH] DMA/qedr: Use true and false for bool variable
Thread-Topic: [EXT] [PATCH] DMA/qedr: Use true and false for bool variable
Thread-Index: AQHW/5CJ09/VmPHcFkCuor39H+9GKqpRJoLg
Date:   Wed, 10 Feb 2021 09:55:28 +0000
Message-ID: <MN2PR18MB3182287BFB84CA1C1AC7A367A18D9@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <1612949901-109873-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1612949901-109873-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=marvell.com;
x-originating-ip: [46.116.59.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4d9c45f-8f1d-452d-3a9f-08d8cda9ff63
x-ms-traffictypediagnostic: MN2PR18MB3357:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB335748B4C6AC4AB07D000B19A18D9@MN2PR18MB3357.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E2uw0sQ6EviKpwtSnML3kUqEpUWDLVdTmwJhA5KuhJakYU/0tNgm1F8CkJZ9aUwK2Lkq2fXNaTlJIg6DC/ppKHMQSso1L4aMZHJWsYQQLDxM7uHdim7RRaWOuB8XQpbRoltKwDvKWYmHlTqki1xRLuvQQZ9Md6u7O4qOxcbcLBNYIAujTZ1pw5SuWyFXHiCNk+8PG9s5jA2F71fu7oqi9WYerpTTUYa1zXgQfd/bZRjRQkKPxEzullWRh8bnq8tsKVhFsbzf7Ugisdax+0/QZ0DQaoz43CPOVEYiGDe+kIlZ+Lt5/3qB55m9Fn+JF0tmpZnUEnz9R4UuJrLz1yKtw9FX+YPYdQaaF3xvMcUycU3nVXelhv+fdHpokD1JogY1yJLozdRbCvfo2z0ETtil5jT0ZhQ5IXOb5TPBwB2AC4Kh5PJJnrskJoRBGlna1X4bYknBFGV5Jxqb4CUm6Zuv0p18dvb51RTbs/N/niQdFznqAI3DqacGBN3l/+qs7eSRRLlSqCiu2PQJ1aVuHFi0+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB3182.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39850400004)(376002)(136003)(346002)(9686003)(86362001)(55016002)(83380400001)(186003)(478600001)(54906003)(33656002)(6916009)(8936002)(66476007)(76116006)(52536014)(2906002)(8676002)(66556008)(66446008)(64756008)(66946007)(6506007)(4326008)(5660300002)(71200400001)(316002)(7696005)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?EO4MYSSOCvzdOfH++KTkWsRcqPCHDiwguB/AaXKc7RwqIGUyJs0jC2amdT?=
 =?iso-8859-1?Q?iDroJa3tE6bdVjHTdB5+MJUBXKDoUf8M9Or/X1UV26ta1IBxD+1FoXIX04?=
 =?iso-8859-1?Q?5dVNsPRKwlxG67NK0yQc61CVV5TCPF7mRKVXn6kcGAu8lCsIU5KZbsgAN7?=
 =?iso-8859-1?Q?zkxWpWa1E3XV0Pfq6WgOQT6Ye55nAOOVW17oP1XxBrA1QftecchGugv4vH?=
 =?iso-8859-1?Q?8OESEa7RJB5Oigb8DZ8VQefuC8eQOaagtxdam4XzbXAPrz+0IXHoLZHZb3?=
 =?iso-8859-1?Q?s0tXlZxr+3hCD0IRlG4CfgoNZnwn7WA2wQ+p0cKM4xQgXmtrRyE/JC/NWc?=
 =?iso-8859-1?Q?uYCFW3FaZmcsOZuhddQ6bxhvmINigyz7VhFxne4iWN1lMdGHlwqPFQaZWm?=
 =?iso-8859-1?Q?8yRwxBOdikWiutBqqV8RHiHus7mJt73hUqNhj+i41p+6aqsMKNbmAfzrzi?=
 =?iso-8859-1?Q?zDFsBDWj7Yb7+ybfhMuUjjv2kOUe9V1TtR++R/BPO9bAr+6Iyj+7AJPPwl?=
 =?iso-8859-1?Q?6SVZfpttchvxPHjooM/mZW4eALORNjOoDwMLA773Xk0HobCvw5zV/5ZPbJ?=
 =?iso-8859-1?Q?D4ciGkm1HSXBSNQTMUrl/tEJkIN83YRGzF5VBQoDblEjlyVRk6NV4BUdk5?=
 =?iso-8859-1?Q?P3HVX106YG0JQ7AUjRFidCiljiIJ9FIieDeGZ6l8mrIdD+dtEjXarT7mdV?=
 =?iso-8859-1?Q?7K1/UXGKJC2S/cvgNsdo2Hp3hhqjBmGNZhKCnH3Cv10Xc4fs6HrEJVHwl/?=
 =?iso-8859-1?Q?y09EZEnhGFIX004cobZ3QDOqN+zo2oqxf9P9cc4Bk5SgS98MgexlgYwLF4?=
 =?iso-8859-1?Q?DnHf8T8NTWf208jzYf4DK87BZj7n0uFUgD3+E4y0PkMCPj6cGlbJrBXvBW?=
 =?iso-8859-1?Q?tCXkGlnW2Pv5+llIoxHdD1/6rfaWFPL7dIDt3yMdPzXWaQgN3BffHJ9bgP?=
 =?iso-8859-1?Q?FyEk1XsW8cJYIiubrNKvC+wBrXzKRDrg7nevjl/mDk6XXSglrShzQw5Iib?=
 =?iso-8859-1?Q?gypBObfMlOo9m6IS/sIqxlRddebXde1CSwSvFQniaG1jsK0bp/GvjoJnYN?=
 =?iso-8859-1?Q?UwDzdlADVGHN4KAo2cKL7+twSeO0MgzE1S6IbPnJXb0gQsEPq7lEj2qKA7?=
 =?iso-8859-1?Q?RDRCqTHtLGDbguQoJyyub3I5t3yaKKuScHVpski+aNgFJUz57kwFCGzXAb?=
 =?iso-8859-1?Q?7w8ske3Ww+ky3iDfrDUCM+vIX8yEN9Mc/XgdxmuDeGDinvQCOT/O0S2i93?=
 =?iso-8859-1?Q?Y8G0Gbqx3Xe3zEMn5iM/97ZRpWczdd+kEo1RZKWlr+NW6foo2hZL7nPKLx?=
 =?iso-8859-1?Q?j+fL62XWJ3O6GLgODoTu5SJOdsl+Bjlruopat/BzqL+HkvY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB3182.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d9c45f-8f1d-452d-3a9f-08d8cda9ff63
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 09:55:28.9566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CHm9bKBOC0S2bNOga0TcDpDspwnhejr6j5YobRJpN4xh9OgfZOLLzvByGkx92XoZxoTtMBmuixMiq8l0TGCLbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3357
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_03:2021-02-09,2021-02-10 signatures=0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> Sent: Wednesday, February 10, 2021 11:38 AM
>=20
> ----------------------------------------------------------------------
> Fix the following coccicheck warning:
>=20
> ./drivers/infiniband/hw/qedr/qedr.h:629:9-10: WARNING: return of 0/1 in
> function 'qedr_qp_has_rq' with return type bool.
>=20
> ./drivers/infiniband/hw/qedr/qedr.h:620:9-10: WARNING: return of 0/1 in
> function 'qedr_qp_has_sq' with return type bool.
>=20
> Reported-by: Abaci Robot<abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/qedr/qedr.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/qedr/qedr.h
> b/drivers/infiniband/hw/qedr/qedr.h
> index 9dde703..3cb4feb 100644
> --- a/drivers/infiniband/hw/qedr/qedr.h
> +++ b/drivers/infiniband/hw/qedr/qedr.h
> @@ -617,18 +617,18 @@ static inline bool qedr_qp_has_srq(struct qedr_qp
> *qp)  static inline bool qedr_qp_has_sq(struct qedr_qp *qp)  {
>  	if (qp->qp_type =3D=3D IB_QPT_GSI || qp->qp_type =3D=3D
> IB_QPT_XRC_TGT)
> -		return 0;
> +		return false;
>=20
> -	return 1;
> +	return true;
>  }
>=20
>  static inline bool qedr_qp_has_rq(struct qedr_qp *qp)  {
>  	if (qp->qp_type =3D=3D IB_QPT_GSI || qp->qp_type =3D=3D IB_QPT_XRC_INI
> ||
>  	    qp->qp_type =3D=3D IB_QPT_XRC_TGT || qedr_qp_has_srq(qp))
> -		return 0;
> +		return false;
>=20
> -	return 1;
> +	return true;
>  }
>=20
>  static inline struct qedr_user_mmap_entry *
> --
> 1.8.3.1

Thanks,=A0

Acked-by: Michal Kalderon=A0<michal.kalderon@marvell.com>


