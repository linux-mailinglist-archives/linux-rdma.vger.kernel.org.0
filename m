Return-Path: <linux-rdma+bounces-16149-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAeYH2n+eWm71QEAu9opvQ
	(envelope-from <linux-rdma+bounces-16149-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 13:17:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4099A1150
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 13:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BF203013AA1
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C089F2356BE;
	Wed, 28 Jan 2026 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGeThiCq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834A71F9ECB
	for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769602657; cv=none; b=OPuxhpdhiqYwVkrby6F9Ie/TsrJo4Z77wrBScU/K3vw57d5IHZNAcDc8A55Xec6nlMm5jkWlHf4G8m9wXtT3kSgp46cuFLZqWel2CYymZIsDuuhwnfkqJzRkh86XgXDcEsNGF3SkkuZrAEDezFFPBvHKV7BzFpC5m2DCnz4+Z0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769602657; c=relaxed/simple;
	bh=XwRWvbTfrRCItB6xvMDdfc2plkD+TmiOZMPk1CyxWu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVL8m+z/nfBJMphGvyFfZ+PRlTXMz8dmgx8Y9IPgM5myyH2UfaQHplCYLS8QTAWdMnBf8RnqWgyjjcT6GSIskhQkcIUKy2JAoeuOtAwhzUdEUTC0LDcotPo9QoXmFVkt+fTcosu7RFgT1pWOaskl9BOmP7kspQxigxU0uE5cE6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGeThiCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82FAC4CEF1;
	Wed, 28 Jan 2026 12:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769602657;
	bh=XwRWvbTfrRCItB6xvMDdfc2plkD+TmiOZMPk1CyxWu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hGeThiCqBnCHTAycF9tA/ln7j60HzRqYKWwXNd6deNEkGilB3aPqWucvAVxjF6JAj
	 2Po5Axjiis2pcR7qxKQsl6rm8aK1p1QgvU7L77uwtgwVSs7Y/lS0MmGlvd+2770JI2
	 MJbPEN6pnbg/ZhHZz7SA968qoLbYoQgrdh93bWzn/9CbJIp8riM+q0jw9zESHpZ2FA
	 btFv7PRWJZHS3DTotwJ4pLJVb/w3w0aT27UpYV7nEh71C7+j8/qr6CSrhVg9fv41ns
	 P5CxC20PBlHIDPmCZgsskH0HlvJwDnRArzjzPpg5PI4/aB6ysWfiiU6pJKNp3UM7l1
	 TSGLplCPM572Q==
Date: Wed, 28 Jan 2026 14:17:33 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
	jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH rdma-rext 0/4] RDMA/bnxt_re: Add QP rate limit support
Message-ID: <20260128121733.GA40916@unreal>
References: <20260116091808.2028633-1-kalesh-anakkur.purayil@broadcom.com>
 <CAH-L+nNFR8broz0i6ddQPrGL38AO1ZVaSRdXe9AcEafT3Sqeaw@mail.gmail.com>
 <20260126201857.GP13967@unreal>
 <CA+sbYW3dLsVqXcaG9xYdh-YRpdf6-ZjrMKRCBnapMY+gFzoA2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sbYW3dLsVqXcaG9xYdh-YRpdf6-ZjrMKRCBnapMY+gFzoA2w@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16149-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4099A1150
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 12:33:57PM +0530, Selvin Xavier wrote:
> On Tue, Jan 27, 2026 at 1:49 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Sun, Jan 25, 2026 at 09:47:05AM +0530, Kalesh Anakkur Purayil wrote:
> > > Hi Leon, Jason,
> > >
> > > A gentle reminder. Could you please review the patch series?
> >
> > Sorry for the delayed response. The idea and implementation look fine to me.
> Thanks you for your response.
> > What is missing is a clear and well-documented definition of the semantics
> > of QP rate limiting for RC QPs.
> 
> man page of ibv_modify_qp doesn't have much information about rate limit
> 
>  struct ibv_qp_attr {
> ...
>           uint32_t                rate_limit;             /* Rate
> limit in kbps for packet pacing */
>        };
> 
> 
> attr_mask:IBV_QP_RATE_LIMIT  Set rate_limit
> 
> This man page contains only the required field for each transition and
> doesn't mention about the optional flags. Do you want us to add a
> section for the QP rate limit in the notes?

