Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DD34B808F
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Feb 2022 07:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239850AbiBPFyv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Feb 2022 00:54:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbiBPFyu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Feb 2022 00:54:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C3B9C12FB
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 21:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644990878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9/zOJDCborvLsDk+UnjYe3KKK9llSGXkdiknPx3npPc=;
        b=CtWTT200APuGQE6DVySJz7XnjDpbI75z0twOXaOe957S7E6EbnjcuwIEm2n4h9AIMUckWD
        /QZxfnVT3R6I+zwOvs0dTlO4WioqldPcA+ToUDQbnP1TbNljq5E98uvYcHa1WbkYdUgUH9
        To/1ZJ8NhtEDwPWJ6RiBtVIIG9ZOD6M=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-qnRo_0k3Pie2OXbvj1xMGQ-1; Wed, 16 Feb 2022 00:54:36 -0500
X-MC-Unique: qnRo_0k3Pie2OXbvj1xMGQ-1
Received: by mail-lj1-f200.google.com with SMTP id s20-20020a2eb8d4000000b00244c0c07f5aso572547ljp.7
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 21:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9/zOJDCborvLsDk+UnjYe3KKK9llSGXkdiknPx3npPc=;
        b=CtR+Tz0zBZIVjQafuNxvPK2LRheFmLmtLPImkPPBxI/31k2iq7mFkQNHvZ7V0QW9Ut
         DdwZfPT/eKychNer7UVqODrr/o/30nCepk8eyOA4ymoNDVbTAPYXOz8A6T9F3n9fZtsQ
         DfhknO67mgV0q8mWYa2sU6BYktsu0iHMb6oMzBSUZ15DeHAxQ51PSqzZIER5hOCS4OGu
         OGOnMsGmvAN7UYg4UivS7WZUujaM8khrY8mFuv6T3vWCZSexddV9+4b1BztfMgmZgILH
         D0CHP5TOmFOsVXJA81pVIpfD28fC6RfLjEuIUgrW21uT6JmCMqteeJ6nUghFfboxooMs
         WOAw==
X-Gm-Message-State: AOAM530Z9kimwl2Q2LwvIef0JVpPiwzua7FHy0FoYNCfqTJtOCgqi3i1
        PdwVMolsQrw1Z39o+esl+ARaAzSztrqbUdUqyiyDVBQSLegcjZqrF+qF3Utx6mAi/bdmJbB7+pJ
        ltP3CVzYo55sygvdKDlZjzBqoXBTql0EAuy0yfQ==
X-Received: by 2002:a05:6512:2808:b0:43f:4baa:7e5f with SMTP id cf8-20020a056512280800b0043f4baa7e5fmr888200lfb.498.1644990873457;
        Tue, 15 Feb 2022 21:54:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2izysi72OFXqxO6f+Gp/pQM1VMtt893cyMFlSDB7uzpOPgcD2ayQfxjKwsT6YPGEgDqw2GPInC4NCG9raqH4=
X-Received: by 2002:a05:6512:2808:b0:43f:4baa:7e5f with SMTP id
 cf8-20020a056512280800b0043f4baa7e5fmr888143lfb.498.1644990871746; Tue, 15
 Feb 2022 21:54:31 -0800 (PST)
MIME-Version: 1.0
References: <20220215081353.10351-1-weijunji@bytedance.com>
 <CACGkMEv44vBkUD4YZHg-irzNfxsKjZ4kMZH91LkEYfmmWWhsBA@mail.gmail.com> <B07F1166-36A4-4B17-A063-F5447296B99D@bytedance.com>
In-Reply-To: <B07F1166-36A4-4B17-A063-F5447296B99D@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 16 Feb 2022 13:54:20 +0800
Message-ID: <CACGkMEsoKact5us2tHK226ui9fe7DTcMy0BPbE1Ohd0bTpxwWg@mail.gmail.com>
Subject: Re: [RFC] Virtio RDMA
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

