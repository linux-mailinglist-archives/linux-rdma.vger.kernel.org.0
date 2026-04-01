Return-Path: <linux-rdma+bounces-18893-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FSfDtXzzGl9YQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18893-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 12:30:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D96FB37885C
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 12:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1208E3085D8E
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 10:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FA13E9281;
	Wed,  1 Apr 2026 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s9khTJU7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFF033F598;
	Wed,  1 Apr 2026 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039129; cv=fail; b=o4q0B2xDXDIPsiCcaiYMnslTV5yEm/zuMQXUnclqyZNMdEqPdklmjP8dAjF3dRFdXZ5GgH9IKc+pZ4HA3a6uAf9urT+yJrmD7UsRJCCUk4NRWbQdcokpCqQ/5AYHKvXNbh57iBvO30gogg4FjOAepg1Id8yNLBKrtq5Jgwqru54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039129; c=relaxed/simple;
	bh=CAtwkHAaD65+J9UADmGD8wsh+Caw1aihIyxPaNQ6ZwE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ocV7HbdSJECvjMENYdavMUDd38A8ZanGl86WvjPJG8DnkaQUuwaafnRv1BLORQ/y/swAofjw89kf9m+0kvbDFdJGJmWTSavdgAzCZ/7lyP47Dw4n8kD6MpQjhx00a3hNXKIuV8iWGmvhJEZ0L79OOw21A0FhOKoT8ZqEoeAzWQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s9khTJU7; arc=fail smtp.client-ip=40.107.209.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZhS569iVMtfHLZVZgRHlSdrPhzUz57Ly3ci2uznzUiwqTLsAsJmmPs07pc/0KJGOn+GkJbH1CZT+7NK8pUyHPXdyL4l95L9Gr6Yf7frBcW8VEGKnit4Xb9BG16xvgnCqh9CR8J4ZSJreJBXob/Hk2wBZz1UWp+rlIfZgRwV83y+HIcYy3uOGFVYSMFmy5+XdLdyE+qI7xJz84jaboTkjGqlx7YtBraFLgrIhhtt+wIXPti8Gmz9hjYU7xfkjczyeJ9acN8V1VrgDZmgVbFOwacz3Owx7nALVCCxIzzWumQm4E1SW8d3oDHO2/JN7RlY7ChXlttPWMXFOLLbJKCvhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3bd1FNZTurmtMWH1+gVwzxUumBGnR7Hm4+TGRYODkg=;
 b=JAiuYdTcehuxNR56N3gamK+tga0Yps7KxkNiWXWIDAbq9+aBl5d7Wac2LgnKsecZdiVOXh9EnCnQxzTG/olhc7np85RMStLDQ4vd1vy1b3W/vQhFCRxYPeLfQN+8Nt44Uz+TY3cWtJEu9JlJcrdWOEMEXXR3G+h2JCQ8ZSF1O384P/6zAMumZb2vRkyW5TYsAjX1D9RA92yPlk0D197vnpeZi6xRSpKknnH9rQJdcRqoYZb7QQEAV3afOWz5UOF8kHlreCPXOLpzgCrVqONGJNwTP7DotOwdznhQ8KNYDonHGjOA/x4uSyHIi1GOAMPjU4jNBPpUHWLrK+R1P7OUTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3bd1FNZTurmtMWH1+gVwzxUumBGnR7Hm4+TGRYODkg=;
 b=s9khTJU7gBwOho8oFNFUQWfyZ2wFI/kmArqLUFeS+qlPpICirsmi92hieGepX/3yS+M+wXFhSqSqxGq967/p9NaoJNuT69qat/VNkh5tbBY4V2nAti8EBHyL6DjWBMjxgVnbMwjzla5KHC+3x3Sf4f6XuZLG5ortOusj3r17Xsg=
Received: from DS7P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::13) by
 BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 10:25:24 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:8:1ca:cafe::5a) by DS7P220CA0009.outlook.office365.com
 (2603:10b6:8:1ca::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.31 via Frontend Transport; Wed,
 1 Apr 2026 10:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 10:25:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 05:25:23 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 05:25:23 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 1 Apr 2026 05:25:20 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH 0/4] ionic: RDMA completion timestamping support
