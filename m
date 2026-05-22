Return-Path: <linux-rdma+bounces-21158-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ8WC6J7EGrdXwYAu9opvQ
	(envelope-from <linux-rdma+bounces-21158-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 17:52:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2CE5B72B2
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 17:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CEBE3038963
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 15:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC738478E28;
	Fri, 22 May 2026 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcTp1XiC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FD947886E;
	Fri, 22 May 2026 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464454; cv=none; b=Z74Aimy63QK4OMLaH830Q6PoSo45DEw98N/hVL9skQ/w2wnGgx8sMBXRJ5Jj1hybC0dD/HyK1MgSY2/qSNDSPPGwTIOo/YeUop8StcEnRASwdRYV2L6Q0mF6n23gv9lIJM8/EYZFB93qFz3SJ7kYj41xYbpZ5sRtEtRyptGHjbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464454; c=relaxed/simple;
	bh=3qj4sp2Ygz+GWSr0uS4CCK2PDHsALrwUnuiNRcnu8Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jqjzacEsUacc6XjXxGpytqZDGiXZ2K7NVljyCh1LEFeQ4Bl/xSlUelA6E0b5FfxYyprhOSzuYq48BTbjRzVluCn414prZjs3SFWEhFUeIphNCXGMHTJavCbsrsJ2SaatE0dL7DYaT6De4b7Bf0vBJXhJ2cmZTN5WnRKSmc06ReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcTp1XiC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807471F000E9;
	Fri, 22 May 2026 15:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464452;
	bh=kK1Z8+G5JdzrtL4yJcz0BSXEx9OH0SiwFwGqYTVQ8SY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BcTp1XiCPzBqdBetmpMEKQsoJCjoKq1KCqPblX+GuDLN6HLCTiYJy+Ncaw6zBdTLj
	 aj9LthNxvTVZind+bRZ8Nj9rxma1ZZdpt9wYUJdj0pWkbHzM8yqP5yKnPJht785Pww
	 NYLSIsxJqhFxsJ+YngCvSkL8fwliNNpjIhKSIxsJyc80ikI8Y8HbFGgnfYJ31ZnFSf
	 EsLAllrN3L6cN9oGbLZPndMqOATS0Bf0XPHHGe2CZc6sK3mSLc0uuE89dKC/HoJLEm
	 bHh5wf1pOcTaAcCn4wNUEvbPK7A6xVCFhvQ+ZgTg/banKd0TpH2CdJAHB91alOrq2K
	 I3/YTuS9bwygA==
Date: Fri, 22 May 2026 08:40:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <pabeni@redhat.com>,
 <edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
 <przemyslaw.kitszel@intel.com>, <sridhar.samudrala@intel.com>,
 <anjali.singhai@intel.com>, <michal.swiatkowski@linux.intel.com>,
 <maciej.fijalkowski@intel.com>, <emil.s.tantilov@intel.com>,
 <madhu.chittim@intel.com>, <joshua.a.hay@intel.com>,
 <jacob.e.keller@intel.com>, <jayaprakash.shanmugam@intel.com>,
 <jiri@resnulli.us>, <horms@kernel.org>, <corbet@lwn.net>,
 <richardcochran@gmail.com>, <linux-doc@vger.kernel.org>,
 <tatyana.e.nikolova@intel.com>, <krzysztof.czurylo@intel.com>,
 <jgg@ziepe.ca>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>, Samuel
 Salin <Samuel.salin@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v3 01/14] virtchnl: create
 'include/linux/intel' and move necessary header files
Message-ID: <20260522084050.5ba31f38@kernel.org>
In-Reply-To: <5426379b-1201-4707-8d18-21dca3d1424e@intel.com>
References: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
	<20260515224443.2772147-2-anthony.l.nguyen@intel.com>
	<20260520175201.72f83c4a@kernel.org>
	<ag7QUgfpM5UAAE2z@soc-5CG4396X81.clients.intel.com>
	<20260521065609.248c7009@kernel.org>
	<5426379b-1201-4707-8d18-21dca3d1424e@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21158-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,redhat.com,google.com,lunn.ch,vger.kernel.org,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com,ziepe.ca];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0C2CE5B72B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 22 May 2026 13:08:08 +0200 Alexander Lobakin wrote:
> >> There are at least
> >>
> >> include/linux/mlx4, include/linux/mlx5 and include/linux/bnxt.
> >>
> >> Those are per-driver and not per-vendor, but intel ethernet has too many drivers 
> >> to have separate folders for them.
> >>
> >> I just do not think this creates a precedent neccessarily.  
> > 
> > You just said the other ones are for specific drivers.  
> 
> Right, but according to your earlier suggestion they belong to
> include/net, not include/linux.
> 
> My understanding is that they're under include/linux, not include/net as
> mlx5 is not only about Ethernet, but also RDMA etc. The same applies to
> Intel's headers.
> 
> What's your position after all this? Still include/net/intel? This
> commit is about stopping scattering Intel headers all over include/linux
> and set one place for them.

I strongly dislike the idea there are "intel" headers. Header files
are not sorted by vendors. That gives off way too much "Intel's corner
of the kernel" vibe. "net+Intel" is fine, but Intel by itself is too
broad.

So IDK. include/net/intel is fine. So is the current layout. Or stick 
to driver / module by module like other vendors.

> >> Folder structure is for you to decide as a maintainer, but it would be nice to 
> >> have known about such doubts earlier.  
> > 
> > I'd love to know if you any suggestions for improving the process.
> > Otherwise please keep your venting off list.  
> 
> I think Larysa just wanted to say that you disliked this commit after
> the series went through several iterations on IWL and 3 iterations here,
> nothing more. It's not about the overall process.

Intel has a strongly negative reviewer score right now.
IMHO it's not appropriate for y'all to complain about upstream
reviews, or how long it takes to get your patches merged...

