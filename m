Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45AB1EE775
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2020 17:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgFDPO3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jun 2020 11:14:29 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:41805 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbgFDPO3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jun 2020 11:14:29 -0400
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 054FDhgl009658;
        Thu, 4 Jun 2020 08:13:49 -0700
Date:   Thu, 4 Jun 2020 20:43:42 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Max Gurtovoy <maxg@mellanox.com>, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>
Subject: Re: iSERT completions hung due to unavailable iscsit tag
Message-ID: <20200604151341.GA20246@chelsio.com>
References: <20200601134637.GA17657@chelsio.com>
 <d316fdb7-4676-0bb9-c208-b06e43d46534@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d316fdb7-4676-0bb9-c208-b06e43d46534@grimberg.me>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wednesday, June 06/03/20, 2020 at 13:27:29 -0700, Sagi Grimberg wrote:
> 
> >Hi,
> >
> >I observe, iscsit_allocate_cmd() process waiting indefinitely for
> >'iscsit tag' to become available.
> >
> >Here is the scenario:
> >- at initiator, run "iozone -i 0 -I -+d -s 100000 -r 16384 -w" in an
> >   infinite loop.
> >- after few seconds, target fails to obtain 'tag' from
> >   sbitmap_queue_get(), while processing ISCSI_CTRL PDU via
> >isert_recv_done().
> >- then iscsit waits there for tag to become available, by calling
> >   schedule() in iscsit_wait_for_tag()
> >- and the process never scheduled back again, not sure why.
> 
> The trace shows only the failed login attempt that
> happened probably after what you are talking about.
> 
> Do you have a trace that shows your analysis?
> 
> >Due to this blockage the whole completion logic at iSER target went to
> >grinding halt, causing NOPOUT request timeouts at initator, and below
> >hung traces at target. Is this a known issue?
> 
> No, its not a known issue.
> 
> I was not able to reproduce it on my VM with siw...
Hi Sagi,

Thanks for looking into this issue.

I don't think this issue could be recreated easily with SIW driver, as
SIW may not pump enough traffic to exhaust the tags at iscsit. iw_cxgb4
helps recreate this issue quickly.

I have changed iscsit driver to recreate this issue quickly, over SIW.
Not sure the change is valid or not, but this recreates the exact issue.

