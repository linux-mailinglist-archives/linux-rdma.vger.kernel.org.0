Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8479D26C
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 17:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732957AbfHZPOr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 11:14:47 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43399 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732956AbfHZPOr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Aug 2019 11:14:47 -0400
Received: by mail-qk1-f195.google.com with SMTP id m2so14279776qkd.10
        for <linux-rdma@vger.kernel.org>; Mon, 26 Aug 2019 08:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mQ5NrxEVb4Y4M7SLU7tmn6Ut0GlJSMpz6tRbXvJFFso=;
        b=Aoyde1A4ubkZtJil9wO3XPC/CF7+ifEVgas8R6+tVpvbsG8yn+pDKU+2C3sc1tCjRe
         phzFKbBAWLcWjW9iqaYFJcCMbZH6XV/iRnLDZQ/ls1zQmicTknNMP0vnELFwkfPm31Oa
         cbvGhZSRUKGV9vci3EETA9IFmm8iRK/g3Xws3Wuo5DaEaSdbZmc4hWpG53dlv3/0lJZu
         9eXmRwWzmsR2eJZf5zc3yDigXOWwAXlyu5GebuuaISaafFHkvu9qUKsY/o4blvv2RD5Y
         dXxAuyNUPLl9YvGLdw8nXHLSNrpT3TiVKDD/1HiVUw9XSMexf8zWF69sadEllrW6qyAE
         aYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mQ5NrxEVb4Y4M7SLU7tmn6Ut0GlJSMpz6tRbXvJFFso=;
        b=KqnZn3GHSgHKTe04hzpU5qkz3ft65aOegSQm0n3RNhzOI2iYhkQroRVu/ulY5sbOUv
         0iE6RAJ+GkuLuPsvTzzYSWIKs7Xn7BNTeKjOsyiKlaUvJclDhThkrE6Mti7fLVXerJ24
         elbpgOZeCJPt9WdwbN4u/M6GLERCUfVB6yNGx4OBuJPPaKqLBm43nbFeJOKEk0VOYz31
         Xs0ITRK2QMI/h5Vc2DxTc2/NQTDtvN1pb8z9N2fFgDytW/LMMlwi06vcj8JDgu5sorIu
         nMOnrfRIeijrw4RZV0dw0bZTSpHb/WdKTRdNwvuZ7SvAEKgA3C/vtP1+GlEz3BB7LOOd
         Ke0w==
X-Gm-Message-State: APjAAAWMsWpGXHVY+j+m2O7spW0E0plp2alfcyaD79pVfSsHDZk/qqyK
        CCpSuz1TolMiKVtKJK7DRp/NZg==
X-Google-Smtp-Source: APXvYqxPVP58Ebwfzm4EfMFJFJd/dwpWZa4aWIJLv3BaVsnDqPsU4/pLb2Xgfbt1dtF7r+RZ1WHZAw==
X-Received: by 2002:ae9:e901:: with SMTP id x1mr17284021qkf.265.1566832486256;
        Mon, 26 Aug 2019 08:14:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id t5sm6545190qkt.93.2019.08.26.08.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Aug 2019 08:14:45 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i2Ghh-0006Kt-FM; Mon, 26 Aug 2019 12:14:45 -0300
Date:   Mon, 26 Aug 2019 12:14:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, dledford@redhat.com
Subject: Re: Re: [PATCH] RDMA/siw: Fix IPv6 addr_list locking
Message-ID: <20190826151445.GD27349@ziepe.ca>
References: <20190826142520.GB27349@ziepe.ca>
 <20190826141740.12969-1-bmt@zurich.ibm.com>
 <OF9B978FE2.360D6425-ON00258462.00521BE6-00258462.00538708@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF9B978FE2.360D6425-ON00258462.00521BE6-00258462.00538708@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 26, 2019 at 03:12:20PM +0000, Bernard Metzler wrote:
> 
> >To: "Bernard Metzler" <bmt@zurich.ibm.com>
> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >Date: 08/26/2019 04:25PM
> >Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org,
> >dledford@redhat.com
> >Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Fix IPv6 addr_list locking
> >
> >On Mon, Aug 26, 2019 at 04:17:40PM +0200, Bernard Metzler wrote:
> >> Walking the address list of an inet6_dev requires
> >> appropriate locking. Since the called function
> >> siw_listen_address() may sleep, we have to use
> >> rtnl_lock() + rcu_read_lock_bh() instead of
> >> read_lock_bh().
> >
> >What is the RCU for if you have RTNL?
> >
> 
> Frankly, I looked around in net/ipv6 and found, if not
> rwlocked, addr_list walking to be rcu protected, even
> if rtnl_lock()'d (e.g. addrconf_verify_rtnl()).
> 
> You are saying this is useless and overdone, since all
> changes to that list are rtnl_lock protected right?
> I was not sure about that.

I'm not sure, I thought it was the case that rtnl protected the
address lists on write.

> For the IPv4 case further up, we also take the rtnl_lock,
> and RCU-deref the address pointer (via
> in_dev_for_each_ifa_rtnl()).

That uses rtnl_derference which calls into rcu_dereference_protected
which is saying 'this RCU protected data is being read outside RCU
because we are holding the write side lock'

Which means it is locked by RTNL

Jason
