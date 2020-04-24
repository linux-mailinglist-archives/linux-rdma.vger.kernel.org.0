Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4DE1B7DE8
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 20:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgDXSdO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Apr 2020 14:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727021AbgDXSdN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Apr 2020 14:33:13 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA724C09B049
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2020 11:33:13 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c63so11232078qke.2
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2020 11:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m4GL+2qW5009jJSbr8XQNzoDynO0xHgFGHV6m3bG+R8=;
        b=hOsTdl2DGYElFVwP2AZc1C2xImVIZIem392vC9ZmMVtYinGbekq3qXVWWfWOmru0gB
         VqrNMhb4zz4qns3UJHTvRlTd5EWRrvfpwuhcGVmcv+s0uaxaS1vdWHB5g3KzXkQHQQeu
         jUXv0FwxN+BKUMBwLrqA+tjqfoRj7ItpPsV4rK4xAR9Qal9gyR0TnfSN8qmDsGT0Fx2k
         WH1AnZ3gX6WTIRhKfw7L8VzxEMaBNfOF9Ux/OF2k/Js/9ttbLXgNNPb6lhg0e31uBhnB
         QK8/X40zuNTQy8FpIczrDhFy9EhQqm3/xzi+dkzu8T7J4znLRgO2tPWCFASJuTSzuCYT
         3iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m4GL+2qW5009jJSbr8XQNzoDynO0xHgFGHV6m3bG+R8=;
        b=tjSnnx+W1EO1KdICgHQaidUgMzFHWNA4t6R0KYCY4Talsgt67qszkAUY9xb6fRLFH+
         AbHjDkBH1Mr0Kwun8bgheCv6UbU/O8P562aXR/ArKAMuWG1CnhFxqEYvjJjg4EkS18oh
         lPaiWqdvsXrl5IWS4ghxo9P+RLUPcqKdm58aR0XYo7rxCjFNgGUANXe55A482DS7ILRg
         B1SF4rfvUY1Sln8uQs/kj84SlES+uWIQiKMTgxwH+k1mUEicpVU6X1Zaq6F3Or+PCC3Q
         gbtXBtGteXvFKMF/XU1mrzo+hGnhVhiN8uyFJD+TDEA64Xu3/pq0jnUQlEJSNQEwXkZB
         cGTA==
X-Gm-Message-State: AGi0Puby0dTmdkCWi7oX6alAzlQ0XNLOxS/5/OYqu50F4js3mprUmnpb
        ETJ19prPnBkq7IKHnh0iOedfVA==
X-Google-Smtp-Source: APiQypIy2HFDJTLHXkfapQFjTL9P9cxp8LoavbehKspKuVFZ3iO8c3HmjkVecVBAoGSW/Tu2ZZz30g==
X-Received: by 2002:a37:65ce:: with SMTP id z197mr10389320qkb.0.1587753192850;
        Fri, 24 Apr 2020 11:33:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id j25sm4286619qtn.21.2020.04.24.11.33.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Apr 2020 11:33:12 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jS38Q-0004lP-Qt; Fri, 24 Apr 2020 15:33:10 -0300
Date:   Fri, 24 Apr 2020 15:33:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3] IB/rdmavt: return proper error code
Message-ID: <20200424183310.GA18285@ziepe.ca>
References: <20200424173146.10970-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424173146.10970-1-sudipm.mukherjee@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 24, 2020 at 06:31:46PM +0100, Sudip Mukherjee wrote:
> The commit 'ff23dfa13457' modified rvt_create_mmap_info() to return
> error code and also NULL but missed fixing codes which called
> rvt_create_mmap_info(). Modify rvt_create_mmap_info() to only return
> errorcode and fix error checking after rvt_create_mmap_info() was
> called.
> 
> Fixes: ff23dfa13457 ("IB: Pass only ib_udata in function prototypes")
> Cc: stable@vger.kernel.org [5.4+]
> Tested-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Acked-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
>  drivers/infiniband/sw/rdmavt/cq.c   | 4 ++--
>  drivers/infiniband/sw/rdmavt/mmap.c | 4 ++--
>  drivers/infiniband/sw/rdmavt/qp.c   | 4 ++--
>  drivers/infiniband/sw/rdmavt/srq.c  | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)

Applied to for-next, thanks

Jason
