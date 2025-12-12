Return-Path: <linux-rdma+bounces-14977-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA58CB80EC
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Dec 2025 07:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FA47304D569
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Dec 2025 06:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF6430EF83;
	Fri, 12 Dec 2025 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pXz9MJxw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7427B30B53E
	for <linux-rdma@vger.kernel.org>; Fri, 12 Dec 2025 06:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765522201; cv=none; b=LdoAXfCRJI7JDtQe0oeethdQOVAi6MUeScRcD2k+UKU6Dh1gmbuyEUJfufQLVgjpGfMqt6/yaNyFS6F4U3RCIOceAH/Cts+Tglqy1/upTcAkLQayZQ0A3mHoa5tGPF44q+nb6m7J7ER2M7K4Ea5jpKoY5Sjb9Rhdw6WJx+H6+TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765522201; c=relaxed/simple;
	bh=DTFGwWuNKbAmdwHkTzFow5YiMCJGtQ8mcyQMBrXwz54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLOW2ohBMWVyZCRVQ6lzheFKMv7otaofvbua4GtHDz7DkW2+L3R/eNz6u7Z/pthszYTD3W0y5kFkZKbAYy4/kZaU4W6WoeqkW/XN1KG/pFnISHI0umxIyfUsGBV0mdxvb9wH35b5LKo9YWG701XOkcKW4n06yu5D58LCQXQrIls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pXz9MJxw; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-299d40b0845so13220655ad.3
        for <linux-rdma@vger.kernel.org>; Thu, 11 Dec 2025 22:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1765522200; x=1766127000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WlnV1FiR/V7IBDigSGeFMTF57gfnchPRlGaj43u2A0o=;
        b=pXz9MJxwnmLhQVc5MdOkkZcnmLvp7GN4k2mXXt7//EF2GNXWWv5DaTBN00YQiK/UWZ
         V4UWHFbD+xdTnhER7byxgILnPtwq5MEKiqUHnhaP1EHSmt4u+Qs/x7/iJNd/xJj2xupA
         Gajun2crv6tkhI+bdRhcnQyAfBcEwMWbFoJuUq1TArwM5v/q0/sk9M3gJT+Yg34i2pFa
         xCCv4bPH59eXQ62lfYWGewxlYkSUIj3BuDMPPdl8aUDUt948qPYGKO+ZsYvljSqL9v/9
         J0ZR9CD07tPKLS3A2PBQVzOFOorfLq5Ot+gzZ87x5VxaiK2RWPXXwBxyStHwxyKX9su6
         A7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765522200; x=1766127000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlnV1FiR/V7IBDigSGeFMTF57gfnchPRlGaj43u2A0o=;
        b=E5V/U65xCZj1wwxvQWeutNP83magzOFmnmfUfNZHJ8g2z1n7pu1MSd9l9qD5Fi9wTF
         5fgS5eSj3NSdEF3HLhOeiO0aSB2bVFU1TRKnZKhSMHz4fFfp0mveCg36TvwxCaiAI8dG
         h8WozuND9ZWQa53BSba5bzBmiD5I4bW6uMQPG7Q2PsU6IZM02snlkqo7rwEk8PRcy0w0
         imktX1Bg1VJWlqEIjeQqBN0LZwvwFGG668aFZU4GXDz9L8v9rod+J5ePRAB3TwWkYwkM
         4gj3hb+e1SMW9KyuWaq5MIIdIsuDpsRVhPVrBu1M034NholVdskV1Y/Gsgmb1T2mrbsX
         8CJw==
X-Forwarded-Encrypted: i=1; AJvYcCXtKfm3lWp2xGRpcU2+Whu7UWzR7eM6SIbT7Z9505K5dhf+/+CLpkrFyjh69IKlnUY5kwPfpz8jYjd6@vger.kernel.org
X-Gm-Message-State: AOJu0YyQeLPMVF3VUZ1eN1Xj7sWboGSV97edpi3WPvJDM8c6ZHX6iP9n
	YvczRfxmoPSPDRV709444j44nKnc48Ybp1PxTWZ6AnefhLerHmpHHAIY6hcsiCKwEEg=
