Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 840D439BEC
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 10:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfFHItx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Jun 2019 04:49:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42546 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfFHItx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 8 Jun 2019 04:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Pc64FXF/YPlBK6WpAw3gK4j6mLFmyQzV+riQYtwKZZ8=; b=iUebSp4gV11prU3sOG7JF9FrI
        2JuHQ5xbLQgcMlsbPMssFX2B3mrdBqWjQjCtT5FVX6Ts2YmlNuv9z2IDexlxenS8UA0Th1fTEIKmm
        CR0M0LG9PqU4UitFs5Sf48yXHiKoecKfHQkryI2EyS8Di/+NNBxfM/MsV6R4pkffLD/8OpwqoSUgx
        7ctwS1whpMBBN/zH2e/X3zeALM4+4BZ6DOka1TloBghQ+uhU+mwfmzEWeCbmLn1wvvbnTBurEPqSd
        NnK+dH3j9gpXegzaYCHj783Wr+QDG4YBKckxG3fdF295yQrVSwBEjg5MN1S+JmRQY9LJDYC1jHhr+
        AUJjRe9kg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hZX2q-0001tl-4j; Sat, 08 Jun 2019 08:49:48 +0000
Date:   Sat, 8 Jun 2019 01:49:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v2 hmm 01/11] mm/hmm: fix use after free with struct hmm
 in the mmu notifiers
Message-ID: <20190608084948.GA32185@infradead.org>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-2-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606184438.31646-2-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I still think sruct hmm should die.  We already have a structure used
for additional information for drivers having crazly tight integration
into the VM, and it is called struct mmu_notifier_mm.  We really need
to reuse that intead of duplicating it badly.
