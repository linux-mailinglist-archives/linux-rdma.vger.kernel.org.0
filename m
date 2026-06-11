Return-Path: <linux-rdma+bounces-22124-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rc0wC0naKmqXyAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22124-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 17:54:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 909E46733C6
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 17:54:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SnwA76P4;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22124-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22124-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86D5B30160FE
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 15:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1072834BA5A;
	Thu, 11 Jun 2026 15:54:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5AE3B3BFC;
	Thu, 11 Jun 2026 15:54:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193284; cv=none; b=FWdmUTDNQHhu0T3yAFTN/kzlD1JEMl8M9WsWA0is1GX9PIqpGlEtKIp0tOvYH+AarK4zsOaofMwolJ+u6+sYMVglfpkhuKgw88isNkNV6RYQ+Ak6XyI4T0fIceIZR6T7/e467OrF9mVwAiCDoBx/FtfqFS4IeQbgby47ZfTTofE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193284; c=relaxed/simple;
	bh=0d6ab74yd5kEzFzfTr1wPyxvkvewk0FCwPFPD3Na4h4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCetR5WyhtDA9HpjNjxYbQ1lEwL2Yiw/tuSpusowMpwl5V5jmA+A+F6GIZxmCN3Wl8xX8qlM2eCuVlx43yJucnUMmFH8AJtyC+SloxHLY8bZ2eDgeyEyAMS+BJnPjN+oMWhD/azEqY5J+PiFzmrBN9u4fx4RYn6YGWhsJb4jcD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnwA76P4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8B71F00893;
	Thu, 11 Jun 2026 15:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781193282;
	bh=4TQhWa4URtxn6HrzLpdqS4kgU4581lhO4yl/qFTymkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SnwA76P4YZBcMd0y+S6MCgLpL3brG1sTKA34JB15OSIS6LCb1xEyXCNV0rSksVBmw
	 0DHxvZ9dGH4p9JXJJFmATayu40QWvAPiaX+cq44LnT4dqyEtFDO5QMjIfUHiVMu2OK
	 76xiQFVia85GAv+hDVXk3h5Fi2r9oT/LDzCAIBeDXZOycd70P36uD9YnUNTLDoCzd1
	 vIOxHZJHiEsPbQ+2l3bc4A7fzBW7gUubR7jBiX23LHJSROmYZK3vPjS4hBMFXSYMyV
	 5zUp/6lGmdwGeJ3WhRHLkEoQKg0ptvhaJsXJYuvr28sg2KetnREhKbwKNfMMJFpfOn
	 CaUaM5qwlEgmw==
Date: Thu, 11 Jun 2026 08:54:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Jiri Pirko <jiri@resnulli.us>, Simon Horman
 <horms@kernel.org>, Sunil Goutham <sgoutham@marvell.com>, Linu Cherian
 <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, hariprasad
 <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Bharat
 Bhushan <bbhushan2@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Ethan
 Nelson-Moore <enelsonmoore@gmail.com>, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next V3 2/7] netdevsim: Register devlink after
 device init
Message-ID: <20260611085440.4fe36bf2@kernel.org>
In-Reply-To: <eb525345-da07-414c-9d05-7e00e3eb472f@nvidia.com>
References: <20260605181030.3486619-1-mbloch@nvidia.com>
	<20260605181030.3486619-3-mbloch@nvidia.com>
	<20260610165053.7c91f331@kernel.org>
	<eb525345-da07-414c-9d05-7e00e3eb472f@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22124-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:mbloch@nvidia.com,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jiri@resnulli.us,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,redhat.com,lunn.ch,davemloft.net,lwn.net,linuxfoundation.org,resnulli.us,kernel.org,marvell.com,nvidia.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 909E46733C6

On Thu, 11 Jun 2026 09:02:03 +0300 Mark Bloch wrote:
> On 11/06/2026 2:50, Jakub Kicinski wrote:
> > On Fri, 5 Jun 2026 21:10:25 +0300 Mark Bloch wrote:  
> >> devl_register() makes the devlink instance visible to userspace. A later
> >> patch also makes registration the point where devlink core may call
> >> eswitch_mode_set() to apply a boot-time default eswitch mode.
> >>
> >> Move netdevsim registration after all objects (resources, params, regions,
> >> traps, debugfs etc) are initialized, and after the initial eswitch mode is
> >> set to legacy.
> >>
> >> Move devl_unregister() to the beginning of nsim_drv_remove(), before those
> >> devlink objects are torn down. This keeps devlink register/unregister as
> >> the notification barrier and makes the later object teardown paths run
> >> after devlink is no longer registered, so they do not emit their own
> >> netlink DEL notifications.  
> > 
> > This is going backwards. At some point someone from nVidia thought that
> > we can order our way out of locking, so mlx5 is likely ordered this way,
> > but this must not be required, or in any way normalized.
> > We (syzbot) quickly discovered that it doesn't cover all corner cases.
> > devl_lock() is exposed specifically to allow the driver to finish
> > whatever init it needs without letting user space invoke callbacks, yet.
> > Almost (?) all driver callbacks hold devl_lock(), so maybe the devlink
> > instance is "visible" to user space but that should not matter.  
> 
> Let me clarify.
> 
> No locking is changed here, and I don't want to make register/unregister
> ordering a substitute for devl_lock().
> 
> The only requirement I have for this series is that devl_register() is called
> only once the driver is ready for devlink core to call eswitch_mode_set().
> That follows from the earlier direction to have the core apply the default
> mode from devl_register() instead of adding an explicit driver call.

This is exactly what I'm objecting to. AFAIU we are trading off
explicit call to get the default value for an implicit behavior
depending on order of calls. We want to optimize for how easy it
is to get the API wrong, not for LoC.

If we don't have a clean way to implement this without driver
changes let's add the explicit API to get the default value.
If driver doesn't call it schedule a work to go via the callback
once devl_lock() is dropped. That way drivers which care can optimize
themselves by reading the default value upfront. Drivers which don't 
care will work correctly, and there's no API call order trap.

Not ideal, but isn't that best we can do here?
I still have flashbacks of the fallout from the call ordering games, 
we have too many drivers to keep this straight...

> So if the objection is to the commit message wording, I can fix that and drop
> the "notification barrier" language.
> 
> For unregister, I can probably leave the old ordering as-is. I moved it only
> to mirror the register path, which felt cleaner, but it is not required for
> the default-mode change and as the lock is held I see no issue with doing
> that.

