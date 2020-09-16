Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BADF26C7B2
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 20:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgIPSbQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 14:31:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbgIPSaO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Sep 2020 14:30:14 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9C96206B5;
        Wed, 16 Sep 2020 18:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600281013;
        bh=pBShAcjX37wN+lmZO/T65Il8Db+L29pTDRX7L/COy6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MdNZtFSdfeKeTA6GQWTx6BqnhKzVn/hCfl6U3P8R5Us08Foe8JUejaNRFIPOobMih
         kPTnd00b50RP/y/lnPq0WtYmSfc00hKlGLMfSX2HLQfoQJQ2VETslkC8jc6vPUhzVk
         w9Dj3zf/jIxSvTMjBDPUgEi9gOK+mDafAFKSeVUc=
Date:   Wed, 16 Sep 2020 21:30:09 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 2/4] IB/core: Enable ODP sync without faulting
Message-ID: <20200916183009.GM486552@unreal>
References: <20200914113949.346562-1-leon@kernel.org>
 <20200914113949.346562-3-leon@kernel.org>
 <20200916164706.GB11582@infradead.org>
 <20200916181911.GL486552@unreal>
 <20200916182523.GA7233@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916182523.GA7233@infradead.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 16, 2020 at 07:25:23PM +0100, Christoph Hellwig wrote:
> On Wed, Sep 16, 2020 at 09:19:11PM +0300, Leon Romanovsky wrote:
> > On Wed, Sep 16, 2020 at 05:47:06PM +0100, Christoph Hellwig wrote:
> > > > +		if (fault) {
> > > > +			/*
> > > > +			 * Since we asked for hmm_range_fault() to populate pages,
> > >
> > > Totally pointless line over 80 characters.
> >
> > checkpatch.pl was updated to allow 100 symbols.
>
> checkpatch.pl doesn't matter, it is in fact pretty silly.  The coding
> style document says:
>
> "The preferred limit on the length of a single line is 80 columns.
>
> Statements longer than 80 columns should be broken into sensible chunks,
> unless exceeding 80 columns significantly increases readability and does
> not hide information."
>
> and that absolutely is not the case here, you could trivially move the
> last word into the next line and would not even increase the line count.

I'm not arguing, just explained why it was missed.

Thanks
