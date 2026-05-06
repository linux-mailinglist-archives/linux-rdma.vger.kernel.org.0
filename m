Return-Path: <linux-rdma+bounces-20083-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFoKHp1I+2lqYwMAu9opvQ
	(envelope-from <linux-rdma+bounces-20083-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 15:56:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE834DB6CA
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 15:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB4A1301C10C
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 13:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F44547F2D2;
	Wed,  6 May 2026 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="M3f7smLK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C480846AED7
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075788; cv=none; b=tF/cCGQ72IrQDtiSQlgKdIQ3yYdbWdMytroY04y9wHJUPVW6Fg8L5qi+GBTPEltvRwAvSAm6yll8F+GDxchvUZa7U+8kldBpPaI74sdslcsEN65Xrh/C3G6+fiKsB0TKbFswGIrRNu+U9ORoQeoWxq57iyNN/AgAlTZ2Vas/aDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075788; c=relaxed/simple;
	bh=fxyElBwLdir6uM5HJrA9UEH+DWI5uUaEmToe5oZDCfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtjD23LNyADq1+tH9VB10KBzp8jHm9VALFR4AanmxqgHirb5JyPZENsCObOxnxU8FBwnam4BjfhzrBLbMky/FrCAPLIXSB5YF2kta5jnciMCI7UPCoDNwHqohcVWohKEAZtaRNNn+FD8+auIxooH88K8oRcZOXniJPoAisSzoTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=M3f7smLK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso57755115e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778075785; x=1778680585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vlDzUIN2szs1pRd6cdxyH1rbZotrFM0SZ+o2vNVbUrQ=;
        b=M3f7smLK0PW6A2TKKGMGGqwlltHbZIINLSAfT9g49C2zvN8fenbHb/NdjiYX0sTnzV
         d16V4gRT1hJ9bCogHeY9YmBvK3+q5ryo63ptndmgCruEJXeasKgFX0Pw0FiLf0fMfAcC
         jM48GL6JeWj5tGKitr9sHXRuERCVv7N9TTV94/xSEfyprc4B0nIXeJNU7d8VfCLRbs7w
         R5yikvmuDBqYDWahBIpNrYz/ZkYf+bvfx9fjl/8Zx0LyrNFf/fZRO5s5vVyJ882jr7+s
         17tOCteBXXZLiqh+TlOfXefR7MAEJbG2Bn+E7T7gI4mH2PzmzIojWipySneABPKodB7A
         6ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778075785; x=1778680585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlDzUIN2szs1pRd6cdxyH1rbZotrFM0SZ+o2vNVbUrQ=;
        b=N4Puf6MKnhzf15nlGie7q92XKWeiERQc7CNwLw2YIq8yllZIlTZA/x82D6FKZg7j5F
         8cmuecwxrr5Ml6ZpQGIu1VCayD7FUhyf83vLZuuQDt6v+E1Aw5cAq55jp1Tx5PlaSuZF
         tDm/QQiM+BBIEXcyGhMf/iFyLq59PGiNLQMUg/mFGESu8ksFAGVoI7L8b45HtAkPn7uL
         sWCTwFu8lq0MFKBXa3FNh7CMuyE4HTaOSxLlg2LkB5eudQzBLv03W+3wLAdQzLLGmGW0
         Mp9Va3hBKfaSSlrsH1bWFmkWXJgfww/F8bHt2jFVBHJB0oVwqMLfMPNbEVjsr0FzPCNI
         q5LQ==
X-Gm-Message-State: AOJu0YzKY21fBfxz7CgijmHsmHKz7VnKMJcyk0PaapaOenFYvI/RUIBf
	s+ptaK48c6j9MJCemGOIt9gy5o9N4bXJosndEWE/cV7TMernMQDuZbZKYVv3YJQYWkU=
X-Gm-Gg: AeBDievPhpj9h6QwILMvvfec5/skwTtrPjkkJqjKQZCSjJOe6aUvk4qNy6MUCea0Eda
	tfrLCPoTEU6QMfmn2rABt/tIIOC/BwB3VRJUVHEjdzOCGWtW/Xx/aqyU0bLSOHVfg7lfUZRUbib
	LGfQyENyywwmAZHRavWifVmyAZW16vfV0bjiy+JnaQfYerWCAy/vXmNtd3gPJPFV3Y+u/JKv37i
	muIPvHAMjlCZkzPXkjwrK1zlanTplEbXkURv9j1yP9QcCsx00s6ggqsOd7VYIZ1ZRd+kW4MPRQI
	LeNmsWkZwds4UB9Qt/Gy8XqJB+/mycwqxOlQzy21d8KAr/P6PJXmnX6CddTkaxia1RdSKMBNnUI
	6T6OGJOoUFXX5yONmAaohjtm7BqcdXKNt5b0s4hYhnMa+YUWHlDogDEWkYFM166kmb+BQCiYvHs
	RT2AafgVU=
X-Received: by 2002:a05:600c:26c8:b0:489:1f04:96c3 with SMTP id 5b1f17b1804b1-48e51e0c80dmr38351235e9.2.1778075784911;
        Wed, 06 May 2026 06:56:24 -0700 (PDT)
Received: from ziepe.ca ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a50d0sm83132495e9.5.2026.05.06.06.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 06:56:24 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1wKcjf-0001pw-GT;
	Wed, 06 May 2026 10:56:23 -0300
Date: Wed, 6 May 2026 10:56:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com,
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com,
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com,
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com,
	ynachum@amazon.com, huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v3 17/17] RDMA/uverbs: Track attr consumption
 and warn on unused attrs
Message-ID: <aftIh+qQ0bl++qxM@ziepe.ca>
References: <20260504135731.2345383-1-jiri@resnulli.us>
 <20260504135731.2345383-18-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504135731.2345383-18-jiri@resnulli.us>
X-Rspamd-Queue-Id: DFE834DB6CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-20083-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On Mon, May 04, 2026 at 03:57:31PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Catch userspace passing attributes that nothing in the kernel
> reads which would be a sign that the driver doesn't support
> a feature, an attr was forgotten in a refactor, or userspace is buggy.
> UHW and PTR_OUT attrs are exempt; destroy attrs are marked consumed by
> the framework. Gate on CONFIG_DEBUG_KERNEL to avoid overhead on
> production kernels.

This is maybe interesting debugging for a version matched rdma-core

But the idea the kernel ignores an attribute is part of the protocol,
if the attribute is marked mandatory by userspace then the kernel will
fail the system call.

I don't remember how often this ends up being used, and I think it is
a bit rare, but it is there.

Jason

