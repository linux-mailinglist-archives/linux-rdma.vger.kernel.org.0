Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369CD25073B
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 20:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHXSPG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 14:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgHXSPF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 14:15:05 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465B7C061573
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 11:15:05 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g33so4947726pgb.4
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 11:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DtOrUQtzHbeu3ICxgKjd1EY7HVvEYdCkKdBDm56KPYs=;
        b=QDcqIO9HaToxSd5lCs58ZOyPtIYxP7R2AjiKIpCWBor8WhFgaABeMyrIee3lYeitfx
         Z0gR7VbuuEfb0obJZwzZgkLfH6EOSIVawQOMDbqZkrcgu8/7vJ8P2vi4KGG17q0wFuYC
         Vj7EJFnWMR3yd/JKN2n+V6YwR2AKUR4KWdWP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DtOrUQtzHbeu3ICxgKjd1EY7HVvEYdCkKdBDm56KPYs=;
        b=YiVqywgPnifS/K/QiVnok2yT6+AnKgX0JK+Oj7Cc13RuwL8IlFOSwjeB330vL9gC32
         1GI8qQ3wZ4fAXCUR5y5c6/0XZRuBZxiAqtTxp0Sdm/MDbRp0KLt1pSa4ihz1VYiXnedK
         oBHCyvQDH7yqI6AZogyXCQBvqGhoyunj3gqE02qQ4MN3+xj7CSSTY0aZ4rv5zKFux7TN
         aD7fxNNeQsDHFuSi/MLqhf7p2Lm+AdlLDWlv3VXP8qpsNpU7SPgdC+XckAnxdRRwNk+D
         QxsgSajLUqoMfJg19VCZPaJUQD5URSEffw1uHTXXt+tnJrKc2uJsvqXw7kFJ9s5zs01t
         HI0A==
X-Gm-Message-State: AOAM530+DvTkiqQrYapewTgZDgdPnOpH8JJO6i7wjTFWci02Q+Jd5mb2
        4so7glKlmayoUl0iKpPp6mepXQ==
X-Google-Smtp-Source: ABdhPJzXHR2dTD7YCWlGs3wOgKHioGOMMnRrp33hNNRKY9rcTuvbGSjKSmf1dJ7QXg4RxmcVWkyRIg==
X-Received: by 2002:a63:5703:: with SMTP id l3mr1237248pgb.329.1598292904673;
        Mon, 24 Aug 2020 11:15:04 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q5sm5027811pfu.16.2020.08.24.11.15.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 11:15:03 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc 6/6] RDMA/bnxt_re: Fix driver crash on unaligned PSN entry address
Date:   Mon, 24 Aug 2020 11:14:36 -0700
Message-Id: <1598292876-26529-7-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1598292876-26529-1-git-send-email-selvin.xavier@broadcom.com>
References: <1598292876-26529-1-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>

When computing the first psn entry, driver checks
for page alignment. If this address is not page aligned,it
attempts to compute the offset in that page for later
use by using ALIGN macro. ALIGN macro does not return offset
bytes but the requested aligned address and hence cannot
be used directly to store as offset.
Since driver was using the address itself instead of offset,
it resulted in invalid address when filling the psn buffer.

Fixed driver to use PAGE_MASK macro to calculate the offset.

Fixes: fddcbbb02af4 ("RDMA/bnxt_re: Simplify obtaining queue entry from hw ring")
Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 3535130..9f90cfe 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -937,10 +937,10 @@ static void bnxt_qplib_init_psn_ptr(struct bnxt_qplib_qp *qp, int size)
 
 	sq = &qp->sq;
 	hwq = &sq->hwq;
+	/* First psn entry */
 	fpsne = (u64)bnxt_qplib_get_qe(hwq, hwq->depth, &psn_pg);
 	if (!IS_ALIGNED(fpsne, PAGE_SIZE))
-		indx_pad = ALIGN(fpsne, PAGE_SIZE) / size;
-
+		indx_pad = (fpsne & ~PAGE_MASK) / size;
 	hwq->pad_pgofft = indx_pad;
 	hwq->pad_pg = (u64 *)psn_pg;
 	hwq->pad_stride = size;
-- 
2.5.5

