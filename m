Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB447393A9
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 19:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfFGRvN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 13:51:13 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35925 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfFGRvN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 13:51:13 -0400
Received: by mail-qk1-f195.google.com with SMTP id g18so1797943qkl.3
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ftOcUP73RZzUm+VegKqsInCyEUpzXcRJHtIqvRcMGok=;
        b=chkBcaJ7yPc5qcIWSAyUE0FBGEWERKxe0I/INk9nTbYYYY9ODGdApAXYv40iBvLQhM
         tId4WIVsrZ8k2mJ64AzSrga7F7S7KqkBr0LC0vRXLjpckaiYkJYmJUiQ6OyBkiIONYdB
         DcnlnqpYt9N9e6eC7uGKiRJewX6Ld0dPcMxq9w2PE2dJGAwkh/kj8pxi4EN0rqJa+BwN
         AALz89/HBxTXiqsTOsGQdg5BtVXMCBskrHzABsu+gZwPrljn5Kma3eajFMauNe6+caRn
         PeZSEd/xj7LnOyEw2fP/5hWoh8jArurcYOJmgklyfpNa0T9WUCcvF5UlGCAKB5x/6Nzo
         Ljxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ftOcUP73RZzUm+VegKqsInCyEUpzXcRJHtIqvRcMGok=;
        b=UmbfuDUtMqYUwmG2t/Lx5jBSJQZ1nHPzPIyOHYY2HAtp+YtUbZF+NtqbWJukFFFJEm
         46G7MFKWUg8lskSdo8OKwhSmWcEGLi3FjzM1fNjz9K6w4fa60wPTjxBWrQSqRS7hIy7D
         0iNjNxxhyTLgik7SISKwHlIhCdxOnvjueSTwKuke+cjuIdKHMg5SL5rEw/TyIPJrPeWb
         kfRm6jZoJzcUJRUqJ0TxfV6i0rvDcNvg0rHkdRdShLzPsvpb0oR0zHRS8dmlSfJxfF7h
         Ivz2vvyoUs9lPtAWyYwBiCRYIDF0WLRnMtNvfdgwW3PgWPQv7OpnPI1YYTQN9tm0m09k
         vt4g==
X-Gm-Message-State: APjAAAXD3LsBLGRBTcGXayLSGCvPHZmTHPpBiyVxxa6bylALUvQvxcg4
        bhzYnEgCtfoXr9NepIECb7Huhw==
X-Google-Smtp-Source: APXvYqx6JpP2wg/nwlUe7EI5hXfg8MB0H4ntcsDCdLcu02wYar7DIkfaaOHIY7sP4wSMZqqkR58QKQ==
X-Received: by 2002:a37:c408:: with SMTP id d8mr36269829qki.18.1559929872083;
        Fri, 07 Jun 2019 10:51:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id t187sm1325665qkh.10.2019.06.07.10.51.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 10:51:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZJ1D-0006KR-1d; Fri, 07 Jun 2019 14:51:11 -0300
Date:   Fri, 7 Jun 2019 14:51:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com
Subject: Re: [PATCH for-next v3 0/4] ib_pd should not have ib_uobject
Message-ID: <20190607175111.GA22828@ziepe.ca>
References: <20190530122422.32283-1-shamir.rabinovitch@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530122422.32283-1-shamir.rabinovitch@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 30, 2019 at 03:24:05PM +0300, Shamir Rabinovitch wrote:
> This patch set complete the cleanup done in the driver/verbs/uverbs
> where the dependency of the code in the ib_x uobject pointer was
> removed.
> 
> The uobject pointer is removed from the ib_pd as last step 
> before I can start adding the pd sharing code.
> 
> The rdma/netlink code now don't have dependency in the ib_pd
> uobject pointer and can report multiple context id that point
> to same ib_pd. 
> 
> Using iproute2 I can test the modified rdma/netlink:
> [root@qemu-fc29 iproute2]# rdma/rdma res show pd dev mlx4_0
> dev mlx4_0 pdn 0 local_dma_lkey 0x8000 users 4 comm [ib_core] 
> dev mlx4_0 pdn 1 local_dma_lkey 0x8000 users 4 comm [ib_core] 
> dev mlx4_0 pdn 2 local_dma_lkey 0x8000 users 5 comm [ib_ipoib] 
> dev mlx4_0 pdn 3 local_dma_lkey 0x8000 users 5 comm [ib_ipoib] 
> dev mlx4_0 pdn 4 local_dma_lkey 0x8000 users 0 comm [ib_srp] 
> dev mlx4_0 pdn 5 local_dma_lkey 0x8000 users 0 comm [ib_srpt] 
> dev mlx4_0 pdn 6 local_dma_lkey 0x0 users 2 ctxn 0 pid 7693 comm ib_send_bw 
> dev mlx4_0 pdn 7 local_dma_lkey 0x0 users 2 ctxn 1 pid 7694 comm ib_send_bw
> 
> Changelog:
> 
> v1->v2
> * 1 patch from v1 applied (Jason)
> * Fix uobj_get_obj_read macro (Jason)
> * Do not allocate memory when fixing uobj_get_obj_read (Jason)
> * Fix uobj_get_obj_read macro (Jason)
> * rdma/netlink can now work as before (Leon)
> 
> v2->v3:
> * rdma/netlink nest multiple context ids of same ib_pd (Leon)
> 
> Shamir Rabinovitch (4):
>   RDMA/uverbs: uobj_get_obj_read should return the ib_uobject
>   RDMA/uverbs: uobj_put_obj_read macro should be removed
>   RDMA/nldev: ib_pd can be pointed by multiple ib_ucontext
>   IB/{core,hw}: ib_pd should not have ib_uobject pointer

I have to think it is rather a clunky approach..

I keep moving the _cmd flow closer to the attrs flow - so to do that
we should be recording the uobj 'get' in the uverbs_attr_bundle and
then putting them when the handler exits automatically. Just like the
attr flow does.

This requires a bit of moving code around so that the write path has
the bundle_priv which records all of this.

What do you think?

Jason
