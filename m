Return-Path: <linux-rdma+bounces-10955-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95102ACD5DE
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 04:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD57176C0F
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 02:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06D822D792;
	Wed,  4 Jun 2025 02:53:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43580214228;
	Wed,  4 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005590; cv=none; b=GYDFlTjw/Gmjz9JIRlfLRXXcVrQ9m1nSJbF99n1nhCDBW5zvvF6y0wwRAz9ZUzVYe8uYobo4jBOQb+NbRxpzwnUMX2WW/KyNi0iEsqDXV7Zp4BHfWSFanPEQdKCsemG83uTSqKHrLpDDSqFlXfI8iOeeeIuTCUE+K6gmwXGOokw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005590; c=relaxed/simple;
	bh=WwXiCyZhb6yzKKt9THlSbvf+dnLCzsV7abwnY/VLqio=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Vj7YAFUqTpRmF9iJ9LxMjbhIhF4JJtpYm282YrhHnMA9pOTr34dizZq2vFdP4PD2AtSdJ51eQ72cTqO1OoX+7qH4XYKLncjkd50gW7m4APpZaJSiJqJEAYLB+zA1wC6Nah0o2Rxbur+EXOsey2ZV28qdyvSQLpc9VltIg0OGA/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-ba-683fb5094085
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	kuba@kernel.org,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	hawk@kernel.org,
	akpm@linux-foundation.org,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	andrew+netdev@lunn.ch,
	asml.silence@gmail.com,
	toke@redhat.com,
	tariqt@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: [RFC v4 00/18] Split netmem from struct page
Date: Wed,  4 Jun 2025 11:52:28 +0900
Message-Id: <20250604025246.61616-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRXUhTcRiH/Z9zds7ZdHBcWicDrdEHDsoMpRcq86LgDwkJXRQF5chDW80p
	WzM1wmnLaOSKDBJdNalMp7Va6paJ2bLSEjJHsdKcKDNBW+hy+EXliu4enoffe/OypKyZSmDV
	2tOCTqvUyGkJJfkeU7dZ3LpbtdV2OQmsjmYamuaK4P6IWwRWexuCn/ODDIS639Bwpy5MgvW9
	iYJZxwIJgdejDPjrxynouOgiYfRKDw2VpkUSyt0NBPS3WURwfeEeCS7jCAPedisNw82/RTDu
	qaSgt6aRAr8lE17bVkL43RSCboeLgPDlmzRUDdhoGDP5EQy8HKWgtsyCwNHpE8HinJXOXIdb
	Gj8T+GnNVwbbnAb8pEGBzb4BEjvtl2jsnLnG4KFPHTTuqV6k8FN3iMCV54M0ng58ofCPzo80
	drR8pHCfrZvBIWdiNndYsjNX0KgLBV1KRo5E1e6qZQomdhSFgx9oI7qRYkZilufS+FsBE21G
	7F+esJdENM1t4n2+eTLCcVwqHxp9Q5mRhCW5oIgPWBeJSFjBpfPDg2EmwhS3gZ8M3hZFWLrs
	A4Ex9O9+Et/0qIuMjHlumOEn/UvEv7Caf9Hgo66iaBuKsiOZWluYp1Rr0raoirXqoi3H8/Oc
	aPmH9eeWjrjRTP8BD+JYJI+RuocyVDKRslBfnOdBPEvK46RJyctKmqssLhF0+cd0Bo2g96A1
	LCVfJd0WPpMr404oTwunBKFA0P2vBCtOMKLYV72xF/aaf+2Z6qqoD7W39pyMisJH4dCCN7kt
	y0W8vRZTc+TxMW+KodQ+XVXRtC9jrUNsPH4ivevTA1NiQzxRv2f/813TFZtGhIeUIlD2zRN/
	0KtIGPGuN9VaF8prcsTbFZeKN9/9ED7bt7HTMnh/9uCzrNLs7DtkZpohGF3dKKf0KmWqgtTp
	lX8ARprZHr8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAwGiAl39CAMSjwQaCGludGVybmFsIgYKBApOO4MtCbU/aDCh8wo4nK+sBjir
	+Hg4p+C4BTicqrYBOPT52wc488THBjijofYDOJzPhAQ49a/6AzjlxuIHON+m5gQ4vIe3Azji
	j8gGOI2E+wM4grioAjjDnckFONC2jgU4lPqlAzi3gOAHONO6nAY43qz/BTjmwo0EOMmaqQQ4
	345AOMagFjj2y+wBOMSvtwI49oydBjiT0qAGOOOE3wE40sPiBDibgY4BOK++2AU4+/icBkAi
	SLSp2QJIuZrdB0igsnVIs6gqSIrY0gNIsqqJBkiy8pIHSNzWvAZIyJj7BEi5uPMCSI2D7gZI
	8eXaBEjvvtUGSKPo8AJIr7TVBEjMoMQHUBFaCjxkZWxpdmVyLz5gCmi6t5sHcOg7ePbu0QaA
	AZcvigEICBgQNBjoqnqKAQkIBhAnGNjY+QOKAQkIFBAxGPPixwSKAQoIAxDuBRjlnPsCigEJ
	CBMQNRje2/YHigEJCAQQJRjr7p8FigEJCA0QNRjl5eMBigEJCBgQHxirsMADkAEIoAEAqgEU
	aW52bWFpbDUuc2toeW5peC5jb22yAQYKBKZ9/JG4AfTTR8IBEAgBIgwNuNw+aBIFYXZzeW3C
	ARgIAyIUDR8pPmgSDWRheXplcm9fcnVsZXPCARsIBCIXDUpXZWASEGdhdGVrZWVwZXJfcnVs
	ZXPCAQIICRqAAYWF2lLhMnhFUz+v8J2j/wIGgDEfykPfRw1GVNckynP3CQ1j0OfA1ZBz2k/g
	Qq1CxIt5b9xPybk4pXrZkv/O+FcWB4iqt9+H6vWJU9jiT+fJAkkgYFGDzrQvwHJV3SFGjmBW
	qL09FCEscsVDvz9j9pWPZqAriysoNGmfYYdTyIT+IgRzaGExKgNyc2Hu9aA3ogIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The MM subsystem is trying to reduce struct page to a single pointer.
