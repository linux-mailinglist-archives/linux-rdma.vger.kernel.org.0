Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E992FF36B
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 19:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbhAUSOf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 13:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbhAUJq6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 04:46:58 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C71EC0617A5
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:38 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m187so865528wme.2
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZmdccX9MGdQfCu47xZuIw29j2db84mzV6TEw0Hxm3I=;
        b=RXfEMISkApvJA3X8uCs1LCUOrsUFhPeyVfGlOQ7pkh0y9c0OQtWMFY/1CVEcHPSqat
         3GSqPm9O5g1z103zHmOT7fJFBQNPeOBaSXKuZD2NV3gFgHz8uCSltK3r57ymgacA/idU
         WiQf5hMPEdMHo+Xa4y0fodRgwRouN95oO7A5Tkbkul8dHYsH8nbLL6EKg9e4Bxlmlfq2
         sn7thzyeTQg2xtSa8SP6cHPwtZPMwWd2T91gOQ6T9a8FUW1AHXufYUsJuD4g0B0/SNVk
         Z67DfPrDKMzZPyKTLOL9bwugDCOBCKu6zj0FL9mGx2rtRS9zKhrHhvots0tg13UKMNtD
         gWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZmdccX9MGdQfCu47xZuIw29j2db84mzV6TEw0Hxm3I=;
        b=qAPm2BSUTvGd6/Qd42ZtIUkW4PNwy7O2hacS7KkhenT9DHPZYj0BV65/8Mlztyz7/x
         wlecNCfipmuQES4CgGWcpGno2SOHjLlyWggtG2GKDF5iiP/Lf5qZ8hGNF6tQtv2SucdF
         l79qYOXSuwz77+toq5GKQZFmQV9I+AB6Z3QxyIW4SpI88vmNyfbZxt9gKtdCasiFnBEi
         XSPB5FwIYCMxHICJb6QzCdrdzs/r7JF2j/Itrak9w8KHTzBhfwHCK14ffUsWOG0KP6Mx
         +iK9PzUkbh8LgOPl+KP52W9z3Eqb2Q9Rfssul9sRDKhhtseEvPrTy8ZescWONmrS3JW+
         wW8g==
X-Gm-Message-State: AOAM533f7fhbWEddAov2J1iQAj0i6n4vgzoYDuqRaVHHj5AqG0ieF4e3
        uIH0p40HcXRMEjGQZ9Ji238pDg==
X-Google-Smtp-Source: ABdhPJyAV7xhFxtJvC8XZkrUWqxRc4o0L7r1xhjv7Hyp1oRpOtfmdbBFOgAUHJAmaBtH3a1xElKFkw==
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr8085626wmk.140.1611222336896;
        Thu, 21 Jan 2021 01:45:36 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:36 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 12/30] RDMA/hw/qib/qib_qp: Fix some issues in worthy kernel-doc headers and demote another
Date:   Thu, 21 Jan 2021 09:45:01 +0000
Message-Id: <20210121094519.2044049-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/qib/qib_qp.c:214: warning: Function parameter or member 'rdi' not described in 'qib_free_all_qps'
 drivers/infiniband/hw/qib/qib_qp.c:387: warning: Function parameter or member 'qp' not described in 'qib_check_send_wqe'
 drivers/infiniband/hw/qib/qib_qp.c:387: warning: Function parameter or member 'wqe' not described in 'qib_check_send_wqe'
 drivers/infiniband/hw/qib/qib_qp.c:387: warning: Function parameter or member 'call_send' not described in 'qib_check_send_wqe'
 drivers/infiniband/hw/qib/qib_qp.c:425: warning: Function parameter or member 's' not described in 'qib_qp_iter_print'
 drivers/infiniband/hw/qib/qib_qp.c:425: warning: Function parameter or member 'iter' not described in 'qib_qp_iter_print'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/qib/qib_qp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_qp.c b/drivers/infiniband/hw/qib/qib_qp.c
index 8d0563ef5be17..ca39a029e4af8 100644
--- a/drivers/infiniband/hw/qib/qib_qp.c
+++ b/drivers/infiniband/hw/qib/qib_qp.c
@@ -207,7 +207,7 @@ int qib_alloc_qpn(struct rvt_dev_info *rdi, struct rvt_qpn_table *qpt,
 	return ret;
 }
 
-/**
+/*
  * qib_free_all_qps - check for QPs still in use
  */
 unsigned qib_free_all_qps(struct rvt_dev_info *rdi)
@@ -376,9 +376,9 @@ void qib_flush_qp_waiters(struct rvt_qp *qp)
 
 /**
  * qib_check_send_wqe - validate wr/wqe
- * @qp - The qp
- * @wqe - The built wqe
- * @call_send - Determine if the send should be posted or scheduled
+ * @qp: The qp
+ * @wqe: The built wqe
+ * @call_send: Determine if the send should be posted or scheduled
  *
  * Returns 0 on success, -EINVAL on failure
  */
@@ -418,8 +418,8 @@ static const char * const qp_type_str[] = {
 
 /**
  * qib_qp_iter_print - print information to seq_file
- * @s - the seq_file
- * @iter - the iterator
+ * @s: the seq_file
+ * @iter: the iterator
  */
 void qib_qp_iter_print(struct seq_file *s, struct rvt_qp_iter *iter)
 {
-- 
2.25.1

