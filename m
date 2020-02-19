Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D49D1644F9
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 14:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgBSNGQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 08:06:16 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39465 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgBSNGP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 08:06:15 -0500
Received: by mail-qt1-f195.google.com with SMTP id c5so95985qtj.6
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 05:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LOhYAjtwm0RnntQotOSjXWQh/9MlZzmVQ8pbNJ6XBfg=;
        b=oL+rRgkRbiftmfnji6CO6r3otO3zmhMMCMVIE7sjP4bdAIKN321dV9XpMkdLY2BPGj
         lDEL9EiZQajE3K9JXXy/9leWFuKdHIN2jCJ9UPPQx0tnL3TmOm6kVsrytCH3U9b2hAh0
         UCHORrPB3LiCHGvZ0SEpzkojmEnn5bnOSpEZ+nM2tQ6pt7m5CWJJ4ebGDksVjMbbQd1M
         +dhGMV93EJ7353ZufsufV4lO53MLiL1IZEnyBFNFJ2yvNMNprHKeLSvMNqg4yDE0vSD3
         TTs23aL4v3v0Kkoi4k2eb7HrXaSEiE28nbUlOZzkUIDuhIP1c/vy0NeX/OUkHhds/0aw
         fr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LOhYAjtwm0RnntQotOSjXWQh/9MlZzmVQ8pbNJ6XBfg=;
        b=WE3Uay5Zi1ESQXTwBbfyUqrh+dE1ZaPmaXLoSw2aZbXsbZXo5MOXJzz3AP5/p2FCPk
         fyg7G4y6hW611eyXjb1ppfUy75WZyDJci5GdxRyKOqgp2/9scJagLaI1qSrxF+FD5RdT
         70pDJEODuFRb6JgYvEUC3UpySonGm2LDMuyVV33p2rXxvb0klgEny4/57CE3aplwh5oh
         s1DZ3rIgh4NQtrS0M0MVZF7AyGyh6yB7K4emIB3BnSTDlQcrC1T/PLUUXJQZa1L0i30F
         57obXWh7X6yvaPLt110O2XCS7NO7lCMyo0La+HJrHntHwtzQUxfN67oafrNdWNIkMwqF
         RNyg==
X-Gm-Message-State: APjAAAVdIaz5jKoSO39ahuwzzF2wqHXxnfVNXYWN78/qKqrQnu6lRXBR
        2zDhky96I6r3tahSQK+payfSBQ==
X-Google-Smtp-Source: APXvYqxBOpvAopDbW95KrBwYxrVlXxdpnw9ZYSLiUGN/aYcsnH3aC5H7eeS+r8UOSe+09V+izWo7Dw==
X-Received: by 2002:ac8:4616:: with SMTP id p22mr22142237qtn.368.1582117574890;
        Wed, 19 Feb 2020 05:06:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id v50sm961847qtb.20.2020.02.19.05.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 05:06:14 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4P3N-0000uA-Rb; Wed, 19 Feb 2020 09:06:13 -0400
Date:   Wed, 19 Feb 2020 09:06:13 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mark Zhang <markz@mellanox.com>
Cc:     Tom Talpey <tom@talpey.com>,
        Alex Rosenbaum <rosenbaumalex@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Alex Rosenbaum <alexr@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [RFC v2] RoCE v2.0 Entropy - IPv6 Flow Label and UDP Source Port
Message-ID: <20200219130613.GM31668@ziepe.ca>
References: <CAFgAxU8XmoOheJ29s7r7J23V1x0QcagDgUDVGSyfKyaWSEzRzg@mail.gmail.com>
 <62f4df50-b50d-29e2-a0f4-eccaf81bd8d9@talpey.com>
 <20200213154110.GJ31668@ziepe.ca>
 <3be3b3ff-a901-b716-827a-6b1019fa1924@mellanox.com>
 <de3aeeb7-41ef-fadc-7865-e3e9fc005476@mellanox.com>
 <55e8c9cf-cd64-27b2-1333-ac4849f5e3ff@talpey.com>
 <e758da0d-94a3-a22f-c2aa-3d13714c4ed3@talpey.com>
 <4fc5590f-727c-2395-7de0-afb1d83f546b@mellanox.com>
 <91155305-10f0-22b5-b93b-2953c53dfc46@talpey.com>
 <cb5ab63b-57cd-46ac-0d51-8bffaf537590@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb5ab63b-57cd-46ac-0d51-8bffaf537590@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 19, 2020 at 02:06:28AM +0000, Mark Zhang wrote:
 
> The symmetry is important when calculate flow_label with DstQPn/SrcQPn 
> for non-RDMA CM Service ID (check the first mail), so that the server 
> and client will have same flow_label and udp_sport. But looks like it is 
> not important in this case.

If the application needs a certain flow label it should not rely on
auto-generation, IMHO.

I expect most networks will not be reversible anyhow, even with the
same flow label?

Jason
