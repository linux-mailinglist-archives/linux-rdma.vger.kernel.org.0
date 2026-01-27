Return-Path: <linux-rdma+bounces-16071-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGuiCI+oeGl9rwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16071-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 12:59:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EB293EEE
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 12:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37075302DF73
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 11:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEA534B676;
	Tue, 27 Jan 2026 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZI3p0MJh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7907B346760
	for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769515141; cv=none; b=ZO+HMRKg+NbpSkvHOlX1Ms/G1MbQmk4Q8VmZSVi1/CMdBJZncc6v9Jt3xKunRPEzB9o4UGOVeol0OYcmSDllneA8JprW5EJQS/eJB0JBT8r6GwxyMbETLclbwRw4sAV03ZBQcA9+sinpIcGZqji0SY0F5EaE19BUukp2J8778Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769515141; c=relaxed/simple;
	bh=yVoJowMfVNjV5nDcrSsPVfO8Ehp+r084b7ngQJYc4lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYAGmTBMsl4xQ3soX7JM4ljNIjENmI2NIv7oqMuyxqPmbpY0bO28XHz1WaM6o11WTwHSstXh/McKmeMA7WhW1Pz1fbI+qXYCPhupQUtMduaUzbG2MRyXyTcUUie3aNSliCorSF8YJAUlqy5/5sQhA4jc1Y/mVfDrb+yqnYtZgyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ZI3p0MJh; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so3290027f8f.3
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 03:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1769515135; x=1770119935; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D39WDTAfBUowfKT1oFtS/cdz5FxQHP2lFSWek8TsruE=;
        b=ZI3p0MJhYvvYfINtVdcLJtP99qs0TdwBouX0ruLlmioIGP+RyVAph7e/k8SmgHLGPe
         vkfmFVGRd/nujrHZxI/Ff3Cnbm2P1dNuwQIKkeH/Dp5ph510wbuljT3/sOUEceYbE/Rq
         sMipobdWkBGjllTB7XfEsQ7YdtD7qawVgnJXYsDrn6CnRQ/QdbLB09/LqxZ0EFvLoRC8
         rel5QoHk9uaGq7ZqHxByv1+10JqaWcNpvUmGtWSsd0S/3EJ6gBMY0Hp8EXP2XWTwzRzZ
         NVjNEl9/nr7ciFaJF1zsQSgf8AwZDAC6yIrQ95J7UDv8ziF3LYzZ0prVbIu5QyNqD42c
         xzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769515135; x=1770119935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D39WDTAfBUowfKT1oFtS/cdz5FxQHP2lFSWek8TsruE=;
        b=olsf/64INXwVtc/fJ16Fo4yHBHg1HExQgNOv5aD1FrJIcyAeVR+FpB+RUSxgrc1k/R
         +dHe6GNOvVmVf7BXfYxhvtqru1nitdNmDee/spNehgNyrBYtm3ldmX1PzfoDoYspPBO5
         5hsbQG7fE507uh+aocEgX+8p8DNCOzy1xzbvpUJSkAJMzczful5NBhKznQzHC5ii3s08
         lUl5uhYXP+TmqAHHoc5wpG8ljSgNiYSwgmMFvcXd5ui6F+cxza6cqeu1K67zpst0QGRP
         RYLISyCJ6scFQC61/XieLxHNVeLoBMyUCMiBLz7XcFvEa2ITiYJ/c1LoUUCn4IKVGe2u
         ApFQ==
X-Gm-Message-State: AOJu0YwyLLAsngbBgSRhvDJqs1AMBFeXDOX2hMlm+NBb8lUmAoeXWxnx
	rzPgfVojnnbnZFg8/5Nr3+3df2ENtH3gRtLdKSIlXPldcDriXkAG6TPHCbM3uLOlEOc=
X-Gm-Gg: AZuq6aKEjOMaS3F1VMU3nHC/4cWIBMRt61dkQuTtItwEv3gysW0JuWokTXW7V6sSZW2
	/STej05SixRcPwf9SBWf3h12jLe3ywR8fb7O0dCAu+fQnblqAQmQE7FcNsaXoj0TdOFFZy/yrAI
	MhKI3AljOETKg5X41Qe6r00eabIHjs1Z6sKus8rt7NRyE27XIQ/9ZJwMNv6ZsQTG9+2UxZw2oAN
	anBokSGhlZJa800N98bkmbzo6Igt7SuDgJaeh8UfKaWdbYt7Tixu207vUmdbhz0QDH0JxU1gpkm
	ZqzRMdh1hMmhATZUTYrHX62Bz4WFXnhUOXj8lSfqopyi2QcTcYfEo94WcmaXQ9qJ+bRIWbpfS9v
	3gODDLXHkfiIV7RzjrpE/Kyjb97Ku98IfBr1nsS7LD0/GXlqXZELPmcj3VWnSjfVrGPBGV/g8ZO
	6PDuUuwHXQQLSTDhsUpq4HVPDwVxzueVvWYw==
