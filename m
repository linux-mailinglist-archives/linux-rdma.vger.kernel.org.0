Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F4F3FEE5A
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 15:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344936AbhIBNIb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 09:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhIBNI2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Sep 2021 09:08:28 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752C0C061757
        for <linux-rdma@vger.kernel.org>; Thu,  2 Sep 2021 06:07:30 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so1409573pjw.2
        for <linux-rdma@vger.kernel.org>; Thu, 02 Sep 2021 06:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tlu2B2vMPrU3SXKIjOqJEI0aXPDLkRUxkJa7dAhyKjE=;
        b=pJuJJ6DXaRoCGXEw0dTDnSqDqH5w9GOq7eyjMqiQoJ4UtD/SMxEOAzwaol/qLcSzN3
         62Y0YYENk/Yn09udevOJiC/qWipZuYHIkkRPTBveAM9WRp1wUOD5MonDQT0Gd9FNajUp
         IBGlc+oRIv+WH0pjZ9Q6wERiGcB3ZmuwiZgzTzx151SRIhd14p+FDh0HIVclMSiaj+ae
         Sn+AKhC2X07ToOZ8a02tfSvR2lTUxGIY3zVtmh3u3VqBbh0R+e/DDnc87/fRV86BQkv9
         U2ETMXIFkz8eKxt4iivTi8vF7XKiiE0gDtiXZp3puoh/wDg3ms8j110l+ab5WewPsnrs
         INzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tlu2B2vMPrU3SXKIjOqJEI0aXPDLkRUxkJa7dAhyKjE=;
        b=q1QXej/Ygkx7bH4J5gATt5bCduvsxIbeRFKSH+E4Skc/iBXDgix5Hkl5CVtSrQAIKK
         xuE71iWBeD15ms428U4Jz+grZjX5OtbEfXl/pgPM6cyRObkWYvS3Ij4xwoZBb1EIGRSR
         lkGrUlV3xvlWxcNiqg47t0cyC9RXMwxWbFu82rSa8YW+v2+qsOoVjXdRF8HkZmtt4/F+
         Ygl4BFwzei605anRItYAclpQEsAOsgrDGR5BlpM16wcsvnVm9dEDIDhUdF7F1iokUH+/
         IqJGfDXG5KKQLm7sxOvuZV9+lXVFGLiyIlqFVJAX/9596rpnOVZv0Kj9fikiaHZIF7YF
         X39w==
X-Gm-Message-State: AOAM532KDf8nUBSBdUFHH819Zp3vXdKGk3YJcAVra7bJESLsQW7VwwaT
        PCwdf3121SZNk/lP9a8QNxnGYg==
X-Google-Smtp-Source: ABdhPJwzBbMxoJ3vXfsWbjXb5S1vXV4ArrFBAb8yGGbduSb1HZou/OYm2WgHnTGNK0wHWsDZ0yB3IA==
X-Received: by 2002:a17:90a:4a05:: with SMTP id e5mr3765653pjh.58.1630588049596;
        Thu, 02 Sep 2021 06:07:29 -0700 (PDT)
Received: from C02FR1DUMD6V.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id d6sm2307415pfa.135.2021.09.02.06.07.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 06:07:28 -0700 (PDT)
From:   Junji Wei <weijunji@bytedance.com>
To:     dledford@redhat.com, jgg@ziepe.ca, mst@redhat.com,
        jasowang@redhat.com, yuval.shaia.ml@gmail.com,
        marcel.apfelbaum@gmail.com, cohuck@redhat.com, hare@suse.de
Cc:     xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
        weijunji@bytedance.com, linux-rdma@vger.kernel.org,
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Subject: [RFC 0/5] VirtIO RDMA
Date:   Thu,  2 Sep 2021 21:06:20 +0800
Message-Id: <20210902130625.25277-1-weijunji@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

