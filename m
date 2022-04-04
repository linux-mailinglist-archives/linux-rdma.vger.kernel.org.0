Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD704F1C1B
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Apr 2022 23:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379677AbiDDVUf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 17:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379919AbiDDSVU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 14:21:20 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAD922B20
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 11:19:23 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-dacc470e03so11671734fac.5
        for <linux-rdma@vger.kernel.org>; Mon, 04 Apr 2022 11:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=rrOVoPDYfRuQCDkCeN9VgrEu7W1kALsieWaIXnsf8l4=;
        b=OLshUOp/AVSlxGlGvke+jx8684Ffhj6K9j4dIyQBJg0ItjpIVBJdpKu/pzN665KLlS
         b5w1BdGczc9pgV1QmygA8GLMtzw6QVMC0EJ9DgImW98zLAlZKw9dl/XNMdpAwIhZnpSf
         BZv6bzjJePnWk9Uy2uotUhWaOqkyZCHQiBL7BBSzqy7U6Sng+TtravoJcPw0keBslHSL
         +KXOQBb1VyrEqFFJ7YLd6So0JhQbdb1sU+fzMHbw64P3aDjyX4CuT+IE3a7QSoNgs5Mk
         JxvpGYOC4CaD4xy+p2hgzErjGlecpnSY3aYic756uGV7JFndWcs3DdgkqBkgXxc7wH7P
         HdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=rrOVoPDYfRuQCDkCeN9VgrEu7W1kALsieWaIXnsf8l4=;
        b=1BLOPZxMXgsIrmmC631DWlGuFf4AOoCntvVXcozeFCFGWlN45lPRrcbZ751YbrbLC5
         RMyOExk5ELP8xosT4U2CfUnrAyJ1r2UtqNhJqmN0EvxZFoolfae1uOf0Sldm6gneVqVh
         xFzLuXEG4Fp+OtZfUIocYhtvh8YuAx+du6yxjXewAggaj7THnQIUb918P6bHdixXNvfB
         20bnopE6EZZReSLk49zwU5Cjknhc26QNs1ers45jtYxAjBFdx5ivBlk4LEfLSJJmx6cL
         nnQbesuJsstPTNBlcaw/PZkze/mdhZ7FH+3IvDtOAftbKMVCk3JfG62kvNDj/upgHNEp
         vctQ==
X-Gm-Message-State: AOAM532K6kSHhsJsviZkbuu4mhhFCP5AeI1MTodJireyp20awEOERw9h
        ixcFUXM2ju1bd1jjK8c/zdj2elQ42n0=
X-Google-Smtp-Source: ABdhPJw+FNUzc+NeK05Xc1sq/3jy/sRD1wQIURNgqMj3iwxdPv5tNJfMbTKOuFSinXJ4npTkOzV3Iw==
X-Received: by 2002:a05:6870:d1d3:b0:dd:b68b:8d50 with SMTP id b19-20020a056870d1d300b000ddb68b8d50mr275783oac.240.1649096362433;
        Mon, 04 Apr 2022 11:19:22 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:5ce5:a41:7a36:d73b? (2603-8081-140c-1a00-5ce5-0a41-7a36-d73b.res6.spectrum.com. [2603:8081:140c:1a00:5ce5:a41:7a36:d73b])
        by smtp.gmail.com with ESMTPSA id s125-20020acaa983000000b002ecdbaf98fesm4436849oie.34.2022.04.04.11.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 11:19:21 -0700 (PDT)
Message-ID: <09525cae-22de-d28d-de4a-120598d0f80b@gmail.com>
Date:   Mon, 4 Apr 2022 13:19:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: warnings from pyverbs tests
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Back from vacation I see the following warnings when I run the pyverbs test suite.

<frozen importlib._bootstrap>:228: RuntimeWarning: pyverbs.device.Context size changed, may indicate binary incompatibility. Expected 160 from C header, got 176 from PyObject

<frozen importlib._bootstrap>:228: RuntimeWarning: pyverbs.qp.QPEx size changed, may indicate binary incompatibility. Expected 136 from C header, got 144 from PyObject

<frozen importlib._bootstrap>:228: RuntimeWarning: pyverbs.qp.QPInitAttrEx size changed, may indicate binary incompatibility. Expected 208 from C header, got 216 from PyObject

<frozen importlib._bootstrap>:228: RuntimeWarning: pyverbs.pd.PD size changed, may indicate binary incompatibility. Expected 128 from C header, got 136 from PyObject

<frozen importlib._bootstrap>:228: RuntimeWarning: pyverbs.pd.ParentDomain size changed, may indicate binary incompatibility. Expected 144 from C header, got 152 from PyObject

<frozen importlib._bootstrap>:228: RuntimeWarning: pyverbs.providers.mlx5.mlx5dv.Mlx5Context size changed, may indicate binary incompatibility. Expected 192 from C header, got 200 from PyObject


It seems the headers in rdma-core and the kernel are out of sync. I just pulled fresh bits from both.

Bob


