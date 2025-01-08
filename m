Return-Path: <linux-rdma+bounces-6899-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E21EA056C5
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2025 10:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B24E3A649D
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2025 09:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9662E1F1309;
	Wed,  8 Jan 2025 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bg/wdFN2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042BC1F0E38
	for <linux-rdma@vger.kernel.org>; Wed,  8 Jan 2025 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736328374; cv=none; b=L0+h0EljzzmvveaPxyVsMVaXtvyCOxdNzALG0jXPHqAtNynTADAXecuYPJdad/rW3KDGmGPxRus1kVoy8JAuqu5pmdCXVsn+SLtdPYyMv4yxNYw6F2KglDL8WaWdijLVDqyH2cTNyyah2LlPGWKajzQplKqkYl7hS26ad/fuwlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736328374; c=relaxed/simple;
	bh=Al+JIkYrhwgUrke0Av47fm6GwPZPZQq1mOw0udRwbsE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BrCxbd8/LvL1NaP9hnTdhPZImSBFJhM6Lzl1ExLsRD31xXwb7aVqTqkDSVMvcIxKegUuJOkCAvmHkSxUrJHRvOmM9hekqoMtviK1mHaMdZRXfCfNaIJ2K5HcrJPz6N7DT2oG0r2G6A68Q/+iFvAFYY2bzYB0g3oU8IJz/eFj/I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bg/wdFN2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso118009035e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 08 Jan 2025 01:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736328370; x=1736933170; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=llw2mMGwxOVC/4Cd8CMxpSQ2joGdUS5FVjkkuZLdTQ4=;
        b=bg/wdFN2c6j6Noxoyp1P+OjM5+U+Sy1i4eeuts/VB8CY0YuYkU0oZ/BXwEMS8EQ1kM
         NAVS4KXdJQ9cMSbzVaeoKRuYspxUUs1Uks7yMOjEMV+RwGvydat1SIjbaodbVFB+7wWi
         +RUWkqCFhY8U+dMcvvFYBON3sjRqMHCBxalOkIy8fOvRpWm9uL7qSsCQCbkiHhxim242
         ZWicFyeTGt9OvxzaF//pQQMFutu12S9J6iTrSKbKdEEUQVtH+4xO04W5+N+lp2sqticJ
         cjgWgDQCwGSJ6leUVtIK9HJNoi+jJ5PfiQUXM8CrcG/gPraOFUcjqzuLzoWlVw+nbTjk
         vSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736328370; x=1736933170;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llw2mMGwxOVC/4Cd8CMxpSQ2joGdUS5FVjkkuZLdTQ4=;
        b=SNZ6A1uy1TMlvuCbR4KHpX5r+hdub4kwgi3D39+QqaItTAxnwGL9D0a1ieJHfey2jb
         ZsFym29KrvCLlyBPtOHfFfp3DT/wzKV+oQaVfHEa8XZRxHq3Cwe5SIATkBY5ekdVyBJV
         oPUurP/Lf4B5vzkzA0zldKMxytN5KpvdPkcTQNHjvWJ/pKfWTn8VnPPS9Z597w7WncEd
         Bjgbi2wuZWEeBm9xW92muFsXiymEAlsKHQWmE1Sp9OZyG0YnkIcQ3d2BrwSKnI7KH6jI
         bMREcti+Isigqcxlr/0BxdCtusajyXhT+JWdKa0iPvpRLSkOb9SoVDzhsALFu5s8M4Wv
         Em8A==
X-Forwarded-Encrypted: i=1; AJvYcCWEFfNEop/jX52LjocGxVqSvXCSJQLL/YHtcTqcDntfCDBH75/yzKhkIvLs/78drZsxXhacQdy+GRpz@vger.kernel.org
X-Gm-Message-State: AOJu0YzhYoCpqL5RogUkapYCFIrAKw6UZ9W9SFu3a9tPpg7KMknCGmYH
	jGgDeIqNfAWT8Q24tU5OEvA73S8xqf+pCDSK5IJF2jO+yZ77Nq0k+OsYL6LWDYo=
X-Gm-Gg: ASbGncuUlFqnSLABCRqoDg7AJBLU+ABhBNwK9c2v2YgsKWMCUBunBU7agpwsKN6sRG+
	7GgZ1G9a31BK59DsBbL4oFaLNHMwV22Iy/OxaE0z5DxDW2jWRuQ6aIo24p4qPHQmJpxfoNa6ZfR
	Oop4hC1UbzDjYnuIYMU5AAMh+i48VNffCQRIHR6ZghdxZYzIfgkE5bqzWF0tsnMJ+XpS7ksIawV
	BnFSjuaxK8ps6W7bg85RtckyiMs+CV/S7zRl7D7zD8RrNfytoj+FPUhUBuPtA==
X-Google-Smtp-Source: AGHT+IHYOyqY4pHUEmLh5C55hIoH02x8AafZyW/gRN9q2tRxk2NxlqiAWNdVuavxbFooX0Vi7IBNWQ==
X-Received: by 2002:a05:600c:4f47:b0:434:e8cf:6390 with SMTP id 5b1f17b1804b1-436e2684dfcmr13959835e9.6.1736328370469;
        Wed, 08 Jan 2025 01:26:10 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8472casm53257556f8f.45.2025.01.08.01.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 01:26:10 -0800 (PST)
Date: Wed, 8 Jan 2025 12:26:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net/smc: delete pointless divide by one
Message-ID: <ee1a790b-f874-4512-b3ae-9c45f99dc640@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Here "buf" is a void pointer so sizeof(*buf) is one.  Doing a divide
by one makes the code less readable.  Delete it.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/smc/smc_core.c | 2 +-
 net/smc/smc_rx.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index ccf57b7fe602..ac07b963aede 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -2155,7 +2155,7 @@ static int smcr_buf_map_link(struct smc_buf_desc *buf_desc, bool is_rmb,
 		for_each_sg(buf_desc->sgt[lnk->link_idx].sgl, sg, nents, i) {
 			size = min_t(int, PAGE_SIZE - offset, buf_size);
 			sg_set_page(sg, vmalloc_to_page(buf), size, offset);
-			buf += size / sizeof(*buf);
+			buf += size;
 			buf_size -= size;
 			offset = 0;
 		}
diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index f0cbe77a80b4..e0ff6ed83057 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -197,7 +197,7 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
 			partial[i].offset = offset;
 			partial[i].len = size;
 			partial[i].private = (unsigned long)priv[i];
-			buf += size / sizeof(*buf);
+			buf += size;
 			left -= size;
 			offset = 0;
 		}
-- 
2.45.2


