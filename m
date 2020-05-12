Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7981CF5F3
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 15:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgELNgn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 09:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgELNgn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 May 2020 09:36:43 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60BDC061A0C
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 06:36:42 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g16so10221755qtp.11
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 06:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LUciNuF3YfvBkvLY8+LGb+DYs4ngpNWdVEaL9UBiyEM=;
        b=VpNOG/3L4uBOZbzf81OxvElrDaXMP8EvHMi2/oxA7Px2wtm+QA+D+wMxfhacL370r4
         zdfQkGCZvEPjgbIw09857h5V9o4QbkKCgRDnP2cVImKiq8fs6TJA71tAJzumPWE7TB9c
         dtPZTCFJaujZRCIg5qa603jM4CX8eF7zySvO8MAqgyeOXsINdi1GbbgvUv69AlyZi/yg
         FxHI4ulN4wC65qm+8q+eXvLCLxy63hSLNVCsXJRwJ7N91v5HbpLnTp0OqOUXQb/jRara
         L2MGNdqEZqd4xug731tzzvbJoRX4tzC0YocqY9NXQwCeXlZrjQ4KwBi6hQ9QADCURcn1
         3aRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LUciNuF3YfvBkvLY8+LGb+DYs4ngpNWdVEaL9UBiyEM=;
        b=WLKJwXXC1OB86leNzwkAQi02fhtiUPPULa6rtRnwuaxsOXrn3fpy/3WJ25K2SuAMG8
         IFjVUlREUa3KZl0xRKQQs7sDh9aPENFOdQS7oCuXqDczn1dmdAkN3Ye4bpK7rAYxEwf4
         C4MdKHspBGtdUseRF0Orttdgzo8kiUCfstRKr3CvoasXuujJHQ0GNvg/+1H2MAgGGvft
         Byzvgebwf/yln7D/W4PG1SMle4zH2/h6GR6Mj5hjmACcleuzOkb1r/regSQ94I/ak8Ya
         hNulF9zffM4Lu69Jz3Mlt6IUiMR3C+8KwofZ4w5nTprut+65p1rvmKboNm7deMvUF27x
         Y/AQ==
X-Gm-Message-State: AGi0Puay821L6dTxgaZBqW2KlrgvF/atlGi5qCgBhWbQ8RzkyDpyDB3/
        Om4V1DrWPsZBtZxN6O6h0JWwkg==
X-Google-Smtp-Source: APiQypIv3Gr6h9qVPJooLoKuIcNHId7FdXfnby/9mtMcoXEX0hZinQu0g69kU0uUrTvUmh+xxqGvnQ==
X-Received: by 2002:ac8:120a:: with SMTP id x10mr22299077qti.127.1589290602052;
        Tue, 12 May 2020 06:36:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id i4sm10829835qkh.66.2020.05.12.06.36.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 May 2020 06:36:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jYV5M-0007yQ-Mb; Tue, 12 May 2020 10:36:40 -0300
Date:   Tue, 12 May 2020 10:36:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        nirranjan@chelsio.com
Subject: Re: [PATCH v1 for-rc] RDMA/iw_cxgb4: Fix incorrect function
 parameters
Message-ID: <20200512133640.GA30617@ziepe.ca>
References: <20200511185608.5202-1-bharat@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511185608.5202-1-bharat@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 12, 2020 at 12:26:08AM +0530, Potnuri Bharat Teja wrote:
> Commit '11a27e21', while reading TCB field in t4_tcb_get_field32() passes
> wrong mask parameter which leads the driver eventually to access illegal
> SRQ index while flushing the SRQ completions during connection teardown.
> Fixes kernel panic/app segfault due to incorrect function parameters passed
> while reading TCB fields and completing cached SRQ buffers.
> 
> Fixes: 11a27e2121a5 ("iw_cxgb4: complete the cached SRQ buffers")
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
> changelog:
> v1: updated commit description
> ---
>  drivers/infiniband/hw/cxgb4/cm.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Applied to for-rc, thanks

Jason
