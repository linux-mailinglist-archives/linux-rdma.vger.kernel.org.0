Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FE4222B72
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 21:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgGPTEt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jul 2020 15:04:49 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:52822 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728163AbgGPTEs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Jul 2020 15:04:48 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 2A24E4C902;
        Thu, 16 Jul 2020 19:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1594926286; x=1596740687; bh=X4TZGBAUf5vX9JLS7EYzM7MXc2vlhi62npF
        VwZnVl6Y=; b=rlpkAoHSBJDKQgioQpjXIJLHzbMbzAmkCqvpOu5JpktyrNGjowj
        H4/Bop3KlUqF1ALlkbJ6pxM9si6UHJvR2fyKp6f7Y9fOx6VqbuJcknmYYIBoYttX
        VPL6F8cSeBOl484tDGFmMxrMJCGksKPa7E0LeMWnj21l316x3Pb5ru4A=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ecya5LEdMvIk; Thu, 16 Jul 2020 22:04:46 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id F25C14C877;
        Thu, 16 Jul 2020 22:04:45 +0300 (MSK)
Received: from localhost.localdomain (10.199.2.86) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 16
 Jul 2020 22:04:37 +0300
From:   <m.malygin@yadro.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <linux@yadro.com>, <jgg@nvidia.com>,
        Mikhail Malygin <m.malygin@yadro.com>,
        Sergey Kojushev <s.kojushev@yadro.com>
Subject: [PATCH v2] rdma_rxe: Prevent access to wr->next ptr afrer wr is posted to send queue
Date:   Thu, 16 Jul 2020 22:03:41 +0300
Message-ID: <20200716190340.23453-1-m.malygin@yadro.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200609125411.13268-1-m.malygin@yadro.com>
References: <20200609125411.13268-1-m.malygin@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.2.86]
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
index b8a22af724e8..84fec5fd798d 100644
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
 
+		next = wr->next;
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
2.26.2

