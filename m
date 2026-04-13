Return-Path: <linux-rdma+bounces-19306-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJLkFHo/3WkubQkAu9opvQ
	(envelope-from <linux-rdma+bounces-19306-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 21:09:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD473F27B3
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 21:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54D483029C1E
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 19:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B990390CA1;
	Mon, 13 Apr 2026 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlvaFh5j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20DF3451B2
	for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776107295; cv=none; b=k24JBxKpeQOMTfHzEzFUNZbRu3ZEGcYhycWsNlXsZdCeb8plOR/lHwkmhg3+LnnFjp2/6F5R3AEWzEGGg3iGqBwgCcBKefRLV235yJIUpLLmlXPRwctRLlSrgnUBaqkMPU4/5Qjj2nWxoq9a1GXub800ZCmEgcVxBzBq8xefCJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776107295; c=relaxed/simple;
	bh=raiePaRSf3ETEyHMcuTEmGMiWW75llq/uiow0HYVMMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9TZrxBNb0cwd3zvhga3pzAledmmcmf+pQPkMIVuN4bJu0JgOu0HtbDcU7Mi82K9m8ZQBWddtQ08lC+63JmCVS/uC1cCcBzuFNRz5CWqY0bGrODrD6CHxeH7/+ojyf0kL4ZerdXBtBJC4ys7GmhXKo55mNxpBNcVF7atpbSc7sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlvaFh5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25B1C2BCB0;
	Mon, 13 Apr 2026 19:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776107295;
	bh=raiePaRSf3ETEyHMcuTEmGMiWW75llq/uiow0HYVMMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SlvaFh5jz1UDreVgtEOd11yw3QhayE7n8Ah+wiB1jBQb+HeOZFxsDRmq4bUoJcvJ/
	 n9AFjXiyKP2o72Bdt5xHMYHDzoVcncYESfyvALkXjpNL7lRbNWaWyD50QZCqd5202x
	 czyhb0hTWwwzmS+pTQBfyfYxZXrlJU0PspnABnW9vZ+3aCs1qGeFZbBQtiHA9KNWC4
	 aR66QJwWiKIEp8OSfMhI+orZ3hiacavOaYFrvZMjg8KGGmlqxxfL1G5QbU2Qql3AEe
	 PNtPS84EYtf+eXVtVGQsxnAJdMTQEdaybT8OJ3wEaZHDGG59i5GtEE4zRAUNyNG/HI
	 52dXguEZG6fUQ==
Date: Mon, 13 Apr 2026 22:08:09 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yonatan Nachum <ynachum@amazon.com>
Cc: linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/efa: Add checksum support for admin
 responses
Message-ID: <20260413190809.GO21470@unreal>
References: <20260409074905.3126023-1-ynachum@amazon.com>
 <20260413083515.GF21470@unreal>
 <20260413092130.GA18233@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260413092130.GA18233@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-19306-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CAD473F27B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 09:21:30AM +0000, Yonatan Nachum wrote:
> On Mon, Apr 13, 2026 at 11:35:15AM +0300, Leon Romanovsky wrote:
> > On Thu, Apr 09, 2026 at 07:49:05AM +0000, Yonatan Nachum wrote:
> > > EFA devices added support for CRC16 checksum on admin responses and to
> > > expose it to the driver the API version increased to 0.2. Add a check
> > > for support on device init and if supported validate the checksum on
> > > each admin response the driver receives. If the checksum validation
> > > failed, drop the CQE.
> > > 
> > > Add the CRC16 module to Kconfig to have the in-tree dependency.
> > > 
> > > Reviewed-by: Firas Jahjah <firasj@amazon.com>
> > > Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> > > Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> > > ---
> > >  drivers/infiniband/hw/efa/Kconfig             |  3 +-
> > >  .../infiniband/hw/efa/efa_admin_cmds_defs.h   |  3 --
> > >  drivers/infiniband/hw/efa/efa_admin_defs.h    | 15 +++---
> > >  drivers/infiniband/hw/efa/efa_com.c           | 50 ++++++++++++++++---
> > >  drivers/infiniband/hw/efa/efa_com.h           |  4 +-
> > >  5 files changed, 55 insertions(+), 20 deletions(-)
> > 
> > <...>
> > 
> > > -#define EFA_ADMIN_API_VERSION_MAJOR          0
> > > -#define EFA_ADMIN_API_VERSION_MINOR          1
> > 
> > <...>
> > 
> > > +#define EFA_ADMIN_API_VERSION_MAJOR          0
> > > +#define EFA_ADMIN_API_VERSION_MINOR          2
> > 
> > <...>
> > 
> > > @@ -954,16 +990,16 @@ int efa_com_validate_version(struct efa_com_dev *edev)
> > >  		  EFA_GET(&ver, EFA_REGS_VERSION_MAJOR_VERSION),
> > >  		  EFA_GET(&ver, EFA_REGS_VERSION_MINOR_VERSION));
> > >  
> > > -	EFA_SET(&min_ver, EFA_REGS_VERSION_MAJOR_VERSION,
> > > -		EFA_ADMIN_API_VERSION_MAJOR);
> > > -	EFA_SET(&min_ver, EFA_REGS_VERSION_MINOR_VERSION,
> > > -		EFA_ADMIN_API_VERSION_MINOR);
> > > +	EFA_SET(&min_ver, EFA_REGS_VERSION_MAJOR_VERSION, EFA_MIN_ADMIN_API_VERSION_MAJOR);
> > > +	EFA_SET(&min_ver, EFA_REGS_VERSION_MINOR_VERSION, EFA_MIN_ADMIN_API_VERSION_MINOR);
> > >  	if (ver < min_ver) {
> > >  		ibdev_err(edev->efa_dev,
> > >  			  "EFA version is lower than the minimal version the driver supports\n");
> > >  		return -EOPNOTSUPP;
> > >  	}
> > 
> > This change breaks all backward compatibility. Are you certain that every EFA
> > device is running the correct firmware, including those currently deployed and
> > used by customers? If not, they will stop to work after random kernel update.
> > 
> > Thanks
> 
> The minimum required API version for the driver to load remains 0.1
> (EFA_MIN_ADMIN_API_VERSION_MINOR). The CRC16 checksum validation is only
> enabled when the device reports API version >= 0.2. Devices running
> firmware 0.1 will continue to work — they just won't have checksum
> validation on admin responses.

Ahh, yes, I missed the addition of _MIN_ in the name.

Thanks

> 

