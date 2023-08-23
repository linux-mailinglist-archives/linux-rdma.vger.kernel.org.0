Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910A37861D9
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Aug 2023 22:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbjHWU5r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Aug 2023 16:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbjHWU5g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Aug 2023 16:57:36 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFF910D8
        for <linux-rdma@vger.kernel.org>; Wed, 23 Aug 2023 13:57:33 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1bdf4752c3cso37856245ad.2
        for <linux-rdma@vger.kernel.org>; Wed, 23 Aug 2023 13:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692824253; x=1693429053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6uZ0t0e6sO58O3lizmIxk8RzijRuep9x2eYijlgjqg=;
        b=ShEnHiukgf++y3nV9Nx8WSgQjzuaX6/h9wGhNaLfE1/ec2zT9mf6VLRnZsXWJ8obCc
         5hUqfCCwbCE59IxLrrp5SPcI2Q3etIBSoNhX50Mutpv1am/QwwQGhWYgH1vdw+RIf3yV
         p8Pnp9MOKSYsHNxSqIZMjPLiBiuslp+vaCcIm537iVVlfqclc4QjJcVIMxtpf1/cx8yT
         uoBHjrDiJRBCGSRfdOJRVnRjyALNh32mNxXLyYA6EZqcjLKMl6NjliBNvayv0kkMl24c
         ACeLOgUmGoEnyYW5ycLiZo/EYbb6T/mBpu+vhL6i7QJ4wmE0MqsK414HXH9l960PLCGR
         mVWQ==
X-Gm-Message-State: AOJu0YyCvcJc2NJDjcymtD3YikejQuM8Zz/T0j26DY7b72iEAhR/Itku
        aU3y90mylIIQ6YitCMHT33o=
X-Google-Smtp-Source: AGHT+IEalzVJl+4Pvq0gnWcxgzRwrMuMXe3JvcwIXM5roJxhfI8+kRZv6VNma7vHsX7FyHMpflmj1Q==
X-Received: by 2002:a17:902:c94e:b0:1c0:b17a:7554 with SMTP id i14-20020a170902c94e00b001c0b17a7554mr2331472pla.64.1692824253102;
        Wed, 23 Aug 2023 13:57:33 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ecb6:e8b9:f433:b4b4])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b001befe0ac506sm11321138plg.175.2023.08.23.13.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 13:57:32 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] RDMA/srp: Do not call scsi_done() from srp_abort()
Date:   Wed, 23 Aug 2023 13:57:27 -0700
Message-ID: <20230823205727.505681-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

After scmd_eh_abort_handler() has called the SCSI LLD eh_abort_handler
callback, it performs one of the following actions:
* Call scsi_queue_insert().
* Call scsi_finish_command().
* Call scsi_eh_scmd_add().
Hence, SCSI abort handlers must not call scsi_done(). Otherwise all
the above actions would trigger a use-after-free. Hence remove the
scsi_done() call from srp_abort(). Keep the srp_free_req() call
before returning SUCCESS because we may not see the command again if
SUCCESS is returned.

Cc: Bob Pearson <rpearsonhpe@gmail.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: d8536670916a ("IB/srp: Avoid having aborted requests hang")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 0e513a7e5ac8..be003fa0168c 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2788,7 +2788,6 @@ static int srp_abort(struct scsi_cmnd *scmnd)
 	u32 tag;
 	u16 ch_idx;
 	struct srp_rdma_ch *ch;
-	int ret;
 
 	shost_printk(KERN_ERR, target->scsi_host, "SRP abort called\n");
 
@@ -2802,19 +2801,14 @@ static int srp_abort(struct scsi_cmnd *scmnd)
 	shost_printk(KERN_ERR, target->scsi_host,
 		     "Sending SRP abort for tag %#x\n", tag);
 	if (srp_send_tsk_mgmt(ch, tag, scmnd->device->lun,
-			      SRP_TSK_ABORT_TASK, NULL) == 0)
-		ret = SUCCESS;
-	else if (target->rport->state == SRP_RPORT_LOST)
-		ret = FAST_IO_FAIL;
-	else
-		ret = FAILED;
-	if (ret == SUCCESS) {
+			      SRP_TSK_ABORT_TASK, NULL) == 0) {
 		srp_free_req(ch, req, scmnd, 0);
-		scmnd->result = DID_ABORT << 16;
-		scsi_done(scmnd);
+		return SUCCESS;
 	}
+	if (target->rport->state == SRP_RPORT_LOST)
+		return FAST_IO_FAIL;
 
-	return ret;
+	return FAILED;
 }
 
 static int srp_reset_device(struct scsi_cmnd *scmnd)
