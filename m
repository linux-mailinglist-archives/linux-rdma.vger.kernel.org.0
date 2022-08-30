Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F525A5CF1
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Aug 2022 09:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiH3Hbp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Aug 2022 03:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiH3HbU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Aug 2022 03:31:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E41C9911
        for <linux-rdma@vger.kernel.org>; Tue, 30 Aug 2022 00:30:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2AE0614A0
        for <linux-rdma@vger.kernel.org>; Tue, 30 Aug 2022 07:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF12C433C1;
        Tue, 30 Aug 2022 07:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661844649;
        bh=93ZqfZgWydv+7Xp7L5/fBgNKOchPMTIpkiaDGy0nrJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tnUypKmySgCOj6qXimd4YCSfABuldHWpfPo3aXRq0wEwHfcTjk8japAU8d6paIONH
         BYYRVDUOvapTLzKG55uvhqjoEZ54hSo1u7MHaRKCjd631ciCH0h2DSGNEJdfDVPiE7
         gNepTY7immHjSNWYKJjZgHn1aIeqjhCduSQ4O3Ku6/Dqy0c1mMrrllk94G2et4C6j9
         LY13zrZhxvgJSuslNgq45bmSevF/UKHyrHuqCO+hNWjV1Kbpb0Z/zTMU7rON+ZL6rZ
         G2XMa2oZKBv45qsh8hXIxqDZVmnBxluJSBo3wubu3jb0E863nGi3B3/bJuQx7vxW3g
         Bg1wux6W7XTaw==
Date:   Tue, 30 Aug 2022 10:30:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Disable local invalidate operation
Message-ID: <Yw28pZu4wuLzfYVT@unreal>
References: <20220829105203.1569481-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829105203.1569481-1-liangwenpeng@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 29, 2022 at 06:52:03PM +0800, Wenpeng Liang wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
> 
> Currently, local invalidate operation doesn't work well. So the hns driver
> does not support it temporarily and removes related code.

Please add Fixes line, and provide some context, so we can take it to
-rc and to all stable@ trees so this feature will be deleted from
previous kernel versions too.

Thanks

