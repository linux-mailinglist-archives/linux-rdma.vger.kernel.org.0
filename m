Return-Path: <linux-rdma+bounces-17282-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIdvBJE4oWkbrQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17282-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 07:24:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DBD1B3397
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 07:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A353314FCB3
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 06:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D7B3B9613;
	Fri, 27 Feb 2026 06:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JrY2RUc4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012071.outbound.protection.outlook.com [40.107.200.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925A433344C;
	Fri, 27 Feb 2026 06:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173109; cv=fail; b=hgTfE/FI7MZ56t+sasyy8+QQcROkyEzsrtacdWZa1VvwR3CIdrvd2cNz1gOq4CMw+pAqf2NEyc4VY9G7zxK1E78SABfL6TSEUPjM6PtXTxbbSQ29TBLcHS/pRufstRhoCYBOjxIW8fkASIR6NQdZyT1AXBiRBzcrMJBSCA58Nrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173109; c=relaxed/simple;
	bh=8s2j3syt0pSYOWn47TXxwrOqU3y9gtCHMkuFaR2N8CM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HUWUDf5I4RBQXnr0KxslwKgm6UToCTxfXexqgdVDt/T+FU0u00hbdK+poJPnigqP6faw60WHKNIORioYcORNra0aOdVcsjU4kkUUmVjL38pZ9fTRzwyDRT8gHf134JXnK0YR9OtnczeHFbxH+/Hz2VByGaezzpc8ZdeO9fTbHNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JrY2RUc4; arc=fail smtp.client-ip=40.107.200.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWFKMaZTfRAQZXK4GHbrlbBp/DSFhrWHFCDKTYeVGjqR8RziNsUYFelEtr6lsqpA27dKctsB7Ya9QmERSfVLLCXdlHyaPcFy2zcLD9aoFAsg8nqPekDvihvSi8atouZRpMIgW2TYOM3VXTm2NuTiYIHpNg1a1eoF6t3Ugsi9w2k7YmpV8x6okowdTJSxHc09TYoDHr3kR5K7HTVU3Dbxz+v+J4fk71kSm/hfEenO7D7fFpFQ7sN2fbu7hoZ/YRgvbEiQ1fxHTbFaKmsY57Y8oZ/swvVqVsBt0//Ua365sQ+aJGn9WlcFPOrwx3AfneqepAQlLD2xwjZBeAc1pQgBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slH5LLKaMKXyIbs0Lj92CORAfRl+Mbj1m59qD3l8h50=;
 b=KHumzGtPcKkz/JWZnOTc9sDMxvl38Gp2UxzTHqvkVXCeuDbNupvI/Qn1qCWTJodJ//p07HpyaxLrY0vj6ra7J//8GjkYlbDF4PWfK5vkloevszTmhywJzno1ZxpEyTAhIHSZrIXMhCEVVJaUEXociA2DHEL5j+G097TWzHExCCxfxTczRtXZr+T7sXhtDRq83ydaPmi5a+qoo65JPPn8S7+YxubJfplxFjS9mncQ4Rr0O31Wb4hJRAb6NGgxKlRq1wAxz7oN4WSbXauoZgegaNca1Pu9F6/XWdIFuYXrZoyngePSSkZhwVMyW26/bfUp4ekOdoPXhYPzv6NMNwZx5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slH5LLKaMKXyIbs0Lj92CORAfRl+Mbj1m59qD3l8h50=;
 b=JrY2RUc4S56E5YXQNrHRYyanbGyptrbzKAFLkm0jTANliHG7FLRSG8afeZ6UNB0juK/hTtRG1yvygUKFhlhgII/8efEQL9fY9xvH3CyHeYHR3doZ1oS5M/Hx4qTa7QcLakvqadX4fJnLWf5uZJe9UXoG38OsNx5Nsdaxh/rdX2o=
Received: from BN0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:408:141::15)
 by DS5PPFEC0C6BDA1.namprd12.prod.outlook.com (2603:10b6:f:fc00::668) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 27 Feb
 2026 06:18:21 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:141:cafe::36) by BN0PR07CA0003.outlook.office365.com
 (2603:10b6:408:141::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 06:18:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 06:18:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 27 Feb
 2026 00:18:20 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Feb
 2026 00:18:20 -0600
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Feb 2026 00:18:18 -0600
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH 1/1] RDMA/ionic: Preserve and set Ethernet source MAC after ib_ud_header_init()
Date: Fri, 27 Feb 2026 11:48:09 +0530
Message-ID: <20260227061809.2979990-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|DS5PPFEC0C6BDA1:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e2800bf-303e-421b-66e5-08de75c8015d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	9mgEG5cl4WXPiKCOzMGmzVweMRzVTfnDiDAoO1E9RjKCIQtMtRTX/Sd1x8NFPznB1f9+PVboLSayMLPvDCGzYZB1FN/i+t2NQtw/ujX5qi8XgL+NUbH0A+hAQy4lxAkoAa8m+nGginvzhQehe+EEqm5N57PI8InMRUe1y7Wghdl2t4pOdIybD6myoms7nHlc9EcYrP+cjln1+zshgcfj9ptokiSVcGlu0inkhwn1HlM7GbGXsSkh3lzQvihsNHdKunbqH7YorGerOwzbOCkQDZjTPe7vSNUTsfkKagu0I33Y03RRZOE/bnqEOL04C2dStkQmh0sHnG75nFClsLKxkl7FjX54X/ZXY+JvYYvoNR5rL12nlWijuhPbYLwPexuV6otreIJrNTVQPKRMx4u6dqZToTCoKWpbTY2llRlIdEqdu5bfUXgAWitA95DidrF4kj6uSAvVfd11lX3f55c3mLWCBCokCTwC71d6Ma98i7g1IekXer9YzBF9B6WM4bZL+/QCBOJi0cOvj6l4dNjszc2ZcnYFgJxxWZ4fUw6AD7FSjNj40Yk2WN2npKPvQO8Qny4ScRJaRSDzSajtVruIwpEv4NHkKXyVSlQIlnFQaU2BcYroLjQP9kpGifWclMKpPgQFrM7OjeuMCYcyt4gV2uVPcK3rfUoeodDOtpLjF8/M5S1YMbH6tSi/4rAgBTHswMs11XFWAhWaMoHlgz2nGVeETLUarZQRtAlSQi0sHGEJUwRg93tQn47ADJIvzJI55IdkDvKRQG2ZbCXDoYh92Z640oliQytv/Cq9Lz/gJvF+xU6t0qLByuUeODdD97jNEqQKcPLkY8DIiHpZ/Ioeew==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xQaizTBwhqlBWixzIhNcJOYjAj1w+aNabzFpNHVXCsvhnIvYrIUCpfkpdh8E4NoaGchPstAjh97d5naL0BcUXWRh5RIF+woPh1c+PcZ4X2PCBKCmCCCO2ONW03B+KU59n+HB5z1dL1eiV+w91/3Ik32eo0MedwWe+kZ+p4VcPW4CsU4Vlx50e5g8Qqsg16qYAe5+/6r4KL7z9qBkk/8WHQ5CLVcTy+0gFzVZGQJLVrdARH7xZkKM5qQptjncVHbCOCY62QKQdpnf5FspMSFafZOihVuxedA32mHy3XzNQy2C8mW1MfW+8RtyVlF8wrjDp5FIrylAI27c9i+7K2uY/vhVOn6IpX7tv2foe/cgVVBQSSqqKRfletC+cJZUGiGQ/Mpvr66Vo7cDtFsozu1fcQ0s+A5Nw+siawfyU4sMeULo4GRgYZXiNuC+ZhOexjem
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 06:18:20.9551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2800bf-303e-421b-66e5-08de75c8015d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEC0C6BDA1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17282-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 61DBD1B3397
X-Rspamd-Action: no action

