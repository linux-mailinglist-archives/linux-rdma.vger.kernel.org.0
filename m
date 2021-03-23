Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0D7346697
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Mar 2021 18:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhCWRon (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Mar 2021 13:44:43 -0400
Received: from mail-dm3nam07on2061.outbound.protection.outlook.com ([40.107.95.61]:58176
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230336AbhCWRo3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Mar 2021 13:44:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKjnw/vzLZb67euL62n6BMGStuneTsrqPyvLysqJwdc+luBfr96IrVM+QN+vUxSFMrSzDw4oLzFup33lho1Q9w7PlrtHeo3P6pDq9S9o7uB/m81YiqpOv8o7FNhdyJyxg/ycBxHlZa6hSCO16Trweh6CqZFQxum3iifVmZMfvrDUp3aK8oyDGCKIePybdTlzczKlhlKGqPwQM4Td6loVdpyx8C1EU8U6d90RL0//KexJP+cCFGf8h5hshrRmNV34RCIgISHmBxlWgnMAFoBidqGhTnzgubPJ4TiGZC05K0kNppC75TvMMX1MfEAsv8a3vw5ADDyLdbCQOvVdQOZl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GggPZsQSUXAHtcvvYt6wxqFEnIJcJOp0jLIfEd6nEKE=;
 b=HaJC2D27PG/B/HshjwcK6GC68KuSs/m95+5A3BuXiyxqa4hn9NBdx9f82D5CLJKrOlsh7KBJHF8tzce5M2zX6UAdD89qasRQXvMIQrOHLhRtpqJ3K3aAxsk8oVPW2dShI6Q3jaKl19Gl763ZPaI15eir8b9yek7lMip1OQ/lCjxnSvLtYXDFF31BqsaqTgZFvdPYcxf/U9W6K6DJpiR3qKsp7UGxRTlqSF7sd+DRL0EEG3HmgBq2iljTxGQdUzU0PfIqMxsnojK7FNeXiCswGDgAdltXochRYAz4UtzEfuBr/mbddRLPEm+cmoFoVIG0nOxZ6m7Ci64W2L0+SmLjgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GggPZsQSUXAHtcvvYt6wxqFEnIJcJOp0jLIfEd6nEKE=;
 b=ksU7Zqeiveilxq6OqaNJ5ZDG7LOKkTeE3ggluSz/nDHEZLXa/FjDIJYPc6ggXF8EJW23anH3MR8ZHGttmETRCCiYikNDMSTWuVBlyK+GEz1SWSEx/k1Xpka2q8VF10vl67CnBGHG8t+KmksgqVG06vuA0X4lWB0XZtn2E5yz8G7UIjdmIozQGvEzmb2UI7faY/R0ugC2HhfrzfMCVZ3KmmuaR/hxeGeobIJ352QQTAvq3SdlkeTVuVP3TnYmda8DvMYZQ7OUo3e5RNsxpUe+byDLEXiCrWT0UhR19EX5pPDtA5YTKZdCHOp78Q1x7QuQzfuA3HyxcgtpsDqnRQEguQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4619.namprd12.prod.outlook.com (2603:10b6:5:7c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 17:44:25 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 17:44:25 +0000
Date:   Tue, 23 Mar 2021 14:44:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Rimmer, Todd" <todd.rimmer@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RFC 0/9] A rendezvous module
Message-ID: <20210323174423.GK2356281@nvidia.com>
References: <20210319202627.GC2356281@nvidia.com>
 <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319205432.GE2356281@nvidia.com>
 <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
 <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210323153041.GA2434215@infradead.org>
 <20210323154626.GH2356281@nvidia.com>
 <20210323160709.GA2444111@infradead.org>
 <BL0PR11MB3299B764F783B77F018CC759F6649@BL0PR11MB3299.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR11MB3299B764F783B77F018CC759F6649@BL0PR11MB3299.namprd11.prod.outlook.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0073.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::12) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0073.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Tue, 23 Mar 2021 17:44:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lOl4p-001cNK-4E; Tue, 23 Mar 2021 14:44:23 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73cbc577-63c0-4db2-8c7d-08d8ee234cec
X-MS-TrafficTypeDiagnostic: DM6PR12MB4619:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4619E1353ECE4430F641D107C2649@DM6PR12MB4619.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ziRpNwr7MktXaB001G1vE8Nl9DGGEQu3BAPsynxD2+1nAMwnHEeasx6pHzbmRZ8CPCXFmi5xEPqNZ/Wy04QTdtAmhVtJYD8fwL/yvoFEH+FT6XrkhzuSgOEeQGhU1Cd3X3IDkgK7s9pRYQrvsJx+x9zxnj2Jxihz73DZGnXykx6GhwhqjbQNft8zg8Onyjnitjo+tZPD6CbEIsrExviPsAcJqNQWjvB2AZO/hDXIAoC6Tep5wXnqJvz9QSxKAuNzH5rYYNKY9KuLT71njnxii9ISErN9+/Gl4cWaGp0fHCpiUAnuzjWnPugNBXFi3AJhalykQOlpTvTvgt39ae1lCWSv18qABPF2I8h9kHehH1x8XOeA5+jxrQyfUPfubATVArGYCrw7H5AdDGGEs9YRUqicT3ts1Jbl5dZlBPODFcSOdmO4xOXk3gJZTk7JRpmd0wXkA0sWTRGwssM2X2j0KCdtcILQVROzCuTrHaVfFvvprikQq1mlHPAuKZFgtYPYmF8ynz2vjeopiEPtRsgkd3eJE17kY8kaLtXdto7kWVwlmMSbx6Gn+H/mDWPJOS3awZ28fhpFszhoOym9R8n9JV9Z/giazrfU4NFyROVA18DbJvwzpHQKm+8A7+Mf7npgAtjO8+NSIE4mRHXRWiirxulbDV12TJd/x0/CfJQRuq8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(39850400004)(376002)(396003)(36756003)(186003)(1076003)(4326008)(66946007)(54906003)(33656002)(5660300002)(66476007)(316002)(66556008)(26005)(38100700001)(9746002)(8676002)(86362001)(6916009)(8936002)(426003)(9786002)(478600001)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CnwuzwQfBAOKzE58EUFGyi85GFC8Q9dbVCRgcgaEhK92DLt6per7hPT4jKIk?=
 =?us-ascii?Q?JRYED4eY0RU8o5lD90vQEERDyDFlRoK007fouQvZPOmQ8Cv/UFVNEu2Isk88?=
 =?us-ascii?Q?9l8Mo4llCVR5SKhVDLTPci0QM+qkPjT/LmCh3/lF4g5Z85C8nLT5hw/ofXpd?=
 =?us-ascii?Q?ApdL/1bDfA9dlvX2oseSZDxUcveHTw8o3Yi/AldP6eSzQ3iZEFiaHCew6/+W?=
 =?us-ascii?Q?8Xr9Ms20t8gNCf1NWy3Kzg4WWrYZf8I8SgQUtTAsXkepqJInIXpquxh4ZDVS?=
 =?us-ascii?Q?G+kS689vrR9XyF0fx7yDOkeDGIQPAmCCpSt69etH3akLtIByEhXNrMPWft6Y?=
 =?us-ascii?Q?K19EPmv24DqQsMRHTBmxEYuQIMbu9xnsdu872i46Y5T9Jhzv2RoW/4WQ+vLo?=
 =?us-ascii?Q?JoO07wxdvF5g14zORV4OnRKEUs1CyxwddfyTU9Zic4A6MT4iCmlZ9uOzLbZQ?=
 =?us-ascii?Q?yfnQXD9nheofPTNKWZcmVD9V9incbWcsp9zOU+HCm9B+2xFqmsevRyeEFDvz?=
 =?us-ascii?Q?l6JmKY6M9WlVOEWknU0U5XdtvQPqHMbBR/zxIDLH5meI6FHyjfw7ljH7UHYk?=
 =?us-ascii?Q?Yir1wAbcOaRGYoqfDjXHsozoYUNO6X9GjIdJCzjSAW29SE+Au/u2vvHiozg9?=
 =?us-ascii?Q?e4jtRaHdZ8JcrNaXbbGKzG4tElFlvWvIvxwJoD4/HNzYcnduQisBWM7lIwex?=
 =?us-ascii?Q?5CAYg+8UouHNv/rSeZZ+AjG8cTuTgBgE2A68cGsYMU+nvagL6/Nu83imQwko?=
 =?us-ascii?Q?oPYDadvFx1317rv4cSTPEq2tRNdCqW+dGex5GX7rhhDE3kY335UUSZPGYYKP?=
 =?us-ascii?Q?oF8UOoSg3w1MCJnz5k8BSThuk4AbRLJSBGprHXfBT1FMIBSVUJfFu9qEGtfq?=
 =?us-ascii?Q?6zGL36Y37KmEdB+u1JdPHMloiwS+gKQWZT6NyUL3LQW3nL5MOE44GQ+Udutc?=
 =?us-ascii?Q?0JBP6R7Fte1XNRwXL2ddKXMW2XgLTsyh2vK7TPrVjjjiE40gqvIHAqVsXejX?=
 =?us-ascii?Q?vjq1KeYezmrEQYXPTvRYAI2TP/aT2SLgUQAajZSAOxyq/fy19rziOR1uycKN?=
 =?us-ascii?Q?vjURtLZXtWnZFEoZzDxo8ay83NBluYL6GoICE5shZjYKeJFBT06lxroQrTR4?=
 =?us-ascii?Q?dm61CuXgu5pMorOxNyVH+VsCsHwJk4jOOb8RuKiH7F3pFMPYe8FKDnFYjnlz?=
 =?us-ascii?Q?gF9dRy021/jTtOi8VPg10eqmDRQmdKf1+oVbI1H4zOjeiyJRbnv8QIJL0Qe6?=
 =?us-ascii?Q?tG++bzyTeOePijHOjGw4iUaiINneTP7fnaraG8UonjyQ8bIBh8FhqOVLBChX?=
 =?us-ascii?Q?WaFKs3eSD60WUDdaTIcLgqfg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cbc577-63c0-4db2-8c7d-08d8ee234cec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 17:44:25.6281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0fFNtl21cVZ+TtSL5sPsprD8cwNbWeL32MoUkRf9YgNn2MA+zSc9PfxN43EHWJK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4619
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 23, 2021 at 05:25:43PM +0000, Rimmer, Todd wrote:

> In studying all the related fields, in most cases if we shuffled
> everything for maximum packing, the structures would still end up
> being about the same size and this would all be for non-performance
> path ABIs.

It is not about size, it is about uABI compatability. Do not place
packing holes in uABI structures as it is *very complicated* to
guarentee those work across all the combinations of user/kernel we
have to support.

Every uABI structure should have explicit padding, it should be
organized to minimize padding, and "easy on the programmer" is not a
top concern.

You must ensure that all compilers generate the same structure byte
layout. On x86 this means a classic i386 compiler, a AMD64 x32 ABI,
and the normal AMD64 compiler.

> It should be noted, there are existing examples with small gaps or
> reserved fields in the existing kernel and RDMA stack.  A few
> examples in ib_user_verbs.h include:

Past mistakes do not excuse future errors. Most of those are not uABI
structs.

Jason
