Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC7A1C733E
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 16:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgEFOrA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 10:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbgEFOq7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 May 2020 10:46:59 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D968C061A0F
        for <linux-rdma@vger.kernel.org>; Wed,  6 May 2020 07:46:59 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id i14so2141478qka.10
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2020 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FCrQwj02OTSOk9YnvSx5aU0aO0OZTpzsgBUQYECz8Eg=;
        b=IO5W44U4fzF3nByUva316six6KPdiRF/THzcgpjv9daBec/2coahnhRv5IIHhrHy3F
         Ia4ZMrhbJ6amwoQyLP6uYdJmIQ8vau6eqW8sOfPAhBJCbzlYH+RSBczxMRYDxS3a6DI+
         E7uZ0l9KBqAfwyUbr8/ZOWl2iN8ZxYnB81cDZSWsIhYGzjoN0QSVLTtQYkluzwmD34Du
         kN5LkXL/LoBtLTLSfsresBzwPzSp4TpauD81fULAOQIijb/X1NvXo6ojkBfJrYCLmgEY
         LLXmpYbNFLGEitAh6m8SLjg4kup2Lm0RrW3gzKMNVshjMhKBJMn4NTO3b5uuQSDHWjlp
         xtcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FCrQwj02OTSOk9YnvSx5aU0aO0OZTpzsgBUQYECz8Eg=;
        b=FXiL78VzvADBzfLDNMAm2dNnTpbo7kbGvZ3qfQSFC0xY5xCiO8ySPKMsnDKpbfgdvr
         Vn1/rsd26svq/Rlb6gbJCsgQMcpyi9FYzkdLMhPrCITxLKdDR745aP+SlImqjYIV2Ltl
         APlpM+UdVMnY4XZ1FcNsNE35ropNFQe8mBX45uMDyA+Gr3CFBp9y7bzmIZQZU2uaHE3m
         kAAym6mrP7DsfOMauIcb830sS5C5PJ/uBfHdLBNbO/KyHq/kIQ+TytVtw2Lk8qfL8Wkd
         viF2cGI2XPrm5vgXOoyoImRpe6cp/brz1gTrDc5/cqqJLfaaXghDHnQziA5DYuuH/U1F
         JspQ==
X-Gm-Message-State: AGi0PubY/rLGqBOl1Gt0jGtA7ZZuoAL7ZiFUwWF495EjCBD/XQO3uJYd
        MLm67Rap50Qw3jccRAnEx+46jA==
X-Google-Smtp-Source: APiQypIxMn46g+55b45NDGZdPONQ89Nvi/DI/B3cU51447QU2hucLmL6ZONomqwgk/QPPhwmgARuLQ==
X-Received: by 2002:a37:7e01:: with SMTP id z1mr9121363qkc.230.1588776418520;
        Wed, 06 May 2020 07:46:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h188sm1801161qke.82.2020.05.06.07.46.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 May 2020 07:46:57 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jWLK5-0003j7-GX; Wed, 06 May 2020 11:46:57 -0300
Date:   Wed, 6 May 2020 11:46:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] IB/hfi1: Fix another case where pq is left on
 waitlist
Message-ID: <20200506144657.GA14279@ziepe.ca>
References: <20200504130917.175613.43231.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504130917.175613.43231.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 04, 2020 at 09:09:17AM -0400, Mike Marciniszyn wrote:
> The commit noted below fixed a case where a pq is left on
> the sdma wait list.
> 
> It however missed another case.
> 
> user_sdma_send_pkts() has two calls from hfi1_user_sdma_process_request().
> 
> If the first one fails as indicated by -EBUSY, the pq will be placed on
> the waitlist as by design.
> 
> If the second call then succeeds, the pq is still on the waitlist
> setting up a race with the interrupt handler if a subsequent request uses
> a different SDMA engine
> 
> Fix by deleting the first call.
> 
> The use of pcount and the intent to send a short burst of packets followed
> by the larger balance of packets was never correctly implemented, because
> the two calls always send pcount packets no matter what.  A subsequent
> patch will correct that issue.
> 
> Fixes: 9a293d1e21a6 ("IB/hfi1: Ensure pq is not left on waitlist")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Kaike Wan <kaike.wan@intel.com>
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> ---
>  drivers/infiniband/hw/hfi1/user_sdma.c |    4 ----
>  1 file changed, 4 deletions(-)

Applied to for-rc, thanks

Jason
