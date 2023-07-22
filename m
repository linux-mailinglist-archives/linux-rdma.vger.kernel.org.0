Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1994875DD43
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Jul 2023 17:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjGVPrX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 Jul 2023 11:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjGVPrW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 22 Jul 2023 11:47:22 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4581B2;
        Sat, 22 Jul 2023 08:47:19 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bb119be881so21948845ad.3;
        Sat, 22 Jul 2023 08:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690040839; x=1690645639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thHxVhAeHOrzVgaGI8zFjUXVwK6gRVQqfqpUeZMdxco=;
        b=aCLZXuUzUd5xIiopS6p1TK1WZ4KZ9stLXnAFPvldB7yUuOje7nD+GwlQHOe01trbL2
         dt5BohDhpv8HiZmSQwKQOw4D4xKFNc1lSgwVbPSc4PWPPuAwBXM8hvI32isaM762gNdJ
         GR8F3+yElyrkrkMBTbabara67ToyrwHzbw13cxOPjoD5++jyFKH11QgjOfISG6yut/Tn
         w3Mkltum/FMhL8l7rCeObNyo6nw2hcG5X4gJ+u9ivQb2YTWGCTAkeLbqUJBOuOt0+6Tc
         YdIFzeV8LLIQjnsYQygc/CQNN/I/OSDVhBqBA/IrzU4CDzXp5/MlnjoV+tBOTDhWlv9s
         g2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690040839; x=1690645639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thHxVhAeHOrzVgaGI8zFjUXVwK6gRVQqfqpUeZMdxco=;
        b=a6QiSDh4Ux+4bXzJclhmQFEM1cUWYgP4qWt4H6JRPYy0BZoRmy1xCBo9paCEA059Zb
         IOkpE/SKINKtwrtPqdvHxzWOjputhTD1HDZtCRv5xd9JbWTZjx63A/GqHm8aaHdBNB3Z
         Gn6ngyrSCI+L9oqmfAnFZbEnWlpdajVtERaJE73YsHHhGerDdG5ejdgOI4orzGGAedji
         2Q06xGZ71hjQJi52kMnAu6UDXXM6YGl61IMfdY0crrjIOSftm7+gs5wnbgK+k8Vz3W4g
         5+EMnRuy/ZlIzxEa8EvATPT1FJ2Pwu32uRvrkBhNAl6Cqetp/zWoWlL8GBJafGyYFN/D
         jiIA==
X-Gm-Message-State: ABy/qLY8kX2ISsFHeRTqqj4G+rGWkyrxSs90DamjDXDOmzU/4Pdy3VZh
        hrkzBbFdz4XUyelkPzPBpgM=
X-Google-Smtp-Source: APBJJlGoiPA6QgIZVhzo/cs/pLcXqcVUTUuxth4GayY7joo6yQSgQoeC0Zc8Rkw1DocGyzJ/Q8OV5w==
X-Received: by 2002:a17:902:e88e:b0:1bb:1e69:28c0 with SMTP id w14-20020a170902e88e00b001bb1e6928c0mr7518680plg.30.1690040838691;
        Sat, 22 Jul 2023 08:47:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001b9cb27e07dsm5562174plq.45.2023.07.22.08.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 08:47:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 22 Jul 2023 08:47:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>,
        Pawel Chmielewski <pawel.chmielewski@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Gal Pressman <gal@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v3 8/8] lib: test for_each_numa_cpus()
Message-ID: <68e850c3-bde7-45f2-9d9e-24aea1f2386b@roeck-us.net>
References: <20230430171809.124686-1-yury.norov@gmail.com>
 <20230430171809.124686-9-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430171809.124686-9-yury.norov@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

On Sun, Apr 30, 2023 at 10:18:09AM -0700, Yury Norov wrote:
> Test for_each_numa_cpus() output to ensure that:
>  - all CPUs are picked from NUMA nodes with non-decreasing distances to the
>    original node; 
>  - only online CPUs are enumerated;
>  - the macro enumerates each online CPUs only once;
>  - enumeration order is consistent with cpumask_local_spread().
> 
> The latter is an implementation-defined behavior. If cpumask_local_spread()
> or for_each_numa_cpu() will get changed in future, the subtest may need
> to be adjusted or even removed, as appropriate.
> 
> It's useful now because some architectures don't implement numa_distance(),
> and generic implementation only distinguishes local and remote nodes, which
> doesn't allow to test the for_each_numa_cpu() properly.
> 

This patch results in a crash when testing sparc64 images with qemu.

