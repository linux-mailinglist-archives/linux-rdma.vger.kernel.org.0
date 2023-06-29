Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5381D742031
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jun 2023 08:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjF2GIO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jun 2023 02:08:14 -0400
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com ([40.107.236.40]:50785
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229539AbjF2GIN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Jun 2023 02:08:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5OCe9tFtmsnrIIk+lg2YJXSecDoVW1Wu0xBacFGuumZyz87zDOB+gX6IjZg3nUm5BQDNtjBRizKdhn4ypJkaxcGETKfTiOauvnRHmd+GOwcCABBk3ubKt2znuEWds6lGDEdb0QOXILZR7wkFqgL1/zHM6ruSvrSNi3qvdOWWHY+LP8YYIIdU9WRt5NnDCE76VLXsjF6L4/kQZIJowlGz4laexkr8+Yb3OrUNwUlsQl5obxB2LrNKgLRdklCfmRbF7FhsDjUAGqaXffL31EvzGYpDF8hIP/+9UJ4jhKhpfgCKiYPlraU8FcS0g+io8OGlSysUzCbZed0jliV+xEeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANN5ntAHBIL43/w8hESc7Z7CdNORkJcrhd/DisoLgf4=;
 b=hJtjJok6fTzRvGu+N5pGi+Zx/8B8PBDUQJfBxi6cDmD1HceYBMKS8zb2TESX9L7P4Uvy5gKc610Wvo9d4fXWkRwtEkE8DW5dSWy7/jKMu2JDiFKCkkEQwox7+A8p7643jWQRfkN+uxbiWnz4RJGEcV2GXcpz6Jps0KOXPt6y+s3/9JYb0UTdY+YQ3iM9GzH0rP8jMqLfbI4FkWIpUyw5LcVsADeVwOHkiwQLHSNj4OHGUIPZ9Kf3ftpj2qNtZKVYBmxWm6EoQswxsIa6uJlyJYqXK1ERSmFa+ZqoLFlPE2emVPJBEXOmw5hhy0aDjyedBRqOvjF7eOrQeWpqqYpX3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANN5ntAHBIL43/w8hESc7Z7CdNORkJcrhd/DisoLgf4=;
 b=DEHSU+qCsw9Z4OPUHlmWToqfQ7A0oN+EJwIyVmh/jazgYerjL/Zf4p7Dkh8sWtFnom/lV8D1scZSMIAZD7lQ0T109Vq6B45WUxd7C3w4114G0o8BNCMkAr3sg+d7YZlH/pIiqNfg5juNVOHu7/zByiXaY/fro4I8oKRXAOPKn/aW52+I5UnmJOFrKQJFlXE1vvBpYlJnoDt0o/AEtnElGmhLvGfdvOHVwHvigIYgvmgt0s55a3ZKUrg1gWVtVcfZHStw6/20oEwDgv4vHpmNDiw4nCCsVlaeCEskPi+Ja9g+2nM5LBzS6IxUHzyurN3TpdakBdrP+lMpSBqMokRsXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 DM4PR12MB5071.namprd12.prod.outlook.com (2603:10b6:5:38a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Thu, 29 Jun 2023 06:08:10 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::12e5:730c:ea20:b402]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::12e5:730c:ea20:b402%4]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 06:08:10 +0000
Message-ID: <4d3f3bf6-3c3f-5f30-055e-22ace6019f73@nvidia.com>
Date:   Thu, 29 Jun 2023 09:08:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net 2/2] net/mlx5e: fix memory leak in mlx5e_ptp_open
To:     Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com
Cc:     saeedm@nvidia.com, leon@kernel.org, lkayal@nvidia.com,
        tariqt@nvidia.com, rrameshbabu@nvidia.com, vadfed@meta.com,
        ayal@nvidia.com, eranbe@nvidia.com, weiyongjun1@huawei.com,
        yuehaibing@huawei.com
References: <20230629024642.2228767-1-shaozhengchao@huawei.com>
 <20230629024642.2228767-3-shaozhengchao@huawei.com>
Content-Language: en-US
From:   Gal Pressman <gal@nvidia.com>
In-Reply-To: <20230629024642.2228767-3-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26)
 To DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|DM4PR12MB5071:EE_
