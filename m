Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0C147F0C1
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Dec 2021 20:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhLXT3t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Dec 2021 14:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239476AbhLXT3t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Dec 2021 14:29:49 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D0BC061757
        for <linux-rdma@vger.kernel.org>; Fri, 24 Dec 2021 11:29:49 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id u21so1752434oie.10
        for <linux-rdma@vger.kernel.org>; Fri, 24 Dec 2021 11:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=pmxP2/qrZkVHg6/QGyFkWOUawcm1A3P+O1yJD3YSCL0=;
        b=DxdEZn0l9y30/cvNVXWqO8c+ucT+2Fq9QZ+RJfs0pNMLG/Dipjkvg9QNmt/Y2Dk1E7
         7cUoFJf7pdQgoI/gHDaTC0/nfJFRh2yNvQC76tnXEbUQ9tIhF24jshLAAMamdTjbkgtH
         RtXjDrLM2tAg7JL2YqK1TRISIy4reRTely8MJ8ioNzA4SdYx+IsOZxGZMYxRCTyTOlPE
         LqTWArdbOa5EAuhMIAOxV404G93dW82SXbyubqHGt3WEam6nBqVvPQ2mDUx2HM5jJ2N9
         /UFw9doWsgaqjO5Q90Nt+Wsolgv50k1y9akIx+9LlY1TUiTiujYiwUGTTqK5YcR9V1Ca
         I6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=pmxP2/qrZkVHg6/QGyFkWOUawcm1A3P+O1yJD3YSCL0=;
        b=SJdK+f9pPPHp1JWu+02POaF1L9sWb4sbE9khv/4uw4bXrjep6kzQEMPsRZp9YQinIp
         dpwS5vFeizmjihZInorgZR317YmGiil+6WiqUJKv8+gcoTrMHR14/dA26EyX7m9tqgYq
         vUE1JhSZoTSqyh3GNoU3Y4MgA8FBXRN2tseZ7udp/u+4aVkx52gp3PjjClMJuyo7ukVe
         cwwGAFuPGfSW0iTlRhWKO3NXkCOY8JyVcOOcTwQid8Ac6BGdUNE5NaeJ3DI8xa2o2XOO
         SA3A0toBLPVrKztWY0TiRTo2LBCLHasIymCP6IKnO8udaJwkHLDSakAnI8ReriKGIQ6C
         KDnQ==
X-Gm-Message-State: AOAM53261qlpoBdYG5KNJnHnF9LApUj9Af4XypilT8OvrpkjHP4roC9v
        h+RclLakmfjYlSE8XSowYrg=
X-Google-Smtp-Source: ABdhPJzcEWT6C704Hf8hzBOpkUkg96WEXpI4pJzP6Fyadlf062RZyRRDPFoUJZkHpHfjXik7MPGIrw==
X-Received: by 2002:aca:b68a:: with SMTP id g132mr6093310oif.139.1640374188739;
        Fri, 24 Dec 2021 11:29:48 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:e07d:a822:bfa3:e780? (2603-8081-140c-1a00-e07d-a822-bfa3-e780.res6.spectrum.com. [2603:8081:140c:1a00:e07d:a822:bfa3:e780])
        by smtp.gmail.com with ESMTPSA id h14sm1088075ots.48.2021.12.24.11.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Dec 2021 11:29:48 -0800 (PST)
Message-ID: <603b0e9d-f64a-ed1e-ac42-c2dbaa0e853a@gmail.com>
Date:   Fri, 24 Dec 2021 13:29:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-US
To:     lizhijian@cn.fujitsu.com, Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: double free of map set
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Somehow I lost the email so you could resend it that would help.

Thanks. Good catch. I think there is a cleaner and simpler way to fix this. All the errors occur when there is a failure in setting up new MRs which first try to delete the already allocated memory and then drop the object which cleans it up again. It would be simpler to just return an error and not call rxe_mr_free_map_set(). Then the error will lead to rxe_mr_cleanup() which will delete the memory just once.

Bob
