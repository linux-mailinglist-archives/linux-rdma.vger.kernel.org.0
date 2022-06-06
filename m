Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130CE53E646
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jun 2022 19:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239821AbiFFOje (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jun 2022 10:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239781AbiFFOj2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jun 2022 10:39:28 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACD115A3C8
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jun 2022 07:39:27 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id s8so14670788oib.6
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jun 2022 07:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pASGD7A0Oxrc5XI72YSbByAp9HDA7sfARKnMSfbO3Wc=;
        b=YNLPSrU0W0PB24DnkH3qvTUh2J1jp+3vX/ifIqMxjtt6DaPwTtscD/uGwDUpr1CuvK
         gDvDH7EuQQOQtvpWea+R5yUS/CaFXNpmq99sah+ZFZXoTOC6WZTYUxWPshI3OPTfyaog
         1NIk8hZsEKgBYyoxdZwi/OHNo5E4zMzr50DqlTDrobYYQrkvJkRyuXlejME5UuRJqQqB
         rIscudU+gxRC64twBrPC1OucIJZ1aO80I6bW7ecKeWlEChD3TMtk09gyrVNcty8emd/y
         SEd30uGx5PrxWKj2cHIhDbd4zcNyUqhgdfBZf0VAZzwajUQ5iDKhGf9/ErPWe/+G66sl
         eqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pASGD7A0Oxrc5XI72YSbByAp9HDA7sfARKnMSfbO3Wc=;
        b=Lcf4vUa+tdRYjop3PEQ9xLtI7v7WwhqfpSlQdoUo1+3TZ0I4me28yY4u//0pN4wZGR
         FuTf2f3UsImHexpnfozNVwDM7NJdUjcJUAyvdTo1+Dr6pwp23M8t1CgE0xUY1JhYEkjy
         djVn2UusrCEbXgksyT3v387HSg9XA9Ccddv+PGcg1HV8bbTb3Z9Knn9RUQy3vBf2LrAa
         jtWHlgePriSmx1VSnE+1rf2/rMnuqkzLntuC28rje5GeQj53TQi/PjdqQZVS+SDA2gq8
         2pxCCu6j3tPwpOhgL302OnlvF4dNQByukr22e3qi/W+WHtApXhqs9/bAorlxuhIkeHdf
         hl8g==
X-Gm-Message-State: AOAM533iyU5sxQsX0PYfzT+tpMa65OZ0xG9hHKCpip3kK+w/4erwi8qv
        +xv2S6ZTRQJz/EINNzj4a4H/m4Kb91iY2g==
X-Google-Smtp-Source: ABdhPJxz+tr/JpUmg8888F+I1a1xrPwJ1239P31NodDA1verRcdCwFvdO+8WH+rA8AzEXjIoYuJUmw==
X-Received: by 2002:a05:6808:221a:b0:32b:9564:c949 with SMTP id bd26-20020a056808221a00b0032b9564c949mr29298658oib.149.1654526366875;
        Mon, 06 Jun 2022 07:39:26 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id q28-20020a05683022dc00b0060c00c3fde5sm658335otc.72.2022.06.06.07.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 07:39:26 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        frank.zago@hpe.com, jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 4/5] RDMA/rxe: Move atomic original value to res
Date:   Mon,  6 Jun 2022 09:38:36 -0500
Message-Id: <20220606143836.3323-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220606143836.3323-1-rpearsonhpe@gmail.com>
References: <20220606143836.3323-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Move the saved original value to the atomic responder resource.
This replaces saving it in the qp. In preparation for
merging the normal and retry atomic responder flows.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c  | 13 +++++++------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 4908b9fc0204..320ab7c717cb 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -579,6 +579,7 @@ static enum resp_states rxe_atomic_reply(struct rxe_qp *qp,
 	enum resp_states ret;
 	struct rxe_mr *mr = qp->resp.mr;
 	struct resp_res *res = qp->resp.res;
+	u64 value;
 
 	if (!res) {
 		res = rxe_prepare_atomic_res(qp, pkt);
@@ -599,16 +600,16 @@ static enum resp_states rxe_atomic_reply(struct rxe_qp *qp,
 	}
 
 	spin_lock_bh(&atomic_ops_lock);
-
-	qp->resp.atomic_orig = *vaddr;
+	res->atomic.orig_val = value = *vaddr;
 
 	if (pkt->opcode == IB_OPCODE_RC_COMPARE_SWAP) {
-		if (*vaddr == atmeth_comp(pkt))
-			*vaddr = atmeth_swap_add(pkt);
+		if (value == atmeth_comp(pkt))
+			value = atmeth_swap_add(pkt);
 	} else {
-		*vaddr += atmeth_swap_add(pkt);
+		value += atmeth_swap_add(pkt);
 	}
 
+	*vaddr = value;
 	spin_unlock_bh(&atomic_ops_lock);
 
 	qp->resp.msn++;
@@ -664,7 +665,7 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 	}
 
 	if (ack->mask & RXE_ATMACK_MASK)
-		atmack_set_orig(ack, qp->resp.atomic_orig);
+		atmack_set_orig(ack, qp->resp.res->atomic.orig_val);
 
 	err = rxe_prepare(&qp->pri_av, ack, skb);
 	if (err) {
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index ac464e68c923..5ee0f2599896 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -156,6 +156,7 @@ struct resp_res {
 	union {
 		struct {
 			struct sk_buff	*skb;
+			u64		orig_val;
 		} atomic;
 		struct {
 			u64		va_org;
@@ -189,7 +190,6 @@ struct rxe_resp_info {
 	u32			resid;
 	u32			rkey;
 	u32			length;
-	u64			atomic_orig;
 
 	/* SRQ only */
 	struct {
-- 
2.34.1

