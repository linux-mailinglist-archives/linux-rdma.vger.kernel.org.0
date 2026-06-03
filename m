Return-Path: <linux-rdma+bounces-21707-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kUepOpqCIGoN4gAAu9opvQ
	(envelope-from <linux-rdma+bounces-21707-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 21:38:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FA563AE81
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 21:38:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ROJTpzrr;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21707-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21707-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2E5F3085908
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 19:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C20E48C3F0;
	Wed,  3 Jun 2026 19:33:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C774548BD55;
	Wed,  3 Jun 2026 19:33:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780515216; cv=fail; b=tlEkPWWwRSjVcQHNadtpssck5XYVC7T86iLVAJberfM/T4B479gGFKV8jFDycLyWyBlgatgTA7kSI4piVxR9zknAXNap9MoI0S800xQbaE4pXbKRbjyawzC8NeFVxXaaxi7ZaavcKvqKoijPDWWiNQYWDclO5s2fVKRXpdcQnLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780515216; c=relaxed/simple;
	bh=onO2pG1AEH3vk27xBQ4d1w+ps68z6VOvlyQl5+tp9go=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cE1BTK8ORF4srcOAQHEhXJLVM3AvYvKholFdSTgBh1co/pUfGJlwNA0Gs+0P18KVJ6hJZRXVQN/t4Pot4EgJc4Q46N6VBDfDAmOs1x0EHK3aQRs/8J2pY0JVVtvknWvaDDSg7tjPu1bMszw/gdUaQc5JksVv7HfYYOP6mIHMNVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ROJTpzrr; arc=fail smtp.client-ip=40.107.208.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4eiOqq+u1w5OEkf3XlOmT/EPXEW6224bmgZgaiptRl+bt+4GDmkqCdjv/EW0UzDO02Wrb05zLT+nrjxdLbjdvCOlCP9Gn5HfKAcHxJCHvRjgLvlmg/MV0aHkGDJ7zCFb/kB6np1F8EmqkEPYtB/nkCpYEND9nxH5TWczYJmjX3B+sH4b6oRVgBYS9FnvhDlZ2oVqJ75fH64K5i4noa9M7qwo+4SY340rldSDbO45BY5JOKFy8UlexiGwiwz/ijhoUpFOPgepm/vf5/LjGLixDEHU/SYeCar/7YwY7O8GnfI4E8zug9Pe6lw8br/nfc7l7aIuH+F1LrWWQkEPmhp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGwiBNv0ml5gByeB1UQLpeEIeyial0/9QwM1CoFdU1s=;
 b=jNXukeDF3xI+FIh45mpOIAYzzvDlDfe79XBrBRptbqtWsB6ytb1WbmjfYoKgpF1TFAiP8E70JcxQZQ3fbAoRb8+kQ4hESfuAaisjDmpOirSGuB1uuugr0SSksPVsjub6HP8JVlS9yaLzBLiC7WP2E0D04HvuN9/shjjzxPqxA3WiP6kDO222UNH4JDFVNUbhnGR6Hr00STaogHwqhIIExgrZKNmRThlJiqLxxmPhUlsbyITYznaZMQTlbNG+nhlamm6dTH6Y/uUN7NCxwP6ujcAKS/QJZVaB0qd+qbnNzBchgFvjvK9dfgF7xJQMMgNkYD/UTGD4bupWSMBm1mAW2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGwiBNv0ml5gByeB1UQLpeEIeyial0/9QwM1CoFdU1s=;
 b=ROJTpzrrg9NZmFKXpq/zoerm8kuHhglmWEEOPX11VxlmXiB09Fs4Nv2l53uCf8pNSF37/NF9gpyuCd03eMT3ga5AsLOCSd/sMIKICnoGOb8xU2cweOOwZtoZFruLik+qHgEfV7TO/d0ITxzdbO19K/OJoJtV6jImn+4u67dTlIaWgXK4HY7InBzIdEHzXEkmo1OV6GDNiKsXCEkmvYxczUgY3R1bF8TYYtYJqJk/tGLWnXCjCAAlzkrUdtq9nYCSNEFgUbEhLX6jcMciipC72GPpna3RyBS7qpEflUvJo1q/0Jq4K4Bb/48XguIEHyU6fqszhEK21Au7SbmB8QhXXg==
Received: from SJ0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:33a::9)
 by LV8PR12MB9406.namprd12.prod.outlook.com (2603:10b6:408:20b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 19:33:26 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::7e) by SJ0PR03CA0004.outlook.office365.com
 (2603:10b6:a03:33a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 19:33:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 19:33:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 12:33:10 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 3 Jun 2026 12:33:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 3 Jun 2026 12:33:01 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Sunil Goutham
	<sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya Sundeep
	<sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Borislav Petkov (AMD)"
	<bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap
	<rdunlap@infradead.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Petr Mladek <pmladek@suse.com>, Tejun Heo
	<tj@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Feng Tang
	<feng.tang@linux.alibaba.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>, Marco Elver
	<elver@google.com>, Eric Biggers <ebiggers@kernel.org>, Li RongQing
	<lirongqing@baidu.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Ethan
 Nelson-Moore" <enelsonmoore@gmail.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
Subject: [PATCH net-next V2 0/7] devlink: Add boot-time eswitch mode defaults
Date: Wed, 3 Jun 2026 22:32:52 +0300
Message-ID: <20260603193259.3412464-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|LV8PR12MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d0445c-7100-4766-a352-08dec1a6fa55
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|13003099007|18002099003|6133799003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	Drsn5poAL82PIaBkXOyUQrjkh3g5CbMLTEqWKuFbCxIWG6IhkNLRlE/vSYrU0/nloO6wB4ntZlsiz75XbIZdWmW5NySYJjgNmsrHKfa0EPelxhuYNxA/1iKYSOlZV0RoAk7o809B2rcKug6s7qINArr3xiHfhqM3yhy/Yjh55v4kgkPDW2sAwR/P9gsULTng10seRbuuE6zpvXi+S48m3umAkUFAY9Zwl7diUYphJI9VzfGTJfPO45rzEmlQoz2ziu+dyemMSLMhLCIB0CkYpruwigC3ZUAPF6RRzxsiNxwWkd0tN020SwURtrRKE6gUHn7yp2Cfn/aJ03s+xwnUJgQB9qL364BffkIraSGqoztQE4mOWpyt9+SLa4Y9dxcYXIBcJ/1Rg1Rmfq7ityjq3CY55ci0mQkLaJMi1oKZDfHxOCtu86SGcYt0xAYCsQ6WoQooV8yxKIQ830kS6ZorqyDWZlR5erB7oJ9CFUjuiAfnfJ8ZXQgbDaiVE3C7avQMOLwmbhALt7y8w2X4KPT062kfI8L7u3iUAXBwC97ShuSWO9OA4LzOPjJexaaLhucxhr9wV0oMd3aP29P6HX532AA4O+0ZojU0Uofc2CNsRi9RUE5HKkg+o09U6FIoMEe8XOEB7PHvBvq6RmeocJU3tOtjnBdIK4TAZ7QZjPqvHgdoWbojAsEhJYk2eOKmweDCjHKH+6qVBGoYmynostmhItGJMW99RDRtIPYXie8w+uk=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(13003099007)(18002099003)(6133799003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2757K8R+vN72yoPLlr88RsfpkJKmq5lsI7SH0XmRUlr4rAf1YBcQFwRE62SpeV+YDvqbasp6kwGDbN7ggukLHPGE7OYlUssh3PjmxoF+wDf8wZSpjCy5u0T7ruKP+kqWGiIanIAmlWl5GtK6ix5fUoSVkYmxQ+JWYDlIst4vP07ub57TYVSS+14lmvw/sy5raUCnN8QYkdyoZh5e1hrxv55QpyqDX546sEYUhLU1Yy9CanMmoBQx6UYpiDlVfoP7HprsEd1sNChIxZnCSut63CZORyMxrvIxxaB0eQpVCfZpdgE59PiWW4Q2HZdePGEfXhuOsDnHhSa/hPD5PlsOiDKnuMSrgkiYq3vYEKmWV8CsKHamClzHbLiABH3JVgIVpXJX8ulLiOOxvj86AfSFtxwN1Fhc3dY2DHOian2u7tL56iWl20gjCEZHGLNbUtkb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 19:33:24.1165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d0445c-7100-4766-a352-08dec1a6fa55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9406
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[41];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jiri@resnulli.us,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:bp@alien8.de,m:akpm@linux-foundation.org,m:rdunlap@infradead.org,m:peterz@infradead.org,m:tglx@kernel.org,m:pmladek@suse.com,m:tj@kernel.org,m:vbabka@kernel.org,m:feng.tang@linux.alibaba.com,m:dave.hansen@linux.intel.com,m:brauner@kernel.org,m:dapeng1.mi@linux.intel.com,m:kees@kernel.org,m:elver@google.com,m:ebiggers@kernel.org,m:lirongqing@baidu.com,m:paulmck@kernel.org,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21707-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[lwn.net,linuxfoundation.org,resnulli.us,kernel.org,marvell.com,nvidia.com,alien8.de,linux-foundation.org,infradead.org,suse.com,linux.alibaba.com,linux.intel.com,google.com,baidu.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74FA563AE81

This series adds a devlink_eswitch_mode= kernel command line parameter for
applying a default devlink eswitch mode during device initialization.

Following the discussion with Jakub[1] and the feedback on the RFC
postings, this version keeps the scope limited to a boot-time devlink
eswitch mode default only.

The option selects either all devlink handles or an explicit comma
separated handle list:

devlink_eswitch_mode=[*]:switchdev
devlink_eswitch_mode=[pci/0000:08:00.0,pci/0000:09:00.1]:switchdev_inactive

The supported modes are legacy, switchdev and switchdev_inactive. The
selected mode is applied through the existing eswitch_mode_set() devlink
operation, the same operation used by the devlink eswitch mode command.

The preparatory patches move registration points that expose the devlink
instance before the driver is ready for a registration-time eswitch mode
change. Where registration is moved later, the matching unregister path is
moved earlier so unregister notifications are sent from devl_unregister()
before object teardown. The final patch adds the parser and applies the
default from devlink core when a matching instance is registered and after
a successful devlink reload that performed DRIVER_REINIT.

Patch 1 skips devlink health recovery notifications while a devlink
instance is not registered. Health state and counters are still updated,
but there is no registered instance for userspace to observe or receive
notifications from yet. This lets drivers move registration later without
hitting health notification registration assertions during early
initialization.

Patch 2 moves netdevsim devlink registration after device initialization,
so registration-time defaults can call eswitch_mode_set() after simulator
state is ready. It also unregisters devlink before netdevsim tears down the
objects that were registered before devlink became visible.

Patch 3 clears the mlx5 FW reset-in-progress bit before reloading after a
firmware reset.

Patch 4 moves mlx5 devlink registration after device initialization,
including the lightweight init path, and moves unregister before the
matching teardown.

Patch 5 moves octeontx2 AF devlink registration after SR-IOV setup and
switch lock initialization.

Patch 6 moves octeontx2 PF devlink registration after PF SR-IOV state
setup.

Patch 7 adds the devlink_eswitch_mode= parser, documentation,
registration-time default application and successful reload default
application.

Changelog:

v1 -> v2:

- Move default eswitch mode application into devlink core. The default is
  now applied during devlink registration and after a successful devlink
  reload that performed DRIVER_REINIT.

- Remove the exported devl_apply_default_esw_mode() driver API and the mlx5
  driver-side call to it.

- Skip devlink health recovery notifications while the devlink instance is
  not registered, so drivers can move registration later without early
  health work hitting registration assertions.

- Move mlx5 devlink registration after device initialization, including the
  lightweight init path, so the core can apply the default through the
  normal registration flow.

- Move the matching netdevsim and mlx5 unregister paths before object
  teardown, so unregister notifications come from devl_unregister() and the
  later object teardown paths run while the devlink instance is no longer
  registered.

- Add registration-ordering preparation patches for netdevsim and octeontx2
  AF/PF, so their eswitch state is ready before registration-time defaults
  may call eswitch_mode_set().

[1] https://lore.kernel.org/all/20260502184153.4fd8d06f@kernel.org/
RFC V1 : https://lore.kernel.org/all/20260506123739.1959770-1-mbloch@nvidia.com/
RFC V2 : https://lore.kernel.org/all/20260510185424.2041415-1-mbloch@nvidia.com/
v1     : https://lore.kernel.org/all/20260521072434.362624-1-tariqt@nvidia.com/

Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Mark Bloch (7):
  devlink: Skip health recover notifications before register
  netdevsim: Register devlink after device init
  net/mlx5: Clear FW reset-in-progress bit before reload
  net/mlx5: Register devlink after device init
  octeontx2-af: Register devlink after SR-IOV init
  octeontx2-pf: Register devlink after SR-IOV state init
  devlink: Add eswitch mode boot defaults

 .../admin-guide/kernel-parameters.txt         |  25 ++
 .../networking/devlink/devlink-defaults.rst   |  80 ++++++
 Documentation/networking/devlink/index.rst    |   1 +
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  24 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  17 +-
 .../ethernet/mellanox/mlx5/core/fw_reset.c    |  28 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  34 ++-
 drivers/net/netdevsim/dev.c                   |  15 +-
 net/devlink/core.c                            | 261 ++++++++++++++++++
 net/devlink/dev.c                             |   3 +
 net/devlink/devl_internal.h                   |   1 +
 net/devlink/health.c                          |   3 +-
 12 files changed, 443 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/networking/devlink/devlink-defaults.rst


base-commit: dfcc2ff12925d99e858eaf539eaa4aaaf81fe2a6
-- 
2.34.1


