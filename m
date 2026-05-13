Return-Path: <linux-rdma+bounces-20554-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCzrMbUeBGpyEAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20554-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 08:48:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7028B52E3B7
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 08:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C2B43055DD5
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 06:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6B13D413C;
	Wed, 13 May 2026 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wg1/LIeB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB5368D63;
	Wed, 13 May 2026 06:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778654897; cv=fail; b=fc+YGIFv/SdMZ7KQAnCe8b/JtFIHxs3A25hTxbfed+lDVTx+9scUpmhXP0juu3foV3Pfkj6h3fR6V9JZ3vxRsIfVqb2xyrsUdCdbBdnTdmklz4Nt20Kv1f1b6XsL05lm5wLPjsusW03fSkTVg8Ag2YkNMswHK7DmrYFe6zePMgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778654897; c=relaxed/simple;
	bh=bHS3OqUR5aQd/YoE1EeKGpyuxb4/8NNGjs7tuAhPRbo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TYnRH4HzV6BKkEGF+H5ei22jI+tC3Y/n+RgtcrCLXrMzj0ZOmgbHw7+K4vJxIdIb3A2g6A7wkCFKRr6f7iOyCQm2S5289hKP1oObGY/qxrAiSj4BVrxiij7aaeYpXdzKqDp3AbioDKIpTDqh61o3GbzhVPlX7kxBZfcZa0DIxzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wg1/LIeB; arc=fail smtp.client-ip=52.101.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqX95b+D9MjFWTlmLL+hmOXIC4VZXwV+q5mNuIogFUq0OIk26TVRRCVYxU0jEAbAzsTUCvdOwigjGUu9/wUo86jWbiyWdQ3g8mQqlG86zRgmARa9DjfxT3CFSRIrldZT4QFkKHW/aB3T19fA1sbDd083l549CyJbY2PMviPPD5ehdE2ecMllimkB2XZlcn+4vAVDJQzXoDDtWxsSdp64PFTSZ4+cechasGss9WJxkkiKpCXRS2newpoMw3XwBUSanqdAvtPX0bxkrTr2r1/GBg0jB+m0gTmyc0UicxKlkWC2fc+pETCbLd36grQL/VlcQWQ7GCJubPPrvUjaOiXuLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9kICXR+4L06GUqoHsa3/h1+fMkmxAl06h60LzeO7rI=;
 b=Sj46ruj5dhcCpVR4S/6mRhFuv+NAMvVLhiWxw0+q4o3VQGuuwdZG4tVn7eUbhBDOPjPcZhBAoRLe1b54HMXJBfm/30slFUa46q805/8dry4hAHXMFaLE0JpbPXAQUxW2Bp860T73ahZbyW+VQ2FWVrLQDNJ758tB9yzQsFwELK1mC7gF9j8SoT/GxfNvab+mnsb/uWCy+ZMoo2k2kv8a9bjZ1jto+dLGN2e+v8jRkh7FBeDzRzskMpnN59166skJDa7l7Exh2wwvck/QQCtTep75YgBb1JogyHO98JzPKWUJd1RTmAsmFU1v6zJlXOJ9SBGyz9H8dLeCwBtDLwNpkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9kICXR+4L06GUqoHsa3/h1+fMkmxAl06h60LzeO7rI=;
 b=Wg1/LIeB48Uc9vB1auOanY8n+IV19fn3LO7b8y861sMRDjPKuSM/tr5V91Pa5KeMM1gd2ckGAOPYe89SQSCggsewFNNhY45uiX2GvB8oHCVXuFOsQEXr2y6XAP49T86LSau8Oa9uhnS0X829wdxyLeqUoZB8Rb8Yrr5n2fzaAX2fy2Mj5gvLfgcnInZG/TB7rNYynD4zJsMHXmq9kteg+Tr7HWaC3Wp5IahO3C/UG4JFRnTzqLAqpH/UhB3zyMAJsooywyjSTpouN2WPOKVS5tpthYZP3t9HUj0cBnzAVPWWEdF1j0nK2OmB8UA2arnbPmMR7eq/iK0aDVmzoCLKVw==
