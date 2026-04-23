Return-Path: <linux-rdma+bounces-19516-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J1SKPtw6mlBzQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19516-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 21:20:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3753F456A99
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 21:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CC903002336
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 19:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FC9391E51;
	Thu, 23 Apr 2026 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="gdx1ISCQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZUvdr8y6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9D83909B8;
	Thu, 23 Apr 2026 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776972022; cv=none; b=Q5Flld9huVbWJg15xXRKye27E7Lh0oz4VeybOTDOQS08fBgk+yrFBs0juJY5YVsXAV17dC+qGkDFiZDxySRbjQ2ehkf/bUQYC8hITe0TxD+kQQ0jVN1z3pCb0U054/AyCaPsjpONT/8Y82ExfNlOawzOfK0iNgDg/eS8xviLl+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776972022; c=relaxed/simple;
	bh=7OAMBqFezqilmW4ZrrxTT+MbAtt0mJHp17fXOTvbY7g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OobOmx6ylQdH+hY3ZWAuEScJUqXpRjM1yA5cQQPkRSKAac4PG1LNeCzslSKQ1cotf9guUldNe8GrLgr1bhwhatFd29CtL5fCft94Str2K49yAmYOWzDrZwkmTzFr6D4ZTX3eUlQGjMq4bsOxbCbaiNX9p21MYgiT/yx1BkpP064=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=gdx1ISCQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZUvdr8y6; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 517CD140016D;
	Thu, 23 Apr 2026 15:20:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 23 Apr 2026 15:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776972018;
	 x=1777058418; bh=zgX8pUM+ByGW1BJ4PzJmLl3HUKg2UKXk7RpMYuVX26w=; b=
	gdx1ISCQg+TSBOVzJw59r+B2kL6yGJACfaN4o+jfw1+LVBJo8M4CLyvxMZqpWhIx
	8fpOYl9DQkAlFfIqSSi144Ul6oti8nQ6hSCVKDwxC+s/lBtdHrv7lReF2ZngadSN
	Od1QCcLnTHuxXOT44WWZfQzQACQhujzMpDPuxVnmfq8rkKaOQ+ikX7We+iSqzRzO
	lrBOtjeU4I9U3WCOUqUbHutFZXTRaEeWJ9839dNT5HYMu8eu7IaaETPPNEntcAqf
	63YieUjaDu3Uo65EwCqgbc3T4uzS9avWCXOdukTXE1yhHm8iyNTcNLelKZkXBko7
	FtdcikH0aPB8qC7aZQPDxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776972018; x=
	1777058418; bh=zgX8pUM+ByGW1BJ4PzJmLl3HUKg2UKXk7RpMYuVX26w=; b=Z
	Uvdr8y6kuGVNdu3c0ZQYsoJsU40DdAh5s3HryOIhEf7x0mApZTi4iFdEyC/sOHH+
	7uxNgxnxV0i/uJwA9+WLgOk7+eKspnp5ZmPGowwF76c5XZwyVTXpJCuE6G9SI9pI
	JCXmyMKupSQ7GgZl01RmGH4oa/94yXKLCW9Jopu44qiDXX7TzAG9eJuKBK3KwBOp
	53Gh7vFoSv8P9lglzIdViXCpVS4wYjSOwwFvMBAmTuraMIYTfxi5YM5DohZxfUsS
	zagp3HpVZ+gSqBaYoQKpsSWl2Gh7GpamX+WRzFOIOfxUOSimzBmOvbZCFSowXc1n
	s/AaHraDRy7mAx+OBWdZQ==
X-ME-Sender: <xms:8nDqaSocVBUsGX6Dqv_G5w1rlJmoZL84errVQL3TlmWj8TRDyuK1aw>
    <xme:8nDqaV0BVjnH0Hj5F-hlKcd8X682cxE0tqu2brwkqUO7P9eoU9sbW3qd158Z-qwg3
    dcfVuqBvxksctosoEesiDf4wm47d41NEex_UAhQcNeIFqWc4Db3og>
