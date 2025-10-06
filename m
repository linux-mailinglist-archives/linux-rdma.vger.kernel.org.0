Return-Path: <linux-rdma+bounces-13787-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C241BBE40A
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Oct 2025 15:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 417284EDC47
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Oct 2025 13:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD84A2D29D6;
	Mon,  6 Oct 2025 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xe94k6yo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF262D374A
	for <linux-rdma@vger.kernel.org>; Mon,  6 Oct 2025 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759759066; cv=none; b=edK641DJhWcmm1oBhEcmuBRU8TPLNoRDvlbH+cZ7nH8dFxWwnVzfRgyYxY3z0/ygEiShrhtST1aJImQ2HlorwNtoAPgbSrePVqVncd1C81GUGfwxgDKFCbRLXlZws+rOx+lxs4mU+lbbWw2NuvLo77nUlKpZlBBR/OvTy1U/pzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759759066; c=relaxed/simple;
	bh=aoHPu3E0mvHoalx0FWQM3EH+lnlTpy4HtT99+90hPDc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AuHWVftTUZ8pf/ubX2z8bAwUG9pSxuIpNEKVUgeqGvY17kIHUDdb3d/RgUMnZWb6lPW+zRlFFRDEqlZmrg3e22aTD4YqOMOduWQz8aH8s26+w6hZjCUUMSlLWmmYxk4HyjScvu/kHehVf8ucC1MQ2LlpxUhIyWe2r0/FmMEq4Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xe94k6yo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759759064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N38NCXKatF4Nc9lTi4kU9EIStYgT9YorHxjupIC+4LM=;
	b=Xe94k6yoBohVja/fm+Awb2foeGBYDIIapZ9QvawSy8Jx8YGdKmSM4QQKk4iibJCZiSe54Q
	gBlnaXphDubGHU3nUg7iw51qGnQ3MDHEtfKCvdWEIQFtiUMWDyxXJRjj68Cpa4qQysKa4f
	mQd6S9D9nkSsyuvweLQ/jDZNO+vsB8w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-XqWYnsnWM5qZMR8JhtgU7Q-1; Mon, 06 Oct 2025 09:57:42 -0400
X-MC-Unique: XqWYnsnWM5qZMR8JhtgU7Q-1
X-Mimecast-MFC-AGG-ID: XqWYnsnWM5qZMR8JhtgU7Q_1759759061
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ecdc9dbc5fso2742578f8f.1
        for <linux-rdma@vger.kernel.org>; Mon, 06 Oct 2025 06:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759759061; x=1760363861;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N38NCXKatF4Nc9lTi4kU9EIStYgT9YorHxjupIC+4LM=;
        b=q7SkwRyyDVP7vV5N8/NGBWKJpu3uhBp4Fpck98PYa1NnOgNuASNsJ2cWzElQrMXTyJ
         4h0v2IFH6lEqGk5uD/E0ID9xHQ9ePppJ+17iwsOqM8UxWD2ZDwHO+XJHH2vdCKYhDt5t
         JQXS8DrAc3sl0wKJV3tdQMWPbJx2++6C7lTRjV1j9c1jQXa+1L7tirCV0BYh+wYmq5ml
         Zz6bLPGYPxIbaoMNPBV9jojLG7bPvTZG0vyBUDA4bP0twcfpCI36T/aI+oisxhItO+I2
         15MoKfwJTIEo7QJnwnAmU6ehhcm4elMSnCN5bgYv2ym6okpHcjxFyaQLBHZg1aMUXXvD
         A7eA==
X-Forwarded-Encrypted: i=1; AJvYcCWhZCY4OHNCmh60mny8FfzLM1zLOm+0l6yMIwDctHw7vo7g+keZ86uOMESxoy+1vSCWcR0g6rvEzSVT@vger.kernel.org
X-Gm-Message-State: AOJu0YwJLwmgEIFj9QS53VaIpGmLxz61OigLiQmLscWm8caEzM112aiv
	5MD0O/kkg3TgfNJXmzPXc5VpZUtzXhs66Ncq9TqQRnepJzyI9K9QUfMsd2Dh9n1dLC8n/6AeaLg
	ILoczWFshJR9VWeF/lpzTKlT4NLisiUZMd7ooxKqAg2Ps13MKKB0P2S7wFlSL8C4=
