Return-Path: <linux-rdma+bounces-22267-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fJNJJeaRMGpEUgUAu9opvQ
	(envelope-from <linux-rdma+bounces-22267-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 01:59:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8474568ABFB
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 01:59:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=DXUzvQ4f;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22267-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22267-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6E8630074E5
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 23:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A78436DA03;
	Mon, 15 Jun 2026 23:59:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C101936A373
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 23:59:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567969; cv=none; b=S0iuJl4kMq/Qsv9GLQ1Y7f/bsvTtWvhiD6rb28hxv5lZAFALBTE4dVX7Y4wj+74WhK2sZNA0jw7xCmICLO4y0oo31X/KU98uWStNpaA5jdEUalliwB0eH4yXyX8XRM64Wd5t/Pmn8AQE8AvkwiWX4n/2MVdMV0s0qZQ0xXc8uOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567969; c=relaxed/simple;
	bh=DEUecJcVGBVnyWLepKxqYJuXwNBpzXUDoxNFhIeQ7Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nU0RVXm3/LJ0M66PHud9lE44L8A5/63qjopTBbpwTDy7ylKOercpBcPDG0PNgCqOZIUwJIf9hD7yJT1oT2o9csyA5cKzUr8XBjohPPzWFli0CtPaTf0vXv8UZwr4qfTnzITGch3szOaASQ3lt89MdQO4NZvC5XTrFbNAIqnzcOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DXUzvQ4f; arc=none smtp.client-ip=209.85.222.175
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9157b94a07aso429282985a.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 16:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781567967; x=1782172767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KK7kSan6P67b0eQIRx5Plvs60Ktl/WyLLAhzMoMEMUY=;
        b=DXUzvQ4ftI0AGGN/N3RzKtJMEMyUWOHpNTwumX5wE/Kg6UDfz82sJn0k13SbuX0Iel
         9C9Q8/3wu04IWegDihC/MsSUa6XBJNrcIMVvsFkXobXYEo7vIPt5i9HqMzt6sNCYd6Bx
         9rBWoNmK5ozzlbyXysuKuehcmXopDBsApy2Ym71EwO8UhNBqdDesLAJCxSl4mQOaDJbX
         Pw9FdB8NA+J3a/ImDKPQGHqPF9QuXhnQtoEal75NSQOt2cji57apcg9bshhuZ22XnsnJ
         jul5KHTVwafnSCmPkNvS4oabpxRI00y9a5ozD+kWX8osuaSeSkQmK7w/F1k7rV35OYO/
         gvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781567967; x=1782172767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KK7kSan6P67b0eQIRx5Plvs60Ktl/WyLLAhzMoMEMUY=;
        b=OgxfiRgtWomTdFjw9tOQ5qHkljaQP/VzDD3GRTWf2eaxveD9PCTJgA4H3EHQkHlVAD
         iRK4fAr0wbYiXshrD+fQfe4o2/ofAgRSYn40hlKsYJQyHytwNzRGCfzJXcJWIyVURomm
         MSy9P5ArtRHeThHjrby0zdhgKqHhxhp0y2iKwfDH7P1RqkpIzIqqz50lihuiLOF0CU/H
         JCUKY8gz5OXzo5dOyZHeqxRIe4SP8l3Wa+W7QMdkXR1slsUGEy1ND38Ntkza60jTP7GQ
         YXX9r2KtZcd4CtXJTZ+4QObNIo0uR43cJFqVsvi/xs9NbfV17QpOlStwy688oQRhUfS2
         zP/A==
X-Forwarded-Encrypted: i=1; AFNElJ/SVhu2U7di2p6s7S/BT07tGHqldSut78LMb0g87zrBJCYsamLB3nmqFlOOKPVbxg7VgYqIBPJdzSEf@vger.kernel.org
X-Gm-Message-State: AOJu0YwlKfLpykG5PkAFwbepjgCCMy5IeI2V7ADm22i1GVYCr5DSduKg
	Qc8AMnGMwEhQKvUCzmet4HIURoFxv72PX91Fekaze/Ul4TdR8SEQpTTjfMdpxOj0Zgg=
X-Gm-Gg: Acq92OHn+noUfczGq50R352QpahQkCOp6+8zIzCL9YhZm8u/sJ0EVV9bLwxoo0T8VmS
	q9CZGnVUiMI+aArNzNcd1WuY+d3AJEhGpNVaNjZZspHW/d4uJkcXR3ErzCEYUMW9+huq6lls1Em
	TOGeD03nrQDBsQLzWC0pbCDSArShKOv+cD9QDSpzFhTkWgWJwBDmPbyqvf7sV5P961uQE3swUzx
	GpIhcM1dY/LDkiaoIhXgMbEtjxnZ0sqAUqdJ5nSHAtC0f0G1uS2EVR0BlfjgQ8uW3ZsgNJwgnkx
	4aYI9Qt+n9zCZAY/msy4Ij0QLgUuw9QN1nYALK+3K5sJrdqKmI6v7woPMSN0K049mTcJddoPQFf
	Caw8CWaRycIiAJk+W6wXDLcuahQKs+JjhEiFFoZ/ILxyD/RP5yjEF032leJlkkExyAgVwytsElg
	qrWjxdAFOg4DUwc7hTUqVxTZZqjN5Wv1bYlsIRF5dFzlsa50XvYTaMN4pjyxUkGmukR1X9uhjdu
	t+zoA==
X-Received: by 2002:a05:620a:17ac:b0:915:a427:f2a3 with SMTP id af79cd13be357-9161baf567bmr2451925385a.6.1781567966528;
        Mon, 15 Jun 2026 16:59:26 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f210b7sm1278184285a.18.2026.06.15.16.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 16:59:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wZHDA-0000000F0L7-2sIA;
	Mon, 15 Jun 2026 20:59:24 -0300
Date: Mon, 15 Jun 2026 20:59:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Timofeyev <sashka@ankey.net>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	Parav Pandit <parav@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 0/2] RDMA: fix cross-NIC same-host IPv6
 RDMA-CM connect
