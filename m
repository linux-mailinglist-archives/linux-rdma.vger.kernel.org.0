Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F980108A26
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2019 09:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfKYIkC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Nov 2019 03:40:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43266 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfKYIkB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Nov 2019 03:40:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id n1so16819877wra.10
        for <linux-rdma@vger.kernel.org>; Mon, 25 Nov 2019 00:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z47Ojrrp4Sr0aVG121k4/W8LgZr4mIcsGLIopDAFISU=;
        b=XGjAcvfcummEjUTitFMwW42z+zT+5KrFfIulzMFwDFWv6G9EX0pNTb2DBEgzYmM1ek
         ZhWAsfbOn7p4kOCU2GEJCULXNK9xg3oG1HpPKHg/YQnnPTbygdZ4NffjVd0IVxN0Z0SH
         YGD7Rd4YGgvYFI2HM/NCEDKoja7OycU19l/Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z47Ojrrp4Sr0aVG121k4/W8LgZr4mIcsGLIopDAFISU=;
        b=BJYeT9JaJM6psp+ULsvR59hVNpdaFDyFDxq67aAS6oPxLRHE2vDK2+SvWHzqAWYAkW
         mKPpz/lVjwT3IwBJRJIUkMVkyUL/l5ZjXgX/FZkXUC9UIfs1ZM5UMrgS7Va475dVtTY7
         zVHIRrZSlJVcbus1AtSq+RCu9iQ5Dy7uKfuV/gOonFZi0x7gyf6kZUS0rnaEATELUmB6
         zwDUQpqJZ9FniDOwBUK4MugUKGNW8BNGXOq/wWz+STh8K9JlLxtEhHzFv/c063TNHlGH
         0ssMHQmTqBQhs6U7SzXFUqNMIc0kxfl8FoougsGWeLzhJxcnv8a5MFY46KUw2jjbf4Uo
         FtQA==
X-Gm-Message-State: APjAAAVB1a2adlDWyk+ZbuCT+6R9ge5VTbcLocLl1dROQ33n1MWbK9hK
        YHI54/qL1iNl00xf7WzjF/CJxA==
X-Google-Smtp-Source: APXvYqx+vmTJgYgR/0ofEZH+gYv00GghqILCtp7Y9tXo5JRamYzXrJK9mYN9rXHn8lN6AGhxZZ3YFQ==
X-Received: by 2002:adf:f489:: with SMTP id l9mr29004000wro.337.1574671199526;
        Mon, 25 Nov 2019 00:39:59 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k4sm7996995wmk.26.2019.11.25.00.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 00:39:58 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 2/6] RDMA/bnxt_re: Fix Send Work Entry state check while polling completions
Date:   Mon, 25 Nov 2019 00:39:30 -0800
Message-Id: <1574671174-5064-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
References: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Some adapters need fence Work Entry to handle retransmission.
Currently the driver checks for this condition, only if the Send
queue entry is signalled. Implement the condition check, irrespective
of the signalled state of the Work queue entries

Fixes: 9152e0b722b2 ("RDMA/bnxt_re: HW workarounds for handling specific conditions")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 958c1ff..4d07d22 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -2283,13 +2283,13 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
 			/* Add qp to flush list of the CQ */
 			bnxt_qplib_add_flush_qp(qp);
 		} else {
+			/* Before we complete, do WA 9060 */
+			if (do_wa9060(qp, cq, cq_cons, sw_sq_cons,
+				      cqe_sq_cons)) {
+				*lib_qp = qp;
+				goto out;
+			}
 			if (swq->flags & SQ_SEND_FLAGS_SIGNAL_COMP) {
-				/* Before we complete, do WA 9060 */
-				if (do_wa9060(qp, cq, cq_cons, sw_sq_cons,
-					      cqe_sq_cons)) {
-					*lib_qp = qp;
-					goto out;
-				}
 				cqe->status = CQ_REQ_STATUS_OK;
 				cqe++;
 				(*budget)--;
-- 
2.5.5