This RFC aims to reopen the discussion of Virtio RDMA.
Now this is based on Yuval Shaia's RFC "VirtIO RDMA"
which implemented a frame for Virtio RDMA and a simple
control path (Not sure if Yuval Shaia has any further
plan for it).

We try to extend this work and implement a simple
data-path and a completed control path. Now this can
work with SEND, RECV and REG_MR in kernel. There is a
simple test module in this patch that can communicate
with ibv_rc_pingpong in rdma-core.

During doing this work, we have found some problems and
would like to ask for some suggestions from community:
1. Each qp need two VQ, but qemu default only support 1024 VQ.
   I think it is possible to multiplex the VQ, since the
   cmd_post_send carry the qpn in request.

2. The virtio-rdma device's gid should equal to host rdma
   device's gid. This means that we cannot use gid cache in
   rdma subsystem. And theoretically the gid should also equal
   to the device's netdev's ip address, how can we deal with
   this conflict.

3. How to support DMA mr? The verbs in host cannot support it.
   And it seems hard to ping whole guest physical memory in qemu.

4. The FRMR api need to set key of MR through IB_WR_REG_MR.
   But it is impossible to change a key of mr using uverbs.
   In our implementation, we change the key of WR while post_send,
   but this means the MR can only work with SEND and RECV since we
   cannot change the key in the remote. The final solution may be to
   implement an urdma device based on rxe in qemu, through this we
   can get full control of MR.

5. The GSI is not supported now. And we think it's a problem that
   when the host receive a GSI package, it doesn't know which
   device it belongs to.

Any further thoughts will be greatly welcomed. And we noticed that
there seems to be no existing work for virtio-rdma spec, we are
happy to start it from this RFC.

How to test with test module:

1. Set test module's SERVER_ADDR and SERVER_PORT
2. Build kernel and qemu
3. Build rdmacm-mux in qemu/contrib and run it in backend
4. Boot kernel with qemu with following args using libvirt
<interface type='bridge'>
  <mac address='00:16:3e:5d:aa:a8'/>
  <source bridge='virbr0'/>
  <target dev='vnet1'/>
  <model type='virtio'/>
  <alias name='net0'/>
  <address type='pci' domain='0x0000' bus='0x00' slot='0x02'
   function='0x0' multifunction='on'/>
</interface>

<qemu:commandline>
  <qemu:arg value='-chardev'/>
  <qemu:arg value='socket,path=/var/run/rdmacm-mux-rxe0-1,id=mads'/>
  <qemu:arg value='-device'/>
  <qemu:arg value='virtio-rdma-pci,disable-legacy=on,addr=2.1,
   ibdev=rxe0,netdev=bridge0,mad-chardev=mads'/>
  <qemu:arg value='-object'/>
  <qemu:arg value='memory-backend-ram,id=mb1,size=1G,share'/>
  <qemu:arg value='-numa'/>
  <qemu:arg value='node,memdev=mb1'/>
</qemu:commandline>

Note that virtio-net and virtio-rdma should be in same slot's
function 0 and function 1.

5. Run "ibv_rc_pingpong -g 1 -n 500 -s 20480" as server
6. Run "insmod virtio_rdma_rc_pingping_client.ko" in guest

One note regarding the patchset.
We know it's not standard to collaps patches from two repos. But in
order to display the whole work of Virtio RDMA, we still did it.

Thanks.

patch1: RDMA/virtio-rdma Introduce a new core cap prot (linux)
patch2: RDMA/virtio-rdma: VirtIO RDMA driver (linux)
        The main patch of virtio-rdma driver in linux kernel
patch3: RDMA/virtio-rdma: VirtIO RDMA test module (linux)
        A test module
patch4: virtio-net: Move some virtio-net-pci decl to include/hw/virtio (qemu)
        Patch from Yuval Shaia
patch5: hw/virtio-rdma: VirtIO rdma device (qemu)
        The main patch of virtio-rdma device in linux kernel
-- 
2.11.0

