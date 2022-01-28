Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16AEA49FEA0
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 18:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350406AbiA1RFg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 12:05:36 -0500
Received: from mail-bn8nam11on2087.outbound.protection.outlook.com ([40.107.236.87]:45723
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350419AbiA1RFg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 12:05:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/HVRABGWbcQ2+7psC3O0I041tpEbux0yxQLFcl8xqDD4/tDjn+NAvWusfNjAKvPCtxNiRhee8FRVrVg7DhY3CsEYCD22m2cf4pif/AOfYI0A7yMghXQtV7Gq0hEPPsU5xZ7NqGxHtAUBbi3T7o+ZqJ7no1aFyNCY4WCMFSnHeu/Zjzl3BCDH2lCS59RWJ0p1rsyNjLYolCFImP7iJOi85SXJ4mqo7W1N0Hxy+aGoxzQmDHV0T17pxyMicePGv544zJXeqWWDvwRubiYAgCw/UlbGwaLMoi9xV8mvLcO2bTMtQ7JNlGKDFwqVGUCX9Ok8PoYv07nu+wBkTuj2OC3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwtM0QBaIAifQ9GgWHscabdOqX0GcvkYfLYpRD4w9Rw=;
 b=ae/gkcNPG1wMAP6yMp+VhhzSLSviefNfv76rQ3gwZ2CDCH64iAGbihI4Cm/Ow126XsFl8woL9BDKSzbRI8lkEPJokOfzNpB+ubopgb0TzkrHNwHvZ7jI2M5k4hF989SXz7pieX3IW/iVq4aibTmZxjkYSj9PF1QHRl7RNAzN7CkAyAKe+Mqc+svpCtDzmiKr/Us0UlwvTkwdUYP+kx85yERV8zSc3jH5zmYPah465BaKEOJISslgNOHRHPKAtnYusGHLmtxSJnVyu0P6+Aimmwd8nCyZ7MwUrLWCG1MckHiqe5E1DJ12P4KUjvbUSTQDPDscnFFxhEZtoHV/LVqAvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwtM0QBaIAifQ9GgWHscabdOqX0GcvkYfLYpRD4w9Rw=;
 b=BfMHv1iuyyqcjh2cmi3+tAvdHUvawEmyX176y+otlGxzL01a3kOHi1/AQZlr/CGg34b+KUhSpQHy4ilwqKmjIPJV5jX+VGnwvHm5Nf4BP8tSNJqpOixyKDeNAZsswxLwLrx/QzdZlNIx86B2JNsDI9vJsKNIIr45r+nb+6thEwWi3dkMKzcXfTN3JmZZ80L4QH3bBV4nCoMJABwIFOQn/GgxrTApj6FmkAj3NobLDu64+ULc6PXO5CWrUWQF6XQKra8VPrlhP3Lie1FWY77wH4uslWhvHgm8itCimoznoJIYqE7n2q5EW0jJybl2dIBRHqEPh3p3x1OM08h00gCzJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN6PR1201MB0051.namprd12.prod.outlook.com (2603:10b6:405:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 17:05:34 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.020; Fri, 28 Jan 2022
 17:05:34 +0000
Date:   Fri, 28 Jan 2022 13:05:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next 00/11] Delete useless module.h|moduleparam.h
 includes
Message-ID: <20220128170533.GB1884437@nvidia.com>
References: <cover.1642960861.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1642960861.git.leonro@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::33) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff1b8bcd-4206-4a62-659d-08d9e28065e5
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0051:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0051B671AD72381EEA2D1F5CC2229@BN6PR1201MB0051.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c+IqxfqVohq5YFFktQ1kLyZvAK14jxcf0U1WuNiHTeYqSIdy3Mi0LO+exjCrJkCpR9G6bqNXJ7NdQV1FY3YvnqBdW2qnVy/+HTrZTz99ZGBG9g4GZ9NZ7iLG44X22ArcroCkljJkxcKejZTsx64L90pReVNUZeTXpqcFtMiVmrKOJg8Hkv0En5iwsENfwjSY5wwjJ5OeQLNQxy6/BKixbWUUScmPn+vCZTzqIKf38Yw9JHJ1+OtGRBgviVxMSaRz/SkYmQ4xfswsGUCn0lmDd3RHhD7wBtSlXiCtEwszhzs6/Z0PNnBpo83yd2kcJtiBlhRRGbavPYPVRNj9vyMR0Egy78y6dJhHcCZY57fVKS08Dp3+qw25fiDB2pyvHJtY4i0QYpSC9NJ6yB+NcffoPHtUC1WsJpGy6uq8Nleik8PU5FHnVHV8uQK3R9NAe5Fs5gZ6ssiV5JpuFW7wQiQAAChjut8nilQbWKQRPDiHQH30EUmvw689sY9e2V9+EpCnlAspVmpgm0/BjpgcrGdO5HVAFMjQwEa1pura4udm1qIvdXjOURW2a/TypMRZDC3BnvHEsIBlP5t7JCO3zj2WN89pHHr/5A125y/E4s5swnutCk39XeMwJq3SuA255bgRXf++BP1YGrf0dwAPnlxgpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(316002)(54906003)(86362001)(4744005)(8676002)(38100700002)(8936002)(4326008)(66556008)(66476007)(5660300002)(66946007)(26005)(83380400001)(1076003)(6486002)(186003)(36756003)(2616005)(2906002)(508600001)(33656002)(6506007)(6512007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NxBjKZ7bZv0IqO8s860EXtt0uAbPTziGuGN6i7akmdnlTDaTPeRLZv/kKIiw?=
 =?us-ascii?Q?5AamIlF6Cwcz8AHz7gndJKVN1iBU+GdML6M0HGaerIf7kOz7K/LzPq1xuU/X?=
 =?us-ascii?Q?C4UjaLBZhAGXYK7PdZBAx6IfAQH78jajMzBFkAMIweA5zLIrheiUAFedfPiC?=
 =?us-ascii?Q?eOjoJDV2PDOjV0gnn7FJTgKSygzbLRQcXsoWCWfbWqbeBApItDbJ0HArVfNf?=
 =?us-ascii?Q?QEB2cxJK57731kTgTr1Dr9/gUqKKfTjnRt8s5Q4lZukyPdG5e2XzABfdmOOh?=
 =?us-ascii?Q?ZR26hZtgOEa7B88H7hW1Uquf6xIrp+7o1Z5hA370TG+QjMuOfR1QrJ2t9wKQ?=
 =?us-ascii?Q?5Mezia4M3U4TqTfSvcC0U64rTo3WEFIBjOqD/qNm7PAeRGhZmU07b7uYTIaD?=
 =?us-ascii?Q?lal96bTRat7jpgfenvO9q9pA1CgrI2qDTn08qccGpRUCPq4y3SplpObQ/JTO?=
 =?us-ascii?Q?GHGy9U3rppbcFd4/lAPiTW+DAeKeR3B2+2TrANMWY2UYM19/xzzgi8U7rDjb?=
 =?us-ascii?Q?RpL8/KmRarFTvReU/j+mFDZq3tWOuZ5886pP2zzyE6iAokfTn8126l5Xyog3?=
 =?us-ascii?Q?awFUIlnPNSZoQOY5tIGLEjtr92PbmMceVHlv+5/rhRkvRETh73IniXvTV7K/?=
 =?us-ascii?Q?p+Q0p/EjYjOh4LgS/lYR7T7LAzzwbQdfzq84h5M3Iqe72YnjeRUgz7SyjuYg?=
 =?us-ascii?Q?iGKmYySVy/ovDWgtIEjQpqLF6N3VHhwHYzslIiYBBlqOPN7F/cq93Ugxk90T?=
 =?us-ascii?Q?lsDrD8FYBuzbiULSZWZKQ747nDwgCqXyPxPxSCMpfjEHMdTl1fsNvcay70LH?=
 =?us-ascii?Q?4uJBQnlXJX2FOLwJ4t3zHqcFIw2l7qfiAvZGCjgezldjZ+f99nArCrcJDSnW?=
 =?us-ascii?Q?/Wg/mCaw7Fu2HAknHOXSWJcMUzfAy31NxFnlKXGHpm6yx9v28NxUGK0P/L1r?=
 =?us-ascii?Q?skb6B8LkIWgRBwHOcFpNhf005nlf2/bBeWKAOyyeyStpXaCuRyzQpSfEN1xZ?=
 =?us-ascii?Q?X8UXAuQoviD+XIqJNKJIm6YCrI96mW7O5L96/o0YJdN/GsLMxbVXWuYzIirk?=
 =?us-ascii?Q?O1dtiMA6A9RJ7sZwf0i6oZwIN1XdHBElDXkUQ2oUEuH1Z1MeSakZyzdTx2+w?=
 =?us-ascii?Q?g92kTzxErR4nT+mBczhK1bvOxsNJT50cblPb2KRBJxNPKIVAZ+WlzKfBbjeI?=
 =?us-ascii?Q?E1dKX+NqAGe0nA6u4qw+kl/53HUcAIWtydzCYrwEovSbUtlChRFQs1pQYC40?=
 =?us-ascii?Q?LWl4rX7W6cNdL4vFX0Q2cVVrUFqeCRs1djqX6ZkhUCYiMNxm76V6kCdXGDlx?=
 =?us-ascii?Q?EqB5LOdMWmKKgm2Ts8knyRY0tUL+EBVUpSGOUcU3nA2mFa4VRdLpSPss+evW?=
 =?us-ascii?Q?iOt6PITabo63SLULVThaaFRRi7EglyvLXVOreM1gWVHqeHSvBeVF6cQCggIP?=
 =?us-ascii?Q?8CI9Uqasplim8syMOh3SD7HN3s7MRy/det5ZtrA2tXrPGyQtZLUInxHtjCnc?=
 =?us-ascii?Q?aHKMcogp06PciFh70cB/sd+SyRCB/dPkokNhKlRmKSP2esYiE5RRBursQO6P?=
 =?us-ascii?Q?V251bUA1Q/DvydtOCGs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1b8bcd-4206-4a62-659d-08d9e28065e5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:05:34.4265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZLe4KjUm49SQt/uiR8HdacgadkpEMKWDAPLPEjxWH+vZIc9kasMAmW1pj1vcVNT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0051
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 23, 2022 at 08:02:49PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Nothing fancy, just delete module.h|moduleparam.h from files that don't
> need these includes at all.
> 
> Thanks
> 
> Leon Romanovsky (11):
>   RDMA/mlx5: Delete useless module.h include
>   RDMA/core: Delete useless module.h include
>   RDMA/hfi1: Delete useless module.h include
>   RDMA/mlx4: Delete useless module.h include
>   RDMA/mthca: Delete useless module.h include
>   RDMA/qib: Delete useless module.h include
>   RDMA/usnic: Delete useless module.h include
>   RDMA/rxe: Delete useless module.h include
>   RDMA/ipoib: Delete useless module.h include
>   RDMA/iser: Delete useless module.h include
>   RDMA/opa: Delete useless module.h include

Applied to for-next, thanks

Jason
