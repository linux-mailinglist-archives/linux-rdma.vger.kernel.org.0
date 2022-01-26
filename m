Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3025F49CE2C
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jan 2022 16:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242806AbiAZP2J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jan 2022 10:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242798AbiAZP2J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jan 2022 10:28:09 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E7AC06161C
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jan 2022 07:28:09 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id g145so13186566qke.3
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jan 2022 07:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FoWrTy2NWPKvjNHcEknybF2wtcmlUtXoCJlZwJCG5OE=;
        b=GtHWe2YVWL3jzXyS54H21ibG3LiQO5j7gUanYx5kCO6jO/JCAGeWc0rnVOCuv7fBx7
         hUDXddwyQON5gNe65uBrSPyUpXnhsHaGSQFQ1sLXd57j/JOPiUVePpvfTPFvYmkw94kG
         bARNvxZe+ptiFnWC2hCP/jfc9n2TxjVvyMPvd8yHvwG7iLP16EH0qHHbTed/nnSHL6o/
         nH0w4wa76hoQqChfUzsVyOp/Ge0UPCL47f8Hlsx7Dz304DMpKuozbHj4AGfPvaUb7+VS
         1AxidQ93Oyn5BI+mokqBol82xw5syJqX6AzHv/3DPRu3seZlIRWSz9EzxYlIgBCzboSW
         IGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FoWrTy2NWPKvjNHcEknybF2wtcmlUtXoCJlZwJCG5OE=;
        b=cCTMygYJfMlnUypShMFsiSKsm2A20Qqz2wOcaTAcJmcTfgcFMnul4E/AHJz3G3Ydbh
         5pVqKC0h+OdUg04cJAAn0Lm4FjM2Lc/avB1z8g4gKwoFNfaBUaWn8vkFfbZ/MSHvc0y8
         Kk1qSoqsM6oDakf2h0adbpOwsWHtonjOn4MLNlpzBAzp6dNHq/yzc8m1wK/xPvxPIH8q
         kaEN1uQIrZm3WL9ecnliEZvXxN5VFSKnocM+cn64pUfbf67zH3tbwGGjpZfG9eRu5ZwV
         +DkMRCFur2MaoP1E3NrSioAMiNwBErLTNXHgKE6VkRgUEQ6EmFS+jAWOGbS4+V3hzAPy
         vg0A==
X-Gm-Message-State: AOAM533/Fsnt1KP6tQ5NtrkiuFfDbX9xY3+t6LK8wqHuyY5jPTf0Sfhw
        VEmj+K2qdslvOV5FZmbSiSB/xw==
X-Google-Smtp-Source: ABdhPJzErmrOoHL7PaptmlxZjACbWTRVC80bJyoHWddltsUtiBYAkYOaly9k+QWsLg1aqmVP99s88g==
X-Received: by 2002:a05:620a:668:: with SMTP id a8mr8261127qkh.202.1643210888346;
        Wed, 26 Jan 2022 07:28:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id a141sm4515686qkc.73.2022.01.26.07.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 07:28:07 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nCkDO-005Zah-Si; Wed, 26 Jan 2022 11:28:06 -0400
Date:   Wed, 26 Jan 2022 11:28:06 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tony Lu <tonylu@linux.alibaba.com>
Cc:     Leon Romanovsky <leon@kernel.org>, kgraul@linux.ibm.com,
        kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [RFC PATCH net-next 0/6] net/smc: Spread workload over multiple
 cores
Message-ID: <20220126152806.GN8034@ziepe.ca>
References: <20220114054852.38058-1-tonylu@linux.alibaba.com>
 <YePesYRnrKCh1vFy@unreal>
 <YfD26mhGkM9DFBV+@TonyMac-Alibaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfD26mhGkM9DFBV+@TonyMac-Alibaba>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 26, 2022 at 03:23:22PM +0800, Tony Lu wrote:
> On Sun, Jan 16, 2022 at 11:00:33AM +0200, Leon Romanovsky wrote:
> > 
> > Please CC RDMA mailing list next time.
> > 
> > Why didn't you use already existed APIs in drivers/infiniband/core/cq.c?
> > ib_cq_pool_get() will do most if not all of your open-coded CQ spreading
> > logic.
> 
> I am working on replacing with ib_cq_pool_get(), this need ib_poll_context
> to indicate the poller which provides by ib_poll_handler(). It's okay
> for now, but for the callback function. When it polled a ib_wc, it
> would call wc->wr_cqe->done(cq, wc), which is the union with wr_id. The
> wr_id is heavily used in SMC.

Part of using the new interface is converting to use wr_cqe, you
should just do that work instead of trying to duplicate a core API in
a driver.

Jason
