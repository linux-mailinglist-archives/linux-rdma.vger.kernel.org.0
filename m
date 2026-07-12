Return-Path: <linux-rdma+bounces-23079-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b+taEDiaU2qvcAMAu9opvQ
	(envelope-from <linux-rdma+bounces-23079-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 15:44:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A070F744D64
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 15:44:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=JrxzHIdN;
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23079-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23079-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A830300D60A
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 13:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3BE367F4A;
	Sun, 12 Jul 2026 13:44:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF26139656D
	for <linux-rdma@vger.kernel.org>; Sun, 12 Jul 2026 13:44:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783863862; cv=none; b=YczDA/bset98H9hzxfJ5ZJjc/8UWhmSTSq8VtsedVBHPamqy7HEPq7AURG4gbmOyUrvBClJw7G3R2IXkn0LC2Rb55CGeBkeEPdteZeoP7i79ZVFbGKM2m+/+XC36yJBDX5I8Qy1BevuwCgBKGJu776JIvR6nF6WY+8lFMDR6TKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783863862; c=relaxed/simple;
	bh=u8Ku9+Ft6Ub+NKxrV7/kvyFuqcR+3K+9qyB2ZU5kUqE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJD0i7elpb3tzeQFwh3wS4sliVHpKWVM3Io39q9Qp5ru3GPvqumQAZnsB6vtzIDuAXPIlhNv3mNQZMBkOtlWpnvK0GkdR0HQU8Nmpfby63RBFrspxwu+c+nrTuUk94YmJSHj7B0W8H6CAKL4YS6UEaBV3uOcAtXpMDrUSi0Pt7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=JrxzHIdN; arc=none smtp.client-ip=52.13.214.179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1783863860; x=1815399860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aJ+QZzWskoau990F18STfJBpsFy4jmCpVXdhKYvSwe8=;
  b=JrxzHIdNTVcWh3wRJfvqPHF60sdUenHoEKn4XM7SUbq4NYPn2iPAKM9D
   sU1AXFRBNdwScwR7xjpTrQNLBBYz0UtzAK08FUhJwEVqkYWAJ6pchp2w+
   pKH+m31tA2wRQv3Ne2WaKqUnP3Lz2u6NIn9bwNOym+cEYUX7TMFfT8H0q
   EoEDRbbjA6MYrF9nMbolA+fBOc2AWr7qxWxasT2sGBlreGTG4wW2R/sXx
   Y265ShucP/ly1GD1VbxQmXuOoTGy6R18mQ+9BqqYv6xom+XX68Lrve83P
   Y5lwfr9GaYvUY8CUM5gN8yn+Qul6T0zKcZDtnk5/U/qwl45ScuKo9SKzF
   g==;
X-CSE-ConnectionGUID: 5d3Ld/P/Rhq9jAhfDsaiFA==
X-CSE-MsgGUID: qDwJ17NuRGSzB4Nsu2PgXA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; 
   d="scan'208";a="23497649"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 13:44:18 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:18873]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.54:2525] with esmtp (Farcaster)
 id 29fafee0-47ec-4bb8-84ab-47cfa3ef9627; Sun, 12 Jul 2026 13:44:17 +0000 (UTC)
X-Farcaster-Flow-ID: 29fafee0-47ec-4bb8-84ab-47cfa3ef9627
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 12 Jul 2026 13:44:17 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Sun, 12 Jul 2026
 13:44:16 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	"Yonatan Nachum" <ynachum@amazon.com>
Subject: [PATCH for-next 1/2] RDMA/efa: Extend page-shift field in MR registration
Date: Sun, 12 Jul 2026 13:44:12 +0000
Message-ID: <20260712134413.19226-2-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260712134413.19226-1-mrgolin@amazon.com>
References: <20260712134413.19226-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,m:ynachum@amazon.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23079-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A070F744D64

Update device interface adding one more bit from reserved to enable
>4GB page sizes that can be supported on 0xefa4 devices.

Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index 826790ca9d83..3eb3a4de8912 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -367,10 +367,10 @@ struct efa_admin_reg_mr_cmd {
 
 	/*
 	 * flags and page size
-	 * 4:0 : phys_page_size_shift - page size is (1 <<
+	 * 5:0 : phys_page_size_shift - page size is (1 <<
 	 *    phys_page_size_shift). Page size is used for
 	 *    building the Virtual to Physical address mapping
-	 * 6:5 : reserved - MBZ
+	 * 6 : reserved - MBZ
 	 * 7 : mem_addr_phy_mode_en - Enable bit for physical
 	 *    memory registration (no translation), can be used
 	 *    only by privileged clients. If set, PBL must
@@ -1103,7 +1103,7 @@ struct efa_admin_host_info {
 #define EFA_ADMIN_MODIFY_QP_CMD_RNR_RETRY_MASK              BIT(5)
 
 /* reg_mr_cmd */
-#define EFA_ADMIN_REG_MR_CMD_PHYS_PAGE_SIZE_SHIFT_MASK      GENMASK(4, 0)
+#define EFA_ADMIN_REG_MR_CMD_PHYS_PAGE_SIZE_SHIFT_MASK      GENMASK(5, 0)
 #define EFA_ADMIN_REG_MR_CMD_MEM_ADDR_PHY_MODE_EN_MASK      BIT(7)
 #define EFA_ADMIN_REG_MR_CMD_LOCAL_WRITE_ENABLE_MASK        BIT(0)
 #define EFA_ADMIN_REG_MR_CMD_REMOTE_WRITE_ENABLE_MASK       BIT(1)
-- 
2.47.3


