Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2426A6FB056
	for <lists+linux-rdma@lfdr.de>; Mon,  8 May 2023 14:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjEHMlk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 May 2023 08:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbjEHMlW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 May 2023 08:41:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7C438F0F;
        Mon,  8 May 2023 05:41:04 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QFLSw0tyHzsRLP;
        Mon,  8 May 2023 20:39:12 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 20:41:02 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-rdma@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <xen-devel@lists.xenproject.org>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <alexanderduyck@fb.com>, <jbrouer@redhat.com>,
        <ilias.apalodimas@linaro.org>
Subject: [PATCH RFC 0/2] introduce skb_frag_fill_page_desc()
Date:   Mon, 8 May 2023 20:39:20 +0800
Message-ID: <20230508123922.39284-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Most users use __skb_frag_set_page()/skb_frag_off_set()/
skb_frag_size_set() to fill the page desc for a skb frag.
It does not make much sense to calling __skb_frag_set_page()
without calling skb_frag_off_set(), as the offset may depend
on whether the page is head page or tail page, so add
skb_frag_fill_page_desc() to fill the page desc for a skb
frag.

In the future, we can make sure the page in the frag is
head page of compound page or a base page, if not, we
may warn about that and convert the tail page to head
page and update the offset accordingly, if we see a warning
about that, we also fix the caller to fill the head page
in the frag. when the fixing is done, we may remove the
warning and converting.

In this way, we can remove the compound_head() or use
page_ref_*() like the below case:
https://elixir.bootlin.com/linux/latest/source/net/core/page_pool.c#L881
https://elixir.bootlin.com/linux/latest/source/include/linux/skbuff.h#L3383

It may also convert stack to use the folio easier.


Yunsheng Lin (2):
  net: introduce and use skb_frag_fill_page_desc()
  net: remove __skb_frag_set_page()

 .../net/ethernet/aquantia/atlantic/aq_ring.c  |  6 +--
 drivers/net/ethernet/broadcom/bnx2.c          |  1 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  6 +--
 drivers/net/ethernet/chelsio/cxgb3/sge.c      |  5 +--
 drivers/net/ethernet/emulex/benet/be_main.c   | 30 +++++++-------
 drivers/net/ethernet/freescale/enetc/enetc.c  |  5 +--
 .../net/ethernet/fungible/funeth/funeth_rx.c  |  5 +--
 drivers/net/ethernet/marvell/mvneta.c         |  5 +--
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  4 +-
 drivers/net/ethernet/sun/cassini.c            |  8 +---
 drivers/net/virtio_net.c                      |  4 +-
 drivers/net/vmxnet3/vmxnet3_drv.c             |  4 +-
 drivers/net/xen-netback/netback.c             |  4 +-
 include/linux/skbuff.h                        | 39 +++++--------------
 net/bpf/test_run.c                            |  3 +-
 net/core/gro.c                                |  4 +-
 net/core/pktgen.c                             | 13 ++++---
 net/core/skbuff.c                             |  7 ++--
 net/tls/tls_device.c                          | 10 ++---
 net/xfrm/xfrm_ipcomp.c                        |  5 +--
 20 files changed, 62 insertions(+), 106 deletions(-)

-- 
2.33.0

