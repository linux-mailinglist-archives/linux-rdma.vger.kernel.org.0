Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C467C5F2B
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Oct 2023 23:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjJKVeK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Oct 2023 17:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjJKVeJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Oct 2023 17:34:09 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503CFAF
        for <linux-rdma@vger.kernel.org>; Wed, 11 Oct 2023 14:34:07 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1dc863efb61so165312fac.0
        for <linux-rdma@vger.kernel.org>; Wed, 11 Oct 2023 14:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697060042; x=1697664842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eQIwabRI/uNovp4wm52uUbIH+HnR4FRH6bY2+vy0apE=;
        b=J6+RQtGumTMkfg8tgi7jcQS+eWbAO24O99KVnh9jaKR99+ZJZY6JAio7wsqBvUe15e
         1NjEniI4g/pQjCqBFo9Ge5bmiAISbilAmNwVssdZGvGbsGbk3hQLCTnstwRhkaiwuMIm
         XgxrDvYSvt7senZaIjSD9IqGyPhBYgOkLCWuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697060042; x=1697664842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQIwabRI/uNovp4wm52uUbIH+HnR4FRH6bY2+vy0apE=;
        b=OvPd8/lxZHeyJ2LBuPRSDdCPiXWpBKdgHGUo/w31vr60fF4u6aaXbRVt80EpnUW1/2
         t8IWJBU53u7pVYTYlZNGz105hK5TLBXf+xfS7MwkKXXR0X03karpVjMmUdTHiwpsVXd1
         KJJCFbRabgNd61aKZ408ZK6dU2X3ws9GhXPBfSLaAQ33YiuTwAptCFN7UcNc0sO9Krri
         rxQwoqzHLfw/tG4fhbLoSpyT11gSlYEmoW/9Uya6NKRvL9eZCL+3fxAAeSLlmsj88XRN
         bFBz5mmtR37GL/htLxSAcNRflRBECp98rlKGq5utAP4P+89nxUf502JnkMtKyTusXtVy
         H8oA==
X-Gm-Message-State: AOJu0YwSeCzkrOIp41yqX+VDCb0M6BZBbCnsu2pexY63L5nMp7MMGChj
        IpAG3YRVOB0oZ+qwpGyaYF4GBA==
X-Google-Smtp-Source: AGHT+IEY6hpryGK3ZRZpCZ/wGDkglUCLj6tPg6/csEmrRfqziDqNEb+8M1nyBYqN2l4rpesyafwOOA==
X-Received: by 2002:a05:6870:7ec2:b0:1e9:7037:6445 with SMTP id wz2-20020a0568707ec200b001e970376445mr5055718oab.20.1697060042036;
        Wed, 11 Oct 2023 14:34:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r27-20020a638f5b000000b0056b27af8715sm320743pgn.43.2023.10.11.14.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:34:01 -0700 (PDT)
Date:   Wed, 11 Oct 2023 14:34:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: simplify mlx5_set_driver_version string
 assignments
Message-ID: <202310111433.9BCCADED@keescook>
References: <20231011-strncpy-drivers-net-ethernet-mellanox-mlx5-core-main-c-v1-1-90fa39998bb2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011-strncpy-drivers-net-ethernet-mellanox-mlx5-core-main-c-v1-1-90fa39998bb2@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 11, 2023 at 09:29:57PM +0000, Justin Stitt wrote:
> In total, just assigning this version string takes:
> (1) strncpy()'s
> (5) strlen()'s
> (3) strncat()'s
> (1) snprintf()'s
> (4) max_t()'s
> 
> Moreover, `strncpy` is deprecated [1] and `strncat` really shouldn't be
> used either [2]. With this in mind, let's simply use a single
> `snprintf`.

Yes, please! readability++

> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://elixir.bootlin.com/linux/v6.6-rc5/source/include/linux/fortify-string.h#L448 [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
