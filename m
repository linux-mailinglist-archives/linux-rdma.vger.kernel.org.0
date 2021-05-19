Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC156388523
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 05:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbhESDP0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 May 2021 23:15:26 -0400
Received: from mail-m2835.qiye.163.com ([103.74.28.35]:23288 "EHLO
        mail-m2835.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237253AbhESDP0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 May 2021 23:15:26 -0400
Received: from localhost (unknown [117.48.120.186])
        by mail-m2835.qiye.163.com (Hmail) with ESMTPA id 7FFC978041A;
        Wed, 19 May 2021 11:14:03 +0800 (CST)
Date:   Wed, 19 May 2021 11:14:03 +0800
From:   WANG Chao <chao.wang@ucloud.cn>
To:     Mark Zhang <markzhang@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Mellanox CX6DX switchdev mode VF fails rdma-core
 tests.test_mlx5_dc.DCTest
Message-ID: <20210519031403.oztprsjpzidwzqdu@MacBook-Air.local>
References: <20210518092537.mzlmqn7eua4ugztu@MacBook-Air.local>
 <13a4c4a3-0914-c8c9-1873-da83ca0177ed@nvidia.com>
 <20210518124411.vps2uyjfzo4ikjjz@MacBook-Air.local>
 <4eb5c13e-6e9a-5d79-da7d-bd4219eef447@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eb5c13e-6e9a-5d79-da7d-bd4219eef447@nvidia.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSUI3V1ktWUFJV1kPCR
        oVCBIfWUFZGksdGFZLHU8eGkNPQ0lKTh9VGRETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRw6Qww6Hz04KAJNAhVPFQ0Y
        SRMaC0pVSlVKTUlKSEJPS09IQ0tOVTMWGhIXVRgTGhRVDBoVHDsOGBcUDh9VGBVFWVdZEgtZQVlK
        SkxVT0NVSklLVUpDTVlXWQgBWUFPTk5KNwY+
X-HM-Tid: 0a79829db28a841dkuqw7ffc978041a
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 05/18/21 at 09:00P, Mark Zhang wrote:
> On 5/18/2021 8:44 PM, WANG Chao wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On 05/18/21 at 08:30P, Mark Zhang wrote:
> > > On 5/18/2021 5:25 PM, WANG Chao wrote:
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > Hi All
> > > > 
> > > > I'm running tests from https://github.com/linux-rdma/rdma-core/tree/master and
> > > > got the following errors from all tests.test_mlx5_dc.DCTest tests:
> > > > 
> > > > build/bin/run_tests.py --dev mlx5_2 --port 1 tests.test_mlx5_dc.DCTest.test_dc_rdma_write
> > > > E
> > > > ======================================================================
> > > > ERROR: test_dc_rdma_write (tests.test_mlx5_dc.DCTest)
> > > > ----------------------------------------------------------------------
> > > > Traceback (most recent call last):
> > > >     File "/data/rdma-core.master/tests/test_mlx5_dc.py", line 62, in test_dc_rdma_write
> > > >       send_ops_flags=e.IBV_QP_EX_WITH_RDMA_WRITE)
> > > >     File "/data/rdma-core.master/tests/test_mlx5_dc.py", line 53, in create_players
> > > >       self.client.pre_run(self.server.psns, self.server.qps_num)
> > > >     File "/data/rdma-core.master/tests/mlx5_base.py", line 36, in pre_run
> > > >       self.to_rts()
> > > >     File "/data/rdma-core.master/tests/mlx5_base.py", line 31, in to_rts
> > > >       self.dct_qp.to_rtr(attr)
> > > >     File "qp.pyx", line 1113, in pyverbs.qp.QP.to_rtr
> > > > pyverbs.pyverbs_error.PyverbsRDMAError: Failed to modify QP state to RTR. Errno: 22, Invalid argument
> > > > 
> > > > ----------------------------------------------------------------------
> > > > Ran 1 test in 0.051s
> > > > 
> > > > FAILED (errors=1)
> > > > 
> > > > ===
> > > > Additional information:
> > > > 
> > > > - VF is LAG and VF binds to host.
> > > > - DC tests fail when NIC is in switchdev mode while legacy mode is fine.
> > > > - Tested on 5.12 inbox driver or OFED 5.3, neither is working.
> > > > - 5f:00.0 Ethernet controller [0200]: Mellanox Technologies MT2892 Family [ConnectX-6 Dx] [15b3:101d]
> > > > - firmware-version: 22.30.1004 (MT_0000000536)
> > > > 
> > > > I worked a bit tracepoint on 5.12 inbox driver. It seems like there's a firmware
> > > > command error for CREATE_DCT.
> > > > 
> > > > I can provide more information if you ask.
> > > > 
> > > > Thanks
> > > > WANG Chao
> > > > 
> > > Is there any syndrome in kernel log? Try to reproduce with debug log
> > > enabled:
> > > echo -n "func mlx5_cmd_check +p" > /sys/kernel/debug/dynamic_debug/control
> > 
> > [26538.391991] mlx5_core 0000:5f:00.2: mlx5_cmd_check:820:(pid 27332): CREATE_DCT(0x710) op_mod(0x0) failed, status bad parameter(0x3), syndrome (0xa22b82)
> > 
> This syndrome indicates DCT is not supported in VF LAG mode here.

Thanks for the info. I test non-LAG mode on 5.12. Both VF and SF pass DC tests.

I got a couple of questions though.

1. Where can I find information for each different syndrome?
2. Is there any plan to support DCT in VF LAG mode?

BTW I think in this case, it's best for kernel to fail as early as
possible. And -EINVAL isn't good enough for regular users, maybe
-ENOTSUPP or more explicit errors in kernel?

