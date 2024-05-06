Return-Path: <linux-rdma+bounces-2295-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1C58BCDE8
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 14:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1991C239B6
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 12:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5E3143C4E;
	Mon,  6 May 2024 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1D7Wu8Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B688F143888;
	Mon,  6 May 2024 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714998472; cv=none; b=paKLbCPxVLrm9cizLRBcLZm8Gs/+JEtWSXKO7ZCnNy/R8yPdWEHwHXXF31NQATzLQFm9yucDSxg9Lta0TIyOLfVOb08KubH9/cQv/igAcDaxA4nV1g+p1hFxQCv8h3N+j/g7Ve8yC8TQ9+bqf9Oe6AnAyHTb078fiZ7jZtJzCTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714998472; c=relaxed/simple;
	bh=QIDgC7M2QIJH3OC2V3oQYH87Kwk5aBHA5wGClCTcfc8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OO5ijtWHy5rVQdUf+BJ45eP058Ok0KR70HPOoA//kZG08YkP0hvFYg91gv9xAfabIDRt/gc/r6RsKCNZNygoqwTVis0JwDp2ciC206Lr86KRaxuzNz/z9qak6+GmZ3RVt6CSJTPhAGQtq/eJTm1e+tpzjYzJoEvuNq2vQvmlZwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1D7Wu8Y; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e242b1dfd6so21382331fa.0;
        Mon, 06 May 2024 05:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714998469; x=1715603269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GXuvYiX4OuwwkykJkn6HJJb0V+/lp12wExSlpOrSCd0=;
        b=F1D7Wu8YvPm848358qbkftgvgN98nMuGSu0mQFPYbpyMPWhhHWNBW+NNuWdOFHfS7k
         9kBke+iu7B2s72NrQLTcxZTgPXFO3gdgUywinHGym+bobnPM3T2aIK/JHJjnalTSAJrK
         3EwbRUEkwabAHmsd1hE8q8s8XJxDSCrv4gwZK4wLL1QsrHxkRRSyIbcoMK8+3J1PmzpJ
         2EdaBOK1XJxBYukzBhUIO0XfutEBZ7gVcwS7f0XahMYZ9hrUwcGO56Fxi3jc95FnUsIt
         8fJ5tNKKZ3QJBQSw0BEq9q0U9u601FRuHZdg5rLvdMxJK+flOfArayQ9xcOtCXleVqP1
         uvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714998469; x=1715603269;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GXuvYiX4OuwwkykJkn6HJJb0V+/lp12wExSlpOrSCd0=;
        b=vl+g8cCqbNOtuam/QcWE4/gfVxecTipdB2vFGCozZaTCrM+Mika1KMcNGlDtQtHsqX
         wJOOlt+Ri6cvQiz5qs+zelgZyiRepnx2JYNKHXe8BI03dYIpRblNj/FM/G1NBHLav+CB
         MLcMTxz+ghQMvG+rviUBv/3Z9uqPZxuhKJ9ehn8I37/0cGqvf8cPYsZIfplssqyKnFYm
         A0TlLuHdDOoN3kxtIvnWbJD8PqROZoAESTqmW9jnl3wzpHq2uTh0BBXR/KN0C+MEr0/m
         vSs+6Ta9qELHxtvvniXv1YivxGibFjs0ntHR9/3zMSFBuOZi5JYOXY9125GMLuie5EgE
         bHSA==
X-Forwarded-Encrypted: i=1; AJvYcCXEsDIV7NdGmYUuM/XTD5AbUfSkXu35hJjqVy3SWKdCytFCSQtu8wRVH7cEkukOr9F4y49oGNaDSIVQqLjSgHSQrFi89tojq8MYtA==
X-Gm-Message-State: AOJu0YyEmKmoWTgbD2i0Jva2P47ylrkNE8hTV+f3dGFMULU3mSOKuZCf
	2oYOlMtNc8E6cSqarMeshS933xQd0V4zJFSgwgXcUwPtg6MyNDk7
X-Google-Smtp-Source: AGHT+IFjG4IRzJJM3v0kd+1DhmMRPvtproZFd9Mx8ib10xCzG9dcydL/Vhf38U10+hPs9VmZMXApwA==
X-Received: by 2002:a2e:b006:0:b0:2e1:c6bd:ebba with SMTP id y6-20020a2eb006000000b002e1c6bdebbamr6177105ljk.1.1714998466559;
        Mon, 06 May 2024 05:27:46 -0700 (PDT)
