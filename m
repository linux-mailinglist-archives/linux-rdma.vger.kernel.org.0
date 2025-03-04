Return-Path: <linux-rdma+bounces-8296-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E750BA4D79E
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 10:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E83D1889FB1
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 09:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C43B1FCF74;
	Tue,  4 Mar 2025 09:08:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C331FCCFF;
	Tue,  4 Mar 2025 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741079315; cv=none; b=UE9rNSZbuhqGsuCiW+c14sewYDIrHa9APAlkvl4yD4k5kGUY/eXu0Eg0lJwjSTKRPe/N2fAMu+5f6yfKENxObH298rjiviQQo0oZGI24sZ5SqWJcT8HK6mvL3d200WCsPoMEx5Z6uPDodrstFHm3l1mxAdRQv2Vacjj81JRkqKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741079315; c=relaxed/simple;
	bh=CoCC/2E7FyvFKauGF/kQWWPV9vKE8tzRMGllp4g9QUA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIVK9nlCKKbfxypoi/k6BzClkGI4dd3tzz447qPbgaHFJj3HQUtz1gyCpOhFUYfBWnzRUq4wALJuM4ql9fCb8Qhne/riysFiPQgkkEec7Xw+7YZVQ5zJv+3yb6ktUoPCZWz+7slyYeJSuigSVnHxSg2Cpwdux9kHNyFYruchjrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z6V9W6h2Xz6L5cK;
	Tue,  4 Mar 2025 17:04:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 518781402C7;
	Tue,  4 Mar 2025 17:08:18 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Mar
 2025 10:08:12 +0100
Date: Tue, 4 Mar 2025 17:08:08 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Shannon Nelson <shannon.nelson@amd.com>
CC: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <kuba@kernel.org>, <lbloch@nvidia.com>,
	<leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>,
	<brett.creeley@amd.com>
Subject: Re: [PATCH v2 5/6] pds_fwctl: add rpc and query support
Message-ID: <20250304170808.0000451d@huawei.com>
In-Reply-To: <20250301013554.49511-6-shannon.nelson@amd.com>
References: <20250301013554.49511-1-shannon.nelson@amd.com>
	<20250301013554.49511-6-shannon.nelson@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 28 Feb 2025 17:35:53 -0800
Shannon Nelson <shannon.nelson@amd.com> wrote:

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
Hi

A few minor suggestions inline,

Jonathan




> +static int pdsfc_validate_rpc(struct pdsfc_dev *pdsfc,
> +			      struct fwctl_rpc_pds *rpc,
> +			      enum fwctl_rpc_scope scope)
> +{
> +	struct pds_fwctl_query_data_operation *op_entry;
> +	struct pdsfc_rpc_endpoint_info *ep_info = NULL;
> +	struct device *dev = &pdsfc->fwctl.dev;
> +	int i;
> +
> +	/* validate rpc in_len & out_len based
> +	 * on ident.max_req_sz & max_resp_sz
> +	 */
> +	if (rpc->in.len > pdsfc->ident.max_req_sz) {
> +		dev_err(dev, "Invalid request size %u, max %u\n",
> +			rpc->in.len, pdsfc->ident.max_req_sz);
> +		return -EINVAL;
> +	}
> +
> +	if (rpc->out.len > pdsfc->ident.max_resp_sz) {
> +		dev_err(dev, "Invalid response size %u, max %u\n",
> +			rpc->out.len, pdsfc->ident.max_resp_sz);
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

Perhaps a little noisy as I think userspace can trigger this easily.  dev_dbg()
might be better.  -EINVAL should be all userspace needs under most circumstances.

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

in is a void * and the C spec always allows implicit conversion for those
so no cast here.

> +	struct device *dev = &uctx->fwctl->dev;
> +	union pds_core_adminq_comp comp = {0};
> +	dma_addr_t out_payload_dma_addr = 0;
> +	dma_addr_t in_payload_dma_addr = 0;
> +	union pds_core_adminq_cmd cmd;
> +	void *out_payload = NULL;
> +	void *in_payload = NULL;
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
> +
> +		in_payload_dma_addr = dma_map_single(dev->parent, in_payload,
> +						     rpc->in.len, DMA_TO_DEVICE);
> +		err = dma_mapping_error(dev->parent, in_payload_dma_addr);
> +		if (err) {
> +			dev_err(dev, "Failed to map in_payload\n");
> +			in_payload_dma_addr = 0;

See below for comment on ordering and why ideally this zero setting should
not be needed in error path.  Really small point though!

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
> +			out_payload_dma_addr = 0;

As above. Slight ordering tweaks and more labels would avoid need
to zero this on error as we would never use it again.

> +			out = ERR_PTR(err);
> +			goto done;
> +		}
> +	}
> +
> +	cmd = (union pds_core_adminq_cmd) {
> +		.fwctl_rpc = {
> +			.opcode = PDS_FWCTL_CMD_RPC,
> +			.flags = PDS_FWCTL_RPC_IND_REQ | PDS_FWCTL_RPC_IND_RESP,
> +			.ep = cpu_to_le32(rpc->in.ep),
> +			.op = cpu_to_le32(rpc->in.op),
> +			.req_pa = cpu_to_le64(in_payload_dma_addr),
> +			.req_sz = cpu_to_le32(rpc->in.len),
> +			.resp_pa = cpu_to_le64(out_payload_dma_addr),
> +			.resp_sz = cpu_to_le32(rpc->out.len),
> +		}
> +	};
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

Can we do these in reverse order of the setup path?
It obviously makes limited difference in practice.
With them in strict reverse order you could avoid need to
zero out_payload_dma_addr and similar in error paths by
using multiple labels.

> +		dma_unmap_single(dev->parent, out_payload_dma_addr,
> +				 rpc->out.len, DMA_FROM_DEVICE);
> +
> +	kfree(in_payload);
> +	kfree(out_payload);
> +
> +	return out;

At least some cases are simplified if you do
	if (err)
		return ERR_PTR(err);

	return in;

and handle all errors via err integer until here.
>  }

>  static const struct auxiliary_device_id pdsfc_id_table[] = {
> diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
> index ae6886ebc841..03bca2d27de0 100644
> --- a/include/linux/pds/pds_adminq.h
> +++ b/include/linux/pds/pds_adminq.h

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

__counted_by_le() probably a nice to have here.


> +} __packed;

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

__le32 rsvd; ?  Or stick to u8 only.


> +} __packed;
> +
> +/**
> + * struct pds_fwctl_rpc_comp - Completion of a firmware control RPC.
> + * @status:     Status of the command
> + * @rsvd:       Word boundary padding
> + * @comp_index: Completion index of the command
> + * @err:        Error code, if any, from the RPC.

Odd mix of full stop and not.  Make it more consistent.

> + * @resp_sz:    Size of the response.
> + * @rsvd2:      Word boundary padding

words changing size in one structure?  Just stick to "Reserved" for
the docs. Never any reason to explicitly talk about 'why' things
are reserved.

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