Date: Wed, 1 Apr 2026 15:54:57 +0530
Message-ID: <20260401102501.3395305-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|BY5PR12MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db51289-9084-4017-2b22-08de8fd8fc2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	kbw6vZ6Ck9XAHyWPsxnt9gidYNzEE9zzAlpgV+YTJ2dqCZMPFPTZN3IMbXYdBA2J4z/29/8VOVkxwNimzMNbTYAhDux1qw6jNuYP7QQ2FMbDpTzFr0xRxUr4whG6yGPoGCL2Bza4er7YMNvaFFpXZKsxivfy4F79JT9aW+A61ZEXmelMUZ6i/zIrDcaNDpewYs5tht7ZhRUW3D0wYILrpFeUPwo3nwQYvOlXjWI8F1Hh5OEV15rZUxqg9gutPtw3+qn2Egb2gbiXacFUqmIFTLcwkIT3ynXkObynj5n6enJke3SFfNwbCISjnswUcSGmWg25Uu6azj/NOI0fSZeiKhq1NW1QKy3LtUZXmr3cNkY2KTjWLqzXd8tvCNira74OT9O1YQM9XNnli6OSn7HR0X1EZQ5IJelv+hzc1vXBHd6suyx/gMDywGL4pfjpL7Pmu44feqqC3EO2zblOAFLizKJd5xjHYnp/QvzphGB4qVyIBySColrBhc4mHICO4TDeDcEmLU/BGU61zAAXt8Qc2XLXWydOE/KCYBu+TROMKvHV5UJz3hGfmPdFk3AXDe9w2CcDyPs830JLH6lucpctAVS45/C4MT8wjQmc8mPqnfpfRQxJu2dPx2f8RCDqOy5Bss6OYbL7nFOzdya61WCCI4Kvmjb9wJqGj8UeaMa5/KyfX1avawbumTdsMOsGrdmI8NgLkU8Be2Svd4pKFDYUFl7P1CE77u9lCOYqIGXca/A7ex4jccuwbI1IpAzzNomCAd6/w1hjt39qrp1n+9wbpg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	V1M8jCeHCXrwquBy6yxAfHpJpKCfcv3e6zMjWPszl+RHkfKedHWWTy3gVAYn7nK3dtA76ROdmuoRaGrdOGDjEqFnkapHLdAMG1ceMriWC3JzEERVnLQaTAJDy6XuoWlvewqrcda2Ee5Vhd0j2dXGzvfBNkvzKC4GxbFH3ckw3sZlYO2rpUj4rO1HRgxZW90pwrQbSQSrJVaDLkVVU4yFC+Q1oBCEr6luABnlpWzZBE5emhJ3pNOMp27ualr3WWDxG0KseKwPUkKTdPaHSki4IYJWzfgvYa3WPrsAhUAfeMewIkRhay1u5eMiuWGS4tlHZdDBUpMYrj2ttWie5zQEeNqiCaothW/cpDGckE+lBfpS1QiQoAioVq1ckWWRIzgEw+20IuCzKJMOqVWh9a28IDlVAgCq+RXHYoZ6lkDjZtLXWCv+2RzNLnYsYXk698a/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:25:23.9044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db51289-9084-4017-2b22-08de8fd8fc2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18893-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D96FB37885C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series adds RDMA completion timestamp support for ionic.

It enables PHC registration for RDMA timestamp capability, exposes a PHC
state page for safe user-space reads, maps that PHC state through RDMA
ucontext mmap, and extends the RDMA CQE format to carry completion
timestamps.

With this, user space can read completion timestamps and convert them to
wall time with low overhead.

Patches:
    net: ionic: register PHC for rdma timestamping
    net: ionic: Add PHC state page for user space access
    RDMA/ionic: map PHC state into user space
    RDMA/ionic: add completion timestamp to CQE format

Provider's PR: https://github.com/linux-rdma/rdma-core/pull/1724

Abhijit Gangurde (4):
  net: ionic: register PHC for rdma timestamping
  net: ionic: Add PHC state page for user space access
  RDMA/ionic: map PHC state into user space
  RDMA/ionic: add completion timestamp to CQE format

 .../infiniband/hw/ionic/ionic_controlpath.c   | 36 ++++++++++-
 drivers/infiniband/hw/ionic/ionic_datapath.c  | 43 ++++++-------
 drivers/infiniband/hw/ionic/ionic_fw.h        | 12 +++-
 drivers/infiniband/hw/ionic/ionic_ibdev.h     |  2 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c   |  2 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h   |  1 +
 .../net/ethernet/pensando/ionic/ionic_if.h    |  1 +
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  5 +-
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  3 +-
 .../net/ethernet/pensando/ionic/ionic_phc.c   | 61 ++++++++++++++++---
 include/uapi/rdma/ionic-abi.h                 | 12 ++++
 11 files changed, 144 insertions(+), 34 deletions(-)

-- 
2.43.0


