Return-Path: <linux-rdma+bounces-2292-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 168238BCC7F
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 12:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E102849C9
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 10:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC5F142E6B;
	Mon,  6 May 2024 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCqVXqTF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB81F128372;
	Mon,  6 May 2024 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714993098; cv=none; b=ALn37OJVLOeU50AoBE8tt+K4tjr+sQ5lsPA9aQnTy2MXo18nlhL4KBqvugyxDeoa1Gz/vAOr71iDSqfUqLiFMd9pwZJ7p3EE5Mc3zgFawcOlrPJ4FQvI1JRRxgbWDh/us1QnMfEypFQ/GsPzDsPrSltF/JCG25IRCooRcNB2zs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714993098; c=relaxed/simple;
	bh=tEPeZeocclLOEpLPNlkCbJjsCP/8GA1N87aJcN/m4jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqAbrwUmJEPgNKiU0/c53Qz/cxiURqVs1Y1UOQ/sdg++b+NZmcJVCN/LQpK58F0Or2Kj1rC+DbgnzI24ZtQ4g+GM19BW40kEoNwvnhAUYmNqKAGH/j1+dQn2UYBCyEpbor/QQ69Ufzht16pLMcsYcv25x6jLsRnecSguYeV34TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCqVXqTF; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34ef66c0178so914498f8f.1;
        Mon, 06 May 2024 03:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714993095; x=1715597895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XkrK48XDqkqdyPXOcxfheKKZzV9bvOmNNiZ+pXNbsmQ=;
        b=KCqVXqTF6k75L03iHN8nxW/PY/eVaiNso9lW2kjv/hkDcNZyAiETHjPjiI4939WVD6
         5E/BLcPpYusuRhGEEo+fBj8Fh0v04deNaaz0kv97uh8hrgLoMIP4oS6xXV44pkEDcwJb
         64BYP70DTqTUIr//enFfQpgcWuufyDF0gTZLslDf60jYGMmMsddgQ7qyJxpm4yLRnrza
         EDEl9U7UdQJUwTPNPjV+g0++LF1bE1WMDKgwL+wlVTkz+51OB0PsN9spY04qKck1NNzw
         dpAV2xnECkX70i8+KGVKflPVPpABl2P8HIEEu0PeKrwt4ysVz3KZGGQFJdAQleUSHqao
         6Q/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714993095; x=1715597895;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkrK48XDqkqdyPXOcxfheKKZzV9bvOmNNiZ+pXNbsmQ=;
        b=RKOihomzImongsuNJzif1/nUzHAhY0axVfIPtisCMmEy8tT7j0lrIYqVRigvTsuZyQ
         1F/+xhLNa+P7lnW6XU4iDk828FBnDwCKX5MMMnHmI6Y+bBj/c/uF4w01mPQksUw2WT5x
         e+8gjlyBqJ/406zCys4KAFTtiKk7t9vWz1Wla9z+SZ+L/SuJkUynQphIFZj13sd7qYRU
         /OADhXuSmMmIFDmYtwhcaLn3Pc7DA5jfmnh+WrT0d6E2DJTn+ip1HRbA+hWJisRuml6N
         W/FQZSY7HtAEXBk810KVsBDwVcobo0brIMKYcMeyl3I+ag98Nsx0u4XkCHdR4TNC/RYJ
         SIgg==
X-Forwarded-Encrypted: i=1; AJvYcCXbfTU8uLyo9itqRFWrgSX+LxOANchAy7Esbc6NuHmmfgNsE3ZowT+lyrtjq5uNB0ssKVEo6yKHdKG2eOwd3D45tkrU7pQl3SC8bg==
X-Gm-Message-State: AOJu0YwADI7+ayLPvEnn8aJ45azZhURDHHolMyYSjV3DHcp7256X41ly
	cPqC9lrBvQsvyja5xkMw0NUGwvct8NghmWf/3A6M/Hf3nYhwl4LQ
