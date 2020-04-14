Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D441A8A67
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2020 21:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504570AbgDNTAj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Apr 2020 15:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504540AbgDNTAh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Apr 2020 15:00:37 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE52C061A0C
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 12:00:37 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id da9so449579qvb.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 12:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zjkQPGHyUki7mfA+Tw+mduT2H9qPW1uaFLP6So+nFxI=;
        b=ezzdfwAByd+cMFPB5FgUjHuupNjDVCWsuKhbWpjd4XQb/2dJ6Id6+/50gKMjoS5ov2
         kXlJo55E2VXXSnyRsRvLqu6av4dvqApct03ot4FTchDwpcr1KIttYITtaxiW+S0RlEdo
         Wyix8em7F0eWWUjm5HXcRhMJmN678zr1IEnxrCjvD9X52qRkzjEmcWJeKJNrPi303sLY
         ztHIioKnFyGl4mYOTAKhXD4uOubG3HcjjngK46ef0Bj58rF1AdodUUefiLORSCWfcdPH
         xqqwyl3YOi/WKTYyfJ3YmAgEb0Qx8vUupgv+y4eCtGpl8xn1RkrsKSjHeQZKZOqXQiOR
         xV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zjkQPGHyUki7mfA+Tw+mduT2H9qPW1uaFLP6So+nFxI=;
        b=MQvaFBTBDl4WIcc7+zfKuVRv413W1XDNtiFEEhuhpra2+YhpWf1fZFLPRo48xT8+Yn
         +N6n+RO0ziK2GH7N/2M4DX80UIfpW7QOvuKSDrfBhDG2DlgjxlflpRQULL9rKV08csNA
         JrGX/TRSq3Hup+mS7km9BN76KvT05xZTgCjt0t8tRMJevtocjk2y2uyIgU00gQXdqp0M
         jhQUz483QGMyIQnA8SAP0SQ0ac0yjb+0w2zMNtmZ4iUb6FkbdA+XOMGpJyTZzQEtqXEu
         Te4xv5LOjq1E1kZGxUn8NfdtEyI/XCavcZLGxBVQnPhM31Ee3Vw/rISlhJYIokkyBiLz
         hx3Q==
X-Gm-Message-State: AGi0PuZT03/s5Q2+ZagLsaJHZT1JaHLbAyel7eybF0qE9tb+D7mlHt0/
        I887bGeHxVPZ78P3o6S7GCGmZrtJVpdGOA==
X-Google-Smtp-Source: APiQypK3beMKTrldiNrRy/RX//5jYIwRZDC1Db5Oj4GioajycyR/4Alz2lKSdiMVDDPCoYUKdaZcsA==
X-Received: by 2002:a0c:fb12:: with SMTP id c18mr1405831qvp.171.1586890836836;
        Tue, 14 Apr 2020 12:00:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g187sm10759832qkf.115.2020.04.14.12.00.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 12:00:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jOQnT-00033Q-Om; Tue, 14 Apr 2020 16:00:35 -0300
Date:   Tue, 14 Apr 2020 16:00:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        linux-rdma@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
        Roland Dreier <roland@purestorage.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix udata response upon SRQ creation
Message-ID: <20200414190035.GB11664@ziepe.ca>
References: <20200406173540.1466477-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406173540.1466477-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 06, 2020 at 08:35:40PM +0300, Leon Romanovsky wrote:
> From: Yishai Hadas <yishaih@mellanox.com>
> 
> Fix udata response upon SRQ creation to use the UAPI structure (i.e.
> mlx5_ib_create_srq_resp).
> 
> Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/srq.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

This isn't really a -rc issue, applied to for-next, thanks

Jason
