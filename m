Return-Path: <linux-rdma+bounces-2294-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BF58BCCE2
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 13:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126F71C2138D
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 11:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80A6143868;
	Mon,  6 May 2024 11:33:26 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFFD143745;
	Mon,  6 May 2024 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714995206; cv=none; b=BlmI2qWpZwu+/GYr+3wiR+mbMJHBB5jV9kY0dbeqkFqb3kq0JoMlWIWOdNHYmezZeSYMjqi3Qlttt5YwVMsC/lAG3Z/rdCcS6clGszLsMZ37w9+kliD/Jl4cZw2iVLTm64lat2izmKWT2hSRjKHYtudE+aEMD/DP+IiGpUCz8Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714995206; c=relaxed/simple;
	bh=Zb955aQvZD3I1Z0tkUp0Sjg98hLqr2WajKweb88oNbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p9DYgA9qNTJl95114K/v2RSqBNrqmGq5nOzGPkbsXvhax9tP+GBIaoHxwfWs4sPn8fo6SJqibeR+4aAKSZ2/nliJBrCusq2BGffaTPsq5wq5vGMeYhjKhPECxH+Vt4g2fNNVWgHPL9wb160ZJFPLTHpf37YxVe54uRBMKQlFXkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VXzj265QPzvRNT;
	Mon,  6 May 2024 19:29:58 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 4267C1400D1;
	Mon,  6 May 2024 19:33:01 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 19:33:00 +0800
Message-ID: <d345b292-e5a1-a428-f5e1-74a6c0c390d9@huawei.com>
Date: Mon, 6 May 2024 19:33:00 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [question] when bonding with CX5 network card that support ROCE
To: Zhu Yanjun <zyjzyj2000@gmail.com>, <saeedm@nvidia.com>,
	<tariqt@nvidia.com>, <borisp@nvidia.com>, <shayd@nvidia.com>,
	<msanalla@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	<weizhang@nvidia.com>, <kliteyn@nvidia.com>, <erezsh@nvidia.com>,
	<igozlan@nvidia.com>
CC: netdev <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
References: <756aaf3c-5a15-8d18-89d4-ea7380cf845d@huawei.com>
 <7b0e61e1-8d50-4431-bd0a-6398c618a609@linux.dev>
 <bb68fc32-9c6c-ceda-a961-f4fde72ce64d@huawei.com>
 <6a285586-0a11-43be-a07a-5ba0b92d0ee6@gmail.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <6a285586-0a11-43be-a07a-5ba0b92d0ee6@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)


Hi Yanjun:
   Thank you for your reply. Are there any other restrictions on using
ROCE on the CX5?

Zhengchao Shao

