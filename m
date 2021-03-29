Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC3D34C271
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Mar 2021 06:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhC2ESl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Mar 2021 00:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhC2ESV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Mar 2021 00:18:21 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE70C061574
        for <linux-rdma@vger.kernel.org>; Sun, 28 Mar 2021 21:18:21 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso11036530oti.11
        for <linux-rdma@vger.kernel.org>; Sun, 28 Mar 2021 21:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=MB5ykQ45eEeTIHyR65lptVCQVtb5fjjFBheoEPW0rMw=;
        b=nBhJ8viMdi4FLYbqvjk8P6UvOUxMu0zjjb3erzF+G4NY5n3ccGztsGFoggS6+2ujnP
         u5CBrlqutddh6M5LW+8rby/Vgu8T2ilyIzubcTliV9NGhRzd3WyTraMLcj/arhpI46S3
         tcbtJ72WbAQUOH88go2GKuRrDjd6/swWTjlWsyvS4yEaekUATQFKELxLGIXUdlFiFsIP
         KkUvNzcCqvNgzoWuZfJZdb+vCw22Jb3WUyYe1uslQITJFmFtmUZHp4OiKqLwi45ty4y1
         6fZTPaWPkRw7Do1Yn77xUl88m42cGTEuN22RPmqsiKY8EcOvWGSiRS2pCcsh0nYWlYEY
         2xrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MB5ykQ45eEeTIHyR65lptVCQVtb5fjjFBheoEPW0rMw=;
        b=T4zcxM3t0qSRUSeno9YTbdjk1QVL6XKrgxxoV141M44oBj0y9/bEj/NaD3rkIfCG0w
         Mtk5YXVo4miymm1T8t4MbYTBTNMdpVKtXJChiQ5k24v1jn9Iyki0x78HwxyPbVKp5+Ci
         k5HueOW6gJi9n5D7DpqeYbCu9ZJX0L9uwvY0R/qf6WSlV7fPG0DND8A3u0U4FPgXPTGD
         qfOrKZbmQjs9LMIyK1UQLVMDd6nkBrjl2H0ZpFcyvpGxCVfxmXL2edQjapZ2VFa76oSn
         mTSXmYTuFKc179BD3M/torUkLjhzeVdr1/0nOYuIKsSo9Rs3hzNjqsZn5PNs9gNRQLVY
         4cCg==
X-Gm-Message-State: AOAM5305Z4/3oMkxPgkLDkW3Q8GJDswC5D7Xq0bqjpVRzcBIJp9lLmWG
        TIgCyzP05+hDclBSAiNKrd1p7gDfKtY=
X-Google-Smtp-Source: ABdhPJxve2jf+HNB9rBmqJ3DozUpEHIgcY/obYR9M0HRzXXEzvslx9io+iR6Vmj1HvPMgS7Vj+8GQA==
X-Received: by 2002:a9d:37b4:: with SMTP id x49mr21141164otb.237.1616991500754;
        Sun, 28 Mar 2021 21:18:20 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:4e83:ca08:71af:61b8? (2603-8081-140c-1a00-4e83-ca08-71af-61b8.res6.spectrum.com. [2603:8081:140c:1a00:4e83:ca08:71af:61b8])
        by smtp.gmail.com with ESMTPSA id m19sm3553663oop.6.2021.03.28.21.18.20
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 21:18:20 -0700 (PDT)
Subject: Fwd: Serious bug in rxe_resp.c
References: <d97c64d0-073d-f51c-d8fe-ea3edd881aad@gmail.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Forwarded-Message-Id: <d97c64d0-073d-f51c-d8fe-ea3edd881aad@gmail.com>
Message-ID: <1a7286ac-bcea-40fb-2267-480134dd301b@gmail.com>
Date:   Sun, 28 Mar 2021 23:18:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <d97c64d0-073d-f51c-d8fe-ea3edd881aad@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org




-------- Forwarded Message --------
Subject: Serious bug in rxe_resp.c
Date: Sun, 28 Mar 2021 23:17:18 -0500
From: Bob Pearson <rpearsonhpe@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.linux.org

Currently all the error cases in the responder where the spec requires the responder to send an ack with an appropriate
syndrome fail to do so for opcodes which do not consume a receive WQE. In the state machine these error states go to the
COMPLETE state which immediately goes to the CLEANUP state and then to the DONE state and then exits the state machine.

I have a work around which is probably OK but I need to do some more checking to make sure that it complies with the IBA.
Comparing to the code at the end of do_complete it looks like the right way to do this is

int do_complete(...)
{
        .....

        if (!wqe)
                goto done;        // jump to bottom of do_complete()

        ....

done:
        if (!pkt)
		....
	else if (qp_type(qp) == IB_QPT_RC)
		return RESPST_ACKNOWLEDGE;
	else
		return RESPST_CLEANUP;
}

This bug was exposed by error test cases for ibv_rereg_mr() which expect to get a NAK.

bob