I would expect the changes to be in https://github.com/linux-rdma/rdma-core/blob/master/libibverbs/man/ibv_modify_qp_rate_limit.3
and your driver implements .modify_qp_rate_limit() callback in rdma-core.

> 
> >
> > How should RDMA_READ or small RDMA_REQ packets be treated? Are response
> > packets included in the rate limit as well? It must be documented in
> > man pages.
> 
> All transmitted packets (including rdma_read request and other request
> packets) will be part of rate limiting setting for the QP. In our
> implementation, the ack packets are not part of the rate limiting of
> the normal transmit path. READ data response will be rate limited at
> the peer side, if the rate limit is configured on the peer side.
> 
> We have another question. Existing implementation of IB_QP_RATE_LIMIT
> is applicable only for raw ethernet QP. With this change, we will
> start supporting for RC QPs also. So mlx driver can also get this
> request for RC QPs, but it will silently ignored as the QP type is not
> Raw ethernet QP. Should we fail the request instead?

We should return something to users, since it would be surprising if a
policy-related feature simply failed without notice.

The tricky part is deciding how to expose this so users can anticipate it
up front, especially since we're dealing with a generic verb.

Thanks

> 
> Thanks,
> Selvin Xavier
> >
> > Thanks
> >
> > >
> > > On Fri, Jan 16, 2026 at 2:43 PM Kalesh AP
> > > <kalesh-anakkur.purayil@broadcom.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > This patchset supports QP rate limit in the bnxt_re driver.
> > > >
> > > > Broadcom P7 devices supports setting the rate limit while changing
> > > > RC QP state from INIT to RTR, RTR to RTS and RTS to RTS. Or, once
> > > > the QP is transitioned to RTR or RTS state.
> > > >
> > > > First patch adds stack support for rate limit for RC QPs.
> > > >
> > > > Second patch adds support for QP rate limiting in the bnxt_re driver.
> > > >
> > > > Third patch adds support to report packet pacing capabilities in the
> > > > query_device.
> > > >
> > > > Forth patch adds support to report QP rate limit in debugfs QP info.
> > > >
> > > > The pull request for rdma-core changes are at:
> > > >
> > > > https://github.com/linux-rdma/rdma-core/pull/1692
> > > >
> > > > Regards,
> > > > Kalesh
> > > >
> > > > Kalesh AP (4):
> > > >   IB/core: Extend rate limit support for RC QPs
> > > >   RDMA/bnxt_re: Add support for QP rate limiting
> > > >   RDMA/bnxt_re: Report packet pacing capabilities when querying device
> > > >   RDMA/bnxt_re: Report QP rate limit in debugfs
> > > >
> > > >  drivers/infiniband/core/verbs.c           |  9 ++++--
> > > >  drivers/infiniband/hw/bnxt_re/debugfs.c   | 14 ++++++--
> > > >  drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 39 +++++++++++++++++++++--
> > > >  drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 12 ++++++-
> > > >  drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  3 ++
> > > >  drivers/infiniband/hw/bnxt_re/qplib_res.h |  6 ++++
> > > >  drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  5 +++
> > > >  drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  2 ++
> > > >  drivers/infiniband/hw/bnxt_re/roce_hsi.h  | 13 +++++---
> > > >  include/uapi/rdma/bnxt_re-abi.h           | 16 ++++++++++
> > > >  10 files changed, 107 insertions(+), 12 deletions(-)
> > > >
> > > > --
> > > > 2.43.5
> > > >
> > >
> > >
> > > --
> > > Regards,
> > > Kalesh AP
> >
> >
> >



