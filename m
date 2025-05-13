Return-Path: <linux-rdma+bounces-10328-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E5FAB55E7
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 15:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9EBD3BF6CE
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 13:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10DD1E5206;
	Tue, 13 May 2025 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpvk2IdF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A0426868E;
	Tue, 13 May 2025 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747142609; cv=none; b=FOo+7qDW5eQfdtmcTq3maQlruRUUWzADCT1vb41r3Ou1gI5bCuaf12oricoV0JuFAiCqLK+HSXK3ezoGvC9b/pKKZEa7KpeyFLhHqJURBh6I64iwlYtde54ogHh3VFCFDHxHAt+9PnAZymf3YleKdXpJ2YJTp/QLDBanZBx7Ebk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747142609; c=relaxed/simple;
	bh=cTXXsJVM38rWqGhADABaRwVadryYo/XtlVFLOSWmiKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hYAS8lO9KArJWQsnsPVfr6yvnyR4WqsmBaXayMJMEY/6s9SAxcWaSQHx23lmFpH+AYhvDuMhSyk2PkFsggEALo+CbuFFpZNaZlA9MmbOn6xYSVRfE0NjlDqZb2zk8i017i5Z7tnS+uj2iddzN0N6myhuT7Y7u8NPTbtRLZ7qqAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpvk2IdF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a0b0dd3b5bso408936f8f.1;
        Tue, 13 May 2025 06:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747142606; x=1747747406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NZarfg4sMf0DvIGIW+49mpcDtIlICol5eHP8GjNEIO0=;
        b=fpvk2IdFOVTMgD2DUro71NqgZDtnfid7by8cWHgaLwuvTm5cww4gnwmlHYOS7sIstI
         GO9h+H2GgpyLAx4I5cGCJu10J57KipQ1nG+/x/QWB3mSWnMJyCldRKIEYQYh84PhevyL
         GHSvmQgKgoszvOnIilLNklvucPp2PI2og6FpgZ+HQkhvRB2yY04Wj+CT2l1FARonvtFK
         LnZJdnDQdBvrjjWQf3GX8mb4Eb92LoRuuOntkrNcnB3KxCwSvKBPI9GhzfOZhmKFhWUW
         oVSjE/y6ikygFfHPod5RdimfzCDHjdPEk9YDnnur5G4f6UOK37zs5/8/p6eOWCNXIPEO
         oZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747142606; x=1747747406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZarfg4sMf0DvIGIW+49mpcDtIlICol5eHP8GjNEIO0=;
        b=aeylNI7ZRJegtb1VTk/O5mXq5+Yrloltmvnh2U+ldLEOzPrAMryfkdwov6sxVKIh7I
         NCKDr1hQSqj5vPaWsWmrVc9ue/IMg6dTFkh3AVHPvWwMpWygQItmOPo56/+XsFCkc1bA
         YrwLNgKVP/G96F6KWRaXO52EtH8P1kKHOuVyP6nlsPn4ykTqlITgEBvneXAs4YXGThFG
         7S4FAeWRsCt67ckJhJf6LxGzJc47O9q8A6gUEAic0EGYXv4+QdVXcoiVTnwAUpJ2HA77
         3iEX8fx2dpc4F/b1dBkzn1HifhWSkA+sHNM+EIhrgD1N5Qr38ierG3JJf/dfB40wpdzl
         3bIA==
X-Forwarded-Encrypted: i=1; AJvYcCV3GGt20Gk2QTNfGcbx7EdNepPz6TaSHjCNKoAarT72cCbWKYlsiDDLQJClIBMdCo/u3LdQxv1cp5wTQA==@vger.kernel.org, AJvYcCXr8Dh3CFnYcZxJ93BdAllccZ+JX652IMQ7xMnhgAfzyMqOWCR7Q4lewNyyHcl9d7ctCzlarMSVUomo8vk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+/+Gzy6wtr465FtYttGLdqOezaJemcV6XuUU4C+SFV8e+6jX
	jgx+64kzEmdpgtnZh0TFoMc5WvFrZ4iQzYygaX2GWSYr/She6jD3PWfGFMt5NWgYUg==
X-Gm-Gg: ASbGncvNnm5QgW90Kf9HLGSYYV03y6q9xPz4sC5FrmVSwrvpa4XBVi9J9nZ5z9LTKhn
	ZLXdtYrn184c3yGrum7knD3ZqSsL46NYvMVlfKWSf5Qoiqc+H7opkh6JKTzyNXZJJX6WUUSh+38
	AG7htyTH+KKSKA2kuCbhCbOHP1YMkssA4oxzO4dCgIXD5MmmbpR0z+nC0wgF1I0ck6OPSIVP3RD
	5nhz51KJSJTjfbftPdyAoeO3v5cY4rClANEkMyir5Y+wPIryyLBb1+rjGOzPv0TF/4ZJ609e8gk
	F72lpo7J+I/rBFH2aGdaJ4jaj50DCnVGnP/IXAiKqw1BznNMIn/I+drz/lS5xyZAZBI44fdTjZp
	p4ro=
X-Google-Smtp-Source: AGHT+IG7916p5DSeA6aKcAfWcE/IadhjplRPE6EDZGeHv6xC31zKbCI8Q0WY8n184rkFstXgnE6Ckg==
X-Received: by 2002:a5d:5f8f:0:b0:3a0:75ff:261f with SMTP id ffacd0b85a97d-3a1f6487679mr4506357f8f.11.1747142606274;
        Tue, 13 May 2025 06:23:26 -0700 (PDT)
Received: from thmoas-precision3591.imag.fr ([2001:660:5301:24:e8a:4faa:4b70:79ec])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2b29sm16452536f8f.53.2025.05.13.06.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 06:23:25 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Yossi Leybovich <sleybo@amazon.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Steve Wise <larrystevenwise@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] driver/infiniband/efa: Fix possible null pointer dereference in `efa_alloc_pd()`
Date: Tue, 13 May 2025 15:22:44 +0200
Message-ID: <20250513132252.980614-1-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`efa_alloc_pd()` assumes that `udata` is not null but it seems like
`__ib_alloc_pd()` in drivers/infiniband/core/verbs.c:279 can call it
through the `ib_device` interface.  This checks if `udata` is null
before dereferencing it.

Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index a8645a40730f..fea634b7d825 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -427,7 +427,7 @@ int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct efa_pd *pd = to_epd(ibpd);
 	int err;
 
-	if (udata->inlen &&
+	if (udata && udata->inlen &&
 	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
 		ibdev_dbg(&dev->ibdev,
 			  "Incompatible ABI params, udata not cleared\n");
@@ -442,7 +442,7 @@ int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	pd->pdn = result.pdn;
 	resp.pdn = result.pdn;
 
-	if (udata->outlen) {
+	if (udata && udata->outlen) {
 		err = ib_copy_to_udata(udata, &resp,
 				       min(sizeof(resp), udata->outlen));
 		if (err) {
-- 
2.43.0


