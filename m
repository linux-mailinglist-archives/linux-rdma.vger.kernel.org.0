Return-Path: <linux-rdma+bounces-2285-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 350E48BC697
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 06:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D9A1F21A89
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 04:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F7743AD2;
	Mon,  6 May 2024 04:47:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7236040847;
	Mon,  6 May 2024 04:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714970822; cv=none; b=qsk6jbYYIUbh8FNZZwj4FIvYyKq426NboWxvkSzP8BXiN1sOqaZW7/fMxtQCz3zpWJr60AwPS++tfMGuezSl2UU8NAKVFMybmt20L1f0Zdofp8/C99Fho1tnUNxlkegpjbqo1aH20CxAUXEP0WB0MUWyCG3NZt6+HpM3zewueAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714970822; c=relaxed/simple;
	bh=kLBnOvFUScc5yrKFJ5GJ2Ejq9jY1L4LRL9T/ehTsn8A=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:CC:Content-Type; b=h/CLeEAIkmQYnHKS6tbtZj4hvQg9rB0Ot8JSBT6VXlIiU04ScjRFOA6Yfs/UjPeSidFhjIfAlyICD7ggTe0LLhm1d74lrF+RCcpvMjrudLGbqUt5xSBTC1JVk9/wkB0Rs95lOyIwlOMPdkVQ1xMMciYpIlIdA/LrTFX3U+pmIQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VXpgd1Z9szcpCX;
	Mon,  6 May 2024 12:43:09 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 851011400FD;
	Mon,  6 May 2024 12:46:56 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 12:46:55 +0800
Message-ID: <756aaf3c-5a15-8d18-89d4-ea7380cf845d@huawei.com>
Date: Mon, 6 May 2024 12:46:55 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
From: shaozhengchao <shaozhengchao@huawei.com>
To: <saeedm@nvidia.com>, <tariqt@nvidia.com>, <borisp@nvidia.com>,
	<shayd@nvidia.com>, <msanalla@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, <weizhang@nvidia.com>, <kliteyn@nvidia.com>,
	<erezsh@nvidia.com>, <igozlan@nvidia.com>
Subject: [question] when bonding with CX5 network card that support ROCE
CC: netdev <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)


When using the 5.10 kernel, I can find two IB devices using the 
ibv_devinfo command.
----------------------------------
[root@localhost ~]# lspci
91:00.0 Ethernet controller: Mellanox Technologies MT27800 Family 
[ConnectX-5]
91:00.1 Ethernet controller: Mellanox Technologies MT27800 Family
----------------------------------
[root@localhost ~]# ibv_devinfo
hca_id: mlx5_0
         transport:                      InfiniBand (0)
         fw_ver:                         16.31.1014
         node_guid:                      f41d:6b03:006f:4743
         sys_image_guid:                 f41d:6b03:006f:4743
         vendor_id:                      0x02c9
         vendor_part_id:                 4119
         hw_ver:                         0x0
         board_id:                       HUA0000000004
         phys_port_cnt:                  1
                 port:   1
                         state:                  PORT_ACTIVE (4)
                         max_mtu:                4096 (5)
                         active_mtu:             1024 (3)
                         sm_lid:                 0
                         port_lid:               0
                         port_lmc:               0x00
                         link_layer:             Ethernet

hca_id: mlx5_1
         transport:                      InfiniBand (0)
         fw_ver:                         16.31.1014
         node_guid:                      f41d:6b03:006f:4744
         sys_image_guid:                 f41d:6b03:006f:4743
         vendor_id:                      0x02c9
         vendor_part_id:                 4119
         hw_ver:                         0x0
         board_id:                       HUA0000000004
         phys_port_cnt:                  1
                 port:   1
                         state:                  PORT_ACTIVE (4)
                         max_mtu:                4096 (5)
                         active_mtu:             1024 (3)
                         sm_lid:                 0
                         port_lid:               0
                         port_lmc:               0x00
                         link_layer:             Ethernet
----------------------------------
But after the two network ports are bonded, only one IB device is
available, and only PF0 can be used.
[root@localhost shaozhengchao]# ibv_devinfo
hca_id: mlx5_bond_0
         transport:                      InfiniBand (0)
         fw_ver:                         16.31.1014
         node_guid:                      f41d:6b03:006f:4743
         sys_image_guid:                 f41d:6b03:006f:4743
         vendor_id:                      0x02c9
         vendor_part_id:                 4119
         hw_ver:                         0x0
         board_id:                       HUA0000000004
         phys_port_cnt:                  1
                 port:   1
                         state:                  PORT_ACTIVE (4)
                         max_mtu:                4096 (5)
                         active_mtu:             1024 (3)
                         sm_lid:                 0
                         port_lid:               0
                         port_lmc:               0x00
                         link_layer:             Ethernet

The current Linux mainline driver is the same.

I found the comment ("If bonded, we do not add an IB device for PF1.")
in the mlx5_lag_intf_add function of the 5.10 branch driver code.
This indicates that wthe the same NIC is used, only PF0 support bonding?
Are there any other constraints, when enable bonding with CX5?

Thank you
Zhengchao Shao

