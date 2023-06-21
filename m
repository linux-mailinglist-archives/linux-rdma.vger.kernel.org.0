Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B2D73846B
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jun 2023 15:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjFUNHt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jun 2023 09:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjFUNHs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jun 2023 09:07:48 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289681998
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jun 2023 06:07:45 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31126037f41so5649308f8f.2
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jun 2023 06:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687352863; x=1689944863;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TU5pe+asCSSBXdxRD62Pc73zx7uMR0rLSJrHUbp5re0=;
        b=CkUcMHVR+Z8yWrVCs3aa+R3jQV4jFsz4M5P2+9ftWZgzt/db2V9KrQOJMxJ11GhMwT
         hAUWMvFrEi/d7CfH6HI+KC5ld9dLAWsTabouLLOzs9dkdlrE7FpQ4f2msqpavhbA422u
         Cuix2KNbn4SkOv7AgpXv5F+qCn68JKCtGu+8+yEDR5xIpJogQEKUIBdi70OV5u40ETay
         PH4+qljOaIEG09l2kO/O5FKZplJPDhwdInH3YBc7tz5gLDA/1FS6JieSn676ZDAHvUVq
         9/0iAliOIzsBAlDf0OM3844UB/cUR0YMJAZTe+YI30MfMoVxhr94NC9haKVShpVdLDCu
         ng4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687352863; x=1689944863;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TU5pe+asCSSBXdxRD62Pc73zx7uMR0rLSJrHUbp5re0=;
        b=IWGTi+L8Jba5hkMf0EFxP6wMyrp/a4GVB6+abBH0D9QtWlLJ+2QrWKFvDpmlVH/h/l
         edwLlsXsrv41oBLIIIvhIS/A4Pvw5gV9yPhf8RX2j9wYpsWSj+qKGu5VVkj0oK88W4Ib
         czqO2vPrrMuBoMtXwfMATUIJBpmX5tilwqZuHmiL1ASA3eqN+U9zpv+pgEmABb96N/y5
         EN1Unt+Ci3FR/H81TG4dBo1zrKIqWIcUh2OYC8yugCMi/HxpT05m1GyaHgW5GlUWE4Wd
         ua1CWKohC/zyPzAumCDri904F1IP7WKwIEa5v2efHCJcQvimGYKTkWpjEbL5zuQ8PCAH
         jtLg==
X-Gm-Message-State: AC+VfDwuHDf2ia9HS6Z1Gpz8O8T9uNLoxMtLT5qdnpBBQkaMy6/5V0zP
        YVag0lS4ENR0Ig+VO41/03HsOInIVcl01i8CISw=
X-Google-Smtp-Source: ACHHUZ4DJdasIxxt0P5VQ3mJXiKww1/aS5p50nS9gK+lncj65MULR6+GXjSyIdfexJKVJjvw3OKC9Q==
X-Received: by 2002:adf:fe48:0:b0:311:10c0:85f0 with SMTP id m8-20020adffe48000000b0031110c085f0mr12540283wrs.14.1687352863404;
        Wed, 21 Jun 2023 06:07:43 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id f7-20020adff8c7000000b0030e6096afb6sm4453467wrq.12.2023.06.21.06.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 06:07:42 -0700 (PDT)
Date:   Wed, 21 Jun 2023 15:07:41 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Petr Oros <poros@redhat.com>
Cc:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        kuba@kernel.org, vadfed@meta.com, jonathan.lemon@gmail.com,
        pabeni@redhat.com, corbet@lwn.net, davem@davemloft.net,
        edumazet@google.com, vadfed@fb.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, saeedm@nvidia.com, leon@kernel.org,
        richardcochran@gmail.com, sj@kernel.org, javierm@redhat.com,
        ricardo.canuelo@collabora.com, mst@redhat.com, tzimmermann@suse.de,
        michal.michalik@intel.com, gregkh@linuxfoundation.org,
        jacek.lawrynowicz@linux.intel.com, airlied@redhat.com,
        ogabbay@kernel.org, arnd@arndb.de, nipun.gupta@amd.com,
        axboe@kernel.dk, linux@zary.sk, masahiroy@kernel.org,
        benjamin.tissoires@redhat.com, geert+renesas@glider.be,
        milena.olech@intel.com, kuniyu@amazon.com, liuhangbin@gmail.com,
        hkallweit1@gmail.com, andy.ren@getcruise.com, razor@blackwall.org,
        idosch@nvidia.com, lucien.xin@gmail.com, nicolas.dichtel@6wind.com,
        phil@nwl.cc, claudiajkang@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mschmidt@redhat.com,
        linux-clk@vger.kernel.org, vadim.fedorenko@linux.dev
Subject: Re: [RFC PATCH v8 04/10] dpll: netlink: Add DPLL framework base
 functions
Message-ID: <ZJL2HUkAtHEw5rq+@nanopsycho>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
 <20230609121853.3607724-5-arkadiusz.kubalewski@intel.com>
 <c7480d0a71fb8d62108624878f549c0d91d4c9e6.camel@redhat.com>
 <ZJLktA6RJaVo3BdH@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJLktA6RJaVo3BdH@nanopsycho>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Wed, Jun 21, 2023 at 01:53:24PM CEST, jiri@resnulli.us wrote:
>Wed, Jun 21, 2023 at 01:18:59PM CEST, poros@redhat.com wrote:
>>Arkadiusz Kubalewski píše v Pá 09. 06. 2023 v 14:18 +0200:
>>> From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>
>[...]
>
>Could you perhaps cut out the text you don't comment? Saves some time
>finding your reply.
>
>
>>> +static int
>>> +dpll_set_from_nlattr(struct dpll_device *dpll, struct genl_info
>>> *info)
>>> +{
>>> +       const struct dpll_device_ops *ops = dpll_device_ops(dpll);
>>> +       struct nlattr *tb[DPLL_A_MAX + 1];
>>> +       int ret = 0;
>>> +
>>> +       nla_parse(tb, DPLL_A_MAX, genlmsg_data(info->genlhdr),
>>> +                 genlmsg_len(info->genlhdr), NULL, info->extack);
>>> +       if (tb[DPLL_A_MODE]) {
>>Hi,
>>
>>Here should be something like:
>>               if (!ops->mode_set)
>>                       return -EOPNOTSUPP;
>
>Why? All drivers implement that.
>I believe that it's actullaly better that way. For a called setting up
>the same mode it is the dpll in, there should be 0 return by the driver.
>Note that driver holds this value. I'd like to keep this code as it is.

Actually, you are correct Petr, my mistake. Actually, no driver
implements this. Arkadiusz, could you please remove this op and
possibly any other unused  op? It will be added when needed.

Thanks!


>
>[...]
