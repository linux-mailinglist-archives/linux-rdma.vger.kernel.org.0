Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C931294BFE
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Oct 2020 13:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442080AbgJULuK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Oct 2020 07:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439571AbgJULuK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Oct 2020 07:50:10 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA550C0613CE
        for <linux-rdma@vger.kernel.org>; Wed, 21 Oct 2020 04:50:09 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b8so2833872wrn.0
        for <linux-rdma@vger.kernel.org>; Wed, 21 Oct 2020 04:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uViQvr4CutDyMVwLGiL9hKhcJx909feK+fBD2dkqOJg=;
        b=PwAzxqRooLJmLgp1mheFzKpH/CWLmRgaTXiaABZZ0lclWOJNOgzMNgQWwxxzayxbAP
         KS7lgQiW34d/sT0lkRJDFd3cUOwnn7mcsiSQcPKwqDp6xySgYhFKshyPaB+X7dqlIHP5
         O0IeXLxU6EmANizCqtEt2EDKPyQRwcxJMdJEfzjnyYj78D2aAn1N/d33Fom/p94EHixe
         GNPSZMV3qgW18D7JOuG4xt0mzKWZxiW7AaIWosmpwGQHgsa9eJ9ldLS3ZEhDk3NQyFE+
         R7szprNQmziX5Z+Zp0Vc2rDuc7fe/VxaiGIrE833JIiF0Cy+pqSyLroXamuWRUM9WTUN
         tlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uViQvr4CutDyMVwLGiL9hKhcJx909feK+fBD2dkqOJg=;
        b=nigP1wHywKRmBBkWTm54OSUzsbmWhXe59V2pa9tCnlYyAxN1Arh7vRbf42wVX4+Bcc
         2w76cyQfK1vKyoFmlCbBbehY2bSChwezm60UrRUuBZGd2rAFXCFPTqvLJ3FOdSCPofwu
         FHr0NS9qDxrvSzpZqMcnMtxEOfp04SY+ka7xw48g1IYInFsxuG9C7XBnoNrNGmWVGbL8
         zJs++hNz3N594fJ3u3EuGTd8J0/5o49irHeBm7RQn0e8KV0AM/i5ONPyfBSO8Wc2qkBc
         DPomfCIs29/lXjjzNZtDa37t+vg9scRxqY9vjsPe80fc0oW8JmPVMk0p+OV4vR5GI3xf
         VoOA==
X-Gm-Message-State: AOAM532IjQ8jHhAeLLoiCC+td30wm+khh1F0Xtmicim24asA2cCElwaT
        wbeqUNiWv4fWYhPiBaZMw8cS9b5wTEM=
X-Google-Smtp-Source: ABdhPJysBbsLXBKRESr1w076MX+7ubrxAbP5/XetcRhRPsMyJTp4L1O9dhltAmG+oM9YW9mmSDge0g==
X-Received: by 2002:adf:e64e:: with SMTP id b14mr4321065wrn.68.1603281008283;
        Wed, 21 Oct 2020 04:50:08 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([77.137.152.100])
        by smtp.gmail.com with ESMTPSA id i14sm2895892wml.24.2020.10.21.04.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 04:50:07 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc] RDMA/bnxt_re: Set queue pair state when being queried
Date:   Wed, 21 Oct 2020 14:49:52 +0300
Message-Id: <20201021114952.38876-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The API for ib_query_qp requires the driver to set cur_qp_state
on return, add the missing set.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index cf3db9628397..f9c999d5ba28 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2078,6 +2078,7 @@ int bnxt_re_query_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 		goto out;
 	}
 	qp_attr->qp_state = __to_ib_qp_state(qplib_qp->state);
+	qp_attr->cur_qp_state = __to_ib_qp_state(qplib_qp->cur_qp_state);
 	qp_attr->en_sqd_async_notify = qplib_qp->en_sqd_async_notify ? 1 : 0;
 	qp_attr->qp_access_flags = __to_ib_access_flags(qplib_qp->access);
 	qp_attr->pkey_index = qplib_qp->pkey_index;
-- 
2.26.2

