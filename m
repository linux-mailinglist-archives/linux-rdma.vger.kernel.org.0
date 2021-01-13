Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7092F4030
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Jan 2021 01:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393957AbhAMAnP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jan 2021 19:43:15 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:35628 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392370AbhAMA2g (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 Jan 2021 19:28:36 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffe3e880001>; Wed, 13 Jan 2021 08:27:52 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Jan
 2021 00:27:52 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 13 Jan 2021 00:27:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mck8lxbwn8hVqBmVbEf/dyDpMg6AxEPLzD9yNnouPPO8NMtA6jOaZr/2eGJ8bNgtp6HngJgxkBLUq3aL0vP8slhIfWGm5cS70As0flEuESf3YHemXP/thgCY1m4nZIPojnO+8ngRQKT2RAeN9DHNyDTFOJdFhlLnkO4kxaCRbmMFAiinD15dlpyHcD07b46wOmwocHHTAvYD/2HV1MnaIgBp2x3u1/1ETBoCvDLDvgaWh8Qj0mCo8OsQA+cMbngaJ83PGZLJr46KTnUtvOqKoKu9CqLtpaakTEXN/Z63EIUGQYNsPWcY8EMNEQ3qNuozlf1rXbhLYzvYFQQM6POC1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RE3UhzloRN11v7HGgy/+Q54a4JCL2iKcsXhBz6BXzhM=;
 b=WXBwi8lKIz2zMLP0Gzrri3sTQ35TQh+4ZuK7tzAgzdaKWMbQklwQ75r6ZrvpT4WS6VqoKH22zfBEvJJHHvZP2sQBsTN+1u4WWd5fHjU8RE6WhlbOgse3OeHUWOmb65+ftJwi/lVQuuhJyhMENDigeHtsB7tgxbgoXIZM97YvTXFTLMfVYJLVvdrJ7Jko6B4oP/DOHf0w7nrbTgi6WsrKFwk5zSSpe69ebw8H85CVWoJbjVnmvObnz1MlQWMsspb7ZdmuI1tpNSZVr672/Ld5YiJhIx3zB6jvlwbnR15iqTvBCX0cB2HT9datPETg9tHYl5SW1Tl2al+qUS7PW1RAXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1433.namprd12.prod.outlook.com (2603:10b6:3:73::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 13 Jan
 2021 00:27:47 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 00:27:46 +0000
Date:   Tue, 12 Jan 2021 20:27:44 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next 0/7] RDMA/rxe: cleanup and extensions
Message-ID: <20210113002744.GA48020@nvidia.com>
References: <20201216231550.27224-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201216231550.27224-1-rpearson@hpe.com>
X-ClientProxiedBy: YT1PR01CA0147.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0147.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Wed, 13 Jan 2021 00:27:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kzU0m-000CVd-Dp; Tue, 12 Jan 2021 20:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610497672; bh=RE3UhzloRN11v7HGgy/+Q54a4JCL2iKcsXhBz6BXzhM=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=at02A4rHdqzp9qkkdAbchSoyJY+N24i8pCHiklF2TgTxkh8ohRtFxERFJyvg4CL/C
         /NeeAzg2q33Y+sCh8f1Hq8zPph6/B9M2jgzH7uqYOfhIwEF7xbs/QR7ECs0KvzLOAN
         KF9Eys5A2ReXcBuueSClBEteIQNNEicwEWoA8imUVeyDtGskZJM6GFwYof1Z0MNtSo
         hi08rJodGvHJmQOV3v87Ba7o4VK+oMm3CmxwlHS3onpGtS6BZRwLU0gikVa+cW4HuA
         9W8Kg9YvupURtOXGYwUwPSeZBmp3sx53XaYSzyxaJelbkOUt3d4GCeW/IIb/Mi0Dwt
         qX9nl6kz3EvFg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 16, 2020 at 05:15:43PM -0600, Bob Pearson wrote:
> This patch series makes various cleanups and extensions to the
> object pool core in RDMA/rxe. They are mostly extracted from an
> earlier patch set that implemented memory windows and extended
> verbs APIs but are separated out since they stand on their own.
> 
> Bob Pearson (7):
>   RDMA/rxe: Remove unneeded RXE_POOL_ATOMIC flag
>   RDMA/rxe: Let pools support both keys and indices
>   RDMA/rxe: Add elem_offset field to rxe_type_info
>   RDMA/rxe: Make pool lookup and alloc APIs type safe
>   RDMA/rxe: Make add/drop key/index APIs type safe
>   RDMA/rxe: Add unlocked versions of pool APIs
>   RDMA/rxe: Fix race in rxe_mcast.c

The bug fix is worth doing and though not ideal it is not worse than
anything else in rxe. If you want to revise things as I suggested a
followup would be fine.

Also, the pool index mode can be completely replaced with an xarry,
including the bitmap allocator thing.

So applied to for-next

Thanks,
Jason
