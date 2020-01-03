Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6935512FE1B
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 21:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgACUrL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 15:47:11 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:35899 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgACUrL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 15:47:11 -0500
Received: by mail-qv1-f65.google.com with SMTP id m14so796221qvl.3
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 12:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HWSgfSNckyAPcKwlqkqymBcotOO8BjxRLt7B5UyU6qI=;
        b=WUTQZDd0eg+P2NQ9vupdbwGad7KeEdwooyufB+PSJjEHnyflRGaunTcRKM7+nNZ4Fh
         6zHjOQbS6aVAuCnyMUXOpVXupFqgtGRSs1hbaeoyWG3zlgdjE5gmSMjAvVSVJwHnfltc
         LvzFFp+BouK4qT4nZcWZQjKLdJsegEb7kQ+NDfgF7YJDOqbCPPGP26ZvNn8V/HuwhmN8
         WcIAsThx5VSdGxcF0bKdv6PAU9KSzTgT3KjJheN/FhniD1tvoQvPUUdZp7wYM/bziKFN
         Ttjd+wrdCJa/ZiEFaI6cc8eHOKb5YE/IC2/yZuNEzJU10pQLjZj6kTZQ26N3me1A3x3r
         iPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HWSgfSNckyAPcKwlqkqymBcotOO8BjxRLt7B5UyU6qI=;
        b=FyPlBI2BjAR3ozOfhcrJABRlmJ9VNYineAuA1KAiOw2hrLK/CoclIINhJseHieV3/W
         nxNUFx7Vf9VLuN7gzSI10PYIXDn05rS+5HM7jTSKqGvi2ocwPntsPEazLqaJAHYndGep
         B0ctUSy3rVk1/oGSHso536ka1e5vnCvK+P1N5cAc9T63bS262VVMIPknwGdNhWxNz+jA
         NUf7sIl9wFcO3OKR0AotViqbibHJD/JfJVlYWazd5D3BXmxFCoEj6kam2YUVApRz9Jq6
         2pKmKLBdgy0AGZi2FNueYAfdY7LmCTMQRoDPE4g1nuO4TbMhr6dsOZ9JQ92dSBkHzRY7
         Prhg==
X-Gm-Message-State: APjAAAVKx+g0xc+2lKQ6rStph2R1LmSETFyVw55I+8ykZHnjoBDLQAgK
        WBU1F+J6/WXRhBwSIzeVBfDbig==
X-Google-Smtp-Source: APXvYqz41nkq9lyt4ariwh1rlwK9va08w8y1fceIe/Vdut5EoDdiyk5BDoepM0s6g6WaDot83UH+pg==
X-Received: by 2002:a0c:acc6:: with SMTP id n6mr70193159qvc.26.1578084430515;
        Fri, 03 Jan 2020 12:47:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 24sm17187506qka.32.2020.01.03.12.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 12:47:09 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inTqf-0002z0-Gc; Fri, 03 Jan 2020 16:47:09 -0400
Date:   Fri, 3 Jan 2020 16:47:09 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 0/4] Patches for 5.5 rc
Message-ID: <20200103204709.GA11402@ziepe.ca>
References: <20191219211609.58387.86077.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219211609.58387.86077.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 19, 2019 at 04:19:15PM -0500, Dennis Dalessandro wrote:
> The first two patches I wouldn't ordinarily have sent for -rc but I noticed we
> did this in the previous -rc post, add an API because we use it in the next fix.
> That's what the first two patches here do. It's understandable if you are
> skeptical that those are OK for -rc and in which case you can drop and we can
> send for next.
> 
> 
> Kaike Wan (1):
>       IB/hfi1: Don't cancel unused work item

As I said before, I took this one to -rc

> Michael J. Ruhl (1):
>       IB/hfi1: List all receive contexts from debugfs

This version of the patch now applies cleanly, so please disregard my
earlier email

> Mike Marciniszyn (2):
>       IB/hfi1: Add accessor API routines to access context members
>       IB/rdmavt: Correct comments in rdmavt_qp.h header

These three are applied to -next

Thanks,
Jason
