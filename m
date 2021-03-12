Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF20433823E
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Mar 2021 01:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhCLA0C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Mar 2021 19:26:02 -0500
Received: from mail-mw2nam08on2043.outbound.protection.outlook.com ([40.107.101.43]:14817
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229526AbhCLAZh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Mar 2021 19:25:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQ1fPN9VFp01s4rETwNTTNkhMw7w6LBbJzDucgA7zTgmguzxI2N85YGa5S0z8vV+53500Qa7PaHKxiJR5+yo9ypR+e0D+UoMYgYaw0O3m6050j8GRSMss7OQU5GbVoz7RfWi6SyKlDrbIx9XvrFd3il1+GMYM5fN0uWpTewhV75oD7xbFwKDffWrwZOoE+Zpwqo6fsih7ks/+VRr4Hhd6y3J5Uhvx7XHzDs54VBmhFkRM4rfeVVYGiyIHhHGtpGFU1Dnc7BP0MXcx9RIFdBkFm8fZSs26LzcoFDTPVPSG1cKRj7Ok3w71u9g94DJB7O/ka/IyLFSLFpoUsZ8ec2rhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ze3yT6LVd6KGp4iljuMKZ6yXmtLMOtVJrU6KLhvDORE=;
 b=WpOHdD4xDSVOdL+/n4nRCpndIb+/+P4NaSwhaFUVRz2xx5KEiv5GeeOx7px7AI9c6c4aDDf0n/IlnI1WBrj3vsSHVrarAOC4A793v5l4VtyZOVX676unjEFFpg9DztUpyeJszztAj05g4LrJuIMRDeQZ2O7GJWhggMRIHH9DVLTYLvlwlxWi9l+oh/5EcMDqy49Vs1T3SshdvgnlxdW/tRECMxZLNdibSSJbM3Y/T/Is8511JKl9beMPMNtV/ihCK49K3bkTXuTuRvDN+BeBgYOO8SeywJUn+Mq/h0F8gO57BIaIGnHFh032BzIR7AYjHBuHxEY4wZY3cl4VspOEYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ze3yT6LVd6KGp4iljuMKZ6yXmtLMOtVJrU6KLhvDORE=;
 b=Ha8OwVq7MKEr1nlg3YOxLzIxmUOgn540VEvOhu9Gaa6ncwMsmFcecZbCn824aRtZZTIicm+xB9Ggpm9ZWT41C1aizpzuVdtn4FuWoeiNf5dfVqC2wLs12WL0PkHXkdwLbDYpxmcgQihvomskh+KV7ECzaqvfbbKxRVQ+GujrZF0T8qt4q2Mi1WFLeJD8am0SIrN92lppLhfbUB5+GvSm71Gl9/fbQIzWjCtNKCQrRSqhR8QK8FCCBks5cQJUquOG2skhXVTEe090jFEA9IllJ8oLANRF4dIr0NUEhmScs44Vq3OvM9sM8ax/y6JD4b8kyVP3pxEsUX1IFgRS06y+NA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB3478.namprd12.prod.outlook.com (2603:10b6:a03:ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Fri, 12 Mar
 2021 00:25:35 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43%6]) with mapi id 15.20.3912.028; Fri, 12 Mar 2021
 00:25:35 +0000