X-ME-Received: <xmr:8nDqaamq_rWSOK6CdZLMRBlb5SJREhMRV-lT_9V1GmTwxSd5W0bWC35lALQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeijeeljecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:8nDqaRa_rMoY3-Gu0IG6in9WxOQrtHLSZfodCQRs-3oWG0hGYNOALQ>
    <xmx:8nDqac-z_p1atCzPwxluejmtD6AzXG34JJfqwXlRQXFPUayD4aMd4w>
    <xmx:8nDqaREJs6AGZct-AGSAW1QRMET9_rt_kBglLTDnxIKI0-7uxp8MxQ>
    <xmx:8nDqaWezx6LiHdIh6_5BLrSXwi94wLwltOZ7z-ABrrvRs79Kw8U4iQ>
    <xmx:8nDqaSlZyN88SxHutEDRqgWwDrmlZGWMI7VKYXHLfjociova4Iy6orlE>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 15:20:17 -0400 (EDT)
Date: Thu, 23 Apr 2026 13:20:16 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Zhiping Zhang <zhipingz@meta.com>, Stanislav Fomichev <sdf@meta.com>,
 Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>, Bjorn
 Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>, Yishai
 Hadas <yishaih@nvidia.com>, alex@shazbot.org
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
Message-ID: <20260423132016.4a25e074@shazbot.org>
In-Reply-To: <20260423142828.GQ3611611@ziepe.ca>
References: <20260420183920.3626389-1-zhipingz@meta.com>
	<20260420183920.3626389-2-zhipingz@meta.com>
	<20260422092327.3f629ad6@shazbot.org>
	<20260422162928.GL3611611@ziepe.ca>
	<20260422132740.5f809bf7@shazbot.org>
	<20260423142828.GQ3611611@ziepe.ca>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-19516-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,shazbot.org:dkim,shazbot.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3753F456A99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 23 Apr 2026 11:28:28 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Wed, Apr 22, 2026 at 01:27:40PM -0600, Alex Williamson wrote:
> 
> > So why does vfio need to be involved in any of the sequence proposed
> > here?  It seems like it would be a much cleaner design, avoiding
> > overloading the existing vfio feature and questionable array semantics,
> > if there were a set-tph ioctl on the resulting dma-buf instead of
> > making some vfio specific interface bundling creation with tph
> > hints.  
> 
> Realistically only VFIO dmabufs will have this property that user
> space can set any TPH.
> 
> Other in-kernel drivers should accept some kind of hint from userspace
> when creating their dmabuf that makes sense for their device, not a
> raw TPH value. Like a GPU might accept a hint that specifies which
> dielet or something like that.
> 
> So I don't see a generality here from that perspective. The generality
> is that exporting drivers that can use TPH now have the option to tell
> the importing driver to send them.

Ok, if dma_buf_ops.get_tph serves the common case of the driver
presenting TPH values and vfio's case of the driver being only a
conduit of user specified TPH values is unique, let's work on the vfio
uAPI.

Why do we need to bundle dma-buf creation and TPH setting into a single
ioctl?  That's what the proposal here does and it results in a really
ugly extension with an off-by-one baked into it.

My suggestion would be that we leave VFIO_DEVICE_FEATURE_DMA_BUF
unchanged and add a VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl which takes
the fd from VFIO_DEVICE_FEATURE_DMA_BUF, along with a steering tag and
processing hint.  It would fdget() the dmabuf fd, validate it's a
dmabuf via f_ops, validate it's a vfio exported dmabuf via dmabuf->ops,
find the matching vfio_pci_dma_buf via priv under memory_lock, and
stuff the provided TPH values into the object.  It would be left to the
user to sequence setting the TPH values on the dmabuf before the dmabuf
is consumed by the importer.

Is that a more reasonable uAPI?  Thanks,

Alex

