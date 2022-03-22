Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823054E39C0
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Mar 2022 08:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiCVHoE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Mar 2022 03:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiCVHnz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Mar 2022 03:43:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C92704AE2C
        for <linux-rdma@vger.kernel.org>; Tue, 22 Mar 2022 00:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647934587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wuRrFu5cUVUqipL227+fRPZtFhvEt9/85KsEOXh5jl0=;
        b=jG5rtXDANFU3ViIeSWF7n4QeQNM8+vM/lxbSqVezgWiYigoUs48j4A/1ZssFqhNZ/3r2Jh
        QtT5WIrv+fHZ3C22KDIGiefhi8BoBIziKU87ZIYL26ZNkBYte0p3qA/5cljnj85c1qSiY/
        H4svxUj/lGm3J85JYpo6Qg5QthrzyTU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-ExZvV-HmObKyq9qaCphmzQ-1; Tue, 22 Mar 2022 03:36:26 -0400
X-MC-Unique: ExZvV-HmObKyq9qaCphmzQ-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-2e5a3c1384cso139405947b3.4
        for <linux-rdma@vger.kernel.org>; Tue, 22 Mar 2022 00:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wuRrFu5cUVUqipL227+fRPZtFhvEt9/85KsEOXh5jl0=;
        b=U2HLV8Gjd5NODuVl1TeO8xC1VmMCdNKy2kW9M7V0GxiliHZ2wxSkqp734cIUIZ3F+J
         hfAAaJ2xZid0eiYtfpXohnxjSx3c4gpWfmq60NkJGTt2U1lxyxNI3+GsqfjwBKNWGb4h
         dJx7GqUDB/7HxAP4QpnCXPhN1BPq8LDFpGTSKsENWqT7JmOhrahxZ1jcG4TiBGhPJ35c
         eJOjyLcOwHoV1MeiQnpYvi2vyRKdMEQY3lwCZdlJUaMMVG1DH7Yn5KUV0aT05Kwutj5l
         erCj89ppGJbZp4LR5Th0PZ2oppK1PVs+PGye44+hOOtVC9SWwlOZ+ehgNsD5lLX12Dwm
         vGsQ==
X-Gm-Message-State: AOAM532tANXeMDtpstI2/IUOZLuqa3UAMhWc0s+Of+hKwgYsHSAw+Vbv
        0tonHt8aVTkrJDCLCgofqh55LWwkFVf+ueo68WAdiG+06QWcFn2Spah/K0zzF9Wq7gSB6vPjCvb
        VXJMlMG6rlASgStPl02DbjMYTVRu54ucBf0F/ZQ==
X-Received: by 2002:a25:6e08:0:b0:633:6ade:e95c with SMTP id j8-20020a256e08000000b006336adee95cmr24781873ybc.489.1647934585702;
        Tue, 22 Mar 2022 00:36:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrNJf4CSwm5n2+dQ8e4PKJuYJ746DO4tb+dICt8VHxI9e7TiXuz2wEye8LJChdsYi6q/e266oM9xHuq7awqus=
X-Received: by 2002:a25:6e08:0:b0:633:6ade:e95c with SMTP id
 j8-20020a256e08000000b006336adee95cmr24781859ybc.489.1647934585517; Tue, 22
 Mar 2022 00:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8vnLXyddEJkV_1Dbmn7UaM4sLX=C1CN9tuA-5Mhczayw@mail.gmail.com>
 <9d9abd33-51f2-5a8e-9df9-8ffe72e3a30b@nvidia.com> <CAHj4cs_uViOtdMmFmJZ=htBXybjUP3uL3LnRR0C4PCnHWUM82A@mail.gmail.com>
 <bbb103d5-7622-dc88-07b8-1edc684d2f82@nvidia.com> <CAHj4cs_L=QHh4XeOJGfibfSJhhijS6s7RBNuLd_XetKT3hfjWQ@mail.gmail.com>
 <9ba8bfae-2363-e331-83c7-317a9456da31@grimberg.me> <CAHj4cs9cmOt=9++wuqJ1ehLPDJcaXJGyTKcHSjU-avWxr1CBrA@mail.gmail.com>
 <f5394785-aafa-784c-9ac0-b4abe19f65be@grimberg.me> <CAHj4cs_WQg752czaR4mtaZVPRW6ZqO16EAHZ10njRB+g+8gOOQ@mail.gmail.com>
In-Reply-To: <CAHj4cs_WQg752czaR4mtaZVPRW6ZqO16EAHZ10njRB+g+8gOOQ@mail.gmail.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Tue, 22 Mar 2022 15:36:14 +0800
Message-ID: <CAFj5m9KD+AUn1nJ=XaqwuuWz4TQgZ+d8Uxq8n7j3adHvg8gR0A@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: kmemleak observed on 5.17.0-rc5 with
 nvme-rdma testing
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Nitzan Carmi <nitzanc@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 22, 2022 at 12:58 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> On Mon, Mar 21, 2022 at 5:25 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> >
> >
> > >>>>> # nvme connect to target
> > >>>>> # nvme reset /dev/nvme0
> > >>>>> # nvme disconnect-all
> > >>>>> # sleep 10
> > >>>>> # echo scan > /sys/kernel/debug/kmemleak
> > >>>>> # sleep 60
> > >>>>> # cat /sys/kernel/debug/kmemleak
> > >>>>>
> > >>>> Thanks I was able to repro it with the above commands.
> > >>>>
> > >>>> Still not clear where is the leak is, but I do see some non-symmetric
> > >>>> code in the error flows that we need to fix. Plus the keep-alive timing
> > >>>> movement.
> > >>>>
> > >>>> It will take some time for me to debug this.
> > >>>>
> > >>>> Can you repro it with tcp transport as well ?
> > >>>
> > >>> Yes, nvme/tcp also can reproduce it, here is the log:
> >
> > Looks like the offending commit was 8e141f9eb803 ("block: drain file
> > system I/O on del_gendisk") which moved the call-site for a reason.
> >
> > However rq_qos_exit() should be reentrant safe, so can you verify
> > that this change eliminates the issue as well?
>
> Yes, this change also fixed the kmemleak, thanks.
>
> > --
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 94bf37f8e61d..6ccc02a41f25 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -323,6 +323,7 @@ void blk_cleanup_queue(struct request_queue *q)
> >
> >          blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
> >
> > +       rq_qos_exit(q);
> >          blk_sync_queue(q);
> >          if (queue_is_mq(q)) {
> >                  blk_mq_cancel_work_sync(q);

BTW,  the similar fix has been merged to v5.17:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=daaca3522a8e67c46e39ef09c1d542e866f85f3b

Thanks,

