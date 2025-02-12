Return-Path: <linux-rdma+bounces-7676-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC62A3262A
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 13:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2AB2188C518
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 12:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5D720E038;
	Wed, 12 Feb 2025 12:47:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5C7B673;
	Wed, 12 Feb 2025 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364429; cv=none; b=T3qrfPoLDdHyTXOjJ3GQLGRCQ1H2AD5XB3YdV2MJdCx0K7xQGcik+mjdzNjmQDAyZPqC9Lzm//7hsMJdVtwAMlyLHCaDfAUYvI0dqGbEG0K+31VgYrvl9i+SLDmLrWTqSMq4WKT9Jcnh3xuUWoxJ9SNhuj8R/rOrLgjXt5M/wmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364429; c=relaxed/simple;
	bh=EtjadoyVk7jETEyltx1iX1caTwhJuaqujhLdLpbQ+UA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FtDf85u8GLr6OUEkXPDP/+T9uA5LaHy8aOiXFl7KZbKyaJj2M7/3huO2ogshJ8KkVeH5V97/Yt04Jnb+S+Vz48rZTZVY1GGv16GzjUmV6Tn62rYiNpDY9o65omlR+eQL/Ude1VyGzDyy35HdpmimVPNgE+FAuuahPGWD+zQR6h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YtJ110QNPz6J7dt;
	Wed, 12 Feb 2025 20:44:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FFE6140B2A;
	Wed, 12 Feb 2025 20:47:02 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Feb
 2025 13:47:01 +0100
Date: Wed, 12 Feb 2025 12:47:00 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Shannon Nelson <shannon.nelson@amd.com>
CC: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gospo@broadcom.com>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <kuba@kernel.org>, <lbloch@nvidia.com>,
	<leonro@nvidia.com>, <saeedm@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<brett.creeley@amd.com>
Subject: Re: [RFC PATCH fwctl 4/5] pds_fwctl: add rpc and query support
Message-ID: <20250212124700.00005f62@huawei.com>
In-Reply-To: <20250211234854.52277-5-shannon.nelson@amd.com>
References: <20250211234854.52277-1-shannon.nelson@amd.com>
	<20250211234854.52277-5-shannon.nelson@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Feb 2025 15:48:53 -0800
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
Various comments inline.  I haven't looked closely at the actual interface
yet though as running out of time today.

Jonathan

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

I'm lost. These look same as the ones in slab.h for kfree and kvfree
which already handle error pointers.  Maybe based on an old kernel?

> +static struct pds_fwctl_query_data *pdsfc_get_operations(struct pdsfc_dev *pdsfc,
> +							 dma_addr_t *pa, u32 ep)
> +{
> +	struct pds_fwctl_query_data_operation *entries = NULL;

Always set before use so don't initialize here.

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
>  static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>  			  void *in, size_t in_len, size_t *out_len)
>  {
> -	return NULL;
> +	struct pdsfc_dev *pdsfc = container_of(uctx->fwctl, struct pdsfc_dev, fwctl);
> +	struct fwctl_rpc_pds *rpc = (struct fwctl_rpc_pds *)in;
In is a void * so never any need to cast it to another pointer type.

> +	void *out_payload __free(kfree_errptr) = NULL;

Similar comment on style for these following documentation in cleanup.h
That is tricky in this case but you can at least declare them and set
them NULL just before they are conditionally assigned.

> +	void *in_payload __free(kfree_errptr) = NULL;
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

As before avoid the gotos mixed with free.
Easiest might be a little helper function for this setup of
the input buffer and one for the output buffer.
Probably not combined with __free that isn't giving much advantage
here anyway.

For this particular one can just return the error anyway as
nothing to do.

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

Mixing the __free() magic and gotos is 'probably' ok in this case
but high risk.

https://elixir.bootlin.com/linux/v6.13.1/source/include/linux/cleanup.h#L135
Makes a fairly strong statement on this.  I'd suggest either figuring
out a code reorg that avoids need for gotos or stopping using __free in this
function.  This looks like similar question to earlier one of
why are these cached as opposed to done inside open/close callbacks
for specific RPC calls?

>  	}
> -

Noise that shouldn't be here.

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
__counted_by_le(num_entries)
probably appropriate here.
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

Why not an __le32?
It's reserved and naturally aligned so who cares on type ;)

> +} __packed;


