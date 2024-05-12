Return-Path: <linux-rdma+bounces-2426-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7BD8C357E
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 10:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1D77B20E41
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 08:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9C01757E;
	Sun, 12 May 2024 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EP4NhPXr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69562DDA0
	for <linux-rdma@vger.kernel.org>; Sun, 12 May 2024 08:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715502049; cv=none; b=lwon2t9Xm7OfoJFIfQEXrX761pYOq5oypMbjcZ4oip+TW26qJ/lXEBIYGmpodU5dZjcSR5EWWFXjcpBOQ/nRK3H8ExcXjB65fHDehNJNQHduNgLRRYzV1T/jeF9yniX1XGxmbPaGYcW29YofluSNCqWUOkBfkNz5hcS3CCE5hfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715502049; c=relaxed/simple;
	bh=57aIvZSlXvHd2XNr6XUvBTj1SaQbsmoHThuid5rkxjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QprKl056+EZ74yyJaKjsE9BVIDq+Jufby/rzP2nX5EfwOH4yRao5Mygeu8e18WqWtmn/873bmFVki1Sr97HCX2cbtJBSSJjP7ayrAX+3eioC9aP7d2z2rDlJhNsWmq6ZHeEE9ypBDqRDXBZosagIDvWHQKCrq9AaTMQfR1gdrnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EP4NhPXr; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59cdd185b9so759523766b.1
        for <linux-rdma@vger.kernel.org>; Sun, 12 May 2024 01:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715502046; x=1716106846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aA2OPIGe9/26kCTNuDnbmS99Q0tmMHaLiwj2IVXEJuE=;
        b=EP4NhPXrgCh0Y+nCrC/A+xOYfqnHp3W77DPdncZCfvE/5ZlUzliAKU4SgrbH6uaU/f
         JvOclsTe9KLMxcpaV2B7wEum5yskQ3samvYxcydNV6OhJi2gRZUtnERhovVBk3QHPPdI
         fBdeGsrH93lAMjqtcP03S331ukgQ9M1AEWqrQBEBoPW8QXtDWrLoAeunquR+9X1MDkdI
         Vteh+s9fD+SDe5Y91NzIe78od3RSswcb8k9AZLM6H4xPg8W9fT1pds6U0AYgipQFpYgj
         2gq4xzsWEV3oWP4wP3ijrtxi095VJxjviTQbP9YWEBx0NMAqVQ7p1C+FhzcnyCYRBDx1
         zNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715502046; x=1716106846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aA2OPIGe9/26kCTNuDnbmS99Q0tmMHaLiwj2IVXEJuE=;
        b=ZjesMTyYDD0slRLkQ0XMu7bPfHc012GeGauFTbSa3Q/tiIUZRlu7tAxOipTcihTfYA
         Lr1Q8+E7/NK9uE+4oR3kDQ0KJGzmIsHwGEa7aaIKM102pqqx0gpda2TLVaOrh5GwV9pT
         dKMPJs4sbU11h0c/NnFERbgheZ1gKCM+QEzu8BnwY5zXJhcEWExM2j+2y7+hbFcSkCCq
         yfulMD0U7THiDCar23aWiMPRc4mCJLcCAW1qyiibcXEI0faJzoNQPU0BKowXMOJBAz+8
         icSTXKaSWaTZ/7uVXGQz3t9hEcciX/+ZTNSRKRbKENVHUeZ6vc3CSd0FjkKjodY+YZyw
         0fHw==
X-Forwarded-Encrypted: i=1; AJvYcCXW1loS4jCUaxt+DTLGQOVtwSEiTz1e2s1g5w1Hu4Go6V6EbRWBzlY83F4ekbsBJsDjwApZ/sheua3ePRuHwOWdaf/lXERFN0h06g==
X-Gm-Message-State: AOJu0YyrfazjootXryPn9ehlR63Ki07UJRlbhalL89qEfEwz4DVtV0xE
	XBt4RXUf2XSXgvxUAZW+Q9eA2ukaULwlXPb0HXZ5gP74e/q6Lf4A7p3lxjz83XA=
X-Google-Smtp-Source: AGHT+IH8IAAcuq0uwpTf6fMx0D8wB462+TGmZE1W/D5t26zWbQkpZSc39eY03aIz5zXbSAbXfLd1/g==
X-Received: by 2002:a17:906:57d4:b0:a59:ba34:f047 with SMTP id a640c23a62f3a-a5a2d1de87dmr521612466b.22.1715502045535;
        Sun, 12 May 2024 01:20:45 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01399sm438058766b.172.2024.05.12.01.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 01:20:45 -0700 (PDT)
Date: Sun, 12 May 2024 11:20:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Shay Drory <shayd@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Moshe Shemesh <moshe@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net/mlx5: Fix error handling in mlx5_init_one_light()
Message-ID: <38283c14-c8b2-4274-9e34-9d5951816a59@suswa.mountain>
References: <a2bb6a55-5415-4c15-bee9-9e63f4b6a339@moroto.mountain>
 <20240511142304.GH2347895@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511142304.GH2347895@kernel.org>

On Sat, May 11, 2024 at 03:23:04PM +0100, Simon Horman wrote:
> On Thu, May 09, 2024 at 02:00:18PM +0300, Dan Carpenter wrote:
> > If mlx5_query_hca_caps_light() fails then calling devl_unregister() or
> > devl_unlock() is a bug.  It's not registered and it's not locked.  That
> > will trigger a stack trace in this case because devl_unregister() checks
> > both those things at the start of the function.
> > 
> > If mlx5_devlink_params_register() fails then this code will call
> > devl_unregister() and devl_unlock() twice which will again lead to a
> > stack trace or possibly something worse as well.
> > 
> > Fixes: bf729988303a ("net/mlx5: Restore mistakenly dropped parts in register devlink flow")
> > Fixes: c6e77aa9dd82 ("net/mlx5: Register devlink first under devlink lock")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> Hi Dan,
> 
> I believe that after you posted this patch, a different fix for this was
> added to net as:
> 
> 3c453e8cc672 ("net/mlx5: Fix peer devlink set for SF representor devlink port")
> 

Ah good.  Plus that patch has been tested.

regards,
dan carpenter


