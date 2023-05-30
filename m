Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC87D716B56
	for <lists+linux-rdma@lfdr.de>; Tue, 30 May 2023 19:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjE3RlN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 May 2023 13:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjE3RlB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 May 2023 13:41:01 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBB7D9
        for <linux-rdma@vger.kernel.org>; Tue, 30 May 2023 10:40:59 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-39831cb47c6so1642374b6e.2
        for <linux-rdma@vger.kernel.org>; Tue, 30 May 2023 10:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685468459; x=1688060459;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YT8IHzYMdvhm3eNkfJx6s6xjk+ygDrXP6MHn+K/CcoE=;
        b=Z5ztXIMP4f/ZCtAnH9GC1hawQ9iG3yX9x9J1MGYUfyvMT8Onk8OO9oItH+oXcmEJxU
         tl/bmSZPD5kYYgdbaQaLn46KL/Pz1y9wC/EbBwMIYB7zLNWob+1bpN3pHTGc9e9XqBJt
         eC98qZJ+D1aT5fXzJPSMIIW0whbxLXjf5IfCXjKYgw3E9QX/bcfEbcpjLrEcdlS51IOE
         kYI6wY08gdi/0fABmu63j2N58Ior68tdp3/vnRD1JxfxeWpbU/PLGAg7r+jEbURNOOfj
         i247FNcHM/L8Ps5AZaR08fqTmWo2WsAkw9b1Tx0mVglHFrIDRAbN5LM608XQ7x/INmJ+
         3MwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685468459; x=1688060459;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YT8IHzYMdvhm3eNkfJx6s6xjk+ygDrXP6MHn+K/CcoE=;
        b=k1cXPt+pT6tXMN+beiSXm/uEfRtCoJM7NeqPbiQImU8gaUIGzMxSKrljpPSY2SdxVl
         o1kKmROllOHA8tBKiPKsqyO2PpZ9GtY0bVZhAt0fwB1At6GMGocgW/g3nnB0G/Dffh16
         pT2ycpipV0XaYjKYH275KRbiLm2WssA5WV06GAkgr/u7RQCUJKw7vDxQFPRSrl2c+kEP
         25qaZOnRxB+nUXC10OrQu6fiWCvd78e6usEPDSRuDfw1gldJi51rrqebem5AeWaaK0mD
         rAh6pbo18Zyp+WxpLlvTZCUKdGy3tFkPz19j9nht3MdH/h6xigihoc+AR1MLEPsm+KpW
         GwUQ==
X-Gm-Message-State: AC+VfDxzgFK5d4eiJMWyMBBopl1g5a1BLqNXaUBbUuPxn4xF79YbMMpQ
        TSDS4m7VvlvKa+9bN5GS5qI=
X-Google-Smtp-Source: ACHHUZ5ymhF1R6sAKXj0mgUicbZu60KIZhrV62yF9hb2A4pYy5w9AJ/khYtyf/yZmHGU3UD6UewX4Q==
X-Received: by 2002:a05:6808:1818:b0:396:1411:804f with SMTP id bh24-20020a056808181800b003961411804fmr1464573oib.26.1685468459136;
        Tue, 30 May 2023 10:40:59 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:61e7:5a75:8a81:5bfc? (2603-8081-140c-1a00-61e7-5a75-8a81-5bfc.res6.spectrum.com. [2603:8081:140c:1a00:61e7:5a75:8a81:5bfc])
        by smtp.gmail.com with ESMTPSA id bq10-20020a0568201a0a00b0055801665622sm3054257oob.38.2023.05.30.10.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 10:40:58 -0700 (PDT)
Message-ID: <9a1cf1ac-ef2a-faaa-542d-17831d5199d2@gmail.com>
Date:   Tue, 30 May 2023 12:40:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     ynachum@amazon.com, Edward Srouji <edwards@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: bug report in tests/test_qpex.py
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

A recent patch:
	7ad213c52201463e798504b96d7e46411d5663e9 Mon Sep 17 00:00:00 2001
	From: Yonatan Nachum <ynachum@amazon.com>
	Date: Thu, 11 May 2023 09:27:30 +0000
	Subject: [PATCH] tests: Fix ambiguous use of qp opcode in traffic functions

incorrectly replaces IBV_QP_EX_WITH_RDMA_WRITE by IBV_WR_ATOMIC_WRITE in test_qp_ex_rc_rdma_write.
It probably should have been IBV_WR_RDMA_WRITE which seems to work. With the rxe provider driver
this test attempts to call qp->wr_atomic_write but does not set the send_ops flags correctly.

Bob
