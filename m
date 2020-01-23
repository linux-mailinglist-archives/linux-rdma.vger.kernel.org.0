Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2760114741C
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2020 23:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgAWWz5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Jan 2020 17:55:57 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46489 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbgAWWz5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Jan 2020 17:55:57 -0500
Received: by mail-pg1-f194.google.com with SMTP id z124so2122838pgb.13
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jan 2020 14:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M7+mwRKYvUclKLwFqX/3sXfC8Je3bfz17EKmfII2yd4=;
        b=BURrV0y5pnWJIIjhBnFJpdId5kmuYEmnbFAQ2DWYb6Sq6ZB8IyZy1zHm6wlOCgvwOs
         B6KMiIEajHIfx4bVJgOVUxJEivBd23gGhGg04SzD9QwxumF1IAfRaGUAw5H0F5qK5HWS
         w+c9mbqoATI1lzKmqlpBLU2xNN1+KY+NG3Laf5YAr2Wie0xAEcF2Mb4Uc0PqftxS9idM
         Y9HUNpSFoAyOXb3h0oDhtGgWzXh8zCwtRvKBMPU4k7UdhNvcf48amH/gGy2EwPzW/XU9
         V9UjESwPvaLZ0IQGRJdgkj9gSRiZLcC0FhGKB73hXn7CkMkMbNhQR+JaJkF4/V9q3PP5
         8e0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M7+mwRKYvUclKLwFqX/3sXfC8Je3bfz17EKmfII2yd4=;
        b=jR/yZOGAiA7gkPmL20jwnSwUD4OU7oyLDlvxRvW8X/Z+rgePfT/oKw1/W2gzpS2uUs
         7P/GrJb87UZ04Lkyb0qGE0eBxll/7yUKmZHT/djsK1fIcdRQPmWRHzhFkUy7i7xHN9KY
         s3VHRJ+Zc7hl3lXTsVI6bdEZsxBlch9lioBG6M8f/a5Lu/rA3Q2k6039gugVT90CFtqb
         7KWDIpre6mp1RCXsdb6gFfPgBlac3XZ5RwLhctBfH5Ldr+9HiOBJmEVW/rdLZ8m2LQSw
         Pn5ooaAS66QLseWk1JEAEOVknZazyQEdM7mguY7axx4qc318ha/WYuAYSkq0EtGC6gEE
         0orQ==
X-Gm-Message-State: APjAAAXLejWSHs9OVMYk15JsFKa6f/XXgRAdCx0muzANsQ0R9cDAq3oy
        0GlzQ3sz2lu91PwKshF3RrqHag==
X-Google-Smtp-Source: APXvYqzwOnjPxOUBUbeXj4mQ/28esCmvyW5jnJ/Er6AzPPnLzeyDXmUNp4StrAgVRGjskJwOoxPU0w==
X-Received: by 2002:a65:52ca:: with SMTP id z10mr741292pgp.47.1579820156317;
        Thu, 23 Jan 2020 14:55:56 -0800 (PST)
Received: from ziepe.ca ([199.201.64.131])
        by smtp.gmail.com with ESMTPSA id g9sm3883722pfm.150.2020.01.23.14.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jan 2020 14:55:55 -0800 (PST)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iulOF-0003zJ-33; Thu, 23 Jan 2020 18:55:55 -0400
Date:   Thu, 23 Jan 2020 18:55:55 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Weihang Li <liweihang@huawei.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 4/7] RDMA/hns: Optimize qp buffer allocation flow
Message-ID: <20200123225555.GB15167@ziepe.ca>
References: <1579508377-55818-1-git-send-email-liweihang@huawei.com>
 <1579508377-55818-5-git-send-email-liweihang@huawei.com>
 <20200123143136.GO7018@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123143136.GO7018@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 23, 2020 at 04:31:36PM +0200, Leon Romanovsky wrote:
> > +	ret = map_qp_buf(hr_dev, hr_qp, page_shift, udata);
>  
> I don't remember what was the resolution if it is ok to rely on "udata"
> as an indicator of user/kernel flow.

udata is to be used to check for kernel/user

Jason
