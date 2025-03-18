Return-Path: <linux-rdma+bounces-8767-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7F2A66FF7
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 10:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03935423485
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 09:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30732207651;
	Tue, 18 Mar 2025 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+8oSYLB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA90D1FA85A
	for <linux-rdma@vger.kernel.org>; Tue, 18 Mar 2025 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290601; cv=none; b=eNgRgtSc46DdisjU5XqPkVsQxOjxF2y3r4RKKBDCK/cEnsdAzawaA7cIEPQ2aVZo7Nn2biEVJo3YwQsrGYW+c1KhzlfA7y77EQc80n43wyV+430RiKYwgXPG5b17hKt7iwFLpRKZMAPv5yYd1HfhaK1UZMIsLiZrkSdTL0rt4Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290601; c=relaxed/simple;
	bh=mzBMBkkZzeq6MOHImrnUvgj4qWJoLUYsd5OZKQZmC1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrHr3ebxkrvFf9VMr0K30k3kXgnGWjWvT5dkd//jK7bvC54GIXxO3xqnpvCafEpm/T/saGQaCWnjM8kFtGmzqOanRBaEhn1zroqBtLLK4YGI0K/oG0oLJkAGH6duxsveZNkRXjcwRXnWLzyiPVD3IjBYnWs0tGha8qR0VzIIukA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+8oSYLB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742290598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CvKDg3JDHn9jOPRmkfFXXZUafsnEo6j8hP0TAoVHOek=;
	b=N+8oSYLBpcovomJSsduvih+8YQBohCUHqv8N2/aFxE/ylxgbyG4uO24weOdGCoBwmndpMZ
	1P7/Q8O32MoN/yGYGHWA4eY6Ifb4uFz+AEFoOu+dbWTZCEfOEmelZm/vQ9icDMCTPqJk2V
	1tHvMhFA3+TM5+ZAbPntL/do0X+0QCQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-qxJlpgeFP7-CAy3ZDM0sBQ-1; Tue, 18 Mar 2025 05:36:36 -0400
X-MC-Unique: qxJlpgeFP7-CAy3ZDM0sBQ-1
X-Mimecast-MFC-AGG-ID: qxJlpgeFP7-CAy3ZDM0sBQ_1742290596
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4394040fea1so15104715e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 18 Mar 2025 02:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742290595; x=1742895395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CvKDg3JDHn9jOPRmkfFXXZUafsnEo6j8hP0TAoVHOek=;
        b=ijvCXZjCDR5MjlBXPnjUBAN3FKlzGQ+yOidgdGmcdlvbcPXRmDYznu/ArGjOuq+/Qs
         mMHATdHr8+4ij88roDRTUoaLfOdzOVZAQBRpMeiWUMAcCN//TxSUrtTunLw+UdzgkMp5
         iRIBxb5PFACjvvSy6B7zd84dz64dyJ/zbeEzAYOylT0RyG6lmt+O0zHopXIMYYl8tyZp
         OEJ5TSTRwc6KkYSlRmUy6PZLycUUfaTi4JncFsr4kfvBpF/OiWddTmBvRptvI9XjNVWh
         qqZzPxxQnRFBnMAYWrpJ0LYlopHjtJlu2nghh7G2YU70pKpWKMDY2D5yeFVNtTkh6ImT
         uahw==
X-Forwarded-Encrypted: i=1; AJvYcCWnGP4jSpANfWV5S4SjDyJU0T9Uz79Z1vUu5gsoJzHm4Gj4CpMZYotTF51d291QZvS9IybpFHVO0zX6@vger.kernel.org
X-Gm-Message-State: AOJu0YyH+uO5Qd4FnR82zrk60E0lmpa4Sn/gTt0BwwApEPzQQ6FVP7y0
	gafjB1BDBlWdUcFZMcZ5iFP0RsTYeDjEz0qMJSjAucg4Hl69TMYDzFw+GbDPCwtc613LOaN6443
	Y1DTpMjbljsywSpkcjMhfzvsT2Yx+vLyNA+gRTHUAUYfjKvxaHYSqQEN+N9yH6tMCyfo=
X-Gm-Gg: ASbGncs7cPSQ1f7FgWZAfvv+UcCZwKJdDtAzMFZxlbmxK7kx0rDB6qhFqGV2do8OQe8
	m/FTlBkNh9eaAKg6F6EjHbQnHb37DnGR3n67Rvwv5n7CEIItaUV5c/MfvBGcI5KTy0MmiAF3FA/
	kZGV3ROHU7OOVa7V8onR0XkeMn2n2eI0UGvprMSEaSgzRSdEEap1jazciqOufM9UMJrlao3g6Zc
	HxlZGoA5LV5fPXi4o8GZ0bPud4Ghk6htnYcp/g4VPDE5l7JL5bC7IvHqi0F988u9+zIQcxGrtP1
	h0fXmjXuMuvPhZRMaaGOcvEIPmNyuDJT10d5HfQex59d5g==
X-Received: by 2002:a05:600c:4f4a:b0:439:8490:d1e5 with SMTP id 5b1f17b1804b1-43d3b981324mr14252895e9.4.1742290595258;
        Tue, 18 Mar 2025 02:36:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3vTKKmwKw0Z8Ob8YbB5NUPivxHGNKx120DzCxn23HNlzcDtLNTUy32hinrYTNPH+w/sR52A==
X-Received: by 2002:a05:600c:4f4a:b0:439:8490:d1e5 with SMTP id 5b1f17b1804b1-43d3b981324mr14252415e9.4.1742290594821;
        Tue, 18 Mar 2025 02:36:34 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d28565b17sm94485335e9.37.2025.03.18.02.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 02:36:34 -0700 (PDT)
Message-ID: <65bfbea3-8007-43ec-af58-2d61f5488a88@redhat.com>
Date: Tue, 18 Mar 2025 10:36:32 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] net/mlx5: Add support for setting parent of
 nodes
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <1741642016-44918-1-git-send-email-tariqt@nvidia.com>
 <1741642016-44918-5-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1741642016-44918-5-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/25 10:26 PM, Tariq Toukan wrote:
> @@ -1018,3 +1018,105 @@ int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
>  	node = parent_priv;
>  	return mlx5_esw_qos_vport_update_parent(vport, node, extack);
>  }
> +
> +static int
> +mlx5_esw_qos_node_validate_set_parent(struct mlx5_esw_sched_node *node,
> +				      struct mlx5_esw_sched_node *parent,
> +				      struct netlink_ext_ack *extack)
> +{
> +	u8 new_level, max_level;
> +
> +	if (parent && parent->esw != node->esw) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Cannot assign node to another E-Switch");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (!list_empty(&node->children)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Cannot reassign a node that contains rate objects");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	new_level = parent ? parent->level + 1 : 2;
> +	max_level = 1 << MLX5_CAP_QOS(node->esw->dev, log_esw_max_sched_depth);
> +	if (new_level > max_level) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Node hierarchy depth exceeds the maximum supported level");

Minor nit for a possible small follow-up: it could be possibly useful to
add to the extact the current and max level.

/P


