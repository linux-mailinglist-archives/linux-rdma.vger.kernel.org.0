Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC76039383
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 19:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbfFGRnB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 13:43:01 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:40457 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfFGRnA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 13:43:00 -0400
Received: by mail-qt1-f174.google.com with SMTP id a15so3223794qtn.7
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oeg4EF5rujeMPp9Nb508v+kktFKAGSLZCcv908l1IKI=;
        b=ASV7ALoDT2zd/fgs+zwpbGGUj0d/qCEx8lkGbpyMxX/W7LD3hK+5d/qGKsSk3EGIC5
         yDv9mgPFQpk3rVuje624DMrgJLaT2fuMeYl0n3m+dftgWTG7oeR1uZG0dEeSIbjxYE1/
         HQkgUODeG07bYrZrgmA2C1MBFRVpqljCDQze4qBlriSUbjaYMvxwp2ntxJzJz1TdtTfU
         ZSIOr/qYX0o2WEL2cWWQ+IBhm/4KEg/bww7JMdEm3JvdEW1ZqoTMqDSvRp8XWiP2bAzZ
         H4gN6kCxEV4uf6nG80fqFqXkJa6VSpzmk2bfOSQ8NSHuHbbDintF7SoFfxQD96Y/q6EQ
         hbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oeg4EF5rujeMPp9Nb508v+kktFKAGSLZCcv908l1IKI=;
        b=dVCmYwS/v8GPeeMkgd96ORf0LvgH8xLjwdd47EdcfPuzfI6x7fgR+ITJyIpcZnpqak
         FE6XxfHdm7ffWC4W+jq8z3pOu3FN8QQgkNIgU4bX0vthu/PrkLMGDoesW4qmYVZGwIkE
         KlXbzS1/1zrVljS3+QTWOO6qASOFOmTE4VFQlFK1B3eHmqxutbv392xZJlLolvaGGe2m
         nJJXJTyDw7ioMDNQXHmhYMFwcmdea0bMrcbZycM10U0lOI5fJJd34NN2JYOyOl+eiqi+
         vuI0TUj/E6QF8mEOoDa1ukVr1YqTssRcJtr0DFr3l947w/DKnbMRJ0/i2qonCG9JU0FZ
         cmJg==
X-Gm-Message-State: APjAAAVY0Zw8V6vEzUTzDvr6Zh2Oqk4MGXsjhpuRzBUR17KKuhsZWIJi
        Mn6wZwDHCloadp16aEdgrQ9w2w==
X-Google-Smtp-Source: APXvYqymWEMaLa+WKtddtzs6yJGAH+5gbYNxEwl4/peDnB4fesrHGK3NrZV0fixGWqPE635JbizZyg==
X-Received: by 2002:ac8:2edc:: with SMTP id i28mr27410453qta.77.1559929379521;
        Fri, 07 Jun 2019 10:42:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id w143sm1375909qka.22.2019.06.07.10.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 10:42:58 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZItG-0006H8-GC; Fri, 07 Jun 2019 14:42:58 -0300
Date:   Fri, 7 Jun 2019 14:42:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Steve Wise <larrystevenwise@gmail.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>
Subject: Re: RFC: Remove nes
Message-ID: <20190607174258.GO14802@ziepe.ca>
References: <20190607162430.GL14802@ziepe.ca>
 <CADmRdJfDLp_C+rVuRqDVfDahtcwSDb8HGgR2_SHmbxD3AUghfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADmRdJfDLp_C+rVuRqDVfDahtcwSDb8HGgR2_SHmbxD3AUghfw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 07, 2019 at 12:23:45PM -0500, Steve Wise wrote:
> On Fri, Jun 7, 2019 at 11:24 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > Since we have gained another two (EFA, SIW) drivers lately, I'd really
> > like to remove NES as we have in the past for other drivers.
> >
> > This hardware was proposed to be removed at the last purge, but I
> > think that Steve still wanted to keep it for some reason. I suppose
> > that has changed now.
> >
> > If I recall the reasons for removal were basically:
> >  - Does not support modern FRWR, which is now becoming mandatory for ULPs
> >  - Does not support 64 bit physical addresses, so is useless on modern
> >    servers
> >  - Possibly nobody has even loaded the module in years. Wouldn't be
> >    surprised to learn it is broken with all the recent churn.
> >
> > Remarkably there still seem to be cards in ebay though..
> >
> > Jason
> 
> It wasn't me.

Oh? I wonder who..

> Perhaps we were discussing cxgb3 removal?

I know we discussed that :) can we remove cxgb3? :)

> Anyway, are you certain it doesn't support REG_MR?  I see support
> for it in nes_post_send().

Hm, not really, but I thought it was one of the ones. It does set
IB_DEVICE_MEM_MGT_EXTENSIONS so I guess it is OK.

Jason
