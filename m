Return-Path: <linux-rdma+bounces-1764-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E3A89744A
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 17:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653AE1F22655
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 15:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9867A14A4C0;
	Wed,  3 Apr 2024 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hKOmOEp7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D40013398E
	for <linux-rdma@vger.kernel.org>; Wed,  3 Apr 2024 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159138; cv=none; b=cs3Vt3pzHYiWfZeR+nvTTPMkJCdQfS8/Z0Kf2s9ohP++l/Fnk9/Jwq1lPzUTRO08xnEH+0L/oVlTlbtwkG0D2hZPIpxPMMC8fpeqwA/qhyA6RaT3MoOntHV622yWyNmilR6LBpff77M7MJLMR3vRoRcueGHvnaqCD9hZG7akyWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159138; c=relaxed/simple;
	bh=zLgexbW2g6iQ/DV/NnjSU9FIqF8+vQiRbmJEWt49Ryo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoyEGR/v3Zi1TRimfBeqF2lxkbsyoG/VLEKP2Y5yQo+lmnVS3WHWMvYa8w1bgNHpplqFe6ix8xQv72C08DOMbO5wZcEOV/8M/2ewaL7IRYvZRUZDxJaseNlmdZ4fGk1RZ7V/35Eqbg6UGps4Vc5ksPWrbcUkHIibOjvgXt5wWmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hKOmOEp7; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c3d2d0e86dso3123893b6e.2
        for <linux-rdma@vger.kernel.org>; Wed, 03 Apr 2024 08:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712159136; x=1712763936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o3Q5Z2ASolvH2m9d3d+Ytjc+Iku6KsM1X3ZuAJ30QD8=;
        b=hKOmOEp7D07F5Dl3op3Zu5QHXUNTKTMiPUEhMLzgsJoDtTsbIwvDhlI02nmQUaC9bY
         lRHA4gWf0KzpvVLsAUqHdza09y5g1me/Hz9ZkghM7bEafNMnS1HyCshGlISNGYWxOkMT
         2f8wJCKwUiYuSDd8BntrxTqs4d1SuVL61avxvE3ko6hnskshLwaBL2UtU1s3rz5iAT6M
         /p/RUvj/omyKOrD3MDY4Ox/vHatN3NytlDuPJwSBYkXEn31yZGXWqCCAF5futwN5KfYX
         ZwlU0UXcp9MZkWeCmOa+R0g8A9aJslvwFrPTW9Q6z9xvMHusaLWDjPBpfbK95Lk/iLYC
         UK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712159136; x=1712763936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3Q5Z2ASolvH2m9d3d+Ytjc+Iku6KsM1X3ZuAJ30QD8=;
        b=nWHVcM/fdePO9hMIry0DK/5FXGZjRUbPtjjle6EMGs/o0h77cEM8CGjDX/UdYg5uUI
         8cRAyjxTZSgNrW9Fw6RGCzr8YQHbUTAYf9dYxketoa71pbJdIRn8/DFI+wV4zKYRZbhj
         60QG+N049pne5D5/2Ayn1Esh/pdgUDqxmXHegllLInC7NLhjTOOCH27567WTfsfjMpfn
         OOL3VCsy2g3/gz/1DvpGf16utG8p98dLqTPWJV3VGgugalJgLk+N0FS2uakXHIbQTpNJ
         a4BVgmWSuPYeatNokXwnQ1sQaxafwAzyYRLXxoSbfxt3Ev210foUAP2OXhf+a1SYcWRY
         C/HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnp101Xr9kB6ni3cwZFMKAgl/7tiAlKqrgDRcy/5CRzX7WrtQy26PRBAp8YHVGv9c0V8yC0dUKwn0kikkWU3PEcbNxV+rC8zPjxA==
X-Gm-Message-State: AOJu0Yz3eE/9606qUB9UHuaNaCFtH20+CscYkhAPXVxNpsnkWi/R/4y+
	2dFsn6RvLiYay+lXz4FS9xYYrxXUDvaQp8oIsweHnahJCz+elwm9WzR9rdsXvrU=
X-Google-Smtp-Source: AGHT+IGfksz7GJje1BMwCewZcFpXfptTSRr1WBLodHQ1lUsHhWa5mSPnxk5fU+k9Rz89zSxFTjK6bw==
X-Received: by 2002:a05:6808:152a:b0:3c5:d42c:48b7 with SMTP id u42-20020a056808152a00b003c5d42c48b7mr1387796oiw.29.1712159136219;
        Wed, 03 Apr 2024 08:45:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id o23-20020a544797000000b003c3d1b47532sm2495301oic.49.2024.04.03.08.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 08:45:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rs2nu-007hVG-P9;
	Wed, 03 Apr 2024 12:45:34 -0300
Date: Wed, 3 Apr 2024 12:45:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 7/9] infiniband: uverbs: avoid out-of-range warnings
Message-ID: <20240403154534.GE1363414@ziepe.ca>
References: <20240328143051.1069575-1-arnd@kernel.org>
 <20240328143051.1069575-8-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328143051.1069575-8-arnd@kernel.org>

On Thu, Mar 28, 2024 at 03:30:45PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang warns for comparisons that are always true, which is the case
> for these two page size checks on architectures with 64KB pages:
> 
> drivers/infiniband/core/uverbs_ioctl.c:90:39: error: result of comparison of constant 65536 with expression of type 'u16' (aka 'unsigned short') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>         WARN_ON_ONCE(method_elm->bundle_size > PAGE_SIZE);
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
> include/asm-generic/bug.h:104:25: note: expanded from macro 'WARN_ON_ONCE'
>         int __ret_warn_on = !!(condition);                      \
>                                ^~~~~~~~~
> drivers/infiniband/core/uverbs_ioctl.c:621:17: error: result of comparison of constant 65536 with expression of type '__u16' (aka 'unsigned short') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>         if (hdr.length > PAGE_SIZE ||
>             ~~~~~~~~~~ ^ ~~~~~~~~~
> 
> Add a cast to u32 in both cases, so it never warns about this.

But doesn't that hurt the codegen?

Jason

