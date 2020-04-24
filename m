Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261861B7DC7
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 20:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgDXSW1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Apr 2020 14:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726920AbgDXSW0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Apr 2020 14:22:26 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A506CC09B049
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2020 11:22:26 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id z90so8694366qtd.10
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2020 11:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lhGTjJMhmPbj8xPe+GsSJUkT3nEa8rLgCXmIyP6n+eg=;
        b=XuG0PscT5Vy9AhQ07hBkyvEkq2yXGGhb2Q+VNmgpLsuJ7Jn0M2LMPyj9Zzoy9THFPj
         inYepjqYVMhUVsWfMIxeSxAH4oHv9Z2Ireh79/qdLuYDZPBFB8caEnFzj1vOsAc3MFTZ
         0h6zrkRJ1KpObaIj8NBryckJewzgHIdBg+IdtoVSId4RZYqjHjC9iV6QNioSaGyopj7S
         jZ9EpZZGk96mBAYzKH9wfWbhrZ0qLBUMU3lCSy5JdEmNka9lqA98ds6XqZ73xhM6qVrw
         DQO/roYYut/HjxGTiISog7JZewLaLSZ5gua4Mcf6kciKsqHoi29saNKxmNrb7k71uyS+
         XU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lhGTjJMhmPbj8xPe+GsSJUkT3nEa8rLgCXmIyP6n+eg=;
        b=OSyH2dNmN0KOjhNyTHr7Waa0LW1o/P36wS3pnOy9NH5XCQOeqWfQEOlsnPi8JLSJse
         TUWx+6GGJfuBBVi+zsV2J5IsHN5skgi3WOB3bBbcnhfE6pqvcgcUkcvcEZOQNg+TpmMq
         A8D6t08DZsEFpVrLZ9xhMXyLwhxedq5zhynZax8vgehKugJOG2x8onm6ZM3I06DOXoN6
         leTLH94G46S+usuGfJCs07+4dWURrq1gsbzrQIIKSs4p528vRibj1DLIsh66eMFXXw3c
         WfPTFHYu0jBpCuQhRkKK0T987eYKiAnq4XG8FBeBPZrSOPyzCYOwhlAibRaH2eJO6tPk
         KTCg==
X-Gm-Message-State: AGi0PuYLPXEFRlWleto9WCA7htwEX5FGOQNmOFkKyJaVVccw6hoCLG2o
        siyyhl1SaaalDou8y/aLRWE9WCLvGh+h9g==
X-Google-Smtp-Source: APiQypJStB8wsJfDWdyA/PthSh8h8Uu+e+WkD2TKfEXk/FixxfTDwIdDwtg8xf7iRPsocs6v8A0T/g==
X-Received: by 2002:ac8:70c8:: with SMTP id g8mr10918555qtp.385.1587752544732;
        Fri, 24 Apr 2020 11:22:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id b10sm4334352qtj.30.2020.04.24.11.22.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Apr 2020 11:22:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jS2xz-0004Nd-RG; Fri, 24 Apr 2020 15:22:23 -0300
Date:   Fri, 24 Apr 2020 15:22:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>
Subject: Re: Request for feedback : Possible use-after-free in routing SA
 query via netlink
Message-ID: <20200424182223.GI26002@ziepe.ca>
References: <8fbdf10e-3f08-6407-eb0d-a1bf663873c3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fbdf10e-3f08-6407-eb0d-a1bf663873c3@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 24, 2020 at 08:28:09AM -0700, Divya Indi wrote:

> If we look at the query, it does not appear to be a valid ib_sa_query. Instead
> looks like a pid struct for a process -> Use-after-free situation.
> 
> We could simulate the crash by explicitly introducing a delay in ib_nl_snd_msg with
> a sleep. The timer kicks in before ib_nl_send_msg has even sent out the request 
> and releases the query. We could reproduce the crash with a similar stack trace.
> 
> To summarize - We have a use-after-free possibility here when the timer(ib_nl_request_timeout)
> kicks in before ib_nl_snd_msg has completed sending the query out to ibacm via netlink. The 
> timeout handler ie ib_nl_request_timeout may result in releasing the query while ib_nl_snd_msg 
> is still accessing query.
> 
> Appreciate your thoughts on the above issue.

Your assesment looks right to me.

Fixing it will require being able to clearly explain what the lifetime
cycle is for ib_sa_query - and what is there today looks like a mess,
so I'm not sure what it should be changed into.

There is lots of other stuff there that looks really weird, like
ib_sa_cancel_query() keeps going even though there are still timers
running..

Jason
