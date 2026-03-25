Return-Path: <linux-rdma+bounces-18655-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG+TA/IxxGkAxQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18655-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 20:05:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B166C32AFDA
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 20:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40A6430903E4
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 19:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE57C3537C5;
	Wed, 25 Mar 2026 19:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="js5Qg++2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013071.outbound.protection.outlook.com [40.93.196.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DF831F99A;
	Wed, 25 Mar 2026 19:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465302; cv=fail; b=r+W4Z5fU/AD0mfIBlwFnjoXC8Mh37QPz5Wy4Afo2GBh4c6Wm0rnllrTBdGfXodPQgYQw0uDy8tE5bTxZ2ifDnDe44NZ14Hs8ytAW4UGQDzrdAtvmCRCsgR+fjpOYkqIzKhOoPqRFp5hcpTiU3ui19mr6awhE0iCjA+0CiuUvg3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465302; c=relaxed/simple;
	bh=qhxU3/Ta+uZ2OfL4nrki6YuegYrkoz9bdeqlr60VQC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Gx4eK+yJsej/uD5QV5LB9kNJ81KAGtHuisci+U2FuU8yYeuGjYxaUndAFnvfSXS/dACUF8iWfwI/TP/gep/5aK8UcrIRT40RdvlbNIGNABbX/cQRyyYm+IEtZy4LMXAm95Aiv5hylUYrRmr/jjfJLJhNxxUhp9vuhJmBoPY9yvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=js5Qg++2; arc=fail smtp.client-ip=40.93.196.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhmYUX6AAhknD3w1Ox5pTewkeYbCDZiN89K2X7toTB7QKEkehJQGlCm+0ieejTxUznZh1pQEoTwInMVyJQTSttbloUVaULQoF0vKijHBQojyd0Dei/nCLWD5Fjh/b9STFnF7RKvEjRQdx6nAYQHfKQEBh/2sGueZ3AuPN0FdHjZ0IUIonFYaiRlm4HN9bUICVMRk0sn7rLPRTIuYaIwixY9PYboqRILuH4a48mEssfhXVg6xi/0Pb89AxCUiZyD3X4mBkOZ73dwy65f9F4npnOI6B06mUhoYTqGcJjUqu9/nrpNr18n5VG552rKriR/AHvNojjKk4zdF9HnGnv2FQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttzs8ufS22etmK50EpgJSE4wN/iE9HfXHRXCrWy3XBQ=;
 b=KO5wTcf5UpbYgtAEaPOzIBJ+GDwRIgaKbr8i/POw+RRUX8a0hhqwbdY+ae2o8Qf3Je09pJ0cWynArJzsvqp6KggZVZPOjX7s0yH6acsYAyKhugwprtOEZGB4Bhip4HoKMU5D7UDG6/wAmgFL7VW0SoPK9gPghPRdzAwu66BV9cTZpKejcXi2K0X4JB+tzGn4BntV3+XGjvSVI3cQ6WHj9IzWPKg8NdmILiV3faEfYn+pLAMZt61ZXHRDX1OEz0hQ+pSSpe4F1Qu4C1EVy8fdsFxElpPtSWTWPzlPn4Rp6ZVRTBdgrguAbyTkJZz8Ai4l6X8ECzdggqqjXY94sr8Ydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttzs8ufS22etmK50EpgJSE4wN/iE9HfXHRXCrWy3XBQ=;
 b=js5Qg++2rk/UjSU80OcrtbVAQmgTiwPnXXoPZ/mj3reSdfxpYBZnvUcks1kg2X/l18ltFPUsr7U8OqSTvdKAxdcY34hueeNyV8O7NM4yNU84Dihpi0f6pijNzpWBe6hJVBnQel1mdqNmNgVgGqe1wNVWZtrULiFzFvijxr6gMfCYptm3lSpCWj5ivDKhzNqqwp9SPw80rzOPOZJ+e+ZtwasETpjuyLicAJ11bEjIJBVzj9ziwtv3YuUXpI3PHM859sS3IsJR1GryzukcM46dKVf1GgZXqaCtXmdOl+5X/1AcY34FcOjxVdfq5H87sQDPROD6+iTtnCkDBFBB3gtevg==
