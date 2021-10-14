Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5DF42DD2C
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Oct 2021 17:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbhJNPEx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Oct 2021 11:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbhJNPDZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Oct 2021 11:03:25 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA427C0613A0
        for <linux-rdma@vger.kernel.org>; Thu, 14 Oct 2021 07:57:10 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so8575630ote.8
        for <linux-rdma@vger.kernel.org>; Thu, 14 Oct 2021 07:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=pMEg5QJtmTOLqBQZmt+O27sajJ3GZ9KRGQJYCVgA0/g=;
        b=pgK2M58thof7zccYmpt4jrx075imKBU26b8BYkMI/+UQRhaXXu1Sc7UgKJf+6j0efj
         K4OnU7agmw6DyRiAmoelV2lWPknpmMOGgdzCo+8A0bF3iSKOB5/AnVPhC3bcdWum32Hw
         JPavXDPAUCRbNK4PXnxiGwWdCF4YsNswenc6tHyM0KKQyBq7QramjiWTYEzknLYff6vy
         EuvyzpLfHSoFI2EoWVkazgDLg9/xHLKY3DPcJ7DcVMnvyzxbcfu2s2vm+pRPJ2RHSWTN
         X4zGlqdt/d4WGbuP5AHrzoXd9rHmKEeBqQAuPJn6V/MMi2bHUUvoKphXeIs57Zt2Mpuq
         M9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=pMEg5QJtmTOLqBQZmt+O27sajJ3GZ9KRGQJYCVgA0/g=;
        b=N/JAAOQWdf1Y6+etkm/Tv6+lNc6KZDC63fnQFPtzl3O+HzE4sG+ghbSh8To8lmWUQc
         Cy1DHf9EFCEUAgEA6UYFMosIClhNq7sqn8Fz4LToJgKktyubLwEFIpXdtCDupH4Ks36y
         dqr4xx7kDzpiZDZHtqXb2fvrOjE6CGtLwPy4PzvnLs7YQ25e0DF8okFCdgw9oG90Rhek
         zPrgBduQi6olE/TTY3mCmk3C55Q60ljI7e/e4mvIpAj6Z8ILQY7L29rF/N4lNaXxyNjQ
         m2XMZrgymUsns6fEIF+klMu4Ny0910PkmgEMyszEw/21kvH/+hKjf/3RaI20vtaixWDs
         +/hQ==
X-Gm-Message-State: AOAM533/bxLMVS3SqnHw9Cm2CbsNYEgdwNjtNCst8nU1RtutV2Isf/Vw
        4u4xnd8wkmM2r8rJFdXTb11PM5dc73A=
X-Google-Smtp-Source: ABdhPJyfuwQg7LYzHsjepwHonON5Tu3lG4F3+XdxXjh33PdFnF2z8cTCIYeFehm0muX+Z9ksGo/z0g==
X-Received: by 2002:a9d:6109:: with SMTP id i9mr2951851otj.45.1634223428336;
        Thu, 14 Oct 2021 07:57:08 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:487b:eaab:6345:1a9? (2603-8081-140c-1a00-487b-eaab-6345-01a9.res6.spectrum.com. [2603:8081:140c:1a00:487b:eaab:6345:1a9])
        by smtp.gmail.com with ESMTPSA id k5sm477032ood.33.2021.10.14.07.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 07:57:08 -0700 (PDT)
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: Bad behavior by rdma-core ?
Message-ID: <414e99de-9b1b-edcc-4547-f8002adecd69@gmail.com>
Date:   Thu, 14 Oct 2021 09:57:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I have been chasing a bug in the rxe driver seen in the python tests (test_cq_events_ud).
The following occurs

	The first time I execute this test it creates two AHs which are allocated by
	rdma-core and passed to rxe_create_ah. The test attempts to destroy them
	(i.e. rxe_destroy_ah is called in the provider driver) but rdma-core does not
	destroy them (i.e. rxe_destroy_ah is not called in the kernel).

	The rxe driver saves the AV state and some metadata for these AHs and keeps it
	since it thinks they are still active.

	The second or third time I execute this test two new AHs are created by
	rxe_create_ah but the memory passed in from rdma-core is the same as the first
	test. I.e. it has recycled them but they are still active in the driver so
	the result is chaos.

Somehow rdma-core thinks it has destroyed the AHs but it does not call down to the
driver. This only occurs for AHs AFAIK.

Bob 
