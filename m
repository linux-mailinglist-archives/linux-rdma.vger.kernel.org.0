Return-Path: <linux-rdma+bounces-194-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A478802A5C
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 03:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8EBA1F20FBC
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 02:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12B9A21;
	Mon,  4 Dec 2023 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="cGCIPOh9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98558C3;
	Sun,  3 Dec 2023 18:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=5vUcNk5ue3sk+3mKADerTcmAghwekiSZ+hMj+HfWZ60=;
	b=cGCIPOh9pBxoLykXW8kAFjTzsHMa9ftAQR3EaaIIHu0mT3dfOclIhiHElqgPnA
	lalPzq5bYLXKYyq7tRZOx1QpKfjSg1+W8H1setooKv95j7Bnu5zwgMJ23Kd/MrMD
	5+9N1n4M/KjqEOmY7NJB/gmKxC5nbsDrxRpQP6i0D4Dns=
Received: from [172.23.69.7] (unknown [121.32.254.149])
	by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wCXq9a2OW1lFtWmDQ--.17161S2;
	Mon, 04 Dec 2023 10:30:15 +0800 (CST)
Message-ID: <35e833bf-8aa6-48bd-999c-6b4c9a4fe7f0@126.com>
Date: Mon, 4 Dec 2023 10:30:14 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5e: Fix slab-out-of-bounds in
 mlx5_query_nic_vport_mac_list()
To: Simon Horman <horms@kernel.org>, Shifeng Li <lishifeng@sangfor.com.cn>
Cc: saeedm@nvidia.com, leon@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ogerlitz@mellanox.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, dinghui@sangfor.com.cn
References: <20231130094656.894412-1-lishifeng@sangfor.com.cn>
 <20231203175015.GP50400@kernel.org>
From: Shifeng Li <lishifeng1992@126.com>
In-Reply-To: <20231203175015.GP50400@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCXq9a2OW1lFtWmDQ--.17161S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar4ftw4rWw4UXr1UXFW8WFg_yoW8KFW3pF
	WaywnrZrykJFZ8ZFWUZ3Z5uF10kr4Uu3W7ua90qw13Aayvgrnrta4UAF1jka9rZFWUKrWv
	ya42vFnIvws8Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UWMKtUUUUU=
X-CM-SenderInfo: xolvxx5ihqwiqzzsqiyswou0bp/1tbiFx08r1pEIGvk+AAAsQ

On 2023/12/4 1:50, Simon Horman wrote:
> On Thu, Nov 30, 2023 at 01:46:56AM -0800, Shifeng Li wrote:
>> Out_sz that the size of out buffer is calculated using query_nic_vport
>> _context_in structure when driver query the MAC list. However query_nic
>> _vport_context_in structure is smaller than query_nic_vport_context_out.
>> When allowed_list_size is greater than 96, calling ether_addr_copy() will
>> trigger an slab-out-of-bounds.
>>
>> [ 1170.055866] BUG: KASAN: slab-out-of-bounds in mlx5_query_nic_vport_mac_list+0x481/0x4d0 [mlx5_core]
>> [ 1170.055869] Read of size 4 at addr ffff88bdbc57d912 by task kworker/u128:1/461
>> [ 1170.055870]
>> [ 1170.055932] Workqueue: mlx5_esw_wq esw_vport_change_handler [mlx5_core]
>> [ 1170.055936] Call Trace:
>> [ 1170.055949]  dump_stack+0x8b/0xbb
>> [ 1170.055958]  print_address_description+0x6a/0x270
>> [ 1170.055961]  kasan_report+0x179/0x2c0
>> [ 1170.056061]  mlx5_query_nic_vport_mac_list+0x481/0x4d0 [mlx5_core]
>> [ 1170.056162]  esw_update_vport_addr_list+0x2c5/0xcd0 [mlx5_core]
>> [ 1170.056257]  esw_vport_change_handle_locked+0xd08/0x1a20 [mlx5_core]
>> [ 1170.056377]  esw_vport_change_handler+0x6b/0x90 [mlx5_core]
>> [ 1170.056381]  process_one_work+0x65f/0x12d0
>> [ 1170.056383]  worker_thread+0x87/0xb50
>> [ 1170.056390]  kthread+0x2e9/0x3a0
>> [ 1170.056394]  ret_from_fork+0x1f/0x40
>>
>> Fixes: e16aea2744ab ("net/mlx5: Introduce access functions to modify/query vport mac lists")
>> Cc: Ding Hui <dinghui@sangfor.com.cn>
>> Signed-off-by: Shifeng Li <lishifeng@sangfor.com.cn>
> 
> Hi,
> 
> I am unsure how you calculated the 96 figure above.
> But in any case I agree that the cited patch introduced
> the mismatch that you describe.
> 
out_sz = MLX5_ST_SZ_BYTES(query_nic_vport_context_in) + req_list_size * MLX5_ST_SZ_BYTES(mac_address_layout)
        = 0x80/8 + 128 * 0x40/8 = 0x410 (bytes)

nic_vport_ctx = MLX5_ADDR_OF(query_nic_vport_context_out, out, nic_vport_context)
               = 0x880/8 = 0x110 (bytes)
mac_addr = MLX5_ADDR_OF(nic_vport_context, nic_vport_ctx, current_uc_mac_address[96]) + 2
          = 0x110 + 96 * 8 + 2
          = 0x412 (bytes)

When i is 96,  the mac_addr offset is 0x412 but the out_sz is 0x410.
And that will trigger an slab-out-of-bounds.

Thanks.

> Reviewed-by: Simon Horman <horms@kernel.org>


