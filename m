Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3922155A1A1
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jun 2022 21:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiFXTRR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jun 2022 15:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiFXTRQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jun 2022 15:17:16 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7908238B
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jun 2022 12:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ed6L4YFQa+bbKb7aKfa3LovnmOAruS0dP40DxKJ3FKopOUoLCoc9XlOQ3s7RgVkAwmjzqWEOuzRPvOA9Z9BaVmC204KyX0BsJO5YBrHv7XoQJoVHL9SA+zMkGw3zwN4sjXy6YBoAKZIN59YDWcFaYM4LOQ8Ei7D7EFxBB3JcSZPNrhSmdn5yc35D25CTo5D8ZMc5ZaI6SkXMZIQ8lLRx12wM2hEkFw0TGwiz/rY1XCV7baNeGlGqdVO57l7T/6JTTsV1ql4T9NGPHAGSmNSl2uX2w58FM393SKAlUAE/eD96I2EqSOscLZlrK990S9yagMKwfWAc7Y4ka9lsZTlK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60YKuXQtlG9iZ1DJe3A1vspXbgEUfmIg/wex9yMGLMI=;
 b=ax5byerSMsY6BupyysqlIJ6hMo23fmEhX1WGcsYyHQVieyhuv+8uSywbvLJNTSF0+2qE2myxly9JLPe3fT+bcDMfCApxm7X40YFhbvPauhBwejzw1pMjUaPurEVLPnHOg/FT06/IUt4/nzcBaaSPQW+BPl5F/FloovBZ8tDLVzJVr9VKpgufEpifrAjFsUltdKN0cu84G7gVfJ9O103XZFqwovxcM7SP78E2a4yni+QWa6luV3Jespm0p4KTF+4ujNoPdZSms4K7O/FcTBH3hCbX4Roi1qXYt7HW8PEV7q8X9UyZC8GvFl7S/d8uSbk+iPXKrlk1OKPWKVoO61swMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60YKuXQtlG9iZ1DJe3A1vspXbgEUfmIg/wex9yMGLMI=;
 b=b/qBge7C42Jnqd4XPk1zLDKAncQ9sj5cBesI64Hrbnfgd5Lv3IOKKQqX61SSaC5s8zE6fl884AsYDER3iSSaUI9rXOMPdn4P/zlgXH4/ob/SRYd6xk32BmPoCzAH+v6JLQ1M3LtdENKKSpRjSJb6D4baR1iUE1WzyweTWQhYt6NrR7DimBSDfwRKM8WWlGle0zfHBvNdpslxs2g4hLuun51qCukRTHiHaUwLEtyKGpG0XxwBBMsHwZ2GgJ3zLpNEVMmbrmn38eDunI2bONHjoDGVh1RL3TkUkitHVdvzi/FJkfozt7kWPp8gNpuZUBfoi46uWmsfCJ6zK/Cm8Lj8ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 24 Jun
 2022 19:17:14 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5373.016; Fri, 24 Jun 2022
 19:17:14 +0000
