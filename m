Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C26B2C2177
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Nov 2020 10:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbgKXJfI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 04:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731006AbgKXJfI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Nov 2020 04:35:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B6AC0613D6
        for <linux-rdma@vger.kernel.org>; Tue, 24 Nov 2020 01:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ATYG+WBgMJMzURc7Y5evOTUda8TNMXOgEuXb/dXBUdQ=; b=AwJMdkq88VbxcIB4rJjHdfuaMf
        IH9D/XuEWX93uyA2fw4dr75p32loZxbArB0DUoDRNjSCrmRSMFLSCGO0DVbVrAkNF2Ja3A70N613i
        1mlDon4dEM/Z2Z6wLIiVzFBoN5zPlAGsjE000qpPZW0ztVACaDpC1VmTeWbBe1YYPgZyhCHyUnOj4
        eeKFhPtXTzaO6Eq9zFuCfj1NWKqjc6wVLmMzDIyFhIiWcuKwrTWSCoQN1dqmxDTgjYBy6XXzbdY4u
        snXUADHws8l+lnwqvO2RBncUi+ZVlRmRxnli6XymFhrodoyeeAPkBtaeRmp0Sx4GXuUrc2WH7Un3m
        E3EB4yoQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khUj4-0008Gg-AL; Tue, 24 Nov 2020 09:35:06 +0000
Date:   Tue, 24 Nov 2020 09:35:06 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH v11 4/4] RDMA/mlx5: Support dma-buf based userspace
 memory region
Message-ID: <20201124093506.GC29715@infradead.org>
References: <1606153919-104513-1-git-send-email-jianxin.xiong@intel.com>
 <1606153919-104513-5-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606153919-104513-5-git-send-email-jianxin.xiong@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> +	if (umem->is_dmabuf)
> +		page_size = mlx5_umem_dmabuf_default_pgsz(umem, iova);
> +	else
> +		page_size = mlx5_umem_find_best_pgsz(umem, mkc, log_page_size, 0, iova);

Please avoid these overly long lines.
