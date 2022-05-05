Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C41C51C574
	for <lists+linux-rdma@lfdr.de>; Thu,  5 May 2022 18:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382112AbiEEQ5V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 May 2022 12:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiEEQ5U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 May 2022 12:57:20 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1EB57B15
        for <linux-rdma@vger.kernel.org>; Thu,  5 May 2022 09:53:39 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id y63so4932456oia.7
        for <linux-rdma@vger.kernel.org>; Thu, 05 May 2022 09:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :references:to:from:in-reply-to:content-transfer-encoding;
        bh=GP0ytFsieiTaXLEx3SXvr3Ziz6ftqTZf3iZOTFJ8DhQ=;
        b=VolZvjAIQ4IaFY56OXmjuaOWo10c3el/C5dKQS8+qJq6ubL9nzl0z+B5le9I4qgxy5
         vOnEPb3Vthr9VSSRdVN2xrpWGAT/sxqwvjXrgDyve12oF7LbceGrXj4EBoy71qkJ3PBp
         VzxUIusOrqRkC5oqVLZ1AjybmARxQIEhy64kwTRO5EEoEd4Nl5f0Ne+jbavHevb2tm4w
         Dg+0f0xLdzDkUxOs1ue052ovj6xXhrkgSBegFfNRmADdIEpiNswDw23jwwMlJmEt6ELP
         D9qwcMnbT/M3oJRbn8RusEMuLdXf4i93oOE7tQPsjKbd47QUERxDLvmbMT9VaB/XmVzy
         yyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:references:to:from:in-reply-to
         :content-transfer-encoding;
        bh=GP0ytFsieiTaXLEx3SXvr3Ziz6ftqTZf3iZOTFJ8DhQ=;
        b=BzUCXxEXojiZVvjGim1e9V/9W4bzdrAmGF0Kj0Pwa8sF9remOWngcmIk+kW83VhkEr
         DJKc0KdEi10XPpLFG9kyB+MXFdyzqmPlrldJZbuvRCKzkY2nGfHkmS4+D9YOIkOG3TPL
         PrI7/w7528O1YXQcS6FMZI5CgGnEFofFUBwDVe76PHQkDTKIcC5qrQKdqtY28d8bAYCu
         yD5Gr92Ej4iQclcxRqamIvxUaTUVw/PJQ6A13X5xFKVPJmXMoXQRi91K8/x9pM2UPQW4
         TnU1At0cm4fnGKFwkLwItp06ghDoJ0Ne8rZpfP3eltz9IMA4hR2ZFWTLEzNthdcsZstE
         I7uA==
X-Gm-Message-State: AOAM533eegAxQUd8Az6R2y0XvHaRcCj1KfJf63LKlVoa9/Xf3pu4CwET
        2AukB2wT70U3L4leiuRyfGsHF5Rc8yk=
X-Google-Smtp-Source: ABdhPJxGK0Qf5sEVzu48zjZQXSfQgk4bk4v+E7PuGO+2fmXR3Sn3fS2JQAG7B5c5THTxtaNQbb3VUQ==
X-Received: by 2002:aca:4b95:0:b0:326:1179:5414 with SMTP id y143-20020aca4b95000000b0032611795414mr3042811oia.256.1651769618966;
        Thu, 05 May 2022 09:53:38 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:4d34:531:f6db:3282? (2603-8081-140c-1a00-4d34-0531-f6db-3282.res6.spectrum.com. [2603:8081:140c:1a00:4d34:531:f6db:3282])
        by smtp.gmail.com with ESMTPSA id z14-20020a056870e30e00b000e7a517df41sm693538oad.13.2022.05.05.09.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 09:53:38 -0700 (PDT)
Message-ID: <af415ea5-8e4d-3821-e4f8-0638119419af@gmail.com>
Date:   Thu, 5 May 2022 11:53:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Fwd: [PATCH for-next] RDMA/rxe: Fix "RDMA/rxe: Cleanup rxe_mcast.c"
Content-Language: en-US
References: <0a2fe427-a185-0432-0690-3ac0e1e0b055@gmail.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <0a2fe427-a185-0432-0690-3ac0e1e0b055@gmail.com>
X-Forwarded-Message-Id: <0a2fe427-a185-0432-0690-3ac0e1e0b055@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


