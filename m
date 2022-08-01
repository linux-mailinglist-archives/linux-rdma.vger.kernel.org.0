Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C7B5862BC
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Aug 2022 04:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239043AbiHACmQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 31 Jul 2022 22:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238902AbiHACmP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 31 Jul 2022 22:42:15 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61CE13D09;
        Sun, 31 Jul 2022 19:42:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7iZbA83w7hMuO7HSP48tYn/yGywIUr/3i+ssu+jSxVS8LzklgiLtHrTSDMCM5Vbt+X/uNuBsL/nJ6Ll8PY0QBUU8TnY9GL87vWLdMMsSlBqitaXC7nMShjhxiQH9ynvh+4v2WCmOJ4Gt1v1lwgqN4rCK9dk0WaRGJAyTMn10RGNurACjoPlR2QZpZ83Y81+dDq0aIdqvepdpyXtI/ASeewAr9ASrp2yObu4ILEeItT5Qxq0IQ5ekIKvWsPT3mCKVqBiUAXawnepXJ9NbBrmYgZ/zH+YwLzNy7W1PxS0Gy4b30hUEIrTe67GMlEVXaSjZPecWcH/S3o/6BIVKZCF/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAg/J966LiZrTvC4rWE5ou2aGLXZt0ricHZJeiiXfiA=;
 b=Z1AQ4T61e6o8dZWtIX1x5rXtQOM9g02bA46Rz/9ZD88TK70L8cUH/sELcj5nyxFbhRiQCrXTi4AVxRixyk0JvYWJOEeI88BWZnJN+q3srfIu2L4BVkhJPE8rruxytG6dQ3trx6jtaf8XAFYb+qstCvBHddgeXhAz8QlU5MAE2cpmEqGVFyFSUDGRFmVfofly650BZy7q+AtqYbVdGnf5wzrb5nzhTMFQabLk0EDuTlGa24xGblXnD7/h1Haykyh4bRcpWDTdSIeJ/WU8D/CwtgJD0HqGZPXYp3aIcWQTEJcLQBONkt1eWXUyGvzcxFikSLjdBf8Zki8rLWXHNGOlHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAg/J966LiZrTvC4rWE5ou2aGLXZt0ricHZJeiiXfiA=;
 b=Uibn4L4EH97lmWxrCn6PoQF+XtO9Cvq5eIbTnhYOTgpuCCG0XxC2g/7i3GoP/+7ibCYlX7wBuBt860uY4gMbpGd3j7zcnrVVOCxzN60/LR+SiHAH/STVwT0O4L/0gcvipjNo0K9YaNzxIhuGA4CZPR/O1Pjllsa8LML/Y2Z8uc3aQhHx6YU0FUYX6x6Y4uezrFwnxWVS+32O8ZHqcQk2isSs9TvYqWE96YBrRk/3sTd8xoSH/qGXLcysuIafE17sxoMc5lt7rTAQdLYro1HqTfBlRnTRPdBIHNCrSaiyoSQteqwULARVRu4lR1pscqIpLiN0QGDiJpWa3yOBF21WIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1366.namprd12.prod.outlook.com (2603:10b6:903:40::13)
 by DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Mon, 1 Aug
 2022 02:42:08 +0000
