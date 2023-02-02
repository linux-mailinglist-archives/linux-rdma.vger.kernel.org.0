Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8263E687457
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 05:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjBBERM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Feb 2023 23:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjBBERL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Feb 2023 23:17:11 -0500
X-Greylist: delayed 452 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 20:17:10 PST
Received: from out-218.mta0.migadu.com (out-218.mta0.migadu.com [IPv6:2001:41d0:1004:224b::da])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2015F761CD
        for <linux-rdma@vger.kernel.org>; Wed,  1 Feb 2023 20:17:09 -0800 (PST)
Message-ID: <b82cfec2-b679-7c5a-06fe-a540fddda0f3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675310975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zK/TAzHm0RtLrqdCRbnz2rIxx2M9pDyw9VFS3C2MaFI=;
        b=HuN5ErL6UezfxuBBQY+gsMkccm5X7FD7m/GXFOMnC6B5mhIccibZkScOvCzktc2PD2BldK
        hGJHh3KPn8D0bxUXIOy4rQeCPyPSBfeb7D5BUCMn3IvUdu8bb4f4okDR26PK0W8je3/KNR
        ndCqAOyZdurQMi4XjG1sOtVJSG7yxM8=
Date:   Thu, 2 Feb 2023 12:09:34 +0800
MIME-Version: 1.0
Subject: Re: [PATCH RFC] RDMA/rtrs: Don't call kobject_del for srv_path->kobj
Content-Language: en-US
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1675261833-2-1-git-send-email-lizhijian@fujitsu.com>
 <6bcba397-f4f1-26df-f8cd-1dbebf111932@linux.dev>
 <d1751eec-3d48-a8c9-1e3b-3263a4a043a3@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <d1751eec-3d48-a8c9-1e3b-3263a4a043a3@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/2/23 11:42, lizhijian@fujitsu.com wrote:
> Thanks your reviewing @Guoqing
>
>> Thanks for the fix, it would be better to comment that why kobject_del can't
>> be called here.
> commmit f7452a7e96c1 ("RDMA/rtrs-srv: fix memory leak by missing kobject free")
> memtioned a free_sess(), but i didn't get it exactly(no such function ?). So i have
> not sorted it out.

It was renamed to free_path I believe.

> And hold on，with below change， kernel gets another WARNING.
> I'm still working on it.
>
> [  125.034407] =========================
> [  125.035490] WARNING: held lock freed!
> [  125.036640] 6.2.0-rc6-roce-flush+ #53 Not tainted
> [  125.038088] -------------------------
> [  125.039143] kworker/0:3/63 is freeing memory ffff90bd01eaa000-ffff90bd01eaa7ff, with a lock still held there!
> [  125.041660] ffff90bd01eaa118 (&srv->paths_mutex){+.+.}-{3:3}, at: rtrs_srv_destroy_once_sysfs_root_folders.isra.0+0x24/0x60 [rtrs_server]
> [  125.044600] 3 locks held by kworker/0:3/63:
> [  125.046091]  #0: ffff90bd05f8ed38 ((wq_completion)rtrs_server_wq){+.+.}-{0:0}, at: process_one_work+0x1f4/0x590
> [  125.048876]  #1: ffff9ff4c085fe78 ((work_completion)(&srv_path->close_work)){+.+.}-{0:0}, at: process_one_work+0x1f4/0x590
> [  125.051789]  #2: ffff90bd01eaa118 (&srv->paths_mutex){+.+.}-{3:3}, at: rtrs_srv_destroy_once_sysfs_root_folders.isra.0+0x24/0x60 [rtrs_server]
> [  125.055167]
> [  125.055167] stack backtrace:
> [  125.057979] CPU: 0 PID: 63 Comm: kworker/0:3 Kdump: loaded Not tainted 6.2.0-rc6-roce-flush+ #53
> [  125.060201] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [  125.063156] Workqueue: rtrs_server_wq rtrs_srv_close_work [rtrs_server]
> [  125.065031] Call Trace:
> [  125.065905]  <TASK>
> [  125.066733]  dump_stack_lvl+0x45/0x5d
> [  125.068003]  debug_check_no_locks_freed.cold+0x77/0x7c
> [  125.069565]  ? device_release+0x34/0x90
> [  125.070814]  __kmem_cache_free+0x74/0x190
> [  125.072059]  device_release+0x34/0x90
> [  125.073203]  kobject_put+0x8b/0x1d0
> [  125.074385]  rtrs_srv_destroy_once_sysfs_root_folders.isra.0+0x35/0x60 [rtrs_server]
> [  125.076456]  rtrs_srv_close_work+0x21/0x270 [rtrs_server]
> [  125.078097]  process_one_work+0x274/0x590
> [  125.079372]  worker_thread+0x4f/0x3d0
> [  125.080508]  ? __pfx_worker_thread+0x10/0x10
> [  125.081751]  kthread+0xe7/0x110
> [  125.082778]  ? __pfx_kthread+0x10/0x10
> [  125.083894]  ret_from_fork+0x2c/0x50
> [  125.084991]  </TASK>

Suppose it also happened during run your script, I guess it might be some
racy conditions.

$ while true;
do
         echo "sessname=foo path=ip:<ip address> device_path=/dev/nvme0n1" > /sys/devices/virtual/rnbd-client/ctl/map_device
         echo "normal" > /sys/block/rnbd0/rnbd/unmap_device
done


Or does it disappear after revert 6af4609c18b3? If so, we can revert it
first.

Thanks,
Guoqing
