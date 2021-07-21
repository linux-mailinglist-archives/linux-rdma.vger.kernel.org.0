Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EF73D0945
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 08:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhGUGQW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 02:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229920AbhGUGQV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Jul 2021 02:16:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0871601FC;
        Wed, 21 Jul 2021 06:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626850618;
        bh=NBY/luiKtwwB80bjedhG96TJvETtvOxecmknE8Z6LME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pfTtXIg3v++XYX/9Af1oV8ddTQc9JPBRCZeGWFcZpZi/Xq04cN18//kYlLxZ6GX0f
         UzujRZ6oxH2Eng47xwvDjW9pzJdZjJ5oBp1A8dmQ81W0n43oqdYlHXSsgsptLcIdwL
         Q6EtgLbnaGzXOBMbZae/A8vM3toia/QHdHGioryM6Acf042NchHrLhq4Nj5XLY0dGC
         5QfDBjvrbvET7McTNEfto0jyXLBCLofSNUjdwvZbmBk+wRyx6EJdHBTwfhO5DwUfwv
         QM86uhZbwV3lMiFQ3Y3sN+Dsacmj8zbvQFdgkwtCTSdRRWO/OGRe82Om1w465ERbrW
         5WBEuHHAmLqtA==
Date:   Wed, 21 Jul 2021 09:56:54 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH rdma-next 3/7] RDMA/core: Remove protection from wrong
 in-kernel API usage
Message-ID: <YPfFNvdw/UPNR9Mb@unreal>
References: <cover.1626846795.git.leonro@nvidia.com>
 <8084238e374fe487c3f9728c2ee5ec8736c204d5.1626846795.git.leonro@nvidia.com>
 <YPfBiDdghnRwSjwG@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPfBiDdghnRwSjwG@infradead.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 21, 2021 at 07:41:12AM +0100, Christoph Hellwig wrote:
> On Wed, Jul 21, 2021 at 09:13:02AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > The ib_create_named_qp() is kernel verb that is not used for user
> > supplied attributes. In such case, it is ULP responsibility to provide
> > valid QP attributes.
> > 
> > In-kernel API shouldn't check it, exactly like other functions that
> > don't check device capabilities.
> 
> Hmm.  These still looks like useful debugging checks.

All in-tree ULPs already set properly based on device capabilities.

Thanks