X-Google-Smtp-Source: AGHT+IELL9UP+t11KZLqkMg1UdSNL2djJ1+JjD4pPJ3iZcc5wpGNwPNaPvETeVCbR5xTAR8HbP9hVQ==
X-Received: by 2002:a5d:50c2:0:b0:34c:f3cb:64cb with SMTP id f2-20020a5d50c2000000b0034cf3cb64cbmr9009503wrt.52.1714993094937;
        Mon, 06 May 2024 03:58:14 -0700 (PDT)
Received: from [10.16.155.254] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id p3-20020a5d59a3000000b0034def22f93csm10481870wrr.69.2024.05.06.03.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 03:58:14 -0700 (PDT)
Message-ID: <6a285586-0a11-43be-a07a-5ba0b92d0ee6@gmail.com>
Date: Mon, 6 May 2024 12:58:13 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [question] when bonding with CX5 network card that support ROCE
To: shaozhengchao <shaozhengchao@huawei.com>, saeedm@nvidia.com,
 tariqt@nvidia.com, borisp@nvidia.com, shayd@nvidia.com, msanalla@nvidia.com,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, weizhang@nvidia.com,
 kliteyn@nvidia.com, erezsh@nvidia.com, igozlan@nvidia.com
Cc: netdev <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org
References: <756aaf3c-5a15-8d18-89d4-ea7380cf845d@huawei.com>
 <7b0e61e1-8d50-4431-bd0a-6398c618a609@linux.dev>
 <bb68fc32-9c6c-ceda-a961-f4fde72ce64d@huawei.com>
Content-Language: en-US
From: Zhu Yanjun <zyjzyj2000@gmail.com>
In-Reply-To: <bb68fc32-9c6c-ceda-a961-f4fde72ce64d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 06.05.24 12:45, shaozhengchao wrote:
> Hi yanjun:
>   The following is the command output after the cat /proc/net/bonding
> /bond0 command is run:

If I remember it correctly, it seems that it is a rdma LAG and bonding 
problem.

Not sure if it is a known problem or not. Please contact your local support.

Zhu Yanjun

