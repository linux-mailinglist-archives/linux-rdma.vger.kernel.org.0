Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B832C26CCC7
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 22:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgIPUs5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 16:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgIPRAl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Sep 2020 13:00:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034E1C002145
        for <linux-rdma@vger.kernel.org>; Wed, 16 Sep 2020 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lb+EUyzRp7ETop1Pk2W0pnDk3wlAmGzmmY0seJtI9r0=; b=QnSQ4P6xnCnvvQzGdSOW7SDEsV
        MwuAvOA6FPhxF/a5nnv8FP1n7r06W0gxGihLfcoNIf0FGEgmcwkUlF2twK33pHfzS9d/PkiCd9Rdz
        YWxyW5bTwHf3kNgrdV9t0IAQ2cbC4TeOdbq1xUgv6Xw2qcspJvDA0u4j3w0FKsJk0YxsQGU+n8nS8
        2VSkmBTvLgyy6FL44a1O0+iimeqfFkM6fVC3VJvzmmBeEFiHX2E9XNhdZaHVIg9pJES0sLMC+pgna
        P/bXUW0aNr7zAkFV5+TLSiDpf8rh6G0yaxrxOHswzBSCGxfGt1HuIqQOngCDDyVggGAtWfTqranN3
        x4yiUA3w==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIaaI-0004Aw-Oy; Wed, 16 Sep 2020 16:47:06 +0000
Date:   Wed, 16 Sep 2020 17:47:06 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 2/4] IB/core: Enable ODP sync without faulting
Message-ID: <20200916164706.GB11582@infradead.org>
References: <20200914113949.346562-1-leon@kernel.org>
 <20200914113949.346562-3-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914113949.346562-3-leon@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> +		if (fault) {
> +			/*
> +			 * Since we asked for hmm_range_fault() to populate pages,

Totally pointless line over 80 characters.

> +			access_mask = (range.hmm_pfns[pfn_index] & HMM_PFN_WRITE) ?
> +				(ODP_READ_ALLOWED_BIT | ODP_WRITE_ALLOWED_BIT) :
> +				 ODP_READ_ALLOWED_BIT;
> +		}

Another weird overly long line, caused by rather osfucated code.  This
really should be something like:

			access_mask = ODP_READ_ALLOWED_BIT;
			if (range.hmm_pfns[pfn_index] & HMM_PFN_WRITE)
				access_mask |= ODP_WRITE_ALLOWED_BIT;

