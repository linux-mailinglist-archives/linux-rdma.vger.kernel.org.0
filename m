Return-Path: <linux-rdma+bounces-16141-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMqeNXTzeWnT1AEAu9opvQ
	(envelope-from <linux-rdma+bounces-16141-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:31:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC535A072A
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3921B301A60C
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 11:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BBF350D77;
	Wed, 28 Jan 2026 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s2uvsoHS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011067.outbound.protection.outlook.com [40.93.194.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258B734DCF2;
	Wed, 28 Jan 2026 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599707; cv=fail; b=tN3BHHvI0FZZug4YMg4kRJ9ruzcEOFcF2NAL4xnRB9vAdrYLK2JmjfPvhW+/iBMV58Og+uDp0hazv3eFONwq0LyD3rBCFJ6A2ncTUQ278Zgsl/gvsb40DG3E9mTxxASbg9U/VnDx4xQmYi/8JA3scrVtWkRBpQXpMokEfe9CQCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599707; c=relaxed/simple;
	bh=+TsFKrnKKV1p2dgtjA47WCAuMN4brrlr8HzPmFibMXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6MPhN3tuLgpichRRtHW1CA3pYLc2hBM0chVS2j8CH8N6nu39lRrUfwWd7worFtCogUkD84YKAOgRvshidCbYhHcWIqZ9yPSFMISlaJ+fnqclLjBet99LWckJwCWvH4gGPFobpO6oL7e4E95EsBBjy/NqWnk1inwEfGHovxBz+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s2uvsoHS; arc=fail smtp.client-ip=40.93.194.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/EIhUA9c333VbCpAiMvuLAgIppby9rXAR2gV9QOIjy8Ss8AXevw60gPqfpC6/OKqAlzxRvIqRjn3DfJo8CVNhyrb3MFKUEWw5mEKDVdGYJ0g4p1HrT2GOW61JjTNYdxWXVWKL07fD9p7eoKNR9I+rvZew3zlgvxN6G76hYwEYE/81uTFJyyCxiZhdvNeFj4iy7RkJ51GkqVu7IBSDXXpy9ltJ2XB9yTdPDpNmHBNBlNvTb9e75K4kaWXvepjWNlqma4hsvI4un+4Fu5EYImBMbsrdv7OyFxjmCvTSUY0cnGZQ0yWlGbO5klI2ytEmiGkgEcqlv0v3jY2si8ppMjFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7b15WwGvDn/phApRK4B0qKnSLSXcoTi+A220DrHSE44=;
 b=emBLhU5qu4ezVEYjxyBZANdQhIoRcr2hP9UXzgeOuS5nrpCzuCv43ToryyAGPEs7YpxAD3B612b775YksuZUVnw5nn60+bbxGWZAZmRR1v2DJit7LuKLIRkfoI9RI3TFjIy9OCByxavMJptvfLv3b/vngezsEgPYqzEsV79f8/po19/wVGe4dBMvs00/sG3w2Wgk0JOFumMuDyX+w0bhAuLqwyvC/UuZnkOwRgDwua4B1HIHC0qClEZaNNq5AJ0zYMiRm/M6AJWS6fxYGk7DkpNGzDq6PimsGrnSwL4x0SFQuLjRKaqSm7xHjJFOCRDM8XFlx/qVux2P/cD2DdzkKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b15WwGvDn/phApRK4B0qKnSLSXcoTi+A220DrHSE44=;
 b=s2uvsoHSOCFN9C06Gyay04a37ljDJbkpTUHmGayfAaNikdt3LSVUUqx3glyIbm1C0KruSSx4LS9xkx1xaiOD2hwOw8HCIngTLXLHHnDD59SCxN4Ihlu/jkoy6N5R0LuJt0swvvEG43aLS8edvctekg05Z6VHHJNUyqufgZ6ipyAvwpjqVPefm7rEXyBMUdgyx20POuqoxWl3rNfxKp8hF5SX24rKzaPo/MRDcyngtwT0PKNFn9vjd6fqxjziSfn2B1gH+v6AEBi+n+IIPqpq1ySl6y6vtpHDFqfr9O2dSDJDs+nnnsqLVL9jZYVZEt/Wvrv16Yrzb7uCwhnoHauDSA==
Received: from BN1PR10CA0005.namprd10.prod.outlook.com (2603:10b6:408:e0::10)
 by PH7PR12MB8123.namprd12.prod.outlook.com (2603:10b6:510:2bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 11:28:17 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:e0:cafe::8e) by BN1PR10CA0005.outlook.office365.com
 (2603:10b6:408:e0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 11:28:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 11:28:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:28:06 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:28:05 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 28
 Jan 2026 03:28:00 -0800
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
Subject: [PATCH net-next V7 07/14] devlink: Add parent dev to devlink API
Date: Wed, 28 Jan 2026 13:25:37 +0200
Message-ID: <20260128112544.1661250-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260128112544.1661250-1-tariqt@nvidia.com>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|PH7PR12MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 2accfab3-f5ad-420f-4c80-08de5e605566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OILIFHJAd/kFIQEatw/JcVA9znxTnhIjVdSX/e03zzi6+bgK+rGF73cG1kzb?=
 =?us-ascii?Q?OeqsdHzLPX9irzEFy2YntIiscbAep8+s04AWLRsg39AsHCAHdDC/pE8+nzQF?=
 =?us-ascii?Q?iZlnN1+8/3vYI+P/sRXeV4eWQjrFX4yXM4rQ3hwa71ouKiZPmyiMbyL1FpkQ?=
 =?us-ascii?Q?IygGs32+8RenaUVSsbWhnVoN25P0v9OVybzPrDVn/bb+gl8XOlTprblnFcOR?=
 =?us-ascii?Q?YbAZ6WrdlLSjWN4Au8ytGQM24KAjrE15SpKrWHtyAXMKEFf1ueK39HjtOsHH?=
 =?us-ascii?Q?5hBqRcYjtgYU2tQ+J4VPgP5mPMuzj4067kSbPFhxtZHbmcBZWvQe/krW2C68?=
 =?us-ascii?Q?A4xhhbCjp3MKssAShwshtH773qYGpNU1Axa++LN/jZS7jwTSwlltI5u5hwi6?=
 =?us-ascii?Q?fNLaO6Me4aF/4ziT8Qy+dElYHTEga7PSCnqHDJF/cvAo9uasrp26oo5fdYel?=
 =?us-ascii?Q?4l9a+b3Ni7fHh+QRw6jeel+Jq6iccT7dDwlEsMyH39pzeQpY1HuIofogDRpo?=
 =?us-ascii?Q?0Tr2HvdbB0COs0kXLJXgPw+cn2pgy9jtAp5IGONPYYSVHir+U/88/tyAonaq?=
 =?us-ascii?Q?CHBpavsYSTNpq2lLLW49VX8FFbgHwT+HCYh81RAzATR0AjQEPWM/jX/f2OgZ?=
 =?us-ascii?Q?bXug0tLVGGi3O0PdiZn4jYWTFvo9LpsKpc0xS3VvKkx6BbPsXaSDSwqm1GC2?=
 =?us-ascii?Q?batKLkQTkxUDCzJMkud0nVBi5gdL/hucSZcOnKLnwNpqPJBw/RimQisiCsks?=
 =?us-ascii?Q?D/8cGA0Oqd/FWYksXKf3Y96tH3+YGeiNkcN9PictlflNwRaPKhMuyJ+g27nB?=
 =?us-ascii?Q?LI1tz/nNTduLDEf4UIdzepVD2SGOimTgkjsFvJcp6AjnqOvSBrpwVosBe1Lz?=
 =?us-ascii?Q?l2qc23ILjbXiUVClbeAPUJ/2+/VhNdYxm5Ag9awpgO0V1BqatqdLwIZp4ubZ?=
 =?us-ascii?Q?ZHcFfHfNSoDUVBvtWmuiOGlosLFZTiS6X+Ku8x259E7maqzVsPpEIu8KlEPf?=
 =?us-ascii?Q?+ZzkH9RQzOd/q+q6tQzyoPZfqoioXhQ0nr5lHOlZIDqUwOmDbY5FwomGh5cX?=
 =?us-ascii?Q?4KA2Tyb0nGHR4WmnEAjMpPYJlWhNjcm1BpHB/yh3zK0+w8jyKhiECHKvlBQB?=
 =?us-ascii?Q?8B9F5n81YUHNEdh6/T4W9i8ehkJX8028742viZkgz7n0au24OolWXwJ/AZoQ?=
 =?us-ascii?Q?RvM4iLHbFDqurdT9Xv1fW7/fTp5K/qvFAKaW3iPsTLDc9UUNZiPiNfrA04gY?=
 =?us-ascii?Q?wT6mlqs1yA7slOgCYD/TGLDEZOsQFbuUOhP/oLqLobQXwWzkjHcKUPh8ugEf?=
 =?us-ascii?Q?OO7MKDaUKt2ypwWqq5ZY/oS6DD1kR748TgWUQQA6iIJXSlEIFzDaogB5Ou4S?=
 =?us-ascii?Q?TXoFMwhhBCwyhkyfmbJcQIqAieqfo4Qg+LaOMVb4NDDIHCBGN8ut+IbA5JiC?=
 =?us-ascii?Q?qnox8stXmNE345zVJEAgoL1wv21i2HTR9lLdZlI2C/rONPIeldcwtu60bahC?=
 =?us-ascii?Q?xpiJonbOFxm3pLiKNUh5TVUirD3Rvwz+FqBX9MzOE3OxG8ln2nHlHAbOoee/?=
 =?us-ascii?Q?HwWOqgu0Ii6n4CBFj7vfotT7u+42zFc7yJWEWBzPFYTkvP57HB681DRY5cps?=
 =?us-ascii?Q?nWAnci/nzcEMPeS7IrqyA3oK5mLK+HEo7XvOfFyOnV3Xr/TtinUpQvOpUDlu?=
 =?us-ascii?Q?EPcMkA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:28:17.4033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2accfab3-f5ad-420f-4c80-08de5e605566
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8123
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16141-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: AC535A072A
X-Rspamd-Action: no action

From: Cosmin Ratiu <cratiu@nvidia.com>

Upcoming changes to the rate commands need the parent devlink specified.
This change adds a nested 'parent-dev' attribute to the API and helpers
to obtain and put a reference to the parent devlink instance in
info->user_ptr[1].

To avoid deadlocks, the parent devlink is unlocked before obtaining the
main devlink instance that is the target of the request.
A reference to the parent is kept until the end of the request to avoid
it suddenly disappearing.

This means that this reference is of limited use without additional
protection.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 12 ++++++
 include/uapi/linux/devlink.h             |  2 +
 net/devlink/devl_internal.h              |  2 +
 net/devlink/netlink.c                    | 51 +++++++++++++++++++++---
 4 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 837112da6738..a8fd0a815c0d 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -867,6 +867,10 @@ attribute-sets:
         type: flag
         doc: Request restoring parameter to its default value.
         value: 183
+
+      - name: parent-dev
+        type: nest
+        nested-attributes: dl-parent-dev
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -1289,6 +1293,14 @@ attribute-sets:
              Specifies the bandwidth share assigned to the Traffic Class.
              The bandwidth for the traffic class is determined
              in proportion to the sum of the shares of all configured classes.
+  -
+    name: dl-parent-dev
+    subset-of: devlink
+    attributes:
+      -
+        name: bus-name
+      -
+        name: dev-name
 
 operations:
   enum-model: directional
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index e7d6b6d13470..94b8a4437bac 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -642,6 +642,8 @@ enum devlink_attr {
 	DEVLINK_ATTR_PARAM_VALUE_DEFAULT,	/* dynamic */
 	DEVLINK_ATTR_PARAM_RESET_DEFAULT,	/* flag */
 
+	DEVLINK_ATTR_PARENT_DEV,		/* nested */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 8374c9cab6ce..3ca4cc8517cd 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -162,6 +162,8 @@ typedef int devlink_nl_dump_one_func_t(struct sk_buff *msg,
 struct devlink *
 devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 			    bool dev_lock);
+struct devlink *
+devlink_get_parent_from_attrs_lock(struct net *net, struct nlattr **attrs);
 
 int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
 		      devlink_nl_dump_one_func_t *dump_one);
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 593605c1b1ef..72897b19c372 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -12,6 +12,7 @@
 #define DEVLINK_NL_FLAG_NEED_PORT		BIT(0)
 #define DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT	BIT(1)
 #define DEVLINK_NL_FLAG_NEED_DEV_LOCK		BIT(2)
+#define DEVLINK_NL_FLAG_OPTIONAL_PARENT_DEV	BIT(3)
 
 static const struct genl_multicast_group devlink_nl_mcgrps[] = {
 	[DEVLINK_MCGRP_CONFIG] = { .name = DEVLINK_GENL_MCGRP_CONFIG_NAME },
@@ -206,19 +207,51 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	return ERR_PTR(-ENODEV);
 }
 
+struct devlink *
+devlink_get_parent_from_attrs_lock(struct net *net, struct nlattr **attrs)
+{
+	struct nlattr *tb[DEVLINK_ATTR_DEV_NAME + 1];
+	int err;
+
+	if (!attrs[DEVLINK_ATTR_PARENT_DEV])
+		return ERR_PTR(-EINVAL);
+
+	err = nla_parse_nested(tb, DEVLINK_ATTR_DEV_NAME,
+			       attrs[DEVLINK_ATTR_PARENT_DEV],
+			       NULL, NULL);
+	if (err)
+		return ERR_PTR(err);
+
+	return devlink_get_from_attrs_lock(net, tb, false);
+}
+
 static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
 				 u8 flags)
 {
+	bool parent_dev = flags & DEVLINK_NL_FLAG_OPTIONAL_PARENT_DEV;
 	bool dev_lock = flags & DEVLINK_NL_FLAG_NEED_DEV_LOCK;
+	struct devlink *devlink, *parent_devlink = NULL;
+	struct net *net = genl_info_net(info);
+	struct nlattr **attrs = info->attrs;
 	struct devlink_port *devlink_port;
-	struct devlink *devlink;
 	int err;
 
-	devlink = devlink_get_from_attrs_lock(genl_info_net(info), info->attrs,
-					      dev_lock);
-	if (IS_ERR(devlink))
-		return PTR_ERR(devlink);
+	if (parent_dev && attrs[DEVLINK_ATTR_PARENT_DEV]) {
+		parent_devlink = devlink_get_parent_from_attrs_lock(net, attrs);
+		if (IS_ERR(parent_devlink))
+			return PTR_ERR(parent_devlink);
+		info->user_ptr[1] = parent_devlink;
+		/* Drop the parent devlink lock but don't release the reference.
+		 * This will keep it alive until the end of the request.
+		 */
+		devl_unlock(parent_devlink);
+	}
 
+	devlink = devlink_get_from_attrs_lock(net, attrs, dev_lock);
+	if (IS_ERR(devlink)) {
+		err = PTR_ERR(devlink);
+		goto parent_put;
+	}
 	info->user_ptr[0] = devlink;
 	if (flags & DEVLINK_NL_FLAG_NEED_PORT) {
 		devlink_port = devlink_port_get_from_info(devlink, info);
@@ -237,6 +270,9 @@ static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
 unlock:
 	devl_dev_unlock(devlink, dev_lock);
 	devlink_put(devlink);
+parent_put:
+	if (parent_dev && parent_devlink)
+		devlink_put(parent_devlink);
 	return err;
 }
 
@@ -274,6 +310,11 @@ static void __devlink_nl_post_doit(struct sk_buff *skb, struct genl_info *info,
 	devlink = info->user_ptr[0];
 	devl_dev_unlock(devlink, dev_lock);
 	devlink_put(devlink);
+	if ((flags & DEVLINK_NL_FLAG_OPTIONAL_PARENT_DEV) &&
+	    info->user_ptr[1]) {
+		devlink = info->user_ptr[1];
+		devlink_put(devlink);
+	}
 }
 
 void devlink_nl_post_doit(const struct genl_split_ops *ops,
-- 
2.44.0


