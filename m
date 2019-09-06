Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D83AABBE0
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2019 17:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733189AbfIFPKr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Sep 2019 11:10:47 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:33453 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfIFPKr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Sep 2019 11:10:47 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N7Qkv-1iEFdy0ONB-017jD5; Fri, 06 Sep 2019 17:10:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rdma/siw: fix NOMMU build
Date:   Fri,  6 Sep 2019 17:10:10 +0200
Message-Id: <20190906151028.1064531-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:svnOKkIwvMMN2TxIk68gqKt+i1qDuao/nvUUaSm/PJwqOnp+jxZ
 FRL3NKODlVWYldlmMkjhkWkhBFWYySN3Lqy+N17P9/LUGuUZQqx43KD4zEyMw2Nr0WGHZVN
 nTlusUYKmQfhofqMp7rDc23pa4DBTPRMmSGtLZzmCD3Zt9aWbpDk//Q9p7Ynm2VgJMVWq7k
 2xxfn4CAxM9aLzBIy91Kw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YvGC+Z3bvOY=:BV6BpiMQShEh3d1hmzWknQ
 IHO/49nosEcLepL0ERAotL3z4HUhFWqzzn2hwUkBO8qttq7As+E7x6fvQ2P6kiwjC71LteDJV
 Ym6O8PuVMzTRV+He5JYY7OTws8Vdj/CgPUigLJ/F2qDtV9reQ3LHTpkvY6GKK+eOxHVuVjN6q
 oys8Dz/HQR7JLvzoMgX7lrt9IMBNoFmbQqs346/3VfL7GGEuyPrbKu3UD7BkkoJzQ+/1zKKwU
 7NKjPDxPMocy9V2EyuE0RvKUCFSyvyC1t1av2TRwAnPb/03u8W1nWb6ldmuzI7p/PElczYMsb
 9PgXlVqq6ZWplUWOuTFld3q3g8pw8v9vC0YhOTQ6tV6vtnEE1V7dduTB6r1MWncL7M1pYC/jf
 4ZNCpLwPPDRHmkb88t3LiV96TSSWoqtIsKP4EpkGmfaaBkBaTWt7g+tRe2DbQPSYlsfqU7ARq
 I6n3eyyN2euNZASADbgkdax180Vki0w48HyoEARNqeVaKP8DqLqDxllKET8wCMdhz9af89Co4
 002wVbkDT9eMCfBIo7+C6s+mw/fJ32CI9K9o8E3SeIDwQ6zpQY03XAKYTrurRpTHgDucNGdbx
 fJozbT7doO533cGGqP0eZNHH7MraDBH1zn+lZFhRK9ItoTcRrYdzjZoX1io55PA7YqMDzo2aw
 pjHfdMz/FFNOY9a4TM+V5+yVbIhQA+D+9PCkEd6ooPsG+YXJXJciEynZELSUt5K1hMZEgeo+z
 QUUOWbPsQ3LaCxjRey1DOQDXtPcm/fzYLSPjgCAr2a8A24GmXLHOjO2N7jmJMFfVdJMJL5l0Q
 15KEpk93ekCEUIzD+zLf93uWD6M6o6i/cds3OZHbQsC73EwzBA=
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On kernels without CONFIG_MMU, we get a link error for the siw
driver:

drivers/infiniband/sw/siw/siw_mem.o: In function `siw_umem_get':
siw_mem.c:(.text+0x4c8): undefined reference to `can_do_mlock'

I don't know whether this driver is able to work at all without
an MMU, but it's easy to avoid the link problem by adding another
compile-time check.

Fixes: 2251334dcac9 ("rdma/siw: application buffer management")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/sw/siw/siw_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index e99983f07663..b3b614c07fdb 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -374,7 +374,7 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
 	unsigned int foll_flags = FOLL_WRITE;
 	int num_pages, num_chunks, i, rv = 0;
 
-	if (!can_do_mlock())
+	if (!IS_ENABLED(CONFIG_MMU) || !can_do_mlock())
 		return ERR_PTR(-EPERM);
 
 	if (!len)
-- 
2.20.0

