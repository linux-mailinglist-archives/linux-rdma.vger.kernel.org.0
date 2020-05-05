Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95751C569F
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2020 15:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgEENV2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 May 2020 09:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbgEENV2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 May 2020 09:21:28 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64241C061A0F
        for <linux-rdma@vger.kernel.org>; Tue,  5 May 2020 06:21:28 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id t8so942084qvw.5
        for <linux-rdma@vger.kernel.org>; Tue, 05 May 2020 06:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H1GnNnDv0nT6SQ5GJhO7uZ4sdui9LWLadfvkrUs/N/4=;
        b=Xdcjo0/3hi+xx1iPcbqWe3nN35dAfrQVNgIYspjIi+l1LxVzrzJChWFUqYsBIyWBlf
         F6wORpZ8GwqBMovQMtYDsT1c+lihYoE5Ii+xGHCocg7s4OBj37LynMexCQr51yzU6Oh7
         rBZplbCrMDjv3eMZcWbNsQOqy6xvDqVLe1s1k8F3gOYBm/fCt+Q+d1HjdeafoGGMekjj
         jLlneKvQLvRn5hOYFgoRdAqXKv8JvLu5XL5Nk+M7V6eNqLTenO6DqPSquhYhm6TLZK+w
         yk4ZsMKksPGmAVYp8+78vtQjH35tJJ9nhQVKu0BUs75/uLsNQ1nNvdO2gJy0mz5eurTV
         MC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H1GnNnDv0nT6SQ5GJhO7uZ4sdui9LWLadfvkrUs/N/4=;
        b=Lb6vXtLjJyc+07g3N9AaDJ052u+0EeRn5hu10tExKUzhE8AXPolOhwGLq99t4ujxBa
         UtEQiyxOOI137ks7rojxDZ5CBLIcjmwzlCHDWgA9allTiB/IOH5k+Av954pb+y8Xi2je
         LXRRmaPjyAW8f+8DiqXNkZjBQ3XOIyBliDKbHjHQ051SlfJNGd4qdUwrcZaNLLR5lwlT
         mcI+z8HEkDboLfnTQL2Dp8/5UVrKV/LTWFy/NlCCSTPQR0mHm8Wq2o1IpCvW2R1hFvPN
         b3180SL7RK9Pe1rhwgwuJUd2g0uHI13OWr9190/PBU2y4WeZS88aRvBttB1/YA4pZORx
         bXHA==
X-Gm-Message-State: AGi0PubahnkGQ7EOHYLJK8hGzNvl6FsdmebW5uuNAfCTJjz7+p6brCpK
        ezBS2bjk9b5LMdiV/kV8I3o6Mw==
X-Google-Smtp-Source: APiQypIV7ASW2aO85pSzhRTES/6Uy7ovASLViCOu462UaOi471yCOzyDY2MYQ0tdYP/x0eXd/wyvzg==
X-Received: by 2002:ad4:44f3:: with SMTP id p19mr2704654qvt.170.1588684887385;
        Tue, 05 May 2020 06:21:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t12sm1751937qkt.77.2020.05.05.06.21.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 May 2020 06:21:26 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jVxVl-0003H4-LQ; Tue, 05 May 2020 10:21:25 -0300
Date:   Tue, 5 May 2020 10:21:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Can't build rdma-core's azp image
Message-ID: <20200505132125.GE26002@ziepe.ca>
References: <05382c9f-a58d-ba5a-02cd-c25aa3604e52@amazon.com>
 <20200407180658.GW20941@ziepe.ca>
 <67f9e08a-467c-34ce-e17e-816cb4bf03db@amazon.com>
 <ca41331c-3b53-fbb6-4543-bc960f796062@amazon.com>
 <20200417162150.GH26002@ziepe.ca>
 <519a9c33-fa1b-7439-fa6a-7a54b69bde0b@amazon.com>
 <20200505010906.GD26002@ziepe.ca>
 <fdb88249-dd6f-2cba-9c26-820456a0f011@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdb88249-dd6f-2cba-9c26-820456a0f011@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 05, 2020 at 09:40:33AM +0300, Gal Pressman wrote:
> On 05/05/2020 4:09, Jason Gunthorpe wrote:
> > On Sun, Apr 19, 2020 at 09:37:45AM +0300, Gal Pressman wrote:
> >> Unpacking libc6:arm64 (2.27-3ubuntu1) ...
> >> dpkg: dependency problems prevent configuration of libc6:i386:
> >>  libc6:i386 depends on libgcc1; however:
> >>   Package libgcc-s1:i386 which provides libgcc1 is not configured yet.
> >>
> >> dpkg: error processing package libc6:i386 (--configure):
> >>  dependency problems - leaving unconfigured
> >> dpkg: dependency problems prevent configuration of libgcc-s1:ppc64el:
> >>  libgcc-s1:ppc64el depends on libc6 (>= 2.17); however:
> >>   Package libc6:ppc64el is not configured yet.
> >>
> >> dpkg: error processing package libgcc-s1:ppc64el (--configure):
> >>  dependency problems - leaving unconfigured
> >> Errors were encountered while processing:
> >>  libc6:i386
> >>  libgcc-s1:ppc64el
> >> E: Sub-process /usr/bin/dpkg returned an error code (1)
> > 
> > Wow, that is actually an APT bug... Must be from old age :O
> > 
> > Ah we can hack around that with this:
> > 
> > https://github.com/jgunthorpe/rdma-plumbing/pull/new/azp_fix
> > 
> > Let me know if it works
> > 
> > Now that github has docker hosting I wonder if we should try to host a
> > copy of the docker image there.. Their docker hosting is a pain last I
> > looked though..
> 
> I've applied these patches and still got the same error :\.

It is because you rebased it on top of 9a68d672c3a835d..

'cbuild: Adjust to the new clang CDN' is the better fix for that..

I rebased it on the github

Jason
