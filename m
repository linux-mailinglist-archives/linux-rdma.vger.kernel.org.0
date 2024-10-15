Return-Path: <linux-rdma+bounces-5414-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DA299F449
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2024 19:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03131F243EC
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2024 17:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1331FAEE8;
	Tue, 15 Oct 2024 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JWkQdSOj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD971FAEE0
	for <linux-rdma@vger.kernel.org>; Tue, 15 Oct 2024 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014172; cv=none; b=mtjpmh6uKGfZSZAxiasWhga4P/8ONSAXTgCmRaCvNhmjaPotMRnXbC1o6rpiHK7EEfXznFQZYMnHx8DQCgZRsz2EkSrsbuOrrg2SlB+X6fhVWrmwLfG6ZPZIiGv6xQhUl2TnOrfB5xHqPEyIFCvxgxdkzFtgIQb6Ah+HPrLSRTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014172; c=relaxed/simple;
	bh=s36pmfuMBLSuf8JmH10WDpryQVwThU6vbN7HzEvH4cs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4SmXdQei5rWbn0b7UE042+bcqHinDTz9r0FU8KmhGtDHWc/1FHAKbBaYaVyTSFfFhDWaBIIRos5tv1And6NdN3fAgc04sNgHrsxQQYfQ2zt8RHZONPs0VuC7wEltUEQ9sC+GGHvOF1N3lF8onrmSHZG1wh5T1iOB3xzKZFuvKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JWkQdSOj; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729014171; x=1760550171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HMqB2SqFKo5r14rj88GmTetNlPhlTumgTsRtFhJGnhk=;
  b=JWkQdSOj48qKP7WVrwtvnowXjffI2Q+JMg0vpKR19X6e6yiK0i7cagkw
   Em9iqtBLTMI1675uDmcJAwfTMsTriAo6Tq6jZAtARJrat0ShkNTZA0u54
   c5BWOgF7kQRGRq3358Irc9/i83Mc5t+cW7YcygdBQ7Z2zfQKP+bD0ONl4
   M=;
X-IronPort-AV: E=Sophos;i="6.11,205,1725321600"; 
   d="scan'208";a="343342810"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 17:42:48 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:36884]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.34.166:2525] with esmtp (Farcaster)
 id 6d20397b-5686-4069-87dd-f88cfe7cc7d2; Tue, 15 Oct 2024 17:42:46 +0000 (UTC)
X-Farcaster-Flow-ID: 6d20397b-5686-4069-87dd-f88cfe7cc7d2
Received: from EX19D011EUA001.ant.amazon.com (10.252.50.114) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 15 Oct 2024 17:42:46 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D011EUA001.ant.amazon.com (10.252.50.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 15 Oct 2024 17:42:45 +0000
Received: from email-imr-corp-prod-iad-1box-1a-6851662a.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Tue, 15 Oct 2024 17:42:45 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com (dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com [10.253.103.172])
	by email-imr-corp-prod-iad-1box-1a-6851662a.us-east-1.amazon.com (Postfix) with ESMTP id C75D940660;
	Tue, 15 Oct 2024 17:42:44 +0000 (UTC)
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Firas
 Jahjah" <firasj@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH for-next 2/2] RDMA/efa: Add option to set QP service level on create
Date: Tue, 15 Oct 2024 17:42:42 +0000
Message-ID: <20241015174242.3490-3-mrgolin@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241015174242.3490-1-mrgolin@amazon.com>
References: <20241015174242.3490-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Using modify QP with AH attributes and IB_QP_AV flag set doesn't make
much sense for connectionless QP types like SRD. Add SL parameter to EFA
create QP user ABI and pass it to the device.

Reviewed-by: Firas Jahjah <firasj@amazon.com>
Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa_com_cmd.c | 1 +
 drivers/infiniband/hw/efa/efa_com_cmd.h | 1 +
 drivers/infiniband/hw/efa/efa_verbs.c   | 4 +++-
 include/uapi/rdma/efa-abi.h             | 3 ++-
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 206f377db27e..9e04edb9dbda 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -31,6 +31,7 @@ int efa_com_create_qp(struct efa_com_dev *edev,
 	create_qp_cmd.qp_alloc_size.recv_queue_depth =
 			params->rq_depth;
 	create_qp_cmd.uar = params->uarn;
+	create_qp_cmd.sl = params->sl;
 
 	if (params->unsolicited_write_recv)
 		EFA_SET(&create_qp_cmd.flags, EFA_ADMIN_CREATE_QP_CMD_UNSOLICITED_WRITE_RECV, 1);
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index 2599f8e58cc4..25f02c0d9698 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.h
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -27,6 +27,7 @@ struct efa_com_create_qp_params {
 	u16 pd;
 	u16 uarn;
 	u8 qp_type;
+	u8 sl;
 	u8 unsolicited_write_recv : 1;
 };
 
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index feb04cfdb8da..ca3af866a5df 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -676,7 +676,7 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 		goto err_out;
 	}
 
-	if (cmd.comp_mask || !is_reserved_cleared(cmd.reserved_90)) {
+	if (cmd.comp_mask || !is_reserved_cleared(cmd.reserved_98)) {
 		ibdev_dbg(&dev->ibdev,
 			  "Incompatible ABI params, unknown fields in udata\n");
 		err = -EINVAL;
@@ -732,6 +732,8 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 		create_qp_params.rq_base_addr = qp->rq_dma_addr;
 	}
 
+	create_qp_params.sl = cmd.sl;
+
 	if (cmd.flags & EFA_CREATE_QP_WITH_UNSOLICITED_WRITE_RECV)
 		create_qp_params.unsolicited_write_recv = true;
 
diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
index d689b8b34189..11b94b0b035b 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -95,7 +95,8 @@ struct efa_ibv_create_qp {
 	__u32 sq_ring_size; /* bytes */
 	__u32 driver_qp_type;
 	__u16 flags;
-	__u8 reserved_90[6];
+	__u8 sl;
+	__u8 reserved_98[5];
 };
 
 struct efa_ibv_create_qp_resp {
-- 
2.40.1