Received: from PH8PR02CA0012.namprd02.prod.outlook.com (2603:10b6:510:2d0::24)
 by DS5PPF7856D51FE.namprd12.prod.outlook.com (2603:10b6:f:fc00::654) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Wed, 25 Mar
 2026 19:01:31 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::d9) by PH8PR02CA0012.outlook.office365.com
 (2603:10b6:510:2d0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 19:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 19:01:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:01:06 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:01:06 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 25
 Mar 2026 12:01:01 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Wed, 25 Mar 2026 21:00:10 +0200
Subject: [PATCH rdma-next 10/10] RDMA/mlx5: Fix null-ptr-deref in Raw
 Packet QP creation
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260325-security-bug-fixes-v1-10-c8332981ad26@nvidia.com>
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
 Srouji" <edwards@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>,
	"Maher Sanalla" <msanalla@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774465211; l=5376;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=mXYcEoM+GTmJ2snXcoZtLt4npc49ENPVJTz16sL28kU=;
 b=ID8FbaQcaxZNqW00Npvz5lFivEhFUuufz2KE9QiJOZjDKcePJrVkYZez26q2TifuCVSDXpAUc
 UlZN3leqzWKD/URhNhBwr7LZMCQolzbYpPjwQ8tDyCKAIEH3Qs6oE/R
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DS5PPF7856D51FE:EE_
X-MS-Office365-Filtering-Correlation-Id: 102a2583-8170-4033-d93a-08de8aa0eceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	7O9Pa0qoEnxhMSHK0C1PTQypwLVY8GObagTFMq3agZpv2qxFfbV/w0XxSaetYYwLxpZ/ufzwxTU+k+gUaHBsz/MtOnsjDWOVtGxXYusjEtNMd2DuyfGghUpQeniYXIBxiQ5I12/yP3ZeUPqlm90nAKAKNRRAUttshnLAcO261v3Z9A4i5P3Bs2Wkdbf7CE/UpmgOF79B+NoOkln4s4/xN8LV3D8JmTlytkGqFx+sJkh/RGZrBicG2RdxzcJStKLi+9aQP6YQYeOePq39fAbvsye8vUu/c/NOmm8fPa0JCQXCMMFYdNXvKFjdCht/NNzYNJ/+jxzvmOev7vTDGO0Vg/HIrmmnCg956hiORsiPvnBNPUqhzvgz5kEa7wB5iNMN5230d5EiRNvfrfe0nFYUEJAKbcDfCps7vmdal4DMgh4gmlIkByynEFi4wwGTJSSfrm102mksBiMQvQThn7eXm6CAnn8A4Q4/jAbtVM/eHhGhSEx6KKjWzm9NAtOYN1m9ah84cA5pdAP+8XZJ2CJPIRZmtY5EC/zN5e2eDnVX0pubAt9Bm6LbePzbbRZAWRNVag1Li2CsJ39oTSE+8LwlRvoty5677QEP8zSkU2MHizWb0QFmSrIbaLX56y85qwBooHX8ozGqrGp3xuSuWJhxLol2TjOG8NPvTrkAKqjP/+U9c7fXXciaZCg0fcy59AUv+tK1btRfUzxZwAyBMr6qe48nwTHoV5vNxbypVetN7fIX+ALWxgn4Ia9Ck/iWMavcJNwfemxSPoVxakISGT5un3VWuq5LObWUhUhXjz40ovnmSAVdQXze3wW8YuM5oBDv
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U/qqlHmXjIXDw8BVeDogd3NdJcv7W7wE3yedCTj0LUZtl1sCy5ERFv/3W2YD1MCiGVHf3ptBNkLrqAMd++fkHwBZ4dvCAUPc61c4JEF6BzBM7q+4ABHxK24DVcNsYAqUz5uuWVdhl/zWuW6viAmrFVYZjbqq4j7VfG/qRraD6bTyP01z5HJD3LzVHSyiQbWlOO54B/H/FfZRK43hCXXU/loZkTTQpubqKcpMnQLXVZA2pWU83c5uRY+qsYtv/GfMCjxB4HYPcJru+2xmRdEbkboplyyWZUxVU1iYhfuhq3f52X658TcYMiu8OTuhgKx3jNpZqPun8u4xd2jOmUnJtRzA8nsfNk58ArhwaElzx1LeqthdO8NUo3ebgQ1O6S6NdgksNTxEgRTEidnjZzNxd+BGNPQD5TCKIZ4UecZYVSXYWTImx0qn239nJJ+DXTfI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 19:01:30.6156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 102a2583-8170-4033-d93a-08de8aa0eceb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7856D51FE
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18655-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B166C32AFDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michael Guralnik <michaelgur@nvidia.com>

Raw Packet QPs are unique in that they support separate send and receive
queues, using 2 different user-provided buffers.
They can also be created with one of the queues having size 0, allowing
a send-only or receive-only QP.

The Raw Packet RQ umem is created in the common user QP creation path,
which allows zero-length queues. Add a later validation of the RQ umem
in Raw Packet QP creation path when an RQ was requested.

This prevents possible null-ptr dereference crashes, as seen in the
below trace:

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] SMP KASAN
  KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
  CPU: 6 UID: 0 PID: 3539 Comm: raw_packet_umem Not tainted 6.19.0-rc1+ #166 NONE
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
  RIP: 0010:__mlx5_umem_find_best_quantized_pgoff+0x37/0x280 [mlx5_ib]
  Code: ff df 41 57 49 89 ff 41 56 41 55 41 89 d5 41 54 4d 89 cc 4c 8d 4f 30 55 4c 89 ca 48 89 f5 53 48 c1 ea 03 48 89 cb 48 83 ec 18 <80> 3c 02 00 44 89 04 24 0f 85 01 02 00 00 48 ba 00 00 00 00 00 fc
  RSP: 0018:ff1100013966f4e0 EFLAGS: 00010282
  RAX: dffffc0000000000 RBX: 00000000ffffffc0 RCX: 00000000ffffffc0
  RDX: 0000000000000006 RSI: 00000ffffffff000 RDI: 0000000000000000
  RBP: 00000ffffffff000 R08: 0000000000000040 R09: 0000000000000030
  R10: 0000000000000000 R11: 0000000000000000 R12: ff1100013966f648
  R13: 0000000000000005 R14: ff1100013966f980 R15: 0000000000000000
  FS:  00007fae6c82f740(0000) GS:ff11000898ba1000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000200000000000 CR3: 000000010f96c005 CR4: 0000000000373eb0
  Call Trace:
   <TASK>
   create_qp+0x747d/0xc740 [mlx5_ib]
   ? is_module_address+0x18/0x110
   ? _create_user_qp.constprop.0+0x18e0/0x18e0 [mlx5_ib]
   ? __module_address+0x49/0x210
   ? is_module_address+0x68/0x110
   ? static_obj+0x67/0x90
   ? lockdep_init_map_type+0x58/0x200
   mlx5_ib_create_qp+0xc85/0x2620 [mlx5_ib]
   ? find_held_lock+0x2b/0x80
   ? create_qp+0xc740/0xc740 [mlx5_ib]
   ? lock_release+0xcb/0x260
   ? lockdep_init_map_type+0x58/0x200
   ? __init_swait_queue_head+0xcb/0x150
   create_qp.part.0+0x558/0x7c0 [ib_core]
   ib_create_qp_user+0xa0/0x4f0 [ib_core]
   ? rdma_lookup_get_uobject+0x1e4/0x400 [ib_uverbs]
   create_qp+0xe4f/0x1d10 [ib_uverbs]
   ? ib_uverbs_rereg_mr+0xd40/0xd40 [ib_uverbs]
   ? ib_uverbs_cq_event_handler+0x120/0x120 [ib_uverbs]
   ? __might_fault+0x81/0x100
   ? lock_release+0xcb/0x260
   ? _copy_from_user+0x3e/0x90
   ib_uverbs_create_qp+0x10a/0x150 [ib_uverbs]
   ? ib_uverbs_ex_create_qp+0xe0/0xe0 [ib_uverbs]
   ? __might_fault+0x81/0x100
   ? lock_release+0xcb/0x260
   ib_uverbs_write+0x7e5/0xc90 [ib_uverbs]
   ? uverbs_devnode+0xc0/0xc0 [ib_uverbs]
   ? lock_acquire+0xfa/0x2b0
   ? find_held_lock+0x2b/0x80
   ? finish_task_switch.isra.0+0x189/0x6c0
   vfs_write+0x1c0/0xf70
   ? lockdep_hardirqs_on_prepare+0xde/0x170
   ? kernel_write+0x5a0/0x5a0
   ? __switch_to+0x527/0xe60
   ? __schedule+0x10a3/0x3950
   ? io_schedule_timeout+0x110/0x110
   ksys_write+0x170/0x1c0
   ? __x64_sys_read+0xb0/0xb0
   ? trace_hardirqs_off.part.0+0x4e/0xe0
   do_syscall_64+0x70/0x1360
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x7fae6ca3118d
  Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5b cc 0c 00 f7 d8 64 89 01 48
  RSP: 002b:00007ffe678ca308 EFLAGS: 00000213 ORIG_RAX: 0000000000000001
  RAX: ffffffffffffffda RBX: 00007ffe678ca448 RCX: 00007fae6ca3118d
  RDX: 0000000000000070 RSI: 0000200000000280 RDI: 0000000000000003
  RBP: 00007ffe678ca320 R08: 00000000ffffffff R09: 00007fae6c8ec5b8
  R10: 0000000000000064 R11: 0000000000000213 R12: 0000000000000001
  R13: 0000000000000000 R14: 00007fae6cb71000 R15: 0000000000404df0
   </TASK>
  Modules linked in: mlx5_ib mlx5_fwctl mlx5_core bonding ip6_gre ip6_tunnel tunnel6 ip_gre gre rdma_ucm ib_uverbs rdma_cm iw_cm ib_ipoib ib_cm ib_umad ib_core rpcsec_gss_krb5 auth_rpcgss oid_registry overlay nfnetlink zram zsmalloc fuse scsi_transport_iscsi [last unloaded: mlx5_core]
  ---[ end trace 0000000000000000 ]---
  RIP: 0010:__mlx5_umem_find_best_quantized_pgoff+0x37/0x280 [mlx5_ib]

Fixes: 0fb2ed66a14c ("IB/mlx5: Add create and destroy functionality for Raw Packet QP")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index c54e7655763844b10943e12a70431da291c58b8a..0663e1ca5465630ac25af646cddfb639ade18c04 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1603,6 +1603,11 @@ static int create_raw_packet_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	}
 
 	if (qp->rq.wqe_cnt) {
+		if (!rq->base.ubuffer.umem) {
+			err = -EINVAL;
+			goto err_destroy_sq;
+		}
+
 		rq->base.container_mibqp = qp;
 
 		if (qp->flags & IB_QP_CREATE_CVLAN_STRIPPING)

-- 
2.49.0


