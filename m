Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E387D7A8D2E
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 21:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjITTyv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 15:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjITTyu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 15:54:50 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355BFA3
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 12:54:45 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a9b41ffe12so128839b6e.3
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 12:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695239684; x=1695844484; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ci4+OnryO0OuFq1CkcZHJGjm1qollh7HtQW5UGfE1VA=;
        b=A9ZmOMUDmbn2FTCYE7jwxkjOQaiOG0RMy1bBmJ43Nv5VBKdBvqOx/J1yrfh4aFdJfl
         GucYmPK7gN1SHz7m2TF2kTnNnezCHz+QBa1y0IrYwvOPQEsw/UgeuBIbQvD0qQurvcNc
         RQo7XIqCDyduQauo6xj9jrl2FU10o212bhMdrTV+jm9rw7ni0ldF9/7cbEuLgKGWAu1+
         5Mjv5dwVez7ioQZuG0eCSEalw0TWU/aIB5Pk1ysGW6QriKHKEs9SpFbvprbJciLwKQZ9
         SEcInjtBJcAvZfmEJ+E7Y8Hds5N80a2kq2LKSOmZ/djx4maO0A/VuBNTfvpX+eSTha6b
         Agbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695239684; x=1695844484;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ci4+OnryO0OuFq1CkcZHJGjm1qollh7HtQW5UGfE1VA=;
        b=ApTsxMMepkohun+s97RsxA7PCoGvKj0YW2uOtcRorgX1F8hApIONZWSBBduxEKK1wE
         sESxsEgusMGRO4wwf6chqU7qx+SPTZqBTCxV7/FVN4bLCAL1uRUTeyCXZPjwk4fVh1KE
         OfktSP63KEDH2ybV4zAR70daZQShffv2iNR/hMpgQRh1tVfKOAuKZuHJ7waLn9/s/8CN
         FCFiPIM6OGk5Bco2cWd83pcBIKyiUjiCBuDArRPL5ZgQ5UzQIm7OTgREeUqY1dO/zElq
         UyvuThfDUH5twSJpb62O1grg7QxKw+q5j7cr86G8uAvjP/stEzrCZY6EM3NCAE6xlxxH
         seBQ==
X-Gm-Message-State: AOJu0Yy27UTAIFNZ2A9pRWQbIrjA+BgHqcvmGXxCop9Mge+C/mDKhYl9
        EzL5Qv7tFO8wmLZucwX91LCKksAX4ug=
X-Google-Smtp-Source: AGHT+IH9BLAR5j+fVSg0wftmAI8UBclAPBiCihFQVgrWjfwKcXrP0ZVK4yI4wrhnOIPxIq204FpeWQ==
X-Received: by 2002:a05:6808:1489:b0:3a9:ed67:5220 with SMTP id e9-20020a056808148900b003a9ed675220mr4216358oiw.24.1695239684417;
        Wed, 20 Sep 2023 12:54:44 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:89bf:743f:97e9:3575? (2603-8081-1405-679b-89bf-743f-97e9-3575.res6.spectrum.com. [2603:8081:1405:679b:89bf:743f:97e9:3575])
        by smtp.gmail.com with ESMTPSA id i18-20020a056808031200b003a88a9af01esm6165794oie.49.2023.09.20.12.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 12:54:43 -0700 (PDT)
Message-ID: <acaf78ec-9c88-572e-9c65-29606f5a895d@gmail.com>
Date:   Wed, 20 Sep 2023 14:54:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: help with performance loss question
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Jason,

I am trying to figure out what caused a big drop in performance in the rxe driver between
v6.5-rc5 and v6.5-rc6. The maximum performance for 'ib_send_bw -F -a' in local loopback mode
dropped from about 1.9GB/sec to 1.1GB/sec between these two tags. I have also measured the performance
of a 6.5 kernel with the 6.4 rxe driver and 6.4 infiniband/core drivers and that also shows the lower
performance so it is not something in the rdma subsystem. (In fact there were no changes in the rxe
driver from 6.5-rc5 to 6.5-rc6.)

If I type 'git log --oneline v6.5-rc6 ^v6.5-rc5' I get about 360 lines but many of them are merge sets
that can contain many patches. Is there a way to list all the patches contained between these two
tags?

Thanks,

Bob
