Return-Path: <linux-rdma+bounces-19679-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJlYLDfl8GmiawEAu9opvQ
	(envelope-from <linux-rdma+bounces-19679-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 18:49:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B4348952F
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 18:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29229309F73F
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 16:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22957326945;
	Tue, 28 Apr 2026 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6WlPMDQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A093264F4
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393353; cv=pass; b=KVGAiYy8+lTfMTD7rHS+49UwCdbQggymEzqADDYTrwewnT37SF9F28yqL9YsAEBnEGQKbhrbzMzqCLhnxpnkjeOLf0tYFnZhmH3E7h6MQLk/eqApnUozMP0AIpyWClIPvT/YVUh6TCT9t/bvlwV9Jlt67lJngzF4L7NFWKD4t5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393353; c=relaxed/simple;
	bh=6RQQwYcPELS1NAz7zt+fqwKi61/aTOp4k08nEMZJn34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koOOAcjs/kirkA+5f6lORsri5SZYORlDJ62NDCjbZwqEuATkC/LbFoxsx+Tmk96djajAyEZIRh54YR0PskKjAj1XtM/4O8PSfeyo6szKaLr9uT7sLyW4HslRe2PlmsQeBHwhlIpwqENXyGZFqjDuaM6hSNoatk1lGq5y922D1CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6WlPMDQ; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65890a6ca20so2788772d50.0
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 09:22:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777393352; cv=none;
        d=google.com; s=arc-20240605;
        b=YpuqINmdNhwOM3SNYJy+SNGTNpAXtPy+WFQglF01OXGlmTTukFCqT2ifeS4cLW2KHM
         FmNPpCdmHCrlBoo/kFDGfXvkMAA7X2egQHoooFJy3UB78DmlaRipriSMTPdI2fb+243s
         qa+VSUERtAp7H6vvG1M7JXP9r5tig1ti1gMCzueVniS9doaV73o1mxrj0Sd+bhMyFO03
         fpw872dTx9N7eDAFUohj4j9fNViRLcYxAk59WmVDBMq5JAak1fPBAkZfoiOxkg8dgcI4
         KfRLklZ2e1jHSDFFZFwkDxxREpWqru21pO94iORXh+u6CMP9PhxrukUO4a94seMxz1hu
         t8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6RQQwYcPELS1NAz7zt+fqwKi61/aTOp4k08nEMZJn34=;
        fh=tBMihR6gJUeSJXX2APTzUulOvKw6d0DMFDp5fr350aM=;
        b=N5Xif4rnKiWBJG4XBFsgUvU7swuIR9u6n2++wu2x7iXjX4G6/NEohdEjW8DxlnSFnp
         6W+aUygTL2LY8rUndi7KvJ75+tnDHFMqv0wDWsdBitp+YUSs0/hVLE0w6E9lUOxj9Oj3
         5M9HViUWUDUKGOzab8TLzKxqtaLX0JEYn5DKyqePcNzWWIx4i874jtxM/aBUNM0x9QRY
         VDVCxTPITdltcEoOhAEapdx3obEPnoNjVJ1fXx+7wsfTVS1KWOSvjtWXJNP+vKToWRRh
         h/EdjuACIl2eaOnlc6W6V2XtI7fx8QPhxCJElzvDj6XyjJ3L8bdsutB6ZFtGcHfKkcTs
         vFEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777393352; x=1777998152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6RQQwYcPELS1NAz7zt+fqwKi61/aTOp4k08nEMZJn34=;
        b=U6WlPMDQwO6xEx5N+GIgp7SqpDyNh/1uqIc2sSFuJSLuG7t4W9P3urNdBY2PzGfdIO
         68OdqpJ9DGqVpKUx/owDXRP6AZyfvjXj+Uj79j2VigN9OOt/wGCIZ364rjHkfWQ1Rx9y
         MkFx9ERRooO26nq/0FHfNgDIYUT3djhgMOdJ3sgCTy3Xe9rYuJ6A3pi2UT/Fjpr11UHf
         Mi6NfrTT9xponI8ZMSCyekRuc1FHhreZi12dgRpbAglR7tK22OJ9FkqDbuMOwmfDAzkY
         /4/Bi/MIlUc/ziXBo+J/VYrNGHIZjeysSocFm3RJluPKrolgfYmkWm43ZtL3R1RYSenY
         Ejxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777393352; x=1777998152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RQQwYcPELS1NAz7zt+fqwKi61/aTOp4k08nEMZJn34=;
        b=Q3+c2V0GHICkHXN3/4xHKZsxD4XMON81uDYKh11daKnvHdZ+fWINFltWWZ7lb+Foeu
         9Zdkqf9QVVvB3ylvA93C/0QatyIv1vk9EwhmrLBloE7zjOujUYNzp6y71O6JKrd9QP7n
         vaQ5RIrrnbpndJu5zMOzdbIPGU2pYkKObLTPbStTf6itRm3VxgHdi91bsaqrrTZ3rlQk
         2G5LL0/VC9pSZe0LGh+SC6B9O75cu7Y+KupEK/BokfhgDxH+XfvZL+tsSJqhA1TP9DZZ
         WGWReqTTvVJy+vIYTIjRKv6SSgAMnkstTRLjxp2QifQU7bhZLQlkA8Qblv1/Ka9/ffzi
         xSMA==
X-Forwarded-Encrypted: i=1; AFNElJ/E8i565A4nEVGtwdF40BjyorDDW1yD8cQ86lXK3VfDNv51lxPtIhydCSuHta35AJuvft/iIVXzwk2P@vger.kernel.org
X-Gm-Message-State: AOJu0YwWHNRtPV8shfQcbCoXcag0ep3Lmg8vQb9t8ZSWQ7WOpDzwvDRH
	MbYXPk7WhSA6tORLJXbBcdF85jo734MF+RMKug860Q+9TFTVz0UIuCEF5dlyOsbsZNbFhZ4M4sX
	t3AQ4iWXbeCQ7EwBMFSzFSa6H8hk2On8=
X-Gm-Gg: AeBDieu4yGqzRyaicjVfvYeQJbAjyEL64DsyhLh4b3wyIJx6Zsvp/kp9bspDVuDSZN5
	Fp5EWd+bPj79Wsd+faFam0E7ze/1aEq1GeWtlX0cnmBdmCVS4K2C7glZsXb+W5BPhnB9NVX04VY
	+8iRLJ8G578qNH7oJDxD1M4vw+BF0ATCrgqkUpKH0ix5FUmK4s11dib0mReYEl+PF1XPIoP/KtX
	ulIxtw0wI9++kr4lTlhAYueFlOCyycU3V+oX6RnXwyLr6oOYVQhxjUZ5FGGCepWdpddIInQmhrO
	lF114bmHhPMXNeQm4Eyi
X-Received: by 2002:a05:690e:d58:b0:657:4633:b67e with SMTP id
 956f58d0204a3-65bfb71052bmr324700d50.46.1777393351810; Tue, 28 Apr 2026
 09:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428154716.375069-1-lgs201920130244@gmail.com> <20260428160619.GJ849557@ziepe.ca>
In-Reply-To: <20260428160619.GJ849557@ziepe.ca>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 29 Apr 2026 00:22:24 +0800
X-Gm-Features: AVHnY4IRwmpnVMv_0gH3lQ-4VAT_2-IrNwFWgWQ8swPc_vkx92CB_0QETmTNdcA
Message-ID: <CANUHTR8TKCN-Bq0b1C_7gmK8hj133EJ5BLOrsD0SZhiCtUUa1w@mail.gmail.com>
Subject: Re: [PATCH v3] IB/mlx4: Fix refcount leak in add_port() error path
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yishai Hadas <yishaih@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Jack Morgenstein <jackm@dev.mellanox.co.il>, Roland Dreier <roland@purestorage.com>, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 29B4348952F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19679-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:email]

Hi Jason,

Thanks for reviewing.

On Wed, 29 Apr 2026 at 00:06, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> Do not put double returns in goto-unwinds..
>
> This should be fixed to open code the kobject_init() immediately after
> the memory allocation so we never switch between kfree and put, and fix
> all the release functions to tolerate half initialized objects.
>
> Then you can remove the mess of kfrees which are all duplicated in the
> release function.
>
> Jason

I will respin this so that all failures after kobject_init_and_add()
use a single kobject_put() based unwind path. The duplicated kfree()
handling in add_port() will be removed, and mlx4_port_release() will
tolerate partially initialized mlx4_port objects.

