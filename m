Return-Path: <linux-rdma+bounces-8355-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE54A4FDC1
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 12:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D831892FDD
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 11:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D39424886D;
	Wed,  5 Mar 2025 11:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JzHskBXo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5E3245015
	for <linux-rdma@vger.kernel.org>; Wed,  5 Mar 2025 11:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741174477; cv=none; b=JR94IqvGrEGqmImG0IdQdrh7qEiIlwYx0kbhIxVyxiogJnLjc3kBQuOj7MlHuA/48YvWRV00FX9BRdMoeg/lCccO9ac0TzxxAGVAtQJ7FfzMZznz4hGPlpKaWzQGl6hmrSrISsMFCj+vKXCpAP3XOn7sP/mV0kH8qDU2JD1g9y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741174477; c=relaxed/simple;
	bh=kL66fAUxg8KDrRHVSUn/3JwrJc0S+PUcIDIXg0KHtrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDw5iyANDyhSTOiY7ugZXr2uhv7nHlnJ966CnwPiiW1NECwb39WrugCwrrBEqyjExY3JBXNFgGdKesRFt/z7zz9OWmBefcRl8i+/UxE8taSpCZZvG7RWP0V8kmUXRd6USkPlLKj4ibXCNkOZGxl2BiexzWx4ni/RohXD5aGebug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=JzHskBXo; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390e6ac844fso5922320f8f.3
        for <linux-rdma@vger.kernel.org>; Wed, 05 Mar 2025 03:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1741174472; x=1741779272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hpM2n8LqDCKtYCNjyQPHE8ZzTXVzmeW07FILl14R+lk=;
        b=JzHskBXolzJ6P/HG1IV9mbpJkmpIl1CoKd2IENNDS2XLLaK1QMKUSgIEPljYHdeXz2
         e+MbC9c+OvAERT5ZeT/iboJacB/a3YRij0Wp5CS5YFFeluxeEsT/56kvKKAU9KIMTFKP
         bAL6/99/Gns94LyaLQh1XIurEf8ftk3A9GQWq5Zs5exw72EhmvoJzJMFRdft9cVt/G2S
         ZPHufcQMDEAerK5u9sGwpPZgQl07YzXRZ8csPUEVx0alNspfPkVFuzxlCAmbSM2LzzQS
         8BlDI3GcQQuA748UHz1wXznQAz7WT3XzbGv+Zk++x+SyW04H4QKSMHQhI9c3/PV3JywQ
         E8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741174472; x=1741779272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpM2n8LqDCKtYCNjyQPHE8ZzTXVzmeW07FILl14R+lk=;
        b=b0seryerMI+eqQtqJ+W9A7jC2kRPrYFZGE7HlQWbIHjwu+z9jJaBMEW0H40t8gKY+b
         aeD1ADNMSZ/X2NJfd4JAGqBUoJZ8ITMhneyZOAsHD3RqlqPSAArvk4EW8ZAmHEjxn0hU
         lINXR/iFee0r5e731ID7DY3hKLuayPLb3Zu56b0SUjBF6W/P3vf3c5gVDoMbOOWTv6JV
         EijvkadlEJw6PXYxT4va+9bEGgHA3SOpR6eCPZiOkn5oUjUD9eXndsZsEm5z0pQWR96H
         BIY2HHMUlLAtNEK46IGDDEVqQf+2IpNypVjE49EbW/HXvRje7gBGASXzYUi6xKtvJzHR
         uFww==
X-Forwarded-Encrypted: i=1; AJvYcCVIuQa1sPLasjz8LNQZxRvx72hbfe4I4jd3QeWPrSoMnGJ0lW3B0IPErXRQdHlPYow/WRny39d0Cj/j@vger.kernel.org
X-Gm-Message-State: AOJu0YwFyhSZD+XoBBmKgjwazYRAgJgkQnJOGTw81o1sqT/8v6rA3r35
	gFLhE6/pXFDp9RExrAFMdaN6G6uLUz2Cj6QlOJomeyroArfAnBVu+awkWweyy9I=
X-Gm-Gg: ASbGncs05OdhzdTUaqPoMwHbx11JZqcEfjhVnasOHFVvrj7BARYC6DI0I7IrMgaDt8J
	U6fqYHXVamOUt029c4MQW/s9dxY6LWsB7u1LWtnH+TUb4UMxa/CL7Iae0IgXG0Qkf64LI0SmpK0
	p//bsMNxBuT5iLRhu4JIKoyk1mby+nS1N877lVpWTbG6AeWgLHrP3GJiPIbrOQhHaw95sY2T6aZ
	I0owo4qTso41LtfczcRlO0eAQV5qTE6ebDai9rcEhxiGSSgDDbQ5sjMaE7rIHNZoBdQEhsnO22L
	+Ipqw046hRiV5scV4t0j8r2y5I7ycQ8tt/pc5cmZVcHV9wIgaqHIsu/S9druY2EXLMQbOK3Q
