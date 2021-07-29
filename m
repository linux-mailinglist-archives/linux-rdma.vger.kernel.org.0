Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689FB3D9F06
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 09:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbhG2H5Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 03:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbhG2H5X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jul 2021 03:57:23 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F684C061757
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 00:57:20 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id o185so7329503oih.13
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 00:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=48lDxI7tsceK+p34FhGaXSYi+7yOu1zRPynJ9t8sGTs=;
        b=S/a19QJfrlWhy5L2h092XaMgShyhqqxZu88lIbghTsNAPDZ8S5cJrndpW/j2SusmNP
         wkLuD4nz5r7k1t2x264Dr69MhtYhR1KAppJ5Q99Y6NRC3DPVnkRum5o+TT//AnoO10bI
         clD79cw1wpSl7/ouvgAMYHcHHrYjNwrFg2ytxqF4eJ8lJzV7C3dIqQAeK4aIy/GlkUeU
         TRR2F+WLFUeFxDH9BFLOTUyJruX0joWzFLZZuwHOkJpiDgo3N/WKcO5guTbEAcGUy2tc
         bb1hZc/kUk1FEYFQOPmBaZk8rABYnAaMEZTEm7ssEsPkAyy3UK8p5BGeBwdBZuYxctfE
         TiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48lDxI7tsceK+p34FhGaXSYi+7yOu1zRPynJ9t8sGTs=;
        b=gUYdz4Y++fP/vKqHNt+VmKvE6YqWPOZ393W/V9dKfbAa8NZ88RwWEBLPCaMMant58Q
         qovg8gRDAZVJewp3jvMcvCOOjfkHiZVzxG7QzZkv0lPxpvRNE7O8/OSkfcksXO3bkeYg
         /M2lDzq15Z2d01n+jwgtD8nl1/4IEWFvp2GPuRO0S6gZLUurLUTfgOQoiDFL+p/dAneV
         7o66olVlo6odOePfzSEzO+o0EzKwDBg9/QILJBayKkBAnBAH5A8sSFSW4mTCIK6umIYz
         wAyqYBbDBxvgjC3GPyZbNEOEp+VplzIwo9Wy5etHQMOCb06fTgN2Me0mT3+KrwVWFZA/
         tH4A==
X-Gm-Message-State: AOAM531/kAOgBmt7zqMiRfjNFTsmd4hlbz2iP/fG8fCyCMiAtXo/7jFh
        UnAa/AlUepXbvt3x9Ox9T1C32gbkjNxSl520LXNaWtYnSnE=
X-Google-Smtp-Source: ABdhPJyvjahIUb1d2PY+tJx4kx9sl9/i/frjUltl2bKtbZ66Q5skP30Af9qTTAz1bQKYFnTMi93OzFqPCBCt/JH0RG8=
X-Received: by 2002:a05:6808:490:: with SMTP id z16mr8871187oid.89.1627545439992;
 Thu, 29 Jul 2021 00:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210718225905.58728-1-Rao.Shoaib@oracle.com> <54817f70-e7e5-d145-badf-268ba7533110@oracle.com>
 <20210727174144.GE543798@ziepe.ca> <CAD=hENdOrfyq2buP269LQVhq+QkZ=hpA3jpbZH+CAFt=CGLV-w@mail.gmail.com>
 <6687ea04-c402-1b4e-dce0-386d29948ecc@oracle.com>
In-Reply-To: <6687ea04-c402-1b4e-dce0-386d29948ecc@oracle.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 29 Jul 2021 15:57:08 +0800
Message-ID: <CAD=hENcTYfV1LT1=_e=eCNxdjr1Nmi+R3hH_CQn70MGRTKG7LA@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via uverbs
To:     Shoaib Rao <rao.shoaib@oracle.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 29, 2021 at 2:52 PM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>
>
> On 7/28/21 11:42 PM, Zhu Yanjun wrote:
> > On Wed, Jul 28, 2021 at 1:42 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >> On Tue, Jul 27, 2021 at 09:15:45AM -0700, Shoaib Rao wrote:
> >>> Hi Jason et al,
> >>>
> >>> Can I please get an up or down comment on my patch?
> >> Bob and Zhu should check it
> > In my daily tests, I found that one host 5.12-stable, the other host
> > is 5.14.-rc3 + this commit.
> > rping can not work. Sometimes crash will occur.
> Can you paste the stack?