The first step towards that is splitting struct page by its individual
users, as has already been done with folio and slab.  This patchset does
that for netmem which is used for page pools.

Matthew Wilcox tried and stopped the same work, you can see in:

   https://lore.kernel.org/linux-mm/20230111042214.907030-1-willy@infradead.org/

Mina Almasry already has done a lot fo prerequisite works by luck.  I
stacked my patches on the top of his work e.i. netmem.

I focused on removing the page pool members in struct page this time,
not moving the allocation code of page pool from net to mm.  It can be
done later if needed.

The final patch removing the page pool fields will be submitted once
all the converting work of page to netmem are done:

   1. converting of libeth_fqe by Tony Nguyen.
   2. converting of mlx5 by Tariq Toukan.
   3. converting of prueth_swdata (on me).
   4. converting of freescale driver (on me).

For our discussion, I'm sharing what the final patch looks like the
following.

	Byungchul
--8<--
commit 1847d9890f798456b21ccb27aac7545303048492
Author: Byungchul Park <byungchul@sk.com>
Date:   Wed May 28 20:44:55 2025 +0900

    mm, netmem: remove the page pool members in struct page
    
    Now that all the users of the page pool members in struct page have been
    gone, the members can be removed from struct page.
    
    However, since struct netmem_desc still uses the space in struct page,
    the important offsets should be checked properly, until struct
    netmem_desc has its own instance from slab.
    
    Remove the page pool members in struct page and modify static checkers
    for the offsets.
    
    Signed-off-by: Byungchul Park <byungchul@sk.com>

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 32ba5126e221..db2fe0d0ebbf 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -120,17 +120,6 @@ struct page {
 			 */
 			unsigned long private;
 		};
-		struct {	/* page_pool used by netstack */
-			/**
-			 * @pp_magic: magic value to avoid recycling non
-			 * page_pool allocated pages.
-			 */
-			unsigned long pp_magic;
-			struct page_pool *pp;
-			unsigned long _pp_mapping_pad;
-			unsigned long dma_addr;
-			atomic_long_t pp_ref_count;
-		};
 		struct {	/* Tail pages of compound page */
 			unsigned long compound_head;	/* Bit zero is set */
 		};
