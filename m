Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E87E400027
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Sep 2021 15:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349030AbhICNIc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Sep 2021 09:08:32 -0400
Received: from mail-bn8nam12on2049.outbound.protection.outlook.com ([40.107.237.49]:26049
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229645AbhICNIb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 3 Sep 2021 09:08:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIbo2ExI6jnPb5mVd+9I+AGXPt422+27rHt9dotK+TgeWXzw2FxMW70d0eKxWjuOOH3Ylykk4jI9bowwTJwmgjUtuJAOcwdYRx6SyIRdGbjGilkAGcJZah8OIsLRCrZGSp2x3MOjZMay2mebf4/OMsbdSAoCR17IBeYtnGgMtgcyhsT9JcUGys5qa3fkMsHO8dCj57uUDmzC+zdlkwi0a1tiZP1n+ZMQ1/O1COAKLgKxfYRBQ3HML3SfoJDIaY9V0JuM7Hl4BGJ7uL8yDKATp4mpbdZw31ipDFZF/onOpG5f9A2E9wDB7bBCXUeF886n0P74/VnhUSD6DoTqz3iwxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgQp3qlHTjbfMLTxESpm+d5V7oCM4B/7H4NYHcDWNYk=;
 b=kgdiKJ5lrGIfvbyVKBWVTh0sFKUBaJ3V60gw+7IwTCtvypUyDnstIo9UwFDqzlhgebo5Zy4Nt0eLovg7riLBzgUChYdIErw+kCYDMS9Tthwo2mLe9flkRxIp25sf2MeVzjB6ZOBPY2iSqvUxcdNxOhVlt3mbqssKF34IiAYlJQZHAEfVhBKpe7tr6z7dQpLRE3iu9FemPltjjzV8lo88XT6Tn32A9+0wLKHhrYAlflI7rBdVyF+CktV8LYA42jOIQyVCj8kcwfvklKWt0DlaRtsC7aoI7tGsk2siq1nKptj9m8vRC2EqsVH+Yy4uQAPdW7sDMRBmGQ8wAlSxZneQiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgQp3qlHTjbfMLTxESpm+d5V7oCM4B/7H4NYHcDWNYk=;
 b=QoRU6P1YQLzH2kS12j2k+wbUhW1xxHmAWTnYg3WasILbRi/mZq3yMU/KChSEEMScudwLbiksQV5+eNDLNmmup3OmcMNqNoyW4AXuVBfuuVwgQjC0GX2iCVkTRwdEg8C+qEWmBZFcOesBt+afYi9t2Eu1mf1j7Z5xuYEyEmjMOryg+cZ/AxLbfTQpgNiE5LYXEuxosJ/yfYqtFOyaAzoDxkxoHQ3hbAZ0jIClakrOT30tjsf5KDowz8g9yNyQdyxCKZbWagVNXrbvJOlfYcvThJlNY+eliY26b/pA3zJJbNGHCVMr5/ngOowtBMc92ZOGQCOlrL02huF5luGHRRsXEg==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5352.namprd12.prod.outlook.com (2603:10b6:208:314::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 3 Sep
 2021 13:07:30 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 13:07:30 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        kernel test robot <lkp@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] IB/qib: Fix null pointer subtraction compiler warning
Date:   Fri,  3 Sep 2021 10:07:28 -0300
Message-Id: <0-v1-43ae3c759177+65-qib_type_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:208:23a::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR03CA0015.namprd03.prod.outlook.com (2603:10b6:208:23a::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Fri, 3 Sep 2021 13:07:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mM8un-00AmvJ-1M; Fri, 03 Sep 2021 10:07:29 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b64a051-e043-4276-a208-08d96edbc94f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5352:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB535270D9A252667147C6E032C2CF9@BL1PR12MB5352.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:318;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EsmNxX8OqoANiB8qsgQE1v9ptoB4na3SneZl6Z2fLTliPbTtXQ2GV40kz+hxIf53klAh4b/0PqYSrpGyot1DtflSnmaspv/YW1LvwtrJAgsPr6ApUMYAnCADGM1o40GIPDJlL7kDH1CvPB7JbFYcmvSHNwNoWzYM1cJ3xNz5r3j8u6m3hAZeThZMRuIfAnZvjFaFBNRaWSrMEwfMpy6swTPObWCczBl9KLAvY2Qgyf6n6ZiUIxEOpZOj7gNqcVkPLloJof18VUKfk6e0Mta65QXcNIMaCPPRK/Mhnwr/Jwk6n4JcTaUA0U8QXbVY9USQ1hMqO3E8YqJoy/a9aF3vIRCWMFkJUcw4wqZuHvHAs3JKxK37pJ7sNtJ4Xd1FbyXcGNPjeWK1DrczW3LOZqGW+oQN8Yxj7tTXkzb7Ed512xELgBILdIpMd26+Vxul7yvpnwWQvK+H8GRM0FHsFPWTb4peuCkPmh68Efg5tHJtkZlDGGpnVEkjOoVrw1ibCiEanV6iLHJoE4WePcski+lPr9q6CHsLXqLzuQ+ayBSWKnmEj1/ozwOw9A4u+JPVOiHeh/oy90seXUlHwoEGxDx+mv6nv5locLjDBWPqyesck+ighdKSqp05NJB4s1w16PVs2PjzUoDNocgKOUin91iczBcufT0aVeJM3xekYxSTc8uIGnBGxt4lsVsPL1EncdAY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(2906002)(9786002)(9746002)(8936002)(83380400001)(8676002)(2616005)(4326008)(478600001)(38100700002)(186003)(5660300002)(66946007)(54906003)(86362001)(66556008)(36756003)(426003)(316002)(26005)(66476007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1RiKMZJoHc9eZeYeBErSaYJClzWVVomz/HyPNRuQvrMEvTkmKTRmU+7g7EnJ?=
 =?us-ascii?Q?0m+iA3UBWs0lAx4bCxhkG2yMOXzlRoaE1iuE9fFRS59jtl5yzmV+eoNgzjTF?=
 =?us-ascii?Q?FHmckqxviCAPxS7S/StSujEJT4PvX4b2LR4x14EIk0BgsQNo44VzGe4pHS7X?=
 =?us-ascii?Q?zWMpJAW10hPeqNWR1v9UmgU3exBI8NUZ5i5tkHMV6T9UbBb61OQKvb4/6PJK?=
 =?us-ascii?Q?vkyz5pNzcjgBnd4tj1NRvhHBmYJpOaFi/CVwm3F3ICPSdwDmSMR+MVpNcRZl?=
 =?us-ascii?Q?zR7AMrcnD6HNfQYozJ8yUri+H+jHqSWDGpqf5Mk7/93PU9uG8PO1mKq+R7S9?=
 =?us-ascii?Q?LYBFIdKTVtzHZJ7cEWl+EIRQ+OGATaZ+1dgYvLoEfPHVmPHoWY9uElpfnBFj?=
 =?us-ascii?Q?X8SVNpkgHxskDJa1qaJ0qRmVD7uOvaQQxlVBcQacFygVwXBJaiY9BdtsdZFA?=
 =?us-ascii?Q?U6G/QWTOw8pv6A8ZjY8lZbqekZYNub2WkTfVKY1BJvL5h33XqAAl8dCB35ba?=
 =?us-ascii?Q?O4j2QfyhoD6Zu8+EjcztmATs6ebVrT61I4yRytuWUbZZXHo1BNuvcYcn5VYi?=
 =?us-ascii?Q?MV/l59JwssDY59osC1bg4vbrxejvqLmM1bM6nE3MmlNPvW1lkk11NLu6Xdgf?=
 =?us-ascii?Q?ep+wL8iI8QV6bn6LaAqX2/+FqeoOJF8GdorlNb0FrfkR5QXmGCuA32lD1BjI?=
 =?us-ascii?Q?b9251HhKjhAygWylP9TTAo7+kxnrMW/orgAj8dqWO9Ri5vpiFdPkH1x23GA4?=
 =?us-ascii?Q?EizmG0iblfkORzX2w+J0RbDPqMIYUAPDl1J2yRx/JsyJcwaIlHwVwShBenI4?=
 =?us-ascii?Q?xluA0rN9N+C0l0recivLXTgNGI+BPzAmA8ln+Tt5AetdyvY0MepMyUN8SSIm?=
 =?us-ascii?Q?6PfqcP615W10G2IitxxMltweQAbX/MQM0dXOkK8EyQDFIj6aTMdkaj7Q5aUH?=
 =?us-ascii?Q?bbxQDTmY2KyR6I/hqDUUX9eJ73plr8NrHVcuVZSPZdv9YUIMrQ0PDAM8wUTo?=
 =?us-ascii?Q?Lo3YVcrx6pK/PQ8/Mk5GHymFSB/BXrkroRVcfWg2Wj/jx6WMb2XgIOORNYFZ?=
 =?us-ascii?Q?ujIBRihH+NcDq2w9lbZDbG1lkjFrBRJi2eJDZl0eMfVnCihExI4D8xRmRz+y?=
 =?us-ascii?Q?HS3DJZfGYx8NbQ5Pi10hP5nnXfBWj6SwywYdLXh3DIF0HSDUAkLpXFuY6KgL?=
 =?us-ascii?Q?kMs3U7qJl6I/+1t3CWNbtKesZGIQc5diw9kdaHBUmqYdxxmLCzjS5AYe6tVW?=
 =?us-ascii?Q?DpSAR+8Ote1Obz7IwJR2tai86p3RjsflInzDouJu2/xP+5u815xXdzegoAXx?=
 =?us-ascii?Q?WD6Uodlmz1XVmmydbe83oYuB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b64a051-e043-4276-a208-08d96edbc94f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 13:07:30.5879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLiVyTNOGjkUFj6gAMF/bSuSMPBsSt0hTxWTOmQ3f551y2KUok8gp7K585H0FwX4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5352
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>> drivers/infiniband/hw/qib/qib_sysfs.c:411:1: warning: performing pointer subtraction with a null pointer has undefined behavior
+[-Wnull-pointer-subtraction]
   QIB_DIAGC_ATTR(rc_resends);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/infiniband/hw/qib/qib_sysfs.c:408:51: note: expanded from macro 'QIB_DIAGC_ATTR'
                   .counter = &((struct qib_ibport *)0)->rvp.n_##N - (u64 *)0,    \

Use offsetof and accomplish the type check using static_assert.

Fixes: 4a7aaf88c89f ("RDMA/qib: Use attributes for the port sysfs")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/qib/qib_sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_sysfs.c b/drivers/infiniband/hw/qib/qib_sysfs.c
index d57e49de6650be..452e2355d24eeb 100644
--- a/drivers/infiniband/hw/qib/qib_sysfs.c
+++ b/drivers/infiniband/hw/qib/qib_sysfs.c
@@ -403,9 +403,11 @@ static ssize_t diagc_attr_store(struct ib_device *ibdev, u32 port_num,
 }
 
 #define QIB_DIAGC_ATTR(N)                                                      \
+	static_assert(&((struct qib_ibport *)0)->rvp.n_##N != (u64 *)NULL);    \
 	static struct qib_diagc_attr qib_diagc_attr_##N = {                    \
 		.attr = __ATTR(N, 0664, diagc_attr_show, diagc_attr_store),    \
-		.counter = &((struct qib_ibport *)0)->rvp.n_##N - (u64 *)0,    \
+		.counter =                                                     \
+			offsetof(struct qib_ibport, rvp.n_##N) / sizeof(u64)   \
 	}
 
 QIB_DIAGC_ATTR(rc_resends);

base-commit: 6a217437f9f5482a3f6f2dc5fcd27cf0f62409ac
-- 
2.33.0

