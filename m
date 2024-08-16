Return-Path: <linux-rdma+bounces-4385-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F736954122
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 07:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65A2282B02
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 05:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9FC7D08F;
	Fri, 16 Aug 2024 05:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UDNXRt5X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAB77DA90
	for <linux-rdma@vger.kernel.org>; Fri, 16 Aug 2024 05:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723786061; cv=none; b=oE26Soukc8M8gPl5k1GG3tpPW/lsjilion7NQ5DYyHopGleNiWlv5k1LynbxcUoxJtg3s9NJOKdRw4yonAdRtMOJEgu6WjmAROTEHTECeoXfYEBgjed6HhAi8I6VK+K7UJS6TvExvZ9HZEhnlMVy1BqIpZ+BVEBhY0YBXOGkmPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723786061; c=relaxed/simple;
	bh=aTzQxHcq17xaLPsNM9+5kXko1CrQIC6Ft4OukYHadrA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kWRgRqw6uAiKsvOdUzRYc5WCIkjqNEoTsh/4RZSjo9VBmmKQVW3dnCFiIcG4mNdFM/y3Nq2IL2LKqYTxv7o2h3hZwtqAXjsk9zwrJ5t9MqvW2dCF33dktYli3rr7AnU3Iq3RT+DA++9tmbIsIQQJU+O85DpRY6GVHzepF7+SN74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UDNXRt5X; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4254277c-2037-44bc-9756-c32b41c01bdf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723786056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gTtWjkvrzP07/15t/7VwvkJr9zd2YYKh4iTWos35Vk=;
	b=UDNXRt5XjUDx4p6ubiZXDZTI8CQVL08GzM9olKRD6dRLNCMMRu4tHq/CGtswddPN7Y3k/G
	1WhXNVBs7IPh5BxCeAtsVp8/+5QimPy3XGP8Bzq0o5bD/Zgx9s8YgbThAeT99NH8l5K6J/
	I51DRq9JMgxfGg4XkDFY5P43TcbXnfY=
Date: Fri, 16 Aug 2024 13:27:26 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [linus:master] [RDMA/iwcm] aee2424246:
 WARNING:at_kernel/workqueue.c:#check_flush_dependency
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: kernel test robot <oliver.sang@intel.com>,
 Bart Van Assche <bvanassche@acm.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-rdma@vger.kernel.org
References: <202408151633.fc01893c-oliver.sang@intel.com>
 <c64a2f6e-ea18-4e8d-b808-0f1732c6d004@linux.dev>
