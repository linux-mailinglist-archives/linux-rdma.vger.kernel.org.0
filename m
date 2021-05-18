Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E5938752B
	for <lists+linux-rdma@lfdr.de>; Tue, 18 May 2021 11:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241325AbhERJdz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 May 2021 05:33:55 -0400
Received: from mail-m2456.qiye.163.com ([220.194.24.56]:24530 "EHLO
        mail-m2456.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239643AbhERJdz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 May 2021 05:33:55 -0400
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 May 2021 05:33:54 EDT
Received: from localhost (unknown [117.48.120.186])
        by mail-m2456.qiye.163.com (Hmail) with ESMTPA id B1D84700CFF;
        Tue, 18 May 2021 17:25:38 +0800 (CST)
Date:   Tue, 18 May 2021 17:25:37 +0800
From:   WANG Chao <chao.wang@ucloud.cn>
To:     linux-rdma@vger.kernel.org
Subject: Mellanox CX6DX switchdev mode VF fails rdma-core
 tests.test_mlx5_dc.DCTest
Message-ID: <20210518092537.mzlmqn7eua4ugztu@MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSUI3V1ktWUFJV1kPCR
        oVCBIfWUFZQkxPTFYYGkMdQhgZGB9OTEtVGRETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OU06Aio5HD0*NAMMDBkMDiwp
        MS4aCktVSlVKTUlKSElCQkhDQk5DVTMWGhIXVRgTGhRVDBoVHDsOGBcUDh9VGBVFWVdZEgtZQVlK
        SkxVT0NVSklLVUpDTVlXWQgBWUFJSENONwY+
X-HM-Tid: 0a797ecb892c8c15kuqtb1d84700cff
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi All

I'm running tests from https://github.com/linux-rdma/rdma-core/tree/master and
got the following errors from all tests.test_mlx5_dc.DCTest tests:

build/bin/run_tests.py --dev mlx5_2 --port 1 tests.test_mlx5_dc.DCTest.test_dc_rdma_write
E
======================================================================
ERROR: test_dc_rdma_write (tests.test_mlx5_dc.DCTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/data/rdma-core.master/tests/test_mlx5_dc.py", line 62, in test_dc_rdma_write
    send_ops_flags=e.IBV_QP_EX_WITH_RDMA_WRITE)
  File "/data/rdma-core.master/tests/test_mlx5_dc.py", line 53, in create_players
    self.client.pre_run(self.server.psns, self.server.qps_num)
  File "/data/rdma-core.master/tests/mlx5_base.py", line 36, in pre_run
    self.to_rts()
  File "/data/rdma-core.master/tests/mlx5_base.py", line 31, in to_rts
    self.dct_qp.to_rtr(attr)
  File "qp.pyx", line 1113, in pyverbs.qp.QP.to_rtr
pyverbs.pyverbs_error.PyverbsRDMAError: Failed to modify QP state to RTR. Errno: 22, Invalid argument

----------------------------------------------------------------------
Ran 1 test in 0.051s

FAILED (errors=1)

===
Additional information:

- VF is LAG and VF binds to host.
- DC tests fail when NIC is in switchdev mode while legacy mode is fine.
- Tested on 5.12 inbox driver or OFED 5.3, neither is working.
- 5f:00.0 Ethernet controller [0200]: Mellanox Technologies MT2892 Family [ConnectX-6 Dx] [15b3:101d]
- firmware-version: 22.30.1004 (MT_0000000536)

I worked a bit tracepoint on 5.12 inbox driver. It seems like there's a firmware
command error for CREATE_DCT.

I can provide more information if you ask.

Thanks
WANG Chao
