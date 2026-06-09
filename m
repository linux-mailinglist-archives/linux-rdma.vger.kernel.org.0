Return-Path: <linux-rdma+bounces-21999-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 79jzJpmnJ2rs0AIAu9opvQ
	(envelope-from <linux-rdma+bounces-21999-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 07:41:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC1F65C7FA
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 07:41:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="YHzEr/wi";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21999-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21999-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A48E43014D98
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 05:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171D43BFAED;
	Tue,  9 Jun 2026 05:40:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FF33C4540;
	Tue,  9 Jun 2026 05:40:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780983653; cv=fail; b=MaxwGO/d81oBewyK1Uv8ldlORteailO6LgH2Zbx+98diZNv3QGci2J9wDIa1TINDO8quj+gacmiMQi11Yp9H4vxSwoB1K8CQuZK6U023I1o4Lm3n+A4pUh1RKjyE3ADtWcWFdqXTzpXoTlywg1wuCEnYtT97E36IYi3W7f3al9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780983653; c=relaxed/simple;
	bh=O314YEvG5JW+bc6Ip8Tlr0U8MW1y8VJ7Dpq6Z3U5/84=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f2Zf6jdLCvVxYFnZW+Vnb0W0sXdsZy7+94WUwK4c2tdXTjVgTU708225DFe0zmPy4/XeCLkoWtEIT7rGvRuDkjAa1I4JP5yryy7dwsccgR5s5W6aHtefQpz7NxKvUbpfMkI1GSXsFAshhlIIs1YnWV1uOHulPxdxtMYP6nyGrmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YHzEr/wi; arc=fail smtp.client-ip=52.101.43.12
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLOz4xnnSdLEd/udtEFPtFksTcap5NgU4c1zQwTIToiJqNMbiKaWfvTUiLUl6M4E7CioMs57fjHt5ovGtDgBJ7DggTrfvLG9HKTMjgzb9lwc+igo0x3bv/92jofDrLyJv7Dt8v3+Aw6HHeo99n73jN3RNyZxFjzUSL5OH4/7d/5KKvGw0NfiuYhSEyitR+1SEafjSKQkT93DpEjy/AbrJ2O184RrHU++wV4iaG/LpQWnELB56K874tTgVvFzZpAj8sZv2HOG6d7aFiDOZUK2bEcbJ8uh9+NqCSGd8xVgDbPukYoTX5E/Nb1wpnXu4kWWB7YGkYvj27S0AM3n/PaaoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gQfz0qjAQFoOdhCeIPSqsb7Wx1GPva0gwy1T5k3UJo=;
 b=OawdYAOqRp3tnRDLOZTPokXyhN/lPvFeaSZRqQ/+41RpgWZ2SjjVlBVY2Wt1gBGxh7zXoOmS1OfSnM7RB81h9/CFJTLAh6RXPl6tOWT5fGBxqF6cA1o0xXt79skVZleWALtLzhLAPXIhz9HLvUDoedV4iP7Maw+vno2oTuNW0UYDq8CmCGXvM3iUaV0x9tGUifZ2jT7JFxb4iutYfOZymMona8TteoROU06nXT4DS1V3dYYWNr+Qc1fkwmEmUoWArHKZfBfG7KB0b8YEC30qynEORbV8azhrxZG42BUgg8+ssAOMmvuzvZX74nldhUNcYho+MOHLLY5+zOgXLJUh2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gQfz0qjAQFoOdhCeIPSqsb7Wx1GPva0gwy1T5k3UJo=;
 b=YHzEr/wiTLiRV4lQE5DUmj8yozlbGC5xAiKHs+G2x7WGVX/oNJnKDiWrUfsD3Hxk5oZuVgKEmm0aR0/cfQjJR1ggVwWNxuAFwz4mpQjhNJmAbVRtY0k8bB+h1AaPA6BX1WWvOZXKjrrDXgwu3xWbbUxMlU0eWhjdCa25/10vET/2TGhnfd/q3i4sr6+GevswzZHT7U7Q/I59X3G4a45mFMXVWGrGJCRVdUpJWFFZZpE7TXHXFfvDXKHq9B8tLeZxlfBURtuH9EhsZdSk8+D7ITpFM/xSBQYQyJkxgnMNvv1c3JamT6YRC0+Tq+wYX55i65qxrlU5/o1CHnldiJuqng==
Received: from PH8P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::29)
 by MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 05:40:47 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:510:2d8:cafe::9d) by PH8P221CA0026.outlook.office365.com
 (2603:10b6:510:2d8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 05:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 05:40:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 22:40:33 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Jun 2026 22:40:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Jun 2026 22:40:23 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>
CC: David Ahern <dsahern@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, "Chuck
 Lever" <chuck.lever@oracle.com>, Or Har-Toov <ohartoov@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drori
	<shayd@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Daniel Zahka
	<daniel.zahka@gmail.com>, Shahar Shitrit <shshitrit@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Cosmin Ratiu <cratiu@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Kees Cook <kees@kernel.org>, Adithya Jayachandran
	<ajayachandra@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Petr Machata
	<petrm@nvidia.com>
Subject: [PATCH iproute2-next 0/7] devlink: add per-port resource support
Date: Tue, 9 Jun 2026 08:39:46 +0300
Message-ID: <20260609053953.487152-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|MN0PR12MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: f13f0f69-1bd4-4487-c3a2-08dec5e9a79e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|11063799006|56012099006|6133799003|18002099003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info:
	nk5J50wIfsofyv7/0JFzH46omqHICMwWUTGJ0FZKuepO57rhFtMsQKU0jbTWEVckCDEPZEMKm3vvREYUMdy06LZzpKa+mZj/9yNM1SAr8n8h4GmK+oQpJUChbXa00RVWCULw4b2iJXhj+yZJteeeJGnCDP/2eC7tY8v7nFi8CM914JgJLAs1tAnubue0YA8SExUz2tYIZ4hHm8k2tIPkEtgaaQAX+EVAdzbMkFBD/+ppsgIuwUTM6SAFFeEoZCwhyWGi7kz+96UKGtTSVb6D9AiqDgPBd4gbSz7OBjnew9kqkuzI6HhSxDi/169UxSSah2NMQ5j+V/Z12uA+ao2KHSS8UOyzyAehrURY6ZwZlkjEEuwGe1gGBApyNTBPKuOC3cxLq7ZazPmYyjzxkUzji5xRsXmdNbPZ7RXgziE0EEX8SBnrudkcQbuhn8xkfvxBB4vEJo/RulKPhrt4EGEg6D7BnNED2WLn3QaQmEEMb1F6eyc2kCMuma8IqwLa6e5pKf7J5EMBszjcz2/lzM6yTZykGqo3Hwdi33/vp4P1zwaaYDMBoIEI8pH9nFC2DekkDfDomV8WTDNvukVRJerTRQTtNjJNKNz5iwMpR49TBOVwnAjEfnu39Qen83SbZKwKxB7PjGIrydlhM2uGmEFn7VVZ8OOqj2ziDrqUJ4wHZAuxMkxPuK9P8RdFPe7doml+3P5mqruTtAnXg59HEmcLPIq8DyDCHoWymsvqH0fe+5x3uvWK4iplyify/T1vRQ/n
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003)(3023799007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1spcJajCy8cyvOPRp2onwVdy8YCArYSsiI0pU1ABCoclJgpnZhRl7yeurYKTaFUlclZk9SgTdZo8nOXCoSUAhiX828GpbUWbBf1nQ+SgMMzoijznBv02aIRiWZuK4Tx5y1CTUyMNPva4flpvG0XIGJc3lYNBV/kdeX82n8e3SAWqlkXMlB+l9N12digUDjZAk4IW2m8JF8buLUKGNOEa/TnE5Yoo2yvGk1bteignpXus9jvflgLS3lg8NU9K0ctSgAzHaZCGG8u9Fqe1jmeiwIQi30J42z9MeLdx7VccapLR40YYJ3BxgskCUn8uuszKcuWj97UCVpnNjS00QkMS30xDsrpDY6CNOVwWsSlcpb/QtesZOeLx+8cu0dNCu81c+AlNt8kPsgywXPanhJpV3UOi79jxX6Mwh6e/tGvTJCq4sl5aPmFaxBNZ+gGP8Vmc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 05:40:46.1936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f13f0f69-1bd4-4487-c3a2-08dec5e9a79e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5859
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
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:dsahern@kernel.org,m:donald.hunter@gmail.com,m:horms@kernel.org,m:jiri@resnulli.us,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shuah@kernel.org,m:matttbe@kernel.org,m:chuck.lever@oracle.com,m:ohartoov@nvidia.com,m:cjubran@nvidia.com,m:moshe@nvidia.com,m:shayd@nvidia.com,m:dtatulea@nvidia.com,m:daniel.zahka@gmail.com,m:shshitrit@nvidia.com,m:jacob.e.keller@intel.com,m:cratiu@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:ajayachandra@nvidia.com,m:danielj@nvidia.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:gal@nvidia.com,m:idosch@nvidia.com,m:jiri@nvidia.com,m:petrm@nvidia.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,m:danielzahka@gmail.
 com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21999-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FC1F65C7FA

Hi,

Currently, devlink resource show only supports querying a specific
device and displays device-level resources. However, some resources
are per-port, such as the maximum number of SFs that can be created
on a specific PF port.

This series extends devlink resource show with full support for
port-level resources, including a dump mode, per-port querying syntax,
and scope filtering. In preparation for these features, the first two
patches refactor how dpipe tables are handled to unblock dump support
and ensure errors in secondary queries are non-fatal.

The series is organized as follows:

Patch 1 splits the dpipe tables display into a separate function.

Patch 2 moves the dpipe tables query into the per-device resource show
callback, ensuring it behaves correctly during a multi-device dump.

Patch 3 fixes a pre-existing memory leak in resource_ctx_fini.

Patch 4 adds dump support to resource show (no device required).

Patch 5 shows port-level resources returned in a dump reply.

Patch 6 adds DEV/PORT_INDEX syntax to resource show.

Patch 7 adds scope filter to resource show.

With this series, users can query resources at all levels:

$ devlink resource show
pci/0000:03:00.0:
  name local_max_SFs size 508 unit entry
  name external_max_SFs size 508 unit entry
pci/0000:03:00.0/196608:
  name max_SFs size 20 unit entry

$ devlink resource show scope dev
pci/0000:03:00.0:
  name local_max_SFs size 508 unit entry
  name external_max_SFs size 508 unit entry

$ devlink resource show scope port
pci/0000:03:00.0/196608:
  name max_SFs size 20 unit entry

$ devlink resource show pci/0000:03:00.0/196608
pci/0000:03:00.0/196608:
  name max_SFs size 20 unit entry

This series is the userspace counterpart to the kernel series:
https://lore.kernel.org/all/20260407194107.148063-1-tariqt@nvidia.com/

Ido Schimmel (2):
  devlink: Split dpipe tables output to a separate function
  devlink: Move dpipe tables query to resources show callback

Or Har-Toov (5):
  devlink: fix memory leak in resource_ctx_fini
  devlink: add dump support for resource show
  devlink: show port resources in resource dump
  devlink: add per-port resource show support
  devlink: add scope filter to resource show

 bash-completion/devlink     |   8 ++
 devlink/devlink.c           | 202 +++++++++++++++++++++++++++---------
 man/man8/devlink-resource.8 |  34 +++++-
 3 files changed, 192 insertions(+), 52 deletions(-)


base-commit: 7340b539841dc739bc0b813e8e86825bc1eb5a4c
-- 
2.44.0


