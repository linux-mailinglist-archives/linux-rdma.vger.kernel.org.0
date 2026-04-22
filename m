Return-Path: <linux-rdma+bounces-19481-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJrwEpwh6Wn2UgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19481-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 21:29:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B08EB44A2C1
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 21:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F5D9306CD2E
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 19:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1652D3F165A;
	Wed, 22 Apr 2026 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="H2zqWgVu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JCcSbt3U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389FE36E476;
	Wed, 22 Apr 2026 19:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886070; cv=none; b=eeU7XO7PwNYkcQ9uAsjcUXpXemNUCrudJ3kkH5FAw55gCpGWzqCJtzBJYnxsk9vmE5OfEjRikwdSAT5H55X8VXWqpcMycv9nFzgW4X1MatlSU4TafWDPHdSy6OMCeH2hRQKmYnlkxqKecBy2PYZLKOr09gto9q8Mn6JNz++b8J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886070; c=relaxed/simple;
	bh=CEPx4xBqpn/LM6mI/TJkP9S6SW10V8v4HWFrbAPvs3k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hf+mRD7dZIUhTvOAEnziAKbueb/BV4/mfe6E0RRPXx+s3PKLkkGo3PTIDa5qc11fG63o8EI/PNrCDQs94zM17HctXt9sgGiJKR3JrUgUKJubvqWKn7R+bw+04k/pM4IqBBL5uYEp7V6PWWMpwo/Jprf8KhmlNo62GQmX3atsct8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=H2zqWgVu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JCcSbt3U; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B08AE1D0020D;
	Wed, 22 Apr 2026 15:27:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 22 Apr 2026 15:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776886063;
	 x=1776972463; bh=ggHJMFIMAYIVtfMm4SfiR6xNegxNgGhsEzHrf1YC/TQ=; b=
	H2zqWgVueVdHhGmA/l+SyejrcQJIuT0lMHQWPHderHUkwn/xcF3Cp84eTGQ2+kxL
	9ClJS3wT30glCIX1XF7Hw9s9/VzKwITM+pfCvJHSQpxf5aYzMYZgRIHqKdMPXSgW
	8bYv89IVb79UbHWFo0LKfep+X8FHZUSAioBYN6cvzzHQURLO4TeV9m/M6nWJF5nw
	8baettDbtFyn8jFTZBNWAVTwMv93ivokyrwZ6SZQ2UDTTrJ6KjDNKxdeShjhec2f
	3w3GKgJvEXf4Jv9Fcpfmfo+ArBZyRLasqCz2qmRQn6TkF3Bu/+8MswTi/qgwL+VY
	/QwEq2CqGn5i0kveGXEopg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776886063; x=
	1776972463; bh=ggHJMFIMAYIVtfMm4SfiR6xNegxNgGhsEzHrf1YC/TQ=; b=J
	CcSbt3UXqNDZdMAD+suswr0h55WRx5sH5kDsgz2ZD/mFSD5LMFjnExdX3DJGW57H
	sXQdLhcASd1/XUOpVYj6MATwIgP3lcMTuUfr3kSXvpWEKD7ip9zI9ZqbPFyRY3mo
	nJheiYHwKVoDcjZYqGjtNSI9bxDtL+fQx79a93anFOQkqIzWthsMRtVzFbL1JifQ
	wbsUwHJWTJf3LuUPGugAkrz2x9nYoH5uJMBTKCHWFeGNnGvWI+AYyvyHpy1BqDKp
	wpCw34NR3bkCCJIZrR/BISsN2qnXLSg60po+9MP2qsgspiGpuhzmKLIpyaLdfwAX
	9qGljhxwyc+JDez89jMqQ==
X-ME-Sender: <xms:LyHpaSO4p1kHk-rcqnzezrRe1Kkm-d6OD7Ij4Z8yMuTOIHL9meDRcg>
    <xme:LyHpaUrM4pP9b-SGUaPuwE9GU82tfhZ7_99k0_J_7AUHAFUisqzAVg60y8nMWtkDJ
    qxI0FxGkM8qs0bTfcC1QJWNDwBRSzKKSc4GlIJ5pb3kRTjG-J6SmQE>
