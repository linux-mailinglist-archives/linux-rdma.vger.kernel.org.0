Return-Path: <linux-rdma+bounces-20851-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPCmJwLXCWoDsQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20851-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 16:56:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5101A561C30
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 16:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5BBB300F179
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 14:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FA6346E66;
	Sun, 17 May 2026 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iISmRWOl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232A732E729;
	Sun, 17 May 2026 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779029738; cv=none; b=eXXgqh/DrTweSDog6sOnPNvqsLsSG6weiD9ytvu6xvCz2ZdzRem1SnxfQJm/ltMc50oheqvxHt18H47caNQ6ZiT8IvW3RIrekRPhlVudg0Rgb/2eCef6QBzi9uSxto3GrLNKr1utrBmy8dEJwOp06i5YHGYNTMkT8DmDlrrS67M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779029738; c=relaxed/simple;
	bh=/zWBwjk4tprXSvhLsN44/iXDdTQ7L87Sn54TcAmePO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQPe54//Y9zfoyrgm9xxCzDqq7EfnRg/RNphYt98ECd43UvfcS3urFJf0FIO/N1iNHz99JqWVcWCi4wN42nmoLjX43M5EeFzkZ9VEzIkQFp7H+ojhgB8e3u11uQhVlO4sIuS5ekGebZ9bUs4GDnVWLopAH2qy+PDJc8uCggZFTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iISmRWOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4D1C2BCB0;
	Sun, 17 May 2026 14:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779029737;
	bh=/zWBwjk4tprXSvhLsN44/iXDdTQ7L87Sn54TcAmePO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iISmRWOlN0qY67nwiZ6AGb0ivnnM1QBIAFojEqY4HTCxQ9jxYcSpwk5ioi00c+lv6
	 JlTXGH8BqVEIqgjy4JqXH+p5WKQotJLRhwp2xfB3URnBCKCvUC/a/i1sZbrPIIccOC
	 QFhX+DwwL7ntPSxcqWq75mp/HRAs2oFNmZVjj8DIBiIYAQCH1gxz7xyS8Op1R8nRcZ
	 KT973C9t9lkKuYrb2Jky1zFHSuqcWuLM8/8FrACdZmGyQioXl+3q7WO6n7qZsk597b
	 guN3DRffZBgIOB/ZbSEty5LDfed8AsdQplpQ/XB5AjDESqBP4murMzz+AtsCL3EW9A
	 ZTBK6DEOdvKCQ==
Date: Sun, 17 May 2026 17:55:31 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Creeley, Brett" <bcreeley@amd.com>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Allen Hubbe <allen.hubbe@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Eric Joyner <eric.joyner@amd.com>
Subject: Re: [PATCH net-next 0/4] RDMA/net/ionic: Misc updates
Message-ID: <20260517145531.GJ33515@unreal>
References: <20260506041935.1061-1-eric.joyner@amd.com>
 <20260506155954.17e984c6@kernel.org>
 <4dc23648-7ec1-b68c-0e1b-282e014e534c@amd.com>
 <20260514164029.GU15586@unreal>
 <695c2fe7-0a30-408f-b699-b1726e201bdd@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <695c2fe7-0a30-408f-b699-b1726e201bdd@amd.com>
X-Rspamd-Queue-Id: 5101A561C30
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20851-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 10:19:23AM -0700, Creeley, Brett wrote:
> 
> 
> On 5/14/2026 9:40 AM, Leon Romanovsky wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > On Thu, May 14, 2026 at 08:03:09PM +0530, Abhijit Gangurde wrote:
> > > On 5/7/26 04:29, Jakub Kicinski wrote:
> > > > On Tue, 5 May 2026 21:19:31 -0700 Eric Joyner wrote:
> > > > > Other smaller additions add a devlink parameter to the ionic ethernet
> > > > > driver for enabling and disabling RDMA,
> > > > My understanding is that the devlink param was expected to change
> > > > the configuration of the device. IOW user can enable/disable RDMA
> > > > to save internal device resources. You seem to be purely preventing
> > > > the auxbus device to be added. So there's nothing gained here compared
> > > > to simply not loading the RDMA driver. What am I missing?
> > > You're right that the current implementation controls only the auxiliary bus
> > > device registration and doesn't reconfigure firmware resource allocation.
> > > The intent behind this devlink param is to provide per-device granularity
> > > for enabling/disabling RDMA. In a system with multiple ionic NICs, an
> > > administrator may want RDMA active on some devices but not others.
> > > That said, if this per-device control justification is sufficient on its
> > > own, or if firmware-side changes are a hard requirement for this to be
> > > acceptable?
> > I'm confident that the administrator can vibe code an appropriate udev
> > rule and disable autoprobing for this case.
> > 
> > The real advantage of a devlink knob here is the ability to control the
> > firmware.
> > 
> > Thanks
> 
> Based on the documentation in devlink-params.rst, the devlink knob for
> enable_rdma indicates that when enabled the driver will instantiate RDMA
> specific auxiliary device of the devlink device. The documentation doesn't
> state what to do when enable_rdma is disabled, but it seemed like removing
> the auxiliary device provided the opposite behavior of enabled.

There is no practical way to document every possible case. When
`enable_rdma == false`, it indicates that the device has RDMA support
disabled.

Thanks

> 
> If that's not the case, does the documentation need to be updated
> accordingly?
> 
> Thanks,
> 
> Brett
> 
> 
> > 
> > > Thanks,
> > > Abhijit
> 
> 

