Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8EEB9EFB8
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 18:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfH0QHx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 12:07:53 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37059 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfH0QHw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Aug 2019 12:07:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id y26so21861178qto.4
        for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2019 09:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cckA6/bRrPXW6qlTX9ByJE7u0RzD14bJX9GtDxcEUnM=;
        b=IcSzgYDFrTYOvzL2QEY6oZkzwLPFZSxu7FRMqbtlk9ctbzKeeyh7O/QpUfPs9awo4I
         hOnklEreT0B6Zwb++yAMaqMpqbWPl0+BrjOFL6EnfVBvBvvGO3BCAYuvF02ZxnZpB+1W
         2NZd+SWihsogHt9/AdyLrlLvQmFeR8Dl6n1s+YDv3oqXzHPc3C40yKSGQ44STRvmgjm/
         z/MMT0/UxKjhWPCTCurjlF3U8ibMxMamMIF12jMY/poa6HPqVIeWf3gYnFEBGz4MmUHj
         YVQpOGI3oS/9jKyf1badLjGD+G2cxm+d7X4fyExX6MkvmIefqXIRYYjA2DPapIjn031b
         Mj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cckA6/bRrPXW6qlTX9ByJE7u0RzD14bJX9GtDxcEUnM=;
        b=b+X4V3od8BbEyakhGbgViYPyuHL9zvkqxC8UwgBqMnSR4UvkTX4eLBekUA1s0QNP/3
         q6tyQ62dBWQSmUxMTiVAm/PYi6qBkGNqFPUyukPn+1sslI0tc51GIudv8EdhQqIPj2eA
         DZrRLd7wagvrlIHIWUdt/szkQzSEChP2WrOYem9BFr4MvFZZhbRCVHf08RuyJO9wgNrI
         duJniv4vXQqO+vMKFcyBSCD243V1up+Ng182CzbOxI7upgmkv4k/nEptXCJsZbM9X4VK
         xYSuLijo5Zgi+tMKY0eiQIYosJ+L5q1scx1PldEeKqBeXtl+4AW5azzSTKDDmcKl876G
         n5BQ==
X-Gm-Message-State: APjAAAVg3V9SOcUlmyyXhGx4sVSTiPbI8js2zH3CwDJR98eRBQRIK9CJ
        J3UQjsUTEGH2cRHA1OMXpJWz8w==
X-Google-Smtp-Source: APXvYqzW5E1ESn8R7XS3rNNFe7PjBVxzc5GLyhDLRceVpABaKHJnIbZ2CaRK9bftzQ+sKbSn63YKAw==
X-Received: by 2002:ac8:1a08:: with SMTP id v8mr23635612qtj.277.1566922071939;
        Tue, 27 Aug 2019 09:07:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id v13sm1029399qkj.109.2019.08.27.09.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 09:07:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i2e0c-0002yU-SA; Tue, 27 Aug 2019 13:07:50 -0300
Date:   Tue, 27 Aug 2019 13:07:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/2] EFA cleanups 2019-08-26
Message-ID: <20190827160750.GA11348@ziepe.ca>
References: <20190826115350.21718-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826115350.21718-1-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 26, 2019 at 02:53:48PM +0300, Gal Pressman wrote:
> Hello,
> 
> This series introduces two minor cleanups for EFA that were hanging
> around in my local git waiting to be submitted.
> The patches are very straight forward, nothing intersting to say about
> them :)..
> 
> Gal Pressman (2):
>   RDMA/efa: Remove umem check on dereg MR flow
>   RDMA/efa: Use existing FIELD_SIZEOF macro

Applied to for-next, thanks

Jason
