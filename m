Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9B2C20B78
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 17:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfEPPrW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 11:47:22 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:46640 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEPPrV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 May 2019 11:47:21 -0400
Received: by mail-qk1-f169.google.com with SMTP id a132so2499480qkb.13
        for <linux-rdma@vger.kernel.org>; Thu, 16 May 2019 08:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gly8914u3fKxIHFmEeK50AYE/jyinnnGvcJ3KWwW7Ds=;
        b=HDT9jbbK4ch9j6HSTxDoHQUdcM8qeu/yA9Fu12Lc7ib7zP2YRJSWnZP6bDuPpSjYs1
         quAT+rxeDsQIfYZ2RP4ydGa9a2GdTxeZXNa03GmLTfpXbaDNWlE3PpKXIJlpg4dZCClz
         K+FX+8EbqPwpBgzWnZsEIrhEwQuBrYpFc+9hihX8bTxUqJyLFTMyXwIM0sxhwaJwqnnw
         sSGDE1rTWCY0krNM0RUJB+YEoz9u/dYj5J+HCD7YXa9chRxPe2AiP/uiEIr38ehFTXL/
         hf79fgXNBN9wxvyr1Hx37+NpoFzzLz1M+sba8t41oRqLFV+3locA0VwyLyEbmGSNkggj
         VBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gly8914u3fKxIHFmEeK50AYE/jyinnnGvcJ3KWwW7Ds=;
        b=W2rAce1d3B60ogX4SxfvvO8jZjV0IpDHbuhlbAMWxXN6gmLJcMYQnHWbdnF8Fv2xAQ
         xZBxO/xiGqyg9nOt7dyHX5P8g+V3yW7Vhbq48GCfI8SGKEQwdAXif5UuVuG2ujXhrgsR
         FWHidZ2HRvXbIHL5gM24AyVUd09QfULY852c6HofOQSuRSAV4PhD5StL2W5FxWG1ov2g
         OVxHViVsENRFS4HODWU3tus/cP1EjKefk25Scs79VDkU0vGTQ/uKJSg2Izmq4elJtHWF
         vG+DaYj0KRDqA1erPVkkbzL3hQbFvf6Z6bpB9W28xhKjrOXHdcddAiXBIu+sZShFydZf
         kV8A==
X-Gm-Message-State: APjAAAUEcYiT8RNb3Pf1s2CeoC60XSg/fpymFcS6U3K+w+JmjrlZibin
        LmEmwY5EGUGdHHFFebsw2cGfcQ==
X-Google-Smtp-Source: APXvYqxcft7k9ZGGhx1YMVzykTtZgxJpxdQ34kTU12kTIx+wofqhZL+vO3Mi+fMfAv7d/ryTlS2DPA==
X-Received: by 2002:a05:620a:118d:: with SMTP id b13mr13767660qkk.113.1558021640992;
        Thu, 16 May 2019 08:47:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id h123sm2885570qkf.5.2019.05.16.08.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 08:47:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hRIbI-000236-16; Thu, 16 May 2019 12:47:20 -0300
Date:   Thu, 16 May 2019 12:47:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: iWARP and soft-iWARP interop testing
Message-ID: <20190516154720.GE22587@ziepe.ca>
References: <20190507161304.GH6201@ziepe.ca>
 <49b807221e5af3fab8813a9ce769694cb536072a.camel@redhat.com>
 <OF39E350A0.36B83BDF-ON002583FC.0053C32C-002583FC.0055FBFD@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF39E350A0.36B83BDF-ON002583FC.0053C32C-002583FC.0055FBFD@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 16, 2019 at 03:39:10PM +0000, Bernard Metzler wrote:
> 
> >To: "Doug Ledford" <dledford@redhat.com>
> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >Date: 05/07/2019 06:13PM
> >Cc: "linux-rdma" <linux-rdma@vger.kernel.org>, "Bernard Metzler"
> ><BMT@zurich.ibm.com>
> >Subject: Re: iWARP and soft-iWARP interop testing
> >
> >On Mon, May 06, 2019 at 04:38:27PM -0400, Doug Ledford wrote:
> >> So, Jason and I were discussing the soft-iWARP driver submission,
> >and he
> >> thought it would be good to know if it even works with the various
> >iWARP
> >> hardware devices.  I happen to have most of them on hand in one
> >form or
> >> another, so I set down to test it.  In the process, I ran across
> >some
> >> issues just with the hardware versions themselves, let alone with
> >soft-
> >> iWARP.  So, here's the results of my matrix of tests.  These aren't
> >> performance tests, just basic "does it work" smoke tests...
> >
> >Well, lets imagine to merge this at 5.2-rc1? 
> >
> >Bernard you'll need to rebase and resend when it comes out in two
> >weeks.
> >
> >Thanks,
> >Jason
> >
> >
> I think I addressed all major issues of the current siw RFC.
> 
> Probably most important, it's now guaranteed that the remaining
> two objects (QP and MR) are kfree'd after return from the
> ib_devices free call. This makes it easier for future development
> of mid layers resource management, as Leon was pointing out.
> 
> All IDR usage is gone as well.
> 
> I removed the siw protection domain, since there is nothing
> siw specific to be stored within. I just keep a structure
> definition of 'struct siw_pd {struct ib_pd *base_pd}' to
> keep INIT_RDMA_OBJ_SIZE() happy. 

? Really? I iwarp doesn't use a protection domain?

> Please advise what I shall do next to keep it going. Shall
> I send another RFC or rebase/resend it to current for-next
> now?

Rebase it when rc1 comes out and resend as not an RFC

Jason
