Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7797A649E62
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Dec 2022 13:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiLLMET (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Dec 2022 07:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiLLMES (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Dec 2022 07:04:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F9B263E;
        Mon, 12 Dec 2022 04:04:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AECFBB80CBB;
        Mon, 12 Dec 2022 12:04:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9383C433EF;
        Mon, 12 Dec 2022 12:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670846655;
        bh=vKOeKHiidJ0Hs3aQY2B6C83IGXF8fBzbV7+v+FLA2NA=;
        h=From:To:Cc:Subject:Date:From;
        b=JqwKP4Z69ddJ+sBCz3Zeoy3nHPa8IAMhBMPdQ3vu2Fd4N3iFkIYSz4WnFJc2c2hEM
         gjlWKqL+t7g6aPKyHCrOEGdIeYcIiMK4vj5ply/gVGLtyPKEL+YE9WcqJvcpWy7j+F
         uk+jyzk5XE5WbF9Q+407BPZOLH5VAaGRJGdqm5ElLLInuiL5OjAlxo+3jy/blS0gIG
         +F4XD7iK8upcVoUKoWPzfUyhUnHQel5U1oN5JqEri725qLoaj4UtNb1aZwemaqo3bL
         UKEWqwbeSLmx8YSKd6US/30PgHq/KtscQO7nl2DvXZxoF0ITm90yc5uZH44QC/hyV0
         HiG1+J6UF92SA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     bvanassche@acm.org
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Martin Liska <mliska@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH v2] RDMA/srp (gcc13): move large values to a new enum
Date:   Mon, 12 Dec 2022 13:04:11 +0100
Message-Id: <20221212120411.13750-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since gcc13, each member of an enum has the same type as the enum [1]. And
that is inherited from its members. Provided these two:
  SRP_TAG_NO_REQ        = ~0U,
  SRP_TAG_TSK_MGMT	= 1U << 31
all other members are unsigned ints.

Esp. with SRP_MAX_SGE and SRP_TSK_MGMT_SQ_SIZE and their use in min(),
this results in the following warnings:
  include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast
  drivers/infiniband/ulp/srp/ib_srp.c:563:42: note: in expansion of macro 'min'

  include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast
  drivers/infiniband/ulp/srp/ib_srp.c:2369:27: note: in expansion of macro 'min'

So move the large values away to a separate enum, so that they don't
affect other members.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=36113

Cc: Martin Liska <mliska@suse.cz>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---

Notes:
    [v2] move to a new enum instead of min_t()s (Bart)

 drivers/infiniband/ulp/srp/ib_srp.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.h b/drivers/infiniband/ulp/srp/ib_srp.h
index 00b0068fda20..5d94db453df3 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.h
+++ b/drivers/infiniband/ulp/srp/ib_srp.h
@@ -62,9 +62,6 @@ enum {
 	SRP_DEFAULT_CMD_SQ_SIZE = SRP_DEFAULT_QUEUE_SIZE - SRP_RSP_SQ_SIZE -
 				  SRP_TSK_MGMT_SQ_SIZE,
 
-	SRP_TAG_NO_REQ		= ~0U,
-	SRP_TAG_TSK_MGMT	= 1U << 31,
-
 	SRP_MAX_PAGES_PER_MR	= 512,
 
 	SRP_MAX_ADD_CDB_LEN	= 16,
@@ -79,6 +76,11 @@ enum {
 				  sizeof(struct srp_imm_buf),
 };
 
+enum {
+	SRP_TAG_NO_REQ		= ~0U,
+	SRP_TAG_TSK_MGMT	= BIT(31),
+};
+
 enum srp_target_state {
 	SRP_TARGET_SCANNING,
 	SRP_TARGET_LIVE,
-- 
2.38.1

