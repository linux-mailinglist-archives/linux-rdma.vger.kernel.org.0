Return-Path: <linux-rdma+bounces-18682-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMICLyXaxGnN4QQAu9opvQ
	(envelope-from <linux-rdma+bounces-18682-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 08:03:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5465833024E
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 08:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C21A3011774
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 07:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C04A241665;
	Thu, 26 Mar 2026 07:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CC4ymfQf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011034.outbound.protection.outlook.com [40.93.194.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C980533A9C1;
	Thu, 26 Mar 2026 07:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774508447; cv=fail; b=Mx0iTdrx8NXSupeg/SZMGVZNoc6EkomN6n2Y1sZ2b6FxihstauaLD6cJybw7WB66nQwUrUshdfukGtQQwSAOERAd6UWXTmdPoGSjQmZxjfmbvQugs+7uYGqLMGIvQbymk2c2WgcLGpOzJDanESU4R4PN5NxrUfpGFIuQJsC+c/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774508447; c=relaxed/simple;
	bh=AF+rXBNJCEGaeOcrBp1rygTdfKLZXLAJj0SMfEoJkrs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RntKTXG8TwSOPAQ2uh6oRoMp7D8La6zFFPEFY46RgxV0mQbOOmvyppGamfouoxByfUxw5gtqPq8klTNIqqTLJ7zS+zbtgYfUuX44CTnhorQu/IcIfrhgzqVVR3gQw46PKrbEItT2CEMRzB0fBGo31Ale+cY16gGR5OfMBXhl4os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CC4ymfQf; arc=fail smtp.client-ip=40.93.194.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8AHU4c8gop+R8Gj6EqpR4r8dbDXiVANThoAizIsu7TwMIWbUdXN3E4aX9jRCHDlnD4k/U02wBnxrEOFX8osXb8C1FWb+RO9Ny+7MElzBlyhWgyWRbBlnw9DCymFCK/brCghstuLNannCIjADljIXRqtB7XbGgFaFp1v31B9wuAYFdXSWneSjnYLy4TuV+bOaySuyrV/vqyNUvWH1Nrm8RS37GtX3zvPGroj4yiGODoQn7eEkYZY3mXVCZLed8FAzaG1iakLcqYEsW8qCa5GLCgks5avlo5G4mxu7b8F/cq9zE0Em4HnfmNgTtGufmHvK6s7HOuO6gxnYwkiyYoTWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2Y/xTOP3cqDCioIX1RY6OTb7tSyXY+I1aIVKQUePP4=;
 b=hSw8Fgp0t5S5hy70q8cYx8D8iDVNlNm/D5c4wccFtUc78XE17f1AsYcILT4mRMhbL6mtPAk5vcvZ7Gw4a358at8SoxOGq0T8U/BKhw0af7n1hgAVYrwcoIYKg06V42cBQ8bDEjX2FqWunuCBoaBhNWRGSUSA/1WbvC+EFIF9T870bCQJeYYwuoYz2ZFScBVT5f0BSQi5qv7eRBXHP43GyQe5JKbLYeTaiN4ia226x4hqS/AS2NbxZ0NfnIZBz8gM/9TAfHSI/sJ9NjyVIcKP6drgHc4klNmT8X78PDBNHm2dCTts3JcUum+GZoRJZl5cSVKuE4a80jvWA2wlxLfeKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2Y/xTOP3cqDCioIX1RY6OTb7tSyXY+I1aIVKQUePP4=;
 b=CC4ymfQfxVTbC6CM2tytxIr3joCtfW1r70ELRQbB/HuYUVbqLaj4efogsuw+rTHrBEjgWzYaE3/+A/8qgFLYW77dL8BCe+r04D81mHfr+gvCrx/EZNfVib0ZZLoHv+AD3KZAfhwuwDPcfejysp9HiFFzBVZcHOlrz1LzP3QLT9t7+mhLmcmg2AzygOJjc0iQsdaljYXQmgtk5iFdIbkFIIqnYGxVYlchYrn+E+U4GCWca7rAmsyLIbzzp4UB2EiXSwB+ORrfVgyNgoVti3g4r+f4UqUYvtD4by3b853aVpFGxWtsEsM0/fKtKCC7Nkqu20Ewrtv5o1bs+evNjczyow==
Received: from DS7PR05CA0031.namprd05.prod.outlook.com (2603:10b6:8:2f::6) by
 IA0PPF6E99B1BC1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 07:00:37 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::c7) by DS7PR05CA0031.outlook.office365.com
 (2603:10b6:8:2f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.20 via Frontend Transport; Thu,
 26 Mar 2026 07:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 07:00:37 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 00:00:19 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Mar 2026 00:00:18 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 00:00:08 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Shahar Shitrit <shshitrit@nvidia.com>, "Daniel
 Zahka" <daniel.zahka@gmail.com>, Parav Pandit <parav@nvidia.com>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, Kees Cook <kees@kernel.org>, "Shay
 Drori" <shayd@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Willem de Bruijn <willemb@google.com>, David Wei
	<dw@davidwei.uk>, Petr Machata <petrm@nvidia.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Daniel Borkmann <daniel@iogearbox.net>, Joe Damato
	<joe@dama.to>, Nikolay Aleksandrov <razor@blackwall.org>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, "Michael S. Tsirkin" <mst@redhat.com>, "Antonio
 Quartulli" <antonio@openvpn.net>, Allison Henderson
	<allison.henderson@oracle.com>, Bui Quang Minh <minhquangbui99@gmail.com>,
	Nimrod Oren <noren@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V9 00/14] devlink and mlx5: Support cross-function rate scheduling
Date: Thu, 26 Mar 2026 08:59:35 +0200
Message-ID: <20260326065949.44058-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|IA0PPF6E99B1BC1:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f76615a-cc4e-4cbf-1774-08de8b05627f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|30052699003|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YbZ/WQF04EdmPRABdi18hZrBJCy3dn1I2tQslrRJ1/kPNSFb2AOI+kU/rJ5Q59jmeJ++1kW2+jOlcK/oDX5ctq0HfowgnRrJpXhSSXhcOjHZfFbNDZZ673nYEjtNjXHEJ5JdhS8JYAr8ouT2NK70BFUTRduCeR3QlpZM1O36Pkf3+JuDc53SQJDDF4fsV4NbpUA4rovhcfe0RRBcYHyRjmiv/NRr8RroTNZUD/9tN/zz7Fm1Kud/tms9r3wGL5TKJYeqjuRlCDDmLgbpggRi1f7OVP+nm/ucGWz8maDmMtqs/XPWlvZMBC9iUsmbLATxzIDQbT6eHfS5EUbjBwWmUXTd8cNe8jFuECkXpjRsNiyIPeTfIcl/Tx2NATLaNvC6SCLPiyjzrLmX4K9em3uk88q+rPzQNIqsosx+Ovu6kAWSoLWrkZkJVNfnyssy9yWmBrJrhm2rWGP2cPAoh/Hib2djREXBZsFtXlzSOSp9gAjzXXrH0LOa+KesElLLkVuemTA9gmepy2SFWFIRGqsaQpq5FzmgUAoPRZ6cqYqEWmALm6SIC139lxWRCnxiWZy+2N0d/+QQxFFH3V52ONXAZD6HJrkuDDxuISaorkQtDA4xHAbkQsop3a41JknC5FNIuPVh1IugYlcL9bZnRl+uthTrqdNUOPuOpk9mNoIESybAQ8peNLiPEnn6COcpCj0ntIoI/HsamlbTwj2kEO2BJg9+U7/uJaK9Bh7hQzg7vgzVv2esb2Astl91AJONF6KuMlIcqudfAkO2MwB7DnWLWQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(30052699003)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fBA13JxmHXShplGLIcNtABYasJKnvfPJe2++97HiJeMx6VI6VLwTg6BmKx4aYj+12LdI+xBlYLDbNhfMIVLa021Xtsb8OIOpU1emSa+WQ7+QsOcDs53EJ1aehtSGTmn0WsRC19VbonSTVogHuMwfxpB/OqcKD8F0fPem89m8CqqAYK2XmtNqtXGHHTWKdZIy3hUtFNzanzYCPLgzMPzO3OljYFPhdQGXiVAgCHwggCn0bGU8oVtiLXuo3raRkZutel4O90jgCIV0bnX4jNVkYSiNDf5I5UufYn5LANAWtsn0zxF1hFT8XcHBjPm9lBBz0CYPXVj7fOk781DjwKzqm3syOjYbOeyaI3OBQxXgju3+CozPorW4ujq5CLZVedWWSTypzLY6dONJc0SoBHfI2g+YoLxpz2LBcroDoAyFQ2s6Wjbp1B13MupILdDsJwbF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:00:37.5824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f76615a-cc4e-4cbf-1774-08de8b05627f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6E99B1BC1
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,google.com,davidwei.uk,fomichev.me,iogearbox.net,dama.to,blackwall.org,linux.dev,redhat.com,openvpn.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18682-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5465833024E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series by Cosmin adds support for cross-function rate scheduling in
devlink and mlx5.
See detailed explanation by Cosmin below [0].

Regards,
Tariq

[0]
devlink objects support rate management for TX scheduling, which
involves maintaining a tree of rate nodes that corresponds to TX
schedulers in hardware. 'man devlink-rate' has the full details.

The tree of rate nodes is maintained per devlink object, protected by
the devlink lock.

There exists hardware capable of instantiating TX scheduling trees
spanning multiple functions of the same physical device (and thus
devlink objects) and therefore the current API and locking scheme is
insufficient.

This patch series changes the devlink rate implementation and API to
allow supporting such hardware and managing TX scheduling trees across
multiple functions of a physical device.

Modeling this requires having devlink rate nodes with parents in other
devlink objects. A naive approach that relies on the current
one-lock-per-devlink model is impossible, as it would require in some
cases acquiring multiple devlink locks in the correct order.

The solution proposed in this patch series makes use of the recently
introduced shared devlink instance [1] to manage rate hierarchy changes
across multiple functions.

V1 of this patch series was sent a long time ago [2], using a different
approach of storing rates in a shared rate domain with special locking
rules. This new approach uses standard devlink instances and nesting.

The first part of the series adds support to devlink rates for
maintaining the rate tree across multiple functions.

The second part changes the mlx5 implementation to make use of this (and
cleans up remnants of the previous approach, involving rate domains).

The neat part about using the shared devlink object is that it works for
SFs as well, which are already nested in their parent PF instances. So
with this series, complex scheduling trees spanning multiple SFs across
multiple PFs of the same NIC can now be supported.

Patches:

devlink rate changes for cross-device TX scheduling:
devlink: Add helpers to lock nested-in instances
devlink: Migrate from info->user_ptr to info->ctx
devlink: Decouple rate storage from associated devlink object
devlink: Add parent dev to devlink API
devlink: Allow parent dev for rate-set and rate-new
devlink: Allow rate node parents from other devlinks

mlx5 support for cross-device TX scheduling:
net/mlx5: qos: Use mlx5_lag_query_bond_speed to query LAG speed
net/mlx5: qos: Expose a function to clear a vport's parent
net/mlx5: qos: Model the root node in the scheduling hierarchy
net/mlx5: qos: Remove qos domains and use shd lock
net/mlx5: qos: Support cross-device tx scheduling
selftests: drv-net: Add test for cross-esw rate scheduling
net/mlx5: Document devlink rates

[1] https://lore.kernel.org/all/20260312100407.551173-1-jiri@resnulli.us/T/#u
[2] https://lore.kernel.org/netdev/20250213180134.323929-1-tariqt@nvidia.com/

V9:
- Link to V8:
  https://lore.kernel.org/all/20260324122848.36731-1-tariqt@nvidia.com/
- Updated netlink_gen.c policy related to index, missed during a rebase.
- Fixed off-by-one error in devlink_get_parent_from_attrs_lock.
- Fixed crash in qos.c when setting a parent to NULL.

Cosmin Ratiu (14):
  devlink: Update nested instance locking comment
  devlink: Add helpers to lock nested-in instances
  devlink: Migrate from info->user_ptr to info->ctx
  devlink: Decouple rate storage from associated devlink object
  devlink: Add parent dev to devlink API
  devlink: Allow parent dev for rate-set and rate-new
  devlink: Allow rate node parents from other devlinks
  net/mlx5: qos: Use mlx5_lag_query_bond_speed to query LAG speed
  net/mlx5: qos: Expose a function to clear a vport's parent
  net/mlx5: qos: Model the root node in the scheduling hierarchy
  net/mlx5: qos: Remove qos domains and use shd lock
  net/mlx5: qos: Support cross-device tx scheduling
  selftests: drv-net: Add test for cross-esw rate scheduling
  net/mlx5: Document devlink rates

 Documentation/netlink/specs/devlink.yaml      |  24 +-
 .../networking/devlink/devlink-port.rst       |   2 +
 Documentation/networking/devlink/index.rst    |   4 +-
 Documentation/networking/devlink/mlx5.rst     |  33 ++
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   1 +
 .../mellanox/mlx5/core/esw/devlink_port.c     |   2 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 532 +++++++-----------
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   3 -
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   8 -
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  15 +-
 include/net/devlink.h                         |   5 +
 include/uapi/linux/devlink.h                  |   2 +
 net/devlink/core.c                            |  42 ++
 net/devlink/dev.c                             |  16 +-
 net/devlink/devl_internal.h                   |  19 +
 net/devlink/dpipe.c                           |  14 +-
 net/devlink/health.c                          |  12 +-
 net/devlink/linecard.c                        |   4 +-
 net/devlink/netlink.c                         |  82 ++-
 net/devlink/netlink_gen.c                     |  24 +-
 net/devlink/netlink_gen.h                     |   8 +
 net/devlink/param.c                           |   4 +-
 net/devlink/port.c                            |  18 +-
 net/devlink/rate.c                            | 290 ++++++++--
 net/devlink/region.c                          |   6 +-
 net/devlink/resource.c                        |   6 +-
 net/devlink/sb.c                              |  22 +-
 net/devlink/trap.c                            |  12 +-
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/devlink_rate_cross_esw.py  | 300 ++++++++++
 30 files changed, 1032 insertions(+), 479 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/devlink_rate_cross_esw.py


base-commit: b50a48b65cb0c955728894b24ba5ecc3cd4b8c7d
-- 
2.44.0


