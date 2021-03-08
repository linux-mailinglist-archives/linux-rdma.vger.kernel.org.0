Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0B933056F
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Mar 2021 01:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhCHAoc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Mar 2021 19:44:32 -0500
Received: from mail-co1nam11on2049.outbound.protection.outlook.com ([40.107.220.49]:24289
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230496AbhCHAoW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 7 Mar 2021 19:44:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dy79Gj+dBDAnRa2QSwQkjWVEdvpWY6eQsIHg7wDyAlrd2N0hdi8PDSxzsSX9UwlxWyc1Arg9ojeMRqixkWVZKA2sYHazOpVO7wiG4YsuCWmYAes5SWNyjTw2eCGljUDNEQ6S5OKh1l8vakWJzbVUIylvRhPArMfCivrO5tclR/bbC/FAx2bXXn4TDEgo4xzg0OWahLL1sXpBIF0Bh4u/Yb2Mb/mE5fEzRFZdg6RZTBlmmItK2Kv3Lqzvto1IzyF/BLVa9zNSEC3jOBxU4IkeMhXI1NnTrzqqWbUwRhyqpquJRWBp62C6JhjJI6rxZvKT1QYpfltqAPDVMfJ8s7YosA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EAYno1u5Dtis8c0z3RBqq0N2dHPDlFrduMBuCSD4So=;
 b=FRGiPz/eTeSNJKqSSJNDlk32IWvRWAwip4F5Eq9qEsp/X/y3vXtWK/hJlLnxzprGK6gPj7a81RjScl+PfG5WnejcN0q2SnCUxUQH3SQmfjxUpo72Pc9ZcHBZRmeoVCLEc4U8T3MM0fYRoB3Pn+Yziwazj6DYiojWHwnFqiwOe2P8G5aLtZ7rdd8d3DDQee1silPaImmyTUX3lbZTVm8Qwyh8xGfrfqqydLGRxF9SBUA7HStBnvH0pmYVnBpxIA1QiHDMVv1IAKoUSdjBXkWnyA0i0/4pPCV5tvIbwffzUqFJOBOVIegpL55pPKpGDiUCNJpewyrbQiX+jHkft8q6LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EAYno1u5Dtis8c0z3RBqq0N2dHPDlFrduMBuCSD4So=;
 b=qhtTH3nwdhlFcJ6qEzTQ923geTN+7AcjtS77owA6XEIabbk6hG4Y6iQwyS/gInDuILY1juEfj7aggksKTFVaIbVf1KlAbdkcOtxcTDPEOeROoC8JAsRyx/rKZs6PbaktyAgl8GeJhLHFx/s7QRb6CbtwYlKYSCq7fuL1bjEqc1Q=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Mon, 8 Mar
 2021 00:44:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3912.026; Mon, 8 Mar 2021
 00:44:21 +0000
Date:   Sun, 7 Mar 2021 20:44:19 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        maorg@nvidia.com
Subject: Re: Fwd: [PATCH 1/1] RDMA/umem: add back hugepage sg list
Message-ID: <20210308004419.GU4247@nvidia.com>
References: <20210307221034.568606-1-yanjun.zhu@intel.com>
 <CAD=hENeqTTmpS5V+G646V0QvJFLVSd3Sq11ffQFcDXU-OSsQEg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENeqTTmpS5V+G646V0QvJFLVSd3Sq11ffQFcDXU-OSsQEg@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR17CA0009.namprd17.prod.outlook.com
 (2603:10b6:208:15e::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR17CA0009.namprd17.prod.outlook.com (2603:10b6:208:15e::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 00:44:20 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lJ40R-008mqE-Ah; Sun, 07 Mar 2021 20:44:19 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5e2cc1f-106a-4bfe-665a-08d8e1cb4fdb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3305:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB330509CBB8035A25C52251FCC2939@DM6PR12MB3305.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9X2aTLHjYIJnHKcaTT7lgNeb+BmldszARTczSwCK0b/SLgmXiNazp+Qk8ciYOoYjPBIx77ZbosHuXKUTo/BGhxoE60GnIJ3cGHI+M5t4ybQRJ5XkePTrIiGM710wgCWXhZxNKgXfHVG9h942lit+MTr2cJp70TnaXOb0qSfEAoPmP9tPPWMJxQ4K3ITxCn0o/+ds6D6wUm9qGE+tdcEWxbVotevrF4xuOTStZmGbUGxJEZYXnIeWo8eEwU/uNxEy8/ZpxZ5RpCF66jDBLEZngrdR5gjHHaRCkMcnX80V7PRSKvlvdAlUK/o+1zLXkDwkiV8M3SOCdyi3GK4cgpLP8rd2BxOxFuZUuaPWqSGes1IYQrQUQ529hwpmapYZbf4dF7/wKUGuho082Mn4iowIt8GN34YG/TgXebZUQ71DCcLkGy8F+BLby1F/iH0Pj1r1fhrqb7N6WVa40bDB0wb/docezH2g4ezFeBRf1cXP3UKKLpB7XfrCQOhP93NY8glvlEVYlQjW4Ut3iCNmy7XtGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(107886003)(86362001)(6916009)(186003)(26005)(5660300002)(2906002)(33656002)(9786002)(9746002)(4744005)(478600001)(1076003)(36756003)(2616005)(8676002)(426003)(4326008)(66476007)(66556008)(54906003)(66946007)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Y4fyIPf+O0TdwjJrDjCOmIHyJJzCkvfPMYk8kx1i2sSrEor4zs04XQSzIsg0?=
 =?us-ascii?Q?EY5OztT6kkpT92AHyvptG6lLErmfTLZ8MCnLvrL+ZjH870UrMmpall6PCQzE?=
 =?us-ascii?Q?32c8YKm0CXY5fa1PC+3+MqHc6o2cimgJDjf+JlVb7RTaarPSZXtqpDVnsbts?=
 =?us-ascii?Q?55gwJpIY0NNxDjOxecu5Kl0Q6RMl7weW7z5BFB6N4aI8VgEseoZECiXsCyMv?=
 =?us-ascii?Q?QQrbmKCS5oJv4U8e+Vl4+XS3u9AgZfkBwtcTdQYH8+pgmDSsY7eCvernQ9um?=
 =?us-ascii?Q?j+qRFhVq6XNiYVNA6dDCzeglCJcGEZTCZ46RQaH8BLthuciSm0+qa3XfCJu7?=
 =?us-ascii?Q?/+u01kcNfOn8wx7CLKGLsQ+9wjGHMKO6eSoOvTy/io6H8djWG5JhdR8CC+6x?=
 =?us-ascii?Q?NVcpfHsyoI0XX8rMbkaiv0CeY0S61I1hLo2i1AiLZU2FRvT7Io7TXU7+bxb1?=
 =?us-ascii?Q?QPNsRuMldbwP+PbReMoo42HOknBTkQwAGFmWHnSlaLw1vVRWfCWhmiT4Nljc?=
 =?us-ascii?Q?XeqZHK0Ld518K0A7y4l0aX3xjjMbO+eK7xmkyeZmNm8IQNpDZjeb02Ikn6iN?=
 =?us-ascii?Q?vN81rp6PpAIctuhszZtaN4fq63vDtU9YOaiKmWsqhp42C/IzjxRnhX/ZKhXx?=
 =?us-ascii?Q?/NtbCUoojOyUQEY9/MJiQdAvOrdJdG+rKDZ3vZhBxfgUkJhbV4PPKg09Mm6Z?=
 =?us-ascii?Q?MTv/+975Mg1OA0aRNWtNA1OTEHMgILZ9rNI5ucaM+xGU1ksHjb0QZglr30d3?=
 =?us-ascii?Q?8tX598ghJ0gUV0DwhIDT3URgj//g0YgU6Lv/Yelluc0/jI1eJ2FKz7InNIk4?=
 =?us-ascii?Q?F1EL25Ad87mq3LAFot8Lp1uPUKhEVI3CYQxsageEU4Jxx0CGtxzelfvzye8b?=
 =?us-ascii?Q?aLHcJH1Ki3jmLw/Hs0xc3VCgq2pFrObX8w0OPJpa+d6sxJYxNSCwzU7UYOp3?=
 =?us-ascii?Q?toDamftbVJyjefYLOblVzsyd+B3W5BwDPdWP+3VbvjiegDueJMxbESB2DAwR?=
 =?us-ascii?Q?fIQCTlsW6dp6VMIxu8kMhG+OualDuOItlMu5zEtleObjhvomr+sOEs9rQv+c?=
 =?us-ascii?Q?wekHSifsmIXvZIpPdVXvuMgcAdIdqpy+T+qvBQD9Oi3Hp9yVpSc3UYA5fco8?=
 =?us-ascii?Q?z69K8ZqvEBByHWtjNtEkYI5QQmbktOQmUZ3TcUI4DIickSdRLjIxc5J2bPSE?=
 =?us-ascii?Q?ZJsQEyDpKKy/CWuuGWoKosy44iTqBH0K49XoQZBAhxSNG5r+OMsNjbgsLSnR?=
 =?us-ascii?Q?HDfZpknZur55mwl98bK6kKmUMC4RNRa7H4IplL9wslDgIiiM4z0dESlyomh/?=
 =?us-ascii?Q?tncfBS9o6JXwdXrhRtk630B4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e2cc1f-106a-4bfe-665a-08d8e1cb4fdb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 00:44:20.8793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZll25w6hRbRbWLh73xKSVp/bqvLRChlHPbNSGzwqfdGqfQgqJCA1v+nat5s+Ju5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3305
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 07, 2021 at 10:28:33PM +0800, Zhu Yanjun wrote:
> From: Zhu Yanjun <zyjzyj2000@gmail.com>
> 
> After the commit ("RDMA/umem: Move to allocate SG table from pages"),
> the sg list from ib_ume_get is like the following:

If you are not getting huge pages then you need to fix
__sg_alloc_table_from_pages()

But as far as I know it is not buggy like you are describing.

> The new function is ib_umem_get to ib_umem_hugepage_get that calls
> ib_umem_add_sg_table.

Nope

Jason
