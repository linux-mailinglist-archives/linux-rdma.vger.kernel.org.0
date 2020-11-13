Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABD92B1D9B
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Nov 2020 15:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgKMOmQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Nov 2020 09:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgKMOmQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Nov 2020 09:42:16 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAFDC0613D1
        for <linux-rdma@vger.kernel.org>; Fri, 13 Nov 2020 06:42:16 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id b16so6547309qtb.6
        for <linux-rdma@vger.kernel.org>; Fri, 13 Nov 2020 06:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=utPnGzEwakwT/6asJ5quxVUqO8Le0Dtu/Fy33I9lAgc=;
        b=NBQ1sqVM+RjVN34HwPUERxKIAOt9ed6RD1bEhrQR+As5NKS4hMZTQRXXd+awX4i17C
         if3kNZK6rA94ylS+F7R7QK5EfYSJmxfa9aYJ2Fr/1nHsAtxfKq7XKqzOxyE3LYJ0biqH
         kmWtqjkuo9NPyekVhpiBekk4DCyuBanFIRLGEco/KU1VUdmkwEbtjhSyRUdQ05XcgwD5
         inU7avZFm1/MtPc/T5jgqsi7RYOsvrg5dIP2Zc9vQ9NkY+gwpSoS8mWFoA8bo21AknPV
         PZd4BYqM1GCiunOS/mAq32vhOYTaTf7rNaIYqPjOdqHBpm9ZJIpcYc07o4jsi7VC/KHK
         PhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=utPnGzEwakwT/6asJ5quxVUqO8Le0Dtu/Fy33I9lAgc=;
        b=hcF0PN2HCcZQd2QK+f4R1Cg265vyr8ycJoUU5SV4fRdceF03YPS+hSVUtb1aGCPVeI
         d9nxUc3Xe3y9RkGG4dpBum2jQquORpf9H4oxpLbbvtfn+O4Zsci6WxLbi3NwvuHRo19Q
         94PisICcxT5t/Rj6HisJrybUvHi/cWRhVG4z2vSBK1OZ+qhZ7dlJzsHxOVaB1i4UMhpu
         8GazjsYvGDwAyqxhS8eKF4cjGryk3QX/mn6hcW6SlmR8yS7Yf1ayJpL2L30oiYeYwl35
         tg3F7KalDiNfU3dzWqsD+TvfSdEdApVjTVdkQHhR3bMElqWEJyo+kX7+io2sVMgK7VbR
         oH2Q==
X-Gm-Message-State: AOAM532AqgzQ3R0RD6q87MFptpZxi88L6niWdfmCBH6Zoq7tPTWLpbc5
        Tj1ExlKKcaKcFDuJ+oIeFdahFQ==
X-Google-Smtp-Source: ABdhPJybbXMsnk3NRAie+HLNPiFo77zLfqHBFbZUXRNl7jPO+wGaTAn51CXGhWGzf1ZrxuVwnOJ+Ig==
X-Received: by 2002:ac8:74ce:: with SMTP id j14mr2144751qtr.329.1605278535318;
        Fri, 13 Nov 2020 06:42:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id r55sm7257434qte.8.2020.11.13.06.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 06:42:14 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kdaHF-004aME-E3; Fri, 13 Nov 2020 10:42:13 -0400
Date:   Fri, 13 Nov 2020 10:42:13 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH] Provider/rxe: Cleanup style warnings
Message-ID: <20201113144213.GE244516@ziepe.ca>
References: <20201106204128.5384-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106204128.5384-1-rpearson@hpe.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 06, 2020 at 02:41:29PM -0600, Bob Pearson wrote:
> Cleanup style warnings produced by checkpatch --no-tree -f.
> Not all warnings were appropriate for user space code and
> those were ignored.
> 
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  providers/rxe/rxe.c | 69 ++++++++++++++++++++++-----------------------
>  1 file changed, 34 insertions(+), 35 deletions(-)

Applied to rdma-core, thanks

Jason
