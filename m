Return-Path: <linux-rdma+bounces-20691-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +POYKqa3BWpZaAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20691-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:53:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CB4541409
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB1443093C34
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 11:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDE13C343C;
	Thu, 14 May 2026 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Eyab5e+l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3413AD51A
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759451; cv=none; b=h2DWq4AUIgsim4M4fYZYSQrvjAaKvtBEbXSSUIj/3uGdmFTOwhZohLJ5exsDl2mIGgz+pAriEWmyfU27HEtbAAPP4uYM6/sJW/d9HDcGXQ1CYq8T85jwsUCx9OYbG02WHih+tCo3LYuXfDPoIoHjXeN6SdJe4fGVtzYud6iocbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759451; c=relaxed/simple;
	bh=aLH5YBATn9eCNSGgtO3MOr4x22/bBQ7ESfJaSuBS89c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLI8IkJhpkloRpdb5svq/a/Y1w0ux/SuC8eiD1fS58UUKeS1ONTW5qjo2zaqWTcl4/yE2kFovCQTctDcHSt+dHKe8EeEnapYpjjPSUH8UfvzKXEZY+DYejoIw4P/FcT1sExLw3lnQMhDolslH0LeRsfxREvo/7tN5DOnhCTwiiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Eyab5e+l; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50e97863425so78100181cf.0
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 04:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778759449; x=1779364249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eDBCsEhXxpxSONCF+uEB0GBHYti2oMl8hGXWjjN3tJ8=;
        b=Eyab5e+lFUjSm4nW7eNvM6JdJ32/ERycNju1lNdhR8GloSudULEoHKEIOfAWwwCyxk
         1hLLj+q0IAW0WwIfH4kR2Cl8+ACdg2zaHD6rF7kkUJ0UAvGUjdlw7SC97bMSX3fPg+bQ
         OOawlstlFz2ig0izecthlVxL2FcB+WazdNVoW8tbv4KkQ2o5m8ZQbsduaB0RVhb/ueFE
         0KiPk6EYrHYS5744qMquHsgLjmapzvLRWV9iCrycWRlAk6x6WjrPc4f5C//OBtmqgOGK
         Y24zVHpX6JwO3SNLCfjdiArqkAzvTi5b6OXi7x5YeNl+YhEPQmOl5IT5B8efllbDhCbN
         zQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778759449; x=1779364249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDBCsEhXxpxSONCF+uEB0GBHYti2oMl8hGXWjjN3tJ8=;
        b=q7tB3KKdq0JsCOlwK7p8rMBaHG8hfCeZUl7MmcGgm08YeROaU6Jg0AIcqbPHlXjYil
         d2wK2mtH7g/9zyIwYObF5TKmq0o5iSSk01HgjNCoJLFkYqw0b5ndn1KvrfFmXOSpMj6o
         33GOfK10lt5IbSLSUdBD891g/0I4pbZI8pYmPRmBSu3Q8XGxH49p+Xs8YkBnz1UwZo34
         ZbZ4Z7A0/w3dhwp6U7nMiArdkpbg6zyOedjcz2o4leNl3feGREdzICITBt6+f9x8JXAa
         +/SvEtzXV1wuN3abPbHIaMhckR/aSvDOBrexI/fKTTXQK30eEOIFdN3YciCZWzI8aAG6
         rwFA==
X-Forwarded-Encrypted: i=1; AFNElJ/6XZc7MQ5cliuTM0RjugIUC7EbV/A9rAXGnT1WePKpXFXGR5vQelKL0+ZsV0hwx+IFGita+PVjNMQ5@vger.kernel.org
X-Gm-Message-State: AOJu0YzacPpvbkeRo8YbRmxurhPDqYAigFfbaN8HZsm/p28LuD1NwK5m
	jutr/o+3Te9g1c7mSH7GgkxMyY1EjNvHyqwyVdt06g+07Ag9uwxUn6Ci5MRJTUxwWP0=
