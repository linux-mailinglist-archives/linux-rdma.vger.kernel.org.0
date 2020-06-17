Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9B01FC8D3
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 10:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgFQIex (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 04:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgFQIex (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jun 2020 04:34:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680B2C061573;
        Wed, 17 Jun 2020 01:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P9h4/lJWY5ar1P99gGNzdzvo8L/3FzSkbgpi/qstzS0=; b=X047MCRD9zFtWhe9wWozOU8dYR
        R+C2KKBmpwd74/A0PeX/oLkzyLWz+DBG/l3tW1Qdz0jNxJDUxfCM/UO8Tp+L23mtZPVX3bGWYksp6
        DUK7COc2UzL7g8zRxWYVRXMuoQsDSA5z3t5wDUxNKZ+YUr3eaPnHP4h+5JAI017GGt8i8QBR+UjGE
        w+YZwm5IXuVuXVH6yzr7Gh4M+AqRNsEp/2V1NcH0VhyLCzSTAUCzEsjfetlr9OCTdUeSFxNwUxag9
        5WmlGTK52iSsP/WzZMezm0yRjRtR/gDen38Lw6vUbrF3L00ZzlKnVqLLOH8eZDd2cjlBGPkeDC1Vk
        2IQAANfg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlTX0-0006j9-EU; Wed, 17 Jun 2020 08:34:50 +0000
Date:   Wed, 17 Jun 2020 01:34:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next 0/7] Introduce KABIs to query UCONTEXT, PD and
 MR properties
Message-ID: <20200617083450.GA25700@infradead.org>
References: <20200616105531.2428010-1-leon@kernel.org>
 <20200617082916.GA13188@infradead.org>
 <20200617083138.GI2383158@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617083138.GI2383158@unreal>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 17, 2020 at 11:31:38AM +0300, Leon Romanovsky wrote:
> On Wed, Jun 17, 2020 at 01:29:16AM -0700, Christoph Hellwig wrote:
> > I think you are talking about UABIs (which in linux we actually call
> > uapis).
> 
> Yes, I used Yishai's cover letter as is.

Why can't he just posted his patches himeself?  And if you forward it
you could actually add value by fixing up obvious issues :)
