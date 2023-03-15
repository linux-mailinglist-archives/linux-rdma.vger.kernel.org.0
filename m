Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C07E6BBF80
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Mar 2023 22:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjCOV4P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Mar 2023 17:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjCOV4O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Mar 2023 17:56:14 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A0187A3A
        for <linux-rdma@vger.kernel.org>; Wed, 15 Mar 2023 14:56:14 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-17ab3a48158so74792fac.1
        for <linux-rdma@vger.kernel.org>; Wed, 15 Mar 2023 14:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678917373;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qm7eiU769IJlzo5e/+6TU1okapKn04Ea2cLkMmlPEBk=;
        b=D4HzQ3JA0MRyO0N4n7So1pUURVbMjpt2lvlNLIc5P5z/s8vFNmvcKdeR8DCLrW9EM2
         cEYszaw3yzpPoWu7U76LbtEBaJ5+pfjoeckdlx6qICJGlxWWhMqrE2M7UuBQpQuJmJ/C
         m1MQ3nKqaJgaGHqzDnEMPipwirl9Pc9drBTvja578aAJ00tBvV4X9m4zBk/NqORUGKp/
         YbRLRVvryASf2ybJI2HNB0ytpYVGk3L1QZr/JONBLSU4lfrxRLptQAtOcC90mI2zfuYQ
         Ps2YvZHnOsY2ucxR6oCb8Ahoosb1AW2v63wLPLSgtpQcgaI/SJOTFfOwNJyzTT8/eDU+
         Nq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678917373;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qm7eiU769IJlzo5e/+6TU1okapKn04Ea2cLkMmlPEBk=;
        b=TGTwSueINvkCfi2dpuZRRGqjGOOu+i6gHL/HpAzoLQpj6ixxxxd0VHvbfUGe/wAZ0o
         8cbFQBQvVvGUD4Ips2CrwTulOaHLyR0ebkC7L/ejEpPdpyuFtNOnURiYNBgaupDPjeCS
         3tjGwgvm1+EnDkuXsocEzZN0N5lIfqOGN4R6rsSWxHe0VYtkmujvYjdShR7AKgpke0eb
         LueSqA5DLocL6ymaVVHFPmdx7AYRXEwHjYDDFOTp+UAc5yQ0kTKSb0ynUrmqx6/XJ5gK
         9XBKg/EDY7PmpGkL9yhTZck0dCnDWbsPGYPhF51rShu70dJBhjQCN97FVz2LChb74voU
         563g==
X-Gm-Message-State: AO0yUKUJNyb+vJltN/B96zLQGRB4tMhi4uTC4QGFGwTB/vUVABTzpOiz
        QZE5fcLBPgeM6ytVqKgccK4=
X-Google-Smtp-Source: AK7set8LXTvHsiCJt/iK3BAlHpIxbLyTGB7Nj6FmG8phOXnr7AvVHZq6hz5Am5wnUmlSPiEcAlBFTQ==
X-Received: by 2002:a05:6870:c690:b0:177:b240:1a01 with SMTP id cv16-20020a056870c69000b00177b2401a01mr7335336oab.25.1678917373380;
        Wed, 15 Mar 2023 14:56:13 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:ebd0:e160:a3dd:fe9a? (2603-8081-140c-1a00-ebd0-e160-a3dd-fe9a.res6.spectrum.com. [2603:8081:140c:1a00:ebd0:e160:a3dd:fe9a])
        by smtp.gmail.com with ESMTPSA id bl18-20020a056808309200b0037d74967ef6sm471982oib.44.2023.03.15.14.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 14:56:12 -0700 (PDT)
Message-ID: <d61963cf-77ef-ef0a-8c94-2de89cb6a5a6@gmail.com>
Date:   Wed, 15 Mar 2023 16:56:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: question about the completion tasklet in the rxe driver
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

I have a goal of trying to get rid of all the tasklets in the rxe driver and with the replacement of the
three QP tasklets by workqueues the only remaining one is the tasklet that defers the CQ completion
handler. This has been in there since the driver went upstream so the history of why it is there is lost.

I notice that the mlx5 driver does have a deferral mechanism for the completion handler but the siw driver
does not. I really do not see what advantage, if any, this has for the rxe driver. Perhaps there is some
reason it shouldn't run in hard interrupt context but the CQ tasklet is a soft interrupt so the completion
handler can't sleep anyway.

As an experiment I removed the CQ tasklet in the rxe driver and it runs fine. In fact the performance is
slightly better with the completion handler called inline rather than deferred to another tasklet.
If we can eliminate this there won't be anymore tasklets in the rxe driver.

Does anyone know why the tasklet was put in in the first place?

Thanks,

Bob
