Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB70EC17
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2019 23:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfD2VcU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Apr 2019 17:32:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:42152 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729370AbfD2VcT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Apr 2019 17:32:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 14:32:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,411,1549958400"; 
   d="scan'208";a="166053523"
Received: from ssaleem-mobl4.amr.corp.intel.com ([10.122.129.109])
  by fmsmga002.fm.intel.com with ESMTP; 29 Apr 2019 14:32:18 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: [PATCH rdma-next] RDMA/umem: Handle page combining avoidance correctly in ib_umem_add_sg_table()
Date:   Mon, 29 Apr 2019 16:32:04 -0500
Message-Id: <20190429213204.17892-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.8.3
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The flag update_cur_sg tracks whether contiguous pages
from a new set of page_list pages can be merged into the
SGE passed into ib_umem_add_sg_table(). If this flag is true,
but the total segment length exceeds the max_seg_size supported
by HW, we avoid combining to this SGE and move to a new SGE (x)
and merge 'len' pages to it. However, if i < npages, the next
iteration can incorrectly merge 'len' contiguous pages into x
instead of into a new SGE since update_cur_sg is still true.

Reset update_cur_sg to false always after the check to merge
pages into the first SGE passed in to ib_umem_add_sg_table().
Also, prevent a new SGE's segment length from ever exceeding
HW max_seg_sz.

There is a crash on hfi1 as result of this where-in max_seg_sz is
defaulting to 64K. Due to above bug, unfolding SGE's in __ib_umem_release
points to a bad page ptr.

[ 6146.398661] TEST comp-wfr.perfnative.STL-22166-WDT _ perftest native 2-Write_4097QP_4MB STARTING at 1555387093
[ 6893.954261] BUG: Bad page state in process ib_write_bw  pfn:7ebca0
[ 6893.961996] page:ffffcd675faf2800 count:0 mapcount:1 mapping:0000000000000000 index:0x1
[ 6893.971565] flags: 0x17ffffc0000000()
[ 6893.976257] raw: 0017ffffc0000000 dead000000000100 dead000000000200 0000000000000000
[ 6893.985518] raw: 0000000000000001 0000000000000000 0000000000000000 0000000000000000
[ 6893.994768] page dumped because: nonzero mapcount
[ 6894.084904] CPU: 18 PID: 15853 Comm: ib_write_bw Tainted: G    B             5.1.0-rc4 #1
[ 6894.094644] Hardware name: Intel Corporation S2600CWR/S2600CW, BIOS SE5C610.86B.01.01.0014.121820151719 12/18/2015
[ 6894.106816] Call Trace:
[ 6894.110155]  dump_stack+0x5a/0x73
[ 6894.114447]  bad_page+0xf5/0x10f
[ 6894.118640]  free_pcppages_bulk+0x62c/0x680
[ 6894.123904]  free_unref_page+0x54/0x70
[ 6894.128692]  __ib_umem_release+0x148/0x1a0 [ib_uverbs]
[ 6894.135028]  ib_umem_release+0x22/0x80 [ib_uverbs]
[ 6894.141003]  rvt_dereg_mr+0x67/0xb0 [rdmavt]
[ 6894.146382]  ib_dereg_mr_user+0x37/0x60 [ib_core]
[ 6894.152235]  destroy_hw_idr_uobject+0x1c/0x50 [ib_uverbs]
[ 6894.158868]  uverbs_destroy_uobject+0x2e/0x180 [ib_uverbs]
[ 6894.165611]  uobj_destroy+0x4d/0x60 [ib_uverbs]
[ 6894.171277]  __uobj_get_destroy+0x33/0x50 [ib_uverbs]
[ 6894.177547]  __uobj_perform_destroy+0xa/0x30 [ib_uverbs]
[ 6894.184094]  ib_uverbs_dereg_mr+0x66/0x90 [ib_uverbs]
[ 6894.190337]  ib_uverbs_write+0x3e1/0x500 [ib_uverbs]
[ 6894.196473]  vfs_write+0xad/0x1b0
[ 6894.200762]  ksys_write+0x5a/0xd0
[ 6894.205069]  do_syscall_64+0x5b/0x180
[ 6894.209728]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: d10bcf947a3e ("RDMA/umem: Combine contiguous PAGE_SIZE regions in SGEs")
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Tested-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/core/umem.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 7e912a9..04795c5 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -101,17 +101,20 @@ static struct scatterlist *ib_umem_add_sg_table(struct scatterlist *sg,
 		 * at i
 		 */
 		for (len = 0; i != npages &&
-			      first_pfn + len == page_to_pfn(page_list[i]);
+			      first_pfn + len == page_to_pfn(page_list[i]) &&
+			      len < (max_seg_sz >> PAGE_SHIFT);
 		     len++)
 			i++;
 
 		/* Squash N contiguous pages from page_list into current sge */
-		if (update_cur_sg &&
-		    ((max_seg_sz - sg->length) >= (len << PAGE_SHIFT))) {
-			sg_set_page(sg, sg_page(sg),
-				    sg->length + (len << PAGE_SHIFT), 0);
+		if (update_cur_sg) {
+			if ((max_seg_sz - sg->length) >= (len << PAGE_SHIFT)) {
+				sg_set_page(sg, sg_page(sg),
+					    sg->length + (len << PAGE_SHIFT), 0);
+				update_cur_sg = false;
+				continue;
+			}
 			update_cur_sg = false;
-			continue;
 		}
 
 		/* Squash N contiguous pages into next sge or first sge */
-- 
1.8.3.1

