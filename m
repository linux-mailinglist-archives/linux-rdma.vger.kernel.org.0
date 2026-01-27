Return-Path: <linux-rdma+bounces-16088-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPPAH//qeGmHtwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16088-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 17:42:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F4597E46
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 17:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71651304C38E
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 16:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A9135EDCC;
	Tue, 27 Jan 2026 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ur6vPhi5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9697235FF47
	for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529604; cv=none; b=dCgcAvkbj3BleoCK1bi4UpCFGmErsn2dg0Gv8FQJwG52I4n/vwhXITZCw2Yp/sZg3WzoEY+zn65cOh49uqJc66RJi1B7HIvQHU1VNrYkbIBaUjHJ4paFjKw2VpFEdrCXHFwiSTVr/WcPFMEvmRDfoPfRG7sZ3VfN6+xfkMEcx/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529604; c=relaxed/simple;
	bh=VoVRxOPctJx9Sl9Txsie0vhB5OIxm2OrIfdEk+xmTkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJ+mk0wfF8tZ0+qrfbDr0q0NzSNUQWsPifYfcjXyJssyp0eYiPxXfUpG5rFCvadHsXOMB1FnKkisQ53LQuFiagD4h9ZN7gKXwAbwwPgnpd2xLK+cXKP4jlVJ16OGCyDPZhRO4q/AvU62xLTGtY39utso/b1PpZ6gf5Zx9t3rRV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ur6vPhi5; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-88fcc71dbf4so37721806d6.2
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 08:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769529601; x=1770134401; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GeRjWwa/qFGDjqE4yc4G2OC2vQNqoVBsa6n1QBSh9JI=;
        b=Ur6vPhi5TGRY2bD+HzQXHovN9fZbXgZbcH6/vhQmUPnsmnyG9GvsLWRulEexbxI3aM
         kRTNrAOXCkTB/11hjAbsy8GhrDChBErSGLM5pvVMIJPkJgYHW4rnsLI9sqgq1VCkeUll
         wq+Kes4TZ2XYWOK8QmZsXKcXCQK+68IbT0wb6vF1IoFE1yPGZJLgS2AUtEAMR4uoOnuQ
         XrnQL8FR6GIsF7PtxugzPgea/24325qZCeRe9pMUqODJeErenpfLHmmewivIAT0oYtHf
         xCEmO8nuRxKoqbv5wnhZ5i0Ktc+K2Som0mT8Jbw/aKuh6BrK007fz5BGC+wIo7xSBCd0
         fgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769529601; x=1770134401;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GeRjWwa/qFGDjqE4yc4G2OC2vQNqoVBsa6n1QBSh9JI=;
        b=XF96BiIdyAvGmS643tqvKpMcyLKo3P+Q53cuUMt77O3kIe8Y6NFL7Nb3taVgxY+sD3
         sw31TKEvXXm5OySlT2m5WWQfxIOOTSUlQN4q8e5P33UzmASIHTxvzwEn+bX/sj5IcrbL
         QwZVV3eZVJu/E5e3luJfUKHHj3mbU4U7H0zejPcVafVYmBbFi3aTuy3VI8yeQ1dTZCyo
         hGeRkcJUZrvD9Aund10zwM2ITL7cDrXuNppkZszLjXzhVucxMFq2gFDQ/sN2FFsUtbMK
         N9/1CWG0QMtH+/DcYJBDzipOiPU4RE9FQ6KfMxHk8OohawngoHdxE14biVW8Fqk+xC2w
         6YrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjkw2NkjS/j1jU+8JdugVzXsy3MueP9u90oHMIKI7QuNjZ+3N6P2/7kAU847JULH6UR35oDZMsriDy@vger.kernel.org
X-Gm-Message-State: AOJu0YwcxKkvMgQK5jsu3wcVIa/AH+nhKYEP1EKCay9+2H1qMwJULSe/
	cNhFZ61mf2/S8BKQDs2+n/RG97rN2JzOIHoTwVQbF+R5RuGsFHCoxNrJu1I/0KwTcas=
X-Gm-Gg: AZuq6aLAHdgqVbSu8PlDTPcuHfMM1rNGxA0CjYaozzVW8cJ/8EHV1ojNCHimLeqnGdu
	PNuojf13UYcqRRsU4qJohZkuU08V5TZNL8ykN/vbIkb1y5wDJmXXPpJieq/iYHYWMHTWRD1VuIq
	239gzj6WJwQea/VRdK+Bl4oz8Y2rCHHN981MAWBi8wF7qcUdqrklvCG2kS09aRN3+xHOu5tG/3f
	GgU/UbsDQkbz1pyMNu+63C991GN4dItK6I8t+2Rw4ByLeuYp2Z4fMqSVZQTB7BQKy0to4FOJS01
	FGHyiIdUPWoo650AAk59Vz2dVXVvk4cGerAWK7d9XoHozk84RvJzVA1YvUKKnUkDrgHxn/Ae1HO
	sErZlVOA+0Ojh6bv7EtraPtVDrK239uTYKxWSvgnh3JngeaOqbd7vOkgktJjjBF0qSEhHwVgbFY
	/UUQ5iy3qiXJ+LWOYnwmbmmLPGmoKC2E8I+odxKNOMv4ScbH7LuWiU7x4tsWeWmgankWQ=
