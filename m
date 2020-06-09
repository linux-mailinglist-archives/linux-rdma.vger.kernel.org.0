Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE261F3B32
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2020 14:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgFIMzh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jun 2020 08:55:37 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:56324 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726903AbgFIMzh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 9 Jun 2020 08:55:37 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 4D1554C855
        for <linux-rdma@vger.kernel.org>; Tue,  9 Jun 2020 12:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1591707334; x=
        1593521735; bh=bu9LcH/TQyTsicUZ+Cd6YZb+Z6fz71eQ+9kt7bQ/CUw=; b=Y
        wVoaZgjaRxBvdxWfmyBbbfU9hAcZlZo48YfgRZsit0s4U+Ck/XzrTTXTrETsXeZ/
        P/sO46QLmqXV1Da/WZU9n1tnIZxJn7+/SqhktIWrfNhje0a47xV0majyARe6b+Lt
        QVbFzKuyvaRLjU3cmnCuB5FDGR9+rS2FGiuOke/jsc=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Df4DdE-TvmLA for <linux-rdma@vger.kernel.org>;
        Tue,  9 Jun 2020 15:55:34 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 51402412C9
        for <linux-rdma@vger.kernel.org>; Tue,  9 Jun 2020 15:55:34 +0300 (MSK)
Received: from localhost.localdomain (10.199.2.62) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 9 Jun
 2020 15:55:33 +0300
From:   <m.malygin@yadro.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <s.kojushev@yadro.com>, <linux@yadro.com>,
        Mikhail Malygin <m.malygin@yadro.com>
Subject: [PATCH] rdma_rxe: Prevent access to wr->next ptr afrer wr is posted to send queue
Date:   Tue, 9 Jun 2020 15:54:12 +0300
Message-ID: <20200609125411.13268-1-m.malygin@yadro.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.2.62]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mikhail Malygin <m.malygin@yadro.com>

rxe_post_send_kernel() iterates over linked list of wr's, until the wr->next ptr is NULL.
However it we've got an interrupt after last wr is posted, control may be returned
to the code after send completion callback is executed and wr memory is freed.
As a result, wr->next pointer may contain incorrect value leading to panic.

Signed-off-by: Mikhail Malygin <m.malygin@yadro.com>
Signed-off-by: Sergey Kojushev <s.kojushev@yadro.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index b8a22af724e8..a539b11b4f9b 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -684,6 +684,7 @@ static int rxe_post_send_kernel(struct rxe_qp *qp, const struct ib_send_wr *wr,
 	unsigned int mask;
 	unsigned int length = 0;
 	int i;
+	struct ib_send_wr *next;
 
 	while (wr) {
 		mask = wr_opcode_mask(wr->opcode, qp);
@@ -700,6 +701,8 @@ static int rxe_post_send_kernel(struct rxe_qp *qp, const struct ib_send_wr *wr,
 			break;
 		}
 
+		next = READ_ONCE(wr->next);
+
 		length = 0;
 		for (i = 0; i < wr->num_sge; i++)
 			length += wr->sg_list[i].length;
@@ -710,7 +713,7 @@ static int rxe_post_send_kernel(struct rxe_qp *qp, const struct ib_send_wr *wr,
 			*bad_wr = wr;
 			break;
 		}
-		wr = wr->next;
+		wr = next;
 	}
 
 	rxe_run_task(&qp->req.task, 1);
-- 
2.21.0