Received: from CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::dd48:8d3b:7eac:ea85]) by CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::dd48:8d3b:7eac:ea85%11]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 02:42:08 +0000
Message-ID: <c5968cf4-c63f-eb70-136b-cb002810f115@nvidia.com>
Date:   Mon, 1 Aug 2022 10:41:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH linux-next] IB/cm:Change the conditional statements
Content-Language: en-US
To:     cgel.zte@gmail.com, linux-kernel@vger.kernel.org
Cc:     linux-rdma@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220801023146.1594841-1-ye.xingchen@zte.com.cn>
From:   Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <20220801023146.1594841-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0109.apcprd02.prod.outlook.com
 (2603:1096:4:92::25) To CY4PR12MB1366.namprd12.prod.outlook.com
 (2603:10b6:903:40::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7e30c1b-652b-4fa2-f092-08da73676d24
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SB1SiVDff+z0sOHAWsFtSjypzowMYeYiBHP33StU/YqVcDM1pO0OCa8mpe9g6SuTIjLmxw99MOGquibUawjJ+yLi6il31eOiVQFFafyIN3FJPw1333KztAb62V/rLPK3Ie3Aj0VpZTjUxZOAvTY9/k5V8cKPxDABAgTi2WOSeNuiulLdTJc+5/oqI6Reej2LV1WGcnbPa/c0AF4L8/n6kM9tiqbo1a9koNLVU9PGtbWtALCWxlK8fYUpg+x3bJknuwToUBdgjoxrpmup8UISRADxU8eiesLVDvS9aMfQ7rnVk44KSgwfPDgM9CMtWvwqb44ssatuezYATwRQZs5WGuCBHZPkZjDaEJkD8TutNXKdsO9r7rmzbnMyNQwSekVPANL6Y0pX0q08HKT9VtbFMBRvm3aBJjKnNR4ZSKDJn9Ms9iGOPrtCbUPEbPjjhMgQFMRu4/7IFWpi5PPpjZ7Ypt4F654Ot45yLsLUeQyp5OBlVwGkZbR4W/tHHQ+y/l8uaAMAmPa2qJqOT2qWkbRzjhKyNmwqAtlHRslodZ1LjV8Fq2XJONZEI9XxgcEaz10i6Wrw5Mlhj0JuchWxjNsfuQYFIENbkR7GJU43DSCcJ3MtynHLK/WsET9NBUA4+SJMYQA8GlyrNxlF9gg2cVhZPWKG+BCl5Y7Ql6C+QatDqiPX3ofvk1UR0ekJwtsz2AH1ah4zrp6Iz1pBbeonVnff1EeoCEUlRLs5cxB0JUyWUju5v8MYXbcepFa8pdz2iPD2jksqVfIelI1zghSZ+F93498aGM0BdxwMLGbyXkp6NZvHD1HALzXuSf18Fm7UCJgMVy1EkVh1p7R2e0eKc8a7ky14V+fcCRkCOJsBvNYpYtT5Hxf1bHJ/h9JQlq4aaSldA8kGgTTPFSLQGEol0FtcJWihN8cIXNpfSvqGv3TtcEc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1366.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(31686004)(53546011)(83380400001)(2616005)(6666004)(5660300002)(186003)(26005)(478600001)(36756003)(6512007)(6486002)(8936002)(966005)(41300700001)(38100700002)(31696002)(6506007)(86362001)(316002)(2906002)(54906003)(4326008)(66476007)(8676002)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU5HLzN6TzUwRlZ5dDVKZW1KdjNadHhvYUFYNCtmcTE0eURIMzY2c0U0emE0?=
 =?utf-8?B?QVpNSlRsQU5mcXdiS0xBbklHOW9MMXdPQXdyNDJKUVJjMnVCN0tWRlNNOE9L?=
 =?utf-8?B?RmhEdFBUMXFweWx3bGxzL3ZybGtNMGdpcW4veTNJUnBKK3N3VGRoRHZzNjly?=
 =?utf-8?B?WVJ5OFVxT2FqUVNtSGdLUHduY20zS0dvUmVaYUV4QUU4Z2pzSGtVVzBBemF4?=
 =?utf-8?B?ZWFyMExqTE1Xd1hGQkluNHg4TUFSZ05Jbm5DYnRkdGNWdHpNdTRDUlVTdDln?=
 =?utf-8?B?aFFPYk1xMGFBU0kxWTRmbHViWlgxYTdqL1FQZ2E0a2lqN2doeUtIckxhSCsx?=
 =?utf-8?B?aGRVeVBUWXVPRjlWVmV1ZEswSTZFL1FNOFpFUlIvTGNDYzQ5ZGJuVWt4Rk03?=
 =?utf-8?B?Qmx0SDdiQTZ2cUo2SWZMZFhXcmowbXFDdlJJMU5qaDFEZnI3MnBPUDRlb2Uw?=
 =?utf-8?B?NVVRME1rbGxpU1oySXIxTkJFZmJWZVEzZGRWOUFwcVhyMEZRd3NTUEhUbmRn?=
 =?utf-8?B?Z0ZFcTFqREFJb01xV2prOFA0RU0zejVDY0RwcTJ3VzF1T25LM1hCb25ZZ2Uw?=
 =?utf-8?B?d0dOVUZTaVM5Qi9FSDhNRkVlbHdudmhwMTlLb0grcE5CZkR3RDAxS0hOZkly?=
 =?utf-8?B?b2ZKL0o4a05OK2ZZVmc0ZGtkT2pxaW94SlZockJLZUVJbEdCWVMzVTRqQXhE?=
 =?utf-8?B?ZWZzbkh6TllKYzlmRDYraDdvZmw0LzNoc0p1ZU5MdU9MeHpjL0xNbVZ4OGJh?=
 =?utf-8?B?djMrKzJ0N2owdjE3RThQb1hGN1NGclQ5UjRvdmRlRmx5NkdBbWlhODdEOE1o?=
 =?utf-8?B?U1EvMUNiVEdNUmVsWmpQWGNCeTJmYWpzN215YkhjZ3hqaU41MVhsYTUyU2pU?=
 =?utf-8?B?MXJCcHpscUpjVVZxaW44QVc5anpwdHB5d3J5TjhpQWgxYWp4RVhOV3V1MUND?=
 =?utf-8?B?VlNsQTArZVBpZzFpdE5hck1nOWhyZXViY0FqWFBXR0lFUjd0WTZ4b2FQUUlj?=
 =?utf-8?B?cDNRTy9vTm96YkYvQnY2RDY5QkFTRHAzekRZU25BQURIMnpXYmN3dm4wVzVV?=
 =?utf-8?B?K1hXUDRFb0tzUVB2TjE5MUtMK3ZHWlc0ZWFRK3R2dWFwWVFjbWRVVURZZ0RK?=
 =?utf-8?B?cHJXM25Da2lnenRXdkIvd29OZ29PM0l6M0RjOXFmNVZXL3Y0VVYwb2xYVmFL?=
 =?utf-8?B?TjJmaExhdjEwaFNRVmNBMzZ4NnN0UEtZRG5VcHdCM3YvK0F0cVRBNDNCM05z?=
 =?utf-8?B?ZHZCSWFobkwwaDB3WkNRWTdDejBqaW55VEpROTNYZzRRclNoOFBuOXdRbG1T?=
 =?utf-8?B?QnhwNUYranhYa1dZb21xc29zT2ptUUo5T1h1bXRlK3hYRmxtTEE3NGMzUFM3?=
 =?utf-8?B?U2JQM04xcUFISUNWZG5DZVY2WEJ0YVcvSmk2d245cW5rMTRmdzYxRVpSOEwy?=
 =?utf-8?B?ZEh3Ykg4d3hLMDQ3cGp5eW10amVtZTArU3BoZU95c2V3NEhmUXM1dU5Wdmti?=
 =?utf-8?B?SG8xN1JBd05GNGFpRzVhZkJYYUZMMEgzajVrMVdCYTlPOFdOdjNuRDI2WjZ3?=
 =?utf-8?B?cDNvdUFhNitrQVZtdzByb0QvWFovdnpRMy9WTVphZ1Z3S09TRVJPTXdha2Vm?=
 =?utf-8?B?SCs3TTlIOVJ0QmlFc0ZzUUNFeHVZalRBOWhtaXpQMUw3cm9VUFBaNGZxdit5?=
 =?utf-8?B?b01LR2dNN0lNb24wSnRKNWV3dm1BSS9TeEk1enRiRWJSN0JrWXE3RnJ1RGdv?=
 =?utf-8?B?ZTllUUNRZzhQTGprZ2dQd3JVMXpnbUFhZEFERGhoR0FISEh3TmpEeUtvU3Vt?=
 =?utf-8?B?NUNOUDZHb0hyQWNaYnk5TG1udVhUQkR5TXVOOEVjZW94RUR6NDRFUjVYMW1m?=
 =?utf-8?B?QUJqOFYxMnZMVytTRWRoSnVQcUdsN1BvanpXdG9QYUJwUiszWlpJOGdiV1cw?=
 =?utf-8?B?SVYxZk9mdnFWY0VnMVJoOHZpL0RLTXlBUUZXQTllTVZtWDR6bXlzVDk4NjZt?=
 =?utf-8?B?U1JzVElTSEJCL0ljZGNKTms3TmZ1YXhBYTA4eSszak52S0xBUzdYQXNheGg4?=
 =?utf-8?B?eVdlK1BDRHFkeVZDdHFaVEI5eVhMSkc2bk9QM3QzdUtlZEFlZjAxVHYra1BI?=
 =?utf-8?Q?4Osda7oYU7/TDDjJ5gsWtpD4X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e30c1b-652b-4fa2-f092-08da73676d24
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1366.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 02:42:07.9590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGpDvvdkt1xVCR6gyLKAtaLKew8FcZPf+Hc5duJiKdykT3Fbz9+yEFHEo8ippPFkM8jqFjXqbSl3aQW9l90ZZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/1/2022 10:31 AM, cgel.zte@gmail.com wrote:
> External email: Use caution opening links or attachments
> 
> 
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Conditional statements could changed to be easier explain.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>   drivers/infiniband/core/cm.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index b985e0d9bc05..6e323d0c0fce 100644
> --- a/drivers/infiniband/core/cm.c
> +++ b/drivers/infiniband/core/cm.c
> @@ -676,14 +676,9 @@ static struct cm_id_private *cm_find_listen(struct ib_device *device,
>                          refcount_inc(&cm_id_priv->refcount);
>                          return cm_id_priv;
>                  }
> -               if (device < cm_id_priv->id.device)
> +               if (device < cm_id_priv->id.device ||
> +                   be64_lt(service_id, cm_id_priv->id.service_id))
>                          node = node->rb_left;
> -               else if (device > cm_id_priv->id.device)
> -                       node = node->rb_right;
> -               else if (be64_lt(service_id, cm_id_priv->id.service_id))
> -                       node = node->rb_left;
> -               else if (be64_gt(service_id, cm_id_priv->id.service_id))
> -                       node = node->rb_right;
>                  else
>                          node = node->rb_right;
>          }
> --
> 2.25.1

This is not correct, ref.:
https://lore.kernel.org/lkml/20220624201733.GA284068@nvidia.com/t/
