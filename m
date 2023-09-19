Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829E07A596A
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 07:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjISFfY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 01:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjISFfS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 01:35:18 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA12C120;
        Mon, 18 Sep 2023 22:35:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JV9rdSh7ZdS2t4iJs00RVSn2SXONLAIQGlrEDzf1Oik+a3IVP4RM5oJ+piUSzUKE6dHsWDsfupxdb4L8ksagUapiOJFhfyXf3xhVQx5XgzkNPyrKJ3WnwG7fbEaiffdVy26XGeeLVb8bNdLETdwNG3ILaz+327V4hx3+vGM8GWOsKAr/k9O/87yzDaYwVBUNacCUif8KR9CbPnN6IJwATajM7XffLHaHGNr/ZeP9huXbDGAYJdqPVW0TB3ADarnFjhLs8f9JDbdeoLMZg7oHzQhSztUNACCKO3q1JLxMUN1hoi7nHdtdGFTe3kTrGc4bIkCnWFSOQmGXYnurXebipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKgjk4jvKUqCdGU9zR1vX7hECg241F1wvmnpDPdnDLA=;
 b=iq9iYhxNXQGXZcK5iiqTs0W0C+IliVYdUuCeBNns0MmVweeg2x4hMKIed8TBSMqgT5bKnLCmZ0f3VC6jSLlG/renqPWX+p7f2tC1DnlIYJdKPQY4M4E7bGRArB5eNEbnJkwTz3xzQJMrhjCvLKCURQH8c+WhYQZxC7mi0PyCz87ic+2ubgQSxyjlBFIYqOrCTzhEnhdmY514BaKY90+OjqhU0ooe6sU1gp3V5pe+Uc03RhP4Jfn19FwOeiviEdsU3Pn2HhlJLnoVIsbbqrcE54+d4KIGqmzdL4bPtjWPcRbVaeVgp7rDwwdd81aYlnhyfZtEOtI//v/DjLJGwlvd9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKgjk4jvKUqCdGU9zR1vX7hECg241F1wvmnpDPdnDLA=;
 b=JgwykG7ddRImtKhol1ANSoN6R2826d2s7mY4btfah9denxObW6b/Cc0zVJBC6dQWwtilC30ArpraCH4saAgPFHrs9XAlM78DoUmVmDx6A6lqZnOyiFak3mneDX9U1zcxN8OgJ+rAEp6Vs2n3Msf50rFqLriKCsCwAobWdNwN8q3EEM9+SZfmYFXjnAGI149XzQYS5Z7EYstjJ50y+EOzncpZfvyEpVEfT1ySHz/uP7H23jbPUo81dkc+KmDAAsQgIVL1xn9OQzdnJ6PwDKt3gaNSZVnyGRyB5J40iNmv3+moJzGGl3GR4/mP9yGfuGwjMKN/3bdlhEo+7C+7DnlDrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11)
 by SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Tue, 19 Sep
 2023 05:35:06 +0000
Received: from IA1PR12MB7495.namprd12.prod.outlook.com
 ([fe80::f69e:f37f:2c20:1731]) by IA1PR12MB7495.namprd12.prod.outlook.com
 ([fe80::f69e:f37f:2c20:1731%7]) with mapi id 15.20.6768.029; Tue, 19 Sep 2023
 05:35:03 +0000
