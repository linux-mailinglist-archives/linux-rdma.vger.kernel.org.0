Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEBD2A04F4
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 13:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgJ3ME1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 08:04:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:50921 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgJ3ME1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Oct 2020 08:04:27 -0400
IronPort-SDR: eBMxhBpxjBR7RjOHFdrG8plM/AK8+zlcDDF0I205DbPl984BmE5d4YbteqUXke71+Ib4cZA26/
 ArOcJPBmqB5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="186401716"
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="186401716"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 05:04:26 -0700
IronPort-SDR: KNs8IDzXh9jPUcKJkno6xLeBW3+TMmboZuD+C1rFkoG5gZV1eVil0Yxt3fFz4z4PV2CA+gRi9P
 p5AxphIkqJdg==
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="537044729"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.203.232]) ([10.254.203.232])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 05:04:24 -0700
Subject: Re: [PATCH] RDMA: Fix software RDMA drivers for dma mapping error
To:     Parav Pandit <parav@nvidia.com>,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca, yanjunz@nvidia.com, bmt@zurich.ibm.com,
        linux-rdma@vger.kernel.org
Cc:     hch@lst.de, syzbot+34dc2fea3478e659af01@syzkaller.appspotmail.com
References: <20201030093803.278830-1-parav@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <c3e63243-765e-adba-69f3-30e286cd8b7d@cornelisnetworks.com>
Date:   Fri, 30 Oct 2020 08:04:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201030093803.278830-1-parav@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/30/2020 5:38 AM, Parav Pandit wrote:
> A cited commit in fixes tag avoided setting dma_mask of the ib_device.
> Commit [1] made dma_mask as mandetory field to be setup even for
> dma_virt_ops based dma devices. Due to which below call trace occurred.
> 
> Fix it by setting empty DMA MASK for software based RDMA devices.
> 
> WARNING: CPU: 1 PID: 8488 at kernel/dma/mapping.c:149
> dma_map_page_attrs+0x493/0x700 kernel/dma/mapping.c:149 Modules linked in:
> CPU: 1 PID: 8488 Comm: syz-executor144 Not tainted 5.9.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 01/01/2011
> RIP: 0010:dma_map_page_attrs+0x493/0x700 kernel/dma/mapping.c:149
> Trace:
>   dma_map_single_attrs include/linux/dma-mapping.h:279 [inline]
> ib_dma_map_single include/rdma/ib_verbs.h:3967 [inline]
>   ib_mad_post_receive_mads+0x23f/0xd60
> drivers/infiniband/core/mad.c:2715
>   ib_mad_port_start drivers/infiniband/core/mad.c:2862 [inline]
> ib_mad_port_open drivers/infiniband/core/mad.c:3016 [inline]
>   ib_mad_init_device+0x72b/0x1400 drivers/infiniband/core/mad.c:3092
>   add_client_context+0x405/0x5e0 drivers/infiniband/core/device.c:680
>   enable_device_and_get+0x1d5/0x3c0
> drivers/infiniband/core/device.c:1301
>   ib_register_device drivers/infiniband/core/device.c:1376 [inline]
>   ib_register_device+0x7a7/0xa40 drivers/infiniband/core/device.c:1335
>   rxe_register_device+0x46d/0x570
> drivers/infiniband/sw/rxe/rxe_verbs.c:1182
>   rxe_add+0x12fe/0x16d0 drivers/infiniband/sw/rxe/rxe.c:247
>   rxe_net_add+0x8c/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:507
>   rxe_newlink drivers/infiniband/sw/rxe/rxe.c:269 [inline]
>   rxe_newlink+0xb7/0xe0 drivers/infiniband/sw/rxe/rxe.c:250
>   nldev_newlink+0x30e/0x540 drivers/infiniband/core/nldev.c:1555
>   rdma_nl_rcv_msg+0x367/0x690 drivers/infiniband/core/netlink.c:195
>   rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>   rdma_nl_rcv+0x2f2/0x440 drivers/infiniband/core/netlink.c:259
>   netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
>   netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
>   netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
> sock_sendmsg_nosec net/socket.c:651 [inline]
>   sock_sendmsg+0xcf/0x120 net/socket.c:671
>   ____sys_sendmsg+0x6e8/0x810 net/socket.c:2353
>   ___sys_sendmsg+0xf3/0x170 net/socket.c:2407
>   __sys_sendmsg+0xe5/0x1b0 net/socket.c:2440
>   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x443699
> 
> [1] commit f959dcd6ddfd ("dma-direct: Fix potential NULL pointer dereference")
> 
> Reported-by: syzbot+34dc2fea3478e659af01@syzkaller.appspotmail.com
> Fixes: e0477b34d9d1 ("RDMA: Explicitly pass in the dma_device to ib_register_device")
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---

Patch did not apply cleanly in rxe but I took the hunk for rdmavt and it 
seems to do the trick. So for the rvt bits:

Tested-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

