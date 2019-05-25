Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E97B2A748
	for <lists+linux-rdma@lfdr.de>; Sun, 26 May 2019 00:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfEYWwM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 May 2019 18:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfEYWwM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 25 May 2019 18:52:12 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8FC42081C;
        Sat, 25 May 2019 22:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558824731;
        bh=MJPUSD67w1vDzE1s8ukB7WvKrTYgamW84goFYYVDSPI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uYhUPzjxc/GeB+FzHFhyxZ7vo3ablcJVW7xTFZBQ663X5B5pDMj9l2/WBJbSP5sIr
         PmGFV5rSX7sooE3xDLZ0ZP95v/yHZ+2wABSbIW1lqY2R4xZBk6KSwpM+VoS3oiefLg
         XSQ9v+swjbOvZCStCoNjXDVcLBs5kNEKQR+06saQ=
Date:   Sat, 25 May 2019 15:52:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Airlie <airlied@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jerome Glisse <jglisse@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        linux-mm@kvack.org, dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: RFC: Run a dedicated hmm.git for 5.3
Message-Id: <20190525155210.8a9a66385ac8169d0e144225@linux-foundation.org>
In-Reply-To: <20190524124455.GB16845@ziepe.ca>
References: <20190522235737.GD15389@ziepe.ca>
        <20190523150432.GA5104@redhat.com>
        <20190523154149.GB12159@ziepe.ca>
        <20190523155207.GC5104@redhat.com>
        <20190523163429.GC12159@ziepe.ca>
        <20190523173302.GD5104@redhat.com>
        <20190523175546.GE12159@ziepe.ca>
        <20190523182458.GA3571@redhat.com>
        <20190523191038.GG12159@ziepe.ca>
        <20190524064051.GA28855@infradead.org>
        <20190524124455.GB16845@ziepe.ca>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 24 May 2019 09:44:55 -0300 Jason Gunthorpe <jgg@ziepe.ca> wrote:

> Now that -mm merged the basic hmm API skeleton I think running like
> this would get us quickly to the place we all want: comprehensive in tree
> users of hmm.
> 
> Andrew, would this be acceptable to you?

Sure.  Please take care not to permit this to reduce the amount of
exposure and review which the core HMM pieces get.

