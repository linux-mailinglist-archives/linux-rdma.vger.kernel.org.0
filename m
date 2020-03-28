Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 887C5196473
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2020 09:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgC1I3z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Mar 2020 04:29:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgC1I3z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 28 Mar 2020 04:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+igT2kxW2gBvpAlcI2eurOCOxaEw7SDLgmrIKT83fz4=; b=Duy0gRPxaKjMDFNi5Oj77LX4ZI
        LDnW2wFkmwbId9ZAiua6W+w1EeedLnEBHjB0EK92E0eT9BpTfYLCz+wVabiHsvKn/AtTz0BmrsIMi
        +LJw65yeW8ND7J/691AQQIScnXJeKG6Y2ADIKwfy2dEDDcFOMVZwTZegEpTHKecbr/8DDVCJhhmP7
        lGuvixYTHg6B+TtaG76gC6tShFuj41NbK8fp4vxU7wIXepm4cSuu515IeX6yS3JEc5DaPXkem12Gf
        Jc1LHx+saBz0I1Bju7og4dMkbiSs+iTltUusK8B12x516RSgHmQSJ9GOQglYS2O4SXI+5yHE4HVuu
        Nv8rMOwg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jI6qn-0004Vo-K8; Sat, 28 Mar 2020 08:29:53 +0000
Date:   Sat, 28 Mar 2020 01:29:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: Re: [PATCH v11 15/26] block: reexport bio_map_kern
Message-ID: <20200328082953.GB16355@infradead.org>
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-16-jinpu.wang@cloud.ionos.com>
 <15f25902-1f5a-a542-a311-c1e86330834b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15f25902-1f5a-a542-a311-c1e86330834b@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 27, 2020 at 08:58:09PM -0700, Bart Van Assche wrote:
> On 2020-03-20 05:16, Jack Wang wrote:
> > To avoid duplicate code in rnbd-srv, we need to reexport
> > bio_map_kern.

NAK.  If you need this helper you are doing something wrong.  What is
the use case where a simple bio_add_page loop won't work?

