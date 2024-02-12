Return-Path: <linux-rdma+bounces-1008-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDAE851CBD
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Feb 2024 19:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95641F21CFB
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Feb 2024 18:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8D63FE4B;
	Mon, 12 Feb 2024 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FqvSun7R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877A11E4B4
	for <linux-rdma@vger.kernel.org>; Mon, 12 Feb 2024 18:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762621; cv=none; b=R1Rtp0IidjjZ415gNBVcjx62nWBWmogrTn9zoehK9KY1ZBY3yxHVPnRVrxdzOUK57gPC3S129xnRFY3mPihvFTDMhNfIlfjRmvbYHmgEzFTEYHWIsyUwTjhf8HLGR3+MXr9quKCIwF3pD6/QH3a0UgpdtYmtoRaNZUolFVxdmHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762621; c=relaxed/simple;
	bh=ljd3GW0VNxjxHS/gV3+xS6+IJarrBJeh1idhgkjc/cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuEjnih5vWj/cthLVdNIkOShHbZvpOkAW62sTBssg31ECk0eN/U1FRMaV/49UC2n9T4TX6R2lX3yprwuJN7CY2uN2OcrVWl+Pxuw+v9Kd1oVyg8GJNrbcTxO6kJKLCC0sa28txpN7sORTZG+/xwD6I63y84ASsYCQzDyCoTpaNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FqvSun7R; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2906bcae4feso1757802a91.3
        for <linux-rdma@vger.kernel.org>; Mon, 12 Feb 2024 10:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707762619; x=1708367419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N61bSTpFZ2e+PLuAfqmvguTh3fa1HE/2EqLDbYjvwcM=;
        b=FqvSun7RXHL/H6ytHAgAmKWDsz3oGmPva50Q6H19bG8jjIIOx6FxGGXp4ixLRgCPaZ
         MeoscEAT60i59UvzXbazQm9s4td6kToCv/VrgMj2porqbI7enwKZWI2PKD/EpUfnl9de
         QDgISkSoe7Jziqcf89i6BnKQD1lMeNymJ3tAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707762619; x=1708367419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N61bSTpFZ2e+PLuAfqmvguTh3fa1HE/2EqLDbYjvwcM=;
        b=KNBeuodpbeV14JiDr+IHheQWrZlUskEo15KscH5qHCWlYiJIx9B+0rIkQSVVjuQp0e
         beKZko5Hm329qZa7GKRNc/+U0V3n8UtHzdvlsrnEilt3pQ8j21kdcOMXtobCj2w0jm37
         uSpapvJ4w5h8UEzydGQQvUrTO7ozmwXK3unQVYAUnbxvEfVo5O4JBIsWWPGEGFUJAH80
         qSswT3EW/YrF9xlseut47EZUdLfyGzOOxNemGOQZujXkydoaXnQhjxEWCX1tvpCUiI3G
         69+ZY+h3N4ZTvDPN2b+CMOyD4EKHY5QGEd4vrqiHyADUSjlHsKKEPnYFKbsRdYZgw0WH
         uOlQ==
X-Gm-Message-State: AOJu0YwTMs7AqE4d8nhrIfh2NkukQOIG5P/Gyzq2DZ2uaNOFT0LrpkqU
	600eo+CAdKj06FrVktGXoZrWlMYMFZopIYY5KIPXOkYL27kogVnCKfFwuLnE3g==
X-Google-Smtp-Source: AGHT+IEWVVrqr5Ta5/Y8coFAcbU/62c7uV5RG1RnJiaLdKJtTlCzfEyZvDIyFRYCS+zxfkBl8ASQfQ==
X-Received: by 2002:a17:90b:1054:b0:297:1779:84fb with SMTP id gq20-20020a17090b105400b00297177984fbmr3738633pjb.43.1707762618832;
        Mon, 12 Feb 2024 10:30:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqzXReP3IYediOTpA4Y6OC6ft/joUK+DbNmZ8ShuoIpBTd0/KboIdivDaLOt5vZNYxKdzl+WOvG4XORuhYoNyibYUN9VXp/wkGK0yP4JRewr1UQUplInabN+LEwmrssN1JUWssJN1fsZZw8YsVjHSb62XTqJrpSQdZkEeLCvdtji2RL0fv1JEt9orngC4M0AHbgtdjwRkfJ+3Yktv6qug5esufKhfNneR0h4I+IuajP7KsRdy79020cVEeh0MT+3vHybMHJrxUKak+Y5gkO5ZeqEakCh9ObI+a
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ok5-20020a17090b1d4500b0029703476e9bsm849739pjb.44.2024.02.12.10.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 10:30:18 -0800 (PST)
Date: Mon, 12 Feb 2024 10:30:17 -0800
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@gmx.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Edward Srouji <edwards@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] RDMA/uverbs: Remove flexible arrays from struct *_filter
Message-ID: <202402121026.0AF90DBA@keescook>
References: <20240211115856.9788-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211115856.9788-1-erick.archer@gmx.com>

On Sun, Feb 11, 2024 at 12:58:56PM +0100, Erick Archer wrote:
> When a struct containing a flexible array is included in another struct,
> and there is a member after the struct-with-flex-array, there is a
> possibility of memory overlap. These cases must be audited [1]. See:
> 
> struct inner {
> 	...
> 	int flex[];
> };
> 
> struct outer {
> 	...
> 	struct inner header;
> 	int overlap;
> 	...
> };
> 
> This is the scenario for all the "struct *_filter" structures that are
> included in the following "struct ib_flow_spec_*" structures:
> 
> struct ib_flow_spec_eth
> struct ib_flow_spec_ib
> struct ib_flow_spec_ipv4
> struct ib_flow_spec_ipv6
> struct ib_flow_spec_tcp_udp
> struct ib_flow_spec_tunnel
> struct ib_flow_spec_esp
> struct ib_flow_spec_gre
> struct ib_flow_spec_mpls
> 
> The pattern is like the one shown below:
> 
> struct *_filter {
> 	...
> 	u8 real_sz[];
> };
> 
> struct ib_flow_spec_mpls {
> 	...
> 	struct *_filter val;
> 	struct *_filter mask;
> };
> 
> In this case, the trailing flexible array "real_sz" is never allocated
> and is only used to calculate the size of the structures. Here the use
> of the "offsetof" helper can be changed by the "sizeof" operator because
> the goal is to get the size of these structures. Therefore, the trailing
> flexible arrays can also be removed.
> 
> Link: https://github.com/KSPP/linux/issues/202 [1]
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> ---
> Hi everyone,
> 
> This patch has not been tested. This has only been built-tested.

I might suggest doing a binary difference comparison[1], as it's possible
that "real_sz" is being used to try to avoid trailing padding on
structs. I wasn't able to trivially construct an example, so maybe I'm
not understanding its purpose correctly.

If, however, there are cases where offsetof(..., real_sz) !=
sizeof(...), then I would check two alternatives:

	struct { } real_sz;

but that may induce padding still, or:

	u8 real_sz[0];

which would be a literally zero-sized array, used only for addressing.

Or, these can be left as-is, and the "flex array not at end of struct"
warnings can be disabled for these targets.

-Kees

-- 
Kees Cook

