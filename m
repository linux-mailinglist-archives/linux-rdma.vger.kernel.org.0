Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3597E59AE
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Nov 2023 16:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjKHPHr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Nov 2023 10:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjKHPHq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Nov 2023 10:07:46 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2093.outbound.protection.outlook.com [40.107.92.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1091BE6;
        Wed,  8 Nov 2023 07:07:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2NcY2DCUg6z+DsoGSNDG1zCh7eLZmpdFBjw7dycJMpHFJEUjLqYRjDT97WyZ9rfATjXEOiSxb8kyxMDKf1DN/8x2UZtGIEY9xoydq4vyA+BKNH+lI4xWSKHSSpm+8Z9aCZ9EmWFoV8rOGb5xtSTy+Hnqap/WCGlLnEnI1VXEkAsxQVejM4nNztNQOS/KhWtKd6koXxzVlLMdQ25eX+HNteQPZGJVgfmacArDKD7RFAoBOOmmiW5120TEWSM13I4c7R9iV3pm/jjr6/nzkSg7fEaRNeD7BLotJYswSrcIEoFmDMdLbD8lbrrwj4Ath4nnPKrDR80jjaa6h8p6Vu7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKg/TuilvdL3zAVF/QQ0UKD/lfEmWqe1bHmbim5knYs=;
 b=fNav/SzxYN1sP8j+DQzJ0xHUgRDz/s071thdmazP0kC0YtovR8cDsb9gZyCP2PsavXz7rmgoLXRu/lc0w95xE4kR07q5LzFQaAlYqVPLw9lxhZFiqvjV1KbekT/xT96Hk2/WtedQZ8gEignqWWWexjyzp5D+v2PiK5sxCubovB5GuDeSADvf04DPowuzf5lrje4vtFT16KzUjvmZJ1W9hDLTivon5H0UVyN2icQrKlTYcxGaWT2FBGRtUtJEkonKozbGy/qjDA4N1xuXaJFk0xuSqDzi86qDURZZ08hyPnGffh81NU0sQe+3/qc+n3QEiTs6ngxY3W+fomZBNyzqOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKg/TuilvdL3zAVF/QQ0UKD/lfEmWqe1bHmbim5knYs=;
 b=WIPrnTawi0/AVI56CVU1tGrNiOo7GOXzXLeTXljumjDEWc/OaSyA5ZEly+m0qoC89Rn9Vr1whMEgLrWbN7ZEQGU3tYSRbjFzRs+lmu1Uv+thRiPYQStLKQGvyBbwaSZndmIYEWlZqJVaW9dLwWyKyX7gMQzVr9RWK30PW/WciFcx7iorY4WX1huQaDMxkQk8q7LU1Okmxo2hxdACT32bvZQk/Pdeg2wz5oX+9xEFQyIJcs9L1kOYiSiWIkV403+Y3yJgPoAOrpPFsBxEl5L2pHUYjIW5Z5/ZjXNqTRaz+gYfQ3wXgVMCIVMQZCuUM08XRaJ9nspylYAqKCDOjN51oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4099.prod.exchangelabs.com (2603:10b6:208:42::12) by
 PH0PR01MB7427.prod.exchangelabs.com (2603:10b6:510:da::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.25; Wed, 8 Nov 2023 15:07:39 +0000
Received: from BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::4043:beba:dfd:c326]) by BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::4043:beba:dfd:c326%3]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 15:07:39 +0000
Message-ID: <3bae0086-6137-7c17-d544-22c2e55755de@cornelisnetworks.com>
Date:   Wed, 8 Nov 2023 10:07:37 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] drivers/infiniband: copy userspace arrays safely
Content-Language: en-US
To:     Philipp Stanner <pstanner@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
References: <20231102191308.52046-2-pstanner@redhat.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20231102191308.52046-2-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:208:e8::16) To BL0PR01MB4099.prod.exchangelabs.com
 (2603:10b6:208:42::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4099:EE_|PH0PR01MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a1e2ed-0190-4942-fef8-08dbe06c72b7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ylssm/7IjyaZQ0aMM+GijsH/iOlDfpG7UkDUlRoe8aUOPqGILtQ8AlliEm0z9/9eysMJICkeVbKS2sPoVtqE91eVMai8frOJgzfxwiDYeEeGWBsEpvodoTSW9kqYw2+V42nPO2iUbmm+/xcDScANzjZ8RyIcaIa46tD+Ka6GL+3BYWhQiEAf2ONvL6CYBhBSfph5z8CEHmMYMgikNL2+HJHPGJbmCr8PiibJ/OrscgmFZFwobyfg8x3BjghDZsr0T0Pu4ou2YPOfRCZUbA0cNqBbMyzTw/k6rTNjtr5olLcVM5rCiy4I92PQ+cPMJoYJyiBcC8nDcYi2DzvmpLj02hjGEOQdZXZktqrQft+h65cNSx3J4D/5nOpmt9XqFtt+4mglFWr+RoMV+9EmlnU7tvTjQpuBnzfyZ3V5Bcn0gYhOh5e52Yh0DEsFOLdbCu73h+tIIWNU6vBjjtJSKKzwirRyGcsAYbCjWmEz2Hep7EdbS1w5u1DskeLOiMjmcZV75ouzY9kP+EsOae2kbXmpxVkcQ+/EKxtlQNaesrINelhnM94I1/Z5i++qAKBDz3uyrXf2N4J/yiq5Rkn2dpDboKkkPesSm192ZVReVMjWWI7vrC6/RzBi+6Cp4Jk3QmPY9pF2Dg4s/+KXLxJXINee0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4099.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(376002)(136003)(396003)(346002)(366004)(451199024)(1800799009)(64100799003)(186009)(31686004)(52116002)(53546011)(38100700002)(6506007)(83380400001)(2616005)(6512007)(5660300002)(8676002)(86362001)(31696002)(4326008)(41300700001)(36756003)(8936002)(44832011)(316002)(2906002)(110136005)(66946007)(66476007)(38350700005)(66556008)(26005)(478600001)(6486002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkhxTC8rQyswMGloeHhuMFVQc2pKY1F0TllsMjl2dDUyMTJtMWRlQUxWTHhm?=
 =?utf-8?B?TGZSUXkrNGZOZWp3WXlub0NsUTlsVGJnOUJMTklhZmRxMUhIcGtZU2RINDdm?=
 =?utf-8?B?d0xrSkowRklXbzBsaWtaa0tiSzgyM2hIQjBtZnFJTk5RVU43d1AzNndNcmhZ?=
 =?utf-8?B?WFpYK0xSVmRVM1RLNXRwWDEvNSs0M1FHSFY0d3V0ci9zVm5td0NTYktoWEVE?=
 =?utf-8?B?bHQzQ0tGUUVXSkVHSVpNN0FsbmZaMk4xN3hiSXVOY25odTNlZExnTk9kTE54?=
 =?utf-8?B?WEUyTjZobHFnVzBrZHRqbVVkUDJsOHl4b3k0WitpY0x5S2MrbXMwdlpMdjBH?=
 =?utf-8?B?V0FseU9mNUFFejZ0ZHg2UmpqQ0NqTis3aXM1WTdCUWkvZWY4ZFEwb3V6WjRX?=
 =?utf-8?B?bFo5RFc4VHNaT21keGk2OEhTak1Kb0tkYVkyKzdaNFRib0cvYUIzQThGYWsz?=
 =?utf-8?B?dUgyL1J0VFkzZDE2MjN2a3NrQVB3SkFrMmZCTGpzU0lUK3QwV1lLNnNuVU9t?=
 =?utf-8?B?MFZTZG1hbERLU1lOK3M0TkZLNlRMNEN0K1VzdzhHRTZFblF4UE0vSWRCbTR6?=
 =?utf-8?B?RlBNRStWUXh6RzJQRGowMTdQYUJoMmxWVlQrczgxeTdBOFY4YURKZWxwSURN?=
 =?utf-8?B?elA0ay82cmVyV2d3eTRCaHdxak9UclVmQVQ5d3ZUejRLL3ZIa2FkN2Nzdy9k?=
 =?utf-8?B?c0NkZlIzb1crSjZJdk43c0JpaVErUi9zcVZkVEJRbkVURVQ4YUlCYVc0L3M5?=
 =?utf-8?B?L2dkbXE4bWh4STcyRnFqUTNPT29hNnFFbXNaSmprR1hvRmd1MCtNVG80cUVG?=
 =?utf-8?B?MGQwenQyWlpIQzRpQi9vSUNjS29hZlc1bmcvZkJiT0JyZE5xN0FVRGdQZ2Fj?=
 =?utf-8?B?QTk2OFJxeUdtaU9PU1EzRjVsQU1wbWczK0dYd3YzWEZyWk5uZE5SY0owWXM2?=
 =?utf-8?B?U2NIeUhLZSt3ZHZseGd6Y2xuKysvTlRweW1iVVUwby9KSGVIWWh5SDNFOG1x?=
 =?utf-8?B?OVJBQ05uT1huRDdBQ2tGcDAxOEQ4Szl4ZlpaNFVtTERnUm9jMlBmWEtuUmdU?=
 =?utf-8?B?Qk44R0hCeWk2S3V2WmlJZ1JDOGlFekoyQTZJT2NwNGtLaGVBSGR2eDZpN1lG?=
 =?utf-8?B?c1FyVHFzYm1vTHR5TkZDYUZBZ3ViOEZ6ek44K01lQ0RLOWpNU1J2Skw4aUI1?=
 =?utf-8?B?dUk3K1IxZEpMQlE1cTZySXNLVW01NkN4YVNZV3AzdTNXeVFEQ1Z5ZEcwMUNR?=
 =?utf-8?B?LzNGVE5FdFgvOG1hNEpSYTgrQVp3R2dmYnlaeFZyMDV3anZoSlJSMTVkQXNn?=
 =?utf-8?B?anBVN2pvVGdsWS9JakNjQmdvVEtlTHRsVW5NYVhTZWpzU0dyUHNNRll0NkFh?=
 =?utf-8?B?ZUh1STNXNnEvcDlIZTdPRW5nSWVlKzJhcHV0RXAxZ2J0Z3JzYlZHdGJpcWI2?=
 =?utf-8?B?OWpOVnV5eHpXSUdqOE40WEJGSjltR3I1TFRjd0wwNjJZRVgrQVFQWlZ0UEZH?=
 =?utf-8?B?dDF1WnM5TlZ6NzBTUnpWNGNtbithNkkwbTZrbGV6YkgxQjZHSy93aWZyUi93?=
 =?utf-8?B?YmVWYWpWTzl0ak41RzNFdEVsb2drZ2NYV3RCdVdQMFpndHJSaGUvSXJ4VGZ6?=
 =?utf-8?B?TzBZTGZhYVhXb2ZBVVpTWS9kSHZ4UmhXcWpXOXVIbkVpcUZsL0JXaHFNK2l1?=
 =?utf-8?B?Qkwxc1VmWGtmb2cwUzcyVW02eGt6SWQ5Z05XNU9Xb0hSaWF2QWx5bW5MNXpl?=
 =?utf-8?B?UHF2UGo2b2YrR2tIYXE1aE43WkZpWGVsbE9ZLzlYZFR0L0JsNHVHanlyNUoz?=
 =?utf-8?B?bkJJN1M3b0VtNWZxemxQMTlHOGdQWWM3NU16Q0dpSWxad1I5RGJxaTFmc0ox?=
 =?utf-8?B?S3lTNmZWMkNFUEpGaExwcTJWMmdpYklDdjVDVDYrUGE1dEhSemJGaGVvWFlB?=
 =?utf-8?B?OUc1Wm9DalNpOGwyeCtYVWFpcVVoeFpKb0EzRkZ4UmtLNEY0K2w3VWZGVXJE?=
 =?utf-8?B?NUVOaFpDQ2xPQjY3TFdPT1RCWm9OVzIyQkNBMHhxd0pCaGM2WWJ3ZEdrVVpp?=
 =?utf-8?B?bm9DdEgvQk9ST2RHWVl4MXAwQnVRL20rZGxYWE9Wa2R4VTB2WVp0bytTampt?=
 =?utf-8?B?UVBINTJGdDR4RWQ3QnA5cm9YdGx1U01IemZQVjhGNnRBekk3Vkh1c1k0N0x2?=
 =?utf-8?Q?VrSoOoBThaB0Cij5cWp+we0=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a1e2ed-0190-4942-fef8-08dbe06c72b7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4099.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 15:07:39.2228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuoiZTylsq1Ia7QOEw7KpmvIG6wAURcMpkrDoC0kK0ltqv6VZAQ3BqPQWMLumXNkLrZz6TJ1MJfgEf6uqeKLTuE100WRDdBd9oA2L42fxfowDbVMhUKQdoBBevPo5oFX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7427
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/2/23 3:13 PM, Philipp Stanner wrote:
> Currently, memdup_user() is utilized at two positions to copy userspace
> arrays. This is done without overflow checks.
> 
> Use the new wrapper memdup_array_user() to copy the arrays more safely.
> 
> Suggested-by: Dave Airlie <airlied@redhat.com>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>  drivers/infiniband/hw/hfi1/user_exp_rcv.c | 4 ++--
>  drivers/infiniband/hw/hfi1/user_sdma.c    | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
> index 96058baf36ed..53a623892d9d 100644
> --- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
> +++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
> @@ -491,8 +491,8 @@ int hfi1_user_exp_rcv_clear(struct hfi1_filedata *fd,
>  	if (unlikely(tinfo->tidcnt > fd->tid_used))
>  		return -EINVAL;
>  
> -	tidinfo = memdup_user(u64_to_user_ptr(tinfo->tidlist),
> -			      sizeof(tidinfo[0]) * tinfo->tidcnt);
> +	tidinfo = memdup_array_user(u64_to_user_ptr(tinfo->tidlist),
> +				    tinfo->tidcnt, sizeof(tidinfo[0]));
>  	if (IS_ERR(tidinfo))
>  		return PTR_ERR(tidinfo);
>  
> diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
> index 29ae7beb9b03..f7fa8e699a78 100644
> --- a/drivers/infiniband/hw/hfi1/user_sdma.c
> +++ b/drivers/infiniband/hw/hfi1/user_sdma.c
> @@ -494,8 +494,8 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
>  		 * equal to the pkt count. However, there is no way to
>  		 * tell at this point.
>  		 */
> -		tmp = memdup_user(iovec[idx].iov_base,
> -				  ntids * sizeof(*req->tids));
> +		tmp = memdup_array_user(iovec[idx].iov_base,
> +					ntids, sizeof(*req->tids));
>  		if (IS_ERR(tmp)) {
>  			ret = PTR_ERR(tmp);
>  			SDMA_DBG(req, "Failed to copy %d TIDs (%d)",

Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
