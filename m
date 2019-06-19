Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AACC34B3BA
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 10:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfFSIOV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 04:14:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59438 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfFSIOV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jun 2019 04:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0ZL0Rt+On3+fcA7ZOTp27GEbaFXAtfEHfk/A4omOFs8=; b=VTq/5defW3rvl0qSVOJTGq4WO
        PXQkheSR6n7cepjJuJbIsuVqXJAeoO6w1Usz/0OOo4rXXtGYEvT83GQ+qAKZ8bmqtqvMjBo88SJmL
        IIWd00nGQ1ntnsuA6llhTgwbAcNH+LoQHYo8RR3DLgE3rFAmRgqjhTiFPPyQfPWNhfGwJr+UsyQJa
        gMhBPjfITvI13/SnXh1sjD0CDMc7PiYSMIBJUj4LSHubqiu5ZQC8eq0kA/vGy9kJi/xCtwqSUmiY3
        BM7plvYLHHJiXz7AgxGshkFNjukTfR/NZqKEqUb7nNjEyBrB+qHiXhOT0y+6rLL8sO6KZljTddayk
        Pd1lyxT4g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hdVjU-0006aZ-Cc; Wed, 19 Jun 2019 08:14:16 +0000
Date:   Wed, 19 Jun 2019 01:14:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 02/12] mm/hmm: Use hmm_mirror not mm as an
 argument for hmm_range_register
Message-ID: <20190619081416.GA24900@infradead.org>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-3-jgg@ziepe.ca>
 <20190615135906.GB17724@infradead.org>
 <20190618130544.GC6961@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618130544.GC6961@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 18, 2019 at 10:05:44AM -0300, Jason Gunthorpe wrote:
> I'm thinking to tackle that as part of the mmu notififer invlock
> idea.. Once the range looses the lock then we don't really need to
> register it at all.

Ok.
