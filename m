Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F65F12A641
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Dec 2019 07:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbfLYGCj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Dec 2019 01:02:39 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:35917 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfLYGCi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Dec 2019 01:02:38 -0500
Received: by mail-lj1-f182.google.com with SMTP id r19so22232316ljg.3
        for <linux-rdma@vger.kernel.org>; Tue, 24 Dec 2019 22:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ql9LhJQ0Z1tDHc5RVJnuD31BahYOTsBmBij/Qm5KSvQ=;
        b=eKvJSVfT5Z9YdIK0hlWmQZtBrmqoEQnVdE7pnBsFnSQv3YHkwNF9StohtjX2jzxvPL
         Ymrd1kKucPonTI3+E0q9m548B8H0nwenJEzDNJ9UUF0TjW9o6a2060Dfb8rQ+QUNlD5X
         BS8VnHeQRWgTAV1TFGhZlpm3Clbq+DwXp3xWT2Vcm2lEleEg1MYpYOvnvwdCI4Yvt2u7
         z5vQ6isdyby5juPSym+uuAoiz29kewt0U8N7W902CwwhLr+euZK4VRR1ON0RZ8+/74+i
         yFVPFDqBXAgjx2R1uL1fN1C6u9472lqPg6PDeiWjvHaf+9iQBCn0HUWTVCRTn6Vm3EQC
         Cv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ql9LhJQ0Z1tDHc5RVJnuD31BahYOTsBmBij/Qm5KSvQ=;
        b=iGtLhSBdFtQ/oWYMrUmBZYtnzkq5YiMMHUfgoiMx6D0YAfkaVIU0TajctsrV24qDHh
         NgqW6MJ6y9y5HGhVW1ivEaG6gDpYQanUoW4N8h7IsI4Xxe/adsLnjVDt67qTO+1mlZBF
         XY2N4r1otK9Fhf6XQs4h2XPH1KpZd2lpPcv1lXhVRc0Twn8ORD4eKuAKLxgQDQc27Hsq
         L8kY2700yxPOsME7SiBhdvzOUnAgSUkxluNaKDtyltaiPGpk8ePVn0WLMaYI9KJhRMwk
         FSifoFsbpxl7M4E2G6rm32DOEbK05nVehE67FUUNg4QzeVn3IzaDP5kgAOg+d7ergUg5
         /w0Q==
X-Gm-Message-State: APjAAAVOpwIG+75ixTt6IBvGdfbXoI26Kcx1iUkn+0M5YubJijdVC9gb
        zuUQ50R7HJ3AOXoo4HhYyYxueaLsTmkZal2pf3U=
X-Google-Smtp-Source: APXvYqw5DobM2tjqfeapIBwKBeGJQYRo3vpANucXujOGxyrMV0w/6trjGVFL8VSR7FFLymNOUVDGSWxrFM0f9OTEBgE=
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr22932912ljn.48.1577253755490;
 Tue, 24 Dec 2019 22:02:35 -0800 (PST)
MIME-Version: 1.0
References: <CAKC_zSs=m_qPs06ZqxB-UJ_nHqhb+V2CBNKj3HsdJX+6eevqCA@mail.gmail.com>
 <CAD=hENfnjGXk7HuaihdxQ-uuYSdox6B_2BHaAMnYKWzMQHx5=Q@mail.gmail.com>
In-Reply-To: <CAD=hENfnjGXk7HuaihdxQ-uuYSdox6B_2BHaAMnYKWzMQHx5=Q@mail.gmail.com>
From:   Frank Huang <tigerinxm@gmail.com>
Date:   Wed, 25 Dec 2019 14:01:56 +0800
Message-ID: <CAKC_zStGqt_BO=sos+jtfEvxO3ZEgv4Sf-YytNPowhnBtGdDog@mail.gmail.com>
Subject: Re: rxe panic
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

yes,

what is the information should i post?

