Return-Path: <linux-rdma+bounces-14471-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A28FC58FEB
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 18:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7CACE3660CB
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 16:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D8C351FBA;
	Thu, 13 Nov 2025 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUzo9MvK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74519225785
	for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052469; cv=none; b=rrJNFbbq7uHdNpX3g3t/CoqMh517SLkC51we6+7TZJaaPD7VN+EQzVtru0eN/eBS2Q6HfqIKFILDan9LfV5E+6a6CTi85mUajgdW5O9UHPESq777BUlLb9TpLPK9iEG5eoZwpvgnhtTbBu2qqIM06kt2ivJrEFByp++Fxu70tuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052469; c=relaxed/simple;
	bh=wxr3oyHuw4JBJD6eiR+G0Wyqv+Sl/Us4AF7aWNcwdh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F4v/Rfvk1b35jUIujYxtAdzSrz6ZZr9WDDc1hR7bLesZrRzZh2OAW2PA927+MUDqde4lZer5WNy8fPF+q4htb2jE2GsYF/m2eoTjBr4gKFcPpyOL6zXvNxovA252u5hUFx3UBPq5Bt5iDf+Gr3rSU32Tf6SzNUYCxrKqsui9uIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUzo9MvK; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-656cb7b20ccso440874eaf.1
        for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 08:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763052466; x=1763657266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xtb1Tg4f0J+buM9U/6muLv9lSlDdspLzgrMc4VoD+Hg=;
        b=IUzo9MvKPRGPRheJBDerm9SQyRov59M6kF16s+n3bcfO+6oW+OFTmrvaCnzJMklK1u
         WJcYKugoUFegGkfItRwhvlhGi9saJ5EzjbHfddLkVdasnKDEl2AdlIfylmKLRiEsfswh
         8FunGBzCCKXFkfzyG1nrseXNzc7JQQeMoYNtsdf9eAbzhvp2krXrENcbKenq/FZmHHE/
         uy9O1Ehy4G96XNJY1SSeconBBf+cr7L949/KxsN9Av6u7l7pflvipP2ZbrWQzx1XIwXs
         2SGHNiB5cvJCmeOOBoqsLKSw6YrbDp1CzkzTwSMLOmS91vJI94ylzo3JTFCHbq6UbIqc
         E2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052466; x=1763657266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xtb1Tg4f0J+buM9U/6muLv9lSlDdspLzgrMc4VoD+Hg=;
        b=hli1aSlXZen8+KLAMXOKWk3HP7kAUM1mZhgti08tsIBhkS65DQHtO3ywAVa2DR1/pY
         TW8+QDTZ64A81bxlYpkG9UUinosZTUHbrsslayvru1nubPV3F42SqJrAgbPoP3VnVGh/
         XcOqF5yK0iybOwJ2Kw8lYkeSeAxD3E+d97c2Zd1Pudxt0FHvihfONNWHPhCU/VWhJI0t
         diiOKylBtwIp24kf81F4QEIBLMnL2+EyDRMJ/VaYSKXQ2xPOc4ZzHkk4fhDf5THwplue
         tsj9Ju68A0Oj+N0QTkMWISo/jdi72Ow8u+7zzfymjWvOFMP0/PGjJ7wkyagZgGf4o8oV
         AOiA==
X-Forwarded-Encrypted: i=1; AJvYcCVnq2lbhdodP7nFV9HJliLHUeqC/G4NvqKQEGcRkWy1398bC6++H1L8FwK976uwxLIUe9EW2+B2ujWx@vger.kernel.org
X-Gm-Message-State: AOJu0Yygfh/bclQm1Q5iB3D2MgEo5ozSppNqpF8YETjy+M9sRsLQqUDT
	HonuwFABepR2IcOxkqIRgEmbOeiGXjuN68VJrJDVxdvVLi/B4dBxM7n98b3lX0Zr4Bk=
X-Gm-Gg: ASbGncsuVFXB3mfHORa0gXMEMR/gbic3UkK0cC9tZX9ClGs9Hb53f/1Sx+ftIOJ4sy5
	gJDrWdnCmzV7w7jcytovp+Z4UAIFRJYNJTOkEZl7m68A2zkLNaHoqwkuziMLC6u/lFH75A3Oszy
	cGR99F4UNJGDxC+CSfl0a2dqIkd2mMqm4KS0YTWLLdiAGAyZjMZ9oniHJprGJ1lIp8BUt01HMxM
	IdWrLEB/B72l7enRrp+qyGMpiUKniIqBHdRY+j5JZkwLE+50bRZInujSsPPNeT0fC/bcdu/+IVG
	7nnYOl7u/8gXBXK7hAN56vnEh1AQAhszjVg7c7nUoSUJvUbnoqPCWg2SLIhU6Zbyx/2J/eihyuF
	ZBukJIhu01kvoTOJSTAszq+RhMewAq+ueDLARb8Vmk+H1nEAB9eEBWv701c3KwdIdTkqxGXYcN8
	Yb77FGCWV2LvDMxHPY/74=
