Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684DC615FD9
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 10:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiKBJd2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Nov 2022 05:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiKBJdZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Nov 2022 05:33:25 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AEE95AB
        for <linux-rdma@vger.kernel.org>; Wed,  2 Nov 2022 02:33:22 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id sc25so43623265ejc.12
        for <linux-rdma@vger.kernel.org>; Wed, 02 Nov 2022 02:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xekgv7hlWx7bzbvREmX1x3qWnu+QmgOoSi/q6Y1y2mA=;
        b=fAn8eG5WBN7wK9mr0LYPFXoqIyfUQoqX5WHIdz6HuJj807wPj0Qa52ujHHMvBGLMKe
         8QLBa9FaPt5vQUmps8N/Zd9xPuJnjWSTNdU+mz79uSrrLsPCItn3WIpCqTxXE4SmuE0x
         2DqJD8UmLyK0x4bE9cfFTOdn8muowio5RNFbLACimzwpsUiLffj9fBt+1oDMEbGFVKrw
         NyWwbXbgBxWQ839rPKUWEfnjddrVoPBplxQvoE/aZmQd6+8PZPOlOW4DVYPTFTtGHtee
         nyAT9cU0ikNdKvhLAZBRMym9D5HI3lN73Ss71QUzaBoA1Zgf4m2/d/ckjcQr7ciavENv
         4NmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xekgv7hlWx7bzbvREmX1x3qWnu+QmgOoSi/q6Y1y2mA=;
        b=PtDAe/bUdnOz9CefE+e6E/geAP9a0JDXM76B6HHQ0yEugy9eltHfg/FJIfffpILImC
         R8uzjc6k4+PT478QjrN/6WNKIwXdzbiBJYGzH6luU7ibTIBekOgGVdx6o7aaN8qjW7du
         1ZrqACW9HAzGcf78HuTeYngjrF23BuyJNKlJ1BC8GsBDi6l19Q1KOemJBKBKoAUmeukX
         sro+d/MNMMGotXTaVedlmdHnsI5XLFVeC9siEMnU896Tds+HsCN6JRvfHHiHkHiep12H
         WSg4EXzeflhB8sQXOASf51424H8iH1kkzjPh9yhJMlWgvIPVG2YJ0oJY5pWD4y/iIFs0
         eZAQ==
X-Gm-Message-State: ACrzQf2R44CLp/wy9rFeecB4aFibJ73VW1x6vo3elokto2oKxSIn4pwr
        MCZQzd55ThrZSGWPMXl02Vom+w==
X-Google-Smtp-Source: AMsMyM47VZ+b2yTjH/WGB3LoMpOnr8cV7ZmnAnuW1lcWjM3AfzJjkPVT6t3jFH7vUn1ODbOMYfIwWQ==
X-Received: by 2002:a17:907:80a:b0:783:2585:5d73 with SMTP id wv10-20020a170907080a00b0078325855d73mr22356782ejb.642.1667381601076;
        Wed, 02 Nov 2022 02:33:21 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o17-20020aa7dd51000000b004637489cf08sm3092370edw.88.2022.11.02.02.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 02:33:20 -0700 (PDT)
Date:   Wed, 2 Nov 2022 10:33:19 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, tariqt@nvidia.com, moshe@nvidia.com,
        saeedm@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [patch net-next v3 00/13] net: fix netdev to devlink_port
 linkage and expose to user
Message-ID: <Y2I5X4eMnisedAE5@nanopsycho>
References: <20221031124248.484405-1-jiri@resnulli.us>
 <20221101102915.3eccdb09@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101102915.3eccdb09@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Tue, Nov 01, 2022 at 06:29:15PM CET, kuba@kernel.org wrote:
>On Mon, 31 Oct 2022 13:42:35 +0100 Jiri Pirko wrote:
>> Currently, the info about linkage from netdev to the related
>> devlink_port instance is done using ndo_get_devlink_port().
>> This is not sufficient, as it is up to the driver to implement it and
>> some of them don't do that. Also it leads to a lot of unnecessary
>> boilerplate code in all the drivers.
>
>Sorry about the late nit picks, the other patches look good.

Nevermind, will fix those.

>Nice cleanup!

Thx!
