Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D317CC3A4
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 21:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbfJDTg0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 15:36:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:48812 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730612AbfJDTg0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Oct 2019 15:36:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DAA3AAD18;
        Fri,  4 Oct 2019 19:36:24 +0000 (UTC)
Date:   Fri, 4 Oct 2019 12:35:15 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michel Lespinasse <walken@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next 00/11] lib/interval-tree: move to half closed
 intervals
Message-ID: <20191004193515.5kfq3un37gbtpm2o@linux-p48b>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        Michel Lespinasse <walken@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org
References: <20191003201858.11666-1-dave@stgolabs.net>
 <20191004002609.GB1492@ziepe.ca>
 <CANN689G3chM1FjFPdCNm9_OQxazs7YP1PuZLpqGtq=qzaZ0Hbw@mail.gmail.com>
 <20191004160347.GH32665@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191004160347.GH32665@bombadil.infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 04 Oct 2019, Matthew Wilcox wrote:

>On Fri, Oct 04, 2019 at 06:15:11AM -0700, Michel Lespinasse wrote:
>> My take is that this (Davidlohr's) patch series does not necessarily
>> need to be applied all at once - we could get the first change in
>> (adding the interval_tree_gen.h header), and convert the first few
>> users, without getting them all at once, as long as we have a plan for
>> finishing the work. So, if you have cleanups in progress in some of
>> the files, just tell us which ones and we can leave them out from the
>> first pass.
>
>Since we have users which do need to use the full ULONG_MAX range
>(as pointed out by Christian Koenig), I don't think adding a second
>implementation which is half-open is a good idea.  It'll only lead to
>confusion.

Right, we should not have two implementations.

Thanks,
Davidlohr
