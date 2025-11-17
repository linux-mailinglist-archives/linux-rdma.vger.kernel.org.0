Return-Path: <linux-rdma+bounces-14523-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EC910C6280B
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 07:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 123BC353821
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 06:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4461C314D19;
	Mon, 17 Nov 2025 06:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EodzqlVh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77462155326
	for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 06:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763360699; cv=none; b=GIlkfv3m3LbavRUkDrti9bLMA3Ihcun8SwkbOgisgh63e3/KcdwzqBwiflajO3EeOOyEn7tV7baiCcSHnHlzFbLsrIjbPaXS4Ho0vsyAm4SiHSUGNiuV0U+JhcpPidqY6Ju93jmAfbSwK0U2P6nlh+lb0PLscV2G7ksgPAe4smo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763360699; c=relaxed/simple;
	bh=zN6MJWxXCT+MnqsRcqumSQbDZRhqttrakOtdjh3WoNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsO9BYRjGTSD9QXXmCdV/ZsVhFYAU4KvzK95Yh6MXUMTdh2JyH/URsq3gjnBMOostmt5UmXaDpuDi2ToODiet9zSwzyo42G6V1dRxtkmB9gIE4jesVUeoC+6GzofHzFmUCM6JFfVuJ6DnZ06POeZHywEaXdLEE9Jmb9WRH0eqHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EodzqlVh; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-640d790d444so3351807d50.0
        for <linux-rdma@vger.kernel.org>; Sun, 16 Nov 2025 22:24:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763360696; x=1763965496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mFaofxhVvrSojptWsJ5wXpG0++2BJTOfM+dugaceAU=;
        b=SqlQBYicV2T29VEKsQL5EwsMyw9VlNjHNRDN6FB07KbTXhrpKv/zxeXxdR091GvUG5
         joUptQg2z1BaR7N/FHH+I3LAgqWxRZiUYwMVcQZqzgqVCCndpj0sCBnH+uMBA9UbUBhg
         O1czHu8N//pyRbmPtGMRoBZ4LJ86sxlMaFkWlC37Hzz3R0/jlhToVfoSrJ6NgHaD/Q3t
         /jAIg3BElZBXdIadMqjStdss/MmLRXN6meDCkyTqn4J3BHFfYxpApeBU1LDIuUg6Hoc/
         rVX1Z0cS7GBdbeyZyIes2QczQiluLaYIYuDv5fW4CZh2mvLMRq8zt5bKFWs3c91Wb/lh
         H4rw==
X-Gm-Message-State: AOJu0YxTOg1XQTpyjAMjnZUuCLd8BgZT1+bKZ0nMPmF5WSLx/NlNpnxg
	MT7h/bpNFaopT6TFjLJhef5auhdIbqXD+xzyopcgcxIMYQko6vCdHl7jLs2STWcF7gEFaJAgs3g
	Rt6xVcTezRN0606Ox03TzBYzFSvvFXJPAI4SUerWQas+73enKBdnLGfoNs1XvGm1PC2xpAako9k
	hEBejeTahh1PzJRJhy7mEF8jeTvzl6AOpEiRG/5XFF7vGDoGjr/Q+6IsdsZEJz45qkct7bQQbNH
	fSw4/dgrImF/Quj9dtknzFynG5F
X-Gm-Gg: ASbGncszhGvrbgQFzM4gtPYf3n80V03BYbwWoseJlLMfGNVu7B1InR3GfK70FhZehUA
	FsbfDBad6HI5ix5UBj/yb6Nnejre2hhkChjFIYwfECQQRi4jp7EmiMdU/fa4S7O2bq7CsBLXOU4
	IBRQdvwjAGmn0p8k9Eou7clL7CGZN/b6pOXVSrIWdir+8/OSDql6QDMe9+cT4ySG1G3cP6LMyP+
	1Kaw2AEogsmETUTqwGYUuDjFPLVoLYtk7Dr76OGeORc5/2AC4PLirHM80NFzVnRkMt9hX5njcHd
	hLlV1eZ6pe7xWalfcl1QUpzHbPcxrDD/DR9HZAG+UWruDf6L6X9PgXsWUMxjkXabrfieAwO6n4Y
	j3wW8QWh5V2rcLBnCI4FRLIpwf9Ch/NR0OxNM0Rh69Uon0fDhtq4PGoOec6+Zt7OufcG6A2OyUc
	u/nPU0zA/+OQGiPuneIja6D+uFbtHzlMKhzETtNrB2q2jWXU2IkGtgSUWvCYE=