[    4.178301] Unable to handle kernel NULL pointer dereference
[    4.178836] tsk->{mm,active_mm}->context = 0000000000000000
[    4.179280] tsk->{mm,active_mm}->pgd = fffff80000402000
[    4.179710]               \|/ ____ \|/
[    4.179710]               "@'/ .. \`@"
[    4.179710]               /_| \__/ |_\
[    4.179710]                  \__U_/
[    4.180307] swapper/0(1): Oops [#1]
[    4.181070] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                 N 6.5.0-rc2+ #1
[    4.181720] TSTATE: 0000000011001600 TPC: 000000000094d800 TNPC: 000000000094d804 Y: 00000000    Tainted: G                 N
[    4.182324] TPC: <_find_next_and_bit+0x20/0xa0>
[    4.183136] g0: 0000000000530b90 g1: 0000000000000000 g2: 0000000000000000 g3: ffffffffffffffff
[    4.183611] g4: fffff80004200020 g5: fffff8001dc42000 g6: fffff80004168000 g7: 0000000000000000
[    4.184080] o0: 0000000000000001 o1: 0000000001a28190 o2: 0000000000000009 o3: 00000000020e9e28
[    4.184549] o4: 0000000000000200 o5: 0000000000000001 sp: fffff8000416af11 ret_pc: 0000000000f6529c
[    4.185020] RPC: <lock_is_held_type+0xbc/0x180>
[    4.185477] l0: 0000000001bbfa58 l1: 0000000000000000 l2: 00000000020ea228 l3: fffff80004200aa0
[    4.185950] l4: 81b8e1e5a4e0c637 l5: 000000000192b000 l6: 00000000023b3800 l7: 00000000020e9e28
[    4.186417] i0: 000000000192a3f8 i1: 0000000000000000 i2: 0000000000000001 i3: 0000000000000000
[    4.186885] i4: 0000000000000001 i5: fffff80004200aa0 i6: fffff8000416afc1 i7: 00000000004c79bc
[    4.187356] I7: <sched_numa_find_next_cpu+0x13c/0x180>
[    4.187821] Call Trace:
[    4.188274] [<00000000004c79bc>] sched_numa_find_next_cpu+0x13c/0x180
[    4.188762] [<0000000001b77c10>] test_for_each_numa_cpu+0x164/0x37c
[    4.189196] [<0000000001b7878c>] test_bitmap_init+0x964/0x9f4
[    4.189637] [<0000000000427f40>] do_one_initcall+0x60/0x340
[    4.190069] [<0000000001b56f34>] kernel_init_freeable+0x1bc/0x228
[    4.190496] [<0000000000f66aa4>] kernel_init+0x18/0x134
[    4.190911] [<00000000004060e8>] ret_from_fork+0x1c/0x2c
[    4.191326] [<0000000000000000>] 0x0
[    4.191827] Disabling lock debugging due to kernel taint
[    4.192363] Caller[00000000004c79bc]: sched_numa_find_next_cpu+0x13c/0x180
[    4.192825] Caller[0000000001b77c10]: test_for_each_numa_cpu+0x164/0x37c
[    4.193255] Caller[0000000001b7878c]: test_bitmap_init+0x964/0x9f4
[    4.193681] Caller[0000000000427f40]: do_one_initcall+0x60/0x340
[    4.194097] Caller[0000000001b56f34]: kernel_init_freeable+0x1bc/0x228
[    4.194516] Caller[0000000000f66aa4]: kernel_init+0x18/0x134
[    4.194922] Caller[00000000004060e8]: ret_from_fork+0x1c/0x2c
[    4.195326] Caller[0000000000000000]: 0x0
[    4.195728] Instruction DUMP:
[    4.195762]  8328b003
[    4.196237]  8728d01b
[    4.196600]  d05e0001
[    4.196956] <ce5e4001>
[    4.197311]  900a0007
[    4.197669]  900a0003
[    4.198024]  0ac20013
[    4.198379]  bb28b006
[    4.198733]  8400a001
[    4.199093]
[    4.199873] note: swapper/0[1] exited with preempt_count 1
[    4.200539] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009

Bisect log attached.

Guenter

---
# bad: [ae867bc97b713121b2a7f5fcac68378a0774739b] Add linux-next specific files for 20230721
# good: [fdf0eaf11452d72945af31804e2a1048ee1b574c] Linux 6.5-rc2
git bisect start 'HEAD' 'v6.5-rc2'
# good: [f09bf8f6c8cbbff6f52523abcda88c86db72e31c] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
git bisect good f09bf8f6c8cbbff6f52523abcda88c86db72e31c
# good: [86374a6210aeebceb927204d80f9e65739134bc3] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
git bisect good 86374a6210aeebceb927204d80f9e65739134bc3
# good: [d588c93cae9e3dff15d125e755edcba5d842f41a] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
git bisect good d588c93cae9e3dff15d125e755edcba5d842f41a
# good: [3c3990d304820b12a07c77a6e091d6711b31f8e5] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git
git bisect good 3c3990d304820b12a07c77a6e091d6711b31f8e5
# good: [b80a945fabd7acc5984d421c73fa0b667195adb7] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
git bisect good b80a945fabd7acc5984d421c73fa0b667195adb7
# good: [22c343fad503564a2ef5c6aff1dcb1ec0640006e] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching
git bisect good 22c343fad503564a2ef5c6aff1dcb1ec0640006e
# good: [bf05130eebc3265314f14c1314077f500a5c8d98] Merge branch 'mhi-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
git bisect good bf05130eebc3265314f14c1314077f500a5c8d98
# good: [18eea171e03cc2b30fe7c11d6e94521d905026f0] Merge branch 'rust-next' of https://github.com/Rust-for-Linux/linux.git
git bisect good 18eea171e03cc2b30fe7c11d6e94521d905026f0
# bad: [94b1547668965e1fde8bde3638845ab582b40034] lib: test for_each_numa_cpus()
git bisect bad 94b1547668965e1fde8bde3638845ab582b40034
# good: [310ae5d9d46b65fdbd18ac1e5bd03681fbc19ae8] sched/topology: introduce sched_numa_find_next_cpu()
git bisect good 310ae5d9d46b65fdbd18ac1e5bd03681fbc19ae8
# good: [a4be5fa84bb269886310f563e9095e8164f82c8c] net: mlx5: switch comp_irqs_request() to using for_each_numa_cpu
git bisect good a4be5fa84bb269886310f563e9095e8164f82c8c
# good: [b9833b80d87030b0def7aeda88471ac7f6acd3cb] sched: drop for_each_numa_hop_mask()
git bisect good b9833b80d87030b0def7aeda88471ac7f6acd3cb
# first bad commit: [94b1547668965e1fde8bde3638845ab582b40034] lib: test for_each_numa_cpus()
