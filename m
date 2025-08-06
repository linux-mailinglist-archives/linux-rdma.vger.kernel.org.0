Return-Path: <linux-rdma+bounces-12599-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D60CB1C613
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 14:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299DD18C27E9
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 12:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4988028B7EB;
	Wed,  6 Aug 2025 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="avwHcNfJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B28424DCEC
	for <linux-rdma@vger.kernel.org>; Wed,  6 Aug 2025 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754483987; cv=none; b=RyGLIRrf1+hMvPKXfksgdwW+WkokJ9ii3+PoJLqB1UF/vgTBx1dY/kuxfdAxYvWzHP7zGhUTDYnWSV5esmzjhowtBUALOB+ruW9gY+G17I+DAZRdF3Dtkl97sNtBK8xKyJv2s/qN9kddnct411wlpT+yp1Zdfao9VT4vd2n7Vok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754483987; c=relaxed/simple;
	bh=swtQ9dzMq+lUac8jbN4//1GKwwI2KLHQMFCBz7s21c8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aef0v2N7s/waexFDBv5o2lsuUWsdLAziCLDo3GwQI6WYZvOuKW79abwS+sJJA1Mxk/syqk+78qgpLpx194jTYl9EAf83NBE4hluutIJyMtVjqt+C0V6Taoyd8bMnINhJ9Cs7c5Oqft8MDHBDl9jvZpjENZb5xLtr+rp8fHfSLPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=avwHcNfJ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-615a115f0c0so11557944a12.0
        for <linux-rdma@vger.kernel.org>; Wed, 06 Aug 2025 05:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1754483982; x=1755088782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wA8sr/HIP4ajt2UgO9mOS4/xSwlrz2Jes7HFAePPJAM=;
        b=avwHcNfJRrJjS+3qJTdD5sDvNbWUmpbDp9KvVSawD9DNePWtEUyIkcC1SDNwGEWKSv
         L3w0zhjsJ882Gb24MLe5pVaaDht0UBzcSf8wePx1e2jO7cjYGWkdWXIKhNYn+TOxtser
         +9cDFLM2edDi22DQEffXSn5uIFvdtiGSJe8eLLwJIBZ2LLwAspzShp6j7gWEbxr3JVOQ
         s4WwxMDg8B4zRMhl27VjntHKN7kYNF6BBYrspeEeP7Im0163kuy2HV5Lay8W/Oo5jt3P
         iOAhLOAW75I+IFDPpgRkjLJgqVnEDwCx7cgRhTVcKw7SIUVhDy/Po61wZAbb5ceKz9rg
         VkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754483982; x=1755088782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wA8sr/HIP4ajt2UgO9mOS4/xSwlrz2Jes7HFAePPJAM=;
        b=adcy+WaJj+MSjYQFN/WJRdOMruaHeZ8wdmeW/gOcqKlX1vL3GpHdL86WqJVtQxYP+a
         FRtuOAImDU8sIAZaiq3OhHIKDQRp7zVqpeWDuMKTZJqrUzmN+ziMjZXQWDA8txT+wXi3
         orXZgpTclokuBKD35v4BX6ZOIfCeKDBo2eb10ZgzDaG+8VBjfH6CJd8vy8ahu+9bD6JO
         wjCPDrHHeI1QN0c3Hd1zvhEJT4624I2874YXVaoAnyjk57IIcoHfiyRvvzKDvoG+4TMf
         UIbh3rbzM1sW0LI2L8YxuGm2wsgPGNWw5jq98rOzq+FcRt9sDGn4yomLU3MHhE35+BoI
         txVw==
X-Forwarded-Encrypted: i=1; AJvYcCXth62nntSWaloOjSBHVCRFUpGLzMWozKOgRGiW4ol7Lll1e9V9RrqWpa7QzX9Q4cNpKnqJvrgvZJhI@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx6CMndLguBbyDuszvj5oDMtBj8IWmSS8bGOl1V9T1NxhjQEwo
	Q0DN3niIjJrR71vTKjcFUfBTv5At/bVXGzF78JQnyOnisVVYNnR7ebWgLz0EVzS+4lk=
X-Gm-Gg: ASbGncup5d9opl/nKJgkV+/auPaSENNemI/MfeTiyOMPJ/1HbDyyrG21MxNpfyPsgXK
	3Ora9J2dLDjw2RECD9XXlTc/oHqMy42DL5nyEl+I9t6hPAlnbylVxM5sy02grEma22wIGQLAxIP
	BMx6ZcC0fHVDhvUu7PTzWUO/dKTQM4dOfbSOhJN1lmj/CYPMywYnX/1HuEuP3VeBGzlsulyNLXt
	nLBjKGOVnwR9qz6p2oMuT2Q2fNqk8SIjqHPU+3k+XrMi6uuxqLm2ywmfqHvzis7tZ1eoC3HIUQb
	RdGis7lp7SXkc4LWmGf2h5oOnPcOzHrT4ybGLZOxGMXusm2/3FrsYDnJcWwYxXHdSCtIZ510f4l
	H9ObWiW9twHLPQhqVFZgkV1BeHJ0189rKQlLitU0JF90s0A1YcLG78ZJk1TXMylh3IeRUS5KVBf
	8V83ybxQ==
X-Google-Smtp-Source: AGHT+IFjUN+U/CXzt3F4KjP6+H4Vt97KSUjqpR+4ZRuNCgDn+XmAU+werr9tQrf3XjecDNVThvBJYA==
X-Received: by 2002:a50:9f05:0:b0:615:e3f1:72cd with SMTP id 4fb4d7f45d1cf-617960b2dd3mr1649179a12.4.1754483982478;
        Wed, 06 Aug 2025 05:39:42 -0700 (PDT)
Received: from ryzen9.home (194-166-79-38.hdsl.highway.telekom.at. [194.166.79.38])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615cc38aee5sm8620934a12.3.2025.08.06.05.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 05:39:41 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>
Subject: [PATCH] rdma_rxe: call comp_handler without holding cq->cq_lock
Date: Wed,  6 Aug 2025 14:39:21 +0200
Message-ID: <20250806123921.633410-1-philipp.reisner@linbit.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the comp_handler callback implementation to call ib_poll_cq().
A call to ib_poll_cq() calls rxe_poll_cq() with the rdma_rxe driver.
And rxe_poll_cq() locks cq->cq_lock. That leads to a spinlock deadlock.

The Mellanox and Intel drivers allow a comp_handler callback
implementation to call ib_poll_cq().

Avoid the deadlock by calling the comp_handler callback without
holding cq->cw_lock.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 drivers/infiniband/sw/rxe/rxe_cq.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index fffd144d509e..1195e109f89b 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -88,6 +88,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 	int full;
 	void *addr;
 	unsigned long flags;
+	u8 notify;
 
 	spin_lock_irqsave(&cq->cq_lock, flags);
 
@@ -110,14 +111,15 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 
 	queue_advance_producer(cq->queue, QUEUE_TYPE_TO_CLIENT);
 
-	if ((cq->notify & IB_CQ_NEXT_COMP) ||
-	    (cq->notify & IB_CQ_SOLICITED && solicited)) {
-		cq->notify = 0;
-		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
-	}
+	notify = cq->notify;
+	cq->notify = 0;
 
 	spin_unlock_irqrestore(&cq->cq_lock, flags);
 
+	if ((notify & IB_CQ_NEXT_COMP) ||
+	    (notify & IB_CQ_SOLICITED && solicited))
+		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
+
 	return 0;
 }
 
-- 
2.50.1


