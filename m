Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2782E4B3EF
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 10:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfFSITv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 04:19:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfFSITu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jun 2019 04:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Oj2mVxSa+2J+fkcSLZJgmIgirExhWFgh1cb5vCMP3vI=; b=tf5cAthDjPtD5dgpkrrmWm6iX
        hJT+iCl3LI50nk+ly+ZUajqlu/ZYu5I81HuuxxEoOqgz7cy6G/879N+lqH8TGVpEIzKb8gY3RWEH3
        spycirx2fT31SjuibyhyqizZP8JiXuZ7DC4RaFSjwiDEGgpm42e6/0HTM69qw1BUen2f8789MSOfC
        3BFfTed174q1HfdzIVms/k2iwj1c/fqiYCnF/5TegT2vD/aAyWCTylC372dVxF67j6a4/CwjOm3IO
        /J6MW7+6GXoWPYd0XJsHHz0VI9rAa4XLWjR2isQ4WJ9LmCy9LcN2FEXjp26JXuspZegFhyO4rNb9S
        ZStiJlmvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hdVoq-0000mV-EN; Wed, 19 Jun 2019 08:19:48 +0000
Date:   Wed, 19 Jun 2019 01:19:48 -0700
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
        Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 08/12] mm/hmm: Remove racy protection against
 double-unregistration
Message-ID: <20190619081948.GC24900@infradead.org>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-9-jgg@ziepe.ca>
 <20190615141612.GH17724@infradead.org>
 <20190618131324.GF6961@ziepe.ca>
 <20190618132722.GA1633@infradead.org>
 <20190618185757.GP6961@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618185757.GP6961@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 18, 2019 at 03:57:57PM -0300, Jason Gunthorpe wrote:
> With the previous loose coupling of the mirror and the range some code
> might rance to try to create a range without a mirror, which will now
> reliably crash with the poison.
> 
> It isn't so much the double unregister that worries me, but racing
> unregister with range functions.

Oh well.  It was just a nitpick for the highly unusual code patterns
in the two unregister routines, probably not worth fighting over even
if I still don't see the point.
