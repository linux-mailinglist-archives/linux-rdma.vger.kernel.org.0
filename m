Return-Path: <linux-rdma+bounces-22692-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id emKeHO2ERmoFXwsAu9opvQ
	(envelope-from <linux-rdma+bounces-22692-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 17:34:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAAE6F977C
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 17:34:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=jovmKwB5;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22692-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22692-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D2C8302F586
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 15:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEAE353A99;
	Thu,  2 Jul 2026 15:27:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2DF30DD30
	for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2026 15:27:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006023; cv=none; b=hqd9ZjgozrSg43JaXEh0SxMJWPCDSF4ls6KuxLi97DEuKK+37NkUk3v1Iew51LEj3qRmKgb78nWzBMBDD9oVnuE7gobOdqsSjpb1fkjDPZM9+2OpbLkrD4is+PXHGEFjdAUaxxKfIZj2PGjesBaXkgEqFEpMDpWZ9CmxhgZhbKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006023; c=relaxed/simple;
	bh=3kyBhjP5JMk8j8K+1xEAajnWvzsKxVJbKoa2akymi9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOg+1t41T7veGYTOAAz1LnL5yV6aMwqX5e3ZBKUn6Jx1OLJcrNHA/rbY0QzYXOFZuMnsWjwWxI2Jof+FudqR6KdEIt6T4jmZwph0ZItmCpvuwPfHkbDmhanhSvMvDKzP3nAWyda8OkFzYe6aqoFRPuLa+MMgOoADEZ1px+dEcQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jovmKwB5; arc=none smtp.client-ip=209.85.222.171
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e5c9211d2so143319485a.1
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jul 2026 08:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783006021; x=1783610821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3kyBhjP5JMk8j8K+1xEAajnWvzsKxVJbKoa2akymi9Q=;
        b=jovmKwB57vQAycgMzlYPF86WLcBY9/kfHcdv9We2SO0Y/7HIwUWJbJsr9RqKm/aphx
         EyVJKURjTRVEi0kpSWJg2JB+UJlxvVlpLyN9N/JZ3pkxGrsvU8eKsOexi8nenn7t0qzN
         PntAgYVQ9jdF+2SOCdYNIaMotSVFfuE3auOgKievR+p5w5E2U0EEzzVUjs++9V9VYgSK
         Vz0bFCSK7wimDPAdr3P6ttHpwqOLBZU1ATVFzZyhT+LeAvRF3qe9pJZddSxU2D1QNIdp
         8te91guOE4A9C73DjZ1P1KgwAHIOpVMP52PI5RhrdpozGu/k/KmTa55FjaZv3ptrsZJA
         8Vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783006021; x=1783610821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kyBhjP5JMk8j8K+1xEAajnWvzsKxVJbKoa2akymi9Q=;
        b=LR236dnrIh9GFnNCgGN76fpqkGOBFOEgLjJj6Hp6uPllYbJ6IzSn5LUL9kXDd4viMh
         fL5gwiVoHdIqG7NRhHXXKnaYnca5nuqPGxcDxhf2CXQqK6FWMb01gzm5RDt5pHEc3xKk
         LK492UaoVLmaFXOnZS/z9vUD5tUZQ/irdNHoloqXZ2E4knWPS3ap65v/w18/EvBtq5be
         PTkonqw/LN83bM7m8WjIiD8gu+YDE0GC307RklZcxnFxWS5dCUPvfAEf/0ykehWXuBlo
         lqmvT4G2pArxJHWqrmw4YM4Tg+HEsWYI2rcsSePS+hC+KZMU0R3n928qraCrk28kqM2k
         Fnfg==
X-Forwarded-Encrypted: i=1; AFNElJ9EHD+NbECNgOPY372j7n2pJSGRP4Y5T1md9jJ8jrSW1xa673bLlno3JC4c+cepIDGrRMHc0EHFbCan@vger.kernel.org
X-Gm-Message-State: AOJu0YxkXzrfZz38TP1YcJnXPd5h/8LuX+3MgPWW+pzsYm6na525RCEm
	dYyCDNthiG3wUzPnQNbgk/KyLsx8zj6Mj70kpenLDCmriMQpiohr2ebioVLN2NGAdTw=
X-Gm-Gg: AfdE7cmULEACaORukpeR+VaP/2mZcFmVHPOQhz50RWHYHPcUORQwJgN0M1qmIywF8rq
	VoD9Ahu+NIukIvy/p2k3wvnk7kypeMVd7rAmd8iP594HFQ/Fo4+UxlbbMBZsYvWHXTd5LSICM2M
	FjGsMN/rwUrqoSPAse+bE+sJHkjIToT4kUJo3w3GF3ZmBHFxAoAJBwqqyRRo2lQwVwAnazWzEmn
	RHT3aKP9p5qnk2tkaj0Yoax3lvKAFCq8qlDiTWSyDYvpy89oUyHCf0hDeCTlpQArWsF9O47tGdc
	4GfIgbtsC7kO3wTbyQAiUKqSEb4xpB9hJEYSaG7DZNcyfu9XTepZ6/WGbTlIXj6Yv9pw92G17Cn
	L2va4uar42u8IIKpn487Wzk1dsqHFb2aWNSLxexVxKJtEOi/DGvvMy4o4pPG/rqRWdoxEYJK/4U
	m2aRPmi3R1NUItNBAMCWfccMdTj3RfpaflJetBUo87aN99c8yzamzbOxq+6TqO1kQ6vwQ=
X-Received: by 2002:a05:620a:28d3:b0:92b:6805:91be with SMTP id af79cd13be357-92e7853d109mr831898385a.70.1783006019875;
        Thu, 02 Jul 2026 08:26:59 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e7ffdd84esm236010785a.10.2026.07.02.08.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 08:26:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfJJZ-00000005xYE-2TnW;
	Thu, 02 Jul 2026 12:26:57 -0300
Date: Thu, 2 Jul 2026 12:26:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Timofeyev <sashka@ankey.net>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	Parav Pandit <parav@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 0/2] RDMA: fix cross-NIC same-host IPv6
 RDMA-CM connect
Message-ID: <20260702152657.GS7525@ziepe.ca>
References: <1781545579.1-sashka@ankey.net>
 <1781661732.reply1-sashka@ankey.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1781661732.reply1-sashka@ankey.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-22692-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashka@ankey.net,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:parav@nvidia.com,m:edwards@nvidia.com,m:vdumitrescu@nvidia.com,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid,ziepe.ca:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDAAE6F977C

On Wed, Jun 17, 2026 at 02:02:12AM +0000, Alex Timofeyev wrote:

> IFF_LOOPBACK one to still recognize it as local. That commit is in
> v6.18 but not in linux-6.6.y, which is the stable base we (and
> presumably other RoCE-on-6.6 users) are on; might be worth a stable
> backport on its own merits, independent of this series.

Feel free to propose backports to stable if it is valuable to you,
RDMA maintainers are not managing stable at all, so you are welcome to
do so.

Jason

