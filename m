Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A85D964B22
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 19:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfGJRCT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 13:02:19 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44514 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJRCT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jul 2019 13:02:19 -0400
Received: by mail-qk1-f195.google.com with SMTP id d79so2433200qke.11
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2019 10:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UWdZTbRnsOfkrH/gcvFB0nmiNziCHTNBkuYxVNvSC3M=;
        b=KFJ/rKJQwuFx0QxloQPg04YGFgrbogfNGTtlA0hv0mx17Fgjb0tQzdyrvEOK6kRqVz
         7V+L2vZL5axYHxpKV6n8NETnuOFvx37FqA1KdIe6t63DBxAo22WEW+NpazyKt4W7PU/F
         YZzlSjdDYOdL3qw4wSMRS05iRP/9F4VmlH4tG7RF5aVEXY+YbdicYqx3DAno8CHzgENV
         SYKHLnQgX6VR0QBtv7MzB0XcgF6wjcJGjL9NZuoMmbuz/5xH8ETaL64soSZk1BSbyJjw
         nJGUnB+cpnt2ly4hneJjgHp1qcMCq54f6L/fSPsxE+Z6xDxHcFLHJvjgE17iWIeMLTi3
         TQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UWdZTbRnsOfkrH/gcvFB0nmiNziCHTNBkuYxVNvSC3M=;
        b=oX0Q9g0CKM9kVHRfAnu5xDyBGVycesJeSxOfqMlD5u+mOkXboODdAwuL/3Qic1PVai
         Mxkr3oYi0v/McY56gwiAbM7cUiZ7GgB7eQKUwZJMYpxfuwlMKRg+EW3dxAfD3LNWrVpU
         EAhVKSwIq6ngjXNvz4bA37o4p47ncw7IFU2OqkJSC0JRAMAokEdRw/F9qWqIA86jcGlc
         hX/a2MlbpqCNRSLJiXZWp9Z3CWjhL5YI8icwSQsjtBV+1k9Ef4uxoZ2d1CLxgIwAfaQ4
         wJPvHAryjzEX3KwOehI5HY5GSwk85aaQozIZfGGcc2g0RC53ikhoYYlDTJCg+XsdwgFJ
         7mtQ==
X-Gm-Message-State: APjAAAWGF8uFUdjxr2EyOb3ZxX4B/47gQu/RbnFdlc6cmsqo6wJvr7EU
        RyxzXhfSVI4dQ/BbLWUam2+UVg==
X-Google-Smtp-Source: APXvYqwQRvMw1qmf0I+iflnwNBy81igr/lgAIC0lwckLUWcLDJy+FXVNnTw++UOx4c3kGykVJaBT3g==
X-Received: by 2002:a37:a343:: with SMTP id m64mr24438145qke.75.1562778138173;
        Wed, 10 Jul 2019 10:02:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r205sm1587546qke.115.2019.07.10.10.02.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2019 10:02:17 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlFyy-0003xQ-Ve; Wed, 10 Jul 2019 14:02:16 -0300
Date:   Wed, 10 Jul 2019 14:02:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Kamenee Arumugam <kamenee.arumugam@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] IB/rdmavt: Fix variable shadowing issue in
 rvt_create_cq
Message-ID: <20190710170216.GA15103@ziepe.ca>
References: <20190709221312.7089-1-natechancellor@gmail.com>
 <20190709230552.61842-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709230552.61842-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 09, 2019 at 04:05:53PM -0700, Nathan Chancellor wrote:
> clang warns:
> 
> drivers/infiniband/sw/rdmavt/cq.c:260:7: warning: variable 'err' is used
> uninitialized whenever 'if' condition is true
> [-Wsometimes-uninitialized]
>                 if (err)
>                     ^~~
> drivers/infiniband/sw/rdmavt/cq.c:310:9: note: uninitialized use occurs
> here
>         return err;
>                ^~~
> drivers/infiniband/sw/rdmavt/cq.c:260:3: note: remove the 'if' if its
> condition is always false
>                 if (err)
>                 ^~~~~~~~
> drivers/infiniband/sw/rdmavt/cq.c:253:7: warning: variable 'err' is used
> uninitialized whenever 'if' condition is true
> [-Wsometimes-uninitialized]
>                 if (!cq->ip) {
>                     ^~~~~~~
> drivers/infiniband/sw/rdmavt/cq.c:310:9: note: uninitialized use occurs
> here
>         return err;
>                ^~~
> drivers/infiniband/sw/rdmavt/cq.c:253:3: note: remove the 'if' if its
> condition is always false
>                 if (!cq->ip) {
>                 ^~~~~~~~~~~~~~
> drivers/infiniband/sw/rdmavt/cq.c:211:9: note: initialize the variable
> 'err' to silence this warning
>         int err;
>                ^
>                 = 0
> 2 warnings generated.
> 
> The function scoped err variable is uninitialized when the flow jumps
> into the if statement. The if scoped err variable shadows the function
> scoped err variable, preventing the err assignments within the if
> statement to be reflected at the function level, which will cause
> uninitialized use when the goto statements are taken.
> 
> Just remove the if scoped err declaration so that there is only one
> copy of the err variable for this function.
> 
> Fixes: 239b0e52d8aa ("IB/hfi1: Move rvt_cq_wc struct into uapi directory")
> Link: https://github.com/ClangBuiltLinux/linux/issues/594
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied to for-next with Mike's ack

Thanks,
Jason
