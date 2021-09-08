Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF6340343D
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Sep 2021 08:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347650AbhIHG2c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 02:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbhIHG2b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Sep 2021 02:28:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAA3C061575;
        Tue,  7 Sep 2021 23:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u2wyT7IFTnz7oIOwl/Ad2kuIIW4qaVDiD603kQr+kus=; b=d0NYOvk4s9M6hHE6ZgFR1s4sGm
        aRD72MMXGIMUn3isbRoA8JNLI49n+5zFN+G8rnAuAm6WZ2tETCDUXWeTTOORZXyGVsaLAGJD8/hg/
        /A2Ktud4nRhG0FDWrGILC1Nb+lUSgpGNud0xmZsCqqagv58Ke9BpYqxucB9vTSESdHhYKqlUO68WY
        WqvHWIx+jVo0+mOiIwH5eSMcADPT0g8ryqQHcfO3QtimTIW0zX4ccGgVLkgdda1lwtfVFeiJyPtwB
        jBtIB/5NjCbLpQpQNrI5MKQWwcY+uAht/6KB23F+XaGL8dgewqvYF5ng7Sdlp/3l7yWQTCfFSEF14
        mArq+rcw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNr23-008Z1A-B7; Wed, 08 Sep 2021 06:26:18 +0000
Date:   Wed, 8 Sep 2021 07:26:03 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Christian K??nig <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        dhobsong@igel.co.jp, taki@igel.co.jp, etom@igel.co.jp
Subject: Re: [RFC PATCH 1/3] RDMA/umem: Change for rdma devices has not dma
 device
Message-ID: <YThXe4WxHErNiwgE@infradead.org>
References: <20210908061611.69823-1-mie@igel.co.jp>
 <20210908061611.69823-2-mie@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908061611.69823-2-mie@igel.co.jp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 08, 2021 at 03:16:09PM +0900, Shunsuke Mie wrote:
> To share memory space using dma-buf, a API of the dma-buf requires dma
> device, but devices such as rxe do not have a dma device. For those case,
> change to specify a device of struct ib instead of the dma device.

So if dma-buf doesn't actually need a device to dma map why do we ever
pass the dma_device here?  Something does not add up.
