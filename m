Return-Path: <linux-rdma+bounces-18915-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LZSD9BpzWlmdQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18915-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:54:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D90F337F73E
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80B36305BB9C
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 18:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C7247DD4B;
	Wed,  1 Apr 2026 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KCeHyprm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AAF47D932;
	Wed,  1 Apr 2026 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069502; cv=fail; b=TzgUbmsbwhGaOzYk4PT/gKyZuDHTty2DiC8KlB9suG8SrDXYjye8xfbK7bkjnbj8/sVaFTdamg4qP0OSgYs3lJtPB0xxNFKBXgsspBt0q0OPe987NLE6jWy62QX8B84L8+rLN5D5Ym2mFnfgRzQkEps2ay+EVu45xAtlOOYvx04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069502; c=relaxed/simple;
	bh=WsVfRnsevZyeTX/B+eZW+LkTKCQspGR8OwM+N/Tkggc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qepbjGpcup4InPgk5UGuU/Tzv6KFM35I7Ik+3Bo7OsKXnWc38b1kGJ3fa2Lpf+M4VBCJ+b7O8DixX12HQulNaTqeT2Fw3pOAFjnZJSw+Ufm+zluup+l6Zrq/cFNJyV+JyhBuFQ08EwMPmgcbLjCzI2FjTbrpPBcen584EXukfe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KCeHyprm; arc=fail smtp.client-ip=40.107.209.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUnRiQ2cWGIQp0hxCQSkqGhYfkys7CdW3OnnMZJMFi8gXkfyTeNVaLxEAo8aFviN8+S3m3b5Yv67cBcIHr4mhSUTuEYlW7iEw6oaQmiR5v/Sl8S20qTjgHdxlHY2xPjjED5NJE86hFSxiL+xlojDM3M4dwgEqr8XeXgLbZk7L2filFQkmx1STs71ERv24eQmFt6ngq6aEINYC/7Q5hShwAxcxd7PNK4WZ0Ag2fse+2jQNRyY1ZLpFXkcv9rTztYsnLBWusfclQzidqac+SrleqnaKp0Ri8X4bhvosT97799fPMlKChwCE9CuLMLRBYBaZplZQnJ9IuhU/rhT7tjQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCWZgKj4j+y2nm+qJu4BtYoh+ItqKFfUow5gcRMo5Qc=;
 b=VLRz7VRz7VisFRLfVo1+o67/Ibqhi4lvU/SQp37mTRoXGgXZz+W67Hjg12R527+3nf/m5pYf6h7sDSeS0jqcprDL7tS8bTLgk4PQ5mG4//u6vEdDWrWAAepRrg+uxAHNaeXaDnE9o2rfTuvEQ+RkEDKhZqVI9GTlSinwA7qHolfL5ubUCOhV44v6AvT7VW+p+rnfZW5jeQfI596uzJn1WhU1qlB+/tGD9AVXTX9gvU9lO+q8WwTG6cZ93Tse2xTon2UHj2tG+AAqXIyCUH6cV49dPM+3RPTA579OBTZvt64XZdY1PKEuRVYv4msRbOHmUAzYIm8fuqblhUNjT1wWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCWZgKj4j+y2nm+qJu4BtYoh+ItqKFfUow5gcRMo5Qc=;
 b=KCeHyprmUNc+lZsAdH+f72v4fw+minAq3cbMXwSdbIj1NuzV/cpIXGUZu1SM8dki6gJPcRlIDGLZvJZLZrihqOW5jEZJK0A6mo3JiwJiPVp1bI+KZ67VYag6yXug5SZlypFcKIOmCa6PFSfvQc+sQnZ7mm93Do2xhoBBSmcyUNk9y5EpYgqHq0fR00v8spgk3nVWTeYFOd9XX1rL6v7S3uuEv9tpImtXFrQiw5QESz19sZZH6J2oO8uB8hQS45531eEJ+UACVjLH06tqwLLOs/b1xVapYgb5TAnpK/dp6QUFa2RbLTHrkJFjWIJ5lgCtpEwGKYg1dNwZQ1CUemH6Zw==
