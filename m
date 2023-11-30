Return-Path: <linux-rdma+bounces-157-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DCE7FE79C
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Nov 2023 04:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3584CB2112E
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Nov 2023 03:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB82125C3;
	Thu, 30 Nov 2023 03:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="kKkUpaRc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EA37C4;
	Wed, 29 Nov 2023 19:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=fpc8g0lA/UAskNB5LDyII3L0XJyWCtne1XEN1G8Bsqo=;
	b=kKkUpaRcwCpyW69JN2drALmh3HxkHXtTo+p3opjL6qHu+B/zjmHCsGR9gCG0vT
	wrm2gFv+RJKc3NQ0Kd3HQVRXZAycPBQsuFh+DPAXVl2boOmLjoaq995xX2e7wTz1
	gcS69XR5B635kEp3tXm/y0cbjE7MjDDns+0g36EYQwEJE=
Received: from [172.23.69.7] (unknown [121.32.254.146])
	by zwqz-smtp-mta-g3-0 (Coremail) with SMTP id _____wCHzzgT_WdlKyv3DA--.60934S2;
	Thu, 30 Nov 2023 11:10:12 +0800 (CST)
Message-ID: <6da55a6b-7852-4832-9541-3f3c45a09a3a@126.com>
Date: Thu, 30 Nov 2023 11:10:08 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5e: Fix a race in command alloc flow
To: Moshe Shemesh <moshe@nvidia.com>, saeedm@nvidia.com, leon@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jackm@dev.mellanox.co.il, ogerlitz@mellanox.com,
 roland@purestorage.com, eli@mellanox.com
Cc: dinghui@sangfor.com.cn, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231121115251.588436-1-lishifeng1992@126.com>
 <ce982860-4cc8-cfee-bf73-00f5183c23a3@nvidia.com>
From: Shifeng Li <lishifeng1992@126.com>
In-Reply-To: <ce982860-4cc8-cfee-bf73-00f5183c23a3@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHzzgT_WdlKyv3DA--.60934S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr1ruF45Kr43CF48Cw4xCrg_yoW5ZFy8pr
	W8Gw17AFn5Krsxtrn7WF4jq3W8Jrs7Gw1UGF1v9r1xWwn8Aa4kA34Ikr4jg34UX3yjqFyU
	JayqqFy8Xr4fX3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jog4fUUUUU=
X-CM-SenderInfo: xolvxx5ihqwiqzzsqiyswou0bp/1S2mtgE4r1pD4XyoMgABs-

On 2023/11/27 0:13, Moshe Shemesh wrote:
> 
> 
> On 11/21/2023 1:52 PM, Shifeng Li wrote:
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
>> [70013.081989] CPU: 26 PID: 1433361 Comm: kworker/26:1 Kdump: loaded Tainted: G           OE     4.19.90-25.17.v2101.osc.sfc.6.10.0.0030.ky10.x86_64+debug #1
>> [70013.082001] Hardware name: SANGFOR 65N32-US/ASERVER-G-2605, BIOS SSSS5203 08/19/2020
>> [70013.082028] Workqueue: events aer_isr
>> [70013.082053] Call Trace:
>> [70013.082067]  dump_stack+0x8b/0xbb
>> [70013.082086]  print_address_description+0x6a/0x270
>> [70013.082102]  kasan_report+0x179/0x2c0
>> [70013.082133]  ? mlx5_cmd_trigger_completions+0x1e2/0x4c0 [mlx5_core]
>> [70013.082173]  mlx5_cmd_trigger_completions+0x1e2/0x4c0 [mlx5_core]
>> [70013.082213]  ? mlx5_cmd_use_polling+0x20/0x20 [mlx5_core]
>> [70013.082223]  ? kmem_cache_free+0x1ad/0x1e0
>> [70013.082267]  mlx5_cmd_flush+0x80/0x180 [mlx5_core]
>> [70013.082304]  mlx5_enter_error_state+0x106/0x1d0 [mlx5_core]
>> [70013.082338]  mlx5_try_fast_unload+0x2ea/0x4d0 [mlx5_core]
>> [70013.082377]  remove_one+0x200/0x2b0 [mlx5_core]
>> [70013.082390]  ? __pm_runtime_resume+0x58/0x70
>> [70013.082409]  pci_device_remove+0xf3/0x280
>> [70013.082426]  ? pcibios_free_irq+0x10/0x10
>> [70013.082439]  device_release_driver_internal+0x1c3/0x470
>> [70013.082453]  pci_stop_bus_device+0x109/0x160
>> [70013.082468]  pci_stop_and_remove_bus_device+0xe/0x20
>> [70013.082485]  pcie_do_fatal_recovery+0x167/0x550
>> [70013.082493]  aer_isr+0x7d2/0x960
>> [70013.082510]  ? aer_get_device_error_info+0x420/0x420
>> [70013.082526]  ? __schedule+0x821/0x2040
>> [70013.082536]  ? strscpy+0x85/0x180
>> [70013.082543]  process_one_work+0x65f/0x12d0
>> [70013.082556]  worker_thread+0x87/0xb50
>> [70013.082563]  ? __kthread_parkme+0x82/0xf0
>> [70013.082569]  ? process_one_work+0x12d0/0x12d0
>> [70013.082571]  kthread+0x2e9/0x3a0
>> [70013.082579]  ? kthread_create_worker_on_cpu+0xc0/0xc0
>> [70013.082592]  ret_from_fork+0x1f/0x40
>>
>> Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
>> Signed-off-by: Shifeng Li<lishifeng1992@126.com>
> 
> Fixes tag should be :
> Fixes: 50b2412b7e78 ("net/mlx5: Avoid possible free of command entry while timeout comp handler")
> 
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> 
I have sent v3.

Thanks!

> Thanks!


