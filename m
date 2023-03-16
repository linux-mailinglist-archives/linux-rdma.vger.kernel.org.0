Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0D16BD242
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Mar 2023 15:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCPOV7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Mar 2023 10:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjCPOV5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Mar 2023 10:21:57 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E6E16332
        for <linux-rdma@vger.kernel.org>; Thu, 16 Mar 2023 07:21:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r11so8380479edd.5
        for <linux-rdma@vger.kernel.org>; Thu, 16 Mar 2023 07:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678976514;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXeMKtIKHjsg7Op7j6slpwd6r2mcaZttOICdsCewQXQ=;
        b=nQ7L/lllKcjEptp704j+LMXbSbmNl4CTIimV3kNmQ+EZJNnERMJjkTmYRc0DramWtS
         W+wVSMe+ix295oPTTNeGyDvyEJ8fUdlqN/sAgsRNqRjVhOcwRhvi9M6F3AScBe9JhAXk
         wZg6+yD6DH9ma0/QOprcc+Rvj95z/XZ6srjX9z0QbQH0/ulpyieexUmmJu+o7id8jUKT
         eAPrUtiU4zCzbsvGWh1LIxmvDkQgNWmZ8994xm28uhohIm+u932quxGMhiwNGKp1BL+E
         ghMxaBA2YcNhAuNsBFRMEE8g+pptHM4UImsvYGiqoK4Ujc6cup5VwbRJ2+RMzkhfbAeg
         Nqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678976514;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXeMKtIKHjsg7Op7j6slpwd6r2mcaZttOICdsCewQXQ=;
        b=ET+0uLJ5zNC0B4O7gLcABZBhds5/96xu4uNmu4QKmujrKAxpuSYfjACIr3D1pfamAu
         kYJgl91IRZ99uK9T7r5rolLfwZQtOXnVQNem4uCwivVb4Na1u3FapU1rIe/z0cj84hF3
         MUH+ian7GUBLKwjUtRrj8jd4Rcor2E4yewGf+TsOkga4iXwuxoIP6WSRmzOnmT38e86T
         OEmCAO+SfrElf2VVfE+sAuKydCfBWsZBOyCNUGgTDA75sgKCvA0pgYpMt4mdKvZBBej9
         Gf5hgN5Fate5jOJxN52h2RcRh13T+hPpKQqEPT8HK3b0utkytZ5BvvZ0r1BUQbdaApoH
         Zx3Q==
X-Gm-Message-State: AO0yUKXAxNW6RtgithQn/OcaVewqenRjqU8/2WV6GvPuAQACBPOgiCCl
        YL2mBi1hRVgN1qEVJTJWiPxnlBB2u1dYh5Cmcu4=
X-Google-Smtp-Source: AK7set+StIpyQ/2MtcJUa6OSnYE9sMOqxifa52MSkychqG0PxBXKJ1FPQ1NyabTgenBL1V9Vcc2JLpnzCO279tdbHg8=
X-Received: by 2002:a50:cdce:0:b0:4fc:8749:cd77 with SMTP id
 h14-20020a50cdce000000b004fc8749cd77mr3180351edj.3.1678976514613; Thu, 16 Mar
 2023 07:21:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7208:13d4:b0:64:9cf5:1560 with HTTP; Thu, 16 Mar 2023
 07:21:54 -0700 (PDT)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <angelacoulibaly5@gmail.com>
Date:   Thu, 16 Mar 2023 07:21:54 -0700
Message-ID: <CAHipQu6GHyDBma-gyvp0J9fsc7koSt9orj_yUyii4rZKybn8NA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_99,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52a listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9965]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [angelacoulibaly5[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [angelacoulibaly5[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-- 
 Hi, Please with honesty  did you receive my last message i sent to you?