X-Received: by 2002:a5d:5226:0:b0:435:dbbe:1130 with SMTP id ffacd0b85a97d-435dd02e24amr1857937f8f.11.1769515134369;
        Tue, 27 Jan 2026 03:58:54 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24bedsm36158361f8f.17.2026.01.27.03.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 03:58:53 -0800 (PST)
Date: Tue, 27 Jan 2026 12:58:51 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, leon@kernel.org, 
	msanalla@nvidia.com, maorg@nvidia.com, parav@nvidia.com, mbloch@nvidia.com, 
	markzhang@nvidia.com, marco.crivellari@suse.com, roman.gushchin@linux.dev, 
	wangliang74@huawei.com, yanjun.zhu@linux.dev
Subject: Re: [PATCH] RDMA/core: Fix stale RoCE GIDs during netdev events at
 registration
Message-ID: <hdcjzzjamllb4pxlewkj7mwcapom26qicxezztwiq4ltd2gn6x@ualpeuraud6u>
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
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16071-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,appspotmail.com:email,i-love.sakura.ne.jp:email,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 15EB293EEE
X-Rspamd-Action: no action

Tue, Jan 27, 2026 at 12:14:58PM +0100, penguin-kernel@I-love.SAKURA.ne.jp wrote:
>On 2026/01/27 18:38, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> RoCE GID entries become stale when netdev properties change during the
>> IB device registration window. This is reproducible with a udev rule
>> that sets a MAC address when a VF netdev appears:
>> 
>>   ACTION=="add", SUBSYSTEM=="net", KERNEL=="eth4", \
>>     RUN+="/sbin/ip link set eth4 address 88:22:33:44:55:66"
>> 
>> After VF creation, show_gids displays GIDs derived from the original
>> random MAC rather than the configured one.
>> 
>> The root cause is a race between netdev event processing and device
>> registration:
>> 
>>   CPU 0 (driver)                    CPU 1 (udev/workqueue)
>>   ──────────────                    ──────────────────────
>>   ib_register_device()
>>     ib_cache_setup_one()
>>       gid_table_setup_one()
>>         _gid_table_setup_one()
>>           ← GID table allocated
>>         rdma_roce_rescan_device()
>>           ← GIDs populated with
>>             OLD MAC
>>                                     ip link set eth4 addr NEW_MAC
>>                                     NETDEV_CHANGEADDR queued
>>                                     netdevice_event_work_handler()
>>                                       ib_enum_all_roce_netdevs()
>>                                         ← Iterates DEVICE_REGISTERED
>>                                         ← Device NOT marked yet, SKIP!
>>     enable_device_and_get()
>>       xa_set_mark(DEVICE_REGISTERED)
>>           ← Too late, event was lost
>> 
>> The netdev event handler uses ib_enum_all_roce_netdevs() which only
>> iterates devices marked DEVICE_REGISTERED. However, this mark is set
>> late in the registration process, after the GID cache is already
>> populated. Events arriving in this window are silently dropped.
>> 
>> Fix this by introducing a new xarray mark DEVICE_GID_UPDATES that is
>> set immediately after the GID table is allocated and initialized. Use
>> the new mark in ib_enum_all_roce_netdevs() function to iterate devices
>> instead of DEVICE_REGISTERED.
>> 
>> This is safe because:
>> - After _gid_table_setup_one(), all required structures exist (port_data,
>>   immutable, cache.gid)
>> - The GID table mutex serializes concurrent access between the initial
>>   rescan and event handlers
>> - Event handlers correctly update stale GIDs even when racing with rescan
>> - The mark is cleared in ib_cache_cleanup_one() before teardown
>> 
>> This also fixes similar races for IP address events (inetaddr_event,
>> inet6addr_event) which use the same enumeration path.
>> 
>> Fixes: 0df91bb67334 ("RDMA/devices: Use xarray to store the client_data")
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>
>I was thinking making the NETDEV_UNREGISTER event handler valid until
>wait_for_completion(&device->unreg_completion) in disable_device() returns
>( https://lkml.kernel.org/r/b4a09ad8-97cc-4fe1-b02a-6192248694a8@I-love.SAKURA.ne.jp ).
>
>Since your patch includes what I was trying to address, you can add
>
>Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84

Indeed, looks like this fixes the issue you pointed out as well.
Jason, should I re-post or can you take the tags above during apply?

Thanks!


