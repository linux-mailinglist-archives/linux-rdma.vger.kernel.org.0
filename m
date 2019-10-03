Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4713BCB02F
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 22:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388688AbfJCUcy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 16:32:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33282 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbfJCUcy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Oct 2019 16:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DuwMGQIzbvieUCH04dpyi9AiTx6jv704Pfn5oVeJ17U=; b=RYxhot7mP0JyjcYaAZEScfO1B
        6EJMyUWXlNdT3UDcTvRnHCNreWLXGGY7iNXJWyn8XMRiBWuyKwXKAiNt97SK5zlHmjecIp1vV4QWf
        3MMmDQuoXudCRIc3Pntnzk2D+nvYpA8R+DX19eIvAyEP60ti312vCUTZKPIKYOvqoGA7oPhRxWmsb
        1wYUz+J1z5n5H4HBkA3jKBidq9Notx4vPfLBTylntN2b7ob3ZWf6Kqj8qAvdy6F2hUPeIbiIPuwzR
        7gp1Xw/1/mREnXHy2ysx3SPtsTRHHROdIH4BPHiovRiPo+t+ICndCH/x22GYqYbq3CHBGXVgVRR/X
        UqAc4SSkg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iG7mM-0006xH-SJ; Thu, 03 Oct 2019 20:32:50 +0000
Date:   Thu, 3 Oct 2019 13:32:50 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, walken@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next 00/11] lib/interval-tree: move to half closed
 intervals
Message-ID: <20191003203250.GE32665@bombadil.infradead.org>
References: <20191003201858.11666-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003201858.11666-1-dave@stgolabs.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 03, 2019 at 01:18:47PM -0700, Davidlohr Bueso wrote:
> It has been discussed[1,2] that almost all users of interval trees would better
> be served if the intervals were actually not [a,b], but instead [a, b). This

So how does a user represent a range from ULONG_MAX to ULONG_MAX now?

I think the problem is that large parts of the kernel just don't consider
integer overflow.  Because we write in C, it's natural to write:

	for (i = start; i < end; i++)

and just assume that we never need to hit ULONG_MAX or UINT_MAX.
If we're storing addresses, that's generally true -- most architectures
don't allow addresses in the -PAGE_SIZE to ULONG_MAX range (or they'd
have trouble with PTR_ERR).  If you're looking at file sizes, that's
not true on 32-bit machines, and we've definitely seen filesystem bugs
with files nudging up on 16TB (on 32 bit with 4k page size).  Or block
driver bugs with similarly sized block devices.

So, yeah, easier to use.  But damning corner cases.
