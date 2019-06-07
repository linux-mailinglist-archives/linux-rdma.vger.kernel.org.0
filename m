Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD0873970C
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 22:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbfFGUtc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 16:49:32 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42338 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbfFGUtb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 16:49:31 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so3856532qtk.9
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 13:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xpue/yTKTfw/egd/V5x6eR0dUTrWX63mNojFgXXVaNY=;
        b=XXE969tPj//9W51VkE9buoc1JR7bmeVIhDAenkig2qDcQeGQ9MQNdB4210YOgBQ6Ee
         urj3N09P7L5Mjvi4xbXHFj8HKfPprYKq7M7k/EcjofeMB2GoxEsuqBmDRxsipmPauBqe
         JJ48ov9QD+JiHQdqD9ykoXBcB6idhYNIBBpzZJ3zljvLxzfdUEHW6WPXsiiOISOg1mj6
         7DBax0TlpUXdzKzMpIHUKAbPg2PH7L5VNttRwq2gKh2xi8KiWg94GJWmCGzV9d7EA4dS
         T2I4WYqCFPx5kBGsqWXqkhkJCYicSNB5CNfx8sekAbHUUM1GtLdieXZWKGLrM/mxrLUx
         C/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xpue/yTKTfw/egd/V5x6eR0dUTrWX63mNojFgXXVaNY=;
        b=SxyKpQLEnRN2wA80ouUM5XrVxIuaocMyWzgaSg0Ci95fA9kFDd6gvwkkj8bzg6zNDP
         +tMghjpXf3XyudtbO7zdpizJywfqgUZglp4nV7bGKMqauK/jONOEFSTnqo6Jwb/CZvwT
         kqOhjtJvHDsTGSpjGLySBsbFRMyvjDovXH/gln2/PQ4jUdGaM7J5GMMnrqXtgJsLyR5O
         mOURYw1FSqgAaXtr9pJVZyfvUfN1f6nzcd2lrENper4X5DGn3xfqWyHNcRPTeg3F+Ycy
         V/3+8LjFr8Ws2m7rhJDe4qmy6U6HPRIr2xADFd7uNB0/4PxP/KBwccRVXfaoIhUjOq2l
         uWRg==
X-Gm-Message-State: APjAAAV0VlfcHKG4S0R7D49A/BUUyJjrl/X6iO/hF4mFriKQ5niBbo+K
        YWfUhrAQ6qFb9CDGfMXbGzH4lQ==
X-Google-Smtp-Source: APXvYqzPKIbGhJdstJ73Gy3kLdTzS56fHmRoDPMXyiprmrDID4cHA2htBZhMjn4/4PIp+2lgQ2jdNg==
X-Received: by 2002:ac8:3325:: with SMTP id t34mr44082999qta.172.1559940571006;
        Fri, 07 Jun 2019 13:49:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id b66sm1666176qkd.37.2019.06.07.13.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 13:49:30 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZLnm-0001TA-75; Fri, 07 Jun 2019 17:49:30 -0300
Date:   Fri, 7 Jun 2019 17:49:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 hmm 09/11] mm/hmm: Poison hmm_range during unregister
Message-ID: <20190607204930.GV14802@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-10-jgg@ziepe.ca>
 <96a2739f-6902-05be-7143-289b41c4304d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96a2739f-6902-05be-7143-289b41c4304d@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 07, 2019 at 01:46:30PM -0700, Ralph Campbell wrote:
> 
> On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > 
> > Trying to misuse a range outside its lifetime is a kernel bug. Use WARN_ON
> > and poison bytes to detect this condition.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> 
> Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
> 
> > v2
> > - Keep range start/end valid after unregistration (Jerome)
> >   mm/hmm.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index 6802de7080d172..c2fecb3ecb11e1 100644
> > +++ b/mm/hmm.c
> > @@ -937,7 +937,7 @@ void hmm_range_unregister(struct hmm_range *range)
> >   	struct hmm *hmm = range->hmm;
> >   	/* Sanity check this really should not happen. */
> > -	if (hmm == NULL || range->end <= range->start)
> > +	if (WARN_ON(range->end <= range->start))
> >   		return;
> 
> WARN_ON() is definitely better than silent return but I wonder how
> useful it is since the caller shouldn't be modifying the hmm_range
> once it is registered. Other fields could be changed too...

I deleted the warn on (see the other thread), but I'm confused by your 
"shouldn't be modified" statement.

The only thing that needs to be set and remain unchanged for register
is the virtual start/end address. Everything else should be done once
it is clear to proceed based on the collision-retry locking scheme
this uses.

Basically the range register only setups a 'detector' for colliding
invalidations. The other stuff in the struct is just random temporary
storage for the API.

AFAICS at least..

Jason
