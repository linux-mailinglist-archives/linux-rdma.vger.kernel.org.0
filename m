Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEED6C3E4D
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Mar 2023 00:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjCUXLj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Mar 2023 19:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCUXLj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Mar 2023 19:11:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5427591C0;
        Tue, 21 Mar 2023 16:11:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EA7361ECC;
        Tue, 21 Mar 2023 23:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFDCC433EF;
        Tue, 21 Mar 2023 23:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679440296;
        bh=tDiICHqkPMBPN9OVtC1mzD4rYR11CDpxr5L1uilFt+U=;
        h=Date:From:To:Cc:Subject:From;
        b=SvwiwnJ14sUZ+r7kQDZRcJoQyhP263E3Flb5/TxoU76vFOpwDeA2m2z1FwV2VvVzv
         9Zbdfmsz8mUHHogfBOBo22vjSKDsQGd5gfhSyWjvYfjbFlpnidlmQwpFOaIV+NCmEh
         tgCyRqJmdNy3l+M/XkLoXW6TSVGMUMCYiv9TugKIgaaXCCF5jJDW6XyMaU/oCTV43m
         qrjMu+TBg9FXu31qpQSAgKImKb2IMkk0JbpvyLmhWibYQ3kHdDoEmoogc6FjboSfN0
         1WIn/CZCARXa1rjXIwkOowMNxcXSkii8+UFSEPhQ01uYgNcf6fmj/oZ7XdX828i880
         q/jR6FqyjmBQg==
Date:   Tue, 21 Mar 2023 17:12:07 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] RDMA/core: Fix multiple -Warray-bounds warnings
Message-ID: <ZBo5x5e7B25hHr4F@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

GCC-13 (and Clang)[1] does not like to access a partially allocated
object, since it cannot reason about it for bounds checking.

In this case 140 bytes are allocated for an object of type struct
ib_umad_packet:

        packet = kzalloc(sizeof(*packet) + IB_MGMT_RMPP_HDR, GFP_KERNEL);

However, notice that sizeof(*packet) is only 104 bytes:

struct ib_umad_packet {
        struct ib_mad_send_buf *   msg;                  /*     0     8 */
        struct ib_mad_recv_wc *    recv_wc;              /*     8     8 */
        struct list_head           list;                 /*    16    16 */
        int                        length;               /*    32     4 */

        /* XXX 4 bytes hole, try to pack */

        struct ib_user_mad         mad __attribute__((__aligned__(8))); /*    40    64 */

        /* size: 104, cachelines: 2, members: 5 */
        /* sum members: 100, holes: 1, sum holes: 4 */
        /* forced alignments: 1, forced holes: 1, sum forced holes: 4 */
        /* last cacheline: 40 bytes */
} __attribute__((__aligned__(8)));

and 36 bytes extra bytes are allocated for a flexible-array member in
struct ib_user_mad:

include/rdma/ib_mad.h:
120 enum {
...
123         IB_MGMT_RMPP_HDR = 36,
... }

struct ib_user_mad {
        struct ib_user_mad_hdr     hdr;                  /*     0    64 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        __u64                      data[] __attribute__((__aligned__(8))); /*    64     0 */

        /* size: 64, cachelines: 1, members: 2 */
        /* forced alignments: 1 */
} __attribute__((__aligned__(8)));

So we have sizeof(*packet) + IB_MGMT_RMPP_HDR == 140 bytes

Then the address of the flex-array member (for which only 36 bytes were
allocated) is casted and copied into a pointer to struct ib_rmpp_mad,
which, in turn, is of size 256 bytes:

        rmpp_mad = (struct ib_rmpp_mad *) packet->mad.data;

struct ib_rmpp_mad {
        struct ib_mad_hdr          mad_hdr;              /*     0    24 */
        struct ib_rmpp_hdr         rmpp_hdr;             /*    24    12 */
        u8                         data[220];            /*    36   220 */

        /* size: 256, cachelines: 4, members: 3 */
};

The thing is that those 36 bytes allocated for flex-array member data
in struct ib_user_mad onlly account for the size of both struct ib_mad_hdr
and struct ib_rmpp_hdr, but nothing is left for array u8 data[220].
So, the compiler is legitimately complaining about accessing an object
for which not enough memory was allocated.

Apparently, the only members of struct ib_rmpp_mad that are relevant
(that are actually being used) in function ib_umad_write() are mad_hdr
and rmpp_hdr. So, instead of casting packet->mad.data to (struct ib_rmpp_mad *)
cast it just to the two members for which enough memory was allocated. That's
actually the reason why

        IB_MGMT_RMPP_HDR == sizeof(struct ib_mad_hdr) + sizeof(struct ib_rmpp_hdr) == 36 bytes

