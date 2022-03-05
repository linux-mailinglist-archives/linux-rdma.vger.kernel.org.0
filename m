Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCBA4CE17E
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Mar 2022 01:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiCEA0C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Mar 2022 19:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiCEA0B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Mar 2022 19:26:01 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8122327D12E
        for <linux-rdma@vger.kernel.org>; Fri,  4 Mar 2022 16:25:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqsQ/y1Pa8q1XKOH6T2TokB+3ihtbnBBu07UdvGKb66kzuy9RlkHBP6Oa0bUCV0xvdW9D5I9wV7u2fMaeQ+aZJtAKHB/fJH0wAlOFXpAzSD5zdRmyEtRUSJZRw1XGtsdEwmRyZRaobj5jlT4ji//CgZXSrqhb+nVqO6i+yvcV3pY7kieRArIxcPs+fgry2Y7bMp5UiwmaBmPRuwikMRPcZnD+k6Lj51AnCmE3I54f3HuFhgliHTEN5++gR+zxlEsUGuNWc2J+/o6lqDznRL4DN8eKKk29rli7Hxd0i8Ot9R5WOib2o04UHUGSiNs3KD7GXsz6lEeP4yaujUBjij3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cyW3yl7LrgJ8JuD7CiUzCYc2KnJvdxn1n+ymo14Ktw=;
 b=B6mLDTyLvy7yRtE8FXwH3irlpbh8QN/x11Use8J4Q/Mkwx6HRg4hN1giFgWo52+ngd60o9mtqMhtlYGOJLQydlRtvlMs4ZxECzz5Vnz76gDrH4p3CNDRW2Psd3BeDibcQ+iNfsXgN30ccyHv/tNT/WiBq0k1OATs3dYXd8e9X/ktL3NujH44V1F04mxa3oPgat9Hci5M4rm9vopiV+ZbyMAUtJRbB1FZg9wPE2DW2HhyVwj2SfT00a8kXlibnIfLY7aJhpJIp8buQOGg749T6v330IZXmFnUEKMDAYhE9oQ7/Gy/RntuX3xiCN/EP/xFuSMVc0fwldcn6s9l7ygXZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cyW3yl7LrgJ8JuD7CiUzCYc2KnJvdxn1n+ymo14Ktw=;
 b=bBS5ByI6dqgWYDmGGPA/PDdqLsEZxcNL+kN7x4OAKnBxFpuhz2lMmsdmR55me05CLHm45AeQBx6/q1ADXQagZCjGlBESt2nHZZj+clizTr330pqSAAGjJQd/w48c6KIHQX2kl5qCSEcrMtTlSUBjfHsvrb7dW0p8LCqhAc1aATBmSWLrlm7jM+Vx6fGYTim8HmV8qTvsrceHN7npaxPMWVRHWumFp/u8zOMvW60AjW7pIxn8daTqqU8+wN45cIXy/KGNtlyHx1/BXc9PUaHbaYRSYtHkU2mVsR2MAq/wrZvOOKKmwPuekzjVHFaFqCDffu3iPfJtWUlCS8+EJZOCog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB3925.namprd12.prod.outlook.com (2603:10b6:610:21::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Sat, 5 Mar
 2022 00:25:11 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28%4]) with mapi id 15.20.5038.017; Sat, 5 Mar 2022
 00:25:11 +0000
Date:   Fri, 4 Mar 2022 20:25:09 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v3 for-next 0/9] RDMA/hns: Clean up and refactor
 mailbox-related code