X-ME-Received: <xmr:LyHpaR7FygKgFPat_6DK2XSoqf46NHfZF2B0nXadDscvLwZ_-J66Mjj1rFI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiheduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepvdekfeejkedvudfhudfhteekudfgudeiteetvdeukedvheetvdekgfdugeev
    ueeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopedufedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtohepii
    hhihhpihhnghiisehmvghtrgdrtghomhdprhgtphhtthhopehsughfsehmvghtrgdrtgho
    mhdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    gvohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrughmrgesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LyHpaUEpl0kbj3Zr_QkWClsrz5XH3Tb_GgEKBR7JhjCI0jIr-WH32g>
    <xmx:LyHpab1-w6l48axOOr6APQzH6pTOpV24DSq5gzvVEIlVGn1Zj-gL0A>
    <xmx:LyHpaZoDdUZ7d1egrMVpR02SBwN3wIqZ_DIsOpTJx97x6ZPSSIlwbg>
    <xmx:LyHpaQN4guGLPxrPWNIvZBxwAXksahGHRXiNIZ8zqKvvNnqeT_fw_w>
    <xmx:LyHpaWrLBulWkK53QFC7Xs3L67e0zKDXohnMzX3K4_ecS8-S26PQiG2V>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 15:27:42 -0400 (EDT)
Date: Wed, 22 Apr 2026 13:27:40 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Zhiping Zhang <zhipingz@meta.com>, Stanislav Fomichev <sdf@meta.com>,
 Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>, Bjorn
 Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>, Yishai
 Hadas <yishaih@nvidia.com>, alex@shazbot.org
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
Message-ID: <20260422132740.5f809bf7@shazbot.org>
In-Reply-To: <20260422162928.GL3611611@ziepe.ca>
References: <20260420183920.3626389-1-zhipingz@meta.com>
	<20260420183920.3626389-2-zhipingz@meta.com>
	<20260422092327.3f629ad6@shazbot.org>
	<20260422162928.GL3611611@ziepe.ca>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-19481-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B08EB44A2C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 22 Apr 2026 13:29:28 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Wed, Apr 22, 2026 at 09:23:27AM -0600, Alex Williamson wrote:
> > In general though, I'm really hoping that someone interested in
> > enabling TPH as an interface through vfio actually decides to take
> > resource targeting and revocation seriously.  There's no validation of
> > the steering tag here relative to what the user has access to and no
> > mechanism to revoke those tags if access changes.  In fact, there's not
> > even a proposed mechanism allowing the user to derive valid steering
> > tags.  Does the user implicitly know the value and the kernel just
> > allows it because... yolo?   
> 
> This is the steering tag that remote devices will send *INTO* the VFIO
> device.
> 
> IMHO it is entirely appropriate that the driver controlling the device
> decide what tags are sent into it and when, so that's the VFIO
> userspace.
> 
> There is no concept of access here since the entire device is captured
> by VFIO.
> 
> If the VFIO device catastrophically malfunctions when receiving
> certain steering tags then it is incompatible with VFIO and we should
> at least block this new API..
> 
> The only requirement is that the device limit the TPH to only the
> function that is perceiving them. If a device is really broken and
> doesn't meet that then it should be blocked off and it is probably not
> safe to be used with VMs at all.

Ok, if the vfio user is only suggesting steering tags for another
driver to use when accessing their own device through the dma-buf, and
the lifecycle is bound to that dma-buf, maybe I'm overreacting on the
security aspect.

I don't know how to qualify the statement in the last paragraph about
"[t]he only requirement is that the device limit the TPH to only the
function that is perceiving them", though.  Is that implicit in being
associated to the dma-buf for the user owned device, or is it a
property of the suggested steering tags, that we're not validating?

Steering tags can induce caching abuse, as interpreted in the
interconnect fabric, but maybe we've already conceded that as
fundamental aspect of TPH in general.

So why does vfio need to be involved in any of the sequence proposed
here?  It seems like it would be a much cleaner design, avoiding
overloading the existing vfio feature and questionable array semantics,
if there were a set-tph ioctl on the resulting dma-buf instead of
making some vfio specific interface bundling creation with tph hints.
Thanks,

Alex