X-Google-Smtp-Source: AGHT+IGCTE8tKLl8b9Fhsy9ttOTObQdap0TWltY/SUDIj59LyRa4/vxVvs/XT4Y2SRyPaR/BQkFRIMlN/2xf
X-Received: by 2002:a05:690e:1598:10b0:63f:a3bf:b7ff with SMTP id 956f58d0204a3-641e7555780mr8374346d50.2.1763360696399;
        Sun, 16 Nov 2025 22:24:56 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6410eae9644sm617582d50.13.2025.11.16.22.24.55
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Nov 2025 22:24:56 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a998ab7f87so7231038b3a.3
        for <linux-rdma@vger.kernel.org>; Sun, 16 Nov 2025 22:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763360694; x=1763965494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mFaofxhVvrSojptWsJ5wXpG0++2BJTOfM+dugaceAU=;
        b=EodzqlVhQ++9DtUkrM7uWbNMKd92Z00CmTcqiqZpvLKU0uy+QY5KjM5O1YuePhf2N/
         Z0X3kuzRvKxP1Ws34/y0Yr9RkCC6dlfefa4F0JrfmoiNo58QA/uVRUIcJYWifjgz5lMO
         y5+6csrYGw2HADdkKTsNJUgValsK8Irh+p8vk=
X-Received: by 2002:a05:6a00:9290:b0:7b8:ac7f:5968 with SMTP id d2e1a72fcca58-7ba3c478446mr12901956b3a.24.1763360694501;
        Sun, 16 Nov 2025 22:24:54 -0800 (PST)
X-Received: by 2002:a05:6a00:9290:b0:7b8:ac7f:5968 with SMTP id d2e1a72fcca58-7ba3c478446mr12901945b3a.24.1763360694035;
        Sun, 16 Nov 2025 22:24:54 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927151d38sm11897785b3a.40.2025.11.16.22.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 22:24:53 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	Eddie Wai <eddie.wai@broadcom.com>
Subject: [PATCH rdma-next v4 1/5] RDMA/core: Add a marshalling function to copy from userspace
Date: Mon, 17 Nov 2025 11:47:37 +0530
Message-ID: <20251117061741.15752-2-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20251117061741.15752-1-sriharsha.basavapatna@broadcom.com>
References: <20251117061741.15752-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This patch adds a marshalling function to copy qp attributes
from userspace to kernel. This can be used by drivers or other
kernel modules that need to process struct ib_uverbs_qp_attr.

This patch also exports ib_resolve_eth_dmac(), so that drivers
can use it to resolve dgid after copying in qp attributes.

These functions will be used in a subsequent patch in this series.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Reviewed-by: Eddie Wai <eddie.wai@broadcom.com>
---
 drivers/infiniband/core/uverbs_marshall.c | 73 +++++++++++++++++++++++
 drivers/infiniband/core/verbs.c           |  8 +--
 include/rdma/ib_marshall.h                |  4 ++
 include/rdma/ib_verbs.h                   |  2 +-
 4 files changed, 81 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_marshall.c b/drivers/infiniband/core/uverbs_marshall.c
index e803f609ec87..388ecf8de371 100644
--- a/drivers/infiniband/core/uverbs_marshall.c
+++ b/drivers/infiniband/core/uverbs_marshall.c
@@ -32,6 +32,7 @@
 
 #include <linux/export.h>
 #include <rdma/ib_marshall.h>
