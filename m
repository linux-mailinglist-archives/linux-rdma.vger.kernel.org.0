Return-Path: <linux-rdma+bounces-8434-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EC7A55716
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 20:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4AB18890BE
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 19:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0659E270EA5;
	Thu,  6 Mar 2025 19:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AVyteuIh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F7A26FA7D
	for <linux-rdma@vger.kernel.org>; Thu,  6 Mar 2025 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290554; cv=none; b=KQp7NJVBm6ScS5cCJKDRwD5RuuaDq7am3PURblktjbW2thMQh0V/F1JbsKUUsIjVIHr0aLDUj8oYBWiP2p1NOjtuWs7PVBRFJuQnsYfETMjwpgSPQM6TmTCGv48/akWmFKr1pN9xJDS4+KcIs3aqq2XCi4cJJKkaLHowm8QS85E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290554; c=relaxed/simple;
	bh=XJfj2IjX+cfbBfCUZB15uM51uhBAxMUtheYDfRvrsG0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H2oyjEGc96jiJ/G4M4Z6z/fzrL3F3LZ6bydMFmcHn/70i5P+kLgFmo1Vi8jugH8mv3ELl5tuNAu8Pxar1aH92XjnMQyAS5EWAZaYTJeAgO+dDt555PRdqzYzNmcB1Ja90wJwBWMtlIUbNZuFyHMDwSRW5NN23EhL0I4f2Nl6eok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AVyteuIh; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3912c09bea5so829977f8f.1
        for <linux-rdma@vger.kernel.org>; Thu, 06 Mar 2025 11:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741290551; x=1741895351; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12HOUV0N5LQ2gOm+72FrFChkl6gwbWnu1Vh8fRPsrGk=;
        b=AVyteuIhnvCmOWtB8xDnGN7AoQjB/ZixK8AXKWqiBM49ds/a59/XAWlGmALEwapeAV
         XH0w3zJtNUtGOA4kWDnAckb1EdkT9gjoNH8TH1XC7UuszbDgWeDkLppRxPkYC9+a9M0v
         ldwxyvkCV7w6Xooj0+pfe6bw68tOX251ygnZcH/7Fq//9A27s4L2mQYUCMSE8vruSURC
         fUNoU/ZSI9OpM3dsoXTguVtw87ngXax+OEkNNTbzYzV1sLLmLaay6NkTrlDKOFicdhAG
         o0C7h6XjuQzUhzhKoOeA5Z9693rXZz6IDJQ6SdCTf8KJsaNK2KNOnftwxpMbyvOhyYw7
         qV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741290551; x=1741895351;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12HOUV0N5LQ2gOm+72FrFChkl6gwbWnu1Vh8fRPsrGk=;
        b=AyfCwDbSGvmgAhICQ9VzCX6sqbRDleuo6Co6t6qUHTooAb0Os/x3A/CUwyFAIkmTtk
         Jl8jv6GJ2QHdQRfJbj/2ccI1fJ8ZuD53HlKt/Sqn2/4pui6Ol+lS6hhQENxDEnRt79iL
         hmGTNqoTRiVrE/3vCLclgBV4OWK9N5yMW2nHFt7ynsJyY6ZqmMDMjm/GIzd0dSUjDCBZ
         mS4froVcOhQ/CLZz6859kGyqKix1ilOsvMN8zB7llWVDq0bVyFoEzhN0/+s54MNP9Ljv
         Q8pUfsCSNHyA+0Rj1ABMn6XmjTX7BOv+tkJH5E7dwsfDIZ7aH237RVO7DxUCW21mOOR5
         LZ6A==
X-Forwarded-Encrypted: i=1; AJvYcCU4LSUw9BM9D3sC7KTGTxZ7x6b9LjLDcMDYHg1un2jpZXmyf0ABHd4E3DU6Iry9OFDUhuDCVuP6f7b6@vger.kernel.org
X-Gm-Message-State: AOJu0YykDj9JcTMCx/qQQNwcyRerCNEo6vdmYGr1/G6SSLnmJZ1c5C6U
	8SbMavbTA5bhISWcO+6yDj2DnCLzEvs9zKHHAhwE3prkQnv5Cwyeu9shZZ18BMY=
X-Gm-Gg: ASbGnctCy+l+lVlhiOuGk0q4q7L5IXmyJmulAP4+6b04UEUd/7GDAmZTmjE7SYnjAB3
	Oe0fcUASXOkDgCQvoDq4aBA2cLmgBZZh9b6sw04KvzvoXaYqxh0ZjI+G2v3rzfAxu81ypNlv/hN
	ENQLEqJhZw5BKUIJvTrpY2JAOD2ztN287XIWVfJRYZrgJ62xDwfEo1FKAyOQN2SWpg2iX4y0h0P
	pymWj3vqyrw4Nwem4rvKbJ0XdF/GIVZFP5EL9/1BuSjQIB07y2ZVaSy7W+ICWhKpmZI33INbxEO
	BsNLg3ubE0+X3SDoO38iMq9MWNJRJkrj7XwZIqq8qLVTT4yGmA==
X-Google-Smtp-Source: AGHT+IGs4Yei7Uj3yACj+GZktDDXIAXgpcENDsnATVmO5YWfHDh8m1kzphPMYmCnef1sPY9l6157dQ==
X-Received: by 2002:a5d:6d09:0:b0:38f:4d20:4a17 with SMTP id ffacd0b85a97d-39132d1f8acmr264061f8f.13.1741290551233;
        Thu, 06 Mar 2025 11:49:11 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912bfdff72sm3009082f8f.36.2025.03.06.11.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:49:10 -0800 (PST)
Date: Thu, 6 Mar 2025 22:49:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Long Li <longli@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] RDMA/mana_ib: Use safer allocation function()
Message-ID: <58439ac0-1ee5-4f96-a595-7ab83b59139b@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

My static checker says this multiplication can overflow.  I'm not an
expert in this code but the call tree would be:

ib_uverbs_handler_UVERBS_METHOD_QP_CREATE() <- reads cap from the user
-> ib_create_qp_user()
   -> create_qp()
      -> mana_ib_create_qp()
         -> mana_ib_create_ud_qp()
            -> create_shadow_queue()

It can't hurt to use safer interfaces.

Cc: stable@vger.kernel.org
Fixes: c8017f5b4856 ("RDMA/mana_ib: UD/GSI work requests")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
There seems to be another integer overflow bug in mana_ib_queue_size() as
well?  It's basically the exact same issue.  Maybe we could put a cap on
attr->cap.max_send/recv_wr at a lower level.  Maybe there already is some
bounds checking that I have missed...

 drivers/infiniband/hw/mana/shadow_queue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/shadow_queue.h b/drivers/infiniband/hw/mana/shadow_queue.h
index d8bfb4c712d5..a4b3818f9c39 100644
--- a/drivers/infiniband/hw/mana/shadow_queue.h
+++ b/drivers/infiniband/hw/mana/shadow_queue.h
@@ -40,7 +40,7 @@ struct shadow_queue {
 
 static inline int create_shadow_queue(struct shadow_queue *queue, uint32_t length, uint32_t stride)
 {
-	queue->buffer = kvmalloc(length * stride, GFP_KERNEL);
+	queue->buffer = kvmalloc_array(length, stride, GFP_KERNEL);
 	if (!queue->buffer)
 		return -ENOMEM;
 
-- 
2.47.2


