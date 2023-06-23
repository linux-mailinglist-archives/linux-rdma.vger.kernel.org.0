Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4F773B20A
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 09:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjFWHsH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jun 2023 03:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjFWHsG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Jun 2023 03:48:06 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0F91992
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 00:48:04 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b466073e19so5597611fa.1
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 00:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687506482; x=1690098482;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=afzpoupdHBz4t80yeY68UW7BcSr6J0mUzcvK1xv8c1M=;
        b=y839S9kxd09ThLEfxmxC6oII3nMiQTOEHF9PojI9kiub9AcAU9VwNCWsdUi79zoGrL
         I53edaB4DcMZQQ0qflpJAUkvrrMC34ACSDUt0ujxI5pBdzcViBCk6n9FKsQqZhEr33/O
         VvEBWTcxrI6FtHpJuHeokazRCXKF4vksYk5o+OAae6lurukOLI6tXHVLSfb+Q+V7FEV/
         sf8imt+RlLt6Lat5yCvrtngprbPt26rUBnApAtbvCEbqlIgaWoDJC9mFHQOn0JbF41dG
         AZbWjTZ98aLp9MgUn+gURDvYq4bO/7X5+p/tQDFnf5y1CNMOL2mMEGQ/vOQjVcpXlF7u
         UTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687506482; x=1690098482;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afzpoupdHBz4t80yeY68UW7BcSr6J0mUzcvK1xv8c1M=;
        b=amcCEauysVOxWaitYGGBFpV4VlxF73qreWDOlWqmtAu+dQ2nu59ObnFXv1qk6mfmRJ
         Xw3paNaQREpwTYGGGG2iQSh5tgFb/8Nohx7rZpw4XNzY6INpcYAhirkx2yafTzG/xp8w
         lMGIekDIha+WzsawndIW2LmMrC2L1IZ1eRieYf0jJGtMELC4Xo+7nvJzT/q8fhiNSryH
         uvE9jGF2fHB31qB3MnWnf79iEFbZcuI1ifhdzeDDU3qflBvlXBKJO9mxiG2j9MwpuqkL
         kxlaq4gGSbmMetXBHmdM7EyhlO9VCBDcKwMuRKEr56d9gA1Nx3QEGTsvGVPmJjmKKR/y
         /rxw==
X-Gm-Message-State: AC+VfDz+/LBAlvWUGplFuRvTHvTNcMe574PBCN4ImlxUwa3TnRolrUU5
        XaQHHwIAry7xIJXrg3VE6bdvZg==
X-Google-Smtp-Source: ACHHUZ60rNJlS88ekBpJsTiP/YnYc408Z0GlUIj/k7KV/RQOAUp7f7ExOF4ZyFZ2IcPQ5FADHxaxYg==
X-Received: by 2002:a2e:9944:0:b0:2b4:6a20:f12b with SMTP id r4-20020a2e9944000000b002b46a20f12bmr13920987ljj.22.1687506482431;
        Fri, 23 Jun 2023 00:48:02 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id b18-20020aa7cd12000000b0051bf49e258bsm666413edw.22.2023.06.23.00.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 00:48:01 -0700 (PDT)
Date:   Fri, 23 Jun 2023 09:48:00 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc:     poros <poros@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>,
        "vadfed@meta.com" <vadfed@meta.com>,
        "jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "vadfed@fb.com" <vadfed@fb.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "M, Saeed" <saeedm@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "sj@kernel.org" <sj@kernel.org>,
        "javierm@redhat.com" <javierm@redhat.com>,
        "ricardo.canuelo@collabora.com" <ricardo.canuelo@collabora.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "Michalik, Michal" <michal.michalik@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jacek.lawrynowicz@linux.intel.com" 
        <jacek.lawrynowicz@linux.intel.com>,
        "airlied@redhat.com" <airlied@redhat.com>,
        "ogabbay@kernel.org" <ogabbay@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "nipun.gupta@amd.com" <nipun.gupta@amd.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux@zary.sk" <linux@zary.sk>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "Olech, Milena" <milena.olech@intel.com>,
        "kuniyu@amazon.com" <kuniyu@amazon.com>,
        "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "andy.ren@getcruise.com" <andy.ren@getcruise.com>,
        "razor@blackwall.org" <razor@blackwall.org>,
        "idosch@nvidia.com" <idosch@nvidia.com>,
        "lucien.xin@gmail.com" <lucien.xin@gmail.com>,
        "nicolas.dichtel@6wind.com" <nicolas.dichtel@6wind.com>,
        "phil@nwl.cc" <phil@nwl.cc>,
        "claudiajkang@gmail.com" <claudiajkang@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        mschmidt <mschmidt@redhat.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
Subject: Re: [RFC PATCH v8 04/10] dpll: netlink: Add DPLL framework base
 functions
Message-ID: <ZJVOMPQ1RHx5mapG@nanopsycho>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
 <20230609121853.3607724-5-arkadiusz.kubalewski@intel.com>
 <c7480d0a71fb8d62108624878f549c0d91d4c9e6.camel@redhat.com>
 <ZJLktA6RJaVo3BdH@nanopsycho>
 <ZJL2HUkAtHEw5rq+@nanopsycho>
 <DM6PR11MB46578CD80F96AB11AF2F81F49B23A@DM6PR11MB4657.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR11MB46578CD80F96AB11AF2F81F49B23A@DM6PR11MB4657.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fri, Jun 23, 2023 at 02:56:24AM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Wednesday, June 21, 2023 3:08 PM
>>
>>Wed, Jun 21, 2023 at 01:53:24PM CEST, jiri@resnulli.us wrote:
>>>Wed, Jun 21, 2023 at 01:18:59PM CEST, poros@redhat.com wrote:
>>>>Arkadiusz Kubalewski píše v Pá 09. 06. 2023 v 14:18 +0200:
>>>>> From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>>
>>>[...]
>>>
>>>Could you perhaps cut out the text you don't comment? Saves some time
>>>finding your reply.
>>>
>>>
>>>>> +static int
>>>>> +dpll_set_from_nlattr(struct dpll_device *dpll, struct genl_info
>>>>> *info)
>>>>> +{
>>>>> +       const struct dpll_device_ops *ops = dpll_device_ops(dpll);
>>>>> +       struct nlattr *tb[DPLL_A_MAX + 1];
>>>>> +       int ret = 0;
>>>>> +
>>>>> +       nla_parse(tb, DPLL_A_MAX, genlmsg_data(info->genlhdr),
>>>>> +                 genlmsg_len(info->genlhdr), NULL, info->extack);
>>>>> +       if (tb[DPLL_A_MODE]) {
>>>>Hi,
>>>>
>>>>Here should be something like:
>>>>               if (!ops->mode_set)
>>>>                       return -EOPNOTSUPP;
>>>
>>>Why? All drivers implement that.
>>>I believe that it's actullaly better that way. For a called setting up
>>>the same mode it is the dpll in, there should be 0 return by the driver.
>>>Note that driver holds this value. I'd like to keep this code as it is.
>>
>>Actually, you are correct Petr, my mistake. Actually, no driver
>>implements this. Arkadiusz, could you please remove this op and
>>possibly any other unused  op? It will be added when needed.
>>
>>Thanks!
>>
>
>Sorry, didn't have time for such change, added only check as suggested by
>Petr.
>If you think this is a big issue, we could change it for next version.

It's odd to carry on ops which are unused. I would prefer that to be
removed now and only introduced when they are actually needed.


>
>Thank you!
>Arkadiusz
>
>>
>>>
>>>[...]
