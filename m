Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F7A417703
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Sep 2021 16:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346324AbhIXOrq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Sep 2021 10:47:46 -0400
Received: from mail-dm6nam10on2119.outbound.protection.outlook.com ([40.107.93.119]:17350
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231627AbhIXOrp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Sep 2021 10:47:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YR5rHb0Cser3TOH5G7WkM4WP1KFLhEmCOwc3UbM7dbEJPSxLdzCL1kD0KuWIeMnLDQPd2ah2m6o+rj9RIjAHMGyzNmpja4BJy+vMZF/s3tz9RthEm6HimPNzAigPsmI4YV4DEw0+BJz5xgmls2hcry78xOv5JZyGfKd6inNq8K/POV9mjStDBwO/+Ww+Xn2JhB0UeuEgLA9njgYInWwhqV1mhKUL9ZljpWffLKZ5Yd2IdoaYtGF2k3FF5CH1djjJzIIQ9uiZN0O56oxPfB51FEOSGKTsoPCbZGKWGJK2qf1Miyq/my2drU+HddU7BOKG0ZCVkBEnwTRZbcLpppV1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rGbPeZOVHXFpMn6r8hLtk8t+SZvU2bxJAcS0S2f78uE=;
 b=oT0AYUJp/yJGOgGzKes5FBRYrigtxLEu5/E10+FZeRJ3EpSTB9oAOSJYnnh+4Ger738H3S42YDfkAAGM4d9O6jwXsSzV0BVozaDqnBJfCOlZxLv9X81CF1V4+aQnR6NvSFPWWHF7BgIM+SMvLVF1/ru0vwmXSAALwJQQpn0jVUBgJKZvopaDOVB/CxEjyQtr4BJdS03A51Jw1azJplRGEXs9ePFQu8jlR3EFAymigihZJ9v/opzxGR7wCgu3OpaylUOzm+kvluKEkxgMGfthLrMyTbv2DxF1uw8nCoo66CKB5AtxRSOCNnfhFM//jOaCKZTbqV1UDwI+hlAdRwiTCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGbPeZOVHXFpMn6r8hLtk8t+SZvU2bxJAcS0S2f78uE=;
 b=MVpk/u7rpqjcwLRzapcAxRkWgiO2zM/RZ984r6obqBU0hobr/rarkxTNntIdeL6GIQ/KMbkVFzHmpmTx8Az32x0ctMNaQjLuQKryOwNJWFeSTJschiuNzGcik/nL94t8Gcx95/5QGGlYy4SEtMGHH1zMm5XnrEeN80AmYTwZjKsAwCBDAiFL2eNft7UuxOPt6K+vSLqCFPdXVFcIhBp/RdoRU7gewLwDortqulzNMTQKu1tYs+ZgTTs41uHRsn01QQ3bqn5TXlwJ1L8ZuyFqr5sM1J0dvp0KN3n13/Veh74Z3/QtvdFYYhQP/tRBRUZ0yVqGIt4Qh/0n6AiAmPco0w==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH2PR01MB5893.prod.exchangelabs.com (2603:10b6:610:41::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13; Fri, 24 Sep 2021 14:46:09 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::30a8:19a9:b5c7:96cd]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::30a8:19a9:b5c7:96cd%9]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 14:46:09 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Guo Zhi <qtxuning1999@sjtu.edu.cn>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
Thread-Topic: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
Thread-Index: AQHXr64eLoiKpRDRD0iedvDFbFrfHauzRfXQ
Date:   Fri, 24 Sep 2021 14:46:09 +0000
Message-ID: <CH0PR01MB71538BE2332867B20A4A77BEF2A49@CH0PR01MB7153.prod.exchangelabs.com>
References: <20210922123341.601450-1-qtxuning1999@sjtu.edu.cn>
In-Reply-To: <20210922123341.601450-1-qtxuning1999@sjtu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sjtu.edu.cn; dkim=none (message not signed)
 header.d=none;sjtu.edu.cn; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7108bd5-a5c2-40b0-f55a-08d97f6a0c20
