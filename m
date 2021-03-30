Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F1134F2B7
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Mar 2021 23:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhC3VBO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Mar 2021 17:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhC3VBH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Mar 2021 17:01:07 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813ECC061574
        for <linux-rdma@vger.kernel.org>; Tue, 30 Mar 2021 14:01:07 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id i25-20020a4aa1190000b02901bbd9429832so4100536ool.0
        for <linux-rdma@vger.kernel.org>; Tue, 30 Mar 2021 14:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=bBaO1Pf8mX5PBCEsoQS7m7GqvimnGc3iaoa/P2PQIF8=;
        b=sllniMcmHcCl7NBAD+PlcyKmCSSDF7ls0MNlZTaxA6nxy+iywOwykATtovM+fKzVZd
         SPfGWppq71pHCM+ZkykfCyF1oWlL+hbSIJN5WsdpJeYmTrCcJRsA/qORVW0BLWygapV8
         6V5wwlX2tPiz+wyH/n1ucKD0VeKDC9yK8NBQfK2VNVTtXXpyB74Rne2K+AGitGYDw3F9
         1ZTlfXrsNriJXL05UIQcR80XUvFXS71PiupKaFN6IdnY2zSA1To/dnFBjEEfCHGkXMDS
         vhyTZzL+R+XeFLftwY3NX/iHSO81M5ZhT/9CuIDeZovu4KaNG0ELLTjsZnA9iN1BgUJ8
         9DBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=bBaO1Pf8mX5PBCEsoQS7m7GqvimnGc3iaoa/P2PQIF8=;
        b=PN8Og1yMIFh3mlDTB6iadR5xDLOroyZa7Bya9PreMbdSmTfEy/XfmlixVEli/Y+8a8
         OBM3Sr19QJV0loAAxosAyVdOFmIUsZhvsMtEHJdgItaG63sRLBdxWiFV9a70I9pk7p95
         ZbqI8DK4hjEEfONXHnrR3+lgSbOvpXt5vMCVYsYD8m1b0cIwHDY7Sg63Q6FwbznL+SP4
         1ia1wm+VWQqyF1AVgLncWu5gctCm+gbRIcuF9u1yfk3S2MgDwsSIBn4eVy23IbSvMuWt
         keBW/RLQgexvkaTBJKO0mEm2DrWMX7v3IVq6WXWkQlbsDL6ci75wEgcUdSvE8WmzO9re
         MGKg==
X-Gm-Message-State: AOAM530neMvnIYd9MgRLFdImuuT5znhMLdlJzQtcKE1naEsWsEztriIo
        TQOSSEETS6ZXExtPrlBmcs9NuG6lRUY=
X-Google-Smtp-Source: ABdhPJxYhhhErHPYglckND0hlMuQabXdtowwhIDeZZ7g55xIAkHESrPqmjol+4ajNkRn/kMH6KIywg==
X-Received: by 2002:a4a:6b04:: with SMTP id g4mr27170542ooc.78.1617138066560;
        Tue, 30 Mar 2021 14:01:06 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:51df:b5a7:cad6:349f? (2603-8081-140c-1a00-51df-b5a7-cad6-349f.res6.spectrum.com. [2603:8081:140c:1a00:51df:b5a7:cad6:349f])
        by smtp.gmail.com with ESMTPSA id c9sm5325ooq.31.2021.03.30.14.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 14:01:06 -0700 (PDT)
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: QP reset question
Message-ID: <dec67c77-5870-12a9-3308-dd24ffbcfa8b@gmail.com>
Date:   Tue, 30 Mar 2021 16:01:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Jason,

Somewhere in Dotan's blog I saw him say that if you put a QP in the reset state that it
- clears the SQ and RQ (if not SRQ) *AND*
- also clears the completion queues

Rxe does nothing special about moving a QP to reset. A few of the Python negative test cases intentionally
force the QP into the error state and then the reset state before modifying back to RTS. They fail if they
do more work and expect it to succeed but get flush errors instead left over from the earlier failed test.

I have not found anything in the IBA that mentions this but it could be there. This will be a little tricky
if the CQ is shared between more than one QP. But easier for me to fix than changing the Python code.

Do you know how this is supposed to work?

bob
