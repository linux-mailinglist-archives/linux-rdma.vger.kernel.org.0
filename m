Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DC962558C
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 09:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiKKInt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Nov 2022 03:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiKKIns (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Nov 2022 03:43:48 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFD5748EC;
        Fri, 11 Nov 2022 00:43:46 -0800 (PST)
Message-ID: <ce4c5925-d321-6b33-7bd7-e05b7145acde@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668156224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sGmpgzjXSDEHtQLPRedUvX6Ie3geWInfb4mFNlmSFwM=;
        b=Ls3DPhz0g72q7glwyWPLIILy5EPB+KjsQlSf0pGkUWKaFY5BtqkinjsQ14TvL9/yiVh2FC
        GCdo/rMbmBLyT8MTQqJwGI4FvIKOgUx5aLROqXwqQnJkfyHqxCUhhp6mgGscPPjsMtRyGn
        hrQBlwqceTN/F2WtimBW52TNfjfT25A=
Date:   Fri, 11 Nov 2022 16:43:36 +0800
MIME-Version: 1.0
Subject: Re: [for-next PATCH v5 06/11] RDMA/rxe: Extend rxe packet format to
 support flush
To:     Li Zhijian <lizhijian@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, liangwenpeng@huawei.com,
        tom@talpey.com, tomasz.gromadzki@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
 <20220927055337.22630-7-lizhijian@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20220927055337.22630-7-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/9/27 13:53, Li Zhijian 写道:
> Extend rxe opcode tables, headers, helper and constants to support
> flush operations.
> 
> Refer to the IBA A19.4.1 for more FETH definition details
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V5: new FETH structure and simplify header helper
>      new names and new patch split scheme, suggested by Bob.
> ---
>   drivers/infiniband/sw/rxe/rxe_hdr.h    | 47 ++++++++++++++++++++++++++
>   drivers/infiniband/sw/rxe/rxe_opcode.c | 17 ++++++++++
>   drivers/infiniband/sw/rxe/rxe_opcode.h | 16 +++++----
>   3 files changed, 74 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
> index e432f9e37795..e995a97c54fd 100644
> --- a/drivers/infiniband/sw/rxe/rxe_hdr.h
> +++ b/drivers/infiniband/sw/rxe/rxe_hdr.h
> @@ -607,6 +607,52 @@ static inline void reth_set_len(struct rxe_pkt_info *pkt, u32 len)
>   		rxe_opcode[pkt->opcode].offset[RXE_RETH], len);
>   }
>   
> +/******************************************************************************
> + * FLUSH Extended Transport Header
> + ******************************************************************************/
> +
> +struct rxe_feth {
> +	__be32 bits;
> +};
> +
> +#define FETH_PLT_MASK		(0x0000000f) /* bits 3-0 */
> +#define FETH_SEL_MASK		(0x00000030) /* bits 5-4 */
> +#define FETH_SEL_SHIFT		(4U)
> +
> +static inline u32 __feth_plt(void *arg)
> +{
> +	struct rxe_feth *feth = arg;
> +
> +	return be32_to_cpu(feth->bits) & FETH_PLT_MASK;
> +}
> +
> +static inline u32 __feth_sel(void *arg)
> +{
> +	struct rxe_feth *feth = arg;
> +
> +	return (be32_to_cpu(feth->bits) & FETH_SEL_MASK) >> FETH_SEL_SHIFT;
> +}
> +
> +static inline u32 feth_plt(struct rxe_pkt_info *pkt)
> +{
> +	return __feth_plt(pkt->hdr + rxe_opcode[pkt->opcode].offset[RXE_FETH]);
> +}
> +
> +static inline u32 feth_sel(struct rxe_pkt_info *pkt)
> +{
> +	return __feth_sel(pkt->hdr + rxe_opcode[pkt->opcode].offset[RXE_FETH]);
> +}
> +
> +static inline void feth_init(struct rxe_pkt_info *pkt, u8 type, u8 level)
> +{
> +	struct rxe_feth *feth = (struct rxe_feth *)
> +		    (pkt->hdr + rxe_opcode[pkt->opcode].offset[RXE_FETH]);
> +	u32 bits = ((level << FETH_SEL_SHIFT) & FETH_SEL_MASK) |
> +		   (type & FETH_PLT_MASK);
> +
> +	feth->bits = cpu_to_be32(bits);
> +}
> +
>   /******************************************************************************
>    * Atomic Extended Transport Header
>    ******************************************************************************/
> @@ -910,6 +956,7 @@ enum rxe_hdr_length {
>   	RXE_ATMETH_BYTES	= sizeof(struct rxe_atmeth),
>   	RXE_IETH_BYTES		= sizeof(struct rxe_ieth),
>   	RXE_RDETH_BYTES		= sizeof(struct rxe_rdeth),
> +	RXE_FETH_BYTES		= sizeof(struct rxe_feth),
>   };
>   
>   static inline size_t header_size(struct rxe_pkt_info *pkt)
> diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
> index d4ba4d506f17..55aad13e57bb 100644
> --- a/drivers/infiniband/sw/rxe/rxe_opcode.c
> +++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
> @@ -101,6 +101,12 @@ struct rxe_wr_opcode_info rxe_wr_opcode_info[] = {
>   			[IB_QPT_UC]	= WR_LOCAL_OP_MASK,
>   		},
>   	},
> +	[IB_WR_FLUSH]					= {
> +		.name   = "IB_WR_FLUSH",
> +		.mask   = {
> +			[IB_QPT_RC]	= WR_FLUSH_MASK,
> +		},
> +	},
>   };

