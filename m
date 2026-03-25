Return-Path: <linux-rdma+bounces-18648-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ7RHqMxxGkAxQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18648-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 20:04:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5BC32AFA7
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 20:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06FF3303CA17
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 19:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F43335C19D;
	Wed, 25 Mar 2026 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oi3B3QZq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013042.outbound.protection.outlook.com [40.93.196.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A76C350A33;
	Wed, 25 Mar 2026 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465268; cv=fail; b=S1D9sYtM1xBabWvc9b/ovDxS/+NaUqZSEnoUHPTsUuMEbRbt0t/ll9vFDgOd3ioha8oJ8gLL8SvOPt81JiMlQr6ZcObqnaet7TDMxrawpV3AJrIsCK5CuFfKBo6NMpkSd6BCey4HxD7l+AM0jTWJNDY78g76EJChho+Ro7kaIVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465268; c=relaxed/simple;
	bh=grM+h8GRDnOD4JjfMVxqh7PYok2VkVzxVMjVCs+8eHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cwv4ZMDre1pv2phtyDeif4Xg/YHOEfExIdL3z+9Bll3XfRGDXA33srjaTlAheiYu58AX/ll3lVIwxvMLaPS620sTsja4JGZFoogrH7bmtzOnmLFYEs0cfnY+EcyPOW1dVB9yf4OHhyjVDl3Jlxzt9bpvbyeTHfnqGwjAiZ5APYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oi3B3QZq; arc=fail smtp.client-ip=40.93.196.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnLMaYWfBeqqOtwD94S+fNDHSEB4o9hTlw0c9xwJtkKyS2e8F/7xAp4lvy5SIK3x/OvEsILyxFC1XmLwWJWChlUCszeRyNQHQxG+DKmxxJ0lsFkubEo2CavcDRrc4zu8chDBci9G99KkX5zA/9BCsbifu3y1OLxyWsi2hM4VO8huJjTff/b6zmfBxRSXIP1yGzyAnE9ubtKQS0TIJIzxVnSXcJHk9kL7NLz15t16u88EWUn4G6D5gP1i2/0QaJV7rrpV54lQ6+pF5T1/fRY49dvkaiN+0/lVYhqx/n6yJdvmXqoMX2CmvKadr3jECwV6crcbxLUIYWpRUqwl89jmMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8GRjYq//0NzG23dOsTx8zq9q1wRwikt2KBwkuzABrY=;
 b=a+3BEA9gxi1xn8P0LXhNeWfIrbGK30ASKBWiSYR2zbaxytAuKoFL1pbuLg+xleQLyGJFiEVGOMldOHf828V0rZmsd42ark/BTXkbYy1aFv+AnwsjeW/EyVqZxfH+SjTZFX23KqH5LQwKSrr5MKkFfBOdHbZ3EAARRFU/l8A/uFJT9/MXI9MGHyetLurv7Mu6d/nLznCY7CpJLR7uF3HdqZEjAepCTMOI5CBJuTNbpwhBkzl8hds90ujfOcRmu1swt22kC5AQ5a0Fm2fuTD79290nAifNy9DLTKsmd2TkrxdwpjTy6iB2qq9gNo5UXuEJXwuFlETbPTQrlBkkQ4t/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8GRjYq//0NzG23dOsTx8zq9q1wRwikt2KBwkuzABrY=;
 b=Oi3B3QZqSz0RGFA4xBIl67zPCLBwx2rHomjc5bg5rpB6NGolChv54qvRgMRCU3IVfnaEDhc2Z8ynaTRhar+EJXAgCctdnt8+uU9mfNIzbS+SKeNMFAZ2Bvl2J2bD0G8PacWJKjGrhsumBEHoT0NaKLL8K42go4o4+r/s9mFtfDfiokLqOenmxfjdB4awUXCwvDn9hwhjddIuyRqxDqyw5HU3phhm5/gNCeujeJFGtdIAAOcG7iUVFV4cNHkAa9/IYvN/6chzwIzSxiKPpFXHWBUZOCFE3RAdTaJFL9cgUu1vn+VT7CIjKQo7OVhjqH2qlog76Zdj8HGDKAIgCPjtHA==
Received: from DS7PR03CA0330.namprd03.prod.outlook.com (2603:10b6:8:2b::22) by
 MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Wed, 25 Mar
 2026 19:01:00 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::46) by DS7PR03CA0330.outlook.office365.com
 (2603:10b6:8:2b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 19:00:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 19:00:57 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:00:31 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:00:31 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 25
 Mar 2026 12:00:26 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Wed, 25 Mar 2026 21:00:03 +0200
Subject: [PATCH rdma-next 03/10] RDMA/core: Fix use after free in
 ib_query_qp()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260325-security-bug-fixes-v1-3-c8332981ad26@nvidia.com>
References: <20260325-security-bug-fixes-v1-0-c8332981ad26@nvidia.com>
In-Reply-To: <20260325-security-bug-fixes-v1-0-c8332981ad26@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Dennis Dalessandro
	<dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Mark Bloch <markb@mellanox.com>, Steve Wise
	<larrystevenwise@gmail.com>, Mark Zhang <markzhang@nvidia.com>, "Neta
 Ostrovsky" <netao@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, "Doug
 Ledford" <dledford@redhat.com>, Matan Barak <matanb@mellanox.com>,
	<majd@mellanox.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774465211; l=4118;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=2El8cr+cyAa9RBhRtC46e0TzQiWJ1QGucPstWX5Wtd4=;
 b=t+JGnpgbSJ3u8n4OtaoroMWZ05XiB76/I/I3/EoCcyIOvMDNQ8gEsKsuMdxGOFq8S2WIzkkh9
 6UdiDrny9ofBRjp+oyHRTzofEQFrhHq1rwPxVWyojYHoMe7KjEEW+wz
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: 1536fea2-0a61-4945-e126-08de8aa0d961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	c2akQPeSQkMK6oDrQTl6KkLcAqOpJ5XHR28+ErNqPvwErQB/+E035xHxFzJiwstU//Ost48xu6weZ59SlqCI3JT3nM58+acXXcXb3RmWf5MRn2PkEfZxAAJAXoO/sJZ6xHqUmzoMwnHRIgC0CrVWRPgR7O8dPcLV6Qp3wmItcByHU5CxVCqxjl/bIhWXn1d24T4WUKi2HV6EKGc7/5ko9bcz/wWi3vD4Iw2T5iRqc1TNdPyfNktdLR6QLDvEb0gIGlF2RIao3SZKqXxLvSr5YzPI8q+3S46RglU+2GXv1t/fSSUoO80+w8/xww/N+PzxTolPGvJmEofZritf8ht1PmoP3jmV2hguSzuke13iTMHqTDmPh+2XwvYTEzB1IL3wkDhVooo/W6VgtgxaMXN1dsQkzTgNIkB3EXpnR+RjBa/kwpYKF/aKWeJICrnobVXvukfhdbmegk0oruwuUnMr9NqpqkPHy0m/42CV/P0DSxvEhQyyhYWjY0nMpCNJcuJ9HTzbupB9HV3h72nu79HwBrEWXnEF6JBTn1J0eHw9QOc1vE4kqNjTYmPWrTa08eSpQO8JGGrIheNFw6MDZDzUbA4Xj5Sr3AJn9LBROjtHxVpGMsiFaiAMsOKfpcrprFWp+MuMBWTr7Qf00WhyBSBJa9JE+KV9MGWrMwI1SwrCyRh036SIusMJMZMCDBiW1c7A9E+PqFUOQXoNeqqjvqm10sk88rd5ESiCx9k/rqdyNky8iEBGw4LiBk+wEVskW3sJ2xRbjblTB5CMw0wsKZ2nNKPwgGVZl8sl6qcHrUDlUXAq9wc/zlv7StFcAJkVpUJw
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k0VBFJ8BF1HagL0WXgcp4D4zohizFUzke0GbJSZ0MSsexPoL6H0OEXya6K4OovP+z29b8gTx5C4YrKfVl6h2Pi5jZKeMo5WXPjkwwYemuoIgTHjKDyaDztwOjsDlnfQlv8OgOGT0etFtE1DmyO9O2mLZkdF7iDBmpyNJ6aqVJZlJxn8eVkjobtwPq7Kn+XUlX1fPMhOB6FCHbapfRhWHlpsikfnKyASAPw6KBwmKvptgbrNeOe8prk7EUqPXz3qGLZzDIW00P+y4alBMc5F3pOvV2pvyZ7uLnHNSW0H7hFRiDJI9IhrZJTwNlwguEmb2jRX/ZuBtYlMhnIcqEEljrRfTRREPVW4t7zPxuMev6mjnDb0HOOsfKWUNMG8W9FEKTf0lh6M54yUmS+olF4LmJaKT1Fw3nD6vujgjGs5IqAF1xfgh1RqjZTPBXCdXmbpR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 19:00:57.8337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1536fea2-0a61-4945-e126-08de8aa0d961
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18648-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BA5BC32AFA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Patrisious Haddad <phaddad@nvidia.com>

When querying a QP via the netlink flow the only synchronization
mechanism for the said QP is rdma_restrack_get(), meanwhile during the
QP destroy path rdma_restrack_del() is called at the end of the
ib_destroy_qp_user() function which is too late, since by then the
vendor-specific resources for said QP would already be destroyed, and
until the rdma_restrack_del() is called this QP can still be accessed,
which could cause the use after free below.

Fix this by moving the rdma_restrack_del() to the start of the
ib_destroy_qp_user(), which in turn waits for all usages of the QP to be
done, then removes it from the database to prevent access to it while it
is being destroyed.

RIP: 0010:ib_query_qp+0x15/0x50 [ib_core]
Code: 48 83 05 5d 8e b9 ff 01 eb b5 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 c7 46 40 00 00 00 00 48 c7 46 78 00 00 00 00 <48> 8b 07 48 8b 80 88 01 00 00 48 85 c0 74 1a 48 83 05 54 91 b9 ff
RSP: 0018:ff11000108a8f2f0 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ff11000108a8f370 RCX: ff11000108a8f370
RDX: 0000000000000000 RSI: ff11000108a8f3d8 RDI: 0000000000000000
RBP: ff1100010de5a000 R08: 0000000000000e80 R09: 0000000000000004
R10: ff110001057a604c R11: 0000000000000000 R12: ff11000108a8f370
R13: ff110001090e8000 R14: 0000000000000000 R15: ff110001057a602c
FS:  00007f2ffd8db6c0(0000) GS:ff110008dc90b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000010b9a7004 CR4: 0000000000373eb0
Call Trace:
 <TASK>
 mlx5_ib_gsi_query_qp+0x21/0x50 [mlx5_ib]
 mlx5_ib_query_qp+0x689/0x9d0 [mlx5_ib]
 ib_query_qp+0x35/0x50 [ib_core]
 fill_res_qp_entry_query.isra.0+0x47/0x280 [ib_core]
 ? __wake_up+0x40/0x50
 ? netlink_broadcast_filtered+0x15a/0x550
 ? kobject_uevent_env+0x562/0x710
 ? ep_poll_callback+0x242/0x270
 ? __nla_put+0xc/0x20
 ? nla_put+0x28/0x40
 ? nla_put_string+0x2e/0x40 [ib_core]
 fill_res_qp_entry+0x138/0x190 [ib_core]
 res_get_common_dumpit+0x4a5/0x800 [ib_core]
 ? fill_res_qp_entry_query.isra.0+0x280/0x280 [ib_core]
 nldev_res_get_qp_dumpit+0x1e/0x30 [ib_core]
 netlink_dump+0x16f/0x450
 __netlink_dump_start+0x1ce/0x2e0
 rdma_nl_rcv_msg+0x1d3/0x330 [ib_core]
 ? nldev_res_get_qp_raw_dumpit+0x30/0x30 [ib_core]
 rdma_nl_rcv_skb.constprop.0.isra.0+0x108/0x180 [ib_core]
 rdma_nl_rcv+0x12/0x20 [ib_core]
 netlink_unicast+0x255/0x380
 ? __alloc_skb+0xfa/0x1e0
 netlink_sendmsg+0x1f3/0x420
 __sock_sendmsg+0x38/0x60
 ____sys_sendmsg+0x1e8/0x230
 ? copy_msghdr_from_user+0xea/0x170
 ___sys_sendmsg+0x7c/0xb0
 ? __futex_wait+0x95/0xf0
 ? __futex_wake_mark+0x40/0x40
 ? futex_wait+0x67/0x100
 ? futex_wake+0xac/0x1b0
 __sys_sendmsg+0x5f/0xb0
 do_syscall_64+0x55/0xb90
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: 514aee660df4 ("RDMA: Globally allocate and release QP memory")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/verbs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index bac87de9cc6735c5d25420a7fac8facdd77d5f09..f1438d5802a3e97e22cdb607cf90a097d041a162 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2157,6 +2157,8 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 	if (qp->real_qp != qp)
 		return __ib_destroy_shared_qp(qp);
 
+	rdma_restrack_del(&qp->res);
+
 	sec  = qp->qp_sec;
 	if (sec)
 		ib_destroy_qp_security_begin(sec);
@@ -2169,6 +2171,8 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 	if (ret) {
 		if (sec)
 			ib_destroy_qp_security_abort(sec);
+		rdma_restrack_new(&qp->res, RDMA_RESTRACK_QP);
+		rdma_restrack_add(&qp->res);
 		return ret;
 	}
 
@@ -2181,7 +2185,6 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 	if (sec)
 		ib_destroy_qp_security_end(sec);
 
-	rdma_restrack_del(&qp->res);
 	kfree(qp);
 	return ret;
 }

-- 
2.49.0


