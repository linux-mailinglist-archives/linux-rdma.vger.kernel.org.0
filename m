Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F714B595E
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Feb 2022 19:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357338AbiBNSIq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Feb 2022 13:08:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357335AbiBNSIp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Feb 2022 13:08:45 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE54652C4
        for <linux-rdma@vger.kernel.org>; Mon, 14 Feb 2022 10:08:36 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id n6so15422476qvk.13
        for <linux-rdma@vger.kernel.org>; Mon, 14 Feb 2022 10:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=Vb3WxFTok3CxC86h8OILY6/7h3vuSZb2vv7Z9Idn4d8=;
        b=WZKm/nuvhR/p+C0aWg2rCijjRau5Crub1yz5ZLvCvG0kSM21K/mVTaoSpIiS2OK2yu
         HA/WSUdiK6JZCgvNNiZXVsHzpHGT3mYUOomnRcPhMz7rG5uh5gVXKzIOj3Ea/LiWrnJu
         X4+yj94If1iFprEfxbPjXOuei1dIIUzsWHfyrMErvk7XEJ+VHrVKvpZmR45e+5p8wOAc
         fvL5cprVe2DhQRRbcQ8/ZDBHZnXgk+ISi2aFg2/XxFJObQWXSxjlB2HCR9XK8xStAV8I
         RanXKlQ3A1mbNLFIaOSeDKs4DanSe5pquE+gU4h/IT8CEMgu68eUArN6Uf7z9Q0yCUvX
         8Z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=Vb3WxFTok3CxC86h8OILY6/7h3vuSZb2vv7Z9Idn4d8=;
        b=n+8DzDZBHxm2N6r2GQhxfFt2wovZp5+y08VQDGLq1YbbMAeY02AHCYuL8MGTZ9JCsd
         S9s77jW4saJFF7egTn5Ov/rQ65cKNV6rpmb40Hut1UhP2iuDGZcKvYGeH5Q70Nlt1bcG
         Ua/Z9Garn6UszERroW3b+Cxz8nYjxoVo2AaZq+WrMmJH+llY0JaFziJZgs1datRsl/mv
         zi7tfSzQadDsEAFNclIaPuZaa01LFf5LnP9ui97ifndP+KQ8DVoT2DmARMmpgGfYXTIy
         OMy6eQlMphfwexdJvdNXcyxv6O+p+dV+3iTVqKUiMgWCkOvsM3uCWuVM0yDSGRTP6X+1
         16Eg==
X-Gm-Message-State: AOAM5319Sg4U2tedW4wXP5H1XoY5vJLI6yVgY5zM9JTWRlaAR1Kx1hv8
        rZ682bC3HNkLLlvtdvgD9qWZ/tGYiA0Ajw==
X-Google-Smtp-Source: ABdhPJzLlaSDmVczFvsp7JTTALo+HNTGCYuqjEGXXeC6NEvcg/7Nze8db7Frj/avHcNNlzex9Y9wiQ==
X-Received: by 2002:a05:6214:202e:: with SMTP id 14mr183273qvf.33.1644862115434;
        Mon, 14 Feb 2022 10:08:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id v22sm18800929qtc.96.2022.02.14.10.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 10:08:34 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nJfm5-003z8V-VO; Mon, 14 Feb 2022 14:08:33 -0400
Date:   Mon, 14 Feb 2022 14:08:33 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Robin Peiremans <rpeiremans@gmail.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: sysfs: cannot create duplicate filename
Message-ID: <20220214180833.GA525064@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJt3DjCM1uKkutB0srAiofuLUunX8hJZ+h+xkkTKmN3p_r+OLg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Feb 13, 2022 at 10:21:49AM +0100, Robin Peiremans wrote:
> Hi
> 
> I ran into this error when upgrading to kernel 5.14 (it works
> pre-5.14). The driver gets loaded (verified via lsmod), but the ib
> utils don't show any ports.
> 
> There's a bugreport on elrepo
> (https://elrepo.org/bugs/view.php?id=1176) that looks pretty much
> identical, but it looks stalled.
> I've bisected the kernel and commit
> 4a7aaf88c89f12f8048137e274ce0d40fe1056b2 seems to be the culprit.
> Since I'm absolutely no dev, I'm hoping someone here can figure out
> what exactly is going wrong. Latest mainline kernel still has the same
> behavior.

Don't know, Mike tested this patch on qib, maybe he knows

Jason
