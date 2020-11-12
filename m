Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623582B0666
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 14:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgKLNZQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 08:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgKLNZQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Nov 2020 08:25:16 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C2EC0613D1
        for <linux-rdma@vger.kernel.org>; Thu, 12 Nov 2020 05:25:15 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id g15so3851731qtq.13
        for <linux-rdma@vger.kernel.org>; Thu, 12 Nov 2020 05:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vkv5jtIJud+QIqcEKAOrz49oEiKkFPAoACrsXa1ygRI=;
        b=Y+8FL3R3aa2iCZyQyaVvGjWPzY6Z3jTlOk9UvCp0XbmnptOo8ioxNJ342L9eRV87/v
         kBr7Uc3IcB3jLIhgBWj1JLHFlzjPn0ONvp4KvsrXBnvBpM1bbAQYW80fTqopVwzy7/QL
         v145ule18cZqgJGNSFTRfnRLoNxnfkxGCv93Qk+prb4/ElemeYtnlRkwMxXSTIaZ2+et
         7uTa75c1MGuYO6AE50dBzd6nJ7UOsGsItaUtEd1GToXwyuwnyUraDj3IyQ6RLvWLuc7e
         C8Y2B8b1gQCO5U6HOpbcp7psDZG3km2Wm82VXZqxWnB0n4UhGhU+sr85efHvVAPMlDt4
         j5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vkv5jtIJud+QIqcEKAOrz49oEiKkFPAoACrsXa1ygRI=;
        b=SOSG0ylqkrVkDdqCF1rywgjueJvfKw92TG91MjdEC0XdbvcPcXKcjesSEfnbreAnSR
         0Io3ISwf1pTAaCWcJLBshg3a5anp2CUCtDSCMrZUREyJBrfGM7+iIRLnL3I0HD7ZzFZz
         jbWI7sHojwP/rpK/LIe4khE12VnRDtnwtsw17UfioCmDNXHv2Py6gxoCcptAHbtBLeog
         D+W18yIqMWnVbFY46uO188ip8Pl9LzMJB1auh9rJg13JFCcKoVr+3cIo0zh/HAVoQfaR
         0PutE/GkOUKi6HZEC7Nbgd2D8m5bhCBjjAZ0GfU/xiYcPoM/HhCHeWlpnyb9P4cmmJz1
         Cpyw==
X-Gm-Message-State: AOAM533L31tcmqpNf2uBvF3MKsB4y498P/ZZTSori69XixbR8JrEVAsJ
        BWqJtDIvh6yjUtvHrEGLo4xliw==
X-Google-Smtp-Source: ABdhPJwYDJZ9CsmJHHji4+pBSpYm8kKmHl05XRyzWDUaADZStBu1Fbw/SJ8cr66iCQGhH6tHaJ1vNw==
X-Received: by 2002:a05:622a:254:: with SMTP id c20mr5230454qtx.335.1605187515293;
        Thu, 12 Nov 2020 05:25:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id w45sm5038843qtw.96.2020.11.12.05.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 05:25:14 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kdCbC-003frw-5j; Thu, 12 Nov 2020 09:25:14 -0400
Date:   Thu, 12 Nov 2020 09:25:14 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [PATCH v10 6/6] dma-buf: Document that dma-buf size is fixed
Message-ID: <20201112132514.GR244516@ziepe.ca>
References: <1605044477-51833-1-git-send-email-jianxin.xiong@intel.com>
 <1605044477-51833-7-git-send-email-jianxin.xiong@intel.com>
 <20201111163323.GP401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111163323.GP401619@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 11, 2020 at 05:33:23PM +0100, Daniel Vetter wrote:
> On Tue, Nov 10, 2020 at 01:41:17PM -0800, Jianxin Xiong wrote:
> > The fact that the size of dma-buf is invariant over the lifetime of the
> > buffer is mentioned in the comment of 'dma_buf_ops.mmap', but is not
> > documented at where the info is defined. Add the missing documentation.
> > 
> > Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
> 
> Applied to drm-misc-next, thanks for your patch. For the preceeding
> dma-buf patch I'll wait for more review/acks before I apply it. Ack from
> Jason might also be good, since looks like this dma_virt_ops is only used
> in rdma.

We are likely to delete it entirely this cycle, Christoph already has
a patch series to do it:

https://patchwork.kernel.org/project/linux-rdma/list/?series=379277

So, lets just forget about it

Jason
