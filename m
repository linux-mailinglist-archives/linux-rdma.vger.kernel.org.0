Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4B51DA5EB
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 02:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgETAAA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 20:00:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgETAAA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 May 2020 20:00:00 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DB0920709;
        Tue, 19 May 2020 23:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589932799;
        bh=AcctfzzOmx7jKiPnxm2Mv0r70W6nYMa1ln1hu/khEgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVba97IEywQkU0aEdc0WOyp6fGyjATtpZPqXqb5PLpknckEzSgCLkUJXJLRQ/tdJC
         G6gQJbUSEIwMnTMZwjSw9bVk6dAJgTcmIxfs9e8CvoM/NXfQPyT4fAKinVA1VXUzg+
         YxaV8bK3yLEumNtBzHJkGG1fN8uM/bmR/DklalNc=
Date:   Tue, 19 May 2020 19:04:46 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] RDMA/siw: Replace one-element array and use
 struct_size() helper
Message-ID: <20200520000446.GB14138@embeddedor>
References: <20200519233018.GA6105@embeddedor>
 <20200519235231.GA31402@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519235231.GA31402@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 19, 2020 at 08:52:31PM -0300, Jason Gunthorpe wrote:
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/infiniband/sw/siw/siw.h     | 2 +-
> >  drivers/infiniband/sw/siw/siw_mem.c | 5 +----
> >  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> Applied to for-next, thanks
> 

Thanks, Jason.

--
Gustavo
