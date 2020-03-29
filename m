Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9499C196DD4
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2020 16:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgC2OKv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 Mar 2020 10:10:51 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38508 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgC2OKu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 29 Mar 2020 10:10:50 -0400
Received: by mail-qt1-f195.google.com with SMTP id z12so12879051qtq.5
        for <linux-rdma@vger.kernel.org>; Sun, 29 Mar 2020 07:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qAXQ/HiQQJ85V+1nD9jJqaE130Ux/3hBzkOcCll//2M=;
        b=Zjm0yel2Jw7jTKU3bc4UNvsjMN2aQPu2SlOdDUOt+SVb+avFdFgyIqswyY5/bJEGk2
         /+EK8LWWJudSJZ4XdVd7EonvXeRhxFL5kT4mKP7YzoRUbDhBnr8db/0r8Fxc544ijQsl
         f7NztMRGkOvhk2HnIGBbi6kLU7jwzw9pFjrVjCP26z8iYY14pjrg/j+rTWRnEj6AEVFF
         DGXzm4NlNzNWY9N81q5TbZsWoY/ZYslc69qYGAHWqw1YImbih41hWRfT84YF4zHkpN2i
         rksrGt5kMFSwaRCD6TVy/v52hdUuXlIYd80d14B18UgQmIV3+rBJMj67SUfx65BSrIA9
         jnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qAXQ/HiQQJ85V+1nD9jJqaE130Ux/3hBzkOcCll//2M=;
        b=BC/+zjLbJz91pohIopbzWq4usH5qOpG060uiBahmm53Jh7VmmovuxoaGzFjfM7qos1
         mKkWsYeNK/OZN71lrmY/F2AqECSsRp4XyzBgNVvZU1UCvx/G6IQpl4CktdQG0olHe+yB
         gu+Ka5MF9q+Eh6fu6sR//4I71WUZ/7r7+jH437trKJZ1TgSKQzHZ7y4cQcTEr5/Vvyi8
         PfD0YacWZgJKMA9ALFrQKvU7AUGKXQkCgm/KIBi3M0D1mdpIEjahGI5DzmQBzTXx2j/1
         dkhBrv45oteS7Vnh1PxHz8GfF/R/R88bkv8ToHCoTVWROIM+QOHTXa9kQ8TDE6vzD4Td
         BVrA==
X-Gm-Message-State: ANhLgQ0BxxoA3ko+jcknHskqaE/hcl0bMmQ6wULXlsHNxnV3Y19+GNku
        Nl9SJ2QE0qi2U0Yo0kzSyxnQaw==
X-Google-Smtp-Source: ADFU+vv0q2VIaCAxj4AYUaHfb1fkd5WxnrWbtBWIvG4n74kX54qUxphTwUJ4W0FWXpjg+1BdOcz/JA==
X-Received: by 2002:ac8:39a1:: with SMTP id v30mr8004872qte.112.1585491049551;
        Sun, 29 Mar 2020 07:10:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c40sm8985301qtk.18.2020.03.29.07.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Mar 2020 07:10:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jIYeG-0007EQ-IG; Sun, 29 Mar 2020 11:10:48 -0300
Date:   Sun, 29 Mar 2020 11:10:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Weihang Li <liweihang@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Xi Wang <wangxi11@huawei.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2][next] RDMA/hns: Fix uninitialized variable bug
Message-ID: <20200329141048.GA27740@ziepe.ca>
References: <20200328023539.GA32016@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328023539.GA32016@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 27, 2020 at 09:35:39PM -0500, Gustavo A. R. Silva wrote:
> There is a potential execution path in which variable *ret* is returned
> without being properly initialized, previously.
> 
> Fix this by initializing variable *ret* to 0.
> 
> Addresses-Coverity-ID: 1491917 ("Uninitialized scalar variable")
> Fixes: 2f49de21f3e9 ("RDMA/hns: Optimize mhop get flow for multi-hop addressing")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Acked-by: Weihang Li <liweihang@huawei.com>
> ---
> Changes in v2:
>  - Set ret to 0 instead of -ENODEV. Thanks Weihang Li, for the feedback.
> 
>  drivers/infiniband/hw/hns/hns_roce_hem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
