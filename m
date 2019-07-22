Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A771707ED
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 19:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbfGVRyY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 13:54:24 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44663 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730598AbfGVRyY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 13:54:24 -0400
Received: by mail-ua1-f66.google.com with SMTP id 8so15707669uaz.11
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jul 2019 10:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iGeOaY3hIaY8aHRyewGNw/uGxEKnAwe4AhNgerMtQ74=;
        b=aYRI0R3PbdVkHVuARyX3UaCa+HAs+6zFQUFFL7odTyXeLoE1N+YXRyca94bOSWY1ah
         f+Jo8bDgTaP1PG3UHgWbzQBwCnsntecv/7frbx33ujZgB6K1fLc6LHWrdCjgomKTARCT
         8FYauUrCR5yyimwrzAweQBOvsS6qaTG0EfJchpPDbH2NG7rgOkRex8d87n2hre3z7KAc
         o27mVLVVCNAHc+g8OAyqMboSVvbnUBv8a9LspVy91cmGFMTNEwgibFg1JcioyogVFwTu
         5AMFKwSnNFOqLxZy3PKWHuIzSYxBpcI/qgkMoTaCApjn2BX8G4d1qbfT9NY0uFyos318
         c2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iGeOaY3hIaY8aHRyewGNw/uGxEKnAwe4AhNgerMtQ74=;
        b=bpWBCyxIJJcdTsfN84TEvK96wK78cIPjsGWouhUFoei/iQDHYQePyzH0iybfnjevMT
         r/UNVpzgZ0VgpIWNFzlmrAk3Ex5pb/bDQZXInzMU57guAi8I3nRT3KcSpKV95zMrmjyV
         fE5XnTAIx6r5yyDmn+pnxeNdgdulaVV5QbVTPPIW3Wdt1MKZlIYaLsA/wHBi5E9rCKgh
         eZCCG2l8S1HZs3pUmwPip40sYQl4h6ujF8XlaXaCVg20p3jkscpGfDNVQvW9nikiHQkT
         AxCvG8mhcctsB6yvM8OUvB9qQ2TGGCOPPb21Jehon5w11wiD9zu6QnmKZPSSjiowB2FP
         0HhQ==
X-Gm-Message-State: APjAAAXP3qTjMoCva3e8mksY/JKwkGTF1SQ2hOKHEX8mj+/aEuPqE+NH
        5oeUQ5HB3YY1lyO9UqlsS2osUQ==
X-Google-Smtp-Source: APXvYqwl3UKBzw58hlNd6Iegw4rjbKiJAvR7R/IgiJVJ7D5pNsVsWKnL+xE0b8Zub8LJq9T9PD1C9Q==
X-Received: by 2002:ab0:760e:: with SMTP id o14mr25387134uap.93.1563818063182;
        Mon, 22 Jul 2019 10:54:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z24sm6396819vso.4.2019.07.22.10.54.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 10:54:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hpcVy-0003Rd-5R; Mon, 22 Jul 2019 14:54:22 -0300
Date:   Mon, 22 Jul 2019 14:54:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lijun Ou <oulijun@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-rc] RDMA/hns: Fix sg offset non-zero issue
Message-ID: <20190722175422.GA13190@ziepe.ca>
References: <1562808737-45723-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562808737-45723-1-git-send-email-oulijun@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 11, 2019 at 09:32:17AM +0800, Lijun Ou wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> When run perftest in many times, the system will report a BUG as follows:
> 
> [ 2312.559759] BUG: Bad rss-counter state mm:(____ptrval____) idx:0 val:-1
> [ 2312.574803] BUG: Bad rss-counter state mm:(____ptrval____) idx:1 val:1
> 
> We tested with different kernel version and found it started from the the
> following commit:
> 
> commit d10bcf947a3e ("RDMA/umem: Combine contiguous PAGE_SIZE regions in
> SGEs")
> 
> In this commit, the sg->offset is always 0 when sg_set_page() is called in
> ib_umem_get() and the drivers are not allowed to change the sgl, otherwise
> it will get bad page descriptor when unfolding SGEs in __ib_umem_release()
> as sg_page_count() will get wrong result while sgl->offset is not 0.
> 
> However, there is a weird sgl usage in the current hns driver, the driver
> modified sg->offset after calling ib_umem_get(), which caused we iterate
> past the wrong number of pages in for_each_sg_page iterator.
> 
> This patch fixes it by correcting the non-standard sgl usage found in the
> hns_roce_db_map_user() function.
> 
> Fixes: 0425e3e6e0c7 ("RDMA/hns: Support flush cqe for hip08 in kernel space")
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_db.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Applied to for-rc

Jason
