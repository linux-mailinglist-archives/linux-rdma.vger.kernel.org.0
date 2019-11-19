Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D805102A59
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 18:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfKSRAk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 12:00:40 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40489 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbfKSRAk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 12:00:40 -0500
Received: by mail-qt1-f195.google.com with SMTP id o49so25391994qta.7
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 09:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aZC6Er52kzFPqj0DyHT+PUzLtdyXWVIHdI4KZMAXv68=;
        b=Cr8fkFO/Gg45Xmel/BdF3Q8Q60Kha+id1YScMBpNd0Lb++tuyFt5SCHXezJ+zwRfAv
         /vB7PjOJ9vgc2uzZktsHEYs/noZB2/CWJkfua8dmGdAwkkK63meF3bPIZvvyEQ0IlbDq
         +Xxn24h5J4+oB2i67cj+O9rdmB+MPK4cVoxyYpc8BBWJH1iHHKogJ59dVI4/YvckQUhB
         BcA4Z169TR7IcQQFP1DosgVQo9OSvZhiwuwqvIrcr3VL5QrBOX2BO4o9lJ1LYtK9OjXe
         L1Xg/qHyy+h2PRBMICUb25NZx54MnGojuXsLRMx8RjbQpVRmmA4VIYm6jGcd5LRTXxEc
         21og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aZC6Er52kzFPqj0DyHT+PUzLtdyXWVIHdI4KZMAXv68=;
        b=YNGlaoQKZ3dxVlnENkXkVKvly8+TEed+mDJKvwpMxlgQBu2x/jSqVTXv8GjIds7LHW
         uXPdr53MG7+iD1PXm/2fyUR16ahoLzu7Bx3ZIoQZoJ9hZuOPWMiz1EoLQ2yLjKugp/5k
         M0yviyecU2CJPL4OicKe2tkjHR3Xjf9jLSRxOfiGSY4NVDXGrDOHKi8qvIOaR/CO9hzO
         wJHsIYymegfP9qX9yDQ1jfusc4P3FJmva7yoarGbv0bzxU5rIpm9oW2u9gDYr7ZlaJDF
         ICXO8ZWVDS85csxfxOUcM2CislP1uunM6GT/Qtx1b3/R7o7KcRnYwuyYPbOOrwa/BED8
         nvzw==
X-Gm-Message-State: APjAAAXoBrfMgaun8PWCq8353Dy1F3XDythO847xUHXL1bOyrS6EuW7B
        XyUUyGh0tboYePk/M6K1J1UV/mwnIYg=
X-Google-Smtp-Source: APXvYqwYVIemMzrKxMeurc3cTe3v+oxw9qWpubD86eVN+0UB60d8nLif89AXgMYs/W2KTpcO+gS2BA==
X-Received: by 2002:ac8:1410:: with SMTP id k16mr32764548qtj.27.1574182839486;
        Tue, 19 Nov 2019 09:00:39 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id k26sm11854560qtm.10.2019.11.19.09.00.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 09:00:39 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iX6rm-0001aP-DJ; Tue, 19 Nov 2019 13:00:38 -0400
Date:   Tue, 19 Nov 2019 13:00:38 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v6 2/2] RDMA/cma: Add trace points in RDMA Connection
 Manager
Message-ID: <20191119170038.GD4991@ziepe.ca>
References: <20191119074516.GG52766@unreal>
 <6F70DF6D-B73A-490D-B344-1F216D1B222F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6F70DF6D-B73A-490D-B344-1F216D1B222F@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 19, 2019 at 07:10:03AM -0500, Chuck Lever wrote:
> >> diff --git a/include/trace/events/rdma_cma.h b/include/trace/events/rdma_cma.h
> >> new file mode 100644
> >> index 000000000000..b6ccdade651c
> >> +++ b/include/trace/events/rdma_cma.h
> >> @@ -0,0 +1,218 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only */
> >> +/*
> >> + * Trace point definitions for the RDMA Connect Manager.
> >> + *
> >> + * Author: Chuck Lever <chuck.lever@oracle.com>
> >> + *
> >> + * Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
> >> + */
> >> +
> >> +#undef TRACE_SYSTEM
> >> +#define TRACE_SYSTEM rdma_cma
> >> +
> >> +#if !defined(_TRACE_RDMA_CMA_H) || defined(TRACE_HEADER_MULTI_READ)
> >> +
> >> +#define _TRACE_RDMA_CMA_H
> >> +
> >> +#include <linux/tracepoint.h>
> >> +#include <rdma/rdma_cm.h>
> >> +#include "cma_priv.h"
> > 
> > Did it compile?
> 
> Yes, it compiles for me, and passes lkp as well.
> 
>  I admit though that it seems like a brittle arrangement. Might be
>  better off moving rdma_cma.h to drivers/infiniband/core/ .

The more headers that can move out of include the better, IMHO

Jason
