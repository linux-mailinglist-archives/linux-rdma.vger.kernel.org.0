Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCC31729A3
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 21:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbgB0UpI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 15:45:08 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34736 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgB0UpI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Feb 2020 15:45:08 -0500
Received: by mail-qk1-f193.google.com with SMTP id 11so842258qkd.1
        for <linux-rdma@vger.kernel.org>; Thu, 27 Feb 2020 12:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=njDBJiy1ss/6gQ6hVdt2opU7gqSmJ7uSzwQdwP8ZZ7k=;
        b=PBMGVKkunw98f7pRap/Ku6GufjEwedGrQ3zqxfVkus9quODLBJ8U0CP6Xfe5KOhBjN
         /LrG4KGS1iA2k49e9RWIhP68etIf6kNh6Qipnq/iFxa/Oh4/SoVfZaJ1cfI/7Ukh1W4l
         itqSwStI/cOCktF4OcDPbrYqEgCwv/IDLPf8K1pJMc+Xcre6oWEB6OH1aMu2ambWZ+wK
         9kUMJKFUjtdvoWAmduxqGENVkaLdniSrOsi0MONR1v3jXCszcD+L8axNaCZXVYvR5Uce
         uFOpnTb8KnuqwzJKLW2KT2QYsDj/UHwUI3/Wue60Njhy33lLnO64HthCUMHQPcxc04+7
         wF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=njDBJiy1ss/6gQ6hVdt2opU7gqSmJ7uSzwQdwP8ZZ7k=;
        b=EB3hdmNWoOaL0grB0uJb1zJkg1EMEL0eZzuj11kfozOZT/QKWYRANXtu4wqOTf1+ja
         PKHMc9D/MsOGubwYM+Vb7kSBsU4WZgpvTbnonOEemlro3n+iOebfrDE7FutjPZMdZ4Jt
         fayk9fSkF6+05slXv4o7eo8FxZ0KJTuvph4AtFE9L+UJ5w3rFlooF/BagfFwGLEcOFhk
         TUGPEkJ5YFzouJVIPXmNduJx/f54XZHESMN4808kLG/L9cMhRpstdQbqWtNqCnKqCRDz
         8toN8Jj0/DVIVGqxCT5ejtUEYwvu3jweF9WvOXPCP6ei2irbn+jJqKWmJO+BV5TlE+Nk
         Q8Og==
X-Gm-Message-State: APjAAAV5+a9k2MFKB8rUt2zSVTeMLO6QPvRDsFP59Q6ROHG79Wq+MaLm
        z/jttL5Z8PNW4l4m4sK44sPuxKKJ0CUTrA==
X-Google-Smtp-Source: APXvYqw+mjG0puD0wjVcsKMQN1g0//GVPKShefllRSs/VYMaJbNXpa39k+EZTXFqnDN3I4M4SstdhQ==
X-Received: by 2002:a37:e47:: with SMTP id 68mr1262943qko.17.1582836306991;
        Thu, 27 Feb 2020 12:45:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id o4sm3734632qki.26.2020.02.27.12.45.06
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 12:45:06 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j7Q1q-0008Je-8o
        for linux-rdma@vger.kernel.org; Thu, 27 Feb 2020 16:45:06 -0400
Date:   Thu, 27 Feb 2020 16:45:06 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RMDA/cm: Fix missing ib_cm_destroy_id() in
 ib_cm_insert_listen()
Message-ID: <20200227204506.GA31943@ziepe.ca>
References: <20200221152023.GA8680@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221152023.GA8680@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 21, 2020 at 03:20:26PM +0000, Jason Gunthorpe wrote:
> The algorithm pre-allocates a cm_id since allocation cannot be done while
> holding the cm.lock spinlock, however it doesn't free it on one error
> path, leading to a memory leak.
> 
> Fixes: 067b171b8679 ("IB/cm: Share listening CM IDs")
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/core/cm.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-rc

Jason
