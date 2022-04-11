Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F004FB349
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Apr 2022 07:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244753AbiDKFgr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Apr 2022 01:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241533AbiDKFgp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Apr 2022 01:36:45 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3813E12AD5
        for <linux-rdma@vger.kernel.org>; Sun, 10 Apr 2022 22:34:31 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x33so18161644lfu.1
        for <linux-rdma@vger.kernel.org>; Sun, 10 Apr 2022 22:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y0VB7dvE8jpVTRyfedBhsiPcxON0ogeZSUfDVmMoJt0=;
        b=HNj1gdJvnHwx6t/jSLntsXJd6RY7663b4g6VknFZgfOtg1ULLaL06txIlasvYNFpYD
         8W23WkMl/H8ab8+X3usaz27IG0SnxNuI/UnRYH+9VVbOPPH2rql9V0d102uVB4ZyfqPv
         vmn7TQqKLQBuuw6uEswGKVIrOVKENJ6CZdMP1JlHgQDB6NDEaohMWY7dszNDE59/a4VN
         9QgaDPdXeh7Wpg3I09sCqZ3wseq7yvlHZuNSb4J+FGrYs61zmjywIbzuVM/NZvCnY+fW
         j9eCi0lZo4yPcPblkGDkrWUhjdiq0cUQJ+8gLv3BUmJdRbTWwJO1DJElPnXmX/czxXZG
         o4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y0VB7dvE8jpVTRyfedBhsiPcxON0ogeZSUfDVmMoJt0=;
        b=wBTt8tJ7BdoyrVRFl3cIEitQeDtbNIv71sTUGHsSa6dsT2jdpcpN990BVKuHd6G1tD
         oeAhogiDJIDhcZmH9jkJ2LIaCCI6phW2fJAditPEBx3/IJ8mgDm1BqcN3+Aa1F1yRZQa
         1BVrhsyu70Q67NuBTaSTWpI/vC3Ij2yoFOfsI9iFiGgFxbkXtYl+Ud/MTzr3A/dj0QV2
         Xw6GdRllPHLj6HkrJFzGPHzoL90o5d0G2SlSIji8y4PQLqeOc3yXFK0bY2hL060n/+ti
         8hTQVZBdz9IVz4pjwRNPr+UQ38bHeowCawZTVd5fXCM8uwDEqN0FrwhzcnYoyhy6QbDB
         B6/w==
X-Gm-Message-State: AOAM533mRaytGBtKDtWYwaOHgDH62ZM1m1uv/YoBICJ4ADsfcb9eWTjl
        HlOF9EX3C1rz/CAHW0IQ4QkWO/PC6TMasgMb2EoRXBoNrsk=
X-Google-Smtp-Source: ABdhPJy8O40AEaIZpNqA+hFgIMUrstJV44wN7X3dl7hgsOESnOfjSCArRBX8sLSviO89Gbu6hRxAERyMrC6jxN89qTY=
X-Received: by 2002:a05:6512:3b21:b0:44a:20fc:3e15 with SMTP id
 f33-20020a0565123b2100b0044a20fc3e15mr20678032lfv.266.1649655269230; Sun, 10
 Apr 2022 22:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <1b0ae089-ff3f-7e84-4c07-a5d97554e3c0@gmail.com> <CAD=hENdM=VEF4MM_L=W1PtiX=x2s_kucMLc41WWmK-6c6s2Nrg@mail.gmail.com>
