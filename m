Return-Path: <linux-rdma+bounces-20758-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CERnCxu7BmpAnQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20758-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 08:20:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71782549ED2
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 08:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 779DF30D0415
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 06:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F39837BE86;
	Fri, 15 May 2026 06:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="HlZQ24CP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95123379EE5
	for <linux-rdma@vger.kernel.org>; Fri, 15 May 2026 06:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825607; cv=none; b=nCHNUSXedPHLhFGg/nM/AU+RMaCfI9z6tY1mrXsSRoYw/fj8IsnkDZPn6icFPyIEGD3TN/eIOvbVr/3dc5F31Jr+KUvSihr++DsdO7T4qwkdvFjyW3MiWy1zx6WRxBXgXY+Ms+91jvKc/XimqBo8ad6H1k0w5jQIU2NJ3BzAbLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825607; c=relaxed/simple;
	bh=vnv5tAP+upBvQIbaClY5ixcrCAr09QFRKIkinfG6vHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h52WS/O03qJ0VKLxK4+Rmuv1K+6Ok9U4ml2PzSfeJgT2W7RT4f1amZn/7zfNZS3qh8IPY3pLmbcEvjS8nljG2xKtEFfeXoyG24Hfgr5pUK3NzWhHcFsKWp3o/HvdMevC3UZjB3QNObUevKONN5lH3vJI70KM5MA1aUakQTSdd2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=HlZQ24CP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso59840335e9.1
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 23:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778825602; x=1779430402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vs4WuSFUBqhtdy86teQYTI1BCjDt1x9ZMt+eZUjyyIM=;
        b=HlZQ24CP3JdVZAZv2OB/xChwiG2iafoJGfLVqIc6cPE1MGIlCl6Ky4bRv8l8miRAV/
         8/D/2r4cdz9gbOEKupNkrtnLRA87OfIVu2ihHqf2Npq9mPxxtqfUXLsqmvrmCHlsk2ZM
         JScoCHIOqB0CAoENl0t4Rw9QnaWZvVnibxYGF/heyLj90y9k3uQq9erbVxH4hXC+xNNP
         ZF5XilDwmEZxGidV4OEcsFQQbLkrIzffsdpRQef7eGOSk56Awex2FsS8q/oF3PYZpuTs
         eZzByfO/0ug3Osf0RADGC2ii/9uv4aUP33Rlg+LRqGJQOOHeoatBhaN/mF3JTsJHRBFn
         DM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778825602; x=1779430402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vs4WuSFUBqhtdy86teQYTI1BCjDt1x9ZMt+eZUjyyIM=;
        b=ogFNYXw33Md2ug+ojwu2ZCC5p8QVmzeosKn2ZcOpjPVbBYXv7DUCEU6Ww143FdfNM1
         xwgVEGdWkChVwsPb1WBjymPVxYzGg1RBaOCXA4alcNF0jAF8/bko517ogAxPIu9vxbwA
         AoyBTtXK0b8Ybf0cvYQZguKNJSh6WqsJSpAEbOVY+kKtqFsrMe8gBwoO+e8WcSzHEq+l
         FafqmDTJ7TquFMLK49a10lCMb7vAX+kk92wf93fAjVbsAiBAmgpA3yR8ojL9Uec3yUy1
         zXYxUBWW5ieEu2vOlqd/n9IJFAD5zwROb14YuocWulpICScf5susNJ2jQeK9EthNXEYG
         tP4w==
X-Gm-Message-State: AOJu0YwJtBdiwEclccOqX7KQQnmdISScesc5Ublud5OheDNrwF/2xc2q
	ZNnATgiBIhw9FgMgy0TDbjT4TK6OY+ZaObIa6R2iaqXNiJkk78K0bKkIoT7KP/YjOzQ=
