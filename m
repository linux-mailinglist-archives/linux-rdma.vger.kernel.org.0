Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA9D532DA0
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 17:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbiEXPgP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 11:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239004AbiEXPgF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 11:36:05 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D09B315
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 08:36:02 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id b200so6324671qkc.7
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 08:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cPQAjM1m9akK4S/p/8R8csriFuLb7VstisXFAwUzXYo=;
        b=nCLgI1Z7r2MYelWfBJ6/7NIKa0r3n3l4bq/XPb0mTEaw9SG3TLOCPcUI3x+RCvjFLy
         B0U+Mg5KS+K++CgUTx1f4YzjqKm95xixRDoxqG7E+1sK9n1uwV5ewXlMoV/E0BxJVJ4g
         bvPae0UDCBQB1GnvoGEmJahCwcfIBbEHoqWZZGTuRR6nsXcMsalmhPg561vZ984AlqWt
         QkkaaAO6/y0ZupUW4tk9F7I4IUo2wcoO3x0NbuqPlDX7Ni2qu52IV/DCLa3jW4dETq+k
         RNUT9SBNmsbopNNm7xxH6duIaW7IX6m8Wp0c1WMcJeNXuVYb0VFgbB9hDXSyj0v0XcXx
         PYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cPQAjM1m9akK4S/p/8R8csriFuLb7VstisXFAwUzXYo=;
        b=OlWJZD3tuAIT6sUCPeV9fQVfO/3njNDTh+VxkP0x9CEK4yEBxtOYKAd8f9IfWHFw8g
         ngstKx4QYIB8J0cL+QCYnbsq5BYEIokuZNP7FlnR6BKTRyr1SZQvzp5u2AtFfbk+Y3+t
         NRx3yNU3/oNZ8pPhFHVne+GGg3mLNyr3Roa7lKaSG6djiuDy9WEXKhwuSQQ1w6lK4l3i
         PW82fyUR7pdT3FGbL7+3KiazECxQmH6GomKz1s4L2jZT7uvPsCfvYdQhwAZxNkRK5C16
         P2+PobTpdfVb2P6Z/M5Exoha0LyzhI+oJOZld6hJ5ZBy/MqGoPioUX0r6mLtizWHfO9A
         J1yQ==
X-Gm-Message-State: AOAM530tiumjw8yzwDxIrCKL4sRlOhLKoYQm0BT3zQhMzK82G3wijAB/
        Op6t0KEUxqILZXUzuodwVIHeRg==
X-Google-Smtp-Source: ABdhPJy2kN6jMzJ8FabEKdoZ5b3xGnUcC8YHL7qwvQqgMAn+1+twTSuVYplEAcIVesviGhNnLk+iVg==
X-Received: by 2002:a05:620a:3714:b0:6a5:564b:222f with SMTP id de20-20020a05620a371400b006a5564b222fmr3156277qkb.648.1653406561417;
        Tue, 24 May 2022 08:36:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id k12-20020a05620a138c00b0069fcc501851sm6072009qki.78.2022.05.24.08.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 08:36:00 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1ntWZk-00BGBD-7b; Tue, 24 May 2022 12:36:00 -0300
Date:   Tue, 24 May 2022 12:36:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: Initialize struct members in
 irdma_reg_user_mr()
Message-ID: <20220524153600.GB2661880@ziepe.ca>
References: <Yoz4iXtRJ8jw6IeD@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yoz4iXtRJ8jw6IeD@kili>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 24, 2022 at 06:23:53PM +0300, Dan Carpenter wrote:
> The ib_copy_from_udata() function does not always initialize the whole
> struct.  It depends on the value of udata->inlen.  So initialize it to
> zero at the start.
> 
> Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> What I know is that RDMA takes fast paths very seriously.
> 
> This is probably a fast path so you may want to implement a different
> solution.  If you want to do something else then, just feel free to do
> that and give me a Reported-by tag.

This isn't fast path..

But the bug here is not validating inlen properly and should be fixed
there, not by zero-initing and allowing userspace to pass in an
invalid inlen..

Jason
