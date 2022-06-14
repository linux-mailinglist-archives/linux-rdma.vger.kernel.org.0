Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BF054A39A
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jun 2022 03:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbiFNBTf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Jun 2022 21:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347396AbiFNBTd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Jun 2022 21:19:33 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B401CBE0B;
        Mon, 13 Jun 2022 18:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzUQ6N9di6W1JKmOdaYbX08vvPAn+stPLVu57lHXGgFPVNKwiuq+zjjEZ2ArYlGa0NghVnxbULH37i51QlZTIYx1ekBYSiKrWgIuPZjPCMLXwoLsxfoK7t9nfMj3G4xurEofUGIWmtPGcJdvp+1EBGiXKJ6H878bop+2eXXVvIMoImgE5dBaV4w4N/o+gmdKVSvnXgHOX9IvCytDRsuF9Gb0aY0o+exbKE8Jtw4ldOX2zbeK6yExjiqB6Q3jMpD+L805qtTOFquXi407dSsxl6tWSr2Eq9QCkR4kP3VaROKq2KziyjSYRKWkurfcUiM1CSR21Q2wbpCi3gRp6WCFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLTppljV1U+xDvvGKiGI0OF1yZwJltMDxdD2orSDhcE=;
 b=NB+iNyXbkP5pfDm6iSSsHtMEAnb9zxSxkHTCGCEjNUcwwZwI1v//TUVJIia/VTG6Ws9mE4GpNVDiM63ICmX1V2j/uuUK9cNV4SLMYPFvZb67f3XLlD92wgdO0f8lX1Ho2/J32/tB4ZHLcTsFE3ko+LSKfn3hKskxiyJGSE0txbdeKzOzrPeerWhtvbxnsTu99Ji9JAZxQazqBfbdNkWqPOvdB0VzR+aiyDSds5M0kkEbHpHkT06L8V6ZtKYJEU6Z3STryMtdl6sFNqJX6E6KxFMMVN80UWQtCAm++BZoEFmcmOK5ud2udectCp2w/1tuSgw738CwN+41RjaOez/1Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLTppljV1U+xDvvGKiGI0OF1yZwJltMDxdD2orSDhcE=;
 b=JwPkZ0N94FXckog5AP600y0+18YAnVAsmOgHVi0mcxGwszTWlrYkIFe3Bis3FJ/Ph/j5Ab6ASJFyQp1xPzju+SSbozqptpbAIT86GFun8HjdiIAYsFPoa3ob5Gj8jzgIcII45ngz5z0PiGG19jWs8f33HjWDHVUNowFw13OEGyLQCfPQtKPNQqoy78MOm5786II8p7NXm0/WU4DP49jfmIdg5Bp5vmc539KM3fTjkmdCBb+ToFWgtVYhHlBx3FuTEvijhYVmufgn8PUAhvrg54qJe0Sb0i5fYK0Jva8mFIqxkoadq9vIeFL0ejhfAKkZZL4FHPHjEktaJvxTnx3AqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1366.namprd12.prod.outlook.com (2603:10b6:903:40::13)
 by DM5PR12MB2456.namprd12.prod.outlook.com (2603:10b6:4:b4::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Tue, 14 Jun
 2022 01:19:24 +0000
Received: from CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::dd48:8d3b:7eac:ea85]) by CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::dd48:8d3b:7eac:ea85%10]) with mapi id 15.20.5332.020; Tue, 14 Jun
 2022 01:19:24 +0000
