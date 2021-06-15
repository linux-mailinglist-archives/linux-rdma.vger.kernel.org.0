Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711623A7404
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jun 2021 04:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhFOCfK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Jun 2021 22:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhFOCfI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Jun 2021 22:35:08 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4A3C0613A2
        for <linux-rdma@vger.kernel.org>; Mon, 14 Jun 2021 19:33:03 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id s23so16595644oiw.9
        for <linux-rdma@vger.kernel.org>; Mon, 14 Jun 2021 19:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/P802oo8QYJGFG0XrAXTrB+clAVvymndTSrfbQQh+qc=;
        b=phKvNq90zlGpVRZ6WYa/fmNdcUN2LhWoJ8Niqyvlt7bUNcM2ksg/B9XNZ8TZHAuSok
         K38LAmC8JFS38UPOd0+DV7k4EFSEleN0ALzAFbFrVa/rG/EcPrWeIEcq07mHFmnkPmAl
         ZgcfsL+VjPIurSs9CEPDNPYWnjOQ0pkxbP2wjMn1gCN/5/kIBfysw+hZQRdEvNCFiowD
         fmxP23+UMFq9mUVYLVOMNYC9Uso+r5d8nEBI9dl32kbbD5d07bu0smOn32gMmta7bmuH
         uTCeT9d3lONviIeu1EucTD4jDs1tpXY/s5+uTqGSS8AR4tLaCAtlkK31s2pEQtrQ/oPT
         EbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/P802oo8QYJGFG0XrAXTrB+clAVvymndTSrfbQQh+qc=;
        b=b07xfOrpO6hMdxJC17xwAf34FmAgSDJ4rAi9XvQBiTnA1JNV8UiUCRWtuRKSW9d02p
         TS8vr7MkSZB+N8DVzPYAQoO3g8yhFYlkGobLK1UZDgo5L2TsVeOG2w081RAONqfhP104
         KqYLvJ4Z09+QTOEKfCV9Rz8HmVopUD7WS7R03J6hpPXcUFs4BZrYfBibOTezoebidpUo
         uRhUgodUMYPha42VeqxjSxRob+ix75Tny1iNgsY98PYvkWPzJIy8slsJ2FNHmYB2Qpb7
         2EdIHW7gIGRxeE7cdgoS9SH2M8Rlnh2x9n8eWIY7dVVg0+pw6RndnkkECUiuNtTf88qz
         cnBg==
X-Gm-Message-State: AOAM530LkyCDAiX4S6AB2/ISRYeDN6REDRongiDUKX6bWRqrtpaYIzqZ
        moiHzb47Tm19HfcxrkAOp0Vklz1V5GM=
X-Google-Smtp-Source: ABdhPJx2l4OA5Fu+PwA2Yyf7ES8uLdQBil11jGf8rfBFTvvXV+25WhRSESgNvki2ZFQ/rzHq/WgSDQ==
X-Received: by 2002:a05:6808:34a:: with SMTP id j10mr1399248oie.149.1623724383090;
        Mon, 14 Jun 2021 19:33:03 -0700 (PDT)
Received: from [192.168.0.21] ([97.99.248.255])
        by smtp.gmail.com with ESMTPSA id f12sm3557441otc.79.2021.06.14.19.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 19:33:02 -0700 (PDT)
To:     Edward Srouji <edwards@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: weird corner of python tests doesn't work
Message-ID: <b2a978d8-10e7-296d-1b9c-2625a1b59667@gmail.com>
Date:   Mon, 14 Jun 2021 21:33:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Edward,

I was trying to configure a rxe device on the lo interface and although some tests (e.g. ib_send_bw) work fine and some of the python tests run correctly many do not. This is useful for testing because I can generate loopback traffic that actually traverses the IP stack after disabling the internal loopback path in rxe. This a more realistic test case. The problem occurs somewhere in libibverbs in the call to ibv_resolve_eth_l2_from_gid(). I'd be interested if the problem is obvious. There are at least a couple of issues. First the default gid_index in tests is 0 and the MAC address based GID[0] for lo is all zeros which breaks things. If you set it to 1 which gives you the IPV6 mangled version of 127.0.0.1 you get further but a netlink message exchange fails and I haven't been to figure it out.

Regards,

Bob Pearson
