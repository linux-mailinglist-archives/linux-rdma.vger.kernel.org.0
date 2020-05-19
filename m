Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876931DA5CA
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 01:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgESXrP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 19:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgESXrO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 19:47:14 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684C7C061A0E
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 16:47:14 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id g20so511946qvb.9
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 16:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hab13sCBMoSFVDNe53Te5/um8u7Dvom/Oq5qeGy6LQM=;
        b=Xhbw9rpuCFAsoXsARVsCZK+5mFgLakvRnkIHpbr4LPiEzmvAFLyiDyxRbU9Mkl9Tfe
         73zROnHsRIGAQKxAXv5vA2bB+Mqm5m394G9/J23BDf/8WQGTOp/6wcKBy2SoClf1hE8n
         CPJmIWUcNVVNK/QO/oUQckvWaQSs6cD3J+zf0ZvwZYNAAWHINHg4rKH8Ts6JpZVdQwET
         dXiDnk2XP5PdM5lfJJldFqF3lgi12EFFkLAnQ4YVU0wRmjSr8MeUAgohtdLObAbCPMtL
         fE28dcJgqERVB0truvko/CaxypXZzlRj+adKyQniVXkcKDWfHG7e52W70g1ZGmN6Ju8l
         Evxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hab13sCBMoSFVDNe53Te5/um8u7Dvom/Oq5qeGy6LQM=;
        b=I2FOfbmk16mJIh8FHcHa4yuBk/Jm9Lkhyr1O00fUJ8mufIwzbmurI027KLVfM/Rq2v
         /ZX2sL0SgzpfN4fafUipTHALKUkCdzFM3KhL70r4pOwZ0kz7FPWfu4Ygm8HoymVP1l0x
         3+ylMncfBgH1ZfOkgWquCSKY94dtQlxwCBq7InsLopFTd9SNMyLrE08TQD2jFVkRpdeF
         3wXKyc8hVeGgaqvk1rnGIz/vQOCiVRzUtjDY7iDeGXzXiF6vp8c0Wt43Wx+yyGaEAUN0
         arCrKfFQuDd2NqdzGHwBEfK7bfp1K6SeArX9BhY+PtO6qqGbv7VdlhhDzZvUq1mxxd2W
         27WA==
X-Gm-Message-State: AOAM532GYQme0NlDlichTfGQPTyY8NWdwPdjwqFy73fo8uklagLB0N9o
        xnKL1N2KwH4gAuTpcjX7TwPO8A==
X-Google-Smtp-Source: ABdhPJzpAvhAglbfwjvqzAhBMICKgBROUjygpu/1kcwuj3g1+1V47CU1Z7d97GhpLB+Zon5+2NymcQ==
X-Received: by 2002:a0c:a619:: with SMTP id s25mr2273937qva.21.1589932033719;
        Tue, 19 May 2020 16:47:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id q2sm845022qkn.116.2020.05.19.16.47.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 16:47:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbBx2-00081J-VC; Tue, 19 May 2020 20:47:12 -0300
Date:   Tue, 19 May 2020 20:47:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH v2] RDMA/rtrs: client: Fix function return on success
Message-ID: <20200519234712.GE30609@ziepe.ca>
References: <20200519163612.GA6043@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519163612.GA6043@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 19, 2020 at 11:36:12AM -0500, Gustavo A. R. Silva wrote:
> Remove the if-statement and return the value contained in _err_,
> unconditionally.
> 
> Addresses-Coverity-ID: 1493753 ("Identical code for different branches")
> Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
> Changes in v2:
>  - Return err, unconditionally. As suggested by Bart Van Assche.
>    Thanks, Bart.

Applied to for-next, thanks

Jason
