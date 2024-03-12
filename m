Return-Path: <linux-rdma+bounces-1402-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8568792AD
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 12:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87C17B23929
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 11:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B821D79942;
	Tue, 12 Mar 2024 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zi8nyRYn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9805F78B45
	for <linux-rdma@vger.kernel.org>; Tue, 12 Mar 2024 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710241477; cv=none; b=IM3fjl8cs5tygYF7XYz2b3eyJc4Yg0rtLnGCikodde6saeTwNbClPhkFKsIGlQStPrO9dpDV8Twc1cZi1QLNnkcAknLSHV7TsF4X+8l7nag37gaMrwvyRRCGei60vftSVE9mNe8QzsK7OySm9aYwBGkb4oOGG2OpNGc9lIMdSlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710241477; c=relaxed/simple;
	bh=3HKN8ybYirv7FhreVmtmy9/WnIGNLznc2TukTqZF6HE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bDCoyMRUNwPd/0PEHM+WWsyvcPvnx7TGgA8JtVDfLafukWJx3mCtDPMSTSP5fYv/ohhp3DL4LjN+Wqzrrw8Vm2HG9aAO5CNLJZW5D7diM5GXYFvyGOPT5FFjRntiukxW5Tll5YKScZmJ4gBvzwcNFf+SmJev1wIVoxG4KDEDOyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zi8nyRYn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710241474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yBtMhDxs0nGYQ9YTVeWaVZMCJiu4Hf7h0wkMOH014XM=;
	b=Zi8nyRYnj+sbW/2Zoh0i4JciLFQbbRNIa2brh4S+NZsqKJm9ioef1wa9rfujzYqywDyvCA
	mf/oyMdPN4ZqnNNdZerpc4ZeAhOJNtKdEICoWhv1/pRCZBZ/pcQOUcmN4UxMemNLSlheUP
	VwK6PmEzhs0Ct9D+EmcrNvjho2js7MI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-ZKxmKKaEMFeCBxksAqFWkQ-1; Tue, 12 Mar 2024 07:04:33 -0400
X-MC-Unique: ZKxmKKaEMFeCBxksAqFWkQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-51133766a92so2168200e87.1
        for <linux-rdma@vger.kernel.org>; Tue, 12 Mar 2024 04:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710241471; x=1710846271;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBtMhDxs0nGYQ9YTVeWaVZMCJiu4Hf7h0wkMOH014XM=;
        b=PuEIuhwgrR7Ey50BFHhbIvG42W9btjye5Ia+sbgx6wl92LGH8h8mikXCAjXsZMImye
         OdhuwMDk+F9+4WHQ24Vz4Sg60F0hBkRkcDYSTBuvvsmSG6nvRWJybEw6dQlLNUFsvXQy
         gXJanUtt0V0Eu1YLn76V3ZgV1cx07x3sXZnK+++uEi3x8cpAsGTgLR92EWKi0CoUIOtR
         gmJSOjBMBGNKB20ScxO3yxjHs9iogOuV0dk8gI+St978+iFG6/+xbjJVkKVLKZYuhDij
         Cx4Fiual45Spl0Vi3fvnokZ+dxoUiAYKgOi66I/ZjKUadHFr8pZSunv1arW3JtRdCfpt
         Rc/A==
X-Forwarded-Encrypted: i=1; AJvYcCXLhfFwtJQqWMi/M8sYqKnGdnQHE6cSqyajif9TTuPvHMU/KP+XgFibmA6BZCpW2nOBsnNWFYCpSN6eHf/8ckOo+qasDPqMIPlPkA==
X-Gm-Message-State: AOJu0Yxd3F65b+tPJetzSsLd22JQvQyUvq/uglbUv3Tp4rz/4BS3I/T8
	FWwObVu/V21Q6k+YHoyvSgd5xq41DzKZsSqeoXUXoiCswWgGszNZoZMnYP5nQugkELonEef/XNJ
	VDrGp0x7cSX6Fox6om9kZ+UDBY2RiYtqFv2KcSrrGTfqsa+CCqd//NmT+V9E=
X-Received: by 2002:a2e:9ec6:0:b0:2d3:cd02:6c55 with SMTP id h6-20020a2e9ec6000000b002d3cd026c55mr1130208ljk.2.1710241471560;
        Tue, 12 Mar 2024 04:04:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdeHTmDcvr9I0Q/tXyJS8zQ+Jw9SJ7dqgwbEUGs6KkqzlZYnD8D0fscFQas4aPza58RZy2eA==
