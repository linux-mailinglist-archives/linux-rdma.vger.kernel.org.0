Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9237D68AE29
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Feb 2023 04:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjBEDRC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Feb 2023 22:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBEDRB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Feb 2023 22:17:01 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F91621973
        for <linux-rdma@vger.kernel.org>; Sat,  4 Feb 2023 19:16:59 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id cf42so13274106lfb.1
        for <linux-rdma@vger.kernel.org>; Sat, 04 Feb 2023 19:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=oH/zlNbutQr5DyyD2dgZTqpIFXINGgNjB2wMdauAVfXe1QFvC0KiIaxL+CFy6W9w1K
         kpERqHfDzC0zCiw59DZpJ8Z/0WQMlM1T1Wq1t3+U+E1ZhPKyj2C/n7i4WT9c4UC5UN1d
         fJl+6wHJYEYKIStlxsTd36E+l7Hu02bQoJj0efAy4ikoxcJMgrC17BGnhPCJcS03IbAF
         F8WC2Laajk4OLqFgBUI9KVxKzxG+xGVkIdNzc4DXBm9SMqGqkxhmeM3kIOVH3AB4XW4u
         bmueBK92bkvx9J6AaWotCMfFJpcb7MXl4vJQvAWz37HAR4gcsQfNWEDlmPc/TFM+5CV9
         dGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=tK4AeubhjC0Bq5LwxH6YOvCiXLXD4pxLoyUvoEKpdtciFLiN1BlQU6fAeus98VCOFH
         x1yM8se9R2F7SF2ViCyy1h682uYI1L1jVQ6ur2J9M/qcOoIQJ5cY9HDNp/buooJdd3Zf
         LjPOK8ZNUXjT3jfO7pzI3uIxbol6fLzpVtAkbN3Yv/m33cSKrcFjVFyl2HOyJ3DDfYEq
         HLkR0xqAbW9ff0b+y82IMjYgDBnSS7/vL+nCQ4b7R/i6ungGrzMfdlzbNCePcpZAVyWl
         uZcGlBwoe9ZcaQNz49VTW7wPz28DxIlcjFTrYsekVZ6jSwRJiiIyOIdyq0PrHiYbqVGp
         0tVA==
X-Gm-Message-State: AO0yUKWqWYQKnCYa6luXsalJB7666AZKpQOdR5rBciPFOTf+RBp5g6XB
        A/AQvgIifDKWJ5pA86zO72FCqUz6x0esFYVygtE=
X-Google-Smtp-Source: AK7set/3ErQTboeVKIWz7sjuMAu6CYqm6BTAwg7FQjSST3Oy0GJ3nFknk9Jr38xcpFqPP9e6jKeII6XYiba/fHm1R8w=
X-Received: by 2002:a05:6512:a84:b0:4cc:8fb8:b263 with SMTP id
 m4-20020a0565120a8400b004cc8fb8b263mr2418345lfu.112.1675567017668; Sat, 04
 Feb 2023 19:16:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6520:1c6:b0:240:2606:2430 with HTTP; Sat, 4 Feb 2023
 19:16:56 -0800 (PST)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <drtracy490@gmail.com>
Date:   Sat, 4 Feb 2023 19:16:57 -0800
Message-ID: <CAP=2o6ET-WiAyHcBcnoA9hOVs7BHr7FKBJBMg=0YUPw2vtzoBQ@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [drtracy490[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [drtracy490[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
