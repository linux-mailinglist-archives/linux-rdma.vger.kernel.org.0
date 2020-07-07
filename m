Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7300A2174F2
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 19:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgGGRQt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 13:16:49 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:51343 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgGGRQt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 13:16:49 -0400
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 067HGTlZ008745;
        Tue, 7 Jul 2020 10:16:30 -0700
Date:   Tue, 7 Jul 2020 22:46:29 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        krishna2@chelsio.com
Subject: Re: iSERT SQ overflow with single target and multi luns
Message-ID: <20200707171627.GA2352@chelsio.com>
References: <20200707123641.GA22620@chelsio.com>
 <58258370-dcb2-4745-ec87-8a65b594075d@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58258370-dcb2-4745-ec87-8a65b594075d@mellanox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Max,

Thanks for the quick response!

I just tested your patch, it's working without any issue.


Just for reference, here is what I observed with Chelsio iWARP adapter,
after applying your patch:

attr.cap.max_send_wr = ISERT_QP_MAX_REQ_DTOS:138 +1 + (rdma_ctxs:4096 *
factor:3) = 12427


rdma_ctxs:4096 comes from  ==>
rdma_rw_mr_factor(ISCSI_ISER_MAX_SG_TABLESIZE:4096)=32 *
ISCSI_DEF_XMIT_CMDS_MAX:128     where mr_pages is 128


Finally, 12427 size got capped to 8190 due to "dev->attrs.max_qp_wr" in
rdma_rw_init_qp().

So final value of attr.cap.max_send_wr is 8190 for Chelsio adapters.



