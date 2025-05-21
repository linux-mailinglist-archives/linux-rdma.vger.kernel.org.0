Return-Path: <linux-rdma+bounces-10496-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D038ABFBB6
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 18:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A450950101F
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 16:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A154722F769;
	Wed, 21 May 2025 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1AqdtOf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E550622F16C;
	Wed, 21 May 2025 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747846447; cv=none; b=JKJcJApSULWteCJl9XEqCUNF+BPSiSjQOgZ8nh2qoKTuGRZT679++y2c4ZgGWow+6E86j1QKL1KnQ7Xu07JOfufnJQOCUEhkjSDcDPaCSavjm9Oid3cJr9mRX3fA6lXMnHQozR/NQgp/OlvyiYkRVIMt57Bh42/bIHjEFRITrNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747846447; c=relaxed/simple;
	bh=lh3ztE7tDzTylan5uU21+WV+j2JH4ZpqzcOAV6F+ctI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGYTpPznERx53he9Ha7NY73ISG2hfHiwHCrOZn1uADWAYSktv+FIgak9gez8EaezdIkqpqdXh3W3pIG/r5906OgyuQBKLQEkP95CoLVSYeIUJge4mqWlul3lMOQQgaqgpbj3gzs7fUChz9+sa0WeG3Iu8J0uorNKOX2ezfYH8yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1AqdtOf; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b170c99aa49so4744797a12.1;
        Wed, 21 May 2025 09:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747846445; x=1748451245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BIQ1Rxc2ZpLERkR7gGmNgkdIGIhV9bfqR3o6mxkItNk=;
        b=N1AqdtOfW7YqGOJkT+YJdOs9qfCSyu7TLaLIoSgaIMPnlH8/iMiIlTf3ZU3romv3Ze
         0aKMVnDRJTivfmoxPnL7+5SLHQp1JenXxrVLUw7SObj1YVmV2XxwJ1HaDXbnmt7yCvt0
         XkDqynX+AHbGAowvFz5FKOdVyvTXk67j1azTIq8yVB0I7o1XYdAW30WAaFV8kevfKmWU
         lFWbaz0Xhlcp7coL0TrMmuUs2TxMHelVTN4StZ/aArfYiXAh7g7lpSieP+88EmFtSRvI
         1cpNC+fRLNEcFE7plYWpgyd8h0kvr8iwFbNOQltRLUwHyZdVbIgaCVbZR/pEg2TRqJr3
         la/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747846445; x=1748451245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIQ1Rxc2ZpLERkR7gGmNgkdIGIhV9bfqR3o6mxkItNk=;
        b=sjdU2a9SONZ8xKkufSQZxEyImE9RUB+NA/v/EPWFOaUELfddMr6Ub1bgseypSuCxwV
         Qkx6Os9CjLzjiSbfgEnJEUxo8q1SobcYr11igHOYGJ9rar0NuHWolkoFs5+ape4ddbro
         Bff0+oAYJvMdPYd4I99bxDCnmsB3T/YdKHxgjehg5hIBVppzmWYxgvaqrBayVIWRl+Qm
         zi7+ok6RIVBLgFP9XsyCIdUEPB6YtQrNUjwnmuRrxVU6M0HqVWgkI9ExziUhZN3fiO7S
         CXim94MklDavQRFKmBKQALBPm+qtgYb931hHTWHJYEO5k0GoiznSoVWg6n7DXIZCG8hm
         kyeA==
X-Forwarded-Encrypted: i=1; AJvYcCW37KVH0Rv5FROh4lo/vKQ92HdWSsSmUqfkianmnCYKY4iovpwBVp9zM2X1JyQ0in4hIZSaDJYDYoCshQ==@vger.kernel.org, AJvYcCWED5b7NGd5/Iddjy/qh3zcSJpdj4DgvvQ8tkWYTnf8rP/opnrqopCRbmhKQBCxjQsNx03MXlccciVjxX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDBAsjTyYZxLIAYDxiGsqXzb1grz5HWihRBTdEDWCpBUlvtP2G
	SH9GK/HvQvsyiNcyY0nO9UUT6gcXwQLFD7czBJmDzeWAeXrAFPDYZvY=
X-Gm-Gg: ASbGnctBiUDjv+JrAfZOxq49/iYm/vc4Bbx/mqb7Bnji5uHTAV0LqTcvxQVy4XAjRiZ
	481S5RE5XhfWvmLk8FipzoqNAbRy+Vw4RdU6iHHkbOTiDTr30Cfd+zwEdQXjYEyFa2GUMZ0aSQE
	FZMkNKGLoSa0vbGpn2QLJZd+JnsZbQ+H95opFZjY5Q/bfUBzx3XHKXKXoRzsufELimrBcQpoDaj
	LuhtxM0sJ4afiaxUOm1sY32QZ/iKMjhoE7k9gUrTT566J3krVtKpRLwmXrUJX5Oik2kB0c6inG9
	SDQ+F9kf//UL8hbrgjo66xccJ3g7AaiP2pn9TljSPuilB3q0MpPLXOKdNDqCES95F7ndwhLLFoQ
	GTgmo6cWZO0FzXM0eCVZygWs=
