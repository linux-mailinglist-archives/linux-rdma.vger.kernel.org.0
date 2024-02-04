Return-Path: <linux-rdma+bounces-888-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 907BF848DCF
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 13:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C2B9B214FF
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 12:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B898219FF;
	Sun,  4 Feb 2024 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XN8JDThR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49433224CC;
	Sun,  4 Feb 2024 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707050585; cv=none; b=Qv93xEK+2lOw9A2SL0xtjMV+na3yq10XZftcIUN8iVbnkxr4uooPIYz1CR5OdOZ+F/DoeErPjmJcTxnorBhCCImx0gYonO0ZLbf5AwsHckyxDAcZwPOlIKt3Uk96mA8QtxfhEy+tnCaXhsbNXfsylFSqjblRmyNPCowb+7/QSTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707050585; c=relaxed/simple;
	bh=Hw1JSj7Svr9NDriyZTOYa5SeuNIxmJs1p7/MQEcpG5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWfYxv8oxF5pW9oH5v0VTV1QEnVWjFlDweMR1B0RjUeVdaN76EmyP0qwZhlgk8rIy9JegXVpo6eUW9j+4DEOiU1dj5ORpNCUvoxb/qvg87l8TiWd/gOUXy8DlFP8uMY+TzbtO11mTmUB8Wbi96F188qZgDOKvKb6ILxqkjNEO3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XN8JDThR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F173C433F1;
	Sun,  4 Feb 2024 12:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707050584;
	bh=Hw1JSj7Svr9NDriyZTOYa5SeuNIxmJs1p7/MQEcpG5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XN8JDThRgLbR2WCugVyteS/nZkNFE59QSb0setvhDk2sH7w+2d5Uj/B3JpHnc7Qzc
	 mG3GxIc3CoxHdnDes4rhEzjGPKK4KE+Utheq4fwwQJzdO7UPUTGbxrMmRrlS4WWzFZ
	 PzF117HhsH4RCpA8S/7PSZRUkH9TZ3a6lIk+qoTaWqk3Y4fU2qUMbKzSIf+ogbOj5a
	 MjsHJV5e8cJrBlljpKKShg41OkiST/u/FRF810vjevLuTlMXQ1oVZmBXZTszITO3Wx
	 tep8Wkw36nkFCx+dgfbH9SMwDRdr+7YbUnXDWCzZtoCePULKLG4hX9v7Yn5i7mUqnU
	 aSS9aWziVwmfQ==
Date: Sun, 4 Feb 2024 14:43:00 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com,
	jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 5/5] RDMA/mana_ib: Adding and deleting GIDs
Message-ID: <20240204124300.GF5400@unreal>
References: <1706886397-16600-1-git-send-email-kotaranov@linux.microsoft.com>
 <1706886397-16600-6-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1706886397-16600-6-git-send-email-kotaranov@linux.microsoft.com>

