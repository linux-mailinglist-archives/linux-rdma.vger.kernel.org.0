Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A1C533DB0
	for <lists+linux-rdma@lfdr.de>; Wed, 25 May 2022 15:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbiEYNUl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 May 2022 09:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbiEYNUk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 May 2022 09:20:40 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB43114D13
        for <linux-rdma@vger.kernel.org>; Wed, 25 May 2022 06:20:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id f23-20020a7bcc17000000b003972dda143eso1092619wmh.3
        for <linux-rdma@vger.kernel.org>; Wed, 25 May 2022 06:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D7gU/pUQx39lHW/cZ81pthfitvLjThp19dHgJSgkmVY=;
        b=hAlxUPZ1PHc4ywg7cIJmRxBH8TETHT+Mqf3c0kYJrBYRRlk9VFQ9fQnQ/PZVgvbF0T
         CDE+UEUkXdqKPVHXrZnQXUXFXCuvKGdv9MCVXM7+LQUOQUBOkG+VvZpvRfjXmMoNPoeY
         /joGVXWRKeqKaoCAVzMk1GeFqIzpSDTCyXaKxlyGhZXlVkJFowLc7atOtKHlSbVcBREM
         n6gs7k5sPYNiyCDhYjnAbevXwZsqJ+iHj/kBRjZih5EnH80J9+67rkSCKmy7Pvl1ZfX/
         mxgy23dVvbyoDaXAO161On5N2J6ixFMFawjbW1J4YqHIj8OYAwMQmLukNWVnmD/Ypc7v
         qkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D7gU/pUQx39lHW/cZ81pthfitvLjThp19dHgJSgkmVY=;
        b=ohsZSOFn1iVyhwCMgbzt35kfBXQDt587VCmOoSEFRDt931DZaq2vO27xEVXQA6t7IE
         Im+vq/MVBGlvs1pocW+lKfUK6EwTH1UQt0ZZJE/c6X4HYm9CEDK23VRtv2670uIPZ7X/
         rNGejamhe7mGoSGAcsihkZTf+BJ4uUjyuYgglyd3/q6eUToTvY2Kyi1r68OoXQT+h49a
         HadLupsZvSNSAktz4atSnvOivL3cUbkftmEaaZPf7QmEUS0zZkUg14tru6qwKjnAulKS
         +nI/tBFqAvEuKYRYOmXI01yL//mDAjRncxoa31IIMhZelce8Q71Qrv4go6Ck4rBmwKwO
         J+8Q==
X-Gm-Message-State: AOAM530YqcivHfbi87zsEL7Gxa/QOqkSNlKV47+yyEoRBNVKUO/IxL/W
        6EaZVShd+jwY7sESl3D6WVFSvNDUDb4amTnd
X-Google-Smtp-Source: ABdhPJzUrMR1fK3PSYwV1OGOMVfOk+iUMjXM6b5ftEsFBZdcX/tiASBufuGVd77nkc3z3IaHGILjdA==
X-Received: by 2002:a05:600c:34d2:b0:397:7209:c1f0 with SMTP id d18-20020a05600c34d200b003977209c1f0mr1613850wmq.132.1653484837920;
        Wed, 25 May 2022 06:20:37 -0700 (PDT)
Received: from fedora.redhat.com ([2a00:a040:19b:e2ff::1005])
        by smtp.gmail.com with ESMTPSA id h1-20020a1ccc01000000b00397342e3830sm5429463wmb.0.2022.05.25.06.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:20:37 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/qedr: Fix reporting QP timeout attribute
Date:   Wed, 25 May 2022 16:20:29 +0300
Message-Id: <20220525132029.84813-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make sure to save the passed QP timeout attribute when the QP gets modified,
so when calling query QP the right value is reported and not the
converted value that is required by the firmware. This issue was found
while running the pyverbs tests.

Fixes: cecbcddf6461 ("qedr: Add support for QP verbs")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/qedr/qedr.h  | 1 +
 drivers/infiniband/hw/qedr/verbs.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qedr/qedr.h b/drivers/infiniband/hw/qedr/qedr.h
index 8def88cfa300..db9ef3e1eb97 100644
--- a/drivers/infiniband/hw/qedr/qedr.h
+++ b/drivers/infiniband/hw/qedr/qedr.h
@@ -418,6 +418,7 @@ struct qedr_qp {
 	u32 sq_psn;
 	u32 qkey;
 	u32 dest_qp_num;
+	u8 timeout;
 
 	/* Relevant to qps created from kernel space only (ULPs) */
 	u8 prev_wqe_size;
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index f0f43b6db89e..03ed7c0fae50 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -2613,6 +2613,8 @@ int qedr_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 					1 << max_t(int, attr->timeout - 8, 0);
 		else
 			qp_params.ack_timeout = 0;
+
+		qp->timeout = attr->timeout;
 	}
 
 	if (attr_mask & IB_QP_RETRY_CNT) {
@@ -2772,7 +2774,7 @@ int qedr_query_qp(struct ib_qp *ibqp,
 	rdma_ah_set_dgid_raw(&qp_attr->ah_attr, &params.dgid.bytes[0]);
 	rdma_ah_set_port_num(&qp_attr->ah_attr, 1);
 	rdma_ah_set_sl(&qp_attr->ah_attr, 0);
-	qp_attr->timeout = params.timeout;
+	qp_attr->timeout = qp->timeout;
 	qp_attr->rnr_retry = params.rnr_retry;
 	qp_attr->retry_cnt = params.retry_cnt;
 	qp_attr->min_rnr_timer = params.min_rnr_nak_timer;
-- 
2.34.3

