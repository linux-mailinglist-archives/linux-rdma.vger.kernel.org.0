Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E7F47537D
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 08:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbhLOHGF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Dec 2021 02:06:05 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:39668 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229853AbhLOHGE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Dec 2021 02:06:04 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BF50PA9007074;
        Wed, 15 Dec 2021 07:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8BxXfQwfRGcNVYmU1rfqC20U3ips75TS8j2TWfuo1f0=;
 b=IqUFFm2RmilOdZN3c43bqcdr6vsLihtLD5mGD6u9vXU8LB1sP2nqgnrXMNN3oeGj+ZFe
 MOYw5gODXsmZp7A0SX1tRcUplNUwsMaJ/5YE+/AGuILn9UNYdS7h/3nv5J3OHLjdalOe
 MP0pP7NL6DfzynNv5QVij3KoOxsUILDpBlbtHxo+NCMSIQBHkgKnmKhUr8y399E5I4cG
 Y+GnwaDUv6ppveW8f6KWlqNHbqzY6WYgbPgG6kxi/2AO5rIBf95BugUXAOYNjWm56f+W
 w9LkqbUKcLG+FysmAbGQAOHxbTlW7CIHm4LjCIkoNawVvi+Q+v5jqWTOeykApbDBiMIK wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx2nfe0nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 07:06:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BF70WYI017422;
        Wed, 15 Dec 2021 07:06:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3020.oracle.com with ESMTP id 3cxmrbe53b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 07:06:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEIR4a5wxbls+rlM3svrVgnU3Z5JU7SDPQyb+ozbrf1fqkZzsa6VZ1YP1nDUWesSY7TW14VW0uDSnr6t5pWDvbQZzgIfTa46wfbDlnSP2mPObniO8MueNfDstAvkmSlnNajMu6RCCE2pYg3sY4YmlyZyKyfkwNUw5SXW3kKcYUWm039ULLKcg+B5py9IABPJ/jp9AHqE3CxUk+KlhKtBKckEfNRvudb5L5RCJ07+WN4q4RBEUNVdvK7Xg/R0TQQnywA8jmgkj4a0A6jU5xptrXZDla5zJfE2sGRhKV2+dL8No49wviQZ9B3ZG4uVSXeq51umAJ2Jq8q+vb+EY6vjgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BxXfQwfRGcNVYmU1rfqC20U3ips75TS8j2TWfuo1f0=;
 b=bbLIxiU0YUv+iJZPwgBXQsFvJhZGn9CA6/lVtgdSUF7jSZ3ouu3jK9MMncWH+FZVPaFoa550vwN5UmPIdLOdK8YZizkqH4sKCa+MJrDNZ7W/HwBxqva15JWrs8wjeR53DBV79AHWpbxI6z2ZyftejSN4EJw1dJyV9nTw322cauxajOzRfcNp+x08dn/CYsN7FFyWVMKiroC4rsn33iMy5WewKyQBLm66zm+RF5Pu08vGoqHuNQ5aqzHJJv9uEQUAauON8sKpT6uAJn96/slW141Ll2C5f3UtL/wf8OCS+ALYbSRN1cUsnRpxee8fKYzUJ/kj9pK5TZ0E0zAliK9ulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BxXfQwfRGcNVYmU1rfqC20U3ips75TS8j2TWfuo1f0=;
 b=Yw0fhVhk+lGN9A70ezzHuRgTfdLdzLVU2UCHps4aWMn18spz8WPnFM8XCINns0Iy1Xe3bCho0HwUJhxPfFl2MCEsjrDc/NUEVjBkoTBjB+zVXqE8SoUOmT3sxnKF2uGp2z7KGIoZWqCheR4iAxKIsJ8hmYq/SI4M5cj+pEbMYQw=
Received: from CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6)
 by MW5PR10MB5805.namprd10.prod.outlook.com (2603:10b6:303:192::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Wed, 15 Dec
 2021 07:05:58 +0000
Received: from CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::eca2:ec30:e72f:93ee]) by CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::eca2:ec30:e72f:93ee%9]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 07:05:58 +0000
From:   Devesh Sharma <devesh.s.sharma@oracle.com>
To:     "cgel.zte@gmail.com" <cgel.zte@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: RE: [External] : [PATCH infiniband-next] drivers/infiniband: remove
 redundant err variable
Thread-Topic: [External] : [PATCH infiniband-next] drivers/infiniband: remove
 redundant err variable
