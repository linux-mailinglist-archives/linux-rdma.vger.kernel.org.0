Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF77393191
	for <lists+linux-rdma@lfdr.de>; Thu, 27 May 2021 16:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbhE0O6s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 May 2021 10:58:48 -0400
Received: from mail-mw2nam10on2058.outbound.protection.outlook.com ([40.107.94.58]:10721
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236574AbhE0O6r (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 May 2021 10:58:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrOy0/EfM+Jn0EuH/FwNdceN1+b9D0eSrJS/R8rb8/eNOgiyEsNJ94ZWd590KhcVfZNNXDneba9flQoMFMsv4u+qaLttskPMqsGB4meGjOwtooQn5OSYAQIeuJnAWbq01urFwXn82NBDz7lNcLPWfL2jkraHb3kzkTYJ7BmKFAPhm8jYj1r8M7BXE5/dP5htII3p/YqIxjiwmjgcKabhF7HhqyrmDMMC26ly1WLtAWnD6rFommqDvLie+MZQdiO3htLvrX0aEUEyjDtElNK48UiWyqcAAuGQS5i2eq9wnkhZOiVIeLvNuMKhHU0FMq+PcXVrwpRrU346nwQ5XqLKJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+6C6RPzTBphP2VMJvNhDQs7bQmUv7OaKs/GQqNc7bc=;
 b=FBxMY9A0GT/nDNgCopBxmpkIp3W3d9R0oPIK08CWh2AmoS6G6nes92B1FwO0umJP9gPy2SpHwieqAYOxMDB8sbeFFwtD6vpbVaPWmNSeyWAtp4yNyVNmc+19CZTmkw9RsOCI/YYY/J47YFg6gjH6agaqL311GGP2MF8x1IWix9vfdNkHGB3BlaHwy2e9U5FAf00Tnsc0F1d4wNB8YjGoNHAbth9HFEHfveiUsl9oRNwuJaLsIakCoaGZHtniqy974fulCeXxAaGQNDaUbuU85vCJ7BCDzrdtVCnqeLDWrverdm7sQ5wJHYqHZMRaY5djj86ncqAlpQpqT+nKz7hCCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+6C6RPzTBphP2VMJvNhDQs7bQmUv7OaKs/GQqNc7bc=;
 b=YRS/d+tOp+9czgrTLhBxpT3rYBzc9E/xF0/MITJIsYaLnsJwJJTKdpuWDW5EXPvw06tS9bhuOJ9NcunGnUxqg0L8+FlQFpvn2VcG8Jjno2UBIqgXi+JSwWkvreB8ruGe+guf71nV/TFKGWCS/DGq7LdAznM0efLSmQCsIxYSMCAzFpnKvOAJWNxLlV/X3uVMJadbgM+67y2Bim0mzYbjojGV69FP5cqCsZWV8ojf0WYwAgJR5ovk0F4r6OcC45WfX3OW6FmJXnQMGt8jvgqKJOzRkQOHMixr7H6oji5wpsqoocAd4bvDpBLscN8vro/CX8YitECvIRNd/B+34BR/rQ==
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5253.namprd12.prod.outlook.com (2603:10b6:208:30b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 27 May
 2021 14:57:12 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.023; Thu, 27 May 2021
 14:57:12 +0000
Date:   Thu, 27 May 2021 11:57:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 2/2] RDMA/mlx5: Allow modifying Relaxed
 Ordering via fast registration
Message-ID: <20210527145710.GF1002214@nvidia.com>
References: <cover.1621505111.git.leonro@nvidia.com>
 <9442b0de75f4ee029e7c306fce34b1f6f94a9e34.1621505111.git.leonro@nvidia.com>
 <20210526194906.GA3646419@nvidia.com>
 <YK992cLoTRWG30H9@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK992cLoTRWG30H9@infradead.org>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0136.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27 via Frontend Transport; Thu, 27 May 2021 14:57:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lmHRe-00FamS-8w; Thu, 27 May 2021 11:57:10 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8864009-d272-4e8d-3ccb-08d9211fb559
X-MS-TrafficTypeDiagnostic: BL1PR12MB5253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB525314A0C41CF9823D81D656C2239@BL1PR12MB5253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IyhDYihKi304B9t91YL9FI+gi+pyVzmTjUp7uwrONDdlDPhTkHVSPxKillLxGRIoea3L+TPlWUWomb2kfuUyLHZH1tdZhbrzqWHScz94yzL3fzMrpwmwVq6B8l08kW2yXJ249tvladb7I1+NjaX+hYGABlGHKMdxLw0gdorEHFOa363fHlIga98rFdUgDWEmmexxHcv1LYEIrw//A9c00wRfVS+UDgeMP3Kpz7704Fq6iQ/3hOuntwv85PX//6eEHrGISKIWE7lKYiwsaAB4m4WpWaKO+IPrGC6h07OL+kzOnTSSM1kvpx+5lfxulz7AWG81COYMtKGYSb2xtIFbUccaHJf8XNEn0Myf4pof+MOiKY4gTYDrFDOkQEWAX3JYwTqEOtBdvk9Wt9x0e9OOjwR/Cg5x0Tcnt4yIm6itUObi3EgusVPEks9wk/hyuPlzxzXKeHLRCUwQuZkbWbWlm3DEYJAlytX/Clxe1xcELcVjV0nPLmU3rPN/dKdPEK5fnCdUf9A9EmX6k2iVpNUHO4DMpLEB73MgZkCXynLIUl+ipMd7vrov9pPDky7219+ZSHkGgSRxGhXhikBR7eut/1gLTJPw96FPmEvqf0uYSOA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(26005)(9786002)(38100700002)(9746002)(8676002)(86362001)(8936002)(66946007)(33656002)(66476007)(66556008)(36756003)(4326008)(316002)(426003)(6916009)(2616005)(1076003)(186003)(83380400001)(2906002)(54906003)(478600001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?a1SC7MnGS9pIMx7eYnJC16aCLqyaZm8ODGzh0vi1WoAtqhpjul4P9uahJTHC?=
 =?us-ascii?Q?V2rorW8c30C0K3iaIuFqAP4fLWMn4DuDvYCWUgYMxOOUNOJiAAVSc2j005va?=
 =?us-ascii?Q?4sqI3M02elDsGs8M1LH2V8r8MbDm80Fv2U8VVc084FHgMu+TqBzgnNhj0xUm?=
 =?us-ascii?Q?JHMZcqAQI+98OWj2bM+fLERmO4e9ENrZ5PcK8HHYx30HTbM5GDcklu0Yem35?=
 =?us-ascii?Q?0VeT9OyN/yFoh3qV9vj5zoYxh8V5YNTUBAb0Vgb0uh/QjthjmYasNDqbMJZA?=
 =?us-ascii?Q?NsIpMOqsMpe8YwQQTzcbpsDc/585ouh1TVXVDnXncTX2vk3NsdT7tgNib8Xh?=
 =?us-ascii?Q?U+hWSGfoBS0OKGcJMOf5Y1CEN1E0fM8hjfoEJxa7nz93tTVgz0ZbVCbU8dXJ?=
 =?us-ascii?Q?jumLeMtykjQiSrI8xQLhyXb6R7YGmpJbbX9bF7Du1lecc/lCnG7XVfvSm2tY?=
 =?us-ascii?Q?0p47nTpSEOsR1iVU9zRDCv0jvDwWQjrxwH3aBMi2+UKRnbuPEARWREuc/wcg?=
 =?us-ascii?Q?5MrkHVuVUH5mA2py7euHDW2nMTFjBNUgEV+9IiLPZKYPV84hRez0volPODn4?=
 =?us-ascii?Q?SkIhsG1ezoR2cppEtU1++Ildjr6etIyKRT9YD223OYZCnN9vxWbANl9mAInf?=
 =?us-ascii?Q?9YJVhvjHBiSN4hKUM5eKl+20sXHwZPZ3TezwTIJ8zcP4EjEX9Z56psJuPNKq?=
 =?us-ascii?Q?zoNtbpDPAtV4Trn0sYTYNsnnn4LDbQWQRsk+JAa0sjnZH6oiZR/E5uKj71OV?=
 =?us-ascii?Q?XeiGJ7yWUg5ZvnSjL8OT4JJfJvavru5AegFJAcDZfHDlS0AuoWrqEqVS1oll?=
 =?us-ascii?Q?YANUsoO4E2JPa723LBe89gQMd165MQXcO+048KOoJ99J6cakVYpyvUPC+GjP?=
 =?us-ascii?Q?c/fwlN6ai1mQ17N2H4epUaY+R9zj1LhDtTk9j5kMOYN5eM7a7qWtuMRt8gqR?=
 =?us-ascii?Q?fBpgnsM278aEYiuC0TUhuolH8eOpQz8rYF73Pc0Z9CzjtLeLJwczbHJKuTdt?=
 =?us-ascii?Q?qt2/yX3yJH0MJ9VSSdKTbq8gIELfLUlmxIzMWcr9z5RAOlnLsUzZMI3G86lm?=
 =?us-ascii?Q?Q1Y2epNXMK6Q0Fu+FluAMVdWTJCC7J44bDhxQSJ8INwP8a/ci8qqBYKj5IEz?=
 =?us-ascii?Q?EvIYRtA7ro9exL96tYXId2cEfX8Hwm6ywBhFfeUfbYZhBpXozW5BERuX/BnF?=
 =?us-ascii?Q?rLcDfTtI6+IDZ5ggGen8Knf6unTxeStUdVc1G2TEk4xZ3HFazgNk8Qai2rkS?=
 =?us-ascii?Q?rWTMfTZJioFgpz+NCjl0BlJetSmhAF+RLpAKdF4/aBqcLOFR1LtrdIorIN3J?=
 =?us-ascii?Q?0c7FFS3McKDg+rgRsIS1K8a7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8864009-d272-4e8d-3ccb-08d9211fb559
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 14:57:12.0818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GvxK59AVR5Is6T/1jpgJmKJ67ZBPwyxk2pIs9iczZpAIcmPTYnMXWI8HyJU54dic
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5253
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 27, 2021 at 12:09:13PM +0100, Christoph Hellwig wrote:
>  1) qp_access_flags as a bitmask of possible operations on the queue pair
>     The way I understood the queue pairs this should really be just bits
>     for remote read, remote write and atomics, but a few places also
>     mess with memory windows and local write, which seems to be some
>     sort of iWarp cludge

Honestly I'm not completely sure what the QP access flags are for
anymore, will have to go look at some point.

>  2) IB_UVERBS_ACCESS_*.  These just get checked using ib_check_mr_access
>     and then passed into ->reg_user_mr, ->rereg_user_mr and
>     ->reg_user_mr_dmabuf

Yes. Using the kernerl flags for those user marked APIs is intended to
simplify the drivers as the user/kernel MR logic should have shared
elements

>  3) in-kernel FRWR uses IB_ACCESS_*, but all users seem to hardcode it
>     to IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_READ |
>     IB_ACCESS_REMOTE_WRITE anyway

So when a ULP is processing a READ it doesn't create a FRWR with
read-only rights? Isn't that security wrong?

Jason
