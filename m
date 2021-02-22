Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADE4321BF5
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 16:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhBVP4s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 10:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhBVP4q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Feb 2021 10:56:46 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC505C06174A
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 07:56:01 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id s12so5582280qvq.4
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 07:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r4MoegJpdRXxLcC5LeWKVsEmGKziwHKu3olvfuERq2U=;
        b=JqkIlq8Q+WWohUyLQeJof+40fIkqF8DMW4mLbGbW5sso3y0eIzhdg2nfeNBDZ8f8vn
         yaFQM79Nf1pZzV2mtEW5pz6Yd0n/mYxE936zDWiIjIgNxytfqwKbSsJTv6Q2SzIL0hPu
         Olrljfp/xUBaE/tukW3etWtQJJvEuRueRjgPYbe0OyRERcNytvTZLEgFpj5uhB5SwL1a
         X35Sjim3b7KqKVVSLA5pPsMoB1g62kdX8fmb69mmRWcyY3fgsmNj0DcDtptw0hC2hP+1
         EIYlITfvXaNQN7fi7ew2Kf+nVCLR93/U56EMb6R//sPBNussvHrEq+IbBhWmXs/fNaWc
         Dbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r4MoegJpdRXxLcC5LeWKVsEmGKziwHKu3olvfuERq2U=;
        b=Y1xf4dA0r2BEIa5y9PW+Ee6nyhzkkxLmFRfjepDsVr8Z1GjUnhNICHywkHN4GRo94V
         zhphFc8rByk0b5SzeC8U9ZyY8oYE7cZM8WpgkcrqFGBrJlWy/RINAgCgjq5pM14UuN58
         i1OzaTpOBvUG911+C7iwBoqQb+n6m6KD1X65CMZ17bIWZlDDO5Sr9yQuDyXUJPCb7GvE
         sW4f2vNQEHo1Tb59Itlc+Djj0v3i3GOLL8jR4D/wYDRDfXR7lG+1h92auNPvGV9DVgU5
         CejWZtTOVnE9RKd5dFKx1W93Tpyik/LCi++WgKhQiAN7rPgu6yeRoeWBSEgbODLezi4Y
         DyeA==
X-Gm-Message-State: AOAM530abg2DzsIN21Am7zb4H7NudmwP2SwglpYxbWpciB0ZbMfPOhhr
        UsZmEiq55NmpjJ0gXuPZz4VyBQ==
X-Google-Smtp-Source: ABdhPJzpPyBKqNLFakOddoqeVTYtYqhNSBewZFwnECYyL/l3bcA293WTKoMMZAHBiAB8bm2UExiVvg==
X-Received: by 2002:ad4:4492:: with SMTP id m18mr1916738qvt.52.1614009361041;
        Mon, 22 Feb 2021 07:56:01 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id v4sm1675717qte.42.2021.02.22.07.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:56:00 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lEDZ2-00ERF8-0Q; Mon, 22 Feb 2021 11:56:00 -0400
Date:   Mon, 22 Feb 2021 11:55:59 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: ibv_req_notify_cq clarification
Message-ID: <20210222155559.GH2643399@ziepe.ca>
References: <bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
 <20210218125339.GY4718@ziepe.ca>
 <5287c059-3d8c-93f4-6be4-a6da07ccdb8a@amazon.com>
 <20210218162329.GZ4718@ziepe.ca>
 <51a8fa8c-7529-9ef9-bb52-eccaaef3a666@amazon.com>
 <20210222134642.GG2643399@ziepe.ca>
 <e26a3e90-cc8b-d681-5d6b-4e363aa1933c@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e26a3e90-cc8b-d681-5d6b-4e363aa1933c@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 22, 2021 at 05:36:17PM +0200, Gal Pressman wrote:

> "Mellanox HCAs keep track of the last index for which the user received an
> event. Using this index, it is guaranteed that an event is generated immediately
> when a request completion notification is performed and a CQE has already been
> reported."

I don't think verbs exposes this behavior.
 
> This also sounds weird, why is an event generated for a completion that has
> already been reported?

It eleminates races, if the consumer says 'I read up to X send me an
interrupt if X+1 exists' when X+1 already exists if there is a race
producer has already written it. So send an interrupt.

> So from my understanding of how this should work, the following code in perftest
> (ib_send_bw test) is buggy?:
> https://github.com/linux-rdma/perftest/blob/master/src/perftest_resources.c#L2955
> 
> Running this with 32 iterations, the client does something like:
> - arm cq
> - post send x 32
> - wait for cq event
> - arm cq
> - poll cq (once, with batch size of 16)
> - no more post send (reached tot_iters)
> - wait for cq event (but an event has already been generated?)

I don't know much about perf-test, but in verbs arming a non-empty CQ
is asking for trouble

Jason
