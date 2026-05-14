Return-Path: <linux-rdma+bounces-20718-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OWBDjL7BWrFdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20718-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:41:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCA8544D95
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19B4F3024137
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 16:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6778D34251D;
	Thu, 14 May 2026 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIOJnuHo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EE8340260;
	Thu, 14 May 2026 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776834; cv=none; b=i130ua8SHeYWTcPgOCTssg83fzMjNTCxY+AfLdRFqQ6IEoCEs4etOsn3k0TXyeIdrMQP8AJdbrnCAHuIp4ULsgHwncl5ccD3LfADmcgjbtEUknV2MIzrftwlyrN8OlkvfFPxZoe1OvMbP+YcdPe4lCV+fbVVXUfrvgUp2OE8NGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776834; c=relaxed/simple;
	bh=hYwVxdsUNFBpETRiRK2LPmgL5E49ZdizfOForXyTEAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRi0RvX6g97d/y6wgvueVUa6+UMHL9+SZS1Fv0cKO8bxf77ELir4u84rcUQxJr0JU6BuvzLugPnUavdvNFwqrBtPz4Q34dOtCB2ZXq4gY/MczVv4x3BObqqus0JN9xDTZlJK3GsU6ijhtgdLjHrHjqLiLYa6Chw5oInYjU6DT3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIOJnuHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203B8C2BCB3;
	Thu, 14 May 2026 16:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778776833;
	bh=hYwVxdsUNFBpETRiRK2LPmgL5E49ZdizfOForXyTEAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PIOJnuHoC13vgBF2KrCH/GoQshh4Z8ogbdCKCeQQNWfhsw9Z6/wdnWb7ZUUOP4q9O
	 4832VyF8S1nsJvKw8Fd9xiodCFbPMdPigFzOf9NyNFwYGgFk9y3ufzXNpI8wgRnCMt
	 gQdnJ3E16/1k/VKNXe22M5Clv9i1dqlcHPlz2MvYyt3go+80ul50wW0pjLbXYDd0zv
	 Rry4lFv0cUnxlgq1Wg2+1NxKeTzQkvN07B65QHuQXKQrlUMoTxoI1Aj1qGh5R3YSd5
	 B90aMyPTcSVPs3VdFvcwXIYu64dvVCNDGfnmEK5nJ5CwXf0Aro31BU5vCuQWVQmQIx
	 L9lGjqLBx/fYw==
Date: Thu, 14 May 2026 19:40:29 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Allen Hubbe <allen.hubbe@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Eric Joyner <eric.joyner@amd.com>
Subject: Re: [PATCH net-next 0/4] RDMA/net/ionic: Misc updates
Message-ID: <20260514164029.GU15586@unreal>
References: <20260506041935.1061-1-eric.joyner@amd.com>
 <20260506155954.17e984c6@kernel.org>
 <4dc23648-7ec1-b68c-0e1b-282e014e534c@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dc23648-7ec1-b68c-0e1b-282e014e534c@amd.com>
X-Rspamd-Queue-Id: 8BCA8544D95
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20718-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 08:03:09PM +0530, Abhijit Gangurde wrote:
> 
> On 5/7/26 04:29, Jakub Kicinski wrote:
> > On Tue, 5 May 2026 21:19:31 -0700 Eric Joyner wrote:
> > > Other smaller additions add a devlink parameter to the ionic ethernet
> > > driver for enabling and disabling RDMA,
> > My understanding is that the devlink param was expected to change
> > the configuration of the device. IOW user can enable/disable RDMA
> > to save internal device resources. You seem to be purely preventing
> > the auxbus device to be added. So there's nothing gained here compared
> > to simply not loading the RDMA driver. What am I missing?
> You're right that the current implementation controls only the auxiliary bus
> device registration and doesn't reconfigure firmware resource allocation.
> The intent behind this devlink param is to provide per-device granularity
> for enabling/disabling RDMA. In a system with multiple ionic NICs, an
> administrator may want RDMA active on some devices but not others.
> That said, if this per-device control justification is sufficient on its
> own, or if firmware-side changes are a hard requirement for this to be
> acceptable?

I'm confident that the administrator can vibe code an appropriate udev
rule and disable autoprobing for this case.

The real advantage of a devlink knob here is the ability to control the
firmware.

Thanks

> 
> Thanks,
> Abhijit