Hi, Zhijian

I am making tests with it. Except rc, other modes are supported? such as 
rd, xrc?

Zhu Yanjun

>   
>   struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
> @@ -378,6 +384,17 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
>   					  RXE_IETH_BYTES,
>   		}
>   	},
> +	[IB_OPCODE_RC_FLUSH]					= {
> +		.name	= "IB_OPCODE_RC_FLUSH",
> +		.mask	= RXE_FETH_MASK | RXE_RETH_MASK | RXE_FLUSH_MASK |
> +			  RXE_START_MASK | RXE_END_MASK | RXE_REQ_MASK,
> +		.length = RXE_BTH_BYTES + RXE_FETH_BYTES + RXE_RETH_BYTES,
> +		.offset = {
> +			[RXE_BTH]	= 0,
> +			[RXE_FETH]	= RXE_BTH_BYTES,
> +			[RXE_RETH]	= RXE_BTH_BYTES + RXE_FETH_BYTES,
> +		}
> +	},
>   
>   	/* UC */
>   	[IB_OPCODE_UC_SEND_FIRST]			= {
> diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
> index 8f9aaaf260f2..02d256745793 100644
> --- a/drivers/infiniband/sw/rxe/rxe_opcode.h
> +++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
> @@ -19,7 +19,8 @@ enum rxe_wr_mask {
>   	WR_SEND_MASK			= BIT(2),
>   	WR_READ_MASK			= BIT(3),
>   	WR_WRITE_MASK			= BIT(4),
> -	WR_LOCAL_OP_MASK		= BIT(5),
> +	WR_FLUSH_MASK			= BIT(5),
> +	WR_LOCAL_OP_MASK		= BIT(6),
>   
>   	WR_READ_OR_WRITE_MASK		= WR_READ_MASK | WR_WRITE_MASK,
>   	WR_WRITE_OR_SEND_MASK		= WR_WRITE_MASK | WR_SEND_MASK,
> @@ -47,6 +48,7 @@ enum rxe_hdr_type {
>   	RXE_RDETH,
>   	RXE_DETH,
>   	RXE_IMMDT,
> +	RXE_FETH,
>   	RXE_PAYLOAD,
>   	NUM_HDR_TYPES
>   };
> @@ -63,6 +65,7 @@ enum rxe_hdr_mask {
>   	RXE_IETH_MASK		= BIT(RXE_IETH),
>   	RXE_RDETH_MASK		= BIT(RXE_RDETH),
>   	RXE_DETH_MASK		= BIT(RXE_DETH),
> +	RXE_FETH_MASK		= BIT(RXE_FETH),
>   	RXE_PAYLOAD_MASK	= BIT(RXE_PAYLOAD),
>   
>   	RXE_REQ_MASK		= BIT(NUM_HDR_TYPES + 0),
> @@ -71,13 +74,14 @@ enum rxe_hdr_mask {
>   	RXE_WRITE_MASK		= BIT(NUM_HDR_TYPES + 3),
>   	RXE_READ_MASK		= BIT(NUM_HDR_TYPES + 4),
>   	RXE_ATOMIC_MASK		= BIT(NUM_HDR_TYPES + 5),
> +	RXE_FLUSH_MASK		= BIT(NUM_HDR_TYPES + 6),
>   
> -	RXE_RWR_MASK		= BIT(NUM_HDR_TYPES + 6),
> -	RXE_COMP_MASK		= BIT(NUM_HDR_TYPES + 7),
> +	RXE_RWR_MASK		= BIT(NUM_HDR_TYPES + 7),
> +	RXE_COMP_MASK		= BIT(NUM_HDR_TYPES + 8),
>   
> -	RXE_START_MASK		= BIT(NUM_HDR_TYPES + 8),
> -	RXE_MIDDLE_MASK		= BIT(NUM_HDR_TYPES + 9),
> -	RXE_END_MASK		= BIT(NUM_HDR_TYPES + 10),
> +	RXE_START_MASK		= BIT(NUM_HDR_TYPES + 9),
> +	RXE_MIDDLE_MASK		= BIT(NUM_HDR_TYPES + 10),
> +	RXE_END_MASK		= BIT(NUM_HDR_TYPES + 11),
>   
>   	RXE_LOOPBACK_MASK	= BIT(NUM_HDR_TYPES + 12),
>   

