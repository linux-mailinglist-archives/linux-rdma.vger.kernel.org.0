Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5536C4B6891
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 11:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiBOKCn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 05:02:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbiBOKCg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 05:02:36 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB10D111DC3
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 02:02:23 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id t14-20020a17090a3e4e00b001b8f6032d96so1686523pjm.2
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 02:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xH1bQIo/hx8vSczTU2m5FGojnhDKQDz7wUzjjN7E5Jw=;
        b=7+ykhh32hSTh2i4ye1B4NTJp1Fx4FzhPECXVxPDkq1u9TGb7mW/b3ifHOn2IL5SthD
         66QPNVySaiNZN9miiqvPyHLVmtEB0KqrFuXqF0LKah9KYGsJ8Cm/lBSglKzf79XyqEH9
         Q2YIs8MY5ag6qolBgxis8MmvfwMl+nlMEAMGApti7Q2ksxoThwjKQkDI/lBW1s1FQ1Oz
         zWCMHyMbEHIWUV5mPyBIG8mw/5UbDRGy5v8ZsRp/B3wI2Y+QoeUgwClWAXsojlboix+k
         ufb3vqaqRyZ+1gtBAm1Zg9UYehBqC8bMh8G/6QmqivmkdUkMEwzJAzSMpuBuLEtmv0Ea
         yPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xH1bQIo/hx8vSczTU2m5FGojnhDKQDz7wUzjjN7E5Jw=;
        b=27wpJK0+1UJwqVUg9qhv8bwqOoVeEBmqZd6G6cQb6h8W+JGiiXf+R2Q/Sc5tkZBkgs
         R9BLgJJYAKmHs1IRA+BMKx2tr2dAKcT6hcekNsywxqrRY7jfc2tVzd4/i+n2Us/LTQdz
         k9SNa9qd2QuhxrX3QgzDyuO++GMXCvS9bs5DQqT28V/i48Nq4VFugW1xov+wG29/rPqC
         7/fBAOf/2hToFpkulf1vr1rKb04ZEJ/X1rsh2FMZL1Z+RFAuVP/tIACPBvCgWPFnJVB0
         rvMHxjl5FE/irofZ2IMgdqQj3DVSZ0HckMAbFLwB21EEAfMawPDHsHilF2tx5pvHRR1S
         kaCA==
X-Gm-Message-State: AOAM533nC+3y8jJQ/PNv3zPTXa57+wsr36foi8VfxR/kJJMXd1J53RfW
        JSGReAJsyTiquSolhIHZOa3SUE8ax/3ftA==
X-Google-Smtp-Source: ABdhPJy4GlxSwAZJ4qG1Fa/7aJVFkIwegJuJN+E/ISNAM0vPMNWnRIxFzbpHCuAXpfLv0TyTVC2zdQ==
X-Received: by 2002:a17:902:f291:: with SMTP id k17mr3552937plc.45.1644919343310;
        Tue, 15 Feb 2022 02:02:23 -0800 (PST)
Received: from smtpclient.apple ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id q8sm43252079pfl.143.2022.02.15.02.02.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Feb 2022 02:02:22 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [RFC] Virtio RDMA
From:   Junji Wei <weijunji@bytedance.com>
In-Reply-To: <CACGkMEv44vBkUD4YZHg-irzNfxsKjZ4kMZH91LkEYfmmWWhsBA@mail.gmail.com>
Date:   Tue, 15 Feb 2022 18:02:16 +0800
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        mst <mst@redhat.com>, yuval.shaia.ml@gmail.com,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Virtio-Dev <virtio-dev@lists.oasis-open.org>,
        Yongji Xie <xieyongji@bytedance.com>,
        =?utf-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        zhoujielong@bytedance.com, zhangqianyu.sys@bytedance.com,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B07F1166-36A4-4B17-A063-F5447296B99D@bytedance.com>
References: <20220215081353.10351-1-weijunji@bytedance.com>
 <CACGkMEv44vBkUD4YZHg-irzNfxsKjZ4kMZH91LkEYfmmWWhsBA@mail.gmail.com>
