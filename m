Return-Path: <linux-rdma+bounces-15357-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8C6CFEDFB
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 17:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CEA030477DB
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 16:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3D4350281;
	Wed,  7 Jan 2026 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="I5CkLsJM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8929D34C9A1
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802541; cv=none; b=Hqs85VslLy3bTNrgriXbeqLenoUGIb7qYIYOsjI3nqAzOqm+h6FqlNVcF6+vPRunSLBME8SudF0ZFTdYKuYFyPcKCOmolp9WbocrpKwfBmrSTJ1GZw5IPcp7JqfXyESZys17b4tk4xg7SHOoWS+YkUtHDy2ltIAJmdKldL+np5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802541; c=relaxed/simple;
	bh=KmQ+lTlSSyeiabGk18iSez5dhQAma8Uy8aFtqhbjpEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgCLbnk6NAMIV2mxZhxo+sr01U3kRWVVapxD487gB9Zkm4RjqoOxQ5xsHFz78KQDf8wB632w0oojCdVowegpuoLbk5hEyEqeaiszv3Kc0MKTbK1880G+7Ht8YtbdDdmlZ7U3K03jBwD5KXqD6OrEsSJ4JPDEKDSR8DreesJ3bAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=I5CkLsJM; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64d0d41404cso3320332a12.0
        for <linux-rdma@vger.kernel.org>; Wed, 07 Jan 2026 08:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1767802524; x=1768407324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEayMUcFMUX1WuUmum18FhEKvHb122sNv3VZ9V0g3Z4=;
        b=I5CkLsJM86whIdGgQHA2EAIzwG7yicr/RG/1v7phlHnjFR4dzyWsZYuFXJrmJufvte
         rvWoILM/8PKgUOjp1DAkJh1LF04Bl3TMWNIDDHdLbt3JWDOB1DdDREzSC75MRsMkurxJ
         de3OTQLdCiCF6Wp0wRQD44+XOOJnCdBca9+D2Bmhvh2iN/Qigt3FLH2VStFM5Bb5fRGI
         /UelAFHgqJk8Wwm9NmLcE7erJjhk6yTgg5kvuX+EjCV/z5cknA10/zqicYSCerJuqa1a
         PMU28sQ0nNd1xQnCeCczzrEtt02WNRa5d0doahaTYiiURaKjjbq1ADKd6JCu9Ipksfcz
         zMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767802524; x=1768407324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pEayMUcFMUX1WuUmum18FhEKvHb122sNv3VZ9V0g3Z4=;
        b=HurOwa6xwRwQlBYofYhd/hvnSCx2/ziceaoz5rBbyAoRHNFVhQjp2ETOimQZPBMeVP
         s3jHufB0RE7qyc5Ay2h6f+4M2JbrSL2hwmUOc16RNFby03KHugpN2IYwzBtgu74T8Krk
         wkWbqzZTjY/2VlpBbFzx1UrgJhKgzh+wdsj09X4MwpKHMscafeTKa167nXbmJOWplNzn
         2N/wJJUSThayANnU1HsJl3xHqjWK9/hr6sn3KX9OhhNG5UUGrgKnZ1ykR9gU6zFwYsRe
         yaqWj5fHli/HM6mRXnEnyHOH8A1kJyok3pwzckY9PcU8N6kg7dUKFTujWrNSIVF/XOoS
         Xv2w==
X-Gm-Message-State: AOJu0YxG/S1zscsFW5qRRn7BAFcS1HW/0ZVU0CW4vQnoN/ZHmEHH4z7e
	Y8a0HQ1Yq11P7H4Z+oks8TcogyabpukDVaKstKH4AeGFYtRZIWfmBnu0Ti73Gmh6CERseqHCK2p
	sfwhE
X-Gm-Gg: AY/fxX4psZi4pMf5IwMMbdYWTAAAelCr2izkWuTn6vngfLLyGWNJEhVYA7G66QHgl1X
	EimiPeNRY7oxa0gEdQs1w8GkfoDK/BRFWjUZu4Xk7pXJ/XTWqK6YIGr+pGo8lOV4xAAWsYS7PJZ
	9m+wC1bHyDfxJZ/7KlJ1RHrpeGg9h6vdoEGutKE5iERtbA46S2QLbdKHBQt244/918nS2MdU47S
	D/LMXblUrAOMIqn8KhvuPXiB3DAZj757PtQLOD6+sUs9NooMMItWweYAW+hvgibGkB9AwgXIQYH
	EKP/TMMziuZ7IC2CK+y5vAsN5S4XRNcB/qe5Jyf8FrHjHev4Ci7mLFHQ6DGWDdBnyweWKq4BiL6
	ZkGPFCcn/7SGTOoUfvUT3EYr27j0RmFA2JottVPLKGT9JR0dUJcY7nnUGJX8KlhyLhFaAGeKB7T
	WW5oCc/B9vvfeHTWMQ/8bXm6/J4BnADHDDZrumEmAjLOGojcyJaZALrhFXLgSdZbH4oYj24RUyF
	OYYEs5nKrVP2Kf5LgFllzs=
X-Google-Smtp-Source: AGHT+IEnF92/LqxSd2EIfroink3kDgqrOi1ckeu9CXIywuvq/ldfEBjnemUn80WFlgTYBU+1zPR7VA==
X-Received: by 2002:a05:6402:358c:b0:64d:16ba:b1c4 with SMTP id 4fb4d7f45d1cf-65097e46b58mr2749167a12.19.1767802523794;
        Wed, 07 Jan 2026 08:15:23 -0800 (PST)
Received: from lb03189.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4c89sm4864773a12.10.2026.01.07.08.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 08:15:23 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com
Subject: [PATCH v2 05/10] RDMA/rtrs-clt: Remove unused members in rtrs_clt_io_req
Date: Wed,  7 Jan 2026 17:15:12 +0100
Message-ID: <20260107161517.56357-6-haris.iqbal@ionos.com>
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

From: Jack Wang <jinpu.wang@ionos.com>

Remove unused members from rtrs_clt_io_req.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
v2:
- Addressed comment to remove additional unused members.

 drivers/infiniband/ulp/rtrs/rtrs-clt.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index 0f57759b3080..986239ed2d3b 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -92,7 +92,6 @@ struct rtrs_permit {
  * rtrs_clt_io_req - describes one inflight IO request
  */
 struct rtrs_clt_io_req {
-	struct list_head        list;
 	struct rtrs_iu		*iu;
 	struct scatterlist	*sglist; /* list holding user data */
 	unsigned int		sg_cnt;
@@ -103,12 +102,10 @@ struct rtrs_clt_io_req {
 	bool			in_use;
 	enum rtrs_mp_policy     mp_policy;
 	struct rtrs_clt_con	*con;
-	struct rtrs_sg_desc	*desc;
 	struct ib_sge		*sge;
 	struct rtrs_permit	*permit;
 	enum dma_data_direction dir;
 	void			(*conf)(void *priv, int errno);
-	unsigned long		start_jiffies;
 
 	struct ib_mr		*mr;
 	struct ib_cqe		inv_cqe;
-- 
2.43.0


