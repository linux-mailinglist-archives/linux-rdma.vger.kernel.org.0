Return-Path: <linux-rdma+bounces-21892-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YvKIKSKrI2owwwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21892-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 07:07:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F62364C813
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 07:07:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=DQU8E07T;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21892-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21892-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7294C30E4E3C
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Jun 2026 05:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069A130C14A;
	Sat,  6 Jun 2026 05:00:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012013.outbound.protection.outlook.com [52.101.43.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B2230567D;
	Sat,  6 Jun 2026 05:00:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780722034; cv=fail; b=IShfTr4iJW38znAnaxT9NjeDTWYZPkrQqiTnRs4zH4WA1OmKRirQk6/hPr3pVRSLRL3GTuSxFLcJpf8AJyZHV2cxYuszZIDOBnb9A2+KsrVhfh5TnQ1rsJ3o7wHQtQFH6lj0ZGPT+9cOh1jkrIiqMLe00QjA6Tru4nF/RiH1Sm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780722034; c=relaxed/simple;
	bh=jIIxSqrJMDTBMiAj80oXFIRTZ+hwZ6Kenke3xaIRYF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k57PrgUyQayGceFTGoRno+AJerB/K7zZwASJtHA8abw4GwTceTxMtBQPhPVBW6BoEcoNyZ9FLIzyWP3N2TyT+XzqnbmkOtIOJTG5AwoaOU0C5wnJaZix+oh/QCixNihHZ3pgaXeJhFrSA19PXmF18RClPyAuwk5HKC8twDRg5O4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DQU8E07T; arc=fail smtp.client-ip=52.101.43.13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkrCA45Dx9MAJQlbMT6HF701LD0kZ6vudgXZZGHnl5NI0NTWEof6QcBa6CusCza8c8uDdpzg54d/3mu2AxAjqbZvIoWPGAMz/bkPWC51R6Qjzai6Q4l4AcZs4CVTFQKBUY/oiKupbbfWXoRt1cSNq5mA3eMjCSCVaIzcCHmg3bMpiB5DUoiw2WIH5yJutfuj0ODbsFCbtDYtcfguI8QRCtRItaVsn5cKtBMlnmBZyENYjZwClBPjz83El4LdNwiBoilRjRvEejpWLKIh9PdkoimXi5ILyl0g2kuTkr0IazotvDzlA9WwztBNZRIwgF40n6Gtln+YawKUVjTd/VGlNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ma/ZEopFDcRmvM/nZ2xunPnDUm5Q/8E87nfEce57zG4=;
 b=xoutQNP4Vr7DDFQVGR1tS4JYwwNiHjXNiqkyOk4EMDIitdb+5ZQn+TDHuW8SpLpmJ9HeFG1vcA3sciqzWyGlYfdmktVxtB0ER35gYvZv1GktChZNrKRiNDShcYuHy8ROYA+QW+AWvvT1sL+VHuDnSqa1Oce0uAnHRqoozElRvE7ioK064ougTBhJLAR0hmlvILNTamSCoGE7uB7Qs2tfvsO6Nio+LKbXI65VRN0BXeglIJpJJil2daVmDD/PkRXpg5pxbE485pce2nk0luy/fKobhia9F2AX3LlOUhDjplv97MVr/3X/osFIU7G0sN3VfEPPdoWDqrErT0y0AIs8hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ma/ZEopFDcRmvM/nZ2xunPnDUm5Q/8E87nfEce57zG4=;
 b=DQU8E07TpzCQaUj2puWPTkraEEVDKnPa65QvruNUiDR1sXaFUd2Ni+VtmH8U6w+Gyn1D2cnZk26/6HoR8sInx8J29I8QOO7rRBalf38FB5fhaMYlzItZhiblCtN5Y8TJ7pjXO/CS/O75AtVkIUtIO1eZOT2X17gOzYmZUgm4neA=
Received: from BLAPR03CA0129.namprd03.prod.outlook.com (2603:10b6:208:32e::14)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.10; Sat, 6 Jun 2026
 05:00:27 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::1a) by BLAPR03CA0129.outlook.office365.com
 (2603:10b6:208:32e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.10 via Frontend Transport; Sat, 6
 Jun 2026 05:00:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sat, 6 Jun 2026 05:00:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 6 Jun
 2026 00:00:26 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 6 Jun 2026 00:00:23 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [for-next v3 3/5] RDMA/ionic: map PHC state into user space
Date: Sat, 6 Jun 2026 10:30:01 +0530
Message-ID: <20260606050003.3648306-4-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260606050003.3648306-1-abhijit.gangurde@amd.com>
References: <20260606050003.3648306-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|DM6PR12MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: a5959931-12c0-4e1a-8ec3-08dec38886aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	r0X5h4XDebEEZ8QtED/k1tEcuU9ihclDqZNpXKvrR+A3vCthZ6MfdoOGQukCHyVClmD0XnMZyNa8rFn0lrf8goUJoMZURcemk3GjYkc0UCiul52zdLkiDIKMJhPlosVuw9+Cua6cqUdUSkQIx0CH/dn7DNaE4rkoNFNyXxY/7ysOxBGi/KpzFpRFShR3ctkUOC8z1HkJksxE7ISOdZS4QqLasLGcSl56Kcii3NG1UKZX9BAkeYyGVx4OtZulcuaDSHpWhqMJaHy1avq4UAz9h7tt6e6oU2GCm6AFHYRPCGjyyZp58RkRN80Dm9ThP8xSg7LFXXz3Pblk533WP+0TotCi0NB4CyvC9599ULMdFUVKHHR9OCFi12OhTntZUtsW3tTKH0N0aRFaQVb1oXdDQRmLFDGZXAnd6LlA3RXLVGTpVth5x3V6sBF3dm7gdGz0iZNolsLczgonSQ2IovNB/6q6Tz2nL+0bi4YhMChrEdq/7qWJEALzFcyo6B5p58m6UAwO5LOC7jymkIFqiPUq5FWkLUpfz2IGWpo+MWHBc/KwHRNljDfwkSD7FZsmmMBMrCxCsrygAX1bGFBTWAAuu+r30qItgJhq5Bte6lkNAqJiH1nQY89aX8Oj0PeFPE5VA3zJT5VMbZXlfNoLh1arbdBHbRz2p4xBx7DtKU6WzQuzshFrkqHNobtibk1S2+MhvZPX4tT8V7XBTsBva6sIEX7+hNAw+FBlozCXW9KGG/c=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H7dJeFL9B0tHsV7A4rBpLcpHTmXaitucNI5SlK7py8hpQ+bPVzsZng9IIeDs0VcrDffSR6l+QI8k+WLFk+UUE2sgXxp1C5qRqW/BVTK7w5hm+LSgQt1j2+tBoQCk530gP//1Eq9UwQxCQtNcn/7WtuwhR0/CHcIn4hF2rndyltGlxqn9oxrzhhzJNSZUTWR1R6Tdh6jqV6MXDndwZN1uIM/NIqvf81t4IqIUsTeICte2euKxF/Q15xrKmQKTiUthNbLe8XL71d3Omewbh7pljJLwrjmAEJQrQUHPLHUWm+2ptE3jK/rPpWvIhgn8ZSfZjPZjpM04qQ7nGpIjkh3subhFDkG/CM11LIPFdy37+by6zkkjP1B0i8UVxtc9d6oe2pKnbxlZ7XQvYQZdcMPLMgnGUrDZedKAJipTDRnojxcF5/n+5kKwqJgkuyLe5S3i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2026 05:00:27.5040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5959931-12c0-4e1a-8ec3-08dec38886aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-21892-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:allen.hubbe@amd.com,m:nikhil.agarwal@amd.com,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:abhijit.gangurde@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:mid,amd.com:dkim,amd.com:from_mime,amd.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F62364C813

Enable user space applications to access the PHC state page when
firmware RDMA completion timestamp is supported.

This mapping allows user space to convert RDMA completion timestamps
to system wall time without kernel transitions, minimizing latency
overhead. Applications can directly read the PHC state through mmap,
enabling efficient timestamp correlation for precision timing
applications.

Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 .../infiniband/hw/ionic/ionic_controlpath.c   | 34 +++++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_ibdev.h     |  2 ++
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c   |  2 ++
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h   |  1 +
 include/uapi/rdma/ionic-abi.h                 |  1 +
 5 files changed, 40 insertions(+)

diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index ea12d9b8e125..9a7c76c9747f 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -391,6 +391,16 @@ int ionic_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 		goto err_mmap_dbell;
 	}
 
