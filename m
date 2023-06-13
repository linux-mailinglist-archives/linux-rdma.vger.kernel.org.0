Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553E872E87B
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jun 2023 18:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbjFMQ1A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jun 2023 12:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjFMQ07 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Jun 2023 12:26:59 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F018AA1
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 09:26:58 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-19f9f11ba3dso3814902fac.2
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 09:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686673617; x=1689265617;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zz+FUsawQCBxfOxaj3sS3P4x+I0BIHidbAG/Hr/y+Ag=;
        b=Dqircumr5L/bg2ms3A+CsL01UmhZx6BLCl/M5er/0Ep+tbzB/uew7B4fx5qYmYerqa
         x6OYVyyLepjfDrksKto3Hg7s6TUYvvQmYA1710Nkq8e2bl5tglALeIO2fnEPNu4TLWPx
         Ke31vvEHGuK1BM8WHi0eTOLv9jgRyI5bKXJUdSFdH11JanX56oZBW0UTK9XbY8QCUGIc
         uePbBIG8Tgg/cCDD+1vnE0SgEk3SrHX3PaaqBElG8tDsfAYgNV+T3tFbSrn/wp4NlzUh
         xIBTcyUT6lihL3GhNd69BgB4vtGqFFccbDc0IzFKUNLbEgC51oEl/r/pFoY80mUzk2Gj
         Av9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686673617; x=1689265617;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zz+FUsawQCBxfOxaj3sS3P4x+I0BIHidbAG/Hr/y+Ag=;
        b=X3jyZX6XWY/Mws0XJV4G0IEk/kcb66TYKFmqzIIT85m3OqxhigA1n7chiDGr8gplTw
         sbp2Aq548MPnbh8qciqDwObQTPsxfeQmHKPstfPJwwzway8OlM9MKo4v/Q65qf1Sq9I1
         9MGCipzk3mfPX61TRCDLt+3VV+WJWahAeky2s7KW6WVnLt274QYJwr9Z2kmVkrlnS1d7
         PbibOM+63mSxl2sBJT6563+JtbGjLcYCl1SHfcxjW4dbj5ZxQLLdNnut5H+4EVA8X+hr
         u7i8NCJMuStpf9xOa+pmnoAtMpvY/XBskRN0Yqf3yaUGCkap+rXn2iIP6ygohsk8yfnw
         rBcA==
X-Gm-Message-State: AC+VfDwYC60Y8AdY2KNZcQx5QabR8pZyGImc5a0D4XtLY/te0DwbcGCq
        X1dWaimN8WyR6k9cN1qd+II5uuvpTTk=
X-Google-Smtp-Source: ACHHUZ6f8HnmZ4Bv0dIFE0Y2rseAUOM0msrn3/UAykBXMaLFvaF5pfIlui8m/0A1kFxK5X/1fIOwtg==
X-Received: by 2002:a05:6870:1aa9:b0:1a2:f7ca:61af with SMTP id ef41-20020a0568701aa900b001a2f7ca61afmr7580812oab.2.1686673617099;
        Tue, 13 Jun 2023 09:26:57 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:b626:4062:16bc:9b1? (2603-8081-140c-1a00-b626-4062-16bc-09b1.res6.spectrum.com. [2603:8081:140c:1a00:b626:4062:16bc:9b1])
        by smtp.gmail.com with ESMTPSA id oi10-20020a0568702e0a00b0019e4fe93d72sm7408646oab.42.2023.06.13.09.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 09:26:56 -0700 (PDT)
Message-ID: <80328b20-9c5d-afe8-0ff4-a7eb05c8fb4f@gmail.com>
Date:   Tue, 13 Jun 2023 11:26:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: Bug report in reg_user_mr in exe
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

Jason,

Recently the code in rxe_reg_user_mr was changed to check if the driver supported the
access flags. Since the rxe driver does nothing about relaxed ordering. I assumed that the
driver didn't support that option but it turns out that this breaks the perf tests which
request relaxed ordering by default.

It looks like the correct fix for this is to go ahead and claim support for relaxed ordering
but it will be a no-op.

Thoughts?

Bob
