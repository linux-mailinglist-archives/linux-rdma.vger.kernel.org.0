Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438952FE74F
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 11:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbhAUKP2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 05:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbhAUJro (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 04:47:44 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F3AC06138E
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:56 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a9so1055907wrt.5
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/z56S/t3xQgupRDRVcqi9lXvNCrBWFO94RXqxT4CMuQ=;
        b=qL6bk2OfCaDqiV1dsjLrmXbE3eDhjXTa/paqFHpv6GVUOlLVqfE82X803aM219wIE2
         UhkS7Ki0YMa7u4BMypzQfBrefVZRSPbJ5sZrSRU2OtValeT3N+LUIJHe85EQfwS5joSC
         yppbjdBD7Ld5/lsq07E/vIw02sn2+SwyjXAeEqoG6TrYUZvTOuX6xfcYgyalU6CSw1gL
         Va5A0Gn8FstqbqsA/m0uN9xDFHkX6y1vpUnFK/flTLvyTz2/x6xinjhZAZY6J5rZTAQH
         OWZXIH1CHqZkaRHfgFIcnsanU6jvg5wRF3ab6kZ9U7BbI0cnGT2clnDDDdcYVNliEL0b
         Q9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/z56S/t3xQgupRDRVcqi9lXvNCrBWFO94RXqxT4CMuQ=;
        b=uQV6wdnQ2b2hT3zpgzivirpN0hWCPKMBPF7SfcwNaUBl1Tu0dqA26as+sO5iUyl2nA
         Ot18P70Zj3BMhyLqcrR+SYi6ZIi5yVerZwuAxI6BWRCus09AzC21iXnW2kvY9hDes2VM
         lgWmepKsCsAJWk105JWVLLeO6AJ7cGPVgZtU2UicJKumMt7Yp/bxT23+1cnbS45nQ8jL
         8V1hyVOefHAfUx3ye5vCenVH+cDbxrGhUCPqBvQoHdOn//9X5opv0XKFUiJf9dT94gVa
         0eZLQpMu/bqrOy+ts8kIJ6hLbPaFYi2aVYd1Q8zzI5tqkqzP2KQJkCCIJgWHWOv/QR7M
         h+SQ==
X-Gm-Message-State: AOAM530+0aiJMKN2UII4uiLzLHDJuYC0jqq0QJ1fftuodbLGjOZFG6sQ
        5Exv9d/msCA/MQ6tFPyz1bPsXQ==
X-Google-Smtp-Source: ABdhPJxP9fP515TxSu/dojg5poCx1LFivE8imReVdPIJ84j5E6L788alyhlX1DaQIBkEcY7GUB3FMg==
X-Received: by 2002:adf:e54a:: with SMTP id z10mr13580456wrm.1.1611222355700;
        Thu, 21 Jan 2021 01:45:55 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:55 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 26/30] RDMA/sw/rdmavt/mr: Fix some issues related to formatting and missing descriptions
Date:   Thu, 21 Jan 2021 09:45:15 +0000
Message-Id: <20210121094519.2044049-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/sw/rdmavt/mr.c:380: warning: Function parameter or member 'virt_addr' not described in 'rvt_reg_user_mr'
 drivers/infiniband/sw/rdmavt/mr.c:449: warning: Function parameter or member 'qp' not described in 'rvt_dereg_clean_qp_cb'
 drivers/infiniband/sw/rdmavt/mr.c:449: warning: Function parameter or member 'v' not described in 'rvt_dereg_clean_qp_cb'
 drivers/infiniband/sw/rdmavt/mr.c:466: warning: Function parameter or member 'mr' not described in 'rvt_dereg_clean_qps'
 drivers/infiniband/sw/rdmavt/mr.c:484: warning: Function parameter or member 'mr' not described in 'rvt_check_refs'
 drivers/infiniband/sw/rdmavt/mr.c:484: warning: Function parameter or member 't' not described in 'rvt_check_refs'
 drivers/infiniband/sw/rdmavt/mr.c:513: warning: Function parameter or member 'mr' not described in 'rvt_mr_has_lkey'
 drivers/infiniband/sw/rdmavt/mr.c:513: warning: Function parameter or member 'lkey' not described in 'rvt_mr_has_lkey'
 drivers/infiniband/sw/rdmavt/mr.c:526: warning: Function parameter or member 'ss' not described in 'rvt_ss_has_lkey'
 drivers/infiniband/sw/rdmavt/mr.c:526: warning: Function parameter or member 'lkey' not described in 'rvt_ss_has_lkey'
 drivers/infiniband/sw/rdmavt/mr.c:551: warning: Function parameter or member 'udata' not described in 'rvt_dereg_mr'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/sw/rdmavt/mr.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
index 90fc234f489ac..601d18dda1f5a 100644
--- a/drivers/infiniband/sw/rdmavt/mr.c
+++ b/drivers/infiniband/sw/rdmavt/mr.c
@@ -369,6 +369,7 @@ struct ib_mr *rvt_get_dma_mr(struct ib_pd *pd, int acc)
  * @pd: protection domain for this memory region
  * @start: starting userspace address
  * @length: length of region to register
+ * @virt_addr: associated virtual address
  * @mr_access_flags: access flags for this memory region
  * @udata: unused by the driver
  *
@@ -438,8 +439,8 @@ struct ib_mr *rvt_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 
 /**
  * rvt_dereg_clean_qp_cb - callback from iterator
- * @qp - the qp
- * @v - the mregion (as u64)
+ * @qp: the qp
+ * @v: the mregion (as u64)
  *
  * This routine fields the callback for all QPs and
  * for QPs in the same PD as the MR will call the
@@ -457,7 +458,7 @@ static void rvt_dereg_clean_qp_cb(struct rvt_qp *qp, u64 v)
 
 /**
  * rvt_dereg_clean_qps - find QPs for reference cleanup
- * @mr - the MR that is being deregistered
+ * @mr: the MR that is being deregistered
  *
  * This routine iterates RC QPs looking for references
  * to the lkey noted in mr.
@@ -471,8 +472,8 @@ static void rvt_dereg_clean_qps(struct rvt_mregion *mr)
 
 /**
  * rvt_check_refs - check references
- * @mr - the megion
- * @t - the caller identification
+ * @mr: the megion
+ * @t: the caller identification
  *
  * This routine checks MRs holding a reference during
  * when being de-registered.
@@ -506,8 +507,8 @@ static int rvt_check_refs(struct rvt_mregion *mr, const char *t)
 
 /**
  * rvt_mr_has_lkey - is MR
- * @mr - the mregion
- * @lkey - the lkey
+ * @mr: the mregion
+ * @lkey: the lkey
  */
 bool rvt_mr_has_lkey(struct rvt_mregion *mr, u32 lkey)
 {
@@ -516,8 +517,8 @@ bool rvt_mr_has_lkey(struct rvt_mregion *mr, u32 lkey)
 
 /**
  * rvt_ss_has_lkey - is mr in sge tests
- * @ss - the sge state
- * @lkey
+ * @ss: the sge state
+ * @lkey: the lkey
  *
  * This code tests for an MR in the indicated
  * sge state.
@@ -540,7 +541,7 @@ bool rvt_ss_has_lkey(struct rvt_sge_state *ss, u32 lkey)
 /**
  * rvt_dereg_mr - unregister and free a memory region
  * @ibmr: the memory region to free
- *
+ * @udata: unused by the driver
  *
  * Note that this is called to free MRs created by rvt_get_dma_mr()
  * or rvt_reg_user_mr().
-- 
2.25.1

