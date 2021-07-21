Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCFA3D0988
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 09:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhGUGem (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 02:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbhGUGdx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jul 2021 02:33:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7C1C061574;
        Wed, 21 Jul 2021 00:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o4z5O5oVLmWvrpTw0QZXLTi68f1f34aOPbcSzXth/Yk=; b=M0rZgzB2Ma/0G7d/eBEGAZHl/y
        AdFgECs0mCEP4pLXjlC49SnEa56Fxnxve/f7j/29gZdSTEr9K5gYXGw9NlSAF9wxwig3Chq8Pjkg3
        5AAIoiGcRECjdZmNSjamC7w2Gb90Hb5E/98cpoBRhWfcMwugst1quuSRP5ilM3xzfL439lB40aGFb
        TpHj0lGlvqZcNyCvSeYepYLtMNvhBIItTLuHhypUIE6QZSAzDpegVwuAKtWxrMM8lgeL33LfKFkk6
        f/zwcOVp3r2+d6LRwq/3nCrreSMIJNWw/HHnt/0Vj4O39DegdZbBtdDkTdkhF+D+wQPJuHDAo5vWc
        otOD2PLQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m66PD-008ucF-C9; Wed, 21 Jul 2021 07:12:37 +0000
Date:   Wed, 21 Jul 2021 08:12:35 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH rdma-next 7/7] RDMA/core: Create clean QP creations
 interface for uverbs
Message-ID: <YPfI4+M/Ula5a0KZ@infradead.org>
References: <cover.1626846795.git.leonro@nvidia.com>
 <8eaf125d3bfb463e1641b6f2794203cc93d76c90.1626846795.git.leonro@nvidia.com>
 <YPfDUN6CaOdGZLPS@infradead.org>
 <YPfHXpFtB1RJ4yjU@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPfHXpFtB1RJ4yjU@unreal>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 21, 2021 at 10:06:06AM +0300, Leon Romanovsky wrote:
> You will need to add some sort of "if qp tpye" for ib_create_qp_uverbs() callers,
> because they always provide udata != NULL. 
> 
> After this series, the callers look like this:
> 
>  1438         qp = ib_create_qp_uverbs(device, pd, &attr, &attrs->driver_udata, obj);
>                                                           ^^^^^^^^^ not NULL
> 
> So instead of bothering callers, I implemented it here with one "if".

Sorry if my mail was confusing.  I don't want it in the callers, I
want it as deep down in the stack as possible instead of having the
strange wrapper.
