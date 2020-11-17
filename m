Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A28F2B6949
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Nov 2020 17:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgKQQCq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Nov 2020 11:02:46 -0500
Received: from btbn.de ([5.9.118.179]:37528 "EHLO btbn.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726588AbgKQQCq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Nov 2020 11:02:46 -0500
X-Greylist: delayed 494 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Nov 2020 11:02:45 EST
Received: from [IPv6:2001:16b8:64fc:e100:ecd3:36d:b750:1faf] (200116b864fce100ecd3036db7501faf.dip.versatel-1u1.de [IPv6:2001:16b8:64fc:e100:ecd3:36d:b750:1faf])
        by btbn.de (Postfix) with ESMTPSA id 0A385E289C
        for <linux-rdma@vger.kernel.org>; Tue, 17 Nov 2020 16:54:31 +0100 (CET)
To:     RDMA mailing list <linux-rdma@vger.kernel.org>
From:   Timo Rothenpieler <timo@rothenpieler.org>
Subject: Issue after 5.4.70->5.4.77 update: mlx5_core: reg_mr_callback: async
 reg mr failed. status -11
Message-ID: <53e3f194-fe27-ba79-bcff-6dd1d778ede0@rothenpieler.org>
Date:   Tue, 17 Nov 2020 16:54:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This has started happening after I upgraded from 5.4.70 to 5.4.77, on a 
"Mellanox Technologies MT27700 Family [ConnectX-4]".

On every bootup, the following messages appear in dmesg:

> store01 ~ # journalctl -b | grep mlx5
> Nov 17 01:25:23 store01 kernel: mlx5_core 0000:01:00.0: firmware version: 12.28.1002
> Nov 17 01:25:23 store01 kernel: mlx5_core 0000:01:00.0: 126.016 Gb/s available PCIe bandwidth (8 GT/s x16 link)
> Nov 17 01:25:23 store01 kernel: mlx5_core 0000:01:00.0: Port module event: module 0, Cable plugged
> Nov 17 01:25:23 store01 kernel: mlx5_ib: Mellanox Connect-IB Infiniband driver v5.0-0
> Nov 17 01:25:23 store01 kernel: mlx5_core 0000:01:00.0: cmd_work_handler:887:(pid 376): failed to allocate command entry
> Nov 17 01:25:23 store01 kernel: infiniband mlx5_0: reg_mr_callback:104:(pid 376): async reg mr failed. status -11
> Nov 17 01:25:23 store01 kernel: mlx5_core 0000:01:00.0: MLX5E: StrdRq(0) RqSz(1024) StrdSz(256) RxCqeCmprss(0)
> Nov 17 01:25:23 store01 kernel: mlx5_core 0000:01:00.0: MLX5E: StrdRq(0) RqSz(1024) StrdSz(256) RxCqeCmprss(0)
> Nov 17 01:25:23 store01 kernel: mlx5_core 0000:01:00.0 ibp1s0: renamed from ib0

Other than those two error messages, the system and adapter appears to 
work fine.
However, sporadically, the issue extends itself and fails to bring up IPoIB:

> store01 ~ # journalctl -b -1 | grep mlx5
> Nov 17 01:12:58 store01 kernel: mlx5_core 0000:01:00.0: firmware version: 12.28.1002
> Nov 17 01:12:58 store01 kernel: mlx5_core 0000:01:00.0: 126.016 Gb/s available PCIe bandwidth (8 GT/s x16 link)
> Nov 17 01:12:58 store01 kernel: mlx5_core 0000:01:00.0: Port module event: module 0, Cable plugged
> Nov 17 01:12:58 store01 kernel: mlx5_ib: Mellanox Connect-IB Infiniband driver v5.0-0
> Nov 17 01:12:58 store01 kernel: mlx5_core 0000:01:00.0: cmd_work_handler:887:(pid 383): failed to allocate command entry
> Nov 17 01:12:58 store01 kernel: infiniband mlx5_0: reg_mr_callback:104:(pid 383): async reg mr failed. status -11
> Nov 17 01:12:58 store01 kernel: mlx5_core 0000:01:00.0: cmd_work_handler:887:(pid 383): failed to allocate command entry
> Nov 17 01:12:58 store01 kernel: mlx5_core 0000:01:00.0: mlx5e_create_mdev_resources:104:(pid 1): alloc td failed, -11
> Nov 17 01:12:58 store01 kernel: mlx5_0, 1: ipoib_intf_alloc failed -11

When that happens, only another reboot fixes IPoIB.
Neither of those issues are a thing when booting 5.4.70.

The most likely candidate for this seems to be 
0ec52f0194638e2d284ad55eba5a7aff753de1b9(RDMA/mlx5: Disable 
IB_DEVICE_MEM_MGT_EXTENSIONS if IB_WR_REG_MR can't work)  which was 
merged in 5.4.73. There were also a lot of mlx5 related changes in 
5.4.71 though.
Though since this is a production system, I cannot sensibly bisect this.


Any ideas on how to mitigate this, like backporting more patches or 
changing some settings are appreciated.
