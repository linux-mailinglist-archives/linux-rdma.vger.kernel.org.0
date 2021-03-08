Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875B4330D2F
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Mar 2021 13:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhCHMQ3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Mar 2021 07:16:29 -0500
Received: from mail-dm6nam10on2048.outbound.protection.outlook.com ([40.107.93.48]:62176
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230047AbhCHMQS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 8 Mar 2021 07:16:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOYMs6bZZmUGuGTGytf1FGb6WLkjblaxBMyFL8HgWSv5PwkVsGN06FUCDbPPMmDGiB/APPxl2EvfmeG+9OlOcEqvGBnbZ+rSaoEp5LNx/vM3fCAJeo6qV9PPZ7/c5Cp7rA6WAFxadmYgEHTXCYf0d0lE1uS1MDvtNx+h5Aqm0AR9x0P9Ol/dOH4IwvT5PZRTbwvv/sTXzUYLhSfVCMq8x1EgXDqAM3dIR705wMlOsjVgK73mPpcyNVG+8/lQkXAOYT2ccxJVaXK/3fAmBJlRu5d4haPOTHVovTxIs+ML9oXysTZuKrguhNyPmtFYnG+vMOA/bLkJwd7KJFFJ0jzJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs2hnLqxG2SOj0T9eHBfgQg5YCAKY2ykd/GlsHw4dhk=;
 b=VThCg0hjfursquExX1FSXZ/lRXAGTxyAEW8TLksayLt6K1EGt/6YzbBrzm8xEuI/47DvwtZdegLME2InYNWAcoGfAWdSjJUbPohpcvenmI1FqPKP6kQBbgf1B8nHtv3f+gAW3mCxVw3mmnlCnSy7T2Bo0uhp8erb+sLFuJ+JB2oqK7rXnxp745uf/M1zoxbTaVxOdXZOC7KO3zEjZeOxNko0lI4Xb3+Ja5SdJf8CeFHqnAAFOnhXjixuC15rrm9z00JJswUS8pi4zDIcOr6h2HlIRYnE8fkitUl1CPd93YI/QbbCWywKoilSuQKzv0KUHS+AALH9oRxGb2g/gcJpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs2hnLqxG2SOj0T9eHBfgQg5YCAKY2ykd/GlsHw4dhk=;
 b=022Og0Kwn/GpnO320AXOHn8J7UQQtZFmuDYXhA8vnlWyDuVTOXsnMksluM3zGE9zh4Ph4Nmvzzkf2u4YhJIxNE9BGbGQXItlPsTY3MvN9B4CXBjMTHfHs2K+ANnaiWnnvj5sl+Tt/Pfh2kXn/KTTv1BcxrdSLUGRPNLleasWfuQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0106.namprd12.prod.outlook.com (2603:10b6:4:4f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Mon, 8 Mar
 2021 12:16:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 12:16:17 +0000
Date:   Mon, 8 Mar 2021 08:16:15 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        maorg@nvidia.com
Subject: Re: Fwd: [PATCH 1/1] RDMA/umem: add back hugepage sg list
Message-ID: <20210308121615.GW4247@nvidia.com>
References: <20210307221034.568606-1-yanjun.zhu@intel.com>
 <CAD=hENeqTTmpS5V+G646V0QvJFLVSd3Sq11ffQFcDXU-OSsQEg@mail.gmail.com>
 <YEUL2vdlWFEbZqLb@unreal>
 <CAD=hENcjqtXstsa3bbBCZVGF-XgAhPz-1tom68zm7WNatH2mZw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENcjqtXstsa3bbBCZVGF-XgAhPz-1tom68zm7WNatH2mZw@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR1501CA0008.namprd15.prod.outlook.com
 (2603:10b6:207:17::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR1501CA0008.namprd15.prod.outlook.com (2603:10b6:207:17::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 12:16:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lJEo3-008wo7-Fj; Mon, 08 Mar 2021 08:16:15 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ccad50a-3223-4645-1365-08d8e22bf95f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0106:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01068A2A739B0FF61DEAB455C2939@DM5PR1201MB0106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46OkTPq5ROCGROhd1p54mWhrcc39SsI+UoMpIlp90SMLDsKLyI1wJYL3NasWwb8HwaL7cZqydRlFf5P9yL3qYspGp+yWwnvHo0rm4TINnmR7AhA9zqR4Z6qIbvEzGTg/ZyWqjupQU0B6VTmeupNg2LvLg19ylBOR2E9xxFxoAkLpxRatV7U3TQvBFR9IzwEkbIQpsEF4mAiZW++u8jCinxfbHSHhGIKDh+AvaFN4Z1XYYUBGM1fVT00Rum4/bItfaCbSgXQzUD6RhCEAMpCkWExvg1XsacMD0dshtub++0AaUW4zByW30A8+YmT3dcUPsy7v05mku4BEry0mKEGqm/ls/Dahh02uwzKjqDPPkfmhAmcfP6qXUidruoS5X2h0K9c/m+YYRL+OFK6D6zHdYj9rujh0H0gHg0PvEZu0adXIHDnz/0O4nydxwigGCqQnd/DunxLs7+CTPQL56Uf8Tlmmbt08CC/YOq9NZMzG9k6mKnKBoOOqqGfNqAbHaGPHnJYFnSA0y9Hx8iCVgzKODg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(26005)(9786002)(8936002)(66556008)(1076003)(9746002)(426003)(54906003)(316002)(2906002)(107886003)(4326008)(186003)(86362001)(478600001)(4744005)(6916009)(66946007)(33656002)(36756003)(66476007)(5660300002)(2616005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jnnCmeAOcP7jBRFUdxn/PnP/anfxkaNoq+pfBHtPkT8B0Tq6AvVm6en7VpdU?=
 =?us-ascii?Q?RVColkcEiZ0VnuWOsHIdD0/8ML4RQTTYu7fCHVyc0IGbDw1u48QmpbRH7BDS?=
 =?us-ascii?Q?QqZXoN4DSmWz/aId/UOhjFNdZXamWniy8dTdpKYlRxXi5fOqs4UNNrsHR9hL?=
 =?us-ascii?Q?o6nxjPDSeVjYtMXpjHpACuNXHb4gAPjaMhaaZT2/A6RfF/qB+FE0Zud8vv3I?=
 =?us-ascii?Q?C5eKScgeuMpiD23Knh6Tk8ZTs2TQ2pJGNuKjjLPF6TfFOuXSWr+MmC2Xv2ND?=
 =?us-ascii?Q?3RUsA4neH1BAvNqd1PvRRWDgY8POlI1UKmH617UqfsWEyskv/FAobH5mPKwV?=
 =?us-ascii?Q?gwRJfqO0xRxS6fl9d1FAKQ3DYnpWsyxWHMsp0EcXx8q4YrDK0S3U4Z60C45o?=
 =?us-ascii?Q?49NdOGf8+fXukd7foEV6JiGmbGQyjADwxCwap+oUL8Wy5QfhKjmH4ElN0THF?=
 =?us-ascii?Q?WVwjS0It2UFkN7OGzT4UTSNbtY5VDBQ0v5Ccal+CbHIgpMs7mlus9bZrG1eJ?=
 =?us-ascii?Q?pH8/ROPwrHxIHWDM6nSEslwiB2FfWjiGJJnOydW8VykKdKiNh7dOa/G1tpvF?=
 =?us-ascii?Q?RY/dWkuApisj0gwoMeQK5WENUOkbcbEdSNEpq4v3keNwk5JMxvBSt/6I2JDq?=
 =?us-ascii?Q?Pk88zBZKvBil+QWBIGjluSgevmz2cMGsr+avFLs/3RxzUc1gPBZUiuUGnF4k?=
 =?us-ascii?Q?OPVlg3nDotLDK2L0WSF0zPbA/HUDabnOQrOOGQ011s3JyWcDsFMZx1ia0zFf?=
 =?us-ascii?Q?735cMYYA7jp7QsxUdxcgCRkEqZN3UTRXzavq8NZ5AvtWOlDlqlXMnUbLZCwh?=
 =?us-ascii?Q?1Bv6otZvjyrXiV43qFcC1dqZwo+thZO+5Glb29DmqRcI0KHYnXuWlj/Tl4hm?=
 =?us-ascii?Q?jUxuGyqnyLmZwcEpe6N6tuet3LNOXRyQ25gMVgh32t5DFP0fxrYWPkXIRK+L?=
 =?us-ascii?Q?OsSSNLZ0NTydNvBgpH0oW1ZzCEChZx3V+vdHhHib12OHpR8CNJILS1YD1mlR?=
 =?us-ascii?Q?WLuy4s8HMdOnkBVRme0AlAw/UNiULZgZtERtYDv42U29WBtOhFR4D3Hv+X/H?=
 =?us-ascii?Q?bxSA6aX7K7AYCX3Tz2LkLkhSWJjs2kku2VG9Hcbc52ZC2DEOKQC5/jEW8DnQ?=
 =?us-ascii?Q?Ii+k92hxGrnwGMApe/XwcZZMupVBfnuqtUkBssLwsDvsxwEuowD36PZp2pid?=
 =?us-ascii?Q?LqsRQGg5dUaWOcYDjZXUoR43SFbp8hiPQNUIEM+aPFj0s2ubaQDiHhTFdhrY?=
 =?us-ascii?Q?hJRoUnSAkR81ZtPRBPTVFxzecQMDE2yb6P1adD//LMVVE9WWfHuw9EDwM99t?=
 =?us-ascii?Q?FuqbxcHeeeCJk2+FDH0+h4+3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ccad50a-3223-4645-1365-08d8e22bf95f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 12:16:17.2881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FE1WWljyZIscH0/IzTdsy9wbLlNHLHuUVqLyIrIa6Gwv7b62QUGHSI5wLp+A4PhB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0106
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 08, 2021 at 06:13:52PM +0800, Zhu Yanjun wrote:

> And I delved into the source code of __sg_alloc_table_from_pages. I
> found that this function is related with ib_dma_max_seg_size. So
> when ib_dma_max_seg_size is set to UINT_MAX, the sg dma address is
> 4K (one page). When ib_dma_max_seg_size is set to SZ_2M, the sg dma
> address is 2M now.

That seems like a bug, you should fix it

Jason
