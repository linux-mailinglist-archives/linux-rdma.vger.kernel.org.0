Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A972F4B814B
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Feb 2022 08:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiBPHU3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Feb 2022 02:20:29 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiBPHU2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Feb 2022 02:20:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D00F0E4499
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 23:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644996012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KqtwqLtGbxhQIx5ehb7kGvtrY5iEbChN1LUJ9eN4Alk=;
        b=YSac8xVkEealowdcvLqWByLO1M/99dW+54mZBffbfh6UX6k5ZGvjo+PpPogUltUqqw8RHZ
        LOkbr6vWcrMFLxNNotCLwMP0/Xa7OsHSv79hE3FXZQC4FI4XmnD4q2uA+auYdFpghyrTnb
        tvA8BIuSabCfjOz0zmE2ADZHeD5bwkw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-Ir6XK09gMAmQqPIJj7ZiZg-1; Wed, 16 Feb 2022 01:58:33 -0500
X-MC-Unique: Ir6XK09gMAmQqPIJj7ZiZg-1
Received: by mail-lf1-f70.google.com with SMTP id z37-20020a0565120c2500b004433b7d95d3so379322lfu.4
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 22:58:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KqtwqLtGbxhQIx5ehb7kGvtrY5iEbChN1LUJ9eN4Alk=;
        b=bLXrhfgyRX1q/rByodx7ECEK4oSlcOgey3vwopirIOQuMDGoXh94JlU+GgS4mHIH7X
         bCP4L9CXC6NoLUqJCe/OwoKElyaGF87WD9PrLISHE9Qie+zsI8TyHse2rV2+KkdJgS/8
         O5MtIHJHNyKsH67xnj/rLGwS/eaW/v36DSaTLFSYdi1vumzxMd6EWRnmRkyCwez2PPpR
         Ru8SU2z3wVSTepYx+7Mwf3VEFqOzg6sh0y6jwBS0VWhFNwDxXUEVCoN7qMJu6rAWI3JR
         lp25RKLVPQ5kHIctFzlgDciuMMp1QP7As0yZdGZ2/iLWkYzbWwLGI0Ozb1lALimsYB+O
         zOaA==
X-Gm-Message-State: AOAM533VMz2UXh3oqhGqnaH0+UWn8pg3ZFTFBIEKv7A2wty3JInd2jFa
        CKzAI2rb4BJoR2aCGDEHDxoYfobsiHQ/S82wNft4qfLQ7j9Re2ObeDaGmZxSx03YOgs06Z4aqBe
        FQ6il8NvY3jjHxLTSWBtpJK/vskpp0f8ONrb/uw==
X-Received: by 2002:a05:6512:3a81:b0:443:3ae7:33af with SMTP id q1-20020a0565123a8100b004433ae733afmr1037847lfu.481.1644994711482;
        Tue, 15 Feb 2022 22:58:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRf4Xtg21/celZg9RVv8kD+6iVViDEy2gbjzUdhMAdILr6XLqwq6h2P4tj9MJD6euLlUIZE5aIuXv4jD0ee00=
X-Received: by 2002:a05:6512:3a81:b0:443:3ae7:33af with SMTP id
 q1-20020a0565123a8100b004433ae733afmr1037824lfu.481.1644994711242; Tue, 15
 Feb 2022 22:58:31 -0800 (PST)
MIME-Version: 1.0
References: <20220215081353.10351-1-weijunji@bytedance.com>
 <CACGkMEv44vBkUD4YZHg-irzNfxsKjZ4kMZH91LkEYfmmWWhsBA@mail.gmail.com>
 <B07F1166-36A4-4B17-A063-F5447296B99D@bytedance.com> <CACGkMEsoKact5us2tHK226ui9fe7DTcMy0BPbE1Ohd0bTpxwWg@mail.gmail.com>
 <19CC8304-C2B3-45A7-BFDB-28E9D0D4A02A@bytedance.com>
In-Reply-To: <19CC8304-C2B3-45A7-BFDB-28E9D0D4A02A@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 16 Feb 2022 14:58:20 +0800
Message-ID: <CACGkMEsafzRWYxEw1YUYHka3sm3tH7qXYhcad++NYcfS6LXFLg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [RFC] Virtio RDMA
To:     Junji Wei <weijunji@bytedance.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        mst <mst@redhat.com>, yuval.shaia.ml@gmail.com,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Virtio-Dev <virtio-dev@lists.oasis-open.org>,
        Yongji Xie <xieyongji@bytedance.com>,
        =?UTF-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        zhoujielong@bytedance.com, zhangqianyu.sys@bytedance.com,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 16, 2022 at 2:50 PM Junji Wei <weijunji@bytedance.com> wrote:
