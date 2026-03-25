Return-Path: <linux-rdma+bounces-18595-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDg7F55aw2m1qQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18595-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 04:46:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED54731F32A
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 04:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F49A3095C47
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 03:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB632DCF72;
	Wed, 25 Mar 2026 03:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZH5/BwS6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293108248B;
	Wed, 25 Mar 2026 03:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774410283; cv=none; b=n/i6bC/UAjnfEsN9ocIB05dvDciTecGPs2q5YIcVoCwbpTifJTIIrm0iWigvI68Lt8xpxhqg1CoF/9S+EwghJyyORwMkeMvO2ZyKlm7D5iWYKVWsN+xCY2qQOLmd8GzCmph/tw0c6wMRIb/E6VAVvKE+HQfEePVnkQzqXd1homk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774410283; c=relaxed/simple;
	bh=gQK6J5IvA9RmrkZN+cbxNmFla6H107ZP9bVcDvKPjRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=apCwlfJMrUPwfK/yuMp3Wb3Gxt4MbnsEuZBrFl9i99bCAIlIfgtCh71bhSeARuoRkvP53eFkV4y1HRJUUShz1metvnxlpKvn2vRcBj3CFCi+8i53B0iVsx9mfBQGZWN2Xbgsjy8YrgMsvQTMaLjI7zXoj3Z09VV35cf4xAwlf0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZH5/BwS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B295C2BCB0;
	Wed, 25 Mar 2026 03:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774410282;
	bh=gQK6J5IvA9RmrkZN+cbxNmFla6H107ZP9bVcDvKPjRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZH5/BwS61g4MXioBvBtBh9BzuX2edP0Y5CNv8b7utbnLqKrt2Ig6FM1yb4aKlGtut
	 H9/iJjjgJUKN+oYGIXfB106Cm4tMLptjuvkKcjmmeeMgI06minn5KC9OivyKstv8T/
	 56u8jKtsopr7dN1CmbeRk9mGks61tQx6DNAZsG5vhWfD6vFFf5rPA0Fzb4+VxiSRwm
	 ebUMaIeNpkbK7NRte7tgB1IjAyHiLu6z0CD/MOcfr0zRTopQ3iPJIaPkBeanBVXmTp
	 /ahpZBDlBOHnGZrr7ICiuCAc6N7vajPt0ed93vZyxXubarOU6YqqqFSmQUkL6GJ0+A
	 t4pIxs1A5yedg==
Date: Tue, 24 Mar 2026 20:44:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 andrew+netdev@lunn.ch, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
 johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
 dtatulea@nvidia.com, mohsin.bashr@gmail.com, jacob.e.keller@intel.com,
 willemb@google.com, skhawaja@google.com, bestswngs@gmail.com,
 aleksandr.loktionov@intel.com, kees@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kselftest@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH net-next v3 03/13] net: introduce ndo_set_rx_mode_async
 and dev_rx_mode_work
Message-ID: <20260324204440.1752423d@kernel.org>
In-Reply-To: <acMU93XN02PHmAGi@mini-arch>
References: <20260320012501.2033548-1-sdf@fomichev.me>
	<20260320012501.2033548-4-sdf@fomichev.me>
	<20260323162003.0d155055@kernel.org>
	<acLUMN1BYkIVyOk8@mini-arch>
	<20260324142114.216fcb01@kernel.org>
	<acMU93XN02PHmAGi@mini-arch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18595-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[fomichev.me,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED54731F32A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026 15:49:27 -0700 Stanislav Fomichev wrote:
> > > Not sure why cancel+release, maybe you're thinking about the unregister
> > > path? This is rtnl_unlock -> netdev_run_todo -> __rtnl_unlock + some
> > > extras.
> > > 
> > > And the flush is here to plumb the addresses to the real devices
> > > before we return to the callers. Mostly because of the following
> > > things we have in the tests:
> > > 
> > > # TEST: team cleanup mode lacp                                        [FAIL]
> > > #       macvlan unicast address not found on a slave
> > > 
> > > Can you explain a bit more on the suggestion?  
> > 
> > Oh, I thought it's here for unregister! Feels like it'd be cleaner to
> > add the flush in dev_*c_add() and friends? How hard would it be to
> > identify the callers in atomic context?  
> 
> Not sure we can do it in dev_xc_add because it runs under rtnl :-(
> I currently do flush in netdev_run_todo because that's the place that
> doesn't hold rtnl. Otherwise flush will get stuck because the work
> handler grabs it...

I was thinking of something a'la linkwatch. We can "steal" / "flush"
the pending work inline. I guess linkwatch is a major source of races
over the years...

Does the macvlan + team problem still happens with the current
implementation minus the flush? We are only flushing once so only
pushing the addresses thru one layer of async callbacks.

