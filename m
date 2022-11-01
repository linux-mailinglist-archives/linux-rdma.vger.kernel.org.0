Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FC16153B9
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Nov 2022 22:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKAVFO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Nov 2022 17:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKAVFN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Nov 2022 17:05:13 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215E21DA6C
        for <linux-rdma@vger.kernel.org>; Tue,  1 Nov 2022 14:05:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIBWv1J/I/orOxiLGNHdwYEvcAnLafCZZBbzwLD+yKRSeKDZO/cXEXPrb6cP6FGh9KTarBlJk6ntFCaQKmp/NA8Z3PkzdUFYxvMKlgSMAg7SrzZylkmJvmE4Alzz55OfrYxpm8ngBvsW0FRA6slKRnrA9UiwtAcNVaGnW0lDr68/o63skxyUkr7i2iZICRRYb+OXQs09dvq+YV/SEDOLwTOWgAwsFT4k8L9TlV9e50eFuMCrnksQGCFG6FtSJ1QK38pCs4pHapMPTfNXiSUca0f1AQ/V08h+vvrumzUfML7NtXTVYhW+I02BQH+eF/Zf+4xzbjwLuQVvKXqBcOSQZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhjFx9t4EezkiEn1V9vdz6O5wOcERZxRiaanVUiIYwE=;
 b=mfHH/E7Ro9pC14nee0tMR5KLFcT/ZfRxXaiELS2R550ndYaN2WkTjcUDGiogA2CgTIhUJQXOaYq2+nkBiObrqDqQRjR19Nc/O2MWl/tBhkUC1WmAz4+UjsX1Ap76oE45r0JV9kReqvJuZID7TKXw1VtqFp1XAeOxXgunWeG4JK1e6dij27gHrOGFlw8Rn6jdt9TpLP7J/p37dlQeaCAUmJlzgegBe5wxT7IvFVmaniEDfboicg/vy4xD2EkqKkFPIy+sI8QbTUNTKq7bF4ZimtzzFJ5+nAoD/GdQ181ZFyup8SpwTF6kZS3L0RLtAoqoc7QW7LqZC7diygDzaBoFKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 SN2PR01MB2079.prod.exchangelabs.com (2603:10b6:804:8::22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.21; Tue, 1 Nov 2022 21:05:09 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::a85b:910b:5c36:a282]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::a85b:910b:5c36:a282%4]) with mapi id 15.20.5769.016; Tue, 1 Nov 2022
 21:05:09 +0000
Message-ID: <062bf1bc-f6c2-4cfe-b3d7-786c4efc379c@talpey.com>
Date:   Tue, 1 Nov 2022 17:05:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] RDMA/siw: Fix immediate work request flush to completion
 queue.
Content-Language: en-US
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     jgg@nvidia.com, leonro@nvidia.com,
        Olga Kornievskaia <kolga@netapp.com>
