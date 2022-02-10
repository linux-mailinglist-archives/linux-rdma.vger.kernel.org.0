Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D414B0758
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Feb 2022 08:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbiBJHhI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Feb 2022 02:37:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbiBJHhI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Feb 2022 02:37:08 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F15270
        for <linux-rdma@vger.kernel.org>; Wed,  9 Feb 2022 23:37:09 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644478625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uC2hrcmNn5oT557Ty7+yiSh4sj5+Wd0hmR9jjwqsZZM=;
        b=bV9/v3KxSv/2ZxbDOw3u05SUuipik6xN9VuiYsejuXw4C3XpOb0WlwC7p/aD4ADw2jAGom
        qL/6e14xbuAeW+xc4vfr0zTh0//X7JJmsNLWUrSPsIQyzMSez4H174JVRQUjahojHRc6/f
        teL3eQtjizpRSTE2nAQhKcsCw/fzMok=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, rpearsonhpe@gmail.com
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 0/3] patches and bug report for rxe 
Date:   Thu, 10 Feb 2022 15:36:52 +0800
Message-Id: <20220210073655.42281-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

Recently, I am trying to run rnbd/rtrs on top of rxe, and get several
calltraces with 5.17-rc3 kernel (CONFIG_PROVE_LOCKING is enabled).

However, seems rnbd/rtrs over rxe still can't work with 5.17-rc3 kernel,
dmesg reports below.

1. server side

[  440.723182] rdma_rxe: qp#17 moved to error state
[  440.725300] rtrs_server L1205: <bla>: remote access error (wr_cqe: 000000003b14397c, type: 0, vendor_err: 0x0, len: 0)
[  440.845926] rnbd_server L256: RTRS Session bla disconnected

2. client side

[  997.817536] rnbd_client L596: Mapping device /dev/loop1 on session bla, (access_mode: rw, nr_poll_queues: 0)
[  998.968810] rnbd_client L1213: [session=bla] mapped 8/8 default/read queues.
[  999.017988] rtrs_client L610: <bla>: RDMA failed: remote access error
[ 1029.836943] rtrs_client L353: <bla>: Failed IB_WR_LOCAL_INV: WR flushe    

Then I tried 5.16 and 5.15 version, seems 5.15 does work as follows.

1. server side

[  333.076482] rnbd_server L800: </dev/loop1@bla>: Opened device 'loop1'

2. client side

[ 1584.325825] rnbd_client L596: Mapping device /dev/loop1 on session bla, (access_mode: rw, nr_poll_queues: 0)
[ 1585.268291] rnbd_client L1213: [session=bla] mapped 8/8 default/read queues.
[ 1585.349300] rnbd_client L1607: </dev/loop1@bla> map_device: Device mapped as rnbd0 (nsectors: 0, logical_block_size: 512, physical_block_size: 512, max_write_same_sectors: 0, max_discard_sectors: 0, discard_granularity: 0, discard_alignment: 0, secure_discard: 0, max_segments: 128, max_hw_sectors: 248, rotational: 1, wc: 0, fua: 0)

I would appreciate if someone shed light on why it doesn't work after 5.15,
And I am happy to test potential patch for it.

Guoqing Jiang (3):
  RDMA/rxe: Replace write_{lock,unlock}_bh with
    write_lock_irq{save,restore} in __rxe_add_index
  RDMA/rxe: Replace write_{lock,unlock}_bh with
    write_lock_irq{save,restore} in __rxe_drop_index
  RDMA/rxe: Replace write_{lock,unlock}_bh with
    write_lock_irq{save,restore} in post_one_send

 drivers/infiniband/sw/rxe/rxe_pool.c  | 10 ++++++----
 drivers/infiniband/sw/rxe/rxe_verbs.c |  5 +++--
 2 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.26.2

