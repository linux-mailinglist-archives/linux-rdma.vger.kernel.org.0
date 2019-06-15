Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6944F47045
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2019 15:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfFON7p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Jun 2019 09:59:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50020 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfFON7p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Jun 2019 09:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=hk/D58rieL8Onhwvbo3S4fbap
        Tkzm4nzftLhksrpzz8IQnXPlyA6z+c3Wygq0AZ/UWLIcS/bb+4qlDejjx9suAxW/tDYeoNA6iZxqB
        Ftj2ODL2/e+Pjz9X7xIclxGEOe6jPjHda1ywTlLZtdih9bZWH4qtC3bYcnHYqBTz2FsInoYbnS4gg
        ybmc/RCOIPHZu2EGHIKJ0pEe23W6Dsmi5fzOyOuKeTmV/ZncUMC2y5Gpu7SHsJ6Y11nxrbQO9SuNq
        KIBJ+AI6XGinNFvmvuO4d8H3HBSBau2G5mumoxNuAzXV6yuvcgppjyZQYG70JTxUJaF4FygMUx150
        R8eT43xWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hc9Da-0005FA-V2; Sat, 15 Jun 2019 13:59:42 +0000
Date:   Sat, 15 Jun 2019 06:59:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 03/12] mm/hmm: Hold a mmgrab from hmm to mm
Message-ID: <20190615135942.GC17724@infradead.org>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-4-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614004450.20252-4-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
