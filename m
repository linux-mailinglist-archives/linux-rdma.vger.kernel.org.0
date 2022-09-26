Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815E85EAF88
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Sep 2022 20:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiIZSVN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Sep 2022 14:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiIZSU5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Sep 2022 14:20:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488FF12A8D
        for <linux-rdma@vger.kernel.org>; Mon, 26 Sep 2022 11:16:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hxb0GaWwe961x31v36MYxaRp8yGYvu9KZcXxWfqlTxHOy//65NW0wWhIfMxduFfXcpFUxuIulOaZWIi7JL5vxAWsFiIGT3wuOqgT1mQz2gkM8lyp5XKwixLfGab/rHQH7hVjWD9oKI6r8/kovH2N8pprcPnljseYtCeVszgvjeyXo35kMQ5i8uSeff/UWXEbH/vqAe2V889vPErHpgW01x4E1w/jtroesDLkezJuTmFiSiDaRk1BTaVfBQcGhul3aeVY3Hegr3NvPLZp3D0cNoqbhssdyc95L//ya9W4me87V2SnXubfWhsLQAodeXZ3c38j7D3CtBeJIPvHr8LD9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eobZMiKT3c/A7n4xaQZ7cq87j2MHMUxH6BESek/0zw=;
 b=EHVn+hWQJVYkGY1W3IwfEeiYQGWF2jA+YJB0sRC6rC4XJQsVK1W0QX2AbiLXhYLS94pGnRD85NhvCUYEP66vsfCQDs9reXCwoi5RpgpLLT5NCbHFEisUXVttAkzTCkw0AE/1DZVadV9inqWradoRPfVkqf+OgqvjUmQQHdyYsEkn7Z7rPmnhU+7sC27dK7ZUCYKtAdxnEE52bTNopyoSUt8Xo4JGzQ6r+xCySWfKaDUNW5ojVk930nwDEDxY1VVzbiaW4+wVGCLWJUNugJlP1mXbYszGo6jfnE3X4iCwfxSI99x9hc0P19ro+g18eXvovh7YNGr72CO0hqgXLNmJbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eobZMiKT3c/A7n4xaQZ7cq87j2MHMUxH6BESek/0zw=;
 b=EW9T+NIqunF8b9lX0UY45/2MosV+NTdP74wEGf2YKdPilakKW77rGxNLX4kDlpd4EBMPKxg/qDCwgmkD3ocpCCgiXnw9KKMjnwk3BXxEE/OMm8hOvyO37f5UKJ4MsYJChxdEBtq3Es9l0QQBMI0XV3LQXkZMXme5bPo+gr17mfusJ2PmF/0Ox03Ll9X2+/CDq9ldtzPrpy4YT0g3UMYEl7BBj6O/gatROPqtM4SfR8sDMSr9U09vPr52qk8woUDmKrgZctaYCWGTOb411vf8n5fzEabafdJLuA1pq7KdN1ZrsfEjQhcSvZC791RPV2cjUu1Zi809wN8Del22QXsgGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 18:16:04 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 18:16:03 +0000
