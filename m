Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDAF2A33EB
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Nov 2020 20:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgKBTUa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 14:20:30 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14692 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgKBTUa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Nov 2020 14:20:30 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa05bfe0001>; Mon, 02 Nov 2020 11:20:30 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Nov
 2020 19:20:29 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 2 Nov 2020 19:20:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtR5i+Qq3k+CHqSNK4APB3Of8bZ33FxiiiRxn4fe9mSzIHEmYbhL+SR65dEZScRfb86GWBLcWBLGe09CmBIRmIiZBMxffcsZGcgyU+PbfDxsUTrawhvAaZT2qgDI8tFCxT6AMYRZN7n6C6CpquSu/p4dTyFJgw3MLhR7U9vELimihgTC+21QxNFOwOpUPNuTjIMxROcWT/6LOeBwDkzDGua4t37eRy0yLqPZiEhbMG4M41KSRthoXkXTrZY8/8cGjzH4claoiQuvKot+odiAFAXqk8dl9Az7f/RDWOj0G9y/5ItXpT6xqb36PLKHlF/yhvb5kiaVSy2aDy3W/rClmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZwU3bFVK/ohEyGMVrc2KlHCHbB0QVBxkH+ZpGhVrgc=;
 b=DdcJh33z0e/IFIsEGCsmPNWai9wk0N9cqr6vPVov8yhzpWefeHvW5HMipMhNetjs/n9dcFEQikuPvEXPypO9D160N7Cb9yxSqGNTXrrHyUMe/fGcj+pWUFc7ltkV1trujzgOlUHBzU4rX4uFeEYfWa0WxkXpg7tb5EGUqgpqpdqrA7/XTPmRN8wFZou+0F6ktTubjYBAdas3SRsfTr3qK6uhvAImv9ZoNKdB3moWxkOGKvYQ02vUo6jSl/bOhGUV2AFeJPwj3K239IrrgbUsnJ49I2kRTpJ8NtlPHM4jqnWnB8Kok8paqZtozNNWXj1Pu4A4tQwdkVdJv3TPqhoRjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 19:20:29 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 19:20:28 +0000
Date:   Mon, 2 Nov 2020 15:20:26 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Parav Pandit <parav@nvidia.com>
CC:     <dennis.dalessandro@cornelisnetworks.com>,
        <mike.marciniszyn@cornelisnetworks.com>, <dledford@redhat.com>,
        <yanjunz@nvidia.com>, <bmt@zurich.ibm.com>,
        <linux-rdma@vger.kernel.org>, <hch@lst.de>,
        <syzbot+34dc2fea3478e659af01@syzkaller.appspotmail.com>
Subject: Re: [PATCH] RDMA: Fix software RDMA drivers for dma mapping error
Message-ID: <20201102192026.GA3706203@nvidia.com>
References: <20201030093803.278830-1-parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201030093803.278830-1-parav@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0172.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0172.namprd13.prod.outlook.com (2603:10b6:208:2bd::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend Transport; Mon, 2 Nov 2020 19:20:28 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kZfNS-00FYAb-VL; Mon, 02 Nov 2020 15:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604344830; bh=pZwU3bFVK/ohEyGMVrc2KlHCHbB0QVBxkH+ZpGhVrgc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=I7/IW63qWybn4vw6Fzc5co0GS1FeeXPl+IVeIop/qxvbxRgcMNAr5p6K+C73rb5A3
         7N5xkkOjNgSFRsXpXHC6KyVE0UzjAKDDx8rzVeC7RWdNELcPp6qqfqTPu1xTdMT6Ue
         P2+dPwvqGd7U8hIP7jC0+RgOKrepTgCEwGjMSYV5Be0m4iixsVOAyiV9RTM67+WFN4
         2Dp4fN6/LUU13kUfg5rLL/zZn8rzbYnSptckYP+TURRIRuzLbpG4QnPnJ3NvocPSIC
         y6rZXlqNO7IC9zZzBLydQJpL5qpLQFYaQm6hP3eFXWfoHAdS7ND9yHF7zYl+zm8mQx
         cU4/PGy6U/zwg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 30, 2020 at 11:38:03AM +0200, Parav Pandit wrote:
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
>  dma_map_single_attrs include/linux/dma-mapping.h:279 [inline]
> ib_dma_map_single include/rdma/ib_verbs.h:3967 [inline]
>  ib_mad_post_receive_mads+0x23f/0xd60
> drivers/infiniband/core/mad.c:2715
>  ib_mad_port_start drivers/infiniband/core/mad.c:2862 [inline]
> ib_mad_port_open drivers/infiniband/core/mad.c:3016 [inline]
>  ib_mad_init_device+0x72b/0x1400 drivers/infiniband/core/mad.c:3092
>  add_client_context+0x405/0x5e0 drivers/infiniband/core/device.c:680
>  enable_device_and_get+0x1d5/0x3c0
> drivers/infiniband/core/device.c:1301
>  ib_register_device drivers/infiniband/core/device.c:1376 [inline]
>  ib_register_device+0x7a7/0xa40 drivers/infiniband/core/device.c:1335
>  rxe_register_device+0x46d/0x570
> drivers/infiniband/sw/rxe/rxe_verbs.c:1182
>  rxe_add+0x12fe/0x16d0 drivers/infiniband/sw/rxe/rxe.c:247
>  rxe_net_add+0x8c/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:507
>  rxe_newlink drivers/infiniband/sw/rxe/rxe.c:269 [inline]
>  rxe_newlink+0xb7/0xe0 drivers/infiniband/sw/rxe/rxe.c:250
>  nldev_newlink+0x30e/0x540 drivers/infiniband/core/nldev.c:1555
>  rdma_nl_rcv_msg+0x367/0x690 drivers/infiniband/core/netlink.c:195
>  rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>  rdma_nl_rcv+0x2f2/0x440 drivers/infiniband/core/netlink.c:259
>  netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
>  netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
>  netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
> sock_sendmsg_nosec net/socket.c:651 [inline]
>  sock_sendmsg+0xcf/0x120 net/socket.c:671
>  ____sys_sendmsg+0x6e8/0x810 net/socket.c:2353
>  ___sys_sendmsg+0xf3/0x170 net/socket.c:2407
>  __sys_sendmsg+0xe5/0x1b0 net/socket.c:2440
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x443699

Do not word wrap oops reports!
 
> [1] commit f959dcd6ddfd ("dma-direct: Fix potential NULL pointer dereference")
> 
> Reported-by: syzbot+34dc2fea3478e659af01@syzkaller.appspotmail.com
> Fixes: e0477b34d9d1 ("RDMA: Explicitly pass in the dma_device to ib_register_device")
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Tested-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> Tested-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by:  Zhu Yanjun <yanjunz@nvidia.com>
> ---
>  drivers/infiniband/sw/rdmavt/vt.c     | 7 +++++--
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 6 +++++-
>  drivers/infiniband/sw/siw/siw_main.c  | 7 +++++--
>  3 files changed, 15 insertions(+), 5 deletions(-)

Applied to for-rc, thanks

Jason