[  381.068203] rdma_rxe: qp#17 moved to error state
[  421.464485] BUG: unable to handle page fault for address: ffff9e5de298d180
[  421.464515] #PF: supervisor write access in kernel mode
[  421.464532] #PF: error_code(0x0002) - not-present page
[  421.464549] PGD 100c00067 P4D 100c00067 PUD 100dc1067 PMD 125e78067 PTE 0
[  421.464572] Oops: 0002 [#1] SMP PTI
[  421.464585] CPU: 25 PID: 0 Comm: swapper/25 Kdump: loaded Tainted:
G S      W  OE     5.13.1-rxe+ #17
[  421.464613] Hardware name: Intel Corporation S2600WFT/S2600WFT,
BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
[  421.464642] RIP: 0010:rxe_cq_post+0x98/0x210 [rdma_rxe]
[  421.464667] Code: 8b b3 48 01 00 00 4d 8b 48 08 41 8b 48 28 49 8d
b9 80 01 00 00 85 f6 0f 84 78 01 00 00 41 8b 50 34 d3 e2 48 01 fa 48
8b 4d 00 <48> 89 0a 48 8b 4d 08 48 89 4a 08 48 8b 4d 10 48 89 4a 10 48
8b 4d
[  421.464718] RSP: 0018:ffff9e5dc6ce0918 EFLAGS: 00010082
[  421.464735] RAX: 0000000000000246 RBX: ffff8b200cabd800 RCX: 0000000000000000
[  421.464756] RDX: ffff9e5de298d180 RSI: 0000000000000001 RDI: ffff9e5dc698b180
[  421.464777] RBP: ffff9e5dc6ce09c0 R08: ffff8b2014d85a80 R09: ffff9e5dc698b000
[  421.464797] R10: ffffffff8bc90940 R11: 0000000000000001 R12: 0000000000000000
[  421.464817] R13: ffff8b200cabd940 R14: ffff8b206e014008 R15: 000000000000001a
[  421.464838] FS:  0000000000000000(0000) GS:ffff8b1fd1040000(0000)
knlGS:0000000000000000
[  421.464861] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  421.464879] CR2: ffff9e5de298d180 CR3: 0000000c4df4e006 CR4: 00000000007706e0
[  421.464899] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  421.464920] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  421.464941] PKRU: 55555554
[  421.464950] Call Trace:
[  421.464961]  <IRQ>
[  421.464971]  rxe_responder+0x621/0x2480 [rdma_rxe]
[  421.464993]  ? __fib_validate_source+0x2e9/0x450
[  421.465013]  rxe_do_task+0x89/0x100 [rdma_rxe]
[  421.465033]  rxe_rcv+0x2eb/0x900 [rdma_rxe]
[  421.465050]  ? __udp4_lib_lookup+0x2c8/0x440
[  421.465065]  rxe_udp_encap_recv+0x68/0xc0 [rdma_rxe]
[  421.465085]  ? rxe_enable_task+0x10/0x10 [rdma_rxe]
[  421.465104]  udp_queue_rcv_one_skb+0x1df/0x4e0
[  421.465120]  udp_unicast_rcv_skb.isra.67+0x74/0x90
[  421.465135]  __udp4_lib_rcv+0x555/0xb90
[  421.465150]  ? nf_ct_deliver_cached_events+0xc1/0x120 [nf_conntrack]
[  421.465181]  ip_protocol_deliver_rcu+0xe8/0x1b0
[  421.465199]  ip_local_deliver_finish+0x44/0x50
[  421.465215]  ip_local_deliver+0xf1/0x100
[  421.465229]  ? coalesce_fill_reply+0x2c1/0x480
[  421.465249]  ? ip_protocol_deliver_rcu+0x1b0/0x1b0
[  421.465265]  ip_sublist_rcv_finish+0x75/0x80
[  421.465281]  ip_sublist_rcv+0x196/0x220
[  421.465296]  ? ip_local_deliver+0x100/0x100
[  421.465312]  ip_list_rcv+0x137/0x160
[  421.465325]  __netif_receive_skb_list_core+0x29b/0x2c0
[  421.465344]  netif_receive_skb_list_internal+0x1c3/0x2f0
[  421.465361]  gro_normal_list.part.158+0x19/0x40
[  421.465376]  napi_complete_done+0x67/0x160
[  421.465391]  i40e_napi_poll+0x53b/0x840 [i40e]
[  421.465426]  __napi_poll+0x2b/0x120
[  421.466123]  net_rx_action+0x236/0x300
[  421.466783]  __do_softirq+0xc9/0x285
[  421.467440]  irq_exit_rcu+0xba/0xd0
[  421.468091]  common_interrupt+0x7f/0xa0
[  421.468737]  </IRQ>
[  421.469366]  asm_common_interrupt+0x1e/0x40
[  421.469990] RIP: 0010:cpuidle_enter_state+0xd6/0x350
[  421.470608] Code: 49 89 c4 0f 1f 44 00 00 31 ff e8 45 49 99 ff 45
84 ff 74 12 9c 58 f6 c4 02 0f 85 32 02 00 00 31 ff e8 ae c8 9f ff fb
45 85 f6 <0f> 88 e0 00 00 00 49 63 d6 4c 2b 24 24 48 8d 04 52 48 8d 04
82 49
[  421.471935] RSP: 0018:ffff9e5dc679fe80 EFLAGS: 00000202
[  421.472599] RAX: ffff8b1fd106bc40 RBX: 0000000000000002 RCX: 000000000000001f
[  421.473266] RDX: 00000062213d764d RSI: 000000003351fed6 RDI: 0000000000000000
[  421.473920] RBP: ffffbe51c1040000 R08: 0000000000000002 R09: 000000000002b480
[  421.474558] R10: 0000a82bea904be8 R11: ffff8b1fd106a984 R12: 00000062213d764d
[  421.475172] R13: ffffffff8c6c6d80 R14: 0000000000000002 R15: 0000000000000000
[  421.475763]  cpuidle_enter+0x29/0x40
[  421.476348]  do_idle+0x257/0x2a0
[  421.476926]  cpu_startup_entry+0x19/0x20
[  421.477497]  start_secondary+0x116/0x150
[  421.478067]  secondary_startup_64_no_verify+0xc2/0xcb
[  421.478640] Modules linked in: rdma_rxe(OE) ip6_udp_tunnel
udp_tunnel xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT
nf_reject_ipv4 nft_compat nft_counter nft_chain_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink tun
bridge stp llc nls_utf8 isofs cdrom loop rfkill ib_isert
iscsi_target_mod ib_srpt ext4 target_core_mod ib_srp
scsi_transport_srp mbcache jbd2 rpcrdma sunrpc intel_rapl_msr
intel_rapl_common rdma_ucm isst_if_common ib_iser ib_umad rdma_cm
ib_ipoib iw_cm skx_edac libiscsi ib_cm nfit libnvdimm
scsi_transport_iscsi x86_pkg_temp_thermal intel_powerclamp mlx5_ib
coretemp crct10dif_pclmul crc32_pclmul iTCO_wdt iTCO_vendor_support
ib_uverbs ghash_clmulni_intel rapl ipmi_ssif intel_cstate ib_core
mei_me acpi_ipmi i2c_i801 joydev intel_uncore pcspkr mei i2c_smbus
lpc_ich ioatdma ipmi_si intel_pch_thermal dca ipmi_devintf
ipmi_msghandler acpi_pad acpi_power_meter ip_tables xfs libcrc32c
sd_mod t10_pi sg mlx5_core ast i2c_algo_bit drm_vram_helper
[  421.478702]  drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops drm_ttm_helper ttm mlxfw ahci libahci pci_hyperv_intf ice
drm i40e tls crc32c_intel libata psample wmi dm_mirror dm_region_hash
dm_log dm_mod fuse [last unloaded: ip6_udp_tunnel]
[  421.483665] CR2: ffff9e5de298d180


> >
> > It seems that changing maximum values breaks backward compatibility.
> >
> > But without this commit, that is, 5.12-stable <-------> 5.14-rc3,
> > rping can work well.
>
> That is strange because all the large values do is initialize the pool
> with large values. Nothing else. So unless large values are used there
> should be no issues. Is it possible that the issue is with 5.14-rc3. Do
> things work between 5.12-stable systems. Anyways, please post the stack
> trace and also information on the setup and rping commands used.
>
> Shoaib
>
> >
> > Zhu Yanjun
> >> Jason