Received: from CH2PR14CA0060.namprd14.prod.outlook.com (2603:10b6:610:56::40)
 by CY8PR12MB8216.namprd12.prod.outlook.com (2603:10b6:930:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 06:48:08 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::d) by CH2PR14CA0060.outlook.office365.com
 (2603:10b6:610:56::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 06:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 06:48:08 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 12 May
 2026 23:47:53 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 12 May
 2026 23:47:52 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 12
 May 2026 23:47:47 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@mellanox.com>, Maxim Mikityanskiy <maxtram95@gmail.com>,
	"Daniel Borkmann" <daniel@iogearbox.net>, Saeed Mahameed
	<saeedm@mellanox.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Paul Saab <ps@meta.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Paul Saab <ps@mu.org>
Subject: [PATCH net] net/mlx5e: xsk: Fix unlocked writing to ICOSQ
Date: Wed, 13 May 2026 09:46:13 +0300
Message-ID: <20260513064613.334602-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|CY8PR12MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c4688cd-d40e-44ba-d708-08deb0bb97fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|82310400026|1800799024|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	CmtALKgIIqOm71srrb2XjzSGtAnOC54y+NwettLwvzhy1DqL2ai2Vs+VIQFXMRD7LuWJh13cw8gJ7K2iRNfQ8CaMHvfeLXM3LTjhS1kxhl4BUofOcoGsoyZja8uYGmH60CmokzT0rbec0kyhaV4f9sTZShn38YVRLCqdV/90B+qAM2QieGc6AZnmxirMwiFxq8Yx2BIW35HUuMo0rPZkcv1tfmu3Rh/OqAx8b82kKGSI0SvNPKEy2nGIVNs/SuQ9/wJj4zpN3UB7U8YluKd9yfeEN58ti3aNop/AFbLaoWB6q8P7VSChH49WLBJqYNxK57vH4igKpea4MUiqXaSfbEEIguUs28R7lDU+4aJJkHSyg8rYR4BbEm0S4popcbSZ+aiz0KDWXedNo3Jo9PPsubk7/S9xBBFMvcc0mADNyRSOCF1Eyoq6l5evTtG5hQeD1+YtzK+qINxi+SkQwLgj/q5UtQkmfLkhRompqDRdbPsNYE/lPDeQdNQ5plNPcgnFLDt0JsWo8L/KnejTgc1CqMxooVFfotpgCZDsHPsnuSke8fe9BbV6fQQLr6wC3v38+fSwEkeivwu9RZZpmP2U5obbtKm8SbcxqOC6tJbAB4ZoF1wDvms6/pnnyFkyUF+J1z/2mv/GzZwA1eQsiMM5ozp68+DuopMTdB+G99VifS+KlieCjpLL6LwvIyUtRG0xeKIgdoy4pIGzO56n958JEMcTeO89vO1NoMJAnDOT3zs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NYT/oxrIbx5tixt8zuVFUygAwmDbzt+YYIXlj8j4rw2hjYZFg+bkRvxkeMKeN0gR3Q8Ed7HXquaRQnio34G9al5qsDMqRThxMhUwOHnle8nYm0JkJuWzo9uLKq3bRv9qTcXcxJAcLN1z0k3GdC/I62dpuiNU7goFBGLSrqHOrI5TDG1Vq/OEZ1d/VH3sF7+MawRjLGkHv0PP/OY+aYtlJVMxQe1gzcxVWBSQuSMsG1d9fFg7p+OzL7Th6Tt2yeGy12CTqtgWkMF1Rxh20Rp7ybjMr8i5RwxdHF0S8f+H6DVbgdpct5M8IAqy/T4EvYu9aQDNs5vNr9qDCX/sO9Q2fe5hL/8Z62KZanyhPuIhMJdbVACkSmYRelb0c7ZwMBTiAwLQZ58VfZsBwUF705yQrSsxVNU3Loodr6C2PgBCmT631tJGr6mBuf6oOvewUM4I
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 06:48:08.6678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4688cd-d40e-44ba-d708-08deb0bb97fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8216
X-Rspamd-Queue-Id: 7028B52E3B7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,mellanox.com,gmail.com,iogearbox.net,vger.kernel.org,meta.com,mu.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20554-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Dragos Tatulea <dtatulea@nvidia.com>

During napi poll, when the affinity changes and there's still XSK work
to be done, we trigger an ICOSQ interrupt on the new CPU. However, this
triggering on the ICOSQ is done unprotected.

There are 2 such races:

A) mlx5e_trigger_irq() is called while mlx5e_xsk_alloc_rx_mpwqe() is
running from a different CPU due to affinity change. This can happen
because IRQ triggering is done after napi_complete_done(). At this point
the NAPI can be scheduled on a different CPU. Like this:

  CPU A (old affinity, NAPI tail)    CPU B (new affinity, fresh NAPI)
  -------------------------------    --------------------------------
  napi_complete_done()  clears SCHED
  mlx5e_cq_arm(...)
                                     napi_schedule_prep() sets SCHED
                                     mlx5e_napi_poll()
                                       mlx5e_xsk_alloc_rx_mpwqe()
                                         mlx5e_icosq_sync_lock() // noop
                                         memcpy 640 B UMR body
                                         advance sq->pc by 10
  mlx5e_trigger_irq(&c->icosq)
    wqe_info[pi] = {NOP, 1}
    mlx5e_post_nop() advances sq->pc

