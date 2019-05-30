Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E929130233
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 20:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfE3StV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 14:49:21 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36743 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3StV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 14:49:21 -0400
Received: by mail-qk1-f193.google.com with SMTP id g18so4614835qkl.3
        for <linux-rdma@vger.kernel.org>; Thu, 30 May 2019 11:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w0i/t6u0ONkXEx6ZyiDM2z9pAVyu8vYIkdQiMSupFL4=;
        b=ID3rou9z207Iu/vciPvrLKMbLIJIJL5p1QIBOqvE2r8BZs31VwNWVyp1+Db0VEVctV
         b/pu4m4vLOawz2hFeTmk7YlHE3JaigOiAFWUI4pDK58czuxj0v4F3OJnvch4VMBzXl/7
         hXXaNsWVjVPZZH7n9SJ0P+vJCzpjsdGi71JfvWas7C9kQ0tWcHKGFjkdGn0w337dhxKs
         SJTgnsKsAnkhp4+4/caa+LOEhE6P6SLXW4cci9PJlmS6wulQb87M157OPDt4pFcz0Ka5
         D2GhG7kE7cr+7v5yhMVfBllnF5vzdrg56LaDVmd/fr9+eryxoRCYomRBpASIsSNnyROn
         p4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w0i/t6u0ONkXEx6ZyiDM2z9pAVyu8vYIkdQiMSupFL4=;
        b=deOBzJLbLlEJrEGh7nHUVPgsVKEIEOa8iUbzfxmonn7anmHgbT9TzDBV2cVuUH9TfT
         q8lU2TkAskAy/AnHefBG+YVvr2SCRmSUpuOP0vSSH7GzQqEBmvY5Dg21nAz6CjRTXNnp
         o1BZkayVdLQT/kGeF9JhKvGKRjFZQiEzHxhm1KgAGU6drUnJyP/d9Hq9CyhPHsOdV3sh
         NIZ2tCudKu1jrCIiw6OCny/F5oxxXZSboT2Zf7Xt7Xzq/YVkXKFu0OH+dZFxTEt3G+5r
         etMYxYz/SOxYvX/M1QnLPSEk2QUFlD9ZrEyGqcKaK3Tnfps3qZIfOODhslSiMHhBwMEI
         kgkg==
X-Gm-Message-State: APjAAAVA5sGX4qVPEMZ8Mnm1EwcQCsFCZMI7v1cwlfcJrTegMw3J1Wyj
        WUDaxyG+hPouUTx44jSxRqNFpg==
X-Google-Smtp-Source: APXvYqyBhd7a9f+Ei8nhwFPFs6CWx4CBREEbAdpXD4RqMybB60dLn+Epr3J2KKsVLoLDjgRVYAlnHw==
X-Received: by 2002:a37:2f87:: with SMTP id v129mr4752741qkh.151.1559242160875;
        Thu, 30 May 2019 11:49:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id j37sm1970061qtb.76.2019.05.30.11.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 11:49:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hWQ75-0001QX-PR; Thu, 30 May 2019 15:49:19 -0300
Date:   Thu, 30 May 2019 15:49:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lijun Ou <oulijun@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH V2 for-next] RDMA/hns: Bugfix for posting multiple srq
 work request
Message-ID: <20190530184919.GA5454@ziepe.ca>
References: <1559231753-81837-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559231753-81837-1-git-send-email-oulijun@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 30, 2019 at 11:55:53PM +0800, Lijun Ou wrote:
> When the user submits more than 32 work request to a srq queue
> at a time, it needs to find the corresponding number of entries
> in the bitmap in the idx queue. However, the original lookup
> function named ffs only processes 32 bits of the array element,
> When the number of srq wqe issued exceeds 32, the ffs will only
> process the lower 32 bits of the elements, it will not be able
> to get the correct wqe index for srq wqe.
> 
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Lijun Ou <oulijun@huawei.com>
> ---
> V1->V2:
> 1. Use bitmap function instead of __ffs64()
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 29 +++++++++++++----------------
>  drivers/infiniband/hw/hns/hns_roce_srq.c    | 15 +++------------
>  3 files changed, 17 insertions(+), 29 deletions(-)

Applied to for-next, thanks

Jason
