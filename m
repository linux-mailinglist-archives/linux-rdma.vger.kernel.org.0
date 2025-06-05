Return-Path: <linux-rdma+bounces-11037-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F513ACF12A
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 15:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E841890240
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 13:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AAB25EFBC;
	Thu,  5 Jun 2025 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Kr9Id81S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8829E23C4FC
	for <linux-rdma@vger.kernel.org>; Thu,  5 Jun 2025 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131069; cv=none; b=X4q85T+M8RLbXxdw9/s6IfdHXMQl+YbJ9Xa2c1WCuZjwJgMuy3czO3iX9+94kozbo4ksDPncmwuHU09p60QTgbYnm9cnsVZJnhB+HrLqY0zD5nvFcuIHntmjylY+IQnJG4b1kn4w8wwJWF9os9YfTefCI6ShO18Dp9NppjX866o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131069; c=relaxed/simple;
	bh=rCO97t5tY3E5x9tBF5MM51T7nX5k5kOJxQqu9YByUYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+BnKUcxPWWQ5JU1UuZu59I1HW0TdhdRSFtexG35SdOoWZS5yt8/1n5YVQhvfwDdjyC77pIMw+IyzcW7Yg3y0GNCs7VR5DjxIVfoLjN8dewy9snO1MKrE3M7wmFnjhUh+04tchUguZgAwxFafF5NvRmauwmGvavY/qiRkvPJu0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Kr9Id81S; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so508757f8f.1
        for <linux-rdma@vger.kernel.org>; Thu, 05 Jun 2025 06:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749131065; x=1749735865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kQdIuSTATuzb/lH9GWsSgTLyKRDQtpfdIWX4HXG5tVQ=;
        b=Kr9Id81Sb1GR3sMZ3YtsKIYQhLqsGiDv5tZqVbu/cb74ByVLmEwaOyjMeG2DM95QaA
         XK1IjD4wa5jCqTLwqEFuEJfceyBX56DM34xzwhUAx9m9O+cqQb0R1aDeKQInzXWHbA3a
         dGVpq7tmG/nXAshI9IBQrcp5+b8WlF43evlFmWdxV97Y/k9Io20JaF3VT6GCTJi/Mcv+
         AbMsQLaa8tajF+n80XD7UV/bLO/oc6LQhwtGcT+PkPzcNcPxh7ijhco6mBSbO24MWsfF
         djkPdjMkU5jtuJyttk7z7aufJ2XrtuGW61D9ToOIf2Le7bM5MlNGP+QVLPVyPx+m1Gmw
         Pguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749131065; x=1749735865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQdIuSTATuzb/lH9GWsSgTLyKRDQtpfdIWX4HXG5tVQ=;
        b=W21c5bByX62CZwkczAa1Zv04HCZAV2S/QQiCMUDeXE/Pw0fAFOpremm7FK//y/Vk8S
         RqRgciOvj5vq4HKi/ocN0QlG8xN44nqbwhtWq/x62kUhlIXosOewVEFRedMvBcsCOhjW
         Oe1QBAfcVJzCigwCclv24MzUPzEPcP4KGloblLxbSex8Ggm8Ca1rf8ysuwSr8+IaA5zd
         O2wFiSdRFYzeWczwQIXBkuTHZNqWQIw58tXvmm1ZjPXwvM+xAk42BYLClr9seo7/5vZ/
         0SmtaUc1LVal7KSRilu7sLAPJDsz01S9QYzmHmxwXbmcSd/wNr/xDyaEgt+kO6EIS0xs
         qmOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8DSwpxg3BcG5CADVdF7P5wVI/xQzjEyVSKI+Ouv28G+omLqnAcIsuz9R5PQNzNhUf6Qxo6GlnZAlY@vger.kernel.org
X-Gm-Message-State: AOJu0YyAi6vPwaIdYjVRoKC2KzaivJ4HfocBr/cEAq1a7nuZfpr8rx/k
	UCQk5SFDVKkFTm3+Mo9lqafj4B7HOfJ0Mejl8pbfctX1cPDPrGr2l3+Bxo/iJ8mP0Dg=
X-Gm-Gg: ASbGncuQMKwHsHZuDXeKkAeq6nDtS8y2bz0Id355tAvXnkmmGHn+f2o98PtnfPICY0w
	aTbSfAmv8qic+Q7pickXpQaM4rwchv1HgXn6bWH0juUco7Jzxn3YY4MkbucD5ZW8d7PYOX36I7g
	IqjwgOFpJ53SLMYZk1fVLnpuS6RBkZ8zLQ7kSLRIffNWYFoy+BryejMYqREu2/nAWO8DXP+d9oe
	gDttGoW0BNiQnN+Vx9QSc3fZPOgsu/ZvPfH++q9lbkw5+o3HNi88xV/Xf+OcYa5CcJSfpEwzIm8
	Ii3sazXDwgxj5U5krM6V3GHTVGWlTYJJ3zAnlC9o16WZIBHSqOQFVOUeaROXguWGhqCrtMY/cgC
	klyrG
