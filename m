Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B01D5B06A5
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 16:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiIGObu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 10:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiIGOb3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 10:31:29 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BB22AC41
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 07:31:16 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id bj12so30730562ejb.13
        for <linux-rdma@vger.kernel.org>; Wed, 07 Sep 2022 07:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=UTPjlhWN0j/3cl0uibj9IdU3K9tIHCNTd74bAPWV+BQ=;
        b=boA3graP4wtJe8cwRxkMJy5rso3t9xyj4fxUFsG0Fez1aWDY0C6gZpYPvm/Hxa5tX5
         Zk+XDE4h4sSr3Kc7gAmKt5OJ7AP3AEEipJ5m7D7tQ5BTHkXWMmIdiC/g3MqGg04yG8Wz
         mFTYUlKwIYoLI0bvi9Q3MSV1athb174l2Ms/7z+L0TzD2CQLBWt0bOa5Jg9CBAeygplA
         zqROn488xUY/B608ffA8/XOsolF390gA0UeCbMrgWX87LxLuf34XOCHn+1VgcYnMY7Sr
         klavsMj/u/K0iLTegE+9syCXTdcAl7jimLLfNxQJoiGWtjh15Idxzz9bfpV/1Jhy4Wly
         oLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UTPjlhWN0j/3cl0uibj9IdU3K9tIHCNTd74bAPWV+BQ=;
        b=EcvpTO6DNGfy2QcrhE+rhD2C4U8f6QxrgcNwVH+7xF8iEG+clrZ8rOlaSyq4pyS5xA
         yG+fQsfMJ64uD5mke1Z3UmXkGJygmBJs3+PhZZhgZrS/K95LWrcO+0i0Ptr56/Ng3ziy
         ktryAUZ6SCkfurNhS7CCqDurulVZAISwVGQ5Faqy3DCpnrL7Yvkek/xNV7Y4FmyVk3xq
         3gXSClCnbr7Avs5Kj5pnN8mJH9pxksz4jj37DWEODUe2ksj21kIouybbmY0iX/N3fY37
         E6EZPRwG6eMeNljZgWikHKRh14A/wOquYBSUv8UumbtMAWWwwmUbK90P+8qyRisyxihX
         uXXw==
X-Gm-Message-State: ACgBeo0/ENL1enVGBwXuBEA1h5aDZq8KifzCoArXbLnp0wPgAVPnRgXY
        aBC8Ef6cmRQGBZKVDE0emJMC37wsXNvpi/FwTy8QUVJYTdWY1u0ubhg=
X-Google-Smtp-Source: AA6agR7OKiKkSx+MbdKnn4tKaQhdmVzFj2krU0Vhk4MjDetoGwDDBbw+8TT3Fj+g2bgbPAiBcK/73KQpnrd5Cpv4s3c=
X-Received: by 2002:a17:907:75ec:b0:741:484b:3ca4 with SMTP id
 jz12-20020a17090775ec00b00741484b3ca4mr2508106ejc.316.1662561074796; Wed, 07
 Sep 2022 07:31:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:3fc4:0:0:0:0:0 with HTTP; Wed, 7 Sep 2022 07:31:14 -0700 (PDT)
Reply-To: lumar.casey@outlook.com
From:   LUMAR CASEY <miriankushrat@gmail.com>
Date:   Wed, 7 Sep 2022 16:31:14 +0200
Message-ID: <CAO4StN0fh9iLpvL71MAvphxmFm4ur7+Op=qm5oJuhdRZZPJ3cA@mail.gmail.com>
Subject: ATTENTION/PROPOSAL
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.8 required=5.0 tests=ADVANCE_FEE_4_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY,UPPERCASE_75_100 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:641 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5003]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [miriankushrat[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 UPPERCASE_75_100 message body is 75-100% uppercase
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 ADVANCE_FEE_4_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ATTENTION

BUSINESS PARTNER,

I AM LUMAR CASEY WORKING WITH AN INSURANCE FINANCIAL INSTITUTE, WITH
MY POSITION AND PRIVILEGES I WAS ABLE TO SOURCE OUT AN OVER DUE
PAYMENT OF 12.8 MILLION POUNDS THAT IS NOW SECURED WITH A SHIPPING
DIPLOMATIC OUTLET.

I AM SEEKING YOUR PARTNERSHIP TO RECEIVE THIS CONSIGNMENT AS AS MY
PARTNER TO INVEST THIS FUND INTO A PROSPEROUS INVESTMENT VENTURE IN
YOUR COUNTRY.

I AWAIT YOUR REPLY TO ENABLE US PROCEED WITH THIS BUSINESS PARTNERSHIP TOGETHER.

REGARDS,

LUMAR CASEY