diff --git a/drivers/target/iscsi/iscsi_target_nego.c
b/drivers/target/iscsi/iscsi_target_nego.c
index 685d771..b278702 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -1255,8 +1255,8 @@ int iscsi_target_locate_portal(
         * in per-cpu-ida tag allocation logic + small queue_depth.
         */
 alloc_tags:
-       tag_num = max_t(u32, ISCSIT_MIN_TAGS, queue_depth);
-       tag_num = (tag_num * 2) + ISCSIT_EXTRA_TAGS;
+       tag_num = 0x20; //hack to exhaust Tags quickly
        tag_size = sizeof(struct iscsi_cmd) +
conn->conn_transport->priv_size;

        ret = transport_alloc_session_tags(sess->se_sess, tag_num,
tag_size);

Run command iozone -i 0 -I -+d -s 90000 -r 16384 -w  (you may give
higher size for "-s" if are not able to recreate the issue)
====================================================
[  +0.000001] isert: isert_recv_done: DMA: 0xffff92c16e439000, iSCSI
opcode: 0x01, ITT: 0x0000001d, flags: 0xa1 dlen: 8192
[  +0.000001] isert: isert_recv_done: ISER_WSV: write_stag: 0xffeadf11
write_va: 0xffff8d2415f68000
[  +0.000001] isert: isert_recv_done: ISER ISCSI_CTRL PDU
[  +0.000050] isert: isert_handle_scsi_cmd: Copy Immediate sg_nents: 2
imm_data_len: 8192
[  +0.000001] isert: isert_get_dataout: Cmd: 00000000824d7bc3 RDMA_READ
data_length: 524288 write_data_done: 8192
[  +0.000007] isert: isert_get_dataout: Cmd: 00000000824d7bc3 posted
RDMA_READ memory for ISER Data WRITE rc: 0
[  +0.000001] isert: isert_recv_done: DMA: 0xffff92c16e43f000, iSCSI
opcode: 0x01, ITT: 0x00000020, flags: 0xa1 dlen: 8192
[  +0.000001] isert: isert_recv_done: ISER_WSV: write_stag: 0xf79eba11
write_va: 0xffff8d2415fe8000
[  +0.000001] isert: isert_recv_done: ISER ISCSI_CTRL PDU
[  +0.000052] isert: isert_handle_scsi_cmd: Copy Immediate sg_nents: 2
imm_data_len: 8192
[  +0.000001] isert: isert_get_dataout: Cmd: 00000000b66c6a25 RDMA_READ
data_length: 524288 write_data_done: 8192
[  +0.000007] isert: isert_get_dataout: Cmd: 00000000b66c6a25 posted
RDMA_READ memory for ISER Data WRITE rc: 0
[  +0.000001] isert: isert_recv_done: DMA: 0xffff92c16e445000, iSCSI
opcode: 0x01, ITT: 0x00000021, flags: 0xa1 dlen: 8192
[  +0.000001] isert: isert_recv_done: ISER_WSV: write_stag: 0x949a4409
write_va: 0xffff8d2416468000
[  +0.000000] isert: isert_recv_done: ISER ISCSI_CTRL PDU
[  +0.000029] isert: isert_handle_scsi_cmd: Copy Immediate sg_nents: 2
imm_data_len: 8192
[  +0.000001] isert: isert_get_dataout: Cmd: 00000000186b1279 RDMA_READ
data_length: 249856 write_data_done: 8192
[  +0.000006] isert: isert_get_dataout: Cmd: 00000000186b1279 posted
RDMA_READ memory for ISER Data WRITE rc: 0
[  +0.000001] isert: isert_recv_done: DMA: 0xffff92c16e44e000, iSCSI
opcode: 0x01, ITT: 0x00000022, flags: 0xa1 dlen: 8192
[  +0.000001] isert: isert_recv_done: ISER_WSV: write_stag: 0x59fb5612
write_va: 0xffff8d24164a5000
[  +0.000001] isert: isert_recv_done: ISER ISCSI_CTRL PDU
[  +0.000032] isert: isert_handle_scsi_cmd: Copy Immediate sg_nents: 2
imm_data_len: 8192
[  +0.000001] isert: isert_get_dataout: Cmd: 00000000ffcf6232 RDMA_READ
data_length: 274432 write_data_done: 8192
[  +0.000005] isert: isert_get_dataout: Cmd: 00000000ffcf6232 posted
RDMA_READ memory for ISER Data WRITE rc: 0
[  +0.000002] isert: isert_recv_done: DMA: 0xffff92c16e451000, iSCSI
opcode: 0x01, ITT: 0x00000023, flags: 0xa1 dlen: 8192
[  +0.000000] isert: isert_recv_done: ISER_WSV: write_stag: 0x6f90e912
write_va: 0xffff8d24164e8000
[  +0.000001] isert: isert_recv_done: ISER ISCSI_CTRL PDU
[  +0.000051] isert: isert_handle_scsi_cmd: Copy Immediate sg_nents: 2
imm_data_len: 8192
[  +0.000001] isert: isert_get_dataout: Cmd: 00000000d4a7e7cc RDMA_READ
data_length: 524288 write_data_done: 8192
[  +0.000006] isert: isert_get_dataout: Cmd: 00000000d4a7e7cc posted
RDMA_READ memory for ISER Data WRITE rc: 0
[  +0.000002] isert: isert_recv_done: DMA: 0xffff92c16e454000, iSCSI
opcode: 0x01, ITT: 0x00000024, flags: 0xa1 dlen: 8192
[  +0.000000] isert: isert_recv_done: ISER_WSV: write_stag: 0x47454916
write_va: 0xffff8d2416568000
[  +0.000001] isert: isert_recv_done: ISER ISCSI_CTRL PDU
[  +0.000051] isert: isert_handle_scsi_cmd: Copy Immediate sg_nents: 2
imm_data_len: 8192
[  +0.000001] isert: isert_get_dataout: Cmd: 0000000018f430df RDMA_READ
data_length: 524288 write_data_done: 8192
[  +0.000009] isert: isert_get_dataout: Cmd: 0000000018f430df posted
RDMA_READ memory for ISER Data WRITE rc: 0
[  +0.000002] isert: isert_rdma_read_done: Cmd 00000000c9c773ad
[  +0.000004] isert: isert_rdma_read_done: Cmd: 00000000c9c773ad
RDMA_READ comp calling execute_cmd
[  +0.000065] isert: isert_rdma_read_done: Cmd 00000000e7b453b8
[  +0.000003] isert: isert_rdma_read_done: Cmd: 00000000e7b453b8
RDMA_READ comp calling execute_cmd
[  +0.000118] isert: isert_rdma_read_done: Cmd 000000002c56d447
[  +0.000003] isert: isert_rdma_read_done: Cmd: 000000002c56d447
RDMA_READ comp calling execute_cmd
[  +0.000067] isert: isert_rdma_read_done: Cmd 0000000081befe9b
[  +0.000004] isert: isert_rdma_read_done: Cmd: 0000000081befe9b
RDMA_READ comp calling execute_cmd
[  +0.000070] isert: isert_rdma_read_done: Cmd 000000003d4991f1
[  +0.000004] isert: isert_rdma_read_done: Cmd: 000000003d4991f1
RDMA_READ comp calling execute_cmd
[  +0.000137] isert: isert_rdma_read_done: Cmd 00000000d57c68cc
[  +0.000004] isert: isert_rdma_read_done: Cmd: 00000000d57c68cc
RDMA_READ comp calling execute_cmd
[  +0.000154] isert: isert_rdma_read_done: Cmd 00000000622c2213
[  +0.000003] isert: isert_rdma_read_done: Cmd: 00000000622c2213
RDMA_READ comp calling execute_cmd
[  +0.000131] isert: isert_rdma_read_done: Cmd 000000009b2a9991
[  +0.000005] isert: isert_rdma_read_done: Cmd: 000000009b2a9991
RDMA_READ comp calling execute_cmd
[  +0.000064] isert: isert_rdma_read_done: Cmd 000000006277fe2f
[  +0.000002] isert: isert_rdma_read_done: Cmd: 000000006277fe2f
RDMA_READ comp calling execute_cmd
[  +0.000071] isert: isert_rdma_read_done: Cmd 00000000ba675bdd
[  +0.000004] isert: isert_rdma_read_done: Cmd: 00000000ba675bdd
RDMA_READ comp calling execute_cmd
[  +0.000138] isert: isert_rdma_read_done: Cmd 00000000b84dc06f
[  +0.000003] isert: isert_rdma_read_done: Cmd: 00000000b84dc06f
RDMA_READ comp calling execute_cmd
[  +0.000134] isert: isert_rdma_read_done: Cmd 00000000b455581f
[  +0.000003] isert: isert_rdma_read_done: Cmd: 00000000b455581f
RDMA_READ comp calling execute_cmd
[  +0.000139] isert: isert_rdma_read_done: Cmd 000000003c6cd07a
[  +0.000003] isert: isert_rdma_read_done: Cmd: 000000003c6cd07a
RDMA_READ comp calling execute_cmd
[  +0.000064] isert: isert_rdma_read_done: Cmd 000000007546787d
[  +0.000003] isert: isert_rdma_read_done: Cmd: 000000007546787d
RDMA_READ comp calling execute_cmd
[  +0.000072] isert: isert_rdma_read_done: Cmd 00000000b7b67720
[  +0.000003] isert: isert_rdma_read_done: Cmd: 00000000b7b67720
RDMA_READ comp calling execute_cmd
[  +0.000131] isert: isert_rdma_read_done: Cmd 00000000163352e9
[  +0.000003] isert: isert_rdma_read_done: Cmd: 00000000163352e9
RDMA_READ comp calling execute_cmd
[  +0.000138] isert: isert_rdma_read_done: Cmd 0000000068f2a18e
[  +0.000002] isert: isert_rdma_read_done: Cmd: 0000000068f2a18e
RDMA_READ comp calling execute_cmd
[  +0.000113] isert: isert_rdma_read_done: Cmd 00000000a73411ac
[  +0.000003] isert: isert_rdma_read_done: Cmd: 00000000a73411ac
RDMA_READ comp calling execute_cmd
[  +0.000118] isert: __isert_create_send_desc: tx_desc 00000000cb753dbc
lkey mismatch, fixing
[  +0.000002] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb68a20 length: 76 lkey: 0x1936400
[  +0.000002] isert: isert_put_response: Posting SCSI Response
[  +0.000005] isert: __isert_create_send_desc: tx_desc 0000000076ae6083
lkey mismatch, fixing
[  +0.000001] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb69030 length: 76 lkey: 0x1936400
[  +0.000001] isert: isert_put_response: Posting SCSI Response
[  +0.000002] isert: __isert_create_send_desc: tx_desc 0000000000df1306
lkey mismatch, fixing
[  +0.000001] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb665c0 length: 76 lkey: 0x1936400
[  +0.000002] isert: isert_put_response: Posting SCSI Response
[  +0.000003] isert: __isert_create_send_desc: tx_desc 00000000c1fc9644
lkey mismatch, fixing
[  +0.000001] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb66bd0 length: 76 lkey: 0x1936400
[  +0.000001] isert: isert_put_response: Posting SCSI Response
[  +0.000002] isert: __isert_create_send_desc: tx_desc 00000000a5972477
lkey mismatch, fixing
[  +0.000001] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb671e0 length: 76 lkey: 0x1936400
[  +0.000001] isert: isert_put_response: Posting SCSI Response
[  +0.000002] isert: __isert_create_send_desc: tx_desc 00000000ff9f1de4
lkey mismatch, fixing
[  +0.000001] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb677f0 length: 76 lkey: 0x1936400
[  +0.000001] isert: isert_put_response: Posting SCSI Response
[  +0.000002] isert: __isert_create_send_desc: tx_desc 00000000d88a86a9
lkey mismatch, fixing
[  +0.000001] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb67e00 length: 76 lkey: 0x1936400
[  +0.000001] isert: isert_put_response: Posting SCSI Response
[  +0.000002] isert: __isert_create_send_desc: tx_desc 000000004552b346
lkey mismatch, fixing
[  +0.000002] isert: isert_send_done: Cmd 0000000036f41ece
[  +0.000001] isert: isert_unmap_tx_desc: unmap single for
tx_desc->dma_addr
[  +0.000001] isert: isert_put_cmd: Cmd 0000000036f41ece
[  +0.000002] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb68410 length: 76 lkey: 0x1936400
[  +0.000001] isert: isert_put_response: Posting SCSI Response
[  +0.000001] isert: __isert_create_send_desc: tx_desc 00000000c6a54549
lkey mismatch, fixing
[  +0.000002] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb69640 length: 76 lkey: 0x1936400
[  +0.000001] isert: isert_put_response: Posting SCSI Response
[  +0.000001] isert: __isert_create_send_desc: tx_desc 00000000fa96828a
lkey mismatch, fixing
[  +0.000002] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb69c50 length: 76 lkey: 0x1936400
[  +0.000000] isert: isert_put_response: Posting SCSI Response
[  +0.000002] isert: __isert_create_send_desc: tx_desc 00000000b192faa5
lkey mismatch, fixing
[  +0.000001] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb6a260 length: 76 lkey: 0x1936400
[  +0.000001] isert: isert_put_response: Posting SCSI Response
[  +0.000002] isert: __isert_create_send_desc: tx_desc 000000003cdfdcda
lkey mismatch, fixing
[  +0.000001] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb6a870 length: 76 lkey: 0x1936400
[  +0.000001] isert: isert_put_response: Posting SCSI Response
[  +0.000002] isert: __isert_create_send_desc: tx_desc 000000000d8c8e53
lkey mismatch, fixing
[  +0.000001] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb6ae80 length: 76 lkey: 0x1936400
[  +0.000001] isert: isert_put_response: Posting SCSI Response
[  +0.000001] isert: isert_send_done: Cmd 0000000068c68afd
[  +0.000001] isert: __isert_create_send_desc: tx_desc 000000002bae438e
lkey mismatch, fixing
[  +0.000001] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb6b490 length: 76 lkey: 0x1936400
[  +0.000001] isert: isert_put_response: Posting SCSI Response
[  +0.000001] isert: isert_unmap_tx_desc: unmap single for
tx_desc->dma_addr
[  +0.000001] isert: __isert_create_send_desc: tx_desc 000000007a2e2413
lkey mismatch, fixing
[  +0.000001] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb6baa0 length: 76 lkey: 0x1936400
[  +0.000001] isert: isert_put_response: Posting SCSI Response
[  +0.000001] isert: isert_put_cmd: Cmd 0000000068c68afd
[  +0.000001] isert: __isert_create_send_desc: tx_desc 0000000010cdeb9f
lkey mismatch, fixing
[  +0.000001] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb6c0b0 length: 76 lkey: 0x1936400
[  +0.000002] isert: isert_put_response: Posting SCSI Response
[  +0.000002] isert: __isert_create_send_desc: tx_desc 00000000d2df7ba7
lkey mismatch, fixing
[  +0.000001] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb604c0 length: 76 lkey: 0x1936400
[  +0.000001] isert: isert_put_response: Posting SCSI Response
[  +0.000001] isert: __isert_create_send_desc: tx_desc 000000006a9e303e
lkey mismatch, fixing
[  +0.000002] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb60ad0 length: 76 lkey: 0x1936400
[  +0.000001] isert: isert_put_response: Posting SCSI Response
[  +0.000002] isert: __isert_create_send_desc: tx_desc 00000000f312b66f
lkey mismatch, fixing
[  +0.000001] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb610e0 length: 76 lkey: 0x1936400
[  +0.000001] isert: isert_put_response: Posting SCSI Response
[  +0.000001] isert: __isert_create_send_desc: tx_desc 0000000092478beb
lkey mismatch, fixing
[  +0.000002] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb616f0 length: 76 lkey: 0x1936400
[  +0.000000] isert: isert_put_response: Posting SCSI Response
[  +0.000002] isert: __isert_create_send_desc: tx_desc 000000007795779b
lkey mismatch, fixing
[  +0.000001] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb61d00 length: 76 lkey: 0x1936400
[  +0.000001] isert: isert_put_response: Posting SCSI Response
[  +0.000335] isert: isert_rdma_read_done: Cmd 0000000084fba6ef
[  +0.000004] isert: isert_rdma_read_done: Cmd: 0000000084fba6ef
RDMA_READ comp calling execute_cmd
[  +0.000091] isert: __isert_create_send_desc: tx_desc 000000007dd73789
lkey mismatch, fixing
[  +0.000001] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb62310 length: 76 lkey: 0x1936400
[  +0.000001] isert: isert_put_response: Posting SCSI Response
[  +0.000220] isert: isert_rdma_read_done: Cmd 00000000202070d9
[  +0.000004] isert: isert_rdma_read_done: Cmd: 00000000202070d9
RDMA_READ comp calling execute_cmd
[  +0.000086] isert: __isert_create_send_desc: tx_desc 00000000a860fa0f
lkey mismatch, fixing
[  +0.000002] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb62920 length: 76 lkey: 0x1936400
[  +0.000002] isert: isert_put_response: Posting SCSI Response
[  +0.000205] isert: isert_rdma_read_done: Cmd 000000001b611453
[  +0.000005] isert: isert_rdma_read_done: Cmd: 000000001b611453
RDMA_READ comp calling execute_cmd
[  +0.000085] isert: __isert_create_send_desc: tx_desc 00000000578e552f
lkey mismatch, fixing
[  +0.000002] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb62f30 length: 76 lkey: 0x1936400
[  +0.000001] isert: isert_put_response: Posting SCSI Response
[  +0.000196] isert: isert_rdma_read_done: Cmd 000000002de94d9d
[  +0.000003] isert: isert_rdma_read_done: Cmd: 000000002de94d9d
RDMA_READ comp calling execute_cmd
[  +0.000074] isert: __isert_create_send_desc: tx_desc 00000000594dc732
lkey mismatch, fixing
[  +0.000001] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb63540 length: 76 lkey: 0x1936400
[  +0.000001] isert: isert_put_response: Posting SCSI Response
[  +0.000161] isert: isert_rdma_read_done: Cmd 000000009d010ac4
[  +0.000003] isert: isert_rdma_read_done: Cmd: 000000009d010ac4
RDMA_READ comp calling execute_cmd
[  +0.000075] isert: __isert_create_send_desc: tx_desc 00000000f5e0992e
lkey mismatch, fixing
[  +0.000001] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb63b50 length: 76 lkey: 0x1936400
[  +0.000001] isert: isert_put_response: Posting SCSI Response
[  +0.000147] isert: isert_rdma_read_done: Cmd 00000000824d7bc3
[  +0.000005] isert: isert_rdma_read_done: Cmd: 00000000824d7bc3
RDMA_READ comp calling execute_cmd
[  +0.000075] isert: __isert_create_send_desc: tx_desc 000000007a0c4472
lkey mismatch, fixing
[  +0.000001] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb64160 length: 76 lkey: 0x1936400
[  +0.000000] isert: isert_put_response: Posting SCSI Response
[  +0.000182] isert: isert_rdma_read_done: Cmd 00000000b66c6a25
[  +0.000003] isert: isert_rdma_read_done: Cmd: 00000000b66c6a25
RDMA_READ comp calling execute_cmd
[  +0.000074] isert: __isert_create_send_desc: tx_desc 000000008408d294
lkey mismatch, fixing
[  +0.000001] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb64770 length: 76 lkey: 0x1936400
[  +0.000001] isert: isert_put_response: Posting SCSI Response
[  +0.000068] isert: isert_rdma_read_done: Cmd 00000000186b1279
[  +0.000005] isert: isert_rdma_read_done: Cmd: 00000000186b1279
RDMA_READ comp calling execute_cmd
[  +0.000043] isert: __isert_create_send_desc: tx_desc 00000000d771cd58
lkey mismatch, fixing
[  +0.000001] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb64d80 length: 76 lkey: 0x1936400
[  +0.000001] isert: isert_put_response: Posting SCSI Response
[  +0.000111] isert: isert_rdma_read_done: Cmd 00000000ffcf6232
[  +0.000005] isert: isert_rdma_read_done: Cmd: 00000000ffcf6232
RDMA_READ comp calling execute_cmd
[  +0.000047] isert: __isert_create_send_desc: tx_desc 00000000e68d6957
lkey mismatch, fixing
[  +0.000002] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb65390 length: 76 lkey: 0x1936400
[  +0.000002] isert: isert_put_response: Posting SCSI Response
[  +0.000145] isert: isert_rdma_read_done: Cmd 00000000d4a7e7cc
[  +0.000004] isert: isert_rdma_read_done: Cmd: 00000000d4a7e7cc
RDMA_READ comp calling execute_cmd
[  +0.000082] isert: __isert_create_send_desc: tx_desc 000000001a916153
lkey mismatch, fixing
[  +0.000001] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb659a0 length: 76 lkey: 0x1936400
[  +0.000001] isert: isert_put_response: Posting SCSI Response
[  +0.000158] isert: isert_rdma_read_done: Cmd 0000000018f430df
[  +0.000003] isert: isert_rdma_read_done: Cmd: 0000000018f430df
RDMA_READ comp calling execute_cmd
[  +0.000074] isert: isert_recv_done: DMA: 0xffff92c16e457000, iSCSI
opcode: 0x01, ITT: 0x00000025, flags: 0xa1 dlen: 8192
[  +0.000001] isert: isert_recv_done: ISER_WSV: write_stag: 0x7c097f0f
write_va: 0xffff8d24165e8000
[  +0.000000] isert: isert_recv_done: ISER ISCSI_CTRL PDU
[  +0.000074] isert: isert_handle_scsi_cmd: Copy Immediate sg_nents: 2
imm_data_len: 8192
[  +0.000002] isert: isert_get_dataout: Cmd: 0000000036f41ece RDMA_READ
data_length: 524288 write_data_done: 8192
[  +0.000010] isert: isert_get_dataout: Cmd: 0000000036f41ece posted
RDMA_READ memory for ISER Data WRITE rc: 0
[  +0.000001] isert: isert_recv_done: DMA: 0xffff92c16e45a000, iSCSI
opcode: 0x01, ITT: 0x00000028, flags: 0xa1 dlen: 8192
[  +0.000001] isert: isert_recv_done: ISER_WSV: write_stag: 0x56b6ec0f
write_va: 0xffff8d2416668000
[  +0.000000] isert: isert_recv_done: ISER ISCSI_CTRL PDU
[  +0.000060] isert: isert_handle_scsi_cmd: Copy Immediate sg_nents: 2
imm_data_len: 8192
[  +0.000001] isert: isert_get_dataout: Cmd: 0000000068c68afd RDMA_READ
data_length: 524288 write_data_done: 8192
[  +0.000006] isert: isert_get_dataout: Cmd: 0000000068c68afd posted
RDMA_READ memory for ISER Data WRITE rc: 0
[  +0.000001] isert: isert_recv_done: DMA: 0xffff92c16e45d000, iSCSI
opcode: 0x01, ITT: 0x00000027, flags: 0xa1 dlen: 8192
[  +0.000001] isert: isert_recv_done: ISER_WSV: write_stag: 0xce2c20d1
write_va: 0xffff8d24166e8000


[  +0.000000] isert: isert_recv_done: ISER ISCSI_CTRL PDU ======> Hungs
at: recv_done()->iscsit_allocate_cmd()->schedule()


[  +0.000002] isert: __isert_create_send_desc: tx_desc 00000000a7c56808
lkey mismatch, fixing
[  +0.000001] isert: isert_init_tx_hdrs: Setup tx_sg[0].addr:
0xffff92c16eb65fb0 length: 76 lkey: 0x1936400
[  +0.000000] isert: isert_put_response: Posting SCSI Response
[ +10.224473] isert: isert_cma_handler: disconnected (10): status 0 id
00000000403c8045 np 00000000211da644
[  +0.000074] isert: isert_wait_conn: Starting conn 00000000a904f010
[  +0.000003] isert: isert_conn_terminate: Terminating conn
00000000a904f010 state 3
[  +2.008824] isert: isert_cma_handler: connect request (4): status 0 id
00000000e8b2a094 np 00000000211da644
[  +0.000002] isert: isert_connect_request: cma_id: 00000000e8b2a094,
portal: 00000000211da644
[  +0.000019] isert: isert_device_get: Found iser device
000000008276e2fd refcount 2
[  +0.000001] isert: isert_set_nego_params: Using initiator_depth: 128
[  +0.000000] isert: isert_set_nego_params: Using remote invalidation
[  +0.000001] isert: isert_comp_get: conn 00000000ee44cd70, using comp
000000006050e4e6 min_index: 1
[  +0.001285] isert: isert_login_post_recv: Setup sge: addr:
ffff92c1c3158000 length: 8268 0x01936400
[  +0.000075] isert: isert_cma_handler: established (9): status 0 id
00000000e8b2a094 np 00000000211da644
[  +0.000001] isert: isert_connected_handler: conn 00000000ee44cd70
[  +0.000001] isert: isert_connected_handler: np 00000000211da644: Allow
accept_np to continue
[  +0.000006] isert: isert_accept_np: Processing isert_conn:
00000000ee44cd70
[  +0.000019] isert: isert_get_login_rx: before login_req comp conn:
00000000ee44cd70
[  +0.999451] isert: isert_rx_login_req: conn 00000000ee44cd70
[  +0.000005] isert: isert_rx_login_req: Using login payload size: 488,
rx_buflen: 488 MAX_KEY_VALUE_PAIRS: 8192
[  +0.000003] isert: isert_get_login_rx: before login_comp conn:
0000000023ea8fab
[  +0.000002] isert: isert_get_login_rx: processing login->req:
000000008556731b
[  +0.000068] isert: isert_get_sup_prot_ops: conn 00000000ee44cd70 PI
offload disabled
[ +13.997880] isert: isert_cma_handler: disconnected (10): status 0 id
00000000e8b2a094 np 00000000211da644
[  +0.183884] iSCSI Login timeout on Network Portal 102.1.1.4:3261

> 
> 
> >Target:
> >[May 7 20:30] iSCSI Login timeout on Network Portal 102.1.1.6:3260
> >[May 7 20:33] kworker/dying (2185) used greatest stack depth: 11672
> >bytes left
> >[  +2.640115] kmemleak: 2 new suspected memory leaks (see
> >/sys/kernel/debug/kmemleak)
> 
> Can you output what kmemleak complains about?
I think, I got this memory leak with older kernels, sorry I did not
saved it.
Anyways, with latest kernels I don't see this memory leak. so you may
ignore this leak.
> 
> >[ +26.031050] INFO: task iscsi_np:8387 blocked for more than 122
> >seconds.
> >[  +0.000004]       Not tainted 5.7.0-rc2+ #2
> >[  +0.000001] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> >disables this message.
> >[  +0.000001] iscsi_np        D14304  8387      2 0x80004084
> >[  +0.000005] Call Trace:
> >[  +0.000008]  ? __schedule+0x274/0x5e0
> >[  +0.000003]  ? stack_trace_save+0x46/0x70
> >[  +0.000002]  schedule+0x45/0xb0
> >[  +0.000002]  schedule_timeout+0x1d6/0x290
> >[  +0.000001]  wait_for_completion+0x82/0xe0
> >[  +0.000007]  iscsi_check_for_session_reinstatement+0x205/0x260
> >[iscsi_target_mod]
> >[  +0.000004]  iscsi_target_do_login+0xe3/0x5c0 [iscsi_target_mod]
> >[  +0.000004]  iscsi_target_start_negotiation+0x4c/0xa0
> >[iscsi_target_mod]
> >[  +0.000004]  iscsi_target_login_thread+0x86f/0x1000 [iscsi_target_mod]
> >[  +0.000003]  kthread+0xf3/0x130
> >[  +0.000004]  ? iscsi_target_login_sess_out+0x1f0/0x1f0
> >[iscsi_target_mod]
> >[  +0.000001]  ? kthread_bind+0x10/0x10
> >[  +0.000002]  ret_from_fork+0x35/0x40
> >[  +0.000003] INFO: task iscsi_ttx:8863 blocked for more than 122
> >seconds.
> >[  +0.000001]       Not tainted 5.7.0-rc2+ #2
> >[  +0.000000] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> >disables this message.
> >[  +0.000001] iscsi_ttx       D14384  8863      2 0x80004084
> >[  +0.000003] Call Trace:
> >[  +0.000002]  ? __schedule+0x274/0x5e0
> >[  +0.000004]  ? c4iw_ib_modify_qp+0xf3/0x160 [iw_cxgb4]
> >[  +0.000002]  schedule+0x45/0xb0
> >[  +0.000002]  schedule_timeout+0x1d6/0x290
> >[  +0.000001]  wait_for_completion+0x82/0xe0
> >[  +0.000003]  __ib_drain_sq+0x147/0x170
> >[  +0.000002]  ? ib_sg_to_pages+0x1a0/0x1a0
> >[  +0.000003]  ib_drain_sq+0x6e/0x80
> >[  +0.000002]  ib_drain_qp+0x9/0x20
> >[  +0.000002]  isert_wait_conn+0x51/0x2c0 [ib_isert]
> >[  +0.000004]  iscsit_close_connection+0x14c/0x840 [iscsi_target_mod]
> >[  +0.000002]  ? __schedule+0x27c/0x5e0
> >[  +0.000004]  iscsit_take_action_for_connection_exit+0x79/0x100
> >[iscsi_target_mod]
> >[  +0.000003]  iscsi_target_tx_thread+0x160/0x200 [iscsi_target_mod]
> >[  +0.000004]  ? wait_woken+0x80/0x80
> >[  +0.000002]  kthread+0xf3/0x130
> >[  +0.000003]  ? iscsit_thread_get_cpumask+0x80/0x80 [iscsi_target_mod]
> >[  +0.000001]  ? kthread_bind+0x10/0x10
> >[  +0.000001]  ret_from_fork+0x35/0x40
> >[  +0.000003] NMI backtrace for cpu 7
> >[  +0.000002] CPU: 7 PID: 493 Comm: khungtaskd Not tainted 5.7.0-rc2+ #2
> >[  +0.000001] Hardware name: Supermicro X10SRA-F/X10SRA-F, BIOS 2.1a
> >10/24/2018
> >[  +0.000001] Call Trace:
> >[  +0.000003]  dump_stack+0x50/0x6b
> >[  +0.000002]  nmi_cpu_backtrace+0x9e/0xb0
> >[  +0.000003]  ? lapic_can_unplug_cpu+0x90/0x90
> >[  +0.000002]  nmi_trigger_cpumask_backtrace+0x9c/0xf0
> >[  +0.000003]  watchdog+0x310/0x4f0
> >[  +0.000002]  kthread+0xf3/0x130
> >[  +0.000002]  ? hungtask_pm_notify+0x40/0x40
> >[  +0.000001]  ? kthread_bind+0x10/0x10
> >[  +0.000001]  ret_from_fork+0x35/0x40
> >[  +0.000002] Sending NMI from CPU 7 to CPUs 0-6:
> >[  +0.000009] NMI backtrace for cpu 0 skipped: idling at
> >acpi_processor_ffh_cstate_enter+0x6f/0xc0
> >[  +0.000001] NMI backtrace for cpu 4 skipped: idling at
> >acpi_processor_ffh_cstate_enter+0x6f/0xc0
> >[  +0.000002] NMI backtrace for cpu 1 skipped: idling at
> >acpi_processor_ffh_cstate_enter+0x6f/0xc0
> >[  +0.000019] NMI backtrace for cpu 2 skipped: idling at
> >acpi_processor_ffh_cstate_enter+0x6f/0xc0
> >[  +0.000001] NMI backtrace for cpu 6 skipped: idling at
> >acpi_processor_ffh_cstate_enter+0x6f/0xc0
> >[  +0.000010] NMI backtrace for cpu 5
> >[  +0.000000] CPU: 5 PID: 4465 Comm: kworker/5:1H Not tainted 5.7.0-rc2+
> >#2
> >[  +0.000000] Hardware name: Supermicro X10SRA-F/X10SRA-F, BIOS 2.1a
> >10/24/2018
> >[  +0.000001] Workqueue: ib-comp-wq ib_cq_poll_work
> >[  +0.000000] RIP: 0010:__free_pages+0xe/0x60
> >
> >
> >Initiator:
> >[ 2002.689250]  connection5:0: ping timeout of 5 secs expired, recv
> >timeout 5, last rx 4296659424, last ping 4296664448, now 4296669696
> >[ 2002.689275]  connection5:0: detected conn error (1022)
> >
> >
> >
> >Thanks,
> >Krishna.
> >
