Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83E2B9232F
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 14:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfHSMOD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 08:14:03 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45992 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfHSMOD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 08:14:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id k13so1546744qtm.12
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 05:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nRWNZuiGM6/Q6mNBegXMuI8+3hZyUA0ed2caq3zIE+s=;
        b=U6P+VhD9qiNyTYj/vf8py7Y/7crTZzN75pXRcqHoBbCIFkdKtT5gnzrsKgDxgRENa9
         nP0ZvR/Rzpsff8cZYlp+r9fhRAzqTvCsv1xKbfzASRmL2mBQmHPW7mHhf+y2MrxgAEq2
         z5kj/Sef0erIiPVm/D03V2rIJdtlaA+U5KeAeb4juYjhtY39EII1X3srd+MF4Q+9N0P8
         7g3oOUoFlC15XevcwiLH/KJD9rNTYGTfEWQ8yc6bU4dLSAupVAMj0mN8jrogCBwlnynl
         xyS3YmvcTut9/H2qBiMuEFtP2syUERBEOuZdZQaf1HrnzgfWzCiZ2xpYrAZaXmAZi7dz
         f2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nRWNZuiGM6/Q6mNBegXMuI8+3hZyUA0ed2caq3zIE+s=;
        b=ZIWevoBqY/TsvOlUXtH+csGYGaQWqYYVIScI1sXSFaFSXVslT/s3/WvIBEN5ABndcJ
         rh5PCh8RzgEI6a0IgoXgbfNRZyDtJIqs6DgzhgEe1wONAQ8zTk4aQxzb3OmEZ3xlEcjV
         qdF3p9dgqM2LDv8Lv9vykc+sBU4f9nPqddw+V6Z1DQ/CxJzuL/uwXdKMVnBURQrEyonZ
         gt1013bQcwxjTpKxZf+h4ozZgi2HWrJUMmNxlBQ5NnA2uhiALjHu2FLl6A8cf3Yl4OMQ
         vpzD4CEpNLBat320YE+7ryjoPqAPwAHL1Kd56vCBy8mA7/w3ABWVNtQ30exqWufM8mtf
         kXxw==
X-Gm-Message-State: APjAAAV3leLn58uNDDdFT2pD8pUeBX1JaJkj/d+2GvHDhBUEbnc6y8oX
        9lsb8qCVLjVRamO4XcceaIgM9g==
X-Google-Smtp-Source: APXvYqwN4pdYCYxd3MvQTpQ8D79Ai3jAM67fFwyK83IAnQZdMnMVUiL20ASrtgdX+jnuaZg29D/D/Q==
X-Received: by 2002:a0c:e6cc:: with SMTP id l12mr10046715qvn.60.1566216842063;
        Mon, 19 Aug 2019 05:14:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id x206sm6898059qkb.127.2019.08.19.05.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 05:14:01 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hzgXw-0001YF-Va; Mon, 19 Aug 2019 09:14:00 -0300
Date:   Mon, 19 Aug 2019 09:14:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PULL REQUEST] Please pull rdma.git
Message-ID: <20190819121400.GA5058@ziepe.ca>
References: <09bcafaab07dfde728357bfe61b6a7edfa3b25c9.camel@redhat.com>
 <CAMuHMdWp+g-W0rJtVTWEiJpbhcV7GoSkub11fZPMUbhJcxMUNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWp+g-W0rJtVTWEiJpbhcV7GoSkub11fZPMUbhJcxMUNA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 19, 2019 at 12:08:16PM +0200, Geert Uytterhoeven wrote:
> Hi Doug, Bernard,
> 
> On Wed, Aug 14, 2019 at 5:00 PM Doug Ledford <dledford@redhat.com> wrote:
> > Fairly small pull request for -rc3.  I'm out of town the rest of this
> > week, so I made sure to clean out as much as possible from patchworks in
> > enough time for 0-day to chew through it (Yay! for 0-day being back
> > online! :-)).  Jason might send through any emergency stuff that could
> > pop up, otherwise I'm back next week.
> >
> > The only real thing of note is the siw ABI change.  Since we just merged
> > siw *this* release, there are no prior kernel releases to maintain
> > kernel ABI with.  I told Bernard that if there is anything else about
> > the siw ABI he thinks he might want to change before it goes set in
> > stone, he should get it in ASAP.  The siw module was around for several
> > years outside the kernel tree, and it had to be revamped considerably
> > for inclusion upstream, so we are making no attempts to be backward
> > compatible with the out of tree version.  Once 5.3 is actually released,
> > we will have our baseline ABI to maintain.
> 
> [...]
> 
> > - Allow siw to be built on 32bit arches (siw, ABI change, but OK since
> >   siw was just merged this merge window and there is no prior released
> >   kernel to maintain compatibility with and we also updated the
> >   rdma-core user space package to match)
> 
> > Bernard Metzler (1):
> >       RDMA/siw: Change CQ flags from 64->32 bits
> 
> Obviously none of this was ever compiled for a 32-bit platform?!?

It is puzzling that 0-day or anyone testing linux-next hasn't noticed
this in that last 7 weeks are so..

Jason
