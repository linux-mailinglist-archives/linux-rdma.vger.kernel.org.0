Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948673E14A4
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Aug 2021 14:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238790AbhHEMX3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 08:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhHEMX2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Aug 2021 08:23:28 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08DBC061765
        for <linux-rdma@vger.kernel.org>; Thu,  5 Aug 2021 05:23:14 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id a19so6015194qkg.2
        for <linux-rdma@vger.kernel.org>; Thu, 05 Aug 2021 05:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S4zS+s1qVPIzTO0H85R2WuDkxmB2UlVm9z/KPt196HA=;
        b=gp1H1Kzu98qgl2JIh9eTpxSNNmyA04LWKuZuMpDS+Lb3EPFLVquROPmsgbu4VZW0/g
         2jppRAXJYrnyb3MhnBRIck40kopbFuXU7EPzz7naWo7ScJuIF3jaftVPI5KUyM4JIemt
         wOHrKalIV0dzkH0x16xndWc7NuRnPraMNxpRCCxrw7N5zi3/dLTN776SJxHy5EcIAMOA
         51GhF4K4pXsVb6HRR+IvqpTPvkitX76Ue4VRqBfFtqZ4au5/2TthkzsHM04k13kVFJYt
         Xad67ihS1wXfF+8xpHlllgFuEy5G0dlaYijKkKlsO7+5mjs0tTezay46BKWtfV3QCQk1
         0Osg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S4zS+s1qVPIzTO0H85R2WuDkxmB2UlVm9z/KPt196HA=;
        b=VS1BX8E4Ii7wjeyAvC+H73Z6hxRS1l1QvkMkcvtGWoeVc/rore9LdAAQ38FD+rpvDQ
         b+kzOWMikc2E6UmRGa0fcxVyu+T66bjGYTQxlYZJITkMNjlAhBIizyRVEKay4rWZxiaO
         +ERq4F5t+bN1uOU4/q5I7K6+KFheKV9GVatjz7JjywKZ5yTEd0M9FXBrbmv+fK/aZ4Iz
         cvTsk/dbvjWnPxwDBwCT5e1Et+AIiiyy8k8MiS9DZIg6oxAZjeMK5E4iKrKv+5YYLxgc
         4T/FEY0jQLGdU/AEkeR/LQh5EXKfcxnMOAE/C6cSeOotQuJKKdGBlN7wKRYBb8HpZ6dT
         dH7Q==
X-Gm-Message-State: AOAM531AgEp/gqluHzxBBCdQDSoLVJFUosHClhCfa9ocaGw+2PYCsLgK
        czU/FiWZ8HetPJiaRTsUFuO+WQ==
X-Google-Smtp-Source: ABdhPJxPIESMe5yJCgv2TXoZZfltC98kYkOgvO1xmCb/FWPcCG+PZuA3W3UuQqsJ9qs5i04epGgJCg==
X-Received: by 2002:a05:620a:4441:: with SMTP id w1mr4556493qkp.272.1628166193934;
        Thu, 05 Aug 2021 05:23:13 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id g26sm2886229qkm.122.2021.08.05.05.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 05:23:13 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mBcP1-00DJR7-IM; Thu, 05 Aug 2021 09:23:11 -0300
Date:   Thu, 5 Aug 2021 09:23:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, liangwenpeng@huawei.com,
        liweihang@huawei.com, dledford@redhat.com, chenglang@huawei.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/hns: Fix return in hns_roce_rereg_user_mr()
Message-ID: <20210805122311.GJ543798@ziepe.ca>
References: <20210804125939.20516-1-yuehaibing@huawei.com>
 <YQqb0U43eQUGK641@unreal>
 <f0921aa3-a95d-f7e4-a13b-db15d4a5f259@huawei.com>
 <YQtdswHgMXhC7Mf5@unreal>
 <974d3309-3617-6413-5a8d-c92b1b2f8dfe@huawei.com>
 <YQvEbUp9cE5G535E@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQvEbUp9cE5G535E@unreal>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 05, 2021 at 01:58:53PM +0300, Leon Romanovsky wrote:

> > IMO, if ibv_rereg_mr failed, the mr is in undefined state, user
> > needs to call ibv_dereg_mr in order to release it, so there no
> > need to recover the original state.
> 
> The thing is that it undefined state in the kernel.  What will be if
> user will change access_flags and try to use that "broken" MR
> anyway? Will you catch it?

rereg is not atomic, if the rereg fails in the middle the mr should be
left in some safe state.

Jason