On 2024/5/6 18:58, Zhu Yanjun wrote:
> 
> On 06.05.24 12:45, shaozhengchao wrote:
>> Hi yanjun:
>>   The following is the command output after the cat /proc/net/bonding
>> /bond0 command is run:
> 
> If I remember it correctly, it seems that it is a rdma LAG and bonding 
> problem.
> 
> Not sure if it is a known problem or not. Please contact your local 
> support.
> 
> Zhu Yanjun
> 
>> [root@localhost ~]# cat /proc/net/bonding/bond0
>> Ethernet Channel Bonding Driver: v5.10.0+
>>
>> Bonding Mode: IEEE 802.3ad Dynamic link aggregation
>> Transmit Hash Policy: layer2 (0)
>> MII Status: up
>> MII Polling Interval (ms): 100
>> Up Delay (ms): 0
>> Down Delay (ms): 0
>> Peer Notification Delay (ms): 0
>>
>> 802.3ad info
>> LACP rate: slow
>> Min links: 0
>> Aggregator selection policy (ad_select): stable
>> System priority: 65535
>> System MAC address: f4:1d:6b:6f:3b:97
>> Active Aggregator Info:
>>         Aggregator ID: 2
>>         Number of ports: 1
>>         Actor Key: 23
>>         Partner Key: 1
>>         Partner Mac Address: 00:00:00:00:00:00
>>
>> Slave Interface: enp145s0f0
>> MII Status: up
>> Speed: 40000 Mbps
>> Duplex: full
>> Link Failure Count: 1
>> Permanent HW addr: f4:1d:6b:6f:3b:97
>> Slave queue ID: 0
>> Aggregator ID: 1
>> Actor Churn State: churned
>> Partner Churn State: churned
>> Actor Churned Count: 1
>> Partner Churned Count: 2
>> details actor lacp pdu:
>>     system priority: 65535
>>     system mac address: f4:1d:6b:6f:3b:97
>>     port key: 23
>>     port priority: 255
>>     port number: 1
>>     port state: 69
>> details partner lacp pdu:
>>     system priority: 65535
>>     system mac address: 00:00:00:00:00:00
>>     oper key: 1
>>     port priority: 255
>>     port number: 1
>>     port state: 1
>>
>> Slave Interface: enp145s0f1
>> MII Status: up
>> Speed: 40000 Mbps
>> Duplex: full
>> Link Failure Count: 0
>> Permanent HW addr: f4:1d:6b:6f:3b:98
>> Slave queue ID: 0
>> Aggregator ID: 2
>> Actor Churn State: none
>> Partner Churn State: churned
>> Actor Churned Count: 0
>> Partner Churned Count: 1
>> details actor lacp pdu:
>>     system priority: 65535
>>     system mac address: f4:1d:6b:6f:3b:97
>>     port key: 23
>>     port priority: 255
>>     port number: 2
>>     port state: 77
>> details partner lacp pdu:
>>     system priority: 65535
>>     system mac address: 00:00:00:00:00:00
>>     oper key: 1
>>     port priority: 255
>>     port number: 1
>>     port state: 1
>>
>> Thank you
>> Zhengchao Shao
>>
>>
>> On 2024/5/6 16:26, Zhu Yanjun wrote:
>>> On 06.05.24 06:46, shaozhengchao wrote:
>>>>
>>>> When using the 5.10 kernel, I can find two IB devices using the 
>>>> ibv_devinfo command.
>>>> ----------------------------------
>>>> [root@localhost ~]# lspci
>>>> 91:00.0 Ethernet controller: Mellanox Technologies MT27800 Family 
>>>> [ConnectX-5]
>>>> 91:00.1 Ethernet controller: Mellanox Technologies MT27800 Family
>>>> ----------------------------------
>>>> [root@localhost ~]# ibv_devinfo
>>>> hca_id: mlx5_0
>>>>          transport:                      InfiniBand (0)
>>>>          fw_ver:                         16.31.1014
>>>>          node_guid:                      f41d:6b03:006f:4743
>>>>          sys_image_guid:                 f41d:6b03:006f:4743
>>>>          vendor_id:                      0x02c9
>>>>          vendor_part_id:                 4119
>>>>          hw_ver:                         0x0
>>>>          board_id:                       HUA0000000004
>>>>          phys_port_cnt:                  1
>>>>                  port:   1
>>>>                          state:                  PORT_ACTIVE (4)
>>>>                          max_mtu:                4096 (5)
>>>>                          active_mtu:             1024 (3)
>>>>                          sm_lid:                 0
>>>>                          port_lid:               0
>>>>                          port_lmc:               0x00
>>>>                          link_layer:             Ethernet
>>>>
>>>> hca_id: mlx5_1
>>>>          transport:                      InfiniBand (0)
>>>>          fw_ver:                         16.31.1014
>>>>          node_guid:                      f41d:6b03:006f:4744
>>>>          sys_image_guid:                 f41d:6b03:006f:4743
>>>>          vendor_id:                      0x02c9
>>>>          vendor_part_id:                 4119
>>>>          hw_ver:                         0x0
>>>>          board_id:                       HUA0000000004
>>>>          phys_port_cnt:                  1
>>>>                  port:   1
>>>>                          state:                  PORT_ACTIVE (4)
>>>>                          max_mtu:                4096 (5)
>>>>                          active_mtu:             1024 (3)
>>>>                          sm_lid:                 0
>>>>                          port_lid:               0
>>>>                          port_lmc:               0x00
>>>>                          link_layer:             Ethernet
>>>> ----------------------------------
>>>> But after the two network ports are bonded, only one IB device is
>>>> available, and only PF0 can be used.
>>>> [root@localhost shaozhengchao]# ibv_devinfo
>>>> hca_id: mlx5_bond_0
>>>>          transport:                      InfiniBand (0)
>>>>          fw_ver:                         16.31.1014
>>>>          node_guid:                      f41d:6b03:006f:4743
>>>>          sys_image_guid:                 f41d:6b03:006f:4743
>>>>          vendor_id:                      0x02c9
>>>>          vendor_part_id:                 4119
>>>>          hw_ver:                         0x0
>>>>          board_id:                       HUA0000000004
>>>>          phys_port_cnt:                  1
>>>>                  port:   1
>>>>                          state:                  PORT_ACTIVE (4)
>>>>                          max_mtu:                4096 (5)
>>>>                          active_mtu:             1024 (3)
>>>>                          sm_lid:                 0
>>>>                          port_lid:               0
>>>>                          port_lmc:               0x00
>>>>                          link_layer:             Ethernet
>>>>
>>>> The current Linux mainline driver is the same.
>>>>
>>>> I found the comment ("If bonded, we do not add an IB device for PF1.")
>>>> in the mlx5_lag_intf_add function of the 5.10 branch driver code.
>>>
>>> Not sure if rdma lag is enabled for this or not. /proc/net/bonding 
>>> will provide more more details normally.
>>>
>>> Zhu Yanjun
>>>
>>>> This indicates that wthe the same NIC is used, only PF0 support 
>>>> bonding?
>>>> Are there any other constraints, when enable bonding with CX5?
>>>>
>>>> Thank you
>>>> Zhengchao Shao
>>>

