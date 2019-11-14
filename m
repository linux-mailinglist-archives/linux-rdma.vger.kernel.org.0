Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E202FC8D4
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 15:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfKNOYL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 09:24:11 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45323 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfKNOYL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Nov 2019 09:24:11 -0500
Received: by mail-qt1-f196.google.com with SMTP id 30so6911571qtz.12
        for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2019 06:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YfeA14uuuPzU+N+/A63W2LLCo3IHXwSL/EjkK/pHBoA=;
        b=PXwwk3aG8DnvtQt2WlwkDuxKtEq+rWhMjk6TRDPP6J7v2ijVF5ntwH71vv2+LPNGON
         FkVeLzwjcEl9zzEmJcuEcNJPI0Zl7WsDbJqqfHzJx7frAIJ4S82/egMXgAlt+KAcJs5S
         0YpEBfP/fz89eoYIu0n6MBzOFLoIJNnjToi1iA49/WI0O6XoZQkkV4XX2reLekkoZGQK
         hEjn4cS4z2FfZfR+/wP3JKdL+Zb6WUpjELz+FQdgwysAQ0W+7Mvxhucp+WoKHgkywQuJ
         Gn94aN6yEE/wOFmjywIASyQrf+GqPnHZOHIa0aufOfzY3JC+/kDSQvxS1fIRd78B2N8u
         w67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YfeA14uuuPzU+N+/A63W2LLCo3IHXwSL/EjkK/pHBoA=;
        b=WP7d9vz1lz6zWilajNAooVnY1DqzwkRTibDaheAai5Nm75fmFklBRI1vhiOV0xqobG
         flI1YzYF8dmqyvrXScInTALVxUxza+JUmJPACpNuBERuE7m4/n5y2kYtao3sKZKPfkIo
         DPcrfNPp/WJvrmu3QRP4+IYpxIE8oqDl4oN25xb2b9XM29gum9L50SsAmJ6dbVnNsjKR
         NGq88A9SGCQyGlZjT7bMsfrNlBbBFbgHwPwnv6ZrzqyK27T/KWtkzEezRV82Tk3iPmiq
         leC8qau2/rPzHFTgm7TG822VDq6gYLvpAkdBNgAyBaq2pAFxXsphP+a6v+mBvf8V+KXc
         IpyQ==
X-Gm-Message-State: APjAAAXNBrYTUgSzWBB3Oom2nvuBeR5Bz6KY1lurSLpG3IzduQY1Egkn
        zEo7/tXpIOHc0+1uK+CdiMKTxQ==
X-Google-Smtp-Source: APXvYqzjYBw8Uth2zEHa9ufAHHel74INCvkgWT2GGxMJP0HHyFDLnEKNDmKisfErW5qKeEy3am6PCA==
X-Received: by 2002:ac8:6757:: with SMTP id n23mr8291467qtp.345.1573741450490;
        Thu, 14 Nov 2019 06:24:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id s42sm3125140qtk.60.2019.11.14.06.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2019 06:24:09 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iVG2b-0000DC-9T; Thu, 14 Nov 2019 10:24:09 -0400
Date:   Thu, 14 Nov 2019 10:24:09 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Shuah Khan <shuah@kernel.org>,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mm/hmm: make full use of walk_page_range()
Message-ID: <20191114142409.GA785@ziepe.ca>
References: <20191104222141.5173-1-rcampbell@nvidia.com>
 <20191104222141.5173-2-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191104222141.5173-2-rcampbell@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 04, 2019 at 02:21:40PM -0800, Ralph Campbell wrote:
> hmm_range_fault() calls find_vma() and walk_page_range() in a loop.
> This is unnecessary duplication since walk_page_range() calls find_vma()
> in a loop already.
> Simplify hmm_range_fault() by defining a walk_test() callback function
> to filter unhandled vmas.
> This also fixes a bug where hmm_range_fault() was not checking
> start >= vma->vm_start before checking vma->vm_flags so hmm_range_fault()
> could return an error based on the wrong vma for the requested range.
> It also fixes a bug when the vma has no read access and the caller did
> not request a fault, there shouldn't be any error return code.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/hmm.c | 121 ++++++++++++++++++++++++++-----------------------------
>  1 file changed, 58 insertions(+), 63 deletions(-)

Applied to hmm.git with Christoph's hunk merged in

Thanks,
Jason
