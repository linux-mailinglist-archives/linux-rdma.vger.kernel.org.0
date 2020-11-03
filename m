Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5908D2A4813
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Nov 2020 15:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgKCOY3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Nov 2020 09:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbgKCOWr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Nov 2020 09:22:47 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB9DC0613D1
        for <linux-rdma@vger.kernel.org>; Tue,  3 Nov 2020 06:22:46 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id da2so5590153qvb.0
        for <linux-rdma@vger.kernel.org>; Tue, 03 Nov 2020 06:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wig+cetBmbDtCrUsNHDAbxDQA+HkAkKABv8Jfsd5F8k=;
        b=lm9TJ18zPbf29vEhKXQRPOa5pJ4SHhhzR782oKOXbXEtp2O6lt44ITpBeHR0nUuI25
         veCbh1kAnAvDSU1vJxiDmArztno3u7iXtnSfHLTxpSSTWsVjCNrhqdlYKQaEbwrOD2EJ
         H2809vf6CT0jJKZ2sE9dfFnjmNExFxVA7rK53vU6S7qCQ/0QHB531jUOuFdpa/epeSRe
         vEDIHywKvB1TNzDLRPmCnaTIWfGtgtn9Wu6Bl3mmPi8H+FStfhZ6US2H1doGpdqOngeT
         FzpkEM9boNZYI5w3P7ttw1Op+pHBER7bxMgnMDjZzH2Py77XdR431bcgYG381fIfraSl
         ujNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wig+cetBmbDtCrUsNHDAbxDQA+HkAkKABv8Jfsd5F8k=;
        b=DrYlrWjDbdkrom3HrGbWz4jAG0y4mAPHCyOYOowMzsvsQ+ki3aIG/pgdHlQErW8M9r
         HCQ/sZnh3uIFX5r21e+degiIVPxjvPklgzG/ElnJ1WTm/MzVosyY4vFAyyhnLdGKken8
         bFTJNzOoDD6vT/SAtPgl53DZuif56ZExdRs1GmfuJDbZMuIN8z0GfLA0/w1LC1n1DHqL
         LlSJtmHo0I7A/UutvRcGhVw2oEpPnkS0TkXNiNESqQ9r/bJpKNFEv510kV5VSqTPFTfD
         VUl6PXzmJD+hOMz6nW5O1i/9ZUl4YNRFzf0WYCdZBdnHyauMvLzmxaOsEdgKsE7E2Kzc
         5ZUw==
X-Gm-Message-State: AOAM530iN9CB65zezE86BTITZUHse1dWnckuA0QhXGbxN44yIARG1n/H
        cQ8F0MUdbQ9RKE9lsAA7BJo5qQ==
X-Google-Smtp-Source: ABdhPJwoXDg0sjmq5aDFmhGa+NNFB42jquwRNFPZAyeiExBleSjw/K+RkBcqsmrULki+uzpd7J+4Fw==
X-Received: by 2002:a0c:fac6:: with SMTP id p6mr27581207qvo.5.1604413365360;
        Tue, 03 Nov 2020 06:22:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id n81sm3571267qke.99.2020.11.03.06.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 06:22:44 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kZxCt-00Fv0G-Oh; Tue, 03 Nov 2020 10:22:43 -0400
Date:   Tue, 3 Nov 2020 10:22:43 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/nldev: Add parent bdf to device
 information dump
Message-ID: <20201103142243.GM36674@ziepe.ca>
References: <20201103132627.67642-1-galpress@amazon.com>
 <20201103134522.GL36674@ziepe.ca>
 <20201103135719.GK5429@unreal>
 <0825e1bf-f913-d2c1-ad3f-35ba3d6b75ef@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0825e1bf-f913-d2c1-ad3f-35ba3d6b75ef@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 03, 2020 at 04:11:19PM +0200, Gal Pressman wrote:
> On 03/11/2020 15:57, Leon Romanovsky wrote:
> > On Tue, Nov 03, 2020 at 09:45:22AM -0400, Jason Gunthorpe wrote:
> >> On Tue, Nov 03, 2020 at 03:26:27PM +0200, Gal Pressman wrote:
> >>> Add the ability to query the device's bdf through rdma tool netlink
> >>> command (in addition to the sysfs infra).
> >>>
> >>> In case of virtual devices (rxe/siw), the netdev bdf will be shown.
> >>
> >> Why? What is the use case?
> > 
> > Right, and why isn't netdev (RDMA_NLDEV_ATTR_NDEV_NAME) enough?
> 
> When taking system topology into consideration you need some way to pair the
> ibdev and bdf, especially when working with multiple devices.
> The netdev name doesn't exist on devices with no netdevs (IB, EFA).

You are supposed to use sysfs

/sys/class/infiniband/ibp0s9/device
 
Should always be the physical device

> Why rdma tool? Because it's more intuitive than sysfs.

But we generally don't put this information into netlink BDF is just
the start, you need all the other topology information to make sense
of it, and all that is in sysfs only already

Jason