ionic_build_hdr() populated the Ethernet source MAC (hdr->eth.smac_h) by
passing the header’s storage directly to rdma_read_gid_l2_fields().
However, ib_ud_header_init() is called after that and re-initializes the
UD header, which wipes the previously written smac_h. As a result, packets
are emitted with an zero source MAC address on the wire.

Correct the source MAC by reading the GID-derived smac into a temporary
buffer and copy it after ib_ud_header_init() completes.

Fixes: e8521822c733 ("RDMA/ionic: Register device ops for control path")
Cc: stable@vger.kernel.org # 6.18
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/infiniband/hw/ionic/ionic_controlpath.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index ea12d9b8e125..84bc5f17a700 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -508,6 +508,7 @@ static int ionic_build_hdr(struct ionic_ibdev *dev,
 {
 	const struct ib_global_route *grh;
 	enum rdma_network_type net;
+	u8 smac[ETH_ALEN];
 	u16 vlan;
 	int rc;
 
@@ -518,7 +519,7 @@ static int ionic_build_hdr(struct ionic_ibdev *dev,
 
 	grh = rdma_ah_read_grh(attr);
 
-	rc = rdma_read_gid_l2_fields(grh->sgid_attr, &vlan, &hdr->eth.smac_h[0]);
+	rc = rdma_read_gid_l2_fields(grh->sgid_attr, &vlan, smac);
 	if (rc)
 		return rc;
 
@@ -536,6 +537,7 @@ static int ionic_build_hdr(struct ionic_ibdev *dev,
 	if (rc)
 		return rc;
 
+	ether_addr_copy(hdr->eth.smac_h, smac);
 	ether_addr_copy(hdr->eth.dmac_h, attr->roce.dmac);
 
 	if (net == RDMA_NETWORK_IPV4) {
-- 
2.43.0


