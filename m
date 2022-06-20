Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED7D55149F
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jun 2022 11:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbiFTJmP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jun 2022 05:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239851AbiFTJmP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jun 2022 05:42:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039DB13DDA;
        Mon, 20 Jun 2022 02:42:12 -0700 (PDT)
Date:   Mon, 20 Jun 2022 11:42:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655718130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcBmBxo2fP82JevvTDoeP4Kiy4jWkYCZ+jz5+ZP0+F0=;
        b=34AeDgo5rWRo4UqRiVBhnQ/5xJfxd38VAC5dMP/YsiTjyWX9dYIK3VSSGQw9ws9BvMBGnM
        DJDrIAj96ZmI3EJkBC56mn2Jf30/VRh0OhXl1LKhcSEmaogTMfxgFNzOJkgRZ4/V2J4yeh
        +NKxPWuZ9HSkxbpCuRi/Ac+mtb7u8aNPqxXM/oDVa5rRs1T5jMQnLa2PfD0vhYCQ380Y+7
        yc6oAMZY2SE64K4bhJCmbuSx8xH31sSco+vOPx2bpGM1E4zjd5hXlyp7pIJR2oQJplZXRs
        xesA955nfEDTUYIHiBDLlE8eDnAjuy95Be/o+S0gyU35sQqUS77pwFfci5Iupw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655718130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcBmBxo2fP82JevvTDoeP4Kiy4jWkYCZ+jz5+ZP0+F0=;
        b=vFc8Hz4WM/MmpvWNk9Tr9MnumxRG2GagKVnGwQVnIbUsb6x5FXtZXa6j0NAogVOvXHWN8z
        DWRxwFvYzenBqmAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [locking/lockdep]  4051a81774:
 page_allocation_failure:order:#,mode:#(GFP_KERNEL),nodemask=(null)
Message-ID: <YrBA7ysAif4I9nPv@linutronix.de>
References: <20220620020727.GA3669@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220620020727.GA3669@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

+ rtrs, infiniband folks.=20

On 2022-06-20 10:07:27 [+0800], kernel test robot wrote:
> Greeting,
>=20
> FYI, we noticed the following commit (built with gcc-11):
>=20
> commit: 4051a81774d6d8e28192742c26999d6f29bc0e68 ("locking/lockdep: Use s=
ched_clock() for random numbers")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git locking/urgent
=E2=80=A6
> in testcase: boot
>=20
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -=
m 16G
>=20
=E2=80=A6
> [   17.451787][    T1] rtrs_server L2256: Loading module rtrs_server, pro=
to 2.0: (max_chunk_size: 131072 (pure IO 126976, headers 4096) , sess_queue=
_depth: 512, always_invalidate: 1)
> [   17.470894][    T1] swapper: page allocation failure: order:5, mode:0x=
cc0(GFP_KERNEL), nodemask=3D(null)

If I read this right, it allocates "512 * 10" chunks of order 5 / 128KiB
of memory (contiguous memory). And this appears to fail.=20
This is either a lot of memory or something that shouldn't be used on
i386.

Either way, locking/urgent is innocent.

> [   17.470905][    T1] CPU: 0 PID: 1 Comm: swapper Not tainted 5.19.0-rc2=
-00001-g4051a81774d6 #1
=E2=80=A6
> [   17.471016][    T1] Node 0 active_anon:0kB inactive_anon:0kB active_fi=
le:0kB inactive_file:0kB unevictable:350872kB isolated(anon):0kB isolated(f=
ile):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB writeback_tmp:0kB ker=
nel_stack:304kB pagetables:4kB all_unreclaimable? no
> [   17.471022][    T1] DMA free:2304kB boost:0kB min:80kB low:100kB high:=
120kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file=
:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB man=
aged:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [   17.471029][    T1] lowmem_reserve[]: 0 544 2867 2867
> [   17.471034][    T1] Normal free:3040kB boost:0kB min:2940kB low:3672kB=
 high:4404kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB acti=
ve_file:0kB inactive_file:0kB unevictable:16348kB writepending:0kB present:=
749560kB managed:671404kB mlocked:0kB bounce:0kB free_pcp:900kB local_pcp:9=
00kB free_cma:0kB
> [   17.471041][    T1] lowmem_reserve[]: 0 0 18591 18591
> [   17.471045][    T1] HighMem free:2040716kB boost:0kB min:512kB low:365=
2kB high:6792kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB a=
ctive_file:0kB inactive_file:0kB unevictable:334524kB writepending:0kB pres=
ent:2379656kB managed:2379656kB mlocked:0kB bounce:0kB free_pcp:296kB local=
_pcp:296kB free_cma:0kB
> [   17.471052][    T1] lowmem_reserve[]: 0 0 0 0
> [   17.471056][    T1] DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 1*25=
6kB (U) 0*512kB 0*1024kB 1*2048kB (U) 0*4096kB =3D 2304kB
> [   17.471073][    T1] Normal: 4*4kB (UM) 2*8kB (UM) 2*16kB (U) 3*32kB (U=
M) 3*64kB (UM) 1*128kB (M) 2*256kB (M) 0*512kB 2*1024kB (M) 0*2048kB 0*4096=
kB =3D 3040kB
> [   17.471093][    T1] HighMem: 1*4kB (M) 1*8kB (U) 0*16kB 0*32kB 0*64kB =
1*128kB (M) 1*256kB (U) 1*512kB (M) 2*1024kB (UM) 1*2048kB (M) 497*4096kB (=
M) =3D 2040716kB
> [   17.471114][    T1] 87718 total pagecache pages
> [   17.471116][    T1] 786302 pages RAM
> [   17.471116][    T1] 594914 pages HighMem/MovableOnly
> [   17.471117][    T1] 19697 pages reserved
> [   17.471118][    T1] 0 pages hwpoisoned

Sebastian
