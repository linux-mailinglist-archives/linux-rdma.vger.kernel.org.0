Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747443E1AAE
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Aug 2021 19:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240475AbhHERoB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 13:44:01 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:53731 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240502AbhHERn4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Aug 2021 13:43:56 -0400
Received: from localhost.localdomain ([217.128.214.245])
        by mwinf5d63 with ME
        id dtje250085JEng903tjfsu; Thu, 05 Aug 2021 19:43:39 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 05 Aug 2021 19:43:39 +0200
X-ME-IP: 217.128.214.245
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] RDMA/rtrs: Remove a useless kfree
Date:   Thu,  5 Aug 2021 19:43:36 +0200
Message-Id: <9a57c9f837fa2c6f0070578a1bc4840688f62962.1628185335.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

'sess->rbufs' is known to be NULL here, so there is no point in kfree'ing
it. It is just a no-op.

Remove the useless kfree.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index ece3205531b8..fc440a08e112 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1844,7 +1844,6 @@ static int rtrs_rdma_conn_established(struct rtrs_clt_con *con,
 		}
 
 		if (!sess->rbufs) {
-			kfree(sess->rbufs);
 			sess->rbufs = kcalloc(queue_depth, sizeof(*sess->rbufs),
 					      GFP_KERNEL);
 			if (!sess->rbufs)
-- 
2.30.2