X-MS-Office365-Filtering-Correlation-Id: bd140bb4-7927-4659-bc02-08db786736f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MyoDS+JdszlUoH8tEige295GjRV+nwbNKi9LLcrBWiUH9cK+/mBWORfB5+zx/Arck+Vv7Hejwr7VqubixsGKVJlRT3NOpgaD2LqtIdtb1VYU7Bxg46OrY5yPTPIiOnVGFw4YGmxBwb3wSFk9otkp0CNns3j3rggnnxRWf2vgs2OBdvHNLfB1RnK3G2xzY0JwUBVqm+JjPoTkharHMcWW15iNQp5ib5TO/5VvkfDolZDnh+xiAIogx3/UIfdf6cHbrV6Qv1qxTaUsTbFZBfgTgHCGiUBIMRogc3OcGAr8LooPuajKWRovLQ1A5WWAMxA18OGYyxL3jCCYvtv5EVL8GwH5vel0Okpj+HbFIPlFq9E97xB6I2kEj0yp0OQMcav78vkxBuMmtvEV3oVYM3dsesEm6UUCLGX5GNu7nBLnlMuIkmB+Y0Tuoi/S/ZbpncZCw2Eri/dnJuHdPb0AIG9GZlZqiAqHpTaZc9ecqm2EWTB3TvgxTNdh1nHja3G8VkgGEju7/srJ8eH9kzcotLttXxsXdB3Vnji1iTAycAW70qdLObT80LIDEDbCVr2ti7iWvdwF7GhX2P9/rRDzvfgNUdq4b9CH0Sm3+Xp48QmHY9+ldvc7sbiX410aQqOWwb38Gwt5cLLWIVDn8eNWjYcMNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(31686004)(6512007)(36756003)(38100700002)(5660300002)(86362001)(41300700001)(7416002)(31696002)(66476007)(8936002)(8676002)(316002)(66946007)(4326008)(66556008)(478600001)(6486002)(6506007)(2906002)(53546011)(4744005)(26005)(186003)(2616005)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dklGSG05NkM3R2t4UGlUYzRySnJYWmFWNERFWHFEakRCS1hFTWpSOUF1MmRj?=
 =?utf-8?B?VTBiMzczQkVpOUFldFVuMFRWKzNTYlZ3S3VkdmJYcUZYY2V0NEtpZG5UYXhU?=
 =?utf-8?B?WitnSWxpS2J5Q3pvdDJKT0pzVy8wZG9OVkUydSs4ZUVzRHpJS25sU3VDN0xE?=
 =?utf-8?B?clNadXdrZVJOMkZodkhvWHQ0OHA3YzdVYnJucE5mZnB4NWc0eW5WWk5SWDA0?=
 =?utf-8?B?WVBneUJuWlU2am50Mi9VSVAzcE5vcW9NY0JaU3JwU3JqUUsxOFlITVE0eWJ0?=
 =?utf-8?B?NElZaVFSSnA5SGJwejZOTUZXa2QzMkVkMVdoQXNGem1ucFExNUNXMHdITjJR?=
 =?utf-8?B?enBqMG9GOVh6aVVqQ2Q5YytPVHZ2VzMxY2JabXBRZm04TTVSL0N1d3VUZEJW?=
 =?utf-8?B?bnZZbDg2R0YzUE41MmNQd0pFdlh4QlpWeTZMK0wzNlZld2Y5TU1mTjdZOEtN?=
 =?utf-8?B?bUhESi9iL3QvYnVxeVBXZklhU1JXNFp6KzBMMmFHU25LS1QzZHd3YnlNcGtz?=
 =?utf-8?B?c0M2Nis5QkVaOWM4bVN1NkR4azVYa1R2ditOeE5OajlkZVBJV2JCTUgvZWJN?=
 =?utf-8?B?K3d6d2I0NmxVbHZCazE1c2Vxclp1OWU5YXBCZTczS2FTU0NPZDFxank0QnMy?=
 =?utf-8?B?K2pGcmJwK1RYVlg2L0NtSThoTFVjYlM4eE91ekNTWVk0bVY3Ui9DWDJsZUJ3?=
 =?utf-8?B?TkFoNHZVZktiQ3Y4MUwyQ0Jza0F0R3IxQmpBN0ZpRVNQeWJCZGJlTmp0WWRR?=
 =?utf-8?B?NExBYmh3MXEzczRsbXVRRDRaczlOQmJaMjNHZjR0dEErL21JdjFqeXpLSzY1?=
 =?utf-8?B?MVl5NU1ENjh2MHovVEVSOWNQalV6MnNmenRBaFF4dkhHNlcrU2E3VGozdzY0?=
 =?utf-8?B?S0U2Vk9vdGFDRkhiM3dBdGdJM25sa0psNUQ3SExaWUZyMkx6Q0RrQUNTK1B2?=
 =?utf-8?B?dC9XN3RNQzNZK1pXV25HbjNqR01kK04yeS9hVmpUUnJIdFo5TGdsd3RwcEor?=
 =?utf-8?B?VEdWTlo1MnNJRDhCVmM4SWdXSUdNODNWM0NJWm5heWhTUkJDNjdnQ3JHa3E5?=
 =?utf-8?B?NkYza2JydVJtcGUya3FmSnZrb00wd1hERm1nRVBsREtyWEFOeXpTU2dMTjNK?=
 =?utf-8?B?VGtaWXMybDlTQ09IeC9xMTB4OStQSUt4YWU2S1RQZVg4WTVGWWR2NnM5ZmRE?=
 =?utf-8?B?S1QyTEhNZTVRZEJOVkY0SHZMTW4vdHhReGJZdWwvWVBRb0VOTFkyWWlLVG44?=
 =?utf-8?B?YnlIZEZYTEZmL3RyZURGRTNpTGtQZURMNTY4RzN6OUZucC83OUhRMmwrdTY2?=
 =?utf-8?B?YnoxaVRDbS8zUGVwckZOWkd2dk9GQjhGaUlvQm1UTTIvVERKQS9sU3ZmMGJn?=
 =?utf-8?B?ODdBOWhHS21GMTRMOGNoVmp5TUJ1Ymp2eFhGOThUd1VIRWJoc2lKZHZoNFR4?=
 =?utf-8?B?cHBMeG53ZjRrbDJ4bFAyRlNaeTBocU5adCtQd3QyQVZyNkpMRWdhc2pTaytX?=
 =?utf-8?B?WEQvWEtGdnJEbFpLWFJIOWpJcDBrMmJqMTZ0ZnhrSmRDWEZjTFBuZEdJZitV?=
 =?utf-8?B?STZRdjRKdkN1c2lyS1lqOHRPSm5aMkpBSmp5T1Q5d0FJN1FiOFoxSnpZeGh2?=
 =?utf-8?B?SHU0UTk3VjB1Rjd1RHFLVWtHbGpMbXdtZTFEU3pqOGVvUE5YaGJwT25Rc2FS?=
 =?utf-8?B?OU95cVIza3NuOTIvSFVtVThYa2I3c1NoS0ZHVitnQUZXbjJBOUJnZmRQb3BD?=
 =?utf-8?B?UDV2M3hEdXZzZHorVmhiT1BIS3drM3l6Z3Y2OHFjVjRIRlhydG80NXV2eFVW?=
 =?utf-8?B?dlE1clRyOHRwOHFQcFVyRm5od0w4eXZwY1haZHpIOUdQdFIyZjMxR2svcmNm?=
 =?utf-8?B?WFBQcFZ4Qk92ZUlwM1N3QnkwdGhoWjRnN2diMmpYeUF4TFFscW9lS3p5S2dD?=
 =?utf-8?B?YWNFTXNXSG5aa2l6QVd1TnFHeHZFR3FBdHBJUFQyZmNHSitPVmhjLy91cU45?=
 =?utf-8?B?SG1jck1YUWJ0QVcxRUJyVDVMTXZPRm9XOFc4THBjMXZ0eVgrNHpUQUVBeFh5?=
 =?utf-8?B?ZzV2MGJiNjh0a2tVMVhTeE1Cek5KazJqeW5PRlV3YXI3L3NXK0k1ek9lUHh1?=
 =?utf-8?Q?H0Dakwgtr5qHFio/lZazMpzy1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd140bb4-7927-4659-bc02-08db786736f4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 06:08:10.5396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HimwBOMeCrFclKO1EgJVQaASDxf2CHVj8hlEH88XqMxLuIQAQiNn6fZjjzVzGGso
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5071
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 29/06/2023 5:46, Zhengchao Shao wrote:
> When kvzalloc_node or kvzalloc failed in mlx5e_ptp_open, the memory
> pointed by "c" or "cparams" is not freed, which can lead to a memory
> leak. Fix by freeing the array in the error path.
> 
> Fixes: 145e5637d941 ("net/mlx5e: Add TX PTP port object support")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Thanks Zhengchao!
Reviewed-by: Gal Pressman <gal@nvidia.com>
