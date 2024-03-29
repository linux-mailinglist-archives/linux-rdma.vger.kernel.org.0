Return-Path: <linux-rdma+bounces-1681-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 224F08920D2
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 16:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3499B33AD6
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 15:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE05E14BFA8;
	Fri, 29 Mar 2024 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeLzvi6q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131E014BF9E
	for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724166; cv=none; b=GfWngS/hW7z4GBtKD+pykc919gst099Tx+w/l4MawnLD+TK9eFocsnguvx//Jdy6n2k58Jhp4LwrRme5DDYDb7JJ3JWwLzhBhPx9XYyZtbAqEybmBwV1zOgOlTionlUeqyfgZUq10rumZOoQgAysioFn+1BQdeEFydc7J9cVGOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724166; c=relaxed/simple;
	bh=B2gmlDep39f/8aLihVViwFCJdjZs3DgwbdYVLyddLe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZpffAQnQDTKPZ9xg7+pTnZZ5tGpoL4iQn7B4ecItOsuEzQ5LkM18k1+E9oeJXhTbag8FTiPSEFtmQLrBGudlreNJKz43yq5AcUU+oEuE3LjG8bAqT8fWk2DBJxNuT+Exg0Cf/vz5/gpWZjLw5AgNdVLJtNYSfP95aLUivspqBj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeLzvi6q; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c3aeef1385so1423950b6e.3
        for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 07:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711724164; x=1712328964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XF9/VOsT7pCQvNE3+t/XGyOip/FH5VeZPlQno+szpqc=;
        b=CeLzvi6qUu0BSi/lza0h0T6Hr67bQ0KWyba1Vhu4gjVLw8CdG2iqYbq3hBs+rZENGf
         uvXn8ZdX224kp0zkfn4mtUyBETa89rpzt5E1etMkB01wsbHQoleObypcyMFsx80Drr4c
         N93tXfLZ4dDrUFm8DiqDcbzjjD+gMeqqm90SrUPOD3dL1Rgr9ViCZ1ZFOwHRnL59cNfq
         83liwAidfvevFNmCTGBf4J4euKZqmZoVAqhLk8mzcZRYWnXCsn7uKV5jMF/BRs2nB+io
         V6DtEw+uKrtjcV+QzK3MKOzRiY2ucLzwdDSXDt1vzuDqryRWYsc/U4e8JCR/JPRFLJo0
         fFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711724164; x=1712328964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XF9/VOsT7pCQvNE3+t/XGyOip/FH5VeZPlQno+szpqc=;
        b=tpE1RCnp6DaDRl/nBysTEFRNggmrjcQUeDZ7EQJ4zpcQ2X7tJEsglZ3W1j3DzF/mlW
         60zJoxcwEiCE8MM/GLVJe2LfWQxueOV/0J7TiMkn3qw4S6YtiqALR4WE6CjXPIWdFWN+
         mHiMTyr3FscAEN1A4Ya1JoVIl/m8WFtoQI7NuwejLaI0Ji6Gu8I714cYdOr8QWo/1Jgi
         JDCmOX7ArPdOx183EXZBTTv3ao08GuF4e5SQTDgdNthQ+3WWClLJT9hHjMXRdRSEN7so
         1o9brKHeS7Kf4BePmk6O2hnj8jZW5UeT9/vcrXR7s5Ga1ODGsLDHb9uPnD66pyWO8Z9j
         +dlA==
X-Forwarded-Encrypted: i=1; AJvYcCWNPy4s4JN0gjNT0O2RHHtprF/noefgZxQDYf6kWUNTSCbCiSmylmt8mTFI2bNzpmTdTB6F3aJHxb4fMDQxm0F7+3eXwdHEIRaiiw==
X-Gm-Message-State: AOJu0Yw5dSAkbqMYihuoiPyYuEKgOcGRBYBQn/vCVrtJF+z3W7K/yaMw
	kTWOHE/83G/qmcBj56Chd3f9DGF0+lV9lF7OnVvmUgUbGglSBjj7
