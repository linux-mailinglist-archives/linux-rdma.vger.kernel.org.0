Return-Path: <linux-rdma+bounces-23185-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dm2OEq/3VWpixAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23185-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 10:47:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F3A7528EA
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 10:47:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=O9c8oGb6;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23185-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23185-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B31253018BD9
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 08:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4A53FC5A7;
	Tue, 14 Jul 2026 08:46:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4AE433BAB;
	Tue, 14 Jul 2026 08:46:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018817; cv=none; b=t1gnTd7MxD5d/p709QnvvdxdX0OKDQ03Shw+Lxs8yjdWrA3vMWe2RhcLMEv+HyORF2OU0vUX7lzsNIo7BiNqsmolqRzElUWFw9GmRIuGo6XTXl1+bE47BO3bMBj45Z0BuMYhzxOPMjrWPjiM5YyTOLpm12rZYvvQ0EgFmrJl+YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018817; c=relaxed/simple;
	bh=TVJMpbsiwRRjuht3Nz7W/nP7ZkFj5oulhXQhTSbPElg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M59GtQjSegqHFfb90AupM+91J4KjHP0GXZzVQ9n4b/ejEbz56kS0heXogNcJVjcm4CtEHEqHkU72Ntus4jFKOtPOLYwfa3ZDZA0MZn2TPCrrie93Px47aOOpRqNs+e0vtJlJ8O9IhkHRv8ASq7gVDNNszx2r7DsAqRSZ1LuRhyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9c8oGb6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B913B1F000E9;
	Tue, 14 Jul 2026 08:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784018816;
	bh=2EHiWynX4kWDLT80bfs6CVHLXHNonAAFPnmP0XhdkgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O9c8oGb6TFoNluP268z/7KWY5mix9GYujKq5Yn0AhZ0vArWkYFYIEMou2mnjso07D
	 RuEeWyRXnItCYRBGEZ9ya1F4XWbQ8h+7m0iyaUGdHzgBcZD95rBOYmA0FzoQ089REN
	 vovkpGV/ZuZNp/nXhVGyHDsZWVCmzQk3fr1qta3IguIlvcaKf2mgZna8sfQTvE7Gwi
	 div/+ZH4nhzZAMHwglPPrYbofACyMT/aLKQomjztu33bkZ2Q2iP+EUoUbU4d2urRB4
	 Bc+voH3FFAS+w2/fGD9fa2IpQjX1oc+zb0R7MnE3hMxpZAyGpzLeH/LEE/0dIieliK
	 BQlsHrFbpZo6g==
Date: Tue, 14 Jul 2026 11:46:52 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: jgg@ziepe.ca, saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: Re: [PATCH v2] RDMA/core: quiesce CQ polling before device shutdown
 on reboot
Message-ID: <20260714084652.GB19233@unreal>
References: <20260702073422.279820-1-chenguang.zhao@linux.dev>
 <20260714075558.1420384-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714075558.1420384-1-chenguang.zhao@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:chenguang.zhao@linux.dev,m:jgg@ziepe.ca,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:zhaochenguang@kylinos.cn,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23185-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99F3A7528EA

On Tue, Jul 14, 2026 at 03:55:58PM +0800, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> On reboot -f with NFS over RDMA, mlx5 shutdown can tear the device
> down while ib-comp-wq still polls live CQs, leading to UAF in
> wr_cqe->done().
> Mark the device shutting down before teardown, and skip CQ poll/arm
> and SYS_ERROR completion delivery while that flag is set.
> 
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
> 1. Set the SHUTTING_DOWN flag at the mlx5 PCI/SF shutdown entry.
> 
> 2. Skip SYS_ERROR notifications during shutdown to avoid the
>    internal error path re-arming CQs.
> 
> 3. Make mlx5_ib_poll_cq / mlx5_ib_arm_cq return immediately while
>    that flag is set, so completions are no longer delivered.
> 
>  drivers/infiniband/hw/mlx5/cq.c                       |  6 ++++++
>  drivers/infiniband/hw/mlx5/main.c                     | 11 +++++++++++
>  drivers/net/ethernet/mellanox/mlx5/core/health.c      |  3 +++
>  drivers/net/ethernet/mellanox/mlx5/core/main.c        |  1 +
>  .../net/ethernet/mellanox/mlx5/core/sf/dev/driver.c   |  1 +
>  include/linux/mlx5/driver.h                           |  6 ++++++
>  6 files changed, 28 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
> index 49b4bf148a4a..584445e6d2fc 100644
> --- a/drivers/infiniband/hw/mlx5/cq.c
> +++ b/drivers/infiniband/hw/mlx5/cq.c
> @@ -618,6 +618,9 @@ int mlx5_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
>  	int soft_polled = 0;
>  	int npolled;
>  
> +	if (mlx5_core_is_shutting_down(mdev))
> +		return 0;
> +

1. Send patches as standalone messages, not as replies.
2. Add the target tree to the patch subject, for example:
   [PATCH rdma-next v2]
3. This is racy; nothing prevents MLX5_INTERFACE_STATE_SHUTTING_DOWN from being set
   immediately after this check.

Thanks