You can reproduce the error by running the pyverbs test suite on for-next with
rdmacm enabled and lock checking configured. Both of these are tricky.
You will also see a lockdep warning but that is for a different test case.

1. The pyverbs test suite has a bug that prevents rxe from attempting several
test cases that depend on rdmacm for connection setup. I always apply the
following git patch which is a hack but enables these to run

diff --git a/tests/base.py b/tests/base.py

index 93568c7f..03b5601e 100644

--- a/tests/base.py

+++ b/tests/base.py

@@ -245,10 +245,11 @@ class RDMATestCase(unittest.TestCase):

         self._add_gids_per_port(ctx, dev, self.ib_port)

 

     def _get_ip_mac(self, dev, port, idx):

-        if not os.path.exists('/sys/class/infiniband/{}/device/net/'.format(dev)):

-            self.args.append([dev, port, idx, None, None])

-            return

-        net_name = self.get_net_name(dev)

+        #if not os.path.exists('/sys/class/infiniband/{}/device/net/'.format(dev)):

+            #self.args.append([dev, port, idx, None, None])

+            #return

+        #net_name = self.get_net_name(dev)

+        net_name = "enp0s3"

         try:

             ip_addr, mac_addr = self.get_ip_mac_address(net_name)

         except (KeyError, IndexError):

This test on /sys/class/infiniband fails because the rxe driver does not have
a device/net entry. I just provide the device name of my ethernet adapter (enp0s3).
I reported this to the maintainer of the pyverbs tests months ago but he never responded.

2. The following diff patch shows the locking tools I have configured

11363,11364c11363

< CONFIG_PROVE_LOCKING=y

< CONFIG_PROVE_RAW_LOCK_NESTING=y

---

> # CONFIG_PROVE_LOCKING is not set

11366,11379c11365,11371

< CONFIG_DEBUG_RT_MUTEXES=y

< CONFIG_DEBUG_SPINLOCK=y

< CONFIG_DEBUG_MUTEXES=y

< CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y

< CONFIG_DEBUG_RWSEMS=y

< CONFIG_DEBUG_LOCK_ALLOC=y

< CONFIG_LOCKDEP=y

< CONFIG_LOCKDEP_BITS=15

< CONFIG_LOCKDEP_CHAINS_BITS=16

< CONFIG_LOCKDEP_STACK_TRACE_BITS=19

< CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14

< CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12

< CONFIG_DEBUG_LOCKDEP=y

< CONFIG_DEBUG_ATOMIC_SLEEP=y

---

> # CONFIG_DEBUG_RT_MUTEXES is not set

> # CONFIG_DEBUG_SPINLOCK is not set

> # CONFIG_DEBUG_MUTEXES is not set

> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set

> # CONFIG_DEBUG_RWSEMS is not set

> # CONFIG_DEBUG_LOCK_ALLOC is not set

> # CONFIG_DEBUG_ATOMIC_SLEEP is not set

11385,11386d11376

< CONFIG_PROVE_NVDIMM_LOCKING=y

< # CONFIG_PROVE_CXL_LOCKING is not set

11389,11391c11379

< CONFIG_TRACE_IRQFLAGS=y

< CONFIG_TRACE_IRQFLAGS_NMI=y

< CONFIG_DEBUG_IRQFLAGS=y

---

> # CONFIG_DEBUG_IRQFLAGS is not set

11411d11398

< CONFIG_PROVE_RCU=y

11445d11431

< CONFIG_PREEMPTIRQ_TRACEPOINTS=y

I think the one that exhibits this warning is one of CONFIG_TRACE_IRQFLAGS=y

Unfortunately it only prints out the warning once per reboot as far as I can tell.
Reloading the rxe driver won't do it.

