Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9D01B76E8
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 15:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgDXNYk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Apr 2020 09:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbgDXNYk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Apr 2020 09:24:40 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8DDC09B045
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2020 06:24:39 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l78so10059239qke.7
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2020 06:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FjurQ7y4aLZjgRR+9oqb6xDrtsHdA+oEzaoMRtAbVI8=;
        b=X0gozXDobfvLzL4+QqIQ1e0UwNhQGNEl1SWZkaURAyqiD2RIXFcUa3Mi2EG57QqyYr
         FeyGK6nGcMwQbwhRy9KpZyhF8csN2Iuwc2YJc5N1VkdOwO6VsCkOeUNsChfXRJy12f5H
         uyU368GcskIQaJ3Eh5WVDjCd6vzOKhkNjIWepQj6pRUji7V3zwWOYBryVRXR+AzmPnO/
         2oBTVXFHGBOOYE45vWcP9T1kJdZCMePOvLd9diQtmE7r4FtjsnbzIWX5+KH90q5VNEEi
         lUVheAdRrki2ak84Dz3U8GtQVv4khnRnligLnbTN5SE5DF1XtT5LMPEelQ5BBZOSXT2H
         W1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FjurQ7y4aLZjgRR+9oqb6xDrtsHdA+oEzaoMRtAbVI8=;
        b=I1KAbT3sTf6uMA3dZm3HnOqF0qt4axqH2LrG0c1zM6AyhVC5LKXcgV+ahLu29fPlG5
         JpyM+Nmb8yxZ8Odje1a3H2z5aY8RRCPaUoTiENlEuTL3bDyU2CZL5KNXz2iclEfLCek7
         4KEEZ5THoXjiCsXvdgg+smkHnzJmW9iSipAqAup50rMFXXGiSXE/08l5zbu9wW8QXleg
         yXvktEFoo/YrDIJNrd3Ig16j+7M5x9AqJEjXXmjrskYIXDu85CwRnm0fr1GG9/pwLeEo
         3mgPjYwQeHcZ9Rtv/KKr5GISmv8pmMCwUGfeQbYicvInnLjOC3IQiePd935nBvq817Yz
         Z2TQ==
X-Gm-Message-State: AGi0PuYIYBe3iRM3Hk2y2MArYBP+jlHWc9Ag95P+Jlp3hi+fgaJnTb0h
        bL7+63MIgeXaU3xV0jQ6vMA+1w==
X-Google-Smtp-Source: APiQypJTVCxDJ+P1pqSyN51A/YrScF7FfBhUTGMSOoeW6rF3rFnxsXSwcY9+rMtLEkHhlfKJy8JoBA==
X-Received: by 2002:a05:620a:2f2:: with SMTP id a18mr8325368qko.261.1587734678188;
        Fri, 24 Apr 2020 06:24:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g133sm3671108qke.73.2020.04.24.06.24.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Apr 2020 06:24:37 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jRyJp-0007gV-6U; Fri, 24 Apr 2020 10:24:37 -0300
Date:   Fri, 24 Apr 2020 10:24:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 0/6] RDMA/hns: Codes optimization
Message-ID: <20200424132437.GA29510@ziepe.ca>
References: <1586938475-37049-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586938475-37049-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 15, 2020 at 04:14:29PM +0800, Weihang Li wrote:
> This series optimize some codes in hns drivers. The first two patches are
> mainly to remove unnecessary memset(), and the others use map table to
> simplify the conversion of values.
> 
> Previous version can be found at:
> https://patchwork.kernel.org/cover/11485099/
> 
> Changes since v1:
> - Fix comments from Jason that the arrays should be defined in type of
>   "static const" in patch #3 ~ #6.
> 
> Lang Cheng (4):
>   RDMA/hns: Simplify the qp state convert code
>   RDMA/hns: Simplify the cqe code of poll cq
>   RDMA/hns: Simplify the state judgment code of qp
>   RDMA/hns: Simplify the status judgment code of hns_roce_v1_m_qp()
> 
> Lijun Ou (2):
>   RDMA/hns: Optimize hns_roce_config_link_table()
>   RDMA/hns: Optimize hns_roce_v2_set_mac()

applied to for-next, thanks

Jason 
