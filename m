Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD59161C86
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2020 21:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgBQU5V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Feb 2020 15:57:21 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34529 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbgBQU5U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Feb 2020 15:57:20 -0500
Received: by mail-pg1-f194.google.com with SMTP id j4so9848251pgi.1
        for <linux-rdma@vger.kernel.org>; Mon, 17 Feb 2020 12:57:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xDJ1INKlr0jBh0nzphKk8e6EypzafLBOB8DTFCzK1+g=;
        b=V2GsPNrtbWj+BYNpjKX2higCYouOQzO6dHtoCinzXez7YrnIOt99uSjAUgOlzSVR0f
         TfzVBLNeOq44FaAGGMGODKbkAQj8jhjruKmVWSZY7cLDOd+6RW8fS2SuLvd092yz44xm
         TJX5YAVBjwEzNLN6eXsSyNnp96a2XKxGrD5lKbJMC3Ez1honjlmQr4ZtFv2MADZRZ8Y+
         JNscCit1ZhzPk0HvmCIGteEzsFmpW16HKHLKixmpj30uwLslF2HW1CEbwDqU5b7QjmPN
         3qEvCegZn5W4xHNtKIUwq/vSpzBEdHKQzKfD5vxUHXip74bUIn+UKB34b6xl8fJwshhy
         FYTA==
X-Gm-Message-State: APjAAAUViwP3bS/ZUoXJo6iIGpJLNCFioZVgywX9lBwk5hXmC8ZeA4CQ
        4FNUIVC6dunVDA0iDlweBlE=
X-Google-Smtp-Source: APXvYqz6oGdNqlJ4Z6Xc1sDYBxO+mBpHsM56aNFtmjvDGJyoH9Edqkk9oxSMKVdvLDL/8tV0D+mvIA==
X-Received: by 2002:aa7:9891:: with SMTP id r17mr18540435pfl.205.1581973040031;
        Mon, 17 Feb 2020 12:57:20 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:2474:e036:5bee:ca5b])
        by smtp.gmail.com with ESMTPSA id x21sm1318466pfq.76.2020.02.17.12.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 12:57:19 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Moni Shoua <monis@mellanox.com>
Subject: [PATCH] RDMA/rxe: Fix configuration of atomic queue pair attributes
Date:   Mon, 17 Feb 2020 12:57:14 -0800
Message-Id: <20200217205714.26937-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From the comment above the definition of the roundup_pow_of_two() macro:

     The result is undefined when n == 0.

Hence only pass positive values to roundup_pow_of_two(). This patch fixes
the following UBSAN complaint:

UBSAN: Undefined behaviour in ./include/linux/log2.h:57:13
shift exponent 64 is too large for 64-bit type 'long unsigned int'
Call Trace:
 dump_stack+0xa5/0xe6
 ubsan_epilogue+0x9/0x26
 __ubsan_handle_shift_out_of_bounds.cold+0x4c/0xf9
 rxe_qp_from_attr.cold+0x37/0x5d [rdma_rxe]
 rxe_modify_qp+0x59/0x70 [rdma_rxe]
 _ib_modify_qp+0x5aa/0x7c0 [ib_core]
 ib_modify_qp+0x3b/0x50 [ib_core]
 cma_modify_qp_rtr+0x234/0x260 [rdma_cm]
 __rdma_accept+0x1a7/0x650 [rdma_cm]
 nvmet_rdma_cm_handler+0x1286/0x14cd [nvmet_rdma]
 cma_cm_event_handler+0x6b/0x330 [rdma_cm]
 cma_ib_req_handler+0xe60/0x22d0 [rdma_cm]
 cm_process_work+0x30/0x140 [ib_cm]
 cm_req_handler+0x11f4/0x1cd0 [ib_cm]
 cm_work_handler+0xb8/0x344e [ib_cm]
 process_one_work+0x569/0xb60
 worker_thread+0x7a/0x5d0
 kthread+0x1e6/0x210
 ret_from_fork+0x24/0x30

Cc: Moni Shoua <monis@mellanox.com>
Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index ec21f616ac98..6c11c3aeeca6 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -590,15 +590,16 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 	int err;
 
 	if (mask & IB_QP_MAX_QP_RD_ATOMIC) {
-		int max_rd_atomic = __roundup_pow_of_two(attr->max_rd_atomic);
+		int max_rd_atomic = attr->max_rd_atomic ?
+			roundup_pow_of_two(attr->max_rd_atomic) : 0;
 
 		qp->attr.max_rd_atomic = max_rd_atomic;
 		atomic_set(&qp->req.rd_atomic, max_rd_atomic);
 	}
 
 	if (mask & IB_QP_MAX_DEST_RD_ATOMIC) {
-		int max_dest_rd_atomic =
-			__roundup_pow_of_two(attr->max_dest_rd_atomic);
+		int max_dest_rd_atomic = attr->max_dest_rd_atomic ?
+			roundup_pow_of_two(attr->max_dest_rd_atomic) : 0;
 
 		qp->attr.max_dest_rd_atomic = max_dest_rd_atomic;
 
