Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB4E547A85
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jun 2022 16:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbiFLOj0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Jun 2022 10:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiFLOjZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 12 Jun 2022 10:39:25 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D82E275D3
        for <linux-rdma@vger.kernel.org>; Sun, 12 Jun 2022 07:39:24 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id v1so6503741ejg.13
        for <linux-rdma@vger.kernel.org>; Sun, 12 Jun 2022 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=JBPn9fhRw7KAjBiUim1NARoXUOCv4AozHWC+FFk1HbE=;
        b=TBx5I3gYDmDWo3zYDX7AdE5mo6ZgaukeOjXukb8itDO0XHAbXnY4/FV6IgovtllEfR
         zaD2+PilBgoWhRfKgoeFQ4ie57U80TKPCKJQ1o5dT22RtxsiEbNMSHKDi6uLR/z9wita
         fN8DVOCzfZM3f71tXULnKGsZP/C4S3im6apr9uQG4wtRvCVfUCPeT8SO51MJzLO2JHd7
         laGQwFv6JXr0b+Sg2gjH3Z9Xt8bwcu/I2xeMU+bty1jV7HPm2Y0mr5o3XpZ0fryr9XQJ
         NcDtYx0T/Ao7HYjAgfo/9ZKP/3ROVvF2g+leCHb/fYVW+UmeedWZf4TYIV3TDLXH5yll
         lT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=JBPn9fhRw7KAjBiUim1NARoXUOCv4AozHWC+FFk1HbE=;
        b=Yahz+f6C4/DowUJdKZCNSCYJ37D44ezObsJOlgqQljPPgtgeFf9J2376JLXJempics
         faLknFyUc6uGQaGp/gWWjGmbzUH9ujDvYaaQ1112lJCbhLz9PPcR21qf+mmelSQIIsdM
         i+n/wWLNvyGA7h0YUsOOK5Kg+xXpn7rslmSW/jggM0qOHVNJjL8z+ZuttAUoaFw+7OAB
         sKga0CUsS34OxmOzqHXc0lTELfsUaSdQ4eShVg4jlebVTjqN9ZKLtZ0oDeVUGAXgBxbt
         C0ZmtkOhsuN7JyjAzTYxWARDeJ0kvsY+kP0OtIQfm221xO3Z2MeKC67XcA0Wn/HJ4ODy
         pnFg==
X-Gm-Message-State: AOAM5334VXyjW8sdGHYJxKZcvlWuDYHYBoFAvP5kqdOdz1bWR9x3U/iY
        FIuBXgHQs6ef+CBOoi1ZKdZQA7omkKJDe/GRIG0=
X-Google-Smtp-Source: ABdhPJxwIS/eb1QxbAiOZ5iY40fHfoT6CjBvJ3Auo5TUQHe+m3nNQ0k/3PFK7ImRxql4r9vS89AM68AAHI52cK7hB+4=
X-Received: by 2002:a17:907:6d15:b0:711:d2d8:4818 with SMTP id
 sa21-20020a1709076d1500b00711d2d84818mr30609708ejc.336.1655044762816; Sun, 12
 Jun 2022 07:39:22 -0700 (PDT)
MIME-Version: 1.0
Sender: reymonddennis@gmail.com
Received: by 2002:a17:907:c03:b0:718:82e3:2298 with HTTP; Sun, 12 Jun 2022
 07:39:22 -0700 (PDT)
From:   Mrs Carlsen Monika <carlsen.monika@gmail.com>
Date:   Sun, 12 Jun 2022 15:39:22 +0100
X-Google-Sender-Auth: VEwID5nveZoyqA0o1RScm335T2I
Message-ID: <CAOOE2sF=WjFwb_9oHY95eid184LhXTfxMi4wpdy6D-WKBZp5yA@mail.gmail.com>
Subject: Dearest One,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_80,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:643 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8950]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [carlsen.monika[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Dearest One,

   CHARITY DONATION Please read carefully, I know it is true that this
letter may come to you as a surprise. I came across your e-mail
contact through a private search while in need of your assistance. am
writing this mail to you with heavy sorrow in my heart, I have chose
to reach out to you through Internet because it still remains the
fastest medium of communication. I sent this mail praying it will
found you in a good condition of health, since I myself are in a very
critical health condition in which I sleep every night without knowing
if I may be alive to see the next day.

I am Mrs.Monika John Carlsen, wife of late Mr John Carlsen, a widow
suffering from long time illness. I have some funds I inherited from
my late husband, the sum of ($11.000.000,eleven million dollars) my
Doctor told me recently that I have serious sickness  which is cancer
problem. What disturbs me most is my stroke sickness. Having known my
condition, I decided to donate this fund to a good person that will
utilize it the way am going to instruct herein. I need a very honest
and God fearing person who can claim this money and use it for Charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained.

I do not want a situation where this money will be used in an ungodly
manners. That's why am taking this decision. am not afraid of death so
I know where am going. I accept this decision because I do not have
any child who will inherit this money after I die. Please I want your
sincerely and urgent answer to know if you will be able to execute
this project, and I will give you more information on how the fund
will be transferred to your bank account. am waiting for your reply.

Best Regards,
Mrs.Monika John Carlsen,
