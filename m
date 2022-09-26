Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60215EB41E
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 00:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiIZWDz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Sep 2022 18:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiIZWD3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Sep 2022 18:03:29 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1925CEA595
        for <linux-rdma@vger.kernel.org>; Mon, 26 Sep 2022 15:02:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t3so7482986ply.2
        for <linux-rdma@vger.kernel.org>; Mon, 26 Sep 2022 15:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=iG5IW0JSXvDHPUhBmm25KDoROGtwoeP9Wl6CEV+mS6Q=;
        b=bH3XVvyeNNuMBwR/KDblcgO2wUIe3I4i4JFu4GLyRW3ThKNDfrBq05Phn4EHue23/P
         tawL2FBLBw21ueE0Kq/yI94WBlcQv70rR0t2LTm8B0fHFZmExa3SKYQIjulYbRs/0Tj1
         luG85TwnLv50EaLXnj7tN3qys76U5cG24DrVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=iG5IW0JSXvDHPUhBmm25KDoROGtwoeP9Wl6CEV+mS6Q=;
        b=TL1FMdecjs3wQVACm5UZRvHpCAn1AsUPTSmPwGFtH12rZ0SZ0u9s2Y6SK8nLNV7S19
         stBM+u/72XYSObkZ6jjkJo4gZBZqdfRFaNdrTD/QJ/faQi8Ya60dfrHUnnpxlcvW4JOU
         lluENuO4yzNfSRLJNRsm0KOdM11E/0hjf4Nw7WML6XKO8SmRnxnQIVs3McOZnP7CFQ7M
         uiLKOeYFDj5yEh3nlBS6TUtXnWZWdcgMBsih+qNK0wx9rGgdcS6M68wr8kb4+TpOlhYh
         Hh9UFlkoqOPRx8b5lk4+Ki4lp73K4BcSLa72Q4s8cy8v7Xk6GaqtMMxJjw6PoFiN/Yzk
         kHYg==
X-Gm-Message-State: ACrzQf0b1L3Xam0MGNKHPlcmlwV2aSG6X4FwNBKkz/KbH3siU82/FUf+
        7tztibieeNH9ay4IpPOXHHQ9PA==
X-Google-Smtp-Source: AMsMyM6wNgrqDvRAOHLQVvZqYe6L7XT9isBSFukx03A5p2O37KxwRQFvgSB4cvWDSBH8916sJcBvCA==
X-Received: by 2002:a17:90a:6441:b0:203:6aa1:56f8 with SMTP id y1-20020a17090a644100b002036aa156f8mr888487pjm.25.1664229778898;
        Mon, 26 Sep 2022 15:02:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mn5-20020a17090b188500b001fd66d5c42csm7022967pjb.49.2022.09.26.15.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:02:58 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:02:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net/mlx5e: Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261502.1383266E@keescook>
References: <YzIestBCo0RL7sVi@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIestBCo0RL7sVi@work>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 26, 2022 at 04:50:42PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/222
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
