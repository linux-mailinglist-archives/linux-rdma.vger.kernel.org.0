Return-Path: <linux-rdma+bounces-6724-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9BC9FBC74
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 11:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656B0188D748
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 10:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C6C1B3935;
	Tue, 24 Dec 2024 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnLsDh0q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E30014EC60;
	Tue, 24 Dec 2024 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735036083; cv=none; b=koOla8IYYE1ezD0H278E/PJmOw5/bQ8alVY7dEeUgtMeDBpwzhztqtgozC7Y5oZ1Wn4KEdJHXvja6qBvKUryqIawSJdJxkgRcgsgKb1yV96uUnrHZLx2wNOq7fxRHRrFPwpJZj2ibYHDwWBqUreZZFosKkMm/pf+bv4NpeFeWko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735036083; c=relaxed/simple;
	bh=OFqI4q12pE5u31D9U3UzoohBFMCrT/QKQo09rRNEM8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELQQ6ik+qS57Q82ec1R42D2PPtfLTQzjgI1LqzOg0v16lAp/ow8MF1Lim3sGmfMv5GCl5mGP2xUJV8tnf5VfA2MPTZoaQq5QQYPchVrvF3dDxKQawoOlqceRw6puvpIQSNiEiHZm+beqH/8Ulm1+YOezWUMdtvMx08fhCec+VCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnLsDh0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D29AC4CED0;
	Tue, 24 Dec 2024 10:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735036083;
	bh=OFqI4q12pE5u31D9U3UzoohBFMCrT/QKQo09rRNEM8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rnLsDh0qcsgQ7G8zM4jGGhuPQZaHpaJTBaTHg6syva+f/gMRFtBTmV8xM7+VRgJEF
	 emO4o9ZNFC042D6R7KPXqc012OjX66B67ImhosSCDAtTX0BSeIO5UeF5LreDxtpa2l
	 3hnglMpLMVdPi06emH2dtCtXlvRlg3UoP+BmbplPOluACzUCrnYJAh0xpLXvJdgW6/
	 IBfHI4/P0gc001QU/Y1/Q0/KmuYa8d2myVehmL8LFeWx8Xx/7bAc+jbQ36uNxMw2Rs
	 sX7WI4KG/KazySDPV7Vi0UDfmGnO7DnutIFS2gQ9XQs+qhJecXj3vH8xs4SHMgeYaL
	 GyhXVuXAcnU/Q==
Date: Tue, 24 Dec 2024 12:27:58 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, selvin.xavier@broadcom.com, chengyou@linux.alibaba.com,
	kaishen@linux.alibaba.com, mustafa.ismail@intel.com,
	tatyana.e.nikolova@intel.com, yishaih@nvidia.com, benve@cisco.com,
	neescoba@cisco.com, bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com, zyjzyj2000@gmail.com, bmt@zurich.ibm.com,
	linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org, tangchengchang@huawei.com,
	liyuyu6@huawei.com, linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH RFC 12/12] RDMA/hns: Support fast path for link-down
 events dispatching
Message-ID: <20241224102758.GE171473@unreal>
References: <20241122105308.2150505-1-huangjunxian6@hisilicon.com>
 <20241122105308.2150505-13-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122105308.2150505-13-huangjunxian6@hisilicon.com>

On Fri, Nov 22, 2024 at 06:53:08PM +0800, Junxian Huang wrote:
> From: Yuyu Li <liyuyu6@huawei.com>
> 
> hns3 NIC driver can directly notify the RoCE driver about link status
> events bypassing the netdev notifier. This can provide more timely
> event dispatching for ULPs.

It is unlikely that it matters for ULPs and better would be if you don't
open-code existing netdev functionality (netdev notifiers).

Thanks

> 
> Signed-off-by: Yuyu Li <liyuyu6@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 697b17cca02e..5c911d1def03 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -7178,9 +7178,22 @@ static int hns_roce_hw_v2_reset_notify(struct hnae3_handle *handle,
>  	return ret;
>  }
>  
> +static void hns_roce_hw_v2_link_status_change(struct hnae3_handle *handle,
> +					      bool linkup)
> +{
> +	struct hns_roce_dev *hr_dev = (struct hns_roce_dev *)handle->priv;
> +	struct net_device *netdev = handle->rinfo.netdev;
> +
> +	if (linkup || !hr_dev)
> +		return;
> +
> +	ib_dispatch_port_state_event(&hr_dev->ib_dev, netdev);
> +}
> +
>  static const struct hnae3_client_ops hns_roce_hw_v2_ops = {
>  	.init_instance = hns_roce_hw_v2_init_instance,
>  	.uninit_instance = hns_roce_hw_v2_uninit_instance,
> +	.link_status_change = hns_roce_hw_v2_link_status_change,
>  	.reset_notify = hns_roce_hw_v2_reset_notify,
>  };
>  
> -- 
> 2.33.0
> 

