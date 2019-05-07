Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7DE21677A
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 18:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfEGQNH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 12:13:07 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:34283 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEGQNH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 12:13:07 -0400
Received: by mail-qt1-f170.google.com with SMTP id j6so19706913qtq.1
        for <linux-rdma@vger.kernel.org>; Tue, 07 May 2019 09:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YM2w6AmpNvRPBJ2loenNlcbSW+vMuZLhd6i39B6cpW8=;
        b=JVPPkUsYVY1FuoiueYHEBERczDM06RKxqcAdMG0Tj2B+F3AGIkv+wB53wKF45oWr+c
         EHai6LdNNGkPpH6XwoAgrzNBmlYZ9Tr1p6QV3kitSb0UeUAoqWReQW+YX/FV620CEW65
         YNXdp60xyVKqYZzjIdIgprt0PF6cx0C1wkp4IPBhHsRFhnZe1Nv6VJIZxqyBNVP7gw0j
         p/RCG+tMAfu0wvIMjJxKdxht3G4prz/IGZXPbmGdTeSspgfAcnnTj8mOTGuGLWjsRdus
         Xh7T2+O2LtO3wikcdurVHl1JPuueVALrkI1JEtFhsD4Nmhp9aAJmsNgE2zOw7UnVofpM
         7/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YM2w6AmpNvRPBJ2loenNlcbSW+vMuZLhd6i39B6cpW8=;
        b=G8tt15WQlZh8WLAMZrVlNhLVC8EOM/XGnrSVOGxG9cmNV4fBFS0QlKmKpeuXyQMPzB
         xhCu2eM8BFhy94vjR09mEkE7RJ8G5gideT5JameiwlUGwUym2+rPeeu6wR+gFIK7XE9H
         7saOiMhStaqx1JcSumPkmDjK4IPFYI7cu7yY5+vWPBrqH4KWyAf1hB/tk1VTiMEcqqsf
         NDUhNXVnG2ONBwOQm7gOm5zZI12fAKuAa0zA9jwBXCYGlMSgWY8EzsG8EIXgp46nuKmX
         DXZPpC3lpnGTKZxu51BN4NR/1EkTjgPZi3Tq55WT/eEn7273XFVUnFQagrhNvrscGbNw
         UN5Q==
X-Gm-Message-State: APjAAAW8yzAcK3LrkMblCAQjtFcJXFE7jQfXPKKRmYXmXWxBHG8huEAn
        oM005k3I6DwnLrIPXalkXNv4jw==
X-Google-Smtp-Source: APXvYqxHTc2ukbN4U4rHlnJSfKBh0vt08RJvULnkhzWlKPPpvxyb9SScELml+yzaDNq7Pz1uw9VoQA==
X-Received: by 2002:a0c:bf10:: with SMTP id m16mr27573444qvi.156.1557245586506;
        Tue, 07 May 2019 09:13:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id s193sm8514962qke.4.2019.05.07.09.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 09:13:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hO2iG-0006k8-T4; Tue, 07 May 2019 13:13:04 -0300
Date:   Tue, 7 May 2019 13:13:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Bernard Metzler <BMT@zurich.ibm.com>
Subject: Re: iWARP and soft-iWARP interop testing
Message-ID: <20190507161304.GH6201@ziepe.ca>
References: <49b807221e5af3fab8813a9ce769694cb536072a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49b807221e5af3fab8813a9ce769694cb536072a.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 06, 2019 at 04:38:27PM -0400, Doug Ledford wrote:
> So, Jason and I were discussing the soft-iWARP driver submission, and he
> thought it would be good to know if it even works with the various iWARP
> hardware devices.  I happen to have most of them on hand in one form or
> another, so I set down to test it.  In the process, I ran across some
> issues just with the hardware versions themselves, let alone with soft-
> iWARP.  So, here's the results of my matrix of tests.  These aren't
> performance tests, just basic "does it work" smoke tests...

Well, lets imagine to merge this at 5.2-rc1? 

Bernard you'll need to rebase and resend when it comes out in two weeks.

Thanks,
Jason
