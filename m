Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7E0364943
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Apr 2021 19:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240238AbhDSRzw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Apr 2021 13:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240236AbhDSRzv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Apr 2021 13:55:51 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080D2C06174A
        for <linux-rdma@vger.kernel.org>; Mon, 19 Apr 2021 10:55:22 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id e13so26833258qkl.6
        for <linux-rdma@vger.kernel.org>; Mon, 19 Apr 2021 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tOaWibhi6DRn42RUGGg+RO3u+N3WiRcK6g5taPBs4Ms=;
        b=Wrv1+SAGfMXTKgoUW9YmawxQvt9G2fey8vubeaOT6YMDpAqHphXv5pTg8K5dbLmOX4
         8AmCmS939Tn9k8P1ieCVp8kACeT2lpGXA+eF4CRZXie94JSzAT3pyvuSY7xTyxVjVqr6
         nlBe4l5Vw36gER8t0kntY5NG3sM3mw4tzXYPwTR8tWkKbAj47xNgC/8xC/AJOECqB/G7
         XQkHtPErZ9K7jJWQw3IjKqybphWYq9Og6avURYvzE1agwsgFIDwVN3qg65iYQ0hquffa
         TR9c/twJyQWMBuyWcty/tXM6BUyN0yT7Yi9722V9ISAxvsC3Tdajtj1gpKzF4GHEtOBR
         WnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tOaWibhi6DRn42RUGGg+RO3u+N3WiRcK6g5taPBs4Ms=;
        b=OOsFYNZ/97sOERV7ETVqX1jVJT+Y5YdCTOND1+XPD+7DAAtV+1AVT13DeytRK5L1SP
         RJgN/tusgUO71TeExox8xaETv3mbNy+f+T3EbuTXGgwn7Zi45HxCwE7GAEb1nwaAquv4
         4iDb6gvZMaiFfK5ZZURXFT1nutknLD9tbCpFXCUxyZddJITVgdS7JrKlKH6VXbvmEd3h
         9hCj5va7juK5zmRb8hKuzIN9itqPXAjt7wBQkJT1zCg9yIPARHJUBncQtpVnbE507fX4
         QYZ0WlDVpD28+NXGysTeWkXFsd5G84wjxKfvh/edqgkaAN9O1bRm01RahmLKMxNjXeg3
         eOvQ==
X-Gm-Message-State: AOAM532X/FQrvaOdPKC6M80pwIdBNIJwnEIGOvPgkVRHNai+WqvyWWKY
        PWoM8JqJkb9XytJbGHPJPprj5A==
X-Google-Smtp-Source: ABdhPJwGlts5G8UGHRwRMVshAgCK+ww0+gQtRjFPprYxwqnhShROXR6Vf55WpjvSm1mOTtq1riLRUw==
X-Received: by 2002:a05:620a:4451:: with SMTP id w17mr12728485qkp.59.1618854921311;
        Mon, 19 Apr 2021 10:55:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id m16sm10194052qkm.100.2021.04.19.10.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 10:55:20 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lYY7E-008dKJ-CM; Mon, 19 Apr 2021 14:55:20 -0300
Date:   Mon, 19 Apr 2021 14:55:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Manjunath Patil <manjunath.b.patil@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        "valentinef@mellanox.com" <valentinef@mellanox.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2] IB/ipoib: improve latency in ipoib/cm connection
 formation
Message-ID: <20210419175520.GB2047089@ziepe.ca>
References: <1618338965-16717-1-git-send-email-manjunath.b.patil@oracle.com>
 <20210413184227.GL227011@ziepe.ca>
 <9CE729BE-0E3B-4101-8AE7-60653388639B@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9CE729BE-0E3B-4101-8AE7-60653388639B@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 14, 2021 at 10:01:43AM +0000, Haakon Bugge wrote:

> ... and, if you anticipate that the UD QP is using pkey1 at indexX,
> the pkey table table gets updates by the SM so the new entry in
> indexX becomes pkey2, the old pkey1 is now at a new position in the
> table (or not in the table is another case), let's say pkey1 is now
> found at indexY. Now, the connected mode QP will use pkey1 at indexY
> if a dedicated query is performed.

This is the concern.. The SM is really supposed to keep the pkey table
stable, I think if it changes it should trigger some heavy flush.

So just confirm that the heavy flush caused a new pkey index to be
loaded and the UD side gets resynced and we ar egodo

> Then we end up in a split brain, the UD QP uses pkey2 and the RC QPs
> use pkey1. With Manju's patch, they will at least use the same pkey.

Well as you pointed it goes throught he heavy flush and triggers
ipoib_pkey_dev_check_presence() which does update the pkey_index, so
it seems fine.

Applied to for-next

> Not related to this commit; I find it strange that the return value
> of update_child_pkey() is not used in __ipoib_ib_dev_flush().

The second callsite uses it

Jason
