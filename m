Return-Path: <linux-rdma+bounces-20941-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AoDMWivC2q2LAUAu9opvQ
	(envelope-from <linux-rdma+bounces-20941-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 02:31:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6878E5758E8
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 02:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 527D2302AF0E
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 00:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C624E23EAB7;
	Tue, 19 May 2026 00:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C6+dbiLA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE9378F2F;
	Tue, 19 May 2026 00:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779150681; cv=none; b=AlDANr1tPwucvlBQYLsNl+cChOpmzxRV6+yZZoezZb2nHUT87EDwCY9ancM2hY71ARYrCZKE3gzc2ACsA+DricWlq3olb9XT1LZ60K7aU0LOGMZd2cnmPZA9PwZorzhxNpnahtaSfukBkNPifjggsLpqOQC/Dl1XMiSG42QFXVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779150681; c=relaxed/simple;
	bh=Hn8nkfC6AtTfS13eIodWwSfN5loWrhpApSyYRHdiRas=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=h+vMfNYoiBTw8BVY9krbMNYBkwjp88y1N/j2lff5HT32SypwT3z1/nBpzgZdW7Xr9vs58/4nbcQ78z/wcAzaQRDsDljVCJFfI5GQi4S7FHUpCChS5DSRFeSojmCjkldcY4xzIBqJIj6VlOqP3mVlvZlG5r7/KPG4J2N+dd/r1QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C6+dbiLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B115AC2BCB7;
	Tue, 19 May 2026 00:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1779150680;
	bh=Hn8nkfC6AtTfS13eIodWwSfN5loWrhpApSyYRHdiRas=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C6+dbiLA7Qe6C0VhGgzhrJtQCs/262xxPZUANDJfuzXdf5siA85xk0If9yuFKEStg
	 JNM8zLf2+9wzRszYeOSqj6gJWs/TZFkhPTp+jsjM28txbYbPLzs+VTomvIr1FBeb5e
	 QnXYXs9hEmJw+yiIH2VrSFVQO9NUCJT9ECzDRppg=
Date: Mon, 18 May 2026 17:31:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Byungchul Park <byungchul@sk.com>, kernel_team@skhynix.com,
 ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 david@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, horms@kernel.org, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, ilias.apalodimas@linaro.org,
 kas@kernel.org, willy@infradead.org, baolin.wang@linux.alibaba.com,
 asml.silence@gmail.com, toke@redhat.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Revert
 "mm: introduce a new page type for page pool in page type"
Message-Id: <20260518173119.f3348ec4cc66b793fed4cccf@linux-foundation.org>
In-Reply-To: <agruFy80Ag3uIab0@lucifer>
References: <20260515034701.17027-1-byungchul@sk.com>
	<agruFy80Ag3uIab0@lucifer>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20941-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[sk.com,skhynix.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,infradead.org,suse.com,cmpxchg.org,linaro.org,linux.alibaba.com,vger.kernel.org,kvack.org];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:mid,linux-foundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6878E5758E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 12:00:11 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:

> Maybe worth putting [PATCH mm-hotfixes] just to make it clear this should be an
> urgent hotfix?
> 
> On Fri, May 15, 2026 at 12:47:01PM +0900, Byungchul Park wrote:
> > This reverts commit db359fccf212e7fa3136e6edbed6228475646fd7.
> 
> Maybe 'this reverts commit db359fccf212 ("...") and partially reverts commit
> 735a309b4bfb9e ("...") <details>'?
> 
> >
> > Netpp page_type'ed pages might be used in mapping so as to use
> > @_mapcount.  However, since @page_type and @_mapcount are union'ed in
> > struct page, these two can't be used at the same time.  Revert the
> > commit introducing page_type for Netpp for now.
> 
> Yikes!
> 
> >
> > The patch will be retried once @page_type and @_mapcount get allowed to
> > be used at the same time.
> >
> > The revert also includes removal of @page_type initialization part
> > introduced by commit 735a309b4bfb9e ("net: add net_iov_init() and use it
> > to initialize ->page_type"), which will be restored on the retry.
> 
> As above maybe mentioning at top of commit msg, as right now this reads as a
> pure revert of db359fccf212.

I did

: This reverts commit db359fccf212 ("mm: introduce a new page type for page
: pool in page type") and a part of 735a309b4bfb9e ("net: add net_iov_init()
: and use it > to initialize ->page_type").

> >
> > Reported-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Closes: https://lore.kernel.org/all/982b9bc1-0a0a-4fc5-8e3a-3672db2b29a1@nvidia.com
> 
> Fixes tag?

I assume db359fccf212 ("mm: introduce a new page type for page pool in
page type") is close enough.  Both that and 735a309b4bfb9e are new in
7.1-rcX.


