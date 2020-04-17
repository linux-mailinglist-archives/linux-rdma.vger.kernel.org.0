Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0371ADD61
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2020 14:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgDQMfN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Apr 2020 08:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727877AbgDQMfN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Apr 2020 08:35:13 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448B7C061A0C
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2020 05:35:13 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 20so2104413qkl.10
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2020 05:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qbVBsojHhWVwwoBXkJEQp4v3MQHUr35oEZS0Fk2G0Oo=;
        b=MhyjJasf9w18QtT75Ok6yrtV6OnoGSNH8IFC/XBhNO4Qx8dL/4h+lMmNtg77xkR94J
         TV+ZHYQm/ZvFZx/3ljufKV6MC+btItA/n8BWNu6iZBrURIGznCwlR/TDpCOrFXAdxZin
         QAcfPxKu0u6UsUTLoLX7SCKj0hMWCcNh2mTwcnTkTN9qhbgc7XL5iUDZYOZOShjFa69T
         OTLguu+aYxyf+0N+WB0Vvq87f/dH5BDZnJ6mYxaVdt3Dqgkv5FtfIFhoxc1d/MLIE7sD
         d0o5nlqiEdXSId7NyXo6KKxYjnwt/FdrRNI6pxydG7Gk6UvxWDvAJfiXpnhy1GHZ0cWT
         21Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qbVBsojHhWVwwoBXkJEQp4v3MQHUr35oEZS0Fk2G0Oo=;
        b=WzL3XcFuhfPfsGNoDl0CIRvNmNmlOKE0/Iy4HCDUYD35UV5WGwr7qFV9TZYvbGs9Jr
         vXWFGpErcPqOmMnrGyDV87FM0brc0+KNjG5hpLkBuPlXP0wYl5eNW/lSDeGhe/MbIlHm
         kUOxfAvBgnSQNbtxP/XncoOLHcOaxnsMsv6NjWrcrPbQxUBUYZ4zvieILzJ6rLqwgYPL
         aG5s28INbRmfhsuIeugJXQebB/3BQD7th/0vdoQk1FcyCRX2/SBuQAdiJPCPcEGYj3fv
         mphjTOoTZV7FBXD5XyKSsZ/Qb9WGVC4ipYJCHi5hu79pTE5BCvrPynX4GOvczFlI9LCi
         NHqA==
X-Gm-Message-State: AGi0PuZM9UsGk3UHGBX7p8KP/xG7dGu4rQXE2cIG/Ep4ShP6LdjktF+V
        cQ+IBWgrqIUiQcpR1LfHB3Xggg==
X-Google-Smtp-Source: APiQypJzpvsD+Qc2lRTNlz+J+mBg5reqkbDm+iQe84aeXMpDzYasymocjGrsySxPSrUOgoUQjILagQ==
X-Received: by 2002:a37:70c6:: with SMTP id l189mr2823584qkc.158.1587126912365;
        Fri, 17 Apr 2020 05:35:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g10sm17168902qkb.9.2020.04.17.05.35.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Apr 2020 05:35:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jPQD9-00070b-Ex; Fri, 17 Apr 2020 09:35:11 -0300
Date:   Fri, 17 Apr 2020 09:35:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [RFC PATCH 0/3] RDMA: Add dma-buf support
Message-ID: <20200417123511.GB26002@ziepe.ca>
References: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
 <20200416175454.GT5100@ziepe.ca>
 <MW3PR11MB45554BB257360F7CDD96175EE5D80@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20200416193408.GB5100@ziepe.ca>
 <MW3PR11MB455530A5F7B5544A56C0CC33E5D80@MW3PR11MB4555.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB455530A5F7B5544A56C0CC33E5D80@MW3PR11MB4555.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 16, 2020 at 09:02:51PM +0000, Xiong, Jianxin wrote:
> > >
> > > Right, the GPU driver needs to cooperate to get the thing to work as
> > > expected. The "p2p" flag and related GPU driver changes proposed in
> > > other threads would ensure VRAM is really used.  Alternatively, a GPU
> > > driver can have a working mode that assumes p2p mapping capability of
> > > the client. Either way, the patches to the RDMA driver would be mostly
> > > identical except for adding the use of the "p2p"
> > > flag.
> > 
> > I think the other thread has explained this would not be "mostly identical" but here is significant work to rip out the scatter list from the
> > umem.
> > 
> 
> Probably we are referring to different threads here. Could you
> kindly refer me to the thread you mentioned? I was referring to the
> thread about patching dma-buf and GPU driver:
> https://www.spinics.net/lists/amd-gfx/msg47022.html

https://lore.kernel.org/linux-media/20200311152838.GA24280@infradead.org/

> > So, I'm back to my original ask, can you justify adding this if it
> > cannot do VRAM? What is the use case?
> 
> Working with VRAM is the goal. This patch has been tested with a
> modified GPU driver that has dma_buf_ops set up to not migrate the
> buffer to system memory when attached. The GPU drivers and the RDMA
> drivers can be improved independently and it doesn't hurt to have
> the RDMA driver ready before the GPU drivers.

Well, if there is no other use case then this series will have to wait
until someone does all the other work to make P2P work upstream.

Jason
