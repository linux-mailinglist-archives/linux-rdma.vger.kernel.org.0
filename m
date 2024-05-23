Return-Path: <linux-rdma+bounces-2598-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578518CD2F5
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2024 14:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8955D1C20DA9
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2024 12:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EB014B090;
	Thu, 23 May 2024 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XAd6g7P2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EE014AD22;
	Thu, 23 May 2024 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469145; cv=none; b=UemOJtNrwasWlJKz/wNeKwbs0SwWoT2dO2pBiNzwXZmh9yFC1btPMGYZDzxpoT/59P5QmPDbt56P5nOxEFnooOTNlIRlv5ctfDBDDZFXBruTHdN8ZZpH6EtM5h3nPTJPxR12bxFcqjhbDmkWEWIjeZF4CaBF9QP0OogZ7dao5KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469145; c=relaxed/simple;
	bh=TzqmEWYQYRlB9A7E5fvOxMBhhDs4D/LxR3mI+vbI3EQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rhzymEfmqd6syMVcOkrRYPyUmj7RF4bSB5dIdvIhTpS2In8ilsIMlzKDbAnbSm/ihLYv4DcZl1z1vvEdusXEcueWlSiejvLuxWBYLNbLAxMOJGqV42GW0mIOr6cI03NlhR5cJ6ZLqKZA0IrVZxD+US8/Kfcc5mkP4HUxDPnZ71M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XAd6g7P2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id AC2A920B9263;
	Thu, 23 May 2024 05:59:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AC2A920B9263
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1716469143;
	bh=JoQNMraYTyMht/kwTEqaGTIg8hspAYUeqmPqnJo0c8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XAd6g7P2Cyfgle6pcEjxBNnT+K/zxbTvbecj1EcvAH+PhB3PbSpiTycMyr4YyWdLz
	 xZvak/rQfXSU8D4qidCB1VFqdO1dJTk9TrpgyeYy7fgS3zkC1LdhOaz3TPA3VtpD0k
	 mifK9Az0ixxO4iDIfmkejLGcZWJmYeerFXogR8ng=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 2/2] RDMA/mana_ib: extend query device
Date: Thu, 23 May 2024 05:58:57 -0700
Message-Id: <1716469137-16844-3-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1716469137-16844-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1716469137-16844-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Fill in properties of the ib device.
Order the assignment in the order of fields in the struct ib_device_attr.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c    | 19 ++++++++++++++++---
 drivers/infiniband/hw/mana/mana_ib.h |  5 +++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 2a41135..814a61e 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -547,14 +547,27 @@ int mana_ib_query_device(struct ib_device *ibdev, struct ib_device_attr *props,
 	struct mana_ib_dev *dev = container_of(ibdev,
 			struct mana_ib_dev, ib_dev);
 
+	memset(props, 0, sizeof(*props));
+	props->max_mr_size = MANA_IB_MAX_MR_SIZE;
+	props->page_size_cap = PAGE_SZ_BM;
 	props->max_qp = dev->adapter_caps.max_qp_count;
 	props->max_qp_wr = dev->adapter_caps.max_qp_wr;
+	props->device_cap_flags = IB_DEVICE_RC_RNR_NAK_GEN;
+	props->max_send_sge = dev->adapter_caps.max_send_sge_count;
+	props->max_recv_sge = dev->adapter_caps.max_recv_sge_count;
+	props->max_sge_rd = dev->adapter_caps.max_recv_sge_count;
 	props->max_cq = dev->adapter_caps.max_cq_count;
 	props->max_cqe = dev->adapter_caps.max_qp_wr;
 	props->max_mr = dev->adapter_caps.max_mr_count;
-	props->max_mr_size = MANA_IB_MAX_MR_SIZE;
-	props->max_send_sge = dev->adapter_caps.max_send_sge_count;
-	props->max_recv_sge = dev->adapter_caps.max_recv_sge_count;
+	props->max_pd = dev->adapter_caps.max_pd_count;
+	props->max_qp_rd_atom = dev->adapter_caps.max_inbound_read_limit;
+	props->max_res_rd_atom = props->max_qp_rd_atom * props->max_qp;
+	props->max_qp_init_rd_atom = dev->adapter_caps.max_outbound_read_limit;
+	props->atomic_cap = IB_ATOMIC_NONE;
+	props->masked_atomic_cap = IB_ATOMIC_NONE;
+	props->max_ah = INT_MAX;
+	props->max_pkeys = 1;
+	props->local_ca_ack_delay = MANA_CA_ACK_DELAY;
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 68c3b4f..1348bfb 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -27,6 +27,11 @@
  */
 #define MANA_IB_MAX_MR		0xFFFFFFu
 
+/*
+ * The CA timeout is approx. 260ms
+ */
+#define MANA_CA_ACK_DELAY	16
+
 struct mana_ib_adapter_caps {
 	u32 max_sq_id;
 	u32 max_rq_id;
-- 
2.43.0


