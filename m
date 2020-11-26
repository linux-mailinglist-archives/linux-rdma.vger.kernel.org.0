Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6AA2C5A9C
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Nov 2020 18:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404328AbgKZRaj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Nov 2020 12:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404097AbgKZRaj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Nov 2020 12:30:39 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384BEC0613D4
        for <linux-rdma@vger.kernel.org>; Thu, 26 Nov 2020 09:30:39 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id 7so1597069qtp.1
        for <linux-rdma@vger.kernel.org>; Thu, 26 Nov 2020 09:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1mZpvfPXL1P094zPPi4BpYDlkPijTUMbrPPIYpGaIDU=;
        b=MBlsiD1JtjAM9vTmjf1CE6PrToZW5yWQr++KK1ZRfLmV19UQ7XXfne1XRdVf30TAaJ
         g5Pu5pT+otunzwUaQpBgBRDWDYfgLZnHv/E/z66e60C6nA3g3yofGAe8Rg5iyKnxiyow
         4AT46hji3F6LFtJYvlEvwWnLzAP9iJr3fYkXwZIfrMyKrhaSAR0sJOcr9J77hMVJm2/Z
         28sy7YDXC+A6AFTf0xQeBEFuNxIhtGarHnzwpN2M7GCzbQR3cpoUsUfOJAIz85GwCSdN
         vtuUWZdvGiCUqNKc17vb/DJjt0NaU3oqhz9NOm9SSxgRq+NC/bSJvyAeP0kjk6vc3Tsu
         b6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1mZpvfPXL1P094zPPi4BpYDlkPijTUMbrPPIYpGaIDU=;
        b=nU0C831pcKi6icqUPPcB+y8tB3yoKgHiGAiwyfUg9+0wg72IiMTDBVjMddNQddfQOM
         dSms7tBXpmLS40FBdHBlb6CWmaAXJOzlCNNZ3zNSMF1viXbVt8YvQiemvP3gfYFOtk45
         qaUL8MLJq4ok6u/vu95ZnVKHIToDJwtpKuHKiDWabTPg8fcj3UGCznHJ0c4iz7OzgQf2
         UbZmyTN2BR1x/tp4FD/nSGYKeD3KkeeHHsT5RdQfHOHjMQ64oaHrjuU7+UnOY51kzSs7
         +u+AePBWeKNOejEvdCu/6S24KjXv9bpUESz4ubfRxDC3iBwYwG8VyBWQoqV9IOady6oQ
         LXmA==
X-Gm-Message-State: AOAM532mvudltdjQU9Pc1WQ2lAWcjmBaaN8rOKRikoHwKFK44tOfv3L7
        adrLMhBbYoHPLXhLAyEsWohEaZVjnuZRqOgv
X-Google-Smtp-Source: ABdhPJzHjn8us4rxdNcvR8xppZvHgyQHIYYkgsVl5ZWid/fj/vwRnm8ihtnccRUsXaLt9GJgdLjH9A==
X-Received: by 2002:ac8:6f42:: with SMTP id n2mr4156749qtv.17.1606411838419;
        Thu, 26 Nov 2020 09:30:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id z30sm3279835qtc.15.2020.11.26.09.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 09:30:37 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kiL6K-002FQK-EF; Thu, 26 Nov 2020 13:30:36 -0400
Date:   Thu, 26 Nov 2020 13:30:36 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [bug report] RDMA/restrack: Store all special QPs in restrack DB
Message-ID: <20201126173036.GT5487@ziepe.ca>
References: <20201126113347.GA128957@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126113347.GA128957@mwanda>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 26, 2020 at 02:33:47PM +0300, Dan Carpenter wrote:

>    231          if (res->type == RDMA_RESTRACK_QP) {
>    232                  /* Special case to ensure that LQPN points to right QP */
>    233                  struct ib_qp *qp = container_of(res, struct ib_qp, res);
>    234  
>    235                  WARN_ONCE(qp->qp_num >> 24 || qp->port >> 8,
>                                                       ^^^^^^^^^^^^^
> qp->port is a u8 so this is always going to be zero.

I think we should ignore this one. I'm expecting the width of port to
increase..

Jason
