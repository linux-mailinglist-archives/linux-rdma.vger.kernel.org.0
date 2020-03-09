Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25FF417E50C
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2020 17:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgCIQxx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Mar 2020 12:53:53 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36416 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgCIQxx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Mar 2020 12:53:53 -0400
Received: by mail-qt1-f196.google.com with SMTP id m33so7524271qtb.3
        for <linux-rdma@vger.kernel.org>; Mon, 09 Mar 2020 09:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zcCQKvtVXYoPO9qwFDvcem9+9BxGLHIpORybCcWEw6I=;
        b=RvPEtnxKlc/xOlzTuPtIr2yWn8+hBwO4+9iPSaISIxR5OY4bYhK7M7qoDiNGCMn1+h
         Ale1+JOaX+vcRnDt4dNmKADxSspHcnOvPWGEGhYlfhpE9cD7N6AS0iJ6Q0pjyvlnWeX0
         o4uL6unP7h2d7DMWG9M3iRqb6SCGwrc2hKa2inZ1g5Ln7XNUwQwdo0u9tVZvvi/YH72E
         TkMYZCO+UwigTmVeappvc43xWPjZA8gGbx6BQOn8HUlQdg+rKT6z85+XFMBqckpT86lU
         2XLtb+ELGN3/sjfMyDoxBxTr+XH6+Y0JJP5nKQtNMf3edo3bP1d+nYkDLXgs3nQ4xJhs
         1HEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zcCQKvtVXYoPO9qwFDvcem9+9BxGLHIpORybCcWEw6I=;
        b=ga2NRPPE/3+7In3W+vSda3Qqy9Bu6Kh8iOrZjoNncCUKhsyvpzB6NC2muWOXAcRO/x
         eontt7+KoGXB7ato9ncMwwzSWZHeGq/PJudve98Ihf6wXM2FnxsdaOB9Kuhq8+n7I6Ig
         SmntI/jFBSN0T7nqRxIazIi05bk8ZRByDc0SfKADB7Vzl93qye/SUDLcYDETsINnL8fW
         knSiqzw7mhkAZBTg5y9zIo3hltJmNAWlk0g+ew+txpQhb564J9/UbcO74Xb6UBiRV3TR
         Ld1mtfHq2M2gBzqPP45zFpYgjlyEsRerWQuO8GAC/X8ZXdvtO+WJyBDYD/ETz3KmLeuY
         LbXg==
X-Gm-Message-State: ANhLgQ2QSTg8/azjpc6yIyJtfyeNY2gOJa8P48hQnVfSJw7qV8K64Fn3
        Upr3eZ3k83xNxL5+a+Dau2XgWw==
X-Google-Smtp-Source: ADFU+vs02TxN5oK2HErUtrc+7iUAf+xvHQsYsq7mAlQsVK0y7ay6UYS6SrD8IWDNsB1+l5cJRZxd6Q==
X-Received: by 2002:ac8:7484:: with SMTP id v4mr15350483qtq.19.1583772830421;
        Mon, 09 Mar 2020 09:53:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id s49sm4906117qtc.29.2020.03.09.09.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Mar 2020 09:53:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jBLf3-00037D-3m; Mon, 09 Mar 2020 13:53:49 -0300
Date:   Mon, 9 Mar 2020 13:53:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] MAINTAINERS: Update maintainers for HISILICON ROCE DRIVER
Message-ID: <20200309165349.GQ31668@ziepe.ca>
References: <1583575114-32194-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583575114-32194-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 07, 2020 at 05:58:34PM +0800, Weihang Li wrote:
> Add myself as a maintainer for HNS RoCE drivers, and update Xavier's e-amil
> address.
> 
> Cc: Lijun Ou <oulijun@huawei.com>
> Cc: Wei Hu(Xavier) <huwei87@hisilicon.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Ack from the other two please

Thanks,
Jason