>  	spin_lock_irqsave(&cq->lock, flags);
>  	if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR) {
>  		/* make sure no soft wqe's are waiting */
> @@ -653,6 +656,9 @@ int mlx5_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
>  	unsigned long irq_flags;
>  	int ret = 0;
>  
> +	if (mlx5_core_is_shutting_down(mdev))
> +		return 0;
> +
>  	spin_lock_irqsave(&cq->lock, irq_flags);
>  	if (cq->notify_flags != IB_CQ_NEXT_COMP)
>  		cq->notify_flags = flags & IB_CQ_SOLICITED_MASK;
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index 02809114fc79..265c95129fad 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -2976,6 +2976,9 @@ static void mlx5_ib_handle_internal_error(struct mlx5_ib_dev *ibdev)
>  	unsigned long flags_cq;
>  	unsigned long flags;
>  
> +	if (mlx5_core_is_shutting_down(ibdev->mdev))
> +		return;
> +
>  	INIT_LIST_HEAD(&cq_armed_list);
>  
>  	/* Go over qp list reside on that ibdev, sync with create/destroy qp.*/
> @@ -3200,6 +3203,9 @@ static void mlx5_ib_handle_sys_error_event(struct work_struct *_work)
>  	struct mlx5_ib_dev *ibdev = work->dev;
>  	struct ib_event ibev;
>  
> +	if (mlx5_core_is_shutting_down(ibdev->mdev))
> +		goto out;
> +
>  	ibev.event = IB_EVENT_DEVICE_FATAL;
>  	mlx5_ib_handle_internal_error(ibdev);
>  	ibev.element.port_num = (u8)(unsigned long)work->param;
> @@ -3222,10 +3228,15 @@ static int mlx5_ib_sys_error_event(struct notifier_block *nb,
>  				   unsigned long event, void *param)
>  {
>  	struct mlx5_ib_event_work *work;
> +	struct mlx5_ib_dev *ibdev;
>  
>  	if (event != MLX5_DEV_EVENT_SYS_ERROR)
>  		return NOTIFY_DONE;
>  
> +	ibdev = container_of(nb, struct mlx5_ib_dev, sys_error_events);
> +	if (mlx5_core_is_shutting_down(ibdev->mdev))
> +		return NOTIFY_OK;
> +
>  	work = kmalloc_obj(*work, GFP_ATOMIC);
>  	if (!work)
>  		return NOTIFY_DONE;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
> index aeeb136f5ebc..d9cc42c4c310 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
> @@ -202,6 +202,9 @@ static void enter_error_state(struct mlx5_core_dev *dev, bool force)
>  		mlx5_cmd_flush(dev);
>  	}
>  
> +	if (mlx5_core_is_shutting_down(dev))
> +		return;
> +
>  	mlx5_notifier_call_chain(dev->priv.events, MLX5_DEV_EVENT_SYS_ERROR, (void *)1);
>  }
>  
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> index 643b4aac2033..078114bfb357 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> @@ -2192,6 +2192,7 @@ static void shutdown(struct pci_dev *pdev)
>  	int err;
>  
>  	mlx5_core_info(dev, "Shutdown was called\n");
> +	set_bit(MLX5_INTERFACE_STATE_SHUTTING_DOWN, &dev->intf_state);
>  	set_bit(MLX5_BREAK_FW_WAIT, &dev->intf_state);
>  	mlx5_drain_fw_reset(dev);
>  	mlx5_drain_health_wq(dev);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
> index 4391ef0bab5d..6f8242bfb455 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
> @@ -111,6 +111,7 @@ static void mlx5_sf_dev_shutdown(struct auxiliary_device *adev)
>  	struct mlx5_sf_dev *sf_dev = container_of(adev, struct mlx5_sf_dev, adev);
>  	struct mlx5_core_dev *mdev = sf_dev->mdev;
>  
> +	set_bit(MLX5_INTERFACE_STATE_SHUTTING_DOWN, &mdev->intf_state);
>  	set_bit(MLX5_BREAK_FW_WAIT, &mdev->intf_state);
>  	mlx5_drain_health_wq(mdev);
>  	mlx5_unload_one(mdev, false);
> diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
> index b1871c0821d0..a9efc37cd254 100644
> --- a/include/linux/mlx5/driver.h
> +++ b/include/linux/mlx5/driver.h
> @@ -653,8 +653,14 @@ enum mlx5_device_state {
>  enum mlx5_interface_state {
>  	MLX5_INTERFACE_STATE_UP = BIT(0),
>  	MLX5_BREAK_FW_WAIT = BIT(1),
> +	MLX5_INTERFACE_STATE_SHUTTING_DOWN = BIT(2),
>  };
>  
> +static inline bool mlx5_core_is_shutting_down(struct mlx5_core_dev *dev)
> +{
> +	return test_bit(MLX5_INTERFACE_STATE_SHUTTING_DOWN, &dev->intf_state);
> +}
> +
>  enum mlx5_pci_status {
>  	MLX5_PCI_STATUS_DISABLED,
>  	MLX5_PCI_STATUS_ENABLED,
> -- 
> 2.25.1
> 
> 

