Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203951DF37A
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2020 02:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbgEWAZK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 20:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731169AbgEWAZK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 May 2020 20:25:10 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03788C061A0E
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 17:25:10 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id v15so5580397qvr.8
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 17:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pjLhAl5np/8ckbTK3ljfDxRIc9+eK4ZTnScpaQqyKC0=;
        b=LhRxrvDS19pKr/M3hyhg4HrrOYeV89Kj8mrCPhqPYnpWF2ImH0rnctgaDvejxCgwVO
         95N4hmlR0sditHkyHFCF8QCVcwvzTYXskLvimW0WJRDF6RV7O9uJNtzZdud+IpkNAfJY
         NJcdqTbQBL8cnWGPwXXm0a89182cWnLbtLx4VgQ8WDEWAGuyLTs7XEdXYy7/RR1UZrsY
         v3YhMQhgnEmFReT/qmJx328uwzDW8fOko0B9oDTtJSnLUAeNdZ0LMbamPP7VNDPXQ94x
         yRDkXeZJp9P7WOS/DdpqdFblAHM+g3stkuL0Zvf23UaMNQ24PcyZ6yfO+UtNLvJ/egfL
         ERQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pjLhAl5np/8ckbTK3ljfDxRIc9+eK4ZTnScpaQqyKC0=;
        b=mxShW42tMgcOrX9SmB3qk7NqmNUAymXiZT+JSzhEPE7GL0r2ePYNNe70oT3rYkZSmo
         y0h+lxwIpbP5fEFwHUwl6XobOxpFsmlhy7Sz2OOAzjED5sHh6P2RX3iV5lj1Xh49Uy5s
         hf1WO7hL+m9rm720eU2MZkyv5L9m9LV3y9lszNbpGJc+Kwq9dtWf7HHj2apy8PbYpqnW
         6xNQw3F156kZ1gEI3XtiVaOan1lnVAzS4CANPzvwVzzD+rKYWjwbY9VsoEQZaCOrrpSG
         kl6dviK5wQpu/jtXBMZkG7DWtJfVRl5bLgFsngzpmIgrCO8cGzCLq5Af1a5kwJvfjuBZ
         YRRQ==
X-Gm-Message-State: AOAM533ybP8JzTOUTR1T35so4RdRQrZKuVcvnDhA75caaTXua0c6lp2D
        XxJIjOF0+0Gdu19cVIrRrNZTqA==
X-Google-Smtp-Source: ABdhPJzv0FKEYtfwZ2RvaOpKwZJD88cfiXNk/0TLc3z9pR8CbI9OHo9m9utMJgBIjMLtmp+ECWDsng==
X-Received: by 2002:a05:6214:1422:: with SMTP id o2mr6360340qvx.13.1590193509301;
        Fri, 22 May 2020 17:25:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id n206sm8859345qke.20.2020.05.22.17.25.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 May 2020 17:25:08 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jcHyO-0002QT-Cb; Fri, 22 May 2020 21:25:08 -0300
Date:   Fri, 22 May 2020 21:25:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     haris.phnx@gmail.com
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        axboe@kernel.dk, dledford@redhat.com
Subject: Re: [PATCH] RDMA/rtrs: server: use already dereferenced rtrs_sess
 structure
Message-ID: <20200523002508.GC9180@ziepe.ca>
References: <20200522082833.1480551-1-haris.phnx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522082833.1480551-1-haris.phnx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 22, 2020 at 08:28:33AM +0000, haris.phnx@gmail.com wrote:
> From: Md Haris Iqbal <haris.phnx@gmail.com>
> 
> The rtrs_sess structure has already been extracted above from the
> rtrs_srv_sess structure. Use that to avoid redundant dereferencing.
> 
> Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> Signed-off-by: Md Haris Iqbal <haris.phnx@gmail.com>
> Acked-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
