Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A4E7CFDC4
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Oct 2023 17:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345450AbjJSPZf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 11:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345550AbjJSPZf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 11:25:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52E3121
        for <linux-rdma@vger.kernel.org>; Thu, 19 Oct 2023 08:25:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5754C433C7;
        Thu, 19 Oct 2023 15:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697729133;
        bh=u/lMWJ+F7E/hlh7pbvNFzd6HWcLB+2i2s6p2bJhsGNM=;
        h=Subject:From:Cc:Date:From;
        b=s/A5u5nuYoWGo2aupBwIYcocCx0oznUJzPAn7aPczoF6P6tSHzITH5v2c6K7hAVmx
         GhmTRWBYv+D/AwH5OX2rDNeHaI802fKR9+OHWUh7LMofQKaIMbOeNuJKOyRmGxi3YS
         E031nLW9QIJpzOZmLdi8u3jVoU1Zr5pEeGkvKR1ElUgTG6d6ABKDb6Kpb5zUaxu0Gv
         cetfm0rfcQgArFAzt8rtEatpFxYgzUw0G+g3AByGweBtac3m4XLQWcjM5gGMVbXs41
         fcUJZ6sY6ouUxZUIH8+gkDEr9c3e+Un53EG1ew/0Rv0AJrUzyfmBbsRJYdqnqvjlVq
         VK0KEJhBcHYWQ==
Subject: [PATCH RFC 0/9] Exploring biovec support in (R)DMA API
From:   Chuck Lever <cel@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alexander Potapenko <glider@google.com>, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        kasan-dev@googlegroups.com, David Howells <dhowells@redhat.com>,
        iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>
Date:   Thu, 19 Oct 2023 11:25:31 -0400
Message-ID: <169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The SunRPC stack manages pages (and eventually, folios) via an
array of struct biovec items within struct xdr_buf. We have not
fully committed to replacing the struct page array in xdr_buf
because, although the socket API supports biovec arrays, the RDMA
stack uses struct scatterlist rather than struct biovec.

This (incomplete) series explores what it might look like if the
RDMA core API could support struct biovec array arguments. The
series compiles on x86, but I haven't tested it further. I'm posting
early in hopes of starting further discussion.

Are there other upper layer API consumers, besides SunRPC, who might
prefer the use of biovec over scatterlist?

Besides handling folios as well as single pages in bv_page, what
other work might be needed in the DMA layer?

What RDMA core APIs should be converted? IMO a DMA mapping and
registration API for biovecs would be needed. Maybe RDMA Read and
Write too?

---

Chuck Lever (9):
      dma-debug: Fix a typo in a debugging eye-catcher
      bvec: Add bio_vec fields to manage DMA mapping
      dma-debug: Add dma_debug_ helpers for mapping bio_vec arrays
      mm: kmsan: Add support for DMA mapping bio_vec arrays
      dma-direct: Support direct mapping bio_vec arrays
      DMA-API: Add dma_sync_bvecs_for_cpu() and dma_sync_bvecs_for_device()
      DMA: Add dma_map_bvecs_attrs()
      iommu/dma: Support DMA-mapping a bio_vec array
      RDMA: Add helpers for DMA-mapping an array of bio_vecs


 drivers/iommu/dma-iommu.c   | 368 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c       |  58 ++++++
 include/linux/bvec.h        | 143 ++++++++++++++
 include/linux/dma-map-ops.h |   8 +
 include/linux/dma-mapping.h |   9 +
 include/linux/iommu.h       |   4 +
 include/linux/kmsan.h       |  20 ++
 include/rdma/ib_verbs.h     |  29 +++
 kernel/dma/debug.c          | 165 +++++++++++++++-
 kernel/dma/debug.h          |  38 ++++
 kernel/dma/direct.c         |  92 +++++++++
 kernel/dma/direct.h         |  17 ++
 kernel/dma/mapping.c        |  93 +++++++++
 mm/kmsan/hooks.c            |  13 ++
 14 files changed, 1056 insertions(+), 1 deletion(-)

--
Chuck Lever