> 
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 11 -----------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  2 --
>  2 files changed, 13 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index fa78b141dff2..2b5a4bd7beeb 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -118,7 +118,6 @@ static const u32 hns_roce_op_code[] = {
>  	HR_OPC_MAP(ATOMIC_CMP_AND_SWP,		ATOM_CMP_AND_SWAP),
>  	HR_OPC_MAP(ATOMIC_FETCH_AND_ADD,	ATOM_FETCH_AND_ADD),
>  	HR_OPC_MAP(SEND_WITH_INV,		SEND_WITH_INV),
> -	HR_OPC_MAP(LOCAL_INV,			LOCAL_INV),
>  	HR_OPC_MAP(MASKED_ATOMIC_CMP_AND_SWP,	ATOM_MSK_CMP_AND_SWAP),
>  	HR_OPC_MAP(MASKED_ATOMIC_FETCH_AND_ADD,	ATOM_MSK_FETCH_AND_ADD),
>  	HR_OPC_MAP(REG_MR,			FAST_REG_PMR),
> @@ -560,9 +559,6 @@ static int set_rc_opcode(struct hns_roce_dev *hr_dev,
>  		else
>  			ret = -EOPNOTSUPP;
>  		break;
> -	case IB_WR_LOCAL_INV:
> -		hr_reg_enable(rc_sq_wqe, RC_SEND_WQE_SO);
> -		fallthrough;
>  	case IB_WR_SEND_WITH_INV:
>  		rc_sq_wqe->inv_key = cpu_to_le32(wr->ex.invalidate_rkey);
>  		break;
> @@ -3227,7 +3223,6 @@ static int hns_roce_v2_write_mtpt(struct hns_roce_dev *hr_dev,
>  
>  	hr_reg_write(mpt_entry, MPT_ST, V2_MPT_ST_VALID);
>  	hr_reg_write(mpt_entry, MPT_PD, mr->pd);
> -	hr_reg_enable(mpt_entry, MPT_L_INV_EN);
>  
>  	hr_reg_write_bool(mpt_entry, MPT_BIND_EN,
>  			  mr->access & IB_ACCESS_MW_BIND);
> @@ -3318,7 +3313,6 @@ static int hns_roce_v2_frmr_write_mtpt(struct hns_roce_dev *hr_dev,
>  
>  	hr_reg_enable(mpt_entry, MPT_RA_EN);
>  	hr_reg_enable(mpt_entry, MPT_R_INV_EN);
> -	hr_reg_enable(mpt_entry, MPT_L_INV_EN);
>  
>  	hr_reg_enable(mpt_entry, MPT_FRE);
>  	hr_reg_clear(mpt_entry, MPT_MR_MW);
> @@ -3350,7 +3344,6 @@ static int hns_roce_v2_mw_write_mtpt(void *mb_buf, struct hns_roce_mw *mw)
>  	hr_reg_write(mpt_entry, MPT_PD, mw->pdn);
>  
>  	hr_reg_enable(mpt_entry, MPT_R_INV_EN);
> -	hr_reg_enable(mpt_entry, MPT_L_INV_EN);
>  	hr_reg_enable(mpt_entry, MPT_LW_EN);
>  
>  	hr_reg_enable(mpt_entry, MPT_MR_MW);
> @@ -3799,7 +3792,6 @@ static const u32 wc_send_op_map[] = {
>  	HR_WC_OP_MAP(RDMA_READ,			RDMA_READ),
>  	HR_WC_OP_MAP(RDMA_WRITE,		RDMA_WRITE),
>  	HR_WC_OP_MAP(RDMA_WRITE_WITH_IMM,	RDMA_WRITE),
> -	HR_WC_OP_MAP(LOCAL_INV,			LOCAL_INV),
>  	HR_WC_OP_MAP(ATOM_CMP_AND_SWAP,		COMP_SWAP),
>  	HR_WC_OP_MAP(ATOM_FETCH_AND_ADD,	FETCH_ADD),
>  	HR_WC_OP_MAP(ATOM_MSK_CMP_AND_SWAP,	MASKED_COMP_SWAP),
> @@ -3849,9 +3841,6 @@ static void fill_send_wc(struct ib_wc *wc, struct hns_roce_v2_cqe *cqe)
>  	case HNS_ROCE_V2_WQE_OP_RDMA_WRITE_WITH_IMM:
>  		wc->wc_flags |= IB_WC_WITH_IMM;
>  		break;
> -	case HNS_ROCE_V2_WQE_OP_LOCAL_INV:
> -		wc->wc_flags |= IB_WC_WITH_INVALIDATE;
> -		break;
>  	case HNS_ROCE_V2_WQE_OP_ATOM_CMP_AND_SWAP:
>  	case HNS_ROCE_V2_WQE_OP_ATOM_FETCH_AND_ADD:
>  	case HNS_ROCE_V2_WQE_OP_ATOM_MSK_CMP_AND_SWAP:
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> index ae29780dd63a..7222ed00bb90 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> @@ -182,7 +182,6 @@ enum {
>  	HNS_ROCE_V2_WQE_OP_ATOM_MSK_CMP_AND_SWAP	= 0x8,
>  	HNS_ROCE_V2_WQE_OP_ATOM_MSK_FETCH_AND_ADD	= 0x9,
>  	HNS_ROCE_V2_WQE_OP_FAST_REG_PMR			= 0xa,
> -	HNS_ROCE_V2_WQE_OP_LOCAL_INV			= 0xb,
>  	HNS_ROCE_V2_WQE_OP_BIND_MW			= 0xc,
>  	HNS_ROCE_V2_WQE_OP_MASK				= 0x1f,
>  };
> @@ -917,7 +916,6 @@ struct hns_roce_v2_rc_send_wqe {
>  #define RC_SEND_WQE_OWNER RC_SEND_WQE_FIELD_LOC(7, 7)
>  #define RC_SEND_WQE_CQE RC_SEND_WQE_FIELD_LOC(8, 8)
>  #define RC_SEND_WQE_FENCE RC_SEND_WQE_FIELD_LOC(9, 9)
> -#define RC_SEND_WQE_SO RC_SEND_WQE_FIELD_LOC(10, 10)
>  #define RC_SEND_WQE_SE RC_SEND_WQE_FIELD_LOC(11, 11)
>  #define RC_SEND_WQE_INLINE RC_SEND_WQE_FIELD_LOC(12, 12)
>  #define RC_SEND_WQE_WQE_INDEX RC_SEND_WQE_FIELD_LOC(30, 15)
> -- 
> 2.30.0
> 
