Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C64A2163297
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 21:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgBRUIf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 15:08:35 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39408 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBRUIf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 15:08:35 -0500
Received: by mail-qt1-f193.google.com with SMTP id c5so15457924qtj.6
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 12:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kipe8/5s7vCnvEca+2dJXTp0KG30ibyDAahKgL9vvPQ=;
        b=oGbjVhylTJd3wpLOqOxQ5ciugb5gKGfsp2BtAvLAFJ0HKX5BLLxE3BQv83Hr9dw7gU
         39Uy+ncWMuPbu6bH/5ZSITnAGt16IIBlmqPwpPOy2Rhzwh3D1JtonJgnHmsMiRl2gu9O
         LsZ8o/y9fEmnSLCFDCVMzmPjzSVlqC39KWVMoA8arYgy7KsZLyAB38eclhynmsBjArdB
         /8odBMJPOJVaiXWiOU5XFaFXerOjv2t9fN/g99F6z3+Swlq7/G8HmmHTRy9Fw3p8r3b7
         dqu0BL8lcHpXiVQ4XbGnQ3jSAx+/8KfTj96S9NQvVWC7KjMwLGxygD/OyqPjmlEnYbrf
         XJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kipe8/5s7vCnvEca+2dJXTp0KG30ibyDAahKgL9vvPQ=;
        b=ACNC3IyYr804wreUXrbuW3DsMuMGCxwfjjxYd6WmxBepr4NRobOlatTa2LVreMV/HG
         O8rCxfgrKUx+PCksDIBd/EzMC5rMIZNXJSzon9KEhTtI93pxoq3M1uZucNvAadeAberA
         FBKvjbC/JSay2uu0wz+z5ryQI200gqVGX83ncKKHsixVh1u0Qi2ZzyXqFMmGOmdvZt17
         QhBRac1/8SCBPGP4NEvvZ8zWFekCsSGmCBvb0TaCKB5dfhC0N1fPZ9TW4UWSqsOqsWmF
         hAbY71fbRgpX/cYqv1uHDS7iQYrCWFnVFZ0EAYhUhz3OBThA1cECLYwlZyCMrS6tjmcb
         UZZQ==
X-Gm-Message-State: APjAAAXDI5HkYszIuf03CN2MqdLo9AlGnYhqTy558DaASaKrXPnJudwk
        SCZUdH7hPdkdzKbLcVBkHRrnucqTCdAh6A==
X-Google-Smtp-Source: APXvYqzH8NPqFTHuKFlPYMVNZio4UaiJTIUlfIeEw18VRFmjOSO78RZjQCks6xzVu5qxF9Gpt9pBzQ==
X-Received: by 2002:ac8:425a:: with SMTP id r26mr18830064qtm.138.1582056514035;
        Tue, 18 Feb 2020 12:08:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x22sm2304513qtq.30.2020.02.18.12.08.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2020 12:08:33 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j49AX-0004gp-3W; Tue, 18 Feb 2020 16:08:33 -0400
Date:   Tue, 18 Feb 2020 16:08:33 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Honggang LI <honli@redhat.com>,
        Gal Pressman <galpress@amazon.com>
Subject: Re: RDMA device renames and node description
Message-ID: <20200218200833.GH31668@ziepe.ca>
References: <5ae69feb-5543-b203-2f1b-df5fe3bdab2b@intel.com>
 <20200218140444.GB8816@unreal>
 <1fcc873b-3f67-2325-99cc-21d90edd2058@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fcc873b-3f67-2325-99cc-21d90edd2058@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 18, 2020 at 12:11:47PM -0500, Dennis Dalessandro wrote:

> > First option is to rely on distro and every distro behaves differently
> > in such cases, some of them won't change anything till their last user
> > dies :) and others more dynamic with more up-to-date packages already
> > adopted our default.
> 
> This is the issue I see. The problem is when the distro doesn't know any
> better and pulls in a new rdma-core and breaks things unintentionally. Up to
> date is good, but up to date that brings with it what is essentially an ABI
> breakage is not.

The point of having the distros update is to get the breakage
fixed. Fedora, Ubuntu, etc should all track upstream and resolve
breakage through their bug process.

Remember, at the time this was set out nobody came forward to say that
there was distro-included userspace that (wrongly) hard coded
names. Now it is a bit late to backtrack - we need to move forward
with fixed userspace..

Jason