X-Gm-Gg: Acq92OGDCJ8043khM8RwmD0aRYMN7Y9O5U9ws2ZohhSIWPSwC85by4azIpYZk4HTUaG
	r/hgoBgGsEJ95B2cwBFzsYozo+gLQAdaGWIyhizldwUo0PvXFyRyEXRRHyvl67DO+LuLg597pky
	/0IYxCXqjMGC/8LJYbniBXzxBF8MvdJSD/2KJuX1jPTbpjhPOEm5mV8FCH/TVhJjQwFtUiIH3rY
	3sW+PM4EfsDPg+9ZUUq3jPgZI4cMlaOtO2Z8rmpidVg5s8CJvCpxB0YGWMo1jSCe9IAl5cSdK83
	sgAJJ3Xzbr3GFJRjzLnVttVkzm8XwdcqDZ8450UtDRW3OX+skgM9/uNCiqnG2n9Z0Cn5fh2Wvu+
	cJTQrj+JjzhBd51N2MeKnZPLF7TxGmFAFckDW5swsZEOFYVtgDQ1HLNPdJDlQTFvQVs4PNnTXKm
	S0t2+I38LZwS6+oNmib4W8SiuJCc0teqc=
X-Received: by 2002:a05:600c:858d:b0:48f:e230:80a3 with SMTP id 5b1f17b1804b1-48fe6514c31mr25237235e9.33.1778825601249;
        Thu, 14 May 2026 23:13:21 -0700 (PDT)
Received: from FV6GYCPJ69 ([208.127.45.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fea5297f7sm10399595e9.0.2026.05.14.23.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 23:13:20 -0700 (PDT)
Date: Fri, 15 May 2026 08:13:17 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, edwards@nvidia.com, 
	kees@kernel.org, parav@nvidia.com, mbloch@nvidia.com, yishaih@nvidia.com, 
	lirongqing@baidu.com, huangjunxian6@hisilicon.com, liuy22@mails.tsinghua.edu.cn, 
	jmoroni@google.com
Subject: Re: [PATCH rdma-next v2 2/2] RDMA/umem: block plain userspace memory
 registration under CoCo bounce
Message-ID: <aga5CzHhdQUW2euI@FV6GYCPJ69>
References: <20260506111447.2697789-1-jiri@resnulli.us>
 <20260506111447.2697789-3-jiri@resnulli.us>
 <20260512130515.GV15586@unreal>
 <agMzXaCIhX4m7ldo@FV6GYCPJ69>
 <20260514162506.GR15586@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514162506.GR15586@unreal>
X-Rspamd-Queue-Id: 71782549ED2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20758-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Thu, May 14, 2026 at 06:25:06PM +0200, leon@kernel.org wrote:
>On Tue, May 12, 2026 at 04:04:13PM +0200, Jiri Pirko wrote:
>> Tue, May 12, 2026 at 03:05:15PM CEST, leon@kernel.org wrote:
>> >On Wed, May 06, 2026 at 01:14:47PM +0200, Jiri Pirko wrote:
>> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> 
>> >> When a device requires DMA bounce buffering inside a Confidential
>> >> Computing guest, __ib_umem_get_va() cannot work. The DMA mapping layer
>> >> redirects all mappings through swiotlb bounce buffers, so the device
>> >> receives DMA addresses pointing to bounce buffer memory rather than
>> >> the user's pages. Since RDMA devices access registered memory directly
>> >> without CPU involvement, there is no opportunity for swiotlb to
>> >> synchronize between the bounce buffer and the original pages.
>> >> 
>> >> The registration would already fail later on, since the umem mapping
>> >> is requested with DMA_ATTR_REQUIRE_COHERENT and gets rejected under
>> >> is_swiotlb_force_bounce() with -EIO. Fail early with -EOPNOTSUPP
>> >> instead, so the user gets a specific error code to react to.
>> >
>> >DMA_ATTR_REQUIRE_COHERENT was our answer to "layering violation claim".
>> 
>> I'm not sure I follow. What's the issue you see?
>
>SWIOTLB is the layer below DMA API, RDMA is the layer above DMA API.
>You shouldn't call to SWIOTLB functions in RDMA code.

This patch doesn't do that. The patch description only describes the
current situation and how the patch changes the behaviour.

[..]

