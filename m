Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8119E1F7550
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2020 10:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgFLIbV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jun 2020 04:31:21 -0400
Received: from mail-vi1eur05on2045.outbound.protection.outlook.com ([40.107.21.45]:6155
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726324AbgFLIbV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Jun 2020 04:31:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/W8ThfPQdYeEEOWZ/LoFm7hJyr8BGUT6+00e/a77PMc6/mJoXo7ENZNbZStV55zT9w+2Hp60FKpzbZCnG7LZuSe/MY1P92n4rKPgwwWCXOfVHXJO+Bdp7YMyFqBr5ji+09HZghCrStJ9o/MSqDZu9kCuHzzilKA47rURtrsvSfHJ6TOgEXZ0XFJY+xGuHzpByw0uYqS7IKCUMtF+1vBFShVe53iFA29sXDW0BxeeRTTLpCs6/ySjIUBG5+v1RMsKCia76by5GfdkLVENRycW+AfqI/Rlk5BDlUIWreX3yEPCjxDCEHCsgwEKfdvz/9ZUl3A8ZzicCsfcRJx6JPTbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCNo0M4LIPxXcgitgvCKTRLLhZ870+8uhmbFAUKec2o=;
 b=ZC5W8e8Nv9uAu4dg8MGOwGmzBbkSNJtRZUphi2hwropH4uSrYOv9nKDPmcQZEFo3zYoLSzdeu5qRUYmZd2erA+MSguyzNppl2rB1GTSj7fc4RGdpv/mkeeB3p9BMNUJgVCW1QQ9PS3kWNuaB08qwCnkB3KCKJ7I3X/K9A43uo/HS2DhehDQkZUg05n9qzr1eK/DMRv1iXDJ3NBLIdJNIjZUkEEWlFwWoVy63UAU0AYf1GxEywVEf0BsnRtJ3MjIDfnbIqNy3PgWP/c0nERLRtOKFs7RMtDC098kzXYtedRg2JZLSvEY7QsHfiwu7xakuD//56ZQjHcYEDB22AXNk0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCNo0M4LIPxXcgitgvCKTRLLhZ870+8uhmbFAUKec2o=;
 b=f2QL64sFUAbzp3LWasdGPPb3QCdSotbouvZXcvhz2rqCXfNbOIk82iwX7FMdYbzSgNKGxCfYh28eEqz/fEFNdMUiDXgekJP6LTL7CBQJ8iiqagat0lAnXi0aYkmv4j6XULe3wQlk6WsexUITgJB/kEAd1h6buoCur1Y0ZrEp6JQ=
Received: from AM6PR05MB6263.eurprd05.prod.outlook.com (2603:10a6:20b:5::31)
 by AM6PR05MB6390.eurprd05.prod.outlook.com (2603:10a6:20b:ba::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Fri, 12 Jun
 2020 08:31:17 +0000
Received: from AM6PR05MB6263.eurprd05.prod.outlook.com
 ([fe80::6dad:73a3:a3af:c829]) by AM6PR05MB6263.eurprd05.prod.outlook.com
 ([fe80::6dad:73a3:a3af:c829%6]) with mapi id 15.20.3088.025; Fri, 12 Jun 2020
 08:31:17 +0000
From:   Yanjun Zhu <yanjunz@mellanox.com>
To:     Kamal Heib <kamalheib1@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: RE: [PATCH for-rc] RDMA/rxe: Fix QP cleanup flow
Thread-Topic: [PATCH for-rc] RDMA/rxe: Fix QP cleanup flow
Thread-Index: AQHWOZBBHnUsw5bvPkOqgA8JjBE7FKjUtHGw
Date:   Fri, 12 Jun 2020 08:31:16 +0000
Message-ID: <AM6PR05MB6263D5C7548FFA67E4BCD29ED8810@AM6PR05MB6263.eurprd05.prod.outlook.com>
References: <20200603101738.159637-1-kamalheib1@gmail.com>
In-Reply-To: <20200603101738.159637-1-kamalheib1@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=mellanox.com;
x-originating-ip: [118.201.220.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9786f4f2-d46c-443e-0526-08d80eaaf9d3
x-ms-traffictypediagnostic: AM6PR05MB6390:
x-microsoft-antispam-prvs: <AM6PR05MB6390A55CA1D0D5163470D690D8810@AM6PR05MB6390.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:209;
x-forefront-prvs: 0432A04947
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dWkMBxDsxXSuosdK5ef24Hg2goQjG4UoPuV337PlI/mdf+m8QEWFUuAk9va0J0uAqAz8F1lgOtn3d5YzcIMM1yhtqRxCmZp7DRC/7evgweJ5RZbH/MtbbfVQCAsENtKN7JdAk1wCHqf27t0Aua/AL2OdsYGDSer05e67OryTS1CCAkjZeRvdA4QajxhmqWhGzgGfBW9wbA67w+hENuF3jyF9XQkPcKHfYng+0A96QWu4hQrPL1QA7UIpfIPx+Lt5drOsOI42F5q+2aYrwDQCffvKv6aJwS5ht5KcV2hMpm2k0CSutFhkIjvnph+BSXLJQxqEKvRVEN3fT7QKWXk5bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6263.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(8936002)(6506007)(316002)(4326008)(54906003)(9686003)(110136005)(53546011)(26005)(7696005)(186003)(55016002)(5660300002)(66946007)(66476007)(66446008)(71200400001)(83380400001)(64756008)(76116006)(66556008)(52536014)(2906002)(478600001)(33656002)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: cT7t6wm+jilwTSmDPqmD248aRGg7qbWAbtlLA0uANc+Mgs+YEpvgqvOJ3e/vjfJ6HSsQFVeCfYAAUcvSbVCvoL6U/+oVcsfClfTQzhoh8n3W6IH3xTF7i4RoliUMCJvN+3wkl8dAj1MY0tpXokio24IUMKQx/J1UlaY9U7cA7sAMiPCF4bt/4H4fw2VYrwhwuiKaUbGyLozcX3UOH03G/k9BI+tKwBbSykyAhccJjrJelNN1hIKmLe7mb/FKgIBGhv+NGo9KfRrQ0icu6xm640jsx91fwURtFk58gNuTJNbgw0rABQv4XtpkgZouahdTFl4PQlHfmS9GsCl4R5pjrh7Iilp5MBnFxaIiritwPJ1dKlmBR7EOamHtISMgn1zo4cbwkD50Pu38aQ2nq65I32EvX9H7SCsKvNoZ73gKMRZX4nAdaX3erl5OvmAykU4nIEdRv+aBFxzsGqzhtZ8CwcLD4891K6i30o2wldrG7VGeCaVfqgUdVRycGnWVr1LD
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9786f4f2-d46c-443e-0526-08d80eaaf9d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2020 08:31:16.9741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uX9ShIACsI36bOeVrK6FNijgJZuzTnb5qXWBSA9mh1JRyLch1WBTmmtJYRlHVMydDnMAx7nn9U5eKVLYGYMiIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6390
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



-----Original Message-----
From: Kamal Heib <kamalheib1@gmail.com>=20
Sent: Wednesday, June 3, 2020 6:18 PM
To: linux-rdma@vger.kernel.org
Cc: Doug Ledford <dledford@redhat.com>; Jason Gunthorpe <jgg@ziepe.ca>; Yan=
jun Zhu <yanjunz@mellanox.com>; Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc] RDMA/rxe: Fix QP cleanup flow

Avoid releasing the socket associated with each QP in rxe_qp_cleanup() whic=
h can sleep and move it to rxe_destroy_qp() instead, after doing this there=
 is no need for the execute_work that used to avoid calling
rxe_qp_cleanup() directly. also check that the socket is valid in
rxe_skb_tx_dtor() to avoid use-after-free.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Fixes: bb3ffb7ad48a ("RDMA/rxe: Fix rxe_qp_cleanup()")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c   | 14 ++++++++++++--
 drivers/infiniband/sw/rxe/rxe_qp.c    | 22 ++++++----------------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  3 ---
 3 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rx=
e/rxe_net.c
index 312c2fc961c0..298ccd3fd3e2 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -411,8 +411,18 @@ int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_bu=
ff *skb, u32 *crc)  static void rxe_skb_tx_dtor(struct sk_buff *skb)  {
 	struct sock *sk =3D skb->sk;
-	struct rxe_qp *qp =3D sk->sk_user_data;
-	int skb_out =3D atomic_dec_return(&qp->skb_out);
+	struct rxe_qp *qp;
+	int skb_out;
+
+	if (!sk)
+		return;
+
+	qp =3D sk->sk_user_data;
+
+	if (!qp)
+		return;
+
+	skb_out =3D atomic_dec_return(&qp->skb_out);
=20
 	if (unlikely(qp->need_req_skb &&
 		     skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW)) diff --git a/drivers/infin=
iband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 6c11c3aeeca6..89dac6c1111c 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -787,6 +787,7 @@ void rxe_qp_destroy(struct rxe_qp *qp)
 	if (qp_type(qp) =3D=3D IB_QPT_RC) {
 		del_timer_sync(&qp->retrans_timer);
 		del_timer_sync(&qp->rnr_nak_timer);
+		sk_dst_reset(qp->sk->sk);
 	}
=20
 	rxe_cleanup_task(&qp->req.task);
@@ -798,12 +799,15 @@ void rxe_qp_destroy(struct rxe_qp *qp)
 		__rxe_do_task(&qp->comp.task);
 		__rxe_do_task(&qp->req.task);
 	}
+
+	kernel_sock_shutdown(qp->sk, SHUT_RDWR);
+	sock_release(qp->sk);
 }
