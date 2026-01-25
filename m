Return-Path: <linux-rdma+bounces-15967-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCy3Orf/dWmMKQEAu9opvQ
	(envelope-from <linux-rdma+bounces-15967-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:34:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A08A8804A6
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5ACB53018C36
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 11:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7AF31AF3B;
	Sun, 25 Jan 2026 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XYDt7TD0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010024.outbound.protection.outlook.com [52.101.193.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2351931AA95;
	Sun, 25 Jan 2026 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769340789; cv=fail; b=M7e+kWgzt6lg9qaJaD+UwKdw/XKKGRoZt9Np/TQ48NPwzFeedmXola40RFn5NudySQpBgLxyZWts5YiAxXYPl/8mwYcEiA7JKsSoa2r88aFjPYYMEqKMfNND0pLaVqN7y35tHCeOapeLVgyMQxy0PCm4bhTKVLBNdi4yH6xehBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769340789; c=relaxed/simple;
	bh=iZeDczdyUO7oQJ6Zo+ZPH0FgWnEPsmbPRePrgVG/ePM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KAqkbnB3jSxq219ByhVjxHojWcR3la3AqhYG3JXuXruLa4kkH7LRD0S8okq6IgJ/7hnH1ZaY5YtzKNB1uCzwt1MPW8a6Ded8g9DR7gugNOA4zyKPdKKnW+aWAejx8qmb+yVJhkibmRN/c5dA4mZ8aM2WcJfGltdj9uff8kwKyho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XYDt7TD0; arc=fail smtp.client-ip=52.101.193.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t860gTGO9e4MA8tmt7OfreGAN7zM2ksBw3kFgxdS19Os9KhLT5w/FoVmAlEstrqCjclLkmgv86m9B+9S8p3scD20QXj09xxB3nk/1DWTg/n+l1NNDG9uzL2slcFMM0awxsmbEVnErF/h/tzgy+2BVA0nRanvst3fmra3G7dQOMT3ASoqe8Ts/ZkzdzN5PWq/ETGUh700CHCgT3Zgt9tURckAHaKpROhNySYu4bE98OxD4z4OuQ7IPsRcWXv+jP5MhtD14vei75IM1TR+dWUfj0OwoyXBgyFPj+ZR3ytvXhcPEPvJo+ZW7FfCIHizh4H6uhnsOVAzbnNRLAh7NR0Pwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7Pzm+/eKAHh85ubvJWRLdTeEyah8pjAtKgsXLl5uoU=;
 b=UfBkIpPY5Nl+zF9BEKeLhvZWBM6jML4FyFn1xwk7h4FEojy29EMpDHMvZsZJ0gNq4fHMAj4jANZLdWKm5k7FW7RJrPF8jcNnO0tiKveDd6rz0vSlvIxpBAS5+g2y9InBx0Gjuf8dN/5bBOyxyMzbKNLrc1/zSonCmu1Z09Le5CbPghCOEPmqsiH375Ag8i8NImZ/5SwziobmYKpD0odY4BuIHQxtt08T0OCDzwshPKRp0WCiqMe4x2o9ddr8jlfuJKD7XcGUpynQIzAsi8M+QM/y9qO3olnmFBKm2ShT29HAGiSrG7Xa/Nspj/VYaoBJk6TKcTz+WPzsIrjtB6Y71g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7Pzm+/eKAHh85ubvJWRLdTeEyah8pjAtKgsXLl5uoU=;
 b=XYDt7TD0Pws1LJwpNwSEcZ3cYYh81UyOZQ87R4KCaO79eodgid1D20bfq6Az/I/cqXpxvRLg0/CVEXeawfTvZZ3/lYS+SvXCgvGRzco6UT0XvkRdSHNwrzmSUNUSwLgfnNEmSPP722YwE4hsSJVxVVSDs+tunJxeYvBvUO1yK/0xZOx8gPuaHhahc1pWP7/u00QixN5Ma6XYBnkQnqzhdHPiWRIFGHRno4t3/oEmRnrvLHRJCENaxnlGtdAH5GfXdgGLQiOA7ulDothwAqAlv3P5aHUh+uL8OIorT48O+fN6rsNYrsuYUQ3P+YIrSHcQbegXXIcPTaLxEW2u8RR4Kg==
Received: from SA9PR13CA0096.namprd13.prod.outlook.com (2603:10b6:806:24::11)
 by IA1PR12MB8224.namprd12.prod.outlook.com (2603:10b6:208:3f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sun, 25 Jan
 2026 11:33:03 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::72) by SA9PR13CA0096.outlook.office365.com
 (2603:10b6:806:24::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.6 via Frontend Transport; Sun,
 25 Jan 2026 11:32:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Sun, 25 Jan 2026 11:33:03 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:32:56 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:32:55 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 25
 Jan 2026 03:32:50 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
	<rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, Krzysztof Kozlowski
	<krzk@kernel.org>
Subject: [PATCH net-next V6 02/14] devlink: introduce shared devlink instance for PFs on same chip
Date: Sun, 25 Jan 2026 13:31:51 +0200
Message-ID: <1769340723-14199-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1769340723-14199-1-git-send-email-tariqt@nvidia.com>
References: <1769340723-14199-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|IA1PR12MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: d55b5c50-02a0-4413-29f2-08de5c05808d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|30052699003|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jGN3TuH/oXbFglgIPCWode1n2kcOUYxxoaRcWg8KSWhAb91/Q6eMhGi6vT+9?=
 =?us-ascii?Q?JpnQjRKWP6jZ3fGzff+Gd05Z3VUcopjm52TJWQfiYZ3ZCXBHR4XhE2/uVMIC?=
 =?us-ascii?Q?Y6XBOXTSHFuZ8xxJmEtng77WxbUOpKZoLVNczeXNKyJyEsbvH3RB6SLY3Ezx?=
 =?us-ascii?Q?h54llDCfxGyt3bQyISFiYnwCWYYswyoRH71i9Sj0TY7wPPEvwKsr3toldKnB?=
 =?us-ascii?Q?rtU1kX6j75RJrA1FnP6qDa2/W0BXQE3kqd3G2P1X2nMiD+0I0dJqFjbKcKr4?=
 =?us-ascii?Q?EIX9ZMudW2mAmTx4fLJ+ihgVE8AZrhG13c3je6DSFFkGwfEk1JSIh7SLj82x?=
 =?us-ascii?Q?leaP0o4BFCICpKa4SzvOOFzUGb2ZLRmFopE/kNHeiNFQNbFSGZxCQu17AtQ5?=
 =?us-ascii?Q?zwac/dguLY+FESeqRSghsafHJVrSyG5GF+7gUOMTR2b1yPbe2GLu+Prpgrep?=
 =?us-ascii?Q?tskZb7A5IXrAlpNdrHOwnQhBufvKFXuUZOmN7x6q93UAo2YlkRFg9MMXcisn?=
 =?us-ascii?Q?ptetkgVIEcd0T5wiC0+B2/AFmrgifX5R8V14uOFc6IwsqxykvUFtgmwgOMFC?=
 =?us-ascii?Q?nYujlm+oMFvZSmJFK8iokGSZ5aIxYc0l5vRWJQQgLQUjfm0XTyjS/4Bm9HaF?=
 =?us-ascii?Q?8x9mQHpEV0hVbHmtzt4+i6GkuvIyeqY4EwejzwjUs//kJvuga1cjZzso+QHR?=
 =?us-ascii?Q?TbB0r/Dq0B+Yra1je+DZj+poCD43NDup1M9pNL2/pfuldlzOR0MBJ1OAnAKd?=
 =?us-ascii?Q?D5J+jvXok7i8gAd44JvbC/k5HDutp7bKz3EJ66g2eWn8gIEYgwj65gma62uy?=
 =?us-ascii?Q?vyweV/r3GfIxc0cGUpf0B+7kn4dL2LvnzJ7fmh6vtnm102xYeeIm5ohw7uUG?=
 =?us-ascii?Q?PE3wXRALeqCfJS7qg5qAuz/J89E+h3A9aMDcfYzfFbDOWZ7j3dfauMuF+IUs?=
 =?us-ascii?Q?VaucRE8FaV0ZpaP2YU7DW6FWyvZgn7WmzBBzdJFloEJgwHcCkoqvJlrdmp5r?=
 =?us-ascii?Q?R+MyHtFiYxdA5VhOtJqv+7Z3AiiTo//9Z+1B4u5Ulalo7UZHG0LiU1jKcZH2?=
 =?us-ascii?Q?QohMK5gLUbFJQHVsa0y6MpUCV/RgxWyEvlLGX7rYNxI8GjKBRLKM+394pj87?=
 =?us-ascii?Q?rGAPOn46mwFOBanBXELvhQJiQ/evMGVwtUYcvZT8SpOjgI84xVVf6HwSXso+?=
 =?us-ascii?Q?fnTlOldGClsMM7HmRg3COZNu719AC4LsSpnps4nEsxJCjTLpjDYxi+wR1hGc?=
 =?us-ascii?Q?mykxAxh6sQ1YOk1WOOWeHz14Cfhzyq3rDxe5eQPvBUrEwZwfVaqj9Rl5G+uc?=
 =?us-ascii?Q?MdajVaghUC0VVnWjS58k87i8eFtReYcl/RkO5jj8wqKIydVbzIoi8IWu7cYd?=
 =?us-ascii?Q?cMcNMHJafgYDSkkPwHNe38po8ZWap32JU4/Mm8D83tseRNdaAE3IIA+oNlXC?=
 =?us-ascii?Q?zQ6Du/PFxZUo9eWv+ilj7JcOlIlZAlYurGW3kkC7PDJ+4ECMNOJb+wxpQyLS?=
 =?us-ascii?Q?Jw43NL1GY6bARVnRkB4u7PYwQv/zy/ehUQoRxIU+C/Ws6VVIaV053u3ElRj9?=
 =?us-ascii?Q?q9EB4W0FqBlFAoJ1GWVTZQYI7B5PB1r6EQGXlpk97/XoSaeSkXvETfNDxeyM?=
 =?us-ascii?Q?5pZ8WNKBWXJ/W7i8ZgaK+UetCSYiDqmH7KbuUb6nQDlAPQe/3/rmtqEdunmE?=
 =?us-ascii?Q?8gr+GA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(30052699003)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 11:33:03.3666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d55b5c50-02a0-4413-29f2-08de5c05808d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8224
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15967-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A08A8804A6
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Multiple PFs may reside on the same physical chip, running a single
firmware. Some of the resources and configurations may be shared among
these PFs. Currently, there is no good object to pin the configuration
knobs on.

Introduce a shared devlink instance, instantiated upon probe of the
first PF and removed during remove of the last PF. The shared devlink
instance is backed by a faux device, as there is no PCI device related
to it. The implementation uses reference counting to manage the
lifecycle: each PF that probes calls devlink_shd_get() to get or create
the shared instance, and calls devlink_shd_put() when it removes. The
shared instance is automatically destroyed when the last PF removes.

Example:

$ devlink dev
pci/0000:08:00.0:
  nested_devlink:
    auxiliary/mlx5_core.eth.0
faux/mlx5_core_83013c12b77faa1a30000c82a1045c91:
  nested_devlink:
    pci/0000:08:00.0
    pci/0000:08:00.1
auxiliary/mlx5_core.eth.0
pci/0000:08:00.1:
  nested_devlink:
    auxiliary/mlx5_core.eth.1
auxiliary/mlx5_core.eth.1

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/net/devlink.h |   6 ++
 net/devlink/Makefile  |   2 +-
 net/devlink/sh_dev.c  | 163 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+), 1 deletion(-)
 create mode 100644 net/devlink/sh_dev.c

diff --git a/include/net/devlink.h b/include/net/devlink.h
index cb839e0435a1..c453faec8ebf 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1644,6 +1644,12 @@ void devlink_register(struct devlink *devlink);
 void devlink_unregister(struct devlink *devlink);
 void devlink_free(struct devlink *devlink);
 
+struct devlink *devlink_shd_get(const char *id,
+				const struct devlink_ops *ops,
+				size_t priv_size);
+void devlink_shd_put(struct devlink *devlink);
+void *devlink_shd_get_priv(struct devlink *devlink);
+
 /**
  * struct devlink_port_ops - Port operations
  * @port_split: Callback used to split the port into multiple ones.
diff --git a/net/devlink/Makefile b/net/devlink/Makefile
index 000da622116a..8f2adb5e5836 100644
--- a/net/devlink/Makefile
+++ b/net/devlink/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y := core.o netlink.o netlink_gen.o dev.o port.o sb.o dpipe.o \
-	 resource.o param.o region.o health.o trap.o rate.o linecard.o
+	 resource.o param.o region.o health.o trap.o rate.o linecard.o sh_dev.o
diff --git a/net/devlink/sh_dev.c b/net/devlink/sh_dev.c
new file mode 100644
index 000000000000..acc8d549aaae
--- /dev/null
+++ b/net/devlink/sh_dev.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <linux/device/faux.h>
+#include <net/devlink.h>
+
+#include "devl_internal.h"
+
+static LIST_HEAD(shd_list);
+static DEFINE_MUTEX(shd_mutex); /* Protects shd_list and shd->list */
+
+/* This structure represents a shared devlink instance,
+ * there is one created per identifier (e.g., serial number).
+ */
+struct devlink_shd {
+	struct list_head list; /* Node in shd list */
+	const char *id; /* Identifier string (e.g., serial number) */
+	struct faux_device *faux_dev; /* Related faux device */
+	refcount_t refcount; /* Reference count */
+	char priv[] __aligned(NETDEV_ALIGN); /* Driver private data */
+};
+
+static struct devlink_shd *devlink_shd_lookup(const char *id)
+{
+	struct devlink_shd *shd;
+
+	list_for_each_entry(shd, &shd_list, list) {
+		if (!strcmp(shd->id, id))
+			return shd;
+	}
+
+	return NULL;
+}
+
+static struct devlink_shd *devlink_shd_create(const char *id,
+					      const struct devlink_ops *ops,
+					      size_t priv_size)
+{
+	struct faux_device *faux_dev;
+	struct devlink_shd *shd;
+	struct devlink *devlink;
+
+	/* Create faux device - probe will be called synchronously */
+	faux_dev = faux_device_create(id, NULL, NULL);
+	if (!faux_dev)
+		return NULL;
+
+	devlink = devlink_alloc(ops, sizeof(struct devlink_shd) + priv_size,
+				&faux_dev->dev);
+	if (!devlink)
+		goto err_devlink_alloc;
+	shd = devlink_priv(devlink);
+
+	shd->id = kstrdup(id, GFP_KERNEL);
+	if (!shd->id)
+		goto err_kstrdup_id;
+	shd->faux_dev = faux_dev;
+	refcount_set(&shd->refcount, 1);
+
+	devl_lock(devlink);
+	devl_register(devlink);
+	devl_unlock(devlink);
+
+	list_add_tail(&shd->list, &shd_list);
+
+	return shd;
+
+err_kstrdup_id:
+	devlink_free(devlink);
+
+err_devlink_alloc:
+	faux_device_destroy(faux_dev);
+	return NULL;
+}
+
+static void devlink_shd_destroy(struct devlink_shd *shd)
+{
+	struct devlink *devlink = priv_to_devlink(shd);
+	struct faux_device *faux_dev = shd->faux_dev;
+
+	list_del(&shd->list);
+	devl_lock(devlink);
+	devl_unregister(devlink);
+	devl_unlock(devlink);
+	kfree(shd->id);
+	devlink_free(devlink);
+	faux_device_destroy(faux_dev);
+}
+
+/**
+ * devlink_shd_get - Get or create a shared devlink instance
+ * @id: Identifier string (e.g., serial number) for the shared instance
+ * @ops: Devlink operations structure
+ * @priv_size: Size of private data structure
+ *
+ * Get an existing shared devlink instance identified by @id, or create
+ * a new one if it doesn't exist. The device is automatically added to
+ * the shared instance's device list. Return the devlink instance
+ * with a reference held. The caller must call devlink_shd_put() when done.
+ *
+ * Return: Pointer to the shared devlink instance on success,
+ *         NULL on failure
+ */
+struct devlink *devlink_shd_get(const char *id,
+				const struct devlink_ops *ops,
+				size_t priv_size)
+{
+	struct devlink_shd *shd;
+
+	if (WARN_ON(!id || !ops))
+		return NULL;
+
+	mutex_lock(&shd_mutex);
+
+	shd = devlink_shd_lookup(id);
+	if (!shd)
+		shd = devlink_shd_create(id, ops, priv_size);
+	else
+		refcount_inc(&shd->refcount);
+
+	mutex_unlock(&shd_mutex);
+	return shd ? priv_to_devlink(shd) : NULL;
+}
+EXPORT_SYMBOL_GPL(devlink_shd_get);
+
+/**
+ * devlink_shd_put - Release a reference on a shared devlink instance
+ * @devlink: Shared devlink instance
+ *
+ * Release a reference on a shared devlink instance obtained via
+ * devlink_shd_get().
+ */
+void devlink_shd_put(struct devlink *devlink)
+{
+	struct devlink_shd *shd;
+
+	if (WARN_ON(!devlink))
+		return;
+
+	mutex_lock(&shd_mutex);
+	shd = devlink_priv(devlink);
+	if (refcount_dec_and_test(&shd->refcount))
+		devlink_shd_destroy(shd);
+	mutex_unlock(&shd_mutex);
+}
+EXPORT_SYMBOL_GPL(devlink_shd_put);
+
+/**
+ * devlink_shd_get_priv - Get private data from shared devlink instance
+ * @devlink: Devlink instance
+ *
+ * Returns a pointer to the driver's private data structure within
+ * the shared devlink instance.
+ *
+ * Return: Pointer to private data
+ */
+void *devlink_shd_get_priv(struct devlink *devlink)
+{
+	struct devlink_shd *shd = devlink_priv(devlink);
+
+	return shd->priv;
+}
+EXPORT_SYMBOL_GPL(devlink_shd_get_priv);
-- 
2.40.1


