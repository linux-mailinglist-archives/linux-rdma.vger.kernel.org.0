Return-Path: <linux-rdma+bounces-11431-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB41AADF0E8
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 17:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52563BB5C6
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 15:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBDD2EF287;
	Wed, 18 Jun 2025 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="cAXE5pvd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B382EAB83
	for <linux-rdma@vger.kernel.org>; Wed, 18 Jun 2025 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259653; cv=none; b=pJm0rpseS9AgkiEATHrW1zO+2O83LPSRAZ08+CCDmYRFwZkcQ3/GRL8IbvVpnpP8XSg5o2GaEpOmRA3yN8mEaN6k2FPyEKkmZDO4v3G2NWhZcFsCUvGRYPqwKoOqUBZfXuOTGP1YXEm1HNyuKaNc83Wr6f1khkBU4BYyrr+uHdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259653; c=relaxed/simple;
	bh=OHrir3aF+muHdTCqQ6G0ZKUnxcCBUpS6B1dB8OgPAEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQ4mhz/34ph5C8BEBVs+b3U7lf9qTwjiwzrwhcunQwbyeh0GXoqgniNmvAy1Wdm760AoOF3B/4mWnMO1lcyT4JrHZHYPzIefEoold5FCsQ3WaMg96QUKVx0WY/5E49t8dbmLMsnalIesu6LiB6VWCgOMMgEezru3dbDPrOpqMwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=cAXE5pvd; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo13672462a12.3
        for <linux-rdma@vger.kernel.org>; Wed, 18 Jun 2025 08:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1750259650; x=1750864450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+S+UmywS1cMQlzcb0xKkbPVLyMmpj3IBlRdMtTw736I=;
        b=cAXE5pvdWrB+tKsNUHmxmRykRjlOz2u4k5zL4uTzSoj6Fqf/+u6KV49THicObdq/vO
         KN/XvoAEc9XMZniPfOwk9cljU0AsSAEp17uVtGoZJbOEo9GDGkdKfsv6+gCTZAhIIH1/
         x/psxYC9fHKp8IKFyGWlDBL/Y8/e6VGEjrUr+rXPvQBX/C6eIn2nNxEwpQf2BZs9gyxn
         RkZoKVIL8VZRPVoHsmGpteT52yoky6FtSEZMojzYt01i4TVsIchcsM0dMimqCj3ffpf4
         F9x+AVOgKHQ5X+9vrwyoB+01bdx3hLk0Kw466HwnnffeUV3SJI4gtGS/a36mW5mukZf3
         H73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750259650; x=1750864450;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+S+UmywS1cMQlzcb0xKkbPVLyMmpj3IBlRdMtTw736I=;
        b=n6LnLADCRljP6q9eAM7M6bG1Rfx7z9f2lrsmpg40pnFjQL1mJRwH/cfZs/MarK90S8
         ofkyeFar1QXPzRY95lKWJAe+74bjV1BFVti7gQ4BSLB85suuFe0EClyI8uEwtZNRO/QK
         1JToN2eiXQsHR0fNmEKg5n3qrmXDN6MDAdZkU3qifHQL7yHdgcqzLnyWcGoB7eqlAyz0
         CELMzidn5h2HFXFiHr3JVenAuZpU5kiJwZCnN+pAVsxAiVYj4rOVCnVvBBUb43guXEJb
         SqMhNIDMRPJXuVA2hDJ1qYZm8LoSlprnIv+Z29MLYe4aEyIWRN2asLOZOfUwaA6HUqcp
         nhkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVb7k38Fog6IdwmuRZp3WuX0MPz5IXYRcWIhKD3OgoPZXnuoUSbb5jBrBNERDsFUoxEZh54zT2yN1v@vger.kernel.org
X-Gm-Message-State: AOJu0YwPQhLPg5wL1ktk1PkNqf9jFP6u+Zqnag9ofyD23bqauStdL6Gb
	tTDXhLA5cW4J7FA49FEH/l14CZ5LKFMu5CfWk0C2c+ekbve7sL6BAinNBt14FiMuRXk=