Date:   Fri, 24 Jun 2022 16:17:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com, dan.carpenter@oracle.com
Subject: Re: [PATCH for-next v11 00/11] Elastic RDMA Adapter (ERDMA) driver
Message-ID: <20220624191713.GA234832@nvidia.com>
References: <20220615015227.65686-1-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615015227.65686-1-chengyou@linux.alibaba.com>
X-ClientProxiedBy: BL1PR13CA0108.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::23) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0a05f87-313e-40d7-f400-08da5616256b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4440:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XcRTK6n14rb7OamhGb0vMQR9TDFPDsyExsbqIqHDZezYYXJbdHqhHvJCc8UNjrw5JgXW33tTX9efaYqZCq8TXuAPh440mujU3nwM93kOwTXA7/FqdUzkqeNI1Yti4bLzLAAUpSJmuCeJaQ7tg+kPwhOUwNJsIsDcprGDpDf/65qIRC+NfiOTGg2UnvcTXFFZJS5AWRWe9s0V6BafJNF4wTkTeijfyd1PvfhK1z05mfN9efwFRtP81Ge3FZAfq6YtXa4WOOwat4T3QioW3zQpMSxtdADUrsrelV2Fu1glROD8DcBSngf2ZM+VuA9ko2xGc9k2hkehPtz6hNKY2eb40KmBWAxZkC1RTJDACSTkzo0FN3gwr3N7seCTkmc01DMWExcuOt9R2sFLNXqxwvQVKNVnGab0YeVQ42/3TwA5XbuDZ4rlJeZ7yNPHZCKZhZGoaKsFmERytFB/vQBFkn6IywgGrG9j6cvbQnrUGLayw/gOvjkIbQGggFemWooolcCHgIxSX6kFnId9RWVHwbMHPYPoCc78YlLttjHe9ZuLAKvw+J763EDKjebWRp9BjZNPu766YxEODAMWdH7KNIrj8w6/BsVaaueG4V0dqAbltmBhTqz/JUHA61bHoJMjsDrktrpEZt7T6un8Hwlcb+Rv0F15dZ2dEPld3l6JSsvqmEwb1uLoiAnocWuHdyVhIjRFt97Fwgot0gdYgJOQkqGvDDrTI/WmGuzMqtJYJbVZxIHTWz/HSxPaumXuFFjXyVrYj2cy6MWOIebhyZ4ATJIbOmsjFdOENsJf6tSkxNZQM5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(4326008)(66476007)(66556008)(66946007)(8676002)(316002)(8936002)(86362001)(2906002)(6486002)(6916009)(36756003)(38100700002)(33656002)(1076003)(26005)(6512007)(186003)(2616005)(478600001)(6506007)(83380400001)(5660300002)(41300700001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SXUKGecfsvqhc6BW+8xmB+PnlC7+aKJ+gkeKLxxJDReSpoKe61UAXxxt5+OR?=
 =?us-ascii?Q?AZcLPMLfgOImnD0lLuiB5L1430GWsV7NbQXHVkCHTZPWHffg+K8TbwzxiMna?=
 =?us-ascii?Q?vER8YKHGZpYYwg5+Algwkc/PMvYct7+sVKqD/vhTzXs92JJDbelh2dkRNqz2?=
 =?us-ascii?Q?cGjYpzRQYaSD8xdyHN+wwZ8tSXjswltgHW3JjJdj2xxwFcHv3LsYX6TI/6W9?=
 =?us-ascii?Q?091+KkoE/Gz4sViutpfFsVJzKSoZVEd5edbGi46Sbax3CmVemnLmv8Kxpw/y?=
 =?us-ascii?Q?NOzEuXgoY4UOnEe+1tDGI62MDciXWtVzbATX2a1NH0EjCNpYbv1MJr8k9mtp?=
 =?us-ascii?Q?3UwoInopgZe5TodubXLlHUPNR7uQirDSE3n+seoVEyJyl0oT9nmRqrRnJa9C?=
 =?us-ascii?Q?dLWhhUz8+ep2jBNWMZVYFIJjLql4nenMRzhhQLGVB8oIqVAJgbBooHiS+Zkh?=
 =?us-ascii?Q?mGejU0NPEVyjnfW2j7LN7YITqbynJKLViYV/UZ4tbe/85UUdsiOeuP8cV/3c?=
 =?us-ascii?Q?wIbGc0wJUMjllZnZImjI7oiSwhQvEZRqSrIO24d6OeOVXTOeaI8hrgb8a5oM?=
 =?us-ascii?Q?nsLXV9zdwSt/4rkSOgwaEr2zrhpknq+jq5RkhkP+WGMlBIhWFzofTDVKI/Nn?=
 =?us-ascii?Q?y71GABGI6ePBBlufGkJ4/6ECydto86ZIYD6GQKtEoYeHYbnBb6y/4Boy1yKf?=
 =?us-ascii?Q?o7ED/sFpXMjEpZkRlbFIoGxg2WELweoOv8n+VWUfUSnDN1HblVHjwAcFXbvK?=
 =?us-ascii?Q?Jtghqej9ULMoiKbQj4H1MX8Kvd4pja2ZZsaygIVtpg9AMh7t6isHtkoRQ5Hj?=
 =?us-ascii?Q?T84m0FW5Sl9yLNE09409GR3pnkG/8lwkHE/IjW97hABYXVddmBlMbadNoXZX?=
 =?us-ascii?Q?R8sJXIPryvE+noTmpMcNqUZOOxIABzWs7GOG999dnObvqsT8fNlc8i8Agaeq?=
 =?us-ascii?Q?ff4nI2P3IMAXswX2EXYjJc3VJpYx7I+DOuDgZE7gR1IytYDdpFovKpw55Jul?=
 =?us-ascii?Q?7DiKkWHk7EvPLZUNeu33sEqNBuOgxtdYdC728RJccGI4aNOl5csr0jnEjjtf?=
 =?us-ascii?Q?sosdXmRJQQJsyiUDDtzODHHjZ8XT46chFSQ8+3FhFJnVjafv88r5M7wD9yWX?=
 =?us-ascii?Q?3M0HwOaU0DzpvOtSHBQoJjrPWtBmoBnOAq2jnQxDX1O2oKniURY0d+24GKeK?=
 =?us-ascii?Q?T2UEv3mSRJQxIhTETd+aTetcj7LsmkvtCI//a6fNG1Yn7V3s4PGgM3Gu9jZ1?=
 =?us-ascii?Q?dBgYa3uH0HnS6h9Bkj11Sii2aNL+wojAT5ZdRriN/AGNZqI+bQAKg5zmc7sP?=
 =?us-ascii?Q?M6JnbwtEc2La/EBjZrXx7GIXGIHvdjiobMPlrqaqRzd7KgoTrtKzVRDDWGZV?=
 =?us-ascii?Q?PtzSX6z2ExmAwAHqC3873LnOY79BSn+Ym7I8SsI4TcC1ilcDGJn66c5ffU1W?=
 =?us-ascii?Q?TT5aJpNBrqBS+Iwnu9cRlSQ0joHf05bveLAAwyPtVA8YW48X6dFMWtETaGAb?=
 =?us-ascii?Q?6lNH8T3DA4BKIVkpgivpoDJxZwxAFfJ3+w41ZymPfg1q7aiLf8KOH8g8rd6Z?=
 =?us-ascii?Q?9R6ve4n+2yxsbmzXD7bF5Lq2A84f2syo27oB+ZhQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a05f87-313e-40d7-f400-08da5616256b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 19:17:14.5165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEQ7hSGXyZ6w1OT9ZRVYowHxYfuMwRY2hBdhB6zgiVWhxU+R6uZBRSZh+tozgWBm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 15, 2022 at 09:52:16AM +0800, Cheng Xu wrote:
> Hello all,
> 
> This v11 patch set introduces the Elastic RDMA Adapter (ERDMA) driver,
> which released in Apsara Conference 2021 by Alibaba. The PR of ERDMA
> userspace provider has already been created [1].
> 
> ERDMA enables large-scale RDMA acceleration capability in Alibaba ECS
> environment, initially offered in g7re instance. It can improve the
> efficiency of large-scale distributed computing and communication
> significantly and expand dynamically with the cluster scale of Alibaba
> Cloud.
> 
> ERDMA is a RDMA networking adapter based on the Alibaba MOC hardware. It
> works in the VPC network environment (overlay network), and uses iWarp
> transport protocol. ERDMA supports reliable connection (RC). ERDMA also
> supports both kernel space and user space verbs. Now we have already
> supported HPC/AI applications with libfabric, NoF and some other internal
> verbs libraries, such as xrdma, epsl, etc,.
> 
> For the ECS instance with RDMA enabled, our MOC hardware generates two
> kinds of PCI devices: one for ERDMA, and one for the original net device
> (virtio-net). They are separated PCI devices.
> 
> Fixed issues in v11:
> - Return -EIO when CMDQ response has error status.
> - Eliminate static checker warnings.

I updated the linux-next branch

Thanks,
Jason
