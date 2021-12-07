Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DBD46B9A3
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 11:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbhLGLAf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 06:00:35 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:23160 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235472AbhLGLAe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Dec 2021 06:00:34 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B7A5SWO025093;
        Tue, 7 Dec 2021 02:57:03 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ct5hfg58u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 02:57:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSU6So4B3RPgoAs0s+zIuQ8wkOLNO5TBhTMdupjt1hCoOEeA9/UREkygH/gvO9hUP/il8LlKRjAAFpYmbR9pN4P/7yYyLKhr28Cyyl/9dBSa1rowW0pD1eGj2BxhxxLLptxOKwAa1J5npJLguM14HQiZo+0fvSeqUi2BPmgMqSRnAa2eEhUzmS6e/tv3wXRHlk1WgW3QqWxXwe3vxQCqbj4Bsp6ay4btCApBRKgMKdtclAA7Fglu1ixUIBTGyi/I3dnlfY7M1gA9/ggb8Na+G3STUE9bL3wQfNFHe41sAspthcdSaq5MRZGazHcqesOl7//tQe1NbuE2ZCie0woiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/nOx92aMTBIl8ytc9nCP4U09QkILwMAGfUBPHloUwU=;
 b=kX5DPpa6NV6+0yknjziEZqlTu6Fh3X7M5sDhpnkEG0Amld6tGkejbVDCU0wHLpnJCVE5Y3ChHtYjW3ieKpoLJ2spgO8CLPuiwVbC2KbrOmvsBmL3EhA2u48Yqbp+sk76ZbtOgLjL2fXDJIRhuutBA5tFH6WuVtlqZKC3Z8p99MTY52UOnBsZUpUkj2c9k5EiUnodgi+Mw5TU3yp8E4CLOa2qmzJJ60hHbsYaTI/TUzLosiO6LqZNn0e+mku71KOyS1Jbzj43loU97I+V74nGHL1h09ydrpVo0exJgwSccg4TpWCYfLo30yH6hrortuCykcl/FDkVP3h1+SjCeuK5GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/nOx92aMTBIl8ytc9nCP4U09QkILwMAGfUBPHloUwU=;
 b=NUnsuyZdpB8hX2RS/BUy+mIYmEt6/NIw18GxRDJUwoy7NYhSGWwIgi/MsoNvqsyWnjop7NZ0tuLRyu5bCjKBxvJ1k4faXCuS7hwZO0vlyZFD/f4h1j8ffwJ+TtVqjsddC5qur72OUIY54iz6DaaTgnTG8PMDoBFPH40Skvmo3lE=