B) mlx5e_trigger_irq() is called on the ICOSQ when
mlx5e_trigger_napi_icosq() is running.

The obvious fix would be to lock the ICOSQ. But ICOSQ has an optimized
locking scheme that doesn't work for this scenario. Kick the async ICOSQ
instead which is always locked.

This issue was noticed in the wild with the following splat:

  netdevice: ge-0-0-1: Bad OP in ICOSQ CQE: 0xd
  WARNING: drivers/net/ethernet/mellanox/mlx5/core/en_rx.c:826 [...]
  [...]
  Call Trace:
   <IRQ>
   mlx5e_napi_poll+0x11d/0x7f0 [mlx5_core]
   __napi_poll+0x30/0x200
   ? skb_defer_free_flush+0x9c/0xc0
   net_rx_action+0x2fe/0x3f0
   handle_softirqs+0xd8/0x340
   __irq_exit_rcu+0xbc/0xe0
   common_interrupt+0x85/0xa0
   </IRQ>
   <TASK>
   asm_common_interrupt+0x26/0x40
  [...]
  ---[ end trace 0000000000000000 ]---
  mlx5_core 0000:08:00.0 ge-0-0-1: Error cqe on cqn 0x548, ci 0x2022, qn 0x8f4,
  opcode 0xd, syndrome 0x2, vendor syndrome 0x68
  00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00000030: 00 00 00 00 01 00 68 02 01 00 08 f4 de 14 59 d2
  WQE DUMP: WQ size 16384 WQ cur size 0, WQE index 0x1e14, len: 64
  00000000: 00 00 00 01 d9 ed 80 02 00 00 00 01 d9 ed 90 02
  00000010: 00 00 00 01 d9 ed a0 02 00 00 00 01 d9 ed b0 02
  00000020: 00 00 00 01 d9 ed c0 02 00 00 00 01 d9 ed d0 02
  00000030: 00 00 00 01 d9 ed e0 02 00 00 00 01 d9 ed f0 02
  mlx5_core 0000:08:00.0 ge-0-0-1: Error cqe on cqn 0x548, ci 0x2023, qn 0x8f4,
  opcode 0xd, syndrome 0x5, vendor syndrome 0xf9
  00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00000030: 00 00 00 00 01 00 f9 05 01 00 08 f4 de 15 cf d2

Fixes: db05815b36cb ("net/mlx5e: Add XSK zero-copy support")
Reported-by: Paul Saab <ps@mu.org>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index b31f689fe271..e90c6c6df835 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -252,7 +252,7 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 		mlx5e_cq_arm(&c->xdpsq->cq);
 
 	if (unlikely(aff_change && busy_xsk)) {
-		mlx5e_trigger_irq(&c->icosq);
+		mlx5e_trigger_napi_async_icosq(c);
 		ch_stats->force_irq++;
 	}
 

base-commit: f5b2772d14884f4be9e718644f1203d4d0e6f0d6
-- 
2.44.0


