Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93804F805D
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Apr 2022 15:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbiDGNWT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Apr 2022 09:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343627AbiDGNWR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Apr 2022 09:22:17 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22639BB82
        for <linux-rdma@vger.kernel.org>; Thu,  7 Apr 2022 06:20:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijjzIYmyqxIG9G2LSpVp/41E1SZMi9nJklOI/cAgEISsQ3DCINS5iSXqP9Vtx5qxcDAABbM29q/5o+dpxDyQiYL/bTdYX7zHW9H862v9wKsVmQDqyqeg5dK/kG1LtrOsUV63vNkYEd8kim16UwMGYFm0wkWpWpklipoykczsyNkyvs0cgnKVJgQivTyC/Hk5rbouS1kmy5S04mGen48cHXt6Y+dC5TuvvvxX+SoI6etn69+hZ42S2DktsuAR/XalrEHCnafST/eBqJPXWQwDmuTHg9RREHnyLloEK5VZxCaDSNwHngKTlIWAnBXmsh1oWvgNBIAEdMsyfw/FO/vyoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXLbR9ye4iwEVnRghYVhk+33hjn+faFKxk/+c02sBIc=;
 b=FJcXS/UrDQ5HqCPKEgOSHy9ZCxT87zsmaJoKWfa6+D8+TBk6PJzyzUt3Lu/km8TvoMNcp+eAczB0U8OIY+YFsW5Vvtpbigm+ij8as5v7TKbn8Hudq8B/ZQ0xUk39MK09F0pi//gQftYgQEeMJg3ufgt1HaBVQn7mmrL/nglkBppn/rAiSkZBqiVPCzylZu1yY5xhaRAXZZ0moX8BjUJfGk0bcHDbqvEGJSvms1Bb642wVEU3F/c117SV9sQ3piSuYaTb15KMio7jl7JioRmG0+iwXTVbyq1P3K1GRgfOSGhWeHpPg3inChkI4uSw4+p/8P4F7q7x50BwVYNm0iky5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXLbR9ye4iwEVnRghYVhk+33hjn+faFKxk/+c02sBIc=;
 b=ZeAUBsjCNsXVW8fJDqF4xZDl7i+rvFP4g6a+07ps+cI/YmU9bfHciHFjVc1jRWDrfkktDvvHmrLQWOHvuEsotg2JoAbMTqmXaNRyrCyw1MWeDBO45lC6oSbRxbEqCw+oNCBUMgV5HKfAOjUbSDisJgZmeyr76zCJXJTYzpPqxq9uaxJf5IvIDZiadiy2Idjdkgi+yDHTl9nvZujxWh8vyIFNpjHBfDu6ZEBicEOPKp8tA+Ye7UBlkFTfyHjdF0sZR05nwm+hD2QrXWkAZz8DmdHIvl6RZgJsvzJVmNEFqW7MqQtTVAwYzAF3mPsrtA49AJmgZpjLeZpg8VSNLGZY5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 13:20:14 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 13:20:14 +0000
Date:   Thu, 7 Apr 2022 10:20:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 2/2] RDMA/hns: Add NOP operation for sending WR
Message-ID: <20220407132012.GL2120790@nvidia.com>
References: <20220407131403.26040-1-liangwenpeng@huawei.com>
 <20220407131403.26040-3-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407131403.26040-3-liangwenpeng@huawei.com>
