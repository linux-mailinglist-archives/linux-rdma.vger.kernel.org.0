Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94E06172235
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 16:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbgB0P0c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 10:26:32 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:45784 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbgB0P0c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Feb 2020 10:26:32 -0500
Received: by mail-qt1-f171.google.com with SMTP id d9so2504695qte.12
        for <linux-rdma@vger.kernel.org>; Thu, 27 Feb 2020 07:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LRaPmV1PsjuQrgHe/F7yYZVrSSfw36PC7SBGYz6cUBA=;
        b=Af6Qzui+1Dj1/i7X04H0Vlve3W3bSdJBPVZU/QgXDJ5ApzqZeHLXh2nZM+9DvYuAu9
         L59W9NHe52YVpzTbKY5RCr20ve0QLyBFZN/95nkONeGw5rh5hONCc6AowchG1ZAF2PfA
         RAL8rjRBYIF4Nfv47+xrq7YBUA6Jht0qhKVhHDhyi16sQyS3brtWCx9T37lYxGiHmIMW
         +fH5ZJMNJUPguiaWpcEMLvhD3pn52k5qHl3jZ7uh+WeoBKedRUQR7TVwcfNZfUyOpYT6
         8eLw5NqRGD2L5b+iBH04XaFCJ79KPb/aAqYgB+OCBtopS2yhzAyAh7iFxk4k5hwarY3f
         jboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LRaPmV1PsjuQrgHe/F7yYZVrSSfw36PC7SBGYz6cUBA=;
        b=A1/ehrAeW9QGIj9dHgEioAspkxKN/WgBZg4Lu8FQCesrxRhRxYKZ24/OIrDz83BUSG
         BIb/MFxC+11w6f8cBksg+tMcOpmSnsIt+OSECc43hX4L8AaO5YRMFoBU8+XYZkuFAgbA
         32iPp+dbY0iRae8lqqms54vH4EJ+NoUy8k5lnIRQ5+jK0s0KTC1KO2H366EV+tTlt/d0
         nMyGNCxxnyWGNDJMiSlPRZ0OfXFzlR6ni7WtpAxp5QzRATcK6rk8miNoF34Yn+muso5s
         WsdGcX/o9sXK/5iYJmuNijQdEjmB1bokeVD2tncvmR/MZ2avmfEHbLIah06L5W2K6x1N
         SWHg==
X-Gm-Message-State: APjAAAWTmNjTuzBhVCNLjw0UuKpPGfJtouVXtgx1hM55gScSqBKzq6y8
        mTtmLa0f1VhKSENSf/sl83hK1Q==
X-Google-Smtp-Source: APXvYqyGJoeh+/bPLZoLrAQAqAI85cRQJB70yUWbg0Bh3eW3GiH8s6XZ5HnaW2DIiA5M2N6xtIPFWw==
X-Received: by 2002:ac8:7776:: with SMTP id h22mr5068111qtu.126.1582817189828;
        Thu, 27 Feb 2020 07:26:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id o2sm3282653qkd.93.2020.02.27.07.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 07:26:29 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j7L3U-00058P-L0; Thu, 27 Feb 2020 11:26:28 -0400
Date:   Thu, 27 Feb 2020 11:26:28 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Haim Boozaglo <haimbo@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: "ibstat -l" displays CA device list in an unsorted order
Message-ID: <20200227152628.GH31668@ziepe.ca>
References: <2b43584f-f56a-6466-a2da-43d02fad6b64@mellanox.com>
 <20200224194131.GV31668@ziepe.ca>
 <d3b6297e-3251-ec14-ebef-541eb3a98eae@mellanox.com>
 <20200226134310.GX31668@ziepe.ca>
 <20200226135749.GE12414@unreal>
 <20200226170946.GA31668@ziepe.ca>
 <1da164dc-9aff-038f-914a-c14d353c9e08@mellanox.com>
 <20200227133341.GG31668@ziepe.ca>
 <b5a619bc-582d-908a-6c6e-5df5bbe4b4b2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5a619bc-582d-908a-6c6e-5df5bbe4b4b2@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 27, 2020 at 09:55:23AM -0500, Dennis Dalessandro wrote:
> > > I can just sort the list at the time of insertion of each node.
> > 
> > I'd rather not have to pay the sorting penalty for all users, it seems
> > only a few command line tools need the sort
> 
> Should we really go out on limb here and assume it's just a few CLI tools?
> What about all the sysadmin type scripts out there? We aren't having a good
> track record not breaking user space lately.

'sysadmin scripts' can't view the umad list without going through a
cli tool - so sorting the cli tools that show lists of device things
will take care of it.

verbs is has always been unsorted, so things like ibv_devinfo 
return in creation order. (which I think is a different random
ordering than it used to be)

This isn't the first time someone has complated about sorting, I
recall there was a complaint about ibv_get_device_list() too, but it
was never sorted. It just happened that sometimes it would be sorted
by some luck.

At least in the umad case it was actually always sorted before.

I think we should also sort ibv_devinfo too while we are here.

> Is the sorting penalty really going to be that bad? It's not like we will
> have a large number of devices that sorting should really be an issue I
> wouldn't think.

There are configurations where we have a large number of devices.

Jason
