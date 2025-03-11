Return-Path: <linux-rdma+bounces-8574-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E061A5BB90
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 10:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446BA3B1A7C
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 09:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6890235362;
	Tue, 11 Mar 2025 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UsXMH6ys"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBED4235364
	for <linux-rdma@vger.kernel.org>; Tue, 11 Mar 2025 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683604; cv=none; b=kuUbP0trJHC8+CP4yMqZJxCE/3EAgW2LaG6U0t7uD0hp1kTMDlcv8pXL1p0wtkwulpQB5X9Nk5kDoFJikAgaoxdQAAo3G4k/qZeBq50XIG6hqvYBJqxDq1bCnaFKhwB0GGO+tTVv0TT/hNFa3oIgHUfMHDlHgpLVIzZo/mDj78Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683604; c=relaxed/simple;
	bh=iA6mnCj7Qy5YCe/bg0WzxBq0xFn9tOEWd8Sg/pfOH78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SxBkluZGUj9gtZAl4o0NqzKnPdoXxD31JoqzzM95F1PpE7TdqHLG6C5EOrJNbtUgHH0K4qt9qQlCImU3d9p68q/BRzvJJvFmZomjfeDYvey4r9LuNHTahs+qzUlZPJCis1oqJmtZnuzGq3v1tvasTpHOPVcJOgPNSsEW7IYdYBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UsXMH6ys; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741683601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KqnlKZZInNbUMVaxemGpweqmwSoqd9viWeAicyRcRjo=;
	b=UsXMH6ysSveBHi/k+wHxKFKboC0MSZ7WzpPPG2y1L3ePMoZDcpGFuNUXQl1HCv3RCt4NHG
	OBqgM3ZKsBW+afUtalDr4WECXD7LnwvIHPXBwIbygY2dY3vT1megtDzWVENaMeSG5JUu/a
	KiZCpcdyhVdF0J7qNy9ct5jxLEN3hCw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-FP5qCIBtOIKau4PuYPAwwg-1; Tue, 11 Mar 2025 04:59:54 -0400
X-MC-Unique: FP5qCIBtOIKau4PuYPAwwg-1
X-Mimecast-MFC-AGG-ID: FP5qCIBtOIKau4PuYPAwwg_1741683593
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so11529915e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 11 Mar 2025 01:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741683593; x=1742288393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqnlKZZInNbUMVaxemGpweqmwSoqd9viWeAicyRcRjo=;
        b=EBv3mzbNABvzZN698OMovfzylK1KKcMRSOS3K4587hBU7/BQSNdX1qVqR90S00XKdp
         zUn/dHi3VUQNLApFLfRAk1ekEEi5qzegroFomNsdwojAzn6U6qi6dXDGhA/ulUFEwZmF
         p7PGvtsN8shEjuL7KOq0bRyA2MsfsMXI/hlITP8qIxVCrfLnV55j2b36LrAefTxpQQTJ
         S1WmEwl6CSR5QtqbmAZqEVbiOmGPtHhqACpow9KkOhbsY9YdNBc6yjH4pD1nJm67Ut5Y
         SRpp4SFOWpiwPLrnNt6DJ2Oh/T6sBXlq099wS8Sqjcf/rAVeLbGRWTyZoniS9ukmT97C
         4+9w==
X-Forwarded-Encrypted: i=1; AJvYcCXAWjw2G2WxjrTOKveF5EwOE44l1dJqxdv8NcNFsiVC4T3pJE53GDWZARpGuUOg1Sv8nI2DCS2lmuwi@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoz9bR/nbArI6/C9eFy6qO/IFNlaIhUHH7YWzb+F+s7V8+DKlH
	l4dmtRlK+LuhVzRlRhUdswMhLcwNwuI3BeW4yd0rWfOpuIcIiu92lQjMvpPM3coyEx+qeoIwy/d
	b8hrkGgbptnrb7TNu9oehFLKKwqAssuP5MW3/45CdrWoeGu/SJ0q2JpDng5w=
X-Gm-Gg: ASbGnctY57mY2D2AloSL1WyVPb2laXOmlFdwkop5bAd4SvbzjsWv3AuNr6ujGuefmRz
	XvVMuSy0hrm2MD0GGWfeH2jg+V46slL0zGLUhLw22/hJ/498d5sE1L5lgjAlqwkNUwOOeS/t2df
	G/OhNK7oTCYbM+jhPj8UEF6SfC61Na74oat9bLG2SbQ1hD2q7D3fpOTdJfYywsjEn/XQb49W1rb
	tjHEtvQKq9WfvbJLfkifL8kCGLUZQyEEzg/SvhzdoZEzQKsU9VfXMZHmBf26EQVmTutv2EwhE/Y
	a45geVemPr8PagJAF7mnPus3y/z1sJ0zBmVi/70Hf6mPVg==
X-Received: by 2002:a05:600c:3542:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-43d01bdbc01mr40750275e9.10.1741683593082;
        Tue, 11 Mar 2025 01:59:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ5AVycEeQIEPH/bGBFOO7jW/oC4hoyt2MafohO5QdfjBwnRvqtWeJdoi9Lli+bBR0MxeIMA==
X-Received: by 2002:a05:600c:3542:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-43d01bdbc01mr40750015e9.10.1741683592688;
        Tue, 11 Mar 2025 01:59:52 -0700 (PDT)
