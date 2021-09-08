Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270D640352E
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Sep 2021 09:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347877AbhIHHWd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 03:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347425AbhIHHWc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Sep 2021 03:22:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6421BC061575;
        Wed,  8 Sep 2021 00:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mtSKj36IL1qd4ZjB9aH2PMck4nVJTWLq/fv+o2UE00w=; b=PGPYATYTF46SLSYRW3M473O0LA
        11RKEANEL7AjfccMC9AzDWmTOeAKiOdctdQAbr+gAS3jguCXnhiZFovXskABT9mnY5NODakv0gBqC
        u4KOc8o8ZhZnrwXVmv2QJ9nuXiPirrKYA0oWKZxz0lPMQ2BSoMA1gHXBvk8v9N9PYscAffke8Khh9
        0PqVl5dnTxVkhW3jGR1UFQ+Slzd1i1q7T2hAEGdlIupR3ftssdXSJOV2N11irQUyMEpeq8qP06yFu
        oOeiZPfzxVvmMvcvp2Ja6kS53NR4iUJHl7FlW9KeA795XeOl11QJZiZCenQ2aMQaMIiuhFGFHxTnp
        2/bOWQfA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNrrT-008bJz-0e; Wed, 08 Sep 2021 07:19:26 +0000
Date:   Wed, 8 Sep 2021 08:19:11 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Christian K??nig <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>,
        Tomohito Esaki <etom@igel.co.jp>
Subject: Re: [RFC PATCH 1/3] RDMA/umem: Change for rdma devices has not dma
 device
Message-ID: <YThj70ByPvZNQjgU@infradead.org>
References: <20210908061611.69823-1-mie@igel.co.jp>
 <20210908061611.69823-2-mie@igel.co.jp>
 <YThXe4WxHErNiwgE@infradead.org>
 <CANXvt5ojNPpyPVnE0D5o9873hGz6ijF7QfTd9z08Ds-ex3Ye-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXvt5ojNPpyPVnE0D5o9873hGz6ijF7QfTd9z08Ds-ex3Ye-Q@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 08, 2021 at 04:01:14PM +0900, Shunsuke Mie wrote:
> Thank you for your comment.
> >
> > On Wed, Sep 08, 2021 at 03:16:09PM +0900, Shunsuke Mie wrote:
> > > To share memory space using dma-buf, a API of the dma-buf requires dma
> > > device, but devices such as rxe do not have a dma device. For those case,
> > > change to specify a device of struct ib instead of the dma device.
> >
> > So if dma-buf doesn't actually need a device to dma map why do we ever
> > pass the dma_device here?  Something does not add up.
> As described in the dma-buf api guide [1], the dma_device is used by dma-buf
> exporter to know the device buffer constraints of importer.
> [1] https://lwn.net/Articles/489703/

Which means for rxe you'd also have to pass the one for the underlying
net device.
