Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360F06D1F4E
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Mar 2023 13:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCaLkY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Mar 2023 07:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCaLkW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 Mar 2023 07:40:22 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612651FD3A
        for <linux-rdma@vger.kernel.org>; Fri, 31 Mar 2023 04:39:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y07UIyVPM834Tk25eyKLfwZ1ykpZ4Pyp/+cJZdzB2A6RCLbeceh05BTfNQF3mGt6eRO+NeY6mLTl4MboUyUbETF0ZIWsueJSqfi/PymOlM8IExM+QcWOiXMQ2VAZJi6NlVJzAltngBVriQijXjDR0fkT13FmSoeRWlGl+kpGe9w+fCS2foioSrCeB5jCtk/+9RPrjE8B2Z2FCVIFAPDKRm5Os6BDwNfEglVExg6skNBfGbh/GYsTC5aCr5PuJ8RBy3dd5jshaZ+xECzz39AH+uo2DAUT2WYdZQ5Kh9YORMj16nOabnt/8nz+S7Nr4i/UVohx4ORcWSNRQSRc1WXaIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgE7nIwnL2jvoT+7CP0HLYgBefxpClPzLs1N8RP0WA0=;
 b=OdKXWXd6w1/35Mw8Jsmg/6i0vMBrVd2k9XjmzyhiV/DY+djMX5nrG1f2ixmJSDdDUzsP+i91ph/FlxPbuXLmGsmX58Wbqi1IGXen2tYgew67WD3D+vua/jLGhVccmcBcHLh9uDMdEuewdJuuBcMs8XrBfu4Q3qm8yCFMvDEG1Muy+wewnAoG7hZIfC+hmaKPG7EiGAfewR2j/V2twbMOyhZ8nK6+iuseTSpSZSar7M2DfQkT4/NBkjQbl22FgvnmiGJnELafJVea+pk728Acwl6TUPeUD/bhaAp6vLEPB20Mxds/SgY+YRT7XkAauzrC7E3TzKD5jTQ4NnJDl3wE5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgE7nIwnL2jvoT+7CP0HLYgBefxpClPzLs1N8RP0WA0=;
 b=XEIVustokUhQLuTSAoIyeFjXS9IbIKFxdXJkcfIiz5ESbo/Io7pWFoMYCJFQOf/5d+nTXegXq+cZ3UEFxYX/aCRNDrsP0beIkopbxrAYHC5NDGliiP0qIiYaVkxggfwBDkmhixOKo5pe9Lu/ZzauKOlhoqd9D1UMK3F1jlVdSL3CtIWN1H0emioqNryaTziJl8JYzB7HcAWgNz54uL3Eqw8ldSwqdyXCyhv+eNrjnChE46dRkAPRYcfkaTcZNT+1m/EwIb9woivWFyxwZzkIu+b8y1P4JEflUc4Im7ukiX8dW8gNYI7qNvpwuCQWga68NfzxKkfXQ78hED9TrVE5cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB8118.namprd12.prod.outlook.com (2603:10b6:806:333::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Fri, 31 Mar
 2023 11:39:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 31 Mar 2023
 11:39:30 +0000
Date:   Fri, 31 Mar 2023 08:39:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "xuhaoyue (A)" <xuhaoyue1@hisilicon.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [RFC PATCH for-next 3/3] libhns: Add support for SVE Direct WQE
 function
Message-ID: <ZCbGcZEVmQXTr8R5@nvidia.com>
References: <20230225100253.3993383-1-xuhaoyue1@hisilicon.com>
 <20230225100253.3993383-4-xuhaoyue1@hisilicon.com>
 <ZBtQ1/3WjWNXAT/b@nvidia.com>
 <53ff5576-3469-1264-aab9-6eed7956238c@hisilicon.com>
 <ZCGSXzD8LJqsXHTF@nvidia.com>
 <3789bfe9-f96e-8d87-9322-6f1476757704@hisilicon.com>
 <ZCWIIK2iC3MdrJO1@nvidia.com>
 <35c1bb98-7be4-52b5-a747-babfa02e4818@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35c1bb98-7be4-52b5-a747-babfa02e4818@hisilicon.com>
X-ClientProxiedBy: BL1PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d4f189-3bcf-43d1-1551-08db31dc9730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2DUXxoMsIXNzNVClKNaI3JyCUjPaU4UJyMpiL9YWRYYz/+g6PxkDVHkr1QwYEudOLpUKoDVDMTkqWHM/30n/TLp7FFfnWmY0RJjnIOndTI2515YwoIVsCIOGscV1BgWCHwG7EX1AQWdJ5eRw2zN9ZX3XMndr/ROs5sV7VkW3m9uP2tZ2FXg7o6eUfzXQzERrHHv8B6umwkYrFuAAL8VCvMpMfWXkTTVQjmqWJSRMKb3gMliNl6n60rzYCdqxcLZAyNpQMWNNAEWGZ7Z/xFNEDdafhTWmNv2bBqZj7S1G506va0mssiyMXG+4gNhZsyFsRTQP/7ej1rIzA6+F/mvDJwlbNMtF0WQWwU4cCHRUC+PJkuCqYRuMzj5im/Qs8Gg1MBJ2EV9McwptKldSjGoOlQnXeRpmQGfv3SCI2epo3/ZU8gqkGmLk3Bix5EBWPR6r+Z/BqRPutIIvQ4//Fqbpx1z3gukP3tkvxVdQro6iMoZbBIvZyH7QTL73cc0iZAeus2cgoslha7LOBWLp3AvsJUx+4mg2rsbzfKy8kRBDARKTqc9tL6jgJtHuLXgYGEHM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199021)(2616005)(8676002)(26005)(83380400001)(53546011)(86362001)(186003)(6512007)(6506007)(38100700002)(36756003)(8936002)(41300700001)(316002)(5660300002)(66946007)(4326008)(6916009)(66476007)(478600001)(6486002)(66556008)(2906002)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OqQYt5f+69dRCyj3fvjBlGYreAvtFCconovBMJtRz9jz7PE8z8GryQinFSTn?=
 =?us-ascii?Q?8kAMAa45KwtQkAvBOxEiSckiQ0OlRuWRGbwru9HxNfJkC/N9psLajOmnp2Vp?=
 =?us-ascii?Q?QUygSmZiNKG9b9MbtUOGDxuZjzCurXm+rYiw15sGd5jkNWqHhqfhEzYCJDQQ?=
 =?us-ascii?Q?MLQOTpqYHA2d+VXqeOXGOPX0fh63zjRD+iFPqbkriAi7wxSFcKAHHlVK286T?=
 =?us-ascii?Q?2Xwo9vPZmL2Fi05KJiUApwp9xztOS7K0biIQCfI4GpWlWfsRw9EfnK6AAJNq?=
 =?us-ascii?Q?BREMSVMtzTEr13EwIkTLCJbBdzEiy2KerkBJfnJdwsWQXQTd+ZAXQ8a2+WDw?=
 =?us-ascii?Q?hgpFbxk/tHULCbV3qGaJaYKnP9rkiE5R0FhuiZ7BxBb7TNm3wLbn44QdSXTB?=
 =?us-ascii?Q?pJqbK8yQ/U9VLvpEizyH4Ec+02QcSBUxJ34Po9+HJ8+LtyrlwOeHtv2t6bHu?=
 =?us-ascii?Q?MCPLeAVWmpwqAvdccNlfxNx3Vfi+kkszN2NCJk36x4c/Mqrw6871kRCwBUwb?=
 =?us-ascii?Q?5pE/HgHmfB5hZ64v1s0GhjNDork9YWwtX6quKiRQaCHwFuFVnpMKeTQClW8p?=
 =?us-ascii?Q?RQzpAe/sEZv6bq7EFW4/IWDklK/F+04xNW4EsfD1I6T6ivtiprJlLmn7kvyk?=
 =?us-ascii?Q?NbTyIefnrW7yYL01eZrH/JditFciH3hZEg/j/q4KImK2yMt22NnYBC2QzAe1?=
 =?us-ascii?Q?EmgS3d3dCYIfgt5H7knFPwAy3NcFcjRIm9n6/kMaHqCwfyWoAlvhpPo2XGQG?=
 =?us-ascii?Q?sp8au6dGww4S6gqqeKOmKCZFPivFeA50p7cd6u1M5DvuuDjoduM/xkoBJr+N?=
 =?us-ascii?Q?8F/B4Oj23QvyUca/NT9QMrhmzavDV8MAAftR/yo3KqRqUxaYTVsZQb2n8CAp?=
 =?us-ascii?Q?9upfCZy3rVKDHKSZE2HMQo0It3iIGQkCZAiYqmzHDqyuzsBWII4JKkho3bEE?=
 =?us-ascii?Q?HBie3gwNQyut6JQ/M78EeRjirxb0xxolVmHYHOH2v6vuM3YzryQBbbRA8qbz?=
 =?us-ascii?Q?9z2uD9wj/qcRRFSLI/FYPDJOSm0EmXzuxteB8I/hSsKgN+BAlh0hahar/p/p?=
 =?us-ascii?Q?1kb6m9eKGIU92RiU/jz5ITf58GGPxuyFUcVFrbpmV2joMvwb0HRwv3Pl77y8?=
 =?us-ascii?Q?+QTz+tkWlZkCxq2yGisogJgd8ReavgQUH7RYESDEP4u2dv21/6w+RRau0L6q?=
 =?us-ascii?Q?uYsINf/xlTQj3fD/PEuaRKtiYNjbnmkch/uS3XujK8sqNp3Cgzey5H78XRqq?=
 =?us-ascii?Q?2MTc8+nODdEfB0JpWOLiSduWryJZaHvePpr3p/8C5mGx6S9F4JZhz8RfIp88?=
 =?us-ascii?Q?JlGAXRtusWl9ohhpIY1Pd3OkREBs/95ZGCQMoilOdhrlp36PavxJYkOCEmBx?=
 =?us-ascii?Q?5REbEK2V9fjRkDeY6A3UU+BwuT6Cd1r6MyRa4UQE2VgfxRFZv6nqOKXovEmp?=
 =?us-ascii?Q?gUWzuy1SNcFdYhScWbN+gBJQhnr2wndftQ07YNoQNEuqDDYCU7cLRPfP6Nro?=
 =?us-ascii?Q?L6+2TPwCSAAPpcj4C9+pOXaMU4jngzlkcZtIZlMldc+khlkRnERI8zFBcsY9?=
 =?us-ascii?Q?DsB7LnZaWe4QoIfQryHb/3mGxRzObMOJLQ22UVjX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d4f189-3bcf-43d1-1551-08db31dc9730
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 11:39:30.3696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIcYT853jO2p2tWhiA2+TjVCTAD2wXwO4X4ZABL8990bzVU/aqCGBqExuTvAYDhf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 31, 2023 at 11:38:26AM +0800, xuhaoyue (A) wrote:
> 
> 
> On 2023/3/30 21:01:20, Jason Gunthorpe wrote:
> > On Thu, Mar 30, 2023 at 08:57:41PM +0800, xuhaoyue (A) wrote:
> >>
> >>
> >> On 2023/3/27 20:55:59, Jason Gunthorpe wrote:
> >>> On Mon, Mar 27, 2023 at 08:53:35PM +0800, xuhaoyue (A) wrote:
> >>>
> >>>>>>  static void hns_roce_write512(uint64_t *dest, uint64_t *val)
> >>>>>>  {
> >>>>>>  	mmio_memcpy_x64(dest, val, sizeof(struct hns_roce_rc_sq_wqe));
> >>>>>> @@ -314,7 +319,10 @@ static void hns_roce_write_dwqe(struct hns_roce_qp *qp, void *wqe)
> >>>>>>  	hr_reg_write(rc_sq_wqe, RCWQE_DB_SL_H, qp->sl >> HNS_ROCE_SL_SHIFT);
> >>>>>>  	hr_reg_write(rc_sq_wqe, RCWQE_WQE_IDX, qp->sq.head);
> >>>>>>  
> >>>>>> -	hns_roce_write512(qp->sq.db_reg, wqe);
> >>>>>> +	if (qp->flags & HNS_ROCE_QP_CAP_SVE_DIRECT_WQE)
> >>>>>
> >>>>> Why do you need a device flag here?
> >>>>
> >>>> Our CPU die can support NEON instructions and SVE instructions,
> >>>> but some CPU dies only have SVE instructions that can accelerate our direct WQE performance.
> >>>> Therefore, we need to add such a flag bit to distinguish.
> >>>
> >>> NEON vs SVE is available to userspace already, it shouldn't come
> >>> throuhg a driver flag. You need another reason to add this flag
> >>>
> >>> The userspace should detect the right instruction to use based on the
> >>> cpu flags using the attribute stuff I pointed you at
> >>>
> >>> Jason
> >>> .
> >>>
> >>
> >> We optimized direct wqe based on different instructions for
> >> different CPUs, but the architecture of the CPUs is the same and
> >> supports both SVE and NEON instructions.  We plan to use cpuid to
> >> distinguish between them. Is this more reasonable?
> > 
> > Uhh, do you mean certain CPUs won't work with SVE and others won't
> > work with NEON?
> > 
> > That is quite horrible
> > 
> > Jason
> > .
> > 
> 
> No, acctually for general scenarios, our CPU supports two types of instructions, SVE and NEON.
> However, for the CPU that requires high fp64 floating-point computing power, the SVE instruction is enhanced and the NEON instruction is weakened.

Ideally the decision of what CPU instruction to use will be made by
rdma-core, using the the various schemes for dynamic link time
selection

It should apply universally to all providers

Jason
