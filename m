Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBA3458A70
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Nov 2021 09:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbhKVIYP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Nov 2021 03:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhKVIYP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Nov 2021 03:24:15 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A31C061574
        for <linux-rdma@vger.kernel.org>; Mon, 22 Nov 2021 00:21:09 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id e3so73159942edu.4
        for <linux-rdma@vger.kernel.org>; Mon, 22 Nov 2021 00:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqezybGM75pn1RIV8vLF5iQsITglcUqVO2AuqRdfsbI=;
        b=RZeUiXxxa3AdbQHg1XoSMhFKv99XNlZmpFzxU8X9yg07A1DUhpeDnysUCcRa1CMbNH
         aCIRfNr2Kz9I8I75ORR2rHfZaY9r7HZaBQZ+omAaLZIIA0MhZ0HIHtWQ87Q2xsRPVpIS
         fEzeEkNoIJ0Ry7OKky9KFsQpgvdK36YtN2kwVS4A53dv80UU+tTIfgQ6zC/XGjqmxv/A
         T153bhunWgcY3tN9R51kdiGm1ycuRk3dKEMKLBpwpxlG7ZG71CcISVZ0FQp/PiTtP91s
         V53a9pghvr4Uyks1/BH4rjT+mqM89DkJWkrJRVIbfaqXUYSIvPMzOH9oF1LXffMOZQjM
         HocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqezybGM75pn1RIV8vLF5iQsITglcUqVO2AuqRdfsbI=;
        b=dbg0jXjEMrJTCRJmf8QkmGI5r/UrEmJoUiUU3QoAnrGbV3XmSU64nAhYp2XM1OwZ3g
         Nqe27xsE8PG5AptNUOhnWuxG3AAWiTDM56xkEJLcnsVtNemrqJjLVafw5bYBj05D+I1q
         pTd7SHlUabhEwMZ2hRt2XYG75mfJ77/ZILAjNexvIKsgZQ8ID2fS/wMqeO0VPyCuucfx
         QS2d+c4gHrZ1gUzbeD5eJrl6nmHkQfUrjsHCakgAHq/aKJi1RY8eF1taBOhnEg/amhyY
         GaQJumJVrop3k9S1XUg0iGyJrFksC2hNdvZ+05mrTtCzrw+DPv39yCKG6nzy207TOl20
         w6Ow==
X-Gm-Message-State: AOAM533u/JbZg8yt/5RKzpdO4/IEkOKK8fOEizUm41vOnP2daz7qapKU
        n2PTKq+phW8SM5EcA+IK8Xyhyv/IROvZHZ7U+Yt78GqL8wo=
X-Google-Smtp-Source: ABdhPJzWnV2p+48rLcGEi0mcekIexn+SFfMFlzNF5E6FlPjJfPabtti0rvQhGVhlu4aFlw1V0FhKDqWW3+ZKHYZ76cA=
X-Received: by 2002:a05:6402:5246:: with SMTP id t6mr62474516edd.18.1637569267675;
 Mon, 22 Nov 2021 00:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20211121142223.22887-1-guoqing.jiang@linux.dev> <YZtKUpNhxAFS43yy@unreal>
In-Reply-To: <YZtKUpNhxAFS43yy@unreal>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 22 Nov 2021 09:20:57 +0100
Message-ID: <CAMGffE=mPPChgd1tZkpKGCtMqxYx8B5wSTCZgkJKtJ+ajsGn-g@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs: Call {get,put}_cpu_ptr to silence a debug
 kernel warning
To:     Leon Romanovsky <leon@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 22, 2021 at 8:44 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Sun, Nov 21, 2021 at 10:22:23PM +0800, Guoqing Jiang wrote:
> > With preemption enabled (CONFIG_DEBUG_PREEMPT=y), the following appeared
> > when rnbd client tries to map remote block device.
> >
> > [ 2123.221071] BUG: using smp_processor_id() in preemptible [00000000] code: bash/1733
> > [ 2123.221175] caller is debug_smp_processor_id+0x17/0x20
> > [ 2123.221214] CPU: 0 PID: 1733 Comm: bash Not tainted 5.16.0-rc1 #5
> > [ 2123.221218] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
> > [ 2123.221229] Call Trace:
> > [ 2123.221231]  <TASK>
> > [ 2123.221235]  dump_stack_lvl+0x5d/0x78
> > [ 2123.221252]  dump_stack+0x10/0x12
> > [ 2123.221257]  check_preemption_disabled+0xe4/0xf0
> > [ 2123.221266]  debug_smp_processor_id+0x17/0x20
> > [ 2123.221271]  rtrs_clt_update_all_stats+0x3b/0x70 [rtrs_client]
> > [ 2123.221285]  rtrs_clt_read_req+0xc3/0x380 [rtrs_client]
> > [ 2123.221298]  ? rtrs_clt_init_req+0xe3/0x120 [rtrs_client]
> > [ 2123.221321]  rtrs_clt_request+0x1a7/0x320 [rtrs_client]
> > [ 2123.221340]  ? 0xffffffffc0ab1000
> > [ 2123.221357]  send_usr_msg+0xbf/0x160 [rnbd_client]
> > [ 2123.221370]  ? rnbd_clt_put_sess+0x60/0x60 [rnbd_client]
> > [ 2123.221377]  ? send_usr_msg+0x160/0x160 [rnbd_client]
> > [ 2123.221386]  ? sg_alloc_table+0x27/0xb0
> > [ 2123.221395]  ? sg_zero_buffer+0xd0/0xd0
> > [ 2123.221407]  send_msg_sess_info+0xe9/0x180 [rnbd_client]
> > [ 2123.221413]  ? rnbd_clt_put_sess+0x60/0x60 [rnbd_client]
> > [ 2123.221429]  ? blk_mq_alloc_tag_set+0x2ef/0x370
> > [ 2123.221447]  rnbd_clt_map_device+0xba8/0xcd0 [rnbd_client]
> > [ 2123.221462]  ? send_msg_open+0x200/0x200 [rnbd_client]
> > [ 2123.221479]  rnbd_clt_map_device_store+0x3e5/0x620 [rnbd_client
> >
> > To supress the calltrace, let's call get_cpu_ptr/put_cpu_ptr pair in
> > rtrs_clt_update_rdma_stats to disable preemption when accessing per-cpu
> > variable.
> >
> > Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
> > index f7e459fe68be..6ff72f2b1a3a 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
> > @@ -169,9 +169,10 @@ static inline void rtrs_clt_update_rdma_stats(struct rtrs_clt_stats *stats,
> >  {
> >       struct rtrs_clt_stats_pcpu *s;
> >
> > -     s = this_cpu_ptr(stats->pcpu_stats);
> > +     s = get_cpu_ptr(stats->pcpu_stats);
> >       s->rdma.dir[d].cnt++;
> >       s->rdma.dir[d].size_total += size;
> > +     put_cpu_ptr(stats->pcpu_stats);
>
> I see that this_cpu_ptr() is used in many other places in rtrs-clt-stats.c,
> why do we need to change only one place?

Right, indeed. guoqing, mind to respin?

Thanks
>
> Thanks
>
> >  }
> >
> >  void rtrs_clt_update_all_stats(struct rtrs_clt_io_req *req, int dir)
> > --
> > 2.31.1
> >
