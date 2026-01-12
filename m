Return-Path: <linux-rdma+bounces-15434-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE4DD104A3
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 02:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A3A33019E01
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 01:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C4E23C51D;
	Mon, 12 Jan 2026 01:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnP1JrpL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A756522FAFD
	for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 01:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768182859; cv=none; b=NtJ/U0c6WvdPiocFeIaqB//u6n3C7in67d8BKnfo8BFcedGbs+z5bMrOFSRgj3Kawbd/GQnNUc+GniD98AtDKe5Z62ZUIFRSDSOC7NatAL130+R267k5806WM90Fch/71l1WvOJI5zA007eb+XpXDwfZewBk0ydoAo/wKdwYd7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768182859; c=relaxed/simple;
	bh=kCD6HRJcmZrPRPRnBZZYRifzn18q6tmbp9qI98+NNEw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YNbgKMmJuZh64gpX2G6HAN9K4uQtQW8ODlevANmCTutylkiGD9kQqD2MYrJ2KXqHI1AFLKg8VLGt/+WilBvdedTOjszO5zdNwWjO5WaU1r1sFpLq80EEBNefdCvqDN3FecHmbKsilgv0s/tQ4aLLQXux5Rp6F8c0RDgUCEBF2Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnP1JrpL; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-459ac2f1dc2so3480329b6e.3
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jan 2026 17:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768182855; x=1768787655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Auu+FpQXOrTqGrm+zeuNScIciQTdgODF3k4zFrtqeoI=;
        b=MnP1JrpLGCtKqHo/4lAyAgHzxnzDcFRX2OTTzpivbxyH7ORmase9vtG0AX1c2oxPKk
         oevyCvzoXtNr/LwuUIG81PNpF4BdZxFQs8AfpoLpuYaWv+dLc440Hb+jbbE6fTW/B2ix
         Jrn9S8CKR4TCjF3KJ7kdWmK+/gfw2oRbQRwxzdpS2U4qwZogWaQvKNef2khAlLheGET4
         tvqhXt0SP0vJYNWeo0HI0V+W0qj/5hXPzQEGIyPode11jT4QkEAhytAyLflciRM+TIdn
         FKGvyJjzbhgsapN7b32urX0VKiLp6dLkXF1aSagLztNRFscY7tnY2HIBXtYZkL8/ON2g
         lo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768182855; x=1768787655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Auu+FpQXOrTqGrm+zeuNScIciQTdgODF3k4zFrtqeoI=;
        b=OvrfPH/OznGrbqU2SOcOhczKwOcJAH/kmHCHLR5FgeE9XC+r1I8pIxjUUgSzGNNNvD
         RUDC63iwdTGiF4S9xk003ihmILqSVxKHdZ7xdIDKmBFm+nY2UJatB7CZAu/h6XfzmqiL
         Wh8jIe0Y0lZ689OEehhWgtyHvLCKni3LYAYHvXbsiTn0rHZWh9n/ZkmmTa5ANEKdZeWr
         MCQzizguFEVLAuer2pWXRftt+ehyAqKQuUEfyBLHBcnMh3lUUKTILeNp9LG73pCAPZ79
         DbLt83E04IPvhgRf98eE5EupvcjGfP/SNvxReTeW+11c6ghIXmLOPTDzN9f0uN7U3N2i
         WX/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGUkIOYr42hQ+TYNi9dO6qc1h8sWZRaPVeo762whUUUmq4SUFN8Rlv2IiIX5WvSkCzchZ2a7JSId6O@vger.kernel.org
X-Gm-Message-State: AOJu0YwM+8PVjxmuHAiqiDmtQH2mHm5Z1uYU8dBOnYzCn69Mc/dXK5KR
	ulb2tcWzmcsiSpUWAcqlYHrko4zNOz+42izYj1KqBsszfltpaGKsmvPw
