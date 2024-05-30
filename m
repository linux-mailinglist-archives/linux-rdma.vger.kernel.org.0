Return-Path: <linux-rdma+bounces-2687-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F158D4B1D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 13:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB2D283CE4
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 11:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447481822D4;
	Thu, 30 May 2024 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sFzBlGkh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B834C17D357;
	Thu, 30 May 2024 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070126; cv=none; b=Es6O1ZK6ogXvcNymrFDYEdvvJSKaI01P8CuqQK5NcGmD9X2jr6KdWyKn62yUY7j49w+Qck/1ZlEe8S/qAZ9BSd+1qymMxV7LPiKpVEdCezYOQAMd9q+48vYutx9NcP5N7r8NLRBFdO8PVJSZEyQIOHTf/IPWDA7M9miJXvFSeAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070126; c=relaxed/simple;
	bh=Tka6UiC1uoB3TRMiDul+wp8wRtb86hr277VqYplsCxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eS3G66lnjIz+xvU5g/bDy0YGB1M2wHK22wJO3yb/c+UzYiGUxwkQBJmQ30VpuCUn6tWVrsqZUVBsYAoiZ6A3g5cX2S9av/TJ1707Me/GNILHMAkqKJrW/W8gbzbXQRA07oQMz4p4pwNZ6f5jYCp2FAW6fnioeW13Fnwwzf1bdWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sFzBlGkh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6F59B20B9260;
	Thu, 30 May 2024 04:55:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6F59B20B9260
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1717070123;
	bh=M3K5XGSDfWbI4lB7ESD4sp7zphrlBgbkJOr4pru6vAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sFzBlGkh2b/X90BdWWE4n3KeHDs6wSuxAmIQJbtw6/LXmCS/uLxFZDcopYIU9ZQSl
	 cFxIhrZJJljW83qBtnNUiavB596sD26CrQ3xjfIF2Q+sZVPskNChZvZC1WTP5Ci2Zy
	 FVQLZ/eR3PRnoxpucdyCTmedbsCWs0CB6xdDMbds=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 2/2] RDMA/mana_ib: extend query device
Date: Thu, 30 May 2024 04:55:17 -0700
Message-Id: <1717070117-1234-3-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1717070117-1234-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1717070117-1234-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Fill in properties of the ib device.
Order the assignment in the order of fields in the struct ib_device_attr.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
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
index 68c3b4f..59a7a35 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -27,6 +27,11 @@
  */
 #define MANA_IB_MAX_MR		0xFFFFFFu
 
+/*
+ * The CA timeout is approx. 260ms (4us * 2^(DELAY))
+ */
+#define MANA_CA_ACK_DELAY	16
+
 struct mana_ib_adapter_caps {
 	u32 max_sq_id;
 	u32 max_rq_id;
-- 
2.43.0


