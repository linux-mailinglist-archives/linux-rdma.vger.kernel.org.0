Return-Path: <linux-rdma+bounces-13307-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B2DB545BC
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 10:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D94AA2B23
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 08:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D453B2D6E43;
	Fri, 12 Sep 2025 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6LK9jVB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736F92D5946;
	Fri, 12 Sep 2025 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666559; cv=none; b=n3Fu+LCt/y/i/Pen9p6UWMep0gw7nj7hURSA0WgdgrsKkxfqrPdqNM5/S5a1Z5xXIfXw3/jmnuC0t5QglAriyDNS7Sd6JGghnLcIjZyZQsy2OFexWesFAjI+rWSJzYLoHh7+qJMfV3Xkobn/dEgcse54lbsiG52JZHhp88DmsWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666559; c=relaxed/simple;
	bh=tC164lnju4nlkcKq4HZ43AZm32SxhQ30U+92JK6VOoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjnXiJuQkEJwR2M6nHd/lB9YliZOIOVpfk2/O0laAioonGkD1nbmKtL4a96wAn0L4og0vThNXk3n5uDCGTeNjCzzwj3dxPeLECA3FGjN0FOfm2gOzTNT4SSwzHl97ZEg1POu/ItYU24iTPZhN+/ITaQE8oGSDb07w2HmxbSYedc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6LK9jVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13389C4CEF4;
	Fri, 12 Sep 2025 08:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757666558;
	bh=tC164lnju4nlkcKq4HZ43AZm32SxhQ30U+92JK6VOoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p6LK9jVBBtGh2HQPAML43tiff6de53N868v8/aC+BfFBwTcGxbtAVMawVuQ2GRDnB
	 Bum4x/NvOeFlFQjR4YajRU3N0QhkltM+UIThlXSGvWHDAX92G6YW/m6XkKj0iazAlh
	 TF0kv+hGO0mFMhk+CsgCDzTx0L4zYOEzEJXKpHMml4eMN/c3Nr8WAMTbYALYaJY2Ck
	 Ml1E5Txm7hjYYP2j/1swR3irtOVq5cwozj8TxALnXriUM+JtGLHX3Kj9Qp2MLoUrV6
	 uEWRKTbCnR6gX98M6zqyYItVgOPYmpygvZWuxJ0C7Dx6tlkVkKSB9L2To/X3+VfxZ2
	 VAzb8fIThH3PA==
Date: Fri, 12 Sep 2025 09:42:34 +0100
From: Simon Horman <horms@kernel.org>
To: Siva Reddy Kallam <siva.kallam@broadcom.com>
Cc: leonro@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, vikas.gupta@broadcom.com,
	selvin.xavier@broadcom.com, anand.subramanian@broadcom.com,
	Usman Ansari <usman.ansari@broadcom.com>
Subject: Re: [PATCH 6/8] RDMA/bng_re: Enable Firmware channel and query
 device attributes
Message-ID: <20250912084234.GT30363@horms.kernel.org>
References: <20250829123042.44459-1-siva.kallam@broadcom.com>
 <20250829123042.44459-7-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829123042.44459-7-siva.kallam@broadcom.com>

On Fri, Aug 29, 2025 at 12:30:40PM +0000, Siva Reddy Kallam wrote:
> Enable Firmware channel and query device attributes
> 
> Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
> Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>

...

> diff --git a/drivers/infiniband/hw/bng_re/bng_sp.c b/drivers/infiniband/hw/bng_re/bng_sp.c

...