diff --git a/include/net/netmem.h b/include/net/netmem.h
index 8f354ae7d5c3..3414f184d018 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -42,11 +42,8 @@ struct netmem_desc {
 	static_assert(offsetof(struct page, pg) == \
 		      offsetof(struct netmem_desc, desc))
 NETMEM_DESC_ASSERT_OFFSET(flags, _flags);
-NETMEM_DESC_ASSERT_OFFSET(pp_magic, pp_magic);
-NETMEM_DESC_ASSERT_OFFSET(pp, pp);
-NETMEM_DESC_ASSERT_OFFSET(_pp_mapping_pad, _pp_mapping_pad);
-NETMEM_DESC_ASSERT_OFFSET(dma_addr, dma_addr);
-NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
+NETMEM_DESC_ASSERT_OFFSET(lru, pp_magic);
+NETMEM_DESC_ASSERT_OFFSET(mapping, _pp_mapping_pad);
 #undef NETMEM_DESC_ASSERT_OFFSET
 
 /*
---
Changes from v3:
	1. Relocates ->owner and ->type of net_iov out of netmem_desc
	   and make them be net_iov specific.
	2. Remove __force when casting struct page to struct netmem_desc.

Changes from v2:
	1. Introduce a netmem API, virt_to_head_netmem(), and use it
	   when it's needed.
	2. Introduce struct netmem_desc as a new struct and union'ed
	   with the existing fields in struct net_iov.
	3. Make page_pool_page_is_pp() access ->pp_magic through struct
	   netmem_desc instead of struct page.
	4. Move netmem alloc APIs from include/net/netmem.h to
	   net/core/netmem_priv.h.
	5. Apply trivial feedbacks, thanks to Mina, Pavel, and Toke.
	6. Add given 'Reviewed-by's, thanks to Mina.

Changes from v1:
	1. Rebase on net-next's main as of May 26.
	2. Check checkpatch.pl, feedbacked by SJ Park.
	3. Add converting of page to netmem in mt76.
	4. Revert 'mlx5: use netmem descriptor and APIs for page pool'
	   since it's on-going by Tariq Toukan.  I will wait for his
	   work to be done.
	5. Revert 'page_pool: use netmem APIs to access page->pp_magic
	   in page_pool_page_is_pp()' since we need more discussion.
	6. Revert 'mm, netmem: remove the page pool members in struct
	   page' since there are some prerequisite works to remove the
	   page pool fields from struct page.  I can submit this patch
	   separatedly later.
	7. Cancel relocating a page pool member in struct page.
	8. Modify static assert for offests and size of struct
	   netmem_desc.

Changes from rfc:
	1. Rebase on net-next's main branch.
	   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/
	2. Fix a build error reported by kernel test robot.
	   https://lore.kernel.org/all/202505100932.uzAMBW1y-lkp@intel.com/
	3. Add given 'Reviewed-by's, thanks to Mina and Ilias.
	4. Do static_assert() on the size of struct netmem_desc instead
	   of placing place-holder in struct page, feedbacked by
	   Matthew.
	5. Do struct_group_tagged(netmem_desc) on struct net_iov instead
	   of wholly renaming it to strcut netmem_desc, feedbacked by
	   Mina and Pavel.

Byungchul Park (18):
  netmem: introduce struct netmem_desc mirroring struct page
  netmem: introduce netmem alloc APIs to wrap page alloc APIs
  page_pool: use netmem alloc/put APIs in __page_pool_alloc_page_order()
  page_pool: rename __page_pool_alloc_page_order() to
    __page_pool_alloc_netmem_order()
  page_pool: use netmem alloc/put APIs in __page_pool_alloc_pages_slow()
  page_pool: rename page_pool_return_page() to page_pool_return_netmem()
  page_pool: use netmem put API in page_pool_return_netmem()
  page_pool: rename __page_pool_release_page_dma() to
    __page_pool_release_netmem_dma()
  page_pool: rename __page_pool_put_page() to __page_pool_put_netmem()
  page_pool: rename __page_pool_alloc_pages_slow() to
    __page_pool_alloc_netmems_slow()
  mlx4: use netmem descriptor and APIs for page pool
  netmem: use _Generic to cover const casting for page_to_netmem()
  netmem: remove __netmem_get_pp()
  page_pool: make page_pool_get_dma_addr() just wrap
    page_pool_get_dma_addr_netmem()
  netdevsim: use netmem descriptor and APIs for page pool
  netmem: introduce a netmem API, virt_to_head_netmem()
  mt76: use netmem descriptor and APIs for page pool
  page_pool: access ->pp_magic through struct netmem_desc in
    page_pool_page_is_pp()

 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  48 +++---
 drivers/net/ethernet/mellanox/mlx4/en_tx.c    |   8 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |   4 +-
 drivers/net/netdevsim/netdev.c                |  19 +--
 drivers/net/netdevsim/netdevsim.h             |   2 +-
 drivers/net/wireless/mediatek/mt76/dma.c      |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  12 +-
 .../net/wireless/mediatek/mt76/sdio_txrx.c    |  24 +--
 drivers/net/wireless/mediatek/mt76/usb.c      |  10 +-
 include/linux/mm.h                            |  12 --
 include/net/netmem.h                          | 138 ++++++++++++------
 include/net/page_pool/helpers.h               |   7 +-
 mm/page_alloc.c                               |   1 +
 net/core/netmem_priv.h                        |  14 ++
 net/core/page_pool.c                          | 103 ++++++-------
 15 files changed, 234 insertions(+), 174 deletions(-)


base-commit: 90b83efa6701656e02c86e7df2cb1765ea602d07
-- 
2.17.1


