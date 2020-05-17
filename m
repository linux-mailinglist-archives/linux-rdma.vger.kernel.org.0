Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67D81D6E16
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2020 01:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgEQXhR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 May 2020 19:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgEQXhR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 17 May 2020 19:37:17 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E586FC05BD09
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 16:37:15 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id dh1so28833qvb.13
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 16:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rhcSID2j+mMPo1eCjHjm9iiZ0d4LAEEpHSI1GPqYg/Y=;
        b=VPQBn9NKgYJao0abn/rmhTzV2pVCRd7KVHo+PXFXelPO8YqmC5Um0O/6vKytmD0FF0
         ir2c2igbnvp7/d0phkK3NqMtZRubXq+Wq1w+UIhEdclCh1mgzAJtqTwKWC5syrWwhtEt
         6kzH2KL3WC9gwow8rKUnppmaUHqx3m0j/MZiwkYRbUlgL5heUwlY7tQr8bF+6upsBbx9
         tssKr8gDqi2alvjGnp7ka2nBYxI76XXAcGWA3zJcl4TmSYWxhryFfkZxxXRZryjnwLxc
         4sqnmxVnAZLpRQSRz6i/LWHjKdaTH53G6zIuqEbQqqS7/vFRwblwGEWE444PLSNTahJ6
         D8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rhcSID2j+mMPo1eCjHjm9iiZ0d4LAEEpHSI1GPqYg/Y=;
        b=Yl+iTADdeF04bNzPGHdkeg5tm1K4/hBB53HcVpeVXxW/Z9sAgZX0//yOz7j7Sv5wF/
         AFYdb3o7j+xyWfK742O0qH+WlJaQv0tJaB7xgAoUo2n7zd/hOtH7r2vmcPU/Y2ooAfxI
         brlSB+W0ixMiJC71/H8J2aCO7yVjRFl01U3mawkv/zv/gnrNLE/NJ1dJfbkJE5NLTJB3
         4OIjz3rhXC/hpU48HIekkwEmXO+lLOzHz+KNn56+BT9n+47s55CAbukYUzgQK3LSGKBP
         HIdSqqK7aoZr/g9tfCgayHIrb+YUP6YLSdw40OxrOmAzIZL83lm+K+FEb5m7T6ddT6RA
         HKzA==
X-Gm-Message-State: AOAM532sXkmraj9qeIGTxegl3yKZv93d3uk2VsHxQPUwOYv9d9ZVBqSp
        aBV7Hvb28mSuzD5ToN02QfQRuQ==
X-Google-Smtp-Source: ABdhPJw0H2ewSyNDCoxPXBVL5RnbFsD7L6rVwUKivw0FvSstFquyCJKeBw1QgvPuOD1mRaziZuGd1w==
X-Received: by 2002:a0c:8d48:: with SMTP id s8mr13001802qvb.114.1589758635034;
        Sun, 17 May 2020 16:37:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id o16sm7213457qko.38.2020.05.17.16.37.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 May 2020 16:37:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jaSqH-0005Tj-Mb; Sun, 17 May 2020 20:37:13 -0300
Date:   Sun, 17 May 2020 20:37:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Sagi Grimberg <sagi@rimberg.me>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next v1 00/10] Enable asynchronous event FD per
 object
Message-ID: <20200517233713.GA20969@ziepe.ca>
References: <20200506082444.14502-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506082444.14502-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 06, 2020 at 11:24:34AM +0300, Leon Romanovsky wrote:

>   RDMA/core: Consolidate ib_create_srq flows
>   IB/uverbs: Cleanup wq/srq context usage from uverbs layer
>   IB/uverbs: Fix create WQ to use the given user handle

I took these small fixed to for-next, the others need some minor
adjusting

Thanks,
Jason
