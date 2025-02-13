Return-Path: <linux-rdma+bounces-7693-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35E0A3345C
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 02:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D17D163031
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 01:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04C07081A;
	Thu, 13 Feb 2025 01:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NwZLORus"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACA86FC3;
	Thu, 13 Feb 2025 01:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739408531; cv=none; b=VHBilGgXDQhOJ5UWcIsOR+uK6cEV06Q9Et3RPADokpAa/5IPvoxV0ch6Vg6NJYn5SIReI+Rj9PtXXIWaosrX646Lgrtdtn/98ipUzXfv5bs6Rwq4lsiV9QX58KJEK4v0YOX9jF+vI2YnTzEzL8YFaM78fJLhsG6G0IcBcRM/Gy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739408531; c=relaxed/simple;
	bh=xaD2/poxUrEC/UvM0cFUpIcvenlnTiEEfxl21TNjaLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jpOhV6VBS2U/FLSeILF04wHFEXmfMrpap9ct9Yyyjy6gKTJw+hkmzbbz5aan3XKKAKgYdTbycDFTSxqqib9WeVrGB7f3S5hX14tB7SF6odGavLN7rh6h0DBP4CsflxipsbmOziej7DnjFrUBQx50MkH75jgl/qeIjBNw9d7VBsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NwZLORus; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739408529; x=1770944529;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xaD2/poxUrEC/UvM0cFUpIcvenlnTiEEfxl21TNjaLo=;
  b=NwZLORusQARJab0p5d3lib6pSWoJQ6BtasRvqNz9BhH3ugpc71fmQ3sg
   idteP4jvo7SYbLDLGzVHF3VHlCZyu+C/zyOGk8dQeE7Nb4krS/2xy4fS2
   nVA4ngVvT5WnY+ikJ0tt48crrD/3tqOe8RItfY8YMO7ASHBRnuDc/Roeg
   PjsdW5AhTZsAzCk3Dud9D+sbXcpRpNkmMNPEs8E7gc/6/1sP9WBIDH2AA
   L4/N2IpMttaMtn0XlxRGQtNqDWHArrIyOfGPcMVTjawsKV+2EYUV6A8iG
   JU/cF0GTfpPA0PJVh/mxqj/CMILw/dMqmVYJ2LVKkItaP2LMgQGQUepo/
   w==;
