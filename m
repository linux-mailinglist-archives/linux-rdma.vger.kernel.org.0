Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D552BBAD2
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Nov 2020 01:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgKUAZk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Nov 2020 19:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgKUAZk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Nov 2020 19:25:40 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCB6C0613CF;
        Fri, 20 Nov 2020 16:25:38 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id z21so15878589lfe.12;
        Fri, 20 Nov 2020 16:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HZIPnEA5dzlkIwnEZ0yykdrPjovgQlTtEkygolng4EI=;
        b=AmSrNYjTnk/Yuy0vu6nm77dBwX1lCu10x2k+1h/W8GGmd7ABUF17Vpksyxo4MdzNPA
         mVWJNFsfBNR9LwJTsDHR2o3NVOcbhpJpvN7tru+5bQ2ecTOJifuhEJWa/IWhREA18Sm0
         hTKE8fu44xB8m22AQof0Ltq61l2L/Tg4Ha9c1DBFoe2HXKVuAR9ThjoIqIc/oaaxNVYF
         FRC8j7G9XJRhtsuHKjSGjBLbARSktuxQkQbSt5RsKSSui+Thhb4lqW/REZyhDngH4QYj
         2WSAgL7FZglvPacG26jyEHg7MiuTQ9kPj44zTMZyhELxb3SdpUeY1y2DKA/ifaeXVBDM
         a6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HZIPnEA5dzlkIwnEZ0yykdrPjovgQlTtEkygolng4EI=;
        b=I91SBB5f4ZJaP0LckYTTflQ0m5xksXMc1/U2vnCuXx3cCO+oXnEcB58aHTp+EnKUDV
         lsf9ShckfS4EA65Q+I/ZGledW9/YeovCDbJDTNf+bSH/3WZBJzF0XshcPRIirHHv7nMD
         5paNx2NWpUOm+tV9aWhwprNVQvT17RDAgcxCCS5BM5vHebZsNbuv8HD6yOaTCu2OFwOK
         LL6kEPysucZpHVutGmsnlrrcKIElex2ZpCFRgKuoJxeE14gUQGh8Wy2Ijs9ehqSGQoUX
         /4i/Pu9J0VbEYS2cgnYDE2OZrr+DXcJ71qrdFVdJO2Dk1fe7IaUJAsDMJGel2NMhrASP
         JZzA==
X-Gm-Message-State: AOAM533GH1oUgAWbQ3UlRUZfqHDGVukMizxGCNni92l5FlsX24x2usRe
        s8UUdVc/e6mQQBX67leq044=
X-Google-Smtp-Source: ABdhPJwRW123ugXYYhyW8R8d1Aq2lA5BeYkDsmyWBkdQv6P+kC/UTpJWC3M4Z3r/JkqiGUk3Yc4hxQ==
X-Received: by 2002:a19:6417:: with SMTP id y23mr8742546lfb.399.1605918336859;
        Fri, 20 Nov 2020 16:25:36 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-6.NA.cust.bahnhof.se. [158.174.22.6])
        by smtp.gmail.com with ESMTPSA id w28sm432959ljd.48.2020.11.20.16.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 16:25:35 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH rdma-next] RDMA/i40iw: Constify ops structs
Date:   Sat, 21 Nov 2020 01:25:29 +0100
Message-Id: <20201121002529.89148-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The ops structs are never modified. Make them const to allow the
compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c | 20 ++++++++++----------
 drivers/infiniband/hw/i40iw/i40iw_type.h | 20 ++++++++++----------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
index 86d3f8aff329..7ed9826221c1 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
@@ -5098,7 +5098,7 @@ void i40iw_vsi_stats_free(struct i40iw_sc_vsi *vsi)
 	i40iw_hw_stats_stop_timer(vsi);
 }
 
