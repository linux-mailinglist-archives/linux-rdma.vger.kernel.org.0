Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413E1782A90
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Aug 2023 15:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjHUNdP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Aug 2023 09:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbjHUNdO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Aug 2023 09:33:14 -0400
X-Greylist: delayed 554 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Aug 2023 06:33:13 PDT
Received: from out-41.mta1.migadu.com (out-41.mta1.migadu.com [IPv6:2001:41d0:203:375::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26470B1
        for <linux-rdma@vger.kernel.org>; Mon, 21 Aug 2023 06:33:13 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692624791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VyIAT3+Jd2Lnu4zWBloKJGIsEQcPyYynSUTyTN7NJV0=;
        b=EN18w9ViyJMIo6ACZAoI1pA+SHzY9mRD8rqopBuvUlITtSlvjMWt8RVAwNfMPwGnf758bs
        +fz61YSBZgQDD33CMH9RsvPcnX655cEl3SA21NhopCLlk76C8RE9DjiDB2X+Sif0KkmhCx
        /L+IMtmd2tGVAf4wMakxSkic9cT1j/c=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V3 1/3] RDMA/siw: Balance the reference of cep->kref in the error path
Date:   Mon, 21 Aug 2023 21:32:53 +0800
Message-Id: <20230821133255.31111-2-guoqing.jiang@linux.dev>
In-Reply-To: <20230821133255.31111-1-guoqing.jiang@linux.dev>
References: <20230821133255.31111-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
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

