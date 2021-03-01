Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E5A328C71
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Mar 2021 19:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239852AbhCASwe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Mar 2021 13:52:34 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15517 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240699AbhCAStH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Mar 2021 13:49:07 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603d36fa0000>; Mon, 01 Mar 2021 10:48:26 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 18:48:25 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 1 Mar 2021 18:48:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ad3pEExzE3kNIsy91Iu9HEIH7tMptR1PPdlN8H20A6TqhXE04rUhcq6mHV/UIFALjngggwCsXCOfgeu+gQyIRoMQkdb9L9Wn259YDDkEl8LYeuM5ku9jA79/ijnRGszlIZFaYQGpUTSdrxrZ2JBT8PtZYwslSx3MCoaMuYwMHjoO0AQalcgQuG51WBroH35ax0qDncUVEfZYNUOyH5zXYdyLCj39TvCDYMIcssrOHQ51teBrG7v+3K8o9RNxzGREQjkx2tejK4XrC74YscfZ8WEZ1jdtGo7isJIhq9N4pmKsHBIKrN/UA3L0yLAZlKjsu/2U3VydiPFu/hhVCOwMgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/FMzIvPA82Lzn4BD/Z9n1ZuqGkNQHw+/H13WBUX7wA=;
 b=iILTHXtJ12dra/wsHeBIfda2RpoLveQvegQJYyJSfB5pnpPrdMsAUWG+xWbaZx3AbBKBd7AncduBgUWfXTwDJcmMHl5IIK4Krh+Y51nYF+Z2LAkm2C5jglaX9jc2fbk8urobfoszkrnc5kN/TBTWsXAfwX5RMmlv3Cmca4nL72dXNtmLbZ6Ki/8F2kRlyqOcha+nh33oGlch2F9G9W2G5Uj+gfmy9ViZ0tHzk7swdBtv1emURg20OeBV5OFzowawgLGq7HD2ISZGnVZD82N+yKFepAaEdgXj4y1z8X+LtOUlyKBK5dl8+tVNSFWynHouXweGliOE2MEfYpd5ydJXpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1515.namprd12.prod.outlook.com (2603:10b6:4:6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.20; Mon, 1 Mar 2021 18:48:24 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3890.026; Mon, 1 Mar 2021
 18:48:24 +0000
Date:   Mon, 1 Mar 2021 14:48:23 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Julian Braha <julianbraha@gmail.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: infiniband: sw: rxe: fix kconfig dependency on
 CRYPTO
Message-ID: <20210301184823.GB745887@nvidia.com>
References: <21525878.NYvzQUHefP@ubuntu-mate-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <21525878.NYvzQUHefP@ubuntu-mate-laptop>
X-ClientProxiedBy: MN2PR19CA0009.namprd19.prod.outlook.com
 (2603:10b6:208:178::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR19CA0009.namprd19.prod.outlook.com (2603:10b6:208:178::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 18:48:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lGnah-00383i-1A; Mon, 01 Mar 2021 14:48:23 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614624506; bh=8/FMzIvPA82Lzn4BD/Z9n1ZuqGkNQHw+/H13WBUX7wA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=X+DJ3J+K72z7cbRp3HJkZRD53LqmOTqNq/uJEobj9ZJISO3Pu6z5r3I1F/01/Nq11
         JLrKvEn1oGtszGFP2zGd9FwMAMfKeGgrbygTrlNAaykFBqShCe2kHBxR0b3LLTrU6B
         p8TMvGTnzLXG6DljIddmoe1VaqNQBWNbYCHf8MRLmG25/OBF07ccYuwjnJo7ZrSRno
         VkwhC5kVkHvuHw0IGc+uf5teP2uvUHs7UwvTlWtvIMzqKEk2GHmil41c6BIHkRiE74
         5JYmbYkQJIY746au6tm8c+5sF3E7qviXdCqN5wp2N3xjw2PU6v4tRiqfDGO/uFTidk
         gtOMCgq7x9N+A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 19, 2021 at 06:32:26PM -0500, Julian Braha wrote:
> commit 6e61907779ba99af785f5b2397a84077c289888a
> Author: Julian Braha <julianbraha@gmail.com>
> Date:   Fri Feb 19 18:20:57 2021 -0500
> 
>     drivers: infiniband: sw: rxe: fix kconfig dependency on CRYPTO
>     
>     When RDMA_RXE is enabled and CRYPTO is disabled,
>     Kbuild gives the following warning:
>     
>     WARNING: unmet direct dependencies detected for CRYPTO_CRC32
>       Depends on [n]: CRYPTO [=n]
>       Selected by [y]:
>       - RDMA_RXE [=y] && (INFINIBAND_USER_ACCESS [=y] || !INFINIBAND_USER_ACCESS [=y]) && INET [=y] && PCI [=y] && INFINIBAND [=y] && INFINIBAND_VIRT_DMA [=y]
>     
>     This is because RDMA_RXE selects CRYPTO_CRC32,
>     without depending on or selecting CRYPTO, despite that config option
>     being subordinate to CRYPTO.
>     
>     Signed-off-by: Julian Braha <julianbraha@gmail.com>

Your patch was horribly mangled in patchworks, I fixed it, but you
need to send patches properly if you intend to send more to the kernel

Applied to for-rc

Thanks,
Jason
