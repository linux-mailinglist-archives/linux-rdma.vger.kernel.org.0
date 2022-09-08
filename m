Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9395B1925
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 11:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiIHJqc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 05:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiIHJqa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 05:46:30 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D233DFF7F
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 02:46:30 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662630388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IDPEaQUg9JW2idPS5Rlt2k6szQfJ/4z00N3+2JpY6wE=;
        b=MVwEYhiNV6UIMPmaqfXZylQ6rKel4xZdDxLkhdOyttYWUkPjpO2cDjG+fZtkPdU5mebaXQ
        cg1AlkECNcnaNYXTiR23ig+qMJfEVb52mc/vBNWLtXJ3zG9kYj7yGU9QThnZ9LdD6KnzWb
        zTgYK36Gc4GtZiJ3xCmD5FOYMTrfuhI=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: [PATCH V2 1/3] RDMA/rtrs: Update comments for MAX_SESS_QUEUE_DEPTH
Date:   Thu,  8 Sep 2022 17:45:46 +0800
Message-Id: <20220908094548.4115-2-guoqing.jiang@linux.dev>
In-Reply-To: <20220908094548.4115-1-guoqing.jiang@linux.dev>
References: <20220908094548.4115-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The maximum queue_depth should be 65535 per check_module_params,
also update other relevant comments.

Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/ulp/rtrs/rtrs-pri.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index ac0df734eba8..a2420eecaf5a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -26,11 +26,10 @@
 /*
  * Max IB immediate data size is 2^28 (MAX_IMM_PAYL_BITS)
  * and the minimum chunk size is 4096 (2^12).
- * So the maximum sess_queue_depth is 65536 (2^16) in theory.
- * But mempool_create, create_qp and ib_post_send fail with
- * "cannot allocate memory" error if sess_queue_depth is too big.
+ * So the maximum sess_queue_depth is 65535 (2^16 - 1) in theory
+ * since queue_depth in rtrs_msg_conn_rsp is defined as le16.
  * Therefore the pratical max value of sess_queue_depth is
- * somewhere between 1 and 65534 and it depends on the system.
+ * somewhere between 1 and 65535 and it depends on the system.
  */
 #define MAX_SESS_QUEUE_DEPTH 65535
 
-- 
2.31.1

