Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075103DF887
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Aug 2021 01:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbhHCXds (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 19:33:48 -0400
Received: from mail-dm6nam10on2086.outbound.protection.outlook.com ([40.107.93.86]:36769
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231966AbhHCXdr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Aug 2021 19:33:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOOJnzdUIkVUM9Re2mFBOxuWPpqs7ZqzagofOdz+xWIlZL4voKz099bsvhK+bnk8kJnIjf16z4lfYeh2MWYK1sQxfpbmfwgfl5G/yPoZx3KnQCP448YX9xg8sI6YfmL6IwGtkavSF7/U491m1rWYlsxvy5Y7pQjHY0PwSddPPo8HCSeeNaY3EVtvHQp6G7+ItaqSnA5uOsrypobFeZKbqu+CScXgy7G5FmGSuJLcgBfX0J9p4Idfp5OEZP+v7fsftON27HoSe+qWf97080htik6y0TVyjqGLAorgmY1BnNgUlKa+5Vwd258Xto8Lyx1I6c0gnssvQ7p0MYT04xLkyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XnMgJ2OFmhjdESmKwpF/X1seMoP2rRGz5Ja1j3hI0A=;
 b=UlBxf3LAVsnBzSYR9qh9TpGuo87tknAuxacdWzXDdAWw+CYa1SOEnqzUQL189M1ue9Revce4O0n7eFbSQ+wVj3zcvM1rCXMsrg5mqwVDKQjFRYBh+aSn4nq8fkpz3+jkuo1TvnbJtoTGD+v+ycxNltnx7i9o1vg0vwKQSrGZV4nc/tEUZJ205yJpTYhA9jgArPtkY6FTTYKlXkkW2nWdrFdH8ZElW+g8sSMEQriHaG/esxP7pk3insUscNDa65I83D7N/AykTMRBw84Y994SVrQ90T1yxdivB7bbsRLm6fnP0h6pH0oDfa6/8MPxfLW9t05VGFqpfQ7JnOcJ1q1qDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XnMgJ2OFmhjdESmKwpF/X1seMoP2rRGz5Ja1j3hI0A=;
 b=WRnTZ7MsM7upeKZz5pwS34sOItxBIR1PI5tFHqy5Z9ytJ1ptnb9mbCW04SsCswW0OcUxhI2lk1t3oZnrY0TYoQz+FtPKA64XA0v38f0YtHCwTH0MFroeQiNXTAFmUvns4l/ZJ2FL8yDYfRj6OYVEHvuZTijoKkRqp/UCO9YAqLNh0amwYzAG3j7jAw+hfzTdWoI7CfIF15iofxSTRVamiubZeLt+ymzg98HB2RU4JX+63PJvauNW98t9giPMTFV563Hzd82pGUcEsNA+C/od/ACo2qTL8/lasi9j36Xiq3waEvj7jt+p47TI5IDnD0fQ8svrU+1rr0NFLcmv/bdHdQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5096.namprd12.prod.outlook.com (2603:10b6:208:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Tue, 3 Aug
 2021 23:33:33 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 23:33:33 +0000
Date:   Tue, 3 Aug 2021 20:33:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH rdma-next v1 0/7] Separate user/kernel QP creation logic
Message-ID: <20210803233331.GA2935025@nvidia.com>
References: <cover.1626857976.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1626857976.git.leonro@nvidia.com>
X-ClientProxiedBy: YT1PR01CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::48)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 23:33:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mB3ud-00CJXj-MQ; Tue, 03 Aug 2021 20:33:31 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a785469-2dcd-45e1-531c-08d956d71bb2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5096057EBC57C4B6C9DC1798C2F09@BL1PR12MB5096.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hD0FEF1UzPqly0BvMcd9gVBrgDUbbi8HMTCaIs0Wc89kAQNgYGBXRLy6mCNBDZlmm0NZuUNAMPl1st1/BeMV6joJRyf9KsKqv5+nElhZ75MiFPbwdoCSSXSE7MBjdtpzSKNLTHbCnTmBI0bjH3vc3888+vu7jUx8hvI97v1AxgnRzr3hraUo6aqpCWt/PnbJKvW0+2Gbdd4ycUX69SaHNI+cvIhzi0XfXSYhg17AqD4N6XeVgRP88yr2KL96W1v60AIh2xKJWXjsQMFlkd4sj5TLTiWuJIPY6MHyy0qeg8A16N/1m062lqT0URL/ci68IPBC1TYR3HdmSns/eN4c5l6b1Zo/1A2TjJQ9Mtx/hYIw0QvVq4jRIXzkO6XMSaKgBHQRlCT/IjYswH8oembfMEUcCD3WdPqQzDXMTqTrBQ1IXIfhmNQb4GoA6rvXzOUdJDeGEPSmXtBkFv6VC/s0kmd7fDCtlVWHmxN0anYZv/nPaJ29rMnxW51yXSc8Im/qCZCEAv32xI2DB9PIzna7/YVKtWCGNho0fJNcDdqaWjuuywQ7VZfoyD6QDODCfQ87cCA/oPbIrMxP7G1+TmbDLV+00I48svEe1KIg1rc/k1jTKC6llCtXtcd/OFVwRKKSXyagPRl2wtW5Ipbv8cISSZlm2BBfHBT24A75g+wAVoc+16aJ/Cq50kxHHt+tdjIN7O/w+6KuVeD2VpeXBPpUKriHP0uYc9+Q1qG/RgRQvyk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(5660300002)(6916009)(2616005)(426003)(966005)(478600001)(33656002)(86362001)(83380400001)(8676002)(66946007)(66476007)(66556008)(36756003)(1076003)(26005)(2906002)(54906003)(9786002)(316002)(4326008)(9746002)(8936002)(38100700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wnAdNKHuVkgZCKSLiYRK2tBawC1zJz3kFVBmJ4bo38piEVpPm4NuVv/aekPP?=
 =?us-ascii?Q?vduyf9HRyw1MvOqhE2AQ9mkSSAytFk5fZJf72hU0swQSHWFSwC5H8EuYqSMr?=
 =?us-ascii?Q?1ChA+GZgCMcjmZtUae9iU2q5+kH/zJuz7mNFaHzg1wePYOmzTSzEAoCRpbOd?=
 =?us-ascii?Q?NVBE5UiLAEaiIDCdQ2bHS55iSm+kWoe+Ocnz9GyhDiXkuhczM/t5eBcng/ZN?=
 =?us-ascii?Q?otigNYXAON5LvUJbNCN1dGY+eKXgyNzPPIFznKV62MrZZZxG2mNnhywVdtO9?=
 =?us-ascii?Q?XjnsTM9pFdyAYjaVpuIp5K/BPtdr7Mg/G1V42rODLfeuIHsD+acXTSYgqe5v?=
 =?us-ascii?Q?GQKof3JZHe11s2uyE1Ca1RkCMJ3GciKhGiY4yIwhqmIOY0zn7vVJiHvohv6y?=
 =?us-ascii?Q?Igt8i85QSUHxCPQf62aMgSglwFUEn1J/joEfSAE8SbA6k+r9jE6f4mdbb5At?=
 =?us-ascii?Q?tVoGEjYoT6JK05LogHpyoMkTTTXc4LNfVpy5Nuq78gay2ORVkgcbWV5vWH6P?=
 =?us-ascii?Q?TT0HupG+ap/i304FZWupjO4R0D6GbTGugNVi4702O3+6yHloMiWpMGrJdPfw?=
 =?us-ascii?Q?Hs1E/bBdnMsOMpTQWX4kkcjQx7clSAqbDjCXedYce5/2pYe0it8EiavtjW3S?=
 =?us-ascii?Q?uEhwJPXXNOAM5eZDSdBd+T50xqLxtInCqm5OF+qNFdj9VxYqKQdfE5yNXYML?=
 =?us-ascii?Q?JcXkqfDjliiRivRNBGj3CU+aumHrVVxOATpMkY7nYNjYZgSrvE77NooTx7gZ?=
 =?us-ascii?Q?VVxqYeBqBwozhhZm+BzmC2YhfJsLn0bvLFE5Zs997OR50ASni4IIgbNqUdWI?=
 =?us-ascii?Q?L5fRJ0e/rZJlv4vpOEnws0uUGbUgc5u1md3Jjt9/uuOjLSoSMhts4VfNK0p4?=
 =?us-ascii?Q?XW48oB/bXaBbL5gInNNKypSRfLNKJzo5BVIIndUNQnRHtoGguGPNozbXihEv?=
 =?us-ascii?Q?W7Q9LALnO3X5L6afuPLcobzcs4h0vBxh3yhNQ7SMSInXstE/KVms0RS2PPZi?=
 =?us-ascii?Q?XfAngRfyVR4OH+w/3nD1rPt6FkvMqCPBJW4UWEJ4bOwQkWAdVf5suWOaQ8pm?=
 =?us-ascii?Q?yH+AQWyFQFiZhxIZsJKTO7SM2noBJotKKpiqpsjmkIeXqGvGEYu628cCOFQB?=
 =?us-ascii?Q?XpJqHdY0ZXYbkPFueQUMfoyWiWi6XJ0mlg/JoYuQZPzqB/ElKwgpSu6s2ZPj?=
 =?us-ascii?Q?n49id+VaSoh9Rx3OjZ3sVRw9HvmBsNuMMxuZu5pqzAdpOBimlVF+WPrkAnj/?=
 =?us-ascii?Q?XnaMN/1jfT6at6eB019Ejw6jALF2oaln2C4ozYovm8yZcrNJWZRXtON2kWWY?=
 =?us-ascii?Q?O0M1uFmHIN6I6oIpuNTTsxvk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a785469-2dcd-45e1-531c-08d956d71bb2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 23:33:33.5540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APEBHeR5mBxpPHExbfWrQX1biMGPutuQO6BSqNFPmnb9+TL8DQq4iKngYMWQS7Sf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5096
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 21, 2021 at 12:07:03PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Changelog:
> iv1:
>  * Fixed typo: incline -> inline/
>  * Dropped ib_create_qp_uverbs() wrapper in favour of direct call.
>  * Moved kernel-doc to the actual ib_create_qp() function that users will use.
> v0: https://lore.kernel.org/lkml/cover.1626846795.git.leonro@nvidia.com
> 
> Hi,
> 
> The "QP allocation" series shows clearly how convoluted the create QP
> flow and especially XRC_TGT flow, where it calls to kernel verb just
> to pass some parameters as NULL to the user create QP verb.
> 
> This series is a small step to make clean XRC_TGT flow by providing
> more clean user/kernel create QP verb separation.
> 
> It is based on the "QP allocation" series.
> 
> Thanks
> 
> Leon Romanovsky (7):
>   RDMA/mlx5: Delete not-available udata check
>   RDMA/core: Delete duplicated and unreachable code
>   RDMA/core: Remove protection from wrong in-kernel API usage
>   RDMA/core: Reorganize create QP low-level functions
>   RDMA/core: Configure selinux QP during creation
>   RDMA/core: Properly increment and decrement QP usecnts
>   RDMA/core: Create clean QP creations interface for uverbs

Applied to for-next, thanks

Jason