X-Gm-Gg: ASbGncudzNDNGvP8U3RlkGIYY06pl6HdDQ+OUM4iB+PtJSlN//Pn4ScFSMdeluFy506
	w7d28hJubzvGfDn08s6Pew/9NqlIJ/PBgvMM+29SBRye68gAlYRY6JS8bVRgIJcIJG/TZPXHK5K
	ZPgELqgwcMjaI/COPIeAiWyfNT9/aSPlANd2lkz6fEE2fcdU2g3dt35p0b7EAMNWPlVDKERegm5
	7/bodoeG/JE4eZdVxoY/Vr5PQfuHd/tGHACiJGyJyPqx8vHm8XbgRgeJur5aUBZyCBL3pMIJymQ
	im9Z87IFK6YaT853wxVUO6asZmV0R0JbjPfldlPoKSeXyR/iIZnOJ0ivrVbrPBzyZkvgFPJ9+ub
	r/DD44syMXH4q8WarsRQ=
X-Received: by 2002:a05:6000:24c8:b0:3e7:471c:1de3 with SMTP id ffacd0b85a97d-4256714c990mr8743324f8f.14.1759759061370;
        Mon, 06 Oct 2025 06:57:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSEXhNL5qt3C2EExsoRcqgHMQ8DFjBOOTUMJgsVGWdtBaHzjZoYrl+W+SOqr9EcfM/+bfqVw==
X-Received: by 2002:a05:6000:24c8:b0:3e7:471c:1de3 with SMTP id ffacd0b85a97d-4256714c990mr8743277f8f.14.1759759060881;
        Mon, 06 Oct 2025 06:57:40 -0700 (PDT)
Received: from rh (p200300f6af131a0027bd20bfc18c447d.dip0.t-ipconnect.de. [2003:f6:af13:1a00:27bd:20bf:c18c:447d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6c54sm21356683f8f.11.2025.10.06.06.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:57:40 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:57:38 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Tariq Toukan <tariqt@nvidia.com>
cc: Catalin Marinas <catalin.marinas@arm.com>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
    Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
    linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, 
    Jason Gunthorpe <jgg@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>, 
    Moshe Shemesh <moshe@nvidia.com>, Will Deacon <will@kernel.org>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
    Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
    "H. Peter Anvin" <hpa@zytor.com>, Justin Stitt <justinstitt@google.com>, 
    linux-s390@vger.kernel.org, llvm@lists.linux.dev, 
    Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>, 
    Nathan Chancellor <nathan@kernel.org>, 
    Nick Desaulniers <ndesaulniers@google.com>, 
    Salil Mehta <salil.mehta@huawei.com>, Sven Schnelle <svens@linux.ibm.com>, 
    Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
    Yisen Zhuang <yisen.zhuang@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
    Leon Romanovsky <leonro@mellanox.com>, linux-arch@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, 
    Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev, 
    Niklas Schnelle <schnelle@linux.ibm.com>, 
    Jijie Shao <shaojijie@huawei.com>, Simon Horman <horms@kernel.org>, 
    Patrisious Haddad <phaddad@nvidia.com>
Subject: Re: [PATCH net-next V6] net/mlx5: Improve write-combining test
 reliability for ARM64 Grace CPUs
In-Reply-To: <1759093688-841357-1-git-send-email-tariqt@nvidia.com>
Message-ID: <e77083c4-82ac-0c95-1cf1-5a13f15e7c58@redhat.com>
References: <1759093688-841357-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 29 Sep 2025, Tariq Toukan wrote:
> +static void mlx5_iowrite64_copy(struct mlx5_wc_sq *sq, __be32 mmio_wqe[16],
> +				size_t mmio_wqe_size, unsigned int offset)
> +{
> +#if IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && IS_ENABLED(CONFIG_ARM64)
> +	if (cpu_has_neon()) {
> +		kernel_neon_begin();
> +		asm volatile
> +		(".arch_extension simd;\n\t"
> +		"ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%0]\n\t"
> +		"st1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%1]"
> +		:
> +		: "r"(mmio_wqe), "r"(sq->bfreg.map + offset)
> +		: "memory", "v0", "v1", "v2", "v3");
> +		kernel_neon_end();
> +		return;
> +	}
> +#endif

This one breaks the build for me:
/tmp/cc2vw3CJ.s: Assembler messages:
/tmp/cc2vw3CJ.s:391: Error: unknown architectural extension `simd;'

Removing the extra ";" after simd seems to fix it.

Regards,
Sebastian