Received: from [10.16.124.60] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c450900b0041bd920d41csm15863308wmo.1.2024.05.06.05.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 05:27:46 -0700 (PDT)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <f49c80dc-6138-4073-b873-97f729817790@linux.dev>
Date: Mon, 6 May 2024 14:27:45 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [question] when bonding with CX5 network card that support ROCE
To: shaozhengchao <shaozhengchao@huawei.com>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, saeedm@nvidia.com, tariqt@nvidia.com,
 borisp@nvidia.com, shayd@nvidia.com, msanalla@nvidia.com,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, weizhang@nvidia.com,
 kliteyn@nvidia.com, erezsh@nvidia.com, igozlan@nvidia.com
Cc: netdev <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org
References: <756aaf3c-5a15-8d18-89d4-ea7380cf845d@huawei.com>
 <7b0e61e1-8d50-4431-bd0a-6398c618a609@linux.dev>
 <bb68fc32-9c6c-ceda-a961-f4fde72ce64d@huawei.com>
 <6a285586-0a11-43be-a07a-5ba0b92d0ee6@gmail.com>
 <d345b292-e5a1-a428-f5e1-74a6c0c390d9@huawei.com>
Content-Language: en-US
In-Reply-To: <d345b292-e5a1-a428-f5e1-74a6c0c390d9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06.05.24 13:33, shaozhengchao wrote:
> 
> Hi Yanjun:
>    Thank you for your reply. Are there any other restrictions on using
> ROCE on the CX5?

https://docs.nvidia.com/networking/display/mlnxofedv571020

The above link can answer all your questions ^_^

Enjoy it.

Zhu Yanjun