Once all this is in place just type

sudo ./build/bin/run_tests.py --dev rxe0

The warning output is below. Since two days ago it has been determined that the
cause of the warning is calling dev_mc_add() inside a spin_lock_irqsave()/_irqrestore().

Bob


-------- Forwarded Message --------
Subject: Re: [PATCH for-next] RDMA/rxe: Fix "RDMA/rxe: Cleanup rxe_mcast.c"
Date: Tue, 3 May 2022 23:39:36 -0500
From: Bob Pearson <rpearsonhpe@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>

On 5/3/22 23:22, Bob Pearson wrote:
> On 5/3/22 19:40, Jason Gunthorpe wrote:
>> On Tue, May 03, 2022 at 05:40:50PM -0500, Bob Pearson wrote:
>>> On 5/3/22 06:38, Jason Gunthorpe wrote:
>>>> On Wed, Apr 13, 2022 at 12:29:38AM -0500, Bob Pearson wrote:
>>>>> rxe_mcast.c currently uses _irqsave spinlocks for rxe->mcg_lock
>>>>> while rxe_recv.c uses _bh spinlocks for the same lock. Adding
>>>>> tracing shows that the code in rxe_mcast.c is all executed in_task()
>>>>> context while the code in rxe_recv.c that refers to the lock
>>>>> executes in softirq context. This causes a lockdep warning in code
>>>>> that executes multicast I/O including blktests check srp.
>>>>
>>>> What is the lockdep warning? This patch looks OK, but irqsave should
>>>> be a universal lock - so why does lockdep complain? Is there nesting?
>>>>
>>>> Jason
>>>
>>> I am bad at parsing them but basically just complaining that you can't
>>> mix _irq and _bh locks I believe.
>>
>> irqsave is a superset of bh within a process context, so lockdep
>> should not complain about just that.
>>
>>> I had had _irqsave locks in rxe_mcast.c which is process context and
>>> _bh locks in rxe_recv.c which is softirq context (NAPI). 
>>
>> Yes, I see that, but that alone should be OK.
>>
>> So lockdep is pointing at something else becoming involved in this..
>>
>>> There isn't any hard irq context for this lock. If you want to see
>>> it I can recompile with lockdep and run the python tests again.
>>
>> Please - the lockdep report should be pasted into the commit message.
>>
>> This patch doesn't make sense alone, although it seems correct from
>> what I can tell.
>>
>> Jason
> 
> This is the warning. I assumed it was lockdep but it seems it's something else.
> 
> [  159.430321] ------------[ cut here ]------------
> [  159.430326] raw_local_irq_restore() called with IRQs enabled
> [  159.430334] WARNING: CPU: 13 PID: 3107 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x2f/0x50
> [  159.430341] Modules linked in: rdma_ucm(E) rdma_cm(E) iw_cm(E) ib_cm(E) rdma_rxe(E) ib_uverbs(E) ip6_udp_tunnel udp_tunnel ib_core(E) isofs vboxvideo drm_vram_helper vboxsf snd_intel8x0 snd_ac97_codec nls_iso8859_1 ac97_bus intel_rapl_msr snd_pcm intel_rapl_common snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq crct10dif_pclmul ghash_clmulni_intel snd_seq_device aesni_intel crypto_simd snd_timer joydev cryptd input_leds snd serio_raw vboxguest soundcore mac_hid sch_fq_codel vmwgfx drm_ttm_helper ttm drm_kms_helper fb_sys_fops syscopyarea sysfillrect sysimgblt ipmi_devintf ipmi_msghandler dm_multipath scsi_dh_rdac drm scsi_dh_emc scsi_dh_alua msr parport_pc ppdev lp parport ip_tables x_tables autofs4 hid_generic usbhid hid psmouse crc32_pclmul e1000 ahci i2c_piix4 libahci pata_acpi video
> [  159.430391] CPU: 13 PID: 3107 Comm: python3 Tainted: G            E     5.18.0-rc1+ #7
> [  159.430395] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> [  159.430397] RIP: 0010:warn_bogus_irq_restore+0x2f/0x50
> [  159.430400] Code: 0f b6 1d af af 05 01 80 fb 01 77 26 83 e3 01 74 06 48 8b 5d f8 c9 c3 48 c7 c7 00 2c de 86 c6 05 91 af 05 01 01 e8 66 0d f2 ff <0f> 0b 48 8b 5d f8 c9 c3 0f b6 f3 48 c7 c7 90 d4 0b 87 e8 fa d6 84
> [  159.430403] RSP: 0018:ffffb8dd054db9e8 EFLAGS: 00010282
> [  159.430405] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [  159.430406] RDX: 0000000000000002 RSI: ffffffff86df36a1 RDI: 00000000ffffffff
> [  159.430408] RBP: ffffb8dd054db9f0 R08: 0000000000000003 R09: 0000000000000000
> [  159.430409] R10: 65725f7172695f6c R11: 0000000000000000 R12: ffff9524680f56c8
> [  159.430410] R13: ffff95240c5fde40 R14: ffff952467e81000 R15: ffff95240c5fde40
> [  159.430411] FS:  00007f2eb2f23000(0000) GS:ffff952517880000(0000) knlGS:0000000000000000
> [  159.430413] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  159.430414] CR2: 00007f2eb0bb3a00 CR3: 0000000122d6e000 CR4: 00000000000506e0
> [  159.430418] Call Trace:
> [  159.430420]  <TASK>
> [  159.430423]  _raw_spin_unlock_irqrestore+0x75/0x80
> [  159.430427]  rxe_attach_mcast+0x304/0x480 [rdma_rxe]
> [  159.430437]  ib_attach_mcast+0x88/0xa0 [ib_core]
> [  159.430452]  ib_uverbs_attach_mcast+0x186/0x1e0 [ib_uverbs]
> [  159.430459]  ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xcd/0x140 [ib_uverbs]
> [  159.430465]  ? _copy_from_user+0x7f/0xb0
> [  159.430474]  ib_uverbs_cmd_verbs+0xdb0/0xea0 [ib_uverbs]
> [  159.430480]  ? rcu_read_lock_sched_held+0x16/0x80
> [  159.430484]  ? lock_release+0x23d/0x330
> [  159.430487]  ? ib_uverbs_handler_UVERBS_METHOD_QUERY_CONTEXT+0xe0/0xe0 [ib_uverbs]
> [  159.430496]  ? lock_release+0x23d/0x330
> [  159.430501]  ? slab_free_freelist_hook.constprop.0+0x8e/0x180
> [  159.430505]  ? lock_acquire+0x1bd/0x330
> [  159.430507]  ? rcu_read_lock_sched_held+0x16/0x80
> [  159.430509]  ? rcu_read_lock_sched_held+0x16/0x80
> [  159.430511]  ? lock_acquire+0x1bd/0x330
> [  159.430514]  ? __might_fault+0x77/0x80
> [  159.430517]  ib_uverbs_ioctl+0xd2/0x160 [ib_uverbs]
> [  159.430522]  ? ib_uverbs_ioctl+0x8e/0x160 [ib_uverbs]
> [  159.430528]  __x64_sys_ioctl+0x91/0xc0
> [  159.430530]  do_syscall_64+0x5c/0x80
> [  159.430533]  ? syscall_exit_to_user_mode+0x3b/0x50
> [  159.430535]  ? do_syscall_64+0x69/0x80
> [  159.430537]  ? syscall_exit_to_user_mode+0x3b/0x50
> [  159.430540]  ? do_syscall_64+0x69/0x80
> [  159.430541]  ? irqentry_exit+0x63/0x90
> [  159.430544]  ? exc_page_fault+0xa8/0x2f0
> [  159.430546]  ? asm_exc_page_fault+0x8/0x30
> [  159.430548]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  159.430549] RIP: 0033:0x7f2eb2d1aaff
> [  159.430551] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64 48 2b 04 25 28 00
> [  159.430556] RSP: 002b:00007ffd3f260c60 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [  159.430558] RAX: ffffffffffffffda RBX: 00007ffd3f260da8 RCX: 00007f2eb2d1aaff
> [  159.430559] RDX: 00007ffd3f260d90 RSI: 00000000c0181b01 RDI: 000000000000003b
> [  159.430561] RBP: 00007ffd3f260d70 R08: 000055c046934e00 R09: 0000000000000000
> [  159.430562] R10: 000000000000001e R11: 0000000000000246 R12: 0000000000000000
> [  159.430563] R13: 0000000000000000 R14: 0000000000000000 R15: 000055c046934f40
> [  159.430567]  </TASK>
> [  159.430568] irq event stamp: 0
> [  159.430569] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [  159.430571] hardirqs last disabled at (0): [<ffffffff856bce5d>] copy_process+0x9dd/0x1f40
> [  159.430574] softirqs last  enabled at (0): [<ffffffff856bce5d>] copy_process+0x9dd/0x1f40
> [  159.430575] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [  159.430577] ---[ end trace 0000000000000000 ]---
> 
> The code for rxe_attach_mcast is
> 
> int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
> 
> {
> 
> 	int err;
> 
> 	struct rxe_dev *rxe = to_rdev(ibqp->device);
> 
> 	struct rxe_qp *qp = to_rqp(ibqp);
> 
> 	struct rxe_mcg *mcg;
> 
> 
> 
> 	/* takes a ref on mcg if successful */
> 
> 	mcg = rxe_get_mcg(rxe, mgid);
> 
> 	if (IS_ERR(mcg))
> 
> 		return PTR_ERR(mcg);
> 
> 
> 
> 	err = rxe_attach_mcg(mcg, qp);
> 
> 
> 
> 	/* if we failed to attach the first qp to mcg tear it down */
> 
> 	if (atomic_read(&mcg->qp_num) == 0)
> 
> 		rxe_destroy_mcg(mcg);
> 
> 
> 
> 	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
> 
> 
> 
> 	return err;
> 
> }
> 
> which calls static function rxe_attach_mcg() which is
> 
> static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
> 
> {
> 
> 	struct rxe_dev *rxe = mcg->rxe;
> 
> 	struct rxe_mca *mca, *tmp;
> 
> 	unsigned long flags;
> 
> 	int err;
> 
> 
> 
> 	/* check to see if the qp is already a member of the group */
> 
> 	spin_lock_irqsave(&rxe->mcg_lock, flags);
> 
> 	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
> 
> 		if (mca->qp == qp) {
> 
> 			spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> 
> 			return 0;
> 
> 		}
> 
> 	}
> 
> 	spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> 
> 
> 
> 	/* speculative alloc new mca without using GFP_ATOMIC */
> 
> 	mca = kzalloc(sizeof(*mca), GFP_KERNEL);
> 
> 	if (!mca)
> 
> 		return -ENOMEM;
> 
> 
> 
> 	spin_lock_irqsave(&rxe->mcg_lock, flags);
> 
> 	/* re-check to see if someone else just attached qp */
> 
> 	list_for_each_entry(tmp, &mcg->qp_list, qp_list) {
> 
> 		if (tmp->qp == qp) {
> 
> 			kfree(mca);
> 
> 			err = 0;
> 
> 			goto out;
> 
> 		}
> 
> 	}
> 
> 
> 
> 	err = __rxe_init_mca(qp, mcg, mca);
> 
> 	if (err)
> 
> 		kfree(mca);
> 
> out:
> 
> 	spin_unlock_irqrestore(&rxe->mcg_lock, flags);
> 
> 	return err;
> 
> }
> 
> which has the offending spin_unlock_irqrestore apparently inline.
> 
> I replace the locks with _bh locks the warning goes away.
> 
> Bob 

I looked up the error message and the commit that added the check claims to be
looking for irq_save/irq_restore sequences that enable some irqs in between them.
I sure don't see anything that looks like that.

Bob
