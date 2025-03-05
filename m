Return-Path: <linux-rdma+bounces-8375-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E47EA50A45
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 19:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5C81889947
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 18:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AEA1A5BB7;
	Wed,  5 Mar 2025 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YdKISRre"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255A01C863A
	for <linux-rdma@vger.kernel.org>; Wed,  5 Mar 2025 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200656; cv=none; b=tC8QK4E2i+7CWvceImcSWsvNMxOnDUOiG1uH35G8qVWnX3i8AZErCG30HZounD6NV4/n1SGgdYDp+WOZE7a4UvislpXAc+yJW09iqbtZajAy80qVnH8rb6dPDGK8r4Rlrr/plfNPaHAeuNt0DpXcizTZZozTJuAZjtdb0UCZcWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200656; c=relaxed/simple;
	bh=QbaAYVsuHtR4sFbwYlItPyeMtj1+0TldiW7il+PRxZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxOGZhqfTyPgh2C3Fu6WYQarsUJDcY3Ltxicr32wNIKLLjUML8gWUC66tMNmuC8wUPsG/9xJxD4ngz8CgDmZGCLnX6iC8QQbiQxrPok3RKXy827ESXYMWceQLHsBtxKEAnq0/HBWxUwF/7s7WGE+vBeoqEA1U8jdjgKWoB8VQGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YdKISRre; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e895f3365aso53460346d6.0
        for <linux-rdma@vger.kernel.org>; Wed, 05 Mar 2025 10:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741200654; x=1741805454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7/tB8dYiu5A38nEKy58/W/Pt5oX/QvBFHO/wQ46XSc=;
        b=YdKISRre2vQzP5L91LnjrMPLlIWIMUyv0FCKNrb8H8ZEwRFG3hWoxi3tw6UQImAN8P
         dC2T8/fDqHcn71EDd95kew5KAHCLbRwWCmexzmO8KLYbo76tEQX/rL+/kFE13HKznSXJ
         VPIvClo7wJ+3I28B+lVMxtM19Ei0Rhm8tDZojPF9tqbMc+e8OOrMiHTNSgHxNPlw5Rxr
         Vy16yI2bw8ut1ptKtqydSYdWwQSjMtnzG3m6YpR914NO6TEEAmife16dDa1QUsA40Exw
         D+fz4MvGGySafE1nvAuaB1u0tWCggL2iFCW27B0Lh86hakThRBKcKgstH3wz4mk1Bz2X
         HM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741200654; x=1741805454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7/tB8dYiu5A38nEKy58/W/Pt5oX/QvBFHO/wQ46XSc=;
        b=xQBIoQrSDmGf2XB70HagIV8z1Y27DiNFCkgoRc2+9c7M4u3QddrLVnlvzzTzqwRQk6
         Duq9+eYTBleAvtD2D4jz1hGICfxlt78O6MFFjvorwEbwJrsxcJp+FVz9KC69q8iuhDes
         eNATB8xnApbsRPmyR/n+DSuKnlGhlxmEs4SGT5MFQMKsBh3PFseVIfuQxGlcBEwvNdOh
         k255b0ncpzlcApQorvL8PVDY1yZKbqu0gKCTGp1IDj13Gpj5+RZFzGVp2L74Bg+iz7tS
         CKwXDWoc/6UeWXGD8DXqZBYjCmbX+8siwmsuq4lLnwaCPUaj+DpkAMQhATY1ZN48wx04
         12EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc2phqfAhFfCEcSuuILBRBlYY2fiuf3vbgDPVhkoZJF9g6jVVnEkhD3g7w3yH/AA7FZlQDcvXzl+nb@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk1UfZ5WsVeztHLvtv8qJFLQrhl9XO7Lugdib3Jw/I15U0PiY2
	F/ohkcVg/40rQJVnVySSD10gTPT71C0LuttWvzYLaE+qj0Dj0ErGheiSKno1h8k=
X-Gm-Gg: ASbGncsTMyix3ZaJobyZADKIaSetHMgv/Rr/U0pDF7JfdmE8a3gSP7HQwdyebFjKn8g
	hz6Ndzx/T2EI3ZmIpDEH4XgRM3TIO9GAGo/wha9YR26BP4oxJQXFPKC8vurnI87N2K1dRVnWDVL
	LG2W7LukaLplM6dl62kjxgoFlDgL77NSlZozdB81NwO9NfvvFiSBwEIAXF/GuDMuddd4K0DVblc
	58HoNfozfC6FwMPZ2CQ2p0wuvavqv/Hq8+La1Lfm0WD17PhpkicIksDRAdOH2UPwoMlAAkqBMsx
	nhLkhhKNP98csaNydteVbWBX8KWqmqmK4+Yv0ACAZ3uDylfRML8A7aj0ARZ57StXtzYx9DCIk/j
	R5ih9+GlEUsqtSZ5Szg==
X-Google-Smtp-Source: AGHT+IHBfk4VjAwwmewmwy7/cD04QxrX3NO7CkQZxs6uiHniAKBSHBOE/omselhSlxfJQQW6JbT7mg==
X-Received: by 2002:a05:6214:518b:b0:6e6:60f6:56cf with SMTP id 6a1803df08f44-6e8e6cfffa9mr54007756d6.5.1741200653911;
        Wed, 05 Mar 2025 10:50:53 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8e8f52086sm10432506d6.63.2025.03.05.10.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:50:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tptpU-00000001UT9-2uWT;
	Wed, 05 Mar 2025 14:50:52 -0400
Date: Wed, 5 Mar 2025 14:50:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: longli@linuxonhyperv.com
Cc: Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: Re: [patch rdma-next v3 1/2] net: mana: Change the function
 signature of mana_get_primary_netdev_rcu
Message-ID: <20250305185052.GA354403@ziepe.ca>
References: <1741132802-26795-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1741132802-26795-1-git-send-email-longli@linuxonhyperv.com>

On Tue, Mar 04, 2025 at 04:00:01PM -0800, longli@linuxonhyperv.com wrote:
>  
> -struct net_device *mana_get_primary_netdev_rcu(struct mana_context *ac, u32 port_index)
> +struct net_device *mana_get_primary_netdev(struct mana_context *ac, u32 port_index)
>  {
>  	struct net_device *ndev;
>  
> -	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
> -			 "Taking primary netdev without holding the RCU read lock");
>  	if (port_index >= ac->num_ports)
>  		return NULL;
>  
> +	rcu_read_lock();
> +
>  	/* When mana is used in netvsc, the upper netdevice should be returned. */
>  	if (ac->ports[port_index]->flags & IFF_SLAVE)
>  		ndev = netdev_master_upper_dev_get_rcu(ac->ports[port_index]);
>  	else
>  		ndev = ac->ports[port_index];
>  
> +	dev_hold(ndev);
> +	rcu_read_unlock();

That's much better, yes

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

