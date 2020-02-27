Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C3F172988
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 21:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgB0Ug7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 15:36:59 -0500
Received: from mail-eopbgr20048.outbound.protection.outlook.com ([40.107.2.48]:28294
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729351AbgB0Ug7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 15:36:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYuA1ztfWTfzUZg/rNPlh5IE9OzODWzzWUe9GmijnYTVyxRz/nP6vhMY+5R2qjM4TQnhIFqEeQkwN51Zt1rSJ7SlLoqMbn6NFcvrcoIv/KfQcpv5dASjRiW3EvLO0xVcw30hl4xTa8EPESKtO3jCpyjsh4ZEodpTvF5jrNYOZRMUhHb45WA41ED3jT9jW4JZsvNv9oVAU56AJB558aEI+WHRHyzJKNcW4fwpFEAi0JUk7N50dChd2Ahj15X8az/rhcoXfQqMWVw6GtIJ367HKc8KtSb8DhsmOVRzxRC3x7i9LEsWhoJMHijpZmwWY98Cd965D9mP/HN85vkjlBptOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwGRv0Ya9DU04/0pupIOhnQK3VeBdHmgD9qibanIXwA=;
 b=K9t8WaOeDYjns02Tfr149xTb2doM0yubQb/YCg3gUJkT/o0sI2CWtfyRxjhUC3Igv+z9C5n456VRJEIwi/xWRNhgPK0p1CvYxMqHCy92eEfSCnVEl1IXQilYhWJ4t1xVyN/VV8qqUMHcNH5nPa0ul+OD2BIBv2zbyRMTkmf0R7eZUbBIFm/Wb3JSC/0P43zRDt1HXPjLr2E18m2XOrFVV1UeSZxna7iPoJHLQpcs6+veP+c6Hw0JZVMjijgRvtHeFL4ahsnYTImrLH0nSX6Yir19E9sCe/BIu36jN3M+A8aB7gQLH8FuHhIADf6Nfr5y+X8GK+A4Fjk0uT7VA7jTOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwGRv0Ya9DU04/0pupIOhnQK3VeBdHmgD9qibanIXwA=;
 b=M/U+V+/zbBShg6lTtUFH9DHubIlg6nMq6oXfX26oC2d3neKXweLCmIZTrTvzk5SGPhMBIAYRbJav/WrpQKp4h4yOifF51sZwyHZXXBexYr8GCflF4eyd73beREtXgmBuXAsty2GYBxyNQSUVEKqoAHVb5HONWNJ/D2LXx3Ld7GI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5439.eurprd05.prod.outlook.com (20.177.200.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 20:36:54 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 20:36:54 +0000
Date:   Thu, 27 Feb 2020 16:36:51 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bernard Metzler <bmt@zurich.ibm.com>, parav@mellanox.com
Subject: [PATCH] RDMA/cma: Teach lockdep about the order of rtnl and lock
Message-ID: <20200227203651.GA27185@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:208:160::23) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR13CA0010.namprd13.prod.outlook.com (2603:10b6:208:160::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.5 via Frontend Transport; Thu, 27 Feb 2020 20:36:54 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1j7Ptr-0006gI-9M; Thu, 27 Feb 2020 16:36:51 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 603ad65f-3b49-41a8-6ec9-08d7bbc4c82b
X-MS-TrafficTypeDiagnostic: VI1PR05MB5439:|VI1PR05MB5439:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB5439891488D5A3E042D56A4DCFEB0@VI1PR05MB5439.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(189003)(199004)(26005)(86362001)(8936002)(52116002)(6916009)(107886003)(8676002)(66946007)(9786002)(33656002)(9686003)(186003)(9746002)(66556008)(2906002)(5660300002)(66476007)(4326008)(36756003)(316002)(1076003)(478600001)(966005)(81166006)(81156014)(99710200001)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5439;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uenEb553IdDG+Kd7b+jqCZjwHORZSVvWRiQI9sJ2donP/CFHKAKJog5R6XFIi4W55Q1ukoaDUjqzuQOXHy+nQN6P6xG7voTnUPnnV+vB+VuKMsIfhW8LoEGMRE16CZpQ2Wv2ZH9VlEtZlN9oNvzszw2diGrxQEMpSRbRWurNu7pw6J7ze4J4dZ8V6KLeVB6owK/TkWzsvq48ExgAZpZ7ohTd6wD0SGShJpS/m22Vxu6pKypIVZrVfOhBFn+JtitfALuLfie7dcEXvUcKYfPO14eAuysQq5CGf95r1utCkcQrIhghiuew3b5F1ix2fSgVdScu9tn3Ldp3LFBJQbb6Rt6blm4u1NVCOzMGB0C83XvsdRpAIdbpW3xcv/yw/jOVd+NnxgzsaYsC0M4/cOaxdNELgg3AZzJxxSiieJ0eoBXhqryctLTooMPsCSo3J09GBjPTb6HWLzRiDXbTC8iGjzXh/onQSedgStat/vtbBTOuDZv4hY8u0Ixe0m0qmqAeFR07gSWnTjvLcC9O4L29Sq4mutw2pVjK8zMUhZU+2axnAf0OmQdD0ptSULEVkOImJgnHYUFKlBaMgr2sDeGbMr6aDdd9KUzFrAvoKMD958l2rAanPUFZmdA7CFRFaKEVsWxyfW+99bKKBmlgwIyPAbCz9FQSHxDMfX1teZoJkgsaazyYrNQ1klLTO5Noosk7
X-MS-Exchange-AntiSpam-MessageData: 4EqRORyzbFTXy8v2YduTGfEyRH+AS3jsmXYgQFXrf7mEIxwzVhYTsxIU7fILlGvfvxMnHXd7e+Hn3YSYOTrUdgJ3CBDK693mvzLegtcTvH12dCUBvcK2NSeXnU5eN7OI3SvI1cFC0dvXTm309cSblQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603ad65f-3b49-41a8-6ec9-08d7bbc4c82b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 20:36:54.4317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: za2AweDmcwqDBk1CErz5QZqXX+sWpsT90O8PHy7EL6fBhnHk4HS3HLdNBYABiFyEo2ViF2T/1ctxQeOFkGHgwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5439
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This lock ordering only happens when bonding is enabled and
a certain bonding related event fires. However, since it can happen this
is a global restriction on lock ordering.

Teach lockdep about the order directly and unconditionally so bugs here
are found quickly.

See https://syzkaller.appspot.com/bug?extid=55de90ab5f44172b0c90

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/cma.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

This will trigger siw to fail on module load, maybe other drivers too.

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 5165158a7aaa7d..c623d54ac9f944 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4789,6 +4789,19 @@ static int __init cma_init(void)
 {
 	int ret;
 
+	/*
+	 * There is a rare lock ordering dependency in cma_netdev_callback()
+	 * that only happens when bonding is enabled. Teach lockdep that rtnl
+	 * must never be nested under lock so it can find these without having
+	 * to test with bonding.
+	 */
+	if (IS_ENABLED(CONFIG_LOCKDEP)) {
+		rtnl_lock();
+		mutex_lock(&lock);
+		mutex_unlock(&lock);
+		rtnl_unlock();
+	}
+
 	cma_wq = alloc_ordered_workqueue("rdma_cm", WQ_MEM_RECLAIM);
 	if (!cma_wq)
 		return -ENOMEM;
-- 
2.25.0

