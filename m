Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA8B5A4D50
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 15:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiH2NOz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 09:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiH2NOW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 09:14:22 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CDE73317
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 06:14:01 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id v26so855259lfd.10
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 06:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=5SGZXXm779vUUr1cqzGV/gRigE4jlSEMeyxYIdb55pM=;
        b=JuH2DuBhqdooGDeH883fQInKWy+C9o/rlQH9zR2Rg7rLnNT8vQWi/d/pql0qHIyNzO
         0xCr/Mj0aNiyp5M+K6i2SauxP5CRm/Bs8kC+lcDo5tUF1/iNwWfIauloIR2P5f2A17VE
         GHDRE7h1ZBefbgdRhvl1+ijSL5bikibhK4eLlQIHwrR+hs3qROlhaikjsLyd9O47F6g8
         ZFHTh5VOiqkenHpaauukTp8mO067Y2DvSKcEP1BW9SvCo84REnPTkeeOZxjjF9KJ5kFi
         5fdVYIjs99Sgk6OVy8KlxA6xME7P7k5BAowfYe3aQS9tcu2Bx5qIf59QRAQFRjk6FFGT
         V/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=5SGZXXm779vUUr1cqzGV/gRigE4jlSEMeyxYIdb55pM=;
        b=Z6eQO0OPQFgaRRyerXQrGcDFJz1Hl5Hwzi11EutfN0u2ZFv4+AITaNxi55gFgHU9p/
         Ay0v0DfbnO+Z97eNDnDEW/Rp7OnUOLA9PEBhC4CVlADYR3RgfQUdutmLQ4yfkOavWotD
         NJxkvgobX+GnqvQ6Cv81N+shJXv4z3JOKOgewvPV1wriy0Z/6K381Kg/Z+xrf8GgEw39
         ac2wDGyV35o0O/38wId6NATizwzf6nUAkCMPYlkhcUT2beeSmhBlaV8IMnKS3oqNKWSA
         cjWH8vBLNCnmoAJyHBL2NWeoqNURr4JIVFubbd1G29+agE9iiJEubpn7boEAGrM16v7r
         OjXg==
X-Gm-Message-State: ACgBeo1NCYodMStvaqUEoFfSXFXEWC4rLK3nAeD18vgWEbf0/seUgqBG
        8+qFvNtsQctHpFI9mXMSVND2+rD81z1R2YlPsf0=
X-Google-Smtp-Source: AA6agR7kSZ3W0aPnlDsOm9XqEUTqV0E4ofM+7ZuKXF3HH/fn5crAd1jiF96UYXECTdAz25DRPOJVR/o+wjrQ8nRw42g=
X-Received: by 2002:a05:6512:b90:b0:494:6a80:c63 with SMTP id
 b16-20020a0565120b9000b004946a800c63mr1880465lfv.634.1661778833603; Mon, 29
 Aug 2022 06:13:53 -0700 (PDT)
MIME-Version: 1.0
Sender: sorerachid81@gmail.com
Received: by 2002:a05:6520:6104:b0:213:94e:9775 with HTTP; Mon, 29 Aug 2022
 06:13:52 -0700 (PDT)
From:   sofiaoleksander <sofiaoleksander2@gmail.com>
Date:   Mon, 29 Aug 2022 14:13:52 +0100
X-Google-Sender-Auth: hx7J8JWiLbPc9r2tM9sc1TOcz2M
Message-ID: <CAKL4mRenY6-217rDyFRi58ROnQ0E3c9gt5SMgkMYt64prswJ8w@mail.gmail.com>
Subject: Hello my dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_99,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_USD,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello my dear,

    My Name is, sofia oleksander, a 20 years old girl from Ukraine and
I'm presently in a refugee camp here in Poland. I lost my parents in
the recent war in Ukraine, right now I'm in a refugee camp in Poland.
Please I'm in great need of your help in transferring my late father
deposited fund, the sum of $3.5 MILLION UNITED STATES DOLLAR, he
deposited  in a bank in United State.

the deposited money was from the sale of the company shares death
benefits payment, and entitlements of my deceased father by his
company.  i have every necessary document for the fund, i seek for an
honest foreigner who will stand as my foreign partner and investor. i
just need this fund to be transferred to your bank account so that I
will come over to your country and complete my education over there in
your country. as you know, my country has been in a deep crisis due to
the recent war and I cannot go back.

Please I need your urgent,
sofia oleksander,
