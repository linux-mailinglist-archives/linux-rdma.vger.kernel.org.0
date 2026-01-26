Return-Path: <linux-rdma+bounces-16035-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNfMJzrMd2mxlQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16035-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 21:19:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D142F8CF9D
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 21:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74B0B3005331
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 20:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571582D5408;
	Mon, 26 Jan 2026 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJ2INJty"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B41A2D47F1
	for <linux-rdma@vger.kernel.org>; Mon, 26 Jan 2026 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769458742; cv=none; b=BRrJYk8SeRUI7zo3VuPT0b6Y0pEOX6Vj4ZcHiujgzct/hJ1NtfcRasMNftxrSYo3e5zSdMSOEMHM2Zrbf3/2ureAPolvuqV0vUAVXrFtBxGRwFk8JV10iQj9I282+FB5P+jdKNnbSb3PAdtgzqa1GPRFegw6YZ+aOWhmXFpFakE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769458742; c=relaxed/simple;
	bh=hsGtzCA9LTMLweuiHyIhBFOkHTWvJyIYs4/OoQPKlIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mALq1hZAbc6LpsjEKGltyysalKOK/zyGgdrDwy0OQJibA0O0oh7zMYxv4qlUh9g0PoB5eDccSNkCoeZzoytXmuUzF2I+C+64y99iCUh0aNNI2bDssKEM/qEcHvmcVxTCalv0iPwaxiUpFfn0KRYPfZKPzsAFhB+3sucUGMvc61s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJ2INJty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF13C116C6;
	Mon, 26 Jan 2026 20:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769458741;
	bh=hsGtzCA9LTMLweuiHyIhBFOkHTWvJyIYs4/OoQPKlIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SJ2INJty5Y1+peWVq9tunyfL+8YTMUpBcKtQNE74i1jgxpdtL3ZF1Qbhg/YYCAlT1
	 HMEShMzsk9QK15Sx4bZpgpUgRZD8PoxCB2PNK8pbKGl8OAYlZwyxgwfx4Xv3I8phdI
	 xWw2jIbj4X9gGWmuWI4pN+8vmcgidM7GOYWptsI0/6swZAhqmOKS6VgRvTLMQoe8ts
	 OWlxALmXae61vcH3yQAD56TxrqWF7ijab5wkkbrf77Vqt6rIIq7ZO74m0yB/m6N3Nq
	 NQTDrxAHCRYFY2V6un1kqjLBBb1VyrHJzXxV0NmQQSGNEsO1PZtKDxvP4evGG/YNvP
	 CL4vR+nilGnRw==
Date: Mon, 26 Jan 2026 22:18:57 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-rext 0/4] RDMA/bnxt_re: Add QP rate limit support
Message-ID: <20260126201857.GP13967@unreal>
References: <20260116091808.2028633-1-kalesh-anakkur.purayil@broadcom.com>
 <CAH-L+nNFR8broz0i6ddQPrGL38AO1ZVaSRdXe9AcEafT3Sqeaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH-L+nNFR8broz0i6ddQPrGL38AO1ZVaSRdXe9AcEafT3Sqeaw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16035-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D142F8CF9D
X-Rspamd-Action: no action

On Sun, Jan 25, 2026 at 09:47:05AM +0530, Kalesh Anakkur Purayil wrote:
> Hi Leon, Jason,
> 
> A gentle reminder. Could you please review the patch series?

Sorry for the delayed response. The idea and implementation look fine to me.
What is missing is a clear and well-documented definition of the semantics
of QP rate limiting for RC QPs.

How should RDMA_READ or small RDMA_REQ packets be treated? Are response
packets included in the rate limit as well? It must be documented in
man pages.

Thanks

> 
> On Fri, Jan 16, 2026 at 2:43 PM Kalesh AP
> <kalesh-anakkur.purayil@broadcom.com> wrote:
> >
> > Hi,
> >
> > This patchset supports QP rate limit in the bnxt_re driver.
> >
> > Broadcom P7 devices supports setting the rate limit while changing
> > RC QP state from INIT to RTR, RTR to RTS and RTS to RTS. Or, once
> > the QP is transitioned to RTR or RTS state.
> >
> > First patch adds stack support for rate limit for RC QPs.
> >
> > Second patch adds support for QP rate limiting in the bnxt_re driver.
> >
> > Third patch adds support to report packet pacing capabilities in the
> > query_device.
> >
> > Forth patch adds support to report QP rate limit in debugfs QP info.
> >
> > The pull request for rdma-core changes are at:
> >
> > https://github.com/linux-rdma/rdma-core/pull/1692
> >
> > Regards,
> > Kalesh
> >
> > Kalesh AP (4):
> >   IB/core: Extend rate limit support for RC QPs
> >   RDMA/bnxt_re: Add support for QP rate limiting
> >   RDMA/bnxt_re: Report packet pacing capabilities when querying device
> >   RDMA/bnxt_re: Report QP rate limit in debugfs
> >
> >  drivers/infiniband/core/verbs.c           |  9 ++++--
> >  drivers/infiniband/hw/bnxt_re/debugfs.c   | 14 ++++++--
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 39 +++++++++++++++++++++--
> >  drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 12 ++++++-
> >  drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  3 ++
> >  drivers/infiniband/hw/bnxt_re/qplib_res.h |  6 ++++
> >  drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  5 +++
> >  drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  2 ++
> >  drivers/infiniband/hw/bnxt_re/roce_hsi.h  | 13 +++++---
> >  include/uapi/rdma/bnxt_re-abi.h           | 16 ++++++++++
> >  10 files changed, 107 insertions(+), 12 deletions(-)
> >
> > --
> > 2.43.5
> >
> 
> 
> -- 
> Regards,
> Kalesh AP



