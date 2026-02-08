Return-Path: <linux-rdma+bounces-16676-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH0xCPEyiGnTkwQAu9opvQ
	(envelope-from <linux-rdma+bounces-16676-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Feb 2026 07:53:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1E41080AF
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Feb 2026 07:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 661A1300CCAB
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Feb 2026 06:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A6F2F0C70;
	Sun,  8 Feb 2026 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoVboQFJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B56F1F0991
	for <linux-rdma@vger.kernel.org>; Sun,  8 Feb 2026 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770533614; cv=none; b=pYUYnEtSitJIV7BLK+ab7wI08b0BB1r7lEBdvU5V4j2CU6faWgcqdDb9CzzxHjiCbmxd6r2J9nEqsiwQDxiLLD2dE7QXmoMTsk8sQc/vCCx6gxIKTU70NUzUwD24ceGhwyxmzbtevU+jvibA30Sa345vydPfS0lclt9xYLzbR7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770533614; c=relaxed/simple;
	bh=7DM5HJM1GWEqz1nrqd2Sgvh7kqpf+4XKF17R0w1uPls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1SOLDdSK8AtWJGXas8JT9kVDbB34JavWwfUMlVUp+JeA1whK/rDt+RTfT/9WzSFV6bNQF0YfrLSNREBiValtKROoe8H+CYh+A+mLC/uLL5fQQzHUZImzl9g0pvmRl2NaEstvOV+nNH0HPbiV6BNAgQVsHkSKdIE135x+BbJW0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoVboQFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F88C4CEF7;
	Sun,  8 Feb 2026 06:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770533614;
	bh=7DM5HJM1GWEqz1nrqd2Sgvh7kqpf+4XKF17R0w1uPls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aoVboQFJfwFdZXZzmq/5Ykdcw4h/XtWVuXzqjHwxd1tDUTRKvQV1uIt4vhZXL0chz
	 yAtxbK15csfJTU01PPZ1LTru7D/sRVUrgia6OHI6AYyidtNdyhWfzOth4Ss77gU2J8
	 PlBSa3+sFw7QOhGr74wIT7ztlVcOPS1ef5lkBoRrM763/LppEwhxXeaRC1YUCnP099
	 V1KF/r37dntAlk8NIS7wf5t6cKHcorOJsvz4b5zncr9rS1V5v/bQtUowPvItxkK5l7
	 1QzvNQloLGQMAEFKDkbDUJdHN0W+bhCmyBJSQkNm11QPrCWMWAfvNnhPD217axg4QU
	 olyvnC+5bH3bQ==
Date: Sun, 8 Feb 2026 08:53:28 +0200
From: Leon Romanovsky <leon@kernel.org>
To: yunje shin <yjshin0438@gmail.com>
Cc: jgg@ziepe.ca, ioerts@kookmin.ac.kr, joonkyoj@yonsei.ac.kr,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/umad: Reject negative data_len in ib_umad_write
Message-ID: <20260208065328.GA12887@unreal>
References: <20260203100628.1215408-1-ioerts@kookmin.ac.kr>
 <177029600846.954009.5373952829243937545.b4-ty@kernel.org>
 <CAMX6_QFeVW=ZgyLT_07GeEbn443osvaPa6XUWFeqztFRmfUEmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMX6_QFeVW=ZgyLT_07GeEbn443osvaPa6XUWFeqztFRmfUEmg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16676-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A1E41080AF
X-Rspamd-Action: no action

On Sun, Feb 08, 2026 at 03:00:41PM +0900, yunje shin wrote:
> I noticed I missed the Cc: stable tag. Should this fix be backported
> to stable trees as well?

1. We (the RDMA maintainers) almost always remove stable@ tags from
   submitted patches. We prefer to reserve those tags for cases that
   truly warrant them, where we can take the extra step of preparing a
   proper backport.

2. Patches that include a Fixes line are automatically considered for
   stable@ inclusion by the AUTOSEL tool used by the stable maintainers.

Thanks

> 
> Thanks, YunJe Shin
> 
> On Thu, Feb 5, 2026 at 9:53 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> >
> > On Tue, 03 Feb 2026 19:06:21 +0900, YunJe Shin wrote:
> > > ib_umad_write computes data_len from user-controlled count and the
> > > MAD header sizes. With a mismatched user MAD header size and RMPP
> > > header length, data_len can become negative and reach ib_create_send_mad().
> > > This can make the padding calculation exceed the segment size and trigger
> > > an out-of-bounds memset in alloc_send_rmpp_list().
> > >
> > > Add an explicit check to reject negative data_len before creating the
> > > send buffer.
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/1] RDMA/umad: Reject negative data_len in ib_umad_write
> >       https://git.kernel.org/rdma/rdma/c/5551b02fdbfd85
> >
> > Best regards,
> > --
> > Leon Romanovsky <leon@kernel.org>
> >
> 

