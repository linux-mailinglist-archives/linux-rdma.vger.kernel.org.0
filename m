Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD333B0815
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 16:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhFVPBt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 11:01:49 -0400
Received: from mail-dm6nam11on2085.outbound.protection.outlook.com ([40.107.223.85]:53240
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232052AbhFVPBp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 11:01:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABcKXOIaW90gkHYf48Pss6FW/nVw8t6AKPSS3RKLs8cxI5ZUYLZiP1ZrGaT566V7riqjMxktzGT94FoGZYRbaZHXCCkHcRpyI8DgqBVsm+Ac+A1uduGPgVnocHEMVeol10qpVw1kK1DFLm+vE4SNuIHxuvIisDPiCs5jub12z8e2gZ6ihOWUE0HnRSLrZma3m+LFiI/gWbheyg53USLk0k1XxOE6Gr2vbwxZxon1gdQ539EqAWg/kSSZWuK3NNUMOPCT8aXfl/V9AsuHjLm/jHnlIrrgaLXvavOoD+r8FbasRuj/r7/o1rL7YyDA9ueP4N6SqQlx+GZtcxAHVLxOkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AV+Ye2pM0y/j9vqKc1pCJ6uobuqhFcY+izrHmu/hzA=;
 b=gYJZskdpNfSS8hBrQjl1+1kzwOaPE4MnNZSE1w5TLot8PBzynoYUwtfLDN59qJv+guVOwZBn2yfTVgu6m6TUDGPZ5XbL1rC13vF/ciI8yCGLmIbyZuohRqUQE16YZKPHfsvDfcKFTIsB0AeIZA6I8b7j4C6Ii1zDmF5q6RquXzTK+Hz/JgdSiWgW30369mSXmAPth8Fad4DaXq02C5Gxu6Rg48w7acSw/RjubYUygwXo5DvU6OqgnkGH94Nrd2nQFLwf64h4hXERtWpv9GDXU6ndhQM/8QeUb5ClXQuT9zGG4MFMb34CaUpcET3RK6/PgLjj4nErEmMIMIUWZt8fTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AV+Ye2pM0y/j9vqKc1pCJ6uobuqhFcY+izrHmu/hzA=;
 b=TcL0fR6eHezl6FDtnn9v/PjsF6uLoOZ5+kXTq+k7ezHz6qPyFdlRyZQGma1Ra1SAWnqd1+DIqVVKgQ4T8Zv30SMH2rU1VVgZHSLFNgzD5gaCJPK8nx11lL/zwaLFlXH+OUKXxyeyOuK8HGd1pU3m3DKTvdRETCksPGsthHCEG+RtgWWPWjnd5YLEJuXtpUXun9hBn9qApvFQlAOTu1JJJ2Tv1Up4d8qOGizdE16MErbQde9yK1I/Ven6SPIW5HWj3gS3aDabEshukAvCLUzdms4xOH1zuOB4u5RnvFKpDd1bX63tQMmdSwRjcPdGk6h59zrNBgCmsHSWVqwJzjHASA==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5239.namprd12.prod.outlook.com (2603:10b6:208:315::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Tue, 22 Jun
 2021 14:59:28 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.018; Tue, 22 Jun 2021
 14:59:28 +0000
Date:   Tue, 22 Jun 2021 11:59:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Mark Zhang <markzhang@nvidia.com>
Subject: Re: [PATCH for-next 1/2] RDMA/cma: Remove unnecessary INIT->INIT
 transition
Message-ID: <20210622145927.GC2371267@nvidia.com>
References: <1624368030-23214-1-git-send-email-haakon.bugge@oracle.com>
 <1624368030-23214-2-git-send-email-haakon.bugge@oracle.com>
 <20210622144729.GB2371267@nvidia.com>
 <23AEB866-AB67-4148-93B2-90D785EF1C8F@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23AEB866-AB67-4148-93B2-90D785EF1C8F@oracle.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAP220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::26) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAP220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Tue, 22 Jun 2021 14:59:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvhs7-00ACtu-10; Tue, 22 Jun 2021 11:59:27 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11a394a7-8143-453e-a2a6-08d9358e550b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5239:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5239A46E996B4C569207EAE2C2099@BL1PR12MB5239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gIebZONX549XddpywaoedAXRUQjA4BjfuSe7shtAcsyy3hSxJNfLNEpgPlgZc2meFW/83c7Oco9xMfsPmE4Y4XYQdGWfsrI15j/bYtnQYLIpVPJwhQgQdaFSwV0wssHutpG3cso8km+8KwQBozrTt2azPpzVXHceQ00+aPhb/0P40duj5gq/ijWnBCds9tqaxpzSEqft2UU5FZU11ykKVly4dBH15omdRTpASGdRpJghc3pjhSL6FFxlgaTCTZY1jACB2tYCLclHYSvV+ZPP/RAjk66QrQAFmEvbyL4maF3y0JYvUCvYivCrsnpPFvDTXhCXO5d2ldhSjVJrmF9isGDAgBXa8VO3Xw2K5ak9AIK0cRIzL9tqLBT3YZaMG9aKPRUd7HGivIKScPbr3+KLVpRhpprUPXKa2Sf9k7aj7ug3oJmyv7BgsNgE2qVDRHAa/3ldma6OX/8hpUVhXHK1u5B+KytY6XJmfSVkc24N2qf8Wx+WyTwdiL7L8UdpWoii9dOS7kz023Nq68cfKMDn/EvJZ/rVq3jG9SR48tvPesNdFvE5mXT3BAZNe+N+T7ViPPgSlbu96kPn6DUpBjKyR2V0Z39L8SUHBC9ZiEWeS2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(66476007)(66556008)(8676002)(66946007)(4326008)(8936002)(33656002)(186003)(36756003)(478600001)(53546011)(6916009)(26005)(54906003)(38100700002)(1076003)(4744005)(316002)(2906002)(107886003)(5660300002)(9786002)(86362001)(9746002)(2616005)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWkwaDNaVUl5T2ZFelRUeTF3RmxCUU4xQ3ZVTmlEM0VNNFowY1Y3WjMyNXdZ?=
 =?utf-8?B?SEFnSm9NVmNzK0s1TU9LN2wrT2tMbHpiZkFLa0dQbjFIMHFEdXZlOGZ0aE1F?=
 =?utf-8?B?cTdONTZDc3VFZEFtZ0lJUnBYYzNycGVtS1hIMERvamVlTkhBWTBvZi8rSUkw?=
 =?utf-8?B?TnBOa3Q2MHo3MnZuZ09RajJJMmI2bitEOG1aWUlGa2dvUE83NUU4UHIyaVdl?=
 =?utf-8?B?WjRZM09PWWE5VHlBd1lSYjh2SnpUY0hFMDlQYWxrY0pjUDNtUU1WeEx3WHdr?=
 =?utf-8?B?RWJCUTFKNEJLbnQxTllhNTNJQmplTmtnMFFRcW5jTEdmaDkyZFdFUEJlbjc4?=
 =?utf-8?B?YlNxcmU3SzFDTlhRaEVsOXdDUjdFamFmZkhUajQwbjN3QUNWc1NqZlZHYXd5?=
 =?utf-8?B?dm0xM25GT2trMlVHZ1RENnFiZlU2aTBlTFFicldpOERGWlpLSGNEUjJLd1VL?=
 =?utf-8?B?VjdxU2c4VWVRNVQxRjI2aUhlKzRITVE3ek5VbjRrc2NtTFFxM0VNSWVQdE1V?=
 =?utf-8?B?ay90U0tjWm15a3JvSnRvN0NyQ3lZNi9nZ0pMZmFkSGFqZHU5aytxOGJpcnI0?=
 =?utf-8?B?U09TOElWWTFpQU91NVcxL0EyU2V3NGJOREdTZzdQQjVPY045c1BwNFlzb1VI?=
 =?utf-8?B?SmZFQkNQYUhDdUdrQi9NTmlJSDFKMGVXUTBYK3o1NG5xQy9jQ0lZRi9hdm1h?=
 =?utf-8?B?ZkNSL2w4ajhpdUYrNm9TamNvdEQ2ZGZvMkgySlV4RHpReCsrTGRoalBTa05N?=
 =?utf-8?B?UHczTERkbzRFMEpDWUhlR0xudmpBTHROQmNBUTBQSlVDdDQyZzlzRFFla0pZ?=
 =?utf-8?B?VHVuZTkwZHdSUG44UGUyQ3RPdlZtT2c1SmxwVnJuejhuK1d3TGt2UlJ6MmRZ?=
 =?utf-8?B?WW1NNHVRNWZ5Y1JXMnJEdXE2ZFhyNm9XNmI5WVl0NVBERWFOby9RSWJLR01p?=
 =?utf-8?B?MGV6YmdpSmU4N2NrTWkwekozWjhab2RZN1Vub0FOSTZlbnJHejgxQmc3RkFr?=
 =?utf-8?B?VnlxR1lTbjJOR0RLc0l3eDZrVllUS3I3VzJ0bnZvNTFXV05tOENHQlpRbFVL?=
 =?utf-8?B?VlUvNGRhTWptS0tJdkE4aUJob25OU2FKbFllOHZaTERlUWtFU0tmQnJVRExX?=
 =?utf-8?B?V0xZRzFqUk1GMFh5N0ttRDY4QkNxL29HQVMwazJVVEdTTE1RZmJIdTlqTlZv?=
 =?utf-8?B?V1MwcUNQRFpPYWNTdncyTXFzQzNBS21ZUmk0QU1tQ1BxRVZ6enYvVSt1eDVm?=
 =?utf-8?B?OGdLZE9FOW5ORTFoWmVUSERzYUdUMHd5b0trMEhnL21ZcWt2QWF6aDVrVHd1?=
 =?utf-8?B?Nk1nWUFXQXE5VEpLbk16RGg2bVlRSUNDRmJpNFJhcUFxT0tSaHA2NktBd04v?=
 =?utf-8?B?OExHenZrbVQ3aWFESDNpME9rT3F3SFRscWhhaHNFck1tZkZKSmpFV0R0MHhn?=
 =?utf-8?B?TFA0TjZxWlgrUzFFeU1uYmtVcyt3TkJ6TDdhUXVscmJibXV4Q1RpU1dwcitp?=
 =?utf-8?B?Q2ljQ2ZPR2NPNmg4WWZnTmVRMkltb2xhTkpaK3UzMDhSQW80L2lLTHJsSGgr?=
 =?utf-8?B?N1RBVHZibXluU3RBVVZ6VHJ5ZERkRGhCSDZTVnVabFdpOXRvd0lyYStLQlkw?=
 =?utf-8?B?dmZrc0x2SzRHZ0N1bkRIVm5hd0hSWTloRnVoVUZ1ZEJaYThlMmdVVWpwbUFw?=
 =?utf-8?B?SjUrZmxwR0cxanpyMnVOdjY1S0VDVzQ2d0RuMVBqMDduWmplVktjYXdSYkNS?=
 =?utf-8?Q?GBEtEn4pO2BM0EcOhBVtx26QexjdtYY7tYHaOxu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a394a7-8143-453e-a2a6-08d9358e550b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 14:59:27.9762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xn/HqwcUz6EOP+imNFm7IQWs+ODLDeypSC4iGW/Qm1RcMVuv2B85hHkAfma/vQs+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5239
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 22, 2021 at 02:53:33PM +0000, Haakon Bugge wrote:
> 
> 
> > On 22 Jun 2021, at 16:47, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > On Tue, Jun 22, 2021 at 03:20:29PM +0200, Håkon Bugge wrote:
> >> In rdma_create_qp(), a connected QP will be transitioned to the INIT
> >> state.
> >> 
> >> Afterwards, the QP will be transitioned to the RTR state by the
> >> cma_modify_qp_rtr() function. But this function starts by performing
> >> an ib_modify_qp() to the INIT state again, before another
> >> ib_modify_qp() is performed to transition the QP to the RTR state.
> > 
> > This makes me really nervous that something depends on this since the
> > API is split up??
> 
> As I commented to Mark, no ULP creates a connected QP with
> rdma_create_qp() and thereafter modifies it with an INIT -> INIT
> transition. And if it did, the values modified would be overwritten
> by the (now) RESET -> INIT transition when cma_modify_qp_rtr() is
> called.

Does anything call query_qp?

Jason
