Return-Path: <linux-rdma+bounces-6229-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F549E39B3
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 13:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74801B25A64
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 12:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED40C1B5EBC;
	Wed,  4 Dec 2024 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WYURK3iR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE69B1B414E
	for <linux-rdma@vger.kernel.org>; Wed,  4 Dec 2024 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733313903; cv=none; b=re19BNnqKDDmWoEEku2ZNNab/phyvGYRZtABoQLNiBsJYOQIIohUUlHH3nblol4oUFXopOgqSqh+Ag1tY3n8HftY1GO8ykcBhXYyCuoGkoomfE1uwRkdz9d4y1cTZGqZ0GvuDGGjiUHNBtZUJPNrd98RzUkPJ9BVgZYlEP0+YhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733313903; c=relaxed/simple;
	bh=SPU5qGKr6W7KLs3zKPv7ze9epevVLLifYZeMgw+ASmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bs+3AiOmN4w+oiCmROkdL/hWnZ1wWceMmCL6hPgGhb+zfZnmjh7UFA3XNpUiazU4Q+bs1pqiXEvil+OpruAKapvQLXzb4kgidDlfZzK3fJr6/gOkAgAodGF6D8QjSUyEdEn6M/BeCuPBDEXUSD5I/5mVzcnghTcyKI3eSJXNwGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WYURK3iR; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385e25c5d75so3337342f8f.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 Dec 2024 04:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733313900; x=1733918700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2HTzLtUFknu2HF0drvxFPQScK4jR5THhLdW6++BBWSg=;
        b=WYURK3iRau7fO47rGbl3wyxQRdS0e+QZ04l2Ikr/e1Su618t1wrHjQl6lmWYr742m9
         Dk2xrFj0lNAFBKqnk5XdzWvJhcvF7OndY1ioS0UOohNjAltdkKTFEHz5WHdNFB82/8c0
         ozEseZztpOY+SPUz2VS2VtgvVazMjBfkhxmX5jO+VCNrE0M8Ay/oOaRWqKJuGg0IUSFM
         Qdi69dh8GiHUv3huOQyrg+DF084DciSbs9zAC4tqmA5kAkysO0id9yn1aUU9/DPh80q+
         qglMqQbzGpUdRof2lcN90rZt5xd4FXXz5pYPHWvxxcQ/3yiouljgVFB3vXrG78uYCiGS
         CM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733313900; x=1733918700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HTzLtUFknu2HF0drvxFPQScK4jR5THhLdW6++BBWSg=;
        b=YwpWmPfgQvTa8HwOH14wJjqDluSEH4Fa7rTwGAcETkcwqPsMnBIhs/qqx0iewhIWA8
         x0d3NM4ge2bUbg1hJmS6b+nL3/ovpfgKKdHIenx9yRr3S/BGEyGNHWhRfV3auylQNyFe
         8khXL5kZILDsJ/mlZMV1Okr6AAR/CY+LPozQwhFCXr12jXdPNnUM2Eu7X2kimnrfAnl/
         +43bdJZIePVOiZZFwLuINEtfsOu8/tt2xpkaQWlgAOYte292S/RVhcDTIOsDPitPxggZ
         xiBRr3f3D4aKrgxLq6hhYWzANXn+RrV5ezCXEv9cHEGMeMnfA1xzhNf1S4eDng8LKNJ+
         bCGw==
X-Forwarded-Encrypted: i=1; AJvYcCWKHjZ58pKvOkR+tzVxCZhSzJSVDpWr9S/eMzwuecpOz/59XHmdvNsx9yNwc6vNYiG460HLdXXxHBpK@vger.kernel.org
X-Gm-Message-State: AOJu0YyrD2Oqzb1FDNgl7iWj5D67C5dwim4bx9Gz/zWhMpMkRJnE+xRU
	h7w2DsM7iw0KoTdiATH423ltovVqG1KGLBoBFs3qYUiVl/snZfrRPjcaB6HP/Wk=
X-Gm-Gg: ASbGncvoTq7zhO4MrJjRgjVVSxhNuHjW+VHdtl9oxQqRJIIpibZWnTDhe4LVBesiole
	wFgh4CJQai/W9tSreznzwNyLT20L7AEpp35I3ktH6tWDKmwCUun95GOcMzKqEt9RrGs98e2yUfU
	YcoWBepiufxLQYKVSGMBB0xFdjypM4QYTN7jSzDGI2xKVrJiLvtoC/Dx67zIHjWLc0/CPO3OalQ
	LUb3/+c2pKyveSnQD6NNZKWtODOHK1aB3pbjFjWbTV4ccZpfP2qvlY=
X-Google-Smtp-Source: AGHT+IHSOOjX2S8RW+96sDth6PSyDUIJojTUbvtBDQ/IgGFSrOvKvxmW9f9sQkeiGJSS62gURMGdVg==
X-Received: by 2002:a05:6000:154a:b0:385:e889:4270 with SMTP id ffacd0b85a97d-385fd4365c1mr5129003f8f.56.1733313900221;
        Wed, 04 Dec 2024 04:05:00 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d527e8besm22012245e9.13.2024.12.04.04.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 04:04:59 -0800 (PST)
Date: Wed, 4 Dec 2024 15:04:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Muhammad Sammar <muhammads@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 net] net/mlx5: DR, prevent potential error pointer
 dereference
Message-ID: <6efeeada-f514-4d30-909c-39a5786764f9@stanley.mountain>
References: <Z07TKoNepxLApF49@stanley.mountain>
 <cd5d7a20-7c34-4d0a-8f75-3cfca5f30b8a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd5d7a20-7c34-4d0a-8f75-3cfca5f30b8a@gmail.com>

On Wed, Dec 04, 2024 at 01:42:14PM +0200, Tariq Toukan wrote:
> 
> 
> On 03/12/2024 11:45, Dan Carpenter wrote:
> > The dr_domain_add_vport_cap() function generally returns NULL on error
> > but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
> > retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM
> > and if it's and -ENOMEM then the error pointer is propogated back and
> > eventually dereferenced in dr_ste_v0_build_src_gvmi_qpn_tag().
> > 
> > Fixes: 11a45def2e19 ("net/mlx5: DR, Add support for SF vports")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> > ---
> > v2: Fix a typo in the commit message.  "generally".
> > 
> >   .../net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c    | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> > index 3d74109f8230..a379e8358f82 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> > @@ -297,6 +297,8 @@ dr_domain_add_vport_cap(struct mlx5dr_domain *dmn, u16 vport)
> >   	if (ret) {
> >   		mlx5dr_dbg(dmn, "Couldn't insert new vport into xarray (%d)\n", ret);
> >   		kvfree(vport_caps);
> > +		if (ret != -EBUSY)
> > +			return NULL;
> >   		return ERR_PTR(ret);
> >   	}
> 
> Thanks for your patch.
> 
> It would be clearer to the reader if you test against -EBUSY and return
> ERR_PTR(-EBUSY).
> Otherwise, return NULL.
> 
> Or at least modify ERR_PTR(ret) to be ERR_PTR(-EBUSY).
> 
> Keeping "return ERR_PTR(ret);" does not make it clear that we have only 2
> possible return values here.

Sure, that's a good point.

regards,
dan carpenter