X-Gm-Gg: Acq92OHXSuzBwGTf1nuOYPxpGp8v2WWSidr90ATVCHv5F9E/KEb1oJp/YZ7JODA2uFe
	VooyyhRpc9g0Q54BoqqjT2FAC3+oDXtkqA51+/ARlBCUkINhzIP1Zi6P1jXs4tzm+4feUY/Wd7B
	kxoMKEHahrhUMOFHSf+9WUqaMd5vzBy4i3TTwkF5MgZ57fSY8MXXykwlJGjOMjIpNgjLElyaDgh
	GT5fNc5bdaxRjzvosvNMmcrqIqNeeLM/amz3MLDO7zBQ84pZ6DSM7fJTC5HP5yhSp0ATMxxjahp
	PXE8bJ06Gw09QPy8Xg6exDcOhRd/V+cz1yJDhlpdjJSVsAqVfIQCp/6mALJJXQhIiug3xyrK5K4
	3J9YBbFh7C/f0LOXLUCikV0267vUXH7tfXtN2eofwWyfIXL6JQx5jtdZEWXkdiw3/HUGnz0ClNy
	Y4XcG4Wvl/48pczVFphd2DxKtERsyu5QjN3MAvmIZdm4RuyXj+4E00igiHAiPBxkQBKTVwWTA3D
	jJQ8Q==
X-Received: by 2002:ac8:7fc2:0:b0:50e:5aed:caea with SMTP id d75a77b69052e-5162fe26062mr96232451cf.14.1778759449125;
        Thu, 14 May 2026 04:50:49 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164585fa0asm15519921cf.31.2026.05.14.04.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 04:50:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNUaW-000000057Ee-0Djd;
	Thu, 14 May 2026 08:50:48 -0300
Date: Thu, 14 May 2026 08:50:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Edward Adam Davis <eadavis@qq.com>
Cc: akpm@linux-foundation.org, arjan@linux.intel.com, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, hdanton@sina.com,
	horms@kernel.org, kuba@kernel.org, kuniyu@google.com,
	leon@kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev,
	zyjzyj2000@gmail.com
Subject: Re: [PATCH] RDMA/nldev: add mutual exclusion in nldev_dellink()
Message-ID: <20260514115048.GX7702@ziepe.ca>
References: <20260513234655.GW7702@ziepe.ca>
 <tencent_3CCD70788A6EAC2D356D4C9674E8D2EEEA0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_3CCD70788A6EAC2D356D4C9674E8D2EEEA0A@qq.com>
X-Rspamd-Queue-Id: E0CB4541409
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20691-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FREEMAIL_TO(0.00)[qq.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.intel.com,davemloft.net,kernel.org,google.com,sina.com,vger.kernel.org,redhat.com,syzkaller.appspotmail.com,googlegroups.com,linux.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 03:31:22PM +0800, Edward Adam Davis wrote:
> On Wed, 13 May 2026 20:46:55 -0300, Jason Gunthorpe wrote:
> > On Wed, May 13, 2026 at 02:17:28PM -0400, Leon Romanovsky wrote:
> > >
> > > On Thu, 07 May 2026 20:50:10 +0800, Edward Adam Davis wrote:
> > > > We must serialize calls to nldev_dellink() or risk a crash as syzbot
> > > > reported:
> > > >
> > > > Call Trace:
> > > >  udp_tunnel_sock_release+0x6d/0x80 net/ipv4/udp_tunnel_core.c:197
> > > >  rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inline]
> > > >  rxe_sock_put drivers/infiniband/sw/rxe/rxe_net.c:639 [inline]
> > > >  rxe_net_del+0xfb/0x290 drivers/infiniband/sw/rxe/rxe_net.c:660
> > > >  rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254
> > > >
> > > > [...]
> > >
> > > Applied, thanks!
> > >
> > > [1/1] RDMA/nldev: add mutual exclusion in nldev_dellink()
> > >       https://git.kernel.org/rdma/rdma/c/0b28000b64f40d
> > 
> > This seems like a rxe bug, I would have expected the lock to be inside
> > rxe to protect its racy implementation of rxe_net_del(), which looks
> > like it is possibly also triggered by NETDEV_UNREGISTER...
> No, it was triggered by RDMA_NLDEV_CMD_DELLINK, you can see the "call trace".
> > 
> > ie it should not change nldev_dellink().
> While this could be fixed within RXE, the same issue affects all other
> RXE-like submodules when they subsequently support the "dellink" interface,
> therefore, handling this within nldev_dellink() is relatively more appropriate.

Why would other modules have an issue? The problem is rxe's racey
refcounting scheme for its lazy socket creation. There is nothing
wrong with nldev, and now you've created some nasty BKL in the nldev
code to fix rxe while ignoring its other races.

Jason

