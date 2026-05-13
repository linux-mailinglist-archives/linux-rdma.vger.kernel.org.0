Return-Path: <linux-rdma+bounces-20607-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLo1EiLQBGr0PQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20607-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 21:25:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A82539E76
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 21:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A0F03027735
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A63D3B4EBF;
	Wed, 13 May 2026 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="EiZU7P0l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ED03B2FFC
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 19:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700313; cv=none; b=l3JV6temBMApjP5sP0swuPmPU70AgpwzVLmBduz9+cPPOeloeGScgvWzp5Wgt2+p5KMExuCi49Zu5FuNp5aae+CWjKExyqGaaxixmsiIaxaydZzgWjxtAynt0YU4NoovZ+oOclmia8rSjXS5AvafB0XFkcV7Y2JnhA4twfhji4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700313; c=relaxed/simple;
	bh=4UNGgoUNqzbApBfG+2S0mBUmqH+5+eoVfmgb/VoQmxo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBNyrq9kHvXlzdfwysGtRz8KEFwacZ/YWly5dM0qgeB2bH5ZZMbNFPpC/J8GpEX40rjB5kiB5gHZ3DkKoJdiOXrk2CwUyBWUb9QfEx0mJta5uiiUqFCMHxutvC/BqQzK5zzcv2ejzcZMmB9CHQuJ0f9+k2dWoW+rstWK64tGgdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=EiZU7P0l; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778700311; x=1810236311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OHs7s82ufPV/Smz2a5gJAL/d3tL2Eb2+xHJMIsF6Qpw=;
  b=EiZU7P0lD4ZR9gD4cU3VsnbylOC49P5sRhp1s6zl4jw3ja7vR3xqu81R
   GR/U7Mo3hjSk49U3qiDvcqC5jviBPEAHUmNiH48RjL0c/Qszsn0LxNdtX
   DdzcpqGBy58zA4FM6PlI5xmBQXeYIAlZHqNf48GD/5QoLztvpFr50Tp7H
   Lr876dQ5dBboE7QR567Lra54dJKFhXt/ABGSS+wMhmsfrPfVtD6CR4FEs
   mFSNT670/yWC+Pu3ZIZzz3IYZT3m5hHAWa1wmQ79TThKvuDZHm/XyJ1RX
   XSbYG+A4u0Hzr7kECzN0gvn5QvJXXfn49c3ykXS5wFEtrm7UH9P0px17Y
   w==;
X-CSE-ConnectionGUID: Qy6eID+gQcqg1DgHxqjQAQ==
X-CSE-MsgGUID: 3HCRN1RXR7+cZ1r5QYU9Gg==
X-IronPort-AV: E=Sophos;i="6.23,233,1770595200"; 
   d="scan'208";a="19592958"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 19:25:08 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:14101]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.241:2525] with esmtp (Farcaster)
 id dafad4da-29f3-4e62-b3bd-49d80a9c39f7; Wed, 13 May 2026 19:25:07 +0000 (UTC)
X-Farcaster-Flow-ID: dafad4da-29f3-4e62-b3bd-49d80a9c39f7
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 13 May 2026 19:25:07 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Wed, 13 May 2026
 19:25:05 +0000
Date: Wed, 13 May 2026 19:24:51 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <mrgolin@amazon.com>,
	<sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Daniel
 Kranzdorf" <dkkranzd@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Validate SQ depth based on WQE size
Message-ID: <20260513192451.GA15167@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
References: <20260507112110.869212-1-ynachum@amazon.com>
 <20260513173812.GH15586@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513173812.GH15586@unreal>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: B3A82539E76
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20607-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 08:38:12PM +0300, Leon Romanovsky wrote:
> On Thu, May 07, 2026 at 11:21:10AM +0000, Yonatan Nachum wrote:
> > From: Michael Margolin <mrgolin@amazon.com>
> > 
> > Change the SQ depth validation to take into account the SQ WQE size.
> > This is needed since when using 128-byte WQE the max SQ depth is cut in
> > half. On create QP command, userspace provides SQ ring size which is SQ
> > depth X WQE size so we can calculate the requested WQE size in the
> > kernel.
> > 
> > Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
> > Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> > Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> > ---
> >  drivers/infiniband/hw/efa/efa_verbs.c | 39 ++++++++++++++++++---------
> >  1 file changed, 27 insertions(+), 12 deletions(-)
> 
> Please add Fixes line.
> 
> Thanks

There is no Fixes tag as this is not a bug fix. The existing validation
works but is overly permissive — it doesn't account for WQE size when
checking max SQ depth. Without it, the device would reject the request
downstream. This patch tightens the validation to fail early in the
kernel.