x-ms-traffictypediagnostic: CH2PR01MB5893:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR01MB589345016787F69A3837F42AF2A49@CH2PR01MB5893.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rYv7UjxUHAlk+X/VbRGr2fCcmbyHiVRu1vMADCFJZsbK39osGUYgXaUqnuW7lDzUMQ8yv1q3RBD/8/sRapHWaD8qa6NJjT1RLRKZ+Nq6L7vJQkhWCFQAE339GhyNnZNc4jbrOhc3a9jYt4a8Gd+YObU76ob1KV2RXdlpZW8jeRPNxpwJ9AHXf5/JCsjfGADt5xkirX80WzvdLLR/0QnkYGwHl5eNUM+Ybq13oOjastTEzhwhgjX4yXsQTMDNMgTbDeYQ8O7vsZvb8ik30sBTptonSegkPu/ONTKRDdpkiK+6lvzPNPjq8hKA8UwRuiw0m16VYfu6xPMgACcI0p7o4qp0QmmGgLDaNDTltyurEIrb35TZvJlgbZ2uvh4mymzDWJHsi9wuGEOeBNeNQOBEu9quXdetx+LxRDnvCVCG+XHW/UAU9rHkVLizGdhX6I9L8lK735wOMbH6+1oFbxqGkpeTC7lNBQEwfYWOZRxyS5wrcbroapOD7rVUa5UTzMTWaVKg+WRBiLCJpcAQry1Rje7n1x0zRHsAJyVsbEgdasKKDSDJYza9Nbvv92cMDeqj5WzS4m3/rNY7nNkEAKa0f1bMOplAYM/NYogZQ4JAfDZniGix6Ol9v6f7zObVMCgInnPsJuheRBRJrW1m0F7Zs7IZtqe5/qvdD6I3tmHtDwOFDY8VPuel+PSKImVQHTz1sYUgbaK/fw3iMNulzWapSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(39840400004)(136003)(376002)(186003)(122000001)(4326008)(9686003)(508600001)(83380400001)(38070700005)(6506007)(52536014)(55016002)(54906003)(8936002)(86362001)(38100700002)(7696005)(71200400001)(316002)(33656002)(5660300002)(66446008)(110136005)(2906002)(26005)(8676002)(76116006)(66476007)(66556008)(64756008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9nAxP51Af1AThMaJKPspA4LxvN9G7Ol6FeVTuULr8uk782xcVy8Q6wgKFixi?=
 =?us-ascii?Q?MVqGU78encaifz1xMBVcrU4JsDZ8T1RoJWjGryiVzm3+PmbXhyib5Cie5rzU?=
 =?us-ascii?Q?dMpCrctAAJDvAKwDtCum8JqyB4yEX0/TFuRrVBfd8fJJpRpWo3H+W8dMaD8+?=
 =?us-ascii?Q?lmxd0nKnO+hD1mDOxyaepRn1V/2Eycp80aahLd/m52MaI3v0lD9riFVB5tJh?=
 =?us-ascii?Q?JYxWYXC+voGevtUYXrKgkNSG8RznDlY42DeqRP50Z1HBj8lyS515Nl1fAOBF?=
 =?us-ascii?Q?Ezta/jXJLyBGcrJciX2vNsu8xhS2L1f1HNaYA1u0nt5skwkLG4jJuAfFJt33?=
 =?us-ascii?Q?R3eRD/zPuiN9eEMzG41RdahF0r+17es+gG74EUmvN4j7gsyFJ0uQFUiYd06X?=
 =?us-ascii?Q?K8v9KA30+qIA2KwoDYAIVPmMydCa+U5RmqUcUitExLadvDwpAxCwQVSI1SpV?=
 =?us-ascii?Q?x+ps0fm8MzWd/g3vsV9ypOuuYuBaUcFny9O4Ri8UXCk/amkMS1+/UgAJ6wS6?=
 =?us-ascii?Q?SjWohtqqA7/KwWETi3UxkWzhBxO/dHMvXqSdRqvZgaXpXWAIYRXIcPqje9Vc?=
 =?us-ascii?Q?z3HGPKxRFTONMXgQTgAUBHQvclemMCbeMYugcAG+9JBbfiiJvRauvFJvbEkP?=
 =?us-ascii?Q?uqPdK2D8PWsmbRCjdZ0gmrpWEHyRhjW9pyJXQODkK2EDlB7q7VNjOLeLDzIZ?=
 =?us-ascii?Q?6LZg0fUNbagAI+fmzY3THlKmwQAXwpnRaPn/hrCbfKj9Sf+gboBmNdqbEnMs?=
 =?us-ascii?Q?aPCkxXD6REC1hc+X+k29l/vFedUawM050yyazcN+nie/nQJiO4E7LV+SFgm6?=
 =?us-ascii?Q?LY0ekRY9yvq9a+HMtn4njLFPeVEhcIEIc5ukOSyejfgpKG4//sKHFyoniJ3z?=
 =?us-ascii?Q?Tb4Zjw3XpCioAC/jvM+sIOyA/ZMriyzBmbQcpqqmrPiwFvcm/buXKAtOkKL6?=
 =?us-ascii?Q?6J4bcBdPwGIDVouW9sGCloysgernJyCnMX+e2reJgsbNHx4nRUXXZkYuXvri?=
 =?us-ascii?Q?87Fx8v31wawlkKxtTWybn33E/jx8uoYCTamIGSjsaFygEIkMTYVjACZVYIeF?=
 =?us-ascii?Q?navBkin3jz7aXeBiA8AVDnNsQ/YJOzwozKuhvDDV93jfMc8EiCT1h3DPmDbT?=
 =?us-ascii?Q?/WYA14UiwST5Cj0M1mEyD/oWZyDFG4ISVF+6iOdu9nNxM4jeP/ZdBCbswZAE?=
 =?us-ascii?Q?lpq/bKfg9uOEIPqKT7L7zVgPhfBzhpdVLpGFEaF0tq8aHbACywt0EtRc7ziW?=
 =?us-ascii?Q?BKkWFdGhL6R6hCfz9XYMRCM1e+f5Uaox/mi4autN9CoYVxEmkkgpxGB0BQYT?=
 =?us-ascii?Q?P1s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7108bd5-a5c2-40b0-f55a-08d97f6a0c20
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 14:46:09.5756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EDSc8Msk8sXxkKVw1IVdCjexuIrfz8uymQWRkk1pG0s2C2qf3Am1VIbV81xJHJ7kSb7jjIVWSuXC2RPcty1MIIY4FTJklbfkmFdnN7J4kaimWkNy/Jn+VgPOYeC1kvOm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB5893
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
>=20
> Pointers should be printed with %p or %px rather than cast to (unsigned l=
ong
> long) and printed with %llx.
> Change %llx to %p to print the pointer.
>=20
> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> ---
>  drivers/infiniband/hw/hfi1/ipoib_tx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c
> b/drivers/infiniband/hw/hfi1/ipoib_tx.c
> index e74ddbe4658..7381f352311 100644
> --- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
> +++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
> @@ -876,13 +876,13 @@ void hfi1_ipoib_tx_timeout(struct net_device
> *dev, unsigned int q)
>  	struct hfi1_ipoib_txq *txq =3D &priv->txqs[q];
>  	u64 completed =3D atomic64_read(&txq->complete_txreqs);
>=20
> -	dd_dev_info(priv->dd, "timeout txq %llx q %u stopped %u stops %d
> no_desc %d ring_full %d\n",
> +	dd_dev_info(priv->dd, "timeout txq %p q %u stopped %u stops %d
> no_desc
> +%d ring_full %d\n",
>  		    (unsigned long long)txq, q,
>  		    __netif_subqueue_stopped(dev, txq->q_idx),
>  		    atomic_read(&txq->stops),
>  		    atomic_read(&txq->no_desc),
>  		    atomic_read(&txq->ring_full));
> -	dd_dev_info(priv->dd, "sde %llx engine %u\n",
> +	dd_dev_info(priv->dd, "sde %p engine %u\n",
>  		    (unsigned long long)txq->sde,

Gho,

As Denny mentioned, I'm assuming that the case is no longer required?

Submit a v2 with that change and I will Ack.

Mike
