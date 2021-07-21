Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508B83D0914
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 08:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhGUGBh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 02:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbhGUGBA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jul 2021 02:01:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC24C061574;
        Tue, 20 Jul 2021 23:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AuOSEbimPYOX6gL06T3EQj240irYWI0lc+R5KYfyRnM=; b=csREhhaW+x+G/vEokg4j8THUcJ
        VoiZOryV7Ws6XVE4LUqE3maX6Oz36QShzzEhyCAySz2aYxFfq/mKUWLZPesGKKVTX8K865i6vxyg/
        YpkKaqe4jAkek4xteOtzIhPTgoRZ0JdVq27GxOLSYOX4jQkxBoKadB1A5eQHfxUVllWTZF6FpUSoi
        atohL5+D0e6ulKvRlhK26bsxX/GlVvSbXR3ZsvCduD0N8Axd5AQhCAdqGO585PDWMNZyeLmYA9M5G
        1WrMW71QnzGHR/ia4rtPS56+xD7KK4knzEeb70+npXJCJm25VGzYOqs5YXXsTe/Y/9acSWy2QADh5
        qi53PnXA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m65uq-008t6q-Ff; Wed, 21 Jul 2021 06:41:17 +0000
Date:   Wed, 21 Jul 2021 07:41:12 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH rdma-next 3/7] RDMA/core: Remove protection from wrong
 in-kernel API usage
Message-ID: <YPfBiDdghnRwSjwG@infradead.org>
References: <cover.1626846795.git.leonro@nvidia.com>
 <8084238e374fe487c3f9728c2ee5ec8736c204d5.1626846795.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8084238e374fe487c3f9728c2ee5ec8736c204d5.1626846795.git.leonro@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 21, 2021 at 09:13:02AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The ib_create_named_qp() is kernel verb that is not used for user
> supplied attributes. In such case, it is ULP responsibility to provide
> valid QP attributes.
> 
> In-kernel API shouldn't check it, exactly like other functions that
> don't check device capabilities.

Hmm.  These still looks like useful debugging checks.
