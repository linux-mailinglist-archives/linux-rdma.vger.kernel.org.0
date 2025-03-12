Return-Path: <linux-rdma+bounces-8624-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0323DA5E409
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 20:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B223AE7F2
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 18:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CAE2580F0;
	Wed, 12 Mar 2025 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrMyhn4J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB8B2580CC
	for <linux-rdma@vger.kernel.org>; Wed, 12 Mar 2025 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741806002; cv=none; b=l5MbpCyflpJm0wU+VvwqjnheCQRKIK1Jffg91M3I2Rj49Oc6znQzH5n1lJ4+yYsEcBiT81KwxmvjkUi3xxr5ZsdTuLU+k3sguEfvpz3nxlaBfUYlJiU+/TRFrzD6RyjtpIFURwL4cpbJ4jcdrX1WVCrboA/tjeNH9BmI82z5GrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741806002; c=relaxed/simple;
	bh=pOa3JZUYlGTvLXwR1UZU9kspfNs+Wi28ZMLxNoua/BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gd2K+bAKUr6/M3eE7hNV2aTl3Fe9f/EiqqePTncU0ORJW5FkanW+3U9K2oWgmVktwwxKT9Nz6JxsLa0gDaGmu3od9UMILogxLJybK7xHpnjgfX9d7e5P100qWMmszFOfPRMcJIDdmC1OTcBo6mgNlWmruf0Np5I5FCLZmfGFIec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrMyhn4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4073C4CEEA;
	Wed, 12 Mar 2025 19:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741806001;
	bh=pOa3JZUYlGTvLXwR1UZU9kspfNs+Wi28ZMLxNoua/BI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mrMyhn4Jz8870/wXMyMksI5zI0gZKLHJqQUy30KNy5jJsqmjr/s+eJpCP74Ks/Mhd
	 g6TGpzs58p/9X6dGxk55n8bKmiP6GX8fOlL/lwEX755qFXmQUa46KtHiexTScncp9Q
	 td77KG6LH7TryzLcKkUPA6lM80CIG7RS5nPK97MVp0p5Z/W3BGpHKLsW9VZ5Qott3x
	 ChuPnIqnM3zLG38eF/wO6cVgIhWhlhsQQV48ToKwQFRQTMiZ76hgA5OBK3IXJJk2JF
	 uuJiUVHPGx+len5bK4xm4TYnAA6r4u++T7vDe8S1q02ukiPg4+V4k2w2Bpq3FJrYYh
	 jtr24hGjMlq2w==
Date: Wed, 12 Mar 2025 20:59:57 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
	Preethi G <preethi.gurusiddalingeswaraswamy@broadcom.com>
Subject: Re: [PATCH rdma-next v2] RDMA/bnxt_re: Support Perf management
 counters
Message-ID: <20250312185957.GH1322339@unreal>
References: <1741770069-1455-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1741770069-1455-1-git-send-email-selvin.xavier@broadcom.com>

