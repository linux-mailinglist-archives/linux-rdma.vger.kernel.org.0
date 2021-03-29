Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A74534C270
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Mar 2021 06:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhC2ESH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Mar 2021 00:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhC2ESG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Mar 2021 00:18:06 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AA5C061574
        for <linux-rdma@vger.kernel.org>; Sun, 28 Mar 2021 21:18:05 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id z15so11929650oic.8
        for <linux-rdma@vger.kernel.org>; Sun, 28 Mar 2021 21:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qphellQFWcpYID3rdS2uPXsSgk98E0w2KHdB4iFSvN8=;
        b=jqrk40vm3/EeQjo2pWs/NH5xENaoRqOV4bfQIGBTIV8R2WDOdvNYPeA0OR0/0ymmdP
         ulh0rMlAcW4AqftMTtV1DuufXbGQy2vnpj1Nw1aSJF+Rts1PUyqB70+VNIZm0x+cSK38
         vGed1AgXdqY6LXvY87+LK+gZYYa7M3THN2NMXbiR8KVVVPh7L13NMs09NoaU7KSr5oDL
         PckKLMzTMuqYcv+5k6o4dstydP2Vz4lSWcD/AxmifDf8nNKAbQ+Y2wiHVuSGVk0FyKqN
         kFfvagw30+Xg2orEedK8RYHPeZ4SsCKfwATEjbtYQeoAV4UfeEwStb2e0drCGQPPMqFK
         RXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qphellQFWcpYID3rdS2uPXsSgk98E0w2KHdB4iFSvN8=;
        b=HBwTUh1uF8I/DB9KLgGOES3fqOmn6Bxs7aI/VdtwbX8A9ZxIW0OtFjlatUG2v14l82
         vY9pEArUxLmsWAYbt8gUTPxQ6NjZPB2G9tBOSHf2NdsBOuHjXC8yjhGgnWQSbcqP0dmm
         fNnSuosoG/RsPsHcbAGufsjzU83X0887MJORTdyNb4WOFJN9HsnvS17D+a7m3OBXRsOE
         uz+SBRRGfE6fc6EPho9Ay0RqFDzOcddsmYLGEbafsFMEl4Wpm3Oj2DAF20hS67hsBzwh
         CHd04nrxYCd0Uo0Zxl/K16+ENJsDsjB/ywCYJTypF1CICGVJQts+YBxnW34Ti3YKYE2P
         blMg==
X-Gm-Message-State: AOAM532W4vFHbD019fPBHqtg9+9Dp/zG7eSTlrcMbkYAPGp0tmXZENM1
        i6DYtFenPXfry9bsLsjl99Ik5vZZFiw=
X-Google-Smtp-Source: ABdhPJxoGDw4k8Lv9TkBK4fHJvXpWdgG7peeKg05UyyIm/SXN2XLAHNvU0v7FUqT29QoD9UoZTG0Lw==
X-Received: by 2002:aca:3046:: with SMTP id w67mr16832430oiw.57.1616991485125;
        Sun, 28 Mar 2021 21:18:05 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:4e83:ca08:71af:61b8? (2603-8081-140c-1a00-4e83-ca08-71af-61b8.res6.spectrum.com. [2603:8081:140c:1a00:4e83:ca08:71af:61b8])
        by smtp.gmail.com with ESMTPSA id g6sm3610198ooh.29.2021.03.28.21.18.04
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 21:18:04 -0700 (PDT)
Subject: Fwd: Possible bug in test_mr.py
References: <c143355e-954a-5953-c67c-c7a9bf451b7b@gmail.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Forwarded-Message-Id: <c143355e-954a-5953-c67c-c7a9bf451b7b@gmail.com>
Message-ID: <edbf4d3f-08bc-31a0-a214-c098748697b5@gmail.com>
Date:   Sun, 28 Mar 2021 23:18:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <c143355e-954a-5953-c67c-c7a9bf451b7b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org




-------- Forwarded Message --------
Subject: Possible bug in test_mr.py
Date: Sun, 28 Mar 2021 22:52:01 -0500
From: Bob Pearson <rpearsonhpe@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.linux.org

Testing ibv_rereg_mr() I noticed that the test uses the rkey originally assigned to the MR by ibv_reg_mr() and not
the rkey subsequently assigned after calling ibv_rereg_mr(). This matters when the original MR did not have remote
memory access and rkey was set to zero. If the rereg changes access to allow remote memory access then the rkey is set
when the verb returns. But the test code never looks again after setting up the original MRs.

In rxe setting rkey = lkey always gets the first rereg test case to pass.

bob
