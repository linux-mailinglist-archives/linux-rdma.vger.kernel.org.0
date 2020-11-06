Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7808D2AA09F
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Nov 2020 00:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgKFXCB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 18:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgKFXCB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Nov 2020 18:02:01 -0500
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D15DC0613CF
        for <linux-rdma@vger.kernel.org>; Fri,  6 Nov 2020 15:02:01 -0800 (PST)
Received: by mail-oo1-xc44.google.com with SMTP id c25so725663ooe.13
        for <linux-rdma@vger.kernel.org>; Fri, 06 Nov 2020 15:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TRO0BakIIKWem/ujlxzbuTfIwl/hCmyLNoKLk+l6IPk=;
        b=DOqXP9x9GfQZZdAYXdTUu6yLjwuG1zn09Lf3os1YuhC206G3nFDgk2vtPc4abXhbIR
         C8Z8W+QRYXoqiQPfiYhF7MD+6Ow99n6RuetXhPMDsgBr0fEP+uhsYfiAeWG8xVJ0//M8
         Y7J3iKgtfZBlsmt0B/sEM3D8jG+Ge3UINqDJk5UVnxZxJUxE1DmIhixwrxa3jPFhQbhw
         ejY6uiiTv69eXqNflR7GsN9wfvLIO6PJ24OlfKbrNVBJnmc8MiSVtv/ZPU5lCoIxV2TF
         K5hgpHj32ZFixjn0f6wx6TWb6OPg0GivjhKq+zuduANjxy0UGZvVDbdCYu+/fvyJsatt
         Qdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TRO0BakIIKWem/ujlxzbuTfIwl/hCmyLNoKLk+l6IPk=;
        b=DYt3qSaOEyyfDKQMz5UGSDDAmfgmWPrEBOzXTmBEnIrHLWBDWAsH61m+NebH+YIm90
         erZM2SUSWUxtvTh4wGwmkkYRUnzIDwqfcxjQj90X1AKuLNLenCJVEhAUF8sRf5PUvOuR
         k/gGbrwn31MQhzueb468CrWLLzmLEdTmm8rPKv4u/FEguM2nrUzVyFx33C2tn+NxV6Bv
         rP89PT+L+r+2Mdca8Za7XNWv3sY441st5rbWzYRuAbitXQ0i3ouXYTWKb/0uMh9uSUDE
         V6UOq4LQIdaxuCbpVQvasm/tI3Q+jFuWIhlJphCKYEX2RApGdQ/EmSpQvoRMcSG1F0gP
         759A==
X-Gm-Message-State: AOAM532CBJu49eQjtmQ82DJFyWq96QgyvM9mr2yenGXAA1ds10K/yLUG
        KrW2GIsEf21/J4jlCz+MU/A=
X-Google-Smtp-Source: ABdhPJz+8DUAX1gP+2tIbBQmBgfgnvJhlRwYUzRoHcxcqefVq+QJyXwaAPF6Po88Qf/jTfwKTglXnQ==
X-Received: by 2002:a4a:9486:: with SMTP id k6mr2807075ooi.85.1604703720442;
        Fri, 06 Nov 2020 15:02:00 -0800 (PST)
Received: from localhost (2603-8081-140c-1a00-f960-8e80-5b89-d06d.res6.spectrum.com. [2603:8081:140c:1a00:f960:8e80:5b89:d06d])
        by smtp.gmail.com with ESMTPSA id h6sm614340oia.51.2020.11.06.15.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 15:02:00 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 2/4] Provider/rxe: Implement ibv_query_device_ex verb
Date:   Fri,  6 Nov 2020 17:01:20 -0600
Message-Id: <20201106230122.17411-3-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201106230122.17411-1-rpearson@hpe.com>
References: <20201106230122.17411-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implement ibv_query_device_ex verb. Make it depend on a RXE_CAP_CMD_EX
capability bit supported by both provider and driver.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 kernel-headers/rdma/rdma_user_rxe.h |  1 +
 providers/rxe/rxe.c                 | 35 +++++++++++++++++++++++++++++
 providers/rxe/rxe.h                 |  2 +-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma_user_rxe.h
index 70ac031e..a31465e2 100644
--- a/kernel-headers/rdma/rdma_user_rxe.h
+++ b/kernel-headers/rdma/rdma_user_rxe.h
@@ -160,6 +160,7 @@ struct rxe_recv_wqe {
 
 enum rxe_capabilities {
 	RXE_CAP_NONE		= 0,
+	RXE_CAP_CMD_EX		= 1ULL << 0,
 };
 
 struct rxe_alloc_context_cmd {
diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index c29b7de5..b1fa2f42 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -87,6 +87,34 @@ static int rxe_query_device(struct ibv_context *context,
 	return 0;
 }
 
+static int rxe_query_device_ex(struct ibv_context *context,
+			       const struct ibv_query_device_ex_input *input,
+			       struct ibv_device_attr_ex *attr,
+			       size_t attr_size)
+{
+	int ret;
+	uint64_t raw_fw_ver;
+	unsigned int major, minor, sub_minor;
+	struct ibv_query_device_ex cmd = {};
+	struct ib_uverbs_ex_query_device_resp resp = {};
+
+	fprintf(stderr, "%s: called\n", __func__);
+	ret = ibv_cmd_query_device_ex(context, input, attr, sizeof(*attr),
+				      &raw_fw_ver, &cmd, sizeof(cmd),
+				      &resp, sizeof(resp));
+	if (ret)
+		return ret;
+
+	major = (raw_fw_ver >> 32) & 0xffff;
+	minor = (raw_fw_ver >> 16) & 0xffff;
+	sub_minor = raw_fw_ver & 0xffff;
+
+	snprintf(attr->orig_attr.fw_ver, sizeof(attr->orig_attr.fw_ver),
+		 "%d.%d.%d", major, minor, sub_minor);
+
+	return 0;
+}
+
 static int rxe_query_port(struct ibv_context *context, uint8_t port,
 			  struct ibv_port_attr *attr)
 {
@@ -860,6 +888,10 @@ static const struct verbs_context_ops rxe_ctx_ops = {
 	.free_context = rxe_free_context,
 };
 
+static const struct verbs_context_ops rxe_ctx_ops_cmd_ex = {
+	.query_device_ex = rxe_query_device_ex,
+};
+
 static struct verbs_context *rxe_alloc_context(struct ibv_device *ibdev,
 					       int cmd_fd,
 					       void *private_data)
@@ -883,6 +915,9 @@ static struct verbs_context *rxe_alloc_context(struct ibv_device *ibdev,
 
 	verbs_set_ops(&context->ibv_ctx, &rxe_ctx_ops);
 
+	if (context->capabilities & RXE_CAP_CMD_EX)
+		verbs_set_ops(&context->ibv_ctx, &rxe_ctx_ops_cmd_ex);
+
 	return &context->ibv_ctx;
 
 out:
diff --git a/providers/rxe/rxe.h b/providers/rxe/rxe.h
index 736cc30e..f9cae315 100644
--- a/providers/rxe/rxe.h
+++ b/providers/rxe/rxe.h
@@ -49,7 +49,7 @@ enum rdma_network_type {
 };
 
 enum rxe_provider_cap {
-	RXE_PROVIDER_CAP	= RXE_CAP_NONE,
+	RXE_PROVIDER_CAP	= RXE_CAP_CMD_EX,
 };
 
 struct rxe_device {
-- 
2.27.0