On Fri, Feb 02, 2024 at 07:06:37AM -0800, Konstantin Taranov wrote:
> Implement add_gid and del_gid for RNIC.
> We support ipv4 and ipv6 addresses.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@linux.microsoft.com>
> ---
>  drivers/infiniband/hw/mana/device.c  |  2 ++
>  drivers/infiniband/hw/mana/main.c    | 66 ++++++++++++++++++++++++++++++++++++
>  drivers/infiniband/hw/mana/mana_ib.h | 37 ++++++++++++++++++++
>  3 files changed, 105 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
> index 2b362f5..9fb515b 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -15,6 +15,7 @@
>  	.driver_id = RDMA_DRIVER_MANA,
>  	.uverbs_abi_ver = MANA_IB_UVERBS_ABI_VERSION,
>  
> +	.add_gid = mana_ib_gd_add_gid,
>  	.alloc_pd = mana_ib_alloc_pd,
>  	.alloc_ucontext = mana_ib_alloc_ucontext,
>  	.create_cq = mana_ib_create_cq,
> @@ -23,6 +24,7 @@
>  	.create_wq = mana_ib_create_wq,
>  	.dealloc_pd = mana_ib_dealloc_pd,
>  	.dealloc_ucontext = mana_ib_dealloc_ucontext,
> +	.del_gid = mana_ib_gd_del_gid,
>  	.dereg_mr = mana_ib_dereg_mr,
>  	.destroy_cq = mana_ib_destroy_cq,
>  	.destroy_qp = mana_ib_destroy_qp,
> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
> index 645abf3..282c024 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -675,3 +675,69 @@ void mana_ib_gd_destroy_rnic_adapter(struct mana_ib_dev *mdev)
>  	mdev->adapter_handle = INVALID_MANA_HANDLE;
>  	mana_ib_destroy_eqs(mdev);
>  }
> +
> +int mana_ib_gd_add_gid(const struct ib_gid_attr *attr, void **context)
> +{
> +	struct mana_ib_dev *mdev = container_of(attr->device, struct mana_ib_dev, ib_dev);
> +	enum rdma_network_type ntype = rdma_gid_attr_network_type(attr);
> +	struct mana_rnic_config_addr_resp resp = {};
> +	struct gdma_context *gc = mdev_to_gc(mdev);
> +	struct mana_rnic_config_addr_req req = {};
> +	int err;
> +
> +	if (!rnic_is_enabled(mdev))
> +		return -EINVAL;

Set .add_gid./del_gid callbacks only when RNIC is enabled.
ib_set_device_ops() allows partial set of the callbacks.

> +
> +	if (ntype != RDMA_NETWORK_IPV4 && ntype != RDMA_NETWORK_IPV6) {
> +		ibdev_dbg(&mdev->ib_dev, "Unsupported rdma network type %d", ntype);
> +		return -EINVAL;
> +	}
> +
> +	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CONFIG_IP_ADDR, sizeof(req), sizeof(resp));
> +	req.hdr.dev_id = gc->mana_ib.dev_id;
> +	req.adapter = mdev->adapter_handle;
> +	req.op = ADDR_OP_ADD;
> +	req.sgid_type = (ntype == RDMA_NETWORK_IPV6) ? SGID_TYPE_IPV6 : SGID_TYPE_IPV4;
> +	copy_in_reverse(req.ip_addr, attr->gid.raw, sizeof(union ib_gid));
> +
> +	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
> +	if (err) {
> +		ibdev_err(&mdev->ib_dev, "Failed to config IP addr err %d\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +int mana_ib_gd_del_gid(const struct ib_gid_attr *attr, void **context)
> +{
> +	struct mana_ib_dev *mdev = container_of(attr->device, struct mana_ib_dev, ib_dev);
> +	enum rdma_network_type ntype = rdma_gid_attr_network_type(attr);
> +	struct mana_rnic_config_addr_resp resp = {};
> +	struct gdma_context *gc = mdev_to_gc(mdev);
> +	struct mana_rnic_config_addr_req req = {};
> +	int err;
> +
> +	if (!rnic_is_enabled(mdev))
> +		return -EINVAL;
> +
> +	if (ntype != RDMA_NETWORK_IPV4 && ntype != RDMA_NETWORK_IPV6) {
> +		ibdev_dbg(&mdev->ib_dev, "Unsupported rdma network type %d", ntype);
> +		return -EINVAL;
> +	}
> +
> +	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CONFIG_IP_ADDR, sizeof(req), sizeof(resp));
> +	req.hdr.dev_id = gc->mana_ib.dev_id;
> +	req.adapter = mdev->adapter_handle;
> +	req.op = ADDR_OP_REMOVE;
> +	req.sgid_type = (ntype == RDMA_NETWORK_IPV6) ? SGID_TYPE_IPV6 : SGID_TYPE_IPV4;
> +	copy_in_reverse(req.ip_addr, attr->gid.raw, sizeof(union ib_gid));
> +
> +	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
> +	if (err) {
> +		ibdev_err(&mdev->ib_dev, "Failed to config IP addr err %d\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
> index 196f3c8..2a3e3b0 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -118,6 +118,7 @@ enum mana_ib_command_code {
>  	MANA_IB_GET_ADAPTER_CAP = 0x30001,
>  	MANA_IB_CREATE_ADAPTER  = 0x30002,
>  	MANA_IB_DESTROY_ADAPTER = 0x30003,
> +	MANA_IB_CONFIG_IP_ADDR	= 0x30004,
>  };
>  
>  struct mana_ib_query_adapter_caps_req {
> @@ -167,6 +168,30 @@ struct mana_rnic_destroy_adapter_resp {
>  	struct gdma_resp_hdr hdr;
>  }; /* HW Data */
>  
> +enum mana_ib_addr_op {
> +	ADDR_OP_ADD = 1,
> +	ADDR_OP_REMOVE,
> +};
> +
> +enum sgid_entry_type {
> +	SGID_TYPE_INVALID = 0,
> +	SGID_TYPE_IPV4 = 1,
> +	SGID_TYPE_IPV6 = 2,
> +	SGID_TYPE_HYBRID = 3

This is not used, please remove it.

Thanks

