Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE9A3889FD
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 10:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244540AbhESI66 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 04:58:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239283AbhESI66 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 04:58:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 956496108D;
        Wed, 19 May 2021 08:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621414659;
        bh=fSOGxkY5zqYF3w0GPDD7TzSkGrrJmoXOOsMdXHHHKYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GtTmKHSMbtd2y+1iUfFU0AIrNovkoS3ZIOKxdyrUcR7Mq+VGzxtJBmQ6F8pcv/wHL
         93ZjChGmuKmek752bGgwDal7Y7D1PIPl0tKUwG3pmxG7V9ytJjKiN5m8xMRCgXJW84
         T2S3sBWbo+M/dxF2OcowzhAhNXGh/FpYzsgys/as+V2uTFFt2thjwKH5AMjH8DQFSg
         iuCrGpx3GUxoEq9C47Y5d2iwlCqtR1J4mfYYND8vX0K4aYT4FJ4CEOHriq97j8s8v+
         VYCBfXZBKk8Mu7J/VWOFe4x8+9+EFBVJO7PQhzlGka0xBOEa+1wzv819sILtcPY1Xg
         XGTAylcSKIC8w==
Date:   Wed, 19 May 2021 11:57:35 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Xi Wang <wangxi11@huawei.com>
Subject: Re: [PATCH for-next 2/2] RDMA/hns: Remove timeout link table for
 HIP08
Message-ID: <YKTS/95LQq9tsoRG@unreal>
References: <1620807370-9409-1-git-send-email-liweihang@huawei.com>
 <1620807370-9409-3-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620807370-9409-3-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 12, 2021 at 04:16:10PM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> The timeout link table works in HIP08 ES version and the hns driver only
> support the CS version for HIP08, so delete the related code.
> 
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |   3 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 177 +++++++++++-----------------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  16 +--
>  3 files changed, 76 insertions(+), 120 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 97800d2..5bd4013 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -854,8 +854,7 @@ struct hns_roce_caps {
>  	u32		gmv_buf_pg_sz;
>  	u32		gmv_hop_num;
>  	u32		sl_num;
> -	u32		tsq_buf_pg_sz;
> -	u32		tpq_buf_pg_sz;
> +	u32		llm_buf_pg_sz;
>  	u32		chunk_sz;	/* chunk size in non multihop mode */
>  	u64		flags;
>  	u16		default_ceq_max_cnt;
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index a3f7dc5..e105e21 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -2062,7 +2062,7 @@ static void set_hem_page_size(struct hns_roce_dev *hr_dev)
>  	caps->eqe_buf_pg_sz = 0;
>  
>  	/* Link Table */
> -	caps->tsq_buf_pg_sz = 0;
> +	caps->llm_buf_pg_sz = 0;
>  
>  	/* MR */
>  	caps->pbl_ba_pg_sz = HNS_ROCE_BA_PG_SZ_SUPPORTED_16K;
> @@ -2478,43 +2478,16 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
>  	return ret;
>  }
>  
> -static int hns_roce_config_link_table(struct hns_roce_dev *hr_dev,
> -				      enum hns_roce_link_table_type type)
> +static void config_llm_table(struct hns_roce_buf *data_buf, void *cfg_buf)
>  {
> -	struct hns_roce_cmq_desc desc[2];
> -	struct hns_roce_cmq_req *r_a = (struct hns_roce_cmq_req *)desc[0].data;
> -	struct hns_roce_cmq_req *r_b = (struct hns_roce_cmq_req *)desc[1].data;
> -	struct hns_roce_v2_priv *priv = hr_dev->priv;
> -	struct hns_roce_link_table *link_tbl;
> -	enum hns_roce_opcode_type opcode;
>  	u32 i, next_ptr, page_num;
> -	struct hns_roce_buf *buf;
> +	__le64 *entry = cfg_buf;
>  	dma_addr_t addr;
> -	__le64 *entry;
>  	u64 val;
>  
> -	switch (type) {
> -	case TSQ_LINK_TABLE:
> -		link_tbl = &priv->tsq;
> -		opcode = HNS_ROCE_OPC_CFG_EXT_LLM;
> -		break;
> -	case TPQ_LINK_TABLE:
> -		link_tbl = &priv->tpq;
> -		opcode = HNS_ROCE_OPC_CFG_TMOUT_LLM;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	/* Setup data table block address to link table entry */
> -	buf = link_tbl->buf;
> -	page_num = buf->npages;
> -	if (WARN_ON(page_num > HNS_ROCE_V2_EXT_LLM_MAX_DEPTH))
> -		return -EINVAL;

You added these lines in previous patch. Please structure the patches in
such way that they don't need to add->delete in same series.

Thanks