Date:   Thu, 11 Mar 2021 20:25:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        maorg@nvidia.com
Subject: Re: Fwd: [PATCH 1/1] RDMA/umem: add back hugepage sg list
Message-ID: <20210312002533.GS2356281@nvidia.com>
References: <20210307221034.568606-1-yanjun.zhu@intel.com>
 <CAD=hENeqTTmpS5V+G646V0QvJFLVSd3Sq11ffQFcDXU-OSsQEg@mail.gmail.com>
 <YEUL2vdlWFEbZqLb@unreal>
 <CAD=hENcjqtXstsa3bbBCZVGF-XgAhPz-1tom68zm7WNatH2mZw@mail.gmail.com>
 <20210308121615.GW4247@nvidia.com>
 <CAD=hENdymrkFV-_piiOKL-fK38SQh3sTAfc7+WPSky8mHtJ8DA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENdymrkFV-_piiOKL-fK38SQh3sTAfc7+WPSky8mHtJ8DA@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0422.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::7) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0422.namprd13.prod.outlook.com (2603:10b6:208:2c3::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.10 via Frontend Transport; Fri, 12 Mar 2021 00:25:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lKVcT-00BfkR-FW; Thu, 11 Mar 2021 20:25:33 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b637e061-867e-4ea2-49d9-08d8e4ed5aad
X-MS-TrafficTypeDiagnostic: BYAPR12MB3478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB34784294639E3FFD9041BC14C26F9@BYAPR12MB3478.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WK19wwxAn0sDdiwLSagVlkwFaEvKV3zQF42chKAH6H4J26FLPG8OSF6i/qrgfmstSe3eK++YABTIJkOvSMrPneYMd1Zuyh2ROlXimsKCL+sScrY2oldSqDSBCvkmfG35sww+vr+Q+JHoHPF2vAThsVsPKWu316M3m48b+ZaEiB9iNvpaPIElBQpxzG9itT5go5u4XLKuZghgcwW8f4rsqMMifzj+nBpY+3+7oOpq8EQaYFttoiiecfv2aJY51K4fphmFd87YGkB0/yvyvh/nxMrI7eseid+qMLj4VfVP0E4b+souYhzdLDlQ5yBfu3PtfURsjLRFO+YQqWosLR5oE8HR4oOYMiumVnF5DKHfVPZlWsy1Ge1KsYH3Ype5F0zJTunce9h2u6eohc2tvfUeJ5D9oHHziwuVoDLojvicse/ZzC44+wqHUy5rcFZ/ZoHPrJAKltJh2Re0/xmCR4zbFgMBQRf29rhN0F7HL1gAiyL24KTx+DaFzA2gOPqbHbJRbgHbk3paUnppP1rTQegA9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(53546011)(4326008)(2616005)(426003)(54906003)(33656002)(86362001)(478600001)(316002)(8676002)(5660300002)(8936002)(9786002)(6916009)(66946007)(9746002)(26005)(36756003)(107886003)(2906002)(1076003)(66476007)(66556008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eEHUR+FZRgPAx0W4MGsb7ljb3nfZIsh5wf2afj6J/mIJ+48MYOKugwnHAgl6?=
 =?us-ascii?Q?PZsYM7RDontR4oiJV0i2oZwwObiOP/IbTcYAeNBD5M8JYrQWBCxgh5XpLaNm?=
 =?us-ascii?Q?X7PxtyPaTN3PX8fg7SciVu2KZs7oKJeuyNe/PEbBW8Ka3I4xBb0EvEE7i4cY?=
 =?us-ascii?Q?V4eJnUatXUrThHHd9qA5Upy3z/Wq+q6wmsqpdTxOZP0lP8T58cO8D8aNspNQ?=
 =?us-ascii?Q?2m9Lf2Eosv8GiVPMJjtHZvack5Gl+zyd/Ev1EX3CnOPQvLyMI++c+exZ6yy8?=
 =?us-ascii?Q?/5tnkUHDEDt9tsGGGRs7j9feQrqRdxWwAWcQXPIkPF9Qx8Sb9sLJV8d4r2u3?=
 =?us-ascii?Q?9OGEuy/xf2A1AHtn5tPs3i1pFF0bAVmxbNASpn4/fcRMvlbLcxNYZ0bvzVgW?=
 =?us-ascii?Q?VL7jUG3KfeGg/LbmasPYoNPIFKJZ9IZ5OhuRAZJyC9pXLDr6ngNx/uUiuXaw?=
 =?us-ascii?Q?84MfHUjZWhHyp2iokTNoowR+1C5+V9wdRF9QvcEMjlVmp51nps1G/QQAKjkh?=
 =?us-ascii?Q?rsc7ZqVj2O1euRPHB6bGcDmWOAIK3lr5cGMbfqlSGat29J0DN8AFptKFzy8Z?=
 =?us-ascii?Q?i+Ux81+jpZSi2gl6tFZdjNEGUMr/milH7dxGycZekHeazUapK0yubKsXtJvT?=
 =?us-ascii?Q?VuqqqortUW1M9lDWGkPHvxnHhvFp0f3gFPK6KtEsxTCudzu6LRywq279Ax33?=
 =?us-ascii?Q?UUUBMOW0+/OhO5fkdPljviMgJxb6Eo02nCmUYA8HrzL8TaAccBn93T9rvo1J?=
 =?us-ascii?Q?zAe6I6GGZdTlP+CUT7e4DGfZoqQidSP/zF5qjnEfQiR3ipby6hW/L72eqdm0?=
 =?us-ascii?Q?p5y8DmMnaTBiafpHOTIfDjUjWNuuqPpynSw6PZHpiIRDoee/FxaagfLYHWpJ?=
 =?us-ascii?Q?C0EEu8wQWIP/BO3lLJe9I3z7yPNRBHHIMOjBvj04crH3EukIEno8LddrQtSv?=
 =?us-ascii?Q?l2JgBvfnJJ+efOa4eKhKXJta1fG02vFBcdBX1U6+JMHJ7Oys2mRsm5BGFwsX?=
 =?us-ascii?Q?O1o5owVZ5gtdK7a8MppEGNlp8WupQQ5TM4HEdqckASf1jpB9+Os0aaDCsF2F?=
 =?us-ascii?Q?VA/DqhX+lEsRRPdKyDHlkRdtbhQotpwoExjL+MQ7fXdcfJ8/fdjvAFtx+r3R?=
 =?us-ascii?Q?GDVDmvCYCrYLL5+7uokz2o1TfxFZchL40eByQSpYoi0Nq2ROHQuAVqeNnlto?=
 =?us-ascii?Q?0zKWsr08QMrLQPKsWW/DfJoSeAIgNxJP2jSo03qBoWmNTchGbItD9O/akk/q?=
 =?us-ascii?Q?jFiD9GTiIv+IvYhPlsGXbXjN5AKiT9y5xcbuXi+86ohbG3uDQ+I40S+EwseO?=
 =?us-ascii?Q?uw5wjW780JPEnq8lcCOx8E8ktCcOF6qqICuJmeqhSCnjGA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b637e061-867e-4ea2-49d9-08d8e4ed5aad
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 00:25:35.7610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQy3SzTtzKwRLFlX8Kz41LsD13ysJriEgoChHXIAGoGbbFkx1ZIc/2Ci3+4EvBr7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3478
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 11, 2021 at 06:41:43PM +0800, Zhu Yanjun wrote:
> On Mon, Mar 8, 2021 at 8:16 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Mon, Mar 08, 2021 at 06:13:52PM +0800, Zhu Yanjun wrote:
> >
> > > And I delved into the source code of __sg_alloc_table_from_pages. I
> > > found that this function is related with ib_dma_max_seg_size. So
> > > when ib_dma_max_seg_size is set to UINT_MAX, the sg dma address is
> > > 4K (one page). When ib_dma_max_seg_size is set to SZ_2M, the sg dma
> > > address is 2M now.
> >
> > That seems like a bug, you should fix it
> 
> Hi, Jason && Leon
> 
> I compared the function __sg_alloc_table_from_pages with ib_umem_add_sg_table.
> In __sg_alloc_table_from_pages:
> 
> "
>  449         if (prv) {
>  450                 unsigned long paddr = (page_to_pfn(sg_page(prv))
> * PAGE_SIZE +
>  451                                        prv->offset + prv->length) /
>  452                                       PAGE_SIZE;
>  453
>  454                 if (WARN_ON(offset))
>  455                         return ERR_PTR(-EINVAL);
>  456
>  457                 /* Merge contiguous pages into the last SG */
>  458                 prv_len = prv->length;
>  459                 while (n_pages && page_to_pfn(pages[0]) == paddr) {
>  460                         if (prv->length + PAGE_SIZE > max_segment)
>  461                                 break;
>  462                         prv->length += PAGE_SIZE;
>  463                         paddr++;
>  464                         pages++;
>  465                         n_pages--;
>  466                 }
>  467                 if (!n_pages)
>  468                         goto out;
>  469         }
> 
> "
> if prv->length + PAGE_SIZE > max_segment, then set another sg.
> In the commit "RDMA/umem: Move to allocate SG table from pages",
> max_segment is dma_get_max_seg_size.
> Normally it is UINT_MAX. So in my host, prv->length + PAGE_SIZE is
> usually less than max_segment
> since length is unsigned int.

I don't understand what you are trying to say

  460                         if (prv->length + PAGE_SIZE > max_segment)

max_segment should be a very big number and "prv->length + PAGE_SIZE" should
always be < max_segment so it should always be increasing the size of
prv->length and 'rpv' here is the sgl.

The other loops are the same.

Jason
