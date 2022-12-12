Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B7364A1A2
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Dec 2022 14:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiLLNnp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Dec 2022 08:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbiLLNnW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Dec 2022 08:43:22 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C337140D4
        for <linux-rdma@vger.kernel.org>; Mon, 12 Dec 2022 05:42:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRtY9VgkyobdmHy6gItibMu53tUSio751kUqUcKHFpbgGcKTgvIWr6A6DTZ7BbTcillD5wHLS2p14nQh70/B0+LyuBXvr8jOgDKBWKcPhWr5YyTgCqW0dr/OiKotoRhjQJTQ3N/ECHEK14EhfqTOX/e9Wj5+9FgxIwioHDyEZLR72w5cwZENrKT0fe31OH/HdA1SB6TCdPDHFLYzvy9r8PQM723o+BoFpbO8GQGAXxPpT+5LLaQMBforjLwOh6rBjXy6/a7kfSgXfBF+uWT35eQYZ/uSMLHEy3Pl4SD26HgIP8bqnok1QaCVSvT9c5Hp07K/t4X8ikriydsmjlb82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBBcUsbPuYrg/XlmRc/riNr/aPrSCuPt9B7Tvntnw+8=;
 b=OasVArMgHJS0SK/zfLYjG9bk9yohl1s9N83K9pdzWgRn6hwK9hCzuP4QC+Zn1GY+sAQPOyYzNcyP3VRThOK+tHjmF9YfN/1hgHNjIuzBLk14MFjQy0CZO3KgOJjKt45DRvGUtxbCWGEBvzy3qN1abpuuRhPofc9xhZoh9dAM7VkQqWs9GAUwAtQ5qVkMKnJZhl0CHsdGHkazSujydRL/tYObl8/b4DSRcwWpMv6txOgsq5jHv9yr0ivZMxk/lVTqZpTZk7CXB4KnY6jC2cekcPmYSZ981fjWIWLkGRnUyD9DBc/8CGJ9vluhGReSJITxoW5r3medBXL/VF5JfcIK8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBBcUsbPuYrg/XlmRc/riNr/aPrSCuPt9B7Tvntnw+8=;
 b=MvxjWZSxOUW/4Msi4DzU/kDFIj74G7elQhHUg+atl8HF48UtM4diadzFA7TXIleWJ0UVv44aNKAxqKNTuq73CwXXaUKTyzeAXWacJ49qctTWvWYBck9Z5dyu70/FKRgRKptclYEc4yJmXNTEi8TxR+ctgqOegq2cXMtXsOE1QXg+qASgMsA0D+MyjxNSPJppYIzZSN73+1Im25zhjw7V8vHjBGb8RiWjSuz20prU2rmAHqWO5Uge9SPTJdtHyI+/B09VMtI6HcbaYcX2sDTl6q5fYcwOFVGsyKsVd58gXperhfTOIg4SI5mhqYOqpPtfRfPCvAjSfDZ5jKr6HG/AoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 13:42:16 +0000
Received: from PH7PR12MB6660.namprd12.prod.outlook.com
 ([fe80::ae46:e45a:2dfe:7c96]) by PH7PR12MB6660.namprd12.prod.outlook.com
 ([fe80::ae46:e45a:2dfe:7c96%9]) with mapi id 15.20.5857.023; Mon, 12 Dec 2022
 13:42:15 +0000
Message-ID: <81008c63-50e0-075a-6795-71ea3d08803c@nvidia.com>
Date:   Mon, 12 Dec 2022 15:42:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH rdma-next] RDMA/core: Fix resolve_prepare_src error
 cleanup
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
        Wei Chen <harperchen1110@gmail.com>
References: <ec81a9d50462d9b9303966176b17b85f7dfbb96a.1670749660.git.leonro@nvidia.com>
 <Y5csPTRDNOIwf49T@nvidia.com>