Message-ID: <20220305002509.GB1248225@nvidia.com>
References: <20220302064830.61706-1-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220302064830.61706-1-liangwenpeng@huawei.com>
X-ClientProxiedBy: BL0PR02CA0094.namprd02.prod.outlook.com
 (2603:10b6:208:51::35) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 427ee195-6bbe-4b14-42e5-08d9fe3e9bfe
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB392512286C3D29CDED3C725CC2069@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wgwQiJAL53Twib7FiS6FhH3K/YdTvpiL75C8lZxyk5FnHeilvag43Y7EfKUVk326O7YwwnVLJ9VWlMH/pOAgFUxKMf/O9ZjSYIEfCM8JfML9vcCC0rHAIdo06f4nXsBHmXysKnnLCwMcfRCbiNAzxaShaEGLQjDm7DD9ZgXX1Vtkm7WBXrnRX1hhMo9IitTJyRiJbmG8tMXm/LknuI4cTcardO6pqDw3+H/7YfgrGt5Cu2waQJnxQCpkBWpxCwB6N6OjfItL8tJDYvBJla99wMSaT1Nbt0aTUwaB3LNllYYAwejyptyXLSW0B03RQl8qVbjC3bzGjtJZKFbvf4lojDvulzgj3QDEW3Agao15ayM31tKwxMta3h7LC7FCZmoqRwvtlfkVxyzNsQkYNqDOu7BMJWFrux2LpUNtInVrkoOBx/H0YcCyPRcneJaHKiy+nCKJkRgD3PyRzA5FB12bnK1wCkrRXf3IBG27/ytkvLfJZGlirU8lv1XKrTja4ZSgtq8jztx40TXic3UERnZsV3Znxa7KlzTBOjZ1s59N52qOvd6CrZRMvHDs/izcpLkMvdFNd0EwkwGEMj5ehTxgRhvm5oFOYGWAPliJ0nMh1icXNsysjSt/RUbXWgQxjkjAAUkdufFvC0R8ixEEMk2N5EmORIxNzA3OqvGKB6q8dfy4nJoX4gGPMpaMOI45GqgeDedS38gaTVWbY3F2nTemok5nAd5DfVQ4QLLoONXjwOnoPkZzfwihP92VYxkI0UD/aTjdpFqPFgRwU7Xf9P8bKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66946007)(8676002)(33656002)(38100700002)(4326008)(66556008)(2906002)(6512007)(6506007)(36756003)(966005)(6486002)(8936002)(2616005)(83380400001)(508600001)(15650500001)(86362001)(6916009)(5660300002)(186003)(26005)(1076003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1BLTHZjOWdONjBiNjgrQ0k3ZGF2ZUQyTnNhMUhEeEFYb1d0WUFlQTdQNmtW?=
 =?utf-8?B?S1VzOXNEZkVjd0pRMmhINVp0aDkxUzEvSklZaFdKRHJkY3phQTE2cXEyZjZ1?=
 =?utf-8?B?OUpnc0drQU0xZUdxRXRPekJpdGJDQXYyUkVXZUhldXVkZnJENURBcGlvQkxq?=
 =?utf-8?B?RHZqYU5WZTJHRHBJaHR6M2ZNMlFtdkdhWXVXYitwSG9BcjBYVGc0c0Y3bVBj?=
 =?utf-8?B?VzNqZXMyYU44YTBuRytlQVFoNlA3SzBMa21VL1I5TGlDRkx2Q1oxeTd1Q3BI?=
 =?utf-8?B?UG1pQnlRU0lSV0FJZXZQQkN4a3Y5ZTFRRFo4TUtOVVZhWVVkSUExVGgyKy92?=
 =?utf-8?B?SUZzR2hOY2lWRU9veW5YaUxCSk0zVUVuN0FBU3JGeEx4eENiN2NrbVFpMmo1?=
 =?utf-8?B?bE9LSEE2azVDOFVsbGRKUUpEcm9MeW15MEdTdE1TTjJocDJ1SHI5UGlzZUhu?=
 =?utf-8?B?KzB0SlI3bXNtakUyekEzSG1WNG1kSENtYzBZbW84YVZFaUhkU0Fub0FnL1Ri?=
 =?utf-8?B?U2FCTTgzL25SamswV204cmg4enAvbFhod3NIQ2RnaEdBcjBESllGODhNcnF2?=
 =?utf-8?B?cUJ0T3RpRWNTRTYzSUlCQVZYdHY5Tm4vclZUaWxUd2pZcHo3MXZiOGoxSmdX?=
 =?utf-8?B?RGMzWnN2a084cVlHcmRWTjAzRlhRaXFRaVFROEorNUJOdUtmc2JVVlFiU0Fy?=
 =?utf-8?B?U01FSnZQc29Ud3pUc3VjcUd4OGluTjZxb21SNjAzTFFiUmJzTFY2QXhiVnNG?=
 =?utf-8?B?QnlQMFJYNWdjbjB0cVhSY0xidDVPV2FTVERQd25UTm0xNU1YSTRvYk1hdWJZ?=
 =?utf-8?B?NGdueHowWnZldUpRbWZnMThGVFJieloraHI1MDNpMFE1amlZOGZVT1gwcUVy?=
 =?utf-8?B?RjZCcmt1Q1lJRW55THllSVROUjhoNE1iaU1LVFowSk9jcVFwRmJ0YVRmSDVL?=
 =?utf-8?B?NkFMUkNYUzd2UzZDam9QU0Q5S09RMjBDa3kzalI4SzB1aHJMSVRqY0dFWVNW?=
 =?utf-8?B?V3cxWWhkVVV3NDVRYVNpSnBLNXBSWVlBZXZzN2NMd1lCYXNtVHloYjNpZVdl?=
 =?utf-8?B?SE1IQ2pxcXJhWXppRGgwMlV0QThhZ3FpdDZvQVVRUjkyR3p2TG5rNEYxQlBR?=
 =?utf-8?B?eXZVWi9LaGFYSnU3b0RoYVR5YXJEcTVCa29Nc1N5Rk9OVEZvZnFzeHlrVTR1?=
 =?utf-8?B?Zldmbm9QbEFtOG1rVGtBYzNaWFV1TGNIVTBjNC8weHpNZ1pCOTZPS0V0UEZ0?=
 =?utf-8?B?Mmx1RE53aGExQi9DQjBOUmg2NDdkYVBKdTNSb3hNR2JiZjE3UmdSMWp0emF1?=
 =?utf-8?B?eSttZmRqcENwVjFVUjlmQ3dPTWFKbHF6UnovTHY3WWFQUlBkK09hQlpnckpG?=
 =?utf-8?B?L0daMFVBSXlmVG9OS1B1SVNlSnZleUs1b3lrYnVHWERGYW9oL1FlZDhOVmJ6?=
 =?utf-8?B?MkdDZm5zR2g0MmJGTDBFL09BbkgvRU9pOXpTWUVNWlVYYUlQbEordlg0VlBZ?=
 =?utf-8?B?aVNjOVVKRm1iQ0dYMEdvNGV0Qk55MEdRTURnTlltdGpoUFZDR0VWNmZaak5Z?=
 =?utf-8?B?alJrUHdEOWFjenZuVER4MzlJOTdtSVRJOVFla0tpeWQ4YkdkK1RMRTRrTUdm?=
 =?utf-8?B?RDJHdTNkckxKK21yd3FuelhxMGQwM29wam1aWnF0Wlg0NllqaFhoTHEzNkRp?=
 =?utf-8?B?Y3ZFdnRFblVOUnd2N0YzSHdzTlk5MWk3MTRSOWQ4aXg3YVk5dCtxSGIyTlFw?=
 =?utf-8?B?L2ZicUx6czFhUnhoazlhUDFUUXRQSnJWT0k2dEs0d05md2FUeTl3Szl0Rkwr?=
 =?utf-8?B?RS9aODVhWU9odUVxM0JySzFPMFpYbFBQWWpSaDIxT1g2L0VmM2IxR3JwR1dn?=
 =?utf-8?B?blMrRkJGYmFvTnhMd09KbWpzbml3Zmd5a3lXajRBV3hmWldITnhhMERvQ1JU?=
 =?utf-8?B?czhMbUlCbDc4NmduaFNMcmEzdkVDWUZqZFBPdHQ5WUZxVUZseEZCZ1QzUDVw?=
 =?utf-8?B?RkZMSkIzNEl1NUpaOEM1Tm9mc3p6dyt1engra053RG9ONEc3Rkxmb0pqVmU3?=
 =?utf-8?B?U2ptVVo1UVg2Z0dnMDEyTk9PQndScjh0eGZjUEl5N2laNU45OFM3UlFsRmY1?=
 =?utf-8?Q?JmxA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427ee195-6bbe-4b14-42e5-08d9fe3e9bfe
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2022 00:25:11.0085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O16rQcfG6tbHOSAeMyvmu9o9336gRwIQJIODZai78MnIhLawb3ApjiF1ow2157Yo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 02, 2022 at 02:48:21PM +0800, Wenpeng Liang wrote:
> Mailbox-related code is getting harder to maintain. Especially after
> removing the HIP06 code, the mailbox-related code needs to be cleaned
> up and refactored more urgently.
> 
> The following is the basic information of each patch:
> (1) #1~#4: Preparing for refactoring
> (2) #5: Formal Refactoring
> (3) #6~#9: Follow-up cleanup
> 
> Changes since v2:
> * Keep using ERR_CAST in the patch #7.
> * v2 Link: https://patchwork.kernel.org/project/linux-rdma/cover/20220225112559.43300-1-liangwenpeng@huawei.com/
> 
> Changes since v1:
> * Remove unnecessary mbox_msg assignment functions in patch #5.
> * Add a new patch #7 to clean up the return value check of hns_roce_alloc_cmd_mailbox().
> * v1 Link: https://patchwork.kernel.org/project/linux-rdma/cover/20220218110519.37375-1-liangwenpeng@huawei.com/
> 
> Chengchang Tang (5):
>   RDMA/hns: Remove the unused parameter "op_modifier" in mailbox
>   RDMA/hns: Remove fixed parameter “timeout” in the mailbox
>   RDMA/hns: Refactor mailbox functions
>   RDMA/hns: Remove similar code that configures the hardware contexts
>   RDMA/hns: Refactor the alloc_srqc()
> 
> Wenpeng Liang (4):
>   RDMA/hns: Remove redundant parameter "mailbox" in the mailbox
>   RDMA/hns: Fix the wrong type of parameter "op" of the mailbox
>   RDMA/hns: Clean up the return value check of
>     hns_roce_alloc_cmd_mailbox()
>   RDMA/hns: Refactor the alloc_cqc()

Applied to for-next, thanks

Jason