Message-ID: <e187af34-d0a8-55ed-cc21-d88845ec1eb5@nvidia.com>
Date:   Tue, 14 Jun 2022 09:19:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] RDMA/cm: fix cond_no_effect.cocci warnings
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, jgg@ziepe.ca
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220610094530.28950-1-jiapeng.chong@linux.alibaba.com>
From:   Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <20220610094530.28950-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0204.apcprd06.prod.outlook.com (2603:1096:4:1::36)
 To CY4PR12MB1366.namprd12.prod.outlook.com (2603:10b6:903:40::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c165f0e2-d531-4157-12e9-08da4da3eab2
X-MS-TrafficTypeDiagnostic: DM5PR12MB2456:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB245663BF39255F12CD1074D6C7AA9@DM5PR12MB2456.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aNRnFcweeTCJcz02yiaBGyoi6PdZe7PR+JTYMPN0pHeb4qHThNXH3nsSoneTQA3b6frI33qp35bSYVMJIibCxml5L/eOdC78KUiwgfvDJHH2u060RrGmY+QUSL70nJ6t6vyx3awx3ER+PRmbnLurqzD7lFCnZePGjWGxXbgMZDJwHcTwrOVpKtHzh4Be/PMRq96dW7UvgCc7sVaCm4QnjiTreQfmEfDedAXXJdDsNQBzOfUPNJycfecht2mtRA7om9c/I/DbbwM1FeT8iLBFmyLbwa7SlTTg7PleWEtV4N8LMo/zpWlFsBUZu6Qge4NjtnsuW2B8gje6qa/cqPTshRXz2aNlYwjWsYZXz3rVBNC8LwqWwuASwpTU7KbovJwYrQtnTn5/nd3tw3LGj1FJ6FLDFoULOH7SQTRC1pIrtymYoMxw91rUHEmwPGZHkzDo555DkHLmxYbL84g18rLH8duZvqNx1dnap6/DX2OScw1tkfkOCCW6OsYUxLjkQ9fLfk4XBTqljVOLyQGs9WAVkmZeCZvvK0f0FNvAvR7DsU5UkCXWHilI5hrAv2ch85yJ7U33n2d86tSQ59Elo7RdbWzdbZZwJIXLF1fdL1oY+9dgeIyNdBM0k36TOdLzCg4dI7U2Kjxj5J/EWKVLprT7tdWBd7LtvaMSqKWdncqAmdsy7J9f1P6Z44/lvFKGy2UzXiGKu/I0tsXjPLx1UMs0bdyor8R+bDZKRyfm1Hc3brgn1ltfeW9xyHZ95Ti9Y7yk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1366.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(2906002)(26005)(38100700002)(53546011)(6666004)(6506007)(2616005)(186003)(6512007)(83380400001)(5660300002)(4326008)(8676002)(36756003)(316002)(31696002)(66946007)(86362001)(508600001)(66556008)(8936002)(66476007)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDRPM3hCNFNxWnBTeVp1UW1LTWpLVERvVldoazFLZExIT3VnVDBmVmdVdDlt?=
 =?utf-8?B?N29YSUVueTNjTnR1dFByN0Z5K0tXSEptS1h6eUFTeWlnd2poWURMZmZtYnhi?=
 =?utf-8?B?dyt2SW9saHdFbENWVC90VThmV29IUk54c2k5MnVSR2F5VWR3RS96MWZrTzlQ?=
 =?utf-8?B?VUVNN3gvQ2ZMWmZjSkUrT1FsWnBQSnYvbDRWZStxREFUZFlFN1hjZFFHY29v?=
 =?utf-8?B?M0dtSHBubmtST1NVSnRuQXpPamhwVWxmRzNoWHNZNWRDVzVhdDhuMGVNMFlo?=
 =?utf-8?B?YjZFM3VZT0ZRdlhYcEkzaDhxeHRFMjdjSDgzKzN6akxGZ29XWk9YWkxsVWlZ?=
 =?utf-8?B?S2xwckdKWExVSmN2T1hkTXhRL21uT00zSEgzT1Z3aVE2QlB5cDF1aEpsS1Q2?=
 =?utf-8?B?UFpNbEpuakF4VTFwMjVQUDdRcHUyUi9QbGVXZmE0RFdMYyszYVlRTVlzUENv?=
 =?utf-8?B?K2lNUVc3emFzS2tYd3RGRDZtNXNHVmRQSWZsdjh1am9hb3RBY2toVWhNNU5Y?=
 =?utf-8?B?V0hHVUpraWdIQ3pCMk4weEVBZWkvUTFkOWpoY1Fqa05SSUpFSTNyR2JjMlRu?=
 =?utf-8?B?MEM5c0wrRmNnOW9QeDVqYU1leXpqSHZONmMvRm9kRFMvRXBpdTlZTWl3L3ph?=
 =?utf-8?B?cXdwdTNWelB3ZzdZbkFtV1cyQmF2ekVickhNalFFN1BGbWZRblMrRXVEeXoy?=
 =?utf-8?B?SE5MaWh2VG1JNFh2ZkltNEtGb3JEWUloYktUano4RUluYUs1ZFYwM29zK2dj?=
 =?utf-8?B?eXZ1anF0eEJXRGZUaG53Sno0T1M3ZFk3RkV1cC9sQ2Q3bG5qRTBOS2M2ODM3?=
 =?utf-8?B?T0NqYkltbzdtTllMcHFzZ3h0MU9OWUhDdXRqZklvSk1kRFkvS3pKTUE2blRM?=
 =?utf-8?B?NUJmbFh3ckJCZmh0empzRE9LbXVXMnV1dUJHWnpuTDAxYzI4MVBDNUpEMnpL?=
 =?utf-8?B?eGNJVm5PQVJCR0wzdzZ6R2VzNFNrWS9uMVBSc1RPZTBxK2hJbXhKWGRqSmo0?=
 =?utf-8?B?VTJOZ2JKbEppeHA5UEg5Z2dhcnZ6YWhNZG8zYmp5VFZkZkdaQnlvVndiR1dQ?=
 =?utf-8?B?OU5PT3VFUFFzV084NjYxMGVQOHhRNFU3L0NKRkdoR1l0WnkyS3RUOU44Nzda?=
 =?utf-8?B?Y3owc1dJV01aZVp3UjVtL05FSktzL3c0c0lKSXVINkRJWnFLa3Y3T3BNS0Qv?=
 =?utf-8?B?WUpxdWh3QmpESFpTTDlKVUxoS2cyQW5WbmlFMVJqN254UDEvOHBiM0VyVUs1?=
 =?utf-8?B?RmZkWHFKV1huWDhnOWFLdERrVlVmSGZyUlo0QWkzYzVaNmRzNjJySGV1RVZ1?=
 =?utf-8?B?c3JWa3VxSVBES2xJQnZXQkxjeUlhVzl0a051eFpXTDlCUXRhaUYrOGxrSS9I?=
 =?utf-8?B?VEpzcVNKYi9WbEc0VGVIcFcrMVlvV2FndURYRkNxTFppVHBxQ2RnNSszejls?=
 =?utf-8?B?ams2WXlmZExsdDBHSEtUSHJSK1JnWFRHaUtNbi9XR0U1ZlF0djlYVEdrMU5T?=
 =?utf-8?B?dTd6RWNFUDA0VEtZSkVBUWMzWlhEcDBwRU9KV29RWnlLNFVIR1YxOXpTU1hY?=
 =?utf-8?B?YjB3b09hOGl6YXBuMkNOdWk5VEZkRUlWTHJxU21iZ0h6VjcyN25MMVNrbGEr?=
 =?utf-8?B?dUl6VXNLQzU0bXdYa3doUWVmOUQ1eTJBQWlvK3RUV1VpclZuTmRQRGpDUDZB?=
 =?utf-8?B?YStNcmFhenBhR0xkM0dOd3BYZmJ0dDVtWllwYWNRWk5HS2hCcXpUWVV0Vm9W?=
 =?utf-8?B?clNNT011TWh0RTlIUVQwWUordFN1RmE3MlNGeW5lay9kdzhDSUo1T3ZwSW5p?=
 =?utf-8?B?c2ZSeVhyc3JTUXhiRjNiVlFvZy9ab1Jlb3oyeDhuSWV4V2pvT1hVSmJrcklu?=
 =?utf-8?B?WlgwUGMxV094MWdGSE9LaGZEdmxYSkVtN1FNdnZEV2NuNGZMS0grVVplYjV2?=
 =?utf-8?B?WjhSK0NiK2JmV1Q3L2pDZjNyazJOSFVFclphNU4yaXdZYXJFUndWdTZ1VElI?=
 =?utf-8?B?eVFKNGRVMWlaMUZzYUJvNzQwdlJ0OStGbnN4bnk1bk0xYnZNMitYWWdObG9W?=
 =?utf-8?B?ZEcwS0FXcXFnaXpOODBrK1JjNlVrOEpVNmpyUGpPQnFMZkl3YTM0eTIyaVVQ?=
 =?utf-8?B?c0V6ZkMydWxweS9wRmFma1dibHNHbGtlNDlOODE0WGZLOThLM2Q5aXB3NmEr?=
 =?utf-8?B?ZjQyZExrRldndVFvRjQ0YmNMSVB5QThTT245MWxDZW5aSEZNRlBRdlluWXV4?=
 =?utf-8?B?OEl5RXl2ZTMwNDFDMjVETlFFTzNaTy9EMHkvU0h5RjRYOWVRRmR2SytGdStU?=
 =?utf-8?B?S0lGaHlLQnRWN0FYczM5WmF0bU53TEJDaGkyZ3AzQjdheW1pcnAyUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c165f0e2-d531-4157-12e9-08da4da3eab2
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1366.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 01:19:24.2330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMJuFqWAXMHsr6rrLmlwnNZIbcUSOD92wbEM2W0QwEuOnbOwJuhhi5ukg69AChuyGvnK94WSM1Mr7oVvyXervA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2456
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/10/2022 5:45 PM, Jiapeng Chong wrote:
> This was found by coccicheck:
> 
> ./drivers/infiniband/core/cm.c:685:7-9: WARNING: possible condition with no effect (if == else).
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   drivers/infiniband/core/cm.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index 1c107d6d03b9..bb6a2b6b9657 100644
> --- a/drivers/infiniband/core/cm.c
> +++ b/drivers/infiniband/core/cm.c
> @@ -676,14 +676,9 @@ static struct cm_id_private *cm_find_listen(struct ib_device *device,
>   			refcount_inc(&cm_id_priv->refcount);
>   			return cm_id_priv;
>   		}
> -		if (device < cm_id_priv->id.device)
> +		if (device < cm_id_priv->id.device ||
> +		    be64_lt(service_id, cm_id_priv->id.service_id))
>   			node = node->rb_left;
> -		else if (device > cm_id_priv->id.device)
> -			node = node->rb_right;
> -		else if (be64_lt(service_id, cm_id_priv->id.service_id))
> -			node = node->rb_left;
> -		else if (be64_gt(service_id, cm_id_priv->id.service_id))
> -			node = node->rb_right;
>   		else
>   			node = node->rb_right;
>   	}

Not sure if the fix is correct, e.g. with this condition:
   device > cm_id_priv->id.device &&
   be64_lt(service_id, cm_id_priv->id.service_id)

The original code gets rb_right but this fix gets rb_left. Maybe the 
warning is complain about this:
	...
	else if (be64_gt(service_id, cm_id_priv->id.service_id))
		node = node->rb_right;
	else
		node = node->rb_right;

Besides cm_insert_listen() has same logic.