X-Gm-Gg: ASbGncti/VbX4Lc8XZt44PcqEwojWGT2UHk0emL3HpqK3XXl8zvjTpAfA7LtaByA3FU
	6QMyPBo69h4ersdVi8dyMeib6OPHqGl4Sq51nXCwt7DUuOZeAITH2bFgvHIb7JA21JB+8w+fHH1
	PzLVpj8VRQ9X7CfG3lXb/VIPUml9X0lLJ9WKji5QHVe/wTZWkuUoxmyrf/EWAy7YmBIowD8kP04
	e205HKqIQoIyIgkaLyG2KF5TuKGUpd6sbwZwXvxGZfKSrw1hYVOAYemKRUpq6O0ls/Mliwdt1sz
	werbNkCPcx9mOEjuCQuWuIiEMSKRDZZM/2k1D2CKCtqYBelBetubp3I0464u3RXVbg6A0Q/xGHN
	T+z2AdMdgwld6BaREog==
X-Google-Smtp-Source: AGHT+IEnxsS/Uvtcf+zcb/7M6kEE3A6RliSG0ulwTdKyTBE8eC4slu4mGjug2HX09alf/gW+PK3nnQ==
X-Received: by 2002:a05:6402:348f:b0:602:225e:1d46 with SMTP id 4fb4d7f45d1cf-608d0835bf5mr17037976a12.3.1750259649535;
        Wed, 18 Jun 2025 08:14:09 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48cd687sm9869313a12.18.2025.06.18.08.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 08:14:08 -0700 (PDT)
Message-ID: <22ec7ed6-9c38-4f81-9ec4-024da12b8710@blackwall.org>
Date: Wed, 18 Jun 2025 18:14:06 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/6] geneve: rely on rtnl lock in
 geneve_offload_rx_ports
To: Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, skalluru@marvell.com, manishc@marvell.com,
 andrew+netdev@lunn.ch, michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
 somnath.kotur@broadcom.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, tariqt@nvidia.com, saeedm@nvidia.com,
 louis.peens@corigine.com, shshaikh@marvell.com,
 GR-Linux-NIC-Dev@marvell.com, ecree.xilinx@gmail.com, horms@kernel.org,
 dsahern@kernel.org, shuah@kernel.org, tglx@linutronix.de, mingo@kernel.org,
 ruanjinjie@huawei.com, idosch@nvidia.com, petrm@nvidia.com,
 kuniyu@google.com, sdf@fomichev.me, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 oss-drivers@corigine.com, linux-net-drivers@amd.com,
 linux-kselftest@vger.kernel.org, leon@kernel.org
References: <20250616162117.287806-1-stfomichev@gmail.com>
 <20250616162117.287806-2-stfomichev@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250616162117.287806-2-stfomichev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/25 19:21, Stanislav Fomichev wrote:
> udp_tunnel_push_rx_port will grab mutex in the next patch so
> we can't use rcu. geneve_offload_rx_ports is called
> from geneve_netdevice_event for NETDEV_UDP_TUNNEL_PUSH_INFO and
> NETDEV_UDP_TUNNEL_DROP_INFO which both have ASSERT_RTNL.
> Entries are added to and removed from the sock_list under rtnl
> lock as well (when adding or removing a tunneling device).
> 
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> ---
>  drivers/net/geneve.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index ffc15a432689..9efedc6758bf 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c
> @@ -41,6 +41,7 @@ MODULE_PARM_DESC(log_ecn_error, "Log packets received with corrupted ECN");
>  /* per-network namespace private data for this module */
>  struct geneve_net {
>  	struct list_head	geneve_list;
> +	/* sock_list is protected by rtnl lock */
>  	struct list_head	sock_list;
>  };
>  
> @@ -1179,8 +1180,9 @@ static void geneve_offload_rx_ports(struct net_device *dev, bool push)
>  	struct geneve_net *gn = net_generic(net, geneve_net_id);
>  	struct geneve_sock *gs;
>  
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(gs, &gn->sock_list, list) {
> +	ASSERT_RTNL();
> +
> +	list_for_each_entry(gs, &gn->sock_list, list) {
>  		if (push) {
>  			udp_tunnel_push_rx_port(dev, gs->sock,
>  						UDP_TUNNEL_TYPE_GENEVE);
> @@ -1189,7 +1191,6 @@ static void geneve_offload_rx_ports(struct net_device *dev, bool push)
>  						UDP_TUNNEL_TYPE_GENEVE);
>  		}
>  	}
> -	rcu_read_unlock();
>  }
>  
>  /* Initialize the device structure. */

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


