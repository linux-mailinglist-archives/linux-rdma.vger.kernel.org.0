Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEB131743F
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Feb 2021 00:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbhBJXU4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Feb 2021 18:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbhBJXUw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Feb 2021 18:20:52 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFC0C06174A
        for <linux-rdma@vger.kernel.org>; Wed, 10 Feb 2021 15:20:12 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id x3so2909884qti.5
        for <linux-rdma@vger.kernel.org>; Wed, 10 Feb 2021 15:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7sLTM6hfOssPDiik8aCiVdZ9zDHcXXsYyD4UKDqlbPE=;
        b=MvJckpZHn/hprnwuzbgoMqt9Fu1fnum4GtFukDoVf5z8xeSrmRDVMHxrS1NWrvkB6u
         cm4O6rHocrqJQtnSYqK/5cTfAUp8Yfl3ZOMKtFvE3bqXh0SqxzKG0cEiFunuHxH+lR6k
         YwPQHK7lm2ZA0lKttIzkjMUd6v1C6/quD0vv9skkYZH+kC2o5+IcGDq4oqhTKdFpmdQB
         q32V+h7SiWmTYj0wEy0bTUUrz9TXdKoRnqj9sgm5sIv3DcFt+woW6+a9eQStIBdBERpV
         Tobur2Vggiax9rAYxMChluwdRObnUy16BOwoLXsNrv0tdQRiRCMtfMfd0FMGicmc5Sru
         tIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7sLTM6hfOssPDiik8aCiVdZ9zDHcXXsYyD4UKDqlbPE=;
        b=TQ6RzC5hEgwOzuL1D/Tvy4knzCvQmMMh/acvqGHFH4Tgq/Z686mJUCkq1oVZFnFtNC
         pbaSHMj3eK+VvSrs+KxC0/xJ1HdYti9kel1hCX5j75ywENHdP6Enr2Ty33LfEFyLRkBd
         TGNiSThLasGv2OQhrtIr5fudgR77luLEa2Qx02syD7U1q5/tA4Hutsp2iY4MBBqF3vih
         gS2Fr+c1A/0Bh7Mggr0DUmutsnOXYof6vbkIXPk41lxoffL80qyaPf6VljpaVuUUUhcR
         rXMLws1S/ELxbmnOzVdfnPyZH1keF2XCdOva/xFr53W0rs+aIoDvqa2VLJGYGBcZxzD/
         cW1Q==
X-Gm-Message-State: AOAM532HEftff+63sKQEOnKXy8kooxK1H0vCeaCHqSwv5SKrD25JKm9W
        OrfuKV1+1TFd7h+WEvHGiXyLmg==
X-Google-Smtp-Source: ABdhPJz/cMnoiG75rTy3LcWjyI/DvIwspEAJBwg1BCxWGX5SKpKUQGZl9SrIgn0qGy4tOlyvthThrw==
X-Received: by 2002:ac8:37d1:: with SMTP id e17mr5146178qtc.215.1612999211741;
        Wed, 10 Feb 2021 15:20:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id d128sm744698qkb.44.2021.02.10.15.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:20:11 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l9ymI-006HPT-GH; Wed, 10 Feb 2021 19:20:10 -0400
Date:   Wed, 10 Feb 2021 19:20:10 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 1/4] mm/gup: add compound page list iterator
Message-ID: <20210210232010.GT4718@ziepe.ca>
References: <20210205204127.29441-1-joao.m.martins@oracle.com>
 <20210205204127.29441-2-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205204127.29441-2-joao.m.martins@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 05, 2021 at 08:41:24PM +0000, Joao Martins wrote:
> Add an helper that iterates over head pages in a list of pages. It
> essentially counts the tails until the next page to process has a
> different head that the current. This is going to be used by
> unpin_user_pages() family of functions, to batch the head page refcount
> updates once for all passed consecutive tail pages.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/gup.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

This can be used for check_and_migrate_cma_pages() too (there is a
series around to change this logic though, not sure if it is landed
yet)

Jason
