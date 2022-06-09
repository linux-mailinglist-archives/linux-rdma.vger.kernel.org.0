Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D049544DCD
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jun 2022 15:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbiFINgR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jun 2022 09:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239593AbiFINgP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jun 2022 09:36:15 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC594B870
        for <linux-rdma@vger.kernel.org>; Thu,  9 Jun 2022 06:36:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n10so47552809ejk.5
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jun 2022 06:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=aviE7mHKVUZ00EzCDsiL0+rxTiLNCOx2+AvKoknl1yc=;
        b=oAP3/xXbwivou1cjC5brhFAWakoZZHqpGTypSiDS8lnRUU47sw33UkrgBipx9oudEI
         /8H2Pc3TSWuN0noV33KZ6OJC3YkRVxXGAggSX6GqOM+MXYxdL9BaMj3Fb+NN3C3SiHFu
         7oHRVDuDmdXd9XT+6j2lVLF1m18QP81Nah503Anzy3AIli0hR5XpzmYqh3n6loNjfSwq
         yI8IN1KtRVJihDSAZF9mEgFO6/YbwwUVSd1JDofm9pKGR4nimLFjU0kbrzcAmcFXqnRS
         rXVr+cp3fdKwMZdIOTV8wt9zhK6+zypyQMabzGfRxbvbggAGplt4nU/uGg7YIET5W42E
         Uw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aviE7mHKVUZ00EzCDsiL0+rxTiLNCOx2+AvKoknl1yc=;
        b=5X8glbF5Ty4f4xSlBGIEbYWL5dzrFiMK7uw/IbjN9Tdd5ioUkiA/pOcHbQJv41Kt6e
         E/pTwv/5ESsgCyyIaUXUEYWuyQvW0cFctxV3/CQudrkdqzdNQtSv7VJ0yhsmi7bLiZN1
         pSzeftm+CkkpDxmrf629diNINGr8rQd3Dl/Pyh5m8b0idR2JkVkwDrVktKUQG4DUe0Pv
         jP61vSrC14Y+l06iJQo2EpvpVJyECS7yuRxiOdiJblTwjNZTJcq59nC1mOPZrhmjS1bD
         T15+ZBirripCLQsJ3kPDoyJDDaEtflsssoaBRQJhma5J2HFYYH46/TOzcZy4wNLSDCQC
         iZYw==
X-Gm-Message-State: AOAM532QxFYcHvcwUjGdjesfX2qbwVRan4bg0TpW7y0ixMIHbwpcnI4N
        VBUOJ+PNoWJ1l/HYOYBVxLlBMw4XgDDmiB62Qs8=
X-Google-Smtp-Source: ABdhPJxCAs8xWBIFtF8AUu6NWxlXFDnDLBJOrRIJ1SFsB9tCZbBUAWtV8nEiW5bE5gjpffdMd6gijIYQXpjsGbPRLtQ=
X-Received: by 2002:a17:907:9813:b0:711:d5ac:b9ef with SMTP id
 ji19-20020a170907981300b00711d5acb9efmr17300322ejc.95.1654781772119; Thu, 09
 Jun 2022 06:36:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:34c7:0:0:0:0:0 with HTTP; Thu, 9 Jun 2022 06:36:11 -0700 (PDT)
From:   Cheng Lee <clee23916@gmail.com>
Date:   Thu, 9 Jun 2022 15:36:11 +0200
Message-ID: <CAAUA_X9njiZAFw_ypP5H54wKZEnzL1WzC4+=t2NxL9JEuh-Grg@mail.gmail.com>
Subject: GREETINGS,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,
        MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:630 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [clee23916[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [clee23916[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 HK_SCAM No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Greetings,

Assalam alaikum,
I have a proposal for you, however is not mandatory nor will I in any
manner compel you to honor against your will. I am Mr Chen Lee, I am a business
partners to former executive director of Arab Tunisian Bank here in Tunisia;

HE retired A year and 7 months ago after putting in 28 years of
meticulous service. During his days with Arab Tunisian Bank, I was the
personal account officer and one of the financial advisers to Mr. Zine
Al-Abidine Ben Ali the past Tunisian President in self exile at Saudi
Arabia. During his tryer period he instructed me to move all his
investment in my care which consists of US$115M and 767KG of gold out
of the Gulf States for safe keeping; and that I successfully did by
moving US$50M to Madrid Spain, US$50M to Dubai United Arab Emirate,
US$15M to Burkina Faso and the 767KG of gold to Accra Ghana in West
Africa as an anonymous deposits, so that the funds will in no way to
be traced to him. He has instructed me to find an investor who would
stand as the beneficiary of the fund and the gold; and claim it for
further investment.

Consequent upon the above, my proposal is that I would like you as a
foreigner to stand in as the beneficiary of this fund and the gold
which I have successfully moved outside the country and provide an
account overseas where this said fund will be transferred into. It is
a careful network and my voluntary retirement from the Arab Tunisian
Bank is to ensure a hitch-free operation as all modalities for you to
stand as beneficiary and owner of the deposits has been perfected by
me. Mr. Zine al-Abidine Ben Ali will offer you 20% of the total
investment if you can be the investor and claim this deposits in Spain
and Burkina Faso as the beneficiary.


Now my questions are:-

1. Can you handle this transaction?
2. Can I give you this trust?

Consider this and get back to me as soon as possible so that I can
give you more details regarding this transaction. Finally, it is my
humble request that the information as contained herein be accorded
the necessary attention, urgency as well as the secrecy it deserves
I expect your urgent response if you can handle this project.

Respectfully yours,
From:Mr Chen Lee.
