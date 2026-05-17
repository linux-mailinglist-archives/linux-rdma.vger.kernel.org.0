Return-Path: <linux-rdma+bounces-20853-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNGKHl/kCWo6twQAu9opvQ
	(envelope-from <linux-rdma+bounces-20853-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 17:53:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA15F5622A8
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 17:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EED6F30068D7
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 15:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5906D3B47C3;
	Sun, 17 May 2026 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SteUFoOO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C94C30C372
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779033179; cv=none; b=Qpi3ozvbC01ZNvIk4uq7748kgzprYSSKqZzmalgBXj2pGGySH4Tf6QQgW8PIaSEEMboPMVQ9drArYJB6nRDB1BqYfxA20HfMOIoCjBiKZKoDsIXDsNTCPkE03b67A/zzS26kPWH/XLtt4frdrSesIicqhT4mbtp10pfE/m3DrOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779033179; c=relaxed/simple;
	bh=oDwkjqbe4IG0UWg89B+m2q8BCdrdlz/mQkFzYvZ1OQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gA1WAYYM5ob8yO7pVXJ6+mOkzZDMXKmgGY9CyREtLIBfvL8onhDoGW/dYS4z5RX+/1fckohtnJnVD58qg3RoR/zIlFgpSb6DFJaaTznqwGLOZaxTJrFzMlV+xybsZt2Q3tRRNYKD2AUmP24E+YY1BfnrJXTK6yOKKR/ODDTUg2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SteUFoOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2161BC2BCB0;
	Sun, 17 May 2026 15:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779033178;
	bh=oDwkjqbe4IG0UWg89B+m2q8BCdrdlz/mQkFzYvZ1OQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SteUFoOOlDCXLLDdbWs9ykEFee6U1iD3CTbSZeXc2465woSg6AWlIjW0IZMlgkI5f
	 hP285Fz1kApmArsbOs80D68aHCPTbL4LOn95GQQzWBrPt1UA74JzE2qzmD0Pj6tWWg
	 Z+vBDH+LJWXtm1GROAN7lgdrd9eFKK+Qol0XB55t1P0QfbtLZMTIOv7l2IzvcmEBLL
	 i3uj+Jp71+K8B1DjhvurTKiicJr05mRIGfIjajE4lS9HJlqBx+g41m9SBYZ8prf6OD
	 Oh7BN3c76a0NMiPKQcp8+7a6wmaP/ST3VJCTC4KUGoHzygRmn1NwoaBXRi1+J+AXRQ
	 eLskrnQX/Kq0g==
Date: Sun, 17 May 2026 18:52:53 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yonatan Nachum <ynachum@amazon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, mrgolin@amazon.com,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Daniel Kranzdorf <dkkranzd@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Validate SQ depth based on WQE size
Message-ID: <20260517155253.GK33515@unreal>
References: <20260507112110.869212-1-ynachum@amazon.com>
 <20260513173812.GH15586@unreal>
 <20260513192451.GA15167@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
 <20260514162812.GS15586@unreal>
 <20260514204521.GA14420@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260514204521.GA14420@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
X-Rspamd-Queue-Id: EA15F5622A8
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-20853-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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

On Thu, May 14, 2026 at 08:45:21PM +0000, Yonatan Nachum wrote:
> On Thu, May 14, 2026 at 07:28:12PM +0300, Leon Romanovsky wrote:
> > On Wed, May 13, 2026 at 07:24:51PM +0000, Yonatan Nachum wrote:
> > > On Wed, May 13, 2026 at 08:38:12PM +0300, Leon Romanovsky wrote:
> > > > On Thu, May 07, 2026 at 11:21:10AM +0000, Yonatan Nachum wrote:
> > > > > From: Michael Margolin <mrgolin@amazon.com>
> > > > > 
> > > > > Change the SQ depth validation to take into account the SQ WQE size.
> > > > > This is needed since when using 128-byte WQE the max SQ depth is cut in
> > > > > half. On create QP command, userspace provides SQ ring size which is SQ
> > > > > depth X WQE size so we can calculate the requested WQE size in the
> > > > > kernel.
> > > > > 
> > > > > Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
> > > > > Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> > > > > Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> > > > > ---
> > > > >  drivers/infiniband/hw/efa/efa_verbs.c | 39 ++++++++++++++++++---------
> > > > >  1 file changed, 27 insertions(+), 12 deletions(-)
> > > > 
> > > > Please add Fixes line.
> > > > 
> > > > Thanks
> > > 
> > > There is no Fixes tag as this is not a bug fix. The existing validation
> > > works but is overly permissive — it doesn't account for WQE size when
> > > checking max SQ depth. Without it, the device would reject the request
> > > downstream. This patch tightens the validation to fail early in the
> > > kernel.
> > 
> > So why do we need kernel patch after all?
> > 
> > Thanks
> 
> The driver already validates max_send_wr against max_sq_depth — this
> patch just makes that check accurate for the 128-byte WQE case. This
> also gives better error reporting as opposed to device failure.

We seem to be going in circles. You stated that no Fixes tag is needed
and that the previous code behaved correctly. However, as justification
for the change, you described it as providing more accurate and improved
reporting, which effectively sounds like a fix to me.

Thanks