crash> bt
PID: 108    TASK: ffff978e28548000  CPU: 16  COMMAND: "ksoftirqd/16"
 #0 [ffffa2f14c9a7b18] machine_kexec at ffffffff8f059992
 #1 [ffffa2f14c9a7b70] __crash_kexec at ffffffff8f13cf7d
 #2 [ffffa2f14c9a7c38] crash_kexec at ffffffff8f13e089
 #3 [ffffa2f14c9a7c50] oops_end at ffffffff8f027a77
 #4 [ffffa2f14c9a7c70] general_protection at ffffffff8fa01635
    [exception RIP: rxe_elem_release+15]
    RIP: ffffffffc08da38f  RSP: ffffa2f14c9a7d28  RFLAGS: 00010246
    RAX: 0000000000000000  RBX: 860e42124013b0aa  RCX: 0000000000000000
    RDX: ffff978e03ba8900  RSI: 0000000000000281  RDI: ffff978e02e746e8
    RBP: ffff978e02e746e0   R8: 0000000000000201   R9: ffffa2f14dcb9000
    R10: 0000000000000000  R11: 0000000000000001  R12: 0000000000000000
    R13: 000000000000001d  R14: 0000000000000006  R15: ffff978e02e746e0
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #5 [ffffa2f14c9a7d38] rxe_responder at ffffffffc08d7d10 [rdma_rxe]
 #6 [ffffa2f14c9a7e48] rxe_do_task at ffffffffc08e060b [rdma_rxe]
 #7 [ffffa2f14c9a7e70] tasklet_action at ffffffff8f0afa1e
 #8 [ffffa2f14c9a7e88] __softirqentry_text_start at ffffffff8fc000d9
 #9 [ffffa2f14c9a7ee0] run_ksoftirqd at ffffffff8f0afa4e
#10 [ffffa2f14c9a7ee8] smpboot_thread_fn at ffffffff8f0cca5e
#11 [ffffa2f14c9a7f10] kthread at ffffffff8f0c8c9f
#12 [ffffa2f14c9a7f50] ret_from_fork at ffffffff8fa00205
crash> dis -l ffffffffc08d7d10
0xffffffffc08d7d10 <rxe_responder+3312>:        jmpq
0xffffffffc08d7c6c <rxe_responder+3148>
crash>

