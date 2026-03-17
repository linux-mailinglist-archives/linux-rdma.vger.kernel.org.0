Return-Path: <linux-rdma+bounces-18252-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIr+J61auWnYAgIAu9opvQ
	(envelope-from <linux-rdma+bounces-18252-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 14:44:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 250852AB250
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 14:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F18830C0FE0
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 13:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D312D73A0;
	Tue, 17 Mar 2026 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fa72ZgqZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9DE2C11C6;
	Tue, 17 Mar 2026 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754906; cv=none; b=AeMe7r8KO+2tuZUk3HoiRIbw8vUEw8Mn9cqk44p+0Esv1UifIsSxxvKQV0O4/PMgXs8WWTOqaKNOqHhkegKQaatNRZdbs3z/SvittAcmoqvUDzbdSmPwayHbgm6K5NQTlyYfRwWD+pYfChtupXprStP8rDTiwQ38TmNH+Dzusbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754906; c=relaxed/simple;
	bh=eitiTD1FHtSBD6EfMhAR7jk5fKmg00swNJqZWk7CXbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/7AVa9JJm03g5nLYtdRQE7PWdkk14XXbiHP1ZIA3iNTS9zMlrH5ZwxazD8kz0FKLsWgoH1g2EOe3T144GpAyysSP1bccR0rlyfzskMSJF/lXsq7KAgWCWmM0GW7RjBzXqbejWoRJbtASq3mCe447RaL/QamZqSkm9rleU7otOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fa72ZgqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7277C4CEF7;
	Tue, 17 Mar 2026 13:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773754906;
	bh=eitiTD1FHtSBD6EfMhAR7jk5fKmg00swNJqZWk7CXbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fa72ZgqZxl/KHHVKHPeg7mCKPavM+rFoBmIwUcJ/kPpYmJ/WJmopN4oiq1DL/XXl8
	 HZgtqs/y6ZBCzG1C5jhvivFMsrwr6xlnzbyRo/9WTcoL1Obb5073HgCEA0oGkMlJXU
	 Uw6Yq3WgbnCCwb/IjIXurnPm4gVuoRpUYEV0N9rAzuaMCSxtzyhQnsMe/Avg8KSr65
	 JLZ6k5px9c1XsdW0Mdil3pxc376NbhgrYHaGKDrgArqHy/xeQ31X7ku8ISt7YHB+Yh
	 sFtHAkQH/XOElsXjgPl5KQvokzFbortEkTLGWdL6bBSrsH36siCpILOWQGLtzUR1dC
	 kR4q62TRY1xSA==
Date: Tue, 17 Mar 2026 15:41:41 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jianzhou Zhao <luckd0g@163.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mark Bloch <mbloch@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>, Kees Cook <kees@kernel.org>,
	Jang Ingyu <ingyujang25@korea.ac.kr>,
	Moni Shoua <monis@mellanox.com>, Doug Ledford <dledford@redhat.com>,
	Christian Benvenuti <benve@cisco.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Yuval Shaia <yuval.shaia@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] IB/core: Fix use-after-free of ipvlan phy_dev in
 ib_get_eth_speed
Message-ID: <20260317134141.GY61385@unreal>
References: <20260311100313.284589-1-jiayuan.chen@linux.dev>
 <20260316162909.GG61385@unreal>
 <07b0ee06-aae7-4c48-8ac6-503ee8f8ea63@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07b0ee06-aae7-4c48-8ac6-503ee8f8ea63@linux.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18252-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,163.com,ziepe.ca,nvidia.com,broadcom.com,kernel.org,korea.ac.kr,mellanox.com,redhat.com,cisco.com,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shopee.com:email]
X-Rspamd-Queue-Id: 250852AB250
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 05:48:55PM +0800, Jiayuan Chen wrote:
> 
> On 3/17/26 12:29 AM, Leon Romanovsky wrote:
> > On Wed, Mar 11, 2026 at 06:03:08PM +0800, Jiayuan Chen wrote:
> > > From: Jiayuan Chen <jiayuan.chen@shopee.com>
> > > 
> > > Jianzhou Zhao reported a NULL pointer dereference in
> > > __ethtool_get_link_ksettings [1]. The root cause is a use-after-free
> > > of ipvlan->phy_dev.
> > > 
> > > In ib_get_eth_speed(), ib_device_get_netdev() obtains a reference to the
> > > ipvlan device outside of rtnl_lock(). This creates a race window: between
> > > ib_device_get_netdev() and rtnl_lock(), the underlying phy_dev (e.g. a
> > > dummy device) can be unregistered and freed by another thread.
> > If ib_device_get_netdev() worked as it was supposed to work, it can't.
> > That function grabs reference on netdev and returns or netdev with elevated
> > reference counter which can't be freed or returns NULL.
> > 
> > Thanks
> > 
> 
> ipvlan's phy_dev is safe in the data path — TX/RX runs in softirq
> context with RCU protection, no lock needed per packet.
> 
> The issue here is in the control path. __ethtool_get_link_ksettings()
> requires rtnl_lock() — all existing ethtool callers follow this:
> 
> - ioctl path: rtnl_lock() is taken first, then __dev_get_by_name()
> looks up the dev without even holding a refcnt — relying entirely
> on RTNL for safety. (net/ethtool/ioctl.c:3571, 3249)
> - netlink path: dev is looked up with refcnt first, but the actual
> ethtool ops run under rtnl_lock(). (net/ethtool/netlink.c:527-533)
> 
> Under RTNL, phy_dev cannot disappear because phy_dev unregistration
> triggers NETDEV_UNREGISTER which deletes ipvlan first — all within
> the same RTNL context. That's why no virtual netdev driver (ipvlan,
> macvlan, bond, etc.) holds an extra refcnt on the lower dev in its
> ethtool callbacks.
> 
> ib_get_eth_speed() calls __ethtool_get_link_ksettings() under
> rtnl_lock(), but obtains the netdev before it. Moving the lookup
> inside rtnl_lock() makes the netdev resolution and ethtool call
> atomic w.r.t. device unregistration, consistent with how ethtool's
> own paths work.

Please reread my earlier response and explain how an ipvlan device can
disappear immediately after a successful call to ib_device_get_netdev().

Thanks

> 
> 
> Thanks
> 
> 

