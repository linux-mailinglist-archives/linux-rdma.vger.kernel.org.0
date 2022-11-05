Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82B461DAF1
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Nov 2022 15:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiKEO2P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 5 Nov 2022 10:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKEO2O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 5 Nov 2022 10:28:14 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94214E1C
        for <linux-rdma@vger.kernel.org>; Sat,  5 Nov 2022 07:28:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ettj5JmT0DB9fUHga2ZKr4hVVjYS5y0Po25e65KMZWPI5blmHdQppIZ4n92k9hVGoQLB/l24LRT9K2O6OYIhbqdA7VrtsTOXbrq5tpefqdXR1BAAZ6KNxvn+YI5zshzApWaXdi88kQmmm65Xo25pYZsfLTWxTq7MyfSDTE8GGBM8Pn1X1RBMBkSPJRjWqPXXow9PbDd1nQK8FKxOHvSeNClKp4gV7PPJ5tApufpJr8cgfuZD4YmxYsozkOQ2VKUyx8vU6KPYptc3v7M75WL/UKdEVkLeYFWsmXCF3zs2iO57FqXRevEzwCAOVc3ivK9tBcUjQ1mV3REOsWFluyIKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7on1DZRjEIbz4iI2kCm3YdQZvrUyRH2rCCvEp3fGWU=;
 b=iTAJfNuU1uOmUJoY58HNr7E+PDcr2+fUpvDNVFtq1FhUpJQfAX5q8JXQ6qSXyZVN4nQ3DsD+RB5Azu7AH9OkgjS6OtdAMYBsPq+CGjYPsHQP5CK1RcjztHfrVziDZ/TNrjwaha9gZ9c4ejxMC2eizykBZi9xvptr0PPw7Derkuz4hm+uB2lwPr/zdl6e0frcM0nK0Id+l2Q2bE52Z1JCZvCbTyu3mgK4D99JCQ+5Sp8dLtyiqSOEY4zyGINQm9pqUZQjVZeHJHThO5sJEslO68MWWLiidjE5XMutsBMynjXn0RpebRokan1JbQp4TpLNIE6s+hgo/15GLX1DPEhcIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from BYAPR01MB4438.prod.exchangelabs.com (2603:10b6:a03:98::12) by
 MN2PR01MB5901.prod.exchangelabs.com (2603:10b6:208:192::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.24; Sat, 5 Nov 2022 14:28:07 +0000
Received: from BYAPR01MB4438.prod.exchangelabs.com
 ([fe80::6a65:3541:48b7:caf8]) by BYAPR01MB4438.prod.exchangelabs.com
 ([fe80::6a65:3541:48b7:caf8%3]) with mapi id 15.20.5791.022; Sat, 5 Nov 2022
 14:28:07 +0000
Message-ID: <2f51ffa2-9c9a-91a6-ac8b-dfcaa132881e@talpey.com>
Date:   Sat, 5 Nov 2022 10:28:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH for-next 1/3] RDMA/irdma: Fix inline for multiple SGE's
Content-Language: en-US
To:     Shiraz Saleem <shiraz.saleem@intel.com>, jgg@nvidia.com,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>
References: <20221104234749.1084-1-shiraz.saleem@intel.com>
 <20221104234749.1084-2-shiraz.saleem@intel.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20221104234749.1084-2-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0297.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::32) To BYAPR01MB4438.prod.exchangelabs.com
 (2603:10b6:a03:98::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB4438:EE_|MN2PR01MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f3058b-92d4-419d-54ac-08dabf39f524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5KGoVKaqKT7sjYRr0RPQnBMQdVcMd5nqPXmIcKuxZeVslbBugsIFgp+J8h4fNtkjj8Qr51KPUPjyvlAFWnhtsCW2Vszol0K5P7q0q7tO9YFndheG7Ex/VKK2501n2YChsKadyPpPkP3DhpytHpsDREm9xPdMEwSaZsTRvqNHcqppNRY4Xw9xjohV7f+F8JYIGpjVnmcewXjO2DfdUlwdZCHroxYaqcZOHF96ND/e0y8hW8skCKlNHvubz3Po9s70AZ/sxJ6NN2XeIihGdPZiKcva/ochPPRMKuI3pZnfho+CpcJXR7UMagp0aUHdl71azvixpBunNxZWswY2YvCnjcSndXMb0XTuh5M1GSkeUsrCNtobmYyZIvg0Oeh65g7yvf7xMTBdWVT1EMIlo8+Pm34XHHlMhXT4GbvYdSB1A5uDwtg5l7GaTPMVpOL0OXY+50Kjwkc4WpN/VX20N8tt299fjnC8Yh8r9VPyc/zeclNbjjfC8R9ZhDMHH5wUAaU2N1NduVMM2lTpB9uNKAV0jt0FDra4HxqZCORlUP7vcFPnUoJnhn+34U869UEmsTqlPmxJTMu3L4QVCnEsEtGYP3bmQZ8jqhJenlGeTigCPChlZFBZ6mKIliJtF9BaxIMY1Vk7dK4Oseb1yyilnf0ZrBiJ8gQRU1s97kHVy/HBCgLjv7l+jvEuzMRs1aZinDcQPnOHlNt66xA4Vjc8jlanezZWeBfC+N2d7Qv5CcEADfhRix8dYodM9dLWMIWtJfsnU2BkeGGYL1uV7lPePkD9UzJvKKNTdaI17i/asMWd78Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4438.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39830400003)(366004)(376002)(396003)(451199015)(30864003)(31686004)(186003)(2906002)(8936002)(6486002)(83380400001)(5660300002)(478600001)(2616005)(26005)(41300700001)(86362001)(31696002)(6512007)(38350700002)(38100700002)(36756003)(8676002)(4326008)(66476007)(66556008)(66946007)(316002)(53546011)(52116002)(6506007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUg3cjZiK0xDOE5HS2dRRlBpdlBXQmorU1VkL3UzUTR4T0ZOb1pxZ3BsWVV5?=
 =?utf-8?B?NXhmV2prTjNwcTVWdllnYzd5Q3l5WEFNTXErcU1lc1grckFwVjRaWlBFMy84?=
 =?utf-8?B?UEhPbDFYNVVCZWptMm9SZm1WYlc0YXNIeE1KOGpRWUFIWWt4bVZEQURXYUxX?=
 =?utf-8?B?UEp3cDFYeHhNeHArYnhoMjFSb0E4QjhCZzRWYy9yMjFSNFVWUHdvSGErSG5K?=
 =?utf-8?B?S3JacHE3NXR1Z1YrbnpHcVFyTG1WUXlXWnZIbnMvTUxWY0FZMnFVUjVQem5C?=
 =?utf-8?B?VDZqdTk5dkR6NENxbEZVZVovUnIrQldwVldvQXc0SUJsOFhQc21jeS80L21r?=
 =?utf-8?B?dU5tVm9wRlJ2Lzc0WGpNSWtESER2ZEd2TkZwdDlUVWlLcDR3ZTFlM2JFdDFJ?=
 =?utf-8?B?elRFcHY2eHpLcjhkeHlYdVRTOWVHZUVBc2hndXBiUnAzUmc1ZTFJb2hVL1F2?=
 =?utf-8?B?SjZHcGhoLzhyaTJCNlBGSEVuVGxyVGYyemtFaEMvdThqQlN2dkIvVi9Zc1FZ?=
 =?utf-8?B?SXRYZUxONytqMSt0UE5UZWEreGRzNWt6bm1qeGVEbHBNc1hKb3JURmN2R1pQ?=
 =?utf-8?B?eFNVT1F1VzBSdThRMEVHWnVBaEJZZVBidWozQzRWSmhYQkUrR1M3Ri9MbjZX?=
 =?utf-8?B?MVJlN1I2eDYwMTZGaVVGclJRNHpoblljNHFDci9QcFlFUk5BQmxMNnpsaXFo?=
 =?utf-8?B?eEtQeWVtRUdlNjRocXRrYmJQWlFpd2o5MmVoVDl6aVMyRkhnSSt5ZnQwVUF1?=
 =?utf-8?B?aXdwNUJIQi9RSGE1dkgzMi9lNmg0RTZNaWF1NU5WQnUvNTg5VkVBb0ozNEk3?=
 =?utf-8?B?ZUE4ZVEyYjBTYXM3ZXoyNzNRd1JRUUdLRHl5TUl1Vm84QlpWbTE0WEhJa212?=
 =?utf-8?B?WVZ0WUliWTNjSFk2RGpKcXE5dTFXanEwVFIrclZKTFIwN2ZaMzQydWdvUkE1?=
 =?utf-8?B?MStNNEYwRlJnQzhoL0VTdG5xQ2x5OCtRYlRPVDJlNkR3UnNIN2hlZlhJZFBs?=
 =?utf-8?B?V3N1RkFJQnZYNUR4Mzg5Yy8yMVV0VWo3L0Z6NFBBcjgrYlJwd3B3a2RRc3R5?=
 =?utf-8?B?Wjk4aUt4OTRwc1YvWVRsV2c4MitOUlpabDhGQVNROU5vVXZnek5TTzlxTktC?=
 =?utf-8?B?QTRQY0NNdzM5TjNDNXhXTHJLMW5hVmRjN01WdFoyeGFHVmhONkJXUmlIWDZv?=
 =?utf-8?B?YWp3K2svRkk1NWorNHpTVDhqVEZ0RkhvRUcvdXNmVnNtTFJ4MTRBR3lTSE5B?=
 =?utf-8?B?bXZCeVBjdHJDRDdiME9UOHNVK3o3dkdQWXZ5QzhWTGprb00xam9IbFJqQWw0?=
 =?utf-8?B?dy9temY5di8zN1hSdVl0L1BpK01WYk9lYXVncmF5ZHRiMXZQa2xuNTBmN25w?=
 =?utf-8?B?a01vY2JLTnZvY1ZOOU1FWlkxV1pzc01hek9aS2FzeGswbkppQmdoUjl0Ri80?=
 =?utf-8?B?d3BrNWVxVzBYZE5haHpMQjRSKzhEMXFuM1RleFM2Szk1ek5tNFhOdUw2ZkVl?=
 =?utf-8?B?V2lKbmZPSjFRUXVYOEdoWTFiVnUvenArVXIvdW5OWEE1b09iekJXS1F4bzRV?=
 =?utf-8?B?Q3ZnYjB1RkZVckh1UTZWb0NoK3FLWTNYM2I4RldZZlYrY0lQZW1LWExHeWpn?=
 =?utf-8?B?V052d3N0ODlMN2VJaW90aWttQVIydlNMdWw4QzEzaUlYSllieloycUdKQXVp?=
 =?utf-8?B?K05TYzNRbXV1NU0zWWlEODVScHVSQWo5RnhZcUZNUCtTTWYxaEFYUklzaGpO?=
 =?utf-8?B?NUExczk4anBIbU5TcFB0a1MvLzRlUjV3R3pkdHZWK3hGR0thKzJkeXVFQTJu?=
 =?utf-8?B?a0QvcHZFSTFBRnM1TUpnaHcvOTRxL1o1M1NxYklEQ3IwVElCZUdleWQ1STBs?=
 =?utf-8?B?Y2pUUkRTSXJXZTBtZTRjcVpFVjR1TENvcno5OXRRZnBoY2x3cnpPbUxXUUk3?=
 =?utf-8?B?c0pWcitCK3VLUnJScUdxUFZsN0gxemVERGs0S2hJWk4zK3JnL2FDV045MXUv?=
 =?utf-8?B?RzNBaFYxaDlxR2M4SWkvZlpQWWN6TWptRDR3YU54aGFXTW9vYmlpaUtUK1pp?=
 =?utf-8?B?Zk11bUVKd0plVnl2a2hMUG9IQWx6VklCMmJXdW5vTnpCMzAxNFc3MndwcFNT?=
 =?utf-8?Q?c4CQ=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f3058b-92d4-419d-54ac-08dabf39f524
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB4438.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2022 14:28:07.4905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5xU9CdEDgty20R3aX1eU5gybXLzzRQ6KpXtxa4+1GXdB/ZxeACctg0F6HyVGrS4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR01MB5901
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/4/2022 7:47 PM, Shiraz Saleem wrote:
> From: Mustafa Ismail <mustafa.ismail@intel.com>
> 
> Currently, inline send and inline write assume a single
> SGE and only copy data from the first one. Add support
> for multiple SGE's.
> 
> Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>   drivers/infiniband/hw/irdma/uk.c    | 148 +++++++++++++++++++++++-------------
>   drivers/infiniband/hw/irdma/user.h  |  18 +----
>   drivers/infiniband/hw/irdma/verbs.c |  54 +++++--------
>   3 files changed, 115 insertions(+), 105 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
> index a6e5d35..4424224 100644
> --- a/drivers/infiniband/hw/irdma/uk.c
> +++ b/drivers/infiniband/hw/irdma/uk.c
> @@ -566,21 +566,36 @@ static void irdma_set_mw_bind_wqe_gen_1(__le64 *wqe,
>   
>   /**
>    * irdma_copy_inline_data_gen_1 - Copy inline data to wqe
> - * @dest: pointer to wqe
> - * @src: pointer to inline data
> - * @len: length of inline data to copy
> + * @wqe: pointer to wqe
> + * @sge_list: table of pointers to inline data
> + * @num_sges: Total inline data length
>    * @polarity: compatibility parameter
>    */
> -static void irdma_copy_inline_data_gen_1(u8 *dest, u8 *src, u32 len,
> -					 u8 polarity)
> +static void irdma_copy_inline_data_gen_1(u8 *wqe, struct ib_sge *sge_list,
> +					 u32 num_sges, u8 polarity)
>   {
> -	if (len <= 16) {
> -		memcpy(dest, src, len);
> -	} else {
> -		memcpy(dest, src, 16);
> -		src += 16;
> -		dest = dest + 32;
> -		memcpy(dest, src, len - 16);
> +	u32 quanta_bytes_remaining = 16;
> +	int i;
> +
> +	for (i = 0; i < num_sges; i++) {

We've been bitten by low provider sge limits in fs/cifs/smbdirect.c,
so we now request only a handful. Looks like this will improve that
for irdma.

But I am a little surprised to see no bounds checking on num_sges or
total bytes here, or in irdma_post_send(). So it seems that a malicious
or buggy consumer can cause significant damage. Is that protected
elsewhere?

Tom.

> +		u8 *cur_sge = (u8 *)(uintptr_t)sge_list[i].addr;
> +
> +		while (sge_list[i].length) {
> +			u32 bytes_copied;
> +
> +			bytes_copied = min(sge_list[i].length, quanta_bytes_remaining);
> +			memcpy(wqe, cur_sge, bytes_copied);
> +			wqe += bytes_copied;
> +			cur_sge += bytes_copied;
> +			quanta_bytes_remaining -= bytes_copied;
> +			sge_list[i].length -= bytes_copied;
> +
> +			if (!quanta_bytes_remaining) {
> +				/* Remaining inline bytes reside after the hdr */
> +				wqe += 16;
> +				quanta_bytes_remaining = 32;
> +			}
> +		}
>   	}
>   }
>   
> @@ -612,35 +627,50 @@ static void irdma_set_mw_bind_wqe(__le64 *wqe,
>   
>   /**
>    * irdma_copy_inline_data - Copy inline data to wqe
> - * @dest: pointer to wqe
> - * @src: pointer to inline data
> - * @len: length of inline data to copy
> + * @wqe: pointer to wqe
> + * @sge_list: table of pointers to inline data
> + * @num_sges: number of SGE's
>    * @polarity: polarity of wqe valid bit
>    */
> -static void irdma_copy_inline_data(u8 *dest, u8 *src, u32 len, u8 polarity)
> +static void irdma_copy_inline_data(u8 *wqe, struct ib_sge *sge_list, u32 num_sges,
> +				   u8 polarity)
>   {
>   	u8 inline_valid = polarity << IRDMA_INLINE_VALID_S;
> -	u32 copy_size;
> -
> -	dest += 8;
> -	if (len <= 8) {
> -		memcpy(dest, src, len);
> -		return;
> -	}
> -
> -	*((u64 *)dest) = *((u64 *)src);
> -	len -= 8;
> -	src += 8;
> -	dest += 24; /* point to additional 32 byte quanta */
> -
> -	while (len) {
> -		copy_size = len < 31 ? len : 31;
> -		memcpy(dest, src, copy_size);
> -		*(dest + 31) = inline_valid;
> -		len -= copy_size;
> -		dest += 32;
> -		src += copy_size;
> +	u32 quanta_bytes_remaining = 8;
> +	bool first_quanta = true;
> +	int i;
> +
> +	wqe += 8;
> +
> +	for (i = 0; i < num_sges; i++) {
> +		u8 *cur_sge = (u8 *)(uintptr_t)sge_list[i].addr;
> +
> +		while (sge_list[i].length) {
> +			u32 bytes_copied;
> +
> +			bytes_copied = min(sge_list[i].length, quanta_bytes_remaining);
> +			memcpy(wqe, cur_sge, bytes_copied);
> +			wqe += bytes_copied;
> +			cur_sge += bytes_copied;
> +			quanta_bytes_remaining -= bytes_copied;
> +			sge_list[i].length -= bytes_copied;
> +
> +			if (!quanta_bytes_remaining) {
> +				quanta_bytes_remaining = 31;
> +
> +				/* Remaining inline bytes reside after the hdr */
> +				if (first_quanta) {
> +					first_quanta = false;
> +					wqe += 16;
> +				} else {
> +					*wqe = inline_valid;
> +					wqe++;
> +				}
> +			}
> +		}
>   	}
> +	if (!first_quanta && quanta_bytes_remaining < 31)
> +		*(wqe + quanta_bytes_remaining) = inline_valid;
>   }
>   
>   /**
> @@ -679,20 +709,27 @@ int irdma_uk_inline_rdma_write(struct irdma_qp_uk *qp,
>   			       struct irdma_post_sq_info *info, bool post_sq)
>   {
>   	__le64 *wqe;
> -	struct irdma_inline_rdma_write *op_info;
> +	struct irdma_rdma_write *op_info;
>   	u64 hdr = 0;
>   	u32 wqe_idx;
>   	bool read_fence = false;
> +	u32 i, total_size = 0;
>   	u16 quanta;
>   
>   	info->push_wqe = qp->push_db ? true : false;
> -	op_info = &info->op.inline_rdma_write;
> +	op_info = &info->op.rdma_write;
>   
> -	if (op_info->len > qp->max_inline_data)
> +	if (unlikely(qp->max_sq_frag_cnt < op_info->num_lo_sges))
>   		return -EINVAL;
>   
> -	quanta = qp->wqe_ops.iw_inline_data_size_to_quanta(op_info->len);
> -	wqe = irdma_qp_get_next_send_wqe(qp, &wqe_idx, quanta, op_info->len,
> +	for (i = 0; i < op_info->num_lo_sges; i++)
> +		total_size += op_info->lo_sg_list[i].length;
> +
> +	if (unlikely(total_size > qp->max_inline_data))
> +		return -EINVAL;
> +
> +	quanta = qp->wqe_ops.iw_inline_data_size_to_quanta(total_size);
> +	wqe = irdma_qp_get_next_send_wqe(qp, &wqe_idx, quanta, total_size,
>   					 info);
>   	if (!wqe)
>   		return -ENOMEM;
> @@ -705,7 +742,7 @@ int irdma_uk_inline_rdma_write(struct irdma_qp_uk *qp,
>   
>   	hdr = FIELD_PREP(IRDMAQPSQ_REMSTAG, op_info->rem_addr.lkey) |
>   	      FIELD_PREP(IRDMAQPSQ_OPCODE, info->op_type) |
> -	      FIELD_PREP(IRDMAQPSQ_INLINEDATALEN, op_info->len) |
> +	      FIELD_PREP(IRDMAQPSQ_INLINEDATALEN, total_size) |
>   	      FIELD_PREP(IRDMAQPSQ_REPORTRTT, info->report_rtt ? 1 : 0) |
>   	      FIELD_PREP(IRDMAQPSQ_INLINEDATAFLAG, 1) |
>   	      FIELD_PREP(IRDMAQPSQ_IMMDATAFLAG, info->imm_data_valid ? 1 : 0) |
> @@ -719,8 +756,8 @@ int irdma_uk_inline_rdma_write(struct irdma_qp_uk *qp,
>   		set_64bit_val(wqe, 0,
>   			      FIELD_PREP(IRDMAQPSQ_IMMDATA, info->imm_data));
>   
> -	qp->wqe_ops.iw_copy_inline_data((u8 *)wqe, op_info->data, op_info->len,
> -					qp->swqe_polarity);
> +	qp->wqe_ops.iw_copy_inline_data((u8 *)wqe, op_info->lo_sg_list,
> +					op_info->num_lo_sges, qp->swqe_polarity);
>   	dma_wmb(); /* make sure WQE is populated before valid bit is set */
>   
>   	set_64bit_val(wqe, 24, hdr);
> @@ -745,20 +782,27 @@ int irdma_uk_inline_send(struct irdma_qp_uk *qp,
>   			 struct irdma_post_sq_info *info, bool post_sq)
>   {
>   	__le64 *wqe;
> -	struct irdma_post_inline_send *op_info;
> +	struct irdma_post_send *op_info;
>   	u64 hdr;
>   	u32 wqe_idx;
>   	bool read_fence = false;
> +	u32 i, total_size = 0;
>   	u16 quanta;
>   
>   	info->push_wqe = qp->push_db ? true : false;
> -	op_info = &info->op.inline_send;
> +	op_info = &info->op.send;
>   
> -	if (op_info->len > qp->max_inline_data)
> +	if (unlikely(qp->max_sq_frag_cnt < op_info->num_sges))
>   		return -EINVAL;
>   
> -	quanta = qp->wqe_ops.iw_inline_data_size_to_quanta(op_info->len);
> -	wqe = irdma_qp_get_next_send_wqe(qp, &wqe_idx, quanta, op_info->len,
> +	for (i = 0; i < op_info->num_sges; i++)
> +		total_size += op_info->sg_list[i].length;
> +
> +	if (unlikely(total_size > qp->max_inline_data))
> +		return -EINVAL;
> +
> +	quanta = qp->wqe_ops.iw_inline_data_size_to_quanta(total_size);
> +	wqe = irdma_qp_get_next_send_wqe(qp, &wqe_idx, quanta, total_size,
>   					 info);
>   	if (!wqe)
>   		return -ENOMEM;
> @@ -773,7 +817,7 @@ int irdma_uk_inline_send(struct irdma_qp_uk *qp,
>   	hdr = FIELD_PREP(IRDMAQPSQ_REMSTAG, info->stag_to_inv) |
>   	      FIELD_PREP(IRDMAQPSQ_AHID, op_info->ah_id) |
>   	      FIELD_PREP(IRDMAQPSQ_OPCODE, info->op_type) |
> -	      FIELD_PREP(IRDMAQPSQ_INLINEDATALEN, op_info->len) |
> +	      FIELD_PREP(IRDMAQPSQ_INLINEDATALEN, total_size) |
>   	      FIELD_PREP(IRDMAQPSQ_IMMDATAFLAG,
>   			 (info->imm_data_valid ? 1 : 0)) |
>   	      FIELD_PREP(IRDMAQPSQ_REPORTRTT, (info->report_rtt ? 1 : 0)) |
> @@ -789,8 +833,8 @@ int irdma_uk_inline_send(struct irdma_qp_uk *qp,
>   	if (info->imm_data_valid)
>   		set_64bit_val(wqe, 0,
>   			      FIELD_PREP(IRDMAQPSQ_IMMDATA, info->imm_data));
> -	qp->wqe_ops.iw_copy_inline_data((u8 *)wqe, op_info->data, op_info->len,
> -					qp->swqe_polarity);
> +	qp->wqe_ops.iw_copy_inline_data((u8 *)wqe, op_info->sg_list,
> +					op_info->num_sges, qp->swqe_polarity);
>   
>   	dma_wmb(); /* make sure WQE is populated before valid bit is set */
>   
> diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/irdma/user.h
> index 2ef6192..f5d3a7c 100644
> --- a/drivers/infiniband/hw/irdma/user.h
> +++ b/drivers/infiniband/hw/irdma/user.h
> @@ -173,14 +173,6 @@ struct irdma_post_send {
>   	u32 ah_id;
>   };
>   
> -struct irdma_post_inline_send {
> -	void *data;
> -	u32 len;
> -	u32 qkey;
> -	u32 dest_qp;
> -	u32 ah_id;
> -};
> -
>   struct irdma_post_rq_info {
>   	u64 wr_id;
>   	struct ib_sge *sg_list;
> @@ -193,12 +185,6 @@ struct irdma_rdma_write {
>   	struct ib_sge rem_addr;
>   };
>   
> -struct irdma_inline_rdma_write {
> -	void *data;
> -	u32 len;
> -	struct ib_sge rem_addr;
> -};
> -
>   struct irdma_rdma_read {
>   	struct ib_sge *lo_sg_list;
>   	u32 num_lo_sges;
> @@ -241,8 +227,6 @@ struct irdma_post_sq_info {
>   		struct irdma_rdma_read rdma_read;
>   		struct irdma_bind_window bind_window;
>   		struct irdma_inv_local_stag inv_local_stag;
> -		struct irdma_inline_rdma_write inline_rdma_write;
> -		struct irdma_post_inline_send inline_send;
>   	} op;
>   };
>   
> @@ -291,7 +275,7 @@ int irdma_uk_stag_local_invalidate(struct irdma_qp_uk *qp,
>   				   bool post_sq);
>   
>   struct irdma_wqe_uk_ops {
> -	void (*iw_copy_inline_data)(u8 *dest, u8 *src, u32 len, u8 polarity);
> +	void (*iw_copy_inline_data)(u8 *dest, struct ib_sge *sge_list, u32 num_sges, u8 polarity);
>   	u16 (*iw_inline_data_size_to_quanta)(u32 data_size);
>   	void (*iw_set_fragment)(__le64 *wqe, u32 offset, struct ib_sge *sge,
>   				u8 valid);
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index a22afbb..b2006a0 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -3165,30 +3165,20 @@ static int irdma_post_send(struct ib_qp *ibqp,
>   				info.stag_to_inv = ib_wr->ex.invalidate_rkey;
>   			}
>   
> -			if (ib_wr->send_flags & IB_SEND_INLINE) {
> -				info.op.inline_send.data = (void *)(unsigned long)
> -							   ib_wr->sg_list[0].addr;
> -				info.op.inline_send.len = ib_wr->sg_list[0].length;
> -				if (iwqp->ibqp.qp_type == IB_QPT_UD ||
> -				    iwqp->ibqp.qp_type == IB_QPT_GSI) {
> -					ah = to_iwah(ud_wr(ib_wr)->ah);
> -					info.op.inline_send.ah_id = ah->sc_ah.ah_info.ah_idx;
> -					info.op.inline_send.qkey = ud_wr(ib_wr)->remote_qkey;
> -					info.op.inline_send.dest_qp = ud_wr(ib_wr)->remote_qpn;
> -				}
> +			info.op.send.num_sges = ib_wr->num_sge;
> +			info.op.send.sg_list = ib_wr->sg_list;
> +			if (iwqp->ibqp.qp_type == IB_QPT_UD ||
> +			    iwqp->ibqp.qp_type == IB_QPT_GSI) {
> +				ah = to_iwah(ud_wr(ib_wr)->ah);
> +				info.op.send.ah_id = ah->sc_ah.ah_info.ah_idx;
> +				info.op.send.qkey = ud_wr(ib_wr)->remote_qkey;
> +				info.op.send.dest_qp = ud_wr(ib_wr)->remote_qpn;
> +			}
> +
> +			if (ib_wr->send_flags & IB_SEND_INLINE)
>   				err = irdma_uk_inline_send(ukqp, &info, false);
> -			} else {
> -				info.op.send.num_sges = ib_wr->num_sge;
> -				info.op.send.sg_list = ib_wr->sg_list;
> -				if (iwqp->ibqp.qp_type == IB_QPT_UD ||
> -				    iwqp->ibqp.qp_type == IB_QPT_GSI) {
> -					ah = to_iwah(ud_wr(ib_wr)->ah);
> -					info.op.send.ah_id = ah->sc_ah.ah_info.ah_idx;
> -					info.op.send.qkey = ud_wr(ib_wr)->remote_qkey;
> -					info.op.send.dest_qp = ud_wr(ib_wr)->remote_qpn;
> -				}
> +			else
>   				err = irdma_uk_send(ukqp, &info, false);
> -			}
>   			break;
>   		case IB_WR_RDMA_WRITE_WITH_IMM:
>   			if (ukqp->qp_caps & IRDMA_WRITE_WITH_IMM) {
> @@ -3205,22 +3195,14 @@ static int irdma_post_send(struct ib_qp *ibqp,
>   			else
>   				info.op_type = IRDMA_OP_TYPE_RDMA_WRITE;
>   
> -			if (ib_wr->send_flags & IB_SEND_INLINE) {
> -				info.op.inline_rdma_write.data = (void *)(uintptr_t)ib_wr->sg_list[0].addr;
> -				info.op.inline_rdma_write.len =
> -						ib_wr->sg_list[0].length;
> -				info.op.inline_rdma_write.rem_addr.addr =
> -						rdma_wr(ib_wr)->remote_addr;
> -				info.op.inline_rdma_write.rem_addr.lkey =
> -						rdma_wr(ib_wr)->rkey;
> +			info.op.rdma_write.num_lo_sges = ib_wr->num_sge;
> +			info.op.rdma_write.lo_sg_list = ib_wr->sg_list;
> +			info.op.rdma_write.rem_addr.addr = rdma_wr(ib_wr)->remote_addr;
> +			info.op.rdma_write.rem_addr.lkey = rdma_wr(ib_wr)->rkey;
> +			if (ib_wr->send_flags & IB_SEND_INLINE)
>   				err = irdma_uk_inline_rdma_write(ukqp, &info, false);
> -			} else {
> -				info.op.rdma_write.lo_sg_list = (void *)ib_wr->sg_list;
> -				info.op.rdma_write.num_lo_sges = ib_wr->num_sge;
> -				info.op.rdma_write.rem_addr.addr = rdma_wr(ib_wr)->remote_addr;
> -				info.op.rdma_write.rem_addr.lkey = rdma_wr(ib_wr)->rkey;
> +			else
>   				err = irdma_uk_rdma_write(ukqp, &info, false);
> -			}
>   			break;
>   		case IB_WR_RDMA_READ_WITH_INV:
>   			inv_stag = true;
