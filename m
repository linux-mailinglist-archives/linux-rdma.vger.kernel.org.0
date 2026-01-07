Return-Path: <linux-rdma+bounces-15358-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECA4CFEE01
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 17:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FF5C3011039
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 16:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EB43612F1;
	Wed,  7 Jan 2026 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Qncy5INL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDDE271464
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802551; cv=none; b=DqgLviDx6S341fiJ6EgZK8mi0ZkdY1A2f6AMNusZJsZK9cDqMS5AGiB7b/J2VEcE9BqZo21EhCQkp/zNO2cBwXDS6JizKsxOfzKB/+B/Rh1TA5SKx3BgtJ4kSow1vooAkefT+BM1SDT0FQi0pVD8Ack6WliswaMu3Nges9027WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802551; c=relaxed/simple;
	bh=gj9fJlfCTB46jAlnfIXI/OwDQ7+x7bnJ0leFDVz68xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWpxaRfKzGh6yHuXJ2jdyWQinfCqnIczqql1dZ0IC/kQxocOKJ9yOhvZjgDDIVKBckFpi4uR/lfviZ+DolY8d+6m3HzTmqDz5k3qVwt8a/gVjfGXAX2aUBPV2w1HOxoAQE1WLEe5Asbj/oqzJH5m6aqQXabq813Zh9IIFDCHbn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Qncy5INL; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64d30dc4ed7so4301347a12.0
        for <linux-rdma@vger.kernel.org>; Wed, 07 Jan 2026 08:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1767802531; x=1768407331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMZksOEA6H7PfEJByCySNf4Rt/aposMosQA5cuQ5QnE=;
        b=Qncy5INLKxXzZlHQ9QgXGQSHozRaljFliwsQ+MlgsusQE12B4dGn1mXn+zIPRbrEqp
         4enK/LY/k96u6OyMGqsyFNAtpELq1HNwltoGEDkgs6gfJNkvPlVMt3BRs5n6XL/tfXG2
         myre0izfB5rY7cq5Zy1Q6K0Dv9jpvwqVsxvdo+/Kyvr10VgYC1Cfunxju45RgYnPfjhK
         U5iqSDJGDwcoKeCZIaLNNMcQ/ndUedMqGAp6V7S44oN8cETsst2Pg+DsM9s/QSopi2cF
         K/YiR20tqPdV0/Ezw3HSLMgPf5hD/9v+I/mYAnkCQRGXD7J8l4lGX5ovo48YNYTU47/r
         LNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767802531; x=1768407331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LMZksOEA6H7PfEJByCySNf4Rt/aposMosQA5cuQ5QnE=;
        b=wTb+UAo2WhkrMndKcf4oWyHQBiIP9d4gNoOZwg69WmqlNhiMVL0LhZszxN+if2sYJu
         X7hU9vPX4lifqfCY66ebLBmfAGf8oExx7xXYaIZKdpPbaqjXdkPaqy1KdstaYLFXoM5C
         ufpZ0bQYFS7RD9NPH9wWT+/NSKF8Wc5RdgGRflZMmcfu/Pp9hp5jRgdiTzNQBMcp0TO3
         tMoA1YWIfEe/bbRiD8tSwotoUh5f2WvVrCv+rA9ez3tT2MyzfIuY9eUNiC5pPopuXaDN
         +u1fiGgMwIdxzxR91XRPe+Dg2wGcfae3TImSPskVqxS35UPdWfRgMllX7Ll/OuFFTR9G
         LLpA==
X-Gm-Message-State: AOJu0YwHm4xq0F0FestNK7QY45lq5elJA0HhL6XtQowEJRpVutjFLOwg
	gDF7VO1WZsvmEUaIY3pIXT83HE7vLz7WzVW9VnuF0K/j/oyJ267JBmlz3C0tP2FbOmX50e95seY
	7DsIt
X-Gm-Gg: AY/fxX4Cowc3v64ujEDeIaVVRz/UVAi8P+vT2hYlJD/AiOO4K2GhD0vCqOrmwZ7FXTL
	OzSdLyJe51MvTWW9MAOXpdrMPDhTwYc1iJO+xa93PNZZ5d3nUwwR5geSGUMUS4rhoAoxMaAPDyB
	aftOtUv3QCNpkFHBLLY40yIzfd8ZYSeypGatACPeTnXjtXlrXt5nFiNMkhaaT2yFRWrR3L4sPDS
	zlbBHUbPoDmfEfIYdtMQXj8/BnqgbrBuxM+HA9XmjnDW1XurJVl0A2FCbEt3cyrALt3BJyq1yUZ
	pfw7U1c9t7bAVQj8dCwx390iEVLEiovZ3EO5QmbyrQuQRzK40lxsSY1W9C3EYP9ND38ChHCsEjG
	HJiWLS1wlEMGVF1wGDUJc6qrlEYZscal6B6/eS0IIGNEaCUfCQlIl9Lzm1TokSlyMVLqWvfxDhr
	GSbXtrjOzXfvedI4UKA4h6Z88aGwS7FlUjANm3OuITvw99SxNZEq7a0GY6voGWcIHV0gBpx9jxY
	mjEsbMScsAHlgTMdqyqMBs=
X-Google-Smtp-Source: AGHT+IEqiRx+60KP72cSaA//Xi//24S+znE7iXyFLtStBwYiSVHKsRMzecqvirhU9Z4wY4wS+qQ36w==
X-Received: by 2002:a05:6402:1469:b0:640:edb3:90b5 with SMTP id 4fb4d7f45d1cf-65097dcdd08mr3094102a12.7.1767802526447;
        Wed, 07 Jan 2026 08:15:26 -0800 (PST)
Received: from lb03189.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4c89sm4864773a12.10.2026.01.07.08.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 08:15:26 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com
Subject: [PATCH v2 09/10] RDMA/rtrs-clt.c: For conn rejection use actual err number
Date: Wed,  7 Jan 2026 17:15:16 +0100
Message-ID: <20260107161517.56357-10-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107161517.56357-1-haris.iqbal@ionos.com>
References: <20260107161517.56357-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the connection establishment request is rejected from the server
side, then the actual error number sent back should be used.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Reviewed-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 5e9f2153936d..59e30640f94a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1929,7 +1929,7 @@ static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
 	struct rtrs_path *s = con->c.path;
 	const struct rtrs_msg_conn_rsp *msg;
 	const char *rej_msg;
-	int status, errno;
+	int status, errno = -ECONNRESET;
 	u8 data_len;
 
 	status = ev->status;
@@ -1951,7 +1951,7 @@ static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
 			  status, rej_msg);
 	}
 
-	return -ECONNRESET;
+	return errno;
 }
 
 void rtrs_clt_close_conns(struct rtrs_clt_path *clt_path, bool wait)
-- 
2.43.0


