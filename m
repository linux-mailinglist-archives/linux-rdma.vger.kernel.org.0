Return-Path: <linux-rdma+bounces-21944-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0vQxBZOCJmr5XgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21944-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 10:51:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BD7654386
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 10:51:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=mLtnT8Ri;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21944-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21944-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A48E3114743
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 08:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D53394EBD;
	Mon,  8 Jun 2026 08:39:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EC03B2FF3
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jun 2026 08:39:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907988; cv=none; b=YbERMc3ZkjpCR7w+QBzR0X+hPYtGlyeBRaTPBETSzeqRyBQvvSA4djERDPBkY723JiGS87p9E/5yy7dRS0UmXxSIgQ8A621UTQAkEALPmmKz/GHOH14y+BpuM0o4ARc9c4RM2779ElZ2DrtCOR7s3vOsO69xheuDM0dORRhq3o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907988; c=relaxed/simple;
	bh=BYqWTyumGhikMgkAqsBe8bf9BSzUYZ7YT2815x5AKJg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aQJRr95OTmIaU93pwrO1Arh0Hs0cVbeK65It4jwJ12uWhMyWBye3lTShR5H0l0oxird5zVxc/rh5M1E5IAg4caeUe2QbfzlDDZOw8rOUg0Ymk3LbuYp1JpgRSItFBGRXEQy47r+3RrKHKQBSAE4r7W1J+GmlialmgmskPTkvOeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=mLtnT8Ri; arc=none smtp.client-ip=50.112.246.219
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1780907982; x=1812443982;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ktvOzhf24dRI636xNEwXUMcQrJA8HLln+4yE2KXE3Mw=;
  b=mLtnT8RiN08p+Oz/9wVZcyxsJvS/Gq1rnHWX1S0Ao1T4KH/1KTsznGgu
   BTZHpPKOyduap37IqCemb6gaaWmSn7Nt/OEvLb3HUX3opxzRwb/Ljjz0P
   DXSpRW5kSr/AnmLvZQXT/6PgakLx0YoDbVT5uXPtmiKItZmPPwsysqfuX
   9Rvgn0NuRoLfxFED+Rekf7FscKrmqhMrKCVTv0xmurFT82tqb2gntPetZ
   dunuvviGdJ1NGvE7yJD6NgbMUdzutmKrO/05feyDrY/b7eWCbrjLv8SA9
   /K+9qB/Slwa01BsKIKAlhBjkQcveeq4osakDB0WVaLogAs2cSi+Mz5jfX
   w==;
X-CSE-ConnectionGUID: Ye+U+V+dSmqiPMsuG9azeg==
X-CSE-MsgGUID: wpEYQhWUSZK002Y82mlwyg==
X-IronPort-AV: E=Sophos;i="6.24,194,1774310400"; 
   d="scan'208";a="21118378"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 08:39:37 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:14454]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.226:2525] with esmtp (Farcaster)
 id 3cdd3052-0d0f-41c4-b97c-20d28d6b5286; Mon, 8 Jun 2026 08:39:37 +0000 (UTC)
