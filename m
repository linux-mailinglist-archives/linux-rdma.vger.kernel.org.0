Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBCD6CF209
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 20:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjC2SSs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 14:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjC2SSr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 14:18:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF395FE1
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 11:18:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69F6AB820F8
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 18:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7452EC433D2;
        Wed, 29 Mar 2023 18:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680113924;
        bh=7WTLsb/dht3VWmMy46nyECkqsTsYn2YKjOmM0kDk1aM=;
        h=From:To:Cc:Subject:Date:From;
        b=KzIRYUXtjPpK7flzj/YvDDfyJTHTw3gc267iTYySn1X6i5Fc9oWkp6D1rhbnn9u27
         3U9h2tRPNnYGvym0ka82Q9w76uZwY8Ru4j8l7/PYG9z14vtTolCVuqk4fb2pLx2/Fi
         SPK+mXFPdrk2ctorcFsUdEwdqhFfZRD0Vqn43xNTR6ZFFCwxw8kEYu6vWHCTxb+ipU
         OH7cnVTJYEGnJwmatpBx/QNnUBy1d+u2yoRs8sItX01nh5C7zrAOgkrG71rsQBY2ht
         qFwXDq1xvzLa4k91NKS8j2ZOrIMPsc9fUJAaVYgunnTQIHiNGsGm1D6oJN0nOOnfBE
         JcdOU0mX2DYFA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Dan Carpenter <error27@gmail.com>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next] RDMA/rxe: Properly check tasklet state
Date:   Wed, 29 Mar 2023 21:18:38 +0300
Message-Id: <1a6376525c40454282a14ab659de0b17b02fe523.1680113901.git.leon@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Fix the following smatch error:

  drivers/infiniband/sw/rxe/rxe_task.c:24 __reserve_if_idle()
  warn: bitwise AND condition is false here

Fixes: d94671632572 ("RDMA/rxe: Rewrite rxe_task.c")
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/all/480b32b6-0f1c-4646-9ecc-e0760004cd24@kili.mountain
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/sw/rxe/rxe_task.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index fea9a517c8d9..48c89987137c 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -21,7 +21,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
 {
 	WARN_ON(rxe_read(task->qp) <= 0);
 
-	if (task->tasklet.state & TASKLET_STATE_SCHED)
+	if (task->tasklet.state == TASKLET_STATE_SCHED)
 		return false;
 
 	if (task->state == TASK_STATE_IDLE) {
@@ -46,7 +46,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
  */
 static bool __is_done(struct rxe_task *task)
 {
-	if (task->tasklet.state & TASKLET_STATE_SCHED)
+	if (task->tasklet.state == TASKLET_STATE_SCHED)
 		return false;
 
 	if (task->state == TASK_STATE_IDLE ||
-- 
2.39.2