X-Google-Smtp-Source: AGHT+IExP+Q2VUfssSVBzcoK4DoZdQoBh0Wj4q9Q+8gtyYNthukDJTFVsGEBJN8d2YKAmoZys7kMgA==
X-Received: by 2002:a05:6871:7981:b0:22a:7c81:1e2e with SMTP id pb1-20020a056871798100b0022a7c811e2emr2729135oac.16.1711724164118;
        Fri, 29 Mar 2024 07:56:04 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-75b6-1a40-9b4e-0264.res6.spectrum.com. [2603:8081:1405:679b:75b6:1a40:9b4e:264])
        by smtp.gmail.com with ESMTPSA id fl9-20020a056870494900b0022a58ffa4a3sm1006249oab.23.2024.03.29.07.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 07:56:03 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 12/12] RDMA/rxe: Let destroy qp succeed with stuck packet
Date: Fri, 29 Mar 2024 09:55:15 -0500
Message-ID: <20240329145513.35381-15-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329145513.35381-2-rpearsonhpe@gmail.com>
References: <20240329145513.35381-2-rpearsonhpe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some situations a sent packet may get queued in the NIC longer
than than timeout of a ULP. Currently if this happens the ULP may
try to reset the link by destroying the qp and setting up an
alternate connection but will fail because the rxe driver is
waiting for the packet to finish getting sent and be returned to
the skb destructor function where the qp reference holding things
up will be dropped. This patch modifies the way that the qp is
passed to the destructor to pass the qp index and not a qp pointer.
Then the destructor will attempt to lookup the qp from its index
and if it fails exit early. This requires taking a reference on
the struct sock rather than the qp allowing the qp to be destroyed
while the sk is still around waiting for the packet to finish.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 42 +++++++++++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_qp.c  |  2 +-
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index b58eab75df97..dc22f3922a59 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -345,25 +345,44 @@ int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
 
 static void rxe_skb_tx_dtor(struct sk_buff *skb)
 {
-	struct sock *sk = skb->sk;
-	struct rxe_qp *qp = sk->sk_user_data;
-	int skb_out = atomic_dec_return(&qp->skb_out);
+	struct net_device *ndev = skb->dev;
+	struct rxe_dev *rxe;
+	unsigned int qp_index;
+	struct rxe_qp *qp;
+	int skb_out;
+
+	rxe = rxe_get_dev_from_net(ndev);
+	if (!rxe && is_vlan_dev(ndev))
+		rxe = rxe_get_dev_from_net(vlan_dev_real_dev(ndev));
+	if (WARN_ON(!rxe))
+		return;
 
-	if (unlikely(qp->need_req_skb &&
-		     skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW))
+	qp_index = (int)(uintptr_t)skb->sk->sk_user_data;
+	if (!qp_index)
+		return;
+
+	qp = rxe_pool_get_index(&rxe->qp_pool, qp_index);
+			if (!qp)
+		goto put_dev;
+
+	skb_out = atomic_dec_return(&qp->skb_out);
+	if (qp->need_req_skb && skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW)
 		rxe_sched_task(&qp->send_task);
 
 	rxe_put(qp);
+put_dev:
+	ib_device_put(&rxe->ib_dev);
+	sock_put(skb->sk);
 }
 
 static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 {
 	int err;
+	struct sock *sk = pkt->qp->sk->sk;
 
+	sock_hold(sk);
+	skb->sk = sk;
 	skb->destructor = rxe_skb_tx_dtor;
-	skb->sk = pkt->qp->sk->sk;
-
-	rxe_get(pkt->qp);
 	atomic_inc(&pkt->qp->skb_out);
 
 	if (skb->protocol == htons(ETH_P_IP))
@@ -379,12 +398,13 @@ static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
  */
 static int rxe_loopback(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 {
+	struct sock *sk = pkt->qp->sk->sk;
+
 	memcpy(SKB_TO_PKT(skb), pkt, sizeof(*pkt));
 
+	sock_hold(sk);
+	skb->sk = sk;
 	skb->destructor = rxe_skb_tx_dtor;
-	skb->sk = pkt->qp->sk->sk;
-
-	rxe_get(pkt->qp);
 	atomic_inc(&pkt->qp->skb_out);
 
 	if (skb->protocol == htons(ETH_P_IP))
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index c7d99063594b..d2f7b5195c19 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -244,7 +244,7 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
 	if (err < 0)
 		return err;
-	qp->sk->sk->sk_user_data = qp;
+	qp->sk->sk->sk_user_data = (void *)(uintptr_t)qp->elem.index;
 
 	/* pick a source UDP port number for this QP based on
 	 * the source QPN. this spreads traffic for different QPs
-- 
2.43.0


