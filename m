Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902C6780710
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Aug 2023 10:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355634AbjHRIXs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Aug 2023 04:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358563AbjHRIXd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Aug 2023 04:23:33 -0400
Received: from out-49.mta0.migadu.com (out-49.mta0.migadu.com [91.218.175.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E192E2684
        for <linux-rdma@vger.kernel.org>; Fri, 18 Aug 2023 01:23:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692347010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jUeWjMC+Lt4smGefr0Lcat/Rgc4mAkUbEeVW6uOHdVY=;
        b=DKd8wzcnQVsDgLZ9kHnL+oktKM4TVEbKJOseVRT+wNF5UpTxMC3y8JxNXqOSoViBM2zCxM
        JD43PgEFid9gr/Ythfdcno+xk7ptctApjFD3Oj4WTflFiJNnAT5M8ZslJ7czWKFh9x4GXh
        1mIT4kq5YogWtOAio9x5q31iWi8MdCQ=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 1/3] RDMA/siw: Balance the reference of cep->kref in the error path
Date:   Fri, 18 Aug 2023 16:23:16 +0800
Message-Id: <20230818082318.17489-2-guoqing.jiang@linux.dev>
In-Reply-To: <20230818082318.17489-1-guoqing.jiang@linux.dev>
References: <20230818082318.17489-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The siw_connect can go to err in below after cep is allocated successfully:

1. If siw_cm_alloc_work returns failure. In this case socket is not
assoicated with cep so siw_cep_put can't be called by siw_socket_disassoc.
We need to call siw_cep_put twice since cep->kref is increased once after
it was initialized.

2. If siw_cm_queue_work can't find a work, which means siw_cep_get is not
called in siw_cm_queue_work, so cep->kref is increased twice by siw_cep_get
and when associate socket with cep after it was initialized. So we need to
call siw_cep_put three times (one in siw_socket_disassoc).

3. siw_send_mpareqrep returns error, this scenario is similar as 2.

So we need to remove one siw_cep_put in the error path.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_cm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index da530c0404da..a2605178f4ed 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1501,7 +1501,6 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 
 		cep->cm_id = NULL;
 		id->rem_ref(id);
-		siw_cep_put(cep);
 
 		qp->cep = NULL;
 		siw_cep_put(cep);
-- 
2.35.3

