Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74559620EE
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 16:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732021AbfGHO4l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 10:56:41 -0400
Received: from mail-eopbgr30057.outbound.protection.outlook.com ([40.107.3.57]:39232
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726580AbfGHO4l (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 8 Jul 2019 10:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kDPGBcCAj6l3fHpTf3bVWd8OMi8i+AZ7q2gPfi9Gc4=;
 b=Nk066nZtI5vkz9VEJt7wI1Ib3d3XT4Ht9K7bqIEhev4DiHysVnLYnKmu71lzgH6SwHY6c1vCFQusNlFDEafPb7P4Wod7Iu9MTw8nNgpDzod0X10dCJ1R9WpcEtdRobdoVmYL5m7UqYqqiAwnI5EX4P+N6n8NlZGgj86uD4hv4vI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5070.eurprd05.prod.outlook.com (20.177.52.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Mon, 8 Jul 2019 14:56:34 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2052.020; Mon, 8 Jul 2019
 14:56:34 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Re: linux-next: build failure after merge of the rdma tree
Thread-Topic: Re: linux-next: build failure after merge of the rdma tree
Thread-Index: AQHVNTnJQ7fo7962E0CZw92tCt9dBKbAwusAgAAFYICAAAfnAA==
Date:   Mon, 8 Jul 2019 14:56:34 +0000
Message-ID: <20190708145630.GG23966@mellanox.com>
References: <20190708140858.GC23966@mellanox.com>
 <20190708130351.2141a39b@canb.auug.org.au>
 <OF8B5D0A35.3AB4C2D3-ON00258431.004F7CF8-00258431.004F7D00@notes.na.collabserv.com>
In-Reply-To: <OF8B5D0A35.3AB4C2D3-ON00258431.004F7CF8-00258431.004F7D00@notes.na.collabserv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:208:160::29) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37cb1c3e-3fef-4c78-1508-08d703b47862
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR05MB5070;
x-ms-traffictypediagnostic: VI1PR05MB5070:
x-microsoft-antispam-prvs: <VI1PR05MB50709CECDB3CFC54817B935ECFF60@VI1PR05MB5070.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(189003)(199004)(71190400001)(71200400001)(66446008)(64756008)(66556008)(66476007)(33656002)(66946007)(73956011)(36756003)(66066001)(86362001)(5660300002)(6512007)(6916009)(1076003)(6486002)(478600001)(486006)(305945005)(11346002)(68736007)(6436002)(53936002)(446003)(7736002)(476003)(2616005)(6116002)(8936002)(3846002)(4326008)(229853002)(81166006)(25786009)(8676002)(81156014)(14454004)(14444005)(102836004)(52116002)(6506007)(256004)(53546011)(2906002)(26005)(386003)(76176011)(99286004)(54906003)(186003)(316002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5070;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dCIASzRJUmLCmUq43NHuKXPahP7O2zcfJt1OmkvczkQb2+2ExAOC+CmZ96Zfu5iTbijgdXwiuknkybyWJG1fo1oIEojKYqNQoPymxrZcmldSks8+0LXyVZ80rdF84GejU0LTVHXJS21U6vLwq+d0JgFMEnewQ1AOH528J/lLIKWqcaa+Vig4jLIfuPt6T+RqSn5m13N37QYqzZRhvvMBaAIJYAX7c9sd6j4SkqXH8aDyxrCc61I2a1L+uNe9GmP9Foklc/sJjJV8qTE/0Bda1OnQqnsJrZ/TmGtQ6Di4wq4iOyVEt2xqWBbmxYwRgHyp12uu+29nVYQLz79ubCsB8a351hRQ+2mMUTescbFnKpKklAU8l/21ackj6wHJZ9NybWqGCQn/sE1qxyaRbiFW6vH0mn4DRMMkpv5CUsFH5Iw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DF44221C472AD84A8B4F9FA8BD74ACDC@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37cb1c3e-3fef-4c78-1508-08d703b47862
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 14:56:34.6484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5070
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 08, 2019 at 02:28:13PM +0000, Bernard Metzler wrote:

> Thanks for  bringing this up. Indeed, that explicit
> initialization seem to be inappropriate. Can you please
> fix that as you suggest?

I'm applying this to fix the PER_CPU stuff in siw:

From 4c7d6dcd364843e408a60952ba914bb72bafc6cc Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@mellanox.com>
Date: Mon, 8 Jul 2019 11:36:32 -0300
Subject: [PATCH] RDMA/siw: Fix DEFINE_PER_CPU compilation when
 ARCH_NEEDS_WEAK_PER_CPU

The initializer for the variable cannot be inside the macro (and zero
initialization isn't needed anyhow).

include/linux/percpu-defs.h:92:33: warning: '__pcpu_unique_use_cnt' initial=
ized and declared 'extern'
  extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;  \
                                 ^~~~~~~~~~~~~~
include/linux/percpu-defs.h:115:2: note: in expansion of macro 'DEFINE_PER_=
CPU_SECTION'
  DEFINE_PER_CPU_SECTION(type, name, "")
  ^~~~~~~~~~~~~~~~~~~~~~
drivers/infiniband/sw/siw/siw_main.c:129:8: note: in expansion of macro 'DE=
FINE_PER_CPU'
 static DEFINE_PER_CPU(atomic_t, use_cnt =3D ATOMIC_INIT(0));
        ^~~~~~~~~~~~~~

Also the rules for PER_CPU require the variable names to be globally
unique, so prefix them with siw_

Fixes: b9be6f18cf9e ("rdma/siw: transmit path")
Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/sw/siw/siw_main.c  |  8 ++++----
 drivers/infiniband/sw/siw/siw_qp_tx.c | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/s=
iw/siw_main.c
index 3f5f3d27ebe5a1..fd2552a9091dee 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -126,7 +126,7 @@ static int siw_dev_qualified(struct net_device *netdev)
 	return 0;
 }
=20
-static DEFINE_PER_CPU(atomic_t, use_cnt =3D ATOMIC_INIT(0));
+static DEFINE_PER_CPU(atomic_t, siw_use_cnt);
=20
 static struct {
 	struct cpumask **tx_valid_cpus;
@@ -215,7 +215,7 @@ int siw_get_tx_cpu(struct siw_device *sdev)
 		if (!siw_tx_thread[cpu])
 			continue;
=20
-		usage =3D atomic_read(&per_cpu(use_cnt, cpu));
+		usage =3D atomic_read(&per_cpu(siw_use_cnt, cpu));
 		if (usage <=3D min_use) {
 			tx_cpu =3D cpu;
 			min_use =3D usage;
@@ -226,7 +226,7 @@ int siw_get_tx_cpu(struct siw_device *sdev)
=20
 out:
 	if (tx_cpu >=3D 0)
-		atomic_inc(&per_cpu(use_cnt, tx_cpu));
+		atomic_inc(&per_cpu(siw_use_cnt, tx_cpu));
 	else
 		pr_warn("siw: no tx cpu found\n");
=20
@@ -235,7 +235,7 @@ int siw_get_tx_cpu(struct siw_device *sdev)
=20
 void siw_put_tx_cpu(int cpu)
 {
-	atomic_dec(&per_cpu(use_cnt, cpu));
+	atomic_dec(&per_cpu(siw_use_cnt, cpu));
 }
=20
 static struct ib_qp *siw_get_base_qp(struct ib_device *base_dev, int id)
diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/=
siw/siw_qp_tx.c
index 5e926fac51db30..1c9fa8fa96e513 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -1183,12 +1183,12 @@ struct tx_task_t {
 	wait_queue_head_t waiting;
 };
=20
-static DEFINE_PER_CPU(struct tx_task_t, tx_task_g);
+static DEFINE_PER_CPU(struct tx_task_t, siw_tx_task_g);
=20
 void siw_stop_tx_thread(int nr_cpu)
 {
 	kthread_stop(siw_tx_thread[nr_cpu]);
-	wake_up(&per_cpu(tx_task_g, nr_cpu).waiting);
+	wake_up(&per_cpu(siw_tx_task_g, nr_cpu).waiting);
 }
=20
 int siw_run_sq(void *data)
@@ -1196,7 +1196,7 @@ int siw_run_sq(void *data)
 	const int nr_cpu =3D (unsigned int)(long)data;
 	struct llist_node *active;
 	struct siw_qp *qp;
-	struct tx_task_t *tx_task =3D &per_cpu(tx_task_g, nr_cpu);
+	struct tx_task_t *tx_task =3D &per_cpu(siw_tx_task_g, nr_cpu);
=20
 	init_llist_head(&tx_task->active);
 	init_waitqueue_head(&tx_task->waiting);
@@ -1261,9 +1261,9 @@ int siw_sq_start(struct siw_qp *qp)
 	}
 	siw_qp_get(qp);
=20
-	llist_add(&qp->tx_list, &per_cpu(tx_task_g, qp->tx_cpu).active);
+	llist_add(&qp->tx_list, &per_cpu(siw_tx_task_g, qp->tx_cpu).active);
=20
-	wake_up(&per_cpu(tx_task_g, qp->tx_cpu).waiting);
+	wake_up(&per_cpu(siw_tx_task_g, qp->tx_cpu).waiting);
=20
 	return 0;
 }
--=20
2.21.0

