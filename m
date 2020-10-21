Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE3F2947F5
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Oct 2020 07:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440655AbgJUFzV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Oct 2020 01:55:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56819 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2440654AbgJUFzV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Oct 2020 01:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603259718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ek5oHDiTFczgYmLK7K56N/a1L/zqMUdH26VmRBR/bSc=;
        b=EZnYprvV4zFeneXp/+jxHyubnA0opJ2K7mB1RykPiXnRdxhj0wp4lvnk8DQ3LbFoHpJ7Ta
        jAAH+pjHZZqCHqp3IHUtAS2/ri0E25zhBXlA9pDCudYynz77NUlI7V3eE9X5hnAKmuuGMX
        mP2QB1IFuEhdC3t6i8xEx86dw5xEZBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-Kh7VaehyPcOmW2OvHqgbYA-1; Wed, 21 Oct 2020 01:55:13 -0400
X-MC-Unique: Kh7VaehyPcOmW2OvHqgbYA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8255A57086;
        Wed, 21 Oct 2020 05:55:12 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-127.pek2.redhat.com [10.72.13.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F8D21002C16;
        Wed, 21 Oct 2020 05:55:09 +0000 (UTC)
Subject: Re: [bug report] rdma_rxe: kernel NULL pointer observed with blktests
 nvme/012 on ppc64le/aarch64
To:     Bob Pearson <rpearsonhpe@gmail.com>, linux-rdma@vger.kernel.org
Cc:     zyjzyj2000@gmail.com, jgg@nvidia.com,
        linux-nvme@lists.infradead.org, sagi@grimberg.me
References: <1650006240.4229491.1603034423590.JavaMail.zimbra@redhat.com>
 <fa25d298-33bc-a110-7074-5f87d7fd418c@gmail.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <1ab3fd1f-5bfe-9778-4abc-b9e6d20357d9@redhat.com>
Date:   Wed, 21 Oct 2020 13:55:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fa25d298-33bc-a110-7074-5f87d7fd418c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 10/20/20 2:54 AM, Bob Pearson wrote:
> On 10/18/20 10:20 AM, Yi Zhang wrote:
>> Hello
>>
>> I found this bug with blktests nvme/012 on ppc64le/aarch64, could anyone help check it,
>> Let me know if you need any test for further investigation, thanks.
>>
>> ppc64le:
>> [  155.427446] run blktests nvme/012 at 2020-10-18 09:54:03
>> [  156.593195] rdma_rxe: loaded
>> [  156.614836] infiniband rxe0: set active
>> [  156.614843] infiniband rxe0: added env2
>> [  156.617421] lo speed is unknown, defaulting to 1000
>> [  156.617449] lo speed is unknown, defaulting to 1000
>> [  156.617484] lo speed is unknown, defaulting to 1000
>> [  156.619911] infiniband rxe1: set active
>> [  156.619916] infiniband rxe1: added lo
>> [  156.619987] lo speed is unknown, defaulting to 1000
>> [  156.640971] Rounding down aligned max_sectors from 4294967295 to 4294967168
>> [  156.641095] db_root: cannot open: /etc/target
>> [  156.655793] lo speed is unknown, defaulting to 1000
>> [  156.700482] loop: module loaded
>> [  156.744820] Loading iSCSI transport class v2.0-870.
>> [  156.805883] iscsi: registered transport (iser)
>> [  156.833559] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>> [  156.884254] nvmet_rdma: enabling port 0 (10.0.2.182:4420)
>> [  157.005564] RPC: Registered rdma transport module.
>> [  157.005573] RPC: Registered rdma backchannel transport module.
>> [  157.121039] nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0c00c1b2-6456-4e5e-a0d4-9677000ca7bc.
>> [  157.121388] nvme nvme0: creating 16 I/O queues.
>> [  157.128894] nvme nvme0: mapped 16/0/0 default/read/poll queues.
>> [  157.130039] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr 10.0.2.182:4420
>> [  158.196673] XFS (nvme0n1): Mounting V5 Filesystem
>> [  158.206313] XFS (nvme0n1): Ending clean mount
>> [  158.207141] xfs filesystem being mounted at /mnt/blktests supports timestamps until 2038 (0x7fffffff)
>> [  190.087119] XFS (nvme0n1): Unmounting Filesystem
>> [  190.087284] BUG: Kernel NULL pointer dereference on read at 0x00000000
>> [  190.087289] Faulting instruction address: 0xc0000000000ae400
>> [  190.087294] Oops: Kernel access of bad area, sig: 11 [#1]
>> [  190.087298] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
>> [  190.087302] Modules linked in: ib_isert iscsi_target_mod rpcrdma ib_iser libiscsi scsi_transport_iscsi loop ib_srpt target_core_mod crc32_generic rdma_rxe ib_srp ib_ipoib rdma_ucm ib_uverbs ip6_udp_tunnel udp_tunnel nvme_rdma nvme_fabrics nvme_core ib_umad nvmet_rdma rdma_cm iw_cm ib_cm ib_core nvmet rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd bonding grace fscache rfkill sunrpc xts pseries_rng uio_pdrv_genirq vmx_crypto uio ip_tables xfs libcrc32c sd_mod t10_pi sg ibmvscsi ibmveth scsi_transport_srp
>> [  190.087335] CPU: 9 PID: 56 Comm: ksoftirqd/9 Not tainted 5.9.0 #1
>> [  190.087339] NIP:  c0000000000ae400 LR: c008000002d1f77c CTR: 0000000000000007
>> [  190.087342] REGS: c00000033b9bf550 TRAP: 0380   Not tainted  (5.9.0)
>> [  190.087345] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 48088280  XER: 20040000
>> [  190.087351] CFAR: c0000000000ae3a8 IRQMASK: 0
>> [  190.087351] GPR00: c008000002d1f77c c00000033b9bf7e0 c000000001842500 c00000033133b086
>> [  190.087351] GPR04: 0000000000000000 00000000000003c0 0000000000000007 0000000000000001
>> [  190.087351] GPR08: c00000033b9bfa70 c00000033133b086 0000000000000000 c008000002d243f0
>> [  190.087351] GPR12: c0000000000b8680 c00000001eca3200 c00000032d2f4000 0000000000000001
>> [  190.087351] GPR16: c00000032d2f4000 0000000000000400 0000000000000000 c008000007c3ba38
>> [  190.087351] GPR20: 0000000000000000 c000000338a06c00 c00000033b9bfa70 c00000033b9bfa70
>> [  190.087351] GPR24: 0000000000000001 c00000033133b086 c000000334083f00 000000005e7d553d
>> [  190.087351] GPR28: 0000000000000000 00000000000003c0 00000000000003c0 0000000000000001
>> [  190.087383] NIP [c0000000000ae400] memcpy_power7+0xa0/0x7e0
>> [  190.087388] LR [c008000002d1f77c] rxe_mem_copy+0x1f4/0x308 [rdma_rxe]
>> [  190.087391] Call Trace:
>> [  190.087394] [c00000033b9bf7e0] [c000000327d83158] 0xc000000327d83158 (unreliable)
>> [  190.087399] [c00000033b9bf8e0] [c008000002d1f77c] rxe_mem_copy+0x1f4/0x308 [rdma_rxe]
>> [  190.087404] [c00000033b9bf970] [c008000002d1fbe4] copy_data+0x11c/0x460 [rdma_rxe]
>> [  190.087409] [c00000033b9bfa00] [c008000002d131ac] rxe_requester+0x1054/0x1368 [rdma_rxe]
>> [  190.087414] [c00000033b9bfb50] [c008000002d21298] rxe_do_task+0x110/0x1d0 [rdma_rxe]
>> [  190.087418] [c00000033b9bfbe0] [c000000000157f40] tasklet_action_common.isra.18+0x1b0/0x1c0
>> [  190.087424] [c00000033b9bfc40] [c000000000d4e8bc] __do_softirq+0x15c/0x3b4
>> [  190.087427] [c00000033b9bfd30] [c0000000001577f4] run_ksoftirqd+0x64/0x90
>> [  190.087432] [c00000033b9bfd50] [c00000000018a794] smpboot_thread_fn+0x204/0x270
>> [  190.087436] [c00000033b9bfdb0] [c000000000184070] kthread+0x1a0/0x1b0
>> [  190.087440] [c00000033b9bfe20] [c00000000000d3d0] ret_from_kernel_thread+0x5c/0x6c
>> [  190.087443] Instruction dump:
>> [  190.087446] f9c10070 f9e10078 fa010080 fa210088 fa410090 fa610098 fa8100a0 faa100a8
>> [  190.087451] fac100b0 f8010110 78a6c9c2 7cc903a6 <e8040000> e8c40008 e8e40010 e9040018
>> [  190.087458] ---[ end trace 244246d4a62eb74b ]---
>> [  190.089228]
>> [  191.089236] Kernel panic - not syncing: Fatal exception
>>
>>
>> # gdb drivers/infiniband/sw/rxe/rdma_rxe.ko
>> Reading symbols from drivers/infiniband/sw/rxe/rdma_rxe.ko...done.
>> (gdb) l *(rxe_mem_copy+0x1f4)
>> 0xf7bc is in rxe_mem_copy (./include/linux/string.h:406).
>> 401			if (q_size < size)
>> 402				__read_overflow2();
>> 403		}
>> 404		if (p_size < size || q_size < size)
>> 405			fortify_panic(__func__);
>> 406		return __underlying_memcpy(p, q, size);
>> 407	}
>> 408	
>> 409	__FORTIFY_INLINE void *memmove(void *p, const void *q, __kernel_size_t size)
>> 410	{
>> (gdb)
>>
>> aarch64:
>> [  691.557907] r[  691.888082] lo speed is unknown, defaulting to 1000
>> [  691.892016] lo speed is unknown, defaulting to 1000
>> [  691.896920] lo speed is unknown, defaulting to 1000
>> [  691.904834] lo speed is unknown, defaulting to 1000
>> [  691.908762] lo speed is unknown, defaulting to 1000
>> [  691.913610] lo speed is unknown, defaulting to 1000
>> [  693.427251] xfs filesystem being mounted at /mnt/blktests supports timestamps until 2038 (0x7fffffff)
>> [  730.178748] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>> [  730.186576] Mem abort info:
>> [  730.189356]   ESR = 0x96000006
>> [  730.192385]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [  730.197680]   SET = 0, FnV = 0
>> [  730.200725]   EA = 0, S1PTW = 0
>> [  730.203843] Data abort info:
>> [  730.206707]   ISV = 0, ISS = 0x00000006
>> [  730.210533]   CM = 0, WnR = 0
>> [  730.213479] user pgtable: 64k pages, 42-bit VAs, pgdp=00000017b7950000
>> [  730.219995] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000, pmd=0000000000000000
>> [  730.230587] Internal error: Oops: 96000006 [#1] SMP
>> [  730.235441] Modules linked in: loop crc32_generic rdma_rxe ip6_udp_tunnel udp_tunnel nvme_rdma nvme_fabrics nvme_core nvmet_rdma nvmet rfkill vfat fat ib_isert iscsi_target_mod rpcrdma ib_srpt target_core_mod sunrpc ib_srp scsi_transport_srp rdma_ucm ib_umad ib_iser ib_ipoib libiscsi rdma_cm scsi_transport_iscsi ib_cm iw_cm dm_multipath mlx5_ib ib_uverbs ib_core acpi_ipmi crct10dif_ce ghash_ce sha2_ce sha256_arm64 ipmi_ssif sha1_ce sbsa_gwdt ipmi_devintf ipmi_msghandler ip_tables xfs libcrc32c sg mlx5_core sdhci_acpi mlxfw tls sdhci qcom_emac mmc_core ahci_platform libahci_platform hdma hdma_mgmt dm_mirror dm_region_hash dm_log dm_mod
>> [  730.291605] CPU: 24 PID: 131 Comm: ksoftirqd/24 Not tainted 5.8.0+ #2
>> [  730.298027] Hardware name: WIWYNN Qualcomm Centriq 2400 Reference Evaluation Platform CV90-LA115-P11/Qualcomm Centriq 2400 Customer Reference Board, BIOS
>> [  730.311830] pstate: 20400005 (nzCv daif +PAN -UAO BTYPE=--)
>> [  730.317392] pc : __memcpy+0x100/0x180
>> [  730.321038] lr : rxe_mem_copy+0x1fc/0x230 [rdma_rxe]
>> [  730.325978] sp : fffffe001588faf0
>> [  730.329277] x29: fffffe001588faf0 x28: fffffe00294b1080
>> [  730.334572] x27: fffffc17b5065086 x26: 00000000000003c0
>> [  730.339867] x25: 0000000000000000 x24: fffffe00113f3000
>> [  730.345162] x23: fffffc17ae07c0f0 x22: 00000000288c9f50
>> [  730.350457] x21: fffffe001588fc60 x20: 0000000000000001
>> [  730.355753] x19: 00000000000003c0 x18: 0000000000000002
>> [  730.361048] x17: 1df0130affff0000 x16: 0000000000000001
>> [  730.366343] x15: 0000000000000002 x14: 0000000000000000
>> [  730.371638] x13: 0000000000000000 x12: 0000000000000000
>> [  730.376933] x11: 0000000000000000 x10: 0000000000000000
>> [  730.382228] x9 : fffffe000a52dd44 x8 : 0000000000000000
>> [  730.387523] x7 : 0000000000000000 x6 : fffffc17b5065086
>> [  730.392818] x5 : fffffe001588fc60 x4 : 0000000000000000
>> [  730.398113] x3 : 00000000000003c0 x2 : 0000000000000340
>> [  730.403409] x1 : 0000000000000000 x0 : fffffc17b5065086
>> [  730.408705] Call trace:
>> [  730.411136]  __memcpy+0x100/0x180
>> [  730.414438]  copy_data+0xc4/0x318 [rdma_rxe]
>> [  730.418691]  rxe_requester+0xa58/0xe38 [rdma_rxe]
>> [  730.423379]  rxe_do_task+0x128/0x200 [rdma_rxe]
>> [  730.427892]  tasklet_action_common.isra.21+0xfc/0x130
>> [  730.432924]  tasklet_action+0x2c/0x38
>> [  730.436570]  __do_softirq+0x128/0x33c
>> [  730.440215]  run_ksoftirqd+0x40/0x58
>> [  730.443777]  smpboot_thread_fn+0x168/0x1b0
>> [  730.447856]  kthread+0x114/0x118
>> [  730.451066]  ret_from_fork+0x10/0x18
>> [  730.454627] Code: d503201f d503201f d503201f d503201f (a8c12027)
>> [  730.460720] ---[ end trace 7d9bff591d1280d9 ]---
>> [  730.465302] Kernel panic - not syncing: Fatal exception in interrupt
>> [  730.471648] SMP: stopping secondary CPUs
>> [  730.475614] Kernel Offset: disabled
>> [  730.479017] CPU features: 0x040002,61800418
>> [  730.483183] Memory Limit: none
>> [  730.486232] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
>>
>>
>> Best Regards,
>>    Yi Zhang
>>
>>
> The code looks different than current. What kernel version are you testing?

The ppc64le log is from 5.9.0, and aarch64 log is from 5.8.0
> Is there tight timing on MR creation/destruction/invalidation and use?
No, I only ran the blktests nvme_trtype=rdma nvme/012

> Bob Pearson
>

