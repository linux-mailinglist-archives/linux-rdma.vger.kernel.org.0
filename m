Return-Path: <linux-rdma+bounces-18544-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KARBONbLwWlUWgQAu9opvQ
	(envelope-from <linux-rdma+bounces-18544-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 00:25:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 852442FEEB1
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 00:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 256AD30C694A
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 23:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF3E3845A8;
	Mon, 23 Mar 2026 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lp7UlBxp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7952ECD3A;
	Mon, 23 Mar 2026 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774308006; cv=none; b=D7qKX3CoNhygo/ZbgFHdvevvYWqmRlyLe5r7qsDh/zoaam0So/7hvNZegjmfysEBr8wHZVKHCC0dCK0C9eJgrYYrGD3yrZIf/uOItrI+/GtycQMVLTZq/Mh2R8TukevaxwwfW07/JLTRt3e4q1TWVad914VvL6DQJ084CAJOSag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774308006; c=relaxed/simple;
	bh=PpHcw3oFZN4iT1D2TENT8YsgkPFR1CPpHVPuhH/9Q38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZccCfwn4+4nGaTGdUYj+L2TnY+dNbtEMewM0Npn7uOwL/F1LgvpU7mcJwlP04T1PLqyMRSCcqT6km90ejYAVRa58jNJCuXD9f66OY/1/aqHvEMsEXFSk4wHl2GUZVFNaPPDANjvSrz8endLC8iXEoro5LFPNH8BqHbJJl6cSUu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lp7UlBxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F9CC4CEF7;
	Mon, 23 Mar 2026 23:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774308006;
	bh=PpHcw3oFZN4iT1D2TENT8YsgkPFR1CPpHVPuhH/9Q38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lp7UlBxpQSS9F616nGQR666fPAc0eOseTKxGcglN/NjreqiNtXuSDZWFEqoRy9Y/9
	 sab0zBoCpJg8h+is+LJDKgZzWKAgErn3aVOYtv2sErqbk3MfYhaFiGaJXE+scWJIjx
	 MLSOkKX0Kng8PY8DUiUMi6WjgF8pU2BzFN2Esp4e5slwJekQxOUhWXZYLRhTZ8bzXi
	 JTEe3j32GpLMIdhr4DcvjfloXGN3EmP5i8XEVAJ7fcffdzFMRxR8gYpeuUVV4NaHnK
	 WEoZGIBG/E+u56jlstsTO1XhymK5URy4c9+qghCHudTrDB0+SgNFb1OD13CoN+hoIM
	 9j8FNAbNqyWqw==
Date: Mon, 23 Mar 2026 16:20:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, andrew+netdev@lunn.ch,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 alexanderduyck@fb.com, kernel-team@meta.com, johannes@sipsolutions.net,
 sd@queasysnail.net, jianbol@nvidia.com, dtatulea@nvidia.com,
 mohsin.bashr@gmail.com, jacob.e.keller@intel.com, willemb@google.com,
 skhawaja@google.com, bestswngs@gmail.com, aleksandr.loktionov@intel.com,
 kees@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
 leon@kernel.org
Subject: Re: [PATCH net-next v3 03/13] net: introduce ndo_set_rx_mode_async
 and dev_rx_mode_work
Message-ID: <20260323162003.0d155055@kernel.org>
In-Reply-To: <20260320012501.2033548-4-sdf@fomichev.me>
References: <20260320012501.2033548-1-sdf@fomichev.me>
	<20260320012501.2033548-4-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18544-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,lists.osuosl.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 852442FEEB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 19 Mar 2026 18:24:51 -0700 Stanislav Fomichev wrote:
> diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
> index 35704d115312..dc83d78d3b27 100644
> --- a/Documentation/networking/netdevices.rst
> +++ b/Documentation/networking/netdevices.rst
> @@ -289,6 +289,14 @@ struct net_device synchronization rules
>  ndo_set_rx_mode:
>  	Synchronization: netif_addr_lock spinlock.
>  	Context: BHs disabled
> +	Notes: Deprecated in favor of sleepable ndo_set_rx_mode_async.
> 
> +ndo_set_rx_mode_async:
> +	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
> +	lock if the driver implements queue management or shaper API.
> +	Context: process (from a work queue)
> +	Notes: Sleepable version of ndo_set_rx_mode. Receives snapshots

It's probably just my weirdness but I find creating adjectives out 
of random nouns by adding "-able" to be in poor taste. "sleepable"
took root in certain three letter subsystems but I hope it won't
in netdev.

Please use your words:

	Notes: Async version of ndo_set_rx_mode which runs in process
	context. Receives snapshots f the unicast and multicast address lists.

> +	of the unicast and multicast address lists.
>  
>  ndo_setup_tc:
>  	``TC_SETUP_BLOCK`` and ``TC_SETUP_FT`` are running under NFT locks
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 469b7cdb3237..b05bdd67b807 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1117,6 +1117,16 @@ struct netdev_net_notifier {
>   *	This function is called device changes address list filtering.
>   *	If driver handles unicast address filtering, it should set
>   *	IFF_UNICAST_FLT in its priv_flags.
> + *	Cannot sleep, called with netif_addr_lock_bh held.
> + *	Deprecated in favor of sleepable ndo_set_rx_mode_async.
> + *
> + * void (*ndo_set_rx_mode_async)(struct net_device *dev,
> + *				 struct netdev_hw_addr_list *uc,
> + *				 struct netdev_hw_addr_list *mc);
> + *	Sleepable version of ndo_set_rx_mode. Called from a work queue
> + *	with rtnl_lock and netdev_lock_ops(dev) held. The uc/mc parameters
> + *	are snapshots of the address lists - iterate with
> + *	netdev_hw_addr_list_for_each(ha, uc).
>   *
>   * int (*ndo_set_mac_address)(struct net_device *dev, void *addr);
>   *	This function  is called when the Media Access Control address
> @@ -1437,6 +1447,9 @@ struct net_device_ops {
>  	void			(*ndo_change_rx_flags)(struct net_device *dev,
>  						       int flags);
>  	void			(*ndo_set_rx_mode)(struct net_device *dev);
> +	void			(*ndo_set_rx_mode_async)(struct net_device *dev,
> +							 struct netdev_hw_addr_list *uc,
> +							 struct netdev_hw_addr_list *mc);
>  	int			(*ndo_set_mac_address)(struct net_device *dev,
>  						       void *addr);
>  	int			(*ndo_validate_addr)(struct net_device *dev);
> @@ -1903,6 +1916,7 @@ enum netdev_reg_state {
>   *				has been enabled due to the need to listen to
>   *				additional unicast addresses in a device that
>   *				does not implement ndo_set_rx_mode()
> + *	@rx_mode_work:		Work queue entry for ndo_set_rx_mode_async()
>   *	@uc:			unicast mac addresses
>   *	@mc:			multicast mac addresses
>   *	@dev_addrs:		list of device hw addresses
> @@ -2293,6 +2307,7 @@ struct net_device {
>  	unsigned int		promiscuity;
>  	unsigned int		allmulti;
>  	bool			uc_promisc;
> +	struct work_struct	rx_mode_work;
>  #ifdef CONFIG_LOCKDEP
>  	unsigned char		nested_level;
>  #endif
> @@ -4661,6 +4676,11 @@ static inline bool netif_device_present(const struct net_device *dev)
>  	return test_bit(__LINK_STATE_PRESENT, &dev->state);
>  }
>  
> +static inline bool netif_up_and_present(const struct net_device *dev)
> +{
> +	return (dev->flags & IFF_UP) && netif_device_present(dev);

Is this really worth a dedicated helper? What are you trying to express
here semantically?

> +
>  void netif_device_detach(struct net_device *dev);
>  
>  void netif_device_attach(struct net_device *dev);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 200d44883fc1..fedc423306fc 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -2381,6 +2381,8 @@ static void netstamp_clear(struct work_struct *work)
>  static DECLARE_WORK(netstamp_work, netstamp_clear);
>  #endif
>  
> +static struct workqueue_struct *rx_mode_wq;
> +
>  void net_enable_timestamp(void)
>  {
>  #ifdef CONFIG_JUMP_LABEL
> @@ -9669,22 +9671,84 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
>  	return 0;
>  }
>  
> -/*
> - *	Upload unicast and multicast address lists to device and
> - *	configure RX filtering. When the device doesn't support unicast
> - *	filtering it is put in promiscuous mode while unicast addresses
> - *	are present.
> +static void dev_rx_mode_work(struct work_struct *work)
> +{
> +	struct net_device *dev = container_of(work, struct net_device,
> +					      rx_mode_work);
> +	struct netdev_hw_addr_list uc_snap, mc_snap, uc_ref, mc_ref;
> +	const struct net_device_ops *ops = dev->netdev_ops;
> +	int err;
> +
> +	__hw_addr_init(&uc_snap);
> +	__hw_addr_init(&mc_snap);
> +	__hw_addr_init(&uc_ref);
> +	__hw_addr_init(&mc_ref);
> +
> +	rtnl_lock();
> +	netdev_lock_ops(dev);
> +
> +	if (!netif_up_and_present(dev))
> +		goto out;
> +
> +	if (ops->ndo_set_rx_mode_async) {

How did we get here if we don't have this op?
Are you planning to plumb more code thru this work in the future?
If yes the whole rx_mode handling should be in a dedicated helper
rather than indenting most of the function.

> +		netif_addr_lock_bh(dev);
> +
> +		err = __hw_addr_list_snapshot(&uc_snap, &dev->uc,
> +					      dev->addr_len);
> +		if (!err)
> +			err = __hw_addr_list_snapshot(&uc_ref, &dev->uc,
> +						      dev->addr_len);
> +		if (!err)
> +			err = __hw_addr_list_snapshot(&mc_snap, &dev->mc,
> +						      dev->addr_len);
> +		if (!err)
> +			err = __hw_addr_list_snapshot(&mc_ref, &dev->mc,
> +						      dev->addr_len);

This doesn't get slow with a few thousands of addresses?

> +		netif_addr_unlock_bh(dev);
> +
> +		if (err) {
> +			netdev_WARN(dev, "failed to sync uc/mc addresses\n");
> +			__hw_addr_flush(&uc_snap);
> +			__hw_addr_flush(&uc_ref);
> +			__hw_addr_flush(&mc_snap);
> +			goto out;
> +		}
> +
> +		ops->ndo_set_rx_mode_async(dev, &uc_snap, &mc_snap);
> +
> +		netif_addr_lock_bh(dev);
> +		__hw_addr_list_reconcile(&dev->uc, &uc_snap,
> +					 &uc_ref, dev->addr_len);
> +		__hw_addr_list_reconcile(&dev->mc, &mc_snap,
> +					 &mc_ref, dev->addr_len);
> +		netif_addr_unlock_bh(dev);
> +	}
> +
> +out:
> +	netdev_unlock_ops(dev);
> +	rtnl_unlock();
> +}
> +
> +/**
> + * __dev_set_rx_mode() - upload unicast and multicast address lists to device
> + * and configure RX filtering.
> + * @dev: device
> + *
> + * When the device doesn't support unicast filtering it is put in promiscuous
> + * mode while unicast addresses are present.
>   */
>  void __dev_set_rx_mode(struct net_device *dev)
>  {
>  	const struct net_device_ops *ops = dev->netdev_ops;
>  
>  	/* dev_open will call this function so the list will stay sane. */
> -	if (!(dev->flags&IFF_UP))
> +	if (!netif_up_and_present(dev))
>  		return;
>  
> -	if (!netif_device_present(dev))
> +	if (ops->ndo_set_rx_mode_async) {
> +		queue_work(rx_mode_wq, &dev->rx_mode_work);
>  		return;
> +	}
>  
>  	if (!(dev->priv_flags & IFF_UNICAST_FLT)) {
>  		/* Unicast addresses changes may only happen under the rtnl,
> @@ -11708,6 +11772,16 @@ void netdev_run_todo(void)
>  
>  	__rtnl_unlock();
>  
> +	/* Make sure all pending rx_mode work completes before returning.
> +	 *
> +	 * rx_mode_wq may be NULL during early boot:
> +	 * core_initcall(netlink_proto_init) vs subsys_initcall(net_dev_init).
> +	 *
> +	 * Check current_work() to avoid flushing from the wq.
> +	 */
> +	if (rx_mode_wq && !current_work())
> +		flush_workqueue(rx_mode_wq);

Can we give the work a reference on the netdev (at init time) and
cancel + release it here instead of flushing / waiting?

>  	/* Wait for rcu callbacks to finish before next phase */
>  	if (!list_empty(&list))
>  		rcu_barrier();
> @@ -12099,6 +12173,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
>  #endif
>  
>  	mutex_init(&dev->lock);
> +	INIT_WORK(&dev->rx_mode_work, dev_rx_mode_work);
>  
>  	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
>  	setup(dev);
> @@ -12203,6 +12278,8 @@ void free_netdev(struct net_device *dev)
>  
>  	kfree(rcu_dereference_protected(dev->ingress_queue, 1));
>  
> +	cancel_work_sync(&dev->rx_mode_work);

Should never happen so maybe wrap it in a WARN ?


>  	/* Flush device addresses */
>  	dev_addr_flush(dev);
>  
> @@ -13296,6 +13373,10 @@ static int __init net_dev_init(void)
>  	if (register_pernet_device(&default_device_ops))
>  		goto out;
>  
> +	rx_mode_wq = alloc_ordered_workqueue("rx_mode_wq", 0);
> +	if (!rx_mode_wq)
> +		goto out;
> +
>  	open_softirq(NET_TX_SOFTIRQ, net_tx_action);
>  	open_softirq(NET_RX_SOFTIRQ, net_rx_action);
>  