> 
> Zhengchao Shao
> 
> On 2024/5/6 18:58, Zhu Yanjun wrote:
>>
>> On 06.05.24 12:45, shaozhengchao wrote:
>>> Hi yanjun:
>>>   The following is the command output after the cat /proc/net/bonding
>>> /bond0 command is run:
>>
>> If I remember it correctly, it seems that it is a rdma LAG and bonding 
>> problem.
>>
>> Not sure if it is a known problem or not. Please contact your local 
>> support.
>>
>> Zhu Yanjun
>>
>>> [root@localhost ~]# cat /proc/net/bonding/bond0
>>> Ethernet Channel Bonding Driver: v5.10.0+
>>>
>>> Bonding Mode: IEEE 802.3ad Dynamic link aggregation
>>> Transmit Hash Policy: layer2 (0)
>>> MII Status: up
>>> MII Polling Interval (ms): 100
>>> Up Delay (ms): 0
>>> Down Delay (ms): 0
>>> Peer Notification Delay (ms): 0
>>>
>>> 802.3ad info
>>> LACP rate: slow
>>> Min links: 0
>>> Aggregator selection policy (ad_select): stable
>>> System priority: 65535
>>> System MAC address: f4:1d:6b:6f:3b:97
>>> Active Aggregator Info:
>>>         Aggregator ID: 2
>>>         Number of ports: 1
>>>         Actor Key: 23
>>>         Partner Key: 1
>>>         Partner Mac Address: 00:00:00:00:00:00
>>>
>>> Slave Interface: enp145s0f0
>>> MII Status: up
>>> Speed: 40000 Mbps
>>> Duplex: full
>>> Link Failure Count: 1
>>> Permanent HW addr: f4:1d:6b:6f:3b:97
>>> Slave queue ID: 0
>>> Aggregator ID: 1
>>> Actor Churn State: churned
>>> Partner Churn State: churned
>>> Actor Churned Count: 1
>>> Partner Churned Count: 2
>>> details actor lacp pdu:
>>>     system priority: 65535
>>>     system mac address: f4:1d:6b:6f:3b:97
>>>     port key: 23
>>>     port priority: 255
>>>     port number: 1
>>>     port state: 69
>>> details partner lacp pdu:
>>>     system priority: 65535
>>>     system mac address: 00:00:00:00:00:00
>>>     oper key: 1
>>>     port priority: 255
>>>     port number: 1
>>>     port state: 1
>>>
>>> Slave Interface: enp145s0f1
>>> MII Status: up
>>> Speed: 40000 Mbps
>>> Duplex: full
>>> Link Failure Count: 0
>>> Permanent HW addr: f4:1d:6b:6f:3b:98
>>> Slave queue ID: 0
>>> Aggregator ID: 2
>>> Actor Churn State: none
>>> Partner Churn State: churned
>>> Actor Churned Count: 0
>>> Partner Churned Count: 1
>>> details actor lacp pdu:
>>>     system priority: 65535
>>>     system mac address: f4:1d:6b:6f:3b:97
>>>     port key: 23
>>>     port priority: 255
>>>     port number: 2
>>>     port state: 77
>>> details partner lacp pdu:
>>>     system priority: 65535
>>>     system mac address: 00:00:00:00:00:00
>>>     oper key: 1
>>>     port priority: 255
>>>     port number: 1
>>>     port state: 1
>>>
>>> Thank you
>>> Zhengchao Shao
>>>
>>>
>>> On 2024/5/6 16:26, Zhu Yanjun wrote:
>>>> On 06.05.24 06:46, shaozhengchao wrote:
>>>>>
>>>>> When using the 5.10 kernel, I can find two IB devices using the 
>>>>> ibv_devinfo command.
>>>>> ----------------------------------
>>>>> [root@localhost ~]# lspci
>>>>> 91:00.0 Ethernet controller: Mellanox Technologies MT27800 Family 
>>>>> [ConnectX-5]
>>>>> 91:00.1 Ethernet controller: Mellanox Technologies MT27800 Family
>>>>> ----------------------------------
>>>>> [root@localhost ~]# ibv_devinfo
>>>>> hca_id: mlx5_0
>>>>>          transport:                      InfiniBand (0)
>>>>>          fw_ver:                         16.31.1014
>>>>>          node_guid:                      f41d:6b03:006f:4743
>>>>>          sys_image_guid:                 f41d:6b03:006f:4743
>>>>>          vendor_id:                      0x02c9
>>>>>          vendor_part_id:                 4119
>>>>>          hw_ver:                         0x0
>>>>>          board_id:                       HUA0000000004
>>>>>          phys_port_cnt:                  1
>>>>>                  port:   1
>>>>>                          state:                  PORT_ACTIVE (4)
>>>>>                          max_mtu:                4096 (5)
>>>>>                          active_mtu:             1024 (3)
>>>>>                          sm_lid:                 0
>>>>>                          port_lid:               0
>>>>>                          port_lmc:               0x00
>>>>>                          link_layer:             Ethernet
>>>>>
>>>>> hca_id: mlx5_1
>>>>>          transport:                      InfiniBand (0)
>>>>>          fw_ver:                         16.31.1014
>>>>>          node_guid:                      f41d:6b03:006f:4744
>>>>>          sys_image_guid:                 f41d:6b03:006f:4743
>>>>>          vendor_id:                      0x02c9
>>>>>          vendor_part_id:                 4119
>>>>>          hw_ver:                         0x0
>>>>>          board_id:                       HUA0000000004
>>>>>          phys_port_cnt:                  1
>>>>>                  port:   1
>>>>>                          state:                  PORT_ACTIVE (4)
>>>>>                          max_mtu:                4096 (5)
>>>>>                          active_mtu:             1024 (3)
>>>>>                          sm_lid:                 0
>>>>>                          port_lid:               0
>>>>>                          port_lmc:               0x00
>>>>>                          link_layer:             Ethernet
>>>>> ----------------------------------
>>>>> But after the two network ports are bonded, only one IB device is
>>>>> available, and only PF0 can be used.
>>>>> [root@localhost shaozhengchao]# ibv_devinfo
>>>>> hca_id: mlx5_bond_0
>>>>>          transport:                      InfiniBand (0)
>>>>>          fw_ver:                         16.31.1014
>>>>>          node_guid:                      f41d:6b03:006f:4743
>>>>>          sys_image_guid:                 f41d:6b03:006f:4743
>>>>>          vendor_id:                      0x02c9
>>>>>          vendor_part_id:                 4119
>>>>>          hw_ver:                         0x0
>>>>>          board_id:                       HUA0000000004
>>>>>          phys_port_cnt:                  1
>>>>>                  port:   1
>>>>>                          state:                  PORT_ACTIVE (4)
>>>>>                          max_mtu:                4096 (5)
>>>>>                          active_mtu:             1024 (3)
>>>>>                          sm_lid:                 0
>>>>>                          port_lid:               0
>>>>>                          port_lmc:               0x00
>>>>>                          link_layer:             Ethernet
>>>>>
>>>>> The current Linux mainline driver is the same.
>>>>>
>>>>> I found the comment ("If bonded, we do not add an IB device for PF1.")
>>>>> in the mlx5_lag_intf_add function of the 5.10 branch driver code.
>>>>
>>>> Not sure if rdma lag is enabled for this or not. /proc/net/bonding 
>>>> will provide more more details normally.
>>>>
>>>> Zhu Yanjun
>>>>
>>>>> This indicates that wthe the same NIC is used, only PF0 support 
>>>>> bonding?
>>>>> Are there any other constraints, when enable bonding with CX5?
>>>>>
>>>>> Thank you
>>>>> Zhengchao Shao
>>>>