0xffffffffc08d7c97 <rxe_responder+3191>:        mov    0xec(%r15),%eax
0xffffffffc08d7c9e <rxe_responder+3198>:        cmp    $0x2,%eax
0xffffffffc08d7ca1 <rxe_responder+3201>:        je
0xffffffffc08d8213 <rxe_responder+4595>
0xffffffffc08d7ca7 <rxe_responder+3207>:        cmp    $0x3,%eax
0xffffffffc08d7caa <rxe_responder+3210>:        jne
0xffffffffc08d7ecc <rxe_responder+3756>
0xffffffffc08d7cb0 <rxe_responder+3216>:        mov    0x450(%r15),%eax
0xffffffffc08d7cb7 <rxe_responder+3223>:        cmp    $0x20,%eax
0xffffffffc08d7cba <rxe_responder+3226>:        jl
0xffffffffc08d873e <rxe_responder+5918>
0xffffffffc08d7cc0 <rxe_responder+3232>:        cmp    $0x21,%eax
0xffffffffc08d7cc3 <rxe_responder+3235>:        jle
0xffffffffc08d8725 <rxe_responder+5893>
0xffffffffc08d7cc9 <rxe_responder+3241>:        sub    $0x26,%eax
0xffffffffc08d7ccc <rxe_responder+3244>:        cmp    $0x1,%eax
0xffffffffc08d7ccf <rxe_responder+3247>:        ja
0xffffffffc08d873e <rxe_responder+5918>
0xffffffffc08d7cd5 <rxe_responder+3253>:        movzbl 0x2d(%rbx),%eax
0xffffffffc08d7cd9 <rxe_responder+3257>:        sub    $0x27,%eax
0xffffffffc08d7cdc <rxe_responder+3260>:        cmp    $0x3,%al
0xffffffffc08d7cde <rxe_responder+3262>:        sbb    %r13d,%r13d
0xffffffffc08d7ce1 <rxe_responder+3265>:        and    $0xfffffff0,%r13d
0xffffffffc08d7ce5 <rxe_responder+3269>:        add    $0x14,%r13d
0xffffffffc08d7ce9 <rxe_responder+3273>:        jmpq
0xffffffffc08d70a2 <rxe_responder+130>
0xffffffffc08d7cee <rxe_responder+3278>:        mov    %rbp,%rdi
0xffffffffc08d7cf1 <rxe_responder+3281>:        callq
0xffffffffc08da380 <rxe_elem_release>
0xffffffffc08d7cf6 <rxe_responder+3286>:        jmpq
0xffffffffc08d7b66 <rxe_responder+2886>
0xffffffffc08d7cfb <rxe_responder+3291>:        mov    %rbp,%rdi
0xffffffffc08d7cfe <rxe_responder+3294>:        callq
0xffffffffc08da380 <rxe_elem_release>
0xffffffffc08d7d03 <rxe_responder+3299>:        jmpq
0xffffffffc08d7b14 <rxe_responder+2804>
0xffffffffc08d7d08 <rxe_responder+3304>:        mov    %rbp,%rdi
0xffffffffc08d7d0b <rxe_responder+3307>:        callq
0xffffffffc08da380 <rxe_elem_release>
0xffffffffc08d7d10 <rxe_responder+3312>:        jmpq
0xffffffffc08d7c6c <rxe_responder+3148>
0xffffffffc08d7d15 <rxe_responder+3317>:        test   $0x10000,%eax
0xffffffffc08d7d1a <rxe_responder+3322>:        je
0xffffffffc08d804f <rxe_responder+4143>
0xffffffffc08d7d20 <rxe_responder+3328>:        mov    0x24(%rbx),%r12d
0xffffffffc08d7d24 <rxe_responder+3332>:        movzbl 0x19f(%r15),%edi
0xffffffffc08d7d2c <rxe_responder+3340>:        lea    0x6c0(%r15),%rsi
0xffffffffc08d7d33 <rxe_responder+3347>:        mov    %r12d,%edx
0xffffffffc08d7d36 <rxe_responder+3350>:        callq
0xffffffffc08d6af0 <find_resource>
0xffffffffc08d7d3b <rxe_responder+3355>:        test   %rax,%rax
0xffffffffc08d7d3e <rxe_responder+3358>:        je
0xffffffffc08d8c40 <rxe_responder+7200>
0xffffffffc08d7d44 <rxe_responder+3364>:        movzbl 0x2d(%rbx),%edx
0xffffffffc08d7d48 <rxe_responder+3368>:        movzbl 0x2e(%rbx),%ecx
0xffffffffc08d7d4c <rxe_responder+3372>:        mov    $0xc,%r13d
0xffffffffc08d7d52 <rxe_responder+3378>:        mov    0x20(%rax),%rdi
0xffffffffc08d7d56 <rxe_responder+3382>:        shl    $0x6,%rdx
0xffffffffc08d7d5a <rxe_responder+3386>:        movslq -0x3f715564(%rdx),%rdx
0xffffffffc08d7d61 <rxe_responder+3393>:        add    %rdx,%rcx
0xffffffffc08d7d64 <rxe_responder+3396>:        add    0x18(%rbx),%rcx
0xffffffffc08d7d68 <rxe_responder+3400>:        mov    (%rcx),%rdx
0xffffffffc08d7d6b <rxe_responder+3403>:        mov    0xc(%rcx),%esi
0xffffffffc08d7d6e <rxe_responder+3406>:        bswap  %rdx
0xffffffffc08d7d71 <rxe_responder+3409>:        bswap  %esi
0xffffffffc08d7d73 <rxe_responder+3411>:        cmp    %rdi,%rdx
0xffffffffc08d7d76 <rxe_responder+3414>:        jb
0xffffffffc08d70a2 <rxe_responder+130>
0xffffffffc08d7d7c <rxe_responder+3420>:        mov    0x2c(%rax),%r8d
0xffffffffc08d7d80 <rxe_responder+3424>:        cmp    %r8d,%esi
0xffffffffc08d7d83 <rxe_responder+3427>:        ja
0xffffffffc08d70a2 <rxe_responder+130>
0xffffffffc08d7d89 <rxe_responder+3433>:        mov    %esi,%r9d
0xffffffffc08d7d8c <rxe_responder+3436>:        add    %r8,%rdi
0xffffffffc08d7d8f <rxe_responder+3439>:        add    %rdx,%r9
0xffffffffc08d7d92 <rxe_responder+3442>:        cmp    %rdi,%r9
0xffffffffc08d7d95 <rxe_responder+3445>:        ja
0xffffffffc08d70a2 <rxe_responder+130>
0xffffffffc08d7d9b <rxe_responder+3451>:        mov    0x8(%rcx),%ecx
0xffffffffc08d7d9e <rxe_responder+3454>:        bswap  %ecx
0xffffffffc08d7da0 <rxe_responder+3456>:        cmp    0x28(%rax),%ecx

