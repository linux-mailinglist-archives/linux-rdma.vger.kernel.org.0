Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FF76100D5
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 20:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbiJ0S43 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 14:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236418AbiJ0S4Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 14:56:25 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6AF51A28
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:24 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-13ba9a4430cso3370944fac.11
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CduSnUe8U0ENFtTvjuXGu9liKm9ihCJ54tUJ8p9KbVU=;
        b=NDGZoDdpI1xhBGTRVVjX8dvpx4d4cI9LHFmfGDOIowNzVRRGZ2K6jzehz30j5C/La0
         8ZFDwVsZ1I+rkNqGNxfger2wUxWydQok3pOfBWC6N8zTpA/Go8st/CiK342xPhkKyEN4
         xtc1rufPAVkBSzaPT4OxG5L1Y6ZOACcGYjOSxKm4OsGMqpekk0M95JS2od6REMZWC0mt
         3Q02gz+qdCfkoVaK3Ytv7xlpwvey4QssPl+Iq7ao4bykVhrJKaZBcNXu2OklnSg+cgwU
         7L3XEgcaLKvGh7Q65Z8jYmuoK3RJPIC7kL+2kpJmRNaiTCeZJp+0GO7lFSGcx3ljjoRO
         7+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CduSnUe8U0ENFtTvjuXGu9liKm9ihCJ54tUJ8p9KbVU=;
        b=wSAVMccRCTGuSyqZoicScL3RPQiH6otL665+hJgXVvFWbsU77MMK8d21LWzkBElbMF
         QAg6w0ZFPKQkREvMNb1C7sAxhx40c/gb64N22XuvQm1zfcLiReaJaxllorpm+HxD7vRQ
         eFzSIhzQ4Rg7g9oWGwxorI3dqsbh4sUd1i1/OeCm2yls4a96uXX9qxEwjVKRS6sVkJmO
         er9fj4tzECjJB12bCv0Rrp7YFHBb6I63ofEV26t7daKSs6KCxu7qrGmUcY5pBncU074U
         hOYw6HNon0gKSortEExFLn8Adthoaaw+uvIp0A782gh18FouNqUeQgGCzsqv1vKJVAyr
         rXPg==
X-Gm-Message-State: ACrzQf32cgf9Y03l7668moZqQ8FN7DBGYIyb3W2tuKADpRTeyHV/3k5V
        CVtYw6DLsBJHXu+DG7HRUhBw8v13fSo=
X-Google-Smtp-Source: AMsMyM6ODWxMmBsPkxgA6TUZ1omAx5P4hYR4HZTKg3OGWEF8HzmofUnUO9SH7iUZRA9CqUTYT9eh1g==
X-Received: by 2002:a05:6870:82a8:b0:13c:673e:322a with SMTP id q40-20020a05687082a800b0013c673e322amr1188364oae.249.1666896982114;
        Thu, 27 Oct 2022 11:56:22 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f015-3653-e617-fa3f.res6.spectrum.com. [2603:8081:140c:1a00:f015:3653:e617:fa3f])
        by smtp.googlemail.com with ESMTPSA id f1-20020a4a8f41000000b0049602fb9b4csm732736ool.46.2022.10.27.11.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:56:21 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 10/17] RDMA/rxe: Replace rxe by qp as a parameter
Date:   Thu, 27 Oct 2022 13:55:04 -0500
Message-Id: <20221027185510.33808-11-rpearsonhpe@gmail.com>
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

Replace rxe as a parameter by qp in rxe_init_packet().
This will allow some simplification.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h  | 2 +-
 drivers/infiniband/sw/rxe/rxe_net.c  | 3 ++-
 drivers/infiniband/sw/rxe/rxe_req.c  | 2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c | 3 +--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index dbead759123d..4e5fbc33277d 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -100,7 +100,7 @@ struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey);
 void rxe_mw_cleanup(struct rxe_pool_elem *elem);
 
 /* rxe_net.c */
-struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
+struct sk_buff *rxe_init_packet(struct rxe_qp *qp, struct rxe_av *av,
 				struct rxe_pkt_info *pkt);
 int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
 		struct sk_buff *skb);
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 1e4456f5cda2..faabc444d546 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -442,9 +442,10 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	return err;
 }
 
-struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
+struct sk_buff *rxe_init_packet(struct rxe_qp *qp, struct rxe_av *av,
 				struct rxe_pkt_info *pkt)
 {
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	unsigned int hdr_len;
 	struct sk_buff *skb = NULL;
 	struct net_device *ndev;
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index c4ab1a152491..2bae7a05805b 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -491,7 +491,7 @@ static struct sk_buff *rxe_init_req_packet(struct rxe_qp *qp,
 						pad + RXE_ICRC_SIZE;
 
 	/* init skb */
-	skb = rxe_init_packet(rxe, av, pkt);
+	skb = rxe_init_packet(qp, av, pkt);
 	if (unlikely(!skb))
 		goto err_out;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 7afff56aa398..71f6d446b1dc 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -665,7 +665,6 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 					  u32 psn,
 					  u8 syndrome)
 {
-	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct sk_buff *skb;
 	int paylen;
 	int pad;
@@ -680,7 +679,7 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 	ack->paylen = paylen;
 	ack->psn = psn;
 
-	skb = rxe_init_packet(rxe, &qp->pri_av, ack);
+	skb = rxe_init_packet(qp, &qp->pri_av, ack);
 	if (!skb)
 		return NULL;
 
-- 
2.34.1

