Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8164E3EC5
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Mar 2022 13:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiCVMvq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Mar 2022 08:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbiCVMvp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Mar 2022 08:51:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E9B2E0A0
        for <linux-rdma@vger.kernel.org>; Tue, 22 Mar 2022 05:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647953417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PhveZTGN0h/vS9NmxXXstYNT18cOT72G9MSmwKlcb4E=;
        b=Og35q0Cao6Z5eFOC0J/16Jb+6eOK+2rVgLKnIdmZxlYlECs4Cgy0S85w4yafhNibZWSW1s
        9PgrDD/cZd/N9rMuaA/Io8HlfnGwX/eL+SN5pKPCYqasH0xO6lWYklzw6RzX5XaarjZnCt
        DyxSUYjj2enWdzwwDv8n3w0jj7BB6ns=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-lpEZAl3cPvKYsR7udavMSg-1; Tue, 22 Mar 2022 08:50:16 -0400
X-MC-Unique: lpEZAl3cPvKYsR7udavMSg-1
Received: by mail-pg1-f198.google.com with SMTP id t129-20020a637887000000b003851a93bf4bso854435pgc.9
        for <linux-rdma@vger.kernel.org>; Tue, 22 Mar 2022 05:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PhveZTGN0h/vS9NmxXXstYNT18cOT72G9MSmwKlcb4E=;
        b=TeTOiGtBMy7kZyO2Ma0W66HhunNAOnvYId4ZDE+Xp78UTnq87vWNGmzMhI5hy96Xpz
         sRVq58biAGeweDuC7yuM63ZqFXtJ+RPfMPEFjviv/9124RCE30suCDXVlNSVM/klWzRT
         NkUFbxiVLcCbrhsrJzUE8DOrgDbNlgpy/D8zKeudM5gpb3zNdLwMv2ZlrDlzTKhBYnhx
         m/xxFddqagzXFAmkLrhXZ//egCEu3pHCCtrT9j3g5S9RSJ1+PZzUQJdBCnvVbIMmvRJl
         nQop4/vfnDi0N1pK5hc4UDc8y784F+2znRDjRDeHtdCDEZsURJBbzkKnhlVOznh3vvCa
         FhmQ==
X-Gm-Message-State: AOAM533SIvoG5+eDrLHTT47Kt87Yd0mV3x/GdvdQ3IUGxfxw2ZzLOImQ
        mS1d3ulXryyy22XDKjhsizi+gpP+xeOLG03UhgPMtn7WAqcMMCCmTEEFa3TanPnqil4OF6ck0st
        Ds+f9ukEFEjomImekqsU91/7WOtD31g8PB0aJpA==
X-Received: by 2002:aa7:8004:0:b0:4fa:c50c:1ffe with SMTP id j4-20020aa78004000000b004fac50c1ffemr35119pfi.40.1647953414906;
        Tue, 22 Mar 2022 05:50:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLnFYgel0MDxcAclGPXOl7DEEjJFFlxPmtSZj49QkL/5VyFNSZKfptbYYBiUftRVxXIcHkZmsGbDYh9k+kBtQ=
X-Received: by 2002:aa7:8004:0:b0:4fa:c50c:1ffe with SMTP id
 j4-20020aa78004000000b004fac50c1ffemr35100pfi.40.1647953414680; Tue, 22 Mar
 2022 05:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8vnLXyddEJkV_1Dbmn7UaM4sLX=C1CN9tuA-5Mhczayw@mail.gmail.com>
 <9d9abd33-51f2-5a8e-9df9-8ffe72e3a30b@nvidia.com> <CAHj4cs_uViOtdMmFmJZ=htBXybjUP3uL3LnRR0C4PCnHWUM82A@mail.gmail.com>
 <bbb103d5-7622-dc88-07b8-1edc684d2f82@nvidia.com> <CAHj4cs_L=QHh4XeOJGfibfSJhhijS6s7RBNuLd_XetKT3hfjWQ@mail.gmail.com>
 <9ba8bfae-2363-e331-83c7-317a9456da31@grimberg.me> <CAHj4cs9cmOt=9++wuqJ1ehLPDJcaXJGyTKcHSjU-avWxr1CBrA@mail.gmail.com>
 <f5394785-aafa-784c-9ac0-b4abe19f65be@grimberg.me> <CAHj4cs_WQg752czaR4mtaZVPRW6ZqO16EAHZ10njRB+g+8gOOQ@mail.gmail.com>
 <CAFj5m9KD+AUn1nJ=XaqwuuWz4TQgZ+d8Uxq8n7j3adHvg8gR0A@mail.gmail.com>
In-Reply-To: <CAFj5m9KD+AUn1nJ=XaqwuuWz4TQgZ+d8Uxq8n7j3adHvg8gR0A@mail.gmail.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Tue, 22 Mar 2022 20:50:02 +0800
Message-ID: <CAHj4cs8mHOvXdd5FTzGEYmHYn+ACrq=rHf4HfYm1c=+Ma24QEg@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: kmemleak observed on 5.17.0-rc5 with
 nvme-rdma testing
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Nitzan Carmi <nitzanc@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 22, 2022 at 3:36 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Tue, Mar 22, 2022 at 12:58 PM Yi Zhang <yi.zhang@redhat.com> wrote:
> >
> > On Mon, Mar 21, 2022 at 5:25 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> > >
> > >
> > > >>>>> # nvme connect to target
> > > >>>>> # nvme reset /dev/nvme0
> > > >>>>> # nvme disconnect-all
> > > >>>>> # sleep 10
> > > >>>>> # echo scan > /sys/kernel/debug/kmemleak
> > > >>>>> # sleep 60
> > > >>>>> # cat /sys/kernel/debug/kmemleak
> > > >>>>>
> > > >>>> Thanks I was able to repro it with the above commands.
> > > >>>>
> > > >>>> Still not clear where is the leak is, but I do see some non-symmetric
> > > >>>> code in the error flows that we need to fix. Plus the keep-alive timing
> > > >>>> movement.
> > > >>>>
> > > >>>> It will take some time for me to debug this.
> > > >>>>
> > > >>>> Can you repro it with tcp transport as well ?
> > > >>>
> > > >>> Yes, nvme/tcp also can reproduce it, here is the log:
> > >
> > > Looks like the offending commit was 8e141f9eb803 ("block: drain file
> > > system I/O on del_gendisk") which moved the call-site for a reason.
> > >
> > > However rq_qos_exit() should be reentrant safe, so can you verify
> > > that this change eliminates the issue as well?
> >
> > Yes, this change also fixed the kmemleak, thanks.
> >
> > > --
> > > diff --git a/block/blk-core.c b/block/blk-core.c
> > > index 94bf37f8e61d..6ccc02a41f25 100644
> > > --- a/block/blk-core.c
> > > +++ b/block/blk-core.c
> > > @@ -323,6 +323,7 @@ void blk_cleanup_queue(struct request_queue *q)
> > >
> > >          blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
> > >
> > > +       rq_qos_exit(q);
> > >          blk_sync_queue(q);
> > >          if (queue_is_mq(q)) {
> > >                  blk_mq_cancel_work_sync(q);
>
> BTW,  the similar fix has been merged to v5.17:

Thanks Ming, confirmed the kmemleak was fixed on v5.17

>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=daaca3522a8e67c46e39ef09c1d542e866f85f3b
>
> Thanks,
>


-- 
Best Regards,
  Yi Zhang

