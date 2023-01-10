Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0A16636CD
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jan 2023 02:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjAJBko (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 20:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbjAJBkV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 20:40:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0212D3D1DE;
        Mon,  9 Jan 2023 17:40:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E09E614B5;
        Tue, 10 Jan 2023 01:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77ACAC433D2;
        Tue, 10 Jan 2023 01:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673314815;
        bh=LFcmV1V/W4BleiubFsbg/Yh62d3qLU/7sOhf+QI1wO0=;
        h=Date:From:To:Cc:Subject:From;
        b=e+J6F6dAhWy+5bDkNCiVxxp6UNTQZiNCailDjUSTNvAJ0xt9RfcILPT+h7kqWM2UT
         bXxnb+0HUFo6dmEG4W/Q7A7zogQcp7fnewiErRYrdBD8ZTdZPxvwgvIluQStvK0y99
         xbKoCrGqdoloO72CtX8OwwuVd/TKeSW0vq2FDHD1Fvm1V+VU6iLtfGCDoQ/dMKQ2D2
         v0NiYWM/gEzSWvKGmD8FNwCgVxYToUZHjgjS8HYI1H+NsdP1is9Pk1PLq/GsOinVsH
         2wwv9czE5P5AQixpAHbqnzkn1PGXyzFxJOOuE3O8gLwEuD05oV+gIr/X9wv91loRkX
         qOKNa0l2XA8aA==
Date:   Mon, 9 Jan 2023 19:40:22 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>,
        Kai Shen <kaishen@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] RDMA/erdma: Replace zero-length arrays with
 flexible-array members
Message-ID: <Y7zCBqwC1LtabRJ9@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Zero-length arrays are deprecated[1] and we are moving towards
adopting C99 flexible-array members instead. So, replace zero-length
arrays, in a couple of structures, with flex-array members.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [2].

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
Link: https://github.com/KSPP/linux/issues/78
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/infiniband/hw/erdma/erdma_hw.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index ab371fec610c..4c38d99c73f1 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -397,7 +397,7 @@ struct erdma_write_sqe {
 
 	__le32 rsvd;
 
-	struct erdma_sge sgl[0];
+	struct erdma_sge sgl[];
 };
 
 struct erdma_send_sqe {
@@ -408,7 +408,7 @@ struct erdma_send_sqe {
 	};
 
 	__le32 length;
-	struct erdma_sge sgl[0];
+	struct erdma_sge sgl[];
 };
 
 struct erdma_readreq_sqe {
-- 
2.34.1

