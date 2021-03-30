Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E6734F4A4
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 00:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhC3WzE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Mar 2021 18:55:04 -0400
Received: from mail-bn8nam12on2046.outbound.protection.outlook.com ([40.107.237.46]:57569
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233049AbhC3Wyl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Mar 2021 18:54:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqJzFvIn5vvqfj4Nt188CHPSteugLdCqGnJN/7NZn5w/7CbYJjF/BvZFH68v1xhGVNqMLo93b0Z9s5uMhyjWqq2+ml3WqDOyqY3nXSKRWFCacbPQEMZwSy+t/9je26/ZMzKtSY4w/1mcmTWYX1L+yhpCZNnM+4JzhSrAkMkzz+XGklFPZSLA4pOV2rpVH/5rZnODuUK3oNEeSVjU5gQiP3dVXurPlXxQozaiHxd1tGbAfnAu9Dv8j44QxxC1JCTBdqkIqgE7uQaT41r3mG/5cxNtXxcx5gYF+nnc/fcWZnK/X1OHVSDpzf9qdwcFJVUR0omtK9JDWKxJTX7zhXXNGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCAeN6HIWFV21nwcxLPRIYikBS/AVxY96q2KVnmOm0c=;
 b=LryaAjLm7stccU4B4pg8NLGRZFmzlkfvOdpUTQONp6eeKXhQM4PSx/U512pdJ6BvedK2jz1i66RoZ3t1fA6Cp3yMIM9NSK+HrQvU8aerbt3x8vRmcdQT+EcNim4DaiRFOIEY2oUS08AvXQoZEOOiKGTXbjI11jtbJfBrzXzriFu5LUFB06DVwiOsMBbmlsAILNvwUtaFtawpoA/Lzkx+HBm7DM+atsV/gSSOf/GjzoNL56JFp/hcKyAXjVsMsXWC+xzX6F06qKO8HsEfICOxNiQ+2kDJySdu8bc8baHfVf+Bf9A28h+izlzhovqCxkz3zO1dJMCZLhUhiVe0i7UuCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCAeN6HIWFV21nwcxLPRIYikBS/AVxY96q2KVnmOm0c=;
 b=l6LSyJnQ+RmyuPVpJEplYrH5QT1bUvrF1ePEmyDogy/4KVC5GHC+NyqZgv4MQ9C1Q4pqJ96DtKjCtS4DQgBSn3pa8uaLU4WMkpdOM2LZ4W6rdjj8FLeNfzrsiHeIZT2iOoMVMcLLqTjP7D5w3ZzT9Lkej/LvHfnDdfohB93HDWi9TF5zbOfOnZtAB1lAD0qSFgc7wGd++pEvbTTMuxdL49LlQf2CvKPagWoRXt1NDGOWQt5YbjBZjCN9qrbfpvceC/lfbu3Yp9N42ZR86/RNzPcztxjP8LcloB1bKZiLkx6tnuceOV+OF2bcqmTdvwoK7R5gCntjkevBwc49JBS/Fg==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 22:54:39 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 22:54:39 +0000
Date:   Tue, 30 Mar 2021 19:54:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next v2] RDMA/rxe: Split MEM into MR and MW
Message-ID: <20210330225437.GD2356281@nvidia.com>
References: <20210325212425.2792-1-rpearson@hpe.com>
 <20210330201245.GA1447467@nvidia.com>
 <54ec9b7c-5c43-2c36-ea51-684fd63368f9@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54ec9b7c-5c43-2c36-ea51-684fd63368f9@gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR14CA0026.namprd14.prod.outlook.com
 (2603:10b6:208:23e::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR14CA0026.namprd14.prod.outlook.com (2603:10b6:208:23e::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Tue, 30 Mar 2021 22:54:39 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRNFt-0067pe-Ru; Tue, 30 Mar 2021 19:54:37 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e4fc8ba-be97-46d3-8c41-08d8f3cecc8b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3514:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3514A017D2E8EED0AE68BB3CC27D9@DM6PR12MB3514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7tqGJdFNRKUNZcHMmKtc9hOV80fiZ0Qe3PZfOquY3U/L4p5OPYa4a/Ti3jUdDmAfppG9SqjPElEiGfWunvwQDGnV7jh3wAH4KDISJbJHTV9FAMgPgpfkX0ZBj19soIZg+d/SUqzuYCnDNjBeMUX7kYrp8zZ51xAbx0apBYFMK5C/R2tHVDDaX0KlVW9KHFMixVa7tzo1qabQD3GYavHxSjJ6dKReXwRDwTph572nBdXVFFsTS4G5iQGsLT+2Y2pVv/hUlb8yIhQPOGPjv64bVC9cKb8g0Cws5biGOtLYon5vUVGMm5m7brYV36o9GSWEfnbRaUb8IWFfKtxCOMbz1G+GlZ2m0q05MmKvzfp4wY/4V/VyCbPHvO7UwmnPEpNRUP/6RSK0vr5R1lURRocT/vubXS6kpsybDtAdbAyNLzYYYz0926EqqdOHazRvlohShdBX33TbFevtbQHilFXms9kd+d2l7RdbBRtoFCsTr8T8NV5CdEG2CKkhzdLjgeXvQWmO9wjXmggVRAuYtbtxZkSwfaJL9AAHYn2VlgkXAbAxPMpEtia6cY/WfipWZsepKPAjsAB4mSzOftXEzZVirBc6VkQdPbC8UD04ZUBIj/Av4v5OU1aIP336QB2iX3sxtuSataDAw8yAT5M0cQB7mz33ZDJuIPiKWGoj7I/FHWEBejpMkZ8JhTLHzS3MpQ0NUtXTwoR7MDopxbV8gGLsAxXn+6oEgd1YWgkplCOiXPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(38100700001)(966005)(4326008)(316002)(33656002)(53546011)(2906002)(66946007)(36756003)(6916009)(66476007)(26005)(9786002)(9746002)(8936002)(5660300002)(2616005)(186003)(426003)(86362001)(66556008)(1076003)(478600001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8AXQBBXfX7+J9paQ7uV3yXfYxMfMuP+3BU6s4Muo70N1KIUrPc/EwLnnEHzm?=
 =?us-ascii?Q?Le4Y+MDsesKsaGesRmWhAdscpOIg/7Dw0JdSgaiIxswwO3iVxP76r2E2PKJf?=
 =?us-ascii?Q?GJTXBNb3KZG9bUZgsdDYohH4Ur+PUTH670MxFyOJxDuM45bapeycygKvB8Vu?=
 =?us-ascii?Q?UMQ1Wnz4SeEGNOtwA5piPrlnAqzftJj9PXDAmRK8A7sQuldfNm+9cm7/vE9j?=
 =?us-ascii?Q?Osnim2O1VfSdB0c627XizaIiITlzzcTlord4/h5pVaLQuI65IXTlQ2FtXkMy?=
 =?us-ascii?Q?AWfZSF1Dlb0oaF4R69/gZv1GW7SKs8TiBu+zzMJP8+2OqZI7C0SYXnMg9pS9?=
 =?us-ascii?Q?1hw67opcmVNvmLR6snjQ4Kr+2t3uyNi0s7g+Uupp2hhlf37NkfdbJIjasDcs?=
 =?us-ascii?Q?ptowX9k3bzrD2hYDugOMInZK3waDcyPvXmicIE+IJQ4OoUjAUHsdWq+jvXyP?=
 =?us-ascii?Q?ZwrT7PVpwwj7KHS9U/kwEchB64k8R+OsIeQbdZ4mA5t+gQXCiYLADqjvR3If?=
 =?us-ascii?Q?AEnbhqVlYOKVRqLmEDBGYGojMlJcM2hjbJIxyHgkJ4Q6AO1FpH7ieexH0vBB?=
 =?us-ascii?Q?pMatJlHQXzDN8DX2vPxE4hq+kO6eNRIFKF8CF54V2rlfIWJsP4zgtXiBqp1X?=
 =?us-ascii?Q?sxyHqLGixiHicA3T9vL5VYoJP9oqKLTMaFXkSajzm3JvTK44f2JC7eLQDy+T?=
 =?us-ascii?Q?ZKluuTEK0PbS7NXjH9M0vzeV6lKs7rGC6z+qGVZCcrHKGktx/ghp8cGeyYXa?=
 =?us-ascii?Q?eQBcJlwun+eqAdm5UUsuQLfMtSOkTse3Nxu62F/x2htm6LD06vBrZRQ3RfNR?=
 =?us-ascii?Q?IZpQFW52U6fr3K+z1XE83siL8jGTICV1XMSSZSHnrhopzizL7eCU7WTqmi2E?=
 =?us-ascii?Q?OWAqhZWFig4BMBJ2AgADAj8x80BoUBJDV7iP/hXvgGRQlwQdHD+bySESK6r1?=
 =?us-ascii?Q?IOcqSmzeR3PXX/ByxXDu+JDZOt9LEeJ8DKwMZM6GRvQIAB/Y11PVn+pOvW7z?=
 =?us-ascii?Q?YRFNMsO/5L9IBC1P9ETHA5+zdDNaLGXaRXYmskjd3PEEhCE9trbAYOEvGmjG?=
 =?us-ascii?Q?VxXlYETAlY0hsaFXPESCo2rZS18H7iqtx25i9NwbDG1x9p9MWTS4dJ1SHuDJ?=
 =?us-ascii?Q?GwHbEpgPC+w//3RQzb9kJG/vBFRCTyPkozuhFsBbZyO/u3ZZ8tOuosw/VKIz?=
 =?us-ascii?Q?OT/oj270yimFQYpcYxwbk09sS62TpojSJsNRPTeLZ15kWOxhSzBWsTetImrM?=
 =?us-ascii?Q?5zQahoFoVC1FQokklQQeVD2gn580JOmwMrSRrpIJkwgJkin6oohFKCMkav6/?=
 =?us-ascii?Q?ADj6JrsE3gCbfep9fJQ498vhiaWZWwrjtGNRCsWFFUfjyQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4fc8ba-be97-46d3-8c41-08d8f3cecc8b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 22:54:39.6483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZf95GkUhMcorFALaSYv91JHYhUL4meNXO88T8EGOuohmlkMoGXcZgjdPxdsU74I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 30, 2021 at 03:46:24PM -0500, Bob Pearson wrote:
> On 3/30/21 3:12 PM, Jason Gunthorpe wrote:
> > On Thu, Mar 25, 2021 at 04:24:26PM -0500, Bob Pearson wrote:
> >> In the original rxe implementation it was intended to use a common
> >> object to represent MRs and MWs but they are different enough to
> >> separate these into two objects.
> >>
> >> This allows replacing the mem name with mr for MRs which is more
> >> consistent with the style for the other objects and less likely
> >> to be confusing. This is a long patch that mostly changes mem to
> >> mr where it makes sense and adds a new rxe_mw struct.
> >>
> >> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> >> Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> >> v2:
> >>  v1 of this patch included some fields in the new rxe_mw struct
> >>  which were not yet needed. They are removed in v2.
> >>  This patch includes changes needed to address the fact that
> >>  the ib_mw struct is now being allocated in rdma/core.
> > 
> > Applied to for-next
> > 
> > I touched it with clang-format first though, lots of little whitespace
> > issues
> > 
> > Thanks,
> > Jason
> > 
> Thanks. Is that a stand along app or a git sub-command?

It is part of clang

https://clang.llvm.org/docs/ClangFormat.html

The sequence at the bottom is useful

git diff -U0 --no-color HEAD^ | clang-format-diff.py -i -p1

But I also have it on a current-single-statement-only hotkey in my editor

Jason
