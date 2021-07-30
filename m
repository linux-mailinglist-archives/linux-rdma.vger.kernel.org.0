Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4D53DBC27
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 17:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbhG3PXQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 11:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239664AbhG3PXQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Jul 2021 11:23:16 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D764CC06175F
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 08:23:10 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id x15so13604603oic.9
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 08:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WMhRFnMJKAyXZh8izjh+285MKWf3zi+yb1ztOuowMzI=;
        b=l4janx2r0NU5GOIq758igLYv/qLgTjaIY01agRRMx4nwxRy9VuND+ZgBd8QPafqtuE
         7n80KtDOXpTLF3QrF8G3bFr05zTmql1JmXAZ57LsGtfvuLGnwXRAr0YZJAwVcxqfSpra
         pLp3+QbmK0cOJdpJK+J7pEB4VO3K6LVaODM/lCmsDfFGVLDtAz9kIbkd8zCT3W/M9dIt
         lp5JAgP2mULTj1b0sK+NHP1/RX3hYO1MqY5sKVvOlWEau93Ly+ZvnVeIlVo/HHDM1jmv
         Q/gjghgtTOlb/xF96ldXpdwh7YyDmlsZNpH03wwlRGYRwbzNk2OYTPvyhy0YgmpW5s9i
         9u2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WMhRFnMJKAyXZh8izjh+285MKWf3zi+yb1ztOuowMzI=;
        b=Jp+4wHr4g+YXFRTAWqVvy2tO0LuzD4E0Lmy71Oa6gyQC6X/WqW0UKWyP4s7dgHsGv2
         e47fAqg6Z+GathU0MmPt1hE6VfnuGK8DbN7WzUKpnjr1A7MQZpAptmd0b03PzVSwZFEG
         svudcsR1z+SWRztP/kZ4vGWZUaIC2Gni6uX0EYN7NWGYHL623c9DWPwx1PrqYmpWb/3Q
         5yXGLZEFcaVPFvVrn7Hn7Hd09e1inlKBmVc9B1yEo3x+4qcWyXrzrZYkbRlllj3bN52x
         15lfYxiV97EfDZ7zdUO32p63CKZmTzaIRqt8ccJjCrMT/VsFFxEuNqXlX2uV2nBZc1YX
         M4Bw==
X-Gm-Message-State: AOAM532AGXYE8Knt7otteZ/eSNtyGEBIyePeTa6AgI1+QN1JD92AnZUW
        +DH10YsUvN3CPMl6ZLPs5GU=
X-Google-Smtp-Source: ABdhPJwPDfZJDUxDiMEFyDj1CXDahemw2p3S85HLpodjzADKwFxcisPUBochqATxT6AZX9koHVJRqg==
X-Received: by 2002:a05:6808:f04:: with SMTP id m4mr2293706oiw.92.1627658590358;
        Fri, 30 Jul 2021 08:23:10 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id x14sm335663oiv.4.2021.07.30.08.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 08:23:10 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, xyjxyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 2/5] Providers/rxe: Support alloc/dealloc xrcd
Date:   Fri, 30 Jul 2021 10:21:55 -0500
Message-Id: <20210730152157.67592-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730152157.67592-1-rpearsonhpe@gmail.com>
References: <20210730152157.67592-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add support for ibv_alloc_xrcd and ibv_dealloc_xrcd verbs.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 providers/rxe/rxe.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 0776279c..3bb9f01c 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -128,6 +128,44 @@ static int rxe_dealloc_pd(struct ibv_pd *pd)
 	return ret;
 }
 
+static struct ibv_xrcd *rxe_open_xrcd(struct ibv_context *context,
+					struct ibv_xrcd_init_attr *attr)
+{
+	struct verbs_xrcd *xrcd;
+	int xrcd_size = sizeof(*xrcd);
+	struct ibv_open_xrcd cmd = {};
+	size_t cmd_size = sizeof(cmd);
+	struct ib_uverbs_open_xrcd_resp resp = {};
+	size_t resp_size = sizeof(resp);
+	int ret;
+
+	xrcd = calloc(1, sizeof(*xrcd));
+	if (!xrcd)
+		return NULL;
+
+	ret = ibv_cmd_open_xrcd(context, xrcd, xrcd_size, attr,
+				&cmd, cmd_size, &resp, resp_size);
+	if (ret) {
+		free(xrcd);
+		return NULL;
+	}
+
+	return &xrcd->xrcd;
+}
+
+static int rxe_close_xrcd(struct ibv_xrcd *ibxrcd)
+{
+	struct verbs_xrcd *xrcd = container_of(ibxrcd,
+					struct verbs_xrcd, xrcd);
+	int ret;
+
+	ret = ibv_cmd_close_xrcd(xrcd);
+	if (!ret)
+		free(xrcd);
+
+	return ret;
+}
+
 static struct ibv_mw *rxe_alloc_mw(struct ibv_pd *ibpd, enum ibv_mw_type type)
 {
 	int ret;
@@ -1742,6 +1780,8 @@ static const struct verbs_context_ops rxe_ctx_ops = {
 	.query_port = rxe_query_port,
 	.alloc_pd = rxe_alloc_pd,
 	.dealloc_pd = rxe_dealloc_pd,
+	.open_xrcd = rxe_open_xrcd,
+	.close_xrcd = rxe_close_xrcd,
 	.reg_mr = rxe_reg_mr,
 	.dereg_mr = rxe_dereg_mr,
 	.alloc_mw = rxe_alloc_mw,
-- 
2.30.2

