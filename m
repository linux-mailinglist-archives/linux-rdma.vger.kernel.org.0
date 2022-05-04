Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3052451B476
	for <lists+linux-rdma@lfdr.de>; Thu,  5 May 2022 02:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbiEEAD5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 May 2022 20:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349306AbiEDX6w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 May 2022 19:58:52 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711D853E13
        for <linux-rdma@vger.kernel.org>; Wed,  4 May 2022 16:54:12 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id f38so5087977ybi.3
        for <linux-rdma@vger.kernel.org>; Wed, 04 May 2022 16:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=ampHH5WJLIBWSsxWwzVjbk5pO9UBFxn81pZ6QIDzZtY=;
        b=Dn1MT8x7p4Rbn+pctwVkt7IgIdUxT0LRLjox/JaF9ttsZ2N8sUUglHFRxQa3sl75aK
         h1U1JpCoOjPff8rV+LL0edQuBh+YvYlTbZ4zx127Qa80qMcS49J0d2nS2s7mVVadwp/M
         vGp6wV8qQhR9tMRiQjyWHIJslgvG4HigF7p24aLxixJ1l99K68kLikab9Y0HgtSpkDYW
         0+riuhXlj9dAnGs04evyYz4sFXKtm0FlJKiBI2Dtbo7ebvKr6E7XJkxgxzCXhReMwL1D
         yv9OUeo9KjH+/RIlVXefhsYivAQRdlwo604eWoXrrvRFVxcSgXwgPis+UtVhyLpBWx3z
         WyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=ampHH5WJLIBWSsxWwzVjbk5pO9UBFxn81pZ6QIDzZtY=;
        b=FUv6yY1F7FYRLL+GWbMwqIu5oMKVDMvO8xRMHU0eGaPx8GW7tUCNaibGVspkeX1Vno
         zT0TbKyS0xOQeC/jT8+Hvpjp4br+jfrnWLfdc8j6ANhqnlRBpkoW37uQMlDFnbEJywtK
         jxAau1rU0oKWqiyrI2gsKCEfiE4mNdPalbpnE0nrdc7bkXQ6UZSYAKKwpfCOwTK/UlJ8
         +72SBtC71qMad/X1bphANwnGn6q9Fuh1kc5cAIS/KH3+H3KsWu2VSIdviBpbJ9LIlk//
         d+P3r3H32saFPKYohKIEiXWGuvsjVLN51T42PYwlOudycZaj6n7mpujgp/XnPZFw2jYq
         3cyw==
X-Gm-Message-State: AOAM531U7R0Bt7NHP+MvcbIukTCXmviXa9hcrrPUbPSLw9fZDvFOFxDb
        saofp0hfDjDLnvM/b/af67GsuTwlUhF2d5TQLQipNO32CO5uQQ==
X-Google-Smtp-Source: ABdhPJyXbFHNtxfp8+qt+M9kuv/iG7XfFeFFPd7I4/fmpdxuycMtmf6dIJw5ghtZAT2CwgvAVE/kUl0HxsirxLIU8v0=
X-Received: by 2002:a9d:6b16:0:b0:605:e0eb:d3d6 with SMTP id
 g22-20020a9d6b16000000b00605e0ebd3d6mr8263208otp.213.1651708440302; Wed, 04
 May 2022 16:54:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6802:1a9:0:0:0:0 with HTTP; Wed, 4 May 2022 16:53:59
 -0700 (PDT)
Reply-To: ortegainvestmmentforrealinvest@gmail.com
From:   Info <joybhector64@gmail.com>
Date:   Thu, 5 May 2022 05:23:59 +0530
Message-ID: <CAP7KLYgH9LcKHS-KgR0zObHAgC6Fr3D+dOJSbDKurTc_12+iFw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b41 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5004]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [joybhector64[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [joybhector64[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-- 
I am an investor. I came from the USA and I have many investments all
over the world.

I want you to partner with me to invest in your country I am into many
investment such as real Estate or buying of properties i can also
invest money in any of existing business with equity royalty or by %
percentage so on,
Warm regards
