Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAB04B666C
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 09:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiBOIpH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 03:45:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiBOIpG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 03:45:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C61B2111F88
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 00:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644914695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uKQ3RZSnULkv8Z5LFmlalSDQprwN6Pd1FNpR2Q5Px8Y=;
        b=T7Ll38TqkevK/Y3tn6vOVI5CxA5rUrKmcBsim8Xhzmh52+lBTbtO+vdCACnt72aQF9Zhcm
        iejXLoH/b/wLC656pMpNkpOqzmmUZ1R0WCeSadIy9WGCxSgsW6+7B6BR2W2dds7JpX49Mg
        x4MpAVs7tfjI0XOXsP3lZ76CQnvMBS8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-4l3EvFJcMmiE-2dlaxzy8g-1; Tue, 15 Feb 2022 03:44:54 -0500
X-MC-Unique: 4l3EvFJcMmiE-2dlaxzy8g-1
Received: by mail-lf1-f72.google.com with SMTP id 27-20020ac25f1b000000b0043edb7bf7e7so5943939lfq.20
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 00:44:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKQ3RZSnULkv8Z5LFmlalSDQprwN6Pd1FNpR2Q5Px8Y=;
        b=0Oxe2TuBnXZ8jxeX6QxAkLiML7SB1fbNoYG7k3lID/Jnn0v8wMvSLHR+uhWCS8IoOq
         1kj6beUspegJfIB2UJalPkMjRq4exx7NXF/mclB2jbBkBE62p741NaNRQnqvMXhZJq09
         g9eZxGcrvHpZEe1mk6VVqNPMYOV1Q8sXgYcRfclrWvKBn8Uu6vOcNqFcdh9ANb9HwxTI
         fN0PfeaCdlceJdRPx7fEXdewaPeSa/WPkC9Q2PuPdPWxaMBGDNj8N9ijr/CnXXjJBRsK
         ELSQHvqxrdXRY7zHEo4SO3OOQxUUuYMhbs2f1hxduKCI0OgLPf++Bb9pqWKrGHXTjt5J
         dJ2g==
X-Gm-Message-State: AOAM533bqRZLoOI+eAfK96LpAZdNTYgdNd8NTAwLZBaQQJC8gjTMJyc8
        xSjjGN9L/TspCWKtrWa1x+Qw1bwf0AI5EbXyB9EI3UCiit9WuJXZgAqNFuFIl+mnmXKnshBf18g
        QfV3cRDTLnPNBuwO+JuIOVb7gTux0U4FL06W23w==
X-Received: by 2002:ac2:4437:: with SMTP id w23mr2385933lfl.481.1644914693119;
        Tue, 15 Feb 2022 00:44:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyttIoN2NhPnCEEtdz7fyFzm3FWFsdrVFccAp9WDKt+gQbEotqXBL06038svFXuv138AX/LGv8g+4UuORQg3ek=
X-Received: by 2002:ac2:4437:: with SMTP id w23mr2385911lfl.481.1644914692928;
 Tue, 15 Feb 2022 00:44:52 -0800 (PST)
MIME-Version: 1.0
References: <20220215081353.10351-1-weijunji@bytedance.com>
In-Reply-To: <20220215081353.10351-1-weijunji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 15 Feb 2022 16:44:41 +0800
Message-ID: <CACGkMEv44vBkUD4YZHg-irzNfxsKjZ4kMZH91LkEYfmmWWhsBA@mail.gmail.com>
Subject: Re: [RFC] Virtio RDMA
To:     Junji Wei <weijunji@bytedance.com>
Cc:     Doug Ledford <dledford@redhat.com>, jgg@ziepe.ca,
        mst <mst@redhat.com>, yuval.shaia.ml@gmail.com,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Virtio-Dev <virtio-dev@lists.oasis-open.org>,
        Yongji Xie <xieyongji@bytedance.com>,
        =?UTF-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        zhoujielong@bytedance.com, zhangqianyu.sys@bytedance.com,
        linux-rdma@vger.kernel.org
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

On Tue, Feb 15, 2022 at 4:15 PM Junji Wei <weijunji@bytedance.com> wrote:
>
> Hi all,
>
> This RFC aims to introduce our recent work on VirtIO-RDMA.
>
> We have finished a draft of VirtIO-RDMA specification and a vhost-user
> RDMA demo based on the spec.This demo can work with CM/Socket
> and UD/RC QP now.
>
> NOTE that this spec now only focuses on emulating a soft
> RoCE (RDMA over Converged Ethernet) device with normal Network Interface
> Card (without RDMA capability). So most Infiniband (IB) specific features
> such as Subnet Manager (SM), Local Identifier (LID) and Automatic Path
> Migration (APM) are not covered in this specification.
>
> There are four parts of our work:
>
> 1. VirtIO-RDMA driver in linux kernel:
> https://github.com/weijunji/linux/tree/virtio-rdma-patch
>
> 2. VirtIO-RDMA userspace provider in rdma-core:
> https://github.com/weijunji/rdma-core/tree/virtio-rdma
>
> 3. VHost-User RDMA backend in QEMU:
> https://github.com/weijunji/qemu/tree/vhost-user-rdma
>
> 4. VHost-User RDMA demo implements with DPDK:
> https://github.com/weijunji/dpdk-rdma
>
>
> To test with our demo:
>
> 1. Build Linux kernel with config INFINIBAND_VIRTIO_RDMA
>
> 2. Build QEMU with config VHOST_USER_RDMA
>
> 3. Build rdma-core and install it to VM image
>
> 4. Build and install DPDK(NOTE that we only tested on DPDK 20.11.3)
>
> 5. Build dpdk-rdma:
>     $ cd dpdk-rdma
>     $ meson build
>     $ cd build
>     $ ninja
>
> 6. Run dpdk-rdma:
>     $ sudo ./dpdk-rdma --vdev 'net_vhost0,iface=/tmp/sock0,queues=1' \
>       --vdev 'net_tap0' --lcore '1-3'
>     $ sudo brctl addif virbr0 dtap0
>
> 7. Boot kernel with qemu with following args using libvirt:
> <qemu:commandline>
>     <qemu:arg value='-chardev'/>
>     <qemu:arg value='socket,path=/tmp/sock0,id=vunet'/>
>     <qemu:arg value='-netdev'/>
>     <qemu:arg value='vhost-user,id=net1,chardev=vunet,vhostforce,queues=1'/>
>     <qemu:arg value='-device'/>
>     <qemu:arg value='virtio-net-pci,netdev=net1,bus=pci.0,multifunction=on,addr=0x2'/>
>     <qemu:arg value='-chardev'/>
>     <qemu:arg value='socket,path=/tmp/vhost-rdma0,id=vurdma'/>
>     <qemu:arg value='-device'/>
>     <qemu:arg value='vhost-user-rdma-pci,page-per-vq,disable-legacy=on,addr=2.1,chardev=vurdma'/>
> </qemu:commandline>
>
> NOTE that virtio-net-pci and vhost-user-rdma-pci MUST in same PCI addresss.
>

A silly question, if RoCE is the focus, why not extending virtio-net instead?

Thanks