X-ClientProxiedBy: YT3PR01CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::35) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70214bab-e8e4-4a5d-b417-08da189959d2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4498:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4498282DBFAACC7B30A0DF8BC2E69@DM6PR12MB4498.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8IizP/UvKFnn+ptD9gwDqb5rRQytS569s9BwnvwlC5THkbWXPXh1EhzXkCw0Z8upgOFxu4REOtuPv2EAHjwY59gYla8t5ul/I7bnnoWitplej5ng0YcPpOrxt+/bBlFtZwq+UiwZczADO1kBf036rV0X3HGs3eLvKTkgbHzTIW+vmfuGiD9WTDjsPYAzjKbnhCqjM5TwCUfAfCoojMTAamaCL+1STDjEOxRK2ahltkf5J5qox0ASyftGQp6zwi30upM5aYQ5R4L4RHnCrCBI4cgKJ3y9HWFMRxmM7iI1kKpeZX0fzDi3O9xEZyCC/jEnjvaICibsfZnzi0yEPw0NMcHDeC1apHVXLYt9M5M7U2vcyIqTS4/0xefSDQwAjRqTa/wb9bUUtx/b+VNzBuG06P7l0+xNZZSwnIoMsNgPX9QiDbibOZmgHl3bC+1zUwOl7hTWe+uEjMnB0nfPMtZEz5EcrZc0CBLWNTnbjS4AIttPnm1ghpHrXtJMTdBeg7UbRcLPf+YY1ptbOCDyf5RxHCy+N55A8XlhCb5AvguGuZ2VSFS76gCGn6xpTUB2zrKj78nc3aXBZCVWVTeDkk4d2Oo8ye4N5jszFMJdgKSxlInF0eGbwj3QAuxcMyAaq3Ldlouy3QfHUqK9u0ERcqm9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6512007)(2906002)(86362001)(6486002)(36756003)(8936002)(4744005)(5660300002)(4326008)(33656002)(2616005)(6506007)(316002)(66556008)(66946007)(26005)(186003)(8676002)(1076003)(38100700002)(66476007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FML3KWWGtdeaLiDlLak9y5g8+2b7EythDQTHzk58jVAbJy0t3pRo6Hra4a5u?=
 =?us-ascii?Q?EsOhjiwCYgut+TtNGO7ymlyfVb5nJzrRJ8L8n9KJobeR6VsYVQlEE3K7UJZT?=
 =?us-ascii?Q?s4eoCbvsG0TaCFTnWXx1u+BanT1xvAqTQD8gjW3zcd4r0INffJswQaw73bVX?=
 =?us-ascii?Q?JkcGO/u0gR2lyH+MgZmTVm7/YVtytmeEK3ss7jojLFyTdWajqKcjifh97Vlf?=
 =?us-ascii?Q?pKfAKQgDE0EvS8oMIv715bcWUo5QcCiTbsv9XgKj1j9A0xBEF4DEXM9w5ED4?=
 =?us-ascii?Q?gXc8KG3pDpwBOsA8U/iVjHuW1dA1vpkPbO9irv8Wn0IJuBz788+h/X8CLJMx?=
 =?us-ascii?Q?Q0T4jCOQVOdaZ5x0AmK8X4Vn7T/IESrxGgrwg3EIYu8U8CBaMTOlPrdD/4MW?=
 =?us-ascii?Q?jSz1qVpzNFd+OD56Lg7EhvDqz5gaaEcxZLiWmrqNDRrI64NO38qK1NtZTg6h?=
 =?us-ascii?Q?0GOMqVmqd7Os5APV8IdMkwxRxSMJXj8gSVfPiDFnL+wSmrQraKQaYPjlwqdU?=
 =?us-ascii?Q?9bU3iyMFsRTXpz+Y+gl43rfuT+k6C5aErUFej0j/RqaSE5e8h+fePgeDGH1U?=
 =?us-ascii?Q?FYozoLme/goKg7I8bMYOQOmmIehtplFvVct7Y6jnj1f4kEUs+B+wadjpvbN2?=
 =?us-ascii?Q?ThrwXiixvVqHyUMMFfm47M03ThrdGoKZsk/n6H+y1xrk+qKB+mlVZ78+i+ug?=
 =?us-ascii?Q?Apf6w7a+YHgBNzIT5862AK8fvp2cD13SfsyKso4+aishe5Y3CQRRFuOxO9mI?=
 =?us-ascii?Q?tDWScT0J4Qu3k19EXnfWfYuIBtRnjrJ9GwBZoBs5Km3zuBBc6WMfSNGG4R5z?=
 =?us-ascii?Q?QyevQbOegUsyPJ6fnAgGhDrxR4aIGaxx8N5USoTO0Jk/lLYnznDmHaE3t5lN?=
 =?us-ascii?Q?ZWlPgwFpZhe3vlI8yhhr5NzNbcWK/Qvhp8DexY0MEewTUqKh1aHVb/qFu8kS?=
 =?us-ascii?Q?79abJyMbKoTfpTXPnUhiVKz77VLtidHYnrmJM2aLsI0CjF1XRIKd92M4LI4p?=
 =?us-ascii?Q?NllShhtzcTU8bir2xPNbijl7OyfQ4cWkRKOxKXTWmK91EtSdNIvIDVwfkYcb?=
 =?us-ascii?Q?D1b4jxlv2ThS9RIMZ6ZI+hnVKPVoXbZ66FKJk0b6Vi1wwjegpSpqwtTrk7wy?=
 =?us-ascii?Q?wKiGioCA9Q3u48N+F1RQFUSo9i7G+X8eSkqWlHavJbCwP5/7UNivhTL2qxi9?=
 =?us-ascii?Q?Z/zfdl4oznxNqvD67nIQiW1bc3Gvq/MYai4f7Gkl5NiYaJ+lM5WtDtU0hFIS?=
 =?us-ascii?Q?Inah73Lq69jPUYDOg7jTQW8HCw4DRCkmz4/lEYQWRJPVidjGMJeOuYRIezfO?=
 =?us-ascii?Q?Asr0pTRfMuYMygNeQdp7OUN9S8mtgtqfyehmkhdNgChtLaG7xqEfXDqKAMLW?=
 =?us-ascii?Q?dsrF1WYjU3C8/m3bfq63Sg0TZ1q4q1uKaloK/NoK4ozmFhT6lJTeNB2qG5oh?=
 =?us-ascii?Q?CVzufJN5G/Hb9ZdUcjg7vdu4AXFlxsazl406vmHp2YD5dc5WQcp8NBR6NAgS?=
 =?us-ascii?Q?AOM/p3en094iNQzo62zlfIFTERRS27N3KU16I07dQjvL5V1uYIVpfSv87LLR?=
 =?us-ascii?Q?PhO1fO6CA2POhuCSFyKkBhEmRGPNk+Ba4AHrqI25I/rdJbkxZD7o/rmiy/tI?=
 =?us-ascii?Q?qHJCDrFrm/90FzHMjGFF2wzru/VMugAhn8O26gAz7lzNhrfO8rZA7Z9ioSwU?=
 =?us-ascii?Q?CuGPD0nGf8h2uPMiCY1XpVxBkD4pp+1gLI3Is9RGJv1FmTLLgQKqtRKS7QYg?=
 =?us-ascii?Q?BaoZ0ah/xQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70214bab-e8e4-4a5d-b417-08da189959d2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 13:20:14.3483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJVhykbo0pAf11zNfR/1gae+yzi3uhm+EMl2ClzmAihaxzSSKD7K6jQcWKYT+GYw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4498
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 07, 2022 at 09:14:03PM +0800, Wenpeng Liang wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
> 
> The NOP operation is a no-op, mainly used in scenarios where SQWQE requires
> page alignment or WQE size alignment. Each NOP WR consumes one SQWQE, but
> the hardware does not operate and directly generates a CQE. The IB
> specification does not specify this type of WR.
> 
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 9 +++++++++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 9 +++++++++
>  2 files changed, 18 insertions(+)

Where is it used?

Jason
