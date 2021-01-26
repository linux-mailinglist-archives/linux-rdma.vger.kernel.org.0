Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B55303DA5
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 13:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403796AbhAZMuB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 07:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392111AbhAZMt4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jan 2021 07:49:56 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3017C08EB25
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:51 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v15so16308922wrx.4
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4f4I65tHSu0Sevubz3lp3Zk+K7fk0+tHrgiLNeMd+Rc=;
        b=p4HdJ6LjNhnbcw4Rkb46d4O637uRz+G/y5kFGVkp3mw/I0eBw5VnPxLp4bvxxC6wPD
         GUyd4XS8uv/MF76CwjocbLJjE/kwtXYQ+If2ymHM+H/TPnFDJnXwSXLLdWBhlOJ4MQBn
         nNO/VP+yk6ec2yyGbteddQCv3ieCJxN/y5KZ+AnFkCHYtohS/SQxbSQxTaGYs3+iqI0P
         tOWUnxm8z/PTmJkNGaUVOnm9brIEBrrC6EjUD72jUJkyPtLQ5kljrZhftYjfpDSmgdec
         4yGsORj7TSSiL+/AspbTUt4v+Ni4/pBRg9UtqRw/eDSoHo/NE7EZm1Nbw+cuJCQqSOKh
         p+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4f4I65tHSu0Sevubz3lp3Zk+K7fk0+tHrgiLNeMd+Rc=;
        b=p7LtZfoJfgtPK51d2Q6H/plWSpTct/OdsYyp7+J8sPhHAvveYuzzuSNCEk8DKgGwWu
         3yROIjioc5uJZCmk43wJtDC8fXRDsFjJ4x+HTmiCfZMlfD9hNH/ircyRfNZYPXiiO328
         duktg3cgu1IDiFCX8PTQ62YpoJMdiCVufmrVGaAWEuVfA37Ke05Bv6bnq8QTC0MbCwcM
         yUlYkmPb5Oy6Qh/9IJ3oqn1Byp7nA3fcIVtINWX6c0j74l8f2J+fBQ2NHVDBd8XtkdG/
         Cj3d9IRccipj+/D3BLdDiPdruG2FpX1Ui6oVi4adsKYed/ohkn7oB9GH4KX14h3gOXbC
         aHmQ==
X-Gm-Message-State: AOAM530WS5kJAAcHEW+42tI09kpd+fY8CDDTef317crduAKPMq4xUhmO
        /O72Rgsu4lQEm3c9CkX7yuYCIgQgHiPVDMm1
X-Google-Smtp-Source: ABdhPJwFJFyJiQxPN+ieJwSG+epJ+dfgs4HDsCWwPmw6XySAq1DHWA1Fxp8sJuDlEEZ9YiFCba30Dg==
X-Received: by 2002:a5d:414c:: with SMTP id c12mr6099593wrq.251.1611665270492;
        Tue, 26 Jan 2021 04:47:50 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:49 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 13/20] RDMA/hw/hfi1/ruc: Fix a small formatting and description issues
Date:   Tue, 26 Jan 2021 12:47:25 +0000
Message-Id: <20210126124732.3320971-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hfi1/ruc.c:277: warning: Function parameter or member 'bth1' not described in 'hfi1_make_ruc_header_16B'
 drivers/infiniband/hw/hfi1/ruc.c:365: warning: Function parameter or member 'bth1' not described in 'hfi1_make_ruc_header_9B'
 drivers/infiniband/hw/hfi1/ruc.c:472: warning: Function parameter or member 'tid' not described in 'hfi1_schedule_send_yield'
 drivers/infiniband/hw/hfi1/ruc.c:472: warning: Excess function parameter 'timeout' description in 'hfi1_schedule_send_yield'

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hfi1/ruc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ruc.c b/drivers/infiniband/hw/hfi1/ruc.c
index 23ac6057b2112..c3fa1814c6a86 100644
--- a/drivers/infiniband/hw/hfi1/ruc.c
+++ b/drivers/infiniband/hw/hfi1/ruc.c
@@ -260,6 +260,7 @@ static inline void hfi1_make_ruc_bth(struct rvt_qp *qp,
  * @qp: the queue pair
  * @ohdr: a pointer to the destination header memory
  * @bth0: bth0 passed in from the RC/UC builder
+ * @bth1: bth1 passed in from the RC/UC builder
  * @bth2: bth2 passed in from the RC/UC builder
  * @middle: non zero implies indicates ahg "could" be used
  * @ps: the current packet state
@@ -348,6 +349,7 @@ static inline void hfi1_make_ruc_header_16B(struct rvt_qp *qp,
  * @qp: the queue pair
  * @ohdr: a pointer to the destination header memory
  * @bth0: bth0 passed in from the RC/UC builder
+ * @bth1: bth1 passed in from the RC/UC builder
  * @bth2: bth2 passed in from the RC/UC builder
  * @middle: non zero implies indicates ahg "could" be used
  * @ps: the current packet state
@@ -455,11 +457,10 @@ void hfi1_make_ruc_header(struct rvt_qp *qp, struct ib_other_headers *ohdr,
 /**
  * hfi1_schedule_send_yield - test for a yield required for QP
  * send engine
- * @timeout: Final time for timeout slice for jiffies
  * @qp: a pointer to QP
  * @ps: a pointer to a structure with commonly lookup values for
  *      the the send engine progress
- * @tid - true if it is the tid leg
+ * @tid: true if it is the tid leg
  *
  * This routine checks if the time slice for the QP has expired
  * for RC QPs, if so an additional work entry is queued. At this
-- 
2.25.1

