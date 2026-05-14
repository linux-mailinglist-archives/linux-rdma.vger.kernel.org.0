Return-Path: <linux-rdma+bounces-20663-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMzSGBl0BWpuXQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20663-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 09:04:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D39453EAE1
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 09:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4940301B718
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 07:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2159C3AF650;
	Thu, 14 May 2026 07:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OcqEbTMl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8283A4275;
	Thu, 14 May 2026 07:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778742293; cv=none; b=JCTtCPrx1kMDmJLsNgl8iv9AqO0ZcIfa5vv35XrWPgLcw5UTRLBm0j9PU5lIqEjCSoOZ3E3qaC73n6tNItnxIXlEmhvHoWJ65AX6vXdOIDR70Fa/ZuKfMPaEu8lMrIWCe4M3xebSAcSQOAFZbfwaZWG3I1ouzf3/+OyugDuV3YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778742293; c=relaxed/simple;
	bh=MnMUCQahNq7XdESoELwHe1zp1wOSV7M9N3l86rTZvBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDHnYxPr6lzQRQFKRA2cK2DrQn2M1/pHxb5qwB0DTCMuJ5KGlWZWcFnK/2+EhNLKEUvqJP2WmgRlT4xL8/hzpm0aNBiIOKHN3eBJhg74pbRTLpE/Ls5FSlZS9CY5+UP38ywtXOr/CkfuM97eQk3cbsbVX5tICQfSAVlBeT3stDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OcqEbTMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F64AC2BCB7;
	Thu, 14 May 2026 07:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778742293;
	bh=MnMUCQahNq7XdESoELwHe1zp1wOSV7M9N3l86rTZvBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OcqEbTMlYwZqwiVxDTRSg2MQJURjEzZEVLWhQEcZovbj8KZseBgDHXeBf5zZsoeOl
	 oJuBsxibAny7SgWyipU3812OM6qJO9Wg8tb9lmmYVSlR22dGwx1W7lreJoAuRhOmga
	 eEuOHEf9Fi96DrFLyaX+ifGKpY4UYshzQiUUPzMU=
Date: Thu, 14 May 2026 09:04:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Joyner <eric.joyner@amd.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH net-next 3/4] RDMA/ionic: Add debugfs support
Message-ID: <2026051440-devourer-appendix-4326@gregkh>
References: <20260506041935.1061-1-eric.joyner@amd.com>
 <20260506041935.1061-4-eric.joyner@amd.com>
 <20260513072113.GE15586@unreal>
 <20260513172314.35e71e7b@kernel.org>
 <20260514060048.GK15586@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260514060048.GK15586@unreal>
X-Rspamd-Queue-Id: 0D39453EAE1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20663-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 09:00:48AM +0300, Leon Romanovsky wrote:
> On Wed, May 13, 2026 at 05:23:14PM -0700, Jakub Kicinski wrote:
> > On Wed, 13 May 2026 10:21:13 +0300 Leon Romanovsky wrote:
> > > 3. The patch is too large and exposes too many details that should be
> > >    gathered through the FW (fwctl).
> > 
> > Why? What's wrong with debugfs? Much easier for people to access.
> 
> There is nothing inherently wrong with debugfs. You can see recently
> accepted debugfs patches from hns [1].
> 
> The issue here is what data is being dumped through debugfs, and in what
> quantity. From a quick look, ionic_dev_info_show() appears to print
> raw data coming straight from the FW.
> 
> In my view, debugfs should expose in‑kernel structures that are shaped
> and controlled by the kernel itself. IMHO it is not the right place to
> debug FW state. There can always be exceptions, of course, but in this
> case the driver is effectively dumping everything from pds_core/FW in
> the RDMA layer.

debugfs is for anything you want, there is nothing wrong with doing
this in debugfs, in fact, it's preferred.  Don't spread debug info out
into other areas, that makes it harder for admins and users to properly
secure things from stuff they don't want users to have access to.

thanks,

greg k-h

