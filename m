Return-Path: <linux-rdma+bounces-16069-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHM7KZyeeGn4rQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16069-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 12:16:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3DC9375D
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 12:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3F493004DEA
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 11:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DC030E828;
	Tue, 27 Jan 2026 11:16:42 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C10A30C366
	for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769512602; cv=none; b=Tn2D8p9IeUkXygkxqBV7KwhCx+nneIcC3P7okfoaZk0f1oIlFuV6NLA0YGdqouMvO1SIXFIlRTNjbl2rZ6Mmmc7tRv43JN59D4avE/CT/uq03FAc3AY3k9nlASoI7WnY0B7JSQZ+7fkFgX4V7zVQAQwRGbjgY86xYX+9quxpNcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769512602; c=relaxed/simple;
	bh=5LigbZBUhyRrm6RrON4tQ6DQXC2YTLahgBenfoMHUt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kexHG1X0lxYmoaSeuvJXpO7q0VKut02Qr6jqeLmI4AhXgT4iRXaqGLcSHuzu0c033D4cBArbUNvXaxA1rhqoYDNtzuXk0sQSBg8wtVQfHZliNnxAsh+Uqb45RtxhGFMPj5UanT19u851HUYg7CANYqACFOrUfsSm3YBJB0wJWUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60RBExx0070443;
	Tue, 27 Jan 2026 20:14:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60RBExg5070439
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 27 Jan 2026 20:14:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <21d63279-79a2-47aa-b305-30a55b8f40f4@I-love.SAKURA.ne.jp>
Date: Tue, 27 Jan 2026 20:14:58 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/core: Fix stale RoCE GIDs during netdev events at
 registration
To: Jiri Pirko <jiri@resnulli.us>, linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca, leon@kernel.org, msanalla@nvidia.com, maorg@nvidia.com,
        parav@nvidia.com, mbloch@nvidia.com, markzhang@nvidia.com,
        marco.crivellari@suse.com, roman.gushchin@linux.dev,
        wangliang74@huawei.com, yanjun.zhu@linux.dev
References: <20260127093839.126291-1-jiri@resnulli.us>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260127093839.126291-1-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav304.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16069-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-rdma@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,I-love.SAKURA.ne.jp:mid,syzkaller.appspot.com:url,appspotmail.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A3DC9375D
X-Rspamd-Action: no action

On 2026/01/27 18:38, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> RoCE GID entries become stale when netdev properties change during the
> IB device registration window. This is reproducible with a udev rule
> that sets a MAC address when a VF netdev appears:
> 
>   ACTION=="add", SUBSYSTEM=="net", KERNEL=="eth4", \
>     RUN+="/sbin/ip link set eth4 address 88:22:33:44:55:66"
> 
> After VF creation, show_gids displays GIDs derived from the original
> random MAC rather than the configured one.
> 
> The root cause is a race between netdev event processing and device
> registration:
> 
>   CPU 0 (driver)                    CPU 1 (udev/workqueue)
>   ──────────────                    ──────────────────────
>   ib_register_device()
>     ib_cache_setup_one()
>       gid_table_setup_one()
>         _gid_table_setup_one()
>           ← GID table allocated
>         rdma_roce_rescan_device()
>           ← GIDs populated with
>             OLD MAC
>                                     ip link set eth4 addr NEW_MAC
>                                     NETDEV_CHANGEADDR queued
>                                     netdevice_event_work_handler()
>                                       ib_enum_all_roce_netdevs()
>                                         ← Iterates DEVICE_REGISTERED
>                                         ← Device NOT marked yet, SKIP!
>     enable_device_and_get()
>       xa_set_mark(DEVICE_REGISTERED)
>           ← Too late, event was lost
> 
> The netdev event handler uses ib_enum_all_roce_netdevs() which only
> iterates devices marked DEVICE_REGISTERED. However, this mark is set
> late in the registration process, after the GID cache is already
> populated. Events arriving in this window are silently dropped.
> 
> Fix this by introducing a new xarray mark DEVICE_GID_UPDATES that is
> set immediately after the GID table is allocated and initialized. Use
> the new mark in ib_enum_all_roce_netdevs() function to iterate devices
> instead of DEVICE_REGISTERED.
> 
> This is safe because:
> - After _gid_table_setup_one(), all required structures exist (port_data,
>   immutable, cache.gid)
> - The GID table mutex serializes concurrent access between the initial
>   rescan and event handlers
> - Event handlers correctly update stale GIDs even when racing with rescan
> - The mark is cleared in ib_cache_cleanup_one() before teardown
> 
> This also fixes similar races for IP address events (inetaddr_event,
> inet6addr_event) which use the same enumeration path.
> 
> Fixes: 0df91bb67334 ("RDMA/devices: Use xarray to store the client_data")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

I was thinking making the NETDEV_UNREGISTER event handler valid until
wait_for_completion(&device->unreg_completion) in disable_device() returns
( https://lkml.kernel.org/r/b4a09ad8-97cc-4fe1-b02a-6192248694a8@I-love.SAKURA.ne.jp ).

Since your patch includes what I was trying to address, you can add

Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84

lines.


