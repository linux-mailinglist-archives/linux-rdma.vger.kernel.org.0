Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAE0164D0B
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 18:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgBSRzb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 12:55:31 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36918 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgBSRza (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 12:55:30 -0500
Received: by mail-qt1-f195.google.com with SMTP id w47so855176qtk.4
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 09:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3OWvKNSFK5+1jzkc9ih7irkJXb1MleGfxd/g4bwizqM=;
        b=W35GK9WsDfntYhq4PMhnP2+gBuPXVOLCKW/ad4UqMk2DwklrF6vx/PwpAfX3kpAjCd
         gZwTa/+md8nZfM3C0UIhoNSBuQ0KPtUK5xlPg3DM3267NE5NUKjRyCsjtiZMgouHyIXD
         AzmBcG54LMlloTuNHyRhtcaEUcyidiWdOR+VOoj/MmYlxucDGrRwoJn/DhqBh+nkYROj
         GkYLbpep+ZsEPgg7hljM0sxhDeJp+4d0VdfrrBr/oXoBM7lLRxRPqLTPU7N1Fv5LT2ZN
         vsCQ2bwdpPq5dDPc9T270KWlx+AuA9iDL9jmSn1IR74c+dWIIQ8zbgPLkZaHZrkt5jLA
         xunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3OWvKNSFK5+1jzkc9ih7irkJXb1MleGfxd/g4bwizqM=;
        b=uW26vLRdgSrDE3SnAWBdrBJlQUJ3p6N3sk0/mnFuVcXTE5iloZe21U7VsfT+5OrddE
         gb0RmxwCCYxC9hvDXPM8O/hKz2lHqBbgVRtMz4YmJMYJzZG5AMdfXqy8u7ujYIrSGMeB
         fcZy/Fm26hqwOWqim8otsuAWKHCIe1PMaDLslggeGNY+gn99LDWi1MafGwWR0N6ctB0o
         f+q9Yn/VKJt1hL8rO/JIgOLFkVXpgg8t17yfPCS41kQw9RVhwFQQANkBNbsGAWohLahu
         VIeATHeUq3fjAzbUI+NpYFp+klETnnOWVRIsht047aGMpMej9ShznebgNIQsf4H8BxSX
         /SIQ==
X-Gm-Message-State: APjAAAW9AUwBx6Jfu0qe4j572MOtNcKegOaLC/o/qAMg/rLmD1Hnjlcy
        l1CXBs7ulV4ppnqeDdSkkeBWsfWBhtqfTQ==
X-Google-Smtp-Source: APXvYqxKTLKRN/BVe0j86S1DCTEgP8QL4hMX3or2M/J9e+Yc9rdjBTfSG00fuT5G35r6YoURPK2P9A==
X-Received: by 2002:ac8:1196:: with SMTP id d22mr23206829qtj.344.1582134929923;
        Wed, 19 Feb 2020 09:55:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id j11sm198098qkl.97.2020.02.19.09.55.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 09:55:29 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4TZI-0003wy-Up; Wed, 19 Feb 2020 13:55:28 -0400
Date:   Wed, 19 Feb 2020 13:55:28 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tom Talpey <tom@talpey.com>
Cc:     Mark Zhang <markz@mellanox.com>,
        Alex Rosenbaum <rosenbaumalex@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Alex Rosenbaum <alexr@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [RFC v2] RoCE v2.0 Entropy - IPv6 Flow Label and UDP Source Port
Message-ID: <20200219175528.GU31668@ziepe.ca>
References: <20200213154110.GJ31668@ziepe.ca>
 <3be3b3ff-a901-b716-827a-6b1019fa1924@mellanox.com>
 <de3aeeb7-41ef-fadc-7865-e3e9fc005476@mellanox.com>
 <55e8c9cf-cd64-27b2-1333-ac4849f5e3ff@talpey.com>
 <e758da0d-94a3-a22f-c2aa-3d13714c4ed3@talpey.com>
 <4fc5590f-727c-2395-7de0-afb1d83f546b@mellanox.com>
 <91155305-10f0-22b5-b93b-2953c53dfc46@talpey.com>
 <cb5ab63b-57cd-46ac-0d51-8bffaf537590@mellanox.com>
 <20200219130613.GM31668@ziepe.ca>
 <a0067ba5-c15b-4194-0de2-3964393e9993@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0067ba5-c15b-4194-0de2-3964393e9993@talpey.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 19, 2020 at 12:41:53PM -0500, Tom Talpey wrote:
> On 2/19/2020 8:06 AM, Jason Gunthorpe wrote:
> > On Wed, Feb 19, 2020 at 02:06:28AM +0000, Mark Zhang wrote:
> > > The symmetry is important when calculate flow_label with DstQPn/SrcQPn
> > > for non-RDMA CM Service ID (check the first mail), so that the server
> > > and client will have same flow_label and udp_sport. But looks like it is
> > > not important in this case.
> > 
> > If the application needs a certain flow label it should not rely on
> > auto-generation, IMHO.
> > 
> > I expect most networks will not be reversible anyhow, even with the
> > same flow label?
> 
> These are network flow labels, not under application control. If they
> are under application control, that's a security issue.

Eh? ipv6 puts them under application control.

Jason