X-Google-Smtp-Source: AGHT+IGFCNQet+BuHm7TrA8WU2G72HMPRvd91sqbtpEJ9RSuQNUwN8KOf9V9uynfETNdHuQJogNZYQ==
X-Received: by 2002:a05:6820:6487:b0:654:f200:1490 with SMTP id 006d021491bc7-65723304154mr1333715eaf.1.1763052466156;
        Thu, 13 Nov 2025 08:47:46 -0800 (PST)
Received: from localhost.localdomain ([192.146.154.240])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65724cfa261sm1227228eaf.5.2025.11.13.08.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:47:45 -0800 (PST)
From: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
To: chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
Subject: [PATCH] Make RPCRDMA_MAX_RECV_BATCH configurable.
Date: Thu, 13 Nov 2025 11:46:48 -0500
Message-ID: <20251113164648.20774-1-gaurav.gangalwar@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bumped up rpcrdma_max_recv_batch to 64.
Added param to change to it, it becomes handy to use higher value
to avoid hung.

Signed-off-by: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c           | 2 +-
 net/sunrpc/xprtrdma/module.c             | 6 ++++++
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 2 +-
 net/sunrpc/xprtrdma/verbs.c              | 2 +-
 net/sunrpc/xprtrdma/xprt_rdma.h          | 4 +---
 5 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 31434aeb8e29..863a0c567915 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -246,7 +246,7 @@ int frwr_query_device(struct rpcrdma_ep *ep, const struct ib_device *device)
 	ep->re_attr.cap.max_send_wr += 1; /* for ib_drain_sq */
 	ep->re_attr.cap.max_recv_wr = ep->re_max_requests;
 	ep->re_attr.cap.max_recv_wr += RPCRDMA_BACKWARD_WRS;
-	ep->re_attr.cap.max_recv_wr += RPCRDMA_MAX_RECV_BATCH;
+	ep->re_attr.cap.max_recv_wr += rpcrdma_max_recv_batch;
 	ep->re_attr.cap.max_recv_wr += 1; /* for ib_drain_rq */
 
 	ep->re_max_rdma_segs =
diff --git a/net/sunrpc/xprtrdma/module.c b/net/sunrpc/xprtrdma/module.c
index 697f571d4c01..afeec5a68151 100644
--- a/net/sunrpc/xprtrdma/module.c
+++ b/net/sunrpc/xprtrdma/module.c
@@ -27,6 +27,12 @@ MODULE_ALIAS("svcrdma");
 MODULE_ALIAS("xprtrdma");
 MODULE_ALIAS("rpcrdma6");
 
+unsigned int rpcrdma_max_recv_batch = 64;
+module_param_named(max_recv_batch, rpcrdma_max_recv_batch, uint, 0644);
+MODULE_PARM_DESC(max_recv_batch,
+		 "Maximum number of Receive WRs to post in a batch "
+		 "(default: 64, set to 0 to disable batching)");
+
 static void __exit rpc_rdma_cleanup(void)
 {
 	xprt_rdma_cleanup();
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 3d7f1413df02..32a9ceb18389 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -440,7 +440,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	newxprt->sc_max_req_size = svcrdma_max_req_size;
 	newxprt->sc_max_requests = svcrdma_max_requests;
 	newxprt->sc_max_bc_requests = svcrdma_max_bc_requests;
-	newxprt->sc_recv_batch = RPCRDMA_MAX_RECV_BATCH;
+	newxprt->sc_recv_batch = rpcrdma_max_recv_batch;
 	newxprt->sc_fc_credits = cpu_to_be32(newxprt->sc_max_requests);
 
 	/* Qualify the transport's resource defaults with the
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 63262ef0c2e3..7cd0a2c152e6 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1359,7 +1359,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed)
 	if (likely(ep->re_receive_count > needed))
 		goto out;
 	needed -= ep->re_receive_count;
-	needed += RPCRDMA_MAX_RECV_BATCH;
+	needed += rpcrdma_max_recv_batch;
 
 	if (atomic_inc_return(&ep->re_receiving) > 1)
 		goto out;
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 8147d2b41494..1051aa612f36 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -216,9 +216,7 @@ struct rpcrdma_rep {
  *
  * Setting this to zero disables Receive post batching.
  */
-enum {
-	RPCRDMA_MAX_RECV_BATCH = 7,
-};
+extern unsigned int rpcrdma_max_recv_batch;
 
 /* struct rpcrdma_sendctx - DMA mapped SGEs to unmap after Send completes
  */
-- 
2.43.7