To:     Jason Wang <jasowang@redhat.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> On Feb 15, 2022, at 4:44 PM, Jason Wang <jasowang@redhat.com> wrote:
>=20
> On Tue, Feb 15, 2022 at 4:15 PM Junji Wei <weijunji@bytedance.com> =
wrote:
>>=20
>> Hi all,
>>=20
>> This RFC aims to introduce our recent work on VirtIO-RDMA.
>>=20
>> We have finished a draft of VirtIO-RDMA specification and a =
vhost-user
>> RDMA demo based on the spec.This demo can work with CM/Socket
>> and UD/RC QP now.
>>=20
>> NOTE that this spec now only focuses on emulating a soft
>> RoCE (RDMA over Converged Ethernet) device with normal Network =
Interface
>> Card (without RDMA capability). So most Infiniband (IB) specific =
features
>> such as Subnet Manager (SM), Local Identifier (LID) and Automatic =
Path
>> Migration (APM) are not covered in this specification.
>>=20
>> There are four parts of our work:
>>=20
>> 1. VirtIO-RDMA driver in linux kernel:
>> https://github.com/weijunji/linux/tree/virtio-rdma-patch
>>=20
>> 2. VirtIO-RDMA userspace provider in rdma-core:
>> https://github.com/weijunji/rdma-core/tree/virtio-rdma
>>=20
>> 3. VHost-User RDMA backend in QEMU:
>> https://github.com/weijunji/qemu/tree/vhost-user-rdma
>>=20
>> 4. VHost-User RDMA demo implements with DPDK:
>> https://github.com/weijunji/dpdk-rdma
>>=20
>>=20
>> To test with our demo:
>>=20
>> 1. Build Linux kernel with config INFINIBAND_VIRTIO_RDMA
>>=20
>> 2. Build QEMU with config VHOST_USER_RDMA
>>=20
>> 3. Build rdma-core and install it to VM image
>>=20
>> 4. Build and install DPDK(NOTE that we only tested on DPDK 20.11.3)
>>=20
>> 5. Build dpdk-rdma:
>>    $ cd dpdk-rdma
>>    $ meson build
>>    $ cd build
>>    $ ninja
>>=20
>> 6. Run dpdk-rdma:
>>    $ sudo ./dpdk-rdma --vdev 'net_vhost0,iface=3D/tmp/sock0,queues=3D1'=
 \
>>      --vdev 'net_tap0' --lcore '1-3'
>>    $ sudo brctl addif virbr0 dtap0
>>=20
>> 7. Boot kernel with qemu with following args using libvirt:
>> <qemu:commandline>
>>    <qemu:arg value=3D'-chardev'/>
>>    <qemu:arg value=3D'socket,path=3D/tmp/sock0,id=3Dvunet'/>
>>    <qemu:arg value=3D'-netdev'/>
>>    <qemu:arg =
value=3D'vhost-user,id=3Dnet1,chardev=3Dvunet,vhostforce,queues=3D1'/>
>>    <qemu:arg value=3D'-device'/>
>>    <qemu:arg =
value=3D'virtio-net-pci,netdev=3Dnet1,bus=3Dpci.0,multifunction=3Don,addr=3D=
0x2'/>
>>    <qemu:arg value=3D'-chardev'/>
>>    <qemu:arg value=3D'socket,path=3D/tmp/vhost-rdma0,id=3Dvurdma'/>
>>    <qemu:arg value=3D'-device'/>
>>    <qemu:arg =
value=3D'vhost-user-rdma-pci,page-per-vq,disable-legacy=3Don,addr=3D2.1,ch=
ardev=3Dvurdma'/>
>> </qemu:commandline>
>>=20
>> NOTE that virtio-net-pci and vhost-user-rdma-pci MUST in same PCI =
addresss.
>>=20
>=20
> A silly question, if RoCE is the focus, why not extending virtio-net =
instead?

I think it's OK to extend virtio-net to implement virtio-rdma. But if we =
want to
support IB in the future, would it be better to implement the =
virtio-rdma in an
independent way? And currently virtio-rdma doesn't have a strong =
dependency on
virtio-net (except for gid and ah stuffs). Is it OK to mix them up?

Thanks.=
