Return-Path: <linux-rdma+bounces-18584-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOCLAGbUwmmwmgQAu9opvQ
	(envelope-from <linux-rdma+bounces-18584-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 19:13:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 837C431A929
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 19:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB3493077531
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 18:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A3939479D;
	Tue, 24 Mar 2026 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRYmzj1s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2755439E198
	for <linux-rdma@vger.kernel.org>; Tue, 24 Mar 2026 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774375990; cv=none; b=ilC31NhFT9ZHMX5RYuOdiZmG9g/5p89bV9zHtH1u9aF1HREteM72hA9wKqOqT+Jmt9iEnMbjWLf0IR+IMIFtii2s8j4n6j2gcl8p0hZK354TIOb7TFZ43Vpdx8kyZLK1CYn1jJ2K/g3sZY/G3JEBKLU48HwWE+zuw1pNOoIyJxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774375990; c=relaxed/simple;
	bh=RaOCjkBVzDFIT96zgHw60AZ1L9GePiOM4NsDXpfCOO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqeVT36BTpCPzRpx3z9cwUZrpL2Xp+VXPYS/KBs67sqG9C29DRTefLwL4K+ajTK0vTtmnckxXkfFZq7G6Xsc79bxwGJD7Hn6LzbcXpgeiFjSDDtL0W8/WQWwCS8kCEXWw+rkoOh1T4Pm0mIpf/iaa5tLpjeVw2E1/9klTfTylgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRYmzj1s; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-126ea4e9694so10710254c88.1
        for <linux-rdma@vger.kernel.org>; Tue, 24 Mar 2026 11:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774375987; x=1774980787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nbVlsaioYKF4sVSgiEokAiqvKpmQsI/mQ3o3FZFtp4=;
        b=VRYmzj1sFIJ7JAUgmbyEsGMPr9TDnUengve0DEWsUgDa1T7JqeGZj2gCz2rhpGzgRx
         A5raWUXSGR2UGlWw09rp8XAdkqukVNuUdPN/tz7kbF+deUkvPksYgkfq2AbMX87tXRB5
         ckgbWL+u/mT3/fE9HGi6Avugz0+2+QTxpO/eu2o+il6PHfFSPBLrO3MhPMGtVW0hoLcH
         4fhCzeNfdHsM7Z5aqkI6C9LnahE+uqE45aWLr++MXo2a+3Yu50bC+q9DTeqgvBOwmPSn
         7ZMT9mtPyRRpJzL+h5+UHablUy+8d1tJoo5fmd4QN7MjrxI9fzlMKuk8xU2I0ySNNh6H
         cRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774375987; x=1774980787;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nbVlsaioYKF4sVSgiEokAiqvKpmQsI/mQ3o3FZFtp4=;
        b=sBO3DwMxfK3NebWEdQWJWXrHZJpDv8a/De/qN+6L94Kfx/GuMPMKM/nbB2EeMnQfIB
         n6gsJSBlOszcivWEhuvatmz4sKQSpGf0do00GAi3lxMM4s4+p6Ht0C576K9BVPrIduee
         GsIS7DKHeeHSFRZCasuCuZBWLsLHeuV8ltIhREB7B4lCSqAiUjfBzGRbHryJjn5ci/4Q
         jZmis7dyptMSraYJfQMZ8Imyut03EH+TLqK80AIBtu2pq423Qt7FsMfqWFFe+jnkhdbH
         CgM15mt8DUnVUFeNmtMyybyApPwz+JOhPy2VV+cPx9JMNlOV6BIPu9dG0t97d3wpZOyn
         DAjg==
X-Forwarded-Encrypted: i=1; AJvYcCXq+PPBZ0Jf48yjqwpIfPkYUEHTlf/MMbkfqeBBrCrPtgDw70boPsb7nM98bgGa4AAYp3eQIm2Am0Ev@vger.kernel.org
X-Gm-Message-State: AOJu0YzMHBgzErbbuZ4OZgEDVnHJdnHXAHWZuDHqh+uvWE6ELUouOrA2
	GYZsVj95bWlr1FgPaKN+1R+iqYFHIZQZcpnQfbBOedUp/79vGfILWYw=
X-Gm-Gg: ATEYQzxCdQ/N2FlkniPwidY6cbhlqAJ9DKDVl4/Uwsw3FTlLqGgVUtSHSsIFpdDBGC6
	nxqTihXa+T2jxd4ZBwZ5wCx1f+RAd/h3w8eZhVr2u5y92opSUN+7CPYmeIwIno6WXI6GPVsGQ2Q
	OVWX/Zvt1rkA9g1rKMlAW+zaG7hHhCklPYmLCYAFkodtWwJDk9FJjypoZjhMrot1Y4tv3J3BCnF
	dGh/QNTYAFB7yC09SHmWl2dRdmTLTTpTz7kdSR4ROUY4VvnWmHMb5oKaa0XR/I678Jzlxh8067R
	xB3zHYmpqoWteaGli7yvP487LZzHfLF+6V8fIC9y44e4ewoKk1LC85j/57AmZ2kTALgT8nHc8Vy
	lS0U21tQ7A7K13Fm/w0VKCUYgJPlixoZhaGEj/phEagAHXFs3j7SgSyEaew3gtSjXqtZX+zhxTm
	VkPqlXsQBAWB6ADr6ilUAQ+ZK1oLGIfhWPw7CKaFKFSXqd+GtmV50P5/hXrFuN/6/PKNkDtBLog
	o/MhKgY86X/p4inLw==
X-Received: by 2002:a05:7022:69a:b0:11b:f056:a1b3 with SMTP id a92af1059eb24-12a96e5d9eamr272090c88.11.1774375986837;
        Tue, 24 Mar 2026 11:13:06 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a7330d1c5sm11223913c88.0.2026.03.24.11.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:13:05 -0700 (PDT)
Date: Tue, 24 Mar 2026 11:13:04 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
	johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
	dtatulea@nvidia.com, mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
	bestswngs@gmail.com, aleksandr.loktionov@intel.com, kees@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: Re: [PATCH net-next v3 03/13] net: introduce ndo_set_rx_mode_async
 and dev_rx_mode_work
Message-ID: <acLUMN1BYkIVyOk8@mini-arch>
Mail-Followup-To: Stanislav Fomichev <stfomichev@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
	johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
	dtatulea@nvidia.com, mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
	bestswngs@gmail.com, aleksandr.loktionov@intel.com, kees@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
	leon@kernel.org
References: <20260320012501.2033548-1-sdf@fomichev.me>
 <20260320012501.2033548-4-sdf@fomichev.me>
 <20260323162003.0d155055@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323162003.0d155055@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18584-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[fomichev.me,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 837C431A929
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/23, Jakub Kicinski wrote:
> On Thu, 19 Mar 2026 18:24:51 -0700 Stanislav Fomichev wrote:
> > diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
> > index 35704d115312..dc83d78d3b27 100644
> > --- a/Documentation/networking/netdevices.rst
> > +++ b/Documentation/networking/netdevices.rst
> > @@ -289,6 +289,14 @@ struct net_device synchronization rules
> >  ndo_set_rx_mode:
> >  	Synchronization: netif_addr_lock spinlock.
> >  	Context: BHs disabled
> > +	Notes: Deprecated in favor of sleepable ndo_set_rx_mode_async.
> > 
> > +ndo_set_rx_mode_async:
> > +	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
> > +	lock if the driver implements queue management or shaper API.
> > +	Context: process (from a work queue)
> > +	Notes: Sleepable version of ndo_set_rx_mode. Receives snapshots
> 
> It's probably just my weirdness but I find creating adjectives out 
> of random nouns by adding "-able" to be in poor taste. "sleepable"
> took root in certain three letter subsystems but I hope it won't
> in netdev.
> 
> Please use your words:
> 
> 	Notes: Async version of ndo_set_rx_mode which runs in process
> 	context. Receives snapshots f the unicast and multicast address lists.

SG, will do!
 
> > +	of the unicast and multicast address lists.
> >  
> >  ndo_setup_tc:
> >  	``TC_SETUP_BLOCK`` and ``TC_SETUP_FT`` are running under NFT locks
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 469b7cdb3237..b05bdd67b807 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -1117,6 +1117,16 @@ struct netdev_net_notifier {
> >   *	This function is called device changes address list filtering.
> >   *	If driver handles unicast address filtering, it should set
> >   *	IFF_UNICAST_FLT in its priv_flags.
> > + *	Cannot sleep, called with netif_addr_lock_bh held.
> > + *	Deprecated in favor of sleepable ndo_set_rx_mode_async.
> > + *
> > + * void (*ndo_set_rx_mode_async)(struct net_device *dev,
> > + *				 struct netdev_hw_addr_list *uc,
> > + *				 struct netdev_hw_addr_list *mc);
> > + *	Sleepable version of ndo_set_rx_mode. Called from a work queue
> > + *	with rtnl_lock and netdev_lock_ops(dev) held. The uc/mc parameters
> > + *	are snapshots of the address lists - iterate with
> > + *	netdev_hw_addr_list_for_each(ha, uc).
> >   *
> >   * int (*ndo_set_mac_address)(struct net_device *dev, void *addr);
> >   *	This function  is called when the Media Access Control address
> > @@ -1437,6 +1447,9 @@ struct net_device_ops {
> >  	void			(*ndo_change_rx_flags)(struct net_device *dev,
> >  						       int flags);
> >  	void			(*ndo_set_rx_mode)(struct net_device *dev);
> > +	void			(*ndo_set_rx_mode_async)(struct net_device *dev,
> > +							 struct netdev_hw_addr_list *uc,
> > +							 struct netdev_hw_addr_list *mc);
> >  	int			(*ndo_set_mac_address)(struct net_device *dev,
> >  						       void *addr);
> >  	int			(*ndo_validate_addr)(struct net_device *dev);
> > @@ -1903,6 +1916,7 @@ enum netdev_reg_state {
> >   *				has been enabled due to the need to listen to
> >   *				additional unicast addresses in a device that
> >   *				does not implement ndo_set_rx_mode()
> > + *	@rx_mode_work:		Work queue entry for ndo_set_rx_mode_async()
> >   *	@uc:			unicast mac addresses
> >   *	@mc:			multicast mac addresses
> >   *	@dev_addrs:		list of device hw addresses
> > @@ -2293,6 +2307,7 @@ struct net_device {
> >  	unsigned int		promiscuity;
> >  	unsigned int		allmulti;
> >  	bool			uc_promisc;
> > +	struct work_struct	rx_mode_work;
> >  #ifdef CONFIG_LOCKDEP
> >  	unsigned char		nested_level;
> >  #endif
> > @@ -4661,6 +4676,11 @@ static inline bool netif_device_present(const struct net_device *dev)
> >  	return test_bit(__LINK_STATE_PRESENT, &dev->state);
> >  }
> >  
> > +static inline bool netif_up_and_present(const struct net_device *dev)
> > +{
> > +	return (dev->flags & IFF_UP) && netif_device_present(dev);
> 
> Is this really worth a dedicated helper? What are you trying to express
> here semantically?

I mostly added it to avoid repeating the same present & UP check. Will
undo.

> > +
> >  void netif_device_detach(struct net_device *dev);
> >  
> >  void netif_device_attach(struct net_device *dev);
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 200d44883fc1..fedc423306fc 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -2381,6 +2381,8 @@ static void netstamp_clear(struct work_struct *work)
> >  static DECLARE_WORK(netstamp_work, netstamp_clear);
> >  #endif
> >  
> > +static struct workqueue_struct *rx_mode_wq;
> > +
> >  void net_enable_timestamp(void)
> >  {
> >  #ifdef CONFIG_JUMP_LABEL
> > @@ -9669,22 +9671,84 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
> >  	return 0;
> >  }
> >  
> > -/*
> > - *	Upload unicast and multicast address lists to device and
> > - *	configure RX filtering. When the device doesn't support unicast
> > - *	filtering it is put in promiscuous mode while unicast addresses
> > - *	are present.
> > +static void dev_rx_mode_work(struct work_struct *work)
> > +{
> > +	struct net_device *dev = container_of(work, struct net_device,
> > +					      rx_mode_work);
> > +	struct netdev_hw_addr_list uc_snap, mc_snap, uc_ref, mc_ref;
> > +	const struct net_device_ops *ops = dev->netdev_ops;
> > +	int err;
> > +
> > +	__hw_addr_init(&uc_snap);
> > +	__hw_addr_init(&mc_snap);
> > +	__hw_addr_init(&uc_ref);
> > +	__hw_addr_init(&mc_ref);
> > +
> > +	rtnl_lock();
> > +	netdev_lock_ops(dev);
> > +
> > +	if (!netif_up_and_present(dev))
> > +		goto out;
> > +
> > +	if (ops->ndo_set_rx_mode_async) {
> 
> How did we get here if we don't have this op?
> Are you planning to plumb more code thru this work in the future?
> If yes the whole rx_mode handling should be in a dedicated helper
> rather than indenting most of the function.

I do expand this, yes, in the subsequent patches. With promisc
handling (ndo_change_rx_flags) and ndo_set_rx_mode fallback. Let me try
to see if I can add some helper+struct to manage a set of snapshots
to make it a bit more clear.

> > +		netif_addr_lock_bh(dev);
> > +
> > +		err = __hw_addr_list_snapshot(&uc_snap, &dev->uc,
> > +					      dev->addr_len);
> > +		if (!err)
> > +			err = __hw_addr_list_snapshot(&uc_ref, &dev->uc,
> > +						      dev->addr_len);
> > +		if (!err)
> > +			err = __hw_addr_list_snapshot(&mc_snap, &dev->mc,
> > +						      dev->addr_len);
> > +		if (!err)
> > +			err = __hw_addr_list_snapshot(&mc_ref, &dev->mc,
> > +						      dev->addr_len);
> 
> This doesn't get slow with a few thousands of addresses?

I can add kunit benchmark and attach the output? Although not sure where
to go from that. The alternative to this is allocating an array of entries.
I started with that initially but __hw_addr_sync_dev wants to kfree the
individual entries and I decided not to have a separate helpers to
manage the snapshots.

> > +		netif_addr_unlock_bh(dev);
> > +
> > +		if (err) {
> > +			netdev_WARN(dev, "failed to sync uc/mc addresses\n");
> > +			__hw_addr_flush(&uc_snap);
> > +			__hw_addr_flush(&uc_ref);
> > +			__hw_addr_flush(&mc_snap);
> > +			goto out;
> > +		}
> > +
> > +		ops->ndo_set_rx_mode_async(dev, &uc_snap, &mc_snap);
> > +
> > +		netif_addr_lock_bh(dev);
> > +		__hw_addr_list_reconcile(&dev->uc, &uc_snap,
> > +					 &uc_ref, dev->addr_len);
> > +		__hw_addr_list_reconcile(&dev->mc, &mc_snap,
> > +					 &mc_ref, dev->addr_len);
> > +		netif_addr_unlock_bh(dev);
> > +	}
> > +
> > +out:
> > +	netdev_unlock_ops(dev);
> > +	rtnl_unlock();
> > +}
> > +
> > +/**
> > + * __dev_set_rx_mode() - upload unicast and multicast address lists to device
> > + * and configure RX filtering.
> > + * @dev: device
> > + *
> > + * When the device doesn't support unicast filtering it is put in promiscuous
> > + * mode while unicast addresses are present.
> >   */
> >  void __dev_set_rx_mode(struct net_device *dev)
> >  {
> >  	const struct net_device_ops *ops = dev->netdev_ops;
> >  
> >  	/* dev_open will call this function so the list will stay sane. */
> > -	if (!(dev->flags&IFF_UP))
> > +	if (!netif_up_and_present(dev))
> >  		return;
> >  
> > -	if (!netif_device_present(dev))
> > +	if (ops->ndo_set_rx_mode_async) {
> > +		queue_work(rx_mode_wq, &dev->rx_mode_work);
> >  		return;
> > +	}
> >  
> >  	if (!(dev->priv_flags & IFF_UNICAST_FLT)) {
> >  		/* Unicast addresses changes may only happen under the rtnl,
> > @@ -11708,6 +11772,16 @@ void netdev_run_todo(void)
> >  
> >  	__rtnl_unlock();
> >  
> > +	/* Make sure all pending rx_mode work completes before returning.
> > +	 *
> > +	 * rx_mode_wq may be NULL during early boot:
> > +	 * core_initcall(netlink_proto_init) vs subsys_initcall(net_dev_init).
> > +	 *
> > +	 * Check current_work() to avoid flushing from the wq.
> > +	 */
> > +	if (rx_mode_wq && !current_work())
> > +		flush_workqueue(rx_mode_wq);
> 
> Can we give the work a reference on the netdev (at init time) and
> cancel + release it here instead of flushing / waiting?

Not sure why cancel+release, maybe you're thinking about the unregister
path? This is rtnl_unlock -> netdev_run_todo -> __rtnl_unlock + some
extras.

And the flush is here to plumb the addresses to the real devices
before we return to the callers. Mostly because of the following
things we have in the tests:

# TEST: team cleanup mode lacp                                        [FAIL]
#       macvlan unicast address not found on a slave

Can you explain a bit more on the suggestion?

> >  	/* Wait for rcu callbacks to finish before next phase */
> >  	if (!list_empty(&list))
> >  		rcu_barrier();
> > @@ -12099,6 +12173,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
> >  #endif
> >  
> >  	mutex_init(&dev->lock);
> > +	INIT_WORK(&dev->rx_mode_work, dev_rx_mode_work);
> >  
> >  	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
> >  	setup(dev);
> > @@ -12203,6 +12278,8 @@ void free_netdev(struct net_device *dev)
> >  
> >  	kfree(rcu_dereference_protected(dev->ingress_queue, 1));
> >  
> > +	cancel_work_sync(&dev->rx_mode_work);
> 
> Should never happen so maybe wrap it in a WARN ?

Or maybe just flush_workqueue here as well? To signal the intent that we
are mostly waiting for the wq entry to be unused to be able to kfree it?

