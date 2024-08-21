Return-Path: <linux-rdma+bounces-4458-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B5D959A80
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 13:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153231F214B8
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 11:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8D01C4EE2;
	Wed, 21 Aug 2024 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="VdSCh6cn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4B91C4EF0
	for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239405; cv=none; b=ORWt7yHnr92ykz5OqLxNvakAcRePNMz8yhl4zlLDEgnBAE03qqPsVwpOPMhvwQxAXLif0PQnRQr5Q1vGpPFBSNbTcCJHzziFcWTsOAsUI/SuvQ/SRLAf3ZFJomq/OinWg4DH9gOxTRTXAbwd6RASuHJdgAdJE7d/meYF2vhuZY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239405; c=relaxed/simple;
	bh=E4Tkz+NNXf0Rqt+KeIW7YV0+OPjkqtWHuBsqB6QLKqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MN5tOlPHd8JL19nivl+Xjr9n9aVG2skg/PkMspyDYsY8rDaWVilo0qUdxdSjxvnH7BKsLDVFuegPscj18Skgqks3B4VG2UgIIRAqiIy7SNggKO5gBjtsp8EDcUUb0nq8j230MST/ZxtSNOe66iYLeP0S9w1seQSTKVI+UfIuU0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=VdSCh6cn; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a83597ce5beso111434366b.1
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 04:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1724239402; x=1724844202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HC3jHGsjdZENIhkaZnf9KhbQHlXlkHO+680dBNxyyNY=;
        b=VdSCh6cnEx1ef554tal8TDZPItXtG1Ad5J/TsMBDzSq2/mM4mCdmae4UUzqUOCHPG0
         jeFiDpY0Fry+XAdrhJCW5dLMf65u8gtWctlGS5fr73khEGc6AGZZxkI4QIYqblvtMPJ+
         REAdSHo49v2Se9e/SEq3Wg0qvhKzKjBUkcwD3T6QXHKuYza+EJMLCVgDN3j15yJHhZKr
         N1jJyHHRhKZ+HM8Ho27nN53QUcS3E/H64PMV2XeQS69jCrlai8yXCzC/xGaHp8rUY80H
         Qvfvlmy1hk1BEBIK79TjUSnIhNFIR00ThbSEA2g9UAE+kQClldYJAmYKA4MSbuSnmDQG
         AwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724239402; x=1724844202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HC3jHGsjdZENIhkaZnf9KhbQHlXlkHO+680dBNxyyNY=;
        b=t2BNddOnE+dch2RQi8QNSyD1QAwlmz0rKNIcEV45Z3t0EfUb7Bc+T9rxDBvPLV7mJL
         /mK8lf8YXUbpcoD6w8eN9Cfr/NvGxE5M20hJtUaDWGIyjfq+Ibzod1D8RU6btoPJp1cC
         85fN0qC/p3LbbKEvWxeuHH+avVLXKzTgqB+m4iB2kgb/8Y8+Jt+l0CN0K/+Rb3E9hLYG
         L3BmbRhDCUmZeAnmgWwZw4Y4RIXoMBhEPSkqfB41/jh4GS1sdmRlKk3Fbwl5Dzve7RuM
         GtMekOAclET47Jfx5GRmZYk9bk5FHCCgOMKX3GGXUW9mYy4+obOuNaGvoBT8zAQzZU9A
         yBNg==
X-Gm-Message-State: AOJu0YwVHKV8ly6CZIX20BO6WHK+kuKM2itLD/Ktyo/2t9NUpEFfoe35
	jnkbuAXzkallmFgopidRbxZx4RJHoksI51RrZizZPf00ZpGN51+iKBAnxBFBQ1WA/SJCDKA3TYw
	nCMs=
X-Google-Smtp-Source: AGHT+IHVtOtKjKEe2nw4L+xnQyvBeribB4AtIzAm+LIzBCmSeGBnSCHvaWZIgSbDeZCm4xw77OPcGQ==
X-Received: by 2002:a17:907:a4c:b0:a7d:ab62:c317 with SMTP id a640c23a62f3a-a8670180e3bmr176885966b.30.1724239401395;
        Wed, 21 Aug 2024 04:23:21 -0700 (PDT)
Received: from lb01533.speedport.ip (p200300f00f051d5f269a60e7b8956185.dip0.t-ipconnect.de. [2003:f0:f05:1d5f:269a:60e7:b895:6185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c65e7sm887934066b.20.2024.08.21.04.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:23:21 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH v2 for-next 07/11] RDMA/rtrs-clt: Print request type for errors
Date: Wed, 21 Aug 2024 13:22:13 +0200
Message-Id: <20240821112217.41827-8-haris.iqbal@ionos.com>
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

Extend the output to print also the request type.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 777f8e52ed7c..7c6d40380638 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -439,8 +439,10 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 	req->con = NULL;
 
 	if (errno) {
-		rtrs_err_rl(con->c.path, "IO request failed: error=%d path=%s [%s:%u] notify=%d\n",
-			    errno, kobject_name(&clt_path->kobj), clt_path->hca_name,
+		rtrs_err_rl(con->c.path,
+			    "IO %s request failed: error=%d path=%s [%s:%u] notify=%d\n",
+			    req->dir == DMA_TO_DEVICE ? "write" : "read", errno,
+			    kobject_name(&clt_path->kobj), clt_path->hca_name,
 			    clt_path->hca_port, notify);
 	}
 
-- 
2.25.1


