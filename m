Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CF245DA2B
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 13:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354853AbhKYMkT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 07:40:19 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61160 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347919AbhKYMiS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Nov 2021 07:38:18 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1APBxL2K018207;
        Thu, 25 Nov 2021 12:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MUmOJB3z2vT7E1qvwowi6w2s5fT+MGsWiTgZIsb6m1A=;
 b=miPhvQYEaAD2uTBb7g3F4dzH4grLOJYQu+it2DqAyp50WTS0R7IW+n6i5fwTTdK9/2Th
 2g9aFTJblJty29Q1YeIvuCxSuRy6bPfn9ssTq/YJAM5ExRor8/22s4L/4wYxAAgGRO2u
 2mw8UbRWzLEVBbzT9O8Mk0cM9GYVU9sfVMbBB5CY+GVLOpuhAOJ8p77KgoySxdSuZqhQ
 hgCUCE0EIoYYmZtjfNQJsTvfH0WkEntcmqPOsqSDTmzTUZuUY+FP3hHWsAkp9d6J5+ll
 yPlKupK/s/7vSzJHYUqbXTUItpy7BmIW3FFmIJMWebuim/vQd2bnJ7vNjTrwIE5yfgaH yQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3chkfkfaau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 12:35:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1APCLQd0134328;
        Thu, 25 Nov 2021 12:35:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by aserp3020.oracle.com with ESMTP id 3ceru8mbum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 12:35:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6jDTrhwsTvEIrN2tMiNoz1B43LcfOaXp/JJHPknTlQrG50Q9jOoMf55E/1+CcUb4Xnb4Ndg5vODsQlKYdfXklS2Wr10V8hmVmfXiWn4lv2y4eNaWubHdHk39hQtcMxcEKXWloQ7KbyXrbhO/riALVy72YjdFe+l07Lac9H66N7ULijDLILmLjpVYj73yVSiDVYW8sAmZvTN44miU4SFnPFPQgzOpeqj6QtA1MXyxCPTocuF1HC5Hfqt4mXKy0bsKfWMUbwumNvNI2CgJyLLa4i8je9dTBbgWLZRDm2sGw8SBACnZQmE0QG3A2FIL8AOiI8RndhdAt4kP04T5eOtzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUmOJB3z2vT7E1qvwowi6w2s5fT+MGsWiTgZIsb6m1A=;
 b=XRt4/+JN+hjsOX5wpuXRn8E2AanOfka+Iwzr65HqChRJ8XteuQMJsuA9/tFKpoiVzOVFu4luEJ46UfurQN7EC/pAgwj1PQL8Lncbq3h5bSg3Dtn2eosLF1la3WhkoCRarptX4meJR73P/e0xA11uwrfEjuc5hRmXSwummtKuq3nCdN2TH7qtMhMLXEtuZfB+xd3aiHb5Oa8+XUC/mLySHTA6REsXmPm+edC30aCpXn+eKeUjfG9aZqtDx8JtJwMKi3QcfwEh/RSHUmSZlU4lllafgGFkv6SY3YoSkWL/NkTjXeaNjjvlpWvSX2kMgjE5+frJehDjAxbMNm1Wz2DaIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUmOJB3z2vT7E1qvwowi6w2s5fT+MGsWiTgZIsb6m1A=;
 b=EqL0X/a5dtEogc22410svJMjqvCHPXiANlMqonpv25RDUWvn/QuFTCBTH0PWTPISO5vUqud589MCpg7YXK5dPRQtWiHq3ZBlDt9bdYqYLh/SCHVA1Qloe5tFEeW0OTXGjR7QeF8BZjOnHj0RLBTC6Cy/4UiwUuIPM2c/mOhjRMs=
Received: from CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6)
 by MWHPR1001MB2288.namprd10.prod.outlook.com (2603:10b6:301:2c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Thu, 25 Nov
 2021 12:35:03 +0000
Received: from CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::7d4a:284a:f0b8:1511]) by CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::7d4a:284a:f0b8:1511%9]) with mapi id 15.20.4713.022; Thu, 25 Nov 2021
 12:35:03 +0000
