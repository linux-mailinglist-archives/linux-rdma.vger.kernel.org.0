Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A206100CD
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 20:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbiJ0S4T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 14:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbiJ0S4Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 14:56:16 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60AD1D33C
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:13 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id l5so3389889oif.7
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEmM98qWgdC7JibJI9d8dkTVJi2BBzT4fZsK+PNxQ0c=;
        b=mlGQy/jmi3dVysoMrth9e0fplnNCx+DgN+sjjKohSkraQQj70yWyuN7aiwKbJEVawT
         KHJrWS0wixtTiwY15CduEvqu+IxM58ilZrE9vY9QrkywKJJ3i6iClqDaNxq2YzLDqQ4i
         JIVVjygvJbZsipM7iW0W6OzQHz7n3WAwgZghCxs+pkD9oeq46kg50baVBEmVgwklcDS/
         3TprY6+4sAnlBXB6akaZoSFzMh2HISzYzXb3mJs2mDjQNKq36C1gC3CtKkVbMRCWZrg+
         tmhXBq1hzwj1u25/3P8X2+CCMLt20Xfy9mZFUT8/NmFRzUkgE+j1xk85lMG/IvtpINiD
         PDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEmM98qWgdC7JibJI9d8dkTVJi2BBzT4fZsK+PNxQ0c=;
        b=NpcuosZCXKNuZSq0U5gF6j1pZGgl1DhfVK69Ask72wZrVo0JRl6ynb4JD7r3F91Roj
         je07Ck3mezU7bl4dIR3tzD86iWFU+xj9SXXXRok5CsgIpsB/QJh49ZZIXKl98LXNVfFM
         D4w6p8fWPKIJ5QBqfucId8Q3vGn3TG21uQv5ZFofPNtjSj4LDbvqHPu+DffIoTYJcCOB
         ePC4SnSOYmscC+bur067oL8w+JkgQ+SeRPEncYp9d5lVT/oV5FaZ7pGGHAqFy1uiNoJN
         2diV8KGf/JK7OM5i8G8zB6YRQH2QsAYjliWaPc1W+5abyz0p/ERv0FESY1fEOlC89JDx
         eUNA==
X-Gm-Message-State: ACrzQf2+ZZ1S/Yw9Jgt49+sFdM6qpHTUjoV0nn2/JqT6s1gNBeU9bdpK
        emYRoTdaFgGQwZ5H7hDWG3k=
X-Google-Smtp-Source: AMsMyM7usfRuTIulNgdr+aVwJsHe3zAM2vRWFpH8UX92P27faccOluLW1FtbRS1+rbiCbOL463mP1g==
X-Received: by 2002:a05:6808:1291:b0:359:b6bc:df0c with SMTP id a17-20020a056808129100b00359b6bcdf0cmr4283983oiw.50.1666896973285;
        Thu, 27 Oct 2022 11:56:13 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f015-3653-e617-fa3f.res6.spectrum.com. [2603:8081:140c:1a00:f015:3653:e617:fa3f])
        by smtp.googlemail.com with ESMTPSA id f1-20020a4a8f41000000b0049602fb9b4csm732736ool.46.2022.10.27.11.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:56:12 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 02/17] RDMA/rxe: Isolate request payload code in a subroutine
Date:   Thu, 27 Oct 2022 13:54:56 -0500
Message-Id: <20221027185510.33808-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027185510.33808-1-rpearsonhpe@gmail.com>
References: <20221027185510.33808-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Isolate the code that fills the payload of a request packet into
a subroutine named rxe_init_payload().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 34 +++++++++++++++++------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index bcfbc78c0b53..10a75f4e3608 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -437,6 +437,25 @@ static void rxe_init_roce_hdrs(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	}
 }
 
+static int rxe_init_payload(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
+			    struct rxe_pkt_info *pkt, u32 payload)
+{
+	void *data;
+	int err = 0;
+
+	if (wqe->wr.send_flags & IB_SEND_INLINE) {
+		data = &wqe->dma.inline_data[wqe->dma.sge_offset];
+		memcpy(payload_addr(pkt), data, payload);
+		wqe->dma.resid -= payload;
+		wqe->dma.sge_offset += payload;
+	} else {
+		err = copy_data(qp->pd, 0, &wqe->dma, payload_addr(pkt),
+				payload, RXE_FROM_MR_OBJ);
+	}
+
+	return err;
+}
+
 static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 				       struct rxe_av *av,
 				       struct rxe_send_wqe *wqe,
@@ -473,20 +492,7 @@ static int finish_packet(struct rxe_qp *qp, struct rxe_av *av,
 		return err;
 
 	if (pkt->mask & RXE_WRITE_OR_SEND_MASK) {
-		if (wqe->wr.send_flags & IB_SEND_INLINE) {
-			u8 *tmp = &wqe->dma.inline_data[wqe->dma.sge_offset];
-
-			memcpy(payload_addr(pkt), tmp, payload);
-
-			wqe->dma.resid -= payload;
-			wqe->dma.sge_offset += payload;
-		} else {
-			err = copy_data(qp->pd, 0, &wqe->dma,
-					payload_addr(pkt), payload,
-					RXE_FROM_MR_OBJ);
-			if (err)
-				return err;
-		}
+		err = rxe_init_payload(qp, wqe, pkt, payload);
 		if (bth_pad(pkt)) {
 			u8 *pad = payload_addr(pkt) + payload;
 
-- 
2.34.1