X-Farcaster-Flow-ID: 3cdd3052-0d0f-41c4-b97c-20d28d6b5286
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 8 Jun 2026 08:39:37 +0000
Received: from dev-dsk-tomsela-1c-ce9cc34e.eu-west-1.amazon.com (10.15.30.17)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 8 Jun 2026 08:39:35 +0000
From: Tom Sela <tomsela@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<mrgolin@amazon.com>, <tomsela@amazon.com>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	"Yonatan Nachum" <ynachum@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Implement the query port speed verb
Date: Mon, 8 Jun 2026 08:39:27 +0000
Message-ID: <20260608083927.4116-1-tomsela@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	TAGGED_FROM(0.00)[bounces-21944-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:mrgolin@amazon.com,m:tomsela@amazon.com,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,m:ynachum@amazon.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tomsela@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[tomsela@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 66BD7654386

Implement the query port speed callback to report the port effective
bandwidth directly in 100 Mb/s granularity.

Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Tom Sela <tomsela@amazon.com>
---
 drivers/infiniband/hw/efa/efa.h         |  1 +
 drivers/infiniband/hw/efa/efa_com_cmd.c |  4 ++++
 drivers/infiniband/hw/efa/efa_main.c    |  1 +
 drivers/infiniband/hw/efa/efa_verbs.c   | 13 ++++++++++---
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 00b19f2ba3da..f4586bb170c1 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -148,6 +148,7 @@ int efa_query_device(struct ib_device *ibdev,
 		     struct ib_udata *udata);
 int efa_query_port(struct ib_device *ibdev, u32 port,
 		   struct ib_port_attr *props);
+int efa_query_port_speed(struct ib_device *ibdev, u32 port_num, u64 *speed);
 int efa_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 		 int qp_attr_mask,
 		 struct ib_qp_init_attr *qp_init_attr);
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 63c7f07806a8..5db4f5805b59 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -6,6 +6,8 @@
 #include "efa_com.h"
 #include "efa_com_cmd.h"
 
+#define EFA_DEFAULT_LINK_SPEED_GBPS 100
+
 int efa_com_create_qp(struct efa_com_dev *edev,
 		      struct efa_com_create_qp_params *params,
 		      struct efa_com_create_qp_result *res)
@@ -468,6 +470,8 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
 	result->device_caps = resp.u.device_attr.device_caps;
 	result->guid = resp.u.device_attr.guid;
 	result->max_link_speed_gbps = resp.u.device_attr.max_link_speed_gbps;
+	if (!result->max_link_speed_gbps)
+		result->max_link_speed_gbps = EFA_DEFAULT_LINK_SPEED_GBPS;
 
 	if (result->admin_api_version < 1) {
 		ibdev_err_ratelimited(
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 03c237c8c81e..97da8e828e34 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -390,6 +390,7 @@ static const struct ib_device_ops efa_dev_ops = {
 	.query_gid = efa_query_gid,
 	.query_pkey = efa_query_pkey,
 	.query_port = efa_query_port,
+	.query_port_speed = efa_query_port_speed,
 	.query_qp = efa_query_qp,
 	.reg_user_mr = efa_reg_mr,
 	.reg_user_mr_dmabuf = efa_reg_user_mr_dmabuf,
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 5cd34746e6a6..5bb00cb85775 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -90,8 +90,6 @@ static const struct rdma_stat_desc efa_port_stats_descs[] = {
 	EFA_DEFINE_PORT_STATS(EFA_STATS_STR)
 };
 
-#define EFA_DEFAULT_LINK_SPEED_GBPS   100
-
 #define EFA_CHUNK_PAYLOAD_SHIFT       12
 #define EFA_CHUNK_PAYLOAD_SIZE        BIT(EFA_CHUNK_PAYLOAD_SHIFT)
 #define EFA_CHUNK_PAYLOAD_PTR_SIZE    8
@@ -332,7 +330,7 @@ int efa_query_port(struct ib_device *ibdev, u32 port,
 	props->phys_state = IB_PORT_PHYS_STATE_LINK_UP;
 	props->gid_tbl_len = 1;
 	props->pkey_tbl_len = 1;
-	link_gbps = dev->dev_attr.max_link_speed_gbps ?: EFA_DEFAULT_LINK_SPEED_GBPS;
+	link_gbps = dev->dev_attr.max_link_speed_gbps;
 	efa_link_gbps_to_speed_and_width(link_gbps, &link_speed, &link_width);
 	props->active_speed = link_speed;
 	props->active_width = link_width;
@@ -344,6 +342,15 @@ int efa_query_port(struct ib_device *ibdev, u32 port,
 	return 0;
 }
 
+int efa_query_port_speed(struct ib_device *ibdev, u32 port_num, u64 *speed)
+{
+	struct efa_dev *dev = to_edev(ibdev);
+
+	*speed = dev->dev_attr.max_link_speed_gbps * 10;
+
+	return 0;
+}
+
 int efa_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 		 int qp_attr_mask,
 		 struct ib_qp_init_attr *qp_init_attr)
-- 
2.47.3


