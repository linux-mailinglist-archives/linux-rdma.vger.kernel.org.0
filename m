Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 492D73D4AD
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 19:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406287AbfFKR54 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 13:57:56 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43810 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406641AbfFKR5w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jun 2019 13:57:52 -0400
Received: by mail-vs1-f65.google.com with SMTP id d128so8517057vsc.10
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2019 10:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W78vNdRb2sj//mar9C9WOm+vUoDh7CmPtoHO17hZmow=;
        b=OwgPYvEwWNzHH1rU/JM3v4PPm4KuyLGfughySV2S5B8izLITroNIGMNRXMLWMwPswX
         yVrA2EPdi6B+FMygVs219bUE7PWdJqBEcCSF37KFWf/kZjtfsOayCgCnh4+vuugPv6/n
         Gg4WAI4KXhhJae6wLK4rlJh/0FjeS14HHtJpsjCbvTiUoub6avt8k4ohE1AQI/ALgL8I
         D9hflDmuDLeno10Iz36THLWonrCRv4BY/91OHMsu95r6D0D1wqy5RYYPAdIBJqkBs5Nt
         XLl3Ut2sj+gS3oIrmX3mmZd8xjDPOoMS5SYRkLEZuQBXjqN4hI7+QR8dBZynFXSAJ9xP
         MAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W78vNdRb2sj//mar9C9WOm+vUoDh7CmPtoHO17hZmow=;
        b=dPA68PL3fSW7M7PiK1z90qQmq3CqD6lKm+JOczis+SHKjUrvtESv6fOhrog26GKSXr
         Iefliz+CWpl3eMjQS9FSVlpOOSVCmJUP9JVcq6SB7gZ4u8XWcYAhJfiSzfyXSPTfANvk
         VB6GAyhnwtzoshbUnFTgyomxujuZhr+8xBWx9hwuLSbuBmJxJZ4GNb3CzKkTWct59FAo
         2Mn2weSm5/bmgq8mnJN7PyWqfuI5wnoYukIt3Ly2wgm5uFKj7ahEUDPJQ2WG4HzKLH87
         ODWEcH6ttQTQpXd6BQtlcB2fmOcMUfEPQRWrJmcfwigzQjyW3ziGp+oRCpQ8idky6HOR
         iTcA==
X-Gm-Message-State: APjAAAX1Gl782YEDSciZz0VChb2lRZFrFmPAjuBCIeGa3s6HnIvjK55P
        A2Hprzc9rkHbst1VjjmU50iGgA==
X-Google-Smtp-Source: APXvYqyKE42rA0LVHFpQ2EDtYDUQhgh9MLakJH0QnCzVIyHNHTCTXSEa96fwSV1kF9vLNraHFiJzmQ==
X-Received: by 2002:a67:ec42:: with SMTP id z2mr24618084vso.218.1560275871110;
        Tue, 11 Jun 2019 10:57:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o66sm4591320vke.17.2019.06.11.10.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jun 2019 10:57:50 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hal1p-0005Cb-ON; Tue, 11 Jun 2019 14:57:49 -0300
Date:   Tue, 11 Jun 2019 14:57:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+e5579222b6a3edd96522@syzkaller.appspotmail.com>,
        dasaratharaman.chandramouli@intel.com, dledford@redhat.com,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com,
        roland@purestorage.com, sean.hefty@intel.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING: bad unlock balance in ucma_event_handler
Message-ID: <20190611175749.GA29375@ziepe.ca>
References: <000000000000af6530056e863794@google.com>
 <20180613170543.GB30019@ziepe.ca>
 <20190610184853.GG63833@gmail.com>
 <20190610194732.GH18468@ziepe.ca>
 <20190610204523.GK63833@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610204523.GK63833@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 10, 2019 at 01:45:24PM -0700, Eric Biggers wrote:
> On Mon, Jun 10, 2019 at 04:47:32PM -0300, Jason Gunthorpe wrote:
> > 
> > There are many unfixed syzkaller bugs in rdma_cm, so I'm not surprised
> > it is still happening..
> > 
> > Nobody has stepped forward to work on this code, and it is not a
> > simple mess to understand, let alone try to fix.
> > 
> 
> But people still use it, right?  Do they not care that it's spewing syzbot
> reports?  Are they depending on the kernel to provide any security properties?

Yes, it should be fixed.

Jason