Date:   Mon, 26 Sep 2022 15:16:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haoyue Xu <xuhaoyue1@hisilicon.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        liangwenpeng@huawei.com
Subject: Re: [PATCH for-next 00/12] RDMA/hns: Cleanups for kernel-6.1
Message-ID: <YzHsYiXu5nctSgTz@nvidia.com>
References: <20220922123315.3732205-1-xuhaoyue1@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922123315.3732205-1-xuhaoyue1@hisilicon.com>
X-ClientProxiedBy: BLAPR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:32b::17) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7be0e4-f891-42a7-e5d6-08da9feb2c34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLrSg1cz1AR7sTEMifBlbdJbf4yNvE14woNJg7gud1fTGMqRvkZdkJphbnYOp0UVoBsAv8+VRgC3+IT9EjZ6+Bh65sq3HB5BpQxgh4M+cN3Zqo1QLKFtfrYoOEqsP+VDj3YQXx7h53YjrdT1bzSHtR58Bhr41Ye6gnXARqS/q1Ped2Woiq3Hjf/NRcrW2Q/xUFIRmb7miJVB/sND21ABLzQei6/Eb/Tl9dPIfNa0gQW5s/igw7LCFZmwsY24V8gtzSusd7cTa1eE1Yxaf3bmtdHx8Dp+gn9piQfjrYWVVG66KvQflWwRaVkj9Xvo1Vsp3Tu1lNATR/IC6YQzbhPObRAlDDXFjWAaNqQsui1y4EsMrw3weQqqxeTPfcStZlt+aVHZ3W/o9e4eGtcEIzy6qk4ZvU8VaFAcPa8rWeQSuBXkYtM/bdnln5wndKXF2ELkbn5nwkdP1R5fljIV/1vlQ34yljxxH4ux87vZVxelJAiPD1c26CyRsqXpLyQY4ItfBdMEZvxTFn09EEhd1GjSbzD/UjXBRyZ9sFlHKvFaJIzq9RSRrQwYfmIp7p9daG/ar/EetxHIGEJl9MDrVPsOXNs52TmPoEhKhPmlYYLAbPKLwMmOmpV3hMQfTEtXISzz/oCmyPS+IxXVpi3d3Vn6WmTjCTy+LsjExsk8OVKoBwX4AhRTYtWqur0Zevhsle7F5oPJyy729JxUxnalCQBgAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199015)(26005)(6512007)(36756003)(5660300002)(2616005)(8936002)(2906002)(66476007)(66556008)(66946007)(8676002)(4326008)(6506007)(41300700001)(38100700002)(86362001)(186003)(6916009)(316002)(83380400001)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3ujxyBXtxzw7avCDFagf3HOuPg916S3NlSsxWuaJYWsIA+UHVo98j7cpbZXo?=
 =?us-ascii?Q?iZIYNWTIrmAKejxwJychS2u4Zzbxi+8AavVU1vAz3ORTCvo3SmKdXcieNJau?=
 =?us-ascii?Q?1yf7EGmXAJGj1e2GCoKDRF+wpaMBeBCAR2BkPo9GboCYvwgxy0ltHU9RXOvR?=
 =?us-ascii?Q?9wvfnta+F3/TmYJ7lz1xyM7GXKUVj4J5419lwMtLHjJO1sEBugnuGdbiEvy1?=
 =?us-ascii?Q?A74UYVDRDjpaguhI2I3AtaG8/DfgG4U4GDjNTQlDzEFsI7HQrATOsOx9CMPa?=
 =?us-ascii?Q?0o2J1ISwyUuq0cqWE3pBoW+aTC1w0CweXGUjNL16tuZ9TbeeS5yjY4V3SuVx?=
 =?us-ascii?Q?MDpBizg3FrTjW3TuakQk5OYMSh6QZ2cHwr7g59ut2hrIi1F2d8JmqZgsnzMf?=
 =?us-ascii?Q?4Dy2fnaSJSPcg3xP87r14ehnX+vJAdGkoNlcDOGmllqPF55JdGalLoN/TRen?=
 =?us-ascii?Q?Rt27YVDJvSP9LH9HCyPnV+SJxQgUDwiSozYWrkU5AIdyhTogju9kwiMKRxjv?=
 =?us-ascii?Q?CroDyy+520SxJn18zjJCxsve6tbzm9LvkcTdR6Grcis3+/iWpwJFj8aS1Uw+?=
 =?us-ascii?Q?5XSKfDHE9PF7T8K4zETIc3mU6Cr7rgozF1vCiNpb7TybzN1LYS826A4yMEQI?=
 =?us-ascii?Q?gLHHsCgePJmx3TqJA977RuljMhycjZNr7yQy2aOGM2w6tJsfBUDIbaJf+idl?=
 =?us-ascii?Q?Yh2UL+nePttzdhYU86jpt55BTn9XtRgyZyW3OC+za1NGlEAwE6cCM3bBT/ZB?=
 =?us-ascii?Q?ik9kBztnEXQbP3A5PiUoHIX4B/2ZE9/2ujJ9cK714u/Agkf36mxT6GBVpEyH?=
 =?us-ascii?Q?PLM8raVdZ5K67f/Dm06PJoY41fUIcTe8F/sqZVJtlyVI9XcBv7Fxw5qxJl9Q?=
 =?us-ascii?Q?EldCVJyNY7FH+aZRHoFwoUqu5yuwi94LkfcPP4n5oKngbW8B/rQIRB9DNFFI?=
 =?us-ascii?Q?4hJVm5J68K5JQr2WGBG1wzUKgp5e9QAznaqrrlU9fQdFjLqBLmdx31t1nKhm?=
 =?us-ascii?Q?V9sAd/N2nL6oJ53fGthlw/MYLeGonPLIEtAF1iINcl4umiJQyaNVkRkhDRJg?=
 =?us-ascii?Q?7L5wNO6GnqroqQhNOxUzyuxeqMYtPY93D4TfHuPLuI8IK9fvuy6KvGbIIuv0?=
 =?us-ascii?Q?sgMyu9gI98/wo0qXzuJfmkBwWIMM/xirJYk6RckVr3r8LZ4V7NxTZNQjkqFd?=
 =?us-ascii?Q?QCtTmaKp77T62GErb6Y8VhOdre70U6h9sk2I3llwCzzUjMWSp1FcCLN8hUr9?=
 =?us-ascii?Q?+qgtQK3560oUsJT+kR/bNnem3wk2nmyYo61DLqI6KdYK764oqFsca/oJrQBk?=
 =?us-ascii?Q?9Xj64on3oQ+ZxsWNHsPeeP6ueTE71hpRlSkUAKvOGC/O1xBPCE2zjIHzs/jp?=
 =?us-ascii?Q?3cJLJeLlwJWzSrskzONi3Fpqo7rfM/eJVQYsEUpVEfy5WiO+9iT7wVTqH4UL?=
 =?us-ascii?Q?rxPXDZzpTiUh4kokdivZqKEp6cxGxRLmnum0NGn7zbpuOrxGGZUOVLZPEY/n?=
 =?us-ascii?Q?LVZ9eLO/kB9TZMp4P5ydlk+nBmieRA1vJbihREbOQzF/YQ8XlhvYklI4z4sa?=
 =?us-ascii?Q?JVEVPP57r41EFFPTWr8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7be0e4-f891-42a7-e5d6-08da9feb2c34
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 18:16:03.6173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HB8LrxBHOeNbIF/8GwfWtnlKtbEdxG3hd+4xMtttVntTjhTvJYLAB7As9F22fhu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 22, 2022 at 08:33:03PM +0800, Haoyue Xu wrote:
> This series includes:
> (1) #1: About the spelling mistakes.
> (2) #2: About the unnecessary braces.
> (3) #3: About the unnecessary brackets.
> (4) #4 #5 #6 #7 #8 #9: About the redundant variables.
> (5) #10 #11: About Repacing constant variables by macros.
> (6) #12: About Unified log style.
> 
> Chengchang Tang (1):
>   RDMA/hns: Remove redundant 'phy_addr' in hns_roce_hem_list_find_mtt()
> 
> Guofeng Yue (4):
>   RDMA/hns: Cleanup for a spelling error of Asynchronous
>   RDMA/hns: Remove unnecessary braces for single statement blocks
>   RDMA/hns: Remove unnecessary brackets when getting point
>   RDMA/hns: Unified Log Printing Style
> 
> Luoyouming (1):
>   RDMA/hns: Repacing 'dseg_len' by macros in fill_ext_sge_inl_data()
> 
> Yangyang Li (2):
>   RDMA/hns: Remove redundant 'num_mtt_segs' and 'max_extend_sg'
>   RDMA/hns: Remove redundant 'max_srq_desc_sz' in caps
> 
> Yixing Liu (2):
>   RDMA/hns: Remove redundant 'attr_mask' in modify_qp_init_to_init()
>   RDMA/hns: Replacing magic number with macros in apply_func_caps()
> 
> Yunsheng Lin (2):
>   RDMA/hns: Remove redundant 'bt_level' for hem_list_alloc_item()
>   RDMA/hns: Remove redundant 'use_lowmem' argument from
>     hns_roce_init_hem_table()

Applied to for-next, thanks

Jason
