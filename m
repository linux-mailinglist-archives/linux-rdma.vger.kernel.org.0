Return-Path: <linux-rdma+bounces-21579-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPbAF8h5HWrEbAkAu9opvQ
	(envelope-from <linux-rdma+bounces-21579-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 14:23:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB19D61F34E
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 14:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09C41305F0B6
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 12:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F633769EE;
	Mon,  1 Jun 2026 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3Ae9hAh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A946733F5A4
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jun 2026 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316062; cv=none; b=fuxCAmQ6+hqFz0juCIfoH17An7T2zL39O++j8ODxXoYBkMYr752UGfpjiHn0BfoNa5Os0GDd123A3m16rvL2BBfuR0J7mCOch+F+R+c8Xbv24MRo9j7FIwKJQiA55KKU1bMWHqxi15BSPJlqKjRYhCGPQcMh8Q6l1NowzXy6xis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316062; c=relaxed/simple;
	bh=ckB/0OrsFAl0uXjbvDISsyp9MLSMakEeAmw4BaJPm88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLOEBDgPVeYCVgxo0a/yybgY4MBfwBetO0z2IyxFDLsdN+DncA6dO1Vc+bDq0yOvoCCNKgB9ewPg/+uNWRIumCDEnZc3mRqJ3n+22VaeF+DzhJeoLDXLI8/HkbnDmBKRtJIJfJbg5ejayMc8fjEWA9STgXUid6+13mleZicCIL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3Ae9hAh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so103334465e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 01 Jun 2026 05:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780316060; x=1780920860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LspmPQV/lHUgHA9RJ7Trmk5tXDicO37E7l+XwVPkr/U=;
        b=k3Ae9hAhCViAGBd5kkfRnCmIEDj9nPEiC2h1k27d6xLf004gk0YZhyqL1jRyZmHOTy
         3cQvR9UIgL4aWarHwzEXeWXrfZ8tDlHLkjfGeQgsZu1TW8aWJSbppEbXmlmpv5wXpPoj
         Km2mZe72gDI0c+idsg+Kjwx6R60JfZBlgEqTJcmwuG4+/mVC1BArdt864f9hVoriEfx9
         Z6xEuq+uj9ID52x/QPtYV4+NRsWJBLI4m4oI7rL3yyLxsbVgJfRHr+4pxVGMPe5m+4mx
         PfwQpTDH829FiunORZkzoqZt42542qhsB3V03Vfj0tHotgS+Vb89cDSs1lMRIJpvMAUl
         YVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780316060; x=1780920860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LspmPQV/lHUgHA9RJ7Trmk5tXDicO37E7l+XwVPkr/U=;
        b=boC+fyeGSkPWVd/kT/oomXA42chxssAwzG6hWSr529X/WQwl5CIdwic/QZliNaUM9c
         8SRH6erzacPasaiLouhDWdQEnMZMfl+GdZpRMS1OaVjdVpCfDuJW98pgEUqfDAYYgFWv
         bFr4zG4LusQgL/17ucRxGkEUcuKsaA7nDy4FBbkYAJKD6jslemJY6GYTvbVHIPsqXUlx
         +u7Vck6xyDqOwPbWrwxHud1dk4HKl24W/1VTkT0siB5L7LYgPLf+bUe7PB5LdsxfnZQU
         qNTPrjGQ/y08dRRYg6eDI1oSYRV6eCIX6e2O640/nxv/WvW8gZEhDt7LGF8Ov+JLClA5
         JGkA==
X-Forwarded-Encrypted: i=1; AFNElJ9QNxaCkx7r6O6ah/W5WRsh2QIqShvJ5jjsHbZH0Z/icKidIq0HMqEV7QWllL/2TK++TodzuzosFfE1@vger.kernel.org
X-Gm-Message-State: AOJu0YzCulrnKwED6yOlsn4cU7xrm584VMoZAkh40wiwOjNa0GwwqL0D
	7PUwlW/R99pxMIJ1QRn+tEfmmg3J14dnqNx9TrdRXsehYO3Mpts1jFSW
X-Gm-Gg: Acq92OGhoUv14/ri7u8xc9+gMp9jU6Jb+hjoluY2Y8E27yRy47CVsL+SkO2EMm60G00
	UB/u5YTDc4HKVaibWUXN79SG68CH0n54Y00pI5deOeJ7Ao/0Ixh4UBcZUvhIxZbhp1YEgkchj9N
	dS/FX2RLL/eeaR1oL2+TjVkrHa9v4ezugsNkonZ9MI+XZCjvJL5skYx/QDeSEAah8UfwXIvyS7m
	4bBp+9yYwfFxUmwawsLYy7A05oHUQjd4MPqx6dITvwHvsS8FcRMXbZbu7jw9k57eAeN0N9CAbkc
	AMq83DEl0IzasGWHRwMQBaNPQ2QmOfyOxM5wU3pAc6isl8HBE1qL1X/QjO7dYog24SORtD4JuMJ
	n+/3oSNQ9P7eSFeSfy5VwYnKrqlHF4MReC0PvN1czGIMftR8zWeHiuLI0+b/GTvcbUXE9fXS4pg
	lCF5Q2vI5zAuZlli2ZSOeMntUFOW3FggYpBnRDbwyz6hMIpuMR/ozxTkI4Ow/padinFYnaGlQ=
X-Received: by 2002:a05:600c:3b09:b0:490:a7ab:bbee with SMTP id 5b1f17b1804b1-490a7abbdcfmr141119495e9.15.1780316059659;
        Mon, 01 Jun 2026 05:14:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c127befsm77948305e9.31.2026.06.01.05.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:14:19 -0700 (PDT)
Date: Mon, 1 Jun 2026 13:14:16 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Yao Sang <sangyao@kylinos.cn>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, "Gustavo
 A . R . Silva" <gustavoars@kernel.org>, netdev <netdev@vger.kernel.org>,
 linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net] net/mlx4: avoid GCC 10 __bad_copy_from() false
 positive
Message-ID: <20260601131416.318cfbd6@pumpkin>
In-Reply-To: <7a018189-021c-44d1-a46d-a75016818a0b@nvidia.com>
References: <20260520102130.423044-1-sangyao@kylinos.cn>
	<1780035629778309.247.seg@mailgw.kylinos.cn>
	<20260529064521.4i5pyilf32au4cnf@sang-pc>
	<7a018189-021c-44d1-a46d-a75016818a0b@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21579-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: EB19D61F34E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 1 Jun 2026 14:00:15 +0300
Tariq Toukan <tariqt@nvidia.com> wrote:

> On 29/05/2026 9:45, Yao Sang wrote:
> > On Mon, May 25, 2026 at 01:47:59PM +0300, Tariq Toukan wrote:  
...
> > Regarding David's suggestion of using a memset_user() loop, I've also
> > looked into it, but couldn't locate either of those APIs in the kernel
> > after check.Please let me know if you have any additional information
> > or suggestions.
> > 
> > If this approach looks good to you, I'll send out the full v2 patch shortly.
> >   
> 
> That would work.
> Thanks.
> 

I wasn't at all sure there was one, but a loop using a 'reasonable size'
buffer will be reasonably simple and fast.
I suspect an on-stack 256 byte buffer would be good enough.
If it were a really hot path there are other options, but this looked
like initialisation so performance isn't that critical.
(But you don't want a loop of put_user() because that will be slow.)

-- David