> +int bng_re_get_dev_attr(struct bng_re_rcfw *rcfw)
> +{
> +	struct bng_re_dev_attr *attr = rcfw->res->dattr;
> +	struct creq_query_func_resp resp = {};
> +	struct bng_re_cmdqmsg msg = {};
> +	struct creq_query_func_resp_sb *sb;
> +	struct bng_re_rcfw_sbuf sbuf;
> +	struct bng_re_chip_ctx *cctx;
> +	struct cmdq_query_func req = {};
> +	u8 *tqm_alloc;
> +	int i, rc;
> +	u32 temp;
> +
> +	cctx = rcfw->res->cctx;

Similar to my comment on an earlier patch in this series,
cctx appears to be initialised but otherwise unused in this function.


> +	bng_re_rcfw_cmd_prep((struct cmdq_base *)&req,
> +			     CMDQ_BASE_OPCODE_QUERY_FUNC,
> +			     sizeof(req));
> +
> +	sbuf.size = ALIGN(sizeof(*sb), BNG_FW_CMDQE_UNITS);
> +	sbuf.sb = dma_alloc_coherent(&rcfw->pdev->dev, sbuf.size,
> +				     &sbuf.dma_addr, GFP_KERNEL);
> +	if (!sbuf.sb)
> +		return -ENOMEM;
> +	sb = sbuf.sb;
> +	req.resp_size = sbuf.size / BNG_FW_CMDQE_UNITS;
> +	bng_re_fill_cmdqmsg(&msg, &req, &resp, &sbuf, sizeof(req),
> +			    sizeof(resp), 0);
> +	rc = bng_re_rcfw_send_message(rcfw, &msg);
> +	if (rc)
> +		goto bail;
> +	/* Extract the context from the side buffer */
> +	attr->max_qp = le32_to_cpu(sb->max_qp);
> +	/* max_qp value reported by FW doesn't include the QP1 */
> +	attr->max_qp += 1;
> +	attr->max_qp_rd_atom =
> +		sb->max_qp_rd_atom > BNG_RE_MAX_OUT_RD_ATOM ?
> +		BNG_RE_MAX_OUT_RD_ATOM : sb->max_qp_rd_atom;
> +	attr->max_qp_init_rd_atom =
> +		sb->max_qp_init_rd_atom > BNG_RE_MAX_OUT_RD_ATOM ?
> +		BNG_RE_MAX_OUT_RD_ATOM : sb->max_qp_init_rd_atom;
> +	attr->max_qp_wqes = le16_to_cpu(sb->max_qp_wr) - 1;
> +
> +	/* Adjust for max_qp_wqes for variable wqe */
> +	attr->max_qp_wqes = min_t(u32, attr->max_qp_wqes, BNG_VAR_MAX_WQE - 1);
> +
> +	attr->max_qp_sges = min_t(u32, sb->max_sge_var_wqe, BNG_VAR_MAX_SGE);
> +	attr->max_cq = le32_to_cpu(sb->max_cq);
> +	attr->max_cq_wqes = le32_to_cpu(sb->max_cqe);
> +	attr->max_cq_sges = attr->max_qp_sges;
> +	attr->max_mr = le32_to_cpu(sb->max_mr);
> +	attr->max_mw = le32_to_cpu(sb->max_mw);
> +
> +	attr->max_mr_size = le64_to_cpu(sb->max_mr_size);
> +	attr->max_pd = 64 * 1024;
> +	attr->max_raw_ethy_qp = le32_to_cpu(sb->max_raw_eth_qp);
> +	attr->max_ah = le32_to_cpu(sb->max_ah);
> +
> +	attr->max_srq = le16_to_cpu(sb->max_srq);
> +	attr->max_srq_wqes = le32_to_cpu(sb->max_srq_wr) - 1;
> +	attr->max_srq_sges = sb->max_srq_sge;
> +	attr->max_pkey = 1;
> +	attr->max_inline_data = le32_to_cpu(sb->max_inline_data);
> +	/*
> +	 * Read the max gid supported by HW.
> +	 * For each entry in HW  GID in HW table, we consume 2
> +	 * GID entries in the kernel GID table.  So max_gid reported
> +	 * to stack can be up to twice the value reported by the HW, up to 256 gids.
> +	 */
> +	attr->max_sgid = le32_to_cpu(sb->max_gid);
> +	attr->max_sgid = min_t(u32, BNG_RE_NUM_GIDS_SUPPORTED, 2 * attr->max_sgid);
> +	attr->dev_cap_flags = le16_to_cpu(sb->dev_cap_flags);
> +	attr->dev_cap_flags2 = le16_to_cpu(sb->dev_cap_ext_flags_2);
> +
> +	if (_is_max_srq_ext_supported(attr->dev_cap_flags2))
> +		attr->max_srq += le16_to_cpu(sb->max_srq_ext);
> +
> +	bng_re_query_version(rcfw, attr->fw_ver);
> +	for (i = 0; i < BNG_MAX_TQM_ALLOC_REQ / 4; i++) {
> +		temp = le32_to_cpu(sb->tqm_alloc_reqs[i]);
> +		tqm_alloc = (u8 *)&temp;
> +		attr->tqm_alloc_reqs[i * 4] = *tqm_alloc;
> +		attr->tqm_alloc_reqs[i * 4 + 1] = *(++tqm_alloc);
> +		attr->tqm_alloc_reqs[i * 4 + 2] = *(++tqm_alloc);
> +		attr->tqm_alloc_reqs[i * 4 + 3] = *(++tqm_alloc);
> +	}
> +
> +	attr->max_dpi = le32_to_cpu(sb->max_dpi);
> +	attr->is_atomic = bng_re_is_atomic_cap(rcfw);
> +bail:
> +	dma_free_coherent(&rcfw->pdev->dev, sbuf.size,
> +			  sbuf.sb, sbuf.dma_addr);
> +	return rc;
> +}

...

