Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9329C69F4D8
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Feb 2023 13:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjBVMs4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Feb 2023 07:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBVMs4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Feb 2023 07:48:56 -0500
X-Greylist: delayed 476 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Feb 2023 04:48:53 PST
Received: from corp-front07-corp.i.nease.net (corp-front07-corp.i.nease.net [59.111.134.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454F531E1D
        for <linux-rdma@vger.kernel.org>; Wed, 22 Feb 2023 04:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=corp.netease.com; s=s210401; h=Received:Message-ID:Date:
        MIME-Version:User-Agent:Content-Language:From:Subject:To:Cc:
        Content-Type:Content-Transfer-Encoding; bh=pnxyCL47frXTed1ME3Xje
        GSh2dyB5+454H2B7JzowSg=; b=WWZJWulpJeXLn54L8IdAtc9fnj21LPDa9CzsP
        7jvVj2tYuOBiq/9A6gNvesF3PJBjqfPcSN4KWx7eC02TbAQEZULddOnH7OpZ6Jtm
        oaIOFmr0vBQtH6t4hyvLlEfLh/5pVPpVV4cS8Vhbgb2hlD3HkH11Pmf0PTuO9x1C
        wShkL0=
Received: from [10.219.192.244] (unknown [183.136.182.140])
        by corp-front07-corp.i.nease.net (Coremail) with SMTP id nRDICgD3wrhUDfZjVY8HAA--.31745S2;
        Wed, 22 Feb 2023 20:40:52 +0800 (HKT)
Message-ID: <4f5e51dc-6116-aad6-de8b-7a1bf7c17656@corp.netease.com>
Date:   Wed, 22 Feb 2023 20:40:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
From:   Yacan Liu <liuyacan@corp.netease.com>
Subject: An issue of kernel stall caused by infiniband mad packet
To:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: nRDICgD3wrhUDfZjVY8HAA--.31745S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4kWrWUKF18Jw1UCFyUZFb_yoW5ArWkpF
        WYkrWfJFW8Jrn0y3y8A3y8Ja45WFs3CF13KF4rJry5ArnxXrZ3WFyxt34jgF48urWkZry5
        Cw1vkr98KrZru3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUHKb7IF0VCFI7km07C26c804VAKzcIF0wAYjsxI4VWkKwAYFVCj
        jxCrM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1V
        AKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvE
        c7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6x
        kF7I0E14v26rxl6s0DM2kK67kvxFCE548m6r1fGryUXwAawVAFpfBj4fn0lVCYm3Zqqf92
        6ryUJw1UKr1v6r18M2kK6xCIbVAIwIAEc20F6c8GOVW8Jr15Jr4le2I262IYc4CY6c8Ij2
        8IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r48Ar1UJr1U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCjxxvEa2IrMxk0xIA0c2IEe2xFo4
        CEbIxvr21lc2IjII80xcxEwVAKI48JMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIE
        Y20_Gr48tr1UJr1l4x8a64kIII0Yj41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY624lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
        9x07jgZ2fUUUUU=
X-CM-SenderInfo: 5olx5txfdqquhrush05hwht23hof0z/1tbiBQAKCVt79MucBwAAsC
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi folks:

   We recently encountered a kernel stall issue related to infiniband 
mad packet. We believe this is caused by some abnormal operations of 
user-level programs.But I am not sure if the kernel driver needs to do 
some protection.

In our cluster, multiple nodes will establish multiple RDMA connections 
with each other. Then, when we start the program, the kernel prompts the 
following error after one minute:

[ 5489.530125] rcu: INFO: rcu_sched self-detected stall on CPU
[ 5489.535714] rcu:     55-....: (19027 ticks this GP) 
idle=236/1/0x4000000000000000 softirq=13510/13510 fqs=4359
[ 5489.545554]  (t=21015 jiffies g=279845 q=701559)
[ 5489.545557] NMI backtrace for cpu 55
[ 5489.545559] CPU: 55 PID: 44979 Comm: kworker/u196:1 Tainted: G    OE 
    5.10.91-netease3-1 #2
[ 5489.545560] Hardware name: Inspur SA5212M5/YZMB-00882-10T, BIOS 
4.1.21 08/25/2021
[ 5489.545582] Workqueue: ib-comp-unb-wq ib_cq_poll_work [ib_core]
[ 5489.545584] Call Trace:
[ 5489.545586]
[ 5489.545590]  dump_stack+0x6b/0x83
[ 5489.545593]  nmi_cpu_backtrace.cold+0x32/0x69
[ 5489.545596]  ? lapic_can_unplug_cpu+0x80/0x80
[ 5489.545599]  nmi_trigger_cpumask_backtrace+0xd7/0xe0
[ 5489.545602]  rcu_dump_cpu_stacks+0xa2/0xd0
[ 5489.545604]  rcu_sched_clock_irq.cold+0x1ff/0x3d6
[ 5489.545607]  ? trigger_load_balance+0x5a/0x240
[ 5489.545610]  update_process_times+0x8c/0xc0
[ 5489.545613]  tick_sched_handle+0x22/0x60
[ 5489.545615]  tick_sched_timer+0x7c/0xb0
[ 5489.545617]  ? tick_do_update_jiffies64.part.0+0xc0/0xc0
[ 5489.545619]  __hrtimer_run_queues+0x12a/0x270
[ 5489.545621]  hrtimer_interrupt+0x110/0x2c0
[ 5489.545623]  __sysvec_apic_timer_interrupt+0x5f/0xd0
[ 5489.545627]  asm_call_irq_on_stack+0xf/0x20
[ 5489.545627]
[ 5489.545629]  sysvec_apic_timer_interrupt+0x72/0x80
[ 5489.545631]  asm_sysvec_apic_timer_interrupt+0x12/0x20

OS:  Debian 11
Kernel: 5.10.91
ofed: MLNX_OFED_LINUX-5.5-1.0.3.2

PS. Thread worker/u196:2+ib-comp-unb-w is consuming 100% CPU.

After some investigations, We found that the kernel thread spends too 
much time in the function wait_for_response(). We know that in the 
process of establishing an RDMA connection, when the local side sends 
out a MAD request, it will wait for the response packet from the remote 
side within a limited time, and it is in the wait_list at this time. 
This wait_list is sorted according to the timeout time, which means the 
complexity of insertion or search is O(n). When the remote application 
does not call rdma_accept() for some reason, it will not send the 
response packet. In this way, the entry will not be cleared from the 
wait_list on the local side for a long time. And the local application 
continues to initiate connections outward, which makes the elements in 
the wait_list more and more, and the wait_for_response() longer and longer.

Regard,
Yacan

