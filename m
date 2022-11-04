Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E776196F6
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Nov 2022 14:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiKDNFO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Nov 2022 09:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiKDNFL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Nov 2022 09:05:11 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A982DA8C
        for <linux-rdma@vger.kernel.org>; Fri,  4 Nov 2022 06:05:10 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id f68so2353007vkc.8
        for <linux-rdma@vger.kernel.org>; Fri, 04 Nov 2022 06:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5p+2212nSs70KkMMypC1tbex5JQYbFSNyVBImxmcawE=;
        b=EWe/VEIPgEDuC4ALFRHz8MGvbLey2Ct+jg3a+a9n4u+IOmvbbp8xXz5iB6Fs8z2Xbm
         b9ilGiiTnbsVoAPVzHY8GPILvliiCuIZ0B2GA6zAyrvwcFjyM16xXFVMFcziEAj5ml5r
         JLPZNX5wHWffm0WE7q+xmQJMiu190ZpECmkvcQUjYYEdveSl1jKq9FLBB1q8yrBQ31G8
         XvJjedCFEXimQf2u9xD49ysAD6O6NnScbrjymzjN5RsQw551tGcbmubuOuchZlH7VPbY
         muEVN03nYo+/R4ReMg8PxDa7BemTA0n6WbIYjZFEoFqGLYqbIVFXa7QZKpYHTmThO+42
         MS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5p+2212nSs70KkMMypC1tbex5JQYbFSNyVBImxmcawE=;
        b=nVb7+Z3zb1p4x9ZjzLZjJrFMOtl1Dx0oGYNA2Du6Wtl8ixc7EW/r+32L1dSN5g/7Y3
         zp7xTDmNpqBNMyf3QsOgaklE+Tbdxc+r9P/hIinCEb35CezNh992+xuzifkJAsB2px09
         B2p5YM+JIwm1VROLnf6u3zMmYuJO3C0uSHQXmNewkO0PJC0Er1wazexj+b5IaNWKWBkm
         K7ICxXBKIydIlU/tCPYzBp4hDJhFv5wrwNKBqorcPQoBd3kQn2omN76Uex8sKxsYVGg1
         OgKOi2pA9DjF0Vt1cflq2PPjKo5Tf6ZiEMhexEd9QrMCPlTlL8jjmnmFgIcbmKL/MVuO
         xNCA==
X-Gm-Message-State: ACrzQf2xaQ+5PGUFNhhOEoQrqWZl7ql4Y5if+OJ5hsB9EpuDj9Ut535y
        0AvsCxaiF6XAxBQltkClOJihuiqSXZeJrYojbP0=
X-Google-Smtp-Source: AMsMyM6oPxXyeO3sUYBtKvpcdqQ+cODYUf3T/akeJLHgfyt896xxdOoQ3b8zvhBZ7+v63AAF4od2miwFNX2NZjYJEWQ=
X-Received: by 2002:a1f:c1d2:0:b0:3b4:a675:4346 with SMTP id
 r201-20020a1fc1d2000000b003b4a6754346mr19317083vkf.39.1667567108564; Fri, 04
 Nov 2022 06:05:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:a58d:0:b0:2f2:a342:51c1 with HTTP; Fri, 4 Nov 2022
 06:05:07 -0700 (PDT)
Reply-To: carolynclarke707@gmail.com
From:   Carolyn Clarke <brad.leagle011101@gmail.com>
Date:   Fri, 4 Nov 2022 15:05:07 +0200
Message-ID: <CAF=xrxSh2f3P-3UNO-0ohHTf+s+8cSCQMo+03TEx1qjTNO47og@mail.gmail.com>
Subject: Please Read
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Good Day To You

I've viewed your profile on Linkedin regarding a proposal that has
something in common with you, kindly reply back for more details on my
private email: carolynclarke707@gmail.com

Thanks,
Carolyn Clarke,
carolynclarke707@gmail.com
