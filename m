Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456E03F32A9
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 20:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbhHTSA7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Aug 2021 14:00:59 -0400
Received: from mail-bn8nam12on2076.outbound.protection.outlook.com ([40.107.237.76]:14016
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234160AbhHTSA7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Aug 2021 14:00:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQ9Ng0dk8FXH25Hyc2SiPZxUkvYkYyQTmbiTWTYsckWg/O1GaKSxQN2XvIxknPR+wVBghwBEnaoUeAL2JjxXKWNaLI7vodBpopmfxrKD9jAB9rmewYStFmuoMUgIzsN6u3aJ/R/LqCcTn4gJAIl0YcTL4CP6hxVjXrUGS46RphLvDVYUu2n74D6NfN9uufg5daTv1WWY7rSqH8e2IZ4V348c60LiJvz1+ujtrQUtj8Qy8UFCHNTTdOFHSg3WGKiC5GvZktZYGs8hWYOG7L2XNOBBTiRyrp/NAV3XDDPWWaFPvxSaaqdH2VYdTo+TKRKVBZ+LMjN9U0g4861UCD9YDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EX2xc+FNhI7HPOgk+FNGLOB9UUfwBi33ZqClgEILpGs=;
 b=SwstxpyIv8ELxdksxTdi7xUzSQ4DPVA7RakHy4g1dW5GAuu1HJgU+QebWjt0ZQHR4LXX+rPytkhCcuNiFWB6Otj59jY9otvzrX9guahFEQ/gmVrJTKAGFMSmHrX/ThglIE3io/W383FZVx94wyf/r7m9Qo6/mDHceIoCr6sGCUYb6D/eH/SHDa6OztoR8GKGKRVPpaKJ6KmDqRj8YLBpzvGx1N/gsewF9OHVOVrTtCeGaanXQJFloJ46+SThbNyLeh3tBlflXZh3Z5vJpL4ptF4Q3qVjyEqf5npN75FaJIEZwhVxJEDBJLleCoNIgfy7PolxFT/4sMTA/1DUYZXV7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EX2xc+FNhI7HPOgk+FNGLOB9UUfwBi33ZqClgEILpGs=;
 b=a1pcxp6brLghLRCQJ3kMsmZ4FQX/ng9BevLjXmzX6Q88MnRPkQHD/0IDQ4/LcCPgPauSVhYi4GOHUfIP5jAiuY/KtQBuksbY0ndtXws4dHd0X+8fAiXB4bhXhp6A3GIGXXfhgMYeduultyeHXdItnnnzCLpyggWEorXNSDdNrUAM9+rKTS2GZuXQHiUIX80NH56eFPHbxbYuhXoXyBaWm+mH28Me96lKGzr7Cw+MkpDj1iiyso99G3cTq3UoXb2aAxPigrKRqa8gKqvUHH18XqhLjRZB3ZSPMnC+EamA6RVd5Hn94nvax6GlW5iDQiNh3TwVufxCFYFO1L6k5rxsiw==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5379.namprd12.prod.outlook.com (2603:10b6:208:317::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 18:00:20 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.021; Fri, 20 Aug 2021
 18:00:20 +0000
Date:   Fri, 20 Aug 2021 15:00:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Md Haris Iqbal <haris.iqbal@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, jinpu.wang@ionos.com
Subject: Re: [PATCH v2 for-next 0/6] Misc update for RTRS
Message-ID: <20210820180018.GA547909@nvidia.com>
References: <20210806112112.124313-1-haris.iqbal@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806112112.124313-1-haris.iqbal@ionos.com>
X-ClientProxiedBy: CH0PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:610:cd::7) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR03CA0092.namprd03.prod.outlook.com (2603:10b6:610:cd::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 18:00:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mH8oU-002Iat-GN; Fri, 20 Aug 2021 15:00:18 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bab9033-25d7-4d56-ab09-08d964045f99
X-MS-TrafficTypeDiagnostic: BL1PR12MB5379:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5379E0C194A15F1F16B40415C2C19@BL1PR12MB5379.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ljrYu35uU8xhB3KjKdFB4mFuEXPFbclw9PJgvYAbQuNucuMCBu70LHSIsXcOcdYqRYpU9/fvdxF6hIeJHnKV2uSgCj/YmEO7uzV0p5ZylBtak94iTLJajpTBvzsUaBN3wVY7dVZacAp3OvIE7iZTVTj67tWKveJwbImaNYd6QsKNK9P/N0yxqVoTaWPeeVhSVoJr9V6/T8IvpgIB4hG5EpFGkjMUuUrMogAdq0iQh33T33PJVV3P5CFyk+u2TwekPezKpsJ7Iw2qrkccT0chRsM8SkPG81e+uCeyY+ZkJ8ytkp71jZpxa0edBkZTNZTmtgRlp3XtiffWJAs6cy98qOC/9jxCg9kqfpSgEe79eBUIbzRmIVmT5tCCKbpPi+xh1wz5wYFGI54NGfXkoQXGACkDzQvpTJ7+g66ZoebnKjhi4oS0n3vTEHwMqBsZgI952raG7LV1TzKv31ymRrXUB49/PjYARH3IPDw6BH8+QivxCsDGtOIGJASkhXvf4Vkh02Qj8keymq4h6rcNcrufNP9CG5oqZMxi3eYUoYsG+KvBh33rifErV3iCAnWW/4fhzOr26vlujksUlgmmMi+qORiGDkJe9Gqd42DhMpwVIk0sS/gl+3Z0Sq1EoUlcmPfLuagEvoc+ysCuUGFfxvCGWB5cq+yQHRq3HXFf3UvXP8EGuUie+C90Auq5+o5xWN/n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(4744005)(6916009)(426003)(83380400001)(4326008)(66476007)(66556008)(186003)(15650500001)(1076003)(66946007)(508600001)(36756003)(8936002)(8676002)(9746002)(9786002)(33656002)(86362001)(2616005)(38100700002)(26005)(316002)(2906002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9DyjyVn2PLCg4dgKcnszmBn/ewTZRxR2LhWJllfpQLML08+v2bq2XrrpCyXd?=
 =?us-ascii?Q?husVzBeC0zdulGFBooxJK1erCS5JWng5nMI9ptrHHLv7zGsEUw0+3g/82UWY?=
 =?us-ascii?Q?MhbxsdK1a9HWvqH4q6MDKbLI3eytNJOqLsFKmhjWJ/6sTn+8C591OKZhtTfH?=
 =?us-ascii?Q?qMVlY9u/S9h9m+euw7+VvXHFf+j7qzOkHOR/Qzz1btlaIhPSm9F+zpJNRC4c?=
 =?us-ascii?Q?C/qoNpoo5MdBEWsbw6Ryi2at5yJQH4ANilLucjkOf3IcXo3PINPw1M32J9qP?=
 =?us-ascii?Q?NdSJA56zuRcvNsn/MwKLKOTUYz7NXIzC3SbKwQp8XGF06aUd5as3twklOouc?=
 =?us-ascii?Q?W4znwxbocIXmPA/efgP82LZ/5JQ31dIgJDALGqLm4bAq1qdjhxsxJzasebsx?=
 =?us-ascii?Q?gJ1UFppb0VW/Vy0vaKuj0t4AU8m6yWz877IAP2LmBWavXSkdkQh4s2O9I1KR?=
 =?us-ascii?Q?fFPVxuJW+C1g4XKuobdCEl3FhYQsRJGeWoLYXkKrVDf3GkpFxlfUUjMNxRvV?=
 =?us-ascii?Q?iofVqGIunvG03eFsIDsqIhye+KIipyt99AF7pPWQ990eag7WgHnu6OwiCoqq?=
 =?us-ascii?Q?hnEcMZcrQI3WqNzfDjA0K91MBXXRiU4Td2e9CWF0Gf9JOexBVBwIZ9EN4AEi?=
 =?us-ascii?Q?W7SL85l930WM5LRjyEC0E0Kn8AWwg3kM2dlMxaethczudbFYRUUWE2+wNsJo?=
 =?us-ascii?Q?Rx/eE/k2CuNUHWAZRMuehy1iEAZNzfrqrHy9ur6cPCU+fY7sqErGa2PygT07?=
 =?us-ascii?Q?99uMWb3vrqDGapsdodo8KGTRKSAy1plKClC+dUoC6DR4F2g0OZU74VtFDFqY?=
 =?us-ascii?Q?RXq/+2pBnGJaN6kC86DXvDg96K0L6iVgATn/PhuhHx8W0aq1KkptX2IMuLFB?=
 =?us-ascii?Q?oYOf8CqNUeIDfuLxrNQnuMl4nWk/sGzlfVgXLi1C4kaQZOHSFGjpeuZzq2xB?=
 =?us-ascii?Q?CzRPAteuKuW5kDHHF3weWjPChDHx6RieM2YrL1y01UwsQUWEynBMGn/tR34e?=
 =?us-ascii?Q?dXh9vxT0pFtJgjJ0c4KhU1OImhb9ncZVDznvsoGZ7qwDZwzJK/zFKCj+6ecs?=
 =?us-ascii?Q?vR9JOmH5bVhbtiA01DLB6bv0yTJ8ombqZ+EDi6drKKaO9P1mbs4SYiVvBZ4b?=
 =?us-ascii?Q?IqCr4j24//iZyYZV8BL/pat2+g0dyRg9E7qr1JtEZavxL3+99M7sVhqWQPkE?=
 =?us-ascii?Q?wUQGln2qf9ugFLKvFExr9w2A4iwZgWNmouqQrLMu8hPDtG5ALdwKr0fgB1kX?=
 =?us-ascii?Q?MgNi83ubGER9VFM15UqqwdvAx+NkcrkUGo3iOldHJVWemYAvHlrVnI5VU44W?=
 =?us-ascii?Q?RIiDZU3hOI09xQFRp+Ac5TvR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bab9033-25d7-4d56-ab09-08d964045f99
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 18:00:19.9972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYB1u6I3LbsXukL3k7r0wPppofQIK/ga7PGUwBQcVAI4UKdk8fvTXWa8m+/O2ljj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5379
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 06, 2021 at 01:21:06PM +0200, Md Haris Iqbal wrote:
> Hi Jason, hi Doug,
> 
> Please consider to include following changes to the next merge window.
> 
> The patchset is orgnized as:
> - patch1 bugfix for corner case.
> - patch2 remove unused functions.
> - patch3 Fix warning with poll mode.
> - patch4 remove likely/unlikely.
> - patch5 Fix inflight io accounting when switch mp_policy.
> - patch6 remove void cast.
> 
> Thanks
> 
> Gioh Kim (3):
>   RDMA/rtrs: Remove all likely and unlikely
>   RDMA/rtrs-clt: Fix counting inflight IO
>   RDMA/rtrs: remove (void) casting for functions
> 
> Jack Wang (2):
>   RDMA/rtrs: Remove unused functions
> 
> Md Haris Iqbal (1):
>   RDMA/rtrs-clt: During add_path change for_new_clt according to
>     path_num

These applied to for-next, thanks

>   RDMA/rtrs: Fix warning when use poll mode

Dropped as requested

Jason
