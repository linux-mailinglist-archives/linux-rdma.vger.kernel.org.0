Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB50393D65
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 09:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhE1HDN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 03:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhE1HDM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 03:03:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC91C061574
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 00:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CquKbK98Pry/DkMvMWqOsGpqTI11cMBOyYp/E1VsvjE=; b=dWtBptgCT2YQI3oPAJABowzcFC
        qcn85lZMPKMh6+AcDJGscj1N+LBvkhbJZlzmiE2C9Wy0RUNGZoQqwLC6+xZaWRVhsnFvAlljPvgCv
        0/SnJ8ZAhuIfq+ND7uneuXpCfpGBRp7QEPIHgmG9N0oubceDNZQNhgBTqJBvEOGnAT5x+17OY7bFI
        C1R+jBO6CKZVO44K/+6dj2r6T4VkT5hp4bukfv3FA8cXGZvE4/a9ka47dc2ejtEKfShw3hHpYl3kX
        3QIYmaocdmqeofQfHRWi/G6+NVvLYeyB5xjroUwM4ZqiN1La49ne03JcwmtqKsT4i0gy23eDVTTD9
        cm7lYBJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lmWUa-001FzF-Sa; Fri, 28 May 2021 07:01:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E13330022C;
        Fri, 28 May 2021 09:01:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D8DB12011BE56; Fri, 28 May 2021 09:01:17 +0200 (CEST)
Date:   Fri, 28 May 2021 09:01:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     liweihang <liweihang@huawei.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
Subject: Re: [PATCH v3 for-next 13/13] RDMA/rdmavt: Use refcount_t instead of
 atomic_t on refcount of rvt_mcast
Message-ID: <YLCVPZazm+3pAqgf@hirez.programming.kicks-ass.net>
References: <1621925504-33019-1-git-send-email-liweihang@huawei.com>
 <1621925504-33019-14-git-send-email-liweihang@huawei.com>
 <CH0PR01MB715336ACBA211A001E362E6BF2239@CH0PR01MB7153.prod.exchangelabs.com>
 <20210527131558.GB1002214@nvidia.com>
 <8de36c1f7a0a4e839c6151b0963a894b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8de36c1f7a0a4e839c6151b0963a894b@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 28, 2021 at 03:58:42AM +0000, liweihang wrote:
> Peter, could you please explain why you said "add_return and sub_return are
> horrible interface for refcount"?

What would you need them for? The only special value is 0. Once you hit
0 the object is dead and you cannot revive.

If I look at drivers/infiniband/sw/rdmavt/mcast.c, which seems to be the
relevant file, the thing that's called ->refcount is not in fact a
reference count.
