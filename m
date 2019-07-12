Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 369E467266
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 17:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfGLPcp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 11:32:45 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40275 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfGLPcp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jul 2019 11:32:45 -0400
Received: by mail-qt1-f193.google.com with SMTP id a15so8467185qtn.7
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 08:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6zUuNAxC0W8UA4PyJfN+NTLv2uHwtQW0uxPeJFySWhY=;
        b=WhHL4nEaSeEd0vRZOuyDcURKZ0cIDxWXvxDZbS9TJi+X/uea1BzMCjEV3BPQDBS7kF
         Dpkkz2XDk8Cq31X6ysMikLsVpO4/A6/XX+9SpUG+W1O09Ph1QgZt6F95E72Jvv5xOz7E
         q7g3yVOFNmZDNJiyrLb7uSW1KGLl0Q1+OFgPCeLMQs4aOOlyJ3DLJmK3xFUpVrkpjcsB
         QQY6IbgORFPsALQkh8diwYLGK2Iijn5DUi7LcqCzPyJj5Pixni0GPZh99oEQHA9a1HDc
         QuLsPci3N/i5e6QkqSbRmroGlDOqP8DKDJE1pkprzCZ4CQ2YDpVXaUlmhimtsJwtsYcH
         a6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6zUuNAxC0W8UA4PyJfN+NTLv2uHwtQW0uxPeJFySWhY=;
        b=eUziXqFfOKlLD/+sXfkISpdbOzcnxeD7k/vWLzDQbD/n66DkNiEgqB8H3gLejT5m2A
         qQh5uE89iYiSu1Qbj4lDnWGI5rJY8d5lbN6nVnRKlqWyZibWcsnOrQLhSh90IVtUJKzj
         yoLwDmVZmvIbGsL+wR7xGYQugyKR0hJBQe8JrHkqNflY9ZUeP0eC4qlEecPnnkR+t8QB
         F5CxByr9geXlC6m9x99uYbancZTK0pHRjRvlPmk+IlmYbZ/WZoq/RabY5xRpWl1CvaAn
         kl0GJvnqHchvdM4n2k+B9JiOfkk6vbz4m79+OoZMI7NYVCMXWsGvl+T8RB+cNBtVuaPO
         BH7w==
X-Gm-Message-State: APjAAAWfpwm22SFCJGLP9JTA17M1Pb1+w0fsVk4RRr5If+mUYmHamXvY
        +NA4KyjrL+YdBoh9ZQBS1Tyivw==
X-Google-Smtp-Source: APXvYqzEwIAjKS3Em026GIl/n6OaECDF5z0P7UjmcJEJgVEtwMvAC0d3LOiyLBn306FibVuHBvyEHQ==
X-Received: by 2002:ac8:444c:: with SMTP id m12mr6913649qtn.306.1562945564475;
        Fri, 12 Jul 2019 08:32:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id v75sm4201337qka.38.2019.07.12.08.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jul 2019 08:32:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlxXP-0002Tp-KZ; Fri, 12 Jul 2019 12:32:43 -0300
Date:   Fri, 12 Jul 2019 12:32:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Doug Ledford <dledford@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: Re: [PATCH] rdma/siw: avoid smp_store_mb() on a u64
Message-ID: <20190712153243.GI27512@ziepe.ca>
References: <20190712144257.GE27512@ziepe.ca>
 <20190712135339.GC27512@ziepe.ca>
 <20190712120328.GB27512@ziepe.ca>
 <20190712085212.3901785-1-arnd@arndb.de>
 <OF05C1A780.433E36D1-ON00258435.003381DA-00258435.003F847E@notes.na.collabserv.com>
 <OF36428621.B839DE8B-ON00258435.00461748-00258435.0047E413@notes.na.collabserv.com>
 <OF3D069E00.E0996A14-ON00258435.004DD8C8-00258435.00502F8C@notes.na.collabserv.com>
 <OF9F46C3F6.DC3E03FF-ON00258435.00521546-00258435.00549C01@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF9F46C3F6.DC3E03FF-ON00258435.00521546-00258435.00549C01@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 12, 2019 at 03:24:09PM +0000, Bernard Metzler wrote:
> 
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >Date: 07/12/2019 04:43PM
> >Cc: "Arnd Bergmann" <arnd@arndb.de>, "Doug Ledford"
> ><dledford@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
> >linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
> >Subject: [EXTERNAL] Re: Re: Re: [PATCH] rdma/siw: avoid
> >smp_store_mb() on a u64
> >
> >On Fri, Jul 12, 2019 at 02:35:50PM +0000, Bernard Metzler wrote:
> >
> >> >This looks wrong to me.. a userspace notification re-arm cannot be
> >> >lost, so have a split READ/TEST/WRITE sequence can't possibly
> >work?
> >> >
> >> >I'd expect an atomic test and clear here?
> >> 
> >> We cannot avoid the case that the application re-arms the
> >> CQ only after a CQE got placed. That is why folks are polling the
> >> CQ once after re-arming it - to make sure they do not miss the
> >> very last and single CQE which would have produced a CQ event.
> >
> >That is different, that is re-arm happing after a CQE placement and
> >this can't be fixed.
> >
> >What I said is that a re-arm from userspace cannot be lost. So you
> >can't blindly clear the arm flag with the WRITE_ONCE. It might be OK
> >beacuse of the if, but...
> >
> >It is just goofy to write it without a 'test and clear' atomic. If
> >the
> >writer side consumes the notify it should always be done atomically.
> >
> Hmmm, I don't yet get why we should test and clear atomically, if we
> clear anyway - is it because we want to avoid clearing a re-arm which
> happens just after testing and before clearing?

It is just clearer as to the intent.. 

Are you trying to optimize away an atomic or something? That might
work better as a dual counter scheme.

> Another complication -- test_and_set_bit() operates on a single
> bit, but we have to test two bits, and reset both, if one is
> set.

Why are two bits needed to represent armed and !armed?

Jason
