Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93452A3418
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Nov 2020 20:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbgKBTdF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 14:33:05 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:35213 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbgKBTdE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Nov 2020 14:33:04 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa05eef0000>; Tue, 03 Nov 2020 03:33:03 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Nov
 2020 19:33:03 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 2 Nov 2020 19:33:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCCaAh4abFG2NRAMyyMVpWgqt3pexiQ+YPlSL3G2K2DBa4e0T8X4/xMCSmizvMPWFTot3bLqvoHYFF5SgSzN4wy5w1DSqxZL5Gy+315PCsT1jN78QMUi5Rx2vxc30f2jqfrm3NxhDO868Ud8tEEQDPpzSYTSvRckv07WbQi8MJP6wtYf2+ZdOZSZcw03fBT1O0nXcJAVYvZ1QJlNPiySaD55dYbEux+BMf0pYJAJJNkR1LL6TsWDvjxYsBUpRQtXM17l7mrnezQuSZ7OfKulevu29of6QTS0LoA8OiLimlAP3O617OVA+y9KNNfBTtQHPJy63ne3+bgT371wBgBBoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gW4LN7hstwWYoX7t4X0eISHDjiDp+nVGLB1HDH73Sng=;
 b=jbz2RSpbgF30gPJJiZ0CQ0WACahr0riXQe80aoOzFhc5MVszZ8ahbSxYmb9Z9U4qUYqTh1qKieJhTx7Dq8Iyc08CDm9i6Oa2ONm2irGkStDXp4KDKm5R5cEf/XauFuIROZb1nUGY8RTHb1V/U5/HVh5hqKRKfl5mJ+MQkIeRWnQd/MRsJkM4933Q6Wbctiu3Cz8GG73Ls+/4AIrzNHw/B1732xpVY97tDtheN3HmXD4lt6HqHglXVrrReklk5YMYUeUk4x84M250Dw1jIougWRAixE4kuziXvar4mWA0pcEWEGEfMWj8TnVkUv5L4ugqlnHHe2h1ImQVNkvtnqpsgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3932.namprd12.prod.outlook.com (2603:10b6:5:1c1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 19:33:01 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 19:33:00 +0000
Date:   Mon, 2 Nov 2020 15:32:59 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>, <linux-rdma@vger.kernel.org>,
        Zhu Yanjun <yanjunz@nvidia.com>
CC:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH] RDMA/rxe,siw: Restore uverbs_cmd_mask
 IB_USER_VERBS_CMD_POST_SEND
Message-ID: <20201102193259.GA3717667@nvidia.com>
References: <0-v1-4608c5610afa+fb-uverbs_cmd_post_send_fix_jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v1-4608c5610afa+fb-uverbs_cmd_post_send_fix_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:208:c0::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0018.namprd05.prod.outlook.com (2603:10b6:208:c0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend Transport; Mon, 2 Nov 2020 19:33:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kZfZb-00Fc2A-Kg; Mon, 02 Nov 2020 15:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604345583; bh=gW4LN7hstwWYoX7t4X0eISHDjiDp+nVGLB1HDH73Sng=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=aw3mNMckHoTzqXnrRPVFFYQVQ1PNUyg5K20iPhX6wZYVazi1b41dRmAtFTSgLPUkr
         w1lnhwge704kXmTuq6C4bsLdou3hrOaKkZ/pKi63P5CQJHF4EJu+kmKkMMCqkupLDv
         rUZ06W24gsEKA19yomm7pzDzfd8rIT6GjIEqLZ2N/dtglR3VnvjBySqp3v9cLtasAX
         2twQWfCn0wEF8UyZqmcIje0WQj1LrthnV3LlGJpCS9sfbkF75TFDl9Ni/GgU85Y6gr
         HHHNry91ZD+3exJ9UwRS+Q9X384ivdINFb8NxPkmTatje20pPTet5QstwpNNFEIt0q
         EJ4G6TtN5Cazg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 30, 2020 at 11:03:05AM -0300, Jason Gunthorpe wrote:
> These two drivers open code the call to POST_SEND and do not use the
> rdma-core wrapper to do it, thus their usages was missed during the audit.
> 
> Both drivers use this as a doorbell to signal the kernel to start DMA.
> 
> Fixes: 628c02bf38aa ("RDMA: Remove uverbs cmds from drivers that don't use them")
> Reported-by: Bob Pearson <rpearsonhpe@gmail.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 3 ++-
>  drivers/infiniband/sw/siw/siw_main.c  | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)

Applied to for-next

Jason
