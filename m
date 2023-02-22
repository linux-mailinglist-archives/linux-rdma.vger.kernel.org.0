Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AA769FAD7
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Feb 2023 19:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjBVSLz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Feb 2023 13:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBVSLz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Feb 2023 13:11:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459DC2DE53;
        Wed, 22 Feb 2023 10:11:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BADE3614E5;
        Wed, 22 Feb 2023 18:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7187C433EF;
        Wed, 22 Feb 2023 18:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677089513;
        bh=6RmY6dF/tedsI7Ars6egTkx1W57+WeN+YMdXjfAxtt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tCPyv2QQb8eycm9xArgO2N6jmY7YT4WHeJr27HWUPnfxiEdba08xds/SPu8LTmb6R
         XXTxbn16/iN7jaGUpr2SxpVrp8V4VWYS7cyLBoRb3Dm+Ecv6Wk1ui0F7s/Z7c/widI
         F24jSAT4KDC7SOG1Z9VVaoZNCu1tKORlH+gGNmfseyQ4/RGvTEJeRmZIo6ljs+JDuS
         odz3LfDWUMUAUqMWNV5KFqaetjJRHdkXdJ4BgVHjbRofFxeXVXaO6WSY1rJoszHsWd
         UOEq60lRVs8VY1qCx98TeqN431ejjgcKo8seixyst1CvNBbDzhpky8FYr/hW1YuLqD
         n+EUXqrnJhkrQ==
Date:   Wed, 22 Feb 2023 20:11:48 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Yacan Liu <liuyacan@corp.netease.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: An issue of kernel stall caused by infiniband mad packet
Message-ID: <Y/Za5NUcROu4Srrj@unreal>
References: <4f5e51dc-6116-aad6-de8b-7a1bf7c17656@corp.netease.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f5e51dc-6116-aad6-de8b-7a1bf7c17656@corp.netease.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 22, 2023 at 08:40:52PM +0800, Yacan Liu wrote:
> Hi folks:
> 
>   We recently encountered a kernel stall issue related to infiniband mad
> packet. We believe this is caused by some abnormal operations of user-level
> programs.But I am not sure if the kernel driver needs to do some protection.
> 
> In our cluster, multiple nodes will establish multiple RDMA connections with
> each other. Then, when we start the program, the kernel prompts the
> following error after one minute:
> 
> [ 5489.530125] rcu: INFO: rcu_sched self-detected stall on CPU
> [ 5489.535714] rcu:     55-....: (19027 ticks this GP)
> idle=236/1/0x4000000000000000 softirq=13510/13510 fqs=4359
> [ 5489.545554]  (t=21015 jiffies g=279845 q=701559)
> [ 5489.545557] NMI backtrace for cpu 55
> [ 5489.545559] CPU: 55 PID: 44979 Comm: kworker/u196:1 Tainted: G    OE
> 5.10.91-netease3-1 #2
> [ 5489.545560] Hardware name: Inspur SA5212M5/YZMB-00882-10T, BIOS 4.1.21
> 08/25/2021
> [ 5489.545582] Workqueue: ib-comp-unb-wq ib_cq_poll_work [ib_core]
> [ 5489.545584] Call Trace:
> [ 5489.545586]
> [ 5489.545590]  dump_stack+0x6b/0x83
> [ 5489.545593]  nmi_cpu_backtrace.cold+0x32/0x69
> [ 5489.545596]  ? lapic_can_unplug_cpu+0x80/0x80
> [ 5489.545599]  nmi_trigger_cpumask_backtrace+0xd7/0xe0
> [ 5489.545602]  rcu_dump_cpu_stacks+0xa2/0xd0
> [ 5489.545604]  rcu_sched_clock_irq.cold+0x1ff/0x3d6
> [ 5489.545607]  ? trigger_load_balance+0x5a/0x240
> [ 5489.545610]  update_process_times+0x8c/0xc0
> [ 5489.545613]  tick_sched_handle+0x22/0x60
> [ 5489.545615]  tick_sched_timer+0x7c/0xb0
> [ 5489.545617]  ? tick_do_update_jiffies64.part.0+0xc0/0xc0
> [ 5489.545619]  __hrtimer_run_queues+0x12a/0x270
> [ 5489.545621]  hrtimer_interrupt+0x110/0x2c0
> [ 5489.545623]  __sysvec_apic_timer_interrupt+0x5f/0xd0
> [ 5489.545627]  asm_call_irq_on_stack+0xf/0x20
> [ 5489.545627]
> [ 5489.545629]  sysvec_apic_timer_interrupt+0x72/0x80
> [ 5489.545631]  asm_sysvec_apic_timer_interrupt+0x12/0x20
> 
> OS:  Debian 11
> Kernel: 5.10.91
> ofed: MLNX_OFED_LINUX-5.5-1.0.3.2

Please approach your NVidia support representative. There are some
differences between upstream and MOFED code in MAD area.

Thanks
