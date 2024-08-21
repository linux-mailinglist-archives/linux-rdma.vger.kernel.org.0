Return-Path: <linux-rdma+bounces-4462-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8867D959A84
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 13:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC97281A01
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 11:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE7A1CBEB7;
	Wed, 21 Aug 2024 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="gkYT60eX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6782C1C4EDD
	for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239408; cv=none; b=Z7+ov0FuspJ3nM+pVkfXAoJfxwWkWDuic6fOvmcCpps7pIn2I/MtEIwTuc4OFReuSqdPRN8HBDfu1v5vrxnC3+ErNNjeELrLaeY9I9ftKTnFy2p0yMEfyJj2xN2CwYxzfhOh7JKPcDUSSj1Zoxsf/hEtDdSzR9bhZJ+CN9Vq+LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239408; c=relaxed/simple;
	bh=9Mhk0G5eTjvUVrGb1C1f4tU+Cv91RNdEbk4On7wexo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PWo2MuT67EmPJZwIvZR7xUdA3ogRpCOueCR5imV6Fg+qAwGn5UYDKuiDVc8imZjKtP53ZXGX5xbl9yqglqFetS0YKRzOtW2gMMXKFBgp/l82IoEr1jx3gnMRKaAbexIZ49573+GF3xoKXHyMGNTl0ojnG8e0ONJ4etmAi7LMbds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=gkYT60eX; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8666734767so102953066b.1
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 04:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1724239405; x=1724844205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAw+RT5l4HLDJKlC26jq7Gm/uP6e5GmxJClzdU5sLnM=;
        b=gkYT60eX1/t8VOrskmE9FZj1It3+g6ud1rEwUcYFyyk7A+MxgRuwMZeUr+ZQQYkgW6
         /MpQdoUPX/jq3wILODXJp74wdgWGq9ggQnZ1xRBQ4vPSmsUzMyb5Cr+FYeDoSu7qZPuF
         LkWw5FxGiqvMJ0P13Cr+u6FbcnAxGfCiz9rYr0Hs+liazYWphHJfWGC9Y6skmyWXm4W/
         H6HLq+FIZ2aJr+rs/kbkxavCEQd80bYd9cIGBE9b8BDd3sGN2RN5lX56LgaNNdLu2pk/
         uhfo/q0p9uztByrHMqox+Yb1VBf0y/gdS5fdDzFmfeegF7jHa7hwTDiQvWpOtf297Y6T
         4RCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724239405; x=1724844205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAw+RT5l4HLDJKlC26jq7Gm/uP6e5GmxJClzdU5sLnM=;
        b=DY8sEHoKgVcIVWKYxat/XTUN2iDmbueqyh1tPzVKfSy2Mmzg5bXq/WANbDGclyUh2D
         Ngm4pfkAOZ8GccL5b5oSvDbuDaUtRHNakhwpw7NGzS0ib+lmrRVBuvGY1+2btEj1hdUI
         nIW/XsgBIwTYEpK38aJkTjTO+8L0PuyU/FV3iMr4iSewjDYLfBaaxJs2vAkRExwy2xr+
         xX/CcNqDdsTVRrS69GUBex+eTlKdqN4jkPcu5XU0Ml0iuVv9Y1LIvR4P8DjVybzkQ1Ao
         LIdDCQGQ+cK/nUwzLJUy2DewVRwbhjzaHTIEVEcDEcUqhgyesOe0e6JHa/2hFLnM23PG
         SBuA==
X-Gm-Message-State: AOJu0YzgQnDCtZVETJS9i4NA7jGcLcrRZzqapFm3VlGjvd4B0ruzpJ5r
	8jgX3+TT1JEF+LumpK34Q598IeS8sebe/4e52bE/Iiv9nt15kVFVxjCqlQnpAzjs5ySdFevIcMx
	CLvA=
X-Google-Smtp-Source: AGHT+IEt0aFD92I2QWlq8G4DDeCfTkuH67HgtPhfVcMKsFPTifLXzo+XYy8VgIEWJlW/b0MDKnnbCg==
X-Received: by 2002:a17:907:1c1d:b0:a86:4649:28e6 with SMTP id a640c23a62f3a-a866f8acf7cmr131214566b.57.1724239404327;
        Wed, 21 Aug 2024 04:23:24 -0700 (PDT)
Received: from lb01533.speedport.ip (p200300f00f051d5f269a60e7b8956185.dip0.t-ipconnect.de. [2003:f0:f05:1d5f:269a:60e7:b895:6185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c65e7sm887934066b.20.2024.08.21.04.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:23:24 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Alexei Pastuchov <alexei.pastuchov@ionos.com>,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH v2 for-next 11/11] RDMA/rtrs-clt: Remove an extra space
Date: Wed, 21 Aug 2024 13:22:17 +0200
Message-Id: <20240821112217.41827-12-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240821112217.41827-1-haris.iqbal@ionos.com>
References: <20240821112217.41827-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Wang <jinpu.wang@ionos.com>

No functional changes.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Alexei Pastuchov <alexei.pastuchov@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index fb548d6a0aae..71387811b281 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1208,7 +1208,7 @@ static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
 		ret = rtrs_map_sg_fr(req, count);
 		if (ret < 0) {
 			rtrs_err_rl(s,
-				     "Read request failed, failed to map  fast reg. data, err: %d\n",
+				     "Read request failed, failed to map fast reg. data, err: %d\n",
 				     ret);
 			ib_dma_unmap_sg(dev->ib_dev, req->sglist, req->sg_cnt,
 					req->dir);
-- 
2.25.1