X-Google-Smtp-Source: AGHT+IFzVnTQj3n+QIgHnz/hXPz29MCKOLBHAPXbLuIFeELI/UwoDe/CHhh1zQ3pSSR6qsSCjVi80w==
X-Received: by 2002:a17:902:d4c3:b0:232:4f8c:1af9 with SMTP id d9443c01a7336-2324f8c1c69mr153349335ad.21.1747846444917;
        Wed, 21 May 2025 09:54:04 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4b0d5f0sm94966375ad.102.2025.05.21.09.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 09:54:04 -0700 (PDT)
Date: Wed, 21 May 2025 09:54:03 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, skalluru@marvell.com, manishc@marvell.com,
	andrew+netdev@lunn.ch, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	tariqt@nvidia.com, saeedm@nvidia.com, louis.peens@corigine.com,
	shshaikh@marvell.com, GR-Linux-NIC-Dev@marvell.com,
	ecree.xilinx@gmail.com, horms@kernel.org, dsahern@kernel.org,
	ruanjinjie@huawei.com, mheib@redhat.com,
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org, oss-drivers@corigine.com,
	linux-net-drivers@amd.com, leon@kernel.org
Subject: Re: [PATCH net-next 2/3] udp_tunnel: remove rtnl_lock dependency
Message-ID: <aC4FK0fmUoaXYt4k@mini-arch>
References: <20250520203614.2693870-1-stfomichev@gmail.com>
 <20250520203614.2693870-3-stfomichev@gmail.com>
 <20250521073401.67fbd1bc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250521073401.67fbd1bc@kernel.org>

On 05/21, Jakub Kicinski wrote:
> On Tue, 20 May 2025 13:36:13 -0700 Stanislav Fomichev wrote:
> > Drivers that are using ops lock and don't depend on RTNL lock
> > still need to manage it because udp_tunnel's RTNL dependency.
> > Introduce new udp_tunnel_nic_lock and use it instead of
> > rtnl_lock. Drop non-UDP_TUNNEL_NIC_INFO_MAY_SLEEP mode from
> > udp_tunnel infra (udp_tunnel_nic_device_sync_work needs to
> > grab udp_tunnel_nic_lock mutex and might sleep).
> 
> There is a netdevsim-based test for this that needs to be fixed up.

Oh, I did not see that one, let me try to find and run it.

> > diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
> > index 2df3b8344eb5..7f5537fdf2c9 100644
> > --- a/include/net/udp_tunnel.h
> > +++ b/include/net/udp_tunnel.h
> > @@ -221,19 +221,17 @@ static inline void udp_tunnel_encap_enable(struct sock *sk)
> >  #define UDP_TUNNEL_NIC_MAX_TABLES	4
> >  
> >  enum udp_tunnel_nic_info_flags {
> > -	/* Device callbacks may sleep */
> > -	UDP_TUNNEL_NIC_INFO_MAY_SLEEP	= BIT(0),
> 
> Could we use a different lock for sleeping and non-sleeping drivers?

We can probably do it if we reorder the locks (as you ask/suggest
below). Overall, I'm not sure I understand why we want to have two
paths here. If we can do everything via work queue, why have a separate
path for the non-sleepable callback? (more code -> more bugs)

> > @@ -554,11 +543,11 @@ static void __udp_tunnel_nic_reset_ntf(struct net_device *dev)
> >  	struct udp_tunnel_nic *utn;
> >  	unsigned int i, j;
> >  
> > -	ASSERT_RTNL();
> > +	mutex_lock(&udp_tunnel_nic_lock);
> >  
> >  	utn = dev->udp_tunnel_nic;
> 
> utn and info's lifetimes are tied to the lifetime of the device
> I think their existence can remain protected by the external locks

SG, will move the lock down a bit.

> >  	if (!utn)
> > -		return;
> > +		goto unlock;
> >  
> >  	utn->need_sync = false;
> >  	for (i = 0; i < utn->n_tables; i++)
> 
> > -	rtnl_lock();
> > +	mutex_lock(&udp_tunnel_nic_lock);
> >  	utn->work_pending = 0;
> >  	__udp_tunnel_nic_device_sync(utn->dev, utn);
> >  
> > -	if (utn->need_replay)
> > +	if (utn->need_replay) {
> > +		rtnl_lock();
> >  		udp_tunnel_nic_replay(utn->dev, utn);
> > -	rtnl_unlock();
> > +		rtnl_unlock();
> > +	}
> > +	mutex_unlock(&udp_tunnel_nic_lock);
> >  }
> 
> What's the lock ordering between the new lock and rtnl lock?

From ops-locked, we'll get: ops->tunnel_lock (__udp_tunnel_nic_reset_ntf)
From non-ops locked, we'll get: rtnl->tunnel_lock

I see your point, we need to do rtnl->tunnel_lock here as well.

> BTW the lock could live in utn, right? We can't use the instance
> lock because of sharing, but we could put the lock in utn?

I was thinking that there is some global state besides udp_tunnel_nic,
but I don't see any, will move the lock, thanks!

