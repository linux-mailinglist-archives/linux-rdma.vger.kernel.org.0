Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56758E7766
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 18:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbfJ1RM5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 13:12:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46354 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbfJ1RM5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 13:12:57 -0400
Received: by mail-qk1-f193.google.com with SMTP id e66so9162164qkf.13
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 10:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N6ntQBU71fLWl0ARr98kR5kpcNQe77PId7P3IB9vOMk=;
        b=j6XtVnbGKdZ58a7wCVhFG6Pgdnewr/t+z36rbb3s8AOCHzAzx82uGrJ9h6jvnaWO1X
         ntPWJW2kXUBHtfn5GOgGGv2XHqbIIiokGm/UsYr2qGfLlN5YOxljiPXprdP7SPimCftL
         1Y+qIBVrK+Lb5/ttkWunAPq0eBa40+jmU3+cYBRvPN8W/ZzIzpuzA1v0appDG7vMNoWu
         UWbzZEWTjnj7sDKUx39DFYDJ62Lhx9KvuJI5rinFL0wUs4EdmXu6mvc/JFukkFKaPt/h
         JM7d2xhr/R544YI7RmGnLpbAIwNVC0w/CoqDSiIPxy067doxyOKGhkXIoyTyz7dWrngN
         L5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N6ntQBU71fLWl0ARr98kR5kpcNQe77PId7P3IB9vOMk=;
        b=HwdcdsgPp+hEWgE6FKFxuqkpHuckVOhf7QoBW0qh5P3Awwx/XgsiRYrKnivYBtKCcO
         Oxrc31fJ4PMt6X6McKfXzfVF5MIZe7awimsmEi7TGjJFhT6OaRax+8Xfu1Px20EaL1Rc
         Se0nIlMdnARShJfWywJcD6SGMSUxqp+aqUae0ABh+LZg4/wEyPOU1C7XepLNrRxTj8Tn
         KkEnHMjILHDlFjeAFDelJiw/Bb8Cza7UGf7cYpMOaYwcON4keXONiejdSWkXxKc713W8
         apqivhb1WTsogZSHTlRPT86i5YFr9/Vwyobt5vuzFQAWqOQucNh0yqjyT+ccF6sKh61H
         rPEw==
X-Gm-Message-State: APjAAAWcO4fKj9Nfc6gLrlSfi4cTyEPq6PrcB8/M/PrV3mmZFe/TV4Kq
        hODpvRq8K0HHPx8/1U8YHbHe4bKfn78=
X-Google-Smtp-Source: APXvYqx7EC2pE0wKrbdhEw0JVkGCc9MkCT+vH6fZRtdfIRXXaqjlWwKSaumHSclWhH0ywCHSzfpOJw==
X-Received: by 2002:a05:620a:81b:: with SMTP id s27mr16618455qks.210.1572282776212;
        Mon, 28 Oct 2019 10:12:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id 189sm5808817qki.10.2019.10.28.10.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 10:12:55 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP8Zb-0003e0-BD; Mon, 28 Oct 2019 14:12:55 -0300
Date:   Mon, 28 Oct 2019 14:12:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        nirranjan@chelsio.com
Subject: Re: [PATCH for-rc] iw_cxgb4: report correct port speed/width
Message-ID: <20191028171255.GA13973@ziepe.ca>
References: <1572001022-4533-1-git-send-email-bharat@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572001022-4533-1-git-send-email-bharat@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 25, 2019 at 04:27:02PM +0530, Potnuri Bharat Teja wrote:
> query speed/width from corresponding netdev.
> 
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  drivers/infiniband/hw/cxgb4/provider.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

This is not a -rc quality patch, so I took it to for-next

Thanks,
Jason