+	if (dev->lif_cfg.phc_state) {
+		ctx->mmap_phc = ionic_mmap_entry_insert(ctx, PAGE_SIZE, 0,
+							IONIC_MMAP_PHC,
+							&resp.phc_offset);
+		if (!ctx->mmap_phc) {
+			rc = -ENOMEM;
+			goto err_mmap_phc;
+		}
+	}
+
 	resp.page_shift = PAGE_SHIFT;
 
 	resp.dbell_offset = db_phys & ~PAGE_MASK;
@@ -421,6 +431,8 @@ int ionic_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 	return 0;
 
 err_resp:
+	rdma_user_mmap_entry_remove(ctx->mmap_phc);
+err_mmap_phc:
 	rdma_user_mmap_entry_remove(ctx->mmap_dbell);
 err_mmap_dbell:
 	ionic_put_dbid(dev, ctx->dbid);
@@ -433,10 +445,26 @@ void ionic_dealloc_ucontext(struct ib_ucontext *ibctx)
 	struct ionic_ibdev *dev = to_ionic_ibdev(ibctx->device);
 	struct ionic_ctx *ctx = to_ionic_ctx(ibctx);
 
+	rdma_user_mmap_entry_remove(ctx->mmap_phc);
 	rdma_user_mmap_entry_remove(ctx->mmap_dbell);
 	ionic_put_dbid(dev, ctx->dbid);
 }
 
