Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1131145161A
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Nov 2021 22:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbhKOVMH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Nov 2021 16:12:07 -0500
Received: from mail-co1nam11on2090.outbound.protection.outlook.com ([40.107.220.90]:33857
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345774AbhKOUMP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 15 Nov 2021 15:12:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWN4cZCmMIOByj+iQeG/vRbhQ1yurVb8kVBND4D3uvl8yFszYrQZDziY/vyIcEUXDlzYUB+qe3pxhzvJO5RdwiHxitJ9ivQucry72LDGSPUaY/gCCTsMh4iJ6Cazh6pVQfiu1V529V395YiXmv/hYyZxy8oZoZhm/7aH9EFkb+nv5iQqt9S3jEFdxKXNRd2OPghJxEiT0pL7ihkgf8gSQMxg8OMQ4cnZwb7g3JfNX+OGOymgsMdUhRlicdiHND4+teuK3cutobh/D8WPqQKwZuEDaknIheTpAQIw9pZ+bVuevHLe+ee3y0gW6J7+LEZzmK4BO6e8+axWhF2Q1OBc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Cmo3HWZsFf+OrKJKLgjKaMjesjU4kBo54HVlk7luME=;
 b=bYzn4j9SZradSD2n6gy7kjJVCEiNBmV2/KrUHUtVMG97sI1IUhc0FLnvSaaoeo2XU4NZjuQ01mQbaHdOyqLBbAPHYUGmdSDxLQRKVhUl4Bb6D4yhm2mhXbL4zLiO88zIMxsAa/sISuNYv1Gqrhg6W+m4nR1cl5hQ/EB/uQdPai0anvAIHn/f6o3ZkHzCLBZJw+d8NxhZGreeVUFTCavZSiwNqexE5DsNC5BX2pgdG0/Ia8wXMP2Db+D/t5UHlrbvEU8kbkMJmpU3kXAIAQdAYSpg6xfa908yt5cNZIKUERm4gXTuiTYXfTg8vqVLIqkcZMO5Y5lwTGmsZygxffFeIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Cmo3HWZsFf+OrKJKLgjKaMjesjU4kBo54HVlk7luME=;
 b=YBaOmPTBZdcVpu/TL1HqmGh865ksT9fGjHMc+ZvesjvoFaRuWKEvpWKEeHKzXO2+fivh6V1Nh0O116d9dUf45Ja+cXqjuRSQlAY5r3PZOSulntoSdLhNbHR+bLLGSz4EHDvsAu9UUdCjuo3aWWs52ZvXERlEo5TRJ8BBc5CMz1ee+uhHwJ/NfbpjW88Rvb3oAxpyYeGU6kvZR1bAjRdJo/sz5KL4DZ1W7XmSGTVcIeqIBPlbZYwNumF/bZsldPhoHL5jgZfq6/kfIeacneDZbGRGC5VuVDM+5NJEqdx3zfLzLNUfuKpHZWmSz7SK6dopcrS/nDetJH2EtH6qT2V4Fg==
Received: from BN6PR1101CA0013.namprd11.prod.outlook.com
 (2603:10b6:405:4a::23) by MW4PR01MB6372.prod.exchangelabs.com
 (2603:10b6:303:76::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Mon, 15 Nov
 2021 20:09:15 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::b) by BN6PR1101CA0013.outlook.office365.com
 (2603:10b6:405:4a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend
 Transport; Mon, 15 Nov 2021 20:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15 via Frontend Transport; Mon, 15 Nov 2021 20:09:14 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 1AFK9DhF124141;
        Mon, 15 Nov 2021 15:09:13 -0500
Subject: [PATCH for-rc] IB/hfi1: Properly allocate rdma counter desc memory
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Date:   Mon, 15 Nov 2021 15:09:13 -0500
Message-ID: <20211115200913.124104.47770.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f872e24-f6f5-46cf-f8c6-08d9a873cc1e
X-MS-TrafficTypeDiagnostic: MW4PR01MB6372:
X-Microsoft-Antispam-PRVS: <MW4PR01MB63721EF97B57014EA6417CBCF4989@MW4PR01MB6372.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UObbqr5472JsWlCO+m/F8Y0/HK8RHAjDg/Z5HUZBo3GWh03zCX7cxV/OmALXzlVsobpTvuY8ujOlejRaluBbUG48PG6T/ip88+T8weCf5WN1bKQFDUrsHxlVB5eYygI4zcR+2Vzw10KVQnqUX/0NLvZ8Be/b9WYcWZ9+lQXvxFFnBDZy6sdt/PVj2+0dSsk7Q2eWCk0J22rPj/JYPykVGkEqyMSwzsTrmNCgJaBX/yZChEDbqYYYvneaD1F6X0P5mUPhzoYtC0YrSIc4TpD5zushkTuqPnI9Ui+CICqFzsitTIhh8yKy/y6EgGxcO97rJkkjz2iopwBIBQp5J8rodt8xDW7pYaNzQR+sF+9nrwRvff1b+nN/n/QjFb9PxP9FANzJ6MzOhFPfmCciWrlHLRbEuJYuFiahHtT/NuadpYO066I0TA2dPCzZAxnrM3fxY4OnGptfA05nJLX7DsP1iolCpBXxm3k5sYpy9qa82rAJbzZaGPIFQu4OKCMOMhKot3PQR0xp7px6nb//L7+ILDz5jEi02jjm8f4atix7Z4sEcoAbioMBU0YtJnAp4OVTjG9X4+c+dM3p1OLe63hIXgjUoGhgxDub4wsn8AqyD8qAhGV3+bnP6U4uvhRNvDximO/VFJPoEXxYvxVBY9bHNBi7Ob8Hl8Fjxd0peT25fHfv6FNBeVS5Lcg5Cb+lapU8ZZus4V9u57+nmbyIUoA7Wv/lCrT/g2REQbqtJuRgzAA=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(44832011)(2906002)(8676002)(81166007)(7126003)(316002)(1076003)(426003)(336012)(8936002)(36860700001)(82310400003)(45080400002)(26005)(107886003)(47076005)(70206006)(70586007)(86362001)(186003)(55016002)(103116003)(508600001)(356005)(4326008)(7696005)(83380400001)(5660300002)(36906005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 20:09:14.8553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f872e24-f6f5-46cf-f8c6-08d9a873cc1e
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6372
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When optional counter support was added the allocation of the memory holding the
counter descriptors was not cleared properly. This caused massive WARN_ON()s in
IB/sysfs code to be hit. There is an assumption made that optional counters must
not come before required counters. This is determiend by the flags field which
was not zeroed.

The result is the console is flooded with WARN_ON for over 3 minutes on driver
load. We can fix by simply using kzalloc vs kmalloc. While here change the
sizeof() calls to use the pointer rather than the name of the type.

[77952.529518] ------------[ cut here ]------------
[77952.535428] WARNING: CPU: 0 PID: 32644 at
drivers/infiniband/core/sysfs.c:1064 ib_setup_port_attrs+0x7e1/0x890 [ib_core]
[77952.548374] Modules linked in: hfi1(+) rdmavt ib_ipoib ib_isert ib_iser
ib_umad rdma_ucm ib_uverbs rpcrdma ib_srpt ib_srp rdma_cm iw_cm ib_cm ib_core
nfsd nfs_acl scsi_transport_srp rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver
nfs lockd grace fscache netfs rfkill sunrpc iscsi_target_mod target_core_mod
libiscsi scsi_transport_iscsi vfat fat iTCO_wdt iTCO_vendor_support mxm_wmi
sb_edac x86_pkg_temp_thermal intel_powerclamp mgag200 coretemp crct10dif_pclmul
drm_kms_helper crc32_pclmul syscopyarea ghash_clmulni_intel sysfillrect ipmi_si
sysimgblt fb_sys_fops aesni_intel mei_me i2c_i801 ipmi_devintf crypto_simd
i2c_algo_bit drm i2c_smbus lpc_ich cryptd pcspkr ipmi_msghandler mfd_core mei
i2c_core ioatdma wmi acpi_power_meter acpi_pad sch_fq_codel ip_tables xfs
libcrc32c sd_mod t10_pi sg ixgbe ahci mdio libahci ptp crc32c_intel pps_core
libata dca [last unloaded: ib_core]
[77952.640387] CPU: 0 PID: 32644 Comm: kworker/0:2 Tainted: G S      W
5.15.0+ #36
[77952.650229] Hardware name: Intel Corporation S2600WTT/S2600WTT, BIOS
SE5C610.86B.01.01.0018.C4.072020161249 07/20/2016
[77952.663077] Workqueue: events work_for_cpu_fn
[77952.668831] RIP: 0010:ib_setup_port_attrs+0x7e1/0x890 [ib_core]
[77952.676337] Code: 48 83 7b 70 00 0f 84 e4 f9 ff ff e9 17 fe ff ff 31 c0 e9 4b
fb ff ff 48 89 ef 89 04 24 e8 67 d0 a8 e0 8b 04 24 e9 1a fb ff ff <0f> 0b 49 8b
10 e9 de fe ff ff ba 34 00 00 00 be c0 0d 00 00 44 89
[77952.699056] RSP: 0018:ffffc90006ea3c40 EFLAGS: 00010202
[77952.705749] RAX: 0000000000000068 RBX: ffff888106ad8000 RCX: 0000000000000138
[77952.714567] RDX: ffff888126c84c00 RSI: ffff888103c41000 RDI: 0000000000000124
[77952.723370] RBP: ffff88810f63a801 R08: ffff888126c8a000 R09: 0000000000000001
[77952.732156] R10: ffffffffa09acf20 R11: 0000000000000065 R12: ffff88810f63a800
[77952.740943] R13: ffff88810f63a800 R14: ffff88810f63a8e0 R15: 0000000000000001
[77952.749717] FS:  0000000000000000(0000) GS:ffff888667a00000(0000)
knlGS:0000000000000000
[77952.759556] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[77952.766765] CR2: 00005590102cb078 CR3: 000000000240a003 CR4: 00000000001706f0
[77952.775527] Call Trace:
[77952.779051]  ib_register_device.cold.44+0x23e/0x2d0 [ib_core]
[77952.786298]  ? __vmalloc_node_range+0x1fb/0x320
[77952.792158]  ? __vmalloc_node+0x44/0x70
[77952.797234]  rvt_register_device+0xfa/0x230 [rdmavt]
[77952.803568]  hfi1_register_ib_device+0x623/0x690 [hfi1]
[77952.810238]  init_one.cold.36+0x2d1/0x49b [hfi1]
[77952.816236]  local_pci_probe+0x45/0x80
[77952.821189]  work_for_cpu_fn+0x16/0x20
[77952.826132]  process_one_work+0x1b1/0x360
[77952.831368]  worker_thread+0x1d4/0x3a0
[77952.836310]  ? process_one_work+0x360/0x360
[77952.841741]  kthread+0x11a/0x140
[77952.846098]  ? set_kthread_struct+0x40/0x40
[77952.851521]  ret_from_fork+0x22/0x30
[77952.856257] ---[ end trace eadcb3e247decd87 ]---
[77952.862174] ------------[ cut here ]------------


Fixes: 5e2ddd1e5982 ("RDMA/counter: Add optional counter support")
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/verbs.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index ed9fa0d..dc9211f 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1628,8 +1628,7 @@ static int init_cntr_names(const char *names_in, const size_t names_len,
 			n++;
 
 	names_out =
-		kmalloc((n + num_extra_names) * sizeof(struct rdma_stat_desc) +
-				names_len,
+		kzalloc((n + num_extra_names) * sizeof(*q) + names_len,
 			GFP_KERNEL);
 	if (!names_out) {
 		*num_cntrs = 0;
@@ -1637,7 +1636,7 @@ static int init_cntr_names(const char *names_in, const size_t names_len,
 		return -ENOMEM;
 	}
 
-	p = names_out + (n + num_extra_names) * sizeof(struct rdma_stat_desc);
+	p = names_out + (n + num_extra_names) * sizeof(*q);
 	memcpy(p, names_in, names_len);
 
 	q = (struct rdma_stat_desc *)names_out;

