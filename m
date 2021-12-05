Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF86468D59
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Dec 2021 21:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238914AbhLEUtQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Dec 2021 15:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbhLEUtQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Dec 2021 15:49:16 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0D0C061714
        for <linux-rdma@vger.kernel.org>; Sun,  5 Dec 2021 12:45:48 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id o20so34666061eds.10
        for <linux-rdma@vger.kernel.org>; Sun, 05 Dec 2021 12:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nbJ4MFaXc6ifrYyBTsi/U/SgY1GHTonQF9TBbZ0bdR4=;
        b=eV5DCNZtGdLtpFrMhoSUiJfMgJyYU0w0Fk3+hwPwIuHyj5sVCZTyfhwBuTDbQmePbL
         uyttFAYWtYf2ClqyjyZQs4tSp5HFg7hARyj0Pk5BbPFM3+bBV/gHWyERMtPD/T5/gvya
         WP5C4gvpgDdQE2OOsH6IvaFOHu1pV3Qawj/MVPmPD/5vpS+BXhP0ABZmK8XCv0uRvS5G
         eTo4I32HhR7nq07m68RebkAS0rRt5+Axy3IqKdKfJdgJSWAMHldFCBbwdS7EPw7sBLlk
         9QEF778JNIdq3aS9L0xgTkTzIi1RFhJGmS9NDCWGDwPUXufn60V5Va7QoB8cE3kFGn3g
         qHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nbJ4MFaXc6ifrYyBTsi/U/SgY1GHTonQF9TBbZ0bdR4=;
        b=UU2nAt6ebZ+TNh5SoxVEZ7aYji34a6pyBW2YdLy3QDYP/dZP/OLSOc2VDzYnNNL4wU
         mski9v4T4/wjbK7KGgtgHAR3gWiVSERH5Pjbs2Hl/ec5zaE+AfIf2Nv94cerR2slr/xH
         7Htxs2rokQWsPlsLvBwU4UZkf6bv5kF9w+d3+PWrZem81B+jXPWshTE+WcCgRM1hpd1L
         nIhRUk5xYd5IMyDF7uFOcb9+twWDp2hsv1HNzzCfj/tysoWNCrcFtw+OEr+IAqFcFF17
         0xcs7Ty6yEKCzbwvfYdtIuX/VzSBMFuAhCPL3fUF6tiKgbqvJYmIFOrBy0kY+gMFOPuV
         gFuA==
X-Gm-Message-State: AOAM531eGKcF8pya9cU03qGogxb839GurkQNIMpEZCOpF3ja8nNVBxPF
        ftHyRq6SYjjTFW4IrFffAa4ECr6gqis=
X-Google-Smtp-Source: ABdhPJzqMV+a94n1Bt73451FNd2cjsF750Uc8KmAMJNjv2OJBaFAc+d8wk4z3ix7fHpi+qvfTwNnzw==
X-Received: by 2002:a17:907:2bd1:: with SMTP id gv17mr39571979ejc.231.1638737147219;
        Sun, 05 Dec 2021 12:45:47 -0800 (PST)
Received: from fedora.redhat.com ([2a00:a040:19b:e02f::1006])
        by smtp.gmail.com with ESMTPSA id h10sm6588742edj.1.2021.12.05.12.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 12:45:46 -0800 (PST)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH for-next] RDMA/bnxt_re: Fix endianness warning
Date:   Sun,  5 Dec 2021 22:45:37 +0200
Message-Id: <20211205204537.14184-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix the following sparce warning:
CHECK   ../drivers/infiniband/hw/bnxt_re/qplib_fp.c
drivers/infiniband/hw/bnxt_re/qplib_fp.c:1260:26: sparse: warning:
 incorrect type in assignment (different base types)

Fixes: 0e938533d96d ("RDMA/bnxt_re: Remove dynamic pkey table")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index f6472cca9ec7..96e581ced50e 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1257,7 +1257,7 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 		req.access = qp->access;
 
 	if (bmask & CMDQ_MODIFY_QP_MODIFY_MASK_PKEY)
-		req.pkey = IB_DEFAULT_PKEY_FULL;
+		req.pkey = cpu_to_le16(IB_DEFAULT_PKEY_FULL);
 
 	if (bmask & CMDQ_MODIFY_QP_MODIFY_MASK_QKEY)
 		req.qkey = cpu_to_le32(qp->qkey);
-- 
2.31.1