>
>
>
> > On Feb 16, 2022, at 1:54 PM, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Tue, Feb 15, 2022 at 6:02 PM Junji Wei <weijunji@bytedance.com> wrote:
> >>
> >>
> >>> On Feb 15, 2022, at 4:44 PM, Jason Wang <jasowang@redhat.com> wrote:
> >>>
> >>> On Tue, Feb 15, 2022 at 4:15 PM Junji Wei <weijunji@bytedance.com> wrote:
> >>>>
> >>>> Hi all,
> >>>>
> >>>> This RFC aims to introduce our recent work on VirtIO-RDMA.
> >>>>
> >>>> We have finished a draft of VirtIO-RDMA specification and a vhost-user
> >>>> RDMA demo based on the spec.This demo can work with CM/Socket
> >>>> and UD/RC QP now.
> >>>>
> >>>> NOTE that this spec now only focuses on emulating a soft
> >>>> RoCE (RDMA over Converged Ethernet) device with normal Network Interface
> >>>> Card (without RDMA capability). So most Infiniband (IB) specific features
> >>>> such as Subnet Manager (SM), Local Identifier (LID) and Automatic Path
> >>>> Migration (APM) are not covered in this specification.
> >>>>
> >>>> There are four parts of our work:
> >>>>
> >>>> 1. VirtIO-RDMA driver in linux kernel:
> >>>> https://github.com/weijunji/linux/tree/virtio-rdma-patch
> >>>>
> >>>> 2. VirtIO-RDMA userspace provider in rdma-core:
> >>>> https://github.com/weijunji/rdma-core/tree/virtio-rdma
> >>>>
> >>>> 3. VHost-User RDMA backend in QEMU:
> >>>> https://github.com/weijunji/qemu/tree/vhost-user-rdma
> >>>>
> >>>> 4. VHost-User RDMA demo implements with DPDK:
> >>>> https://github.com/weijunji/dpdk-rdma
> >>>>
> >>>>
> >>>> To test with our demo:
> >>>>
> >>>> 1. Build Linux kernel with config INFINIBAND_VIRTIO_RDMA
> >>>>
> >>>> 2. Build QEMU with config VHOST_USER_RDMA
> >>>>
> >>>> 3. Build rdma-core and install it to VM image
> >>>>
> >>>> 4. Build and install DPDK(NOTE that we only tested on DPDK 20.11.3)
> >>>>
> >>>> 5. Build dpdk-rdma:
> >>>>   $ cd dpdk-rdma
> >>>>   $ meson build
> >>>>   $ cd build
> >>>>   $ ninja
> >>>>
> >>>> 6. Run dpdk-rdma:
> >>>>   $ sudo ./dpdk-rdma --vdev 'net_vhost0,iface=/tmp/sock0,queues=1' \
> >>>>     --vdev 'net_tap0' --lcore '1-3'
> >>>>   $ sudo brctl addif virbr0 dtap0
> >>>>
> >>>> 7. Boot kernel with qemu with following args using libvirt:
> >>>> <qemu:commandline>
> >>>>   <qemu:arg value='-chardev'/>
> >>>>   <qemu:arg value='socket,path=/tmp/sock0,id=vunet'/>
> >>>>   <qemu:arg value='-netdev'/>
> >>>>   <qemu:arg value='vhost-user,id=net1,chardev=vunet,vhostforce,queues=1'/>
> >>>>   <qemu:arg value='-device'/>
> >>>>   <qemu:arg value='virtio-net-pci,netdev=net1,bus=pci.0,multifunction=on,addr=0x2'/>
> >>>>   <qemu:arg value='-chardev'/>
> >>>>   <qemu:arg value='socket,path=/tmp/vhost-rdma0,id=vurdma'/>
> >>>>   <qemu:arg value='-device'/>
> >>>>   <qemu:arg value='vhost-user-rdma-pci,page-per-vq,disable-legacy=on,addr=2.1,chardev=vurdma'/>
> >>>> </qemu:commandline>
> >>>>
> >>>> NOTE that virtio-net-pci and vhost-user-rdma-pci MUST in same PCI addresss.
> >>>>
> >>>
> >>> A silly question, if RoCE is the focus, why not extending virtio-net instead?
> >>
> >> I think it's OK to extend virtio-net to implement virtio-rdma. But if we want to
> >> support IB in the future, would it be better to implement the virtio-rdma in an
> >> independent way?
> >
> > I'm not sure but a question is whether IB is useful to be visible by
> > the guest. E.g can you implement the soft RoCE backend via IB
> > hardware?
>
> We can't. So do you mean we can implement virtio-rdma only for IB in the future?

It's probably virtio-IB but we need to listen to others.

>
> >> And currently virtio-rdma doesn't have a strong dependency on
> >> virtio-net (except for gid and ah stuffs). Is it OK to mix them up?
> >
> > There are a bunch of hardware vendors that ship a converged Ethernet
> > adapter. It simplifies the management and deployment.
>
> Virtio-rdma is not depend on virtio-net, we can bind it to another ethernet device
> via mac address in the future. And is it too mass to mix up two different device
> in one spec?

So either should be fine, we just need to figure out which one is
better. What I meant is to extend the virtio-net to be capable of
converged ethernet.

Thanks

>

