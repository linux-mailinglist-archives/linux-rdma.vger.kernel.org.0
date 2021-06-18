Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF0E3AD0C4
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 18:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhFRQ4M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 12:56:12 -0400
Received: from mail-mw2nam12on2045.outbound.protection.outlook.com ([40.107.244.45]:47104
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229730AbhFRQ4M (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Jun 2021 12:56:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIS9ybwd3e1/Xz805392yoaoS93M9SdiyU0j/vemI19tbQWQdQftQF7g6yV8kTIJyfNxVtIKwoh17gGs5AQ2ZhyDy793CTZRaTF3majn+cyu1Y5HKPsrV20gmGPJI9J7kqB8VHWFtpvhIQZ0RqnoJzLlT8hqv8WbaoaMlEAdN0C79g9RZwIR8NBq9P9oDmKX7ATWonVOqQ+TxEqJPBbDp1tGaHfZ9aEUW8rPymU4+62hErD9cDmTZt/4QEETR842Gwwr0AL7G6k+bh4ChxGh8KgJUTapeUUPLgTBI7sZPdt2fv8sOXY5WJgG3AgQT4OYuj/T4SYC7Y+6FltLS0CrhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYUSjJT0cW+iYj8U0NXIlI9AIh3X7XGYpxrCmeTzb5g=;
 b=bdNfURNCH7QkSGu9XCS5+IxKHg7OVBKVy+6jrhdzHzYftMCeNxs8Tng+XlgGPqB+dcvGSzgXuy/ipuC1s6ICqwRwwNLw1UKzF7VwJcY9BaYhrL1nvSlrLnxymDhZdkOG5yrA18nWZox0wQBR1YuRCRjMuWUg7GMfbePN0FZgu4j6N/BOSC4BvUC8XuZ098Bbv15ejoXSdmCwMTU1kjeZt/ZqfwCdIIwDchzY0czLJmffHh68HdV76uN9HM6QSyT/D/yjvjGqOTwD2vrc0b09UTP92mWfUtTW0ILpTBUtldOsNAQnCxX9lnAGRkbBB9bSwAMsqExtSj4hML6zW1DoRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYUSjJT0cW+iYj8U0NXIlI9AIh3X7XGYpxrCmeTzb5g=;
 b=QqA/9ZCIg0oPoiMiSF3pxMMdensiXd6usOR29Mvw/PG2+z2WavGb7VF2k7Ngoud+Vg+lm7F16iIov4QFq7hzijxk2dUEZu1+mSEIyzyUPab37j3dlNGJYZEevDmPvNhVZvmIRGdYqwRm0Mp18hsWschSyq1yQ0ZvSykAYSU5lfEzTvecd5JzBfN6CNCqilXQeuPwXAq5buHgrxUaxPjQE7zE4t7hvyr+TxPf4Lr0pQMsF/B6F6XzkIk2RgPl1D+X7cP3Me8iBtVbLHtTAQxH3BIgcIuET8X+ASayFEO/0dVVcywRVHFcftuuakW0pvRdWWOJwzni+T+nP4mC3v9lsw==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5287.namprd12.prod.outlook.com (2603:10b6:208:317::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 16:54:01 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 16:54:01 +0000
Date:   Fri, 18 Jun 2021 13:54:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, haris.iqbal@ionos.com, axboe@kernel.dk
Subject: Re: [PATCH for-next 0/5] RTRS enable write path fast memory
 regitration
Message-ID: <20210618165400.GA2052769@nvidia.com>
References: <20210608113536.42965-1-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608113536.42965-1-jinpu.wang@ionos.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0382.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::27) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0382.namprd13.prod.outlook.com (2603:10b6:208:2c0::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.10 via Frontend Transport; Fri, 18 Jun 2021 16:54:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1luHkm-008c1t-Eq; Fri, 18 Jun 2021 13:54:00 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eda2791-5739-423e-9357-08d93279ac67
X-MS-TrafficTypeDiagnostic: BL1PR12MB5287:
X-Microsoft-Antispam-PRVS: <BL1PR12MB528767B173B7351618B0889CC20D9@BL1PR12MB5287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ur8nbyJo1jNN785QHB0nWRJtCNHwYS8pmc4GK3lPQchx/cD/Qz9I//V6GabCoz4ZpCjNdYHp2g+9Uq5QP0nxeh565UYllyfUOanYcO8PTJP5zWmG5px/MzCvXzvD8G+4mXipvEovUfZTDAGVDxVAzOPMZ+/K/z8Uq+mPysm0Fp0giR+vqbeBn7c85jMcnuR3Xb+toF5KZjtF5KFrAJVu7g/bJdhu5IlMP3N+FdkMNjdTAyBHFQaoX1q0S6wv1Lo/UdN4H8KJHVs9UTJTgSM3Bp/Ar1p/7M3l55N0Ov4jbZP/TBkl74DxX9+m/c4Ak7joQO3LRGeAWT3unXKNCJmY5GF4XbVfsHsTrtf/eSg8iYMZz15X3L1VAORNcRVloqpNFSKI3hP8M6NnL7C7vOGB9+h3lAcMWQtBYJ2GY22WF2atd4ao3I++HZhJLJyejCKIABbaC5HawBMyBARyiZYc0pMWqHgIrFk+I1agen7hGBjQ88pWVk260c0dzgAY/3M3hsoTkza4H6TixeVQRADm5kRf5iPTI3C027lcACkmMBE6va7bwiHDJatcoj79W80JUzn9VehEEo4uhuzmkXOWD5VqZPQnZAH5EMMY/Rpc+BH7p7dlauWfymZr7ueRcE8UPb1GE/GsV9jEg/AwdmTRk05CK7ehA0wMAJLXk4zSczFOHn9GMPXvmA1FMHRX0ZBVF6oT0v1nVEsCcaTnazrfXhV12GNjzbvMrGYfZ6N45P0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(38100700002)(6916009)(9746002)(966005)(9786002)(426003)(26005)(8936002)(2906002)(5660300002)(4326008)(66476007)(66946007)(8676002)(1076003)(478600001)(186003)(2616005)(83380400001)(86362001)(4744005)(33656002)(36756003)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JAq7B5+IXrP6H8bkqgAzj30yf12xJICLIBAdZ3FjzXZ2nYczuErJIXUSQ8fd?=
 =?us-ascii?Q?ffwYSOYOscnyPZeT7ksTwP0SQW/zfiaI1ADYqd3RZKK5WDwFF+HZfOkm0glj?=
 =?us-ascii?Q?6aMgy+MmISHWtUo9enOoJWkxnuXE72NK8XWY59Mw+sJbmz8Wr+U/4zyr5iNa?=
 =?us-ascii?Q?/BFKIybfdg7SD0J9uU9q8jWfugByWE8GqlrIpAtJm2fraLi8L5TUWwnAm1WX?=
 =?us-ascii?Q?iNi9QzmnahZeY00hrINiBMAE+FHFiP86cbGvjxoLMKlJeJy12eHWcd15+E34?=
 =?us-ascii?Q?iHGVWKoS1GTpRenbblsYO26V0fFfphr5CQZLBKkSxScOwXN/xgQOyhBS/lpJ?=
 =?us-ascii?Q?Sg41hybOguy7VVYK90Dx5Tw6ZVEKzemTgkvAq0agd8n+YAAhy0HDgcRGgAxQ?=
 =?us-ascii?Q?W+P2fOdbh9n1RUM0xCDobnYpRoCCpfVq71k6cxYVWE1wlpLx6SdTsAe+aqqD?=
 =?us-ascii?Q?llTrgeRJl3LrOyUzsZh9fVUTdMBTcmdgnSKkz1UuPNIGo/hWXrKMCHMwpoGh?=
 =?us-ascii?Q?iRo+XqI+EpjEEMnUQTi4k0hB6b9K+OjCFkQphciDXQmuUf/k0uIBlClx2dvo?=
 =?us-ascii?Q?hHzz41BGbq0JfPw7nKC1x7umO7v8LfONWVK9y8Txu6oX6IICcuNlbcm4sqmj?=
 =?us-ascii?Q?UJVHreSnS7I+UjfRKvmObhkyn6C/qZVBFkOn8ow0TDof0+v6XNCSHCJ6a6OR?=
 =?us-ascii?Q?ub3Hq+3/wGhBRc2bZn+04nAnOIjDk5BrwNzvWjeSK0A+pye3jOsqs4TI6MhX?=
 =?us-ascii?Q?Tib2EIW+zO/vk09rpcKyOzcM3pYh4NRJQnrPP3xYlpWAq0Bkszpp46OTOgf3?=
 =?us-ascii?Q?lkdbnlHu3czwP8bvgmMvislvnjlyn4gqE/fVcOpHdyp3ciRUe3cw4eIUu6tv?=
 =?us-ascii?Q?8/Cy+8vXYXwCsKc14nDTV2z+uUMh3pFg9d/OBMhPLbOfh+7Ut6U/u7+deMXs?=
 =?us-ascii?Q?qh/u5ieY/sibqDLjqPq91BaXM4RP+itaZTCbZ39fS7nWkG71b2DU2QAIblr0?=
 =?us-ascii?Q?Boj4gCGWWGGxqeh2IXekq/X0Mqe4lMFOuiN/qMBAJrNot37RgY3rEvbNSwAK?=
 =?us-ascii?Q?4hIKV5f7id5/n9rLgcl0ciZ+uP7fDniQfce1psxYbX/bceP7C49xGtuhpC5w?=
 =?us-ascii?Q?3Q3mhIhAcI+MMLKUKaqDz8YAbXAy8hiHQ6Q5yPNutUT67FjdGNn+9vVwKbk+?=
 =?us-ascii?Q?VP3m5061iV4rK7KtToDWA1QZp4uT3+fYqkNjIsPeH78oTQBb4uuPCwLU/Hu5?=
 =?us-ascii?Q?kYs3uebGG7shufUOx8rJTvAahbJnr7DCvv1qHKINLhOPcRcdGMEW9cOddFZI?=
 =?us-ascii?Q?SoTQys11KER3H+m8xmEmDYIE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eda2791-5739-423e-9357-08d93279ac67
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 16:54:01.7364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1au/stzz3MG6Q/nbhri6/sSxGhiaNDWUH87SjYVG95xtIxjAyqP/NybDLUDEw4HT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5287
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 08, 2021 at 01:35:31PM +0200, Jack Wang wrote:
> Hi Jason, hi Doug, hi Jens
> 
> Please consider to include following changes to the next merge window.
> 
> This enables fast memory registration for write IO patch, so rtrs can
> support bigger IO than 116k without splitting. With this in place, both
> read/write request are more symmetric, and we can also reduce the memory
> usage.
> 
> The patchset is orgnized as:
> - patch1 preparation.
> - patch2 implement fast memory registration for write patch.
> - patch3 reduce memory usage.
> - patch4 raise MAX_SGEMENTs
> - patch5 rnbd-clt to query and use the max_sgements setting.
> 
> As the main change is in RTRS, so it's easier to go through RDMA tree, hence
> send this patchset to linux-rdma.
> 
> This patchset depends on: https://lore.kernel.org/linux-rdma/20210608103039.39080-1-jinpu.wang@ionos.com/T/#t

It doesn't apply - please rebase and resend it

Jason
