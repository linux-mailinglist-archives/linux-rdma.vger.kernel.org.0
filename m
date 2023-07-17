Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236A2755DF4
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jul 2023 10:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjGQIKo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jul 2023 04:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjGQIKn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jul 2023 04:10:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3360FA6;
        Mon, 17 Jul 2023 01:10:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAE5760FA6;
        Mon, 17 Jul 2023 08:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A6EC433C7;
        Mon, 17 Jul 2023 08:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689581441;
        bh=3BI8Gb7qqek+UQaNpN3lbIXBVjdNBu5DmPwjCxoinRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YC6LAqsROzypf3yPftYTxUsVauBU4Csak40lgaVFo5i2n7wjo4HHorDcCQbeidfIE
         68PidudAw3qX3kqfHoY2gbP7vyEZqlRTlqPg1c+q15xoiwxSuxdoxIwuc8RtnWb1E/
         VS+TQvhJvqkjwK43JOy4rs1LD0PKSI90ieo1QCnitNNyXo/BPIjCRAzSz7TDd0SvtV
         vRHz8B0KzoPea6DxkWjBL/1VHltE8m78m+MiNcvKSMEHI+1D3RrFRY3ldZCckyzrVR
         pnFx7ha1V18CptSaTirxiAYUvp0v3ZT9AvrKC59uIjcJ8c+osKilfpd/Xv7vnA5DMl
         tJr0p9LV2iL0g==
Date:   Mon, 17 Jul 2023 11:10:37 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 for-rc 3/3] RDMA/hns: Add check and adjust for
 function resource values
Message-ID: <20230717081037.GF9461@unreal>
References: <20230717060340.453850-1-huangjunxian6@hisilicon.com>
 <20230717060340.453850-4-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717060340.453850-4-huangjunxian6@hisilicon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 17, 2023 at 02:03:40PM +0800, Junxian Huang wrote:
> Currently, RoCE driver gets function resource values from firmware
> without validity check. 

Kernel trusts devices underneath, otherwise why should we stop with
capabilities? Let's check all PCI transactions and verify any response
from FW too.

> As these resources are mostly related to memory,
> an invalid value may lead to serious consequence such as kernel panic.
> 
> This patch adds check for these resource values and adjusts the invalid
> ones.

These are FW bugs which should be fixed.

Thanks