> [root@localhost ~]# cat /proc/net/bonding/bond0
> Ethernet Channel Bonding Driver: v5.10.0+
>
> Bonding Mode: IEEE 802.3ad Dynamic link aggregation
> Transmit Hash Policy: layer2 (0)
> MII Status: up
> MII Polling Interval (ms): 100
> Up Delay (ms): 0
> Down Delay (ms): 0
> Peer Notification Delay (ms): 0
>
> 802.3ad info
> LACP rate: slow
> Min links: 0
> Aggregator selection policy (ad_select): stable
> System priority: 65535
> System MAC address: f4:1d:6b:6f:3b:97
> Active Aggregator Info:
>         Aggregator ID: 2
>         Number of ports: 1
>         Actor Key: 23
>         Partner Key: 1
>         Partner Mac Address: 00:00:00:00:00:00
>
> Slave Interface: enp145s0f0
> MII Status: up
> Speed: 40000 Mbps
> Duplex: full
> Link Failure Count: 1
> Permanent HW addr: f4:1d:6b:6f:3b:97
> Slave queue ID: 0
> Aggregator ID: 1
> Actor Churn State: churned
> Partner Churn State: churned
> Actor Churned Count: 1
> Partner Churned Count: 2
> details actor lacp pdu:
>     system priority: 65535
>     system mac address: f4:1d:6b:6f:3b:97
>     port key: 23
>     port priority: 255
>     port number: 1
>     port state: 69
> details partner lacp pdu:
>     system priority: 65535
>     system mac address: 00:00:00:00:00:00
>     oper key: 1
>     port priority: 255
>     port number: 1
>     port state: 1
>
> Slave Interface: enp145s0f1
> MII Status: up
> Speed: 40000 Mbps
> Duplex: full
> Link Failure Count: 0
> Permanent HW addr: f4:1d:6b:6f:3b:98
> Slave queue ID: 0
> Aggregator ID: 2
> Actor Churn State: none
> Partner Churn State: churned
> Actor Churned Count: 0
> Partner Churned Count: 1
> details actor lacp pdu:
>     system priority: 65535
>     system mac address: f4:1d:6b:6f:3b:97
>     port key: 23
>     port priority: 255
>     port number: 2
>     port state: 77
> details partner lacp pdu:
>     system priority: 65535
>     system mac address: 00:00:00:00:00:00
>     oper key: 1
>     port priority: 255
>     port number: 1
>     port state: 1
>
> Thank you
> Zhengchao Shao
>
>
> On 2024/5/6 16:26, Zhu Yanjun wrote:
>> On 06.05.24 06:46, shaozhengchao wrote:
>>>
>>> When using the 5.10 kernel, I can find two IB devices using the 
>>> ibv_devinfo command.
>>> ----------------------------------
>>> [root@localhost ~]# lspci
>>> 91:00.0 Ethernet controller: Mellanox Technologies MT27800 Family 
>>> [ConnectX-5]
>>> 91:00.1 Ethernet controller: Mellanox Technologies MT27800 Family
>>> ----------------------------------
>>> [root@localhost ~]# ibv_devinfo
>>> hca_id: mlx5_0
>>>          transport:                      InfiniBand (0)
>>>          fw_ver:                         16.31.1014
>>>          node_guid:                      f41d:6b03:006f:4743
>>>          sys_image_guid:                 f41d:6b03:006f:4743
>>>          vendor_id:                      0x02c9
>>>          vendor_part_id:                 4119
>>>          hw_ver:                         0x0
>>>          board_id:                       HUA0000000004
>>>          phys_port_cnt:                  1
>>>                  port:   1
>>>                          state:                  PORT_ACTIVE (4)
>>>                          max_mtu:                4096 (5)
>>>                          active_mtu:             1024 (3)
>>>                          sm_lid:                 0
>>>                          port_lid:               0
>>>                          port_lmc:               0x00
>>>                          link_layer:             Ethernet
>>>
>>> hca_id: mlx5_1
>>>          transport:                      InfiniBand (0)
>>>          fw_ver:                         16.31.1014
>>>          node_guid:                      f41d:6b03:006f:4744
>>>          sys_image_guid:                 f41d:6b03:006f:4743
>>>          vendor_id:                      0x02c9
>>>          vendor_part_id:                 4119
>>>          hw_ver:                         0x0
>>>          board_id:                       HUA0000000004
>>>          phys_port_cnt:                  1
>>>                  port:   1
>>>                          state:                  PORT_ACTIVE (4)
>>>                          max_mtu:                4096 (5)
>>>                          active_mtu:             1024 (3)
>>>                          sm_lid:                 0
>>>                          port_lid:               0
>>>                          port_lmc:               0x00
>>>                          link_layer:             Ethernet
>>> ----------------------------------
>>> But after the two network ports are bonded, only one IB device is
>>> available, and only PF0 can be used.
>>> [root@localhost shaozhengchao]# ibv_devinfo
>>> hca_id: mlx5_bond_0
>>>          transport:                      InfiniBand (0)
>>>          fw_ver:                         16.31.1014
>>>          node_guid:                      f41d:6b03:006f:4743
>>>          sys_image_guid:                 f41d:6b03:006f:4743
>>>          vendor_id:                      0x02c9
>>>          vendor_part_id:                 4119
>>>          hw_ver:                         0x0
>>>          board_id:                       HUA0000000004
>>>          phys_port_cnt:                  1
>>>                  port:   1
>>>                          state:                  PORT_ACTIVE (4)
>>>                          max_mtu:                4096 (5)
>>>                          active_mtu:             1024 (3)
>>>                          sm_lid:                 0
>>>                          port_lid:               0
>>>                          port_lmc:               0x00
>>>                          link_layer:             Ethernet
>>>
>>> The current Linux mainline driver is the same.
>>>
>>> I found the comment ("If bonded, we do not add an IB device for PF1.")
>>> in the mlx5_lag_intf_add function of the 5.10 branch driver code.
>>
>> Not sure if rdma lag is enabled for this or not. /proc/net/bonding 
>> will provide more more details normally.
>>
>> Zhu Yanjun
>>
>>> This indicates that wthe the same NIC is used, only PF0 support 
>>> bonding?
>>> Are there any other constraints, when enable bonding with CX5?
>>>
>>> Thank you
>>> Zhengchao Shao
>>