=20
 /* called when the last reference to the qp is dropped */ -static void rxe=
_qp_do_cleanup(struct work_struct *work)
+void rxe_qp_cleanup(struct rxe_pool_entry *arg)
 {
-	struct rxe_qp *qp =3D container_of(work, typeof(*qp), cleanup_work.work);
+	struct rxe_qp *qp =3D container_of(arg, typeof(*qp), pelem);
=20
 	rxe_drop_all_mcast_groups(qp);
=20
@@ -828,19 +832,5 @@ static void rxe_qp_do_cleanup(struct work_struct *work=
)
 		qp->resp.mr =3D NULL;
 	}
=20
-	if (qp_type(qp) =3D=3D IB_QPT_RC)
-		sk_dst_reset(qp->sk->sk);
-
 	free_rd_atomic_resources(qp);
-
-	kernel_sock_shutdown(qp->sk, SHUT_RDWR);
-	sock_release(qp->sk);
-}
-
-/* called when the last reference to the qp is dropped */ -void rxe_qp_cle=
anup(struct rxe_pool_entry *arg) -{
-	struct rxe_qp *qp =3D container_of(arg, typeof(*qp), pelem);
-
-	execute_in_process_context(rxe_qp_do_cleanup, &qp->cleanup_work);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/=
rxe/rxe_verbs.h
index 92de39c4a7c1..339debaf095f 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -35,7 +35,6 @@
 #define RXE_VERBS_H
=20
 #include <linux/interrupt.h>
-#include <linux/workqueue.h>
 #include <rdma/rdma_user_rxe.h>
 #include "rxe_pool.h"
 #include "rxe_task.h"
@@ -285,8 +284,6 @@ struct rxe_qp {
 	struct timer_list rnr_nak_timer;
=20
 	spinlock_t		state_lock; /* guard requester and completer */
-
-	struct execute_work	cleanup_work;
 };
=20
 enum rxe_mem_state {
--
2.25.4

