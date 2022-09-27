Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8565EC21D
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 14:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiI0MKZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Sep 2022 08:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiI0MKX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Sep 2022 08:10:23 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2129.outbound.protection.outlook.com [40.107.100.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716F725EB7
        for <linux-rdma@vger.kernel.org>; Tue, 27 Sep 2022 05:10:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5AIGUFcUWrki2VPkSV/dY5/ApvNeacP6CYGLiixWGmRh/3iFuhel9Yj94zw0I9PtBgBTH9+nBjJk7PPYhXWb01zJ6zjC9J7GZfWHnluyodjDGTnJWi2l2ArDl0pUioqEnnQ3Vg+R/BdQA6EkWkPypzgXBAbrKvpXq8R6EjhVhnBs9sibk2rj2FhYRbhlR7p2snD3vyitvn18zWgtkdLDGaz5mxCTurbCQaoDlNu/mEa1bOR1T1FU9iTyiiaOEkkpCCNkbDDX20xSTI+J24rwV6cctEkrSmEtsR4vl/hHG9Yx+jPkjDuCRkuFqsLuzISOZ2n++VMLZKnhwoE+ZbQiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fChkhtFgz1+pcMSpycHG+8iY9fm9gE7Lgm/Wl6sBIR8=;
 b=Y8aqvaNTLGBiX2XKLT/Qpd/QPcCDLRjBduKmey4IKEVmoXoaABtGKNr3PHuAGE4QljoExZ920TO57nFe6gcE3YPlf44iwqafYz167SfCfZVpsZt+dr0hLchDOr0UEi8ruOiIr7VR4HuGGAFyLXYxh2Cq2adlcGYV+PoH+m18VdsG5PBAxrtiP+K+XVko5Y/fADjM6ysKD4gKNkGwy2eGpOczizX452dJyGxmYOexSooKE9EmQJLhuDy1S6FuK7RIgF+Zl5Nht3oX63j3KzNn2izxXIeaM9FMA7p+7werkkE2OU0+ydEkXgJ0tKtoPBj3aXLWwRVcgUPsei9WTZzcXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fChkhtFgz1+pcMSpycHG+8iY9fm9gE7Lgm/Wl6sBIR8=;
 b=GCt0u2bCGswrqRKV7WZSEXQNR+MAEshSgJ8/PW+blFBKKV1s2TuyMqa1LdoSsjL7ZeN/riMdKWIdZDbWm3X+dB2PXhL/GmD9BOpJG+88e/efuyZyhNKn9SKqXZjVOHDp5kM/+VfqX/tBYq0AVpCNloAuGfyY/20c3vUi7XQYITIEhyVASlRhqDacfB3/kyWpbNPTn1f2PeQfQOXX67yzGCLeo2pjkb7QkPAu5cNUhujcpG3b3sKMq0xf/jYDa7WJHyfGogsPD1IDG4kfpY5thMrcw/fTOsHNQPv3Yx6Wj58qw7GkpNnCnoRm2pjbINU4kYTDXYINOnoOJ9Yp1V08zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from CY4PR01MB2616.prod.exchangelabs.com (2603:10b6:903:e7::20) by
 CO2PR01MB2053.prod.exchangelabs.com (2603:10b6:102:17::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14; Tue, 27 Sep 2022 12:10:16 +0000
Received: from CY4PR01MB2616.prod.exchangelabs.com ([fe80::edd4:ab7:508:e093])
 by CY4PR01MB2616.prod.exchangelabs.com ([fe80::edd4:ab7:508:e093%8]) with
 mapi id 15.20.5654.026; Tue, 27 Sep 2022 12:10:16 +0000
Message-ID: <a7af94af-4ae1-ca41-009e-24ce9daca13f@cornelisnetworks.com>
Date:   Tue, 27 Sep 2022 08:10:12 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH -next] IB/hfi1: Use skb_put_data() instead of
 skb_put/memcpy pair
Content-Language: en-US
To:     Shang XiaoJing <shangxiaojing@huawei.com>, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
References: <20220927022919.16902-1-shangxiaojing@huawei.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20220927022919.16902-1-shangxiaojing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::15) To CY4PR01MB2616.prod.exchangelabs.com
 (2603:10b6:903:e7::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR01MB2616:EE_|CO2PR01MB2053:EE_
X-MS-Office365-Filtering-Correlation-Id: fb1c6d1a-5a5a-416c-69da-08daa0813cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RroMu/ypUOWCG9zNuRDCjma9e4UmNMnbuw2Wyz2o0NJrTt7wTfwbNISMcpypW/iSTNjgQEIih5Mh3YjNEd06zGchsee49T+QPBIfRG5TZCVsKx9QsesI/DicF5K0uhDZIW9r9wJsYnYJQyuHGAvEAzKMg0Fj/wHKx0OmZP6UsVyk/jAXbyaxd4JNa4liYuBXX/ZauD9cr0LFK6Kdo4pi/6qgHDljPLpHqueqVHMw1vjneeZ7keJjAuk9SMcIadwWnfAYV6GZtiJpODAEYmyBV8cTJDi7SIFjQeIIvj9pS+A5plBWBnvopMhEHddL+NSjkMMWSzW5cP08KCT8AQx/tjzL51UTlkMp5ZTjtpnE3sWl+li6y9STd6tixQ3c4KnwDMGGDPVsibs0IBGONoRAC1UogYfGpByy2wO4yV/VkXnmcuN0Ao+VJz19Zfvbj+E8lhn9hL1XVcSDA+rtR98txrRyU6PZdlXNo5GQN3WIh/xL+mKREc/pGTFM+DyU/gZaYm9q2xHLpTV4CUXTYiiFumYhOV5rXiUcSoIw+PlV9rP/5u75vVYqaX5p0fm6C6S8gpMK/Z3rZ4YsCeyLAO2ZSV8jfb9o4SiXFRaR/tFvB6ZdagDJBwrIiQQqVv8Ix10lU9ElKOdTlVxhpEsrayNZjj9ryxGe8xR9k20GNNzBmn1QKzNu7jeXq0baVDmlky2tXzCHK/imArUJ2iXpE00KCmWSw1oz1W7dsN89q27givXZK3UCfu44Al8fYy3N7rXmZlLJno+Vi8yXeSjHQFpOEWFi7NgnZ1B79Rr4Z7AYAaE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR01MB2616.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39840400004)(366004)(451199015)(36756003)(2616005)(2906002)(41300700001)(6506007)(8936002)(6666004)(44832011)(5660300002)(6512007)(38100700002)(52116002)(38350700002)(186003)(26005)(53546011)(86362001)(31696002)(83380400001)(8676002)(478600001)(316002)(31686004)(66556008)(66946007)(66476007)(6486002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU9yLzduK1VmcEVsekl4NENGT1YyakcxN1RjSVo3UmhQNnU0UHZ4ZnpiS041?=
 =?utf-8?B?MG45RWJ1U2JLMElDL1orZnZyS3U1RUw4Q09uRWpTS2NwakJkMU5jaHdWckVO?=
 =?utf-8?B?R2EyZS8yVWtSMlpwYXF5dnlSZUFYeXJMR09tcWRGa29TZmRYL2t1a0UyWHFy?=
 =?utf-8?B?S2Q1MTBXd0FIRFdsM1FVc04rMWcxcDJXZDVwZnVGL09YV0JxMkU5WDlESzJ5?=
 =?utf-8?B?VStETUFSbUVKeU9GcjVLZjdTZUtJYVQzVlFUTis1aWVraFM4UGxaOHlzeGMw?=
 =?utf-8?B?TThmaTQwaXFheGU4OWUrc1p4NmRycUs5TW4wYUdSMGFHNjVPZ29yT3dQRk9J?=
 =?utf-8?B?NUIwODZWTE1DbW9zbllIdGptdjhLMThvMWppTnlBWGxDNTJBbi9Mekk5a2ZP?=
 =?utf-8?B?UHZJMnN3U09aZVNKVnB3UXlGbUM1MUZidVZOaldXbS9rS3plbDNiTnI3enBM?=
 =?utf-8?B?NEs0WnZxWStsWnV4cmUyUlZhUTg2SG5keklvL2MyRzZoT3NvUjk2dEkwMnRW?=
 =?utf-8?B?Y0hzNldBWGxaem02YnQ2Y0ZTcWtZWDF1UUpjbzZTSUdsQ0w5R1BJT3JZd1Jq?=
 =?utf-8?B?ekt4VkFodjJDdzhTWWxZTFprVTZkVVc1L0FBQVYxNDVITjV2SWNhRnRrTjZO?=
 =?utf-8?B?aUsxREJjRUoyTEJ1Y0ZwMndjWXJGVWpGeEJnTnVkQkd5MFliZ1VDTWZOT29E?=
 =?utf-8?B?cTVNMXlZRDVzWVplWHFJNThqOWh4cmJMMzNkMkUwTWU4cGlZbWxwcCtVbHpE?=
 =?utf-8?B?RUVqTk0veGtJTnRHSE5YWnZsbG0wNGQzalpNTFFrdU1aVnlGZVVBM0xSSkFU?=
 =?utf-8?B?QzAwZXZ6MzlkMUVqc0ZlSzh1UUFIbDIvZUpxNE54ZHd3NExQQzQ1bGp4Mzl0?=
 =?utf-8?B?MmwyL1hPcnFkRDRuSUxmcVNrN1RReHBodklUQ0srUUwxVitMaW5VVUQvOE03?=
 =?utf-8?B?L0ZtWnJmeG5jZmNHQW9CbWoreVZRZUkxcDR1UjRjOEJ6RkVHYVZxYThXTC9H?=
 =?utf-8?B?ZnNMNk5EVDgwaXc1MUhKTmJVZTBBTFJNZlZJSDNmejZCOXlaZkZRQVJpU0dY?=
 =?utf-8?B?SnpFdVRaN2ZyeGkrcXNmU1IwUHZlaENaY3pTVUllWVFTZEZLOTBLQlcyS2ty?=
 =?utf-8?B?Z1A3bHFjMkNCazFrWEVrRnNoYlk4OGdyZHNxbVZIaG0rOW1YMlFtdWRKT1dw?=
 =?utf-8?B?Yi91Y21FV0hFRnZZaU5uVDZBOXVGMXhDSlNKcFBIckJkL3FXSnBZbjVZdGx1?=
 =?utf-8?B?bGVJN3pqWklmMFc5U3BXL2hkOUlvUFFUS2FnRWtVUkJNWFlGQVlSQWJKRHYx?=
 =?utf-8?B?STA2NGd3R2NKTmxmV1RZOEthNGNnVDNpd1FhUXhxcGhRYUROU3lDdTBTamhC?=
 =?utf-8?B?T0VydFYvL0J4UEp6Q2lqTy9GRnRRaTFWRGVCZWpQdEZZeThYK09xcEtDNHdy?=
 =?utf-8?B?SG1LVU9tSmVsV2FNeTl5TW44eTU0bEozY2ZyOUxEZ09uU2xGRUhEQTlod1BY?=
 =?utf-8?B?YWJFcmdSeHVGbHBrYjVvM2pLMWpodEFXZWJRdklGNlFZVUZZTVRtaTlJM2RM?=
 =?utf-8?B?WWJLaFdZa1dpZlgranREcEJ4N1N3YlFWMVNDQzY1NHpyaDZaK01pQmtiUjlI?=
 =?utf-8?B?WGQxeXM4QjZucFVPVFU3VkdrVHRPSXB1Um45cTN0b3NNL21DL0M3aHlKb1dJ?=
 =?utf-8?B?ZEVTdCtDQmZUYUsrR3hqblkreXNKYU9xWHpTWDZoZnNBUFBLN0czR254aXhh?=
 =?utf-8?B?WCt2WVV2eGlZR0pTOUtIUDVuWDVxdzNnZnFNMEl4Q09QR2dRSkVoWXJQdWFJ?=
 =?utf-8?B?OEIyWDBGYlZWMUZQUU8xa2NKZDNuWVlDalNsei9tQTRHd29YeVdFNnJ3TGRX?=
 =?utf-8?B?dlhnS2V2cTQrU09JRm50TnJZNysvZzhWQlFKNi9MNnB0cGNwRkFvNkRBeUVM?=
 =?utf-8?B?MEhyMEIvQlBFRTFWb1BtVGtQQVlmRnA2Q1JFVGFja2RvTlNDMUtEMkw1UFJT?=
 =?utf-8?B?d0VoejNTckhJcEtuaGNMaWh1dS9QSkl4a3lQYXY5b2RYNDJSZ1UreUduWUYy?=
 =?utf-8?B?cmpKVm5kNGQ0UTZ6eHVVQUFyb09QUDlHTTZJSVN6MmMyK1l2ZStCcW1VdjBR?=
 =?utf-8?B?RGV1UFo2NHBKZGgyVlBQOURnTkcxV3lRMyt6RWZZSjhXWTlPcXBoYXVnQ1Uz?=
 =?utf-8?Q?0h0hRNTz2w85YgRBC8FGc4E=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1c6d1a-5a5a-416c-69da-08daa0813cd0
X-MS-Exchange-CrossTenant-AuthSource: CY4PR01MB2616.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 12:10:16.0675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 563HONi69CT5e7DYncr3sgLfZEgUcWOuENWdXhehxD2k3XqATIsNhid8qhx8goJHHSfN0SBZ+AbyLTnDx2YdXqAnH1xQrD5QxAm4+ioXDxgoQsLVAbgFEzvqoQargC8H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR01MB2053
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/26/22 10:29 PM, Shang XiaoJing wrote:
> Use skb_put_data() instead of skb_put() and memcpy(), which is shorter
> and clear. Drop the tmp variable that is not needed any more.
> 
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> ---
>  drivers/infiniband/hw/hfi1/ipoib_rx.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/ipoib_rx.c b/drivers/infiniband/hw/hfi1/ipoib_rx.c
> index 3afa7545242c..629691a572ef 100644
> --- a/drivers/infiniband/hw/hfi1/ipoib_rx.c
> +++ b/drivers/infiniband/hw/hfi1/ipoib_rx.c
> @@ -11,13 +11,10 @@
>  
>  static void copy_ipoib_buf(struct sk_buff *skb, void *data, int size)
>  {
> -	void *dst_data;
> -
>  	skb_checksum_none_assert(skb);
>  	skb->protocol = *((__be16 *)data);
>  
> -	dst_data = skb_put(skb, size);
> -	memcpy(dst_data, data, size);
> +	skb_put_data(skb, data, size);
>  	skb->mac_header = HFI1_IPOIB_PSEUDO_LEN;
>  	skb_pull(skb, HFI1_IPOIB_ENCAP_LEN);
>  }

Seems OK to me. Although I don't know that it's any more "clear". More
appropriate commit message would say it removes the open coded way of doing
things. Regardless...

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

