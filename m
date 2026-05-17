Return-Path: <linux-rdma+bounces-20839-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ChfGvOqCWq/kAQAu9opvQ
	(envelope-from <linux-rdma+bounces-20839-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 13:48:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 078EC560D18
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 13:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE0563004637
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 11:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F23134EF0D;
	Sun, 17 May 2026 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5VVYV/0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DB62264C0
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779018480; cv=none; b=DJg1NpqbxUiYNDjet9/jxHsDfJ+txzhvaOlzWZPBDO5uIRwmq3Ns+D4Hp229z5NBt38IDCHoixkztysdr+UmiJAuY4d3HVetvFtE0z/XxUDRO8Mbdef5ZMo8GbeLe5fasJ9Z2kl1eqp68rT/fsXJLAHjGo2tjGdVXDOx4hsNgkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779018480; c=relaxed/simple;
	bh=5kNTiWHA0XrWEPeRW+SGrAZlYF7AUmHzLxOlHCMRRig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDejLLAm3e+PHmsM+rSNQRJIK6wflxOc+1wGmPjNuBCLBBCl1DmO+moRBLB+OPKRe8n5QNP4fCIAwPgmX4WlcFvPJVBPGh+6apiLcMMZ63DR5baZg401lsf51BaM15XADkq9uOe3OkgWSNojaGM835cQJOL2eScsxUxcnXY0GQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5VVYV/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EFBC2BCB0;
	Sun, 17 May 2026 11:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779018479;
	bh=5kNTiWHA0XrWEPeRW+SGrAZlYF7AUmHzLxOlHCMRRig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u5VVYV/04VDEsg29ysAjI9OsndMG3kYCmTgyG2rPZ6+hjuD7Ff0LoaKiaKqONzUhp
	 pRTITdNuzEgDcTZmnHOZ08WtCMiA+jDf8K29jPsTZ8C4S8wBT91kmi/el9wR9zgNwo
	 O6fjV5mgkS0HLt0u0ltAmUYdGe9EdtjsCNHmJBPOzKopcSMYCXVjeHNRqp96UuBGDk
	 QTNslszcvxIQqPAFJBURzvo8zPJ7Ufjv5eK4prFUyUNDnE1h4bEDimaHxVcetjorTn
	 fALmjwN34Q9Wdn4+4sF52BzIsMPL3bhtRZMkh+YzrjRoQsZeGCeaT/IMAdLGkgODHs
	 OT8O0lDG9dy/A==
Date: Sun, 17 May 2026 14:47:55 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-rdma@vger.kernel.org,
	mrgolin@amazon.com, gal.pressman@linux.dev, sleybo@amazon.com,
	parav@nvidia.com, mbloch@nvidia.com, yanjun.zhu@linux.dev,
	marco.crivellari@suse.com, roman.gushchin@linux.dev,
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com,
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com, michaelgur@nvidia.com, shayd@nvidia.com,
	edwards@nvidia.com, sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v4 00/16] RDMA: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <20260517114755.GF33515@unreal>
References: <20260507125231.2950751-1-jiri@resnulli.us>
 <20260512192319.GM7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512192319.GM7702@ziepe.ca>
X-Rspamd-Queue-Id: 078EC560D18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20839-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 04:23:19PM -0300, Jason Gunthorpe wrote:
> On Thu, May 07, 2026 at 02:52:15PM +0200, Jiri Pirko wrote:
> > From: Jiri Pirko <jiri@nvidia.com>
> > 
> > This patchset introduces a generic buffer descriptor infrastructure
> > for passing memory buffers (dma-buf or user VA) to uverbs commands,
> > and wires it up for CQ and QP creation in the uverbs core, efa, mlx5,
> > bnxt_re and mlx4 drivers.
> > 
> > Instead of adding ad-hoc per-buffer UAPI attributes for each new buffer
> > type, each command declares dedicated UVERBS_ATTR_UMEM attributes that
> > carry one buffer descriptor each. Each descriptor specifies a buffer
> > type, covering both VA and dma-buf. A consumption check ensures
> > userspace and driver agree on which attributes are used.
> > 
> > The patchset:
> > 1-2,4. Plumbing: rename ib_umem_get() to ib_umem_get_va() and re-route
> >    it through the new central ib_umem_get(); no behaviour change.
> > 3. Introduces the core buffer descriptor infrastructure and UAPI.
> > 5. Inlines the const attr helpers so ib_core can use them.
> > 6. Factors out CQ buffer umem processing into a helper.
> > 7. Adds the CQ buffer UMEM attribute and driver wrappers.
> > 8-11. Converts efa, mlx5, bnxt_re and mlx4 to use the new CQ helpers,
> >    with drivers taking umem ownership.
> > 12. Removes the legacy umem field from struct ib_cq, now that all
> >    drivers use the new helpers.
> > 13. Adds optional whole-QP, RQ and SQ UMEM attributes to QP creation.
> > 14. Converts mlx5 QP creation to use the new attributes.
> > 15-16. Adds mlx5 driver-namespace UMEM attributes for CQ and QP
> >    doorbell records.
> 
> I think it is OK looking, Leon?

I have a strange feeling that we have too many ib_umem_get_*()
functions. For example ib_umem_get_cq_buf() which doesn't accept
anything CQ specific. Or this general ib_umem_get_attr_or_va().

IMHO, the in-kernel API started to be very messy.

Thanks

> 
> Jason

