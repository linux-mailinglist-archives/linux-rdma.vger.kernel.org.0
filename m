Return-Path: <linux-rdma+bounces-18641-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wiSxHdIcxGmCwgQAu9opvQ
	(envelope-from <linux-rdma+bounces-18641-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 18:35:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BD9329E97
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 18:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8DC57300B5A4
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 17:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317FB4070FA;
	Wed, 25 Mar 2026 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeVKCRrA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFEB40626C
	for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460103; cv=none; b=Hu58ZumO843gL57M6gt0dYoMyWLAgeZStmCl+awRyJpvNIsmUnSyzXBShjshB3h6n3TgAs4vogm8iXsieWOQKcruCx2IqPCJ0bxQkpEmedJ9w64AYfgqS4Dx0xunKfrm+AAyEBH5HFCss3OtMZUZLYMdXN44y7hsO0NSK6tLfhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460103; c=relaxed/simple;
	bh=clM9+UyXrzN9nEW43pJpghdXSx89Puh9hjZlPMWv+hI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSzAZdbEH+uNygyItZyQGBL2u28j5CW4qXAU+gAaXIQya9ivzUKMd8QdrJVDNP64kK5bQSeyGnpI85MsPGFgcAkqUUuipT3kMhnrHs8SbvICsxaLaMpjJd5khb06g6Q3p03KcEIHSV6KBo/DvygZ34Y4Haw2211cLwYE1C5uaec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeVKCRrA; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12a80c36350so105861c88.1
        for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 10:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774460100; x=1775064900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6LvfhXxnMpqu+8Jaxmf8YnU74NbO72vJex03sq4AEB4=;
        b=QeVKCRrA7qO9pYLUdqR1gtTQMaq7b4+caHjFbI6fiixPD/pY+8y9ybm+LLCw4NWDI1
         XfEz5wUmjp4l9ZuMW9af0hIoo1FVD6Y7tstrV8I54xOZq8kGQ9vNkj9R1lDTItwMnX9X
         wXWMrD5zYRWX5O27k7mJHEEyMswoz9/BOe4NiBhGEaICvInXumrp4CB3YFFzunUkrGIi
         gB5RRVGgnF2Rzoves4aXDT1zLz22i13dQFZkYFvwxZoAxjWi4uopQp6k0JfS7Ldbarrt
         jcCdVGVP2mkC3dfDJ98SoAq+UbXDFqXKdLxUa5NOWlgAyUXPOguSpEzAvYfOMCcjuCLy
         iZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774460100; x=1775064900;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LvfhXxnMpqu+8Jaxmf8YnU74NbO72vJex03sq4AEB4=;
        b=iPMT87LqMgujiDPU4hPAOEom1H131AMDMyHjQH1vAl0vr7YZ6SHVj5bY3zFkbS9jOS
         zPEuBEQchnT0vIUnnJ1OI2qhD0ZyHauWP2BxPCRB8SgjvDEKDEOaVK9ASvE1gbrKLSHd
         GbjjjwF1HRZOxjj/8TYw3CqtPdCXpctOUW9knNJOnq+6z/4J+9PzWVvfAtrej0dbF4Wb
         7jifRQPtrUqwrRn33XZvndMnp0oKpystO1dWFqa+UtPAqSDjCYO1cTaBFC8He3a1Cltl
         ae3u64AlytX3tyRaTCNSRh+jM0BlDZer4iv768uJx7vC8l+Ck444qd7zLRHFkLFrY5xf
         2qVg==
X-Forwarded-Encrypted: i=1; AJvYcCXmyFSNlj/KK/AnnQaV9L+7g23JImEgpnhqgEoA7sLsXSEF6eFWm5agq9MyVenUn+AetNIErThQJcxp@vger.kernel.org
X-Gm-Message-State: AOJu0YwFZ0Egy7lVxJL2Uek/tGEZ1bn2LRRIvqhaZdodCoVICGVpQTj0
	bXQsC/QpqsnJWH0zX6uaaqLVztNYTyMQxu7cg/ldPoqT/X7bbS0Ce7w=
X-Gm-Gg: ATEYQzziFeVId/GWxGjU1eUr/X5DUvgpRXdRJB1sb0H/iLnyPn3X8eKTKq9hnRgNzim
	rjbcOERQpbjXFmt0mdFXl70x2oMFT1P/12mnFnZUFICbpqJpX0djtvn+rF4Hh66TMRKZ+zXjSm/
	wmVFTCIEmmmNRCzaPlELiIuGfbNBWSiVDrXbJbRVjVqiUm+VUBT6X6Q6A2wmWFdzPsAgO6WOcpc
	P0dfTH/p1bRhSw+P+ENT60X3KewRJ2as652FrFsp6E8b5PG+20GBnS7mLtac77xvpdUOjWoKPuH
	yrkisxPr8YWkAIalHIw2ZntkL5TtLQJOEOF5weC870/yLpKESjSss6gd/xkdCAxcepVRGhSxaq+
	+84cT3d7DadbO5J/rB0rbkmGe2Go+QXX4lhEWLfMsEwLIMVwiC3gq3tf5MKWcCARim4hUXlG0bS
	d6T27Wj46gbvtZWWaGmDN2EBY/pasxLI+3EXMFW0WSPRB/OmnSHBGPpfWbHLANK6T2KZxhgHULs
	p+1y0YkJO0EAJagzQ==
X-Received: by 2002:a05:7301:1e91:b0:2b7:1d38:3596 with SMTP id 5a478bee46e88-2c15d32adfamr1794122eec.4.1774460099374;
        Wed, 25 Mar 2026 10:34:59 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ee01373sm211727eec.26.2026.03.25.10.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 10:34:58 -0700 (PDT)
Date: Wed, 25 Mar 2026 10:34:57 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org, andrew+netdev@lunn.ch,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
	alexanderduyck@fb.com, kernel-team@meta.com,
	johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
	dtatulea@nvidia.com, mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
	bestswngs@gmail.com, aleksandr.loktionov@intel.com, kees@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: Re: [PATCH net-next v3 03/13] net: introduce ndo_set_rx_mode_async
 and dev_rx_mode_work
Message-ID: <acQcwZOXJjPlVpP6@mini-arch>
Mail-Followup-To: Stanislav Fomichev <stfomichev@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
	johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
	dtatulea@nvidia.com, mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
	bestswngs@gmail.com, aleksandr.loktionov@intel.com, kees@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
	leon@kernel.org
References: <20260320012501.2033548-1-sdf@fomichev.me>
 <20260320012501.2033548-4-sdf@fomichev.me>
 <20260323162003.0d155055@kernel.org>
 <acLUMN1BYkIVyOk8@mini-arch>
 <20260324142114.216fcb01@kernel.org>
 <acMU93XN02PHmAGi@mini-arch>
 <20260324204440.1752423d@kernel.org>
 <acP59NM6HZhV9oAe@mini-arch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acP59NM6HZhV9oAe@mini-arch>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18641-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,fomichev.me,vger.kernel.org,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,lists.osuosl.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13BD9329E97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/25, Stanislav Fomichev wrote:
> On 03/24, Jakub Kicinski wrote:
> > On Tue, 24 Mar 2026 15:49:27 -0700 Stanislav Fomichev wrote:
> > > > > Not sure why cancel+release, maybe you're thinking about the unregister
> > > > > path? This is rtnl_unlock -> netdev_run_todo -> __rtnl_unlock + some
> > > > > extras.
> > > > > 
> > > > > And the flush is here to plumb the addresses to the real devices
> > > > > before we return to the callers. Mostly because of the following
> > > > > things we have in the tests:
> > > > > 
> > > > > # TEST: team cleanup mode lacp                                        [FAIL]
> > > > > #       macvlan unicast address not found on a slave
> > > > > 
> > > > > Can you explain a bit more on the suggestion?  
> > > > 
> > > > Oh, I thought it's here for unregister! Feels like it'd be cleaner to
> > > > add the flush in dev_*c_add() and friends? How hard would it be to
> > > > identify the callers in atomic context?  
> > > 
> > > Not sure we can do it in dev_xc_add because it runs under rtnl :-(
> > > I currently do flush in netdev_run_todo because that's the place that
> > > doesn't hold rtnl. Otherwise flush will get stuck because the work
> > > handler grabs it...
> > 
> > I was thinking of something a'la linkwatch. We can "steal" / "flush"
> > the pending work inline. I guess linkwatch is a major source of races
> > over the years...
> >
> > Does the macvlan + team problem still happens with the current
> > implementation minus the flush? We are only flushing once so only
> > pushing the addresses thru one layer of async callbacks.
> 
> Yes, it does happen consistently when I remove the flush. It also
> happens with my internal v4, so I need to look again at what's going on.
> Not sure whether it's my internal regression or I was just sloppy/lucky
> (since you're correct in pointing out that we flush only once).

Hmm, the test does 'team -d' in the background. That's why it works for
bonding, but not the teaming. I'll update the test to a bunch of
'ip' commands instead of starting a daemon..

> Before I went down the workqueue route, I had a simple
> net_todo_list-like approach: `list_add_tail` on enqueue and
> `while(!list_empty) run_work()` on rtnl_unlock. This had a nice properly of
> tracking re-submissions (by checking whether the device's list_head is
> linked into the list or not) and it was relatively easy to do the
> recursive flush. Let me try get back to this approach and see whether
> it solves the flush? Not sure what wq buys us at this point.

Will still look into that, maybe something similar to the linkwatch as
you mentioned.

