Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3114E3CB808
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jul 2021 15:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhGPNtV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Jul 2021 09:49:21 -0400
Received: from mail-co1nam11on2071.outbound.protection.outlook.com ([40.107.220.71]:58432
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232808AbhGPNtV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Jul 2021 09:49:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZEPKGHpdCD3I/mtIZi6rVEulnBIw8iVGiEnh8nPW1egnJB2lfr1Asru5tGn7D9pAfQkSI+l7QONMQfdt0STVIimegctlhWpXZnAXjpRt/wrUoBACbpNfgjlZMPrx7TBBJlKCT3ahP7gWLVXrd/Oumx6RUH4uH+Xq/X4/iUeOKhmhWF2ZhKv47sW+y7xMwR7gR1wz5pjJbtOXrHcd/2RBt3oAyDKWVGpcwY1G8KstbD0PKUnPFms8BBrDXQEFg6yiTmPgKbluXjf4woguopnigABZpQmG7qwZnXQwBZK0UxXUGKOcJW2KgVfHW4NEcD1zL+xh0VKXvlx5BgL4PSNVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRTWizsZC/nprK7teqphGZpgqrySKxHctpQyh+PwB0o=;
 b=R7/SqMVoEmwbqFdiNcsvxb6bQuoZrGoAr6QmKQBIR/QilID5jy5dZRJKURmJf/IMVQrnlCvbxLUUUK1JeloAauzmpCuQSspjdOE7mRyYpkz83j0N/uvt+x2ikp1ijt+jSbxmJ69o0PEmlESVPuH5F6QEB2jxL+SmWxbxtSeVuEwDC/QcL1B4KfuCpjYY8B0QVckjulOVgzFhTCOwaFWPCFTQqqo2t0YWK0nF7Zn5+j2I0xezWTZ/d1KHMJrJ3ovsWgE0f1j/syjBg9FliqiQlIKla5NtuejC+gvoR9LpkzkoyTCvGLw28F8GsZQUyi3gBarM6GJDh+XM9AaWi22AlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRTWizsZC/nprK7teqphGZpgqrySKxHctpQyh+PwB0o=;
 b=senPAKX5iKmETiUNFfc+RA9M+nMIF7u6nGp7if9FnGn2QmT6JLtPBnCcEOY/hqo1BiEKiAPzfYO90sLSzcDf7+y41nGCUtm0NzPpFmjQme7rVK+0394wVitgSBj51asvxQucwsARgOE3Q/XT4NBAdzZHlXGPvl1Xpw9aXNUbtGAW5hhiYJoUauwXJVOzGnGdwP4VIWhL8YU64cWL/BYttTxcyTxnHAf7ob1oTSQoOnTCxo51id5VplZ65GdQr1D1HXCjX9PZu5QVW/m3LE7iSIS9f+3ogmDEVUJb/QYJGTUnBLT9AMCmCnNVvhFYLYKSEt6EjF3UL3TlYR9raTfbRg==
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5096.namprd12.prod.outlook.com (2603:10b6:208:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.25; Fri, 16 Jul
 2021 13:46:23 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.026; Fri, 16 Jul 2021
 13:46:23 +0000
Date:   Fri, 16 Jul 2021 10:46:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Split hardware stats to device and
 port stats
Message-ID: <20210716134621.GA750641@nvidia.com>
References: <20210712105923.17389-1-galpress@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712105923.17389-1-galpress@amazon.com>
X-ClientProxiedBy: CH2PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:610:20::16) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:610:20::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Fri, 16 Jul 2021 13:46:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m4OAX-0039Hv-LF; Fri, 16 Jul 2021 10:46:21 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7835524f-61d3-4f3f-6616-08d948601998
X-MS-TrafficTypeDiagnostic: BL1PR12MB5096:
X-Microsoft-Antispam-PRVS: <BL1PR12MB509685CD58E8C41892FE4D7FC2119@BL1PR12MB5096.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JbmnAYIn2i/e3FJoCk7MeJbhDN7rLLT21/duu1o3clphQoY1hU2TOdm2L9Q+5BCm7yuDeNJAYpQW0udjN56sBavtzFL2ZKnY1D8CzMQzu+5eYHktPACRWZPwlgXcptAX9QWvQPjhYLKG+4OYxk9+ykuMsGzK/dqX0O+5ItvIomz8cB9/Djd9G4fkrjr9lDo4P3xo2nybK1PoZHyf7SruFt0vdDQNC9qkpOwqXzJfcFTGhAslzVNaovkOit01sAFkdyJP1gbRLiIFrEXnTvesG03yksb8GoCJMJqZQLU8W3bWZcCV1dQBs8UU7uw9F0NRlq+Bs51Cr7hVj1lxkn9QQguHUxnXE8XpzG2g3l38d/TJKnNpLgvepckIallhJOCg4La4aetfLGgKlQzb+BPiElu0np4Uf7SVSp16skjktNtD4cdSnMo8dspnzWnQPyoF1xgyQC9dgQYzX91UYj1YJzXdfHGuvQxTOthfWbW+udxClj/BL0VNNh8cajdzUPzVV4VMlyipOFlWFubYHmgbRJO8SVC9gBbLXMKeoa2cynAIW7zh06q3STQJW1E8CkOK/2wFIvsapLxWi06T+2hCN4883eEmYWHuvH0W7OZHKi97u20LH14yQsJq/+IMzlikoBHsmTsXacRqvbOvQk/8ww+nhIEhj458+D5y5MoGxr5gt1Jd6bI8UKH9lf0o06UZ2INd+qNgRU6Tiy7DLqPMqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(186003)(26005)(38100700002)(83380400001)(4326008)(478600001)(8936002)(316002)(33656002)(66476007)(66556008)(66946007)(54906003)(9746002)(9786002)(6916009)(86362001)(8676002)(36756003)(426003)(4744005)(2616005)(5660300002)(1076003)(2906002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1xIOzmF4FRKR9ULaVM9VBzYfPPqrUiccfvD/CHASIPF7qRYDQ6UTQri7EA9O?=
 =?us-ascii?Q?f7QbOVmaHN9fwPVM9wqqnLXFZenweaeogJ4y/6IZVMbqkmsQmEEQdDSlQw3/?=
 =?us-ascii?Q?uHxVPaplVowt94MV4CO3VcylOKraLHX2OtBrtjvyErm5FRZFyVLlEY4eb/v2?=
 =?us-ascii?Q?88r9o6uFzOcgDY8i726rmVs4HzduNM5caZXrcu2gWqJwBmrzMy/nt6t8LLxC?=
 =?us-ascii?Q?LZiZTPawe2x1Hy/gFKtW+4adrpjScMdJ4tD5NS/ohDJRPcd7X8fDaOhStNH1?=
 =?us-ascii?Q?eG4c6zxs8PNm+mgI2n3VLgC2TML6bYBhlBInY8k4XQR2Ao6NQdEfrXJ8wudW?=
 =?us-ascii?Q?XlwhipczeISmC4jf5swRFGhaY2IOUAHfbXca/mC2nEe4M0lY8HzYWiDuOC/0?=
 =?us-ascii?Q?ofHvMqM2WUWEyYYGL5goAHRaIHIPWTgfL0AuRb65naC7sE67A0p3qLO1heSh?=
 =?us-ascii?Q?t+HLJg4uj9APcfFKk5dQF86qSI7GDU9UmNkHgawP7r/0Mqjh4/VTyAmSuG0B?=
 =?us-ascii?Q?DfKdJhMitB/2h1pSgUrUN2S0uq1Dl/CiNp0Ng6QXOFCf7b63ELlCtrLHnXUm?=
 =?us-ascii?Q?sudoNKARFsnO3jUtJ0xTxrH/JYwfDP94NUsUyoY7VQzUFAftAPHEaPN5KfPc?=
 =?us-ascii?Q?ISx2e+dasn19k9s1iyw3ZHC5HqNiI+8NGFFKZuOtQrSJwv2KjnDznIzsahE/?=
 =?us-ascii?Q?t0emWWATlkHWloT5MvHrY72C9E3mmBBnoBMVrKiliA/ecItcKu8pXL+F8nU3?=
 =?us-ascii?Q?jmEfhyhuAKZwyWc+BFdZx7qVs8mWnsisENvCQjg5xF1kgrzQV/VWZIZFXnjR?=
 =?us-ascii?Q?kSQnQsdjzkXWreEJ1K7YMJVDfrlSaXkk+a5mkU7JgUpAMDp0HcvntjXVLBvm?=
 =?us-ascii?Q?OWkR3FstcvMR7jgS/fafveXm4vCb50QvWLuE3aNMnkWMa3MtEVUAkSQ3p+xn?=
 =?us-ascii?Q?Sc9ydSDCpomqh2KsmOoGtRP3hQnjhhO80q4thhkLf3VB9aPsosWxsjyhxPp5?=
 =?us-ascii?Q?w5N16CDOcNg8Dz/DTAsCxLGjQkD3pt10FW93G/YWapHbKLTuJ/nhPX+Nuia7?=
 =?us-ascii?Q?NPXCtOIyrNlbdSPFnOG4N4mlwWsyt27nim9Yxnr2ZWMmrB8pokMkxd1HeWIf?=
 =?us-ascii?Q?zrCYNPrQZ1hy4b5ysmXWcGVr6vKIXBWilSdvl2ctUus6TNmGAjypgCS3kEQu?=
 =?us-ascii?Q?ARH995cMm2EV7OdsiRj/RpU/6EzgtKSfZh6KshQDtoOvwnefcYqdMKPet9Oa?=
 =?us-ascii?Q?e9Qusqe8OAXrMzfqvXEIiPkft55HELLTYoI1gtofbP2TYHBzJvp23dyyMgOu?=
 =?us-ascii?Q?GODFHAgG2FMwRnLi96T9298n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7835524f-61d3-4f3f-6616-08d948601998
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 13:46:23.4707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y24yH/T9SlOFlKNPO/9vp2edYgYIxNadNXBDkSrfd6uoxFPlOeJy25VdpchIdZW1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5096
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 12, 2021 at 01:59:23PM +0300, Gal Pressman wrote:
> The hardware stats API distinguishes between device and port statistics,
> split the EFA stats accordingly instead of always dumping everything.
> 
> Reviewed-by: Firas JahJah <firasj@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_verbs.c | 120 +++++++++++++++-----------
>  1 file changed, 71 insertions(+), 49 deletions(-)

Applied to for-next, thanks

Jason
