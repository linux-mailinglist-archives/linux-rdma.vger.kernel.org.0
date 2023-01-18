Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0916729C5
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jan 2023 21:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjARUyj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Jan 2023 15:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjARUyi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Jan 2023 15:54:38 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC1D4C11
        for <linux-rdma@vger.kernel.org>; Wed, 18 Jan 2023 12:54:36 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id g68so24363906pgc.11
        for <linux-rdma@vger.kernel.org>; Wed, 18 Jan 2023 12:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=38Ab1ydOxWFoCnQ1hn18tsTd/nLpjWDkMcuz9LcJhgc=;
        b=QcyKTP98pIj4xoEtMVaGgqSYkQu19v4GHm3EeHftxsvlz9FraAkTB6wZdkfNGVLtGd
         ugvtfy72K2zx1HqIbEIzd0CmgQjHeKQaFTLcEiTde2MxVGAPLpBkuXs9i+TD+Oery4rr
         M5Ee7c3RrmztbjIZM61dd1PYrXAP3IddNfsT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38Ab1ydOxWFoCnQ1hn18tsTd/nLpjWDkMcuz9LcJhgc=;
        b=qNYNnWUCwrID9qT7ybUijOlXD5dBDzzi6iyYTcBnPWTro8b48N1i8zCoBStuf7Vst1
         ASZBzVLB+OWif+pGaPOclzgVSwEmHEVFxxaqHBWPHc0q17Gp/fbCozkF1DMj7bvyzKwn
         ouUFAQsWeqMjLvb7JstDDjpoLu8F6xoOHxm3L3TeROMsiNpwPga+CxNihiO3OGPtHsKQ
         6Qv2X2Z3NmZ7DQGpvcD7kGJgj3vcPG/lmp/vifpJaEbQPX5uk+CpNeVOMeKTe2FttULF
         26sn9nLsxQWVmn1J1Cb0/Lj6xOxi9qM3+BPRrV5cYHV/Mcj9El1HMdgS/uCkBfPuu1aI
         f7KA==
X-Gm-Message-State: AFqh2krs42+hsE3KYlSfc1AtXG2MkQE0nMIZaWXBmRj0qAWVTNar7Bxz
        knbPMiSGjg84upZbWNGM32hDjg==
X-Google-Smtp-Source: AMrXdXuiNSgEY7oHvEwxaIEKfBUrMnTDuVqSiNAxvJGyyZSQNRNFIyO+qQS75b9JhsA6buYwmwliog==
X-Received: by 2002:a05:6a00:4289:b0:583:319a:4425 with SMTP id bx9-20020a056a00428900b00583319a4425mr8760833pfb.29.1674075276168;
        Wed, 18 Jan 2023 12:54:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 66-20020a620645000000b00581172f7456sm5101790pfg.56.2023.01.18.12.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:54:35 -0800 (PST)
Date:   Wed, 18 Jan 2023 12:54:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     caizp2008 <caizp2008@163.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Yupeng Li <liyupeng@zbhlos.com>,
        tariqt@nvidia.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH 1/1] net/mlx4: Fix build error use array_size()
 helper in copy_to_user()
Message-ID: <202301181253.B19EE86@keescook>
References: <20230107072725.673064-1-liyupeng@zbhlos.com>
 <Y7wb1hCpJiGEdbav@ziepe.ca>
 <202301131039.7354AD35CF@keescook>
 <202301131453.D93C967D4@keescook>
 <11689498.158e.185b5471bad.Coremail.caizp2008@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11689498.158e.185b5471bad.Coremail.caizp2008@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 15, 2023 at 07:53:34PM +0800, caizp2008 wrote:
> my kernel config is config-mlx4-error.

Where can I find this config?

-- 
Kees Cook