Received: from SJ0PR05CA0013.namprd05.prod.outlook.com (2603:10b6:a03:33b::18)
 by DM4PR12MB7576.namprd12.prod.outlook.com (2603:10b6:8:10c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 18:51:27 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::66) by SJ0PR05CA0013.outlook.office365.com
 (2603:10b6:a03:33b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.15 via Frontend Transport; Wed,
 1 Apr 2026 18:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 18:51:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:51:06 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:51:06 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Apr
 2026 11:50:57 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Carolina Jubran <cjubran@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, Shay Drori <shayd@nvidia.com>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, Kees Cook <kees@kernel.org>, "Daniel
 Jurgens" <danielj@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V4 05/12] devlink: Add dump support for device-level resources
Date: Wed, 1 Apr 2026 21:49:40 +0300
Message-ID: <20260401184947.135205-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260401184947.135205-1-tariqt@nvidia.com>
References: <20260401184947.135205-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|DM4PR12MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5f8892-788d-4d0c-26fa-08de901fae52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	S0+8wKbH2PotjuSvdSDDszU9hVWebC89ctwsLuxrHGGJdqqcBECtViTbV/x1SOiqPdtVO+ATAtKUGgl2nO+CY51VYz7GzsKFoJL/UypBoWM6kq/hccAr7eBKOsMyTtqn4992AcbCJ8l9XoSraM7dI9FZPt4PIjtM5X9TjXVN0EPwIcNBC5H7FRhhRQPyWzBUBQRyjTnpknHUJNsk+Aa+ZtN8gdx0ZQG8ALJU1UBh8WmmDzO2cczf3wWAOHW8DcgigI/TksyEG/3LYuCouwEXLCOK9HlA38CTISvJ/ugvSLcDWR+Jcqb+t0j1dQ6GzWOLpxcQH8Vw40uPzwT/QROF1O1bK+rO2+Co/7GM9ipV9aSe+WWRAVG73XVWG0Gwph92mGE/ye6xxkYckwhrONJEW5FuQPIq70GB9KdVqAYXn/Ihb4z/wJwJo6INqYwQFVqcinQ1esz7xJrbkbIFfxr7htNMQ2Q99Ng5o6rClZdqEMLbY8v0f1YvxY4780Cq9U0MQk6j1YVZ2Q2+iBl+y1OcPaJFSfBbX8CSFXBM9E1aXjjCCvN0hpMdnmcQgHdbu/Rtd5+DIUbxv98uapDDXyH8Q+ZwCZM1XvSCWaWAks9ydetI5qhLFJ5sDGAPf9TumZso5Pd1Oht0F0JeK9CoDdI0eS4VpdqwIRXTtkbrMPbsI0jDB+QyxRyLDeg4kmlHyyhDcZubEg6Yu3L5NvesclnSjDTBWjqKYyjZtZlu5UAcoBLodhHqooVnoTlVXsz1vpknEroVT0hWyqfSmRSvrooW2g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mX36ouBQvqWNu6d6EA87g9rXH+ktYxqh6LN+OUaQNoD+erMsYXTJSCPBnfU8ePDxpGus14mOt5gzKakusLtwUDF7jZyX+F9oAIHni5/pMw8poMTjHUZVzeJuET7b7ZqEaYJwgjlQP+10bLzlLxlJ588nVPX62SwYnxf/nIr5b1RpS6to9jo6ltlbmXJJwcvqDXtJLPD4iEpZUlvMbsL+RGNIAZlTkWHgslGVEezMWsdfWg5H1TNRZxQKf3wePuomyaz9IYenYeVeqG8s7nD7RMOIUXvHYkU8m0cpMmv+GvfKly02bNZmr+5LcRz74NK0mjeEWdsr5RuBpzEo59PevDkNg0+pCbwsEY7usu7ZVujJvzmuYoTet7Y5MOBw5/OJKnK4FYepqZdUUfcidNlVhGBFDk5TmiUwcRcfXjN1bt/ugdGa9QNg/aTwIN+AwOv7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 18:51:27.4886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5f8892-788d-4d0c-26fa-08de901fae52
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7576
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18915-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D90F337F73E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Or Har-Toov <ohartoov@nvidia.com>

Add dumpit handler for resource-dump command to iterate over all devlink
devices and show their resources.

  $ devlink resource show
  pci/0000:08:00.0:
    name local_max_SFs size 508 unit entry
    name external_max_SFs size 508 unit entry
  pci/0000:08:00.1:
    name local_max_SFs size 508 unit entry
    name external_max_SFs size 508 unit entry

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml |  6 +-
 net/devlink/netlink_gen.c                | 20 +++++-
 net/devlink/netlink_gen.h                |  4 +-
 net/devlink/resource.c                   | 77 ++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index b495d56b9137..c423e049c7bd 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1764,13 +1764,17 @@ operations:
             - bus-name
             - dev-name
             - index
-        reply:
+        reply: &resource-dump-reply
           value: 36
           attributes:
             - bus-name
             - dev-name
             - index
             - resource-list
+      dump:
+        request:
+          attributes: *dev-id-attrs
+        reply: *resource-dump-reply
 
     -
       name: reload
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index eb35e80e01d1..a5a47a4c6de8 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -305,7 +305,14 @@ static const struct nla_policy devlink_resource_set_nl_policy[DEVLINK_ATTR_INDEX
 };
 
 /* DEVLINK_CMD_RESOURCE_DUMP - do */
-static const struct nla_policy devlink_resource_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
+static const struct nla_policy devlink_resource_dump_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
+};
+
+/* DEVLINK_CMD_RESOURCE_DUMP - dump */
+static const struct nla_policy devlink_resource_dump_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
@@ -680,7 +687,7 @@ static const struct nla_policy devlink_notify_filter_set_nl_policy[DEVLINK_ATTR_
 };
 
 /* Ops table for devlink */
