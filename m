Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A6B648010
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Dec 2022 10:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiLIJXM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Dec 2022 04:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiLIJXL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Dec 2022 04:23:11 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB7A36C42
        for <linux-rdma@vger.kernel.org>; Fri,  9 Dec 2022 01:23:10 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3bfd998fa53so44789817b3.5
        for <linux-rdma@vger.kernel.org>; Fri, 09 Dec 2022 01:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w90NWJhw4FQfn+8z7KfpbjxiRrip6Hjp/8w4XPYddxs=;
        b=EGKppYya0mh2UCv3We3FEeNdvWfQjpFNmnKEVcLojyQXzK02OiLU3QdEfqiLnta5Ny
         dxZJotSxE66/4YTdSaqdaKwZVTwiSICf1TGPaXUxR1ED8cLdqvEUEzOgVGH3jMcP9eBI
         XOe7gJby5/DJ4FoO3YAGrcnMyMPstqrsdnO8zkpzoJCauajgkZBJiqFB7/uefyEQ5yWN
         WrSSZw74I5U7agJIwxxZIGfyD62aOmGWsDWpP6k1hjXq5NDESqo8D/pjN0BgRy1j8i0L
         Ra6wv2DutxQksgfKOGnEMu5JDVkIRUg6N5uJTtTIM8wXnjuLMHNk8jUrxFn7CpYvywHv
         5fFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w90NWJhw4FQfn+8z7KfpbjxiRrip6Hjp/8w4XPYddxs=;
        b=3ZDLpXZwHCJXBIgkyOacvxbDV+o1UJ8UeProS36hRKSuz304GZBKEUydzQCAluTPYK
         BLchwCBxQHCdI2dqEeu26ApNqpfvEF3alO3ERc5TBAroL/UxzFg/tuFw6Ll9puUuawuv
         3BwpxAXaeJxUvMJBWWaNBB/hDkuJ7p8lajeKiKzHDYRRjVWH4WpyxAYSUKHGQQWbc0d4
         Cp7G8RqEPY47oFih7HGkCu9TBI92mTybsNCTvER+v1EhMv3pWtDVPZJH6inCAaJjVTyL
         ahc68Y/hTya2J4Cyt7d3ZnLvLn0whD9PgpPkl+vBMSZP4pVdOfoFwi88qcraFucvdZMy
         VPCQ==
X-Gm-Message-State: ANoB5pl7sd4TfGzPnsm7cgi/XrzAAfvlvvf8YiSnzwHjKeVVguBDXpQb
        449Ohrp1HMjDm99Eb/2NVn4uQCBvOtBOOiNrbw4=
X-Google-Smtp-Source: AA0mqf5KAzBzhCKvGT3C8zmcgQSrruV6TOQhZb7TPuX05cfDSnh/lqfnDI584JJuuoSg8/Xfv/wbRbRVJepRzuKZjiU=
X-Received: by 2002:a81:7844:0:b0:3c8:cd0e:87d6 with SMTP id
 t65-20020a817844000000b003c8cd0e87d6mr46435432ywc.272.1670577789672; Fri, 09
 Dec 2022 01:23:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:a3a4:b0:319:90e1:bd03 with HTTP; Fri, 9 Dec 2022
 01:23:09 -0800 (PST)
From:   Bethany Logan <bethanylogan44@gmail.com>
Date:   Fri, 9 Dec 2022 03:23:09 -0600
Message-ID: <CAHobhXPoSaQ_WZtBgR-Deeaiftg38uX_YfPHJbMACX1q5GE1qw@mail.gmail.com>
Subject: hi
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

Hi Dear, I have a good proposal
for you.
