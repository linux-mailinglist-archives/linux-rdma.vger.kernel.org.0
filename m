Return-Path: <linux-rdma+bounces-20528-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cACnCz6WA2pG7wEAu9opvQ
	(envelope-from <linux-rdma+bounces-20528-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 23:06:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97442529E0A
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 23:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E6CD306412E
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 21:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF6E3C873B;
	Tue, 12 May 2026 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CsQIoHEB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732643C5552;
	Tue, 12 May 2026 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619934; cv=none; b=n0W8THuakMHeHHuHiucWp4wYNgWjCw84UQEmj7xG4w4KIygczeBOXIl14LiV2dvEW4BS0RiVHjTwrgvO+aOtrS02Voz9aW0ZKk40EukKOTFeGtqQrOTx3Oq81SAuJZ3xqQQYmXXKG6ALR3IY99F8RCjK2aZlsTGTwUrv0CIT4gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619934; c=relaxed/simple;
	bh=mo6e8Tl7INL5treUcIkpAfOY+0nT4RQkp/YxRTbOF7A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=k0exrYkNX3YgQ0ynKmlfLaz/7ifD0StfKWPYV3iP7EwXG85gbsiSN6P20TC1UBQr+bYkiG0qLxQBxyog8dcNos/pYzo462fAe8JiVnygcFka/uuG3vmxunmQ7Z14Jfl5rlbFJ8437+Ppk6JUFOswo3RF1sX+RHRV39sZttGnvhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CsQIoHEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508B2C2BCC7;
	Tue, 12 May 2026 21:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1778619934;
	bh=mo6e8Tl7INL5treUcIkpAfOY+0nT4RQkp/YxRTbOF7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CsQIoHEB8oaEHcAMFfdBryz0a1eiebYrMmN+ZI44OCVnR6E+YcN/oFEnuMH+jF8mL
	 +Edt3gUZ7QqMMLtvW3HlcoJSiNJNWZv+LWR2rt0xoSG0CV1D7QQvsc3ETwZmvXUkqm
	 3q3WEw97mCEI6T1eJBIQMdOn0NalAzj1VojejrbI=
Date: Tue, 12 May 2026 14:05:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Stanislaw Gruszka
 <stf_xl@wp.pl>, Alexander Potapenko <glider@google.com>, Marco Elver
 <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Allison Henderson
 <allison.henderson@oracle.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-wireless@vger.kernel.org>, <kasan-dev@googlegroups.com>,
 <linux-mm@kvack.org>, <netdev@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <rds-devel@oss.oracle.com>
Subject: Re: [PATCH v2 0/4] treewide: fixup gfp_t printks
Message-Id: <20260512140532.f16379be75ab006f2cca4747@linux-foundation.org>
In-Reply-To: <DIGPS83BGEGA.5I7VLH8TV7XE@google.com>
References: <20260326-gfp64-v2-0-d916021cecdf@google.com>
	<DIGPS83BGEGA.5I7VLH8TV7XE@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 97442529E0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20528-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,wp.pl,google.com,oracle.com,davemloft.net,redhat.com,lists.freedesktop.org,vger.kernel.org,googlegroups.com,kvack.org,oss.oracle.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:mid,linux-foundation.org:dkim]
X-Rspamd-Action: no action

On Tue, 12 May 2026 12:58:20 +0000 Brendan Jackman <jackmanb@google.com> wrote:

> On Thu Mar 26, 2026 at 12:31 PM UTC, Brendan Jackman wrote:
> > This patchset used to be about switching gfp_t to unsigned long. That is
> > probably not gonna happen any more but while writing it I found these
> > cleanups that seem worthwhile regardless.
> >
> 
> ...
>
> Any chance someone can take these?

[2/4] is merged into the wireless tree (I assume) and the other three
are in mm.git's mm-unstable branch.