Refactor the rest of the code, accordingly.

Fix the following warnings seen under GCC-13 and -Warray-bounds:
drivers/infiniband/core/user_mad.c:564:50: warning: array subscript ‘struct ib_rmpp_mad[0]’ is partly outside array bounds of ‘unsigned char[140]’ [-Warray-bounds=]
drivers/infiniband/core/user_mad.c:566:42: warning: array subscript ‘struct ib_rmpp_mad[0]’ is partly outside array bounds of ‘unsigned char[140]’ [-Warray-bounds=]
drivers/infiniband/core/user_mad.c:618:25: warning: array subscript ‘struct ib_rmpp_mad[0]’ is partly outside array bounds of ‘unsigned char[140]’ [-Warray-bounds=]
drivers/infiniband/core/user_mad.c:622:44: warning: array subscript ‘struct ib_rmpp_mad[0]’ is partly outside array bounds of ‘unsigned char[140]’ [-Warray-bounds=]

Link: https://github.com/KSPP/linux/issues/273
Link: https://godbolt.org/z/oYWaGM4Yb [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/infiniband/core/user_mad.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index f83954180a33..ba847ccf1bf0 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -497,8 +497,9 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
 	struct ib_umad_packet *packet;
 	struct ib_mad_agent *agent;
 	struct rdma_ah_attr ah_attr;
+	struct ib_rmpp_hdr rmpp_hdr;
+	struct ib_mad_hdr mad_hdr;
 	struct ib_ah *ah;
-	struct ib_rmpp_mad *rmpp_mad;
 	__be64 *tid;
 	int ret, data_len, hdr_len, copy_offset, rmpp_active;
 	u8 base_version;
@@ -506,7 +507,7 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
 	if (count < hdr_size(file) + IB_MGMT_RMPP_HDR)
 		return -EINVAL;
 
-	packet = kzalloc(sizeof *packet + IB_MGMT_RMPP_HDR, GFP_KERNEL);
+	packet = kzalloc(sizeof(*packet) + IB_MGMT_RMPP_HDR, GFP_KERNEL);
 	if (!packet)
 		return -ENOMEM;
 
@@ -560,13 +561,14 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
 		goto err_up;
 	}
 
-	rmpp_mad = (struct ib_rmpp_mad *) packet->mad.data;
-	hdr_len = ib_get_mad_data_offset(rmpp_mad->mad_hdr.mgmt_class);
+	mad_hdr = *(struct ib_mad_hdr *)packet->mad.data;
+	rmpp_hdr = *(struct ib_rmpp_hdr *)((u8 *)packet->mad.data + sizeof(struct ib_mad_hdr));
+	hdr_len = ib_get_mad_data_offset(mad_hdr.mgmt_class);
 
-	if (ib_is_mad_class_rmpp(rmpp_mad->mad_hdr.mgmt_class)
+	if (ib_is_mad_class_rmpp(mad_hdr.mgmt_class)
 	    && ib_mad_kernel_rmpp_agent(agent)) {
 		copy_offset = IB_MGMT_RMPP_HDR;
-		rmpp_active = ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr) &
+		rmpp_active = ib_get_rmpp_flags(&rmpp_hdr) &
 						IB_MGMT_RMPP_FLAG_ACTIVE;
 	} else {
 		copy_offset = IB_MGMT_MAD_HDR;
@@ -615,12 +617,12 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
 		tid = &((struct ib_mad_hdr *) packet->msg->mad)->tid;
 		*tid = cpu_to_be64(((u64) agent->hi_tid) << 32 |
 				   (be64_to_cpup(tid) & 0xffffffff));
-		rmpp_mad->mad_hdr.tid = *tid;
+		mad_hdr.tid = *tid;
 	}
 
 	if (!ib_mad_kernel_rmpp_agent(agent)
-	   && ib_is_mad_class_rmpp(rmpp_mad->mad_hdr.mgmt_class)
-	   && (ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr) & IB_MGMT_RMPP_FLAG_ACTIVE)) {
+	    && ib_is_mad_class_rmpp(mad_hdr.mgmt_class)
+	    && (ib_get_rmpp_flags(&rmpp_hdr) & IB_MGMT_RMPP_FLAG_ACTIVE)) {
 		spin_lock_irq(&file->send_lock);
 		list_add_tail(&packet->list, &file->send_list);
 		spin_unlock_irq(&file->send_lock);
-- 
2.34.1

