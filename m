Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63363AC2B3
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 07:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhFRFCj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 01:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbhFRFCi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 01:02:38 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357E5C061574
        for <linux-rdma@vger.kernel.org>; Thu, 17 Jun 2021 22:00:29 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso8470901oto.12
        for <linux-rdma@vger.kernel.org>; Thu, 17 Jun 2021 22:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LF9j0eH+jXgghCkKnaF0vq69S/STV0Lb06R2C2j0AYY=;
        b=fer/A0ixDGv+m0xsVqrpqnsW28Gd1GQWnjbbRUzRpnmueQARSE4y3YOR/nef2DE3WQ
         RSZgQ+r8YulhOQwdgfcA1hMu0uNO+fEBHRb3VlznpwOfWXZHf73s7Gzmr8/RW+wD+5iz
         SNXC1zZgvOznlSKch7dHrYEzqpeGVIESOyeewg/TCJGCQeCE9dgA+/JY4pUy8mQMWW6i
         5z8YxQT+jzb0z5249XSxb3JzfZtQWyqr5AaqFPD2U+Mqn4agoKHmQgUhQhBM18Rn2sgU
         XAfcGaBSCz12twy3O/MXeTBeF1VSS8zS7LMc7LH8XLnet/d0S22xmB5klHQqMUcG5Nqq
         bQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LF9j0eH+jXgghCkKnaF0vq69S/STV0Lb06R2C2j0AYY=;
        b=T7qS4eDjDY8H9RL1sfAOj1wR5hymvvuqZX4kV41RFQ/vU25eQSDp1KdXh3IU4+xk6N
         /iyuqLLWzVW7ELr1R/JzubtxcxnWqlahSAKP05h2NnttbeCBo42/fyUknoGidAp8RhYF
         GhhVglEdX/V1eaihemEXY9bA0SCuP67aL4jXTOdoeKKy0heR4ATHvdywGMG1PGrD5Neb
         wVWbk50DmmfGnM6TlZ1cjBQ/18DZk8s0TliVP0B4rd4pXzCcK4tH7K1fjawZ2NuHFENo
         KZCQH+R53iPZ5iEVd2mjvnGHwUtMTp8MyLy1JpYJtdiCr8JpHDFiE5hfh5qAAIjeFS98
         lVgw==
X-Gm-Message-State: AOAM532LmpIB3rUUNa0wjFPuNxRA50tfwyUr8f3fO6KPgUbJ/rQGdjg6
        ZgBjdwjZq3Yiy6/f8+aN6iU=
X-Google-Smtp-Source: ABdhPJyaM8xafIm+jL4cQFJazxFsbU/XJ2yZ/cxfMk0lFjrYeU2DG7fpXPYWchqmFDxf9fGqpPw5HA==
X-Received: by 2002:a9d:4c85:: with SMTP id m5mr7640917otf.185.1623992428620;
        Thu, 17 Jun 2021 22:00:28 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-2fce-3453-431e-5204.res6.spectrum.com. [2603:8081:140c:1a00:2fce:3453:431e:5204])
        by smtp.gmail.com with ESMTPSA id q11sm1615267ooc.27.2021.06.17.22.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 22:00:28 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 5/6] RDMA/rxe: Fix extra copy in prepare_ack_packet
Date:   Thu, 17 Jun 2021 23:57:42 -0500
Message-Id: <20210618045742.204195-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618045742.204195-1-rpearsonhpe@gmail.com>
References: <20210618045742.204195-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently prepare_ack_packet writes almost all the fields of the
BTH in the ack packet twice. Replace code with the subroutine
init_bth().

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 93322d20c0ab..72cdb170b67b 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -637,18 +637,11 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 	ack->opcode = opcode;
 	ack->mask = rxe_opcode[opcode].mask;
 	ack->paylen = paylen;
-
-	/* fill in bth using the request packet headers */
-	memcpy(ack->hdr, pkt->hdr, RXE_BTH_BYTES);
-
-	bth_set_opcode(ack, opcode);
-	bth_set_qpn(ack, qp->attr.dest_qp_num);
-	bth_set_pad(ack, pad);
-	bth_set_se(ack, 0);
-	bth_set_psn(ack, psn);
-	bth_set_ack(ack, 0);
 	ack->psn = psn;
 
+	bth_init(ack, opcode, 0, 0, pad, IB_DEFAULT_PKEY_FULL,
+		 qp->attr.dest_qp_num, 0, psn);
+
 	if (ack->mask & RXE_AETH_MASK) {
 		aeth_set_syn(ack, syndrome);
 		aeth_set_msn(ack, qp->resp.msn);
-- 
2.30.2