Message-ID: <a80d2e67-11f2-5b13-f966-b9150df1e568@nvidia.com>
Date:   Tue, 19 Sep 2023 13:34:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC] rdma: Add support to dump SRQ resource in raw format
To:     Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
References: <20230918131140.4037213-1-huangjunxian6@hisilicon.com>
Content-Language: en-US
From:   Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <20230918131140.4037213-1-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To IA1PR12MB7495.namprd12.prod.outlook.com
 (2603:10b6:208:419::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7495:EE_|SJ0PR12MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a5b254-6c9a-422d-4a93-08dbb8d22c68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7UJ5whrO9q1/ljsLvyzw9RB8ETnYezB9TBf8722+4ZCD8gPWIuTAiZlnqGGZ5h20TX1dQ2lRt1o0u6yUBuB/cJy+nx7DK2aE+7XkqmA4LsJJ0I4pMv3I/xrLgQu/JMse4JWSWxUv8eWzwGzNjPnorbGUDIDW8uqH6KTv/B4pHyAYFWEv1AL2lHAm76MVlNK9/rAS1y7kdpsBHykKJuc8YAlV1EK0bZ7tsScvZFmZHB9ITlsxQ3RHfJR9iSaDA+OIhXf6zsp8H8yFpYk62r1GGJRnSuz02WVU7l6eLHQ2vMFeLW72exjBBoX1daRPvXveXhVUgDLWfwo+mH38uJwygUnGC85DxW2HmXAvKsih9fvNuQoqtUs2Z0HYMtjZXJ67CYxI56oqGj4AAyyDyN6Md8nWSEhHe3LSH2C9Yy7km5G+8hUYtgBHl68fGSI+2MCHDuDKHcwk55fUEg4lMeSRe+gYadVXSuP22SVrpJDt6d0eocMqGnq4Iv3Vwm+G7vBgPeMOxdRi5pM0+d4SUYy/SZT2cTVad3XWY98HOxULcjrpPQ5TjGvsH7JjkahX85b75K0myn5I2Ks83wp4vLJl7cEOqg92wg2V5NN6m8PUYP3Y+MrS1T2+GuFFPvCW+OosMgzqY4iHK3hKAQ2Ti0UA+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7495.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(376002)(396003)(346002)(186009)(451199024)(1800799009)(26005)(53546011)(6486002)(6666004)(38100700002)(66556008)(2616005)(83380400001)(2906002)(66946007)(316002)(66476007)(4326008)(478600001)(5660300002)(8676002)(86362001)(6506007)(6512007)(36756003)(31686004)(31696002)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2wyVFh3K24vMmUvVUNtemZxamVqNHUxOU03eHJkRVpKRjlkS214blJiWkhx?=
 =?utf-8?B?WCsvOFlsb21YOTNEcngwejZ1aWZxdjA1RkQyc1dsUTJvUXFpazBtQ2tpWjZX?=
 =?utf-8?B?OGRWQnQ0M0hZYmNVN0xETnNEdmQ5aFhZVEpoeTAvai8rMlJ0Z0ZXek9VL2xM?=
 =?utf-8?B?UTRkVVFGT3RMcVp4NVBoNG9YNGhzZEovVkxqd0JteVdobGZrNTJoZzNza296?=
 =?utf-8?B?VVhxN0JHSWo1eHQ4Ujhha050M0czMmRoRWFWWlZBVDRSVDMwM1pzQndaV003?=
 =?utf-8?B?eUJiVk9nOXY2SFh6OXMrQ0VoOXZ0bUNPNmJkMGY5Um5hYWxYSXpCT201UTdz?=
 =?utf-8?B?d2tWNkoxdEg4Ykp4OC9uRVlPVStDMVl3TzVEY2xwVWNvK1VEY0FSSWR4QkdF?=
 =?utf-8?B?MU12a3NieXN2TjF0aTlWazF6bjZud2xWYVZxSUptRmNhWDlRMFM1SnVaZzR1?=
 =?utf-8?B?c0tDakhEN0xMV2ltay96M1h4dUlBWkpIY0k3eDhsSFFnQTJ3VlpxNFNFL1F5?=
 =?utf-8?B?ZmlSeVpBWGJ6VTZYQnNkRlJxRTAwSjVMcitMTGZRdjNsbG5GOXF6dUdUaW9Z?=
 =?utf-8?B?d1YxRllRdEpTRUJZUWtGTVNIdlFsM2VrUnhseDMzbXFyWlk0UHhhZExQUjZJ?=
 =?utf-8?B?Zk5QOGR4am5UaCtMY0ZkaXFqRk9PTTZoRzNXWnphN0NITXUvWGNTbTZMS3dT?=
 =?utf-8?B?RENQQ0tmQ3l0WEMzTTF3cFdTeXlkS3psN2hQV1lEWWx3Y1B6U2FWNjhUMzRC?=
 =?utf-8?B?dC9lWEpWSXN2MzJOZ3dmeU1DTlRGckpLKzgwSlQ2Y0p5MGZXNE96VWZzN2xj?=
 =?utf-8?B?bjViZFJ6bmhEcXRqbFhBaWZoc2liMnFCVWV2VnZadUlraWlLcHliWWVxS1Ex?=
 =?utf-8?B?M3lwOWxrOW1TVGRSTTlZcXBLV0FCQmdvWVNQb3M0NGYxQ2s4UVVtZTFMUzk0?=
 =?utf-8?B?OU9CTXBjaUJmampkOEpzL3pQNHpGTGNJYjRXMXlMeEVHakNVWTR0Nk5UR3NY?=
 =?utf-8?B?b2ZtemZ6S2V4YXdNRGNCS2cxc2N2TFhPS25XVDFNNHIwYmZGOGtZWVcwcVRm?=
 =?utf-8?B?Z1NyOGVEZmd1azN6WG9raVpFTS9iSStIRHU4dG5VZ0t4TVNQeURxblRaM2V6?=
 =?utf-8?B?eFRaejJtZThNSnZJZU9GT2xVclZSUlBsK0ViWTNQWUk5Q25DNlVweGxobnlZ?=
 =?utf-8?B?Qm5pMVE1WTNMT1BEaG4vZm5CSXYrOTg4TGFqd1Zoc1h6Mkord01xeW1tenVU?=
 =?utf-8?B?TnBkVUo2eElVaUVPY3NTR2lqbklpSmdNcytKNmZXRGxEZHo2bkpJZStUb0xy?=
 =?utf-8?B?VUJ6cHJXQ0djRHhSRlYxSzR6c3l5dmdnbWFZbXF1N2JqdVhYcTNHYWFVV1J0?=
 =?utf-8?B?cXVDV01FdVg2TjZlWThUV1V3aEZHUno0bHJJU3BMOVFGYkVidE81aGgraURB?=
 =?utf-8?B?eVBOMDcrK1RQZytPOEVFRXBhWkRBSS9FeXBoS3hiZmNBYkRlM3g1VG8xejFQ?=
 =?utf-8?B?RlJkQXJZdldCbVhmdFZmQ1hwQ2lQTURkM2Z3NStZS2UwVkZ4MVZ1NFFudlZo?=
 =?utf-8?B?OEIzR3ZMNEdXS09mUjV1TWVaUWVhZ0tuNlllelM4NWplUmR6SW1Pb1B1RWNL?=
 =?utf-8?B?NHJ6QUEwdXhmSFZGNDhLYk5FNm15VDJMOVdwdWRrenZRQ0FsQXE0VE9PMU5V?=
 =?utf-8?B?WlE1VWwyNmVjWXdXa0FKRE5QNFVOUysrWHdqMXQxWFVsZUh2cXpjb25XdTdW?=
 =?utf-8?B?OTFoNjdNTmFhSngvdTdsME8zQkxsLzFlbDJqYTBtZ3RGT2todllWMXpvSkps?=
 =?utf-8?B?RE1ZSWNhZ0NpZlBuSllPR1F2VzFYWlkwRUhRYWg0c3BBTUpqSTRwVXhBcVpz?=
 =?utf-8?B?RlEyTnlCeDVRaHpDSkRPV0JkQjk2N1Zhekl4dE1DMVRwc2MwektFZGZlR0Jh?=
 =?utf-8?B?NmU1a1N2RklRQjhXTnIyeVdFWUE4dk81SUVFMU9aaEl0ZzRsdWxSSnJUeC9F?=
 =?utf-8?B?aXl6VWxEME93bXlEcGxHN1VyWWU3MGlEZCtQZnpsc3NkUjdhdWJLWlhZUHZk?=
 =?utf-8?B?YU43UnNkWEk0S1JNMmlvajA2SG02RlZrRlhwYmd2ZFlWNlVhVnlaMnNNQkp0?=
 =?utf-8?Q?eMhP3nIWKqd68F7LuH9IiKXvw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a5b254-6c9a-422d-4a93-08dbb8d22c68
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7495.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 05:35:03.5118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StKtKQk4Z6nUHqebtIDPgRPk/krRBbamr/Z6fyPozZwoJfXvzW6jkj1TnfizeCR0R6yL5ttLGXpwpdGWA95sew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/18/2023 9:11 PM, Junxian Huang wrote:
> External email: Use caution opening links or attachments
> 
> 
> From: wenglianfa <wenglianfa@huawei.com>
> 
> Add support to dump SRQ resource in raw format.
> 
> This patch relies on the corresponding kernel patch:
> RDMA/core: Add support to dump SRQ resource in RAW format
> 
> Example:
> $ rdma res show srq -r
> dev hns3 149000...
> 
> $ rdma res show srq -j -r
> [{"ifindex":0,"ifname":"hns3","data":[149,0,0,...]}]
> 
> Signed-off-by: wenglianfa <wenglianfa@huawei.com>
> ---
>   rdma/include/uapi/rdma/rdma_netlink.h |  2 ++
>   rdma/res-srq.c                        | 17 ++++++++++++++++-
>   rdma/res.h                            |  2 ++
>   3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/rdma/include/uapi/rdma/rdma_netlink.h b/rdma/include/uapi/rdma/rdma_netlink.h
> index 92c528a0..84f775be 100644
> --- a/rdma/include/uapi/rdma/rdma_netlink.h
> +++ b/rdma/include/uapi/rdma/rdma_netlink.h
> @@ -299,6 +299,8 @@ enum rdma_nldev_command {
> 
>          RDMA_NLDEV_CMD_STAT_GET_STATUS,
> 
> +       RDMA_NLDEV_CMD_RES_SRQ_GET_RAW,
> +
>          RDMA_NLDEV_NUM_OPS
>   };
> 

Usually this file is submitted as a separate patch.

