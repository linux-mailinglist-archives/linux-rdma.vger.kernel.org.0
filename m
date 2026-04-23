Return-Path: <linux-rdma+bounces-19496-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOdqLkwL6mnFsgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19496-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 14:06:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D5359451C28
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 14:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E15553002515
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 12:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36303EB7F0;
	Thu, 23 Apr 2026 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iyqo87F0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BC13E8684
	for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776945986; cv=none; b=j94r6lcFXyvQyctN6+asr327kWF9fno5RsEstlNv2q4Ky5LIOQvdJqGlhAfpBBI+TmhbZg7Owae2sNYGgTkNtfzzprCwxhuGsXu5EhrD62FOgNNn5KlANXR0/Csv/qYGQbMcQJ6RmmgUvo5GQPU4Uy6I4SsCu2uoPvXlPWg92MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776945986; c=relaxed/simple;
	bh=F9kqgcMOdYs7jwkWr7asOxMnf+uaxTM5gvypZPXR4h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQcOpDwHQ5Q8vCpUeN8X9MSb3aWYq1HlE/CbyP0DFtFMfmG49oEodCz0Gol+umn+qdwJVE6a+MfCYVhHIaESBGilkWlaKlqyW+XQ8JX2POa/YQzGzp+QRpad2kTVt0y7KlvPt3wvLRVGWYwELXOy2ER8U7jeMGmQ/8+UxZSC9NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iyqo87F0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2867C2BCAF;
	Thu, 23 Apr 2026 12:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776945986;
	bh=F9kqgcMOdYs7jwkWr7asOxMnf+uaxTM5gvypZPXR4h8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iyqo87F0R6pa3TY/Q8qoTUNWF12EJgxyXjPcEFTw6tCl4YS2tj0jd4ma0RTGYesdt
	 zTxvPoe+lltZHVt8gY0rvqktx5NVCD5pcKqP9C72v9tHyvGXduBWTbflK66FTW2TbE
	 Ynz3Hyb7BQ/++Bx0/hpevnia/52+YnzM5DQVLaKhzWWpqNESQDIbaxpBzD7Hrz6FFt
	 ZFK2FG+U6gMkcr2Brh8U3HcfqOpG0TPmLoBGsq58lNvwXyBfX/y76wJ/IUjZ0YCOai
	 Hcfg/SnvpieC70odFpC3hTsCA5dUmImGPiJVyPPcw+yU5qQmSm92X2aNIT912DLD7c
	 hrZMgDYnWEsHw==
Date: Thu, 23 Apr 2026 15:06:21 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yonatan Nachum <ynachum@amazon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, mrgolin@amazon.com,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add checksum support for admin
 responses
Message-ID: <20260423120621.GC172828@unreal>
References: <20260409074905.3126023-1-ynachum@amazon.com>
 <20260420065528.GA29767@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420065528.GA29767@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19496-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5359451C28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 06:55:28AM +0000, Yonatan Nachum wrote:
> On Thu, Apr 09, 2026 at 07:49:05AM +0000, Yonatan Nachum wrote:
> > EFA devices added support for CRC16 checksum on admin responses and to
> > expose it to the driver the API version increased to 0.2. Add a check
> > for support on device init and if supported validate the checksum on
> > each admin response the driver receives. If the checksum validation
> > failed, drop the CQE.
> > 
> > Add the CRC16 module to Kconfig to have the in-tree dependency.
> > 
> > Reviewed-by: Firas Jahjah <firasj@amazon.com>
> > Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> > Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> > ---
> >  drivers/infiniband/hw/efa/Kconfig             |  3 +-
> >  .../infiniband/hw/efa/efa_admin_cmds_defs.h   |  3 --
> >  drivers/infiniband/hw/efa/efa_admin_defs.h    | 15 +++---
> >  drivers/infiniband/hw/efa/efa_com.c           | 50 ++++++++++++++++---
> >  drivers/infiniband/hw/efa/efa_com.h           |  4 +-
> >  5 files changed, 55 insertions(+), 20 deletions(-)

<...>

> > 
> 
> Kind reminder.

There is nothing to revisit. We are in the merge window, and we do not
accept new features during this period.

Thanks

> 
> Thanks
> 

