Return-Path: <linux-rdma+bounces-16093-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nJBgAGUreWkyvwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16093-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 22:17:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E4A9AA74
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 22:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C2513005319
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 21:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F412B126C02;
	Tue, 27 Jan 2026 21:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="phJA20SM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A741CF8B
	for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769548637; cv=none; b=tXQRgl337L3YckOeEi+8TFoGy2O0vD/Cz88CoCMsLF991DH3Ky2mS9DBbEwr4ZEga/G06azADrrAc9Phjs154SjNelkj/ehMOjyNtbrJNF4WmuL5Q0vgSUW1I2uODTkxWNtjCaLWA1yT+C3+4FEqnm4zpZ9CR20l9U1MjA2uf8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769548637; c=relaxed/simple;
	bh=5elH9a+v6aGBm7ddVnfQlqAZKdR8HoK+AcIoobh2fzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdO8j4szXXm64JFS69OxKEzkFZ0FxXl5tJbh1WR/qMk4en7FHQj8FCXzyM4PveLbS7LkqwZsBqZj+fmyPWHoKJwvoZ2p89MIDkW2zXcrn9aSpnLuWIngaGt9DPH8vx82kxw/fHo+jkbxE7yZN2gn9zPB3q1Oud5qOpGOd3jxrrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=phJA20SM; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <05b40f3c-0d21-411a-b61a-156246482327@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769548633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1IdrB1HugcUUWFFDVbeMH8YBeu5h/q4kUSouGgQV3JU=;
	b=phJA20SMQrJde8RQxRFIeRXnnY6bzYHaKg581CY8HagXo7gy329YJkFJydExGWy7hbEqls
	Pu4EvmDRuqhiVRxCXKrRtoBcISAEsXhYrQcjlzQOxxBYicoCx/l5BZjabAzYgbqL66iRsZ
	d+awq8ALw0zGN6+AzIwzWWXzGeI+S40=
Date: Tue, 27 Jan 2026 13:17:06 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/core: Fix stale RoCE GIDs during netdev events at
 registration
To: Jason Gunthorpe <jgg@ziepe.ca>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-rdma@vger.kernel.org,
 leon@kernel.org, msanalla@nvidia.com, maorg@nvidia.com, parav@nvidia.com,
 mbloch@nvidia.com, markzhang@nvidia.com, marco.crivellari@suse.com,
 roman.gushchin@linux.dev, wangliang74@huawei.com
References: <20260127093839.126291-1-jiri@resnulli.us>
 <21d63279-79a2-47aa-b305-30a55b8f40f4@I-love.SAKURA.ne.jp>
 <20260127160000.GG1641016@ziepe.ca>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260127160000.GG1641016@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16093-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,syzkaller.appspot.com:url,linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: F2E4A9AA74
X-Rspamd-Action: no action


On 1/27/26 8:00 AM, Jason Gunthorpe wrote:
> On Tue, Jan 27, 2026 at 08:14:58PM +0900, Tetsuo Handa wrote:
>> On 2026/01/27 18:38, Jiri Pirko wrote:
>>> From: Jiri Pirko <jiri@nvidia.com>
>>>
>>> RoCE GID entries become stale when netdev properties change during the
>>> IB device registration window. This is reproducible with a udev rule
>>> that sets a MAC address when a VF netdev appears:
>>>
>>>    ACTION=="add", SUBSYSTEM=="net", KERNEL=="eth4", \
>>>      RUN+="/sbin/ip link set eth4 address 88:22:33:44:55:66"
>>>
>>> After VF creation, show_gids displays GIDs derived from the original
>>> random MAC rather than the configured one.
>>>
>>> The root cause is a race between netdev event processing and device
>>> registration:
>>>
>>>    CPU 0 (driver)                    CPU 1 (udev/workqueue)
>>>    ──────────────                    ──────────────────────
>>>    ib_register_device()
>>>      ib_cache_setup_one()
>>>        gid_table_setup_one()
>>>          _gid_table_setup_one()
>>>            ← GID table allocated
>>>          rdma_roce_rescan_device()
>>>            ← GIDs populated with
>>>              OLD MAC
>>>                                      ip link set eth4 addr NEW_MAC
>>>                                      NETDEV_CHANGEADDR queued
>>>                                      netdevice_event_work_handler()
>>>                                        ib_enum_all_roce_netdevs()
>>>                                          ← Iterates DEVICE_REGISTERED
>>>                                          ← Device NOT marked yet, SKIP!
>>>      enable_device_and_get()
>>>        xa_set_mark(DEVICE_REGISTERED)
>>>            ← Too late, event was lost
>>>
>>> The netdev event handler uses ib_enum_all_roce_netdevs() which only
>>> iterates devices marked DEVICE_REGISTERED. However, this mark is set
>>> late in the registration process, after the GID cache is already
>>> populated. Events arriving in this window are silently dropped.
>>>
>>> Fix this by introducing a new xarray mark DEVICE_GID_UPDATES that is
>>> set immediately after the GID table is allocated and initialized. Use
>>> the new mark in ib_enum_all_roce_netdevs() function to iterate devices
>>> instead of DEVICE_REGISTERED.
>>>
>>> This is safe because:
>>> - After _gid_table_setup_one(), all required structures exist (port_data,
>>>    immutable, cache.gid)
>>> - The GID table mutex serializes concurrent access between the initial
>>>    rescan and event handlers
>>> - Event handlers correctly update stale GIDs even when racing with rescan
>>> - The mark is cleared in ib_cache_cleanup_one() before teardown
>>>
>>> This also fixes similar races for IP address events (inetaddr_event,
>>> inet6addr_event) which use the same enumeration path.
>>>
>>> Fixes: 0df91bb67334 ("RDMA/devices: Use xarray to store the client_data")
>>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> I was thinking making the NETDEV_UNREGISTER event handler valid until
>> wait_for_completion(&device->unreg_completion) in disable_device() returns
>> ( https://lkml.kernel.org/r/b4a09ad8-97cc-4fe1-b02a-6192248694a8@I-love.SAKURA.ne.jp ).
>>
>> Since your patch includes what I was trying to address, you can add
>>
>> Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
>>
>> lines.
> Can we feed it to syzkaller please and see if it does actually clear
> it's repo? That particular bug already has 5 patches claiming to fix
> it.


#syz test: repository_link branch

The above command will make syzkaller test your commit.

BTW, your commit should be the topmost commit.


Thanks,

Zhu Yanjun

>
> It has become some kind of catch all of all kinds of refcounting errors
>
> [  247.188486][ T6052] unregister_netdevice: waiting for vcan0 to become free. Usage count = 2
>
> Does this actually change the refcounting around that could fix that?
> Looked like no?
>
> Jason

