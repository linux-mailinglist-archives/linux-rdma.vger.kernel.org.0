Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1F371354AB
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2020 09:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgAIIsB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jan 2020 03:48:01 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:47331 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbgAIIsB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jan 2020 03:48:01 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mw99Y-1jey8c0CyC-00s2rY; Thu, 09 Jan 2020 09:47:46 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Moni Shoua <monis@mellanox.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IB/core: Fix build failure without hugepages
Date:   Thu,  9 Jan 2020 09:47:30 +0100
Message-Id: <20200109084740.2872079-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mkrhrw40NErOvP8CxwUXSW4llRsS42HydBRTLlnckgzOAZHs4E/
 hAw/7GSlComduAO87UIxsrWBEWcIF+7ft/buqQtfeeqxApMdprqOpGlFDlfIhDQNy1E1LEd
 2Q9J9QMoA8Lp7KAaqUzbTAxbc2w0PjVgVJZEnlMdjvNGiewGek9MojVygyqKU2Zpmx+rZW7
 7C0RDFSmDuAbfH6Rn18MA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:03kATHjJVDc=:OV0JtzVoDE39MIMzD9tJrj
 IYkYlVS89skmK73I+iAs19WcYvxf9Z3w+YV/Ly32JQYhnaTysEDXIRG85ttV280GphHPno7A9
 3PW7EbmUUQJPqSFUyVfjJ/P4WnmW4i4SN4iSDyJgP7cowHA9cyTtQTeDYN9xArJwqXuHp0GA4
 LdK+cF8PEE1b03EtnlVrhibhltwQm+zEG/RI8fLHpv8GMRdRB4SjN/M5+acPjjwnirz1sHU9O
 mb8hDzwVWeI6jP/52JbUbyOV4RRoITZkIC1BKNkCWO7/AI+1hwxAevhCO6Htqy7R1HV+WqHzq
 Ruq174DQRlJuJxTHTJnylvvjr2pC1UAKFQcD4s8VqiVgnJK9t4NrtblGD3tNP/Zj0Fhi1fK2p
 NJkTKkMWoojSKEFeSKrvLgtAGJl1LCHM8wuWeK1142iS1f20/rF0+VPldBCkJZjFtvagAkucB
 KePnVLLnAjgjR44CI1Op9TGJSzd2ndiwVrl7hdgYJ0LtmvlIrPnPhExQ86wJ248dtRTYng6Bt
 sD0+tdqXMuEQo5Hk/6KcuoRZiwj3O9jWKE/OwLNiDb/vfzaeUw4vEfdGsY3nkxD5FsuEMQx28
 HRYnUBRCaiWan6Ikit6MNNwROhFc1m2EAW72evrSNRuu4CyL1kT6XOlAFiiCFBq8srPZaum1C
 bUOoouGoI3+15NHBpOBq58N6eqWzMzjVvHLwdYnBlUYKTAbFCigx2iBzS0P4N7CIrbjH1V+ue
 v+/LDRj2iLUivulKIWDOtN9fM6AAbBSHEM9rldw1UXeTz8lSM9IfBr5KkeNAg3nrdslG5BlCn
 FZhY52Vgf+zP4b2XZgIrgxxqfYFlIvJdnFFlDFIB6w206b8OEh2tDP31rfqCl2hnRZL8wwK2J
 xMKRZdN0K9IHPNvz8lfg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

HPAGE_SHIFT is only defined on architectures that support hugepages:

drivers/infiniband/core/umem_odp.c: In function 'ib_umem_odp_get':
drivers/infiniband/core/umem_odp.c:245:26: error: 'HPAGE_SHIFT' undeclared (first use in this function); did you mean 'PAGE_SHIFT'?

Enclose this in an #ifdef.

Fixes: 9ff1b6466a29 ("IB/core: Fix ODP with IB_ACCESS_HUGETLB handling")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/core/umem_odp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index f42fa31c24a2..b9baf7d0a5cb 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -241,10 +241,11 @@ struct ib_umem_odp *ib_umem_odp_get(struct ib_udata *udata, unsigned long addr,
 	umem_odp->umem.owning_mm = mm = current->mm;
 	umem_odp->notifier.ops = ops;
 
+	umem_odp->page_shift = PAGE_SHIFT;
+#ifdef CONFIG_HUGETLB_PAGE
 	if (access & IB_ACCESS_HUGETLB)
 		umem_odp->page_shift = HPAGE_SHIFT;
-	else
-		umem_odp->page_shift = PAGE_SHIFT;
+#endif
 
 	umem_odp->tgid = get_task_pid(current->group_leader, PIDTYPE_PID);
 	ret = ib_init_umem_odp(umem_odp, ops);
-- 
2.20.0

