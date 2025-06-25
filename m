Return-Path: <linux-rdma+bounces-11633-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFA0AE87F7
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 17:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69AD61BC6115
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 15:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E62626B75F;
	Wed, 25 Jun 2025 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TUDvy8oy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FB526B76B
	for <linux-rdma@vger.kernel.org>; Wed, 25 Jun 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864948; cv=none; b=l8eFcJRjM6obaJTnEHtHgjl9j/bzfjj7Nxh9gBiScg+q+/lMO5VQMYqp4fRchaDMc/lgpa2X3BMnoZzzXVW+8pQpdXntIjAbYiazXXhH4r+KWSFfy6lgi/ATI8V8Rr9YJB9meYwjRi++wFYnYhSFxHGLbRLJUj/HKyzF0J5H0Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864948; c=relaxed/simple;
	bh=tPS5HgtBH/a3YI75SOngGR5gSYBTs9/8ZTRA5upNPuY=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=ustxAUvDZ+K7ae0Em1HSfwX2ky99uiePdliacxLbsSFRZMx5sWQ4yMo1TLz7EshSaeSDHO/WCx+ccMWEAEaOVtjt7NaE5/OdUL/xGo0lExkl31sZquOppGorq8JwPrxdWqfbd8nI/TWVSifpeM6Hu255rNWic5pwf7aRhzADKnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TUDvy8oy; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-73a44512c8aso554730a34.0
        for <linux-rdma@vger.kernel.org>; Wed, 25 Jun 2025 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750864945; x=1751469745; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R7RcZ8tD+YY3u8+1Exwd57sweAEXV5GRa7q2EAtC8fU=;
        b=TUDvy8oy4Vj5NJRISQLoZWYsTrI3pumAE1AJMWveuBRE6Pv8Rpx8NgiOPuIU83m9uT
         T6n347s7Qmxy/g1Os0fniC++k1I/45Vknz5IaZ1FEHZXTa3Fe82zO1bsqQXw4up8Di7i
         riTVHnWin+uXLvn0Mko9IhXEOfWePSUAXOhdgJlSTt/GYY5vOYEZFDRIE5e6nJXuHedn
         FW6dwVXMYmrJgDXH0T37EzF6aq/juAcO2iaUBkqWX5ULS+DlIg7KrfGQnwivrfbB+XHs
         Gzm9wdoIRT/DItpGJZZBVobuwJs7ifEst/1pPN12knKWmYcj7C9t3Y2s7BWSh1zcKQrw
         iHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750864945; x=1751469745;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7RcZ8tD+YY3u8+1Exwd57sweAEXV5GRa7q2EAtC8fU=;
        b=PG2dTXXRlEsM3eB4lEurKYaDR8ptC9Jmm/F8kuoitG40DiFYUac+ESKYs6dYAMa///
         yrRIq4KWupaJPhHe6XMc28m+dWrpJ1w5ndXCpxW216NtBKaLoa0B2zITDENlKoTqpBYx
         8MlnvrCoMNcCu0+B0c2V3ZL62inTVFbrCy4L9fDcoH0Z/1K2/x7cYkOqdouEL/2J+ykR
         kb/lP5+Bmgfp3Aa/brO+/Dc/jBzUhYXiLmeOhCjE0aVHe18LEBVx9x/jfxGwdy7K9lpt
         SOvBxEBWZ2ZIfAGiPgnKg5egffFlmvLT1MhlLwOj1m+4Z6JJ0gwy5wgGToyKuGMBuaIT
         VRmg==
X-Forwarded-Encrypted: i=1; AJvYcCU9BKPv4NlNCTMv/+OZ1eEgwj+txMaEd6NRxEXHYzFNsaC1DdCoH4r+z2K5BV/TJ1IutYQFgSXDMUM3@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl4v2cN5o3JrMxi/t92MUnuoHv9aUakaZaTgXgMeKZ+9vDu1ts
	n1aMDM+01uQX0n5H6bZj9AF5oC/1OZu+S0WbV//PNKH4bfiBQe3RpshAlHQl0WDCfM0=
X-Gm-Gg: ASbGncuU+FfjG3mwSv2AUYtqYsjS8eDwIa55ecUGa++yyvU1omb1heIiDaQwHxzami3
	X9xMUbJURQOe98ht9oHHxIEGsDgzD9zICmfoUAMGJPQgLLzlhrqNOsaMzcalridaYIO56f51dwY
	CmKRSiCEHiT0Ivc0PRLmzuT53d6RfpGvNunjPAtoRsf+St00uohqxLDaZ8pqoeANAE+cjtLXx8K
	qPWsxCfGHODdXx60JQArV+oCjG8avBD9s7tRelizeTqcNY4lLgVn9jBVtpTeP1EYAwiC3nJ+165
	iG3fQgc7Reh8sv4mvcCOg6LmwnRtXpJg8XY6Ru4qy21CpASfqjvQdg3+cnRq832HvixTHA==
X-Google-Smtp-Source: AGHT+IHb85FqTS0ycz4BbaaNVMY143Zje2j6HGa+QScgiEjK4EjT7d3k0hQ6xgLXGqqJ3LGIaVnNTA==
X-Received: by 2002:a05:6830:8088:b0:72b:7cc8:422 with SMTP id 46e09a7af769-73adc7eb8eemr1794371a34.20.1750864945168;
        Wed, 25 Jun 2025 08:22:25 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1fca:a60b:12ab:43a3])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73a90c921a7sm2240183a34.34.2025.06.25.08.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:22:24 -0700 (PDT)
Message-ID: <685c1430.050a0220.18b0ef.da83@mx.google.com>
X-Google-Original-Message-ID: <@sabinyo.mountain>
Date: Wed, 25 Jun 2025 10:22:23 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Daisuke Matsuda <dskmtsd@gmail.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/rxe: Fix a couple IS_ERR() vs NULL bugs
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The lookup_mr() function returns NULL on error.  It never returns error
pointers.

Fixes: 9284bc34c773 ("RDMA/rxe: Enable asynchronous prefetch for ODP MRs")
Fixes: 3576b0df1588 ("RDMA/rxe: Implement synchronous prefetch for ODP MRs")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/infiniband/sw/rxe/rxe_odp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index 01a59d3f8ed4..f58e3ec6252f 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -470,10 +470,10 @@ static int rxe_ib_prefetch_sg_list(struct ib_pd *ibpd,
 		mr = lookup_mr(pd, IB_ACCESS_LOCAL_WRITE,
 			       sg_list[i].lkey, RXE_LOOKUP_LOCAL);
 
-		if (IS_ERR(mr)) {
+		if (!mr) {
 			rxe_dbg_pd(pd, "mr with lkey %x not found\n",
 				   sg_list[i].lkey);
-			return PTR_ERR(mr);
+			return -EINVAL;
 		}
 
 		if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
@@ -535,8 +535,10 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
 		/* Takes a reference, which will be released in the queued work */
 		mr = lookup_mr(pd, IB_ACCESS_LOCAL_WRITE,
 			       sg_list[i].lkey, RXE_LOOKUP_LOCAL);
-		if (IS_ERR(mr))
+		if (!mr) {
+			mr = ERR_PTR(-EINVAL);
 			goto err;
+		}
 
 		work->frags[i].io_virt = sg_list[i].addr;
 		work->frags[i].length = sg_list[i].length;
-- 
2.47.2


