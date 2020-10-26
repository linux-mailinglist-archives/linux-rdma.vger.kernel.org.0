Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F526299A0F
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Oct 2020 00:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395083AbgJZXBK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 19:01:10 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:4844 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395082AbgJZXBJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 19:01:09 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9755340000>; Tue, 27 Oct 2020 07:01:08 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 23:01:08 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 26 Oct 2020 23:01:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQCfOnpP0DB3dhrCBEdcpS/unqDHKXUFyXvBaCwUNbyEWCuZ6YxR0DMcOkwe5nYuQpRJHzdPXR3Nca0P/+OTNbRopk7fXbwKwXFqKOGKOkLYWqx8kTwDwlujV9Xfv85xyhNFru3SxrXyy4Hyj6XEI06qKMFopsp/cDEXW8PijQWxTIIcwD5OrRBhl1vfbmKwzYbYCQXO9//6WQ/avjT76LY2JWDSf1GlHDaru53kCFNDCof1C+GQ5GY7L4DEJC/bZpciTtSzsYSkjZkmjURqzzc5OQ/Ozsl2QLfOW6oR7GnGpGF+ouVBCltSi48ZtVa6xZr2zBhon/xdWQULcVNzXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrYO0+QOHS940qv7dynBguYbu+7jeyYIzT2H9/EQ3zc=;
 b=ZB8TglFfBUxl6o8K0C/186wHlc0h4R+d3HOGZIPRzGRLl0/X5euIxoQGecV6R4mV2uhiXUricr+N22GSAtIXH/Arr/U176UmmILLGO8xFR46iIDVGPmy2nu39Au1onSKZiPVj9gXUrUaaGCe+TEb5Y+oGMK+wfqn5M6FqLVzMcZ6WY0W6FyAmwYhaMerE9CPAV5D9ybH9YbCNCxqCQh/i6Ovk5OEz3YbvRCaqYIm7uQ7pWkkHmcucJdnuSLFqJoUcxyJgdAeAjFmkDANQvFwth7lBkKEEifa+tSKJM4P5doZG4RinYyby6V+ooo6vuXprT8B8hl36BR18+zpM6ENZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1436.namprd12.prod.outlook.com (2603:10b6:3:78::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20; Mon, 26 Oct 2020 23:01:05 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 23:01:05 +0000
Date:   Mon, 26 Oct 2020 20:01:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next] rdma_rxe: remove unused RXE_MR_TYPE_FMR
Message-ID: <20201026230104.GA2160312@nvidia.com>
References: <20201009165112.271143-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201009165112.271143-1-rpearson@hpe.com>
X-ClientProxiedBy: MN2PR16CA0050.namprd16.prod.outlook.com
 (2603:10b6:208:234::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0050.namprd16.prod.outlook.com (2603:10b6:208:234::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Mon, 26 Oct 2020 23:01:05 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXBU8-00940S-2q; Mon, 26 Oct 2020 20:01:04 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603753268; bh=HrYO0+QOHS940qv7dynBguYbu+7jeyYIzT2H9/EQ3zc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=NhDWlrv8PYhYxOLXBsZS3VzUOpYhSEqAr7sjdNGHrZ9SVkFslENQMioFnipHZwz1e
         GM9h7/7pYZPnERU5vQa8LYcVDf3dnJnbE63cNc9VsKDAideX4nHa+UBGDN1IGBUOOW
         0hqUfxasRrvpW2BrAIEvIUz15fTUOE8l21Heu1SCVY6SQRqpnVgAIhnAMsrU0h7rYd
         T+J11nvqQqUXlQclvpl87mRIM8BhU64sc5eA6Kz65N5S6zbiCpqJYJ3JTtCnvTtLcW
         jrQT0Ldnj+cRWkVzKCcrLS8UM1/q15nF7BRSj+49zZ1gSb9ibkx0H1KV3tPQFmOcW9
         iude83fNp8NOA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 09, 2020 at 11:51:13AM -0500, Bob Pearson wrote:
> This is a left over from the past. It is no longer used.
> 
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c    | 1 -
>  drivers/infiniband/sw/rxe/rxe_verbs.h | 1 -
>  2 files changed, 2 deletions(-)

Applied to for-next, thanks

Jason