+static int ionic_mmap_phc_state(struct ionic_ibdev *dev,
+				struct vm_area_struct *vma)
+{
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
+
+	if (vma->vm_flags & (VM_WRITE | VM_EXEC))
+		return -EPERM;
+
+	vm_flags_clear(vma, VM_MAYWRITE);
+
+	return vm_insert_page(vma, vma->vm_start,
+			      virt_to_page(dev->lif_cfg.phc_state));
+}
+
 int ionic_mmap(struct ib_ucontext *ibctx, struct vm_area_struct *vma)
 {
 	struct ionic_ibdev *dev = to_ionic_ibdev(ibctx->device);
@@ -455,6 +483,12 @@ int ionic_mmap(struct ib_ucontext *ibctx, struct vm_area_struct *vma)
 	ionic_entry = container_of(rdma_entry, struct ionic_mmap_entry,
 				   rdma_entry);
 
+	if (ionic_entry->mmap_flags & IONIC_MMAP_PHC) {
+		rc = ionic_mmap_phc_state(dev, vma);
+		rdma_user_mmap_entry_put(rdma_entry);
+		return rc;
+	}
+
 	ibdev_dbg(&dev->ibdev, "writecombine? %d\n",
 		  ionic_entry->mmap_flags & IONIC_MMAP_WC);
 	if (ionic_entry->mmap_flags & IONIC_MMAP_WC)
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
index 82fda1e3cdb6..de23376267f5 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.h
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
@@ -72,6 +72,7 @@ enum ionic_admin_flags {
 
 enum ionic_mmap_flag {
 	IONIC_MMAP_WC = BIT(0),
+	IONIC_MMAP_PHC = BIT(1),
 };
 
 struct ionic_mmap_entry {
@@ -173,6 +174,7 @@ struct ionic_ctx {
 	struct ib_ucontext	ibctx;
 	u32			dbid;
 	struct rdma_user_mmap_entry	*mmap_dbell;
+	struct rdma_user_mmap_entry	*mmap_phc;
 };
 
 struct ionic_tbl_buf {
diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.c b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
index f3cd281c3a2f..f827dce59973 100644
--- a/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
@@ -40,6 +40,8 @@ void ionic_fill_lif_cfg(struct ionic_lif *lif, struct ionic_lif_cfg *cfg)
 	cfg->dbid_count = le32_to_cpu(lif->ionic->ident.dev.ndbpgs_per_lif);
 	cfg->dbpage = lif->kern_dbpage;
 	cfg->intr_ctrl = lif->ionic->idev.intr_ctrl;
+	if (lif->phc)
+		cfg->phc_state = lif->phc->state_page;
 
 	cfg->db_phys = lif->ionic->bars[IONIC_PCI_BAR_DBELL].bus_addr;
 
diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.h b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
index 20853429f623..2b29e646c193 100644
--- a/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
@@ -23,6 +23,7 @@ struct ionic_lif_cfg {
 	u64 __iomem *dbpage;
 	struct ionic_intr __iomem *intr_ctrl;
 	phys_addr_t db_phys;
+	void *phc_state;
 
 	u64 page_size_supported;
 	u32 npts_per_lif;
diff --git a/include/uapi/rdma/ionic-abi.h b/include/uapi/rdma/ionic-abi.h
index 7b589d3e9728..2c70ac149c4f 100644
--- a/include/uapi/rdma/ionic-abi.h
+++ b/include/uapi/rdma/ionic-abi.h
@@ -48,6 +48,7 @@ struct ionic_ctx_resp {
 	__u8 expdb_qtypes;
 
 	__u8 rsvd2[3];
+	__aligned_u64 phc_offset;
 };
 
 struct ionic_qdesc {
-- 
2.43.0


