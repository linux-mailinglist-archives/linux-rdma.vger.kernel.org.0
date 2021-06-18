Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7C53AD0BF
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 18:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhFRQxw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 12:53:52 -0400
Received: from mail-bn8nam11on2043.outbound.protection.outlook.com ([40.107.236.43]:52640
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229730AbhFRQxv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Jun 2021 12:53:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIWVLCKvGfcvDptSafEiaXi9kR85la/wfzOSd7zyDpScVcM2Q9bzAGdVg4jom6qYRhv3Fh0qYRdfbCTWTDt1VTI8jxK7n8QJs9+FqxwcRUC/IykEO7FsJ0wKOVE/ZugYwnbvkmFIwWxXqidVORHiNTkAkVLuDvHbMfWZ8rrF7BYicqzOmT4xmd5uq7DVOtIHMlKDV2/s8cTPGcFak+J+XtU0Hw/Bc+m8wFm+7qJpJTitjFFOFGTPs8bRorVFuiR3ZOCsCcyDD3CjQ/6kKzGBHCY2NTVXQ5p6H9E3wSN1MdnRRJTciOd0NV8iI7wJDDyNCNyPXlYvScGrWwfexvXnUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+t+PhqtGWp8mZt3KPnzxtws0kEs4puC8v90k5TXcY4=;
 b=YiAQqyjFIlNuB7W0lRAKxq/3yPQHLn/yeeCU9iZUSDeNA3bgq2c0NEEa6wqBqLJOp0bHIH7LBUhE7E4mBnkKEyA7i5bUOsN93P0mGnHggznCEH/tizzDPRj7aqwlxTGy3XjeTRqx1lXK5bARAf6/yIFrU36q1Srsx7j8VevkDkgx0v6RSEE3wz+vmM94EMiR3fRKUb4C2MJzFUJWYv9v7tODxkhJ061sSH2+RzjNwEaB2qKrsrzdGr0SupYFTw+UgaU8QWs4jUVUCOCsq++gezFrL9FAv5RPcsW31LbhyYCBdfRVdYy0gai/jOCbItQ3B6WaF/ml+RqeHvNo3X/K9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+t+PhqtGWp8mZt3KPnzxtws0kEs4puC8v90k5TXcY4=;
 b=GC7UUIj/By2a89oaxIsFk4T84ULnsOMROnl8RcFQRHO9JxGrT7dLv94oONb090/IjRgGrYy46it1IquFJR184rFetaQDkE2wKLI1XrggFkA/VY2a9ZEu42ZXgUrZddDh2rD2U7ZZozAOmvci0wgiSeZNdNqDP6+8GNTySdg5gu5o99co1BiUaygFdn4eGrM4eKJT3VuRpKpp9FDnoQ99SdsDehTf3/TGJFGh16jl3HaRGIiXfZ9LyWp4/j6mFzcmZ7MAlhxziEWVJ0jfzBMEJTOJ+Alo3g87+Sj4eP5WtDvxeoKPoflWsqlqy7rVAjVy/SlPgT+svI1nh0wW0zqrdA==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Fri, 18 Jun
 2021 16:51:40 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 16:51:40 +0000
Date:   Fri, 18 Jun 2021 13:51:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, haris.iqbal@ionos.com
Subject: Re: [PATCHv3 for-next 0/5] Misc update for RTRS
Message-ID: <20210618165138.GA2052316@nvidia.com>
References: <20210614090337.29557-1-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614090337.29557-1-jinpu.wang@ionos.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0074.namprd13.prod.outlook.com (2603:10b6:208:2b8::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Fri, 18 Jun 2021 16:51:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1luHiU-008bur-S2; Fri, 18 Jun 2021 13:51:38 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97b28db3-6b47-44c7-a34c-08d93279582d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5192:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5192E69726902ACD5EAECE97C20D9@BL1PR12MB5192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ekt8eshVNm16pFH+jTILXKlpT0Ht8+qhuz6XA2Tvqffip8DVOwtz0XSATwdifFcHsdLlc4QZahTIp7u+Q12Xg3X4SQQ6Yu8NW83CySIt/AnrBFacC2M/Cnsqfoy2I7dEWArO1LIgR8xFfWxYLxaNQMgVWxImzKOiibOXAw5jhfsKp6BQV87bx8vEF2WYTCq+ZBOfErqSWMyLYa6kpxb/Rj3zBCaHDnOtfQ3dHa6o61LCBysc8O1xLncc25jIVZnm86VyRJ9GiZuXhed2u9wvkUgQfn/C6UD46cM6GlJJD5+WA+5SNYit2QkGy3jYwnsQPJQazKCVBgDWS/IthhS0sHbZSsP3u4AoCCn/LnpZBGDZc/K650p3M/jhixpC019GnQU0vlHEPf/0rOCrDMa1a/eGSr9ijU5Bwo5zn5ofUc4y8Jn6GsC/rGykiDHnruhm80DuXCbmpECFO10dPh1eqdZ4p3hec1QhsGdzm9wMG7TO1x10z/7p3eqCsuwYzRqb2Pkml/owCJcWqBCwaiUTuycXwUROkDn+Shh0R+V3aZ66TiM42V8VDDkgj+BgMC5F86E00VfDJet3DVYJJ5nzpLnj71xCqruEMOdmmLukFyyfJ3uJ0j5s8EjlAmpTP8C91Tw1mEfNaqw/2P7laWq1m8mDanq/X8068WliHLPFlVIASqNavJWZfVEsfu043irR0z2Fh+6ClWrk44huEfEvDn2d9XcpFT5UMc5oYuxPvDR3X7LqsaJnI+fZAUsCsgmgJaHoQmj9XKDijCVokFy9qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(36756003)(9746002)(9786002)(26005)(8936002)(66946007)(83380400001)(15650500001)(6916009)(316002)(2906002)(966005)(478600001)(66476007)(5660300002)(33656002)(1076003)(8676002)(86362001)(38100700002)(2616005)(66556008)(426003)(186003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YlvD/RSg8y2FqKOx6qTXzFUE54RSrORzYsieIbvItu+x3av8XSIaQp0z9DLa?=
 =?us-ascii?Q?EMkx1pBacIqtYWCB73apdMrclx3kNtRMXJoKu95WxMHpzKgrlczeLe7PIQHh?=
 =?us-ascii?Q?mNPbGcP3rIGwwWEhukXzUAFWAdK1arHzbbWsENBN36F+JYtRXesPk7+ypMVT?=
 =?us-ascii?Q?JlrWR4d/dTjX+ogQNk984f6dikv+r2LA78DgtfL/CSsNNj0fhZCde+cu/rE3?=
 =?us-ascii?Q?G7k2CWKkBQJthOPsi44LCe6rubQh3aYyiuDDOJmqOdeksBx54mgBRZE7E3rQ?=
 =?us-ascii?Q?pkzfE2M/Brg+i65w1DOO/l2rHRT4lcUkVPApUZA0AJK3quqe/JoOCrLuamlH?=
 =?us-ascii?Q?MQmRNu9UUZSrBV5paH2BpNToGaBzPzVS3OTCTj22ljNCGgDjtthj/RsUYQSy?=
 =?us-ascii?Q?4zHn4ueEkEzgvOkdmqq3vpbMBa350wcs0ovW49w8h+Hiy1ULXc6H78RkZOf0?=
 =?us-ascii?Q?4a9OxYlCU3g1cNv/4PJCJfLxJ7OdD/FtxylpQ2qxsktMQZgHBOcFYDjwLETl?=
 =?us-ascii?Q?IPjFdjoq9dxt1KBsCKHgOxyv/V6W1bmiCRncoKACBEJtiIPg/QtbEIlRRuYA?=
 =?us-ascii?Q?WK5Xd57Tgk3w/rEV8yba66QDcS480R4pfxhBvXkD/U30UmTltHgow6H1K+82?=
 =?us-ascii?Q?Gn/NSB0PtEaOCGltzkr3qBfeGfZh4lWTsXXYrs9r/PeJheCZ4NgQs4NTgjvS?=
 =?us-ascii?Q?56wT96Qm04QP97pcxFAxMA7bVB7ZMLQ09VwDEoMQo1fdPHjXcOAv0We4wJEj?=
 =?us-ascii?Q?z7nqoJJZrtP37bHegB+xV07bpRxjwYG+7zGQMXXhdOoHG96sgCYfoH92L4+r?=
 =?us-ascii?Q?e+eljjNoVeaAlMqi9LDcqrm3kNg2c8jQBp6KPlHAm+JQXUFGabX4FwWGOxDQ?=
 =?us-ascii?Q?iDBp1jEDfNvOMRIrVn7UoetVS8fIfmnwQTLhUBSekwfq3bZpc1wrX6zC5fYg?=
 =?us-ascii?Q?l8cDVcsw09eh/V7sPFp0sXfLLq3NLyEgJrjPk8DuW0KhW2DJSJQcLkEjD/M5?=
 =?us-ascii?Q?KVbR2o5DwNxJfurvHxE9tVTnujI/6pBosdU8P4Kw4CKBte8KrnTgGnNR/8Ch?=
 =?us-ascii?Q?3wSUDfkaLevXp+GgAwXiMzrKG1Ydr7bNnEiIUgpZA+KcC5JgfPvevATH46+Z?=
 =?us-ascii?Q?T4GkQKuhZKEVs/ItlORjTcoKFKivIjvsQe+UzEsb8A5PAidt2J2+cLUKSDV6?=
 =?us-ascii?Q?Ke49p7djjgrbmZ7Xc42zTi8xUUqPxYOj6kaaPEjw73XcYOrm4UsTmZEMaNvq?=
 =?us-ascii?Q?JGN3/NXFAeCzJmLUNICLUNS45MppttBd3yWJVecGHmmr4hwvBgm3q9VFdr60?=
 =?us-ascii?Q?cdBcvwR/jpVThGqV5M/uWHDm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b28db3-6b47-44c7-a34c-08d93279582d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 16:51:40.4251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIb2Zl4XNrseSGooi9N8JYV8q450EgpqFZvC7HBtyiT2qCFaFIuXOAwbwETwGd1G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 14, 2021 at 11:03:32AM +0200, Jack Wang wrote:
> Hi Jason, hi Doug,
> 
> Please consider to include following changes to the next merge window.
> It contains:
> - first 2 patches are for reducing the memory usage when create QP.
> - the third one are to make testing on RXE working.
> - the fourth one is just cleanup for variables.
> - the last one is new to check max_qp_wr as suggested by Leon
> 
> v3->v2:
> - added R-b from Leon for all 5 patches.
> - s/NOMEM/ENOMEM in patch3 commit message as suggested by Leon.
> - Rephrase the commit message for the renaming (patch4) as suggested by Leon
> v2->v1:
> - A new patch to check device map_qp_wr when create QP.
> 
> v2: https://lore.kernel.org/linux-rdma/20210611121034.48837-1-jinpu.wang@ionos.com/T/#t
> v1: https://lore.kernel.org/linux-rdma/20210608103039.39080-1-jinpu.wang@ionos.com/T/#t
> 
> This patchset is based on rdma/for-next branch.

Applied to for-next, thanks

> Note: I tried the patchset for fast memory registration on write path can still apply.
> https://lore.kernel.org/linux-rdma/20210608113536.42965-1-jinpu.wang@ionos.com/T/#t

Not sure how you did this, because it doesn't apply for me, it was
sent from some internal tree by the looks of it.

Jason