X-Gm-Gg: AY/fxX7bi8CTnol/3+Q2tors8TFlVHkJs7IOgYbqm4THGS/jpal6Ype+1ADro3DKU+R
	TAI0diKGx8RYl9eVV/MUmRgsMX5QFwibELJtU3kulsOeznCR+QexeCF/dSBGMNxz/kIgirPHGFZ
	H5OTcgRMumbMQWjzKV/UoqohB59X7rGDyxtd4SWa7Sou7Q7zI9XbkYRuX2GivvtYXlzUQHvXxUY
	wo3FzYy6lQWCymYmVWm+Tm+UkgOVK3atKbtRj53Udt1OZsogxpcCfTuCklsNdVGjGhpC/fqi5Hr
	yeNbYyDj6MdMU+B/FFBRLK2aAjSp61x3/zYnCTXIfdujyX9htEEtSZdwC3EmHGKfumnaRKHFsIC
	s+7TK5VpFyjdT5pc6uRktpJLbS/TAU08XnHRkPsUpPZ+r1cWv6JPn2TbYYaW2ZmYhKIJExpSXRB
	OmbCZe8nNELZ1Oo9S8MhXNlYRIWccLD5zpJoxbUaIDgXs=
X-Google-Smtp-Source: AGHT+IHHe+FujPafjJdj2bFqV/CZm+SjasixzOvOcVsRDushPbttKyEYUrU+geCNc1IKW1DzU3OQzw==
X-Received: by 2002:a05:6808:1d27:b0:45a:769b:2157 with SMTP id 5614622812f47-45a769b2a38mr6340991b6e.26.1768182855469;
        Sun, 11 Jan 2026 17:54:15 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e1b0779sm7423502b6e.7.2026.01.11.17.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 17:54:14 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH v2] RDMA/rxe: Fix double free in rxe_srq_from_init
Date: Mon, 12 Jan 2026 01:54:12 +0000
Message-Id: <20260112015412.29458-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rxe_srq_from_init(), the queue pointer 'q' is assigned to
'srq->rq.queue' before copying the SRQ number to user space.
If copy_to_user() fails, the function calls rxe_queue_cleanup()
to free the queue, but leaves the now-invalid pointer in
'srq->rq.queue'.

The caller of rxe_srq_from_init() (rxe_create_srq) eventually
calls rxe_srq_cleanup() upon receiving the error, which triggers
a second rxe_queue_cleanup() on the same memory, leading to a
double free.

The call trace looks like this:
   kmem_cache_free+0x.../0x...
   rxe_queue_cleanup+0x1a/0x30 [rdma_rxe]
   rxe_srq_cleanup+0x42/0x60 [rdma_rxe]
   rxe_elem_release+0x31/0x70 [rdma_rxe]
   rxe_create_srq+0x12b/0x1a0 [rdma_rxe]
   ib_create_srq_user+0x9a/0x150 [ib_core]

Fix this by moving 'srq->rq.queue = q' after copy_to_user.

Fixes: aae0484e15f0 ("IB/rxe: avoid srq memory leak")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v1 -> v2:

1. Move both 'srq->rq.queue = q' and 'init->attr.max_wr = srq->rq.max_wr'
after copy_to_user().
2. Add call trace for better understanding of the issue.
---
 drivers/infiniband/sw/rxe/rxe_srq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index 2a234f26ac10..c9a7cd38953d 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -77,9 +77,6 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 		goto err_free;
 	}
 
-	srq->rq.queue = q;
-	init->attr.max_wr = srq->rq.max_wr;
-
 	if (uresp) {
 		if (copy_to_user(&uresp->srq_num, &srq->srq_num,
 				 sizeof(uresp->srq_num))) {
@@ -88,6 +85,9 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 		}
 	}
 
+	srq->rq.queue = q;
+	init->attr.max_wr = srq->rq.max_wr;
+
 	return 0;
 
 err_free:
-- 
2.25.1