On Wed, Mar 12, 2025 at 02:01:09AM -0700, Selvin Xavier wrote:
> From: Preethi G <preethi.gurusiddalingeswaraswamy@broadcom.com>
> 
> Add support for process_mad hook to retrieve the perf management counters.
> Supports IB_PMA_PORT_COUNTERS and IB_PMA_PORT_COUNTERS_EXT counters.
> Query the data from HW contexts and FW commands.
> 
> Signed-off-by: Preethi G <preethi.gurusiddalingeswaraswamy@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
> v1->v2:
> 	Fix the warning reported by kernel test robot by returning rc
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h     |  4 ++
>  drivers/infiniband/hw/bnxt_re/hw_counters.c | 88 +++++++++++++++++++++++++++++
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c    | 36 ++++++++++++
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h    |  6 ++
>  drivers/infiniband/hw/bnxt_re/main.c        |  1 +
>  5 files changed, 135 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> index b33b04e..8bc0237 100644
> --- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> +++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> @@ -246,6 +246,10 @@ struct bnxt_re_dev {
>  #define BNXT_RE_CHECK_RC(x) ((x) && ((x) != -ETIMEDOUT))
>  void bnxt_re_pacing_alert(struct bnxt_re_dev *rdev);
>  
> +int bnxt_re_assign_pma_port_counters(struct bnxt_re_dev *rdev, struct ib_mad *out_mad);
> +int bnxt_re_assign_pma_port_ext_counters(struct bnxt_re_dev *rdev,
> +					 struct ib_mad *out_mad);
> +
>  static inline struct device *rdev_to_dev(struct bnxt_re_dev *rdev)
>  {
>  	if (rdev)
> diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
> index 3ac47f4..d90f2cb 100644
> --- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
> +++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
> @@ -39,6 +39,8 @@
>  
>  #include <linux/types.h>
>  #include <linux/pci.h>
> +#include <rdma/ib_mad.h>
> +#include <rdma/ib_pma.h>
>  
>  #include "roce_hsi.h"
>  #include "qplib_res.h"
> @@ -285,6 +287,92 @@ static void bnxt_re_copy_db_pacing_stats(struct bnxt_re_dev *rdev,
>  		readl(rdev->en_dev->bar0 + rdev->pacing.dbr_db_fifo_reg_off);
>  }
>  
> +int bnxt_re_assign_pma_port_ext_counters(struct bnxt_re_dev *rdev, struct ib_mad *out_mad)
> +{
> +	struct ib_pma_portcounters_ext *pma_cnt_ext;
> +	struct bnxt_qplib_ext_stat *estat = &rdev->stats.rstat.ext_stat;
> +	struct ctx_hw_stats *hw_stats = NULL;
> +	int rc = 0;
> +
> +	hw_stats = rdev->qplib_ctx.stats.dma;
> +
> +	pma_cnt_ext = (void *)(out_mad->data + 40);
> +	if (_is_ext_stats_supported(rdev->dev_attr->dev_cap_flags)) {
> +		u32 fid = PCI_FUNC(rdev->en_dev->pdev->devfn);
> +
> +		rc = bnxt_qplib_qext_stat(&rdev->rcfw, fid, estat);

And why don't you stop after getting an "rc != 0" here?

Thanks

> +	}
> +
> +	pma_cnt_ext = (void *)(out_mad->data + 40);
> +	if ((bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) && rdev->is_virtfn) ||
> +	    !bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx)) {
> +		pma_cnt_ext->port_xmit_data =
> +			cpu_to_be64(le64_to_cpu(hw_stats->tx_ucast_bytes) / 4);
> +		pma_cnt_ext->port_rcv_data =
> +			cpu_to_be64(le64_to_cpu(hw_stats->rx_ucast_bytes) / 4);
> +		pma_cnt_ext->port_xmit_packets =
> +			cpu_to_be64(le64_to_cpu(hw_stats->tx_ucast_pkts));
> +		pma_cnt_ext->port_rcv_packets =
> +			cpu_to_be64(le64_to_cpu(hw_stats->rx_ucast_pkts));
> +		pma_cnt_ext->port_unicast_rcv_packets =
> +			cpu_to_be64(le64_to_cpu(hw_stats->rx_ucast_pkts));
> +		pma_cnt_ext->port_unicast_xmit_packets =
> +			cpu_to_be64(le64_to_cpu(hw_stats->tx_ucast_pkts));
> +
> +	} else {
> +		pma_cnt_ext->port_rcv_packets = cpu_to_be64(estat->rx_roce_good_pkts);
> +		pma_cnt_ext->port_rcv_data = cpu_to_be64(estat->rx_roce_good_bytes / 4);
> +		pma_cnt_ext->port_xmit_packets = cpu_to_be64(estat->tx_roce_pkts);
> +		pma_cnt_ext->port_xmit_data = cpu_to_be64(estat->tx_roce_bytes / 4);
> +		pma_cnt_ext->port_unicast_rcv_packets = cpu_to_be64(estat->rx_roce_good_pkts);
> +		pma_cnt_ext->port_unicast_xmit_packets = cpu_to_be64(estat->tx_roce_pkts);
> +	}
> +	return rc;
> +}
> +
> +int bnxt_re_assign_pma_port_counters(struct bnxt_re_dev *rdev, struct ib_mad *out_mad)
> +{
> +	struct bnxt_qplib_ext_stat *estat = &rdev->stats.rstat.ext_stat;
> +	struct ib_pma_portcounters *pma_cnt;
> +	struct ctx_hw_stats *hw_stats = NULL;
> +	int rc = 0;
> +
> +	hw_stats = rdev->qplib_ctx.stats.dma;
> +
> +	pma_cnt = (void *)(out_mad->data + 40);
> +	if (_is_ext_stats_supported(rdev->dev_attr->dev_cap_flags)) {
> +		u32 fid = PCI_FUNC(rdev->en_dev->pdev->devfn);
> +
> +		rc = bnxt_qplib_qext_stat(&rdev->rcfw, fid, estat);
> +	}
> +	if ((bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) && rdev->is_virtfn) ||
> +	    !bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx)) {
> +		pma_cnt->port_rcv_packets =
> +			cpu_to_be32((u32)(le64_to_cpu(hw_stats->rx_ucast_pkts)) & 0xFFFFFFFF);
> +		pma_cnt->port_rcv_data =
> +			cpu_to_be32((u32)((le64_to_cpu(hw_stats->rx_ucast_bytes) &
> +					   0xFFFFFFFF) / 4));
> +		pma_cnt->port_xmit_packets =
> +			cpu_to_be32((u32)(le64_to_cpu(hw_stats->tx_ucast_pkts)) & 0xFFFFFFFF);
> +		pma_cnt->port_xmit_data =
> +			cpu_to_be32((u32)((le64_to_cpu(hw_stats->tx_ucast_bytes)
> +					   & 0xFFFFFFFF) / 4));
> +	} else {
> +		pma_cnt->port_rcv_packets = cpu_to_be32(estat->rx_roce_good_pkts);
> +		pma_cnt->port_rcv_data = cpu_to_be32((estat->rx_roce_good_bytes / 4));
> +		pma_cnt->port_xmit_packets = cpu_to_be32(estat->tx_roce_pkts);
> +		pma_cnt->port_xmit_data = cpu_to_be32((estat->tx_roce_bytes / 4));
> +	}
> +	pma_cnt->port_rcv_constraint_errors = (u8)(le64_to_cpu(hw_stats->rx_discard_pkts) & 0xFF);
> +	pma_cnt->port_rcv_errors = cpu_to_be16((u16)(le64_to_cpu(hw_stats->rx_error_pkts)
> +						     & 0xFFFF));
> +	pma_cnt->port_xmit_constraint_errors = (u8)(le64_to_cpu(hw_stats->tx_error_pkts) & 0xFF);
> +	pma_cnt->port_xmit_discards = cpu_to_be16((u16)(le64_to_cpu(hw_stats->tx_discard_pkts)
> +							& 0xFFFF));
> +
> +	return rc;
> +}
> +
>  int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
>  			    struct rdma_hw_stats *stats,
>  			    u32 port, int index)
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index 2de101d..dc31973 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -49,6 +49,7 @@
>  #include <rdma/ib_addr.h>
>  #include <rdma/ib_mad.h>
>  #include <rdma/ib_cache.h>
> +#include <rdma/ib_pma.h>
>  #include <rdma/uverbs_ioctl.h>
>  #include <linux/hashtable.h>
>  
> @@ -4489,6 +4490,41 @@ void bnxt_re_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
>  	kfree(bnxt_entry);
>  }
>  
> +int bnxt_re_process_mad(struct ib_device *ibdev, int mad_flags,
> +			u32 port_num, const struct ib_wc *in_wc,
> +			const struct ib_grh *in_grh,
> +			const struct ib_mad *in_mad, struct ib_mad *out_mad,
> +			size_t *out_mad_size, u16 *out_mad_pkey_index)
> +{
> +	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
> +	struct ib_class_port_info cpi = {};
> +	int ret = IB_MAD_RESULT_SUCCESS;
> +	int rc = 0;
> +
> +	if (in_mad->mad_hdr.mgmt_class  != IB_MGMT_CLASS_PERF_MGMT)
> +		return ret;
> +
> +	switch (in_mad->mad_hdr.attr_id) {
> +	case IB_PMA_CLASS_PORT_INFO:
> +		cpi.capability_mask = IB_PMA_CLASS_CAP_EXT_WIDTH;
> +		memcpy((out_mad->data + 40), &cpi, sizeof(cpi));
> +		break;
> +	case IB_PMA_PORT_COUNTERS_EXT:
> +		rc = bnxt_re_assign_pma_port_ext_counters(rdev, out_mad);
> +		break;
> +	case IB_PMA_PORT_COUNTERS:
> +		rc = bnxt_re_assign_pma_port_counters(rdev, out_mad);
> +		break;
> +	default:
> +		rc = -EINVAL;
> +		break;
> +	}
> +	if (rc)
> +		return IB_MAD_RESULT_FAILURE;
> +	ret |= IB_MAD_RESULT_REPLY;
> +	return ret;
> +}
> +
>  static int UVERBS_HANDLER(BNXT_RE_METHOD_NOTIFY_DRV)(struct uverbs_attr_bundle *attrs)
>  {
>  	struct bnxt_re_ucontext *uctx;
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> index fbb16a4..22c9eb8 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> @@ -268,6 +268,12 @@ void bnxt_re_dealloc_ucontext(struct ib_ucontext *context);
>  int bnxt_re_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
>  void bnxt_re_mmap_free(struct rdma_user_mmap_entry *rdma_entry);
>  
> +int bnxt_re_process_mad(struct ib_device *device, int process_mad_flags,
> +			u32 port_num, const struct ib_wc *in_wc,
> +			const struct ib_grh *in_grh,
> +			const struct ib_mad *in_mad, struct ib_mad *out_mad,
> +			size_t *out_mad_size, u16 *out_mad_pkey_index);
> +
>  static inline u32 __to_ib_port_num(u16 port_id)
>  {
>  	return (u32)port_id + 1;
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index e9e4da4..59ddb36 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -1276,6 +1276,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
>  	.post_recv = bnxt_re_post_recv,
>  	.post_send = bnxt_re_post_send,
>  	.post_srq_recv = bnxt_re_post_srq_recv,
> +	.process_mad = bnxt_re_process_mad,
>  	.query_ah = bnxt_re_query_ah,
>  	.query_device = bnxt_re_query_device,
>  	.modify_device = bnxt_re_modify_device,
> -- 
> 2.5.5
> 

