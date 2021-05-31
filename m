Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6485939680A
	for <lists+linux-rdma@lfdr.de>; Mon, 31 May 2021 20:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhEaSpP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 May 2021 14:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEaSpP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 May 2021 14:45:15 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF90C061574
        for <linux-rdma@vger.kernel.org>; Mon, 31 May 2021 11:43:33 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id j184so12008263qkd.6
        for <linux-rdma@vger.kernel.org>; Mon, 31 May 2021 11:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rNAZSY9hdU3fgMqzsDU2BSlfWt3Zlzk9dbxnBkPowaw=;
        b=AAE2kv7BMaqUvSOojjd3vNaoFh1IrJxbaVfmoMDhwBvDpdzsSRMR92yNDlKHRxVOSR
         Wzf6cdiACDfXVszpFjwkl77ouTRLqLE7zZa2qgap3xN5bozKQcHEUIyNRxOHpUQ3VMG9
         kGH5SMMLyHWL6h6MIlj+oCKwuPf1WS5STuaRtZb/tA8MBZ3Spjdh4ZsmXnzOlEn24+Qb
         zp78MUwIiaeFnlr8Y6Tahx2A8UCmyug6U/QEzkpTQpP688RI2Qdm+KL715IxE1wvrsyC
         ZjTRSqgAo0IOWXd9eWZzMoGskk+qLASTgYyGcHv5E1L/AZ95ZPTsZ5iIzKv+v+pGB5y/
         ttSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rNAZSY9hdU3fgMqzsDU2BSlfWt3Zlzk9dbxnBkPowaw=;
        b=P0P91rVxWBNABCOeFQvhEDOabtlCDZqhi88eCSJOBsoVS1CkfND7RjkwxRe9M30WQk
         owgHMmtNak22jwteJcSTjzDbgxrlI4zkUVyt9DEEYGAZ2HwyQhHzwh58tQ1M6NUSONbE
         9yBt5KAntfhv/3xp25d7RCVF/vgu1Oo0wfwV4+4UwzpyIhJl8pX4AkA3arwW1N69qEFK
         jpuF83uvHSRO+aFbG3I0drgbmRtOAtSLX44G9Tnge7HgSbjGPPimScCT2QgLi5LTvU8f
         TU/la31gfqhwoWwz1W62yvwY+EldU7PiWslLlH/EcFqcuOBHZ8usV11NqWOK8WF9w31n
         sZOg==
X-Gm-Message-State: AOAM533fXzutlPj45Iaee90WADWWoupBtt65hdNz3OpMKM6UPVQpF1uf
        uzp72qlH6Hrn48Uu1I4glsKSLg==
X-Google-Smtp-Source: ABdhPJzsTs5RjErq3aGWKdDnMAQplWk94k4HyyJjYentaCaOVbdeVX/eiKWx+LLNpqfB4vDBrdu/Tw==
X-Received: by 2002:a05:620a:1643:: with SMTP id c3mr17580763qko.308.1622486613038;
        Mon, 31 May 2021 11:43:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id t15sm3233048qtr.35.2021.05.31.11.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 11:43:32 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lnmst-00HDpC-J1; Mon, 31 May 2021 15:43:31 -0300
Date:   Mon, 31 May 2021 15:43:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, haris.iqbal@ionos.com, gi-oh.kim@ionos.com
Subject: Re: [PATCH] RDMA/rtrs: Avoid
 Wtautological-constant-out-of-range-compare
Message-ID: <20210531184331.GL1096940@ziepe.ca>
References: <20210531122835.58329-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531122835.58329-1-jinpu.wang@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 31, 2021 at 02:28:35PM +0200, Jack Wang wrote:
> drivers/infiniband/ulp/rtrs/rtrs-clt.c:1786:19: warning: result of comparison of
> constant 'MAX_SESS_QUEUE_DEPTH' (65536) with expression of type 'u16'
> (aka 'unsigned short') is always false [-Wtautological-constant-out-of-range-compare]
> 
> To fix it, limit MAX_SESS_QUEUE_DEPTH to u16 max, which is 65535, and
> drop the check in rtrs-clt, as it's the type u16 max.
> 
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 5 -----
>  drivers/infiniband/ulp/rtrs/rtrs-pri.h | 4 ++--
>  2 files changed, 2 insertions(+), 7 deletions(-)

I kept the patch as is since the first hunk gets wonky conflicts if it
is squashed

Jason
