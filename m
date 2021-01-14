Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF722F6AAC
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jan 2021 20:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbhANTPs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jan 2021 14:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbhANTPr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jan 2021 14:15:47 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C616C061575
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jan 2021 11:15:07 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d26so6926235wrb.12
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jan 2021 11:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Nah0Z12bXVObhm90/AgNXk0unawgWk7EywylHat3+M=;
        b=dIubmR0BQcsP2BUiW2mcPq4XrPadr19t718a9fQ67tSk8XTj+GAYEUaUODBlXy1biT
         gauZPGedH8NLGHy0kffOOV7qlvbAHtKiAvkq3bHapH1kiZpgf/dFVaAkH/etFfRX4EAF
         1RhRWa6DLJIFppUds12eG8K4cmB0X5vb4F46njEQbiZ9jFaDHTrbwD9a+zJPFOI4vcaX
         wnm0xjwaWbLZTBKPBBSIwTCrAPN71ZIcVasYAT92+lwnLhBpIWRcx8HpSHcHH68xFHfv
         xvjWSLKe83bNN6TvP5dT5vWQc9OtKvsoUa0doFPAS9YeizTTqDt0tFUy7f0VAbcNf01H
         i+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Nah0Z12bXVObhm90/AgNXk0unawgWk7EywylHat3+M=;
        b=oH9V0vRdgwioR2ArAedr0k5/Dfzz3E1Y1cfmp46VT0MPys2n5BGIY6V5EqhUVq6frc
         Ldf2FZX442TE4WZyTXqvkKxQ9faDfXRcbXOwOdLNGeT1Mc3DxAEILNpx8RXHx1cDED11
         4k1eFeuZ+FB4NZpggboethGc65lvfYbAWpGiQ9evj12N893deKsbHWpXRng2tg5lRSzs
         IF6tnmzIpYAisnlxbA1ACCaaHPdPitTs+c8IHjG8sYnwk8BfxKOnLiIPqDFLlav1YmAC
         aTV9t5iOr1UCr6a+ZYeNwr4k5CyEeuuuEF0mOVK0VEUBIIBfe3xBW4nJ0Yp29OJX6Xob
         Tg6Q==
X-Gm-Message-State: AOAM5334ax3ViuzE6luwufPXowJuyAUTvs2iljURH3CkNoVipIbR3Nq5
        GRVG/hhG28aKqymDOybcOSlU4N1Y9UQ=
X-Google-Smtp-Source: ABdhPJxzVMd8Yy/DEm3UH0MH6rzvBkWknToRzg4lr4cRYp5gzCy36tdb3wtjvkW8xa/wFBxlMjo42g==
X-Received: by 2002:a5d:660b:: with SMTP id n11mr9481417wru.407.1610651705823;
        Thu, 14 Jan 2021 11:15:05 -0800 (PST)
Received: from kheib-workstation.redhat.com ([77.137.152.100])
        by smtp.gmail.com with ESMTPSA id x17sm11470055wro.40.2021.01.14.11.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 11:15:05 -0800 (PST)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc] RDMA/cxgb4: Fix the reported max_recv_sge value
Date:   Thu, 14 Jan 2021 21:14:23 +0200
Message-Id: <20210114191423.423529-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The max_recv_sge value is wrongly reported when calling query_qp, This
is happening due to a typo when assigning the max_recv_sge value, the
value of sq_max_sges was assigned instead of rq_max_sges.

Fixes: 3e5c02c9ef9a ("iw_cxgb4: Support query_qp() verb")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/cxgb4/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index a7401398cb34..d109bb3822a5 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -2474,7 +2474,7 @@ int c4iw_ib_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	init_attr->cap.max_send_wr = qhp->attr.sq_num_entries;
 	init_attr->cap.max_recv_wr = qhp->attr.rq_num_entries;
 	init_attr->cap.max_send_sge = qhp->attr.sq_max_sges;
-	init_attr->cap.max_recv_sge = qhp->attr.sq_max_sges;
+	init_attr->cap.max_recv_sge = qhp->attr.rq_max_sges;
 	init_attr->cap.max_inline_data = T4_MAX_SEND_INLINE;
 	init_attr->sq_sig_type = qhp->sq_sig_all ? IB_SIGNAL_ALL_WR : 0;
 	return 0;
-- 
2.26.2

