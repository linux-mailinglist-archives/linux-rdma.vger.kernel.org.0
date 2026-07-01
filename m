Return-Path: <linux-rdma+bounces-22613-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id udTcEAPDRGra0QoAu9opvQ
	(envelope-from <linux-rdma+bounces-22613-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 09:34:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D34466EAAE7
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 09:34:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Pts97LqI;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22613-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22613-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2D1130160DB
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 07:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D023B7B9D;
	Wed,  1 Jul 2026 07:34:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012049.outbound.protection.outlook.com [40.107.200.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7F93B0AE7;
	Wed,  1 Jul 2026 07:34:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891257; cv=fail; b=PKEe3oagT7EtdZTahgsMOfyGifjsN/x4u3YiXLdO+g0Xo/M4pS+LD6PwEgvU0xklOZmO+xfZR7TEK9jC+1xK9+SpLyDsAzAaGt7dS2Xk18RwKG+/YcYMEvkZJeSQUzJP/PUBYkNyOD0Zti/1aCgGl6d1jPl981oS2Q6FSci4AE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891257; c=relaxed/simple;
	bh=9mv0ltrKjiecIgayt60KGUxf+nD1XnTQsjfSk7ZKaBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fep1+mb53BcqtWhnf/MCwfPcI81hmSGtEdviqUYeORjDy+tBwxPrfn/bXXigA0OX1DbvIg9T2ERS+s540qQx3qPXE2s69fAMIsT9uTQG+EDxuOwWlsEzZhFnOLGGHdx904jKFV9blIbYFuTmQ1ln/0ts+l2/rs/l0hpY00sCKWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pts97LqI; arc=fail smtp.client-ip=40.107.200.49
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pzv7DcSs1gWRWC2lQMrnlv3Co+YP+y6xH2hUOTYz/vGqDWY7DYA9J0j7HeQ8zmvIQueMznAvj7V07CCzdudOoaNLSpE5HLjJE2KRp0a3EVofJNvwEZNrRB/zd2M+x8AoVqS/EabZPWE3Pw4PmEzIr6U5P7qMJ1L9ilKoKy4KmGU1puOXY6rNUV0U7Yzhx0qHHUkFEztpMHjIpjxkcOvBMUtyoyNumgzkrgSGbPVYwvhtN2hcLMI+SUdld12KkO+MK0mZ4jAlXI6kUOB+0rFEWCiIQu8A4YT823o9lhNTPdW1vgS0o4nkFBDUbsce8/7R7qqqaC7EO2imaT0cXV8wSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Th89mV8u9qzJ58FwXTm+/ewdTmIYmgeoyOIeOIsWgO0=;
 b=F8KkZ/eKawCgX1HA2pQXVPJz3qshUy2yF8HoqCUSUXzsTSLU98WKAD911NCKn7O3VTRegYcoFJJbjpmJepXPRrPXQzSLSIMSX6tyYdDpV0s3elNMaUEE61kQ06Tjm/2N/EbTIF5dg0Mr3y2pv7TbDtnvpVN/R+8Ecawhde6Lwr3t9wwqkmTXEj2Fe0Cwyjs/DdF9b0pO6ZVtRYGIJ3V9MTv3UoKyey9TwkuHWltY3xiPhOQqRfkjFm8p8qI/uhbVt49ogBtzgXaA+evGK6LTvW8xHnRCzw5v7Pn0boo0/WE547ZKYzG4RZZpnLcUhNkwj6aKrN2NA751j6LehWJhjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Th89mV8u9qzJ58FwXTm+/ewdTmIYmgeoyOIeOIsWgO0=;
 b=Pts97LqIRnwf99EnUHbKYFhs7bPOt/8M+q/rd/kQYM8VVI2Cf/Q93UJ6oXET0ncCMlYSGVRRiwUJg34vCyQw/yjigIO/7VeGQmSylS+isqUtgMEylzMQXvcpQ1Lc7960E6ggXSi+aJNdHXxrXsCHVJrX9zW4PZV73JV3A282jl+xKZByZxdfzAWFple57c/0FWB5PJKlAaUq9FyS/bRCUK1Wa9qVtuARsfgOhSjh7NpCXpKdCiI9raYQnVhDBEghVrgf64PrDTca2WRUK/bhLaIGytqZoMZq9Aq2OVdJzc4+ErZo6TG0mXPwP9GRDJfJ/c8WZs0nyqBz9apZmobmNQ==
Received: from DM6PR01CA0027.prod.exchangelabs.com (2603:10b6:5:296::32) by
 CY5PR12MB6646.namprd12.prod.outlook.com (2603:10b6:930:41::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.16; Wed, 1 Jul 2026 07:34:07 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::3c) by DM6PR01CA0027.outlook.office365.com
 (2603:10b6:5:296::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 07:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 07:34:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 00:33:43 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 00:33:43 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Jul
 2026 00:33:33 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Adithya Jayachandran <ajayachandra@nvidia.com>, Bobby Eshleman
	<bobbyeshleman@meta.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Daniel Borkmann <daniel@iogearbox.net>, Daniel Jurgens
	<danielj@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, David Wei
	<dw@davidwei.uk>, Donald Hunter <donald.hunter@gmail.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Joe Damato <joe@dama.to>, Jonathan Corbet
	<corbet@lwn.net>, Kees Cook <kees@kernel.org>, Leon Romanovsky
	<leon@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ratheesh Kannoth
	<rkannoth@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>, Shay Drori <shayd@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Simon Horman
	<horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Tariq Toukan
	<tariqt@nvidia.com>, Willem de Bruijn <willemb@google.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next V10 02/14] devlink: Add a helper for getting a nested-in instance
Date: Wed, 1 Jul 2026 10:32:42 +0300
Message-ID: <20260701073254.754518-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260701073254.754518-1-tariqt@nvidia.com>
References: <20260701073254.754518-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|CY5PR12MB6646:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b9dad0-7a5c-4c25-f868-08ded7432260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	qiGAlJmzejAN/KRBMKvmh7s/Q8TE/iEWvNcq5Sq+n82Z5EnB/QgxHR4k4hpwl24TYbpdcAY8G2YNc86ahY/q9qCq7G+kM7gsFEI8McWu0ICU4d1tjbCTAheXC8DvW6deAvaYDa2nnGP0NHtDMT577UCXnForoKsdUMdn17xZjJc1UliqN3DU2CAhusiEeh4UUT21etFdrr9Ix1sqaxAbvqmxKZdLS043f/iF6kCl3/wjrNYZP786sj2IS3gIJrxTtEPkGapiBrlr0gqka3qL/rSiK1bKaYPRV5UZY1AQR45HkTNL+BiqiHAK+3Q/CxmSSkkvtNRmK7LsjTj/xgah87/vC23ZuzBf139AkwoKeawXbFW9WrUPsLbwoiv8bjVlkdAxQqQptByDMkdNlgNZIM/F80czUcbON7273c3vJNJ6+9gpzypRkWcJ5SJRhIgpuE06BVAHVB7UrtCwzlSlr5kvdN2jRNB6Fmb3Gx9/ux4c25bFGm7ahapHuW5kL83gUlsKTrNt5jKhZ39uGsIFPUz7Jieax9MNnSwXBLPY48DTtYG22UfomLIXDjFrSUWXvG+g1E5fe+lt3/ldbH7IuIbJfrsQY4FhLE8EfWjpoG8oNPP1ZGDYKnw+eIA1A5k1WdZNORkLrRVTM2BshJOLd2MvP0cDBrl1eQmEs1GFjfEx09Z/FX/FyaWmdRBGrN+epTfdYvbOsfusfvvSjAz89w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	C+48xfFRrYfaJ5p/kE9OcUiB42LvlSLwKVNpfD65gbeCYcl2CzT7cGVV1s5zAObDrDrcbVh5VvLTi0Wv8C3HXJDk6X4AI5uOolyjPUHROlP0dVb9hgulu2+GgeSRmN67yqvqpkvTPq0WxFDfpMkA+jetXoy2BTEaSZiCONh7coYZcie/uDbyc7l5nUcAxLo+ck03MjYAiLvgZLRqPiOJhKRjEY8kWnp0bO5KRjordjSem85FaZe7JYASnd1RtkX9X6uG7zfQFNmHROm1PKuhQ1HoL7gKV7Q69ntJOX+XINUXa3J4iqT4a7K9Fm5gLsYsyQDHohr+e7/Kl1WU/7Tn/RgafZF5vJPG4EhOTMTt9f9CtDyUqy4ybQkCHyODEjziASTuyE5uGhRzSqpsve4oXVArNLqjahJESSzbMXmLqzliOcIQFqrrMWacEAf4Ie1D
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:34:06.9388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b9dad0-7a5c-4c25-f868-08ded7432260
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6646
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:ajayachandra@nvidia.com,m:bobbyeshleman@meta.com,m:cjubran@nvidia.com,m:cratiu@nvidia.com,m:daniel@iogearbox.net,m:danielj@nvidia.com,m:daniel.zahka@gmail.com,m:dw@davidwei.uk,m:donald.hunter@gmail.com,m:dtatulea@nvidia.com,m:jiri@nvidia.com,m:jiri@resnulli.us,m:joe@dama.to,m:corbet@lwn.net,m:kees@kernel.org,m:leon@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:moshe@nvidia.com,m:ohartoov@nvidia.com,m:parav@nvidia.com,m:petrm@nvidia.com,m:rkannoth@marvell.com,m:saeedm@nvidia.com,m:shshitrit@nvidia.com,m:shayd@nvidia.com,m:shuah@kernel.org,m:skhan@linuxfoundation.org,m:horms@kernel.org,m:sdf@fomichev.me,m:tariqt@nvidia.com,m:willemb@google.com,m:gal@nvidia.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:donaldhunter@gmail.co
 m,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22613-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,meta.com,iogearbox.net,gmail.com,davidwei.uk,resnulli.us,dama.to,lwn.net,kernel.org,vger.kernel.org,marvell.com,linuxfoundation.org,fomichev.me,google.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D34466EAAE7

From: Cosmin Ratiu <cratiu@nvidia.com>

Upcoming code will need to obtain references to locked nested-in
devlink instances. Add a helper to lock, reference and return the
nested-in instance.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/core.c          | 16 ++++++++++++++++
 net/devlink/devl_internal.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index fe9f6a0a67d5..ee26c50b4118 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -67,6 +67,22 @@ static void __devlink_rel_put(struct devlink_rel *rel)
 		devlink_rel_free(rel);
 }
 
+struct devlink *__must_check devlink_nested_in_get_lock(struct devlink *devlink)
+{
+	devl_assert_locked(devlink);
+	if (!devlink->rel)
+		return NULL;
+	devlink = devlinks_xa_get(devlink->rel->nested_in.devlink_index);
+	if (!devlink)
+		return NULL;
+	devl_lock(devlink);
+	if (devl_is_registered(devlink))
+		return devlink;
+	devl_unlock(devlink);
+	devlink_put(devlink);
+	return NULL;
+}
+
 static void devlink_rel_nested_in_notify_work(struct work_struct *work)
 {
 	struct devlink_rel *rel = container_of(work, struct devlink_rel,
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index e4e48ee2da5a..36dff282f9b0 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -136,6 +136,10 @@ typedef void devlink_rel_notify_cb_t(struct devlink *devlink, u32 obj_index);
 typedef void devlink_rel_cleanup_cb_t(struct devlink *devlink, u32 obj_index,
 				      u32 rel_index);
 
+/* Returns the locked+referenced nested-in instance or NULL. */
+struct devlink *__must_check
+devlink_nested_in_get_lock(struct devlink *devlink);
+
 void devlink_rel_nested_in_clear(u32 rel_index);
 int devlink_rel_nested_in_add(u32 *rel_index, u32 devlink_index,
 			      u32 obj_index, devlink_rel_notify_cb_t *notify_cb,
-- 
2.44.0


