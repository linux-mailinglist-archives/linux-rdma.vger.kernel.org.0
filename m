Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757CE47545F
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 09:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240866AbhLOIlC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Dec 2021 03:41:02 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:16878 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231561AbhLOIlB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Dec 2021 03:41:01 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BF51XkE007078;
        Wed, 15 Dec 2021 08:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Ch5Y2IRbMYDjCx9BTI0TD/IsoVNJgZ6b2ZOhCzg4zkU=;
 b=0rNv513/cJ6JxEW3sL136Q7oaTQ9ZfIMklxSPtInLMaAFUT383mRJfMJGxm3KncoSqnD
 yLFtuUEnHKZYr0v0nqQFmFwOQR6Xnh2vSbK6nbR0psT4o9LanAzmc4x7IkY8m4xWRHtk
 kFCzFJKXZFDMhmn86aA/sTeAU4qhQxAhg5+mOQbkrOkORfDiSE7+HNeHX1YX4XDsdRd7
 UZC5YF3mCX+b70zIKfRHC5kppK7ByXzNNQqCUvG7st32DY6OStYvX7hxfILoKev2VG5C
 1JuC9ppVqXwU+x7GMDIQBfd9Dod9X4h+gU3GdSswYsud/v094xyiWVkvfoEpp030SJRX bQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx2nfe6h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 08:40:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BF8ZgUK160815;
        Wed, 15 Dec 2021 08:40:58 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by userp3020.oracle.com with ESMTP id 3cvnerfrwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 08:40:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tl8FTN0GaNMSSLjLx8PBvCKlSmO/01tUbC3MNjwI7j6Elcu+KqfwU3oqfjohFmK03B44+AQRMvsqmfGyfMQllyO4dXU3ox5ccy2gPoa78vGbQO4At+u6d4PL5Kzq1V+oAB8XoDaH/mdgpG8vl3hXDlDIIqvelt9BVVwM6b9G1LUeNV9Z3aAJRrCG+Di2bXpdek3fIpFg8sF0RuPqZ2lRIKULIWfa3+afEfRv3an4zpXbRzLaKZHoMDnDyZj8Nrs8//Yy/bO7aUaEtO8/qac4R98OMCMT3d6AYmk9sZfUlouz6bXJoNIBvkBMBmPt2HDutLu8XO7bHxlrWdeuRixYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ch5Y2IRbMYDjCx9BTI0TD/IsoVNJgZ6b2ZOhCzg4zkU=;
 b=HGZS7k538pDxFJpZ6G1RnYI1NbnjkWRSbCygKDPthjvsQbCsGWR5Gr/aM4wCGlhrSF505YWnnlGpgl2IbZdSjEDfaUac+Nk9QY0A20k/la2061Tn3rmllOIEjxc727Y0R7eCVC3wmOs5vi6ZL9nWxiDaKdJPIBPTQRt69jwDKCBnT1f+oOrbhNNCYBrTbzXMVK1DOePNNq8c4mImMfr9aO7TFF1bTovXJ2CCYBSlxNx1fb1nqvqSEL/ZCVkF+4HrB+BwMgS5dJyXuAKA0pjE+KF2u10lRZfSR2rWA55XIk4+ab6Ji1ofPSa9oZEUEql9e8ugUZqGPpOwlWrodB4cBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ch5Y2IRbMYDjCx9BTI0TD/IsoVNJgZ6b2ZOhCzg4zkU=;
 b=uHhN/rhIksCF+mr79NGoJIeJfdP3qJKD1GlYS1S4d30H4rsCg29aLLKugT9su9d8PMUt3wBMOwORcoJhX4597VMGzCLsGLjrMTxeUm4Y/kKxs9GbRjvwkAqGbyXoZioiYHjWcaLxFRSx4RdYFVG0zLJHsC8f3WhHQwDK374B1j8=
Received: from CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6)
 by CO1PR10MB4579.namprd10.prod.outlook.com (2603:10b6:303:96::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Wed, 15 Dec
 2021 08:40:56 +0000
Received: from CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::eca2:ec30:e72f:93ee]) by CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::eca2:ec30:e72f:93ee%9]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 08:40:56 +0000
From:   Devesh Sharma <devesh.s.sharma@oracle.com>
To:     "cgel.zte@gmail.com" <cgel.zte@gmail.com>
CC:     "chi.minghao@zte.com.cn" <chi.minghao@zte.com.cn>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zealci@zte.com.cn" <zealci@zte.com.cn>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: RE: [External] : [PATCH for-next v2] RDMA/rxe: remove redundant err
 variable
Thread-Topic: [External] : [PATCH for-next v2] RDMA/rxe: remove redundant err
 variable
Thread-Index: AQHX8YjQo+mZE49R5UaJ2SAU4RB2OawzO6kA
Date:   Wed, 15 Dec 2021 08:40:56 +0000
Message-ID: <CO6PR10MB5635E7E6977C12D40D96541ADD769@CO6PR10MB5635.namprd10.prod.outlook.com>
References: <CO6PR10MB56353FD77836D5605CDDB8DEDD769@CO6PR10MB5635.namprd10.prod.outlook.com>
 <20211215075258.442930-1-chi.minghao@zte.com.cn>
