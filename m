Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2532E3FE7F3
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 05:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhIBDX6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Sep 2021 23:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbhIBDX4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Sep 2021 23:23:56 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C60C061575
        for <linux-rdma@vger.kernel.org>; Wed,  1 Sep 2021 20:22:57 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id c79so834119oib.11
        for <linux-rdma@vger.kernel.org>; Wed, 01 Sep 2021 20:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wvFGg64Je451Je1jQyGRGjOCFcnujKDCItZ4iwxUjoY=;
        b=L1rpnqKvm6nfWkeR3kwTHMqWxLOeAwnBMPxaVDGeJhr3bDzC5fvNgTjPt2zGiaBTQb
         23lesIR61kmJ32WuP4I7n701bDkpypVimbCOEAkd5IWcbvwfScIpcHubQSLkRBj4DM9F
         9jJoEzldV3asRa45vfxPNa7S30c43/Ejx/2c07P1eOaf4Mp+7MLVh7vDwDjRKgB7tc0G
         p4PgOZZlXIOT2TramxFKXQjJ/OQGh8+0xISpDnpPUd2jEOdnn8Fz9UMbvdGFYwIFpvM/
         mDVVqiE5kIRSrHc2pllhYCboXrUY6BfM/LBxGqLXmKPDEDOlTo3SaTDryNWYdAQne9XZ
         C34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wvFGg64Je451Je1jQyGRGjOCFcnujKDCItZ4iwxUjoY=;
        b=ZlvNHcxZImM18ckKwKSaucAUCdSEhpCH+IvPQPCbGGOnvIW6kSqfXE9Cy8KrT/Vppq
         1v4QDyIplTQ6+IfFQqo4teS2unqQzwbRV1qraQr9vJxIvzwJ2C96aJ9Fz4sC4nGEiA3R
         nzkzC9KxyxoD7z1PuAcy07IT31KvxUG0j2yCfVXECjAT74TipppYBzykjGSe/A4kjpZS
         yLNFUbLgjsVEle0KSaZCUMeMp1UBcNSRKGaprsHxR8gXzhrDBroUPdM+Bp1Wh0CViRb5
         msoq6l8FeQFdw7q6T2e4PF4ajypELdOp2wIr1eWNoJQnpcsOtgEp7msDjdNUmssDAIlj
         3zfA==
X-Gm-Message-State: AOAM532porx8qGqpo5lvH8aZYL/U+bxr1w3nZsbxlkgsHKFW/7MAv0Ai
        E6jXSLRu5sxr5Top0S4XVDXtNOh91Qo=
X-Google-Smtp-Source: ABdhPJyoz1bdXXNfLCSjhk1KAYMPnAyZNQSVZpuT17/YrYouwjy++nfowdXhdebLhPkTa9jZ9ggOng==
X-Received: by 2002:aca:1219:: with SMTP id 25mr689940ois.28.1630552976894;
        Wed, 01 Sep 2021 20:22:56 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:fb7d:2886:9924:bae9? (2603-8081-140c-1a00-fb7d-2886-9924-bae9.res6.spectrum.com. [2603:8081:140c:1a00:fb7d:2886:9924:bae9])
        by smtp.gmail.com with ESMTPSA id 8sm166784oix.7.2021.09.01.20.22.56
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 20:22:56 -0700 (PDT)
Subject: Fwd: rdma link add NAME type rxe netdev IFACE stopped working
References: <f1c73298-b37f-8589-bdb1-a727c3b7c844@gmail.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Forwarded-Message-Id: <f1c73298-b37f-8589-bdb1-a727c3b7c844@gmail.com>
Message-ID: <fab27850-4a9e-7a79-4542-97cba2cbb8de@gmail.com>
Date:   Wed, 1 Sep 2021 22:22:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f1c73298-b37f-8589-bdb1-a727c3b7c844@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org




-------- Forwarded Message --------
Subject: rdma link add NAME type rxe netdev IFACE stopped working
Date: Wed, 1 Sep 2021 22:04:03 -0500
From: Bob Pearson <rpearsonhpe@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.linux.org

rdma link has started to fail today reporting an error as follows after working before.

bob@ubunto-21:~$ sudo rdma link add rxe0 type rxe netdev enp0s3

error: Invalid argument

bob@ubunto-21:

Nothing has changed in the past day or two except I pulled recent changes into rdma-core. This runs after
typing

export LD_LIBRARY_PATH=/home/bob/src/rdma-core/build/lib/:/usr/local/lib:/usr/lib

which is also the same. Any ideas?

Bob
