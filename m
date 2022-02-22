Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC97F4BF51E
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Feb 2022 10:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiBVJvK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Feb 2022 04:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiBVJvJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Feb 2022 04:51:09 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3FFCF383
        for <linux-rdma@vger.kernel.org>; Tue, 22 Feb 2022 01:50:44 -0800 (PST)
Subject: Re: bug report for rxe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1645523439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Mp7f4/Ee9U1QhxbxNyL82o2084NSezNRFyHTc6VF/I=;
        b=OCafrbYwM9dov/2S4C8xpVXMfzSTNYtvk7gfBdqDYWoFO/hhRNz59QVqG1PhhK+OaScLHI
        EXHQNH1sCsRLdZW8rPF8+xwgNEgfLNcU3oNODDxILw0o0uThOd6rhGPI9ltnoNLyohvQM6
        ntstWutJRyb/MumMBcQPcNiEwOq8YCg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, rpearsonhpe@gmail.com
Cc:     linux-rdma@vger.kernel.org
References: <20220210073655.42281-1-guoqing.jiang@linux.dev>
Message-ID: <473a53b6-9ab2-0d48-a9cf-c84b8dc4c3f3@linux.dev>
Date:   Tue, 22 Feb 2022 17:50:34 +0800
MIME-Version: 1.0
In-Reply-To: <20220210073655.42281-1-guoqing.jiang@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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



On 2/10/22 3:36 PM, Guoqing Jiang wrote:
> However, seems rnbd/rtrs over rxe still can't work with 5.17-rc3 kernel,
> dmesg reports below.
>
> 1. server side
>
> [  440.723182] rdma_rxe: qp#17 moved to error state
> [  440.725300] rtrs_server L1205: <bla>: remote access error (wr_cqe: 000000003b14397c, type: 0, vendor_err: 0x0, len: 0)
> [  440.845926] rnbd_server L256: RTRS Session bla disconnected
>
> 2. client side
>
> [  997.817536] rnbd_client L596: Mapping device /dev/loop1 on session bla, (access_mode: rw, nr_poll_queues: 0)
> [  998.968810] rnbd_client L1213: [session=bla] mapped 8/8 default/read queues.
> [  999.017988] rtrs_client L610: <bla>: RDMA failed: remote access error
> [ 1029.836943] rtrs_client L353: <bla>: Failed IB_WR_LOCAL_INV: WR flushe
>
> Then I tried 5.16 and 5.15 version, seems 5.15 does work as follows.
>
> 1. server side
>
> [  333.076482] rnbd_server L800: </dev/loop1@bla>: Opened device 'loop1'
>
> 2. client side
>
> [ 1584.325825] rnbd_client L596: Mapping device /dev/loop1 on session bla, (access_mode: rw, nr_poll_queues: 0)
> [ 1585.268291] rnbd_client L1213: [session=bla] mapped 8/8 default/read queues.
> [ 1585.349300] rnbd_client L1607: </dev/loop1@bla> map_device: Device mapped as rnbd0 (nsectors: 0, logical_block_size: 512, physical_block_size: 512, max_write_same_sectors: 0, max_discard_sectors: 0, discard_granularity: 0, discard_alignment: 0, secure_discard: 0, max_segments: 128, max_hw_sectors: 248, rotational: 1, wc: 0, fua: 0)
>
> I would appreciate if someone shed light on why it doesn't work after 5.15,
> And I am happy to test potential patch for it.

After investigation, seems the culprit is commit 647bf13ce944 ("RDMA/rxe:
Create duplicate mapping tables for FMRs"). The problem is mr_check_range
returns -EFAULT after find iova and length are not valid, so connection 
between
two VMs can't be established.

Revert the commit manually or apply below temporary change,  rxe works again
with rnbd/rtrs though I don't think it is the right thing to do. Could 
experts provide
a proper solution? Thanks.

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c 
b/drivers/infiniband/sw/rxe/rxe_mr.c
index 453ef3c9d535..4a2fc4d5809d 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -652,7 +652,7 @@ int rxe_reg_fast_mr(struct rxe_qp *qp, struct 
rxe_send_wqe *wqe)
         mr->state = RXE_MR_STATE_VALID;

         set = mr->cur_map_set;
-       mr->cur_map_set = mr->next_map_set;
+       //mr->cur_map_set = mr->next_map_set;
         mr->cur_map_set->iova = wqe->wr.wr.reg.mr->iova;
         mr->next_map_set = set;

@@ -662,7 +662,7 @@ int rxe_reg_fast_mr(struct rxe_qp *qp, struct 
rxe_send_wqe *wqe)
  int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr)
  {
         struct rxe_mr *mr = to_rmr(ibmr);
-       struct rxe_map_set *set = mr->next_map_set;
+       struct rxe_map_set *set = mr->cur_map_set;
         struct rxe_map *map;
         struct rxe_phys_buf *buf;

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c 
b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 80df9a8f71a1..e41d2c8612d8 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -992,7 +992,7 @@ static int rxe_map_mr_sg(struct ib_mr *ibmr, struct 
scatterlist *sg,
                          int sg_nents, unsigned int *sg_offset)
  {
         struct rxe_mr *mr = to_rmr(ibmr);
-       struct rxe_map_set *set = mr->next_map_set;
+       struct rxe_map_set *set = mr->cur_map_set;

And the test is pretty simple.

1.  VM (server)

modprobe rdma_rxe
rdma link add rxe0 type rxe netdev ens3
modprobe rnbd-server

2.  VM (client)

modprobe rdma_rxe
rdma link add rxe0 type rxe netdev ens3
modprobe rnbd-client
echo "sessname=bla path=ip:$serverip 
device_path=$block_device_in_server" > 
/sys/devices/virtual/rnbd-client/ctl/map_device

BTW, I tried wip/jgg-for-next branch with commit 3810c1a1cbe8f.

Guoqing