From:   Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <Y5csPTRDNOIwf49T@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::35) To PH7PR12MB6660.namprd12.prod.outlook.com
 (2603:10b6:510:212::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6660:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 011d68fe-0bff-49b6-325e-08dadc46ad5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yV+ajbWgi6wtgni6/2zPLiJYu+km+Vut0Et17aqpduII86+9IB918fDp4+Ak4uqllj4wEGxRDhAa07svbNmh+cAgjoa5fWFL2Xzk5InXOOFsk3LPPRf6eVRn/QZHqJ7fd6JAjVO9J7Brd6jMadoYUzXwEV6wGcYKeScq9SRP+sBnc0McfKBpWnO3PcdAIb5Euz8y8N6POvvnvgYrmpvGD1R5BxiT9eH9WwrlEiovhmYfmpT+1nEN0tZ82kZS+aubBOoiL9DZaFu21KTTZtn7OBW1gIhuv4OuDMQaOnZk7nJYtdboNjOBRStUAEbWr7n3/o+wVqEfsud791TgO/qdNF9DyccvHMc75BZtUXjVI66r1O3WmNzRf778njuUFuOO74L04WAKLO9EdXWay+6//ax7592oV02zFr/FWXat3jY1pKwOmvYSnrMVNKq0zWaaZQ0JjkqVu9QQDEf8TJoe2BLnzWJbmiVE0L6PkNrKGxYQcK6lMOYc15xUMt+QGKn158N1TbJV1RLxrXvfe8JzZQKUn/cHzYFOe9FM/Zbs9y6UDQL408rfEvF+DbnWXZ0rif1FkLDM2TmMZXXLIYUvEwsSDdbzPTHbzeiw6/kfs2T+XaMOOaqD5nAaxni2uG1LBhfydqEGU0OcyEbKUTxLEbAuONM9jaMu/0NgCfk/uss9vxkNTtDwiwKh5Wo33Mafp/7AYGLatJ8zdm7XyAGavL7fmcvB7RRvsWKZqY7QwI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199015)(31696002)(36756003)(2906002)(86362001)(478600001)(6486002)(186003)(316002)(53546011)(26005)(66946007)(41300700001)(8676002)(6512007)(6506007)(8936002)(66556008)(5660300002)(110136005)(4326008)(54906003)(6666004)(66476007)(2616005)(38100700002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWNtenVmeXA5YjBzQitJU3FrNUdOWWNUUVROQTNqTnNnKzlHSXJ3ZjZ4UlV0?=
 =?utf-8?B?N1BKV0NBTk5yUzF5ZXpaMEc1SW56U25FOVNFZDVMV3drT0Z5eVNsK0QxS3VK?=
 =?utf-8?B?VTcrMXRHOS94RE0xNEs3L0FDekhJdHRTZHBNbWJQQm02Y0o4WXhhN2NRVXlY?=
 =?utf-8?B?aXlDRG9yRlZxcXp5blV4dUVpek54SWpnUnd0bm55VTRwbklZZWVHdG1nenIw?=
 =?utf-8?B?ZHZqMnA5Y2pubXhLZ2xNeUlpLzBSTkF6dEg5cXFiZnYyeHhFU3NmYVdaVFM0?=
 =?utf-8?B?VEVXRzNKbkltcHFWSC9BZStRN0ZvQncwejdGTlg4Y1UySDhDME1hdWJPYUNh?=
 =?utf-8?B?Vk43dWZQQVJDbVo3U1JRdU5UT2NTWlJ4K0s1amtnMWNSNGVmVTFMcEh3Lzc4?=
 =?utf-8?B?Rys2VnZpdldjQ2wxQnVuOWw4WjJHaFRFOGo2aVkwVFpNMjEydFcvRkc1L0Fp?=
 =?utf-8?B?ZjZnWm9DOW5NT0F0YXcxSW1zN2FWZmhtbjlRYjZnaVpodkEwYmFhbEhCTm5I?=
 =?utf-8?B?YlBTeE9pWExkR2ZpZkdIS2tCZEh1emxjN3FVVjhVWDg0amFwM1UzVVNPdEFh?=
 =?utf-8?B?Y1g2N1VobWRlSy9hK0xIOVFzUlo4VklicDZGNTVBVUVOSkRwQk1LSWl3aENB?=
 =?utf-8?B?V3VoVHFZWVVrRmVLQ2dsUjlCbDFVRElzOTlza1hCYU11SUpjQ2MyOHAxdWU5?=
 =?utf-8?B?VXRlUk9xT1V4cjZZQnM3dXlMZnlLUHpwZ3RPblhIMGxDQWRnQXo0Ly94U25a?=
 =?utf-8?B?MXlIc2hZendwanZvUkR5amNoNmpzanovY2dyUVBTTXJQMHhkblpWOG5zNEZy?=
 =?utf-8?B?WExZZDc2YjRDVXArbHEzQzI2ZW5NaFFQS0c2RHdua29pUnpPL2RJZ0FTSXhk?=
 =?utf-8?B?OTZCWGdocnF0T0cxYS83Tzh5cnJsa0xqZkhtWE81YXpoTCtFWGpWMGtMcXBp?=
 =?utf-8?B?REZ5RWl2TWxHODFXMHFERUpuVzVnLzM3eDZvejZibFhCMG5aZktKalV4VmNp?=
 =?utf-8?B?cmpGenRTaUxjS25ycG5BN1ZtdWhCYmNUZzEwTnpJL1dXb0NqbDRUUi9kMUtX?=
 =?utf-8?B?SUg2aVI3T2RKMU5GcElqeEJRNFJBdmpjR0FGdnErRElGR0h6T0o4QzJaWkJB?=
 =?utf-8?B?elpmVlQwV3JQMDhlMFZrSUJ1NDBOZkNTQzgrTnhPS3NFVWtlWXZkTGdRSXBL?=
 =?utf-8?B?cDZObk53cmI4azRad0FWdE1qUlBiQStBL3diM3N6OU1oUzE3c2l5THpxTENr?=
 =?utf-8?B?M0lINDgvUTR6N0pEVkxGSmZjWkpaZFpxRXBXMEpsc3RmVWhSQjUwZHBkaEtC?=
 =?utf-8?B?U0g4M3BQcjVDNDJVLzRERWVibWVUdkN2SC80Vnd0cDhzbHo1b1lBZzRPZytJ?=
 =?utf-8?B?SUFGRXlWTGhXOVpaamVaeWcxR05OeS9ubEF1UThKWEdFdzVEdklsVDZCRXdH?=
 =?utf-8?B?cGhsaElxZkd0elZkNXpHY3BEOWJ0RHpjNnJoQ0RBcWM5RWl1NHBnS3FoVkRv?=
 =?utf-8?B?Q0R1Y1NIMDM3M2E1QzFTVmQvNWdyZVRFSGp3N0s4NFd5bkF2UytuRHBYU0V6?=
 =?utf-8?B?VHRTVmROclpSZ21HZng3MFc0cU9DTG0xWkZHbE9aWmFLazg4Mnp3QW9rTVY4?=
 =?utf-8?B?TzdhSTdsREw5RHZtUWduN0Vvb2tyQVdsenZtTXlFbDRwRG00elNCOS9YSEQ0?=
 =?utf-8?B?RXcyd25yUEt1UThma09LOWdKNzI5bzhYL0FkSUsvS2FLd1NzRHRMenE4Rm03?=
 =?utf-8?B?dTljQndYUFlFblM1cWhVTkZMeDN4SWNxZE1jR1U3VUVCekJFTmY3aFN4b2ZP?=
 =?utf-8?B?L3VVTm9tY0trZWJERnNDTXF0aURlaUwvWEllKzlwUGlDZ3lEcExBTU1EVEVq?=
 =?utf-8?B?Tnc1TzRaY2NrMWYvZzdZa1NYTmkxOGtwSnJNVVQ3cWxsMk5paU5ySENxYzZ3?=
 =?utf-8?B?cHZmalRnaEJKSFhJV2dqN3gyeEt2Ym94c0tpeTJNbW1xOEVFOHo3SWs0bk10?=
 =?utf-8?B?bzBTQmY2ejlMbmxMQlpNRmZZdkZ5ckRFY09PWlk1QlN4eXFtdU9yMzVJbGJt?=
 =?utf-8?B?Y3BueTJNMUppY2hMT0M3dmdEaENsV2llaUpSbEw5Vmt5UTRQWkFGMTNhd2xU?=
 =?utf-8?Q?VuRF/MVFtlebBS/vYNonf0N2h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011d68fe-0bff-49b6-325e-08dadc46ad5e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 13:42:15.8634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SxerJS402z0G9fW64Lq03T0pbRSpHncvbWyqUgfDBS7J7lmItIc6vsDsx8Lvd+g5HBa1SK30K9BQg4qCytr/ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I think we have the same realization but different understanding of the 
code, please correct what I'm missing, rest inline:

On 12/12/2022 15:27, Jason Gunthorpe wrote:
> On Sun, Dec 11, 2022 at 11:08:30AM +0200, Leon Romanovsky wrote:
>> From: Patrisious Haddad <phaddad@nvidia.com>
>>
>> resolve_prepare_src() changes the destination address of the id,
>> regardless of success, and on failure zeroes it out.
>>
>> Instead on function failure keep the original destination address
>> of the id.
>>
>> Since the id could have been already added to the cm id tree and
>> zeroing its destination address, could result in a key mismatch or
>> multiple ids having the same key(zero) in the tree which could lead to:
> 
> Oh, this can't be right
> 
> The destination address is variable and it is changed by resolve even
> in good cases.
This is what I don't think can happen, since one address is 
resolved(bound), it can't be bound again so each an other try of resolve 
would fail and enter the error flow which I just fixed.
> 
> So this part of the rb search is nonsense:
> 
> 		result = compare_netdev_and_ip(
> 			node_id_priv->id.route.addr.dev_addr.bound_dev_if,
> 			cma_dst_addr(node_id_priv), this);
> 
> The only way to fix it is to freeze the dst_addr before inserting
> things into the rb tree.
I completely agree, and this was my assumption that after resolve 
address, and resolve route(where I add to the tree), the dst_addr is 
frozen, the only scenario where it isn't was the resolve_prepare_src 
failure which some why nullified the value instead of keeping the original.

and what I'm trying to say, is that once the CM is added the tree(aka 
passed resolve addr once + resolve route) , there can't be a 
good(success) case for the resolve_prepare_src again, since it is 
already bound so every consecutive call should fail, meaning the 
cma_dst_addr is technically frozen.
> 
> ie completely block resolve_prepare_src()
> 
> Most probably this suggests that the id is being inserted into the
> rbtree at the wrong time, before the dst_add becomes unchangable.
> 
> Jason