+#include <rdma/ib_cache.h>
 
 #define OPA_DEFAULT_GID_PREFIX cpu_to_be64(0xfe80000000000000ULL)
 static int rdma_ah_conv_opa_to_ib(struct ib_device *dev,
@@ -171,3 +172,75 @@ void ib_copy_path_rec_to_user(struct ib_user_path_rec *dst,
 	__ib_copy_path_rec_to_user(dst, src);
 }
 EXPORT_SYMBOL(ib_copy_path_rec_to_user);
+
+static void ib_copy_ah_attr_from_user(struct ib_device *device,
+				      struct rdma_ah_attr *dst,
+				      struct ib_uverbs_ah_attr *src)
+{
+	int ah_flag;
+
+	ah_flag = src->is_global ? IB_AH_GRH : 0;
+	rdma_ah_set_ah_flags(dst, ah_flag);
+	rdma_ah_set_dlid(dst, src->dlid);
+	rdma_ah_set_sl(dst, src->sl);
+	rdma_ah_set_path_bits(dst, src->src_path_bits);
+	rdma_ah_set_static_rate(dst, src->static_rate);
+	rdma_ah_set_port_num(dst, src->port_num);
+
+	if (src->is_global) {
+		struct ib_global_route *grh = &dst->grh;
+		const struct ib_gid_attr *sgid_attr;
+
+		memset(grh, 0, sizeof(*grh));
+		sgid_attr = rdma_get_gid_attr(device, src->port_num,
+					      src->grh.sgid_index);
+		if (!IS_ERR(sgid_attr))
+			grh->sgid_attr = sgid_attr;
+		memcpy(&grh->dgid, src->grh.dgid, sizeof(grh->dgid));
+		grh->flow_label = src->grh.flow_label;
+		grh->sgid_index = src->grh.sgid_index;
+		grh->hop_limit = src->grh.hop_limit;
+		grh->traffic_class = src->grh.traffic_class;
+	}
+}
+
+void ib_copy_qp_attr_from_user(struct ib_device *device,
+			       struct ib_qp_attr *dst,
+			       struct ib_uverbs_qp_attr *src)
+{
+	dst->qp_state = src->qp_state;
+	dst->cur_qp_state = src->cur_qp_state;
+	dst->path_mtu = src->path_mtu;
+	dst->path_mig_state = src->path_mig_state;
+	dst->qkey = src->qkey;
+	dst->rq_psn = src->rq_psn;
+	dst->sq_psn = src->sq_psn;
+	dst->dest_qp_num = src->dest_qp_num;
+	dst->qp_access_flags = src->qp_access_flags;
+
+	dst->cap.max_send_wr = src->max_send_wr;
+	dst->cap.max_recv_wr = src->max_recv_wr;
+	dst->cap.max_send_sge = src->max_send_sge;
+	dst->cap.max_recv_sge = src->max_recv_sge;
+	dst->cap.max_inline_data = src->max_inline_data;
+
+	if (src->qp_attr_mask & IB_QP_AV)
+		ib_copy_ah_attr_from_user(device, &dst->ah_attr, &src->ah_attr);
+	if (src->qp_attr_mask & IB_QP_ALT_PATH)
+		ib_copy_ah_attr_from_user(device, &dst->alt_ah_attr, &src->alt_ah_attr);
+
+	dst->pkey_index = src->pkey_index;
+	dst->alt_pkey_index = src->alt_pkey_index;
+	dst->en_sqd_async_notify = src->en_sqd_async_notify;
+	dst->sq_draining = src->sq_draining;
+	dst->max_rd_atomic = src->max_rd_atomic;
+	dst->max_dest_rd_atomic = src->max_dest_rd_atomic;
+	dst->min_rnr_timer = src->min_rnr_timer;
+	dst->port_num = src->port_num;
+	dst->timeout = src->timeout;
+	dst->retry_cnt = src->retry_cnt;
+	dst->rnr_retry = src->rnr_retry;
+	dst->alt_port_num = src->alt_port_num;
+	dst->alt_timeout = src->alt_timeout;
+}
+EXPORT_SYMBOL(ib_copy_qp_attr_from_user);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 3a5f81402d2f..729d58c3326b 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -55,9 +55,6 @@
 #include "core_priv.h"
 #include <trace/events/rdma_core.h>
 
-static int ib_resolve_eth_dmac(struct ib_device *device,
-			       struct rdma_ah_attr *ah_attr);
-
 static const char * const ib_events[] = {
 	[IB_EVENT_CQ_ERR]		= "CQ error",
 	[IB_EVENT_QP_FATAL]		= "QP fatal error",
@@ -1732,8 +1729,8 @@ EXPORT_SYMBOL(ib_modify_qp_is_ok);
  * returns 0 on success or appropriate error code. It initializes the
  * necessary ah_attr fields when call is successful.
  */
-static int ib_resolve_eth_dmac(struct ib_device *device,
-			       struct rdma_ah_attr *ah_attr)
+int ib_resolve_eth_dmac(struct ib_device *device,
+			struct rdma_ah_attr *ah_attr)
 {
 	int ret = 0;
 
@@ -1752,6 +1749,7 @@ static int ib_resolve_eth_dmac(struct ib_device *device,
 	}
 	return ret;
 }
+EXPORT_SYMBOL(ib_resolve_eth_dmac);
 
 static bool is_qp_type_connected(const struct ib_qp *qp)
 {
diff --git a/include/rdma/ib_marshall.h b/include/rdma/ib_marshall.h
index b179e464e3d1..dd8817941f4c 100644
--- a/include/rdma/ib_marshall.h
+++ b/include/rdma/ib_marshall.h
@@ -22,4 +22,8 @@ void ib_copy_ah_attr_to_user(struct ib_device *device,
 void ib_copy_path_rec_to_user(struct ib_user_path_rec *dst,
 			      struct sa_path_rec *src);
 
+void ib_copy_qp_attr_from_user(struct ib_device *device,
+			       struct ib_qp_attr *dst,
+			       struct ib_uverbs_qp_attr *src);
+
 #endif /* IB_USER_MARSHALL_H */
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 0a85af610b6b..24cabb6a5770 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3117,7 +3117,7 @@ static inline bool ib_is_udata_cleared(struct ib_udata *udata,
  */
 bool ib_modify_qp_is_ok(enum ib_qp_state cur_state, enum ib_qp_state next_state,
 			enum ib_qp_type type, enum ib_qp_attr_mask mask);
-
+int ib_resolve_eth_dmac(struct ib_device *device, struct rdma_ah_attr *ah_attr);
 void ib_register_event_handler(struct ib_event_handler *event_handler);
 void ib_unregister_event_handler(struct ib_event_handler *event_handler);
 void ib_dispatch_event(const struct ib_event *event);
-- 
2.51.2.636.ga99f379adf


