Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDCEEE2406
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 22:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbfJWUKO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 16:10:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36049 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfJWUKO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 16:10:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id w18so22924309wrt.3
        for <linux-rdma@vger.kernel.org>; Wed, 23 Oct 2019 13:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g6CcOcaVVLgGpZ4MxD+DXZSEKn6YOrmTVBuFl9GsLvw=;
        b=CNRiTq3+hfKArxvXTietVtP/KH/h6gAtjdTXBM62QXfqBfIv1DdL/3v0W59S/Rcv91
         AyyTnz5+M8JLRRrjSJbs2d+V0MhE3CqTNaXonYJOBFy6XCq79HfH5tv59clzwZloP/Lv
         ooYwMKWvGFX5+QXF8L7VDQspesADgT4dSFXQBu25cmcJcAt1PjhHzqmwfqOoBNDUS54h
         C9ym3kc81WWDJtSyaC4ARo/u0eD7toG9yW4PjpgBTPdW+wDupRsrr5SFd5dis2OKgkv6
         ePmkuM4ZUkUK072J+42HrRhxumgsP2aXjXz8yCoSPLfqM7iNuiwq5X2+VkAGcQAnkIz2
         eRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g6CcOcaVVLgGpZ4MxD+DXZSEKn6YOrmTVBuFl9GsLvw=;
        b=qSmnhpV3N+Q8V/WujhDhJKJjYdJ/pFkJWG21GSLRPjtDyJWtQHYIjkgZF6CNkeoJEi
         raFbrDm4RC86m1eCVNfMwYKHMhWvpvrtSOW8iJEtbz1aFlzwwUIgkl/l7bpHQ+0HewBQ
         peJpzW+eKN02bZLZGjhBaYiU7lXLVDuV4dWj+YEj8z5QP7CdYsvHl9L5G8RbM3ptIpdY
         u5v1Q4YyVLV/yHOcwDu5aX+5IqrALobGC+UnGhkf0uVCO43kQnTvf8pHZuS88R9qy0yu
         iQkTX0Iy0IzZD9SUsSR6urUL90S2TLQIO0pk2GK3NlE8c/ITvJXL+yQlYhPmPjmxHKfo
         W4vg==
X-Gm-Message-State: APjAAAUMAc/ZLNHFUBqjqwYekqQpouxX27N9G1c33NlgaECx0jPQpc6D
        v0Jd+jz/68M6nvuv2SgkavY=
X-Google-Smtp-Source: APXvYqxh/8Lt0VKZeP6+vNdXFnvZ8SnxPyYmwM3K9eqR7QR7jgcdzHZifKX1k6ze42QMKPsRk370Dg==
X-Received: by 2002:adf:a4ce:: with SMTP id h14mr447823wrb.263.1571861412560;
        Wed, 23 Oct 2019 13:10:12 -0700 (PDT)
Received: from kheib-workstation (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id t123sm198661wma.40.2019.10.23.13.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 13:10:12 -0700 (PDT)
Date:   Wed, 23 Oct 2019 23:10:08 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] selftests: rdma: Add rdma tests
Message-ID: <20191023201008.GA30186@kheib-workstation>
References: <20191023173954.29291-1-kamalheib1@gmail.com>
 <20191023174219.GO23952@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023174219.GO23952@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 23, 2019 at 02:42:19PM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 23, 2019 at 08:39:54PM +0300, Kamal Heib wrote:
> > Add a new directory to house the rdma specific tests and add the first
> > rdma_dev.sh test that checks the renaming and setting of adaptive
> > moderation using the rdma tool for the available RDMA devices in the
> > system.
> 
> What is this actually testing? rdmatool?
>

This is a very basic test that uses the rdmatool for checking two of the
RDMA devices functionalities.

> This seems like a very strange kselftest to me.
>

Basically, you can take a look into other subsystems selftests (e.g.
net) to see that it not that strange :-).

Yes, the first test is very basic, but the idea behind it is to utilize
the kernel selftests infrastructure to test the rdma subsystem, I plan to
introduce more tests in the near future, hopefully other folks from the
community will join me too.

Thanks,
Kamal

> Jason
