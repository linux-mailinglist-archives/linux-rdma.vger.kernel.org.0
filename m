Return-Path: <linux-rdma+bounces-21866-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EyT4N0MTI2rdhgEAu9opvQ
	(envelope-from <linux-rdma+bounces-21866-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 20:19:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B8D64A856
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 20:19:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=NMgXGUvA;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21866-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21866-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E10EF300C905
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 18:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7313A3821;
	Fri,  5 Jun 2026 18:11:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013033.outbound.protection.outlook.com [40.93.196.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA639383C94;
	Fri,  5 Jun 2026 18:11:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683083; cv=fail; b=d2l3+e2zIUKJBx4EP0YefqwgxYmsv2dCV2QQul6L6TevSt82PrxQp2QVSkUj3gqGniqKVjx0UeUjC5JBVGlB2I07F5+Cqa0iBvbnTzBaQ2MUAEh35HhSI8309pMQxLcHC5EAfclQn6XtosU+Cfb9LaYCvtxrWwqzROhb6SBq4g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683083; c=relaxed/simple;
	bh=3L4qTVaXVsHhZGtPKr5grk91uzRlksA5PWNKFDY+HD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqfJ9s80haqFeOtp9jzlRPlPL/TOs4qpDidlRq7l2TzAUzPU2l50lvdMzCEF9+n8qb1hRQEJTjkVd9znVT6wbeyjwp7Mk6mG9rjLmWoPtnS2C9ZfmW7PdgfMk1xQYXkA9d0m0fZdXl0FmWsXViV+QiLqPf0aokUhyJx7IeqQrFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NMgXGUvA; arc=fail smtp.client-ip=40.93.196.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSQTqmuiwMe90ZCSJBrpzv6qEPhA3O8h6nt1nweAkG7APgFKEfGqc7j1rUHnGb0YeUJI7jYv1gEKAyZf8Nv4duvR8mmjWRVanNwUbXBfiUuq88cCuKZNkrVFphDZD+tIbQg4H5gRpSdDBUa/SGcg5nYoAIl5xumHGV9/0OyNCqcaPCBEM431mbllhUZ92CFrIONVzm3x9cLv3SRIx+8n9F3F1S9n+/OUX2OsuPWqF+edhRgLE2aX/fyjSuV0d07E7v19ewAsXk90oZhXIOb+t4VOZRy3t32WJ8WQYpfUg7KrNBnZaFci907rFu9xhzZXqSmeEsJYS3OVuxUgGq11+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwMMEhxYUtogO9ja4xvnvWwjCYS+isEdhmWIzJuXmR4=;
 b=T1av4hiT/UUSzQrJvFrOm7gfJ1MP/x7xTmoY2MuTKGUZWWq1kiph2KUsy0+KHka5YqYVMOtgH61T4/Iu6+OTRc193jHZfm2G6QgWQnpkrPtMmtZjFCmshpEWr4D9fsgbjxGJfFvXoGEJerP4nfn7ERhfdHLUtoeRwul5QFCjG0BzNjBXheonFJJUnwiTvVjhtXOBFr0tddfFYx4r9cIiJZey5Tt+ZBhu/Qx9KLhi7dwjUNTewMemAyJJoOCD03bg7Qwtvk0aqtC2M0/jgxCYv69cMzvXmj/lle5sHhfMeQeIzjTFmBwZhkXkbXqKDG30PFZ+FMaUDOc7WsqltqpLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwMMEhxYUtogO9ja4xvnvWwjCYS+isEdhmWIzJuXmR4=;
 b=NMgXGUvAp8M+laJtLNEtIVTJ+88bU/t0VEEwwPsSB3jkzllzYc4gXgwNspUA7BjfMkJ6xi0OyfXIhJPsomhHY2KP7zwurmFSVYG5oX0UMLlt8cxsx3s6vy22lG+KzfCaayUSYfVCdACc45hArWxZL1aoXtlLXafK7tePdvxKd/PQxZCMeDmFayQcUe1zn2Oqfv1pU0cLsYYTm6d+EITx5g8TRglrsyYU5qGJmw9pKRx6JK3jsJ+DwB+RcaMjhqi9QgfaG3LVIyJ1Mf/u5kiUNCKceT+rq2cg6fNG3K3T9IvoxZpgH3qp/HSXRj1ibdT1ETaW5SMfDVIQIcvHDg1DfA==
Received: from CH5P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::25)
 by LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 18:11:15 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::40) by CH5P222CA0009.outlook.office365.com
 (2603:10b6:610:1ee::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 18:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 18:11:14 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Jun
 2026 11:10:59 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 5 Jun 2026 11:10:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 5 Jun 2026 11:10:50 -0700
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
	<rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Petr Mladek
	<pmladek@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Vlastimil Babka <vbabka@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>, Feng Tang
	<feng.tang@linux.alibaba.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, "Kees
 Cook" <kees@kernel.org>, Marco Elver <elver@google.com>, Eric Biggers
	<ebiggers@kernel.org>, Li RongQing <lirongqing@baidu.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [PATCH net-next V3 2/7] netdevsim: Register devlink after device init
Date: Fri, 5 Jun 2026 21:10:25 +0300
Message-ID: <20260605181030.3486619-3-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605181030.3486619-1-mbloch@nvidia.com>
References: <20260605181030.3486619-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|LV2PR12MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac8e2e1-5a19-4a0d-1375-08dec32dd526
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|56012099006|11063799006|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ftWqh5jr5h+DAdGQd8P6qkG/VSJEuWDWYCpxEtzlidZmPJas3YcdnL1t/NS+I40JGQllK52k5e1q+hgtBf1XJYLQvlc3S8BU6xUTWH+KhiQGDmAjnZpIiDP4/eU3pH+adEFKgF7/uBct7BicYbGjWIlXM49C05rIcFZKpSjN4rLGlaytEeB7nIVZGop+JSOiYm/mkLi/Ms0uwUJrQGvIiAB79Hd3GoJtG0qJgHbq+U8q5ufepOYuBpYdKfG9jUacoI9wOsQHHnSrhiLAh5mqYI4+HKqY8MAxhm99HImQEw9G8jvsDi4O0fpZe/uZ6NOpUMMj1YTvJl3fUI8HlhZet2a7oPpXD0945XlzL5xGMHDwq0qhvOf7JYGzy2A4VdZEsBV0djcsX4sEStn5MiuWFUqS5cXHPtQD7o2vV77XbMHsHfhXO4FxC6wiyCVPIM8il1s2yp9wb9uQb58HehEWgusjmIhyVEklJFMPIgU4i6mZ5FLTJy1x6V/M/t/V0rJvZjmzMqj/fGdI2l3rNnbH6wW40CRpGnNyTQ4qUnKwQKq9Dz9j3OFVgI33WDNpclsc2oL/YFSnqWStydhOXe9yKrWg3WqtjUtXFVS1Ib9g49cVItVFhc4DA/2ZfqY6L9mCm01ze3EJCkVu1/3U58rDsX46UbNDdgi7Oedth0u8+UYmmMZB07iUpEBr5BWiTIb7WiBYA/vaVdZ7AeyMi6l08bfAzBe5mRtNwjw3nKFCscY=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(56012099006)(11063799006)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Q+KVtXfIPYtnX2Qr59MtQNRZEnmqSWltaUWAZcATvLHeLChJwlxdeNywpVMemXBjomfJxx1onYEAD3bOaPijHZW4bN+0zclPJ7vQeZUaYzhxLQSM/Jk93DarcnseaUUK/f3jpKQysg/Cem0e4hUff9gVoCpqCDflOJfwqUBaUfieT+H5eDK2gLeNO2sTTFMT1K/fxEUMZ8eSxlJcmRsQAWsYEBjwppgxXn3v/nySuek9fh7tmgbF3Q40FjI0CozrC3MHYr1DUsv1iIK3LTxBR91ID84jW8zkmVkXU/TMeA5/chHBcgcVMd/V9JcQ/FnRoEqwkcxGFj4IbqoHLeGWSKBz3KNS++iqN94jjqDLwI2DQQnJGZMQHdSQ6unNlKLVKA2FxIzdAzkHXs3U0criZQM670L7KeijYMvbKz6WcmNuCmsKsljniG5csQbzcJQk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:11:14.9046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac8e2e1-5a19-4a0d-1375-08dec32dd526
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[41];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jiri@resnulli.us,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:bp@alien8.de,m:akpm@linux-foundation.org,m:rdunlap@infradead.org,m:tglx@kernel.org,m:pmladek@suse.com,m:peterz@infradead.org,m:dave.hansen@linux.intel.com,m:vbabka@kernel.org,m:brauner@kernel.org,m:tj@kernel.org,m:feng.tang@linux.alibaba.com,m:dapeng1.mi@linux.intel.com,m:kees@kernel.org,m:elver@google.com,m:ebiggers@kernel.org,m:lirongqing@baidu.com,m:paulmck@kernel.org,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21866-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[lwn.net,linuxfoundation.org,resnulli.us,kernel.org,marvell.com,nvidia.com,alien8.de,linux-foundation.org,infradead.org,suse.com,linux.intel.com,linux.alibaba.com,google.com,baidu.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,vger.kernel.org:from_smtp,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42B8D64A856

devl_register() makes the devlink instance visible to userspace. A later
patch also makes registration the point where devlink core may call
eswitch_mode_set() to apply a boot-time default eswitch mode.

Move netdevsim registration after all objects (resources, params, regions,
traps, debugfs etc) are initialized, and after the initial eswitch mode is
set to legacy.

Move devl_unregister() to the beginning of nsim_drv_remove(), before those
devlink objects are torn down. This keeps devlink register/unregister as
the notification barrier and makes the later object teardown paths run
after devlink is no longer registered, so they do not emit their own
netlink DEL notifications.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/netdevsim/dev.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index aed9ad5f1b43..7cf4102b049e 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -1680,13 +1680,9 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
 		goto err_devlink_unlock;
 	}
 
-	err = devl_register(devlink);
-	if (err)
-		goto err_vfc_free;
-
 	err = nsim_dev_resources_register(devlink);
 	if (err)
-		goto err_dl_unregister;
+		goto err_vfc_free;
 
 	err = devl_params_register(devlink, nsim_devlink_params,
 				   ARRAY_SIZE(nsim_devlink_params));
@@ -1733,9 +1729,14 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
 		goto err_hwstats_exit;
 
 	nsim_dev->esw_mode = DEVLINK_ESWITCH_MODE_LEGACY;
+	err = devl_register(devlink);
+	if (err)
+		goto err_port_del_all;
 	devl_unlock(devlink);
 	return 0;
 
+err_port_del_all:
+	nsim_dev_port_del_all(nsim_dev);
 err_hwstats_exit:
 	nsim_dev_hwstats_exit(nsim_dev);
 err_psample_exit:
@@ -1757,8 +1758,6 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
 			       ARRAY_SIZE(nsim_devlink_params));
 err_resource_unregister:
 	devl_resources_unregister(devlink);
-err_dl_unregister:
-	devl_unregister(devlink);
 err_vfc_free:
 	kfree(nsim_dev->vfconfigs);
 err_devlink_unlock:
@@ -1797,6 +1796,7 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
 	struct devlink *devlink = priv_to_devlink(nsim_dev);
 
 	devl_lock(devlink);
+	devl_unregister(devlink);
 	nsim_dev_reload_destroy(nsim_dev);
 
 	nsim_bpf_dev_exit(nsim_dev);
@@ -1804,7 +1804,6 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
 	devl_params_unregister(devlink, nsim_devlink_params,
 			       ARRAY_SIZE(nsim_devlink_params));
 	devl_resources_unregister(devlink);
-	devl_unregister(devlink);
 	kfree(nsim_dev->vfconfigs);
 	kfree(nsim_dev->fa_cookie);
 	mutex_destroy(&nsim_dev->progs_list_lock);
-- 
2.34.1


