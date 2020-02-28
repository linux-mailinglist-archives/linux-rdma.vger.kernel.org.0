Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3D84173870
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2020 14:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgB1NfC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Feb 2020 08:35:02 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37577 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgB1NfC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Feb 2020 08:35:02 -0500
Received: by mail-qt1-f196.google.com with SMTP id j34so2000528qtk.4
        for <linux-rdma@vger.kernel.org>; Fri, 28 Feb 2020 05:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SO4k+cEae+kcaRUxuLpklhk4ez8pzokBlgA+/XnFpzY=;
        b=YVBzc0fPtfTWU3WI4CpD6wflzlKNfGdtBy6xeStvbbJrgzA1/3+LYWWJJUKFHLlNe6
         estvGTicQLamm11cs7CeJACAaxInS7RYp50Ztlq8H6enN1ap/uDBCZGrp01GO+iJRfIo
         f9AQLO3nan12oFT4cROZv+gFhJRYiiUvK/NiN1xOGXaQVrAU3sF5LpTxKxD41jmRvNf8
         PaL+thoLLUdzf38op6Q1/pE7SJNflTxQSjoshQsa2XyYGSpX/1fVU/9woELTNFVBP8L6
         j4p3BrvBSXmHOMVMeKrnH+22GmcJSgmom5xUSelUdQBcdQiwVibPhsEnqQPTwhfKHlje
         6KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SO4k+cEae+kcaRUxuLpklhk4ez8pzokBlgA+/XnFpzY=;
        b=azyjyH3Vy4iH/6htza9QrnP4tI46/boWkEqT3i88ta0CLyg+a3DXgqelRDg8dBpfnM
         XDQRgxbsnRRhxMiwUniNiq1kFV8YC7Om8VFgkrhnGD2Lj72omTOA16ru/DvDwTP9vkSr
         78WD7j6FzpwTNcgVc3/tCdRlT38kqws0WN+oTcX5KHtjsLhZ5S9ihN+GrfBBQ+lbzI4O
         916FJd5BaDOdx0b+5P1OmxqX9+22s4td7guxhwkW+NItxsp7iKiCf795ULfmZd1iGX+2
         BrAtPPEbAKT0ATrlD+Cr4tuCUMZqii5mYqN2ZMCdtEYOBh2R/KSqVGBSaNmQOgViDUPj
         lQfQ==
X-Gm-Message-State: APjAAAVhwtkqa7QxCv6erEaZRUuzhbtAruYeyIB9ereHkXw/Argt9VsX
        n8FR5dslWtPfNnbIDtPl1fjlkg==
X-Google-Smtp-Source: APXvYqz34jQPrszufJ93Ceni4PEZYOnNx21NiUQdDnBqKX3jqVT7UroWcBUFS7T8hVPeCfHcAR4H6g==
X-Received: by 2002:ac8:5190:: with SMTP id c16mr4174211qtn.200.1582896901187;
        Fri, 28 Feb 2020 05:35:01 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id o25sm5120118qkk.7.2020.02.28.05.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Feb 2020 05:35:00 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j7fnA-0007ph-1Q; Fri, 28 Feb 2020 09:35:00 -0400
Date:   Fri, 28 Feb 2020 09:35:00 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     syzbot <syzbot+55de90ab5f44172b0c90@syzkaller.appspotmail.com>,
        chuck.lever@oracle.com, dledford@redhat.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, parav@mellanox.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Subject: Re: Re: possible deadlock in cma_netdev_callback
Message-ID: <20200228133500.GN31668@ziepe.ca>
References: <20200227164622.GJ31668@ziepe.ca>
 <20200227155335.GI31668@ziepe.ca>
 <20200226204238.GC31668@ziepe.ca>
 <000000000000153fac059f740693@google.com>
 <OF0B62EDE7.E13D40E8-ON0025851B.0037F560-0025851B.0037F56C@notes.na.collabserv.com>
 <OF0C6D63D8.F1817050-ON0025851B.0059D878-0025851B.0059D887@notes.na.collabserv.com>
 <OFF9E6CFC6.7E79459D-ON0025851C.00472582-0025851C.0047F357@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFF9E6CFC6.7E79459D-ON0025851C.00472582-0025851C.0047F357@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 28, 2020 at 01:05:53PM +0000, Bernard Metzler wrote:
> 
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >Date: 02/27/2020 05:46PM
> >Cc: "syzbot" <syzbot+55de90ab5f44172b0c90@syzkaller.appspotmail.com>,
> >chuck.lever@oracle.com, dledford@redhat.com, leon@kernel.org,
> >linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
> >netdev@vger.kernel.org, parav@mellanox.com,
> >syzkaller-bugs@googlegroups.com, willy@infradead.org
> >Subject: [EXTERNAL] Re: possible deadlock in cma_netdev_callback
> >
> >On Thu, Feb 27, 2020 at 04:21:21PM +0000, Bernard Metzler wrote:
> >> 
> >> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >> >Date: 02/27/2020 04:53PM
> >> >Cc: "syzbot"
> ><syzbot+55de90ab5f44172b0c90@syzkaller.appspotmail.com>,
> >> >chuck.lever@oracle.com, dledford@redhat.com, leon@kernel.org,
> >> >linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
> >> >netdev@vger.kernel.org, parav@mellanox.com,
> >> >syzkaller-bugs@googlegroups.com, willy@infradead.org
> >> >Subject: [EXTERNAL] Re: possible deadlock in cma_netdev_callback
> >> >
> >> >On Thu, Feb 27, 2020 at 10:11:13AM +0000, Bernard Metzler wrote:
> >> >
> >> >> Thanks for letting me know! Hmm, we cannot use RCU locks since
> >> >> we potentially sleep. One solution would be to create a list
> >> >> of matching interfaces while under lock, unlock and use that
> >> >> list for calling siw_listen_address() (which may sleep),
> >> >> right...?
> >> >
> >> >Why do you need to iterate over addresses anyhow? Shouldn't the
> >> >listen
> >> >just be done with the address the user gave and a BIND DEVICE to
> >the
> >> >device siw is connected to?
> >> 
> >> The user may give a wildcard local address, so we'd have
> >> to bind to all addresses of that device...
> >
> >AFAIK a wild card bind using BIND DEVICE works just fine?
> >
> >Jason
> >
> Thanks Jason, absolutely! And it makes things so easy...

Probably check to confirm, it just my memory..

Jason
