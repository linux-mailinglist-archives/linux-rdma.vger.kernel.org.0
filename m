Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 028E3E770C
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 17:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfJ1Qyj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 12:54:39 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42023 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfJ1Qyi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 12:54:38 -0400
Received: by mail-qt1-f195.google.com with SMTP id z17so8913104qts.9
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 09:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=105SgWr73rkCfFA8RUlFBrEu0cuARq8iF9sCl/XmecQ=;
        b=D809WesW5aARmHw7dbnNX7Sk5rQ2y+pFrIc2DgjXchK/YRj5BW4EiGysxjaZzM0uPR
         /9aG7XNER9S+OAbZ5TBLAZ62j2BYpV+/FJ5VpVII7Uyr9q684czFkxtfNuJva1Od0PtL
         IaAF/hWU+LH3F84U64QlD/vTsl3L3/buAJDo/CFJreOCcrl7V+bfOPoDhZTxGKE5qUqj
         cO40NzBUbRZEsFD+AhKr1UMToVI4plOC/u1pt5dsVoe8rr89XgWEa/KRZdG30obUOUEg
         UP8KEw7bkB5uEBk381U49i2SvxSmIFLRmICiK/jcJ98HWcSl/W/MzLnh+zDyYFLFRzyT
         z8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=105SgWr73rkCfFA8RUlFBrEu0cuARq8iF9sCl/XmecQ=;
        b=Vxs/tgWJJ36f9uMA0GZ8d7t5afMROJxhRlMktA6TD9WlRL/ypE4YLumBNKF/A2OePv
         iG+jMjk4TR4hjrexcb+sBrLNX4X8vHIENAeM8PwUPsr79usHNsQCWjlcUtro/KvNHUw0
         wv1Ea3wNJNPxJge12HTKCgL/VLiwsGI8eRUI01eP/8sIHoTcWNu6Tmuwv7DKsku551wA
         zxZ9NltUf1opC56b0nIRPDovgziQDPBkwmFmHAHB+BcN4bU5HfaMqUl612eI6+ex7kyQ
         sc+pg3t2ukX6f061lVGoDeeRVAZODA28TPiwbfVjO1BNITgnuY44Ohdb4j//9fpFQEx9
         Vp6g==
X-Gm-Message-State: APjAAAVbXyI3xtUSFYBDVnNYgdvsuHJWtNG9hz9ajcIEerXZi5NNEWhS
        Paf4gY4/h5JpRDy6yLKt11zQtQ==
X-Google-Smtp-Source: APXvYqw9v0xKTPSNMThwz+LbT4dlwgz4Y5n6SMjm1bFyq2tzXxRqh/VRyPO1cIf4bhhSN+4IX3grvQ==
X-Received: by 2002:a0c:870d:: with SMTP id 13mr10631507qvh.245.1572281677617;
        Mon, 28 Oct 2019 09:54:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id u189sm6080976qkd.62.2019.10.28.09.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 09:54:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP8Hs-0004oo-Ae; Mon, 28 Oct 2019 13:54:36 -0300
Date:   Mon, 28 Oct 2019 13:54:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Lijun Ou <oulijun@huawei.com>, Wei Hu <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Tao Tian <tiantao6@huawei.com>,
        Leon Romanovsky <leon@kernel.org>,
        Yangyang Li <liyangyang20@huawei.com>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/hns: fix memory leak on 'context' on error
 return path
Message-ID: <20191028165436.GA18470@ziepe.ca>
References: <20191024131034.19989-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024131034.19989-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 24, 2019 at 02:10:34PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently, the error return path when the call to function
> dev->dfx->query_cqc_info fails will leak object 'context'. Fix this
> by making the error return path via 'err' return return codes rather
> than -EMSGSIZE, set ret appropriately for all error return paths and
> for the memory leak now return via 'err' with -EINVAL rather than
> just returning without freeing context.
> 
> Addresses-Coverity: ("Resource leak")
> Fixes: e1c9a0dc2939 ("RDMA/hns: Dump detailed driver-specific CQ")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_restrack.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Applied to for-next with the note to remove the EINVAL return

Thanks,
Jason