From:   Devesh Sharma <devesh.s.sharma@oracle.com>
To:     Kamal Heib <kamalheib1@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: RE: [PATCH for-next] RDMA/bnxt_re: Remove pkey table
Thread-Topic: [PATCH for-next] RDMA/bnxt_re: Remove pkey table
Thread-Index: AQHX4a3wHKiqXIKkXE2ihkP+ViZwaKwULhIA
Date:   Thu, 25 Nov 2021 12:35:03 +0000
Message-ID: <CO6PR10MB563588097B3D4B4F05CFECD3DD629@CO6PR10MB5635.namprd10.prod.outlook.com>
References: <20211125033615.483750-1-kamalheib1@gmail.com>
In-Reply-To: <20211125033615.483750-1-kamalheib1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e5b012c-3620-43d2-2328-08d9b01000fc
x-ms-traffictypediagnostic: MWHPR1001MB2288:
x-microsoft-antispam-prvs: <MWHPR1001MB2288016A5273293A87694FB2DD629@MWHPR1001MB2288.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l2uqWOutLAzj7sNS4O1e8oLqo+EjxeATR2RxX3HKj6gaCB5kQXVTPNxi58S2LdXPskEevzQEKglK7NHeHgXaYnCRbVgt+NfF+6HlFtl8Ap2WK4Tp1r4yCYsXjuoSJieOM4TKcr0aynrWotgFe8JPzQRenXTiXcbpfPsC3ZzOIIDvwmYnJhV5TeutMMiBpsZ2H7//lhwIOMWOWJjffh3bxljlpyiji6tMQG1Je19x6rQxe+I59vsCQJV/I6zBHaQU+jYgqUDGNGG5BWUW9NuWTkhD9olxBccTkfcsqDa9B8ua0zriK7A6y3SzAzO+MtPw4bYQqsEjvlrMzUeGdom1Y5ZaCwAzO58sF0V1asI1t3PX6nwjJXsZTseMmRf8yuIvJYO9Hi59U2ZArgmAfSsuMAzVGMGX9pktqrEba5wAPsPANgLd1ok7Gzk+Pg/dhvHGeTUW9wOUlIxVlkWkQNVNtMyQdI0gmONs9v8WUJgUymDOKwyXiRoFdZDtHg/4BlaCp/AApdaZDG/kCDGfmkH+Kfsx64vO2H8+QqA2lwl1bktyooKvYCg8TH1mnVeQ8u4VW9RvubGIl766J9CAg2b2x0QKKw2xYjcFisa7Fu6gDzL39cdU+0A2kXZTQtaLD9OhJFCg4cdIg3+8BwMLQ6B6Nik2AFAZW8wOyew+zI09Uafph5/juAiswNCSiBt1aYM0jjWWgR2jC4s1ugE9uG+J4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5635.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(9686003)(86362001)(110136005)(26005)(38100700002)(7696005)(186003)(2906002)(5660300002)(55016003)(76116006)(122000001)(508600001)(8936002)(71200400001)(54906003)(4326008)(53546011)(316002)(6506007)(8676002)(66476007)(83380400001)(64756008)(30864003)(66446008)(66946007)(66556008)(52536014)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9UPuc7qgarVmnOeQPR7UzV3DMqva3wzCH9IuNzEZRmMjY9NjLs3HvYWDz+1H?=
 =?us-ascii?Q?qS24ihxISceYlJNl2f9iJHwTNY8io0SrKigTWFrNPGrLDlDRoa/KnsM6EKAD?=
 =?us-ascii?Q?ssS1Dctp7suCHC05bnoQWKEdOExhOP3jWt6nq3MJU1SvLJBdgrbkeffD5Ruh?=
 =?us-ascii?Q?VdsNpnox1w+scYrOVUvmz0m8vBmlv7ukEG5ny3zqj+dYZvRNNXfDker60v3M?=
 =?us-ascii?Q?nSjZjHfqRcyisq7WaMx/vARJlisyzcWeXi+PP6fd3ydjC4rhbaAMS0vCKPk0?=
 =?us-ascii?Q?MmdQrJjDKG9xoXMRv+7C8TNTwDVXyjiIp0NN0DEn9dsf+pM4P6mm4ky7zqnp?=
 =?us-ascii?Q?k5hwyBdSoGuWn4kkzYmc8WdyJzzB8vUS1t+bdYPPfPGy0gJiWpvtW+xumYMO?=
 =?us-ascii?Q?j8fy4mNd3xdmu6rVv7LaHCCco63tvXtTJlZJ0c5utWdRxOfmt+cWVep9EYRg?=
 =?us-ascii?Q?ZmdT2ituyxPpNylZuj7abE7YKzJ5LtfJMhaaeYZ1ZMZNCWIROONZgp08penH?=
 =?us-ascii?Q?YlQO4J2WVI1u0jzFrv1huQu1wduaDQAC5ihxmISX5Vm2nRIFzsCTOG5d5Pf8?=
 =?us-ascii?Q?HZ0qoESgv6H7T8lLv6SFtaPYOBpioFUjEHgQJz3+pFaIe1d0BE63azIwCQoF?=
 =?us-ascii?Q?hwhvKYbdsAiJjL2qz5ge+DBXJyC4go0X4ibM2JY2WgvthdEoOj20TIlfQid2?=
 =?us-ascii?Q?jyOYFgXnPzlFQmvl0F33JSMAtrETcAPkt9YA9HIop5YM+FhG4dFBavRvM1uN?=
 =?us-ascii?Q?9GHQ1Bty7E5HIvZn73KIa0NxxYnkXfsVSyLQqT/NlqWILNNZbQj4gnPRpcOS?=
 =?us-ascii?Q?yeoAKJCROxjYWlZktjoGLFAjdSKmz0cInSlReJ1U5ffCDQvLMUKGK4aIM28g?=
 =?us-ascii?Q?1gCEhuqzfslpI3GKdnTPD+250pY+qZmQ6hj0v63rP7ZvO31G38cZBCimM4FO?=
 =?us-ascii?Q?zo2PZvCsnrlackhyioNP93RDlr7+AShzPC+PAQS3xZIl81oCUKhqsPAqehhN?=
 =?us-ascii?Q?vF1s8gJOsBBwLgbj7eDC/ZLH4D9a5RFFx9Xvs1PG8TB4IoWjPu1t70c05Yct?=
 =?us-ascii?Q?FQdcPkaBLpbVdYN9hrzVZdi/YpFIJ+dXolAtw9+z0N73SiSqEdTqHb+TNXYN?=
 =?us-ascii?Q?TTeBzW1ZKUop3MCorpOcU3wOoIYrfel6BkX0MMf8T9fZk7AjMRGS9bryKikt?=
 =?us-ascii?Q?PtYRZ94JJhb3OqMvIs8d0GIgh2Tpp5XYAcHETwmKoi6v6tt2q72LDWBqbgDD?=
 =?us-ascii?Q?MKIddsRtXmLiMJJ8Nivkwl4WuUVBW7RrKW9WWzElKbl7ANcSFxEHVsSydA+7?=
 =?us-ascii?Q?6bIDs2RhzGndNbaw3kCBShmYFGKxj/DIncgP9YBXa5Ze74dGvjhF4Wp+Ov2+?=
 =?us-ascii?Q?s0hOCC3g7IMZ851jTJ19LRiqDCxO9t3vAsMz+GeqviZO2L0M5pHbShbmuSYJ?=
 =?us-ascii?Q?KIE18EyJ5OBAL+tOUPDYhO5nwQ6z8UPhh2+VSzwW8mEHvBdBSKTeI5Jgknsu?=
 =?us-ascii?Q?Lq8kB6/7g1o1psSdrooemtJteB6rcy++a7cAv9kPp/mqaqgi+3lakZIJR6lm?=
 =?us-ascii?Q?fViI5TcnZmw3V39wml6o2DRS9yIf99tr8MLbYi1ZhfMLk+Qx5Il8wjaWdwL3?=
 =?us-ascii?Q?uGAT/+ck1hRrwnD+51PJbqD8bu/D6DI+L6/lCqfrksJWK7JTy2Pr7VbABCAk?=
 =?us-ascii?Q?ilGjwA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5635.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5b012c-3620-43d2-2328-08d9b01000fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 12:35:03.1020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y97xMK0pBXkezpUtpSE1kgJ8E5S/lfzewwBnoU8MJ7vnycHaNtNVUC3dS1bWzMOn4RPI/99VbmVzaFpACaDCTom7tQct9QXfB3MGvgtEWFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2288
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10178 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111250069
X-Proofpoint-GUID: cnMm7uWIsvNa41aG3sIJme5SQJXJRmrg
X-Proofpoint-ORIG-GUID: cnMm7uWIsvNa41aG3sIJme5SQJXJRmrg
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Kamal Heib <kamalheib1@gmail.com>
> Sent: Thursday, November 25, 2021 9:06 AM
> To: linux-rdma@vger.kernel.org
> Cc: Selvin Xavier <selvin.xavier@broadcom.com>; Jason Gunthorpe
> <jgg@ziepe.ca>; Kamal Heib <kamalheib1@gmail.com>
> Subject: [PATCH for-next] RDMA/bnxt_re: Remove pkey table
>=20
> The RoCE spec requires RoCE devices to support only the default pkey.
> However the bnxt_re driver maintains 0xFFFF entries pkey table and uses
> only the first entry. Remove the pkey table and hard code a table of leng=
th
> one hard wired with the default pkey.
>=20
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  9 +--
> drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 11 ++-
> drivers/infiniband/hw/bnxt_re/qplib_res.c | 50 ------------
> drivers/infiniband/hw/bnxt_re/qplib_res.h |  7 --
> drivers/infiniband/hw/bnxt_re/qplib_sp.c  | 99 +----------------------
> drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  9 ---
>  6 files changed, 10 insertions(+), 175 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index 29cc0d14399a..3224f18a66e5 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -262,13 +262,12 @@ void bnxt_re_query_fw_str(struct ib_device
> *ibdev, char *str)  int bnxt_re_query_pkey(struct ib_device *ibdev, u32
> port_num,
>  		       u16 index, u16 *pkey)
>  {
> -	struct bnxt_re_dev *rdev =3D to_bnxt_re_dev(ibdev, ibdev);
> +	if (index > 0)
> +		return -EINVAL;
>=20
> -	/* Ignore port_num */
> +	*pkey =3D IB_DEFAULT_PKEY_FULL;
>=20
> -	memset(pkey, 0, sizeof(*pkey));
> -	return bnxt_qplib_get_pkey(&rdev->qplib_res,
> -				   &rdev->qplib_res.pkey_tbl, index, pkey);
> +	return 0;
>  }
>=20
>  int bnxt_re_query_gid(struct ib_device *ibdev, u32 port_num, diff --git
> a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> index ca88849559bf..f6472cca9ec7 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> @@ -46,6 +46,7 @@
>  #include <linux/delay.h>
>  #include <linux/prefetch.h>
>  #include <linux/if_ether.h>
> +#include <rdma/ib_mad.h>
>=20
>  #include "roce_hsi.h"
>=20
> @@ -1232,7 +1233,7 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res
> *res, struct bnxt_qplib_qp *qp)
>  	struct bnxt_qplib_rcfw *rcfw =3D res->rcfw;
>  	struct cmdq_modify_qp req;
>  	struct creq_modify_qp_resp resp;
> -	u16 cmd_flags =3D 0, pkey;
> +	u16 cmd_flags =3D 0;
>  	u32 temp32[4];
>  	u32 bmask;
>  	int rc;
> @@ -1255,11 +1256,9 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res
> *res, struct bnxt_qplib_qp *qp)
>  	if (bmask & CMDQ_MODIFY_QP_MODIFY_MASK_ACCESS)
>  		req.access =3D qp->access;
>=20
> -	if (bmask & CMDQ_MODIFY_QP_MODIFY_MASK_PKEY) {
> -		if (!bnxt_qplib_get_pkey(res, &res->pkey_tbl,
> -					 qp->pkey_index, &pkey))
> -			req.pkey =3D cpu_to_le16(pkey);
> -	}
> +	if (bmask & CMDQ_MODIFY_QP_MODIFY_MASK_PKEY)
> +		req.pkey =3D IB_DEFAULT_PKEY_FULL;
> +
>  	if (bmask & CMDQ_MODIFY_QP_MODIFY_MASK_QKEY)
>  		req.qkey =3D cpu_to_le32(qp->qkey);
>=20
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c
> b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> index bc1ba4b51ba4..126d4f26f75a 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> @@ -649,31 +649,6 @@ static void bnxt_qplib_init_sgid_tbl(struct
> bnxt_qplib_sgid_tbl *sgid_tbl,
>  	memset(sgid_tbl->hw_id, -1, sizeof(u16) * sgid_tbl->max);  }
>=20
> -static void bnxt_qplib_free_pkey_tbl(struct bnxt_qplib_res *res,
> -				     struct bnxt_qplib_pkey_tbl *pkey_tbl)
> -{
> -	if (!pkey_tbl->tbl)
> -		dev_dbg(&res->pdev->dev, "PKEY tbl not present\n");
> -	else
> -		kfree(pkey_tbl->tbl);
> -
> -	pkey_tbl->tbl =3D NULL;
> -	pkey_tbl->max =3D 0;
> -	pkey_tbl->active =3D 0;
> -}
> -
> -static int bnxt_qplib_alloc_pkey_tbl(struct bnxt_qplib_res *res,
> -				     struct bnxt_qplib_pkey_tbl *pkey_tbl,
> -				     u16 max)
> -{
> -	pkey_tbl->tbl =3D kcalloc(max, sizeof(u16), GFP_KERNEL);
> -	if (!pkey_tbl->tbl)
> -		return -ENOMEM;
> -
> -	pkey_tbl->max =3D max;
> -	return 0;
> -};
> -
>  /* PDs */
>  int bnxt_qplib_alloc_pd(struct bnxt_qplib_pd_tbl *pdt, struct
> bnxt_qplib_pd *pd)  {
> @@ -843,24 +818,6 @@ static int bnxt_qplib_alloc_dpi_tbl(struct
> bnxt_qplib_res     *res,
>  	return -ENOMEM;
>  }
>=20
> -/* PKEYs */
> -static void bnxt_qplib_cleanup_pkey_tbl(struct bnxt_qplib_pkey_tbl
> *pkey_tbl) -{
> -	memset(pkey_tbl->tbl, 0, sizeof(u16) * pkey_tbl->max);
> -	pkey_tbl->active =3D 0;
> -}
> -
> -static void bnxt_qplib_init_pkey_tbl(struct bnxt_qplib_res *res,
> -				     struct bnxt_qplib_pkey_tbl *pkey_tbl)
> -{
> -	u16 pkey =3D 0xFFFF;
> -
> -	memset(pkey_tbl->tbl, 0, sizeof(u16) * pkey_tbl->max);
> -
> -	/* pkey default =3D 0xFFFF */
> -	bnxt_qplib_add_pkey(res, pkey_tbl, &pkey, false);
> -}
> -
>  /* Stats */
>  static void bnxt_qplib_free_stats_ctx(struct pci_dev *pdev,
>  				      struct bnxt_qplib_stats *stats) @@ -
> 891,21 +848,18 @@ static int bnxt_qplib_alloc_stats_ctx(struct pci_dev
> *pdev,
>=20
>  void bnxt_qplib_cleanup_res(struct bnxt_qplib_res *res)  {
> -	bnxt_qplib_cleanup_pkey_tbl(&res->pkey_tbl);
>  	bnxt_qplib_cleanup_sgid_tbl(res, &res->sgid_tbl);  }
>=20
>  int bnxt_qplib_init_res(struct bnxt_qplib_res *res)  {
>  	bnxt_qplib_init_sgid_tbl(&res->sgid_tbl, res->netdev);
> -	bnxt_qplib_init_pkey_tbl(res, &res->pkey_tbl);
>=20
>  	return 0;
>  }
>=20
>  void bnxt_qplib_free_res(struct bnxt_qplib_res *res)  {
> -	bnxt_qplib_free_pkey_tbl(res, &res->pkey_tbl);
>  	bnxt_qplib_free_sgid_tbl(res, &res->sgid_tbl);
>  	bnxt_qplib_free_pd_tbl(&res->pd_tbl);
>  	bnxt_qplib_free_dpi_tbl(res, &res->dpi_tbl); @@ -924,10 +878,6
> @@ int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct pci_dev
> *pdev,
>  	if (rc)
>  		goto fail;
>=20
> -	rc =3D bnxt_qplib_alloc_pkey_tbl(res, &res->pkey_tbl, dev_attr-
> >max_pkey);
> -	if (rc)
> -		goto fail;
> -
>  	rc =3D bnxt_qplib_alloc_pd_tbl(res, &res->pd_tbl, dev_attr->max_pd);
>  	if (rc)
>  		goto fail;
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h
> b/drivers/infiniband/hw/bnxt_re/qplib_res.h
> index e1411a2352a7..982e2c96dac2 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
> @@ -185,12 +185,6 @@ struct bnxt_qplib_sgid_tbl {
>  	u8				*vlan;
>  };
>=20
> -struct bnxt_qplib_pkey_tbl {
> -	u16				*tbl;
> -	u16				max;
> -	u16				active;
> -};
> -
>  struct bnxt_qplib_dpi {
>  	u32				dpi;
>  	void __iomem			*dbr;
> @@ -258,7 +252,6 @@ struct bnxt_qplib_res {
>  	struct bnxt_qplib_rcfw		*rcfw;
>  	struct bnxt_qplib_pd_tbl	pd_tbl;
>  	struct bnxt_qplib_sgid_tbl	sgid_tbl;
> -	struct bnxt_qplib_pkey_tbl	pkey_tbl;
>  	struct bnxt_qplib_dpi_tbl	dpi_tbl;
>  	bool				prio;
>  	bool                            is_vf;
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> index 379e715ebd30..b802981b7171 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> @@ -146,17 +146,7 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw
> *rcfw,
>  	attr->max_srq =3D le16_to_cpu(sb->max_srq);
>  	attr->max_srq_wqes =3D le32_to_cpu(sb->max_srq_wr) - 1;
>  	attr->max_srq_sges =3D sb->max_srq_sge;
> -	attr->max_pkey =3D le32_to_cpu(sb->max_pkeys);
> -	/*
> -	 * Some versions of FW reports more than 0xFFFF.
> -	 * Restrict it for now to 0xFFFF to avoid
> -	 * reporting trucated value
> -	 */
> -	if (attr->max_pkey > 0xFFFF) {
> -		/* ib_port_attr::pkey_tbl_len is u16 */
> -		attr->max_pkey =3D 0xFFFF;
> -	}
> -
> +	attr->max_pkey =3D 1;
>  	attr->max_inline_data =3D le32_to_cpu(sb->max_inline_data);
>  	attr->l2_db_size =3D (sb->l2_db_space_size + 1) *
>  			    (0x01 << RCFW_DBR_BASE_PAGE_SHIFT); @@ -
> 414,93 +404,6 @@ int bnxt_qplib_update_sgid(struct bnxt_qplib_sgid_tbl
> *sgid_tbl,
>  	return rc;
>  }
>=20
> -/* pkeys */
> -int bnxt_qplib_get_pkey(struct bnxt_qplib_res *res,
> -			struct bnxt_qplib_pkey_tbl *pkey_tbl, u16 index,
> -			u16 *pkey)
> -{
> -	if (index =3D=3D 0xFFFF) {
> -		*pkey =3D 0xFFFF;
> -		return 0;
> -	}
> -	if (index >=3D pkey_tbl->max) {
> -		dev_err(&res->pdev->dev,
> -			"Index %d exceeded PKEY table max (%d)\n",
> -			index, pkey_tbl->max);
> -		return -EINVAL;
> -	}
> -	memcpy(pkey, &pkey_tbl->tbl[index], sizeof(*pkey));
> -	return 0;
> -}
> -
> -int bnxt_qplib_del_pkey(struct bnxt_qplib_res *res,
> -			struct bnxt_qplib_pkey_tbl *pkey_tbl, u16 *pkey,
> -			bool update)
> -{
> -	int i, rc =3D 0;
> -
> -	if (!pkey_tbl) {
> -		dev_err(&res->pdev->dev, "PKEY table not allocated\n");
> -		return -EINVAL;
> -	}
> -
> -	/* Do we need a pkey_lock here? */
> -	if (!pkey_tbl->active) {
> -		dev_err(&res->pdev->dev, "PKEY table has no active
> entries\n");
> -		return -ENOMEM;
> -	}
> -	for (i =3D 0; i < pkey_tbl->max; i++) {
> -		if (!memcmp(&pkey_tbl->tbl[i], pkey, sizeof(*pkey)))
> -			break;
> -	}
> -	if (i =3D=3D pkey_tbl->max) {
> -		dev_err(&res->pdev->dev,
> -			"PKEY 0x%04x not found in the pkey table\n",
> *pkey);
> -		return -ENOMEM;
> -	}
> -	memset(&pkey_tbl->tbl[i], 0, sizeof(*pkey));
> -	pkey_tbl->active--;
> -
> -	/* unlock */
> -	return rc;
> -}
> -
> -int bnxt_qplib_add_pkey(struct bnxt_qplib_res *res,
> -			struct bnxt_qplib_pkey_tbl *pkey_tbl, u16 *pkey,
> -			bool update)
> -{
> -	int i, free_idx, rc =3D 0;
> -
> -	if (!pkey_tbl) {
> -		dev_err(&res->pdev->dev, "PKEY table not allocated\n");
> -		return -EINVAL;
> -	}
> -
> -	/* Do we need a pkey_lock here? */
> -	if (pkey_tbl->active =3D=3D pkey_tbl->max) {
> -		dev_err(&res->pdev->dev, "PKEY table is full\n");
> -		return -ENOMEM;
> -	}
> -	free_idx =3D pkey_tbl->max;
> -	for (i =3D 0; i < pkey_tbl->max; i++) {
> -		if (!memcmp(&pkey_tbl->tbl[i], pkey, sizeof(*pkey)))
> -			return -EALREADY;
> -		else if (!pkey_tbl->tbl[i] && free_idx =3D=3D pkey_tbl->max)
> -			free_idx =3D i;
> -	}
> -	if (free_idx =3D=3D pkey_tbl->max) {
> -		dev_err(&res->pdev->dev,
> -			"PKEY table is FULL but count is not MAX??\n");
> -		return -ENOMEM;
> -	}
> -	/* Add PKEY to the pkey_tbl */
> -	memcpy(&pkey_tbl->tbl[free_idx], pkey, sizeof(*pkey));
> -	pkey_tbl->active++;
> -
> -	/* unlock */
> -	return rc;
> -}
> -
>  /* AH */
>  int bnxt_qplib_create_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_a=
h
> *ah,
>  			 bool block)
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> index a18f568cb23e..5939e8fc8353 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> @@ -255,15 +255,6 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl
> *sgid_tbl,  int bnxt_qplib_update_sgid(struct bnxt_qplib_sgid_tbl *sgid_t=
bl,
>  			   struct bnxt_qplib_gid *gid, u16 gid_idx,
>  			   const u8 *smac);
> -int bnxt_qplib_get_pkey(struct bnxt_qplib_res *res,
> -			struct bnxt_qplib_pkey_tbl *pkey_tbl, u16 index,
> -			u16 *pkey);
> -int bnxt_qplib_del_pkey(struct bnxt_qplib_res *res,
> -			struct bnxt_qplib_pkey_tbl *pkey_tbl, u16 *pkey,
> -			bool update);
> -int bnxt_qplib_add_pkey(struct bnxt_qplib_res *res,
> -			struct bnxt_qplib_pkey_tbl *pkey_tbl, u16 *pkey,
> -			bool update);
>  int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
>  			    struct bnxt_qplib_dev_attr *attr, bool vf);  int
> bnxt_qplib_set_func_resources(struct bnxt_qplib_res *res,

Looks good to me.
Reviewed-By: Devesh Sharma <devesh.s.sharma@oracle.com>
> --
> 2.31.1