In-Reply-To: <20211215075258.442930-1-chi.minghao@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 486494b1-c65d-43ef-d336-08d9bfa69c9e
x-ms-traffictypediagnostic: CO1PR10MB4579:EE_
x-microsoft-antispam-prvs: <CO1PR10MB45792920C8EA31DAF7DEF298DD769@CO1PR10MB4579.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:186;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +MrKnQC3bVGRCRLYiA5C4+pyjbtrIn1KnFNp89DR1aA7syNjXi/+CeyyyA/CmzthQiLMS9p6kqU6CGT4Wc0LcEJ5ZY5ahwYY9lLtZK6HfglOlDthNNUmOeMxJlqoqCvokvqagODH8y4GcR2sqJadRzsr1dRqgiheESxlEjOZZvxoLDrT1mSI8NQH4MYzv8ZGc2Pyd4NBC9n5yiTFPLW/7t8rcR3qzG/49JxEASn2GtiFh3LDNVpbZkHzeAIDZ57LGbB7wp940dAEJsuJFY+I907pMzpGTYHCSzq/+LT1gpXpZMAfh0UJpmQezUsNhuWQOc4atK13fe+b6jo2jU7EpHSuui4lsFfD8Ybgk+h40xrSi5HhibGzGB2qpfgtbP6+SH/pQOYUb6Xe6rJZBuhZAEtIJvlN/j4ZyhlrsudUCp0QyjJehSiR4jDBm6sRuuLlxm6Enr2+YpveGP3InYQPmZScr8znGuiDGfS7vgfIayv2j4Q2kRL70YAqn8rOr5RcjF9fLk2AW2tgAVQff4D+UAu1O6TBWWWKigX5c2kmWuAMHdJ+K/exGjb2cu4xrEV1DWiCaHt/euxkx4c6y6XwqsdrqlbM9jVkZdb2H22QHqrAFNEtS2rdtHHn2Z+giwDeR0fa2KDuVWxWCTGwAvWcyFu+h1fU1Y33ucTAADnFc9FUTsNlHHrIYV7fBnZeKMy6pRG62dmeBf7eysD/bxqZsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5635.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(66946007)(66556008)(66476007)(38070700005)(52536014)(66446008)(55016003)(316002)(83380400001)(64756008)(71200400001)(7696005)(76116006)(6916009)(122000001)(5660300002)(38100700002)(4326008)(8676002)(26005)(186003)(6506007)(54906003)(508600001)(53546011)(33656002)(8936002)(86362001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QCUanTQk+LFlckpXbrlNNEMMFD0oxd/G3iwIkrx8CnN7BtzZRAAG06lvl8zA?=
 =?us-ascii?Q?mJ89K8bW6gFMOyrd/NqMC2w63YULyrQYopLxlOgQhygBu37WaVIGD3wYzxDe?=
 =?us-ascii?Q?Z3JJAwLe+RWazUmJsPE8gfK08qF4c1pY14+X7Vp6u07hnf7PT+Zo5RpZkKyu?=
 =?us-ascii?Q?+DHoxBM1sEmpJA9l6y2M52+DR4Cd9Jm/SAVKdAvr3VH7sxksRDzPT+/JgL6b?=
 =?us-ascii?Q?v1dtKfgFNg7lHsI4tXFBfS6swZuLCkLelTKJDM6BRzULMVNcFwWKnDcbFn8+?=
 =?us-ascii?Q?XShXg5N4S90O3FJR1m+UYbYpt/rfNhsEBP3ow/gvBS/hiHE6MI7LVKk5RPhi?=
 =?us-ascii?Q?fxsJ4n2WWRSvgefF97EyUTffvCjNDDlmAcMZomgb9GMmT/DykPauWeKIHuB+?=
 =?us-ascii?Q?ZTpxmB+nS/Djl6qhFk8/9LibpsP8wl/c74ycW3W0wFEIdnjAurJqORb0qHxU?=
 =?us-ascii?Q?nnzomAD4V6eD1Hx8EcS8Xgs6cilBfch5QYVX97rs8WB6Qr52WdivZULMx3tA?=
 =?us-ascii?Q?kF+OI1JwJAs1vjMFyE53oe/HK4oAMQQ8/8KITHWcfx1dfr9HQ8MIxlMOzhr3?=
 =?us-ascii?Q?MLfszoC/6Vw9y0Ik2mSFxxEDrehSgVRQO4T/grAcjsk8/VDm99jfzqW1NNl7?=
 =?us-ascii?Q?UqGR7UiPIYdu6bu0o5aN/3vjU+YvjtIdv1Y7TordmZvYh3TCFOPys35v80RI?=
 =?us-ascii?Q?gM267RzkJsW/t4PPNDFTZbHeEbCLo4fY4/+PVnfVdSQTtq5MoXS6OP39rnoC?=
 =?us-ascii?Q?maw/2RPPI7x58qWaSvdZ35iR3v7DZ/ATEZmnyQwGkswkxojK+NV2cRAWc7Kp?=
 =?us-ascii?Q?NqhOf9Gxu5SR45yyjzbSuCtqrXsdCUrDzl3vKLYRIBnj0PYnkjj4X27XUzuq?=
 =?us-ascii?Q?luUkYX8vI910gPzU9WTKkLzLzrNR7WVO66cQDXiWnt9WudfReT0zvmps9Gjz?=
 =?us-ascii?Q?NzM5uRKFyH2Quqd3WsoxV6IvnU0kFaFaJeXXPWim8HLenT+ij8xhfSafkXfV?=
 =?us-ascii?Q?x8lGthx8EN/B+WT6UzL1BBkm6laejdKlqECd02uEP0v7TLZ+n8i9IWCOx3+r?=
 =?us-ascii?Q?kj55/RkekvcTrxHuagiBJsp4HQ9TScMtPrUPfb3NN67Oj5exyt8jcdM8GTW7?=
 =?us-ascii?Q?lYyv1Xp6zgtpgDo93nNzspdgtxC8ofulIVFDFYrwqnFad6E/ncn5EzwOWaQC?=
 =?us-ascii?Q?EW1d6kKgjxoz5EQcctgrAjOaSdzNAgw5+Ka96tACei7wHhmFopR7Uabkc8Jl?=
 =?us-ascii?Q?DIaTeG6YF05vFykC0clyhKCPsffrlXhEdzH8ckf75osdJrVr/7hDMWZSVycs?=
 =?us-ascii?Q?NYy/F24l70rcWu2fnhARecQBrPCJ0+b14+Qi+5tyE5/F2LQqS8F+9OSzZUyd?=
 =?us-ascii?Q?AiZrkJr3dlXDv4ctVxXlALbTg3syBt0qxK0T8Q9WISOxmXbRQ8jtUkNBTok/?=
 =?us-ascii?Q?FCHW7be3fLrNH8WX4zftlsPeAezpoFIqI+Mu2FmaAW8513ThqwuKO6u9goKn?=
 =?us-ascii?Q?/GrqwJLqBE8pwDri4ctiGY6jBARFp3GiXf6GNwaNxZGpCqaZztgRFqfiWOqJ?=
 =?us-ascii?Q?brYa4088dNfNqK0n5xzXqzXrvOTOorJYADBCRNMorVvlr2xrPvwVltIDqAEW?=
 =?us-ascii?Q?141Pf22hFQ0Ls1DEtRpx4tVQz0RodbBCJ5V7ftv/UzVK8/RQxvUHaH6F5X9c?=
 =?us-ascii?Q?SM5u/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5635.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486494b1-c65d-43ef-d336-08d9bfa69c9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 08:40:56.2049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3bFos02lw0WZ4KPbp3+vjUG2r8zrM5dXMn55utWn3+y6b2Nqi9KGXRhJ0P9FRG2V9kTWYlgoG7ZW1Kd3d9flEDsUIUviJQrag8JkKLSKEE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4579
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10198 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=940 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112150048
X-Proofpoint-ORIG-GUID: dvhlz9Zw2seeoWe0CXreEzXDoZ709GDA
X-Proofpoint-GUID: dvhlz9Zw2seeoWe0CXreEzXDoZ709GDA
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: cgel.zte@gmail.com <cgel.zte@gmail.com>
> Sent: Wednesday, December 15, 2021 1:23 PM
> To: Devesh Sharma <devesh.s.sharma@oracle.com>
> Cc: cgel.zte@gmail.com; chi.minghao@zte.com.cn; dledford@redhat.com;
> jgg@ziepe.ca; linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org;
> zealci@zte.com.cn; zyjzyj2000@gmail.com
> Subject: [External] : [PATCH for-next v2] RDMA/rxe: remove redundant err
> variable
>=20
> From: Minghao Chi <chi.minghao@zte.com.cn>
>=20
> Return value directly instead of taking this in another redundant variabl=
e.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/infiniband/sw/rxe/rxe_net.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c
> b/drivers/infiniband/sw/rxe/rxe_net.c
> index 2cb810cb890a..f557150bd59a 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -22,24 +22,20 @@ static struct rxe_recv_sockets recv_sockets;
>=20
>  int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)  {
> -	int err;
>  	unsigned char ll_addr[ETH_ALEN];
>=20
>  	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
> -	err =3D dev_mc_add(rxe->ndev, ll_addr);
>=20
> -	return err;
> +	return dev_mc_add(rxe->ndev, ll_addr);
>  }
>=20
>  int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)  {
> -	int err;
>  	unsigned char ll_addr[ETH_ALEN];
>=20
>  	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
> -	err =3D dev_mc_del(rxe->ndev, ll_addr);
>=20
> -	return err;
> +	return dev_mc_del(rxe->ndev, ll_addr);
>  }
>=20
LGTM
Reviewed-by: Devesh Sharma <Devesh.s.sharma@oracle.com>

>  static struct dst_entry *rxe_find_route4(struct net_device *ndev,
> --
> 2.25.1

