Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9CA487809
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jan 2022 14:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbiAGNNE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jan 2022 08:13:04 -0500
Received: from mail-bn8nam11on2078.outbound.protection.outlook.com ([40.107.236.78]:25735
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238730AbiAGNNB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jan 2022 08:13:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCzDJnCWBdRPItO0E2FIQDUZa2VphhOct/Ihl7VZdXa3Cm4VU1C7DEa39D8u21tm+DcuHGOHmlOomK0g3dDV8kvt8EovaaToEdrf88Ows/tpksDjwiLt5E4xfBwUx7AlHUC7TsMgtJOsI6Kxr8mppcXdJ1ZmeVw//s8WCcluzW1Jv/6wWE+Xwde1hxg6MhCedh63qC0F8OIkmxS/RRoYeqSejxcFtJDeeo16+m4FaEdj7Y1eLBKaZnmKwFrJjYgaXMMGH8YHTZAclZj8gr36fTfSdEVHXlM3TcqJRaWJhFRyzCZ0B7e4SIKjyIhkrsqmoHkg14A+wt37xd5jbY1rsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E73D4pROQj3ppNr1Xg/2mcmLgj93y0VpMjVMylys19U=;
 b=X+7fzztfrUOIujnKjQ0cHM2kZHVFqjMGx0MXtY1sNIUDIKEkE/EpePaUQilmnv/tYCrbCF+IZasFaA4Vqm5nnF0TEEZID2DPEknMFO9xM4HyJjwwkk/kzDA3NY3IDUnXgB1p+LFN0NqLVHXAVsnpTFxrsvmSgg/gHu9mMHgyrCcl4fmxXw8zB7yeUAMBCwyrpmtr/XXRkrl4PRCoQpCDcp9LOZdCjGI19s8BttqqG4gYUcQ+cuhBhyLXSzQZBdTkTuqSJ+BLZvTp39ZPozFv+3is3x4Ve2ihTfeUCvpNpEgsT3+eRZaNaxzWej1LWJevU3K3OJ7hsAmFJtU7gKYbAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E73D4pROQj3ppNr1Xg/2mcmLgj93y0VpMjVMylys19U=;
 b=GV+xc56vK6wgQH3RKDmc1RmLrSlnSgOs3OpW7erN/xG7qZLyztPYUJrJXS+CgyZP6H9MIDYzxOysQPY01ppGWRrvHkvrDqv5JTjWZXhFlK8EyRkdp2jvL8uXHv6/hAScINtoOc0tu63YeMs0LlreLL48tG/1daFg7wdrAY7eAiyx77Mq/KxpTU0GMKMZ7CTB4B4Tz2YcgcxBwVQFRkRZ4esX3utcfBjDl3lZyHI7pXf9+N0lOPmklkePlRf4HSz2DVsP55KfWT2S19p/9O/GRC66ooqbmO6d0+mDoeZCa/Lsf5qxbozJXNYKDynR7qmhfvrKLlVQXJ8snwbXoSQtCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 13:13:00 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 13:13:00 +0000
Date:   Fri, 7 Jan 2022 09:12:57 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v8 0/8] RDMA/rxe: Correct race conditions
Message-ID: <20220107131257.GA3062742@nvidia.com>
References: <20211216233201.14893-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216233201.14893-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: YTOPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24432d42-0927-4613-002d-08d9d1df6dcc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5192:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5192AA724FE3D30417A56FF0C24D9@BL1PR12MB5192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhUB84R8k7+Ft5ADpSCb/1Tn1AvdXtikL6fTXv8nre/TeENR3G1JqiT3wFxvCDpaFNrsupPnTxxOoIlNpKkXHF400HNF9IG9lOjdHufXUNiG7S96kgEPVzwUNDj1EyJtWMKc2CQ2CD+nTi1OihRohCNC96fncnFL5uAzP1RMEEqR17ck5ODmz/3c7FshGbb1+PXPIH+UIOXXi9nadJkSORTpMVSjpNLO5PXgMHIkA73H0EfVDK1y9gl0SCWNT5lZNoDPBdtvhV//7IhLqbeLTImu6BHh/gn2vljbDBTx8pWkHfPKWGEvKZdlbmoWBaM/eN4aZaW7gszEZ6d9uEzLmiWXhYqU9PttRq+Fb5qPyV8WUyy0TXHEiBQjqUqURqc3Pf2KSbjXWU+m/OEg77pFq9XFOli8EhCa8QkWCvxANjMrrITwZpiQ9l9IERnXQErtnDTAcdmvN4qbZUE16GTvqbsWPi/KUqhT4Ai8epriFQnxB449eMH2vNP51jPXeSBNw4jJKEfmK1uiOmRg3ajo5J7ZL8s7rZUHjY/mWKc6Catys3fca6wFzCmnDR0oU3BN97NcnVaoSygBBBMonvoURQZNGeO+HpDPiut2nZVSyj9iz1bDPkTvHBHTpXZcFLZACubucfRVcPJP2jYZw08tnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(66946007)(4326008)(186003)(5660300002)(6512007)(6666004)(6506007)(26005)(6916009)(33656002)(38100700002)(508600001)(1076003)(86362001)(4744005)(66476007)(8936002)(66556008)(6486002)(8676002)(2906002)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tpw36YuBd44HbtQUTd3V8MyJTylhzCkdj/IU4MULo16gxzxVB95oKriHyIrC?=
 =?us-ascii?Q?bDhyrG90pKXnAkSghdhwY6rtTfRYlY6KhK+hV7gnFDRJc4pwhdpee3tffY2L?=
 =?us-ascii?Q?86Ekxf7DvNapH+KOEe8WRftRAwmvku9U6XvZqvOXj/ch1S4nKqsauowalxG6?=
 =?us-ascii?Q?GRKV6mVEvIA/3Js7ytqScK7Qs6yw4w9yMDwT/J5MC8brQSjc2raRWZK6Vmj8?=
 =?us-ascii?Q?8KSI6yTVGNr3XChW0osgJ1pV9g5AD7Y8amruALoqzPg7Vl/Ud2PZLSPi0Cxp?=
 =?us-ascii?Q?TvZpzPH7qQg2tDYHUgBjdQEy1L0HWMyHUSrfUJ8EYtrvQceqODc+XglA013r?=
 =?us-ascii?Q?S98nVflsV6rw5LJzpldOxA99VJ7wa5CgR7qJ2JNjwfmYhtcqT0Yr9D9o4QTr?=
 =?us-ascii?Q?/hh+ydI75adYpJJIATHxkM1QyipRTM0XweaOTKR9i3AmhJrCmmeSQgaDNSEc?=
 =?us-ascii?Q?SBCVnG5kc8fws3Z3uhjPdCtJxsjgGZCvYE791MvpFeUj4RC7XXO53d2vMxHh?=
 =?us-ascii?Q?FaP4Sbfo2nu2loN7EHBEcpRJJR8GyTL7RSXXZr/1y9jmP4djB+QUfbIYjgCN?=
 =?us-ascii?Q?dJk/qtNHa1j+GfQtRT2Nt8zGa4QmZhUcYr9xHV39S5Qkzp+Lf3OojPBNHkQo?=
 =?us-ascii?Q?Q7nnceBrPb9iTKIufTjurLv0xrOPG5VCU746Clg7GeaWZwbNsJqVWDqdnttV?=
 =?us-ascii?Q?ZnCdIUOWVfBEC6eSdIq7K2YQap+LOrvwQF7JA7SWURW2WgbZKHNH6pgI1mE3?=
 =?us-ascii?Q?lhwTO6+PFZKoQvUm7PZ929amAn1N/80kLOb7iMmA9POmNd4C3t6hKg8mPlCk?=
 =?us-ascii?Q?70DCX7MJJjgvUYHAFc48yupIDwjTgsU22a7ja7qv5COR/GbPlJ+4vvf2+NJk?=
 =?us-ascii?Q?cRTbr7us1KWiIFxVF68YprVZsX1kiG6S78E/GFTVNiippXYmgC50YTbihdod?=
 =?us-ascii?Q?ZiZclbd9Tfi7ffCSoNZPbNMoRnWeKkyWhs4R4OjIRxmU5WDUa1xQI/xkfooi?=
 =?us-ascii?Q?UyZuRyuJMLNK04lVK/x8utoXoaw+ikgge9M4dVafWaqeXE8Mh5GgY5A31pFa?=
 =?us-ascii?Q?imRypj/F4NgFBZ+NbWsQyfDk5CzQJOZ83OzFRtDAfAZk4fAGZaI9JHjchmtY?=
 =?us-ascii?Q?QQN5lbPleuW/WZWf4c4SPkHz2tmyKQPkQ50douiK4hQ8wo6rh8sYJy14zS/L?=
 =?us-ascii?Q?Qdskv64kUmiLSe6vxbhQeWnCBRhOBxxhDiwnAKmn0kQeMXj+Y1+Wdx/EZRyA?=
 =?us-ascii?Q?HUUPgoynEVwu3PojUxoWQLzWLOTK4bkOdUtq5XzEazTCWtIjNhygNVJdpKq3?=
 =?us-ascii?Q?87i36QGxB11PAJebw1QGlXo9lJQeuyWpJOH2Qgy5ADQMsRkpopP6edyexP4r?=
 =?us-ascii?Q?+11SyQc2er2s53EtztkVKsaasN91Txd/f0whrn2LhjV4AuQNj5c2G8NsL+gn?=
 =?us-ascii?Q?VGKwCEy++fy+9p6ttel+z5u3RfwH1cDKnfcFQPhBGixM+omNMr2q9kXTSAYp?=
 =?us-ascii?Q?m7/TKJSnrkNoW5w8IX1se8y9OtoshmSEu/oi+/hPCarWrIm9XxIck5OIdL7X?=
 =?us-ascii?Q?OeJAXW5C+ScnTYR6GDM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24432d42-0927-4613-002d-08d9d1df6dcc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 13:13:00.1196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Wyb78/5FjZyHQQzpJA4fiaev8ta9D7jVzT2Qsq4anRsJIIeEqi30bLk9K4DuU7Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 16, 2021 at 05:31:54PM -0600, Bob Pearson wrote:
> There are several race conditions discovered in the current rdma_rxe
> driver.  They mostly relate to races between normal operations and
> destroying objects.  This patch series
>  - Makes several minor cleanups in rxe_pool.[ch]
>  - Replaces the red-black trees currently used by xarrays for indices
>  - Simplifies the API for keyed objects
>  - Corrects several reference counting errors
>  - Adds wait for completions to the paths in verbs APIs which destroy
>    objects.

I think this will work better for you you strip out the RXE_POOL_KEY
stuff that is only use for multicast and move it to the mcast
file. They are so different now they shouldn't be sharing much of
anything.

Jason