References: <20221101153705.626906-1-bmt@zurich.ibm.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20221101153705.626906-1-bmt@zurich.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:208:256::32) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|SN2PR01MB2079:EE_
X-MS-Office365-Filtering-Correlation-Id: 684a1907-30ef-4b6d-0bf1-08dabc4cc2a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ji1K+qt37mVuxnE6JrC2T4BtpTcr8TijzVLe0EyLZzbr8+bXstIwenV59WdVwUStXZ9AcGxnnfqOgxwooswEKfP7Kxgq6gvSV/d8TrW8FcaNjO0H8d/Ft1teg4q+lLoPGBOkwVgedZrEvgGLblIlcgYPz4iNByIUp6dj1QMMbMKCt2UNjwpymiyzb8J8ETGav3Lggho95592il3MGEDb3FXw8CbhbyLZb+C/1OoTSw3DcgbMk08eWk/N674xAqQoz5bZ21KZ18kQS1v7H000dk/P4drslDRdCxDgN33MrZnhX29m7beOokC3g+IG9Gt3CUvfRLzkJEGJT6ifGJi3B/KfRY9+It3teB1A386tjH24o9K4MitpkMrTvKgRj9sBAqs/1lJCPXhH9LtN9HdOj4jEUCx+rapKuyjDgNmZNpoUw4Q0TDMUA8eRHDG+pFe08VmYY3MTCYz/1R+exkUyF+IoKZW65SxiajQiDhj+yuo3DtQcWcA7tbSleP+j313SurBqPbqRXHhCy0jKDTZRRNPDUp68L3X6JalTa8lm34Ib8pLBKUJl3SGoteboq18FZ3XHzV8fPQijKpEV2WJ1VFDaojwAI0w+LKMT7q93OCYRR9I8dy/FA5Vcd2BYGhLdNNTgrKY2y9uAdmhq4pKj/xADhWZRwk6RFZ3tDv1qAAGUBTnrQlLpEET6/z0hrNsFoK2h71qRE7QaVTd9LenBMYcLaEvq6L0bylpHJqJyjNsaHiM1v+ZdvPczHjFJJjuTmMkwc6Bk9Q9RlI2SDY6Wl3w/1OkmC4eNShA6aZSFwt1bhkQv0aYbbJ6pzcwC94z6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(136003)(396003)(346002)(366004)(376002)(451199015)(31686004)(186003)(6486002)(86362001)(2906002)(38350700002)(31696002)(38100700002)(36756003)(83380400001)(66556008)(52116002)(53546011)(6506007)(8936002)(26005)(478600001)(2616005)(41300700001)(6512007)(5660300002)(8676002)(66476007)(66946007)(316002)(4326008)(14773001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjgrY3lNYXVSNXM1Z05UQVBLUlNLL1IrOXlTajJXV01tQnJndTJyOXgwWHc3?=
 =?utf-8?B?eVowRnVxM2dIRSttaVg1WHk5dlloTFpEVEZhb1BpV2ZiMHN5S0paWEprVktT?=
 =?utf-8?B?czRvNFkrdmtJR250Mk1VWTBBQmpZYzNjclJGY21tNzNEakpvRVdUTUJuMHZr?=
 =?utf-8?B?VE9rUTRXZnZnTHBOM0djc0NrN1pKRWUybmkwMUUwZHFuMWJCdFJRYVNVU1lP?=
 =?utf-8?B?SjcyL1F2ckRTSzAvaEZiYjhUVkZsV1AwSGtBK3hrZW5mOXQva0VJa2dwM3BX?=
 =?utf-8?B?RWlvV1VsNkM3UzJTalI1NDRmM0NadUV5N1k3bE9yWWFncHNDVkphaVJISlhX?=
 =?utf-8?B?amowRGE5eTJGcS80ald1QjRtYmw3eTNzdENTcWZRSnA2aGtDUWZVaEJtLzdx?=
 =?utf-8?B?cjNDV0x3Q2ZpYXhlamlyZHVIcjExZ0w2TTJhRm95V3pzNHB4NGJUTWQxakFs?=
 =?utf-8?B?dHpSWnR5RFJsTzRITVFUOEJ2UTNOeVBXZVc3RmlKMTdkRStRTjVCN0QyNzdE?=
 =?utf-8?B?UU1iUDd5b1MvNjZFd3NuS2FRWGZ4TDZQbFBidXEwUXVZalkyaWpYdUNrN3FC?=
 =?utf-8?B?MXdsaEpVd1NxK2FKUWxPQldhQitzaTd6TmZBVFVxa3lScFNrVkZjME1TWHd4?=
 =?utf-8?B?WTY5VWtwODJ3ZzhOaUd2Yk5oQ0ZIenMzay8zQmJWd2hHMGlubTJRd2RIQ0Z1?=
 =?utf-8?B?WkdiNUcweWNIVTRaUXNiMnVKSG9sSHdRaFdvMGp4aGM3Z25na0Y1Ni9HOE1I?=
 =?utf-8?B?bXVvSURTa3ZWa2lxY1NUQTJFeThINDIyaE1PTEdLbjdjaVdVb0xYTFh1eUhM?=
 =?utf-8?B?MmtyZ0s0WFMyTDVUazRDbmluOWk3bm8wQysydVM1UUd3VEF2dUpvK3RMRGg1?=
 =?utf-8?B?ZFduSFVjaWNYVHcrMkszKzFiRXdsWVREY3FFdkVqcXgwTXNqTWFmTnNkUlRR?=
 =?utf-8?B?aEx0ZHBSOWRJZ2RBL2xuY3RYNlpjWHBHdFk0MnNQc0VuTUFIQkhHcG1WVTU1?=
 =?utf-8?B?cDYwZVl3dFhWOGJlZk5BbEFaeDV6dE12Zkp6a2lxUDZRTlZLRi9VazBKRGp2?=
 =?utf-8?B?bUFIRVNEa05MemVMUzVPeWJraXRDMkV4TXhxS204WXRUWVpkeXR5ME81b3l1?=
 =?utf-8?B?S3Njby8ycUpLVDltZFZTekV0Wmx6cnpLYUxJb2d5NkxXRHNlTWdTNCtXdnpk?=
 =?utf-8?B?MW5xTEdKVnpDQ0tZS09McmppY0NYZzBRTXFTY2RabmU0QXZnSWZvdlk5ZWpV?=
 =?utf-8?B?Q0w1Mkw4NVlWVnVWUitZeklubWJ6ZnpYN2Q1eEJ0UmRXZzFEdjRvTG55SVRG?=
 =?utf-8?B?aU0zU3JKbmRUZ2RJWlZQUEpUVzZOdGJoQ3hmaDA2WEJPUGJwM0pWNnpjZi8x?=
 =?utf-8?B?U2x4TFc1UGM2NU1qZG9nYWM0YlRYSno0K1kxQWNmTGJhZ3JMbHRWM2FiZUY2?=
 =?utf-8?B?TVF2QUVkZDZsa1FlNTQwQ2FjOCtKQWZiOC9hSmg4NWFpdERoU3U3MXhNS3Vy?=
 =?utf-8?B?OWtsbnVrbzc5VHVHS0ZrUWRMcG5oT2lzaytFcUx0UGlVTkFrTU9ESSs4a1ZH?=
 =?utf-8?B?V25lUzltYjI1SjdleTRJZjh5WVE2S2hrY0s4RmhFZDFXQlZ2TVk3UGduM1dZ?=
 =?utf-8?B?L2kvWnNrTXdJS09lZnpZRUpqUkVYSWl5SmVkTmlaVTVzckhxbXVTbXFqMENC?=
 =?utf-8?B?MUZsV2NRSG90amZ3M0had3ZiZzlaclRqd0w1T3NBTFo0ZVFHTW9xSlltK2M4?=
 =?utf-8?B?MlpDbzI4Z0ZHdVp2ZFNGVmVBay95eWkwNWpLZzhqcmQzSFNwRUNYTmNCQmRn?=
 =?utf-8?B?OVdHWDVMT3BnSDMySDFjSXpRaG1IVS9sTVJzOHJ3czhwckxBNWRDTHV1VW44?=
 =?utf-8?B?RVJpMkVYSmw0RW5pV1Y0M2RlYmhXWi8yQVBjN3ZMVU13VVVvVXB4bzZVNjM5?=
 =?utf-8?B?emdmaTIwN2VLRXVKN2JNK1laY1VNOGxGb3l3R1IzREZsWkM1U1dDUnk3Qkpk?=
 =?utf-8?B?eUIwbDk4ZktHN0dTMHN2QkU0cEFkQm1seWpWVkRWMnYyM01YenJtaEZNUHBx?=
 =?utf-8?B?SGl5Z2NyaUZSREs2TmZvR25tZklwYWF5OFNWbnBsUE5UVk1UMnRlTUZTSGwz?=
 =?utf-8?Q?BpNTUng8vs7jctXpoTpfT+EUU?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684a1907-30ef-4b6d-0bf1-08dabc4cc2a7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 21:05:09.7016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siCm/ux4MtNWrNDI6/65i7/HQgUSkybBNDPA4RJgqttTzSiGeiGlgKWUk4RukHhK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR01MB2079
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/1/2022 11:37 AM, Bernard Metzler wrote:
> Correctly set send queue element opcode during immediate work request
> flushing in post sendqueue operation, if the QP is in ERROR state.
> An undefined ocode value results in out-of-bounds access to an array
> for mapping the opcode between siw internal and RDMA core representation
> in work completion generation. It resulted in a KASAN BUG report
> of type 'global-out-of-bounds' during NFSoRDMA testing.
> This patch further fixes a potential case of a malicious user which may
> write undefined values for completion queue elements status or opcode,
> if the CQ is memory mapped to user land. It avoids the same out-of-bounds
> access to arrays for status and opcode mapping as described above.
> 
> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> Fixes: b0fff7317bb4 ("rdma/siw: completion queue methods")
> 
> Reported-by: Olga Kornievskaia <kolga@netapp.com>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>   drivers/infiniband/sw/siw/siw_cq.c    | 24 ++++++++++++++--
>   drivers/infiniband/sw/siw/siw_verbs.c | 40 ++++++++++++++++++++++++---
>   2 files changed, 58 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw_cq.c b/drivers/infiniband/sw/siw/siw_cq.c
> index d68e37859e73..acc7bcd538b5 100644
> --- a/drivers/infiniband/sw/siw/siw_cq.c
> +++ b/drivers/infiniband/sw/siw/siw_cq.c
> @@ -56,8 +56,6 @@ int siw_reap_cqe(struct siw_cq *cq, struct ib_wc *wc)
>   	if (READ_ONCE(cqe->flags) & SIW_WQE_VALID) {
>   		memset(wc, 0, sizeof(*wc));
>   		wc->wr_id = cqe->id;
> -		wc->status = map_cqe_status[cqe->status].ib;
> -		wc->opcode = map_wc_opcode[cqe->opcode];
>   		wc->byte_len = cqe->bytes;
>   
>   		/*
> @@ -71,10 +69,32 @@ int siw_reap_cqe(struct siw_cq *cq, struct ib_wc *wc)
>   				wc->wc_flags = IB_WC_WITH_INVALIDATE;
>   			}
>   			wc->qp = cqe->base_qp;
> +			wc->opcode = map_wc_opcode[cqe->opcode];
> +			wc->status = map_cqe_status[cqe->status].ib;
>   			siw_dbg_cq(cq,
>   				   "idx %u, type %d, flags %2x, id 0x%pK\n",
>   				   cq->cq_get % cq->num_cqe, cqe->opcode,
>   				   cqe->flags, (void *)(uintptr_t)cqe->id);
> +		} else {
> +			/*
> +			 * A malicious user may set invalid opcode or
> +			 * status in the user mmapped CQE array.
> +			 * Sanity check and correct values in that case
> +			 * to avoid out-of-bounds access to global arrays
> +			 * for opcode and status mapping.
> +			 */
> +			u8 opcode = cqe->opcode;
> +			u16 status = cqe->status;
> +
> +			if (opcode >= SIW_NUM_OPCODES) {
> +				opcode = 0;
> +				status = IB_WC_GENERAL_ERR;
> +			} else if (status >= SIW_NUM_WC_STATUS) {
> +				status = IB_WC_GENERAL_ERR;
> +			}
> +			wc->opcode = map_wc_opcode[opcode];
> +			wc->status = map_cqe_status[status].ib;
> +
>   		}
>   		WRITE_ONCE(cqe->flags, 0);
>   		cq->cq_get++;
> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
> index 3e814cfb298c..8021fbd004b0 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> @@ -676,13 +676,45 @@ static int siw_copy_inline_sgl(const struct ib_send_wr *core_wr,
>   static int siw_sq_flush_wr(struct siw_qp *qp, const struct ib_send_wr *wr,
>   			   const struct ib_send_wr **bad_wr)
>   {
> -	struct siw_sqe sqe = {};
>   	int rv = 0;
>   
>   	while (wr) {
> -		sqe.id = wr->wr_id;
> -		sqe.opcode = wr->opcode;
> -		rv = siw_sqe_complete(qp, &sqe, 0, SIW_WC_WR_FLUSH_ERR);
> +		struct siw_sqe sqe = {};
> +
> +		switch (wr->opcode) {
> +		case IB_WR_RDMA_WRITE:
> +			sqe.opcode = SIW_OP_WRITE;
> +			break;
> +		case IB_WR_RDMA_READ:
> +			sqe.opcode = SIW_OP_READ;
> +			break;
> +		case IB_WR_RDMA_READ_WITH_INV:
> +			sqe.opcode = SIW_OP_READ_LOCAL_INV;
> +			break;
> +		case IB_WR_SEND:
> +			sqe.opcode = SIW_OP_SEND;
> +			break;
> +		case IB_WR_SEND_WITH_IMM:
> +			sqe.opcode = SIW_OP_SEND_WITH_IMM;
> +			break;
> +		case IB_WR_SEND_WITH_INV:
> +			sqe.opcode = SIW_OP_SEND_REMOTE_INV;
> +			break;
> +		case IB_WR_LOCAL_INV:
> +			sqe.opcode = SIW_OP_INVAL_STAG;
> +			break;
> +		case IB_WR_REG_MR:
> +			sqe.opcode = SIW_OP_REG_MR;
> +			break;
> +		default:
> +			rv = -EOPNOTSUPP;

I think -EINVAL would be more appropriate here. That error is
returned from siw_post_send() in a similar situation, and
this routine is actually called from there also, and its rc
is returned, so it's best to be consistent.

Other than that, looks good to me:
Reviewed-by: Tom Talpey <tom@talpey.com>

Tom.


> +			break;
> +		}
> +		if (!rv) {
> +			sqe.id = wr->wr_id;
> +			rv = siw_sqe_complete(qp, &sqe, 0,
> +					      SIW_WC_WR_FLUSH_ERR);
> +		}
>   		if (rv) {
>   			if (bad_wr)
>   				*bad_wr = wr;
