Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C63D288BE5
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 16:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388901AbgJIO5K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 10:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388811AbgJIO5K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 10:57:10 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DCDC0613D2
        for <linux-rdma@vger.kernel.org>; Fri,  9 Oct 2020 07:57:08 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id bl9so4871060qvb.10
        for <linux-rdma@vger.kernel.org>; Fri, 09 Oct 2020 07:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6GE5XtwpF4aEcJm96nnfrrNLk+nAU1CpOxYGlBo79f4=;
        b=JNnpNyXPU89PrAi0h1W8lShWlJyqeROd1J4gtT8tVkuM9u75aeXNOq04Mhm67sOzsB
         wS3gQ0as8zUnx06pJgs7LdNYn53DQmLtlmUHUVjQl93gTEUgjGPBoEX2xICoTeCkpT+W
         +4On0CWSmlinhlB+SrZcIyEyVAhaMJ77LfmAC4prXXQwttKTcQlbnXHQLgtvYbOoiO/1
         PUFoz7ZPqdqe+QL+kDJkcDuEuWJiVuEuImpTCEr4ylum0K3XVs36shFrFZsHUEU/+El9
         osLzo9jzfAjtPNWE/mBi/abvJKvN9MXETmuGA7Kwv84NVVisHm+VtVgxU57soO9KnpCo
         Ii/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6GE5XtwpF4aEcJm96nnfrrNLk+nAU1CpOxYGlBo79f4=;
        b=khn4oSat+dFYgexHjaB9EQrDMWZ+5CNRnNaWtCZqvF+L8ecW2tTlGvwZqMu86Eq1kB
         QN9RlwOT1nok/caKQRZ/U/UsnHt0XFUezGGaNWdXtja3n0PmQ/h7UVJZ96d1IF5jGyEz
         JDvCtA5vi4jSqFEzQMEqrTr/n+5esjolUZc67CPe6SKOeVYhLIf9kBMPk7Y1kCFhsSrr
         UjHoHRPACnVr7LEO+MKWuS0CMOmqocnqT3tX8S4Jq8rEFZokt3i8uqvy8rZ6py9Xu82W
         JeuUgAc3udFf9pqoe382x4FNH+ZiXE5yH4//p7e44Q8D3eKUKzJkJlGdsDIljYZ84Eik
         EJ8A==
X-Gm-Message-State: AOAM533sszx6+/2cckHNSd7D+OuCBw/tvuk8VdvktwpRirygV7Pjn8gb
        ghPULtfoU3KErtpFhE60hJD3+O9Ojmd+HDJF
X-Google-Smtp-Source: ABdhPJykgDEkgOPwxiB0oPqInEL46MRKQ5Aes8NbaNEYw43vyv99/rUeoNncCVkhGJCZw7IJHuubVw==
X-Received: by 2002:a0c:c709:: with SMTP id w9mr13060827qvi.26.1602255427930;
        Fri, 09 Oct 2020 07:57:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id k126sm6061448qke.135.2020.10.09.07.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 07:57:07 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQtpS-0020EZ-MX; Fri, 09 Oct 2020 11:57:06 -0300
Date:   Fri, 9 Oct 2020 11:57:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever <chucklever@gmail.com>
Cc:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
Message-ID: <20201009145706.GU5177@ziepe.ca>
References: <20201006124627.GH5177@ziepe.ca>
 <ad892ef5-9b86-2e75-b0f8-432d8e157f60@oracle.com>
 <20201007111636.GD3678159@unreal>
 <4d29915c-3ed7-0253-211b-1b97f5f8cfdf@oracle.com>
 <20201008103641.GM13580@unreal>
 <aec6906d-7be5-b489-c7dc-0254c4538723@oracle.com>
 <20201008160814.GF5177@ziepe.ca>
 <727de097-4338-c1d8-73a0-1fce0854f8af@oracle.com>
 <20201009143940.GT5177@ziepe.ca>
 <0E82FB51-244C-4134-8F74-8C365259DCD5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E82FB51-244C-4134-8F74-8C365259DCD5@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 09, 2020 at 10:48:55AM -0400, Chuck Lever wrote:
> Hi Jason-
> 
> > On Oct 9, 2020, at 10:39 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Fri, Oct 09, 2020 at 12:49:30PM +0800, Ka-Cheong Poon wrote:
> >> As I mentioned before, this is a very serious restriction on how
> >> the RDMA subsystem can be used in a namespace environment by kernel
> >> module.  The reason given for this restriction is that any kernel
> >> socket without a corresponding user space file descriptor is "rogue".
> >> All Internet protocol code create a kernel socket without user
> >> interaction.  Are they all "rogue"?
> > 
> > You should work with Chuck to make NFS use namespaces properly and
> > then you can propose what changes might be needed with a proper
> > justification.
> 
> The NFS server code already uses namespaces for creating listener
> endpoints, already has a user space component that drives the
> creation of listeners, and already passes an appropriate struct
> net to rdma_create_id. As far as I am aware, it is namespace-aware
> and -friendly all the way down to rdma_create_id().
> 
> What more needs to be done?

I have no idea, if you are able to pass a namespace all the way down
to the listening cm_id and everything works right (I'm skeptical) then
there is nothing more to worry about - why are we having this thread?

> > The rules for lifetime on IB clients are tricky, and the interaction
> > with namespaces makes it all a lot more murky.
> 
> I think what Ka-cheong is asking is for a detailed explanation of
> these lifetime rules so we can understand why rdma_create_id bumps
> the namespace reference count.

It is because the CM has no code to revoke a CM ID before the
namespace goes away and the pointer becomes invalid.

Jason
