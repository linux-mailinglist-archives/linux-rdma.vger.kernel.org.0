Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0033B3BDF
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 06:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhFYFBh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 01:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhFYFBg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Jun 2021 01:01:36 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982ADC061574
        for <linux-rdma@vger.kernel.org>; Thu, 24 Jun 2021 21:59:16 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id n99-20020a9d206c0000b029045d4f996e62so8110771ota.4
        for <linux-rdma@vger.kernel.org>; Thu, 24 Jun 2021 21:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=yMPlp3EcUErDQMNPNpOPbkNpOBX/mQC7UzklYdEHx0Q=;
        b=jd4X4e1XYbRWmxJwnf5F+7qOV1bRBwE+olx/UMy9NKbuGU0vTNAt9DPw2DkgMfeGJd
         tXI3xqxIKJlME8R457STSXXljEcfLt5PFxQRD73oTA0MdEwvOP2S8nlvFajiXCIRmRyZ
         PPIMQ5sR0sCo3kmz/2zhz+CSYQfRYiZbPCMaE3yZy0yT7aWnus9UcsGR0ufDNSP/9Vrn
         14A3PH10FbEP9sAKdCQzfRUnZXjMmYjB3LKjeElzD0l06xWC6hEjYl7uKQ8iwEQDiX8L
         DyZfQCjXJwZucqUkQCasApEmx2lBceMe5fTaHGHK8+4S32ouwoocnkwd91XjX5SGBhRk
         hOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=yMPlp3EcUErDQMNPNpOPbkNpOBX/mQC7UzklYdEHx0Q=;
        b=unWSf729re/IUy0jya6SwNDCy3LOUaUFXHe1ohmh381/9fSR57epB0nczW80ibDJDZ
         f6L4ZZRJaPJ+/ZKLYWzqccPWuUoN72qsgV4r9pQaWvSIIjvQVtBJpMYG53fLYTXHjqrN
         9rREYpXGXZ9VxHVzZiv2w5dsQgkx0ZgjYnH9ie5z8cWa/OCroHTEzPvJRj0+Pt3+6vzH
         7n/rnP79yP9UOhoQF3TedSeNMXzS+TNBe+RFDQpN3vMfJL4t9ySpe0q+C3Sqg7YhxyGe
         F4P+z7DpDLPilvnkTY/443fNawWg807xXWIVrhZXFiBNUFsIx9aUqiCmFrpH6nuNCeRw
         3ZAw==
X-Gm-Message-State: AOAM533ASKKjgrTnSseoTK1aMqZb3hwlNEyCLQwR3TtegFWSz79/Te0I
        Nl+nj0ApKUEIUC9Fi//kaK50dRPPULI=
X-Google-Smtp-Source: ABdhPJz4qisVfxC3z6wnF+/UKdovfRdF0IlA3VjzuP52ePEWwadeS1y5SMURFotDssYN8+p5LA6iMw==
X-Received: by 2002:a9d:39a4:: with SMTP id y33mr7969874otb.84.1624597155738;
        Thu, 24 Jun 2021 21:59:15 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:8bf2:41e6:f3a9:1be4? (2603-8081-140c-1a00-8bf2-41e6-f3a9-1be4.res6.spectrum.com. [2603:8081:140c:1a00:8bf2:41e6:f3a9:1be4])
        by smtp.gmail.com with ESMTPSA id k26sm587895ook.0.2021.06.24.21.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 21:59:15 -0700 (PDT)
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: rxe MW PR for rdma-core
Message-ID: <29c7ec8a-3190-cb75-855d-f8c9b483d896@gmail.com>
Date:   Thu, 24 Jun 2021 23:59:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It took a few hours but I finally managed to get rid of the merge commits in the rxe MW PR. It's back out there at github. I lost the name change Jason had made when I deleted and reforked my repo. I remade the update kernel headers commit without the ??. It still passes all the screening tests.

Regards,

Bob