X-CSE-ConnectionGUID: zDpyNfafRgyIA9jhTsNfpw==
X-CSE-MsgGUID: pCFxt5E2TVGqKtsW7UjxOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="50718273"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="50718273"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 17:02:08 -0800
X-CSE-ConnectionGUID: jZc693COTii5KhQePibepg==
X-CSE-MsgGUID: eyfnlNLkTp6R13bV4rsbwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113891240"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.128]) ([10.125.108.128])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 17:02:06 -0800
Message-ID: <d8a77435-0a52-4f2e-8407-65a0e5cc14c3@intel.com>
Date: Wed, 12 Feb 2025 18:02:05 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH fwctl 4/5] pds_fwctl: add rpc and query support
To: Shannon Nelson <shannon.nelson@amd.com>, jgg@nvidia.com,
 andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
 dan.j.williams@intel.com, daniel.vetter@ffwll.ch, dsahern@kernel.org,
 gospo@broadcom.com, hch@infradead.org, itayavr@nvidia.com, jiri@nvidia.com,
 Jonathan.Cameron@huawei.com, kuba@kernel.org, lbloch@nvidia.com,
 leonro@nvidia.com, saeedm@nvidia.com, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Cc: brett.creeley@amd.com
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <20250211234854.52277-5-shannon.nelson@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211234854.52277-5-shannon.nelson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 4:48 PM, Shannon Nelson wrote:
> From: Brett Creeley <brett.creeley@amd.com>
> 
> The pds_fwctl driver doesn't know what RPC operations are available
> in the firmware, so also doesn't know what scope they might have.  The
> userland utility supplies the firmware "endpoint" and "operation" id values
> and this driver queries the firmware for endpoints and their available
> operations.  The operation descriptions include the scope information
> which the driver uses for scope testing.
> 
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  drivers/fwctl/pds/main.c       | 369 ++++++++++++++++++++++++++++++++-
>  include/linux/pds/pds_adminq.h | 187 +++++++++++++++++
>  include/uapi/fwctl/pds.h       |  16 ++
>  3 files changed, 569 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
> index 24979fe0deea..b60a66ef1fac 100644
> --- a/drivers/fwctl/pds/main.c
> +++ b/drivers/fwctl/pds/main.c
> @@ -15,12 +15,22 @@
>  #include <linux/pds/pds_adminq.h>
>  #include <linux/pds/pds_auxbus.h>
>  
> +DEFINE_FREE(kfree_errptr, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T));
> +DEFINE_FREE(kvfree_errptr, void *, if (!IS_ERR_OR_NULL(_T)) kvfree(_T));
> +
>  struct pdsfc_uctx {
>  	struct fwctl_uctx uctx;
>  	u32 uctx_caps;
>  	u32 uctx_uid;
>  };
>  
> +struct pdsfc_rpc_endpoint_info {
> +	u32 endpoint;
> +	dma_addr_t operations_pa;
> +	struct pds_fwctl_query_data *operations;
> +	struct mutex lock;	/* lock for endpoint info management */
> +};
> +
>  struct pdsfc_dev {
>  	struct fwctl_device fwctl;
>  	struct pds_auxiliary_dev *padev;
> @@ -28,6 +38,9 @@ struct pdsfc_dev {
>  	u32 caps;
>  	dma_addr_t ident_pa;
>  	struct pds_fwctl_ident *ident;
> +	dma_addr_t endpoints_pa;
> +	struct pds_fwctl_query_data *endpoints;
> +	struct pdsfc_rpc_endpoint_info *endpoint_info;
>  };
>  DEFINE_FREE(pdsfc_dev, struct pdsfc_dev *, if (_T) fwctl_put(&_T->fwctl));
>  
> @@ -112,10 +125,351 @@ static int pdsfc_identify(struct pdsfc_dev *pdsfc)
>  	return 0;
>  }
>  
> +static void pdsfc_free_endpoints(struct pdsfc_dev *pdsfc)
> +{
> +	struct device *dev = &pdsfc->fwctl.dev;
> +
> +	if (pdsfc->endpoints) {
> +		int i;
> +
> +		for (i = 0; pdsfc->endpoint_info && i < pdsfc->endpoints->num_entries; i++)
> +			mutex_destroy(&pdsfc->endpoint_info[i].lock);
> +		vfree(pdsfc->endpoint_info);
> +		pdsfc->endpoint_info = NULL;
> +		dma_free_coherent(dev->parent, PAGE_SIZE,
> +				  pdsfc->endpoints, pdsfc->endpoints_pa);
> +		pdsfc->endpoints = NULL;
> +		pdsfc->endpoints_pa = DMA_MAPPING_ERROR;
> +	}
> +}
> +
> +static void pdsfc_free_operations(struct pdsfc_dev *pdsfc)
> +{
> +	struct device *dev = &pdsfc->fwctl.dev;
> +	int i;
> +
> +	for (i = 0; i < pdsfc->endpoints->num_entries; i++) {
> +		struct pdsfc_rpc_endpoint_info *ei = &pdsfc->endpoint_info[i];
> +
> +		if (ei->operations) {
> +			dma_free_coherent(dev->parent, PAGE_SIZE,
> +					  ei->operations, ei->operations_pa);
> +			ei->operations = NULL;
> +			ei->operations_pa = DMA_MAPPING_ERROR;
> +		}
> +	}
> +}
> +
> +static struct pds_fwctl_query_data *pdsfc_get_endpoints(struct pdsfc_dev *pdsfc,
> +							dma_addr_t *pa)
> +{
> +	struct pds_fwctl_query_data_endpoint *entries = NULL;
> +	struct device *dev = &pdsfc->fwctl.dev;
> +	union pds_core_adminq_comp comp = {0};
> +	union pds_core_adminq_cmd cmd = {0};
> +	struct pds_fwctl_query_data *data;
> +	dma_addr_t data_pa;
> +	int err;
> +	int i;
> +
> +	data = dma_alloc_coherent(dev->parent, PAGE_SIZE, &data_pa, GFP_KERNEL);
> +	err = dma_mapping_error(dev, data_pa);
> +	if (err) {
> +		dev_err(dev, "Failed to map endpoint list\n");
> +		return ERR_PTR(err);
> +	}
> +
> +	cmd.fwctl_query.opcode = PDS_FWCTL_CMD_QUERY;
> +	cmd.fwctl_query.entity = PDS_FWCTL_RPC_ROOT;
> +	cmd.fwctl_query.version = 0;
> +	cmd.fwctl_query.query_data_buf_len = cpu_to_le32(PAGE_SIZE);
> +	cmd.fwctl_query.query_data_buf_pa = cpu_to_le64(data_pa);
> +
> +	dev_dbg(dev, "cmd: opcode %d entity %d version %d query_data_buf_len %d query_data_buf_pa %llx\n",
> +		cmd.fwctl_query.opcode, cmd.fwctl_query.entity, cmd.fwctl_query.version,
> +		le32_to_cpu(cmd.fwctl_query.query_data_buf_len),
> +		le64_to_cpu(cmd.fwctl_query.query_data_buf_pa));
> +
> +	err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
> +	if (err) {
> +		dev_err(dev, "Failed to send adminq cmd opcode: %u entity: %u err: %d\n",
> +			cmd.fwctl_query.opcode, cmd.fwctl_query.entity, err);
> +		dma_free_coherent(dev->parent, PAGE_SIZE, data, data_pa);
> +		return ERR_PTR(err);
> +	}
> +
> +	*pa = data_pa;
> +
> +	entries = (struct pds_fwctl_query_data_endpoint *)data->entries;
> +	dev_dbg(dev, "num_entries %d\n", data->num_entries);
> +	for (i = 0; i < data->num_entries; i++)

I think you need to convert num_entries from __le32 to host for the above 2 lines?

> +		dev_dbg(dev, "endpoint: id %d\n", entries[i].id);
> +
> +	return data;
> +}
> +
> +static int pdsfc_init_endpoints(struct pdsfc_dev *pdsfc)
> +{
> +	struct pds_fwctl_query_data_endpoint *ep_entry;
> +	struct device *dev = &pdsfc->fwctl.dev;
> +	int i;
> +
> +	pdsfc->endpoints = pdsfc_get_endpoints(pdsfc, &pdsfc->endpoints_pa);
> +	if (IS_ERR(pdsfc->endpoints)) {
> +		dev_err(dev, "Failed to query endpoints\n");
> +		return PTR_ERR(pdsfc->endpoints);
> +	}
> +
> +	pdsfc->endpoint_info = vcalloc(pdsfc->endpoints->num_entries,
> +				       sizeof(*pdsfc->endpoint_info));
> +	if (!pdsfc->endpoint_info) {
> +		dev_err(dev, "Failed to allocate endpoint_info array\n");
> +		pdsfc_free_endpoints(pdsfc);
> +		return -ENOMEM;
> +	}
> +
> +	ep_entry = (struct pds_fwctl_query_data_endpoint *)pdsfc->endpoints->entries;
> +	for (i = 0; i < pdsfc->endpoints->num_entries; i++) {
> +		mutex_init(&pdsfc->endpoint_info[i].lock);
> +		pdsfc->endpoint_info[i].endpoint = ep_entry[i].id;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct pds_fwctl_query_data *pdsfc_get_operations(struct pdsfc_dev *pdsfc,
> +							 dma_addr_t *pa, u32 ep)
> +{
> +	struct pds_fwctl_query_data_operation *entries = NULL;
> +	struct device *dev = &pdsfc->fwctl.dev;
> +	union pds_core_adminq_comp comp = {0};
> +	union pds_core_adminq_cmd cmd = {0};
> +	struct pds_fwctl_query_data *data;
> +	dma_addr_t data_pa;
> +	int err;
> +	int i;
> +
> +	/* Query the operations list for the given endpoint */
> +	data = dma_alloc_coherent(dev->parent, PAGE_SIZE, &data_pa, GFP_KERNEL);
> +	err = dma_mapping_error(dev->parent, data_pa);
> +	if (err) {
> +		dev_err(dev, "Failed to map operations list\n");
> +		return ERR_PTR(err);
> +	}
> +
> +	cmd.fwctl_query.opcode = PDS_FWCTL_CMD_QUERY;
> +	cmd.fwctl_query.entity = PDS_FWCTL_RPC_ENDPOINT;
> +	cmd.fwctl_query.version = 0;
> +	cmd.fwctl_query.query_data_buf_len = cpu_to_le32(PAGE_SIZE);
> +	cmd.fwctl_query.query_data_buf_pa = cpu_to_le64(data_pa);
> +	cmd.fwctl_query.ep = cpu_to_le32(ep);
> +
> +	err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
> +	if (err) {
> +		dev_err(dev, "Failed to send adminq cmd opcode: %u entity: %u err: %d\n",
> +			cmd.fwctl_query.opcode, cmd.fwctl_query.entity, err);
> +		dma_free_coherent(dev->parent, PAGE_SIZE, data, data_pa);
> +		return ERR_PTR(err);
> +	}
> +
> +	*pa = data_pa;
> +
> +	entries = (struct pds_fwctl_query_data_operation *)data->entries;
> +	dev_dbg(dev, "num_entries %d\n", data->num_entries);
> +	for (i = 0; i < data->num_entries; i++)
> +		dev_dbg(dev, "endpoint %d operation: id %x scope %d\n",
> +			ep, entries[i].id, entries[i].scope);
> +
> +	return data;
> +}
> +
> +static int pdsfc_validate_rpc(struct pdsfc_dev *pdsfc,
> +			      struct fwctl_rpc_pds *rpc,
> +			      enum fwctl_rpc_scope scope)
> +{
> +	struct pds_fwctl_query_data_operation *op_entry = NULL;
> +	struct pdsfc_rpc_endpoint_info *ep_info = NULL;
> +	struct device *dev = &pdsfc->fwctl.dev;
> +	int i;
> +
> +	if (!pdsfc->ident) {
> +		dev_err(dev, "Ident not available\n");
> +		return -EINVAL;
> +	}
> +
> +	/* validate rpc in_len & out_len based
> +	 * on ident->max_req_sz & max_resp_sz
> +	 */
> +	if (rpc->in.len > pdsfc->ident->max_req_sz) {
> +		dev_err(dev, "Invalid request size %u, max %u\n",
> +			rpc->in.len, pdsfc->ident->max_req_sz);
> +		return -EINVAL;
> +	}
> +
> +	if (rpc->out.len > pdsfc->ident->max_resp_sz) {
> +		dev_err(dev, "Invalid response size %u, max %u\n",
> +			rpc->out.len, pdsfc->ident->max_resp_sz);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < pdsfc->endpoints->num_entries; i++) {
> +		if (pdsfc->endpoint_info[i].endpoint == rpc->in.ep) {
> +			ep_info = &pdsfc->endpoint_info[i];
> +			break;
> +		}
> +	}
> +	if (!ep_info) {
> +		dev_err(dev, "Invalid endpoint %d\n", rpc->in.ep);
> +		return -EINVAL;
> +	}
> +
> +	/* query and cache this endpoint's operations */
> +	mutex_lock(&ep_info->lock);
> +	if (!ep_info->operations) {
> +		ep_info->operations = pdsfc_get_operations(pdsfc,
> +							   &ep_info->operations_pa,
> +							   rpc->in.ep);
> +		if (!ep_info->operations) {
> +			mutex_unlock(&ep_info->lock);
> +			dev_err(dev, "Failed to allocate operations list\n");
> +			return -ENOMEM;
> +		}
> +	}
> +	mutex_unlock(&ep_info->lock);
> +
> +	/* reject unsupported and/or out of scope commands */
> +	op_entry = (struct pds_fwctl_query_data_operation *)ep_info->operations->entries;
> +	for (i = 0; i < ep_info->operations->num_entries; i++) {
> +		if (PDS_FWCTL_RPC_OPCODE_CMP(rpc->in.op, op_entry[i].id)) {
> +			if (scope < op_entry[i].scope)
> +				return -EPERM;
> +			return 0;
> +		}
> +	}
> +
> +	dev_err(dev, "Invalid operation %d for endpoint %d\n", rpc->in.op, rpc->in.ep);
> +
> +	return -EINVAL;
> +}
> +
>  static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>  			  void *in, size_t in_len, size_t *out_len)
>  {
> -	return NULL;
> +	struct pdsfc_dev *pdsfc = container_of(uctx->fwctl, struct pdsfc_dev, fwctl);
> +	struct fwctl_rpc_pds *rpc = (struct fwctl_rpc_pds *)in;
> +	void *out_payload __free(kfree_errptr) = NULL;
> +	void *in_payload __free(kfree_errptr) = NULL;

__free(kfree) should work from kzalloc(). No need to define special macro.

> +	struct device *dev = &uctx->fwctl->dev;
> +	union pds_core_adminq_comp comp = {0};
> +	dma_addr_t out_payload_dma_addr = 0;
> +	union pds_core_adminq_cmd cmd = {0};
> +	dma_addr_t in_payload_dma_addr = 0;
> +	void *out = NULL;
> +	int err;
> +
> +	err = pdsfc_validate_rpc(pdsfc, rpc, scope);
> +	if (err) {
> +		dev_err(dev, "Invalid RPC request\n");
> +		return ERR_PTR(err);
> +	}
> +
> +	if (rpc->in.len > 0) {
> +		in_payload = kzalloc(rpc->in.len, GFP_KERNEL);
> +		if (!in_payload) {
> +			dev_err(dev, "Failed to allocate in_payload\n");
> +			out = ERR_PTR(-ENOMEM);
> +			goto done;
> +		}
> +
> +		if (copy_from_user(in_payload, u64_to_user_ptr(rpc->in.payload),
> +				   rpc->in.len)) {
> +			dev_err(dev, "Failed to copy in_payload from user\n");
> +			out = ERR_PTR(-EFAULT);
> +			goto done;
> +		}

So the cleanup macros and gotos here make things a bit messy. But maybe you can define a transient struct:
struct payload {
	void *data;
	dma_addr_t dma;
	size_t len;
	struct device *dev;
	enum dma_data_direction dir;
};

static inline void cleanup_payload(struct payload *payload)
{
	dma_unmap_single(payload->dev, payload->dma, payload->len, payload->dir);
	kfree(payload->data);
	kfree(payload);
}
DEFINE_FREE(free_payload, struct payload *, if (_T) cleanup_payload(_T));

static struct payload *alloc_payload(struct device *dev, size_t len, enum dma_data_direction dir)
{
	dma_addr_t dma;
	int err;

	struct payload *p __free(kfree) = kzalloc(sizeof(*p), GFP_KERNEL);
	if (!p)
		return NULL;

	void *data __free(kfree) = kzalloc(len, GFP_KERNEL);
	if (!data)
		return NULL;

	dma = dma_map_single(dev, data, len, dir);
	err = dma_mapping_error(dev, dma);
	if (err)
		return NULL;

	p->dma = dma;
	p->len = len;
	p->dir = dir;
	p->data = no_free_ptr(data); 

	return no_free_ptr(p);	
}

With that you can use __free() cleanly and then when your rpc function exits, it'll unmap and free everything automatically. 

struct payload *p __free(free_payload) = alloc_payload(...);

Just a thought....

> +
> +		in_payload_dma_addr = dma_map_single(dev->parent, in_payload,
> +						     rpc->in.len, DMA_TO_DEVICE);
> +		err = dma_mapping_error(dev->parent, in_payload_dma_addr);
> +		if (err) {
> +			dev_err(dev, "Failed to map in_payload\n");
> +			out = ERR_PTR(err);
> +			goto done;
> +		}
> +	}
> +
> +	if (rpc->out.len > 0) {
> +		out_payload = kzalloc(rpc->out.len, GFP_KERNEL);
> +		if (!out_payload) {
> +			dev_err(dev, "Failed to allocate out_payload\n");
> +			out = ERR_PTR(-ENOMEM);
> +			goto done;
> +		}
> +
> +		out_payload_dma_addr = dma_map_single(dev->parent, out_payload,
> +						      rpc->out.len, DMA_FROM_DEVICE);
> +		err = dma_mapping_error(dev->parent, out_payload_dma_addr);
> +		if (err) {
> +			dev_err(dev, "Failed to map out_payload\n");
> +			out = ERR_PTR(err);
> +			goto done;
> +		}
> +	}
> +
> +	cmd.fwctl_rpc.opcode = PDS_FWCTL_CMD_RPC;
> +	cmd.fwctl_rpc.flags = PDS_FWCTL_RPC_IND_REQ | PDS_FWCTL_RPC_IND_RESP;
> +	cmd.fwctl_rpc.ep = cpu_to_le32(rpc->in.ep);
> +	cmd.fwctl_rpc.op = cpu_to_le32(rpc->in.op);
> +	cmd.fwctl_rpc.req_pa = cpu_to_le64(in_payload_dma_addr);
> +	cmd.fwctl_rpc.req_sz = cpu_to_le32(rpc->in.len);
> +	cmd.fwctl_rpc.resp_pa = cpu_to_le64(out_payload_dma_addr);
> +	cmd.fwctl_rpc.resp_sz = cpu_to_le32(rpc->out.len);
> +
> +	dev_dbg(dev, "%s: ep %d op %x req_pa %llx req_sz %d req_sg %d resp_pa %llx resp_sz %d resp_sg %d\n",
> +		__func__, rpc->in.ep, rpc->in.op,
> +		cmd.fwctl_rpc.req_pa, cmd.fwctl_rpc.req_sz, cmd.fwctl_rpc.req_sg_elems,
> +		cmd.fwctl_rpc.resp_pa, cmd.fwctl_rpc.resp_sz, cmd.fwctl_rpc.resp_sg_elems);
> +
> +	dynamic_hex_dump("in ", DUMP_PREFIX_OFFSET, 16, 1, in_payload, rpc->in.len, true);
> +
> +	err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
> +	if (err) {
> +		dev_err(dev, "%s: ep %d op %x req_pa %llx req_sz %d req_sg %d resp_pa %llx resp_sz %d resp_sg %d err %d\n",
> +			__func__, rpc->in.ep, rpc->in.op,
> +			cmd.fwctl_rpc.req_pa, cmd.fwctl_rpc.req_sz, cmd.fwctl_rpc.req_sg_elems,
> +			cmd.fwctl_rpc.resp_pa, cmd.fwctl_rpc.resp_sz, cmd.fwctl_rpc.resp_sg_elems,
> +			err);
> +		out = ERR_PTR(err);
> +		goto done;
> +	}
> +
> +	dynamic_hex_dump("out ", DUMP_PREFIX_OFFSET, 16, 1, out_payload, rpc->out.len, true);
> +
> +	dev_dbg(dev, "%s: status %d comp_index %d err %d resp_sz %d color %d\n",
> +		__func__, comp.fwctl_rpc.status, comp.fwctl_rpc.comp_index,
> +		comp.fwctl_rpc.err, comp.fwctl_rpc.resp_sz,
> +		comp.fwctl_rpc.color);
> +
> +	if (copy_to_user(u64_to_user_ptr(rpc->out.payload), out_payload, rpc->out.len)) {
> +		dev_err(dev, "Failed to copy out_payload to user\n");
> +		out = ERR_PTR(-EFAULT);
> +		goto done;
> +	}
> +
> +	rpc->out.retval = le32_to_cpu(comp.fwctl_rpc.err);
> +	*out_len = in_len;
> +	out = in;
> +
> +done:
> +	if (in_payload_dma_addr)
> +		dma_unmap_single(dev->parent, in_payload_dma_addr,
> +				 rpc->in.len, DMA_TO_DEVICE);
> +
> +	if (out_payload_dma_addr)
> +		dma_unmap_single(dev->parent, out_payload_dma_addr,
> +				 rpc->out.len, DMA_FROM_DEVICE);
> +
> +	return out;
>  }
>  
>  static const struct fwctl_ops pdsfc_ops = {
> @@ -150,16 +504,23 @@ static int pdsfc_probe(struct auxiliary_device *adev,
>  		return err;
>  	}
>  
> +	err = pdsfc_init_endpoints(pdsfc);
> +	if (err) {
> +		dev_err(dev, "Failed to init endpoints, err %d\n", err);
> +		goto free_ident;
> +	}
> +
>  	err = fwctl_register(&pdsfc->fwctl);
>  	if (err) {
>  		dev_err(dev, "Failed to register device, err %d\n", err);
> -		return err;
> +		goto free_endpoints;
>  	}
> -
>  	auxiliary_set_drvdata(adev, no_free_ptr(pdsfc));
>  
>  	return 0;
>  
> +free_endpoints:
> +	pdsfc_free_endpoints(pdsfc);
>  free_ident:
>  	pdsfc_free_ident(pdsfc);
>  	return err;
> @@ -170,6 +531,8 @@ static void pdsfc_remove(struct auxiliary_device *adev)
>  	struct pdsfc_dev *pdsfc  __free(pdsfc_dev) = auxiliary_get_drvdata(adev);
>  
>  	fwctl_unregister(&pdsfc->fwctl);
> +	pdsfc_free_operations(pdsfc);
> +	pdsfc_free_endpoints(pdsfc);
>  	pdsfc_free_ident(pdsfc);
>  }
>  
> diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
> index 7fc353b63353..33cd03388b15 100644
> --- a/include/linux/pds/pds_adminq.h
> +++ b/include/linux/pds/pds_adminq.h
> @@ -1181,6 +1181,8 @@ struct pds_lm_host_vf_status_cmd {
>  
>  enum pds_fwctl_cmd_opcode {
>  	PDS_FWCTL_CMD_IDENT		= 70,
> +	PDS_FWCTL_CMD_RPC		= 71,
> +	PDS_FWCTL_CMD_QUERY		= 72,
>  };
>  
>  /**
> @@ -1251,6 +1253,187 @@ struct pds_fwctl_ident {
>  	u8     max_resp_sg_elems;
>  } __packed;
>  
> +enum pds_fwctl_query_entity {
> +	PDS_FWCTL_RPC_ROOT	= 0,
> +	PDS_FWCTL_RPC_ENDPOINT	= 1,
> +	PDS_FWCTL_RPC_OPERATION	= 2,
> +};
> +
> +#define PDS_FWCTL_RPC_OPCODE_CMD_SHIFT	0
> +#define PDS_FWCTL_RPC_OPCODE_CMD_MASK	GENMASK(15, PDS_FWCTL_RPC_OPCODE_CMD_SHIFT)
> +#define PDS_FWCTL_RPC_OPCODE_VER_SHIFT	16
> +#define PDS_FWCTL_RPC_OPCODE_VER_MASK	GENMASK(23, PDS_FWCTL_RPC_OPCODE_VER_SHIFT)
> +
> +#define PDS_FWCTL_RPC_OPCODE_GET_CMD(op)	\
> +	(((op) & PDS_FWCTL_RPC_OPCODE_CMD_MASK) >> PDS_FWCTL_RPC_OPCODE_CMD_SHIFT)
> +#define PDS_FWCTL_RPC_OPCODE_GET_VER(op)	\
> +	(((op) & PDS_FWCTL_RPC_OPCODE_VER_MASK) >> PDS_FWCTL_RPC_OPCODE_VER_SHIFT)
> +
> +#define PDS_FWCTL_RPC_OPCODE_CMP(op1, op2) \
> +	(PDS_FWCTL_RPC_OPCODE_GET_CMD(op1) == PDS_FWCTL_RPC_OPCODE_GET_CMD(op2) && \
> +	 PDS_FWCTL_RPC_OPCODE_GET_VER(op1) <= PDS_FWCTL_RPC_OPCODE_GET_VER(op2))
> +
> +/**
> + * struct pds_fwctl_query_cmd - Firmware control query command structure
> + * @opcode: Operation code for the command
> + * @entity:  Entity type to query (enum pds_fwctl_query_entity)
> + * @version: Version of the query data structure supported by the driver
> + * @rsvd:    Word boundary padding
> + * @query_data_buf_len: Length of the query data buffer
> + * @query_data_buf_pa:  Physical address of the query data buffer
> + * @ep:      Endpoint identifier to query  (when entity is PDS_FWCTL_RPC_ENDPOINT)
> + * @op:      Operation identifier to query (when entity is PDS_FWCTL_RPC_OPERATION)
> + *
> + * This structure is used to send a query command to the firmware control
> + * interface. The structure is packed to ensure there is no padding between
> + * the fields.
> + */
> +struct pds_fwctl_query_cmd {
> +	u8     opcode;
> +	u8     entity;
> +	u8     version;
> +	u8     rsvd;
> +	__le32 query_data_buf_len;
> +	__le64 query_data_buf_pa;
> +	union {
> +		__le32 ep;
> +		__le32 op;
> +	};
> +} __packed;
> +
> +/**
> + * struct pds_fwctl_query_comp - Firmware control query completion structure
> + * @status:     Status of the query command
> + * @rsvd:       Word boundary padding
> + * @comp_index: Completion index in little-endian format
> + * @version:    Version of the query data structure returned by firmware. This
> + *		 should be less than or equal to the version supported by the driver.
> + * @rsvd2:      Word boundary padding
> + * @color:      Color bit indicating the state of the completion
> + */
> +struct pds_fwctl_query_comp {
> +	u8     status;
> +	u8     rsvd;
> +	__le16 comp_index;
> +	u8     version;
> +	u8     rsvd2[2];
> +	u8     color;
> +} __packed;
> +
> +/**
> + * struct pds_fwctl_query_data_endpoint - query data for entity PDS_FWCTL_RPC_ROOT
> + * @id: The identifier for the data endpoint.
> + */
> +struct pds_fwctl_query_data_endpoint {
> +	__le32 id;
> +} __packed;
> +
> +/**
> + * struct pds_fwctl_query_data_operation - query data for entity PDS_FWCTL_RPC_ENDPOINT
> + * @id:    Operation identifier.
> + * @scope: Scope of the operation (enum fwctl_rpc_scope).
> + * @rsvd:  Word boundary padding
> + */
> +struct pds_fwctl_query_data_operation {
> +	__le32 id;
> +	u8     scope;
> +	u8     rsvd[3];
> +} __packed;
> +
> +/**
> + * struct pds_fwctl_query_data - query data structure
> + * @version:     Version of the query data structure
> + * @rsvd:        Word boundary padding
> + * @num_entries: Number of entries in the union
> + * @entries:     Array of query data entries, depending on the entity type.
> + */
> +struct pds_fwctl_query_data {
> +	u8      version;
> +	u8      rsvd[3];
> +	__le32  num_entries;
> +	uint8_t entries[];
Why u8 above but uint8_t here?

u8 entries[] __counted_by_le(num_entries);

DJ

> +} __packed;
> +
> +/**
> + * struct pds_fwctl_rpc_cmd - Firmware control RPC command.
> + * @opcode:        opcode PDS_FWCTL_CMD_RPC
> + * @rsvd:          Word boundary padding
> + * @flags:         Indicates indirect request and/or response handling
> + * @ep:            Endpoint identifier.
> + * @op:            Operation identifier.
> + * @inline_req0:   Buffer for inline request
> + * @inline_req1:   Buffer for inline request
> + * @req_pa:        Physical address of request data.
> + * @req_sz:        Size of the request.
> + * @req_sg_elems:  Number of request SGs
> + * @req_rsvd:      Word boundary padding
> + * @inline_req2:   Buffer for inline request
> + * @resp_pa:       Physical address of response data.
> + * @resp_sz:       Size of the response.
> + * @resp_sg_elems: Number of response SGs
> + * @resp_rsvd:     Word boundary padding
> + */
> +struct pds_fwctl_rpc_cmd {
> +	u8     opcode;
> +	u8     rsvd;
> +	__le16 flags;
> +#define PDS_FWCTL_RPC_IND_REQ		0x1
> +#define PDS_FWCTL_RPC_IND_RESP		0x2
> +	__le32 ep;
> +	__le32 op;
> +	u8 inline_req0[16];
> +	union {
> +		u8 inline_req1[16];
> +		struct {
> +			__le64 req_pa;
> +			__le32 req_sz;
> +			u8     req_sg_elems;
> +			u8     req_rsvd[3];
> +		};
> +	};
> +	union {
> +		u8 inline_req2[16];
> +		struct {
> +			__le64 resp_pa;
> +			__le32 resp_sz;
> +			u8     resp_sg_elems;
> +			u8     resp_rsvd[3];
> +		};
> +	};
> +} __packed;
> +
> +/**
> + * struct pds_sg_elem - Transmit scatter-gather (SG) descriptor element
> + * @addr:	DMA address of SG element data buffer
> + * @len:	Length of SG element data buffer, in bytes
> + * @rsvd:	Word boundary padding
> + */
> +struct pds_sg_elem {
> +	__le64 addr;
> +	__le32 len;
> +	__le16 rsvd[2];
> +} __packed;
> +
> +/**
> + * struct pds_fwctl_rpc_comp - Completion of a firmware control RPC.
> + * @status:     Status of the command
> + * @rsvd:       Word boundary padding
> + * @comp_index: Completion index of the command
> + * @err:        Error code, if any, from the RPC.
> + * @resp_sz:    Size of the response.
> + * @rsvd2:      Word boundary padding
> + * @color:      Color bit indicating the state of the completion.
> + */
> +struct pds_fwctl_rpc_comp {
> +	u8     status;
> +	u8     rsvd;
> +	__le16 comp_index;
> +	__le32 err;
> +	__le32 resp_sz;
> +	u8     rsvd2[3];
> +	u8     color;
> +} __packed;
> +
>  union pds_core_adminq_cmd {
>  	u8     opcode;
>  	u8     bytes[64];
> @@ -1291,6 +1474,8 @@ union pds_core_adminq_cmd {
>  
>  	struct pds_fwctl_cmd		  fwctl;
>  	struct pds_fwctl_ident_cmd	  fwctl_ident;
> +	struct pds_fwctl_rpc_cmd	  fwctl_rpc;
> +	struct pds_fwctl_query_cmd	  fwctl_query;
>  };
>  
>  union pds_core_adminq_comp {
> @@ -1320,6 +1505,8 @@ union pds_core_adminq_comp {
>  	struct pds_lm_dirty_status_comp	  lm_dirty_status;
>  
>  	struct pds_fwctl_comp		  fwctl;
> +	struct pds_fwctl_rpc_comp	  fwctl_rpc;
> +	struct pds_fwctl_query_comp	  fwctl_query;
>  };
>  
>  #ifndef __CHECKER__
> diff --git a/include/uapi/fwctl/pds.h b/include/uapi/fwctl/pds.h
> index a01b032cbdb1..da6cd2d1c6fa 100644
> --- a/include/uapi/fwctl/pds.h
> +++ b/include/uapi/fwctl/pds.h
> @@ -24,4 +24,20 @@ enum pds_fwctl_capabilities {
>  	PDS_FWCTL_QUERY_CAP = 0,
>  	PDS_FWCTL_SEND_CAP,
>  };
> +
> +struct fwctl_rpc_pds {
> +	struct {
> +		__u32 op;
> +		__u32 ep;
> +		__u32 rsvd;
> +		__u32 len;
> +		__u64 payload;
> +	} in;
> +	struct {
> +		__u32 retval;
> +		__u32 rsvd[2];
> +		__u32 len;
> +		__u64 payload;
> +	} out;
> +};
>  #endif /* _UAPI_FWCTL_PDS_H_ */


