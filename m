Return-Path: <linux-rdma+bounces-1858-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D56D89CDC5
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 23:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926441C21B80
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 21:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C15148FEE;
	Mon,  8 Apr 2024 21:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oCKAg4T5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3C7147C60
	for <linux-rdma@vger.kernel.org>; Mon,  8 Apr 2024 21:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712612712; cv=none; b=kcNMB2THvt1QWk3a7q5nDxNG17331zKn9EpSGUaordXiY9a7KWbcgJLvgAU5O3g2CVuTZOAzFHFm2P6UV4ugzcRY7b+4tbuwr4pnnLPxc61Y90pM1W5VteyTMNvtN83q0pOZLmkPudETy2XpU5K6XvScbiwwund7Rv/UMgTawG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712612712; c=relaxed/simple;
	bh=X7881QJirmg5kgKlNpkQ8RqV6ValjW0F1QdmK3UujVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1Chb+MLaJqKUoUsPhVFrWHZhEXZFVKiHPFS/kEkc+NYcAXO/+zMiLh6qGHmJLnsw0LJr8p94ePW8nhi/jdnKmZjXFpTHL20hMUubuti9kepT17BGYLTiIkxqZRuguVd6ZRvKAma0FytkAooEogZS+HW7SoVdjYaLH57OxfoqHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oCKAg4T5; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d0377850aaso190489639f.3
        for <linux-rdma@vger.kernel.org>; Mon, 08 Apr 2024 14:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712612709; x=1713217509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fWZpTS9XdHFgXpHr6/MbkrB3un8w3RjB6kb0cWMEi/E=;
        b=oCKAg4T5S6hImvAITr6uNGMtSyMLcpuU0HEv8kCQgByNXXAIKLV/86jkYvllx6VqM9
         zo9+/144w1GgnwrURX+hm+jz8xcxfgdwH4lHJcvq7cAO2w9LCAqlKjiT6jVdq6jRn0Lj
         F+u0sO+gKOUw0vOnhGnm4RZksUsTb0X5lDenEIYpZEZSiIUsa3Fnstu2kr+4AwjhtMfE
         e9A6MTkGb45qQ3Ok7z1Tqp1su1ES6U/us9vj0G+/zc55+UJq1wDg2w4CRVA8088KElUq
         PwAvSxKGnyO5XyXGj4+K5IBGfX4ImKxsPUomMp+NSEtlRNO6n5fz/vRmsVBEHcwUoOIo
         dLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712612709; x=1713217509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWZpTS9XdHFgXpHr6/MbkrB3un8w3RjB6kb0cWMEi/E=;
        b=cpOzcfMHIgsiW6UF46qaTXCmaLmk4rl3kzWTZrB9QttSuvW5H7pJyM5XWkNwD4XEHo
         LfKZCZW+nJGhNCGF2yld/aNP9Bh9Qqfzyfv8c1CMSsSZniYnPsqzUztTtBYoH6hk5ir3
         8VSzPqBp4fQ3if7wc6+8wc+AMiWc7pR+taSquzgI9NobnUhBgeyEORs90f/6nmKB4NgQ
         BOPbHPbeSp70Tg0wEe7C7tu7mRf/BTuG0Sbvwenew5l/svwJ0YHuSlZzwx+W13+yOOAT
         cfK+2bg8wULb2fzhquZRnNmPNfaBY5P3JQzCtHLv0+eN8W9TTIRUDidOjujEbwmaEyWa
         4h2w==
X-Forwarded-Encrypted: i=1; AJvYcCVw1Wd9WoKa7+WSPdHndmk8vEZLodIigrF4bb42lZIPpxiNHPfdTDHytchqWItbP68dxye6JcHgl2AHYLbvbkbMlgfLSfd7/JmwlA==
X-Gm-Message-State: AOJu0YxLZs8YZ+p4K/7NcyX9Iiyw/lxpxuWz6Z2998GmNPfzlwhijyar
	++Ijr5UJMcg0UdVjz4vUvxb0jJiln/M9KZmBzmABuTVdTGGl03B7x6ap9no1+Q==
