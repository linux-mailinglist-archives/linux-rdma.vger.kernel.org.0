Return-Path: <linux-rdma+bounces-51-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF177F5663
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Nov 2023 03:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8430D281684
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Nov 2023 02:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063854423;
	Thu, 23 Nov 2023 02:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="pOZl2CHy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D52B112;
	Wed, 22 Nov 2023 18:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=UlxvLHjBs0+KVhlcvFETRh+wWbRujxcqONaLwY9ZXkY=;
	b=pOZl2CHy15CILlb/xweooyqCmAppWfRvdwQNMDPqEadI6gqKwPiZphD9h5UR6u
	eI88+VXUshcG0fwFS2LtIEMRk3QuVvjpCex3rfvHpKl9lMcuQZJplkkVnrvjs9UA
	TIlSnT0E6/HxLUbqeGfm2TzAUUtnK9wuMP72snhyFeb9M=
Received: from [172.23.69.7] (unknown [121.32.254.149])
	by zwqz-smtp-mta-g3-0 (Coremail) with SMTP id _____wD3XznVtl5lJaXiCw--.59075S2;
	Thu, 23 Nov 2023 10:20:07 +0800 (CST)
Message-ID: <3cfe509b-ca24-47a7-931c-fe620c2dab7c@126.com>
Date: Thu, 23 Nov 2023 10:20:03 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5e: Fix a race in command alloc flow
To: Leon Romanovsky <leon@kernel.org>
Cc: saeedm@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jackm@dev.mellanox.co.il,
 ogerlitz@mellanox.com, roland@purestorage.com, eli@mellanox.com,
 dinghui@sangfor.com.cn, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231121115251.588436-1-lishifeng1992@126.com>
 <20231122120245.GC4760@unreal>
From: Shifeng Li <lishifeng1992@126.com>
In-Reply-To: <20231122120245.GC4760@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3XznVtl5lJaXiCw--.59075S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGryfAF4xGr45WFy8CFW3KFg_yoW5Cw45pr
	yxGw47AFn5Krsxtrn7Xw4jq3W8J397Kw15GF1v9r1xWwsaya4kAa4Ikr4jg34UX3yjqa47
	JayDKFy8Xr4fX3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeD73UUUUU=
X-CM-SenderInfo: xolvxx5ihqwiqzzsqiyswou0bp/1tbi1xgxr153c3k9gwABsN

On 2023/11/22 20:02, Leon Romanovsky wrote:
> On Tue, Nov 21, 2023 at 03:52:51AM -0800, Shifeng Li wrote:
>> Fix a cmd->ent use after free due to a race on command entry.
>> Such race occurs when one of the commands releases its last refcount and
>> frees its index and entry while another process running command flush
>> flow takes refcount to this command entry. The process which handles
>> commands flush may see this command as needed to be flushed if the other
>> process allocated a ent->idx but didn't set ent to cmd->ent_arr in
>> cmd_work_handler(). Fix it by moving the assignment of cmd->ent_arr into
>> the spin lock.
>>
>> [70013.081955] BUG: KASAN: use-after-free in mlx5_cmd_trigger_completions+0x1e2/0x4c0 [mlx5_core]
>> [70013.081967] Write of size 4 at addr ffff88880b1510b4 by task kworker/26:1/1433361
>> [70013.081968]
>> [70013.081989] CPU: 26 PID: 1433361 Comm: kworker/26:1 Kdump: loaded Tainted: G           OE     4.19.90-25.17.v2101.osc.sfc.6.10.0.0030.ky10.x86_64+debug #1
>> [70013.082001] Hardware name: SANGFOR 65N32-US/ASERVER-G-2605, BIOS SSSS5203 08/19/2020
>> [70013.082028] Workqueue: events aer_isr
>> [70013.082053] Call Trace:
>> [70013.082067]  dump_stack+0x8b/0xbb
>> [70013.082086]  print_address_description+0x6a/0x270
>> [70013.082102]  kasan_report+0x179/0x2c0
>> [70013.082133]  ? mlx5_cmd_trigger_completions+0x1e2/0x4c0 [mlx5_core]
>> [70013.082173]  mlx5_cmd_trigger_completions+0x1e2/0x4c0 [mlx5_core]
>> [70013.082213]  ? mlx5_cmd_use_polling+0x20/0x20 [mlx5_core]
>> [70013.082223]  ? kmem_cache_free+0x1ad/0x1e0
>> [70013.082267]  mlx5_cmd_flush+0x80/0x180 [mlx5_core]
>> [70013.082304]  mlx5_enter_error_state+0x106/0x1d0 [mlx5_core]
>> [70013.082338]  mlx5_try_fast_unload+0x2ea/0x4d0 [mlx5_core]
>> [70013.082377]  remove_one+0x200/0x2b0 [mlx5_core]
>> [70013.082390]  ? __pm_runtime_resume+0x58/0x70
>> [70013.082409]  pci_device_remove+0xf3/0x280
>> [70013.082426]  ? pcibios_free_irq+0x10/0x10
>> [70013.082439]  device_release_driver_internal+0x1c3/0x470
>> [70013.082453]  pci_stop_bus_device+0x109/0x160
>> [70013.082468]  pci_stop_and_remove_bus_device+0xe/0x20
>> [70013.082485]  pcie_do_fatal_recovery+0x167/0x550
>> [70013.082493]  aer_isr+0x7d2/0x960
>> [70013.082510]  ? aer_get_device_error_info+0x420/0x420
>> [70013.082526]  ? __schedule+0x821/0x2040
>> [70013.082536]  ? strscpy+0x85/0x180
>> [70013.082543]  process_one_work+0x65f/0x12d0
>> [70013.082556]  worker_thread+0x87/0xb50
>> [70013.082563]  ? __kthread_parkme+0x82/0xf0
>> [70013.082569]  ? process_one_work+0x12d0/0x12d0
>> [70013.082571]  kthread+0x2e9/0x3a0
>> [70013.082579]  ? kthread_create_worker_on_cpu+0xc0/0xc0
>> [70013.082592]  ret_from_fork+0x1f/0x40
> 
> I'm curious how did you get this error? I would expect to see some sort
> of lock in upper level which prevents it.
> 
Just inject AER unrecoverable error to pci BDF device corresponding to 
the network card constantly and I get this error.

Thanks
> Thanks