Received: from CH0PR18MB4129.namprd18.prod.outlook.com (2603:10b6:610:e0::12)
 by CH2PR18MB3318.namprd18.prod.outlook.com (2603:10b6:610:28::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Tue, 7 Dec
 2021 10:57:00 +0000
Received: from CH0PR18MB4129.namprd18.prod.outlook.com
 ([fe80::1cf:8941:5e32:653f]) by CH0PR18MB4129.namprd18.prod.outlook.com
 ([fe80::1cf:8941:5e32:653f%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 10:57:00 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Kamal Heib <kamalheib1@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Ariel Elior <aelior@marvell.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: RE: [EXT] [PATCH for-next] RDMA/qedr: Fix reporting
 max_{send/recv}_wr attrs
Thread-Topic: [EXT] [PATCH for-next] RDMA/qedr: Fix reporting
 max_{send/recv}_wr attrs
Thread-Index: AQHX6t3CkJYDUzvPLECkstAcOcfnH6wm3F5A
Date:   Tue, 7 Dec 2021 10:56:59 +0000
Message-ID: <CH0PR18MB41292180806C1D1DF3E0DE58A16E9@CH0PR18MB4129.namprd18.prod.outlook.com>
References: <20211206201314.124947-1-kamalheib1@gmail.com>
In-Reply-To: <20211206201314.124947-1-kamalheib1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 151255f5-0d74-4716-0f80-08d9b9704b56
x-ms-traffictypediagnostic: CH2PR18MB3318:EE_
x-microsoft-antispam-prvs: <CH2PR18MB331875E60580C0329295D253A16E9@CH2PR18MB3318.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yUkR6wIheOQCKrphwmEAe7UuKPkbUUe0cUCgkNYVmYNcGjkNL7FojoMKv1If1X0WEyqT3GlLTye/Cd2n7BcJBlb3X+RewdwVPnoefC0y+2SUI0lBRZzI1FTZUmRXQjSgPH5ZVVPOoE3UW39UdYzK1eVLXziZ827go/ZOh1L7DsbyDE+hR39M0vPM6MfZMphAnCo6RMNbE7wuILV724DffVjmjtkO7cFEJzOejtqEdX+xuWNAaumN4pel6sC6vCOGnZ95yqRaduycl2FZoQM4UHtAsoQ/PoFu/UtvPNkGgVZ/OaAQ52qecgyhXnYnJhlh3BHJVjq/R734JvkKVeB2BHBgQFtnJ7wVxOeByb6/jVv4dDjVZJXd4x1orzd2VH1LwlrXlKSUNzsm3HDUWMSc7XIU+XwXL+HMfOUosb9wdqxv6yXediLdujTQSQ95a4pQ5GYD+S6EcgRBXnIRUqzEvVNzMC/rvBGmgv0J348AIJGT8oR4kfm8hLJUi6yl8o2lomSbD8FKYVjpsWmQI1mXlOTmCx9tqp88XrmpohTpcG6YHfdKPYQ86JEty99LBSck1NJ7avuOi64G8+XbH2DDc3eoAslmHM9uYd8fJzvg3dhg4m0E4wpG8VRzObhSoX7WuN4EpzHHq1rTVy5nY+7GNoPToIqJuGRhQ8HEyNw7Sbfpsz+8A1oVMq6QxCBDUcwa67KymFEyVvv3FNklZAgbBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4129.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(186003)(76116006)(66946007)(38100700002)(71200400001)(122000001)(86362001)(64756008)(66476007)(6506007)(5660300002)(26005)(52536014)(66446008)(66556008)(33656002)(110136005)(2906002)(8936002)(9686003)(8676002)(54906003)(38070700005)(7696005)(4326008)(55016003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2LKwIlUB6YUXhUviP6V1uTiu+ZqT7FgsMAxGRtB748BEts0QuZ+2k9Fq6O?=
 =?iso-8859-1?Q?GHubBngjIpq3fl+WrxBNG20p6vBgqw8i5LwlOXkKiyhB7z9NM13L73LICP?=
 =?iso-8859-1?Q?4uKwLwpRltMTBjxkEJIIDVPGB/VLyCG9aMUEFgJfepCX+lEBDMlkGJOGYJ?=
 =?iso-8859-1?Q?3KxrnkMClnwteSx2Zyf0GECfqhQb9F9TtBqHe9gA19gi50U6ncwZVnWBos?=
 =?iso-8859-1?Q?bRzpNk2ItdxLtChgwfXPTuXYa4uKdYfu+erUfn0c6MmHTL2bUaq4liiPLE?=
 =?iso-8859-1?Q?2tNObkklf1rQD9EFyn9nO5tqu8S3/ocl4zIoShuoIdKWhYiZ3iQcaQ7gJi?=
 =?iso-8859-1?Q?DJEUMxbQjiBmXqBDRW1GNbTSQZBSd11Ncr7NFtUPEcRINgpklcNntFPw/x?=
 =?iso-8859-1?Q?VFq+w0gYLttBiITkPQlPB19/0h8OFIwg1ZaP9nwFuTBMDhGF9eppRLBHD5?=
 =?iso-8859-1?Q?+b40w2FPAkzX5pfuJx01Ua2E6HMqkOznmMEHK7flcpWziflW0HRNYq+L1m?=
 =?iso-8859-1?Q?QjpWhtJ900JYM7MkPiEx10wCtpT+cd0QZg/NuyOPP6nQp6zRxt+yXi7jEk?=
 =?iso-8859-1?Q?xCQACmm1De+DV+zFamIylzIcUbbZSnrPEcSzfk7PVyXtk+bFDIM76jlk82?=
 =?iso-8859-1?Q?+9FgPcpoGkkota22Ilu/E+bqilpotUpO8oJjtW9te6HU6GlCILchrZwdXv?=
 =?iso-8859-1?Q?/ICR5Fsf8/zguz5RO4NtoAXBU71FT7MNzEmRBxh/lME47/LGFhKdexOaqY?=
 =?iso-8859-1?Q?TAxhE8mZslhwPPK0E3Ma49fIicissskDny3yhHGW9oonFQu/XkOTMjHIS2?=
 =?iso-8859-1?Q?OOXBl5U/ACkrTaaoijXyjungjhwGbhWlxxNWCGZsuPvBkIFNEPoTAH+g4k?=
 =?iso-8859-1?Q?ujEAgGp/wdOLsubbiZqxzddpaq3iohGU49r0bOcRAPDLJB5xDTmVc5nMG3?=
 =?iso-8859-1?Q?P23deLZLQZIPf7Vg0QhemDqh5qhkhzYGmmT7I+GMQew4wEmLiMMLHDHrRb?=
 =?iso-8859-1?Q?ALtTMpjdyCq5WVv0SxblRIcDcYRuzf/wmapWJGLUt2BIWGWYdEARvU+9hh?=
 =?iso-8859-1?Q?w2z5qEzECd+CZgUoGS7xAD9TIw5x1H3oismKgBqLUCh4IoEeFM95W6rY9Q?=
 =?iso-8859-1?Q?76Vpw3ppqDyMP5RLTxQmqy1qqYhl4fECSw5T0RewIYYk2vOTDMmHcWi5ii?=
 =?iso-8859-1?Q?0dfsdt4yms2GYl38JRrjNqrcX3NPDnEgve6ACgdnEfj/U7u9ciwY2vmRfD?=
 =?iso-8859-1?Q?aaeOl6myHe6qBVSaUZHIL8pbb2Xu2rfdsqCZiYRvPsW+veFuiQh887K4cq?=
 =?iso-8859-1?Q?FlaeMiozzGQQCri5Vv2Ap0Z6veimow5dC4jQWQ7NsZN/lq4NFVKsJCQyrF?=
 =?iso-8859-1?Q?Ix03Ob/jB84Xi5BGTH5lLLi6mJRVfsKigFVOp1GCF1AGIwW4MT8mOEDFiC?=
 =?iso-8859-1?Q?+snJwcfDpRG0cnArUt29LOFLmGwIVpwQ3X/w+zlNqzG6LM7m0p4EtywC1e?=
 =?iso-8859-1?Q?0bn//KYKtWFiNulWUFUB/+Q8w+IchngBmc23kHBAJi4iC0Y24SQIkgaAuT?=
 =?iso-8859-1?Q?6SSBSzoSwCCZ6slknJCJkjMrEuBsLApmeEngadMx+bNtuYKleUR3X3JlhH?=
 =?iso-8859-1?Q?THRj+nZAFrv2jAU1qRF5HKC1u5RN48417zDiUi7yi3BoHjRPs4BrhDICsA?=
 =?iso-8859-1?Q?9JIz6iA37TIhvR3hfwM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4129.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151255f5-0d74-4716-0f80-08d9b9704b56
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 10:56:59.8062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6deIiclU0s1U6ujcYGpTIZH8AeF3wmiXsRBs6wyK7+1CNLBQ+xKXiWcLzKlDdGC97xixovfQDKFyBgz5ZPPTDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3318
X-Proofpoint-GUID: wfD7Wzmq-bDZrylsF_4ZvF_pIIjZIPv0
X-Proofpoint-ORIG-GUID: wfD7Wzmq-bDZrylsF_4ZvF_pIIjZIPv0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_04,2021-12-06_02,2021-12-02_01
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Kamal Heib <kamalheib1@gmail.com>
> Sent: Monday, December 6, 2021 10:13 PM
>
> Fix the wrongly reported max_send_wr and max_recv_wr attributes for user
> QP by making sure to save their valuse on QP creation, so when query QP
> is called the attributes will be reported correctly.
>=20
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/qedr/verbs.c
> b/drivers/infiniband/hw/qedr/verbs.c
> index 9100009f0a23..a53476653b0d 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -1931,6 +1931,7 @@ static int qedr_create_user_qp(struct qedr_dev
> *dev,
>  	/* db offset was calculated in copy_qp_uresp, now set in the user q
> */
>  	if (qedr_qp_has_sq(qp)) {
>  		qp->usq.db_addr =3D ctx->dpi_addr + uresp.sq_db_offset;
> +		qp->sq.max_wr =3D attrs->cap.max_send_wr;
>  		rc =3D qedr_db_recovery_add(dev, qp->usq.db_addr,
>  					  &qp->usq.db_rec_data->db_data,
>  					  DB_REC_WIDTH_32B,
> @@ -1941,6 +1942,7 @@ static int qedr_create_user_qp(struct qedr_dev
> *dev,
>=20
>  	if (qedr_qp_has_rq(qp)) {
>  		qp->urq.db_addr =3D ctx->dpi_addr + uresp.rq_db_offset;
> +		qp->rq.max_wr =3D attrs->cap.max_recv_wr;
>  		rc =3D qedr_db_recovery_add(dev, qp->urq.db_addr,
>  					  &qp->urq.db_rec_data->db_data,
>  					  DB_REC_WIDTH_32B,
> --
> 2.31.1

Thanks,=A0

Acked-by: Michal Kalderon=A0<michal.kalderon@marvell.com>