On Wed, Dec 25, 2019 at 1:28 PM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>
> Is there any vmcore about this problem?
>
> On Wed, Dec 25, 2019 at 1:03 PM Frank Huang <tigerinxm@gmail.com> wrote:
> >
> > hi, there is a panic on rdma_rxe module when the restart
> > network.service or shutdown the switch.
> >
> > it looks like a use-after-free error.
> >
> > everytime it happens, there is the log "rdma_rxe: Unknown layer 3 protocol: 0"
> >
> > is it a known error?
> >
> > my kernel version is 4.14.97
> >
> > [448840.314544] rdma_rxe: Unknown layer 3 protocol: 0
> > [448840.314626] general protection fault: 0000 [#1] SMP PTI
> > [448840.314627] Modules linked in: binfmt_misc ib_isert
> > iscsi_target_mod ib_srpt target_core_mod rpcrdma ib_iser ib_srp
> > scsi_transport_srp rdma_rxe(OE) ib_ipoib ib_umad ip6_udp_tunnel
> > udp_tunnel rdma_ucm rdma_cm iw_cm ib_cm ib_uverbs ib_core
> > ebtable_filter ebtables devlink ip6table_filter ip6_tables
> > ipt_MASQUERADE nf_nat_masquerade_ipv4 nf_conntrack_netlink iptable_nat
> > xt_addrtype xt_conntrack br_netfilter bridge stp llc overlay
> > ip_set_hash_ip ip_set nfnetlink iscsi_tcp libiscsi_tcp libiscsi
> > scsi_transport_iscsi sch_ingress openvswitch nf_conntrack_ipv6
> > nf_nat_ipv6 nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4
> > nf_defrag_ipv6 nf_nat nf_conntrack libcrc32c sunrpc intel_rapl
> > x86_pkg_temp_thermal intel_powerclamp coretemp vfat fat kvm_intel kvm
> > irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
> > intel_cstate
> > [448840.314677]  intel_uncore intel_rapl_perf mxm_wmi iTCO_wdt
> > iTCO_vendor_support ipmi_ssif pcspkr i2c_i801 lpc_ich ipmi_si
> > ipmi_devintf ipmi_msghandler pcc_cpufreq shpchp wmi ast drm_kms_helper
> > ttm crc32c_intel drm ixgbe igb mdio ptp pps_core dca i2c_algo_bit
> > [448840.314700] CPU: 1 PID: 17 Comm: ksoftirqd/1 Tainted: G
> > OE   4.14.97-el7.centos.x86_64 #1
> > [448840.314701] Hardware name:  /80010211        , BIOS 3.12 11/27/2018
> > [448840.314703] task: ffff9ce768af8000 task.stack: ffffbd7c4c6c4000
> > [448840.314710] RIP: 0010:rxe_elem_release+0xf/0x60 [rdma_rxe]
> > [448840.314711] RSP: 0018:ffffbd7c4c6c7d28 EFLAGS: 00010246
> > [448840.314713] RAX: 0000000000000000 RBX: 2917351aae258b92 RCX:
> > 0000000000000000
> > [448840.314714] RDX: ffff9cfb3f64ba40 RSI: 000000000000026c RDI:
> > ffff9cfb3f678008
> > [448840.314715] RBP: ffff9cfb3f678000 R08: 0000000000000201 R09:
> > ffffbd7c4df35000
> > [448840.314716] R10: 0000000000000000 R11: 0000000000000001 R12:
> > 0000000000000000
> > [448840.314717] R13: 000000000000001d R14: 0000000000000006 R15:
> > ffff9cfb3f678000
> > [448840.314719] FS:  0000000000000000(0000) GS:ffff9ce76f840000(0000)
> > knlGS:0000000000000000
> > [448840.314720] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [448840.314721] CR2: 00007f4fc400f000 CR3: 000000260420a005 CR4:
> > 00000000001626e0
> > [448840.314723] Call Trace:
> > [448840.314730]  rxe_responder+0xcf0/0x1fe0 [rdma_rxe]
> > [448840.314738]  ? check_preempt_wakeup+0x125/0x240
> > [448840.314742]  ? check_preempt_curr+0x84/0x90
> > [448840.314745]  ? ttwu_do_wakeup+0x19/0x140
> > [448840.314747]  ? try_to_wake_up+0x54/0x450
> > [448840.314751]  rxe_do_task+0x8b/0x100 [rdma_rxe]
> > [448840.314754]  tasklet_action+0xfe/0x110
> > [448840.314758]  __do_softirq+0xd9/0x2a2
> > [448840.314761]  run_ksoftirqd+0x1e/0x70
> > [448840.314763]  smpboot_thread_fn+0x10e/0x160
> > [448840.314766]  kthread+0xff/0x140
> > [448840.314768]  ? sort_range+0x20/0x20
> > [448840.314770]  ? __kthread_parkme+0x90/0x90
> > [448840.314771]  ret_from_fork+0x35/0x40
> > [448840.314773] Code: 7a 00 00 74 04 31 c0 eb c3 4c 89 e7 e8 bb f9 ff
> > ff 31 c0 eb b7 0f 1f 80 00 00 00 00 0f 1f 44 00 00 55 48 8d 6f f8 53
> > 48 8b 5f f8 <48> 8b 43 20 48 85 c0 74 08 48 89 ef e8 60 1c 53 fb 8b 43
> > 30 48
> > [448840.314817] RIP: rxe_elem_release+0xf/0x60 [rdma_rxe] RSP: ffffbd7c4c6c7d28
