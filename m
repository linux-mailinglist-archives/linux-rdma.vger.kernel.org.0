Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6217D281DB5
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 23:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgJBVeZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Oct 2020 17:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJBVeY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Oct 2020 17:34:24 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32F8C0613D0
        for <linux-rdma@vger.kernel.org>; Fri,  2 Oct 2020 14:34:24 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id a2so2811956otr.11
        for <linux-rdma@vger.kernel.org>; Fri, 02 Oct 2020 14:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=NRExhTZbgeBLj7a+OLqwqC3KddTzhzOSyzJyb5aSV/M=;
        b=RkZkmklmEjfFf4mNKbrCo8JLOD6UUWx8cLKjpoYM0V4zu0VUJ4BHUB6DmUlwrode8I
         pwXYx438uIa6LqWoP3/ZDLjagRJuMCHUCvkj19NC9iUege55vwsBGpYAEhL9SxQWbfnX
         q6OzQtMsYHK7dCTCcFH1HAhv/BadYqKu7aMMhNpX20SidLBN/TvqAz+w1F8Y2nr4W1MJ
         2cjP7yGYlQYgUvJF+FjVW77mgsoRs3Mq/0/qDN/2mFWNZQ7uYVKt4KlfZnr7dneGt1aR
         pfP8ZSTh6GdJ9xtcELkECC5YZPKVU9/Hdu+VmpxPPUiwnAG3ZYDw+YIYehFMJuZA7yEm
         GBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=NRExhTZbgeBLj7a+OLqwqC3KddTzhzOSyzJyb5aSV/M=;
        b=b9pDwD4dhNDm4kSe7Wr4/W0H57eu7y//zw6Ml+l6EYNCAM06Mf9wrxJwUIOu3BZUBR
         6abT21AdRTMfpVLWeBhBfxRIykmqUk9bSYGmpPFKA50tA2HZXhpueWdqNlT3mmm+NAEL
         3NyWurFl13aTNno02MVUe+UajRXHMPhVklKOLMXmJUa4FCfNL6dcG7GhV5YOGKmhQ332
         GWa1XD3Yi95EnaGtBylLq3ZFBlcVnuOxL7RQB5SS+tKsyH+PXMaZm0xCnkl2summMxP/
         DIwvJqFewxwBpQaZQFZ82p+CO0PheOmsr1ScPf+yJafekW8k8OVOlL06W5gMQsCncepl
         DJxw==
X-Gm-Message-State: AOAM533N6LDNoZv35xf6KKIl20FNOpH2XcTXHc3Nie07saosNzBQMp4+
        qr1puLvT/gkkMjyhyrlvZQM=
X-Google-Smtp-Source: ABdhPJwRwyWLG9gL/Rm4nr4lsuGmGqhYUlg7SoHuv6zNim/15w3NnRt1mhV3U8pgpkFYYc8kp4KE2Q==
X-Received: by 2002:a9d:6349:: with SMTP id y9mr3030699otk.246.1601674463662;
        Fri, 02 Oct 2020 14:34:23 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:854e:2d13:6043:4f5a? ([2605:6000:8b03:f000:854e:2d13:6043:4f5a])
        by smtp.gmail.com with ESMTPSA id h14sm672974otr.21.2020.10.02.14.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 14:34:23 -0700 (PDT)
To:     Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leon@kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: py verbs tests
Message-ID: <1c6511ba-e92e-c285-e00d-f2dba04a6747@gmail.com>
Date:   Fri, 2 Oct 2020 16:34:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I am currently trying to figure out why one of the pyverbs tests is failing.

I added a check implementing C9-205 (p 419) of the IBA spec. I requires that a responder receiving a packet longer
than the receive buffer or the PMTU shall be silently dropped. I.e. a class D error.

    C9-205: Before executing the request, the responder shall validate the
    Packet Length field of the LRH and the PadCnt of the BTH as described
    in 9.8.3.2.2: Responder - Length Validation.
    The following characteristics shall be validated:
    • The Length fields shall be checked to confirm that there is sufficient
    space available in the receive buffer specified by the receive WQE.
    • The packet payload length must be between zero and PMTU bytes
    inclusive in size.
    If a packet is detected with an invalid length, the request shall be an invalid
    request and it shall be silently dropped by the responder as specified in
    Section 9.9.3 Responder Side Behavior on page 435. The responder then
    waits for a new request packet.

tests/test_cq_events.py passes PATH_MTU = 1024 in the modify QPs verb for RC and XRC but not UD.
This should be a required parameter as part of the primary destination address but is not getting
set for UD. The test then proceeds to send a 1024 byte payload to the destination and for UD hangs
waiting for the completion.

I don't want to mess with these tests because I am a poor python coder. Is there some reason why it is
OK to not set the PMTU for UD QPs?

Bob
