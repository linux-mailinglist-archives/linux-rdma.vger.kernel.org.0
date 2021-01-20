Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07182FD8C9
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jan 2021 19:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390160AbhATSti (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jan 2021 13:49:38 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:23440 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391957AbhATStX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Jan 2021 13:49:23 -0500
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10KIcJIB019061;
        Wed, 20 Jan 2021 18:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=9kxJp1X6p45IofkRoGcZakLYuBv4mXKFigcoGauHKgw=;
 b=nqZPoqFiZJU9Tx8R5ZcISjYyEQPqdP4q8VDKENnzysbcWt6DH6GXwNCvYrEaHzv7StpY
 D0mfKSKIRN7FTU/H5NxbtVPrSxbaphkX9fdIuUUWPC5srMi4Y3Dx26KDPEciShqIXgmI
 F/vk2t73TGOQMl79cnXvjx7/jFBZ9IdZdf2VIXDsO9Tczxs2SqM+gjIf0vOogOBtiQfe
 8PO33TtAz6hv2WxMGNkCx/T3+xppfxEEpEv/eBPUM/ixCGDkzj/aJuR7MIMLgTQf91ih
 eScXFx95Kg026LHTcLjFJxu11KBizZ26D59LDsUu9QtYz6+k2+mnTPq5WYpH0slyVq1x 9A== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 3668r307fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 18:48:14 +0000
Received: from G1W8107.americas.hpqcorp.net (g1w8107.austin.hp.com [16.193.72.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id C2E6792;
        Wed, 20 Jan 2021 18:48:13 +0000 (UTC)
Received: from G2W6309.americas.hpqcorp.net (2002:10c5:4033::10c5:4033) by
 G1W8107.americas.hpqcorp.net (2002:10c1:483b::10c1:483b) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 20 Jan 2021 18:48:13 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (15.241.52.11) by
 G2W6309.americas.hpqcorp.net (16.197.64.51) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 20 Jan 2021 18:48:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhgVx4iq4AxQEK5JMsXrPQgFbt9to6V13oi8eCBTFL3LAGTSPVsvPx/9FoFLcZbnnegOvjW9sJrT47N+xT7As7Ive+gCahY73kCBRPfZq70rt0COLmxn59RmuTZaZdk0ReuSWcSeQTUEGkJzmJgZ5vXYCa3CsTcn51fS+S9RZpKex810XwfEtRf6I7NEWwMHiTsICz4+vWlouZ7zOg+/DhpbqYmGtMF35i+Vfgz3iPoi6GspkM6OoNRDhbTN5ULzUdTfigC7uKKU6KxiDn5V0kCxRdn9zd5lhOX4RjNpV7wKc/FFRTnbqXJhWumuAOAWEfNw/oprFR12H0JCAVzeRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kxJp1X6p45IofkRoGcZakLYuBv4mXKFigcoGauHKgw=;
 b=VDge+FVfk3qEMGezRGsBA3Fp6NNt4+nSlbAQEmLJxYG2wmxMCoVZ4ekvunrdZizgmo/M+xh7RKNgUSAEQg28Vr3dfm97ayW7OXh0KjFiJgrv/uSIxDqzIHToMeMZOxF7AumrYdWrFXVZvVAVkJPFkfR/ljTMsol+LwANikeWcwFgjsq2EMbkcNTpkNJX0cWrW+lv1c+YOc6cpn6AqN/irpuP63J/Selzv3M6+9fBoibVUERAluzwE0DGBiPkAKcg5+K338KA7FzklG4engGike/86YIfiuCqAg1fxiM1vW4dvWfHfzSgI0dnYi8oUKWFwgz5byAlp68P/tY9C4UfzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750c::21) by CS1PR8401MB0870.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7508::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 20 Jan
 2021 18:48:12 +0000
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6df1:c76f:a5e7:844e]) by CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6df1:c76f:a5e7:844e%2]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 18:48:12 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Hillf Danton <hdanton@sina.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: FW: [PATCH for-next] RDMA/rxe: Fix bug in rxe_alloc
Thread-Topic: [PATCH for-next] RDMA/rxe: Fix bug in rxe_alloc
Thread-Index: AQHW7q0Fr8Ep3RKejkWEg7b67h/4laow1qMA
Date:   Wed, 20 Jan 2021 18:48:12 +0000
Message-ID: <CS1PR8401MB0821488ABBCDC7575CC237ABBCA20@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
References: <20210119214947.3833-1-rpearson@hpe.com>
In-Reply-To: <20210119214947.3833-1-rpearson@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [2603:8081:140c:1a00:f524:74e9:6e54:fceb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2fa47d8-86c4-4c61-0b91-08d8bd73f032
x-ms-traffictypediagnostic: CS1PR8401MB0870:
x-microsoft-antispam-prvs: <CS1PR8401MB087011E81DCBDFD546E655ABBCA29@CS1PR8401MB0870.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ww91JZSbYg/gVaom80fxQOp886Oasmf5I7jt6I22Y8NOPavOL3r4IDD+QNYHid0hcswq/2SpQUvyFHz+D4xQDiNHWXCHp/buDRBL5OUy0eobJC6CZJy4d9gtZCjHUygAXiHMJZGN/X3brjxDheliYsWOMMj8/IWGHTAYdBBTxiymuzm8PoSXsEMPXihTx68akR1yiZP6jbiw7fh5M0m0+9uArSJptkfkJZmwhUTwVSZPhzaKco0OO2kZpFFqbsU+b1jCqy9Xj8eZaibRpIVWmO6Jq8iABPn7pmgM3EK/5zdiGS2cQDocqBhMRhHdS0vjZUKMpDDF3mIsCpiVNO1qLrdjqHujTvrwXSBwhlGKVaW1i2gzZ36xH0sQ/3uEwx5SoGHQwiqPXE6xZe/cxAfvqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(366004)(376002)(136003)(8676002)(478600001)(2906002)(110136005)(76116006)(66476007)(71200400001)(186003)(66946007)(64756008)(66556008)(33656002)(53546011)(7696005)(6506007)(5660300002)(316002)(66446008)(83380400001)(52536014)(55016002)(9686003)(8936002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ODsGk18XBVsKL0vY+CzjT7p81rBx4+HGAUZx6rPP2oFtGl7Hbr28+uvob6Lw?=
 =?us-ascii?Q?q3/2xn70hhKPSU07h4iolSQ3bB7NTfpQbGnHpyjAMwSDqbbw8UE9g40Er0mw?=
 =?us-ascii?Q?DbsTFPvj5qPys4YRcRWplbN/kPtsn9+Q+3YLsJBPQRXQNNkJYIATxOkvdzPN?=
 =?us-ascii?Q?/Yb4tPk5k3n62Gck1BeP9Xs+qB9VzzzWuOh+KSPFBSQmwM8c0l0t2+FWOf4n?=
 =?us-ascii?Q?qsTCE/FRIoZWAJgJZWlmjHxZ91MTRCfCEJsq3q510UUQF5I67bWgdzGwPa6q?=
 =?us-ascii?Q?gwS7KyQf/3crTewfoBcbQPFZeRH4hKVbtykudPQwL2Fo6AMgbB6wzMbJLHVg?=
 =?us-ascii?Q?hKNzVuqE3MYvilKz5oZzrS2xqXiURF7C9W+AdT6Iy/QnoU3BvGfblf5STEXO?=
 =?us-ascii?Q?H283Ee7sdXx0pzqGXR5Gd21Z69iEb7Lsw7eLir5dCopLhPokwRdPFXSofUDN?=
 =?us-ascii?Q?1ArMe4M8LewdHCyR+Z/RCQE0tlWDGR2tYZ18VRaB5Zdd/dOzU1bNGCMGALwa?=
 =?us-ascii?Q?X5LUKBvrjURBvoilcOZUxh0nwi5eoxoX4On2FQa5Wrzm+rfaeUUDhvvo880s?=
 =?us-ascii?Q?bwyukhr+LAsB7iV+scp9Llp0xoW4BiPhw+nwDYv7TSzSTG76TuZXNaa93U2w?=
 =?us-ascii?Q?etrRfPRnmzZ5dzdhISpFOiDLK2B8DLl6uJiOUgKfE6Nipku36rYwQmKx8Nxc?=
 =?us-ascii?Q?o5UlEsvPeWlnWFhHJ1uwEVOB3CxvIXSvm/dsfwuGn/HgLFw4i9LsiU+B7SzI?=
 =?us-ascii?Q?OJBfJmTaSc0Zea+f7wd4WegBZ2L3zjgkQlLTEexkYU8O9iXxN3xbyuO4OqP2?=
 =?us-ascii?Q?rIkAHwRKSBcx9NSfHBbGpnUo0Ez+O7vhuomObSv3k/AXT48BtTeTSEtu0DBz?=
 =?us-ascii?Q?JuenKv3RCqXvz5JAYgnANiblxQHZNLXXC2+YA5Bt/qZPNTsmbm8dK5HCuWvv?=
 =?us-ascii?Q?1G6+BGL48pYuoLSMoPdiyBFqfLFgsn7reqDBVCJIj+33u4KSH7JaKmXV5XIb?=
 =?us-ascii?Q?TXpGF+NY7KjdM/vtjciBqVk9+HfRgjZQfWqdhVls50mnv6s=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fa47d8-86c4-4c61-0b91-08d8bd73f032
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 18:48:12.0835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KTzXqVlXURHKBRUuUYWpdMeZFz4oK1rZNZz8WnBM+GcHI+lnb/Qbf6M2GjmgnNYp5GBbBhytCA+pUT7LW44RyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0870
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-20_10:2021-01-20,2021-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101200108
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



-----Original Message-----
From: Bob Pearson <rpearsonhpe@gmail.com>=20
Sent: Tuesday, January 19, 2021 3:50 PM
To: jgg@ziepe.ca; zyjzyj2000@gmail.com; linux-rdma@vger.linux.org
Cc: Pearson, Robert B <robert.pearson2@hpe.com>; syzbot+ec2fd72374785d0e558=
e@syzkaller.appspotmail.com
Subject: [PATCH for-next] RDMA/rxe: Fix bug in rxe_alloc

A recent patch which added an 'unlocked' version of rxe_alloc introduced a =
bug causing kzalloc(..., GFP_KERNEL) to be called while holding a spin lock=
. This patch corrects that error.

rxe_alloc_nl() should always be called while holding the pool->pool_lock so=
 the argument to kzalloc should be GFP_ATOMIC.

rxe_alloc() prior to the change only locked the code around checking that p=
ool->state is RXE_POOL_STATE_VALID to avoid races between working threads a=
nd a thread shutting down the rxe driver. This patch reverts rxe_alloc() to=
 this behavior so the lock is not held when
kzalloc() is called.

Reported-by: syzbot+ec2fd72374785d0e558e@syzkaller.appspotmail.com
Fixes: 3853c35e243d ("RDMA/rxe: Add unlocked versions of pool APIs")
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 46 ++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/r=
xe/rxe_pool.c
index d26730eec720..dd02da007ae2 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -84,6 +84,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] =3D {
 		.name		=3D "rxe-mc_elem",
 		.size		=3D sizeof(struct rxe_mc_elem),
 		.elem_offset	=3D offsetof(struct rxe_mc_elem, pelem),
+		/* is created at interrupt level so avoid sleeps */
 		.flags		=3D RXE_POOL_ATOMIC,
 	},
 };
