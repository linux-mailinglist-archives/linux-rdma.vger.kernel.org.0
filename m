Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E547B1651
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Sep 2023 10:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjI1IqY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Sep 2023 04:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjI1IqW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Sep 2023 04:46:22 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2073.outbound.protection.outlook.com [40.107.14.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF4D1A3;
        Thu, 28 Sep 2023 01:46:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OK3jRGoYb7nDSMzVelo77cgnfDD1ie2Cz4bhiZkMKUODoBYdKALgi5m4moPDek/wKaeKiZ6pDIh0xYVMledXiLiNl+2zHz+tQpy519ECYDdiuGGMeCBl7msaxhL3Mek3FZX8EMZXzmxKQQmYD2ry8pb9ILTO9xJdzlij/y3a16Dnk5IbvSWAU5X61ds5lMPfYq631nPVAfLRxnFnO5LWZ8eP0e+iMD/Jqabisy438bXj+12KY7leOMSkt/1RgR8gbipAiAprCR13ogVb1T+H76k54/YViLdvszHLIgVOnaKjX8XMztpP6wI0nF+OMNDEnTcU8Zk4Xd4GFRnI0Ap6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqJOThX61V7em4Tl2L3PoPhdRutUFGXNAxIZvKCj+NU=;
 b=a6+9Usdvyz7MBpcvLP8XHNsEeDy3wDxOLgSSZ9bpMWsMONErO/jwe/C1v1DBWb0fzFQeLH7jLeAgiamI5xrDIDjrG/6n4BuBSCSjzDiGl2HOso2mf5EMRu5FawrkRtXi2l26NYiJXPFX4eG8+SFYOxKkzWRVx98jI34NQ4C9CJ4pDEU6fUro4xminQoxi9gDkEA+FcgWKL1+IM+1VgSA52aYiohLrgAsSDAi+yJtOAu7/D7FcyPhqItUA+RoXqb7+K3rJ40aOOFQ+mMD8bfLBt8f+rGQ5lClj990rAZvnaOoxWMF5toCwQxZpdbrZ5sA6VDq4RRAb1m2FpsqDuOfvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqJOThX61V7em4Tl2L3PoPhdRutUFGXNAxIZvKCj+NU=;
 b=dOqS4s1BxRUj8gfeSpawkIB4oqe8a5q0VVfZwGTiFnPSwbIZIpSKvLz2mi1rruMonr9eA8rLlr+vFlMxWif5Y/wNhAlfrAAI7QfQZtQgq3j4ojYKgmiqLVYfEaXzcopNh6W1bXLnBvkNjOckW8Au6lg1WMxEue6kv0mE6ftRWaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS8PR04MB8514.eurprd04.prod.outlook.com (2603:10a6:20b:341::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 08:46:18 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 08:46:18 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, borisp@nvidia.com,
        saeedm@nvidia.com, leon@kernel.org, sd@queasysnail.net,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com, sebastian.tobuschat@oss.nxp.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v6 01/10] net: macsec: move sci_to_cpu to macsec header
Date:   Thu, 28 Sep 2023 11:44:21 +0300
Message-Id: <20230928084430.1882670-2-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928084430.1882670-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230928084430.1882670-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::31) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS8PR04MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 837957ae-4a9e-484e-3db6-08dbbfff5da5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: elePA4PQlGikRBRK3I6mcXehtXLpseMza2FEbNfWIifVSTGot7Bkve+M93kG2l5ZLCBLLJA7ud4gsL5z+nynPcvHUq7akgHhWGy9wz+v1nrH2LMPNxt9fHXOVNoxHNJRvKcLpYdqEKq11zg5hwNr9pH6zADRWlfIOKvv7yAuJxh+DaS+5aAF65xnrmjH2bbg879BpnHEm47P02gJUiUkxzh0M4gLpcTTnzcregn7FCIcm77ULIEe7KcgprhPeqoTXctvjQkvSsFJxrMpAc2utfeEWmcQuop9X6ujYA1xACogOL6w6qENR8wL4AGEUEpxlamm48gXeoF2vWO46Us79NiAZQS6CFS2f2B0xT+qINZNTHJg+ml4fnTMzeRttzRO5S+3HKNc6VNh95F4kL/tii34kEVJELkXiUW2A6Bv/ej//DvgCj5mncJGeiv3UeOxc1QMPpm9tpl9jL7/tAz2uMwVYjStweguHK2ZUnHDhPfasykIql4o8HV/YJ43FayLlSFxqfhEk9h5Q8rHXIhR/1yCw4hrjWmBEL5YmX2iwfOe3YAhvztNJVoO9W7w0YYFztu+ndju9aYE3upGm5KdYQIPEYaIMvyrofCH3hQ4ikZPr0mFxV56gdGCNVdBhp+IKZAzTF9wZQFCEgUsikqf2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(26005)(66476007)(66556008)(6666004)(86362001)(52116002)(1076003)(6512007)(6486002)(478600001)(2906002)(38350700002)(38100700002)(83380400001)(7416002)(316002)(8936002)(5660300002)(4326008)(2616005)(66946007)(8676002)(921005)(6636002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m4CCBy4Qa2IVRHPMPTv1Hyq+HIeCVL7AK5beU4JYjKJZ3PtSDbi9BIaX0n4f?=
 =?us-ascii?Q?9GuiB3Na0vUzeB6nCyBkOtuJJJI9AicpDVgy6BDHH88CQ/6Sv1W7hIU/H/ux?=
 =?us-ascii?Q?81Jz5N7R8zlp7tXSjU97pyotVvyXFmPOMBIghEw3AfUnH8eXgrsYh/pEAxgK?=
 =?us-ascii?Q?DmCwXeKN1G60Ceryrvo4k2Mm3w2lECu6fN4KddDa88VM1SbCCflsGJF0879e?=
 =?us-ascii?Q?+03CMjJDoYa+hM/le97pwyLidP/5iXdJtbHjdXdVVP0dG468LsituP/CKc+Z?=
 =?us-ascii?Q?YamBjIOWW8tyR3sQN4MWsNUpaj8FYMjCECBvSCZCPuoXD9hznGLwZgb4J0K2?=
 =?us-ascii?Q?So2NsY/aZZAsrmQhtd4cUw85wq5quTAfUHpWQurz9nI1gvjb9cmK+E/Vo9mB?=
 =?us-ascii?Q?kt+E3lAchNO1zuy3GZ8lUxWUrLhe+8odNrU+8mQ+R3gB0C589dObSrDE34f/?=
 =?us-ascii?Q?M00K+IpSj2e0RaTrd5i2NxnwHnEOgGlENUWbtRhH/50QXoMj+kvZP4lj6tY1?=
 =?us-ascii?Q?gk7yHClrQM4TWej8jqvcSRAXqXiJZCHBDjrG6sNRoG800OhEE4YxvuWWWoV5?=
 =?us-ascii?Q?crTHWKRmZzMSRw/+WY4IDW8cf64FlMu+UKXj2gpJSLELMeGVWd4e/Jq7SS7L?=
 =?us-ascii?Q?uVn+/Q7BFUScOWsStubEKMTkAaq4LxW+xB/aateLXWQIan+9F+yZ3AoC7cEP?=
 =?us-ascii?Q?1dCrEBodcHXNAqCbsN3/dj7ik9FBp4m+SnJHVOHzmEA19z7q2P6Yb5YugPs7?=
 =?us-ascii?Q?6ivXjABrZkLElM++BrKbG/vmFpdrZD+YRyru+VuQ5qsV0kHeTONe2DpAomxA?=
 =?us-ascii?Q?j7gCnpJCZgKXVg+aNr1+3uK62yr2f64yxr25T+YFz3hXymJHnOWyfaJwMvcD?=
 =?us-ascii?Q?fhnGFiUD4uo7/Go1ziFsQq3SYS2KzgIL2t24/6F8A+LTxBzzja6fpdq1dlIr?=
 =?us-ascii?Q?wpCi0+heA4Ozrm6v1WTERXMYAvNf6BVYtnI0zk6oMi+I9v2FKq2DWoAxj5U6?=
 =?us-ascii?Q?k6HpssU/+5u4+JxvRNYMcJUR1HIWDPgDyRr2beHQeitaczdpD3g9konF2Yiy?=
 =?us-ascii?Q?6/3zFeU+1nLiV/uyObAChxIZp6VQl1OsedcJHIK2CdiZYWJao2dkIVTYdbr2?=
 =?us-ascii?Q?0qFH2ajyYptLo6EEDrHJ49W8wtykF2Sx1ErdDFXE+L0HP0Prh/rnA4w33Wqn?=
 =?us-ascii?Q?5M+XhqvZnv315xhsP68/MtjsE0Z14pRLMXoU9qucQAZaTnpfpT5OJJKUOivq?=
 =?us-ascii?Q?85pTTd3ilpI8mCeuhpuUOKZFu/qGavAA9hes2NzZlQlJhpL2MehGbmIOksuO?=
 =?us-ascii?Q?17U42Q5qkJy8xBIcTP1z8Y6PepE8Bpv/LhJdTlDSgsvxVui6xJpwVee6+w17?=
 =?us-ascii?Q?T1pVGC8c18JNHjYR8s7zUAoALV9++F2xueg8VtUwOgYq710z8aiQFoKHGKJR?=
 =?us-ascii?Q?CmOqrlYWl7l9I77I011k9xZzyxlkUfUvQPEP3OIXMPLaYV5hNXCEctMV6ar/?=
 =?us-ascii?Q?vxcT52pHK4vcm+GvsTfgbRcfHpPwjhFLmoRvQ2IAjawDH+2ST7hPwYCobv5h?=
 =?us-ascii?Q?iz+0HhAn1QOMIErkAq83TYXFeouU0FnENWMWFQsyD1MpFqmRiYxsxuXNG957?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837957ae-4a9e-484e-3db6-08dbbfff5da5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 08:46:11.3569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jeo6J5C/HRW2MUV5pZoTBfi0uy7cItbSVHkLZom1cm5XCoULFoz9LIE6zWucqXR0TF4ThXPDAMxXFNc9+XqCVnNGLrENv89MrI0a5mWfrMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8514
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Move sci_to_cpu to the MACsec header to use it in drivers.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v6:
- none

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- patch added in v3

 drivers/net/netdevsim/macsec.c | 5 -----
 include/net/macsec.h           | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netdevsim/macsec.c b/drivers/net/netdevsim/macsec.c
index 0d5f50430dd3..aa007b1e4b78 100644
--- a/drivers/net/netdevsim/macsec.c
+++ b/drivers/net/netdevsim/macsec.c
@@ -3,11 +3,6 @@
 #include <net/macsec.h>
 #include "netdevsim.h"
 
-static inline u64 sci_to_cpu(sci_t sci)
-{
-	return be64_to_cpu((__force __be64)sci);
-}
-
 static int nsim_macsec_find_secy(struct netdevsim *ns, sci_t sci)
 {
 	int i;
diff --git a/include/net/macsec.h b/include/net/macsec.h
index 75a6f4863c83..75216efe4818 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -324,4 +324,9 @@ static inline void *macsec_netdev_priv(const struct net_device *dev)
 	return netdev_priv(dev);
 }
 
+static inline u64 sci_to_cpu(sci_t sci)
+{
+	return be64_to_cpu((__force __be64)sci);
+}
+
 #endif /* _NET_MACSEC_H_ */
-- 
2.34.1