Message-ID: <20260615235924.GT1066031@ziepe.ca>
References: <1781545579.1-sashka@ankey.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1781545579.1-sashka@ankey.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-22267-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashka@ankey.net,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:parav@nvidia.com,m:edwards@nvidia.com,m:vdumitrescu@nvidia.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8474568ABFB

On Mon, Jun 15, 2026 at 05:46:19PM +0000, Alex Timofeyev wrote:
> RDMA-CM cannot establish an IPv6 RoCEv2 connection between two NICs that
> live on the same host. This shows up on hosts that pin one process per
> NUMA-local NIC and let those processes talk to each other over each NIC's
> global IPv6 GID (e.g. a storage daemon with one engine per NUMA node on
> dual ConnectX-7). rdma_resolve_addr() and ib_send_cm_req() both return
> success, but the destination NIC silently drops the frame and the peer
> never sees the REQ; the connection times out.
> 
> The bug has two halves, one on each side of the connection:
> 
> 1) Send side (patch 1, drivers/infiniband/core/addr.c)
> 
>    When the destination address is local, addr_resolve_neigh() copies the
>    *source* device's MAC into the path record's destination MAC. That is
>    right for true loopback (same netdev), but for a destination that lives
>    on a different netdev of the same host the destination NIC will not
>    accept a frame addressed to the source NIC's MAC and drops it in HW.
>    The fix resolves the netdev that owns the destination address and uses
>    its MAC.

I'm not sure about this, you need to have policy routing or VRF setup
so these local routes don't show up.. Do you have that?

A local route result should result only in a local loopback AH, it should
never result in a packet on the wire, and we shouldn't be trying to
mangle loopback routes at all.

> 2) Receive side (patch 2, drivers/infiniband/core/cma.c)
> 
>    Once the REQ does reach the peer, validate_ipv6_net_dev() rejects it:
>    rt6_lookup() of a same-host destination collapses onto the loopback
>    netdev, so the strict rt6i_idev->dev == net_dev check fails with
>    -EHOSTUNREACH even though the REQ arrived on the right net_dev. The fix
>    accepts an RTF_LOCAL route when net_dev itself owns the listener
>    address. This half is only observable once patch 1 lets the REQ
>    arrive.

Same answer here, if you have proper routing you won't get a loopback
route to match and you won't fail on this check. Removing the check
does not seem correct.

Jason

