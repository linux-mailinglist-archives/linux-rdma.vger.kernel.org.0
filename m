Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5698A765DD7
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 23:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjG0VRD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 17:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjG0VRC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 17:17:02 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F5930E4
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 14:16:56 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-c4cb4919bb9so1377435276.3
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 14:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690492616; x=1691097416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uGRhmfCXLxN6YU1cWESg55BRtPox1xD8u6NHDhwMzU=;
        b=wswgZlkJ4NBe7/FtnWso7C3R/rqxZSJUmuWg9QHSi9JMGr8w9D2uQzTwgYsequJulq
         is/1hwyg+1vqmZ9shtq1fLohk50d+i8QBH94zB9Ej1yzYbUEOx8Q8l3bt0oVwirfr+xh
         AcGAad0J9UQ+W6bzboUyHjcJsZi+WSrDF+7OkvzGWimEu22FXf1MLJ5EWwQk8FgWWRli
         5nuxAenh9aEGSFI3R+2Wy25KS6nV9YXFHtJMJgUjRnHRAdpCMvCEBYpGfAgwwEMdv3tk
         6JayWaqklc5v3KEH7PSXfzGTJ/CMqnzNShHlNUjbz1y94StJOZzcLCOnavQ4iCJKf8+F
         iyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690492616; x=1691097416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uGRhmfCXLxN6YU1cWESg55BRtPox1xD8u6NHDhwMzU=;
        b=T01Vkh2Ewy5O+JRXgnjaNbF8pP+CWwt1Bn+7SxjiaA2bFMrmBap8Kfp6t3lvH5FKyx
         J92Hsj0YEnHE7IuFo0CRKzRsN+gZ2NAvCT9y8w08BqE/YwqRSia9xDRAQmHEyxIu7U9D
         mKAY3Iq6vg9sUxlawBg27+MhH+6hS95L+58YcHUcyR2cJuMZNthfOaF5u8SfGcSn48sY
         iMqjz78ncnlXyFpQWczlHrAcUIvb7NYqcrcmOa038cE8S/lHT4X7ERR3yDaq7aNvdPDs
         KkPZlnZii4u09IyF07xGqVbzSn5rrJxdGftENlGmKpBTA8Js7v6Oc5Mpdu0++JOpKxjr
         AwYQ==
X-Gm-Message-State: ABy/qLYT23V/R+/JmtovMlavyyZ5X853gLkUH3hdyKNHXiZ/mUqbH7MU
        vcLSH5/jWAxw6ZoaHXAM+jxatZ+2D2Yi0FDWG/q0eA==
X-Google-Smtp-Source: APBJJlF/WP9UF5vhbN5Eh27rtP31+QJ0KngVSCOWM/D/823cWc4t3dHqdkGuZ+k5czJWqkSh0GU74FyljZsGrCSOQus=
X-Received: by 2002:a25:fe0f:0:b0:cfa:f7cb:be16 with SMTP id
 k15-20020a25fe0f000000b00cfaf7cbbe16mr513279ybe.49.1690492615774; Thu, 27 Jul
 2023 14:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com> <20230623123820.42850-8-arkadiusz.kubalewski@intel.com>
In-Reply-To: <20230623123820.42850-8-arkadiusz.kubalewski@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 Jul 2023 23:16:42 +0200
Message-ID: <CACRpkdar39x8nd5cWEDiFDHwLqHghUQZqkR0rEcv2-sZOZZ0KQ@mail.gmail.com>
Subject: Re: [RFC PATCH v9 07/10] ice: add admin commands to access cgu configuration
To:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc:     kuba@kernel.org, jiri@resnulli.us, vadfed@meta.com,
        jonathan.lemon@gmail.com, pabeni@redhat.com, corbet@lwn.net,
        davem@davemloft.net, edumazet@google.com, vadfed@fb.com,
        jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        saeedm@nvidia.com, leon@kernel.org, richardcochran@gmail.com,
        sj@kernel.org, javierm@redhat.com, ricardo.canuelo@collabora.com,
        mst@redhat.com, tzimmermann@suse.de, michal.michalik@intel.com,
        gregkh@linuxfoundation.org, jacek.lawrynowicz@linux.intel.com,
        airlied@redhat.com, ogabbay@kernel.org, arnd@arndb.de,
        nipun.gupta@amd.com, axboe@kernel.dk, linux@zary.sk,
        masahiroy@kernel.org, benjamin.tissoires@redhat.com,
        geert+renesas@glider.be, milena.olech@intel.com, kuniyu@amazon.com,
        liuhangbin@gmail.com, hkallweit1@gmail.com, andy.ren@getcruise.com,
        razor@blackwall.org, idosch@nvidia.com, lucien.xin@gmail.com,
        nicolas.dichtel@6wind.com, phil@nwl.cc, claudiajkang@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-rdma@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        poros@redhat.com, mschmidt@redhat.com, linux-clk@vger.kernel.org,
        vadim.fedorenko@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Arkadiusz,

On Fri, Jun 23, 2023 at 2:45=E2=80=AFPM Arkadiusz Kubalewski
<arkadiusz.kubalewski@intel.com> wrote:

> +/**
> + * convert_s48_to_s64 - convert 48 bit value to 64 bit value
> + * @signed_48: signed 64 bit variable storing signed 48 bit value
> + *
> + * Convert signed 48 bit value to its 64 bit representation.
> + *
> + * Return: signed 64 bit representation of signed 48 bit value.
> + */
> +static s64 convert_s48_to_s64(s64 signed_48)
> +{
> +       return signed_48 & BIT_ULL(47) ?
> +               GENMASK_ULL(63, 48) | signed_48 : signed_48;
> +}

Can't you just use sign_extend64() from <linux/bitops.h>
passing bit 48 as sign bit istead of inventing this?

Yours,
Linus Walleij