X-Google-Smtp-Source: AGHT+IFhcRjxC3RYssOw9YiOI4i2fR0hgc5YoCn+lwsc2UV78sEfmb324dUC+Cr+juAHyeRCzFmMBg==
X-Received: by 2002:a5d:64a1:0:b0:38f:6287:6474 with SMTP id ffacd0b85a97d-3911f735a79mr2149235f8f.15.1741174471766;
        Wed, 05 Mar 2025 03:34:31 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd42e53e0sm14790365e9.27.2025.03.05.03.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 03:34:31 -0800 (PST)
Date: Wed, 5 Mar 2025 12:34:27 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Long Li <longli@microsoft.com>
Cc: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, 
	KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shradha Gupta <shradhagupta@linux.microsoft.com>, Simon Horman <horms@kernel.org>, 
	Konstantin Taranov <kotaranov@microsoft.com>, Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, 
	Erick Archer <erick.archer@outlook.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH] hv_netvsc: set device master/slave flags
 on bonding
Message-ID: <7z2vlhnu2seaujnuvtpjllbj4pnc5aqn5pwfujvzsrzc7emllb@ce2v22r3ombt>
References: <1740781513-10090-1-git-send-email-longli@linuxonhyperv.com>
 <52aig2mkbfggjyar6euotbihowm6erv3wxxg5crimveg3gfjr2@pmlx6omwx2n2>
 <SA6PR21MB4231D93C746A70C24B79F806CEC92@SA6PR21MB4231.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA6PR21MB4231D93C746A70C24B79F806CEC92@SA6PR21MB4231.namprd21.prod.outlook.com>

Mon, Mar 03, 2025 at 07:47:37PM +0100, longli@microsoft.com wrote:
>> Subject: [EXTERNAL] Re: [PATCH] hv_netvsc: set device master/slave flags on
>> bonding
>> 
>> Fri, Feb 28, 2025 at 11:25:13PM +0100, longli@linuxonhyperv.com wrote:
>> >From: Long Li <longli@microsoft.com>
>> >
>> >Currently netvsc only sets the SLAVE flag on VF netdev when it's
>> >bonded. It should also set the MASTER flag on itself and clear all
>> >those flags when the VF is unbonded.
>> 
>> I don't understand why you need this. Who looks at these flags?
>
>The SLAVE flag is checked here:
>https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/microsoft/mana/mana_en.c?h=v6.14-rc5#n3144

In kernel. We have other means. The check is incorrect. The code should
use netif_is_*_port() herlper. Does not exist, add it.


> and is also checked in some user-mode programs.

As currently it is not exposed, it can't be checked. Don't add it.

>
>There is no code checking for MASTER currently. It is added for completeness. SLAVE doesn't make sense without a MASTER.

Does not make sense. Either you need it or not. If not, don't add it.


NAK. Please let IFF_MASTER and IFF_SLAVE rot.


>
>> 
>> 
>> >
>> >Signed-off-by: Long Li <longli@microsoft.com>
>> >---
>> > drivers/net/hyperv/netvsc_drv.c | 6 ++++++
>> > 1 file changed, 6 insertions(+)
>> >
>> >diff --git a/drivers/net/hyperv/netvsc_drv.c
>> >b/drivers/net/hyperv/netvsc_drv.c index d6c4abfc3a28..7ac18fede2f3
>> >100644
>> >--- a/drivers/net/hyperv/netvsc_drv.c
>> >+++ b/drivers/net/hyperv/netvsc_drv.c
>> >@@ -2204,6 +2204,7 @@ static int netvsc_vf_join(struct net_device
>> *vf_netdev,
>> > 		goto rx_handler_failed;
>> > 	}
>> >
>> >+	ndev->flags |= IFF_MASTER;
>> > 	ret = netdev_master_upper_dev_link(vf_netdev, ndev,
>> > 					   NULL, NULL, NULL);
>> > 	if (ret != 0) {
>> >@@ -2484,7 +2485,12 @@ static int netvsc_unregister_vf(struct
>> >net_device *vf_netdev)
>> >
>> > 	reinit_completion(&net_device_ctx->vf_add);
>> > 	netdev_rx_handler_unregister(vf_netdev);
>> >+
>> >+	/* Unlink the slave device and clear flag */
>> >+	vf_netdev->flags &= ~IFF_SLAVE;
>> >+	ndev->flags &= ~IFF_MASTER;
>> > 	netdev_upper_dev_unlink(vf_netdev, ndev);
>> >+
>> > 	RCU_INIT_POINTER(net_device_ctx->vf_netdev, NULL);
>> > 	dev_put(vf_netdev);
>> >
>> >--
>> >2.34.1
>> >
>> >

