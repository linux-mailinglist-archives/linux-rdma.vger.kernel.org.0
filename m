Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E658E3FF5BC
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 23:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347069AbhIBVmQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 17:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347065AbhIBVmQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Sep 2021 17:42:16 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF64C061575
        for <linux-rdma@vger.kernel.org>; Thu,  2 Sep 2021 14:41:17 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id g4-20020a4ab044000000b002900bf3b03fso989320oon.1
        for <linux-rdma@vger.kernel.org>; Thu, 02 Sep 2021 14:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=cx4qVIqAIUlKi2nKucEur7d6HYlykzwuplF2bqq/RfM=;
        b=MmizLW7gczE1l+FV92TldCt/o1CyvPdI9P3A/MT7Pgt1UBlZng7PIfs8JI8e58pgKh
         CSabWLg0m1crqo9DqRvzZYsXx/OjFP223G8FsHwUneG5HecWX5DhbhWA88SBB55yQVmI
         LXMbJHxWY88r+M1mMVQMS76hUjJafeuQZopQ3a+O2MjR6sXetTl1VBQ2gwf6r2lcGDwZ
         U1SCIfPduR5ae1af9SMlNVgrF7TiaHwj3qVIln2ix/Oe/NzCMK96r8ba6HqFqUuLvXnt
         WaNgvLO6iV9fqGq7y9ZTMg0/jTI3yT2llkIPhHwu557FpmR2VkebY/1AqhsjdxlOhgun
         PkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=cx4qVIqAIUlKi2nKucEur7d6HYlykzwuplF2bqq/RfM=;
        b=YQJ/ad4PnVBrrAb7NGtoVFvqbpGX3w8zQT4oG8FVMjWhcNJCtowsqfvhAMB1wCiD4r
         E875TqA3YYa4E1i/H5CRseg4/wUGPORwuxIYOghkG4OgAZqkvu2TDzgLd+v1eefNTveJ
         Yy5obUvMQ3Pnzl68cZG84aPCTX1bAQtAEdUp4jx0vs8SrXnZWsZ2uW/+FXbREve6cFuO
         UCSge7lXCAGjneeThQ/pQgZbF1AdOrZcsUaXo8RGeioDAt0ti6ngzK8Ecwcc954drvmc
         xkj5xOgPPID6OdbHvq5ArmvjhsG1vuRyBbZAjSZfJe8Gz6/abBuXVL5p/TMyytFzSw4I
         AstA==
X-Gm-Message-State: AOAM532ao/1Sp2D8qskf/6NwfBxclXcs4YhDvW6vZSPI9NbFrLvPzoHW
        gqMN/G4sjvd7GIC4jKvIBXBy+zA/NWk=
X-Google-Smtp-Source: ABdhPJyCuouXvEplaGDbpILjRK4MRT8RMSSiemJEcBI54XX3HSt28weVE2u8gC4cWR3hiZ8qPHK4lg==
X-Received: by 2002:a4a:cb19:: with SMTP id r25mr211181ooq.39.1630618876469;
        Thu, 02 Sep 2021 14:41:16 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:4e8b:d9ac:5f99:519a? (2603-8081-140c-1a00-4e8b-d9ac-5f99-519a.res6.spectrum.com. [2603:8081:140c:1a00:4e8b:d9ac:5f99:519a])
        by smtp.gmail.com with ESMTPSA id u15sm658887oon.35.2021.09.02.14.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 14:41:16 -0700 (PDT)
To:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: blktest/rxe almost working
Message-ID: <c7557529-d07d-3e35-0f03-2bbe867af4a1@gmail.com>
Date:   Thu, 2 Sep 2021 16:41:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Now that for-next is on 5.14.0-rc6+ blktest srp/002 is very close to working for rxe but there is
still one error. After adding MW support I added a test to local invalidate to check and see if the l/rkey matched the key actually contained in the MR/MW when local invalidate is called. This is failing
for srp/002 with the key portion of the rkey off by one. Looking at ib_srp.c I see code that does in fact
increment the rkey by one and also has code that posts a local invalidate. This was never checked before
and is now failing to match. If I mask off the key portion in the test the whole test case passes so
the other problems appear to have been fixed. If the increment and invalidate are out of sync this could
result in the error. I suspect this may be a bug in srp. Worst case I can remove this test but I would
rather not.

Bob
