Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2326D75737
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 20:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfGYSuI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 14:50:08 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46917 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfGYSuH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Jul 2019 14:50:07 -0400
Received: by mail-qk1-f196.google.com with SMTP id r4so37155088qkm.13
        for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2019 11:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y4L7kTBXw1yQT2crJGOkjUhNG8iaVsIWi9dQ5W6VAqY=;
        b=ZLrbAFi6tXbGj0H0hR5YJW0CnfSmtN6AfqvM8UrzeLUmnKJBEqCcKzwk6fQJoTXebI
         r5TeBaGL2mIWockLaAfMudLCUsMVB2gKfwCaFkrJknQBmUAcroMJDV9n401bK8fPesr1
         XbFNiked/+vqgZgugxkKB5OmncUpGJDujusA9BAGPRyvYfmABVlzhsMmt0ThggK7G586
         Bk9TxGZWl02UFImC4cszPFBlHZCd73+qugqpJcwtpq1z4SXSqPdCtHTxOMLRy8A86JkO
         exGYra7y7+1izFnKavOUmUN9fdPGeUmM+U1Fcqp5LRe06d2bj0eTZvNyZ3RpEfVy6H6j
         /NJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y4L7kTBXw1yQT2crJGOkjUhNG8iaVsIWi9dQ5W6VAqY=;
        b=E0cbq6KMCvckf0o+tZLYlZrP+YcFgvDvnl0u3qWgcYTwThZQda0TptpN7zAzTju2lP
         WbCz0GziVvi4RPtcojXpWxBtdxcBniEACOo1mMxwukpMPfsdJ7uCd9HWhEFdmwlLcjwr
         Fup5GEBW9HzBTPIHfktcn0VpwT/ZnOJwS9SGoKOJFvIpVE5WvITkbjFpkOl6BxXPtt/i
         RyJwXCN/wwGpKA3vl2HlQHtNqaEqWyOwI4NBwmnvPfGcYUqxn1JdPa1o7ajPPFH2HfZU
         jrE+3W84UBsOOmbK+NLI1OKVdAlGY+J85U1C7EiJlYT9qFhu0NayEeXP95S6N1jcgeLl
         Q3BA==
X-Gm-Message-State: APjAAAU+pty3yDe9ScejzDHuYu08scZOcf8+gZ9w1iEnWGoczwBrxrA6
        t/liYyaoP158MeKWgOlLRvMxjQ==
X-Google-Smtp-Source: APXvYqwwhb5abS6t+bEuSsrus6WRso4TfWD199d8DejmWFRvwqGjAtWgkbAwtf2Rnc8TEBApIDaXlA==
X-Received: by 2002:a37:4e17:: with SMTP id c23mr59771760qkb.34.1564080607042;
        Thu, 25 Jul 2019 11:50:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o18sm30186576qtb.53.2019.07.25.11.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 11:50:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqioY-0000nR-6a; Thu, 25 Jul 2019 15:50:06 -0300
Date:   Thu, 25 Jul 2019 15:50:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Cc:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] Replace tasklets with workqueues
Message-ID: <20190725185006.GD7467@ziepe.ca>
References: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
 <20190722151426.5266-11-mplaneta@os.inf.tu-dresden.de>
 <20190722153205.GG7607@ziepe.ca>
 <21a4daf9-c77e-ec80-9da0-78ab512d248d@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21a4daf9-c77e-ec80-9da0-78ab512d248d@os.inf.tu-dresden.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 25, 2019 at 04:36:20PM +0200, Maksym Planeta wrote:
> Is this one better?
> 
> Replace tasklets with workqueues in rxe driver. The reason for this
> replacement is that tasklets are supposed to run atomically, although the
> actual code may block.
> 
> Modify the SKB destructor for outgoing SKB's to schedule QP tasks only if
> the QP is not destroyed itself.
> 
> Add a variable "pending_skb_down" to ensure that reference counting for a QP
> is decremented only when QP access related to this skb is over.
> 
> Separate part of pool element cleanup code to allow this code to be called
> in the very end of cleanup, even if some of cleanup is scheduled for
> asynchronous execution. Example, when it was happening is destructor for a
> QP.
> 
> Disallow calling of task functions "directly". This allows to simplify logic
> inside rxe_task.c
> 
> Schedule rxe_qp_do_cleanup onto high-priority system workqueue, because this
> function can be scheduled from normal system workqueue.
> 
> Before destroying a QP, wait until all references to this QP are gone.
> Previously the problem was that outgoing SKBs could be freed after the QP
> these SKBs refer to is destroyed.
> 
> Add blocking rxe_run_task to replace __rxe_do_task that was calling task
> function directly.

Mostly but it would also be good to describe the use after free and
races more specifically

Jason