Received: from [192.168.88.253] (146-241-12-146.dyn.eolo.it. [146.241.12.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb79cfsm17510326f8f.10.2025.03.11.01.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 01:59:52 -0700 (PDT)
Message-ID: <2c9accbd-fd6f-421c-9d00-1f36a6152b8d@redhat.com>
Date: Tue, 11 Mar 2025 09:59:50 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/smc: use the correct ndev to find pnetid
 by pnetid table
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>, wenjia@linux.ibm.com,
 pasic@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250304124304.13732-1-guangguan.wang@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250304124304.13732-1-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/25 1:43 PM, Guangguan Wang wrote:
> When using smc_pnet in SMC, it will only search the pnetid in the
> base_ndev of the netdev hierarchy(both HW PNETID and User-defined
> sw pnetid). This may not work for some scenarios when using SMC in
> container on cloud environment.
> In container, there have choices of different container network,
> such as directly using host network, virtual network IPVLAN, veth,
> etc. Different choices of container network have different netdev
> hierarchy. Examples of netdev hierarchy show below. (eth0 and eth1
> in host below is the netdev directly related to the physical device).
>             _______________________________
>            |   _________________           |
>            |  |POD              |          |
>            |  |                 |          |
>            |  | eth0_________   |          |
>            |  |____|         |__|          |
>            |       |         |             |
>            |       |         |             |
>            |   eth1|base_ndev| eth0_______ |
>            |       |         |    | RDMA  ||
>            | host  |_________|    |_______||
>            ---------------------------------
>      netdev hierarchy if directly using host network
>            ________________________________
>            |   _________________           |
>            |  |POD  __________  |          |
>            |  |    |upper_ndev| |          |
>            |  |eth0|__________| |          |
>            |  |_______|_________|          |
>            |          |lower netdev        |
>            |        __|______              |
>            |   eth1|         | eth0_______ |
>            |       |base_ndev|    | RDMA  ||
>            | host  |_________|    |_______||
>            ---------------------------------
>             netdev hierarchy if using IPVLAN
>             _______________________________
>            |   _____________________       |
>            |  |POD        _________ |      |
>            |  |          |base_ndev||      |
>            |  |eth0(veth)|_________||      |
>            |  |____________|________|      |
>            |               |pairs          |
>            |        _______|_              |
>            |       |         | eth0_______ |
>            |   veth|base_ndev|    | RDMA  ||
>            |       |_________|    |_______||
>            |        _________              |
>            |   eth1|base_ndev|             |
>            | host  |_________|             |
>            ---------------------------------
>              netdev hierarchy if using veth
> Due to some reasons, the eth1 in host is not RDMA attached netdevice,
> pnetid is needed to map the eth1(in host) with RDMA device so that POD
> can do SMC-R. Because the eth1(in host) is managed by CNI plugin(such
> as Terway, network management plugin in container environment), and in
> cloud environment the eth(in host) can dynamically be inserted by CNI
> when POD create and dynamically be removed by CNI when POD destroy and
> no POD related to the eth(in host) anymore. It is hard to config the
> pnetid to the eth1(in host). But it is easy to config the pnetid to the
> netdevice which can be seen in POD. When do SMC-R, both the container
> directly using host network and the container using veth network can
> successfully match the RDMA device, because the configured pnetid netdev
> is a base_ndev. But the container using IPVLAN can not successfully
> match the RDMA device and 0x03030000 fallback happens, because the
> configured pnetid netdev is not a base_ndev. Additionally, if config
> pnetid to the eth1(in host) also can not work for matching RDMA device
> when using veth network and doing SMC-R in POD.
> 
> To resolve the problems list above, this patch extends to search user
> -defined sw pnetid in the clc handshake ndev when no pnetid can be found
> in the base_ndev, and the base_ndev take precedence over ndev for backward
> compatibility. This patch also can unify the pnetid setup of different
> network choices list above in container(Config user-defined sw pnetid in
> the netdevice can be seen in POD).
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> ---
>  net/smc/smc_pnet.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> index 716808f374a8..b391c2ef463f 100644
> --- a/net/smc/smc_pnet.c
> +++ b/net/smc/smc_pnet.c
> @@ -1079,14 +1079,16 @@ static void smc_pnet_find_roce_by_pnetid(struct net_device *ndev,
>  					 struct smc_init_info *ini)
>  {
>  	u8 ndev_pnetid[SMC_MAX_PNETID_LEN];
> +	struct net_device *base_ndev;
>  	struct net *net;
>  
> -	ndev = pnet_find_base_ndev(ndev);
> +	base_ndev = pnet_find_base_ndev(ndev);
>  	net = dev_net(ndev);
> -	if (smc_pnetid_by_dev_port(ndev->dev.parent, ndev->dev_port,
> +	if (smc_pnetid_by_dev_port(base_ndev->dev.parent, base_ndev->dev_port,
>  				   ndev_pnetid) &&
> +	    smc_pnet_find_ndev_pnetid_by_table(base_ndev, ndev_pnetid) &&
>  	    smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid)) {
> -		smc_pnet_find_rdma_dev(ndev, ini);
> +		smc_pnet_find_rdma_dev(base_ndev, ini);
>  		return; /* pnetid could not be determined */
>  	}
>  	_smc_pnet_find_roce_by_pnetid(ndev_pnetid, ini, NULL, net);

I understand Wenjia opposed to this solution as it may create invalid
topologies ?!?

https://lore.kernel.org/netdev/08cd6e15-3f8c-47a0-8490-103d59abf910@linux.ibm.com/#t

Wenjia, could you please confirm?

Thanks,

Paolo


