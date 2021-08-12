Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309513E9F7F
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Aug 2021 09:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhHLHgY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Aug 2021 03:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbhHLHgX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Aug 2021 03:36:23 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4981C061765;
        Thu, 12 Aug 2021 00:35:58 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id nt11so8004254pjb.2;
        Thu, 12 Aug 2021 00:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=GlUzBZlaOoOtYGy1tVlXbHFbHEq0/VdkpbsBXQi4TMY=;
        b=eqzi9gvT2lMC9XqsL+9KpCm38Ft48Q5vTN2LNQunBNY5dW+mN7sBmRpoAvQgjPo2pA
         64YjMmxoBFejoJihn7watvLSvOBtwndYX1APMpqs402Lnizlg3eKvD2xjuzykNw8oEHU
         /q62loPDvoYUnfGFAzRaxNTaKoU1B0vWtLWXZTNLo2W3qNuI6ij0PehPSoyqgD/d7GzL
         B3aS8TwDjEXp7FCg6j6mcMHwfune2lQAdZsx7/UaVDIpAstGngNWS7fzmGlJF73FGpcc
         ZGTxufCmMiOc8XyVl9TG0JbD6neUpa7KJ13Bihd3CTZwdPwlKuClpoYL8Td9/syoVLQi
         Qr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=GlUzBZlaOoOtYGy1tVlXbHFbHEq0/VdkpbsBXQi4TMY=;
        b=kYbeV8XZElSoI74lnXvhIZ79ZE2PTekeKxPijrwi4zKRP1fA26L7Epz+IBcz2I9/27
         sCNA4LgcXKda+OGJlF4XvwnqM/J9qQUmrMT2eo0TY0+IwFDPPJpqkwGfpzjiFwjTW3B3
         kXAyWUMqumkD3ntK+rqkS3yEqUfx5L/PEhGBwbOhfswMLEIhda5UEB+NRg5Kol2IZx7M
         /Xw+eMefUDVgvIQo8hPyCmlrjLzO7y942VL4upMHsYap/Gmv7uB5UhvBFvbk7WEgE6Oe
         zBHRZ3GK0+dh2JE1SmLG1VAQophfRPpSC6uWl83OMdkPKpYKvuAqoqzlPyXknC1Gw4SS
         qU1w==
X-Gm-Message-State: AOAM533wf/RYwCcZc5lPOgaLODzZEksTIczR+ia23zgPWvjwluoxvLa6
        8UxaIdxiJFLbDxrmtJ3sGG2GCLm5WV8Zpcymb+8=
X-Google-Smtp-Source: ABdhPJzLvF5GeBGD6qJ04CbntLI8Wbna4sVs6a9G+KgpV7iCvYz6tzggA19z5mnap57WWgY8zVCglQ==
X-Received: by 2002:aa7:800b:0:b029:330:455f:57a8 with SMTP id j11-20020aa7800b0000b0290330455f57a8mr2851456pfi.7.1628753758367;
        Thu, 12 Aug 2021 00:35:58 -0700 (PDT)
Received: from [10.178.0.26] ([85.203.23.37])
        by smtp.gmail.com with ESMTPSA id y4sm1783698pjw.57.2021.08.12.00.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 00:35:57 -0700 (PDT)
To:     "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>
From:   Tuo Li <islituo@gmail.com>
Subject: [BUG] RDMA/hw/qib/qib_iba6120: possible buffer underflow in
 rcvctrl_6120_mod()
Message-ID: <9c03a5f4-865b-000e-0206-9e01f876261a@gmail.com>
Date:   Thu, 12 Aug 2021 15:35:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

Our static analysis tool reports a possible buffer underflow in 
qib_iba6120.c in Linux 5.14.0-rc3:

The variable ctxt is checked in:
2110:    if (ctxt < 0)

This indicates that ctxt can be negative.
If so, possible buffer underflows will occur:
2120:    qib_write_kreg_ctxt(dd, kr_rcvhdrtailaddr, ctxt, 
dd->rcd[ctxt]->rcvhdrqtailaddr_phys);
2122:    qib_write_kreg_ctxt(dd, kr_rcvhdraddr, ctxt, 
dd->rcd[ctxt]->rcvhdrq_phys);

However, I am not sure whether ctxt < 0 and op & QIB_RCVCTRL_CTXT_ENB 
can be true at the same time.

Any feedback would be appreciated, thanks!

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>

Best wishes,
Tuo Li
