Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D5F287F27
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 01:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbgJHXdM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 19:33:12 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:41646 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731038AbgJHXdM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Oct 2020 19:33:12 -0400
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7fa1b50000>; Fri, 09 Oct 2020 07:33:09 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Oct
 2020 23:33:09 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 8 Oct 2020 23:33:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6C/sqxAZf4EWz6JdnE9RZZwnshfvxF5U3ybzgNq0MMZBVhbO0CWn0MjVfcfmMW61K3OXt+ZfsaF03mBWffyIPyMAQq0OpIcF6ZswGi6UCcD36cBhlKMi1AUZ09URbJz3TXVsIVmiONoq97mAms6ltoBlXjAW8o2fOI8rK2XiOHDl7Y8VboY18rHwWJvOqpBFybFWBmulR7JSHTcayAk3+QFgp1YbZT2HiSLW9WuOIA34RnRm1GpvqJLacZUnlFpO/5+K3v5ajaMHw1YI1c/PjAVNdgKjAWTgLU+84TksDIAf5gjfHf4ITfSk7mxjrNjXhRpnpYmK+8lGCiz3K16xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJAhNnZvzlgfNn3HwkwgVEm0RU1YC9CmVV8C1Nb3Q/0=;
 b=LnmzxDaxpWfESu+fAAXe6ucaESWWXADs+I1Bn0/tYxYtRmMxHykulJClaMvzuX2Tim5tryFQc4YC8Sa+fJyP2UG4zcAfcTq2hYyM0zSgnYesPXhuBBEWQTJa87TtH/pb5CxQeoIXDRrgi4H0T0pcOGtCOG8aQoA2ZnC87nGtqxdca7792rgXSpPOZIRcC2tqkHfSn5xv4ToPZCqbof6DgJC2sYhYEBKJ/XvgEnY5+/873NIQkHwuQxO1a3opDx7vfDqmyd6rA+5Fv5rAJXtVjnFNXsNFGqStertvOQg2TFKJgcQ7iGSw2pK3lDg+qVBx9WLJbxZg0m4BREKNc1lAvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Thu, 8 Oct
 2020 23:33:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.046; Thu, 8 Oct 2020
 23:33:07 +0000
Date:   Thu, 8 Oct 2020 20:33:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next] rdma_rxe: fixed bug in rxe_rcv_mcast_pkt
Message-ID: <20201008233305.GA422633@nvidia.com>
References: <20201008203651.256958-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201008203651.256958-1-rpearson@hpe.com>
X-ClientProxiedBy: BL1PR13CA0290.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0290.namprd13.prod.outlook.com (2603:10b6:208:2bc::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.11 via Frontend Transport; Thu, 8 Oct 2020 23:33:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kQfPF-001m4r-Qq; Thu, 08 Oct 2020 20:33:05 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602199989; bh=MJAhNnZvzlgfNn3HwkwgVEm0RU1YC9CmVV8C1Nb3Q/0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=CHK/17rGQ0rAiEkdVw++4f7tIx6g8EKeLHRr3KvfjPihGSORIDUOqK/pPlLYWsJLM
         Ig1BGSxTa1oIuT6b28pJWO9IpLTZRMtxt3E1SWO4Wk1KP82VgnobxjzoiCnb5kHRUW
         d0v8MJTDOdcMD7mw+xtopawLiizxOffRvg8loYC1WSJWaNNKdX1Pia6IOkFhHFOR1z
         RY8BadPuN4RiKem2LKwR3vGPEX8R3eQLAXZoWMMqMj5G7pg18dioJu8lDXpwceTO4g
         OGsf2VRx/UHbz8cJU3iPqmxNc+EtXBXeBp5du2p9JVo0V4fdm74ulRPB+md0AxYosG
         TkqanFPlKVJzQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 08, 2020 at 03:36:52PM -0500, Bob Pearson wrote:
> - The changes referenced below replaced sbk_clone by
>     taking additional references, passing the skb along and
>     then freeing the skb. This deleted the packets before
>     they could be processed and additionally passed bad data
>     in each packet. Since pkt is stored in skb->cb
>     changing pkt->qp changed it for all the packets.
>   - Replace skb_get by sbk_clone in rxe_rcv_mcast_pkt for
>     cases where multiple QPs are receiving multicast packets
>     on the same address.
>   - Delete kfree_skb because the packets need to live until
>     they have been processed by each QP. They are freed later.
> 
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> Fixes: 86af61764151 ("IB/rxe: remove unnecessary skb_clone")
> Fixes: fe896ceb5772 ("IB/rxe: replace refcount_inc with skb_get")

Fixes lines go before the Signed-off-by

Makes sense to me, applied to for-next

Thanks,
Jasno