X-Google-Smtp-Source: AGHT+IFLq1rfhsWUUiNdA9bi7kvLMeZ12YsococyqKNZ8JgPgANUhC2CZCaaL5DaG2XegMan2Yy0ow==
X-Received: by 2002:a05:6602:47cc:b0:7d5:ea22:5a0 with SMTP id ea12-20020a05660247cc00b007d5ea2205a0mr4333622iob.9.1712612708751;
        Mon, 08 Apr 2024 14:45:08 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id s6-20020a056602168600b007d5e2b5803fsm1239469iow.17.2024.04.08.14.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 14:45:08 -0700 (PDT)
Date: Mon, 8 Apr 2024 21:45:05 +0000
From: Justin Stitt <justinstitt@google.com>
To: Erick Archer <erick.archer@outlook.com>
Cc: Long Li <longli@microsoft.com>, Ajay Sharma <sharmaajay@microsoft.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Shradha Gupta <shradhagupta@linux.microsoft.com>, 
	Konstantin Taranov <kotaranov@microsoft.com>, linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH v3 3/3] net: mana: Avoid open coded arithmetic
Message-ID: <sdj7w6zhu2lzbedahqtlorxv6v55gkogr7wisbzhcxwq4mubeg@yuddsvb2dec6>
References: <20240406142337.16241-1-erick.archer@outlook.com>
 <AS8PR02MB7237A21355C86EC0DCC0D83B8B022@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB7237A21355C86EC0DCC0D83B8B022@AS8PR02MB7237.eurprd02.prod.outlook.com>

Hi,

On Sat, Apr 06, 2024 at 04:23:37PM +0200, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> As the "req" variable is a pointer to "struct mana_cfg_rx_steer_req_v2"
> and this structure ends in a flexible array:
> 
> struct mana_cfg_rx_steer_req_v2 {
>         [...]
>         mana_handle_t indir_tab[] __counted_by(num_indir_entries);
> };
> 
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the calculation "size + size * count" in
> the kzalloc() function.
> 
> Moreover, use the "offsetof" helper to get the indirect table offset
> instead of the "sizeof" operator and avoid the open-coded arithmetic in
> pointers using the new flex member. This new structure member also allow
> us to remove the "req_indir_tab" variable since it is no longer needed.
> 
> Now, it is also possible to use the "flex_array_size" helper to compute
> the size of these trailing elements in the "memcpy" function.
> 
> This way, the code is more readable and safer.
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index d8af5e7e15b4..f2fae659bf3b 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1058,11 +1058,10 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
>  	struct mana_cfg_rx_steer_req_v2 *req;
>  	struct mana_cfg_rx_steer_resp resp = {};
>  	struct net_device *ndev = apc->ndev;
> -	mana_handle_t *req_indir_tab;
>  	u32 req_buf_size;
>  	int err;
>  
> -	req_buf_size = sizeof(*req) + sizeof(mana_handle_t) * num_entries;
> +	req_buf_size = struct_size(req, indir_tab, num_entries);
>  	req = kzalloc(req_buf_size, GFP_KERNEL);
>  	if (!req)
>  		return -ENOMEM;
> @@ -1074,7 +1073,8 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
>  
>  	req->vport = apc->port_handle;
>  	req->num_indir_entries = num_entries;
> -	req->indir_tab_offset = sizeof(*req);
> +	req->indir_tab_offset = offsetof(struct mana_cfg_rx_steer_req_v2,
> +					 indir_tab);
>  	req->rx_enable = rx;
>  	req->rss_enable = apc->rss_state;
>  	req->update_default_rxobj = update_default_rxobj;
> @@ -1086,11 +1086,9 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
>  	if (update_key)
>  		memcpy(&req->hashkey, apc->hashkey, MANA_HASH_KEY_SIZE);
>  
> -	if (update_tab) {
> -		req_indir_tab = (mana_handle_t *)(req + 1);
> -		memcpy(req_indir_tab, apc->rxobj_table,
> -		       req->num_indir_entries * sizeof(mana_handle_t));
> -	}
> +	if (update_tab)
> +		memcpy(req->indir_tab, apc->rxobj_table,
> +		       flex_array_size(req, indir_tab, req->num_indir_entries));
>  
>  	err = mana_send_request(apc->ac, req, req_buf_size, &resp,
>  				sizeof(resp));
> -- 
> 2.25.1
> 

Thanks
Justin