X-Received: by 2002:a2e:9ec6:0:b0:2d3:cd02:6c55 with SMTP id h6-20020a2e9ec6000000b002d3cd026c55mr1130189ljk.2.1710241471243;
        Tue, 12 Mar 2024 04:04:31 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-128.dyn.eolo.it. [146.241.226.128])
        by smtp.gmail.com with ESMTPSA id e14-20020a50fb8e000000b00568554e368dsm2280952edq.3.2024.03.12.04.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 04:04:30 -0700 (PDT)
Message-ID: <6bc2bab66d3bc7aebbde92d4f268effe6b62db35.camel@redhat.com>
Subject: Re: [PATCH v5 net 2/2] rds: tcp: Fix use-after-free of net in
 reqsk_timer_handler().
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, syzkaller
 <syzkaller@googlegroups.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Allison
 Henderson <allison.henderson@oracle.com>
Date: Tue, 12 Mar 2024 12:04:29 +0100
In-Reply-To: <20240308200122.64357-3-kuniyu@amazon.com>
References: <20240308200122.64357-1-kuniyu@amazon.com>
	 <20240308200122.64357-3-kuniyu@amazon.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-08 at 12:01 -0800, Kuniyuki Iwashima wrote:
> syzkaller reported a warning of netns tracker [0] followed by KASAN
> splat [1] and another ref tracker warning [1].
>=20
> syzkaller could not find a repro, but in the log, the only suspicious
> sequence was as follows:
>=20
>   18:26:22 executing program 1:
>   r0 =3D socket$inet6_mptcp(0xa, 0x1, 0x106)
>   ...
>   connect$inet6(r0, &(0x7f0000000080)=3D{0xa, 0x4001, 0x0, @loopback}, 0x=
1c) (async)
>=20
> The notable thing here is 0x4001 in connect(), which is RDS_TCP_PORT.
>=20
> So, the scenario would be:
>=20
>   1. unshare(CLONE_NEWNET) creates a per netns tcp listener in
>       rds_tcp_listen_init().
>   2. syz-executor connect()s to it and creates a reqsk.
>   3. syz-executor exit()s immediately.
>   4. netns is dismantled.  [0]
>   5. reqsk timer is fired, and UAF happens while freeing reqsk.  [1]
>   6. listener is freed after RCU grace period.  [2]
>=20
> Basically, reqsk assumes that the listener guarantees netns safety
> until all reqsk timers are expired by holding the listener's refcount.
> However, this was not the case for kernel sockets.
>=20
> Commit 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in
> inet_twsk_purge()") fixed this issue only for per-netns ehash.
>=20
> Let's apply the same fix for the global ehash.
>=20
> [0]:
> ref_tracker: net notrefcnt@0000000065449cc3 has 1/1 users at
>      sk_alloc (./include/net/net_namespace.h:337 net/core/sock.c:2146)
>      inet6_create (net/ipv6/af_inet6.c:192 net/ipv6/af_inet6.c:119)
>      __sock_create (net/socket.c:1572)
>      rds_tcp_listen_init (net/rds/tcp_listen.c:279)
>      rds_tcp_init_net (net/rds/tcp.c:577)
>      ops_init (net/core/net_namespace.c:137)
>      setup_net (net/core/net_namespace.c:340)
>      copy_net_ns (net/core/net_namespace.c:497)
>      create_new_namespaces (kernel/nsproxy.c:110)
>      unshare_nsproxy_namespaces (kernel/nsproxy.c:228 (discriminator 4))
>      ksys_unshare (kernel/fork.c:3429)
>      __x64_sys_unshare (kernel/fork.c:3496)
>      do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83=
)
>      entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
> ...
> WARNING: CPU: 0 PID: 27 at lib/ref_tracker.c:179 ref_tracker_dir_exit (li=
b/ref_tracker.c:179)
>=20
> [1]:
> BUG: KASAN: slab-use-after-free in inet_csk_reqsk_queue_drop (./include/n=
et/inet_hashtables.h:180 net/ipv4/inet_connection_sock.c:952 net/ipv4/inet_=
connection_sock.c:966)
> Read of size 8 at addr ffff88801b370400 by task swapper/0/0
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-=
gd239552ce722-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  <IRQ>
>  dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
>  print_report (mm/kasan/report.c:378 mm/kasan/report.c:488)
>  kasan_report (mm/kasan/report.c:603)
>  inet_csk_reqsk_queue_drop (./include/net/inet_hashtables.h:180 net/ipv4/=
inet_connection_sock.c:952 net/ipv4/inet_connection_sock.c:966)
>  reqsk_timer_handler (net/ipv4/inet_connection_sock.c:979 net/ipv4/inet_c=
onnection_sock.c:1092)
>  call_timer_fn (./arch/x86/include/asm/jump_label.h:27 ./include/linux/ju=
mp_label.h:207 ./include/trace/events/timer.h:127 kernel/time/timer.c:1701)
>  __run_timers.part.0 (kernel/time/timer.c:1752 kernel/time/timer.c:2038)
>  run_timer_softirq (kernel/time/timer.c:2053)
>  __do_softirq (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jum=
p_label.h:207 ./include/trace/events/irq.h:142 kernel/softirq.c:554)
>  irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632 kernel/softirq.c=
:644)
>  sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1076 (discrimin=
ator 14))
>  </IRQ>
>=20
> Allocated by task 258 on cpu 0 at 83.612050s:
>  kasan_save_stack (mm/kasan/common.c:48)
>  kasan_save_track (mm/kasan/common.c:68)
>  __kasan_slab_alloc (mm/kasan/common.c:343)
>  kmem_cache_alloc (mm/slub.c:3813 mm/slub.c:3860 mm/slub.c:3867)
>  copy_net_ns (./include/linux/slab.h:701 net/core/net_namespace.c:421 net=
/core/net_namespace.c:480)
>  create_new_namespaces (kernel/nsproxy.c:110)
>  unshare_nsproxy_namespaces (kernel/nsproxy.c:228 (discriminator 4))
>  ksys_unshare (kernel/fork.c:3429)
>  __x64_sys_unshare (kernel/fork.c:3496)
>  do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
>=20
> Freed by task 27 on cpu 0 at 329.158864s:
>  kasan_save_stack (mm/kasan/common.c:48)
>  kasan_save_track (mm/kasan/common.c:68)
>  kasan_save_free_info (mm/kasan/generic.c:643)
>  __kasan_slab_free (mm/kasan/common.c:265)
>  kmem_cache_free (mm/slub.c:4299 mm/slub.c:4363)
>  cleanup_net (net/core/net_namespace.c:456 net/core/net_namespace.c:446 n=
et/core/net_namespace.c:639)
>  process_one_work (kernel/workqueue.c:2638)
>  worker_thread (kernel/workqueue.c:2700 kernel/workqueue.c:2787)
>  kthread (kernel/kthread.c:388)
>  ret_from_fork (arch/x86/kernel/process.c:153)
>  ret_from_fork_asm (arch/x86/entry/entry_64.S:250)
>=20
> The buggy address belongs to the object at ffff88801b370000
>  which belongs to the cache net_namespace of size 4352
> The buggy address is located 1024 bytes inside of
>  freed 4352-byte region [ffff88801b370000, ffff88801b371100)
>=20
> [2]:
> WARNING: CPU: 0 PID: 95 at lib/ref_tracker.c:228 ref_tracker_free (lib/re=
f_tracker.c:228 (discriminator 1))
> Modules linked in:
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-=
gd239552ce722-prebuilt.qemu.org 04/01/2014
> RIP: 0010:ref_tracker_free (lib/ref_tracker.c:228 (discriminator 1))
> ...
> Call Trace:
> <IRQ>
>  __sk_destruct (./include/net/net_namespace.h:353 net/core/sock.c:2204)
>  rcu_core (./arch/x86/include/asm/preempt.h:26 kernel/rcu/tree.c:2165 ker=
nel/rcu/tree.c:2433)
>  __do_softirq (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jum=
p_label.h:207 ./include/trace/events/irq.h:142 kernel/softirq.c:554)
>  irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632 kernel/softirq.c=
:644)
>  sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1076 (discrimin=
ator 14))
> </IRQ>
>=20
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Fixes: 467fa15356ac ("RDS-TCP: Support multiple RDS-TCP listen endpoints,=
 one per netns.")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Eric, the patches LGTM, and I can see your suggested-by tag, but better
safe then sorry: could you please confirm it is ok for you too?

Thanks,

Paolo


