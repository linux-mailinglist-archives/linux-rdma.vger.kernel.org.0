Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843A678135F
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Aug 2023 21:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350114AbjHRTch (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Aug 2023 15:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379624AbjHRTc3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Aug 2023 15:32:29 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845874212
        for <linux-rdma@vger.kernel.org>; Fri, 18 Aug 2023 12:32:28 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-790a8c74383so41722339f.3
        for <linux-rdma@vger.kernel.org>; Fri, 18 Aug 2023 12:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692387147; x=1692991947;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VM/48JRgRJrmA8/X3MvupkeS0OjLd7GfIckwsUAbu98=;
        b=aJGEpi2LTTl886Amcr8VOHva3pTt8hiJJdcr9yddIB0/X1Eii/87PwdksGT51668zX
         7vC14PqQ2ByPvirvl45Ic9d3pnJ/eh/bAyaGsuAFvFCQUbwFjYAnB+6nexPsVbW/8tAq
         mg5oTsstRGUNg+w/yRtMeA+FM9ePwoYUGZJDf8q9HIritEAhX5qRFEGkPlWfKv21p70T
         Kx0YODED4KOa5xrN5ByLD1nsu23Hm0CVWafF0+baNyDbynrPLSSYfn3EgvRvXfFsazzZ
         ynbkfy4SWIf9Yc9Kxy7HE6WA81Y5OmZgxA2PY9pHNkpMamloSoANf0vTm6KCFy6zOGY3
         b59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692387147; x=1692991947;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VM/48JRgRJrmA8/X3MvupkeS0OjLd7GfIckwsUAbu98=;
        b=H3kL+qJ8lvurgDLdLjFugsugq4rZ9p1uBH+wau+X6nl4T9NxWe0uoJ2MRUaX2a4yyk
         BbzUWazJ4+SrTZcEXA0UP6Hki86rYrlQxRm0/gByyfd/XszQ4bC6zJGG5FdXW5SsDUl0
         XSX8bJ9wlwZmTbR7HM1OhXRsHYqmnpRu7QwRVU7NUx5NC6FXbysMNAuzcN4+zoHHpQJ5
         ZQJSjdGcCc0g10oolNKeRhGHIqEP6FyQbD7Pcwpdna+AodHIW6WF7Gkzv/iKJnHdHbA4
         zwoveEtmoLN/Pcl1jVz7ThVc6k4wGaKS9QaLJS4L0P5jrOMDbkAE84N3tdbgVK8a9Hgm
         FuRQ==
X-Gm-Message-State: AOJu0YySxuuSrqSND/wEySa4jLz7xifM8xac4809q1wq0+uM4xm4Nijk
        0Sb/XUORUqWf8SFtx5rZ2s0YkzuYCLLOjj7IZlsPzVbuM6U=
X-Google-Smtp-Source: AGHT+IHle2dcD8vvudFarbcNoXuq0GcwwtdsL4vcgnwbq1qKU0FHt4HcjBv5f9lKsH4ozVYo/8/tr8vmYbl75anbRxM=
X-Received: by 2002:a05:6e02:10c1:b0:347:6b30:5bd3 with SMTP id
 s1-20020a056e0210c100b003476b305bd3mr241012ilj.13.1692387147596; Fri, 18 Aug
 2023 12:32:27 -0700 (PDT)
MIME-Version: 1.0
From:   Abhishek Joshi <abjshprof@gmail.com>
Date:   Fri, 18 Aug 2023 12:32:01 -0700
Message-ID: <CAJ6TakGwk6u2m+vgszEyWhCSs9d4ipYhBm8E4+TtV86nDWfDjQ@mail.gmail.com>
Subject: Confusion regarding RDMA read behavior during retransmission
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The Spec says:
The PSN of the retried RDMA READ request need not be the same as the
PSN of the original RDMA READ request. Any retried request must
correspond exactly to a subset of the original RDMA READ request in
such a manner that all potential duplicate response packets must have
identical payload data and PSNs regardless of whether it is a response
to the original request or a retried request.

It seems that a retransmitted READ must return identical data to the original.

But consider this scenario
a READ followed by WRITE followed by the original(retransmitted) READ.
What is the expected response in this case? I tried this and it
returns the latest value which is what I would expect.
My question is why do we not return the original data?


Thanks and Regards,
Abhishek