In-Reply-To: <c64a2f6e-ea18-4e8d-b808-0f1732c6d004@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/8/16 12:14, Zhu Yanjun 写道:
>
> 在 2024/8/16 9:07, kernel test robot 写道:
>>
>> Hello,
>>
>> kernel test robot noticed 
>> "WARNING:at_kernel/workqueue.c:#check_flush_dependency" on:
>>
>> commit: aee2424246f9f1dadc33faa78990c1e2eb7826e4 ("RDMA/iwcm: Fix a 
>> use-after-free related to destroying CM IDs")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> [test failed on linus/master 5189dafa4cf950e675f02ee04b577dfbbad0d9b1]
>> [test failed on linux-next/master 
>> 61c01d2e181adfba02fe09764f9fca1de2be0dbe]
>>
>> in testcase: blktests
>> version: blktests-x86_64-775a058-1_20240702
>> with following parameters:
>>
>>     disk: 1SSD
>>     test: nvme-group-01
>>     nvme_trtype: rdma
>
> Hi, Bart && Jason && Leon
>
> It seems that it is related with WQ_MEM_RECLAIM.
>
> Not sure if adding WQ_MEM_RECLAIM to iw_cm_wq can fix this or not.

The commit is as below.

diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index 1a6339f3a63f..7e3a55349e10 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -1182,7 +1182,7 @@ static int __init iw_cm_init(void)
         if (ret)
                 return ret;

-       iwcm_wq = alloc_ordered_workqueue("iw_cm_wq", 0);
+       iwcm_wq = alloc_ordered_workqueue("iw_cm_wq", WQ_MEM_RECLAIM);
         if (!iwcm_wq)
                 goto err_alloc;

Zhu Yanjun

>
> Best Regards,
>
> Zhu Yanjun
>
>>
>>
>>
>> compiler: gcc-12
>> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ 
>> (Sapphire Rapids) with 256G memory
>>
>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>
>>
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new 
>> version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>> | Closes: 
>> https://lore.kernel.org/oe-lkp/202408151633.fc01893c-oliver.sang@intel.com
>>
>>
>> [  125.048981][ T1430] ------------[ cut here ]------------
>> [  125.056856][ T1430] workqueue: WQ_MEM_RECLAIM 
>> nvme-reset-wq:nvme_rdma_reset_ctrl_work [nvme_rdma] is flushing 
>> !WQ_MEM_RECLAIM iw_cm_wq:0x0
>> [ 125.056873][ T1430] WARNING: CPU: 2 PID: 1430 at 
>> kernel/workqueue.c:3706 check_flush_dependency 
>> (kernel/workqueue.c:3706 (discriminator 9))
>> [  125.085014][ T1430] Modules linked in: siw ib_uverbs nvmet_rdma 
>> nvmet nvme_rdma nvme_fabrics rdma_cm iw_cm ib_cm ib_core dimlib 
>> dm_multipath btrfs blake2b_generic intel_rapl_msr xor 
>> intel_rapl_common zstd_compress intel_uncore_frequency 
>> intel_uncore_frequency_common raid6_pq libcrc32c x86_pkg_temp_thermal 
>> intel_powerclamp coretemp nvme nvme_core ast t10_pi kvm_intel 
>> qat_4xxx drm_shmem_helper mei_me kvm crct10dif_pclmul crc32_pclmul 
>> crc32c_intel ghash_clmulni_intel sha512_ssse3 rapl intel_cstate 
>> intel_uncore dax_hmem intel_th_gth intel_qat crc64_rocksoft_generic 
>> dh_generic intel_th_pci idxd crc8 i2c_i801 crc64_rocksoft mei 
>> intel_vsec idxd_bus drm_kms_helper intel_th authenc crc64 i2c_smbus 
>> i2c_ismt ipmi_ssif wmi acpi_power_meter ipmi_si acpi_ipmi 
>> ipmi_devintf ipmi_msghandler acpi_pad binfmt_misc loop fuse drm 
>> dm_mod ip_tables [last unloaded: ib_uverbs]
>> [  125.176472][ T1430] CPU: 2 PID: 1430 Comm: kworker/u898:26 Not 
>> tainted 6.10.0-rc1-00015-gaee2424246f9 #1
>> [  125.188840][ T1430] Workqueue: nvme-reset-wq 
>> nvme_rdma_reset_ctrl_work [nvme_rdma]
>> [ 125.199152][ T1430] RIP: 0010:check_flush_dependency 
>> (kernel/workqueue.c:3706 (discriminator 9))
>> [ 125.207527][ T1430] Code: fa 48 c1 ea 03 80 3c 02 00 0f 85 a8 00 00 
>> 00 49 8b 54 24 18 49 8d b5 c0 00 00 00 49 89 e8 48 c7 c7 20 46 08 84 
>> e8 ed 8b f9 ff <0f> 0b e9 93 fd ff ff e8 a1 bf 82 00 e9 80 fd ff ff 
>> e8 97 bf 82 00
>> All code
>> ========
>>     0:    fa                       cli
>>     1:    48 c1 ea 03              shr    $0x3,%rdx
>>     5:    80 3c 02 00              cmpb   $0x0,(%rdx,%rax,1)
>>     9:    0f 85 a8 00 00 00        jne    0xb7
>>     f:    49 8b 54 24 18           mov    0x18(%r12),%rdx
>>    14:    49 8d b5 c0 00 00 00     lea    0xc0(%r13),%rsi
>>    1b:    49 89 e8                 mov    %rbp,%r8
>>    1e:    48 c7 c7 20 46 08 84     mov $0xffffffff84084620,%rdi
>>    25:    e8 ed 8b f9 ff           callq  0xfffffffffff98c17
>>    2a:*    0f 0b                    ud2            <-- trapping 
>> instruction
>>    2c:    e9 93 fd ff ff           jmpq   0xfffffffffffffdc4
>>    31:    e8 a1 bf 82 00           callq  0x82bfd7
>>    36:    e9 80 fd ff ff           jmpq   0xfffffffffffffdbb
>>    3b:    e8 97 bf 82 00           callq  0x82bfd7
>>
>> Code starting with the faulting instruction
>> ===========================================
>>     0:    0f 0b                    ud2
>>     2:    e9 93 fd ff ff           jmpq   0xfffffffffffffd9a
>>     7:    e8 a1 bf 82 00           callq  0x82bfad
>>     c:    e9 80 fd ff ff           jmpq   0xfffffffffffffd91
>>    11:    e8 97 bf 82 00           callq  0x82bfad
>> [  125.231266][ T1430] RSP: 0018:ffa000001375fb88 EFLAGS: 00010282
>> [  125.239626][ T1430] RAX: 0000000000000000 RBX: ff11000341233c00 
>> RCX: 0000000000000027
>> [  125.250304][ T1430] RDX: 0000000000000027 RSI: 0000000000000004 
>> RDI: ff110017fc930b08
>> [  125.260878][ T1430] RBP: 0000000000000000 R08: 0000000000000001 
>> R09: ffe21c02ff926161
>> [  125.271664][ T1430] R10: ff110017fc930b0b R11: 0000000000000010 
>> R12: ff1100208d2a4000
>> [  125.282387][ T1430] R13: ff1100020d87a000 R14: 0000000000000000 
>> R15: ff11000341233c00
>> [  125.292984][ T1430] FS:  0000000000000000(0000) 
>> GS:ff110017fc900000(0000) knlGS:0000000000000000
>> [  125.304552][ T1430] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  125.313446][ T1430] CR2: 00007fa84066aa1c CR3: 000000407c85a005 
>> CR4: 0000000000f71ef0
>> [  125.324080][ T1430] DR0: 0000000000000000 DR1: 0000000000000000 
>> DR2: 0000000000000000
>> [  125.334584][ T1430] DR3: 0000000000000000 DR6: 00000000fffe07f0 
>> DR7: 0000000000000400
>> [  125.345252][ T1430] PKRU: 55555554
>> [  125.350876][ T1430] Call Trace:
>> [  125.356281][ T1430]  <TASK>
>> [ 125.361285][ T1430] ? __warn (kernel/panic.c:693)
>> [ 125.367640][ T1430] ? check_flush_dependency 
>> (kernel/workqueue.c:3706 (discriminator 9))
>> [ 125.375689][ T1430] ? report_bug (lib/bug.c:180 lib/bug.c:219)
>> [ 125.382505][ T1430] ? handle_bug (arch/x86/kernel/traps.c:239)
>> [ 125.388987][ T1430] ? exc_invalid_op (arch/x86/kernel/traps.c:260 
>> (discriminator 1))
>> [ 125.395831][ T1430] ? asm_exc_invalid_op 
>> (arch/x86/include/asm/idtentry.h:621)
>> [ 125.403125][ T1430] ? check_flush_dependency 
>> (kernel/workqueue.c:3706 (discriminator 9))
>> [ 125.410984][ T1430] ? check_flush_dependency 
>> (kernel/workqueue.c:3706 (discriminator 9))
>> [ 125.418764][ T1430] __flush_workqueue (kernel/workqueue.c:3970)
>> [ 125.426021][ T1430] ? __pfx___might_resched 
>> (kernel/sched/core.c:10151)
>> [ 125.433431][ T1430] ? destroy_cm_id 
>> (drivers/infiniband/core/iwcm.c:375) iw_cm
>> [  125.440844][ T2411] /usr/bin/wget -q --timeout=3600 --tries=1 
>> --local-encoding=UTF-8 
>> http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-spr-2sp1/blktests-1SSD-rdma-nvme-group-01-debian-12-x86_64-20240206.cgz-aee2424246f9-20240809-69442-1dktaed-4.yaml&job_state=running 
>> -O /dev/null
>> [ 125.441209][ T1430] ? __pfx___flush_workqueue 
>> (kernel/workqueue.c:3910)
>> [  125.441215][ T2411]
>> [ 125.473900][ T1430] ? _raw_spin_lock_irqsave 
>> (arch/x86/include/asm/atomic.h:107 
>> include/linux/atomic/atomic-arch-fallback.h:2170 
>> include/linux/atomic/atomic-instrumented.h:1302 
>> include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 
>> include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
>> [ 125.473909][ T1430] ? __pfx__raw_spin_lock_irqsave 
>> (kernel/locking/spinlock.c:161)
>> [  125.480265][ T2411] target ucode: 0x2b0004b1
>> [ 125.482537][ T1430] _destroy_id 
>> (drivers/infiniband/core/cma.c:2044) rdma_cm
>> [  125.488511][ T2411]
>> [ 125.495072][ T1430] nvme_rdma_free_queue 
>> (drivers/nvme/host/rdma.c:656 drivers/nvme/host/rdma.c:650) nvme_rdma
>> [  125.500747][ T2411] LKP: stdout: 2876: current_version: 2b0004b1, 
>> target_version: 2b0004b1
>> [ 125.505827][ T1430] nvme_rdma_reset_ctrl_work 
>> (drivers/nvme/host/rdma.c:2180) nvme_rdma
>> [ 125.505831][ T1430] process_one_work (kernel/workqueue.c:3231)
>> [  125.508377][ T2411]
>> [ 125.515122][ T1430] worker_thread (kernel/workqueue.c:3306 
>> kernel/workqueue.c:3393)
>> [ 125.515127][ T1430] ? __pfx_worker_thread (kernel/workqueue.c:3339)
>> [  125.524642][ T2411] check_nr_cpu
>> [ 125.531837][ T1430] kthread (kernel/kthread.c:389)
>> [  125.537327][ T2411]
>> [ 125.539864][ T1430] ? __pfx_kthread (kernel/kthread.c:342)
>> [  125.545392][ T2411] CPU(s):                               224
>> [ 125.550628][ T1430] ret_from_fork (arch/x86/kernel/process.c:147)
>> [  125.554342][ T2411]
>> [ 125.558840][ T1430] ? __pfx_kthread (kernel/kthread.c:342)
>> [ 125.558844][ T1430] ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
>> [  125.561843][ T2411] On-line CPU(s) list: 0-223
>> [  125.566487][ T1430]  </TASK>
>> [  125.566488][ T1430] ---[ end trace 0000000000000000 ]---
>>
>>
>>
>> The kernel config and materials to reproduce are available at:
>> https://download.01.org/0day-ci/archive/20240815/202408151633.fc01893c-oliver.sang@intel.com 
>>
>>
>>
>>
-- 
Best Regards,
Yanjun.Zhu


