Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986815A47AC
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 12:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiH2K5h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 06:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiH2K5g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 06:57:36 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7969A5C9F0
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 03:57:35 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id u9so14912972ejy.5
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 03:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=fooWRCRQ5NpQZAtgv4vB54UA5EbZwRKA5syR72kvTKfskVQQQsyyvhMXSWpZNWUCzG
         WKZmpVnAnkgu+stfccMam/jxsKt5Iwuql93cZfXd6rBIOQnLiQE0/YJXDBZVwHgHFr7U
         i1aGZPPwZSV3dfLUOgQvHxpMnXwo9uO6PoAYP/gwvY+0y1JE6QTfcS3f+Z8v9tlaONsl
         KSOvBftrnR+Ba9JE8Q2HzCgFvAIkwuAxTkENr/vcK18/6zwBwZQfR8Yvi6Xau8uA+DTP
         dCHbcQCdKIxR5zlsbspEfZ11xB4Lh0T/rwJ7Ev4Rw3HlwOsK0c7LccTVec85OcZ160uj
         Cc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=Df8hpFTzFLJVoL25g9U3m4nDAdAXOPtlPsn9Q4fyHafmm3H0RwXrvm6RdDX4mLHPzr
         HHKBWSWGRQOhBILenAkb9jHZnzsHTPA0Eq9FYMSRDvrQ48DMKCvRX4OpfTD95lpKNH5S
         75fjhiEs07eL9/ZjYpPwX/yj7kRz2wBA05iaM6//4RxlKQiMvh21T40TOHHsSChMIj0m
         osjg4aNYOj1b7axe4Q3+Do0AxOp5Vc/BSmJ5CcAttUVozJSnsnTCPpE97fjXBu8fCFN0
         94qXncdICmfabDQUHvwNkSVzmbczR6dv/uU4r7aCrTmEJdmP+ONPEPLTB3S+kMGBYYtb
         lnmw==
X-Gm-Message-State: ACgBeo3pk3Q6RDLQIHnVfrzDO3ta5an5J/eXxcH0zU9HuNkHJHtYK+K+
        61gO3wWfDhm7pLUIrdF6mBakD3xf0sw3q5aGj4s=
X-Google-Smtp-Source: AA6agR7Er0u+uQdG1mLLDCCLQ/1W45lRt9P/WAHBZb6JBMNytmpHUN6LODfnUL7GmJHB4H37sUHUt+NOiQHadhDeGas=
X-Received: by 2002:a17:907:1b0e:b0:72f:9b43:b98c with SMTP id
 mp14-20020a1709071b0e00b0072f9b43b98cmr13140053ejc.710.1661770655040; Mon, 29
 Aug 2022 03:57:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:a90:b0:22:8059:1af9 with HTTP; Mon, 29 Aug 2022
 03:57:34 -0700 (PDT)
Reply-To: davidnelson7702626@gmail.com
From:   david <nenkan1975@gmail.com>
Date:   Mon, 29 Aug 2022 11:57:34 +0100
Message-ID: <CAFO9AXj6wwXLhPuk-ydB02SZw8bpW_QuA2YqEBw5N22abOq3vg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:643 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5002]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [nenkan1975[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [nenkan1975[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [davidnelson7702626[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello friend, I want to send money to you to enable me invest in your
country get back to me if you are interested.
