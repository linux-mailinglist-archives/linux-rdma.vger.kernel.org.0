Return-Path: <linux-rdma+bounces-22157-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eMA4MkfhK2q1GwQAu9opvQ
	(envelope-from <linux-rdma+bounces-22157-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 12:36:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 867F4678B98
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 12:36:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ionos.com header.s=google header.b=LzJiviwc;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22157-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22157-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=ionos.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7E2130E69C9
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 10:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B378395D9F;
	Fri, 12 Jun 2026 10:36:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FB1371D0A
	for <linux-rdma@vger.kernel.org>; Fri, 12 Jun 2026 10:36:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781260609; cv=pass; b=TlauOS6qBr+G73C7/LAzGUX3vb9mbhIkCyFK7cXmLCdPn48/ByyBz74ZU1FnTuxYrqTclkg1/CM/Mh7mzxOX1K7uHZPAuoVri/hdZEMoR3KMIZmLXdd84PSiIcLUQRKCmPjArrkuIgIca8H8SRuCACWK8KAtHkgDJijddj4wStc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781260609; c=relaxed/simple;
	bh=tpqD6dEgKwpDgTt1o9eFgCfJTmaToJVb/2vuyaplCfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vd5jqBLrLAtOL9GqTunWNrP3h8Qr38+6RzGZdZyesVFnaXzBaD3INsLeFWM7YLu9JOOw0OX3GdlVR8UiknBcf/TGInpUBiDEux4JE3VzMZTj65XcnH/iHzE9PPYgxgi+89fgaDvV1+W6gKoN41ZGOE5dALk2UWNve5AN6J7LYBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=LzJiviwc; arc=pass smtp.client-ip=209.85.208.169
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-396753f343aso7822821fa.2
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jun 2026 03:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781260605; cv=none;
        d=google.com; s=arc-20240605;
        b=eHjE3kUG+RkdySm96Pu0SXehCRJ6BmPP1lWVA7Qldbz19HBpHhaeE4ldA4Xn0zGkSE
         c9KY/x9MPQCnvyLA2JIz6YmusSpjI1wKidtEjOCLfiDqd1hjRu+yhblg7Wz1TSAxp6nh
         u4OSj1pUderqQlYGIOrXbNqGrmk8HdQiLewkSm78DaOqX1NRMBC79K9qXUJLA9Yq+mnd
         NZfGD/WjsJX+I03KROkd80td0s7mpwQRmLjCK67LUL0JGR+5WEJEu1x9rKY4HB4hBG7w
         ZqWiSWSIip3YD5+sJzTCN7fIxwHoNrQE59Eg36SBHbOjwqUrK6KzDzPe7egMvjaYN3Pk
         mcUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t8/MJrALaz6S8qNbsg31/wcn5U1Sj+Gpvh/chh0VHc4=;
        fh=P6MGnbdgnhlGDoGSon7wVOJ4p+cGwtIoOrH5YQdEGLA=;
        b=BBiKLDfbVAWhHluRicix69Yz2Ctyi3mV1+GfA1NX25JJr5t4/cJkWRGU6KVH9F4jE8
         lV0y318U+XFIRWHK0P4MP01+8/ypI2CUaLFFKTrio9dp2M/KnxvQNykP60n3CMvApdZp
         QTLTfvjQNrd+UBJL4zMW0a5Bjob/EiA/lWfSq3QZIWooSk/h//Zucd4WHcb4eqfQAZDF
         wN2rKsJXwGuxu2Ooeb62apJzYR7fnNStDQ4e1q9j29kXgJyAaGbA99VCJDpvH5HhUYGL
         mJYy29N/tXrwdgny8YbcW0uMykvvBWiHvpR34tE6E0upPDpKA3XGz2eBwRna8GA+H/VS
         BOYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1781260605; x=1781865405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8/MJrALaz6S8qNbsg31/wcn5U1Sj+Gpvh/chh0VHc4=;
        b=LzJiviwceISAohEOtNC4PCyESDuk7Id7bvpl7o8L4RP6BlHos0fn8TpndiONXXjZgX
         udRjnpgvScN8U9TUs9hs9vkCVIqUWx8yhOFY448gfw6B075gsvtk0Y7xaCEaEAI7Opek
         N+TEcWDspniRhHsOa4Ny6+Bop6TjSvRgPXsq9eEUz6QJIN+cziAuatzWBxoYMk5P0mAi
         0Gh4qFq8eeMQ6l/eZB3pC0iwOjaj9CdAwEuGo67SEVjTbqtpl6uq9GLHPTbLBv5V4F/P
         sibmLaeaYkD2imXcZLIsGoNdHNUYREBLGc3YXFVYmygnekGFqDJ8fhr95WtEWK+xh0gE
         KojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781260605; x=1781865405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t8/MJrALaz6S8qNbsg31/wcn5U1Sj+Gpvh/chh0VHc4=;
        b=sNEUcPPsKJ94kBxT/qCLBirY/QNEjpWUY+xO1rlTX51hXG7BXn1n1pPyKpD3boO+oy
         pjUQWy8ZsEEY7bGilOKr63uK43VV06v2U34IIbkoWOP9SodUHvZnQ0k9aC56z1AlAVGr
         hV8jwLd/gw1WuWt4fCPkSNDLcJ4wkpfyMS6Uf8hxd3FPePv6XL+iBxJQ/pZzA3UBGU9S
         NnNvTuotxqKG/5iro+SbV4BEUW8QpGpHWhRxcZjwhHHT/boiJjpYbVeLlDrtapRQO2Kv
         ichYr3VxOHYRBOToDYSCu9tQ324s0iLwn8t/afca/LcIxNMNcaR+qzz2kQPmbEifiHnu
         mxZA==
X-Forwarded-Encrypted: i=1; AFNElJ+L19/3kjZunCjcd5EtYsHhD/pSMKO8te7zNib0xPh0GowJoAJga78GSCYFlsREQBVjz1FqGl6P721i@vger.kernel.org
X-Gm-Message-State: AOJu0YztEV/1x+n+9UzPUq2WKWd6508plF8rkSaYdqh3U1yfyPifQpaf
	O2I8nRJyaJzCW6u80QRFUSswgz3UcihaiYdWU7Fy2e0Sh4wznCmyZeOCyKAme8w365iut1BVTD2
	UJ+65tknmb77qopEqW3Cy1sdbR5l9O54jo2cMY4CzwLTXhTwrl2vktXg=
X-Gm-Gg: Acq92OEW+r4+K2B0iwu6feNqxIMGXfTB1P9DKxQnQ5RwV6h1yzX+RM1P6OO0rsG+yeF
	yZpRLROwkdNFbGvGUGbQMdqkhFryc7+h05TvwPISEr+gc49ZU2Vf3s13By02SUIY9CpryNzSxms
	0JpJNlg2URvg/Tph6Xu1xUm5W1C7g23ksdPod7sx9EzZY/W8tnFEYyZZDHjyc3CXM6hnyAuUsan
	v1GUV9jC30q4LAT6HNQWlqOwSo0KCe79p5MxiKCycUK/6LyKV7eD/qqu9pGCOPWzHAmZkL0ulhY
	nZXTRYhng4Eae9lBzf22LdqN4zqx7pVJPnw/bGnqy2z2cwu8b+SR7jNfpB7zeVUj2FmQ
X-Received: by 2002:a05:651c:2114:b0:396:a77d:210d with SMTP id
 38308e7fff4ca-3992afcb1b9mr7731741fa.7.1781260605428; Fri, 12 Jun 2026
 03:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505074644.195453-1-haris.iqbal@ionos.com>
 <20260512103424.GR15586@unreal> <CAJpMwyg-6Qxskq2ktuhvf46yD5848J9BYLMPPfBLjg2Uzs=xnw@mail.gmail.com>
 <20260611115902.GO327369@unreal>
In-Reply-To: <20260611115902.GO327369@unreal>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Fri, 12 Jun 2026 12:36:32 +0200
X-Gm-Features: AVVi8CcddBB36C8Ot9lu1AJmuGsTsI5ux-b2nD3IzT3SB1V77NCFVDdDUt0L2xE
Message-ID: <CAJpMwyj2A1ZOAUUd+7KR-RxeMrqgvZd2MqZ2iqjJKXhRXHXY9w@mail.gmail.com>
Subject: Re: [LSF/MM/BPF RFC PATCH 00/13]
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-block@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, axboe@kernel.dk, bvanassche@acm.org, hch@lst.de, 
	jgg@ziepe.ca, jinpu.wang@ionos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.06 / 15.00];
	WHITELIST_DMARC(-7.00)[ionos.com:D:+];
	SUBJ_ALL_CAPS(2.10)[28];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22157-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[haris.iqbal@ionos.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:linux-block@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:axboe@kernel.dk,m:bvanassche@acm.org,m:hch@lst.de,m:jgg@ziepe.ca,m:jinpu.wang@ionos.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haris.iqbal@ionos.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[ionos.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ionos.com:dkim,ionos.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 867F4678B98

On Thu, Jun 11, 2026 at 1:59=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Wed, May 27, 2026 at 02:44:08PM +0200, Haris Iqbal wrote:
> > On Tue, May 12, 2026 at 12:34=E2=80=AFPM Leon Romanovsky <leon@kernel.o=
rg> wrote:
> > >
> > > On Tue, May 05, 2026 at 09:46:12AM +0200, Md Haris Iqbal wrote:
> > > > Following a conversation with Bart yesterday, I am sending the RMR+=
BRMR
> > > > code through patch for easier review.
> > > >
> > > > The patches apply over the for-next branch of the block tree over c=
ommit
> > > > 07dfa981ca3
> > > >
> > > > For context,
> > > > RMR (Reliable Multicast over RTRS) is a kernel module that provides
> > > > active-active block-level replication over RDMA. It guarantees deli=
very
> > > > of IO to a group of storage nodes and handles resynchronization of =
data
> > > > directly between storage nodes without involving the compute client=
.
> > > >
> > > > BRMR (Block device over RMR) sits on top of RMR and exposes a stand=
ard
> > > > Linux block device (/dev/brmrX) backed by an RMR pool. Together, RM=
R and
> > > > BRMR provide a single-hop replication and resynchronization solutio=
n for
> > > > RDMA-connected storage clusters.
> > > >
> > > > My session is on Wednesday, at 12 in the storage room (Istanbul).
> > >
> > > To summarize the discussion:
> > >
> > > 1. Move as much logic as possible into the block layer; RDMA should s=
erve
> > >    strictly as a transport.
> > > 2. Identify another in=E2=80=91kernel user of this functionality, and=
 add support for
> > >    it if required. At least accommodate potential users elsewhere in =
the
> > >    kernel.
> >
> > Thanks for the summary Leon.
> >
> > The main logic which handles multicast/replication legs, missed I/O
> > tracking, re-synchronization, etc are the core parts of RMR.
> > If we move those to a separate module, there won't be much left in
> > RMR. RMR already uses RTRS from the RDMA subsystem as transport.
> >
> > Having said that, I am not against moving RMR out of the RDMA layer.
> > It can serve as a reliable replication service/library for any other
> > user in the kernel to use.
> > Which subsystem (block or something else) would be a better fit then,
> > can be discussed.
> >
> > PS: Would this be a good candidate for a session/discussion in the upco=
ming LPC?
>
> Probably yes.
>
> Thanks

Thanks Leon. I'll submit the abstract through the portal.
Do you think the topic is better suited towards Refereed track or Kernel Su=
mmit?

>
> >
> > >
> > > Thanks

