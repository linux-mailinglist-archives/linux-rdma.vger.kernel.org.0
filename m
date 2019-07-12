Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D99F66FE1
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 15:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfGLNTe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 09:19:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfGLNTe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jul 2019 09:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+B8h4Iz6ru/chORA1eax9a8LOD242SI/Y9Vwa/AMfAc=; b=uNpMthTv5WiPKImJMY7yrm8f9
        ugaiYOydOgutz9+Qeha+7aq6QZdbe+iwIdaD2KR7yXSBLK5P4KMm4n/vx1G1bQ69NR/HpagCuGR8T
        taWweVNCxzr/xoFgH2AfmLgNNYEhHbMb1WXDEbeDpWbMZo77D2shcue6HVmoXnHVRA9BcLgzZlx28
        4UEFzd0+X5BxhUfwBjJt95/2q/vBSKgqtu+z9saWEHI23HXrWOl5wWwd6wOfeVClxDLt3rfxXnUva
        LHk3AM6H4D4iiHDE2nvJ/dT/czNHpAb8x8RS7YJzdFkuRP19IaWc96ZNP69Vb4CeYBOzAnoqZK33C
        sARK7gg7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlvSW-0002zt-SV; Fri, 12 Jul 2019 13:19:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 03C4C209772E6; Fri, 12 Jul 2019 15:19:30 +0200 (CEST)
Date:   Fri, 12 Jul 2019 15:19:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] rdma/siw: avoid smp_store_mb() on a u64
Message-ID: <20190712131930.GT3419@hirez.programming.kicks-ass.net>
References: <20190712120328.GB27512@ziepe.ca>
 <20190712085212.3901785-1-arnd@arndb.de>
 <OF05C1A780.433E36D1-ON00258435.003381DA-00258435.003F847E@notes.na.collabserv.com>
 <OF36428621.B839DE8B-ON00258435.00461748-00258435.0047E413@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF36428621.B839DE8B-ON00258435.00461748-00258435.0047E413@notes.na.collabserv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 12, 2019 at 01:05:14PM +0000, Bernard Metzler wrote:
> @@ -1131,6 +1131,10 @@ int siw_poll_cq(struct ib_cq *base_cq, int num_cqe, struct ib_wc *wc)
>   *   number of not reaped CQE's regardless of its notification
>   *   type and current or new CQ notification settings.
>   *
> + * This function gets called only by kernel consumers.
> + * Notification state must immediately become visible to all
> + * associated kernel producers (QP's).

No amount of memory barriers can achieve that goal.
