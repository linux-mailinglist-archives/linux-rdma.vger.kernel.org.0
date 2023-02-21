Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C9869E0EE
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Feb 2023 14:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjBUNAX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Feb 2023 08:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjBUNAW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Feb 2023 08:00:22 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2109.outbound.protection.outlook.com [40.107.244.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05905C143;
        Tue, 21 Feb 2023 05:00:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBX36V1N3zC7IoAqgbUGhwyOhpyjuDlSe7KVKBNM5shRmsGOgeg7tjyR5Cf+r0JjDssviUQ37Ouzfzh9kySQXxYhMKcrPt4lmV8nHTLd+GCWC+NjJ0VvnJMcwftpABrGVmkPHDhtWMlKfzVIDSW3T4RFx6jIVflfylJQSN8GKq9et65aByM7Pr0VjMIE6i88M6BfGIY7TtTU9kTmVp4NOp19KZ7HBAKZZLbuvfEO2MRRIXrdaq14R3VV6qLdtBSBmDXl2GtRc0coj00bnTcCbS+mSN0dRAxUdfJriEzgxrbguk8jbd6gJ6U3YAvAsFkrW80yG4nQ1R6uIgfUEOj63w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBlpbQswyjg+jHz2DrxIohaMv38hv5ks7y+DuNA2oW0=;
 b=aiVm2CwR1peXuhWNe/DnaJrsgPaBwxGSNuw7THryrd1e3j7yjiHW1crM8QjDGxHF3jostb176tGWUYxHQLAim1HwptJx5ZxfH1WAIEefh/VJNsp6IticZ7p9W8XxP3A+qKUftMBxziXYNpnQTsQXIb8HrdZqB6UxrYS8mGxwBLekNH88pdD7g+HJ8CN8Vl9hKPRrMUoRyTv1xbPJf2BZxRUKb+o2BB+fjQIbAd/6hgMHty5s7Bw4GuII7NxgdiBMdZluR+rt5MRHDcU1mNzLPKRYBfMMmBSSCSKwwt6yyoOkuKh5FnBiWUy4UUyTmNBZP+fEXOdbRNediAbKVh2K2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBlpbQswyjg+jHz2DrxIohaMv38hv5ks7y+DuNA2oW0=;
 b=eF1Z0Mf4IwLB9K5ILtgffV03RJjIlkSQtDPf8yHIuBZUvNOG8KVPeYbeS/9yy8VVvlnYbZYn7+yn08KcW+lLfs9i2FbB/2BJ0Aw6qlkhqKFzRFVr8JfY6v/9Bj1IzcALnnQWJ5qCQrIue2E692o55GflSFDGKFQQX9kqhSOmiabfY7JWdscgeK5DwB49TaCE/eepuUWFr5z5pFao+B+DaCB+ozeid3oA6P0b47Z0O7n9NygXDbQs0G0TBZZx/Th/vV47slfVWp0cp+0+DXsyuIsSZsoQ3DYQFVJEujtP2UUZmiFuS6ffVmb3B/dn3FFUNT/uFdKQxpKy805ZATxowg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BN6PR01MB2610.prod.exchangelabs.com (2603:10b6:404:d0::7) by
 SA1PR01MB8202.prod.exchangelabs.com (2603:10b6:806:373::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.21; Tue, 21 Feb 2023 13:00:16 +0000
Received: from BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8]) by BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8%9]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 13:00:15 +0000
Message-ID: <6d2fe281-891c-8909-5330-f05d4407431a@cornelisnetworks.com>
Date:   Tue, 21 Feb 2023 08:00:12 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] IB/rdmavt: Fix target union member for rvt_post_one_wr()
To:     Kees Cook <keescook@chromium.org>
Cc:     Zhang Yi <yizhan@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230218185701.never.779-kees@kernel.org>
Content-Language: en-US
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20230218185701.never.779-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:208:329::31) To BN6PR01MB2610.prod.exchangelabs.com
 (2603:10b6:404:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR01MB2610:EE_|SA1PR01MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf2d972-f835-4d17-3fcd-08db140b939a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8MYQ+z39+cxgNvMZGAKIMMLam+PuENEHnRO7GZjpL+zmnLU6cBwbNKQtJPQWVLrEXJkLBUxFejQGhsniM7+vsxe0+Suowea7ObJW+Kfr92lnte/wxTs5H6iWOQNtsXvYAkf8jiuKRoDTQNOHz+bM2nts7M+G4inCRi1wHHYjxSf2pJkuWena5HIT3miTKJiZbQRZdczVC/FrmVKjxYbpq/a8j6Sxknu9+EhlhGX9wR4VLkJnEjePLKELL8i6svYt2Hg62420GqwVtGXzypnKmbR2LLuQto+iSS598D2kETCTpyGYFSOsZSi3kdDE02pQViD4u/Rab2RRqQ+buaZFAjqo299rU4zRLrTR6iesL4/HRo2pCfL21bp1ISewdhf3eD3jokfgCDImHcrlwt7scjqXNfmGgbSLjP/0wI8JO0PAhMx+pqIoSIfvnBBRkk+K5ZTaywXhFITrC0IHUPkyspKo2kt9M8JkGhkvZ7wuHTeUs5Jn0ATKbvCnV4qv8b7Zr6nSZnceKNDemVpjqFzic/jQAcLEzUey1ibgFhmHoJEVviXw/ku/rtryDAr2Fn1ZiagGwoMPtGSNMOA74J89dim8HFg1su2tdZwA3AWCcxAu/SnFgwf4rZxrv18vwKiV0RTQVMS/3wznYLMD9v5wNs/As/C8Y0QTSk/Bn/BfJ1DzVzhptTr7HyIZghIqvKGkeZk8hfpHoTmY6Njo53kSjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2610.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39830400003)(136003)(346002)(366004)(451199018)(186003)(26005)(52116002)(6512007)(6486002)(966005)(36756003)(31696002)(31686004)(6916009)(478600001)(2616005)(86362001)(66476007)(316002)(8676002)(66946007)(66556008)(6506007)(6666004)(53546011)(54906003)(83380400001)(4326008)(41300700001)(8936002)(5660300002)(44832011)(2906002)(38350700002)(38100700002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHNvTVFuNkJwYzlIZS9NcGhMRW5Hckg3R0tjL3NxQVRSeVNOaXNmcnN1bDJJ?=
 =?utf-8?B?OG1LUlhQdHdlZFMwRXdmSkZGWmFaUlo3WlpMeHluS2Nlbzd5TUY0VmQwNjZT?=
 =?utf-8?B?ZXk0enk1VUh1N2lPOFV3MDF2SHh5UlJJcncyc0ZqREtpWFFhU1ozUkJVQnRC?=
 =?utf-8?B?UlNNYm5nTmN6QlFIUnJkdXFsTFo4cXMvZTlWYkxSdjhyaVhJS0pHbWkxU0Nw?=
 =?utf-8?B?VnBTYkd6MDlPZGxEYm5ieFBlcGFCamxaaHJXUVZVa2hQMlRLMGlaeStYMEhC?=
 =?utf-8?B?bkp6amRyVnRURE4wMlZoZ2MxT3pDZzZFcUNmR0NHNzg3cFZUTkxuUGNiR2ZR?=
 =?utf-8?B?eTBSL2Rta1hUdVBIVmxHc1JHYW43dWxHQ0xKdzFSbDlySk5paXR2NlZQMmU1?=
 =?utf-8?B?L2FvUGdwMUsyd1BleHNjdVN1ZWJXOW95c2s0cXpWcDdjT2UzRVhqSVR5b25R?=
 =?utf-8?B?SVorU1hkOVdldnRuUGk3MlM5UWVVdE1OekppZDVvQ0RvSFNQTHlVOTVhcXJz?=
 =?utf-8?B?TXV3cmd1MzlRMGlTUWlKMU1taXJycFlVRlBWcUtqaTdEZ00xeWh5ZlZUUCtY?=
 =?utf-8?B?aThyOVhWcVFldllsTlpSTC9nUkxVcDRZY1E3WUd1T1pkU2U1cXhoOE9KL3ZM?=
 =?utf-8?B?dWY0VWt3c0FSNUc0QmdVM1RYc3F1OVFzVkY4d0FMck03NDFsOTJNZmtrTU1s?=
 =?utf-8?B?NXk3eWpUYi9wckNJQU5waHFLUG9YWnFZT0c1UkFuRi9sT0F4M0Myd29vRncz?=
 =?utf-8?B?dldOOWZhZ2lVampJZjkzNEdIODFFWGpFRXZyMldhWm9Celc5ZnY3d3M3UUVV?=
 =?utf-8?B?bkJ5UWtUcWVDMWgxMWZVdkppeDcwL0tYa2Q0ejNKanNOaVFXSWZKeDJTdExE?=
 =?utf-8?B?NzgvS1hPM25ERFdmV0Iyd0hwdkllbmFpZTg3enpjM0dCRUdpYlQveEVvTUxY?=
 =?utf-8?B?cHd0T1RmT09VVjI2ZkFFL21IaUdiSlBuUG0xQVpnQUZhYUlIbkFwdFdybEM4?=
 =?utf-8?B?M244MUREb1JqVS9ITGpHSWlzZXpqc3h0aEdheW92Y0d0dld6Qkw2aDRyRGF3?=
 =?utf-8?B?ZW5yV3NzWDVuUUFjaS9zYmpVZDRnemtRemFDelRoaWVrUFQwVzhXR2oxTE9J?=
 =?utf-8?B?QVdJL0hpWXRjNUN5ZDhhcjlYZFpDelZJR29hdTBZUFpxL0s1WmoyMFZBdDNH?=
 =?utf-8?B?VUpZRWVZdjF2aDhnNzVYM2w3eW0rVEdFaDZqaXArSUY1amFZS2F4T2ltNTha?=
 =?utf-8?B?ZklGdU9ubUR6YTVjbWNzdUhabWpXWDltRHZZVG9UNUlwTjZKS1ZQVVNCa00r?=
 =?utf-8?B?dm0vOXRhQTRmRlVhV3FBaUJhcnY2M3BHckVMTlpiVlhMSkxPTSsxSm5GR0J6?=
 =?utf-8?B?dUFGMjBHdnJuak5kbWVlVGt1Y2EwMDhUbDVIS2hkTENZQ1JYUWFjeTR0NVJr?=
 =?utf-8?B?UEtGNTZhY0Zjd2pqUnVHay9oVFZ2ZWRZSXJUWEcvUDFlVGI0ZjZLUkVZYklY?=
 =?utf-8?B?alFBWjVJbE5wUWN3elZvTFVENWdCbmJ1OFkrVHB1TDdOQURKSzdwUkxuUDBR?=
 =?utf-8?B?MUpSWm9UdyticUNpeUhoa2xYVjRsY3FKMjhaOFNNK21JcTlKS1lUdEwrTDI1?=
 =?utf-8?B?OFIyZ0pqRWFHQlA3d0l3Q2ZiS1VsRGk1VndiVGdDM1hxU1BYbVkwOW90M2dD?=
 =?utf-8?B?ZFhzK2xUZW91S3N3L3VUSzRpa0JqNE1LdWoreUQ0dTFndUp0a3FOUHhnQmR2?=
 =?utf-8?B?MDV0ay9SWkI3SXAvWVVTciswUFJMSU04RjFncXN1SllCeVpGSXV0YW5aUFBo?=
 =?utf-8?B?dGQ0bmQyVjUydlM2N1hPZ0tWN1V6SWFMTXlMU3BTOFd1ZmdhVzRRRVRJdDRU?=
 =?utf-8?B?ZkZpZHI1Q2JtVlNqeFYyZktCVWkzcEJXMzhTckZJY0VkYXloKzYyazdaUWFn?=
 =?utf-8?B?NFJoMXJMUXQwclNXSEEwV2gzVEVlQnMxOEFROE5xeTVjOGZ5a2g4TURvcHg4?=
 =?utf-8?B?T0lLOVBjR0Zzbm5DcWdWMFJzMlFhUU96N0dGNS81R2xLNCtZLzJta2Q3ZUsz?=
 =?utf-8?B?S2pWb3BBa2wzYkNLT3lOVDBvMUJwbFM1YXZEbHFoZm1rWHJkZ1cxOWZNMEh5?=
 =?utf-8?B?a1U5TVp4RG1scEFqQ1NscGJoVGhCZytHVlU3YWtNTmtJaFgvSVJkMytYcjM4?=
 =?utf-8?Q?T+qTOdzsz50wTgk4+Hf0Jes=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf2d972-f835-4d17-3fcd-08db140b939a
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2610.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 13:00:15.8487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTaHnkB0zyPG8059MaB5Sj721osXJAMty9mLTSAQM2CogQiKefIqsvRSM/cz5qJySIg4CctKc5ldD5NlTCEdWiGEQGi0+2eTrh60SfHM0U7ZgeLXXCoHY3olJWz/3JdV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8202
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/18/23 1:57 PM, Kees Cook wrote:
> The "cplen" result used by the memcpy() into struct rvt_swqe "wqe" may
> be sized to 80 for struct rvt_ud_wr (which is member "ud_wr", not "wr"
> which is only 40 bytes in size). Change the destination union member so
> the compiler can use the correct bounds check.
> 
> struct rvt_swqe {
>         union {
>                 struct ib_send_wr wr;   /* don't use wr.sg_list */
>                 struct rvt_ud_wr ud_wr;
> 		...
> 	};
> 	...
> };
> 
> Silences false positive memcpy() run-time warning:
> 
>   memcpy: detected field-spanning write (size 80) of single field "&wqe->wr" at drivers/infiniband/sw/rdmavt/qp.c:2043 (size 40)
> 
> Reported-by: Zhang Yi <yizhan@redhat.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216561
> Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/infiniband/sw/rdmavt/qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
> index 3acab569fbb9..3f707e1fa517 100644
> --- a/drivers/infiniband/sw/rdmavt/qp.c
> +++ b/drivers/infiniband/sw/rdmavt/qp.c
> @@ -2040,7 +2040,7 @@ static int rvt_post_one_wr(struct rvt_qp *qp,
>  	wqe = rvt_get_swqe_ptr(qp, qp->s_head);
>  
>  	/* cplen has length from above */
> -	memcpy(&wqe->wr, wr, cplen);
> +	memcpy(&wqe->ud_wr, wr, cplen);
>  
>  	wqe->length = 0;
>  	j = 0;

Thanks for the patch. We've been debating this issue internally since last week.
The problem I have is this makes it look like everything is a "UD" req when it
could be a different QP type. Maybe we just need a comment explaining.

-Denny
