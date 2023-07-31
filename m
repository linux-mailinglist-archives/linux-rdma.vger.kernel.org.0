Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA17C769D10
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 18:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjGaQod (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 12:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjGaQo1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 12:44:27 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76A219B6
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 09:44:10 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1bb782974f4so3184350fac.3
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 09:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690821849; x=1691426649;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HbLoTZwYDVSsilHbvJKLPQ0BdI/lJzWgTKkVogNXl0U=;
        b=eNakMA5RXChe5HEYmcHeRqiP0onCPjR9hytbpckl7Slu79nxlsZhb7zDHG4+GV+l8o
         YcexPgGBwtBEpipioVt9r1yJx9MJ/nNcd/VPBEBm51SBcOrd/qXp7OkC+UBDgG4lEe+E
         Ip/hSxYAn1R/5M18psI8BblD/YYrcDBx26X+OOewZZtBf6RWWRhzPby1pVPfJ/sY24Ad
         zqZZW9j5hu2gdthSubxm+uq9xYBZq9Mp3SVl6MrUV3yGlfcQURCai5D6g6Xf0+6wfJHL
         oZgmEj44BQZriiXALk1/g0DsOFy6l3DF9hhlrzGoalDx2pf0fRDIm6yb0KbxkGCdsgdF
         TvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690821849; x=1691426649;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbLoTZwYDVSsilHbvJKLPQ0BdI/lJzWgTKkVogNXl0U=;
        b=joPU4JE3l0X5jACtb4gP9HmXPwvcL7eOzkCKMc8buTQB3JdBMIa9IeQY1TYF19b2wO
         4rHdTvLmXLmM7solzV5cv3YjzMruA8H/Rkn7FsAz+45h4ES7laYLaNuxP+2ftUS4QxgU
         PojzlyA4fEGdJfKmcuwPxC4OcGIb1mcWvYZ8M0I5uy5PppMtTEs4w8jBQhba2d3U412W
         8o21oDu0/8rQHcftu3rZuHJ0KA66XjHWofcFBXk90e9lVaYhLxaxZlp2pFbEEIgZ4qcL
         oYqhL3iPcjwVcgxbSWS12ZXSuGHHufNnOYadstivlFX/2ZpFNOqXsi3TUpeSwsZwHHRv
         v2KQ==
X-Gm-Message-State: ABy/qLYTxzBq281QOJ/eT/TiwCO3uY7NWLQjWYyIeQltUgp/z7UawPYp
        YDVyRk1E3sVq8LBYM4hstQh9/bkHpl+8gzkippM=
X-Google-Smtp-Source: APBJJlGdqxrSOvVmRYUJ+71qtXgf6G8k7KdpbOsIm86avvggkmXQHxsLM5UJ6OcBPfu98aOoHC1P97xkCcVubPUB8O4=
X-Received: by 2002:a05:6870:7024:b0:1b0:218b:8acc with SMTP id
 u36-20020a056870702400b001b0218b8accmr11363910oae.7.1690821848627; Mon, 31
 Jul 2023 09:44:08 -0700 (PDT)
MIME-Version: 1.0
Sender: mrsnadiaemaan50@gmail.com
Received: by 2002:a05:6870:c150:b0:1ad:2669:61b1 with HTTP; Mon, 31 Jul 2023
 09:44:08 -0700 (PDT)
From:   Stepan CHERNOVETSKY <s.chernovetskyi@gmail.com>
Date:   Mon, 31 Jul 2023 17:44:08 +0100
X-Google-Sender-Auth: BgpO5eOkefHuW6yo_zR4TVCC8_8
Message-ID: <CAPG80=DP-Lv8QiXjDv7x1wHBM-oDO5PpLLtUtQiDkwbvbN4X4w@mail.gmail.com>
Subject: INVESTMENT PROPOSAL
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.2 required=5.0 tests=ADVANCE_FEE_5_NEW,BAYES_50,
        DEAR_SOMETHING,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:36 listed in]
        [list.dnswl.org]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrsnadiaemaan50[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrsnadiaemaan50[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.0 DEAR_SOMETHING BODY: Contains 'Dear (something)'
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 ADVANCE_FEE_5_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Dear Sir/Madam,

Please do not be embarrassed for contacting you through this medium; I
got your contact from Google people search and then decided to contact
you. My goal is to establish a viable business relationship with you
there in your country.

I am Mr CHERNOVETSKYI Stepan. from Kyiv (Ukraine); I was a
businessman, Investor and Founder of Chernovetskyi Investment Group
(CIG) in Kyiv before Russia=E2=80=99s Invasion of my country. My business h=
as
been destroyed by the Russian military troops and there are no
meaningful economic activities going on in my country.

I am looking for your help and assistance to buy properties and other
investment projects in your company or in any good profitable business
that will give us good profit, I
consider it necessary to diversify my investment project in your
country, due to the invasion of Russia to
my country, Ukraine and to safeguard the future of my family.

Please, I would like to discuss with you the possibility of how we can
work together as business partners and invest in your country or in
your company through
your assistance, if you can help me.

Please, if you are interested in partnering with me, please respond
urgently for more information.

Yours Sincerely,
Mr CHERNOVETSKYI Stepan.
Chairman / CEO - Chernovetskyi Investment Group (CIG)
