Return-Path: <linux-rdma+bounces-12823-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B04B2CA83
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Aug 2025 19:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFA064E3EC7
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Aug 2025 17:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB6A304BB5;
	Tue, 19 Aug 2025 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="1GrBkpa+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05FE304BAF
	for <linux-rdma@vger.kernel.org>; Tue, 19 Aug 2025 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624355; cv=none; b=pelJQvlxIo45ZsBENRewIgCJgTfZvYhxms7/Uv/E0tPafEUIHEc5LvXZx32XH/ZSNmoA2vhhYqJGzv4XQYwvvNfmm/qoNayO+9+9HRXcBKm74ikKKqITuEnr7nc4fC2tsRQWAhIJgzaZVdh8hGSsCwGD5vmXHAGxjgiLqkPQKX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624355; c=relaxed/simple;
	bh=GBV13FKyir8kfypxR26CrxL7efucypvzQsqK+fC/kYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfJ6L2b9B7lOUkUsCibWiTf8GcNLzSE0m/g+N4d1Uef5F3qQ5+rMsyV+Zes49RpenBPxJLr6xFOMJSo/ukI6U+bEovl2zlQ28RR0WZenS4L5LQSccVjORG1ryZ2wgNW/bnnMFzWavwfhK1HjElJbkAEa9zA2qkos/dQmEP8fgf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=1GrBkpa+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7acfde3so791541566b.3
        for <linux-rdma@vger.kernel.org>; Tue, 19 Aug 2025 10:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1755624351; x=1756229151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KjoQco34wnq0FWx62tALK2m6MwiEYH9uCLBDH7Ywwg=;
        b=1GrBkpa+Ew5GESYlvubKkHRqYeJca7zR0fAcRDq1OujD8g/04u8mcrJJpQAxGCRi3n
         11rfGL9ETIW8vgRE3qqx/U1mIwxAbdlk3R4JnrH7SW46d2ttcjwoAc2SfqM4Aeah1CZ6
         Po6i9ok0VPN0aptRfVpNuP6IkD10sBY4ueKZKafiEVr0dqtxkFy13/j/qdCIhdf8R5j7
         TDKEXdUMpckOqRZOIUZBLF4C50d08fRPeY9zDRnMqUnSq8+T9Ft7NQfX2304Z2GV0pZt
         2xTycYEB1M/envRt/+Tai6kfZxBrL/k32t0T+MG1x6Ial2hjHdLGm3uNskfJlmD4Dai2
         2kEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755624351; x=1756229151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KjoQco34wnq0FWx62tALK2m6MwiEYH9uCLBDH7Ywwg=;
        b=OLY2fbsUYX/4Bb2CallK6+5jMWBVYg/2w01QTCqKFuSAumSj+mBkhEDJYiarpj5skf
         IuvaDbBnFc3JBHGr79OEvQIp6DqtZNHVMApF5b1KHS95LZA6g5xpZnObAj8+HB9NqvrZ
         1iy+xEIkv9cHd0uD+PFFF15ueAOYljOVQg75WgjwYOrJ7KSobjrMKDXNs6u7iOP9SoZT
         SmTFXeNdtvOvJwabh+cmyeJ4w8z9Y29hyMv7NCIW6ivQG/lQMfru1eF3gWU63Gc9rzfS
         K4uE/DlH0ZXb9OU6pBx+p85Q7Csk2GQZcLHrn/jQv/+pQoXPqpZSvxGEzz1AqyLD9Emi
         /YxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoG/24LgW6P8zfwlQ7ewvSyvrN9upZVC39nN09civtzvDoK+a9NYjgHzjw4LcUFmHKoJvVxXC25nzz@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy/jCJNgYqoPShB/juik0EEx+P0wMKvu2+XERfZrFL7B9Nek8R
	2P9jmC7aG9J5E5pm0inYP+oBH3IDC6i/nLDAQXZajwQAtYapMGyQ8s8JP/yXCNBYNTo=
X-Gm-Gg: ASbGncsdazPIyzSypmuRY5iC4qL1TEetWycQjK9nPUiuXaiUwT5p2ezQTvzQ7UIyj+y
	KXldeVQmtjjEFQiZuWk4Ge4j+KfAdOyGeNfObOu+McyJ40AdN7VqXeNShMS1xwE/qL8ZonSt05G
	XlYJKlKva8Dpmdc9LRACvCs4m3Emw7ed5AXOw+EjETMIIRZTlrmPBHg+C4DC6TptHhneK8eKBTU
	D5G8i5pW6+OF/BqD05cU8sYK8Tk1bv+wGAZb9YaT/264sW+qh24rlU5KxgjBGHynuRiLf+GG3f8
	dJoa5Cs90TTPwMKhCXB4JuiBL3E23Of0/DgzcQFigX/WW5Zz01aKA6p6NkFRtECyoEMXxVFQinN
	7oXn/AmTHFUDRyGcJTBDP8dzSKREMyn+VsG6dDboPlZZrQ8GtJzd5avZczkbF40UxkItwIXA=
X-Google-Smtp-Source: AGHT+IE5AjGUKwAZkNWCiL2ZU44AUNHMlXyejjcisiBbclf5xRlDqp3F/kYCU1CMxsOc/0mV5vXxNA==
X-Received: by 2002:a17:907:2dac:b0:afd:c0fe:b6a3 with SMTP id a640c23a62f3a-afddccdcc90mr302942666b.29.1755624351040;
        Tue, 19 Aug 2025 10:25:51 -0700 (PDT)
Received: from ryzen9.home (194-166-79-38.hdsl.highway.telekom.at. [194.166.79.38])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded2badd9sm18648266b.20.2025.08.19.10.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 10:25:50 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: yanjun.zhu@linux.dev
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	philipp.reisner@linbit.com,
	zyjzyj2000@gmail.com
Subject: [PATCH] rdma_rxe: call comp_handler without holding cq->cq_lock
Date: Tue, 19 Aug 2025 19:24:27 +0200
Message-ID: <20250819172427.645153-1-philipp.reisner@linbit.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <e0f88ef5-b046-4128-8c81-ce3c7e20274c@linux.dev>
References: <e0f88ef5-b046-4128-8c81-ce3c7e20274c@linux.dev>
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
holding cq->cq_lock.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 drivers/infiniband/sw/rxe/rxe_cq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index fffd144d509e..95652001665d 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -88,6 +88,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 	int full;
 	void *addr;
 	unsigned long flags;
+	bool invoke_handler = false;
 
 	spin_lock_irqsave(&cq->cq_lock, flags);
 
@@ -113,11 +114,14 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 	if ((cq->notify & IB_CQ_NEXT_COMP) ||
 	    (cq->notify & IB_CQ_SOLICITED && solicited)) {
 		cq->notify = 0;
-		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
+		invoke_handler = true;
 	}
 
 	spin_unlock_irqrestore(&cq->cq_lock, flags);
 
+	if (invoke_handler)
+		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
+
 	return 0;
 }
 
-- 
2.50.1


