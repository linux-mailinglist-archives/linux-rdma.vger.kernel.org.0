Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78605B2A73
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Sep 2022 01:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiIHXfN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 19:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiIHXeN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 19:34:13 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9550C305
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 16:32:12 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id fs14so14457856pjb.5
        for <linux-rdma@vger.kernel.org>; Thu, 08 Sep 2022 16:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=RIUvJWfbzBEXrJAcAY7oxmt5BHVfHCVf6zAEZsYz6YQ=;
        b=qiGq077uevEO1fkn1PVz2D1RUXwtFW40diRUcIiyluxqxorTGGmJUgWPcRdgevgJgE
         Ht017rhtBXi/wJjZZDnfqbf1QqyVsUC93afgRNBZ/bWo4njtcmv0Aq29YYUiiuf1mABi
         Td4RH7NLfpEzcC6ZZrHiBj04tArsxgpEw3mxGqJ2qEdBtOG8WjsGmThuEnVczBIXTKMS
         Nj2J3P16IJ3wmI/JL+jcNDq8xiBA6JETWhWGvc4Q1JOyMAAvaqZRTfziwAaUYAatrQSR
         vrztwbTBQlFAI/uM7sBmFCDFKbhT6jeUsez0Evbn7ZcXBYrpXBCKzAD5Rj/QLVZBhE5Q
         5SlA==
X-Gm-Message-State: ACgBeo25sfiLprMA2aSLaQS+elhxikmyOxwMAvUY1+UHYDnZONtZZjZR
        Ef83YU6HOH0KakKyHL/2DZ8=
X-Google-Smtp-Source: AA6agR6TfedSNIFq7gvWj6bxZgUGgKyFmbeGWaWvhRXtmNJcpt5ndWK5TlVFiOQ8nAVlfVV3l+UkkA==
X-Received: by 2002:a17:90b:4f44:b0:1f5:1310:9e7f with SMTP id pj4-20020a17090b4f4400b001f513109e7fmr6554030pjb.235.1662679931245;
        Thu, 08 Sep 2022 16:32:11 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:c18a:7410:112c:aa7c])
        by smtp.gmail.com with ESMTPSA id n20-20020a170903405400b00172a567d910sm51774pla.289.2022.09.08.16.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 16:32:10 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH] RDMA/srp: Fix srp_abort()
Date:   Thu,  8 Sep 2022 16:31:39 -0700
Message-Id: <20220908233139.3042628-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix the code for converting a SCSI command pointer into an SRP request
pointer.

Cc: Xiao Yang <yangx.jy@fujitsu.com>
Fixes: ad215aaea4f9 ("RDMA/srp: Make struct scsi_cmnd and struct srp_request adjacent")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 7720ea270ed8..b2e2f3d0b998 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2788,7 +2788,7 @@ static int srp_send_tsk_mgmt(struct srp_rdma_ch *ch, u64 req_tag, u64 lun,
 static int srp_abort(struct scsi_cmnd *scmnd)
 {
 	struct srp_target_port *target = host_to_target(scmnd->device->host);
-	struct srp_request *req = (struct srp_request *) scmnd->host_scribble;
+	struct srp_request *req = scsi_cmd_priv(scmnd);
 	u32 tag;
 	u16 ch_idx;
 	struct srp_rdma_ch *ch;
@@ -2796,8 +2796,6 @@ static int srp_abort(struct scsi_cmnd *scmnd)
 
 	shost_printk(KERN_ERR, target->scsi_host, "SRP abort called\n");
 
-	if (!req)
-		return SUCCESS;
 	tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmnd));
 	ch_idx = blk_mq_unique_tag_to_hwq(tag);
 	if (WARN_ON_ONCE(ch_idx >= target->ch_count))
