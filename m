Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D57629C8B
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 18:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390210AbfEXQxE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 12:53:04 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:41233 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390448AbfEXQxD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 May 2019 12:53:03 -0400
Received: by mail-vk1-f193.google.com with SMTP id l73so2324674vkl.8
        for <linux-rdma@vger.kernel.org>; Fri, 24 May 2019 09:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BWxqjKZCed63tdrqv52w7wsfWcnck29Bguoecq4JyuE=;
        b=V2c3cbyoJqcZX30pcTkJEv7QnnWfFOVUG/SZKLtnQEgMJVwm89vkCiLejgP7M+iRpN
         q/gLFJwalceC5ic9vkHhbkH+U/d7dt/5gsWtZqSmPEamXKr1uoECt4WeGoJqd2HwGhbx
         9Occ1equYYbcXlCB88viJlGsBFmUVprPlSaUrUnpgJaFB5VgTgvCVd56gO+SEN+aAAgm
         xm1VbLsF+wb2n+Ta5LcBu1FilJNm/nl1Mj5onw2ziQywv/g3tjrYI+IB0DZ9YrwYdgB0
         VEIEcUTbHmI4X7mxwSOIeASg6iishBSuXQpcZN/RP20qWAgLsgkprlD05w//8ySkAW73
         D/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BWxqjKZCed63tdrqv52w7wsfWcnck29Bguoecq4JyuE=;
        b=G8Y65v+NgyiJ7ctEhq/fro5f0jom7Si3pEy8UrophhO/gxHFZro0wGg3RPmNzGJgo9
         pB4340jeiOYEyzbAlYD0D5AqgKoqP5KkGo8ljrzzEfdx6PfBqER9RwxqJ25LuTBl+H+X
         pWLDEn5mUVtGTbL1SIuR9vdtt+7tf2TmBXWEQmL7g+1vWx7hDmVlCw2Sm1Ioq3FjBWtA
         EoZAKLMbtGBG/+2RCuIj0EaIrq7TfIrYzOZS9olFSi6fkp4OO+MbJZCuoT/JanmKoaWn
         diq700XqykxKukXhjFThZg0ega+Vdo7U9OtBWB5HuVMkkU8rS1NiKwrIYflFPjCFbJVu
         1aMQ==
X-Gm-Message-State: APjAAAXh2eEeob7mOZpkatzN8fT0w0208UuR91jHXJzBTAS9+KXV2ZSG
        AOyTyWfVc1xBnHWe49KgtpT7Kw==
X-Google-Smtp-Source: APXvYqxGf4YX6m1bc63rX3ITovS0x9J+uBVKSme0zDKMj1gtik5rsITucqSrT8VXY0G62c80cqSI9A==
X-Received: by 2002:a1f:fe81:: with SMTP id l123mr6286152vki.51.1558716782783;
        Fri, 24 May 2019 09:53:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id b2sm1470363vkf.16.2019.05.24.09.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 09:53:01 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hUDRF-0008FA-F4; Fri, 24 May 2019 13:53:01 -0300
Date:   Fri, 24 May 2019 13:53:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
        Dave Airlie <airlied@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        linux-mm@kvack.org, dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: RFC: Run a dedicated hmm.git for 5.3
Message-ID: <20190524165301.GD16845@ziepe.ca>
References: <20190523154149.GB12159@ziepe.ca>
 <20190523155207.GC5104@redhat.com>
 <20190523163429.GC12159@ziepe.ca>
 <20190523173302.GD5104@redhat.com>
 <20190523175546.GE12159@ziepe.ca>
 <20190523182458.GA3571@redhat.com>
 <20190523191038.GG12159@ziepe.ca>
 <20190524064051.GA28855@infradead.org>
 <20190524124455.GB16845@ziepe.ca>
 <20190524162709.GD21222@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524162709.GD21222@phenom.ffwll.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 24, 2019 at 06:27:09PM +0200, Daniel Vetter wrote:
> Sure topic branch sounds fine, we do that all the time with various
> subsystems all over. We have ready made scripts for topic branches and
> applying pulls from all over, so we can even soak test everything in our
> integration tree. In case there's conflicts or just to make sure
> everything works, before we bake the topic branch into permanent history
> (the main drm.git repo just can't be rebased, too much going on and too
> many people involvd).

We don't rebase rdma.git either for the same reasons and nor does
netdev

So the usual flow for a shared topic branch is also no-rebase -
testing/etc needs to be done before things get applied to it.

Cheers,
Jason
