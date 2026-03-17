Return-Path: <linux-rdma+bounces-18238-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMCBKKEluWm1sQEAu9opvQ
	(envelope-from <linux-rdma+bounces-18238-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 10:57:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A92562A75F9
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 10:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA33F302A409
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 09:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E4339EF1C;
	Tue, 17 Mar 2026 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mehyF8oF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B31375F82;
	Tue, 17 Mar 2026 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740954; cv=none; b=str1Ke7OiDw2/OUnOGPcsTmYuhjvo8zIk9sekh3twMyWf5PXy8PY4l0pK6QiYgr1S5YOhse8pjbJSRgzL6SrA118i4tIrnsacbKCXQW3By2HZAuG+R29M5A6TTuN3tDQwe8DJ6bGOB0gPuYTEH4x98kV+gma3oJCPmH4bUkEW1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740954; c=relaxed/simple;
	bh=ST5M2Ewq07s1JCa7AgMkHMnP9+1fRIS/TI7/2Wjvbgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmsCXs3DXnDd3+/BR67ikBJq2Fz3xkBCb3rrrHJHDbtznxiHAwMH3qWuStvzu4C8FxDt0ZNemBGiC9a8MQ7SeWi2srKYyS89TOT/WELqqFfAixDsDtYWSRbli9xH6GvPUFwjQohBsGwXFh/pwN1jqBuQAyOc+AXMfZ6BMFTGXTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mehyF8oF; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <07b0ee06-aae7-4c48-8ac6-503ee8f8ea63@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773740950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ST5M2Ewq07s1JCa7AgMkHMnP9+1fRIS/TI7/2Wjvbgw=;
	b=mehyF8oFTsntVJMHlvnIiNUjH0FSMJUagJOZMEjWl6IUqZl3lmlsz+TDxcTP1v9zaRymn/
	x6StfFDAlEPF256xtn02xXMcrpeH83CSZYdbZ0if+ulY3eZLGS0AncsNLdAUG0i/D2jaOb
	MgwCxRrgsgNTLvRmJuo1yLMfC+aCVUg=
Date: Tue, 17 Mar 2026 17:48:55 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1] IB/core: Fix use-after-free of ipvlan phy_dev in
 ib_get_eth_speed
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Jiayuan Chen <jiayuan.chen@shopee.com>, Jianzhou Zhao <luckd0g@163.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Mark Bloch <mbloch@nvidia.com>,
 Edward Srouji <edwards@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Patrisious Haddad <phaddad@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>, Kees Cook <kees@kernel.org>,
 Jang Ingyu <ingyujang25@korea.ac.kr>, Moni Shoua <monis@mellanox.com>,
 Doug Ledford <dledford@redhat.com>, Christian Benvenuti <benve@cisco.com>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Yuval Shaia <yuval.shaia@oracle.com>, linux-kernel@vger.kernel.org
References: <20260311100313.284589-1-jiayuan.chen@linux.dev>
 <20260316162909.GG61385@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260316162909.GG61385@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18238-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,163.com,ziepe.ca,nvidia.com,broadcom.com,kernel.org,korea.ac.kr,mellanox.com,redhat.com,cisco.com,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid,shopee.com:email]
X-Rspamd-Queue-Id: A92562A75F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/17/26 12:29 AM, Leon Romanovsky wrote:
> On Wed, Mar 11, 2026 at 06:03:08PM +0800, Jiayuan Chen wrote:
>> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>>
>> Jianzhou Zhao reported a NULL pointer dereference in
>> __ethtool_get_link_ksettings [1]. The root cause is a use-after-free
>> of ipvlan->phy_dev.
>>
>> In ib_get_eth_speed(), ib_device_get_netdev() obtains a reference to the
>> ipvlan device outside of rtnl_lock(). This creates a race window: between
>> ib_device_get_netdev() and rtnl_lock(), the underlying phy_dev (e.g. a
>> dummy device) can be unregistered and freed by another thread.
> If ib_device_get_netdev() worked as it was supposed to work, it can't.
> That function grabs reference on netdev and returns or netdev with elevated
> reference counter which can't be freed or returns NULL.
>
> Thanks
>

ipvlan's phy_dev is safe in the data path — TX/RX runs in softirq
context with RCU protection, no lock needed per packet.

The issue here is in the control path. __ethtool_get_link_ksettings()
requires rtnl_lock() — all existing ethtool callers follow this:

- ioctl path: rtnl_lock() is taken first, then __dev_get_by_name()
looks up the dev without even holding a refcnt — relying entirely
on RTNL for safety. (net/ethtool/ioctl.c:3571, 3249)
- netlink path: dev is looked up with refcnt first, but the actual
ethtool ops run under rtnl_lock(). (net/ethtool/netlink.c:527-533)

Under RTNL, phy_dev cannot disappear because phy_dev unregistration
triggers NETDEV_UNREGISTER which deletes ipvlan first — all within
the same RTNL context. That's why no virtual netdev driver (ipvlan,
macvlan, bond, etc.) holds an extra refcnt on the lower dev in its
ethtool callbacks.

ib_get_eth_speed() calls __ethtool_get_link_ksettings() under
rtnl_lock(), but obtains the netdev before it. Moving the lookup
inside rtnl_lock() makes the netdev resolution and ethtool call
atomic w.r.t. device unregistration, consistent with how ethtool's
own paths work.


Thanks


