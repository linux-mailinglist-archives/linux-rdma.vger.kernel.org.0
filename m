Return-Path: <linux-rdma+bounces-20706-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB81LI74BWqcdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20706-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:30:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F8B544B23
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CB523019CA9
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 16:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080483370F0;
	Thu, 14 May 2026 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaFQShu5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00E930E0EC
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776098; cv=none; b=j06xVyCvViBOXu0POE0lBbI3gxwIjr9zU37/MllplBa3WeBV+kBeS3Y2kDLFUGSb9ml9GL16HdXIkeWmXwSNkdVocZfMnsD1lLhjVQ8hra25Eepzo799n4q193f+SsEYA+reR9UwYt6+lAQ8Na19xeja7NUwT5hGg99Zs7wJP+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776098; c=relaxed/simple;
	bh=UHCQVpWHz/od0BLxWaJEPhynihPU2Yd/BbRXmLTA2ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hs72H18XfZCVSMrmPpVSzoPpmYbjA4y14YJWNI3zT9hwiWpXAhL49CaKQakUNFs9WiEHHtEA7ezU0CdIiDQip8Ik/UjR/9LfJRP2sf2dRZYgEmtp3DLTxq8QjNo8SxZd5Cj8N//4wQIDOaUqpZi2dhsL7uTCMMF79tTEQHMTMoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaFQShu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B075FC2BCB3;
	Thu, 14 May 2026 16:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778776098;
	bh=UHCQVpWHz/od0BLxWaJEPhynihPU2Yd/BbRXmLTA2ZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TaFQShu5IJiwmdEJ/5hcMQ8uC905HJGXsP1K8tkLQwaES1EhslQcNCgGdoKiYLV/G
	 NK25KFxODljCDFrahzRYHn+BMQT4+FET0SE63XEszFb2PObZsWtNAcjer3Z9KdGCy7
	 3B5jeIuWb7h7XZf1ACD1l/NqTq3DuT8xxhGUPWpQB+lB6UcuUSbHXnU0636zK9d0OG
	 pPyvyt5LsfGUOUGIpF5iHBbinh2bV6GC3ttRoQ+A1UDBXre62FHrbBiGznVsGtddGK
	 EBoQI23uIAFxxT+mB847XwAD6DLVl06ufkRiag6TPVoZVXJYGEI31vxfNrKHWZclnA
	 120xUvoe6dOBA==
Date: Thu, 14 May 2026 19:28:12 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yonatan Nachum <ynachum@amazon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, mrgolin@amazon.com,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Daniel Kranzdorf <dkkranzd@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Validate SQ depth based on WQE size
Message-ID: <20260514162812.GS15586@unreal>
References: <20260507112110.869212-1-ynachum@amazon.com>
 <20260513173812.GH15586@unreal>
 <20260513192451.GA15167@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513192451.GA15167@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
X-Rspamd-Queue-Id: 28F8B544B23
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20706-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 07:24:51PM +0000, Yonatan Nachum wrote:
> On Wed, May 13, 2026 at 08:38:12PM +0300, Leon Romanovsky wrote:
> > On Thu, May 07, 2026 at 11:21:10AM +0000, Yonatan Nachum wrote:
> > > From: Michael Margolin <mrgolin@amazon.com>
> > > 
> > > Change the SQ depth validation to take into account the SQ WQE size.
> > > This is needed since when using 128-byte WQE the max SQ depth is cut in
> > > half. On create QP command, userspace provides SQ ring size which is SQ
> > > depth X WQE size so we can calculate the requested WQE size in the
> > > kernel.
> > > 
> > > Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
> > > Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> > > Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> > > ---
> > >  drivers/infiniband/hw/efa/efa_verbs.c | 39 ++++++++++++++++++---------
> > >  1 file changed, 27 insertions(+), 12 deletions(-)
> > 
> > Please add Fixes line.
> > 
> > Thanks
> 
> There is no Fixes tag as this is not a bug fix. The existing validation
> works but is overly permissive — it doesn't account for WQE size when
> checking max SQ depth. Without it, the device would reject the request
> downstream. This patch tightens the validation to fail early in the
> kernel.

So why do we need kernel patch after all?

Thanks