X-Google-Smtp-Source: AGHT+IEZBXkNJsZax09ksMSFFsYVIlL2lvRHaY0jmuIMadt7kKvrCMXnThYERvTqZ4mq0dgdqgi/bQ==
X-Received: by 2002:a05:6000:25ca:b0:3a5:1c71:432a with SMTP id ffacd0b85a97d-3a51d91c1f0mr5935337f8f.14.1749131064750;
        Thu, 05 Jun 2025 06:44:24 -0700 (PDT)
Received: from [10.0.1.22] (109-81-1-248.rct.o2.cz. [109.81.1.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6ca46sm25077312f8f.31.2025.06.05.06.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 06:44:24 -0700 (PDT)
Message-ID: <beb343ec-6349-4f9c-9fea-588b04eb49ee@suse.com>
Date: Thu, 5 Jun 2025 15:44:23 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] module: Make sure relocations are applied to the
 per-CPU section
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-modules@vger.kernel.org, oe-lkp@lists.linux.dev, lkp@intel.com,
 linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Allison Henderson <allison.henderson@oracle.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
References: <202506041623.e45e4f7d-lkp@intel.com>
 <20250604152707.CieD9tN0@linutronix.de>
 <20250605060738.SzA3UESe@linutronix.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250605060738.SzA3UESe@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/5/25 8:07 AM, Sebastian Andrzej Siewior wrote:
> The per-CPU data section is handled differently than the other sections.
> The memory allocations requires a special __percpu pointer and then the
> section is copied into the view of each CPU. Therefore the SHF_ALLOC
> flag is removed to ensure move_module() skips it.
> 
> Later, relocations are applied and apply_relocations() skips sections
> without SHF_ALLOC because they have not been copied. This also skips the
> per-CPU data section.
> The missing relocations result in a NULL pointer on x86-64 and very
> small values on x86-32. This results in a crash because it is not
> skipped like NULL pointer would and can't be dereferenced.
> 
> Such an assignment happens during static per-CPU lock initialisation
> with lockdep enabled.
> 
> Add the SHF_ALLOC flag back for the per-CPU section (if found) after
> move_module().
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202506041623.e45e4f7d-lkp@intel.com
> Fixes: 8d8022e8aba85 ("module: do percpu allocation after uniqueness check.  No, really!")

Isn't this broken earlier by "Don't relocate non-allocated regions in modules."
(pre-Git, [1])?

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1…v2: https://lore.kernel.org/all/20250604152707.CieD9tN0@linutronix.de/
>   - Add the flag back only on SMP if the per-CPU section was found.
> 
>  kernel/module/main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 5c6ab20240a6d..4f6554dedf8ea 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2816,6 +2816,10 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
>  	if (err)
>  		return ERR_PTR(err);
>  
> +	/* Add SHF_ALLOC back so that relocations are applied. */
> +	if (IS_ENABLED(CONFIG_SMP) && info->index.pcpu)
> +		info->sechdrs[info->index.pcpu].sh_flags |= SHF_ALLOC;
> +
>  	/* Module has been copied to its final place now: return it. */
>  	mod = (void *)info->sechdrs[info->index.mod].sh_addr;
>  	kmemleak_load_module(mod, info);

This looks like a valid fix. The info->sechdrs[info->index.pcpu].sh_addr
is set by rewrite_section_headers() to point to the percpu data in the
userspace-passed ELF copy. The section has SHF_ALLOC reset, so it
doesn't move and the sh_addr isn't adjusted by move_module(). The
function apply_relocations() then applies the relocations in the initial
ELF copy. Finally, post_relocation() copies the relocated percpu data to
their final per-CPU destinations.

However, I'm not sure if it is best to manipulate the SHF_ALLOC flag in
this way. It is ok to reset it once, but if we need to set it back again
then I would reconsider this.

An alternative approach could be to teach apply_relocations() that the
percpu section is special and should be relocated even though it doesn't
have SHF_ALLOC set. This would also allow adding a comment explaining
that we're relocating the data in the original ELF copy, which I find
useful to mention as it is different to other relocation processing.

For instance:

	/*
	 * Don't bother with non-allocated sections.
	 *
	 * An exception is the percpu section, which has separate allocations
	 * for individual CPUs. We relocate the percpu section in the initial
	 * ELF template and subsequently copy it to the per-CPU destinations.
	 */
	if (!(info->sechdrs[infosec].sh_flags & SHF_ALLOC) &&
	    infosec != info->index.pcpu)
		continue;

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux-fullhistory.git/commit/?id=b3b91325f3c77ace041f769ada7039ebc7aab8de

-- 
Thanks,
Petr

