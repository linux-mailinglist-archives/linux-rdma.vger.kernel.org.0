Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28E225BAA7
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 07:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgICF4B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 01:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgICF4A (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 01:56:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B8DC061244
        for <linux-rdma@vger.kernel.org>; Wed,  2 Sep 2020 22:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vzV5RvOassPCslV+mJ0hYI9SLP7NiWzyhjHZJ1Jw+g4=; b=J0091bcpTkO0Cpw1aU01fhKctQ
        B3LKcMaS6ezEWTJbnXQRr5K4xN11ngLAGFg4qKupaE/d7J97v+Txv1qBxGxQ9/QdzPcyN0WP1MfL1
        P7i9aLouHgGJT7ktCP6cmpsTB3DithgjQlr/KreSDHgAR1BYiba874kmPSq2DmLQ0G6AjrzjK/8nK
        HodmZTADf+mjOxCqZ1/Om8d7lIrOb2NGrysGhtJGsXX8C6cd47GaY/gZFwKuCEmsPaDQuZq2prtnL
        YQT4YVy8dGLaTSsytJ7TviBiyBnw/Qq4+PkTu5r6O1csAiOpu02ki7jOiOIVnp6nVq0Lgov+KyB9U
        EEb6jv+g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDiDp-0008GT-2y; Thu, 03 Sep 2020 05:55:45 +0000
Date:   Thu, 3 Sep 2020 06:55:45 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
        Stephen Rust <srust@blockbridge.com>,
        Doug Dumitru <doug@dumitru.com>
Subject: Re: [PATCH v2] IB/isert: fix unaligned immediate-data handling
Message-ID: <20200903055545.GA31262@infradead.org>
References: <20200901030826.140880-1-sagi@grimberg.me>
 <20200902185333.GA1420661@nvidia.com>
 <780aa197-e377-ea0b-1fdd-8619057003e8@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <780aa197-e377-ea0b-1fdd-8619057003e8@grimberg.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 02, 2020 at 03:06:44PM -0700, Sagi Grimberg wrote:
> I don't have the exact bisection, the original report mentioned:
> 3d75ca0adef4 ("block: introduce multi-page bvec helpers")
> 
> But I cannot explain what in that patch caused this.

That way how the multi-page bvec helpers work rely on aligned transfers,
so for the ramdisk driver this might be the root cause.  OTOH we have
reports for xen block device where unaligned I/O causes corruption which
basically go back to day 0.
