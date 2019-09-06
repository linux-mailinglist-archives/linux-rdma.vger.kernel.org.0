Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74CD6ABCCD
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2019 17:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394899AbfIFPnD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Sep 2019 11:43:03 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:35393 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394896AbfIFPnD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Sep 2019 11:43:03 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M7sYM-1i1IIg2adW-0051I2; Fri, 06 Sep 2019 17:42:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ib_umem: fix type mismatch
Date:   Fri,  6 Sep 2019 17:42:37 +0200
Message-Id: <20190906154243.2282560-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:K9/EFzvNoMru8L8s9TvbI42t5t0VeGJl4YOAHC+qXPJKsxIG/QA
 bEgBPhwyGxE+wquiLrWWz8BfpIOA1qoMHUsgMxn8reqteYVqxOkOrBR1WF0y8WFmxxW2H29
 ZqeVIFEJYcMo8KnMJbVojzk5fgRNUubK1bCSkOHVxVvpJj9WidxK0gW/m5BNUGZBpq7LW1z
 4fisvxaYts59Sf/GnB6vA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kyijkn+kpMo=:Wac2vwJV0iJeEqlNcjo4j1
 zm8eeRR5mt+6Q6HO46u2FdC1Y3sVIh/19vmOZWnfRe2lpXHNyvls5Fvlaf66ONwQ3/GXysnpi
 ATt0dPjRld7KpPQgUHdgQ5UzdoaML140C/vIg2bTb4wSySIo/q7kCWoKhxaZYO5HpggnPH6My
 PyqhzH6cSCk900ikNXkTmr0apvmsCqwXob7nd2e32mq4YeZsK1tt2vnNYasbC/PLCii2X28pR
 TGOE1plLFgqq9PXHB1LsD7Jl75zgzwhgXRTOZOvlGt2NzRVPoELox4oPZkbF6iVKGByhdlpMe
 FfaWatXY0Ja4tbJZZ1E9zt0upGOm5Tf7AF0ISBO2YJ403u/G/cC7HqkgIC3tLOMoPTANR/cbJ
 719XvwmwW07OQ+iSfwkLHWCMsF17pHrq5BCqa4TcgvLCmvhEVrOSjzQD9AUxolWgcNMqD7Ms0
 cp6tftCjFzO/87vfR+2mD07A+rlvccPXgSQutYjZg3l9zRUggczDW84PS7zlLKlwcOpcqszQg
 0O3h7J5cLuShM31elfxcg/ksQ3VOkj98pgOhv1TMfCaQkDH0PSMlh7NSF/Q8T7yUJvzAyzddp
 B8N28+S1uAa7NNJLDTsKl4kr97ItRbWkA+aDm1LWIcwvt+gusBhYXf/jQy6aH8druY2scKimv
 QkRAa2JSUizS8bbsHHK4VwU2sUC9auc1OyLP9MNRIXVYsDmAc2qVFLVUcolMP8M+lwjew9BRK
 hCBXN4yEzuq9jFTB9dfyEREwcxHjsGAdMdJNL9sO7IF+vjrSF9xDrjGGwwudk5c43HzF2UZX6
 pvkoAl/nKG3wlJV4nM6Ipna7Saa7KW3T0iQp0/piQO/uDPkWtk=
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On some 32-bit architectures, size_t is defined as 'int' rather
than 'long', causing a harmless warning:

drivers/infiniband/core/umem_odp.c:220:7: error: comparison of distinct pointer types ('typeof (umem_odp->umem.address) *' (aka 'unsigned long *') and 'typeof (umem_odp->umem.length) *' (aka 'unsigned int *')) [-Werror,-Wcompare-distinct-pointer-types]
                if (check_add_overflow(umem_odp->umem.address,
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/overflow.h:59:15: note: expanded from macro 'check_add_overflow'
        (void) (&__a == &__b);                  \
                ~~~~ ^  ~~~~

As size_t is always the same length as unsigned long in all supported
architectures, change the structure definition to use the unsigned long
type for both.

Fixes: 204e3e5630c5 ("RDMA/odp: Check for overflow when computing the umem_odp end")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/rdma/ib_umem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index a91b2af64ec4..5dffe05402ef 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -44,7 +44,7 @@ struct ib_umem_odp;
 struct ib_umem {
 	struct ib_device       *ibdev;
 	struct mm_struct       *owning_mm;
-	size_t			length;
+	unsigned long		length;
 	unsigned long		address;
 	u32 writable : 1;
 	u32 is_odp : 1;
-- 
2.20.0