Thanks,
Krishna.
On Tuesday, July 07/07/20, 2020 at 16:23:30 +0300, Max Gurtovoy wrote:
> Hi Krishna,
> 
> thanks for debugging this.
> 
> please try the following untested patch:
> 
> 
> diff --git a/drivers/infiniband/ulp/isert/ib_isert.c
> b/drivers/infiniband/ulp/isert/ib_isert.c
> index b7df38e..49f5f05 100644
> --- a/drivers/infiniband/ulp/isert/ib_isert.c
> +++ b/drivers/infiniband/ulp/isert/ib_isert.c
> @@ -119,7 +119,7 @@
>  {
>         struct isert_device *device = isert_conn->device;
>         struct ib_qp_init_attr attr;
> -       int ret;
> +       int ret, factor;
> 
>         memset(&attr, 0, sizeof(struct ib_qp_init_attr));
>         attr.event_handler = isert_qp_event_callback;
> @@ -128,7 +128,9 @@
>         attr.recv_cq = comp->cq;
>         attr.cap.max_send_wr = ISERT_QP_MAX_REQ_DTOS + 1;
>         attr.cap.max_recv_wr = ISERT_QP_MAX_RECV_DTOS + 1;
> -       attr.cap.max_rdma_ctxs = ISCSI_DEF_XMIT_CMDS_MAX;
> +       factor = rdma_rw_mr_factor(device->ib_device, cma_id->port_num,
> +                                  ISCSI_ISER_MAX_SG_TABLESIZE);
> +       attr.cap.max_rdma_ctxs = ISCSI_DEF_XMIT_CMDS_MAX * factor;
>         attr.cap.max_send_sge = device->ib_device->attrs.max_send_sge;
>         attr.cap.max_recv_sge = 1;
>         attr.sq_sig_type = IB_SIGNAL_REQ_WR;
> diff --git a/drivers/infiniband/ulp/isert/ib_isert.h
> b/drivers/infiniband/ulp/isert/ib_isert.h
> index 3b296ba..c9ccf1d 100644
> --- a/drivers/infiniband/ulp/isert/ib_isert.h
> +++ b/drivers/infiniband/ulp/isert/ib_isert.h
> @@ -63,7 +63,8 @@
>                 (ISER_RX_PAYLOAD_SIZE + sizeof(u64) + sizeof(struct
> ib_sge) + \
>                  sizeof(struct ib_cqe) + sizeof(bool)))
> 
> -#define ISCSI_ISER_SG_TABLESIZE                256
> +/* Maximum support is 16MB I/O size */
> +#define ISCSI_ISER_MAX_SG_TABLESIZE    4096
> 
>  enum isert_desc_type {
>         ISCSI_TX_CONTROL,
> 
> 
> On 7/7/2020 3:36 PM, Krishnamraju Eraparaju wrote:
> >Looks like the commit 07173c3e(block: enable multipage bvecs) has
> >uncovered iSER SQ sizing issue.
> >
> >Here is how I hit the issue:
> >Created two luns under single target, then run the below script on each
> >lun(parallelly).
> >
> >   while [ 1 ]
> >   do
> >   iozone -i 0 -i 1 -I -+d -s 100000 -r 16384 -w
> >   done
> >
> >
> >Then failures like below are logged in dmesg output, due to iw_cxgb4 SQ
> >getting full at iSER target.
> >    "isert: isert_rdma_rw_ctx_post: Cmd: 00000000cb75342a failed to post
> >RDMA res"
> >
> >
> >This issue won't occur if luns are created on seperate targets.
> >Also, the issue won't occur if I revert the multipage bvecs(07173c3e)
> >changes at initator.
> >
> >
> >Currently SQ is being sized this way:
> >attr.cap.max_send_wr = ISERT_QP_MAX_REQ_DTOS:138 +1 +
> >(ISCSI_DEF_XMIT_CMDS_MAX:128 * factor:3) = 523.
> >I tried increaseing the SQ size and observed that the issue is not
> >occuring when attr.cap.max_send_wr is 562.
> >
> >
> >Looks like the avg length of RDMA READ/WRITE operations has increased
> >after "multipage bvecs" changes.
> >Queueing many large sized RDMA READ/WRITE WRs may cause backpressure and
> >increases the chances of SQ getting full at provider driver.
> >Notice the length(0x7f000 & 0x2000) of each RDMA READ operation below,
> >for Before and After case.
> >
> >Before "multipage bvecs" RDMA READ:
> >[  +0.001903] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x78]
> >[  +0.000007] iser: iser_fast_reg_mr: lkey=0x8a41 rkey=0x8a41
> >addr=0x446166000 length=0x7f000
> >[  +0.000000] iser: iser_prepare_read_cmd: Cmd itt:120 READ tags
> >RKEY:0X8A41 VA:0X446166000
> >[  +0.000007] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x6f]
> >[  +0.000003] iser: iser_fast_reg_mr: lkey=0x13b51 rkey=0x13b51
> >addr=0x443b25000 length=0x7f000
> >[  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:111 READ tags
> >RKEY:0X13B51 VA:0X443B25000
> >[  +0.000022] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0xe]
> >[  +0.000001] iser: iser_fast_reg_mr: lkey=0xa371 rkey=0xa371
> >addr=0x4461a4000 length=0x2000
> >[  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:14 READ tags
> >RKEY:0XA371 VA:0X4461A4000
> >[  +0.000004] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x79]
> >[  +0.000003] iser: iser_fast_reg_mr: lkey=0x12f4f rkey=0x12f4f
> >addr=0x4461a9000 length=0x7f000
> >[  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:121 READ tags
> >RKEY:0X12F4F VA:0X4461A9000
> >[  +0.000005] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x7d]
> >[  +0.000003] iser: iser_fast_reg_mr: lkey=0xe040 rkey=0xe040
> >addr=0x447e67000 length=0x7f000
> >[  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:125 READ tags
> >RKEY:0XE040 VA:0X447E67000
> >[  +0.000021] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x7b]
> >[  +0.000001] iser: iser_fast_reg_mr: lkey=0xb149 rkey=0xb149
> >addr=0x3d0366000 length=0x2000
> >[  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:123 READ tags
> >RKEY:0XB149 VA:0X3D0366000
> >[  +0.000004] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0xb]
> >[  +0.000003] iser: iser_fast_reg_mr: lkey=0x1014c rkey=0x1014c
> >addr=0x3d0368000 length=0x7f000
> >[  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:11 READ tags
> >RKEY:0X1014C VA:0X3D0368000
> >[  +0.000007] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x62]
> >[  +0.000003] iser: iser_fast_reg_mr: lkey=0x7c3b rkey=0x7c3b
> >addr=0x3d03e7000 length=0x7f000
> >[  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:98 READ tags
> >RKEY:0X7C3B VA:0X3D03E7000
> >[  +0.000021] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x11]
> >[  +0.000001] iser: iser_fast_reg_mr: lkey=0x11752 rkey=0x11752
> >addr=0x3d6de6000 length=0x2000
> >[  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:17 READ tags
> >RKEY:0X11752 VA:0X3D6DE6000
> >[  +0.000004] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x77]
> >
> >
> >After "multipage bvecs" RDMA READ:
> >[  +0.002455] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x7d]
> >[  +0.000006] iser: iser_fast_reg_mr: lkey=0x7991 rkey=0x7991
> >addr=0x3d2819000 length=0x7f000
> >[  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:125 READ tags
> >RKEY:0X7991 VA:0X3D2819000
> >[  +0.000005] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x7e]
> >[  +0.000003] iser: iser_fast_reg_mr: lkey=0x8c9b rkey=0x8c9b
> >addr=0x3d2898000 length=0x7f000
> >[  +0.000000] iser: iser_prepare_read_cmd: Cmd itt:126 READ tags
> >RKEY:0X8C9B VA:0X3D2898000
> >[  +0.000003] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x7f]
> >[  +0.000003] iser: iser_fast_reg_mr: lkey=0x856d rkey=0x856d
> >addr=0x3d2917000 length=0x7f000
> >[  +0.000000] iser: iser_prepare_read_cmd: Cmd itt:127 READ tags
> >RKEY:0X856D VA:0X3D2917000
> >[  +0.000004] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x1]
> >[  +0.000002] iser: iser_fast_reg_mr: lkey=0x9b55 rkey=0x9b55
> >addr=0x3d2999000 length=0x7f000
> >[  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:1 READ tags
> >RKEY:0X9B55 VA:0X3D2999000
> >[  +0.000003] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x2]
> >[  +0.000002] iser: iser_fast_reg_mr: lkey=0x86cf rkey=0x86cf
> >addr=0x3d2018000 length=0x7f000
> >[  +0.000000] iser: iser_prepare_read_cmd: Cmd itt:2 READ tags
> >RKEY:0X86CF VA:0X3D2018000
> >[  +0.000003] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x3]
> >[  +0.000003] iser: iser_fast_reg_mr: lkey=0x8062 rkey=0x8062
> >addr=0x3d2097000 length=0x7f000
> >[  +0.000000] iser: iser_prepare_read_cmd: Cmd itt:3 READ tags
> >RKEY:0X8062 VA:0X3D2097000
> >[  +0.000003] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x4]
> >[  +0.000002] iser: iser_fast_reg_mr: lkey=0xc34b rkey=0xc34b
> >addr=0x3d2116000 length=0x7f000
> >[  +0.000000] iser: iser_prepare_read_cmd: Cmd itt:4 READ tags
> >RKEY:0XC34B VA:0X3D2116000
> >[  +0.000003] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x5]
> >[  +0.000002] iser: iser_fast_reg_mr: lkey=0x8b6d rkey=0x8b6d
> >addr=0x3d2195000 length=0x7f000
> >[  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:5 READ tags
> >RKEY:0X8B6D VA:0X3D2195000
> >[  +0.000003] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x6]
> >[  +0.000002] iser: iser_fast_reg_mr: lkey=0xce56 rkey=0xce56
> >addr=0x3d0e14000 length=0x7f000
> >[  +0.000000] iser: iser_prepare_read_cmd: Cmd itt:6 READ tags
> >RKEY:0XCE56 VA:0X3D0E14000
> >[  +0.000003] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x7]
> >[  +0.000002] iser: iser_fast_reg_mr: lkey=0xba45 rkey=0xba45
> >addr=0x3d0e93000 length=0x7f000
> >[  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:7 READ tags
> >RKEY:0XBA45 VA:0X3D0E93000
> >[  +0.000002] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x8]
> >
> >Hence, I feel iSER target SQ is undersized and needs to be sized
> >properly to hold max possible entries. I might be wrong.
> >
> >Please take a look.
> >
> >Thanks,
> >Krishna.