In-Reply-To: <CAD=hENdM=VEF4MM_L=W1PtiX=x2s_kucMLc41WWmK-6c6s2Nrg@mail.gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 11 Apr 2022 13:34:17 +0800
Message-ID: <CAD=hENet+KQe35eqXabM+EpucHh3mYypUo4H8S-XmwNPcOv4+A@mail.gmail.com>
Subject: Re: null pointer in rxe_mr_copy()
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 11, 2022 at 1:14 PM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>
> On Mon, Apr 11, 2022 at 11:34 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >
> > Zhu,
> >
> > Since checking for mr == NULL in rxe_mr_copy fixes the problem you were seeing in rping.
> > Perhaps it would be a good idea to apply the following patch which would tell us which of
> > the three calls to rxe_mr_copy is failing. My suspicion is the one in read_reply()
> Hi, Bob
>
> Yes. It is the function read_reply.

 720 static enum resp_states read_reply(struct rxe_qp *qp,
 721                                    struct rxe_pkt_info *req_pkt)
 722 {
 723         struct rxe_pkt_info ack_pkt;
 724         struct sk_buff *skb;
 725         int mtu = qp->mtu;
 726         enum resp_states state;
 727         int payload;
 728         int opcode;
 729         int err;
 730         struct resp_res *res = qp->resp.res;
 731         struct rxe_mr *mr;
 732
 733         if (!res) {
 734                 res = rxe_prepare_read_res(qp, req_pkt);
 735                 qp->resp.res = res;
 736         }
 737
 738         if (res->state == rdatm_res_state_new) {
 739                 mr = qp->resp.mr;
<----It seems that mr is from here.
 740                 qp->resp.mr = NULL;
 741


>
>  kernel: ------------[ cut here ]------------
>  kernel: WARNING: CPU: 74 PID: 38510 at
> drivers/infiniband/sw/rxe/rxe_resp.c:768 rxe_responder+0x1d67/0x1dd0
> [rdma_rxe]
>  kernel: Modules linked in: rdma_rxe(OE) ip6_udp_tunnel udp_tunnel
> rds_rdma rds xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT
> nf_reject_ipv4 nft_compat nft_chain_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink tun bridge stp llc
> vfat fat rpcrdma sunrpc rdma_ucm ib_srpt ib_isert iscsi_target_mod
> target_core_mod intel_rapl_msr intel_rapl_common ib_iser libiscsi
> scsi_transport_iscsi rdma_cm ib_cm i10nm_edac iw_cm nfit libnvdimm
> x86_pkg_temp_thermal intel_powerclamp coretemp ipmi_ssif kvm_intel kvm
> irdma iTCO_wdt iTCO_vendor_support i40e irqbypass crct10dif_pclmul
> crc32_pclmul ib_uverbs ghash_clmulni_intel rapl intel_cstate ib_core
> intel_uncore wmi_bmof pcspkr mei_me isst_if_mbox_pci isst_if_mmio
> acpi_ipmi isst_if_common ipmi_si i2c_i801 mei intel_pch_thermal
> i2c_smbus ipmi_devintf ipmi_msghandler acpi_power_meter ip_tables xfs
> libcrc32c sd_mod t10_pi crc64_rocksoft crc64 sg mgag200 i2c_algo_bit
> drm_shmem_helper drm_kms_helper syscopyarea sysfillrect ice
>  kernel: sysimgblt fb_sys_fops ahci drm libahci crc32c_intel libata
> megaraid_sas tg3 wmi dm_mirror dm_region_hash dm_log dm_mod fuse [last
> unloaded: ip6_udp_tunnel]
>  kernel: CPU: 74 PID: 38510 Comm: rping Kdump: loaded Tainted: G S
>  W  OE     5.18.0.RXE #14
>  kernel: Hardware name: Dell Inc. PowerEdge R750/06V45N, BIOS 1.2.4 05/28/2021
>  kernel: RIP: 0010:rxe_responder+0x1d67/0x1dd0 [rdma_rxe]
>  kernel: Code: 24 30 48 89 44 24 30 49 8b 86 88 00 00 00 48 89 44 24
> 38 48 8b 73 20 48 8b 43 18 ff d0 0f 1f 00 e9 10 e3 ff ff e8 e9 52 98
> ee <0f> 0b 45 8b 86 f0 00 00 00 48 8b 8c 24 e0 00 00 00 ba 01 03 00 00
>  kernel: RSP: 0018:ff5f5b78c7624e70 EFLAGS: 00010246
>  kernel: RAX: ff20346c70a1d700 RBX: ff20346c7127c040 RCX: ff20346c70a1d700
>  kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: ff20346c53194000
>  kernel: RBP: 0000000000000040 R08: 2ebbb556a556fe7f R09: 69de575d0320dc48
>  kernel: R10: ff5f5b78c7624de0 R11: 00000000ee4984a4 R12: ff20346c70a1d700
>  kernel: R13: 0000000000000000 R14: ff20346ef0539000 R15: ff20346c70a1c528
>  kernel: FS:  00007ff34d49b740(0000) GS:ff20347b3fa80000(0000)
> knlGS:0000000000000000
>  kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  kernel: CR2: 00007ff40be030c0 CR3: 00000003d0634005 CR4: 0000000000771ee0
>  kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  kernel: PKRU: 55555554
>  kernel: Call Trace:
>  kernel: <IRQ>
>  kernel: ? __local_bh_enable_ip+0x9f/0xe0
>  kernel: ? rxe_do_task+0x67/0xe0 [rdma_rxe]
>  kernel: ? __local_bh_enable_ip+0x77/0xe0
>  kernel: rxe_do_task+0x71/0xe0 [rdma_rxe]
>  kernel: tasklet_action_common.isra.15+0xb8/0xf0
>  kernel: __do_softirq+0xe4/0x48c
>  kernel: ? rxe_do_task+0x67/0xe0 [rdma_rxe]
>  kernel: do_softirq+0xb5/0x100
>  kernel: </IRQ>
>  kernel: <TASK>
>  kernel: __local_bh_enable_ip+0xd0/0xe0
>  kernel: rxe_do_task+0x67/0xe0 [rdma_rxe]
>  kernel: rxe_post_send+0x2ff/0x4c0 [rdma_rxe]
>  kernel: ? rdma_lookup_get_uobject+0x131/0x1e0 [ib_uverbs]
>  kernel: ib_uverbs_post_send+0x4d5/0x700 [ib_uverbs]
>  kernel: ib_uverbs_write+0x38f/0x5e0 [ib_uverbs]
>  kernel: ? find_held_lock+0x2d/0x90
>  kernel: vfs_write+0xb8/0x370
>  kernel: ksys_write+0xbb/0xd0
>  kernel: ? syscall_trace_enter.isra.15+0x169/0x220
>  kernel: do_syscall_64+0x37/0x80
>
> Zhu Yanjun
>
>  in rxe_resp.c
> > This could be caused by a race between shutting down the qp and finishing up an RDMA read.
> > The responder resources state machine is completely unprotected from simultaneous access by
> > verbs code and bh code in rxe_resp.c. rxe_resp is a tasklet so all the accesses from there are
> > serialized but if anyone makes a verbs call that touches the responder resources it could
> > cause problems. The most likely (only?) place this could happen is qp shutdown.
> >
> > Bob
> >
> >
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> >
> > index 60a31b718774..66184f5a4ddf 100644
> >
> > --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> >
> > +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> >
> > @@ -489,6 +489,7 @@ int copy_data(
> >
> >                 if (bytes > 0) {
> >
> >                         iova = sge->addr + offset;
> >
> >
> >
> > +                       WARN_ON(!mr);
> >
> >                         err = rxe_mr_copy(mr, iova, addr, bytes, dir);
> >
> >                         if (err)
> >
> >                                 goto err2;
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> >
> > index 1d95fab606da..6e3e86bdccd7 100644
> >
> > --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> >
> > +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> >
> > @@ -536,6 +536,7 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
> >
> >         int     err;
> >
> >         int data_len = payload_size(pkt);
> >
> >
> >
> > +       WARN_ON(!qp->resp.mr);
> >
> >         err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
> >
> >                           payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
> >
> >         if (err) {
> >
> > @@ -772,6 +773,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
> >
> >         if (!skb)
> >
> >                 return RESPST_ERR_RNR;
> >
> >
> >
> > +       WARN_ON(!mr);
> >
> >         err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
> >
> >                           payload, RXE_FROM_MR_OBJ);
> >
> >         if (err)
> >
