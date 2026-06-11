Return-Path: <linux-rdma+bounces-22107-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iyK7JBKjKmqEuAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22107-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 13:59:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3432F67194F
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 13:59:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MEjMqfo2;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22107-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22107-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68D023029616
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 11:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D7A3D903B;
	Thu, 11 Jun 2026 11:59:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCFC3CB2D4;
	Thu, 11 Jun 2026 11:59:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781179148; cv=none; b=C5TUlUseaZSVjn6sfyOUoie4WIBv9h0KfYLko8oS3nUE96uVa962n58w35xDE+IPJrE4gae9Qw/NRJJnp7l80WK1hLz1oz1lD1KA+MwRCnnAMAAU2GNApz1zodUNztH1MqXxYW0DZFnfAinj5lZK8MAjDzkhLcYue0coI5dni/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781179148; c=relaxed/simple;
	bh=8KaF6mblFTthT4vUi6B2dz8Qy2dVYAv+MLA4DxjD5UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AunnQo2/YybbmbtLxq/uS3g5BbT633Za47huOQlaeYyLXfOCZGam6ptC2HsoZni8PKe2/ihkHOGqIHCj/KBxKcRtg5RFbsGGeH6ehUXSJ/ieLau7i8NVDMdAE8XGvVN/yTr+Vail0LWY646bibhBwDJrfRxTEto7fwNM90sh/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEjMqfo2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198A91F00893;
	Thu, 11 Jun 2026 11:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781179146;
	bh=9Z4ndnCxV+CiLTTLCplpjJEgcmLTMIk7XFj1r1QBl6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MEjMqfo29SfAQpahMBxLdEUP40M8qYZSS8LoII0n+6hpcFkJQCokTqDfgzQKjjG6O
	 tWjhkSF9KBrwG/hjbkl5yeAtC5IqK0hOFQfeS3DibgMV+5heGY7tzwMesHipuB4COk
	 PLn4AQoKXotCKcpqHoOjyTjaG9/vJit4SiSJGb3zjWMBDmmWkRnn/O1eDAJkR8CMYH
	 1WqaqFNMIYbfK0oVqaVD1GemoGAl4fbW/QRwcmz1ZDMVsXydl14zVP7ENGSsZZpGs6
	 bN3S1pw+4QnhmXRq+p1W3wwJfuTaogA8zcXShzKHqgikkbjR0WoohISBVeG7EwK33U
	 ihMO/c7IPrk2g==
Date: Thu, 11 Jun 2026 14:59:02 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Haris Iqbal <haris.iqbal@ionos.com>
Cc: linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, axboe@kernel.dk, bvanassche@acm.org,
	hch@lst.de, jgg@ziepe.ca, jinpu.wang@ionos.com
Subject: Re: [LSF/MM/BPF RFC PATCH 00/13]
Message-ID: <20260611115902.GO327369@unreal>
References: <20260505074644.195453-1-haris.iqbal@ionos.com>
 <20260512103424.GR15586@unreal>
 <CAJpMwyg-6Qxskq2ktuhvf46yD5848J9BYLMPPfBLjg2Uzs=xnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJpMwyg-6Qxskq2ktuhvf46yD5848J9BYLMPPfBLjg2Uzs=xnw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.56 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUBJ_ALL_CAPS(2.10)[28];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22107-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:haris.iqbal@ionos.com,m:linux-block@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:axboe@kernel.dk,m:bvanassche@acm.org,m:hch@lst.de,m:jgg@ziepe.ca,m:jinpu.wang@ionos.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[unreal:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3432F67194F

On Wed, May 27, 2026 at 02:44:08PM +0200, Haris Iqbal wrote:
> On Tue, May 12, 2026 at 12:34 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, May 05, 2026 at 09:46:12AM +0200, Md Haris Iqbal wrote:
> > > Following a conversation with Bart yesterday, I am sending the RMR+BRMR
> > > code through patch for easier review.
> > >
> > > The patches apply over the for-next branch of the block tree over commit
> > > 07dfa981ca3
> > >
> > > For context,
> > > RMR (Reliable Multicast over RTRS) is a kernel module that provides
> > > active-active block-level replication over RDMA. It guarantees delivery
> > > of IO to a group of storage nodes and handles resynchronization of data
> > > directly between storage nodes without involving the compute client.
> > >
> > > BRMR (Block device over RMR) sits on top of RMR and exposes a standard
> > > Linux block device (/dev/brmrX) backed by an RMR pool. Together, RMR and
> > > BRMR provide a single-hop replication and resynchronization solution for
> > > RDMA-connected storage clusters.
> > >
> > > My session is on Wednesday, at 12 in the storage room (Istanbul).
> >
> > To summarize the discussion:
> >
> > 1. Move as much logic as possible into the block layer; RDMA should serve
> >    strictly as a transport.
> > 2. Identify another in‑kernel user of this functionality, and add support for
> >    it if required. At least accommodate potential users elsewhere in the
> >    kernel.
> 
> Thanks for the summary Leon.
> 
> The main logic which handles multicast/replication legs, missed I/O
> tracking, re-synchronization, etc are the core parts of RMR.
> If we move those to a separate module, there won't be much left in
> RMR. RMR already uses RTRS from the RDMA subsystem as transport.
> 
> Having said that, I am not against moving RMR out of the RDMA layer.
> It can serve as a reliable replication service/library for any other
> user in the kernel to use.
> Which subsystem (block or something else) would be a better fit then,
> can be discussed.
> 
> PS: Would this be a good candidate for a session/discussion in the upcoming LPC?

Probably yes.

Thanks

> 
> >
> > Thanks

