Return-Path: <linux-rdma+bounces-2243-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B598BAD18
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 15:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66541C21C30
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 13:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B344A15358B;
	Fri,  3 May 2024 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GG9rlfyG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF6814A08F
	for <linux-rdma@vger.kernel.org>; Fri,  3 May 2024 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741462; cv=none; b=JGtim3HAWUMMdB/MG7PmqAWMK5VKfaAvs/R6UskKsDYlo94N+3IYgWtOre+OpwK0itUfYPDgJeJ+iaVKJ7iBjMz/EgFMLGtmzPapIY071bAs7tJL1W4RB/7uupOM0QWskKVANAHCt2h1Wip93q1cT2DWpvKujAYHMFIqgeuUvA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741462; c=relaxed/simple;
	bh=pffomHGtC34y1FLgL5SDQy8VpYgWMygSGhAt21/DLgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rW9j5JXiG7vSego1jMq+uEX9KIO/lpWohMIEE7qg93IlvNndQkkbdleBT7j5O7mva1OeQPI3Yck2ZJrBj1/VW0BI8k1XutXAhn3y1thq34+LZtr80WctcjZSCll4kZEf8u8KlrggMf5eWJDdjzfZoI2uRLU8NWm+mmLT28ox7dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GG9rlfyG; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5aa27dba8a1so5310645eaf.0
        for <linux-rdma@vger.kernel.org>; Fri, 03 May 2024 06:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714741459; x=1715346259; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T24fsb6UmCj1BuBe7A8xi01GqDYWjj7XjEjPE3iHXwo=;
        b=GG9rlfyGnKj8ylVzSj2OObBUNA6DDnSqdsQ6krq0LoEsHwjdQIln+4AOW9e61WCWDX
         Z23LJZfyYvr58JW0pSGW4J45ukdf4AiB+jATlqVny2+fkObZJKrgifCx9AJTfgsLRklD
         vMgGj7bvbynRCcLJI4MUHWUgiF7hqeNMxFPJ2QhrM3XMfTuJMlgwPudp0Un1xhJf4nM5
         ItQyoTcfN6pZd2m3sWpi4BL6gzwzGJHmeU+bb1mkDXECI+oN/6+szO9FiO20tbGZP4nc
         4ilIGx7orEj+RP1sA4j1Eg9+0ZUA9K8Bg3RiwbT6X6csmAAbqxpsyGGOfaQczsc1tJIu
         e12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714741459; x=1715346259;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T24fsb6UmCj1BuBe7A8xi01GqDYWjj7XjEjPE3iHXwo=;
        b=IHqaAMpswARPnuKJ1C+neqef7kHlYedK2cda6eniYjRjEfNnQa/0cUs6Ip9bDqSuHN
         Q/LgrP9geK5Cz60B1WJXUWLX+E0JPhseFRriZvFtuzPSalTbrgnOM/4Iqtkix4EqlUAW
         32GvgknpJySaBm7ztODFGbUYVomyiq/9r3hb2W2MrVWkGwhz+cuLMQlRGvNpD14+7Fiv
         2mCWA3nyuOSsTgZp5gFUkW5OeYUMjnCr1tdCQ6z1yWvDyRS8El9nFRi93HQ10n8zIZf2
         JaGeTuhihNXWBqNGJ51YrBUBv3gHjGYeEUrE2qp4gJxr8C6/7zH3ADC0GSdqvVOX/4QC
         SsGA==
X-Forwarded-Encrypted: i=1; AJvYcCVmdS8/qU3C5ZdWLFd3pkQ4tDdfsqfg42JNZsoWCqYqcNiuujZuI0WWeHAmt21FXhDuqJroPGa+2EsVgh+VhmylYGfCCQYKKO/AmA==
X-Gm-Message-State: AOJu0YxmLlcN7kT87azOLZ4bAr5oVde9UIH6pxyKi7OtOyEy0mTGX1S5
	pa3jyPj4C4sjjL46rVZQ2I03ljIL8WIa1jxivTw/RpcXMI7jNlqMWVU4hVad844=
X-Google-Smtp-Source: AGHT+IFkDVZmGphlJUVtShrOiyFDXAxL2dqwcQGk35D/hs5G0hXFSbZERBs+fJjVjtBARWifNREq9A==
X-Received: by 2002:a4a:4bc6:0:b0:5a9:cef4:fcea with SMTP id q189-20020a4a4bc6000000b005a9cef4fceamr2843172ooa.1.1714741459559;
        Fri, 03 May 2024 06:04:19 -0700 (PDT)
Received: from ziepe.ca ([216.228.117.190])
        by smtp.gmail.com with ESMTPSA id gr5-20020a0568204cc500b005a4bb400a0fsm620032oob.4.2024.05.03.06.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 06:04:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s2saG-006Wjv-Qi;
	Fri, 03 May 2024 10:04:16 -0300
Date: Fri, 3 May 2024 10:04:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	dri-devel@lists.freedesktop.org, Leon Romanovsky <leon@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Lukas Wunner <lukas@wunner.de>,
	Dean Luick <dean.luick@cornelisnetworks.com>
Subject: Re: [PATCH 3/3] RDMA/hfi1: Use RMW accessors for changing LNKCTL2
Message-ID: <20240503130416.GA901876@ziepe.ca>
References: <20240215133155.9198-1-ilpo.jarvinen@linux.intel.com>
 <20240215133155.9198-4-ilpo.jarvinen@linux.intel.com>
 <26be3948-e687-f510-0612-abcac5d919af@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26be3948-e687-f510-0612-abcac5d919af@linux.intel.com>

On Fri, May 03, 2024 at 01:18:35PM +0300, Ilpo Järvinen wrote:
> On Thu, 15 Feb 2024, Ilpo Järvinen wrote:
> 
> > Convert open coded RMW accesses for LNKCTL2 to use
> > pcie_capability_clear_and_set_word() which makes its easier to
> > understand what the code tries to do.
> > 
> > LNKCTL2 is not really owned by any driver because it is a collection of
> > control bits that PCI core might need to touch. RMW accessors already
> > have support for proper locking for a selected set of registers
> > (LNKCTL2 is not yet among them but likely will be in the future) to
> > avoid losing concurrent updates.
> > 
> > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Reviewed-by: Dean Luick <dean.luick@cornelisnetworks.com>
> 
> I found out from Linux RDMA and InfiniBand patchwork that this patch had 
> been silently closed as "Not Applicable". Is there some reason for
> that?

It is part of a series that crosses subsystems, series like that
usually go through some other trees.

If you want single patches applied then please send single
patches.. It is hard to understand intent from mixed series.

Jason

