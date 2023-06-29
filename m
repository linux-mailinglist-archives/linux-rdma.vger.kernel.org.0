Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CCA7423B2
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jun 2023 12:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjF2KGf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jun 2023 06:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2KEd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jun 2023 06:04:33 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B6E3AA3
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 03:03:25 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-313f3a6db22so516597f8f.3
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 03:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1688033003; x=1690625003;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uaMGImYnQKnsq7fsnwOVnpPcILnExtFuFwZ75WjZ+G8=;
        b=h+09ytWCV2amGFMopbaZtCXUJjJKz8DhAHtUefOVoKcGXTUaJcbmQzfziST1ySjwBs
         fwMco4LDFc2kq+ha49mXvjonPLONQbpv3VPtykCjLfssrCYQ4DbEi8P9yVzhmqZZxDA2
         qj4cQioeKR7RYGJx9ZwrtCpAPmq53BjVkt2tRarlOIUDH2Y1XbUgv9Mip5o2n88kjgEO
         Yu2e+7sJ/cxB/dBNmExZIehrl8FIx27R5lVO+qDZPbkA110hpbVEiZxm1g5PFoROd4mJ
         ucY4MkjHjiL+Wj2Ebd7rUzW+0Lq+eIYa+3auIEWrvhpKVopwKTYj+znGGMkMIrcfAWpM
         3/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688033003; x=1690625003;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaMGImYnQKnsq7fsnwOVnpPcILnExtFuFwZ75WjZ+G8=;
        b=OgF9HiJzM0NLYxcYtoUxa40BTpoejAtqGNa4N/+CcVidB0ySUXACJkDoabn0xYlr29
         y2iPYs3ubz85ejfT+jLl3IFIDGZ0WrBOuFDbCDP4e96W3pzSfHo2kRaQajSQGGADEp7y
         tw7jQXG2C8b5ffRwYRj2nUzPj0SqmM+BMzlxMNbPWxlqsUbYLKUoOxpJa4T8ynq6kOv1
         vDV3Xk34iSo9uneoNvzPmgARA2aT1syF1IISL/IUPIIYBjuHt8QwapEajPv1vWgmzFLd
         gdaRuzLZWspPIKHMLOO/yOJwzFkTsC7eK7xSIz+e2rQH1CWI1R8u9v4hzYU2tKo3fMAf
         irlw==
X-Gm-Message-State: AC+VfDwVYPrdmZy3SD7IXHYntj15SyL5p+/rt80twGE4/abqZryYRm53
        5df8zcvPyKnAxPzWODBMu4N+NQ==
X-Google-Smtp-Source: ACHHUZ4gGOlHZ3B9k0qBbIR5qB2LqkDmU6fIVVUkapqWekDMKRTnDoYalnmqNRmJCQ+KcYBUnFu3kw==
X-Received: by 2002:a05:6000:42:b0:313:e2c4:7bc2 with SMTP id k2-20020a056000004200b00313e2c47bc2mr14036940wrx.53.1688033003304;
        Thu, 29 Jun 2023 03:03:23 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l6-20020adff486000000b00313fd294d6csm7414075wro.7.2023.06.29.03.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 03:03:22 -0700 (PDT)
Date:   Thu, 29 Jun 2023 12:03:21 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Vitaly Grinberg <vgrinber@redhat.com>
Cc:     "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
        David Airlie <airlied@redhat.com>, andy.ren@getcruise.com,
        anthony.l.nguyen@intel.com, arnd@arndb.de, axboe@kernel.dk,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        claudiajkang@gmail.com, corbet@lwn.net, davem@davemloft.net,
        edumazet@google.com, geert+renesas@glider.be,
        gregkh@linuxfoundation.org, hkallweit1@gmail.com,
        idosch@nvidia.com, intel-wired-lan@lists.osuosl.org,
        jacek.lawrynowicz@linux.intel.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        jesse.brandeburg@intel.com, jonathan.lemon@gmail.com,
        kuba@kernel.org, kuniyu@amazon.com, leon@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux@zary.sk, liuhangbin@gmail.com,
        lucien.xin@gmail.com, masahiroy@kernel.org,
        michal.michalik@intel.com, milena.olech@intel.com,
        Michal Schmidt <mschmidt@redhat.com>,
        Michael Tsirkin <mst@redhat.com>, netdev@vger.kernel.org,
        nicolas.dichtel@6wind.com, nipun.gupta@amd.com, ogabbay@kernel.org,
        Paolo Abeni <pabeni@redhat.com>, phil@nwl.cc,
        Petr Oros <poros@redhat.com>, razor@blackwall.org,
        ricardo.canuelo@collabora.com, richardcochran@gmail.com,
        saeedm@nvidia.com, sj@kernel.org, tzimmermann@suse.de,
        vadfed@fb.com, vadfed@meta.com, vadim.fedorenko@linux.dev
Subject: Re: [RFC PATCH v8 00/10] Create common DPLL configuration API
Message-ID: <ZJ1W6Trfar7xxkJ2@nanopsycho>
References: <CACLnSDhkUA=19905RKk=f1WBkd3jTEDcvytJCgavi90FroXb5w@mail.gmail.com>
 <ZJ0/StDYFANB1COA@nanopsycho>
 <CACLnSDgudK155J8myg99Q+sr18sUy5nJOQsBWtgsFBPGRVhDCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACLnSDgudK155J8myg99Q+sr18sUy5nJOQsBWtgsFBPGRVhDCQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thu, Jun 29, 2023 at 10:26:28AM CEST, vgrinber@redhat.com wrote:
>Hi Jiri,
>We are pushing for it to be implemented in Intel Ice driver.

It does not have to be part of the initial submission. It can be
extended later on. Also, not possible to define the UAPI without actual
driver implementation.


>Thanks,
>Vitaly
>
>On Thu, Jun 29, 2023 at 11:22 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Thu, Jun 22, 2023 at 09:44:19AM CEST, vgrinber@redhat.com wrote:
>> >Hi,
>> >Could it be possible to add PPS DPLL phase offset to the netlink API? We
>> >are relying on it in the E810-based grandmaster implementation.
>>
>> In which driver you need to implement this?
>>
>>
>> >Thanks,
>> >Vitaly
>>
>
