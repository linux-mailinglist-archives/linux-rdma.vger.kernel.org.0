Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A393AF9C8
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 01:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhFUXyv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 19:54:51 -0400
Received: from mail-bn8nam12on2063.outbound.protection.outlook.com ([40.107.237.63]:22400
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231975AbhFUXys (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 19:54:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bx5aNycB9MMUbZXKEBviu3bpGm4TGfEbigf1eC5NtTyGMA3qsNyDXXLMdsLcbF1Ae/DrX4O0Dfvvao6YuAZrMFqReaHo/yrJrjzzn+uRtEC1txE5AxtOfRkFofVE3YYHCOprTjcfLGej2fezkCRaHhMEzWfDgdUhN2oFRtkX90KSah+NWLdF183ocGSiihFzlQtfoU3XMFQ4Sp1fxOSRNemWXqQeu//R/XGyagA+wymkTl5ZAFcpkG9mtj4GYHprWCMqSCJBgebuHBEnlmq/M3xMFpAeLZbc/FPYkHHg6svaWBDcFinl07GFNmHc4ZCcf5tebQf22Y4Jt7oI2f9A8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plHilSCnXyIO3yolpaOb8qIFV8R+gL77+ThFFzTgPPc=;
 b=PdXxm5W9O/VoAiNG+HbTpOHYdPjPHEbdOs10nrU1IEkssbJJQyYzyptKUooEO9mP6hds1uHfzfzpK5nLoW/LUG5qE9o9KkPZBrqqH/icjcBuFdIzAQHLwNoLcLSiZUD6WLqbBaQrajkZD5myO8+xEyzigyRiNP2H1ShEH64KO3h6lHZy9uaJ6xtHMbt554gtXYkEopdOuzt/iMQPP8ezwEcg/J1W3VHw1f3gbfmH628SruAtQCnDMdfngRX18ZLEfsVbkrKTccnkUbngi20yTGLJknKdE3bMCDob6TdZQwtcSWyd5dOi0U97E3mEq3LYs+m2fC+49Qe4pRCyYFeAZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plHilSCnXyIO3yolpaOb8qIFV8R+gL77+ThFFzTgPPc=;
 b=YaWs4tNrXzY1dRM4bsid+WpsWLAWjMnkolOuPaiz/woBtHmYfyi5K0rBcOJeS4UrtKJjtoY8hurzk/4PPsNgl8BMx1Ml5hSYhFPy+uoSP9jrd1bRNT1WSpX9Yox+JGf2w8DjnQd0QhX1a3ZWiGS8zAmHoQvdP3wZbb22EP9UthEcAv85j6jaBsl0z64+xmlYT0dAFgwIl4DVteqJeOGQH1jNb+R68cH7z911TMtxo6xw3EABfnnWTvJu2fVNBNiC0MuS8D6Fs1X3vu0BQcE14HT2I1sKYyPwDml4c8ujqdb6h4nssqqZSfMT8OmPCiyCDZF0nr0SoHsaeI70jlfXrQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5095.namprd12.prod.outlook.com (2603:10b6:208:31b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Mon, 21 Jun
 2021 23:52:30 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 23:52:30 +0000
Date:   Mon, 21 Jun 2021 20:52:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Lijun Ou <oulijun@huawei.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Weihang Li <liweihang@huawei.com>
Subject: Re: [PATCH rdma-next v2] RDMA: Fix kernel-doc warnings about wrong
 comment
Message-ID: <20210621235229.GA2374294@nvidia.com>
References: <e57d5f4ddd08b7a19934635b44d6d632841b9ba7.1623823612.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e57d5f4ddd08b7a19934635b44d6d632841b9ba7.1623823612.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR1501CA0002.namprd15.prod.outlook.com
 (2603:10b6:207:17::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR1501CA0002.namprd15.prod.outlook.com (2603:10b6:207:17::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Mon, 21 Jun 2021 23:52:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvTiP-009xfc-Jl; Mon, 21 Jun 2021 20:52:29 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e2cc442-2fb8-4808-4199-08d9350fa1b7
X-MS-TrafficTypeDiagnostic: BL1PR12MB5095:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5095870E910565D72D52BDE1C20A9@BL1PR12MB5095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hcaAH7VtAx/pSSGhbGR3fTCe2BbPPYzfPr8yzsWd+CF9wwK91XUDpns7+laQmyMkh0XL/LeADbh1jLVyN82ZyI78PyO/1/x8e552LVwyRweYb9sru+RhaKGQU7lOhqNkYLe889BKMMY6KrFDKo+793P5Ze2hgHmbL21AAT+vJHEsvtUtRs4FT25W/mY4oCEKTl0LGt52TPENztUDtTv/XrWjeqxC466YUT+eDXm7ANFnMFLbRuKeLPUkS/IcYzPJrn7PhKPc9rFDnmlGuNcXJZ2/P+eoR3uttsOPfS8/1qgkvGmk6V9bFTZEhZHMzPGAazL0v0JPOZ8f2GU1yQvksO31uKKFnGl2xF3zYARLsZVxtdIniRlGCcVgw2MGB3aqCUbKDivSQLbRkOgkUojyhla+QhmspDlvj5qlJ6Bolul/UQPI+SBNPNWErEmQ2rVl69zzDBTgB1u3B+z+2ncp9YSbbzAIPVDTlf9ATIrM53JPip/v07zz1HiUra7j8ws2JY85nBgV4W84AFAvJAW17hgZRONXzu81Vg6vwnnYfW3Hi8eaG7s2a+K9NKkP1XEn8PXy69S/FIWyNNbdD83jlmoFWTOKpdoUO5i+apBEQl9xGOY0VKAqDyg8Xdjh6YZVQz9tXiIn2OUlNLKaGM95kaZBQXNyiAlJDU8SFGafE3OzDE1e8mTQsWU6UpKBVGQW/5yvXYitJXlZT4tA/wJ06etVCenREmw7wk8qfoariQ1BCtE1qbDXrJd+MEzRfmVJ4SbGcmGNjFr1h3DVo5xlbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(1076003)(8676002)(26005)(966005)(6916009)(2906002)(7416002)(66556008)(2616005)(4326008)(316002)(478600001)(9786002)(36756003)(33656002)(66476007)(66946007)(8936002)(38100700002)(186003)(426003)(54906003)(9746002)(83380400001)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WjBkZsnY5ihfdlqyBfYqrMF41USGkDZDm6nGDdjr3z6tWa3G7ZF0VhmWFXWc?=
 =?us-ascii?Q?ukw9JTXZhkUGFeV4S7/PKDjQpNzQ62CsPPDem9GxOMdqZ+HaHiYNYkVc0QUf?=
 =?us-ascii?Q?KfKQoicaBeXsHTlBt/9e5hyGbBt6AN4JFfUXMd0KdbDXDGh37aiALzXinKJZ?=
 =?us-ascii?Q?1TMoe7GVw9G8T3z4YQOsRe2sbA9DSONRDpLgz1CuEb9freawvdmDdWndkWQx?=
 =?us-ascii?Q?AsLjbKCIvM4r4lPz3PH3J5EyCPCm14+k6LFw75rDGLKkxvE55GfwOHyPnONx?=
 =?us-ascii?Q?3XBqNWEgRGyf1I3FkwlDsZAvtBED3HPkvHNeqFzhPt8ng58nn5ekBQnGQsM/?=
 =?us-ascii?Q?WUjdV/pL/VrOglVmCDdT7ucimKegE626Kowh2x5IxxM3pT5VVqBy3a2xAmoX?=
 =?us-ascii?Q?dZnRES2HGoW07ENRZT0lNB4Gg7ahqxd4PcKdxhQNR90y5IGAdiJpJGs5FGhG?=
 =?us-ascii?Q?1tAbJR9sR4uoL3t9czEN+3SWtjqc9Qp7dFvZF1+DmajAP0yZX7FXwfNCx8a2?=
 =?us-ascii?Q?UUub4Y33gHcyB38aweOJ2BX1lagHLFcw1vg8iGILNAiXcd1OF8gwDS+2MyGh?=
 =?us-ascii?Q?Vb5IrNDFlynamOMke4CjskcXgG47fbfSassBbXdcYeH57F2PF+CKVJDLkqP3?=
 =?us-ascii?Q?eRBkvkd3WRB9lNkTn2GDqOkWOPDZWkvpvhgtg0eJ1FrTYZb8CvNiKUGok6xw?=
 =?us-ascii?Q?cka9zU71H20Cg+3uBsQzlBmxMYXwKf/i1Cmc/u+zo57cq68CPoTjiQDokKOM?=
 =?us-ascii?Q?dpyYEpjdJpoyP3v/MHxQw5hl8HLOcjhSS6uakzr3n+naVh922PCm5DoTzaHp?=
 =?us-ascii?Q?JBD8XfZhtN7dBhq7Pm5fn6Mrgf5h8EOmyRH2GwvuqMf1EU5hjZdZzSpYmS4H?=
 =?us-ascii?Q?RLQKqBJwPOhPTRsj8At7xvKsdYMpxv/ihEfVTTTMKOWqdTCPZARHWfpPCDUg?=
 =?us-ascii?Q?xH/7kshc9vUlNVJtKna7PWYjQ9AIUL3mAZBQXKAjgoQmQvzQ42s8GGr/exMm?=
 =?us-ascii?Q?S7hSaOu9d66Il3G1SHi3TAa6kmhOOzgmlKwxPMKL0LskdBgDeqKX86QDuOzI?=
 =?us-ascii?Q?3Rpe0W2C53epUDOLyFIRM74hU2uOi46hvWP3+2ijjl2tnS2HAzbHbksmhnoV?=
 =?us-ascii?Q?17BIrwsBXhRW50SoXBHsiyWPFJpRLu3YMMXiCbn2L++oW9vIm+aTqxbpkNbn?=
 =?us-ascii?Q?lNpbHj2eexSM4TU0Na6SP6gbnS/O/xB3s2CLZrXZU+/QSSAvn+BBh5doAGJk?=
 =?us-ascii?Q?hwRE1/4q/ZqGdWHpHlkrYHWmZknGBgrSyVGu2ZhdURG7SM8KjP05gZtgVqKh?=
 =?us-ascii?Q?YidO5mWvnWilk2Byrr4XTgZm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2cc442-2fb8-4808-4199-08d9350fa1b7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 23:52:30.4544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5fA/0S2g/PQ59VrPX18XrUSN7FZiFJ8gyccIcKSmrFWLUn0a9fJqlpIAdWMFRAa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5095
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 16, 2021 at 09:09:47AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Compilation with W=1 produces warnings similar to the below.
> 
>   drivers/infiniband/ulp/ipoib/ipoib_main.c:320: warning: This comment
> 	starts with '/**', but isn't a kernel-doc comment. Refer
> 	Documentation/doc-guide/kernel-doc.rst
> 
> All such occurrences were found with the following one line
>  git grep -A 1 "\/\*\*" drivers/infiniband/
> 
> Reviewed-by: Jack Wang <jinpu.wang@ionos.com> #rtrs
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  Changelog:
>  v1 https://lore.kernel.org/lkml/8b40bbff098247962af5a7b35d47b2e964daa523.1622726066.git.leonro@nvidia.com
>  * Found two extra places in hns_roce_hem.c
>  * Added Dennis's ROB
>  v0 https://lore.kernel.org/lkml/635def71048cbffe76e2dd324cf420d8a465ee9d.1622460676.git.leonro@nvidia.com:
>  * Rebased to drop i40iw
>  * Added Jack's ROB
> ---
>  drivers/infiniband/core/iwpm_util.h       | 2 +-
>  drivers/infiniband/core/roce_gid_mgmt.c   | 5 +++--
>  drivers/infiniband/hw/hfi1/chip.c         | 4 ++--
>  drivers/infiniband/hw/hfi1/file_ops.c     | 6 +++---
>  drivers/infiniband/hw/hfi1/hfi.h          | 2 +-
>  drivers/infiniband/hw/hfi1/init.c         | 4 ++--
>  drivers/infiniband/hw/hfi1/pio.c          | 2 +-
>  drivers/infiniband/hw/hns/hns_roce_hem.c  | 4 ++--
>  drivers/infiniband/sw/rdmavt/mr.c         | 4 ++--
>  drivers/infiniband/sw/rdmavt/qp.c         | 3 ++-
>  drivers/infiniband/sw/rdmavt/vt.c         | 4 ++--
>  drivers/infiniband/ulp/ipoib/ipoib_main.c | 7 ++++---
>  drivers/infiniband/ulp/iser/iser_verbs.c  | 2 +-
>  drivers/infiniband/ulp/isert/ib_isert.c   | 4 ++--
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c    | 4 ++--
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c    | 2 +-
>  16 files changed, 31 insertions(+), 28 deletions(-)

Applied to for-next, thanks

Jason
