Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0804365BF5E
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Jan 2023 12:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbjACLuo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Jan 2023 06:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbjACLun (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Jan 2023 06:50:43 -0500
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9208E7
        for <linux-rdma@vger.kernel.org>; Tue,  3 Jan 2023 03:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1672746642; x=1704282642;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PP+2ozAbtD9lfi8UzRj4ASN80+2SI5lASjELtSAeR/0=;
  b=u/AnYqfFfcsJ10vSozNiApUuZZkiavwLVzctF+BsTwP9Bvw+kNWaFABK
   FVXNH9GoQpGL2yotNF5f4njL0vNMlwQcxQM18tV9FKbun8X9PhA11biX+
   0mY6LMXB5zuQhye40pzVKkOy4pynKM+pXRePMm3aZt+zh1qLiYJ6/e2BJ
   0=;
X-IronPort-AV: E=Sophos;i="5.96,296,1665446400"; 
   d="scan'208";a="1088866838"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 11:50:35 +0000
Received: from EX13D47EUC003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com (Postfix) with ESMTPS id F0BC742099;
        Tue,  3 Jan 2023 11:50:34 +0000 (UTC)
Received: from EX19D045EUC003.ant.amazon.com (10.252.61.236) by
 EX13D47EUC003.ant.amazon.com (10.43.164.208) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Tue, 3 Jan 2023 11:50:33 +0000
Received: from 88665a2fa36d.ant.amazon.com.com (10.43.161.114) by
 EX19D045EUC003.ant.amazon.com (10.252.61.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.7;
 Tue, 3 Jan 2023 11:50:29 +0000
From:   Yonatan Nachum <ynachum@amazon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
        <yatias@habana.ai>
Subject: [PATCH for-rc v2] RDMA: Fix ib block iterator counter overflow
Date:   Tue, 3 Jan 2023 13:50:16 +0200
Message-ID: <20230103115016.11869-1-ynachum@amazon.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.161.114]
X-ClientProxiedBy: EX13D40UWA003.ant.amazon.com (10.43.160.29) To
 EX19D045EUC003.ant.amazon.com (10.252.61.236)
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When registering a new DMA MR after selecting the best aligned page size
for it, we iterate over the given sglist to split each entry to smaller,
aligned to the selected page size, DMA blocks.

In given circumstances where the sg entry and page size fit certain
sizes and the sg entry is not aligned to the selected page size, the
total size of the aligned pages we need to cover the sg entry is >= 4GB.
Under this circumstances, while iterating page aligned blocks, the
counter responsible for counting how much we advanced from the start of
the sg entry is overflowed because its type is u32 and we pass 4GB in
size.  This can lead to an infinite loop inside the iterator function
because in some cases the overflow prevents the counter to be larger
than the size of the sg entry.

Fix the presented problem with changing the counter type to u64.

Backtrace:
[  192.374329] efa_reg_user_mr_dmabuf
[  192.376783] efa_register_mr
[  192.382579] pgsz_bitmap 0xfffff000 rounddown 0x80000000
[  192.386423] pg_sz [0x80000000] umem_length[0xc0000000]
[  192.392657] start 0x0 length 0xc0000000 params.page_shift 31 params.page_num 3
[  192.399559] hp_cnt[3], pages_in_hp[524288]
[  192.403690] umem->sgt_append.sgt.nents[1]
[  192.407905] number entries: [1], pg_bit: [31]
[  192.411397] biter->__sg_nents [1] biter->__sg [0000000008b0c5d8]
[  192.415601] biter->__sg_advance [665837568] sg_dma_len[3221225472]
[  192.419823] biter->__sg_nents [1] biter->__sg [0000000008b0c5d8]
[  192.423976] biter->__sg_advance [2813321216] sg_dma_len[3221225472]
[  192.428243] biter->__sg_nents [1] biter->__sg [0000000008b0c5d8]
[  192.432397] biter->__sg_advance [665837568] sg_dma_len[3221225472]

Fixes: a808273a495c ("RDMA/verbs: Add a DMA iterator to return aligned contiguous memory blocks")
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
---
 include/rdma/ib_verbs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 975d6e9efbcb..6821c7951363 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2836,7 +2836,7 @@ struct ib_block_iter {
 	struct scatterlist *__sg;	/* sg holding the current aligned block */
 	dma_addr_t __dma_addr;		/* unaligned DMA address of this block */
 	unsigned int __sg_nents;	/* number of SG entries */
-	unsigned int __sg_advance;	/* number of bytes to advance in sg in next step */
+	u64 __sg_advance;		/* number of bytes to advance in sg in next step */
 	unsigned int __pg_bit;		/* alignment of current block */
 };
 
-- 
2.38.1