X-Received: by 2002:ad4:5cad:0:b0:892:6f04:50bc with SMTP id 6a1803df08f44-894cc7cecdfmr31317406d6.3.1769529601326;
        Tue, 27 Jan 2026 08:00:01 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8949dcf5c5asm98799596d6.36.2026.01.27.08.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 08:00:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vklU0-00000009595-1RnA;
	Tue, 27 Jan 2026 12:00:00 -0400
Date: Tue, 27 Jan 2026 12:00:00 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-rdma@vger.kernel.org,
	leon@kernel.org, msanalla@nvidia.com, maorg@nvidia.com,
	parav@nvidia.com, mbloch@nvidia.com, markzhang@nvidia.com,
	marco.crivellari@suse.com, roman.gushchin@linux.dev,
	wangliang74@huawei.com, yanjun.zhu@linux.dev
Subject: Re: [PATCH] RDMA/core: Fix stale RoCE GIDs during netdev events at
 registration
Message-ID: <20260127160000.GG1641016@ziepe.ca>
References: <20260127093839.126291-1-jiri@resnulli.us>
 <21d63279-79a2-47aa-b305-30a55b8f40f4@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21d63279-79a2-47aa-b305-30a55b8f40f4@I-love.SAKURA.ne.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16088-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: B1F4597E46
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 08:14:58PM +0900, Tetsuo Handa wrote:
> On 2026/01/27 18:38, Jiri Pirko wrote:
> > From: Jiri Pirko <jiri@nvidia.com>
> > 
> > RoCE GID entries become stale when netdev properties change during the
> > IB device registration window. This is reproducible with a udev rule
> > that sets a MAC address when a VF netdev appears:
> > 
> >   ACTION=="add", SUBSYSTEM=="net", KERNEL=="eth4", \
> >     RUN+="/sbin/ip link set eth4 address 88:22:33:44:55:66"
> > 
> > After VF creation, show_gids displays GIDs derived from the original
> > random MAC rather than the configured one.
> > 
> > The root cause is a race between netdev event processing and device
> > registration:
> > 
> >   CPU 0 (driver)                    CPU 1 (udev/workqueue)
> >   ──────────────                    ──────────────────────
> >   ib_register_device()
> >     ib_cache_setup_one()
> >       gid_table_setup_one()
> >         _gid_table_setup_one()
> >           ← GID table allocated
> >         rdma_roce_rescan_device()
> >           ← GIDs populated with
> >             OLD MAC
> >                                     ip link set eth4 addr NEW_MAC
> >                                     NETDEV_CHANGEADDR queued
> >                                     netdevice_event_work_handler()
> >                                       ib_enum_all_roce_netdevs()
> >                                         ← Iterates DEVICE_REGISTERED
> >                                         ← Device NOT marked yet, SKIP!
> >     enable_device_and_get()
> >       xa_set_mark(DEVICE_REGISTERED)
> >           ← Too late, event was lost
> > 
> > The netdev event handler uses ib_enum_all_roce_netdevs() which only
> > iterates devices marked DEVICE_REGISTERED. However, this mark is set
> > late in the registration process, after the GID cache is already
> > populated. Events arriving in this window are silently dropped.
> > 
> > Fix this by introducing a new xarray mark DEVICE_GID_UPDATES that is
> > set immediately after the GID table is allocated and initialized. Use
> > the new mark in ib_enum_all_roce_netdevs() function to iterate devices
> > instead of DEVICE_REGISTERED.
> > 
> > This is safe because:
> > - After _gid_table_setup_one(), all required structures exist (port_data,
> >   immutable, cache.gid)
> > - The GID table mutex serializes concurrent access between the initial
> >   rescan and event handlers
> > - Event handlers correctly update stale GIDs even when racing with rescan
> > - The mark is cleared in ib_cache_cleanup_one() before teardown
> > 
> > This also fixes similar races for IP address events (inetaddr_event,
> > inet6addr_event) which use the same enumeration path.
> > 
> > Fixes: 0df91bb67334 ("RDMA/devices: Use xarray to store the client_data")
> > Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> 
> I was thinking making the NETDEV_UNREGISTER event handler valid until
> wait_for_completion(&device->unreg_completion) in disable_device() returns
> ( https://lkml.kernel.org/r/b4a09ad8-97cc-4fe1-b02a-6192248694a8@I-love.SAKURA.ne.jp ).
> 
> Since your patch includes what I was trying to address, you can add
> 
> Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
> 
> lines.

Can we feed it to syzkaller please and see if it does actually clear
it's repo? That particular bug already has 5 patches claiming to fix
it.

It has become some kind of catch all of all kinds of refcounting errors

[  247.188486][ T6052] unregister_netdevice: waiting for vcan0 to become free. Usage count = 2

Does this actually change the refcounting around that could fix that?
Looked like no?

Jason