> 
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 115 ++++++++++++++++++++-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  37 +++++++
>  2 files changed, 148 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index c4b92d8bd98a..f5649fd25042 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -1650,6 +1650,97 @@ static int hns_roce_config_global_param(struct hns_roce_dev *hr_dev)
>  	return hns_roce_cmq_send(hr_dev, &desc, 1);
>  }
>  
> +static const struct hns_roce_bt_num {
> +	u32 res_offset;
> +	u32 min;
> +	u32 max;
> +	enum hns_roce_res_invalid_flag invalid_flag;
> +	enum hns_roce_res_revision revision;
> +	bool vf_support;
> +} bt_num_table[] = {
> +	{RES_OFFSET_IN_CAPS(qpc_bt_num), 1,
> +	 MAX_QPC_BT_NUM, QPC_BT_NUM_INVALID_FLAG, RES_FOR_ALL, true},
> +	{RES_OFFSET_IN_CAPS(srqc_bt_num), 1,
> +	 MAX_SRQC_BT_NUM, SRQC_BT_NUM_INVALID_FLAG, RES_FOR_ALL, true},
> +	{RES_OFFSET_IN_CAPS(cqc_bt_num), 1,
> +	 MAX_CQC_BT_NUM, CQC_BT_NUM_INVALID_FLAG, RES_FOR_ALL, true},
> +	{RES_OFFSET_IN_CAPS(mpt_bt_num), 1,
> +	 MAX_MPT_BT_NUM, MPT_BT_NUM_INVALID_FLAG, RES_FOR_ALL, true},
> +	{RES_OFFSET_IN_CAPS(sl_num), 1,
> +	 MAX_SL_NUM, QID_NUM_INVALID_FLAG, RES_FOR_ALL, true},
> +	{RES_OFFSET_IN_CAPS(sccc_bt_num), 1,
> +	 MAX_SCCC_BT_NUM, SCCC_BT_NUM_INVALID_FLAG, RES_FOR_ALL, true},
> +	{RES_OFFSET_IN_CAPS(qpc_timer_bt_num), 1,
> +	 MAX_QPC_TIMER_BT_NUM, QPC_TIMER_BT_NUM_INVALID_FLAG,
> +	 RES_FOR_ALL, false},
> +	{RES_OFFSET_IN_CAPS(cqc_timer_bt_num), 1,
> +	 MAX_CQC_TIMER_BT_NUM, CQC_TIMER_BT_NUM_INVALID_FLAG,
> +	 RES_FOR_ALL, false},
> +	{RES_OFFSET_IN_CAPS(gmv_bt_num), 1,
> +	 MAX_GMV_BT_NUM, GMV_BT_NUM_INVALID_FLAG,
> +	 RES_FOR_HIP09, true},
> +	{RES_OFFSET_IN_CAPS(smac_bt_num), 1,
> +	 MAX_SMAC_BT_NUM, SMAC_BT_NUM_INVALID_FLAG,
> +	 RES_FOR_HIP08, true},
> +	{RES_OFFSET_IN_CAPS(sgid_bt_num), 1,
> +	 MAX_SGID_BT_NUM, SGID_BT_NUM_INVALID_FLAG,
> +	 RES_FOR_HIP08, true},
> +};
> +
> +static bool check_res_is_supported(struct hns_roce_dev *hr_dev,
> +				   struct hns_roce_bt_num *bt_num_entry)
> +{
> +	if (!bt_num_entry->vf_support && hr_dev->is_vf)
> +		return false;
> +
> +	if (bt_num_entry->revision == RES_FOR_HIP09 &&
> +	    hr_dev->pci_dev->revision <= PCI_REVISION_ID_HIP08)
> +		return false;
> +
> +	if (bt_num_entry->revision == RES_FOR_HIP08 &&
> +	    hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
> +		return false;
> +
> +	return true;
> +}
> +
> +static void adjust_eqc_bt_num(struct hns_roce_caps *caps, u16 *invalid_flag)
> +{
> +	if (caps->eqc_bt_num < caps->num_comp_vectors + caps->num_aeq_vectors ||
> +	    caps->eqc_bt_num > MAX_EQC_BT_NUM) {
> +		caps->eqc_bt_num = caps->eqc_bt_num > MAX_EQC_BT_NUM ?
> +				   MAX_EQC_BT_NUM : caps->num_comp_vectors +
> +						    caps->num_aeq_vectors;
> +		*invalid_flag |= 1 << EQC_BT_NUM_INVALID_FLAG;
> +	}
> +}
> +
> +static u16 adjust_res_caps(struct hns_roce_dev *hr_dev)
> +{
> +	struct hns_roce_caps *caps = &hr_dev->caps;
> +	u16 invalid_flag = 0;
> +	u32 min, max;
> +	u32 *res;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(bt_num_table); i++) {
> +		if (!check_res_is_supported(hr_dev, &bt_num_table[i]))
> +			continue;
> +
> +		res = (u32 *)((void *)caps + bt_num_table[i].res_offset);
> +		min = bt_num_table[i].min;
> +		max = bt_num_table[i].max;
> +		if (*res < min || *res > max) {
> +			*res = *res < min ? min : max;
> +			invalid_flag |= 1 << bt_num_table[i].invalid_flag;
> +		}
> +	}
> +
> +	adjust_eqc_bt_num(caps, &invalid_flag);
> +
> +	return invalid_flag;
> +}
> +
>  static int load_func_res_caps(struct hns_roce_dev *hr_dev, bool is_vf)
>  {
>  	struct hns_roce_cmq_desc desc[2];
> @@ -1730,11 +1821,19 @@ static int hns_roce_query_pf_resource(struct hns_roce_dev *hr_dev)
>  	}
>  
>  	ret = load_pf_timer_res_caps(hr_dev);
> -	if (ret)
> +	if (ret) {
>  		dev_err(dev, "failed to load pf timer resource, ret = %d.\n",
>  			ret);
> +		return ret;
> +	}
>  
> -	return ret;
> +	ret = adjust_res_caps(hr_dev);
> +	if (ret)
> +		dev_warn(dev,
> +			 "invalid resource values have been adjusted, invalid_flag = 0x%x.\n",
> +			 ret);
> +
> +	return 0;
>  }
>  
>  static int hns_roce_query_vf_resource(struct hns_roce_dev *hr_dev)
> @@ -1743,10 +1842,18 @@ static int hns_roce_query_vf_resource(struct hns_roce_dev *hr_dev)
>  	int ret;
>  
>  	ret = load_func_res_caps(hr_dev, true);
> -	if (ret)
> +	if (ret) {
>  		dev_err(dev, "failed to load vf res caps, ret = %d.\n", ret);
> +		return ret;
> +	}
>  
> -	return ret;
> +	ret = adjust_res_caps(hr_dev);
> +	if (ret)
> +		dev_warn(dev,
> +			 "invalid resource values have been adjusted, invalid_flag = 0x%x.\n",
> +			 ret);
> +
> +	return 0;
>  }
>  
>  static int __hns_roce_set_vf_switch_param(struct hns_roce_dev *hr_dev,
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> index d9693f6cc802..c2d46383c88c 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> @@ -972,6 +972,43 @@ struct hns_roce_func_clear {
>  #define CFG_GLOBAL_PARAM_1US_CYCLES CMQ_REQ_FIELD_LOC(9, 0)
>  #define CFG_GLOBAL_PARAM_UDP_PORT CMQ_REQ_FIELD_LOC(31, 16)
>  
> +enum hns_roce_res_invalid_flag {
> +	QPC_BT_NUM_INVALID_FLAG,
> +	SRQC_BT_NUM_INVALID_FLAG,
> +	CQC_BT_NUM_INVALID_FLAG,
> +	MPT_BT_NUM_INVALID_FLAG,
> +	EQC_BT_NUM_INVALID_FLAG,
> +	SMAC_BT_NUM_INVALID_FLAG,
> +	SGID_BT_NUM_INVALID_FLAG,
> +	QID_NUM_INVALID_FLAG,
> +	SCCC_BT_NUM_INVALID_FLAG,
> +	GMV_BT_NUM_INVALID_FLAG,
> +	QPC_TIMER_BT_NUM_INVALID_FLAG,
> +	CQC_TIMER_BT_NUM_INVALID_FLAG,
> +};
> +
> +enum hns_roce_res_revision {
> +	RES_FOR_HIP08,
> +	RES_FOR_HIP09,
> +	RES_FOR_ALL,
> +};
> +
> +#define RES_OFFSET_IN_CAPS(res) \
> +	(offsetof(struct hns_roce_caps, res))
> +
> +#define MAX_QPC_BT_NUM 2048
> +#define MAX_SRQC_BT_NUM 512
> +#define MAX_CQC_BT_NUM 512
> +#define MAX_MPT_BT_NUM 512
> +#define MAX_EQC_BT_NUM 512
> +#define MAX_SMAC_BT_NUM 256
> +#define MAX_SGID_BT_NUM 256
> +#define MAX_SL_NUM 8
> +#define MAX_SCCC_BT_NUM 512
> +#define MAX_GMV_BT_NUM 256
> +#define MAX_QPC_TIMER_BT_NUM 1728
> +#define MAX_CQC_TIMER_BT_NUM 1600
> +
>  /*
>   * Fields of HNS_ROCE_OPC_QUERY_PF_RES, HNS_ROCE_OPC_QUERY_VF_RES
>   * and HNS_ROCE_OPC_ALLOC_VF_RES
> -- 
> 2.30.0
> 