@@ -337,14 +338,13 @@ void __rxe_drop_index(struct rxe_pool_entry *elem)
 	write_unlock_irqrestore(&pool->pool_lock, flags);  }
=20
+/* only called while holding pool->pool_lock so must use GFP_ATOMIC */
 void *rxe_alloc_nl(struct rxe_pool *pool)  {
 	struct rxe_type_info *info =3D &rxe_type_info[pool->type];
 	struct rxe_pool_entry *elem;
 	u8 *obj;
=20
-	might_sleep_if(!(pool->flags & RXE_POOL_ATOMIC));
-
 	if (pool->state !=3D RXE_POOL_STATE_VALID)
 		return NULL;
=20
@@ -356,8 +356,7 @@ void *rxe_alloc_nl(struct rxe_pool *pool)
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
=20
-	obj =3D kzalloc(info->size, (pool->flags & RXE_POOL_ATOMIC) ?
-		      GFP_ATOMIC : GFP_KERNEL);
+	obj =3D kzalloc(info->size, GFP_ATOMIC);
 	if (!obj)
 		goto out_cnt;
=20
@@ -376,16 +375,51 @@ void *rxe_alloc_nl(struct rxe_pool *pool)
 	return NULL;
 }
=20
+/* objects which can be created at interrupt level should have
+ * have RXE_POOL_ATOMIC flag set
+ */
 void *rxe_alloc(struct rxe_pool *pool)
 {
-	u8 *obj;
 	unsigned long flags;
+	struct rxe_type_info *info =3D &rxe_type_info[pool->type];
+	struct rxe_pool_entry *elem;
+	u8 *obj;
+
+	might_sleep_if(!(pool->flags & RXE_POOL_ATOMIC));
=20
 	read_lock_irqsave(&pool->pool_lock, flags);
-	obj =3D rxe_alloc_nl(pool);
+	if (pool->state !=3D RXE_POOL_STATE_VALID) {
+		read_unlock_irqrestore(&pool->pool_lock, flags);
+		return NULL;
+	}
+
+	kref_get(&pool->ref_cnt);
 	read_unlock_irqrestore(&pool->pool_lock, flags);
=20
+	if (!ib_device_try_get(&pool->rxe->ib_dev))
+		goto out_put_pool;
+
+	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
+		goto out_cnt;
+
+	obj =3D kzalloc(info->size, (pool->flags & RXE_POOL_ATOMIC) ?
+		      GFP_ATOMIC : GFP_KERNEL);
+	if (!obj)
+		goto out_cnt;
+
+	elem =3D (struct rxe_pool_entry *)(obj + info->elem_offset);
+
+	elem->pool =3D pool;
+	kref_init(&elem->ref_cnt);
+
 	return obj;
+
+out_cnt:
+	atomic_dec(&pool->num_elem);
+	ib_device_put(&pool->rxe->ib_dev);
+out_put_pool:
+	rxe_pool_put(pool);
+	return NULL;
 }
=20
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
--
2.27.0

Hillf,

Not sure if you saw this. Your note also seems to be a patch to address the=
 syzkaller bug report.
It has some problems though. The only reason for adding the _nl versions of=
 the pool APIs was
to let the caller hold the pool->pool_lock which won't work since you take =
that lock in rxe_alloc_nl().
There was a race I saw in testing where two verbs API users were simultaneo=
usly trying to join a
multicast group and ended up creating two copies of the mcast group object =
which broke the mcast code.
The fix was to lock a sequence of checking to see if the group already exis=
ts followed by allocating and
filling in a new one if it doesn't. There are some other situations where t=
he same issue will come up.

As far as I can tell the RXE_POOL_ATOMIC flag is never needed and can be de=
leted. New objects are only
created from verbs API calls and never from interrupt level.

bob