-static struct i40iw_cqp_ops iw_cqp_ops = {
+static const struct i40iw_cqp_ops iw_cqp_ops = {
 	.cqp_init = i40iw_sc_cqp_init,
 	.cqp_create = i40iw_sc_cqp_create,
 	.cqp_post_sq = i40iw_sc_cqp_post_sq,
@@ -5107,7 +5107,7 @@ static struct i40iw_cqp_ops iw_cqp_ops = {
 	.poll_for_cqp_op_done = i40iw_sc_poll_for_cqp_op_done
 };
 
-static struct i40iw_ccq_ops iw_ccq_ops = {
+static const struct i40iw_ccq_ops iw_ccq_ops = {
 	.ccq_init = i40iw_sc_ccq_init,
 	.ccq_create = i40iw_sc_ccq_create,
 	.ccq_destroy = i40iw_sc_ccq_destroy,
@@ -5116,7 +5116,7 @@ static struct i40iw_ccq_ops iw_ccq_ops = {
 	.ccq_arm = i40iw_sc_ccq_arm
 };
 
-static struct i40iw_ceq_ops iw_ceq_ops = {
+static const struct i40iw_ceq_ops iw_ceq_ops = {
 	.ceq_init = i40iw_sc_ceq_init,
 	.ceq_create = i40iw_sc_ceq_create,
 	.cceq_create_done = i40iw_sc_cceq_create_done,
@@ -5126,7 +5126,7 @@ static struct i40iw_ceq_ops iw_ceq_ops = {
 	.process_ceq = i40iw_sc_process_ceq
 };
 
-static struct i40iw_aeq_ops iw_aeq_ops = {
+static const struct i40iw_aeq_ops iw_aeq_ops = {
 	.aeq_init = i40iw_sc_aeq_init,
 	.aeq_create = i40iw_sc_aeq_create,
 	.aeq_destroy = i40iw_sc_aeq_destroy,
@@ -5137,11 +5137,11 @@ static struct i40iw_aeq_ops iw_aeq_ops = {
 };
 
 /* iwarp pd ops */
-static struct i40iw_pd_ops iw_pd_ops = {
+static const struct i40iw_pd_ops iw_pd_ops = {
 	.pd_init = i40iw_sc_pd_init,
 };
 
-static struct i40iw_priv_qp_ops iw_priv_qp_ops = {
+static const struct i40iw_priv_qp_ops iw_priv_qp_ops = {
 	.qp_init = i40iw_sc_qp_init,
 	.qp_create = i40iw_sc_qp_create,
 	.qp_modify = i40iw_sc_qp_modify,
@@ -5156,14 +5156,14 @@ static struct i40iw_priv_qp_ops iw_priv_qp_ops = {
 	.iw_mr_fast_register = i40iw_sc_mr_fast_register
 };
 
-static struct i40iw_priv_cq_ops iw_priv_cq_ops = {
+static const struct i40iw_priv_cq_ops iw_priv_cq_ops = {
 	.cq_init = i40iw_sc_cq_init,
 	.cq_create = i40iw_sc_cq_create,
 	.cq_destroy = i40iw_sc_cq_destroy,
 	.cq_modify = i40iw_sc_cq_modify,
 };
 
-static struct i40iw_mr_ops iw_mr_ops = {
+static const struct i40iw_mr_ops iw_mr_ops = {
 	.alloc_stag = i40iw_sc_alloc_stag,
 	.mr_reg_non_shared = i40iw_sc_mr_reg_non_shared,
 	.mr_reg_shared = i40iw_sc_mr_reg_shared,
@@ -5172,7 +5172,7 @@ static struct i40iw_mr_ops iw_mr_ops = {
 	.mw_alloc = i40iw_sc_mw_alloc
 };
 
-static struct i40iw_cqp_misc_ops iw_cqp_misc_ops = {
+static const struct i40iw_cqp_misc_ops iw_cqp_misc_ops = {
 	.manage_push_page = i40iw_sc_manage_push_page,
 	.manage_hmc_pm_func_table = i40iw_sc_manage_hmc_pm_func_table,
 	.set_hmc_resource_profile = i40iw_sc_set_hmc_resource_profile,
@@ -5195,7 +5195,7 @@ static struct i40iw_cqp_misc_ops iw_cqp_misc_ops = {
 	.update_resume_qp = i40iw_sc_resume_qp
 };
 
-static struct i40iw_hmc_ops iw_hmc_ops = {
+static const struct i40iw_hmc_ops iw_hmc_ops = {
 	.init_iw_hmc = i40iw_sc_init_iw_hmc,
 	.parse_fpm_query_buf = i40iw_sc_parse_fpm_query_buf,
 	.configure_iw_fpm = i40iw_sc_configure_iw_fpm,
diff --git a/drivers/infiniband/hw/i40iw/i40iw_type.h b/drivers/infiniband/hw/i40iw/i40iw_type.h
index c3babf3cbb8e..1dbf3991cc54 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_type.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_type.h
@@ -493,16 +493,16 @@ struct i40iw_sc_dev {
 	struct i40iw_sc_aeq *aeq;
 	struct i40iw_sc_ceq *ceq[I40IW_CEQ_MAX_COUNT];
 	struct i40iw_sc_cq *ccq;
-	struct i40iw_cqp_ops *cqp_ops;
-	struct i40iw_ccq_ops *ccq_ops;
-	struct i40iw_ceq_ops *ceq_ops;
-	struct i40iw_aeq_ops *aeq_ops;
-	struct i40iw_pd_ops *iw_pd_ops;
-	struct i40iw_priv_qp_ops *iw_priv_qp_ops;
-	struct i40iw_priv_cq_ops *iw_priv_cq_ops;
-	struct i40iw_mr_ops *mr_ops;
-	struct i40iw_cqp_misc_ops *cqp_misc_ops;
-	struct i40iw_hmc_ops *hmc_ops;
+	const struct i40iw_cqp_ops *cqp_ops;
+	const struct i40iw_ccq_ops *ccq_ops;
+	const struct i40iw_ceq_ops *ceq_ops;
+	const struct i40iw_aeq_ops *aeq_ops;
+	const struct i40iw_pd_ops *iw_pd_ops;
+	const struct i40iw_priv_qp_ops *iw_priv_qp_ops;
+	const struct i40iw_priv_cq_ops *iw_priv_cq_ops;
+	const struct i40iw_mr_ops *mr_ops;
+	const struct i40iw_cqp_misc_ops *cqp_misc_ops;
+	const struct i40iw_hmc_ops *hmc_ops;
 	struct i40iw_vchnl_if vchnl_if;
 	const struct i40iw_vf_cqp_ops *iw_vf_cqp_ops;
 
-- 
2.29.2