Thread-Index: AQHX8Xnwbss9YZf1d0uHJXodl85i+KwzITKw
Date:   Wed, 15 Dec 2021 07:05:58 +0000
Message-ID: <CO6PR10MB56353FD77836D5605CDDB8DEDD769@CO6PR10MB5635.namprd10.prod.outlook.com>
References: <20211215060625.442082-1-chi.minghao@zte.com.cn>
In-Reply-To: <20211215060625.442082-1-chi.minghao@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f19dcc96-b376-4c6d-23e8-08d9bf99585a
x-ms-traffictypediagnostic: MW5PR10MB5805:EE_
x-microsoft-antispam-prvs: <MW5PR10MB58054ABB5A7ACBD8B54EFDEBDD769@MW5PR10MB5805.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: scNgb0cGaACxtsDwz3oFJyy/aN5zJr6ebjkWP58xTpxp4oj7xisbn8g2vqux++sMU4hC+orTV+DaUq7Gk6JWDrxsUPtcFgIDDUhPAAh1MAKDpiQZwlO5QeW4O1BfArFrMdzm624Cki724t3ryZARAKPef6VFFIytMH8j6mTRRpiVwbMSqoFp83H2zJTyfNlGZrki55aKbvtzj0DWxEroFjDDUqoCcGhSGId7LgitOSyAsfUac7tav7O99FFbrIfB3iRE6x8t9VsumtB5F0u7aXk33a0SoS/RBiu1R/fYJh/rXq1V5U6ms7UHRi/BPUpKghVwwuhzBMOSuN3R+NtgJNuY02/Zydr4xHYkGSMoi+JTWyhgoISDQ1wsL1lhu070rlCQOyR9ZdQrprtKsCQRn+jUmiG6fHpXgniN9YL6sXQ3ORzsBPdFQpbTql0YXmhOA2SZvu0JqAfE574kzp2bnLrQEV5DzdIIgwrZTgWeblcnakQ0xqFGViKlQn0zmFQOsmAFMz2klrUIBV9niXJoWmRdYzPtJ2mPdTcZ3ydY/iR/+j7KEqVBr8GgTOkqxl/pV+dnflm8MRwgEnxTwEautXwk9SoC4IX/ztmKg7f1hOgvruegJx/NKOAS6OM2XcQWzD3YOExRiFZ2w9D0n/NRT7Z1y7Ktf1m6Vr1DDrwcynMbN6sB6OnJ1+tJKtamScPUxo7dgFCVFd38J/ynHhQJMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5635.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(122000001)(110136005)(8676002)(33656002)(66476007)(4326008)(2906002)(186003)(52536014)(66446008)(76116006)(64756008)(83380400001)(66556008)(54906003)(9686003)(53546011)(26005)(71200400001)(7696005)(66946007)(508600001)(8936002)(86362001)(316002)(6506007)(55016003)(38100700002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1jjG+evs/xOFpEoxzyQOl/y4WDNUOERfIKmDLiHuYjjrQT6lbgZRgm/fqddJ?=
 =?us-ascii?Q?vmBICU71q34e97XI51s+/i+hkWcMU9+LlnRpszwpUk+gyYv5VQyywilYTfwd?=
 =?us-ascii?Q?sPwtcG6h8/Knhz7KkOtMKZilOuft0Y9276gJAz8rsIKdDU/SBIJa8SL4BhUi?=
 =?us-ascii?Q?nFfRjgRMLG4ZbcNfa1+f7RC8NTRJEyczk8duGFZZYHt3K+QVBFS4Lka62G7q?=
 =?us-ascii?Q?XLQqNEp9jzICUvRNXngIlXJnVLRAW1+eDLnLAqCi4OmXoENIqiwhDV9Yox84?=
 =?us-ascii?Q?/+1+p75mNqoWA5nAFth8GsffDHQaT5m9izOGFclHF8lJfmIO2E90sxif/M5N?=
 =?us-ascii?Q?/LkG5xAQnIJ/j5RF005QCbXlaWdcHvWlYh0fSD+WFdCcAQ/k6rdptOzKWMf2?=
 =?us-ascii?Q?w5MZRtG406/10UYx129Gnu794uyRu9G7O73PknEOngp/azLbfigT4C/9wuG2?=
 =?us-ascii?Q?Zsn5wm+FQwpiCSxvHhdVi4srUot7IQlUifJ6Zc7eEw1iJqhMRj8dcHknPcOA?=
 =?us-ascii?Q?E/7uePDxQoXAuHJXmmNJ9R3WIRnsoKKX9UAlk+ZRnFzJpVdWoulNEz8YGpqA?=
 =?us-ascii?Q?tuv5whReFVYPFTZ1EfL7h1tpqlZMIRyC378M2E+YrkEDDJkptT6e5sgmT4Oq?=
 =?us-ascii?Q?uHtrPS75wSx+MVBwTrCef6Gwb+qWESoCQwhn4ho88mL1eJ0pF1yqfpwdYxd3?=
 =?us-ascii?Q?jIwz9UKZsDKawXZDjn+dXqpkQeBnqsVbLQZYBLJvTIU58QmV98b1gVzGLQDw?=
 =?us-ascii?Q?siDAWA9M8GIdExSGbW0bn2PEQmjqkAEFGx/MU0/VhDlmbyj347fQ4pjnJL32?=
 =?us-ascii?Q?/npsmN5WiWwwqRpSILxp64fPp8CjYd9XDYGD0H1Say6hwwXTO8zWNs9uBU0v?=
 =?us-ascii?Q?vHMwONk3/tDGRlRg02EfuUVfr9ZXgmtWPMq/3pJ8CxUzy7hl4aVfY196YrXi?=
 =?us-ascii?Q?IYTuP6hBwnfQIg01HGbawc/pXSaEVAKRbnSE+3732xpobzRXFspI/YImhvNK?=
 =?us-ascii?Q?FPNPEveIQFWbKyPGRSNNTFzqAhm90/ESVdIrLzQcauGdARbaaAUWlqHPurSG?=
 =?us-ascii?Q?9Sbzt25LYceqzDw90paHLGPM+yh00Jan2ZGS00oVuEzUzogH3UYXR6xYvNLH?=
 =?us-ascii?Q?KpWcbKZdjnevMUPjBw15z8iT/GGRk7qnoE4g2HE1AMyJ9vH79DYmOcNiqAQ5?=
 =?us-ascii?Q?UEyGKWJR9ZClYScGdsZHnVi2C38N+42JSsT1DsKIVZwUEk51PqlGeu+7v84T?=
 =?us-ascii?Q?R6FmK2qUTkriIECA3nRI8JMXgfIt8WmyRrqxSXMjLcm1bnKBevmsyGjd4EWv?=
 =?us-ascii?Q?iQYHAZ3Rj4saYMwpP2hdWoUYXgvaNbCkKx5g2XpKlUpaRS043vxpj4BmRQnd?=
 =?us-ascii?Q?Eg1VjhD2bbZS08vgt15zqrljir2JXWqD38lbjXtnAb/1RcITf1i/27+FmRwb?=
 =?us-ascii?Q?i/zAe6GWqF32Jpx4rseFuMEFtE/kcbGaprHvqlkfcdSCR80qcfab1E6lG0XB?=
 =?us-ascii?Q?3cEt0oGAEtMSGZLUzmgzb0qqRgyxfpDmCswGuXjzGG5Sfl6fA4Jb3VmYw1eF?=
 =?us-ascii?Q?hnFwGjcB28R9OgvqQsEmJE3OQLs/sjnCqsDiRPzxq1qaleb+BgkIVU9Dd7Q2?=
 =?us-ascii?Q?+jCrEJjr8TXrP66Ts2GlS+X0PFJkNpHTm7wdvC8n/KZ+toDkQVLRauR7D6do?=
 =?us-ascii?Q?N5r0oA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5635.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f19dcc96-b376-4c6d-23e8-08d9bf99585a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 07:05:58.1575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xBr2/2vYLlruQ9TyBX8O0heNAG3bCuRKiy404VDQWebRXlfvmUaWC/N4gWek+7sK9AqUCt137jytoQfmDxytJZJxQpw+7P9v2kstobR0r7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5805
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10198 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=736 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112150039
X-Proofpoint-ORIG-GUID: 9Ed-nBoOKmPEmPDkdAL9WKRwWUBbo4XM
X-Proofpoint-GUID: 9Ed-nBoOKmPEmPDkdAL9WKRwWUBbo4XM
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: cgel.zte@gmail.com <cgel.zte@gmail.com>
> Sent: Wednesday, December 15, 2021 11:36 AM
> To: zyjzyj2000@gmail.com
> Cc: dledford@redhat.com; jgg@ziepe.ca; linux-rdma@vger.kernel.org; linux-
> kernel@vger.kernel.org; Minghao Chi <chi.minghao@zte.com.cn>; Zeal
> Robot <zealci@zte.com.cn>
> Subject: [External] : [PATCH infiniband-next] drivers/infiniband: remove


Change the subject line
[PATCH for-next] RDMA/rxe: ....

> redundant err variable
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
>  static struct dst_entry *rxe_find_route4(struct net_device *ndev,
> --
> 2.25.1