-const struct genl_split_ops devlink_nl_ops[74] = {
+const struct genl_split_ops devlink_nl_ops[75] = {
 	{
 		.cmd		= DEVLINK_CMD_GET,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
@@ -958,10 +965,17 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.pre_doit	= devlink_nl_pre_doit,
 		.doit		= devlink_nl_resource_dump_doit,
 		.post_doit	= devlink_nl_post_doit,
-		.policy		= devlink_resource_dump_nl_policy,
+		.policy		= devlink_resource_dump_do_nl_policy,
 		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= DEVLINK_CMD_RESOURCE_DUMP,
+		.dumpit		= devlink_nl_resource_dump_dumpit,
+		.policy		= devlink_resource_dump_dump_nl_policy,
+		.maxattr	= DEVLINK_ATTR_INDEX,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
 	{
 		.cmd		= DEVLINK_CMD_RELOAD,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 2817d53a0eba..d79f6a0888f6 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -18,7 +18,7 @@ extern const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_RATE_TC_
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
 
 /* Ops table for devlink */
-extern const struct genl_split_ops devlink_nl_ops[74];
+extern const struct genl_split_ops devlink_nl_ops[75];
 
 int devlink_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 			struct genl_info *info);
@@ -80,6 +80,8 @@ int devlink_nl_dpipe_table_counters_set_doit(struct sk_buff *skb,
 					     struct genl_info *info);
 int devlink_nl_resource_set_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_resource_dump_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_resource_dump_dumpit(struct sk_buff *skb,
+				    struct netlink_callback *cb);
 int devlink_nl_reload_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_param_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_param_get_dumpit(struct sk_buff *skb,
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index f3014ec425c4..02fb36e25c52 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -223,6 +223,31 @@ static int devlink_resource_put(struct devlink *devlink, struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
+static int devlink_resource_list_fill(struct sk_buff *skb,
+				      struct devlink *devlink,
+				      struct list_head *resource_list_head,
+				      int *idx)
+{
+	struct devlink_resource *resource;
+	int i = 0;
+	int err;
+
+	list_for_each_entry(resource, resource_list_head, list) {
+		if (i < *idx) {
+			i++;
+			continue;
+		}
+		err = devlink_resource_put(devlink, skb, resource);
+		if (err) {
+			*idx = i;
+			return err;
+		}
+		i++;
+	}
+	*idx = 0;
+	return 0;
+}
+
 static int devlink_resource_fill(struct genl_info *info,
 				 enum devlink_command cmd, int flags)
 {
@@ -302,6 +327,58 @@ int devlink_nl_resource_dump_doit(struct sk_buff *skb, struct genl_info *info)
 	return devlink_resource_fill(info, DEVLINK_CMD_RESOURCE_DUMP, 0);
 }
 
+static int
+devlink_nl_resource_dump_one(struct sk_buff *skb, struct devlink *devlink,
+			     struct netlink_callback *cb, int flags)
+{
+	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	struct nlattr *resources_attr;
+	int start_idx = state->idx;
+	void *hdr;
+	int err;
+
+	if (list_empty(&devlink->resource_list))
+		return 0;
+
+	err = -EMSGSIZE;
+	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			  &devlink_nl_family, flags, DEVLINK_CMD_RESOURCE_DUMP);
+	if (!hdr)
+		return err;
+
+	if (devlink_nl_put_handle(skb, devlink))
+		goto nla_put_failure;
+
+	resources_attr = nla_nest_start_noflag(skb, DEVLINK_ATTR_RESOURCE_LIST);
+	if (!resources_attr)
+		goto nla_put_failure;
+
+	err = devlink_resource_list_fill(skb, devlink,
+					 &devlink->resource_list, &state->idx);
+	if (err) {
+		if (state->idx == start_idx)
+			goto resource_list_cancel;
+		nla_nest_end(skb, resources_attr);
+		genlmsg_end(skb, hdr);
+		return err;
+	}
+	nla_nest_end(skb, resources_attr);
+	genlmsg_end(skb, hdr);
+	return 0;
+
+resource_list_cancel:
+	nla_nest_cancel(skb, resources_attr);
+nla_put_failure:
+	genlmsg_cancel(skb, hdr);
+	return err;
+}
+
+int devlink_nl_resource_dump_dumpit(struct sk_buff *skb,
+				    struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb, devlink_nl_resource_dump_one);
+}
+
 int devlink_resources_validate(struct devlink *devlink,
 			       struct devlink_resource *resource,
 			       struct genl_info *info)
-- 
2.44.0


