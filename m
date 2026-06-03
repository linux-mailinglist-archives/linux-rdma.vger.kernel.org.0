Return-Path: <linux-rdma+bounces-21675-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BvZkD+8BIGqptwAAu9opvQ
	(envelope-from <linux-rdma+bounces-21675-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 12:29:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B7863696E
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 12:29:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ICvyyVU7;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21675-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21675-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51E4E304ADDA
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 10:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A71E3AFCEA;
	Wed,  3 Jun 2026 10:27:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E90138A728;
	Wed,  3 Jun 2026 10:27:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482456; cv=fail; b=QLsfF2mNVsqEa4jhQxH0nN0/vRNL2an2Y0cjZD6QPa80SP3YrBk82EmG9t9SxjA6dYRyWpxpIAtGSRfEo2/CkNaT0axZ99fFNj3k6KcwnRQG/IuxGeKpEL+vEHSzZQa1HIdR3v53W71EgcxcxtuTmBdGFdeNvSrRSQcrPXhIhvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482456; c=relaxed/simple;
	bh=HeWCSKjStkGw1Bd0JI0zhxCLPYMRW7aNE0Ew0/ChlPM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=olnUZEKfJMSjD6XcKLZrLkhODp3391ae0Kx+U1RYacBQ+JFcvgEpRfp9aWJEmbdo6ALGmJlQd8XjVYMNTGNOz9kMLhsCZCV0q211QYamGjofyiW92kaLMevJyWO/aho8O2gVofIIM1GM12NxLXPc5kGVi5UeepLwEIatLrO3Yrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ICvyyVU7; arc=fail smtp.client-ip=52.101.57.24
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5G0f7cAHMRJXf3eNlu6TYNJhJuEoCyZG9H+v+0Nm0abBiT+mrvRor6wd/zn4lQkpsflLimJ0UJBleCAsqZQQu2QG/TWS9CMX4MqDqSVaNGarOUL6CVWyQMloky+lzvOUw3/pELKnsVupfZvKfU7MkTFrXaXhBjF2kQ03aiX0qyx50ep5Mru9E/gdF11rK6RMQsHbPy+OufGInSjkoUbtJ0q4gVVVAC35mgUjmvsv0WsOgnHpP3bBOhDQRknDBCMFJ5XgUCUQauJXzWImLofRFqk5bhSAb3eRY++LOR1IeGVvhSQZpMCogdFfBvLSaTGyhiVbVbzCAhMEom27mbAmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLwzHQQKihB1EYQ6c0YtX2LJcCJSu8DXOv9gvwqyNOk=;
 b=AtPWLpyByZS295re9GeP1cD/HYIwYDKP158p+V/wurasD71vhj8Dvi8xQjywI5BDDYQUhGrFQnCkHm2Z+hngyxyvlNnq0/bW0tAezYh3GZnSKgVXTtguu/oYyFZJcsaoQoCh4abNYQ3nvMdlRNGrNnNTvt+G1JmqTKRHBO08CHh4W0N2EzLB1LI47Qf64RVgjfW6eTOTbL+nRxCHiU5BIbfU9VvIxZGjahLR3mxvt+bva6DVgQZjUty/mbLkLnTk8/NjhG7QDcnYSRE6NCFnRQOBkJWk02SSkXrJTl8TQx/FGaDUSlFKC+z0UnRjk9AaJzAYiSrHhEifs8el3ipREA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLwzHQQKihB1EYQ6c0YtX2LJcCJSu8DXOv9gvwqyNOk=;
 b=ICvyyVU7HqEP+frEopcteJ7D96xAv9R3ij7R4QQUSy+OZOkMqD0E2DIJh6S6Rj8LadZZ358gzg7BYjdBLznzIRFNsrYWb3+Blexd/FEfp3/XSkyzrHRSzSPKgMP6NwYQfsp7wVSYtWx6wwwPyLUNtW0JCXXD+kuUk5MZM0ETW1x8xOPCAhMjnW22jITzPG9D33Dyow6WTpcKu5e2jp6lrbaH/NQmxTFNUfTEVTgkXkt22fKrb68mm/eVhMpevCnO+A6f3z6wnQBYRC9bs/84Mx2+V/r8DaqD918a61A414BviFp2EYC/ga+yi3nx+8FC9EDBXoxCK21V08f3P8jGsA==
Received: from SJ0PR13CA0069.namprd13.prod.outlook.com (2603:10b6:a03:2c4::14)
 by SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 10:27:29 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::8) by SJ0PR13CA0069.outlook.office365.com
 (2603:10b6:a03:2c4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 10:27:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 10:27:28 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 03:27:10 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 03:27:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 3 Jun
 2026 03:27:03 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dumitrescu
	<vdumitrescu@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Arthur Kiyanovski <akiyano@amazon.com>, "Petr
 Machata" <petrm@nvidia.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
	"Nikolay Aleksandrov" <razor@blackwall.org>, David Ahern
	<dsahern@kernel.org>, <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Amery Hung <ameryhung@gmail.com>
Subject: [PATCH net-next V3 0/2] devlink: add generic device max_sfs parameter
Date: Wed, 3 Jun 2026 13:26:44 +0300
Message-ID: <20260603102646.404797-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db67bc7-9474-4e4a-8e04-08dec15ab6b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|13003099007|18002099003|6133799003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	vK1j/9rMT6Pq73TnE4JB4+PqmLqJBMXOUgLg5PAbUEsDWsQzkjLYybguvpRBk6dzFptqEswJ3QUygYkQgx7nAvuMgjNs3m7ZCYkut7kRc2aOnQHSTGdCeI7+9sXmtITJyf4q1Z0ty23s+zTRkxY9velMvLFJpdo5rEC8T29WDBtaev+Le8mAYhzXUhU7+vC3oyuLm1D8AULA/scLjLG4NYEcyES+pLj/BNezHSrTAs5Wv7m/0Q5Lh3v5uFc9KkLyRXHYausDwof+bggdQAV3vOSxgtFTMPZvII7lEC8/RGpl0qwjQaihB8YYFzVqVzVSZ5Ok7qRgYfXkHf0lxN63ClAIp4qLzg6PSBZNmr5E7mMShc6/ywdGoYNlKqN9TBmZb0xUVD9I9TnsP0yrV2FVs95u2PB2tnuADbbHliNRfH71WJQoBJDHe2mIq3yDYidMq2prz7ddWlb6I4fMfyzU56AZ/hLBG9hdL64cWjBRopyWnAlH475q3xt96fqtfoooaL/8U/vwtPnTrtsDF2wJkID/6iSmaKrW7Q8ibayKfq8ZrXX5NP7JEPvWop/Ij/ZSnVPAfQZcSoqIDCx+DF1FhTb79iI/Cw+PGjIRwXVm3HDH/CsIukNcGRJ53wZr9SmuJBtJrS1LhVGuEXJjZrpuc3X5yUIizXzzVXOGsedyYer4efVA7w/eadLV533bvtcID5uUtdigRgdKLErsuNdBYxViYdJ+TKkeTSWQZRrpYCM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(13003099007)(18002099003)(6133799003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Co9nBiWiOa5Xrh+gx/qydoVw9jRQOw3ixXXLHMMim+A9dvWDgmIekOV7VdpTpjZssYuQxcKGNJbwuR1o637lUpAfcTJXwimH+h25j6w9tHtzcIREpimS44eFmHLnV1N3sBmPtUSo/ceVlfF3nNVw+NYvyYbSmc+8iFDgY9VTpwfvme96lUgz0RVOcvhWpoFinSYPF7YDKU7lJDb69EezCSnUZAZrh1HrZZV16YnLMRMb7d2rXgo1vCgg1BVC0V0ezHA/gpy6bNJJznP50KbbHBvlT0ip0vkGeJwZo2fBBxkfXBcmVrEbcFmro6uRCCw/iuOJ1ss/YNpYwmhYhvxzvDlWu4DsgCWTSGrYET+CTqlj9s2moPnHuFd9Ug4lXuxGoQpH9bSSZfKR9xIUCZEyRSVltVPg6S/vYo1mttKPlmb7sXpm8TET9Do3aVRaPR4T
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 10:27:28.8307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db67bc7-9474-4e4a-8e04-08dec15ab6b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:jiri@resnulli.us,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:vdumitrescu@nvidia.com,m:daniel.zahka@gmail.com,m:aleksandr.loktionov@intel.com,m:przemyslaw.kitszel@intel.com,m:akiyano@amazon.com,m:petrm@nvidia.com,m:rkannoth@marvell.com,m:razor@blackwall.org,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:gal@nvidia.com,m:ameryhung@gmail.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21675-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[resnulli.us,kernel.org,lwn.net,linuxfoundation.org,nvidia.com,gmail.com,intel.com,amazon.com,marvell.com,blackwall.org,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:from_mime,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2B7863696E

Hi,

This series by Nikolay introduces a new generic devlink device
parameter, max_sfs, to control the number of light-weight NIC
subfunctions (SFs) that can be created on a device.

The first patch adds the generic devlink parameter and infrastructure
support.
The second patch implements support for the parameter in the mlx5
driver.

With this addition, users can enable or disable SF creation directly via
devlink, without relying on external vendor-specific tools.

Regards,
Tariq

Notes about a few items from a previous Sashiko review:
 > Should there be a validate callback analogous to
 > mlx5_devlink_total_vfs_validate() that reads the cap and rejects values
 > above the device-reported maximum, so the documented "device-specific
 > max" is actually enforced?

 N: I don't know of such cap, if there was I'd have added it.

 > mlx5_devlink_total_vfs_set() rejects with -EOPNOTSUPP and an extack
 > "SRIOV is not per PF on this device" when sriov_support or
 > per_pf_total_vf_supported is clear, but no equivalent
 > per_pf_num_sf_supported (or any SF-related) capability bit is added to
 > nv_global_pci_cap_bits or queried here.  On hardware that lacks the
 > feature, the user only sees the generic firmware error "Failed to
 > change ... global PCI configuration".

 N: I don't know of such bit, if there was such bit I'd have added it.

 > At this point, a successful write of per_pf_num_sf has already been
 > committed to non-volatile firmware storage.  If the subsequent
 > mlx5_nv_param_read_per_host_pf_conf() or the second mlx5_nv_param_write()
 > fails (for example, transient firmware/PCIe issue), is there a path that
 > rolls back per_pf_num_sf?
 >
 > Because these are permanent parameters that "require a reboot to take
 > effect", a half-applied state (e.g., per_pf_num_sf=1 but
 > pf_total_sf_en=0/total_sf=0) appears to persist across reboots until
 > the user issues another successful set.

 N: That is expected and in line with the rest of the code.

 > The commit message says max_sfs is to "control the total light-weight
 > NIC subfunctions"; the BAR-size side-effect is not mentioned, and any
 > previously configured log_sf_bar_size is overwritten on every
 > max_sfs set.  Should that behavior be documented or split out from the
 > count knob?

 N: It should be documented when it is split out, at present time - no.

V3, all changes are in patch 02 (mlx5 implementation):
- Cap max_sfs at U16_MAX using a validate callback (sashiko)
- Change the warning message to match the docs (sashiko)
- On get verify that per_pf_num_sf & pf_total_sf_en are set
  otherwise return 0 since it means SFs are not properly enabled (sashiko)
- Define the default log bar size and use it instead of raw value (sashiko)

V2:
https://lore.kernel.org/netdev/20260519200436.353249-1-tariqt@nvidia.com/

Nikolay Aleksandrov (2):
  devlink: add generic device max_sfs parameter
  net/mlx5: implement max_sfs parameter

 .../networking/devlink/devlink-params.rst     |   6 +
 Documentation/networking/devlink/mlx5.rst     |   7 +-
 .../mellanox/mlx5/core/lib/nv_param.c         | 118 +++++++++++++++++-
 include/net/devlink.h                         |   4 +
 net/devlink/param.c                           |   5 +
 5 files changed, 136 insertions(+), 4 deletions(-)


base-commit: c2c0486c56800ce276e79c40a6e576ffd672f2a9
-- 
2.44.0


