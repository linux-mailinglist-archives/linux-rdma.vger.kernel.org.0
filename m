Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C103CF47A
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 08:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbhGTFqx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 01:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbhGTFqv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jul 2021 01:46:51 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6D8C061574
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jul 2021 23:27:30 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so20610589otp.8
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jul 2021 23:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vyGfiuIkHxNKIbvwnTryZcN+4bz2j6BgQ2g3jRz6rOU=;
        b=OaNU+jXYFAnKUhzzNvrqBX3hf2L27QBfih4tHaiSzOB/W/sRMyam8K+6HvYKNwv6BJ
         X7PALrAKAAgXT5nTOJlUjyNmUraWCMg/hFO164JYfoj5TkAdlfcRZmr7PR3dIHCZNE0m
         SP1a2cnGM4ZiOd+w66qphUhDYf28q7VhffMo+f7lyp3qQHmr9BokA9wdbi6IaNtlV2GT
         Mwq4VCnamtZ/9UEPZ6O/zEZmuERYKljrwrBrX76h4klpm9YY8UdCZm4BqBqX0DT+vf7Z
         skKr4PG1ynfowDdKGN0njotNVBifSCMX/2UVBnBgExvceXBA1R+gn7wvikA5pHghB2qm
         s5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vyGfiuIkHxNKIbvwnTryZcN+4bz2j6BgQ2g3jRz6rOU=;
        b=S6qWeugqa98PrW9BRVDstG3/7c1UIWnZEbwSfTp0Pb11nLntwxra42kPF25Jqs4fG8
         FxIKd2tFeFWS/dBuSBxNsyr0gJWLOZhCSEx5XAX+SWVG0WaK1Uoeq3OgQS3MwAxrlz2N
         jzLhIUErDwKy5OuUDWl7yeD3RrpdsrNQKyRSoWQS2T7p/eu0qhbuJ0YSc7ovdOljwPk6
         M8uSZW3dAL3SB+1uDPD4NNh0FoWln+jg2/UzcF9D6VTupxB1uebC8serfxdQqYbQRZda
         RWzvO8ouRvo8I3W+De8IJruvKr54tiScrwZ+Em9d+1j6cKXFEFJ6LZ6fUkZvUso++mUC
         hvcw==
X-Gm-Message-State: AOAM53268U/M8uZ1h5fhfoFPEQ5kwd1OyD6i9bavaL6uFO8jHSumQ06/
        P7p3zAHmHdt8eFhQl1flB2Pw8jQZvXk=
X-Google-Smtp-Source: ABdhPJzqpYaeo+zJz9+CoFnXEYbt0UgWuCj3tET8i1WbXSjDoXxZMY3c97bZygaItNTXfhe6dlNITw==
X-Received: by 2002:a9d:61d9:: with SMTP id h25mr17432397otk.81.1626762449359;
        Mon, 19 Jul 2021 23:27:29 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:7a29:439f:8db2:5b76? (2603-8081-140c-1a00-7a29-439f-8db2-5b76.res6.spectrum.com. [2603:8081:140c:1a00:7a29:439f:8db2:5b76])
        by smtp.gmail.com with ESMTPSA id m4sm336117oou.0.2021.07.19.23.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 23:27:28 -0700 (PDT)
Subject: Re: RDMA/rxe is broken (impacting running NFSoRDMA over softRoCE)
To:     Olga Kornievskaia <aglo@umich.edu>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <CAN-5tyGbmTjiT+nxXB7BMp6mwpUs+HVUGy-CGXBBrC04jQ3grA@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <63d7f374-1252-82c8-769d-2d1a540466fd@gmail.com>
Date:   Tue, 20 Jul 2021 01:27:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAN-5tyGbmTjiT+nxXB7BMp6mwpUs+HVUGy-CGXBBrC04jQ3grA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/19/21 10:46 PM, Olga Kornievskaia wrote:
> Hello,
> 
> I would like to report that the rxe driver got broken some time
> between 5.13 and 5.14-rc1 (so basically the last git pull). It's not
> just NFSoRDMA but simple rping doesn't work. I believe I found the
> problematic commit: 5bcf5a59c41e19141783c7305d420a5e36c937b2
> "RDMA/rxe: Protext kernel index from user space"
> 
> Server side logs: "rdma_rxe: bad ICRC from <>".
> 
Thanks. That is helpful. Will try to find it.
