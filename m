Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B386134CF
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Oct 2022 12:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiJaLpu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Oct 2022 07:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiJaLpN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Oct 2022 07:45:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7B9EE1A;
        Mon, 31 Oct 2022 04:45:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC40B60FD3;
        Mon, 31 Oct 2022 11:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB92C433C1;
        Mon, 31 Oct 2022 11:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667216710;
        bh=Z7a3Uy401OHjnzkVuyZzMaPtXD6RGqSJ3Gr9uE6GveA=;
        h=From:To:Cc:Subject:Date:From;
        b=Gg7cTrAgdQPxH+Hico6RhSNMP2l7ogese3Ca7q2zb9PlEtxD0PMtkIPLRpgYXZCNF
         QJhjvqgY5BMI7W9R4GAif77YQgKEPb9nZQI7I3Wjx0TbWKLBaicHkwMe4fjRgvwXlp
         9On2PRzeW+ryhnI3UFp5ZNFguRev0jN8GIFe5zUSvuI3AiYB7HMaaRc+RoT4E2EORf
         ntrMWTeDiswV+NFXOMYQ+nqCYpYeIcu0o7ut0JO9tKMdH2IFGIbsW6uSi+ot42FGI6
         W3M3IvcfWvNQNxqxudipEsyAesC4V6q/V8oe+gsL6Em5S3rn96x7pPaoFrzoNxGN0b
         aKdWdH1oFbB0g==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     bvanassche@acm.org
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Martin Liska <mliska@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/srp (gcc13): force int types for max_send_sge and can_queue
Date:   Mon, 31 Oct 2022 12:45:06 +0100
Message-Id: <20221031114506.10501-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since gcc13, each member of an enum has the same type as the enum [1]. And
that is inherited from its members. Provided "SRP_TAG_TSK_MGMT = 1U << 31",
SRP_MAX_SGE and SRP_TSK_MGMT_SQ_SIZE are unsigned ints.

This results in the following warnings:
  include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast
  drivers/infiniband/ulp/srp/ib_srp.c:563:42: note: in expansion of macro 'min'

  include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast
  drivers/infiniband/ulp/srp/ib_srp.c:2369:27: note: in expansion of macro 'min'

Force the use of min_t() instead of min() to use int for all those, as
this is what both targets
  target->scsi_host->can_queue
and
  init_attr->cap.max_send_sge
are.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=36113

Cc: Martin Liska <mliska@suse.cz>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 1075c2ac8fe2..7db487da8293 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -560,7 +560,8 @@ static int srp_create_ch_ib(struct srp_rdma_ch *ch)
 	init_attr->cap.max_send_wr     = m * target->queue_size;
 	init_attr->cap.max_recv_wr     = target->queue_size + 1;
 	init_attr->cap.max_recv_sge    = 1;
-	init_attr->cap.max_send_sge    = min(SRP_MAX_SGE, attr->max_send_sge);
+	init_attr->cap.max_send_sge    = min_t(int, SRP_MAX_SGE,
+			attr->max_send_sge);
 	init_attr->sq_sig_type         = IB_SIGNAL_REQ_WR;
 	init_attr->qp_type             = IB_QPT_RC;
 	init_attr->send_cq             = send_cq;
@@ -2366,7 +2367,7 @@ static void srp_cm_rep_handler(struct ib_cm_id *cm_id,
 		 * bounce requests back to the SCSI mid-layer.
 		 */
 		target->scsi_host->can_queue
-			= min(ch->req_lim - SRP_TSK_MGMT_SQ_SIZE,
+			= min_t(int, ch->req_lim - SRP_TSK_MGMT_SQ_SIZE,
 			      target->scsi_host->can_queue);
 		target->scsi_host->cmd_per_lun
 			= min_t(int, target->scsi_host->can_queue,
-- 
2.38.1

