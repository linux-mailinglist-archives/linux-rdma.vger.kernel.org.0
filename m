Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C274C740FE5
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jun 2023 13:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjF1LQT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jun 2023 07:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjF1LPt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Jun 2023 07:15:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CA7268F
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jun 2023 04:15:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-311367a3e12so6987361f8f.2
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jun 2023 04:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687950944; x=1690542944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vYX8/ePECLgfWoMNpv2uZz3s+XofYXzTKNlcug8MZ0c=;
        b=fqqAWDgaS+bOqIJSzLWZRezOltTA++pw4kHhHgds2mzu/vkKTntgTtpCB6A6nB4cX6
         hpWgvj+S5sTJWYH0Kr+F1cT48fn2V/s+cwGaHSC58PY3OGaapWhbc+j1oQ6r2ZK9+pDU
         L44UyEgV5MeVhwUmZF/skaDGm5Bnn4ierQ3cDH9PGgKgd7ZzXFpkdqK1cvdP/P/UGO23
         7skNSyQMTluY4nBiLnhNfXUahZMNEBjKCRxR6um4/8HNQIF399N5KWDlvMMABmjfmhMD
         snPh3SdISJZmZJLu9mq2okO59gqWj1+uL+N5T2cryvuANcfRdh2roIRSES3h8TprrkEd
         /9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687950944; x=1690542944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYX8/ePECLgfWoMNpv2uZz3s+XofYXzTKNlcug8MZ0c=;
        b=alMRoM4+5KyiePN3C9Of5r84MTSKFxRUvam78tECvefylvZG78CbyqbIGahQnL2LNV
         7g7bSCewbxCEiuHpMWH08uIcZRop496Xe2B0uPGb3es/B3O7/RNgqPFc9myggvr8kR50
         BCL8zYI177MX7533roPEW71VY22KoB8uMJQ+IJTd4EstwUYcUNaRMRwRZNmDwGBaGctA
         VekIlJzPsNWPr+tBO1yWsTeEYbXHUFiMluq+Sr78KUtumDWD8ID1hK8nCM9K8V6Ouhdh
         7YW6pXei86fe8+YSRLZO/S6uo3zhrocevXY0y1ti5IpWr2vlXdo3kKNpN2MIuw0aY0cM
         P4iA==
X-Gm-Message-State: AC+VfDyhjTsOxaRjQst0KlYg6Ho5cfbvSGKR/8z2l7StStf7fHj9fSwb
        6kT6LmvxCrk4bZRFq6f56YvzIg==
X-Google-Smtp-Source: ACHHUZ45owiPf7elrn+8tOw5ryHFm6Cke05JKdz0dMQUlVmsn5e6N8Sh+GX5X2BWx3ut2u/1kvQkxQ==
X-Received: by 2002:adf:f70c:0:b0:313:f07a:af3e with SMTP id r12-20020adff70c000000b00313f07aaf3emr7222410wrp.46.1687950943971;
        Wed, 28 Jun 2023 04:15:43 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g9-20020a5d5549000000b00307acec258esm13205270wrw.3.2023.06.28.04.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:15:43 -0700 (PDT)
Date:   Wed, 28 Jun 2023 13:15:41 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc:     "kuba@kernel.org" <kuba@kernel.org>,
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
        <linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>,
        mschmidt <mschmidt@redhat.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
Subject: Re: [RFC PATCH v9 00/10] Create common DPLL configuration API
Message-ID: <ZJwWXZmZe4lQ04iK@nanopsycho>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
 <ZJq3a6rl6dnPMV17@nanopsycho>
 <DM6PR11MB4657084DDD7554663F86C1C19B24A@DM6PR11MB4657.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4657084DDD7554663F86C1C19B24A@DM6PR11MB4657.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Wed, Jun 28, 2023 at 11:15:11AM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Tuesday, June 27, 2023 12:18 PM
>>
>>Fri, Jun 23, 2023 at 02:38:10PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>
>>>v8 -> v9:
>>
>>Could you please address all the unresolved issues from v8 and send v10?
>>I'm not reviewing this one.
>>
>>Thanks!
>
>Sure, will do, but first missing to-do/discuss list:
>1) remove mode_set as not used by any driver
>2) remove "no-added-value" static functions descriptions in
>   dpll_core/dpll_netlink
>3) merge patches [ 03/10, 04/10, 05/10 ] into patches that are compiling
>   after each patch apply
>4) remove function return values descriptions/lists
>5) Fix patch [05/10]:
>   - status Supported
>   - additional maintainers
>   - remove callback:
>     int (*source_pin_idx_get)(...) from `struct dpll_device_ops`
>6) Fix patch [08/10]: rethink ice mutex locking scheme
>7) Fix patch [09/10]: multiple comments on
>https://lore.kernel.org/netdev/ZIQu+%2Fo4J0ZBspVg@nanopsycho/#t
>8) add PPS DPLL phase offset to the netlink get-device API
>

You are missing removal of pin->prop.package_label = dev_name(dev); in
ice.


>Thank you!
>Arkadiusz
