Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EE746FDD2
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Dec 2021 10:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhLJJhp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Dec 2021 04:37:45 -0500
Received: from smtp181.sjtu.edu.cn ([202.120.2.181]:38602 "EHLO
        smtp181.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhLJJhp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Dec 2021 04:37:45 -0500
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp181.sjtu.edu.cn (Postfix) with ESMTPS id 28D4210094B67;
        Fri, 10 Dec 2021 17:34:08 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id 0C171200CDB03;
        Fri, 10 Dec 2021 17:34:08 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JF3oZ51GzNj4; Fri, 10 Dec 2021 17:34:07 +0800 (CST)
Received: from ubuntu.localdomain (unknown [10.183.38.144])
        (Authenticated sender: billsjc@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id 68B6B200BFDAB;
        Fri, 10 Dec 2021 17:33:59 +0800 (CST)
From:   Jiacheng Shi <billsjc@sjtu.edu.cn>
To:     Wenpeng Liang <liangwenpeng@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Cc:     linux-rdma@vger.kernel.org, Jiacheng Shi <billsjc@sjtu.edu.cn>
Subject: [PATCH] RDMA/hns: Replace kfree with kvfree
Date:   Fri, 10 Dec 2021 01:32:55 -0800
Message-Id: <20211210093255.5478-1-billsjc@sjtu.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Variables allocated by kvzalloc should not be freed by kfree.
Because they may be allocated by vmalloc.
So we replace kfree with kvfree here.

Fixes: 6fd610c5733d ("RDMA/hns: Support 0 hop addressing for SRQ buffer")
Signed-off-by: Jiacheng Shi <billsjc@sjtu.edu.cn>
---
 drivers/infiniband/hw/hns/hns_roce_srq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 6eee9deadd12..e64ef6903fb4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -259,7 +259,7 @@ static int alloc_srq_wrid(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 
 static void free_srq_wrid(struct hns_roce_srq *srq)
 {
-	kfree(srq->wrid);
+	kvfree(srq->wrid);
 	srq->wrid = NULL;
 }
 
-- 
2.17.1