X-Gm-Gg: AY/fxX6eBBPIqCqbfXnfwVbyjecj19Yz+4v156WsJPUAlpPjSNMW6q1FGf7zKzg/2ut
	0JhYulePCixb9fN51WPyYArxzq3Q7iKsD30q3yT53iTCq3eZENIdNJBsX0eHr1owRq8e2k8hQB7
	BPZO3SQrcTULvyci/bYxhjQNzYJzz+Ul09rTZetzqNMb4IAjmPmWEDzixDiXpYXsQQtKZdRb0Yv
	0rQSjaVseJCQg+zuh3rjf8eXumbNDhaBcHOGTuaWcA3HztJsrVLM6UZ5mIS1FOgKFvNAfuGIqGw
	61u88NZ1vJoh27rqk7gshzR2341hEO9Aoru325ICM0tqOgA/AODSVRnM6+EA+H2Z6IjMuMPHVeQ
	w1ViC8OA1WbigEx9fJsULSuOkFiu/YN0mAoViD+BlxsLRChfaziqyF9H2mUi5CQRSOpLLhSlpGx
	poHYRQiSF9hg1mmEZsg5I=
X-Google-Smtp-Source: AGHT+IFGlG7Khs7l0RX0nbij+9e0KUsOdKjB25WRf4l6rO1/TPgRflxwJpbDrMlMSorhExmwkad+NQ==
X-Received: by 2002:a17:902:dac3:b0:295:888e:d204 with SMTP id d9443c01a7336-29f23d1edcemr14254525ad.57.1765522199698;
        Thu, 11 Dec 2025 22:49:59 -0800 (PST)
Received: from ziepe.ca (p99249-ipoefx.ipoe.ocn.ne.jp. [153.246.134.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea01723bsm44047885ad.62.2025.12.11.22.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 22:49:58 -0800 (PST)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1vTwyS-00027A-LS;
	Fri, 12 Dec 2025 02:49:56 -0400
Date: Fri, 12 Dec 2025 02:49:56 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/ionic: Replace cpu_to_be64 + le64_to_cpu with swab64
Message-ID: <aTu7FFofH/ot1A74@ziepe.ca>
References: <20251210131428.569187-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210131428.569187-2-thorsten.blum@linux.dev>

On Wed, Dec 10, 2025 at 02:14:29PM +0100, Thorsten Blum wrote:
> Replace cpu_to_be64(le64_to_cpu()) with swab64() to simplify
> ionic_prep_reg().  No functional changes.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/infiniband/hw/ionic/ionic_datapath.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/ionic/ionic_datapath.c b/drivers/infiniband/hw/ionic/ionic_datapath.c
> index aa2944887f23..1a1cf82d1745 100644
> --- a/drivers/infiniband/hw/ionic/ionic_datapath.c
> +++ b/drivers/infiniband/hw/ionic/ionic_datapath.c
> @@ -1105,7 +1105,7 @@ static int ionic_prep_reg(struct ionic_qp *qp,
>  	wqe->reg_mr.length = cpu_to_be64(mr->ibmr.length);
>  	wqe->reg_mr.offset = ionic_pgtbl_off(&mr->buf, mr->ibmr.iova);
>  	dma_addr = ionic_pgtbl_dma(&mr->buf, mr->ibmr.iova);
> -	wqe->reg_mr.dma_addr = cpu_to_be64(le64_to_cpu(dma_addr));
> +	wqe->reg_mr.dma_addr = swab64(dma_addr);

This doesn't make any sense to me. The original code looks wrong and
would fail sparse, switching to swab just highlights how nonsense it
is, there is no way that is right on BE and LE.

Pensando guys what is the right thing to do here??

Jason

