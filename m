Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CD93E2121
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Aug 2021 03:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241075AbhHFBoy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 21:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhHFBox (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Aug 2021 21:44:53 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227B9C061798
        for <linux-rdma@vger.kernel.org>; Thu,  5 Aug 2021 18:44:38 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c9so8328465qkc.13
        for <linux-rdma@vger.kernel.org>; Thu, 05 Aug 2021 18:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UjUg2cUQb95U3OFdHhs6XgieXL4GS3upA0q60oAkd4U=;
        b=jhyg8H870XIJQYMmxwY5rQvAJQw25ZfSnTT48qMiwceGkFfyx4sQlKt87V1PA7XHti
         egaCYXMsbvj76ijKBe2JM9OhiG9nlxU1vKA4GiOy0q1K6GhB9bWoajsgpp9QuDSWvtCy
         jec3M0gfD5E0rFYL3tofcYMA4F3cWcDX7CUGZj2HsTvBvpD/K2cZM80TgI/+TymIW5M6
         jRJgzb4tCv+/l1V3gmDjXrgBBvveTRpRm2Xc1SWH3u4rEBVaeO4D6/AEKPMtZyM03/Pi
         PtO/8nj1Pa0cP6ulQczuCkH3aro+p27vfoj1TbvAhi4qwkmxtSgi6LZBRe0Jb1FYQhRl
         TCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UjUg2cUQb95U3OFdHhs6XgieXL4GS3upA0q60oAkd4U=;
        b=XM9bwcYZyeZgs9aYPrTgbQ78fFEUphNn70MlFX2zbC364maGJc1dNcrg7uABcWcbnM
         8reDS//3qfuzdfIXoE/QTBICYFZztOVUcnkDJDB0jxEvIo4YIL1R1rj2IE9jUQ75S3Zu
         82U0KINA9LRDmELch8Up/T/YdWkbU29vRZibAJfUMEZJ5cdgF/FDjd8JynFG4Uyj/2Vw
         sCfRs+MREJVkDWhdiusYCA6BiTvPtfiVyrW8mxj/l0+f0+U9owvP6yapHGww+SDWfKDy
         V81wFUTcdTsJdzY7/TFOSVpjErcWHEu2vo8/nCD0UrqBwM368BNvrF8mnjp2EIuumr0S
         5F0g==
X-Gm-Message-State: AOAM532awbDHYC5rN8DbvFQ2Pq7WGw6rklkY29TSUp7AJVsniIdvGOFS
        NNu20ZWkVPFH8DHe80OiPgAMKw==
X-Google-Smtp-Source: ABdhPJx3JUJGcie9wVKgF4BC79/12zv+ZofpglFGOGeSZo9JdU4tQyyxkDPekm69j7O+A0qChC4W6Q==
X-Received: by 2002:a05:620a:2446:: with SMTP id h6mr7659106qkn.497.1628214277352;
        Thu, 05 Aug 2021 18:44:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id u19sm2852096qtx.48.2021.08.05.18.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 18:44:36 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mBoua-00Dvf5-6c; Thu, 05 Aug 2021 22:44:36 -0300
Date:   Thu, 5 Aug 2021 22:44:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: Help understand use of MAC address resolution in RDMA
Message-ID: <20210806014436.GL543798@ziepe.ca>
References: <CAN-5tyGiuTXBy2pcSd6PT3_Bdxx6H8QWzXaurSooMz7uhU2rrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyGiuTXBy2pcSd6PT3_Bdxx6H8QWzXaurSooMz7uhU2rrw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 05, 2021 at 10:38:42AM -0400, Olga Kornievskaia wrote:
> Hi folks,
> 
> Can somebody help me understand how RoCE (this is probably RDMA core
> and not specific to RoCE but I'm not sure) manages destination MAC
> addresses for its connection?
> 
> Specifically the problem being observed is a server initiates an RDMA
> CM disconnect (client replies), client tries to reconnect. Server
> sends an ARP advertising a different MAC for the IP that the RDMA
> connection was using. RDMA code keeps sending the RDMA CM connect
> message to the old MAC for a certains period of time (90-100sec) then
> it finally sends it to the new MAC address.
> 
> Question: how does the core RDMA layer manage the MAC address for the
> connection. Why does it seem like it ignores the ARP updates?

RDMA objects acquire a MAC adress when they are created and do not
synchronize with the neighbor cache after.

What you are seeing is that the CM_ID object holds the bad mac until
it is destoroyed and likely a new CM_ID object gets created that holds
the updated MAC

Jason
