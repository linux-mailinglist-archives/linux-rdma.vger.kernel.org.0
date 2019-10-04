Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B937CC265
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 20:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfJDSQu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 14:16:50 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37446 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbfJDSQu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 14:16:50 -0400
Received: by mail-qk1-f196.google.com with SMTP id u184so6661450qkd.4
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2019 11:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oE8kJevCjFytZL5gkVb9MuZ6rIst5eLpSx35aqrnebg=;
        b=k3uUdgwfl9Cz0kx/EDhh59plZ+l28scx0fVqHmhifNeXUymGqaSl7Uf4puFaTIz2ST
         oa+Vb7NxDocz3oofGxej2mZedKtpy/fJielHurjm8p2w/npL/WpdrLS7bi05YaUwuNv4
         NYQq6tFmutgh1NQzItIp+i9kt2iUGhgjwhHgUldfUNx68xXL1gYaHIhiTxrl2yvGag55
         n2pPwX7wud/ntgUiBYsdUI3bF4eTs4cJDp83ZVc/P7cnBcWLsx70OWDeIHKlvGDqbYnk
         V7j8EWSb1CNc6BFWDW3K9oEKYy95dBGaEcuYfsDye4fgx7J8YlXq3gLWqRefhfCK0dvz
         pxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oE8kJevCjFytZL5gkVb9MuZ6rIst5eLpSx35aqrnebg=;
        b=iv+A+fjJWCntJEA8mQ+lLjm/kbgxPh2+TPe33Tuoqi96yooKVejhgnhzMWM/RaCes4
         OZoQ5ib5bXn6UNB+8gtix+eiTK4OACLE80Z25/6BYuIYuYDGU9Iqxdg8mu9Hn2DAQUSW
         qEtVWqwZ2GjfBPKMMpfKSBS8Rvh4hhUbu1Th7CSOKSNprd5/2f5E2wRilQ3bzE5NGAYK
         5O3Qop1/8Hq+A5Qe2mTiP6Ih7VIEtOya7EfLWp10xdk0uN/isRsB4VQbFrWTve29aPZn
         AcPoj3KriflqGAz9nb52DNFzIQozORmOb0uXsok4AIK9y8ogSPMeZZZVAMArzNY75tS8
         uP8Q==
X-Gm-Message-State: APjAAAUyLOjhq9To51gcepN4FfeMrjq60tkHbe5zDdRUiV77il0s5H9u
        UfGGnyfPGnEp+DQYUIBqLgC/lA==
X-Google-Smtp-Source: APXvYqyLD4FU0kk1pDF8XqG+vg9smodSRU4af+tYKvmuGU4fCYOwPtKL+q2OaApNxmlOwxF2Jqizig==
X-Received: by 2002:a37:2e01:: with SMTP id u1mr11588779qkh.455.1570213009234;
        Fri, 04 Oct 2019 11:16:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id v5sm5089978qtk.66.2019.10.04.11.16.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 11:16:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iGS8G-0007JC-41; Fri, 04 Oct 2019 15:16:48 -0300
Date:   Fri, 4 Oct 2019 15:16:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolas Waisman <nico@semmle.com>
Subject: Re: [PATCH v2] cxgb4: do not dma memory off of the stack
Message-ID: <20191004181648.GA28069@ziepe.ca>
References: <20191001153917.GA3498459@kroah.com>
 <20191001165611.GA3542072@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001165611.GA3542072@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 01, 2019 at 06:56:11PM +0200, Greg KH wrote:
> Nicolas pointed out that the cxgb4 driver is doing dma off of the stack,
> which is generally considered a very bad thing.  On some architectures
> it could be a security problem, but odds are none of them actually run
> this driver, so it's just a "normal" bug.
> 
> Resolve this by allocating the memory for a message off of the heap
> instead of the stack.  kmalloc() always will give us a proper memory
> location that DMA will work correctly from.
> 
> Reported-by: Nicolas Waisman <nico@semmle.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied to for-rc, thanks

Jason
