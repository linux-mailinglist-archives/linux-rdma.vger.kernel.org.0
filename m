Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9151E323380
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Feb 2021 22:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhBWVzG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Feb 2021 16:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhBWVzF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Feb 2021 16:55:05 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEADC061574;
        Tue, 23 Feb 2021 13:54:40 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id c1so15295qtc.1;
        Tue, 23 Feb 2021 13:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/2YQl5j1lSOrAsVX4Tf33JuArsqON9FAJrHoqBhvUAY=;
        b=SjL74SvJbXYEkIKRmaESz2/LOhR/fjSCIQlBo0t9SDZgvgnPExxSf75AcToNpc7ly2
         RW/2vpEL6qwoZDXLpGPsthZccUfSK4m9mNnP/USqPt71YkkCbkYXM9Wlqu200pLoJUSt
         KC+9tL9vYWTr3imlHgR6AT53O2+8UNXwYBZO/jSXoCDxqqkYFwgau5I3lF6/RrTkhLZz
         lXRyhuWK0fjeMWBMBiu6nqE7y6tRk6BwTf5RBra+OXBYx4SPKkfXve7Rr141B6+No5nq
         r+jz5grHZfCizJqtkkTuMrSChWfPLw6K/+ZKNGWuHOmzYAgytgM0fgXRvf4PR2HTp59g
         k2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/2YQl5j1lSOrAsVX4Tf33JuArsqON9FAJrHoqBhvUAY=;
        b=Xr3LiPHFnGE8z0Bnkrf4AvZ7bJ+uHL/VIV96Gcmtig4a1S9EVKAXJwjeU9+rdAa+J7
         ef2zq5HtBezT9aehCU3pMH9M312MxnZW+qiASRbzVJOCm+rOwC5fivRQoYL9e0bP/Zk+
         XkSPCKVgfl2398Ht63+HovmpvI76PkVYvaeGpVNhF3kYgcJkCB3l+vYVL/3Q8jaZAECG
         71iTjJCAwDKOQqlVWTl3HJ5K3MEzPch6bBUBlnYWYF19Hk7fJkUQ12z289BAPHRDiTgI
         RKuNLd4x+pSrPbHXcchxpADjd22m3e6HWEr7jd13Wfl0DbEm7Jas+rmlsUf5Fi+59V8B
         AH5w==
X-Gm-Message-State: AOAM533lefhSZ86uxK34wGJBhpKX1Frb1ihz773SxpzANJSmDvUlmqXt
        JL4UHIb6soejZZ8Ai+sI1yM=
X-Google-Smtp-Source: ABdhPJx1Ohe2fn4HMWjqXJHYzXGca6gc4EdzEanQQP7Ro4JcSnT4WwVaHLzZ9Ckw7PpL1SKFGVPtfg==
X-Received: by 2002:ac8:5992:: with SMTP id e18mr26827902qte.177.1614117279726;
        Tue, 23 Feb 2021 13:54:39 -0800 (PST)
Received: from ubuntu-mate-laptop.localnet (108-188-130-030.biz.spectrum.com. [108.188.130.30])
        by smtp.gmail.com with ESMTPSA id 80sm95389qkm.45.2021.02.23.13.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 13:54:39 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: infiniband: sw: rxe: fix kconfig dependency on CRYPTO
Date:   Tue, 23 Feb 2021 16:54:37 -0500
Message-ID: <10464303.FBcTZR2von@ubuntu-mate-laptop>
In-Reply-To: <CAK8P3a1jRS=QyTxJzSxfEsaAuF5HnOXbv4MOu8b5EZWEhUep=Q@mail.gmail.com>
References: <21525878.NYvzQUHefP@ubuntu-mate-laptop> <CAJ-ZY99xZEsS5pCbZ7evi_ohozQBpHcNHDcXxfoeaLzuWRzyzw@mail.gmail.com> <CAK8P3a1jRS=QyTxJzSxfEsaAuF5HnOXbv4MOu8b5EZWEhUep=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tuesday, February 23, 2021 4:26:44 PM EST Arnd Bergmann wrote:
> On Tue, Feb 23, 2021 at 9:46 PM Julian Braha <julianbraha@gmail.com> wrote:
> >
> > I have other similar patches that I intend to submit. What should I do,
> > going forward? Should I use "depends on CRYPTO" for cases like these?
> > Should I resubmit this patch with that change?
> 
> No, we should not mix the two methods, that just leads to circular dependencies.
> 
> How many more patches do you have that need to get merged?
> 
> If it's only a few, I'd suggest merging them first before we consider a
> broader change. If the problem is very common, we may want to
> think about alternative approaches first, and then change everything
> at once.
> 
>        Arnd
> 

Sorry, I don't have a specific number, but it's certainly under a dozen patches.