On Tue, Feb 15, 2022 at 6:02 PM Junji Wei <weijunji@bytedance.com> wrote:
>
>
> > On Feb 15, 2022, at 4:44 PM, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Tue, Feb 15, 2022 at 4:15 PM Junji Wei <weijunji@bytedance.com> wrote:
> >>
> >> Hi all,
> >>
> >> This RFC aims to introduce our recent work on VirtIO-RDMA.
> >>
> >> We have finished a draft of VirtIO-RDMA specification and a vhost-user
> >> RDMA demo based on the spec.This demo can work with CM/Socket
> >> and UD/RC QP now.
> >>
> >> NOTE that this spec now only focuses on emulating a soft
> >> RoCE (RDMA over Converged Ethernet) device with normal Network Interface
> >> Card (without RDMA capability). So most Infiniband (IB) specific features
> >> such as Subnet Manager (SM), Local Identifier (LID) and Automatic Path
> >> Migration (APM) are not covered in this specification.
> >>
> >> There are four parts of our work:
> >>
> >> 1. VirtIO-RDMA driver in linux kernel:
> >> https://github.com/weijunji/linux/tree/virtio-rdma-patch
> >>
> >> 2. VirtIO-RDMA userspace provider in rdma-core:
> >> https://github.com/weijunji/rdma-core/tree/virtio-rdma
> >>
> >> 3. VHost-User RDMA backend in QEMU:
> >> https://github.com/weijunji/qemu/tree/vhost-user-rdma
> >>
> >> 4. VHost-User RDMA demo implements with DPDK:
> >> https://github.com/weijunji/dpdk-rdma
> >>
> >>
> >> To test with our demo:
> >>
> >> 1. Build Linux kernel with config INFINIBAND_VIRTIO_RDMA
> >>
> >> 2. Build QEMU with config VHOST_USER_RDMA
> >>
> >> 3. Build rdma-core and install it to VM image
> >>
> >> 4. Build and install DPDK(NOTE that we only tested on DPDK 20.11.3)
> >>
> >> 5. Build dpdk-rdma:
> >>    $ cd dpdk-rdma
> >>    $ meson build
> >>    $ cd build
> >>    $ ninja
> >>
> >> 6. Run dpdk-rdma:
> >>    $ sudo ./dpdk-rdma --vdev 'net_vhost0,iface=/tmp/sock0,queues=1' \
> >>      --vdev 'net_tap0' --lcore '1-3'
> >>    $ sudo brctl addif virbr0 dtap0
> >>
> >> 7. Boot kernel with qemu with following args using libvirt:
> >> <qemu:commandline>
> >>    <qemu:arg value='-chardev'/>
> >>    <qemu:arg value='socket,path=/tmp/sock0,id=vunet'/>
> >>    <qemu:arg value='-netdev'/>
> >>    <qemu:arg value='vhost-user,id=net1,chardev=vunet,vhostforce,queues=1'/>
> >>    <qemu:arg value='-device'/>
> >>    <qemu:arg value='virtio-net-pci,netdev=net1,bus=pci.0,multifunction=on,addr=0x2'/>
> >>    <qemu:arg value='-chardev'/>
> >>    <qemu:arg value='socket,path=/tmp/vhost-rdma0,id=vurdma'/>
> >>    <qemu:arg value='-device'/>
> >>    <qemu:arg value='vhost-user-rdma-pci,page-per-vq,disable-legacy=on,addr=2.1,chardev=vurdma'/>
> >> </qemu:commandline>
> >>
> >> NOTE that virtio-net-pci and vhost-user-rdma-pci MUST in same PCI addresss.
> >>
> >
> > A silly question, if RoCE is the focus, why not extending virtio-net instead?
>
> I think it's OK to extend virtio-net to implement virtio-rdma. But if we want to
> support IB in the future, would it be better to implement the virtio-rdma in an
> independent way?

I'm not sure but a question is whether IB is useful to be visible by
the guest. E.g can you implement the soft RoCE backend via IB
hardware?

> And currently virtio-rdma doesn't have a strong dependency on
> virtio-net (except for gid and ah stuffs). Is it OK to mix them up?

There are a bunch of hardware vendors that ship a converged Ethernet
adapter. It simplifies the management and deployment.

Thanks

>
> Thanks.
>

