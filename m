Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E07EA285D6
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 20:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbfEWSWW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 14:22:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49284 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731505AbfEWSWI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 14:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P7P/rAyxWzeNmj+2ZKGl+tpZq+0DY4fZmz/12N/pJuk=; b=Wde0ZWPb9FtpJuaCuRkz+Oj3t
        9+p0YOonkXuC3u4X4AXtUT4KAfKnvE66numdW8tyfdFbduc2ElXlKRxIurPWDwSh7i5AVnGVlPpc5
        f9J3YjyaP+W0O+TknVeRWVKRGZhqK6NbjwwVod4BoU9oTH3OMxlWykszXqakoQBr60cazHGnd4jzU
        QqySE8XnnyGdfQouYCCmHv6NNVUKCFDMhAPx4ES9kMnEdqlQe7/swTbiGEQj2hVjJaYyHli5FQjFo
        sm4npVWE/AP2zOFAdUrimgK4LVpwiqZ28dJpiDdxN9phrgJk+UMq03iqculdG/lWQTgdhBRPUE00H
        0suuDmC9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTsLv-0000zv-LU; Thu, 23 May 2019 18:22:07 +0000
Date:   Thu, 23 May 2019 11:22:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [RFC PATCH 02/11] mm/hmm: Use hmm_mirror not mm as an argument
 for hmm_register_range
Message-ID: <20190523182207.GA3816@infradead.org>
References: <20190523153436.19102-1-jgg@ziepe.ca>
 <20190523153436.19102-3-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523153436.19102-3-jgg@ziepe.ca>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Nitpick:

s/hmm_register_range/hmm_range_register/ in the subject and patch
description.
