Return-Path: <linux-rdma+bounces-16156-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDiZOJsSemkl2QEAu9opvQ
	(envelope-from <linux-rdma+bounces-16156-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 14:43:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E1DA242C
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 14:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EB24300CE75
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 13:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79CD353EC9;
	Wed, 28 Jan 2026 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2dRmVAod"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CB5350A2B
	for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769607831; cv=none; b=XGGKNckGxZRF4Xoie7dGdlS00lujVuQX9xEyPt9yp3ERE1sz7P5GaSKrdOO6LPhB5vxjxFS7rpKxX81AJ8XM2ydPgVtM5k/43RCAUiYobBYy2WZgg8SBcQ5IAKAiuzftLXYKT8iOp6FpLIE+BQZx+bMKvlmYMcFzPi3IfQ4DxVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769607831; c=relaxed/simple;
	bh=CmD5m+lRl2FaqvqzvO+WzqbaYeMItPNtZ1dwe28xVpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpMWe7OwVM9QS1QcnFiyYFh8Ve5fIUTwjjiwHkQaR4RnGubkzGM04eRJQRmcOewFQHT7wTJwEZoaxx3GF2CynI6xfyOJTkqz0Cfd1DpnWEg049dj6SPEnnqIyD5mDRRWCITOSrHEnciU1/ZMmHUev7kcF1Kr55VcXYmCrPNQlDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=2dRmVAod; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-480706554beso5951725e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 05:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1769607828; x=1770212628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nz99cdeOjvrjZChisvnF8cIKoEPTY9x5v04DZ1VsVJE=;
        b=2dRmVAod+MnR0SSpBfO3U4n8BDVkrsOHVt+SBd7oxobj75RETixmcs3/UuVIQMsNdy
         jZc+Ugqiyb5OC/0664DpsQ/XKbv3BkIe7DuZP5KR3j/pt0FnwCFPUX1M482pfS1rsEXG
         YCg/rriSyf5oaqW7yMQJlsWtH4L+6UkTijy2vF8wY1pl1FHZ7/zfOpyfT9/dEIOP9K41
         eWXvsdXuySJt1krXQ7mkR3pZyUfoJa1lY5ZSB9xbpStrc0UPQL8Y/b+0IiLrdCnaIIvn
         aN59BaB/pDzMoU1U76Uic2yz2EDyfN5sgzfd6/5f6sSvmyRMSF7HAaxp8WedjqUxPUwg
         +Krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769607828; x=1770212628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nz99cdeOjvrjZChisvnF8cIKoEPTY9x5v04DZ1VsVJE=;
        b=kAMzbjJWcNB8T81BbcdR0P8H+bLyY5JZRmKyd7V68w4W+n40bEE2RC6xxXBL+764Bn
         U+9ZbUI21n3Atj5fYz6rNImtr+B67tivBBt4AdplEJuvFXJpyTD0Qq/VnIebb1/d+sxw
         KgmtfiZ4G7rZruHkFaD8DPfBQr9VIxn6s1edmpLzTObF31YB1UKLdFUp4W+Hzi58sqr6
         CUlr1ceoKGh0QAWe0mK4OzLOY9EA24QUGchewUUsdHVML5j2mnRZYJ+HGpadoypOcvsP
         pbgp5vHhD2R3z7w5SRCA6l8MTYpELHhLJ2qqGx7fjrwy4Ptp24LmzxvwmzncA+J0Fgjq
         xwXw==
X-Forwarded-Encrypted: i=1; AJvYcCUCXSqO4vt2xHlR0NmDwLehzAt63dn7XKSKl1x4Ix1UIev2QJRJ9wOo6JwuW2rdFZOGHKe6qtikxBQV@vger.kernel.org
X-Gm-Message-State: AOJu0YxFe80ruWD4ofSxc3slQeE2Ce9aRdwpQftToYVx0gp/QBKYAu51
	NdYJbXXW7q5Myq4dmlvMzLf1PLd5fQGgnW0gc2tBL91AbDIY15qvs7yl3g8revAGn6g=
X-Gm-Gg: AZuq6aIFe5HsOJP3wh/oYGSMvDx0p/L2onNLo3c91Qtve6AkyrYoTe4l5UqEUd3T3+s
	Hl12ovPBmXoF10N/wdmSCY6ArUAL0OwOqT3Lmp2RqYCZhFs9dCdelIEBfTWB0voOnNHWELnVrfb
	LOjqHOFQzoSjjQ9+4DX4jrcpnd4mKh4L+Ikh2VcCImTCbJ/pz8CCXlX0fLlfjdWil5UXxkFTTob
	r6zQes6w7l6JPgPPRfoOEmN5rPEofnph295MtY2opYw+3mV3CWqXWj7qgCjjR7suDn7N8YKH+Vo
	2Y9TOO0goNRg5/LGEYd/kU0gEXSbJmvBH10f1rZyioopqFcOf7Ma567/D50gOAzBv5/d0he03v+
	2Mo40OjTq5sEyxSXXt0fW80V6n46RIQXk6eZGdlES4Tf7J96+ns1tJ+tawwV5tXMyD66eMgn0cd
	1bfN+AnQUZk31s4JNhVYWfC75xbqIQvbbf
X-Received: by 2002:a05:600c:348d:b0:480:1a3a:5ce6 with SMTP id 5b1f17b1804b1-48069c1a8aemr61842905e9.14.1769607827901;
        Wed, 28 Jan 2026 05:43:47 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806e2a0581sm65095e9.5.2026.01.28.05.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 05:43:47 -0800 (PST)
Date: Wed, 28 Jan 2026 14:43:45 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: "Yanjun.Zhu" <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-rdma@vger.kernel.org, leon@kernel.org, msanalla@nvidia.com, maorg@nvidia.com, 
	parav@nvidia.com, mbloch@nvidia.com, markzhang@nvidia.com, 
	marco.crivellari@suse.com, roman.gushchin@linux.dev
Subject: Re: [PATCH] RDMA/core: Fix stale RoCE GIDs during netdev events at
 registration
Message-ID: <frj7x3bda5txsccw2pj4aydjkvjvfpegscruytyln557or4uvp@benl4wdd6fbe>
References: <20260127093839.126291-1-jiri@resnulli.us>
 <21d63279-79a2-47aa-b305-30a55b8f40f4@I-love.SAKURA.ne.jp>
 <20260127160000.GG1641016@ziepe.ca>
 <05b40f3c-0d21-411a-b61a-156246482327@linux.dev>
 <9975b59a-58e2-4766-9e4e-c927a1d7a3d0@I-love.SAKURA.ne.jp>
 <f3402d0f-40a1-4792-a8e2-be65c71a176b@linux.dev>
 <af4866d0-2e50-477c-b823-1c4a8a86f7e5@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af4866d0-2e50-477c-b823-1c4a8a86f7e5@I-love.SAKURA.ne.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16156-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[i-love.sakura.ne.jp:email,resnulli-us.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10E1DA242C
X-Rspamd-Action: no action

Wed, Jan 28, 2026 at 05:52:42AM +0100, penguin-kernel@I-love.SAKURA.ne.jp wrote:

[...]

>
>Two things I worry about Jiri's patch are that
>
>  refcount_set(&device->refcount, 2) in enable_device_and_get() becomes unsafe if 
>  DEVICE_GID_UPDATES notifications can let someone to call ib_device_put()

Perhaps I'm missing something, but where exactly in the notifications
related to this patch is someone calling ib_device_put()?


>
>and
>
>  I'm not convinced that it is safe/meaningful to keep DEVICE_GID_UPDATES notifications valid
>  between wait_for_completion(&device->unreg_completion) in disable_device() and the beginning
>  of ib_cache_cleanup_one() because I don't know whether DEVICE_GID_UPDATES notifications can
>  make sense after device->refcount became 0

Could you please clearly elaborate what seems to be a problem? I don't
see why notifications related to this patchset can't update gids for
devices with refcount 0. Do you?

