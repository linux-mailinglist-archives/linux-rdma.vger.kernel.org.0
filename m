Return-Path: <linux-rdma+bounces-19581-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN3fFplD72kx/gAAu9opvQ
	(envelope-from <linux-rdma+bounces-19581-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 13:08:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 977E94717E5
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 13:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 063C0302C6C0
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 11:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D36039FCBF;
	Mon, 27 Apr 2026 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Aq860lTM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B4539B946;
	Mon, 27 Apr 2026 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287822; cv=fail; b=aDRsCCVIFwsQ48AwfzEWoBD8CwznVIXBlpyr5K8U7Cao8u44EVihoRBhyxxdWnPNqRxaD5XIdRg+nw+24mrnA5Keql/qpFbxbEtlnYOvIrbMlbPxMlTGEWyL+8p89eI5Zv6WrE7tbBOBa0Fi+VPXyy+CPh60BKrQEZJHrp6scpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287822; c=relaxed/simple;
	bh=JSt2D6BkbHVyUIkrKwyd4D93NeyLBJNidZco93owStc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gRpBzlaT6FYk/0pL+uimcXAlQTq21o3dmc8GLk7dO7ALqDfj7EL6YcxQrjF7S/wDsl6wrngI9lK6uom9LZiZ/8aEQXDk736lDZmESCwTYSyrg8vx209Kpb6Fi08BB8ocLc30vgp2fUF+RGKrs+sA76/e/yzGBR4XyGI6KhtUb/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Aq860lTM; arc=fail smtp.client-ip=40.93.198.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBSoMLmmNlzrrMDQ18AHyZbF9Cfjmysie/cUSvyYYwYuECOnDMiJuGKFZe9j04lhStkJPAl863FrojFA0j+jkaEGlYm1boLp21uWP6wQHRduwD7ESbN591t9aQO6qRmPx5KynnIOxOis5LQEudwYSVPuUTLQe6XRqKDy82acsRHgT2BFHTjOB1gMrfsY2lgaqPk1COCSqou/6GT0VH85sLBX/iDYTdmRzm+dp8tJ+8zlBH4HUm2OQGAOKdWw5h9DGeUXvzoBg2+Mk9nCHW9ucuS+nEy3+n9RmyFmcdyrFxOSA7mmTJhyViZqIBlBYGWNjsSIOy4pku5KVMgugy5EcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+hX2rITV3WABuor/7B8LhrisF1Slldl6ms7NqJFzsM=;
 b=QRCmHdVmO8vIzF2YF5PYx4ehb8VvU2vr+dPvX7tk/z3xkVdmcUirigvcJY59MfNAVP4eTBAwFPR4YHin90LkbYpTqGrcBw+SlkI1N0gU34fdHmcSQYDlO3ydBjFcH0MbSmN0ly+oJRSYoGcVwQaGd9B1GhXTQ7jRZIXFLFqwRJX96dNjI5I/5FpOEmW8Ygfjvnr8PFEJOKfCmvxQ3bDx/D2DYVLgYXJdVk1T+WHjF3dFrl0XqgWCVz19pjJPwyX2Z1ZD+8leL6OhnkheM/c3vSrX5n3I1/7OAjadhGLGNB8JzblQjAuX+BRlN44tRII6LrnCvao90HZyp61RqEmHRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+hX2rITV3WABuor/7B8LhrisF1Slldl6ms7NqJFzsM=;
 b=Aq860lTMIE74TeVQx52P28wr0MmnpXVBbNZOXDg4CRWWe5jxD1KhtA5rK+RlKvZutycP3E/GkpFPQI22ivAN7XA/teML5XGBjbog9JVGWwfaqnFUoLss1FdiM/0clgol78hZz2oWlBD76VA64f7ISjxnBwDvd8YnIVJAocfPratzQ5EZLmzQ8FUIwh7xGsI9lrb1B63g8lvTLcwTu+8YbTxkIh04g2sjAnZnauLe8KC/zhvLIbUr46AMBv8BO9Ip/fZUn9ZXFrRjsyIIKsjUlX2Et6K1nY3U7GYiPjorfmT0z26Qz36seuO0Vs8OHUFdwOOxVUJ6/bL4jIAIOKaG/g==
Received: from BYAPR02CA0032.namprd02.prod.outlook.com (2603:10b6:a02:ee::45)
 by SJ5PPFDF5E260D0.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Mon, 27 Apr
 2026 11:03:34 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::b7) by BYAPR02CA0032.outlook.office365.com
 (2603:10b6:a02:ee::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 11:03:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 11:03:33 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 04:03:16 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 04:03:15 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Apr 2026 04:03:10 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 27 Apr 2026 14:02:36 +0300
Subject: [PATCH rdma-next v3 5/5] RDMA/mlx5: Fix null-ptr-deref in Raw
 Packet QP creation
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260427-security-bug-fixes-v3-5-4621fa52de0e@nvidia.com>
References: <20260427-security-bug-fixes-v3-0-4621fa52de0e@nvidia.com>
In-Reply-To: <20260427-security-bug-fixes-v3-0-4621fa52de0e@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Dennis Dalessandro
	<dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Mark Bloch <markb@mellanox.com>, Steve Wise
	<larrystevenwise@gmail.com>, Mark Zhang <markzhang@nvidia.com>, "Neta
 Ostrovsky" <netao@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, "Doug
 Ledford" <dledford@redhat.com>, Matan Barak <matanb@mellanox.com>,
	<majd@mellanox.com>, Maor Gottlieb <maorg@mellanox.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>,
	"Maher Sanalla" <msanalla@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777287764; l=5376;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=h2517xFaD4h5RCJGmHRR+frjDveXS7FYvQ1dO6AnUfQ=;
 b=L1Au7eGw2GArI9wit43aX0ROKvL7wdH5BWHcJJqedhNTSvzvE6xpQqHEd2fRdm8zyvKo6Fl4m
 CfNZOye4S1rCYpU1ww8ldzwdd6Lft81wr+o5MTeS8OcK9XejDDbTBGC
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|SJ5PPFDF5E260D0:EE_
X-MS-Office365-Filtering-Correlation-Id: aac30028-37b0-4e12-838a-08dea44c9fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oA+9wm+OLKqIrApx1UpUsUH2skIfnPNySLQSUBa8/W6r9k6qdLewSzEKLISxDwRitg27RURG6s0jEk36PVR5qAou6IJylVrcFGY37u8bAsOAIypJWHqgIU9SICJfvRZPiNJcS0qD5aPk+dh0VQtKmPdB08ily3/m7F2XAXm6xxOCwME+uZQUXwTIpr86YBtZ2fhEOkIMEhgn678EQmfOX+Np0UC2akJOGnRGQaXmRO6YIKovUVMByA4q+txoiipMUs0FasOvE6kmmw9qg2KjcxGfJPVrzgnCOBnT4mtT9YV8YfP7CWQDl7CGKHnAsSs58OZzUVDJtR7dBXY7KCdjL2ZgGUy/oaAh5oGpamQ9aB+fynEseXhOv0NRkdujDNrQDbPYugPvhfiZ7w+Euo27EXwgQrTZgXFSEglftG2hx7vdkFqpWIzlOjgSaRipa5QohRil6H/2T26JLPbadI2Pb/YpsGL2KXyXI9aTCibXuZ4jppqYqwDEeHSoQ9oCHO2g/xF9Y4JaxxZMday4NwZx+lrpd7bS5FpD+ErokAehaSBauOuEfGuPvIDu+rUc0A12TDIIyyprU+7w3eFiik8Lxmn4/V9HTEmHbxEQpvFSfaemM++Fhxq03r7NyjEQkhucDrKKTfPtXQo9+d7CoMaKbK2hhi85syC0WxWmA7ouS4Pjp0KHg56nF8u2l0JG2YhdwHyx+RglAvg83mBI/9m6IRG8WvVsGsFEFOfa94OXAsu/WiPPzQj/h7jPJQU7CSIB9tfd+IBoqOfMeGvOGOL176xsGFWIHqqoXcQIe0dSiEXsKoiky54mVcjjjH9DV3pl
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4EeFvqH2ngPe+8733tcxdxhrJ9Ww1bel++/TB6Cfk2UV79Bz+PYZT3XEnIsV4Um2LQU+gteB31mb+TcaQpY2RFmzbhWkiJSiZgklxIG7iJB42QinF4WWUKYiuXh9Tr1ZVP42VCPcv8Y/KRXa7uaHTV7dVq+WK3ut8Umk0IwmAHVhhwAgvQFbQKUzlbeZAsHEF2DeHPwOZSiXtqyzljwRT3o+Wv9UUisyc4cKtVrvwl9WIM2VUP9pDzFiZ0vqpHnfRYaPSmUcFHmGyHOa+dguqXaxRTw2WNTDZUjLG5hK+JyUJyIE6xcZPhvUPyfLy70AHsew/8UT3QUKqJMPDgFTXc+6+W9uwCkWhGTXT9x0XOFmBmfrUktYUqc4ws11Nh9Mic8wXWwtKr9khVbutx7zGNJSVinA0lFumihJ+5qI1b6fYde2mlT1BHmyS4l1kyGT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 11:03:33.4975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aac30028-37b0-4e12-838a-08dea44c9fa4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDF5E260D0
X-Rspamd-Queue-Id: 977E94717E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-19581-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,qemu.org:url,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

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
index 8f50e7342a76949f7caf24f9ea32243ea60e2b83..1611a704c1b33231063f5ff0f155ce7d5148e508 100644
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


