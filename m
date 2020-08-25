Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDE1251D98
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 18:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgHYQxN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 12:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgHYQxK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 12:53:10 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BB8C061574
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 09:53:10 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id 77so11015316ilc.5
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 09:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KedSMyS/GsxCpM9zHmual0N4QYs290Pqahi8Eh0yaWQ=;
        b=DdAgV91j0mtn+d8PTDmQXEjOQ/k/vxTIfi8kH1dUrGh7i96Y+6ZiEpL2octXLIuPfD
         /tZIAiqlPq2EQFvLkPFJGhfYg/UK59dpj/aXZ8h3uM6ibOOnxb3d37WdI3SCMTLEMcwG
         fRFWB26BKrLfhpS/p7OZ/FZYRLvzKJYhuOIwkEWoBFbBn8ZLPcQRW3YCUF1cIl/vwfHV
         jB32HIANNB1fTG5eTCz1SZnEbztpc78ag65qcHAZryX3gMuljbUduQdJ3sN1dubZbGVe
         ruv/y7SR2AQY/dRMqQRB+Wq/NVrK9sE9FdHmQiiMVjWBqyrcDt0g7xU7PlhEk17kgy0x
         Mplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KedSMyS/GsxCpM9zHmual0N4QYs290Pqahi8Eh0yaWQ=;
        b=rGC2lcYhji51zSs/EYMIWIMKLvx9HOe+pWFXHQjIwUbmKbAtMW6MZUs6C2WSuTfF/i
         G2tr+ToTnSzOIVwyFfHw0yBRz02odGaSm/AFidszdeuk2u15gAxjIBu7aYH4YgeRtUa7
         dTSamGDP+V5X+6En4s6FDcyUG3MfRk9ggPleyEdTnBjWEWMKBlorvuFRvgk4skUh/C/8
         al2c8BcDHcqRmbf7WurzHaA1RLFlT5cJTzBeO6IBugIMrn9haHxGtyjj0TAa3iS0u+rA
         7s/qCH8EpRuEST6ed76zBiTK5wx6w9Fq1Q4Nz7BUbRaJt4eX5jHEtnoBlKGbI0fhTzRV
         QE6A==
X-Gm-Message-State: AOAM532hC4zShIvG7Wp+4ndaGCFQK7O5D/tUxL+tk9C9UTRmRIDJOyhU
        urfgt2kusvcNztZlDFi3rQ1gSQ==
X-Google-Smtp-Source: ABdhPJzkTV5SrvQAIZZFJwYlnADYBdMQj8I+tyeBQt+nbPlOF/1+R6rEP+QpjOCwyDc3jSsPoukJ6Q==
X-Received: by 2002:a92:cd0a:: with SMTP id z10mr9480627iln.128.1598374389776;
        Tue, 25 Aug 2020 09:53:09 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id n12sm2719050ion.13.2020.08.25.09.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 09:53:09 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kAcC3-00EiFh-Pl; Tue, 25 Aug 2020 13:53:07 -0300
Date:   Tue, 25 Aug 2020 13:53:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: Re another alternative to resolve hardened user copy warnings
Message-ID: <20200825165307.GI24045@ziepe.ca>
References: <42b0da37-898f-2ca1-ffcb-444b65c9c48d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42b0da37-898f-2ca1-ffcb-444b65c9c48d@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 25, 2020 at 11:37:52AM -0500, Bob Pearson wrote:

> Currently only the rxe driver is exhibiting the issue of kernel
> warnings during qp create caused by recent kernel changes looking
> for potential information leaks to user space. The test which
> triggers this warning is very specific. It occurs when a portion of
> a kernel object stored in a slab cache is copied to user space and
> the copied area has not been 'whitelisted' by setting useroffset and
> usersize parameters for the kmem cache. As already discussed there
> are two ways to mitigate this

I think we should just add a uverbs_copy_to() for integers, much like
netlink does.

We already have various getters for integers..

Jason
