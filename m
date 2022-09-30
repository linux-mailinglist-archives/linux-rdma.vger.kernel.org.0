Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483775F0D86
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Sep 2022 16:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiI3O3L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Sep 2022 10:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiI3O3K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Sep 2022 10:29:10 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0661A10BB
        for <linux-rdma@vger.kernel.org>; Fri, 30 Sep 2022 07:29:10 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id t16so4994227ljh.3
        for <linux-rdma@vger.kernel.org>; Fri, 30 Sep 2022 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=WT82etd91PDSUL/8+27QkPwmNaDjHjZz1/B6ldVoOBw=;
        b=qQwpEE3Vy0et5Pgd1C+v2Cb2jDwJKcF3YBx1PAqtmTavWYvA/Zl/C6j/3swr1KRgxg
         25BjWNOMv57LBEf9a3F8cWMYYJeIftolo2BX+5dk/DIziEv6waQf0B0gbmD/25yefFBR
         RB8BOpOgxlLQ8BGC5Q9S1d8TgDZ0iluyx2TZcDSOqrhKwpPAcZpSZR0pqIMyGQuyCXfn
         kCvVP1Sj87QoslCypJV4h6dDgmPRU4ZDIF1wu5riZPI27bFjbSK292k45+MASX6i0ptF
         QEve4gNJnaOl5lnbrDoROPYvF7CMUpSZGfwVRpy5bLGlPZUrTVWjsHPcEthPx8xxMSar
         xdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=WT82etd91PDSUL/8+27QkPwmNaDjHjZz1/B6ldVoOBw=;
        b=PIhDL2xlK6OuhEl1szCGyo2eoiS7cpIkioEX/DTgp4omXnjZraeQ6KFQampMuBlUns
         L1G6j5BS0EF9aJ6WGVZGLO/EBgWQggGW9cIbC9C+uUQN26VPTMmIGgwIHqrWYS6CrxXw
         S/FD+HogTZtSlAvj17Bl2DF7GaileldS72ZmOUgT96Qvr5h6ptaUlZWiPYgfPbIaHvv/
         Xa4GLbBMW2S23FzjwOgN92+fGqP4pSFxPnKBQ/2NF9cYZlXAG+gk3WckhoEeAhoWfhJm
         G7Lz6JeWn4oa5ZXu02PFQHGZwh4QpAcvU9/TOA/vr0GFYyEOxhY0qDJlMBYibd5VMtqX
         LNqw==
X-Gm-Message-State: ACrzQf3T5/SWTXCNsn57P8Jp7ytel12eNYHPtiIImoeX1cmGR8StuUlX
        IhFhoRRmWfCiHaHUmL1xjc3n3zmqGKLu0pW833Y=
X-Google-Smtp-Source: AMsMyM72WQxG7/L6ffIXlZ6UHWzuhPwi2aKI6Pkk542Z9Fc/DBeu9/8ArwRfZ8tavgTklPKU543fgnsoB8v5KdORAU8=
X-Received: by 2002:a2e:8014:0:b0:26a:d12c:3719 with SMTP id
 j20-20020a2e8014000000b0026ad12c3719mr2977652ljg.472.1664548148526; Fri, 30
 Sep 2022 07:29:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:3daa:0:0:0:0 with HTTP; Fri, 30 Sep 2022 07:29:07
 -0700 (PDT)
From:   Maya Williamson <aw7338485@gmail.com>
Date:   Fri, 30 Sep 2022 14:29:07 +0000
Message-ID: <CABCwc84QyuP1tydGn4Qp26qB_MZELTgn_ZNW0ThE4_p6q5cZNg@mail.gmail.com>
Subject: re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-- 
Hello,

I'd like to talk to you

Maya
