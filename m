Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C22A6C8A09
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Mar 2023 02:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjCYBq5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Mar 2023 21:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCYBq4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Mar 2023 21:46:56 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30247AF31
        for <linux-rdma@vger.kernel.org>; Fri, 24 Mar 2023 18:46:55 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id s8so4413973lfr.8
        for <linux-rdma@vger.kernel.org>; Fri, 24 Mar 2023 18:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679708813;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1cRiDtZyjpH8UUowiP+C7FXClzy38HXhFY9Gfav+GA=;
        b=k2+w05t9K0XTZ1IgTYdK9ekRbeXV+H1OsyR0xAPrL/ENiqECYMnnIBuM29c4rmG5M2
         gtCE7sYxPOlm1OMIv8PvglkI7f9K1e222bMwWu1WUkQraCf1DdNEtQJXpoERrBcYtUIy
         Zd86wsr4CGqSrp5tH9Rdf1AnRx5sFZV8OIaXJ1j2OKuNH+EFHgWSVwdcsIdhd/9K9OHJ
         6sq3rb2GRc+ksZ4JfKS+j3flGxvHfByEsAeT0yaNy5UvbViAREzuPB115IyTLu1Ngrez
         qE2VpdxWv+yWeyVBnn4MI5p5c2j75xIjZTr0p2w7lI2qPIT9pAcCsPwtrBwTTDEXpOAx
         xe0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679708813;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1cRiDtZyjpH8UUowiP+C7FXClzy38HXhFY9Gfav+GA=;
        b=hr1Qw6nTIvLpKfMdQGQkOmHav3s+DSfNd/uYd/ux+cZhYy8GUxoJ89j5mEpIKElF/Y
         i7zgGURTBOimtFPe4bBfVbXlrY7KZOHDmrbpgqYQjL2Ba31zgSLieXgHaS1CXrrRD4LJ
         4xFDSoPeTNxxIIKb7N4K9es/qUizwkf4cBkigmgmUBW7N32pc9Vw08U4B1isR8VvhRcl
         f1pau4HPgVs0J9VgjZJu+L+U+66NgP1QgoLLA+L1FFitxVsBs88+ccDTQ/PHC7fprtP+
         J0tguPK/mVCZqbKINrpSkkLhij0/dEmUXr+8jTuRwDKJmELLenoKejYKv8uT26ivi6pD
         9Fyg==
X-Gm-Message-State: AAQBX9e3XuDgS3rjIIqsy8z7frMSAsE0sqejo+osTbF75NMzkxeCzash
        Xm7VzhgwRLDBn9FRbPuzHHBoIVv6HtQhqfhaOA==
X-Google-Smtp-Source: AKy350ZGtnS1q+aVSgLMA1ZQXn8aqrpRbEn8Asjp5XxIHLqIZ1NC8eAMD1oPBGBhC8dOiZnl8VYt4220ONVkCt00KVM=
X-Received: by 2002:ac2:5dd7:0:b0:4ea:fa82:7f73 with SMTP id
 x23-20020ac25dd7000000b004eafa827f73mr1324844lfq.5.1679708813180; Fri, 24 Mar
 2023 18:46:53 -0700 (PDT)
MIME-Version: 1.0
Sender: raheemsterling419111@gmail.com
Received: by 2002:ab2:2988:0:b0:1ae:ed93:3365 with HTTP; Fri, 24 Mar 2023
 18:46:52 -0700 (PDT)
From:   Aisha Al-Qaddafi <aisha.gdaffi24@gmail.com>
Date:   Fri, 24 Mar 2023 18:46:52 -0700
X-Google-Sender-Auth: Fdy4y8lEqKJTpe14cbPHNSV0BqI
Message-ID: <CAN26_+GtEf+YTV7jEgNNx2nsS+RehVetO11ruiUazPK0LpyeUw@mail.gmail.com>
Subject: Your Urgent Reply Will Be Appreciated
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        LOTS_OF_MONEY,MILLION_HUNDRED,MILLION_USD,MONEY_FRAUD_5,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY,URG_BIZ
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:141 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [raheemsterling419111[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [raheemsterling419111[at]gmail.com]
        *  1.0 MILLION_USD BODY: Talks about millions of dollars
        *  1.7 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.9 URG_BIZ Contains urgent matter
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  1.4 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I came across your e-mail contact prior to a private search while in need
of your assistance. I am Aisha Al-Qaddafi, the only biological Daughter of
Former President of Libya Col. Muammar Al-Qaddafi. Am a single Mother and a
Widow with three Children.
I have investment funds worth Twenty Seven Million Five Hundred Thousand
United States Dollars ($27.500.000.00 )   I am interested in you for
investment project assistance in your country, may be from there, we can
build business relationship in the nearest future. I am willing to
negotiate an investment/business profit sharing ratio with you based on the
future investment earning profits.
If you are willing to handle this project on my behalf kindly reply
urgently to enable me to provide you more information about the investment
funds.
Best Regards
Mrs Aisha Al-Qaddafi
