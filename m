Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D959F3AFCEB
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 08:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhFVGQm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 02:16:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:25148 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229677AbhFVGQl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 02:16:41 -0400
IronPort-SDR: grlOUodDHUNQacapJi8fD7zETcq0RcxxMp7uGrAS0pUY5PvHQ/ECA2jV+5gEBD9VaCmsk3uNlL
 i/k7duP1JqUw==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="187373707"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="187373707"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 23:14:26 -0700
IronPort-SDR: uTXj1eV9OSREsDrxY82DojwtSd6ZTstZHlT5AS6eImRzMPg6WNfI/ZWSztLu3Wl73ZPampQl6f
 0lpT8WnhUSkA==
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="641551760"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 23:14:26 -0700
From:   ira.weiny@intel.com
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kheib@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] RDMA/siw: Remove kmap()
Date:   Mon, 21 Jun 2021 23:14:21 -0700
Message-Id: <20210622061422.2633501-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210622061422.2633501-1-ira.weiny@intel.com>
References: <20210622061422.2633501-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

kmap() is being deprecated and will break uses of device dax after PKS
protection is introduced.[1]

These uses of kmap() in the SIW driver are thread local.  Therefore
kmap_local_page() is sufficient to use and will work with pgmap
protected pages when those are implemnted.

There is one more use of kmap() in this driver which is split into its
own patch because kmap_local_page() has strict ordering rules and the
use of the kmap_mask over multiple segments must be handled carefully.
Therefore, that conversion is handled in a stand alone patch.

Use kmap_local_page() instead of kmap() in the 'easy' cases.

[1] https://lore.kernel.org/lkml/20201009195033.3208459-59-ira.weiny@intel.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 7989c4043db4..db68a10d12cd 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -76,7 +76,7 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, void *paddr)
 			if (unlikely(!p))
 				return -EFAULT;
 
-			buffer = kmap(p);
+			buffer = kmap_local_page(p);
 
 			if (likely(PAGE_SIZE - off >= bytes)) {
 				memcpy(paddr, buffer + off, bytes);
@@ -84,7 +84,7 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, void *paddr)
 				unsigned long part = bytes - (PAGE_SIZE - off);
 
 				memcpy(paddr, buffer + off, part);
-				kunmap(p);
+				kunmap_local(buffer);
 
 				if (!mem->is_pbl)
 					p = siw_get_upage(mem->umem,
@@ -96,10 +96,10 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, void *paddr)
 				if (unlikely(!p))
 					return -EFAULT;
 
-				buffer = kmap(p);
+				buffer = kmap_local_page(p);
 				memcpy(paddr + part, buffer, bytes - part);
 			}
-			kunmap(p);
+			kunmap_local(buffer);
 		}
 	}
 	return (int)bytes;
@@ -485,6 +485,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 
 		while (sge_len) {
 			size_t plen = min((int)PAGE_SIZE - fp_off, sge_len);
+			void *kaddr;
 
 			if (!is_kva) {
 				struct page *p;
@@ -517,10 +518,11 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 							iov[seg].iov_base,
 							plen);
 				} else if (do_crc) {
+					kaddr = kmap_local_page(p);
 					crypto_shash_update(c_tx->mpa_crc_hd,
-							    kmap(p) + fp_off,
+							    kaddr + fp_off,
 							    plen);
-					kunmap(p);
+					kunmap_local(kaddr);
 				}
 			} else {
 				u64 va = sge->laddr + sge_off;
-- 
2.28.0.rc0.12.gb6a658bd00c9

