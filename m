Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C107397CA
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jun 2023 09:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjFVHGO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jun 2023 03:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjFVHGN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Jun 2023 03:06:13 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF121BD3
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jun 2023 00:05:59 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f9c0abc8b1so15417075e9.1
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jun 2023 00:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687417557; x=1690009557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VIhSOYk52hVuqfcboW85OQLI0NHly7jy25hrkyJ2YAw=;
        b=WZQ2qdOUncD9AsxUeqky0Sv9plZI/2WtRmFLj/vUPrLspAKtFdJAjDNBfRiM90Wl6l
         Bu52No9UiIMeNp5vJfqV4tdzKNy4gqSSkZZgdTA2tEhX9UhJ0VFvTD1WUjcyZjBnxsqM
         CY6kI+W0r2aC0t58Ot4ae4EkJpbEUxEO+qU0IzQugmgTpIX9f4Vdc6bAsBsmzf0/VZPu
         oMD/OCT9ypK+CBaNDZaMdjjZbvVgK6KKjigdSYdUY6tPiNMyp/u8BcNpj7C6Q76VkPqd
         cFeXbCEhZGKbNKcefxvBWXoomyu9ZEWY69AGbsxFJ97j4shY74xka5Cdz8D7NjEiYYcZ
         YJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687417557; x=1690009557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIhSOYk52hVuqfcboW85OQLI0NHly7jy25hrkyJ2YAw=;
        b=iRYUxTsz5+vs8Lh+iMKRUfXysGnLFFBqY5gT4aF2fWCCr/99Tx81YO/aXexJ4LrMrg
         17ypJg/Z3GbY6lYLbT63atj57TJnZKih9cJPYuZcj3ns5qaez5owde5ZhytctpDCMFgs
         ECwXLidYffmgaZuJcuimO+7krQixjtCirgEWWGAATXyzje/+MsMVXQ17Xnt1Uz9CSHck
         2BJu0J+XbrJb/ICo2NNpJ1VGATIB3FSESjYNochNdfm0VhdCPcfpl9q/r9uONA463aRw
         0u4Rf32YBQYToTxUViVGZH7moXeoXsTm6Mo3roq6ZT5FWppxzlQppNJHmKfXnB3Hop3O
         bscw==
X-Gm-Message-State: AC+VfDxsqXQEtz8zQZ1lLZSd02SgP63Hpo/UVnqvlx4tEvnd61x6fyAC
        mn3aUtdi9p3KjS69eD1g/Y+U1A==
X-Google-Smtp-Source: ACHHUZ47nqUaHErWDVz/sLK5UcH8SW19SUG16keT/oe5Rk5/giZmsiFYSgziHOgHrlK6XzxNNrCLiA==
X-Received: by 2002:a1c:7415:0:b0:3fa:77c8:6724 with SMTP id p21-20020a1c7415000000b003fa77c86724mr51349wmc.10.1687417557595;
        Thu, 22 Jun 2023 00:05:57 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c231100b003f8ec58995fsm6919930wmo.6.2023.06.22.00.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 00:05:57 -0700 (PDT)
Date:   Thu, 22 Jun 2023 09:05:56 +0200
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
Subject: Re: [RFC PATCH v8 03/10] dpll: core: Add DPLL framework base
 functions
Message-ID: <ZJPy1FBvMC4z5SG2@nanopsycho>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
 <20230609121853.3607724-4-arkadiusz.kubalewski@intel.com>
 <ZIS1FX0QAqDSvVUK@nanopsycho>
 <DM6PR11MB46570B50A01D81F54F1068369B5DA@DM6PR11MB4657.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB46570B50A01D81F54F1068369B5DA@DM6PR11MB4657.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Wed, Jun 21, 2023 at 08:55:35PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Saturday, June 10, 2023 7:38 PM
>>
>>Fri, Jun 09, 2023 at 02:18:46PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>>From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>>
>>>DPLL framework is used to represent and configure DPLL devices
>>>in systems. Each device that has DPLL and can configure inputs
>>>and outputs can use this framework.
>>>
>>>Implement core framework functions for further interactions
>>>with device drivers implementing dpll subsystem, as well as for
>>>interactions of DPLL netlink framework part with the subsystem
>>>itself.
>>>
>>>Co-developed-by: Milena Olech <milena.olech@intel.com>
>>>Signed-off-by: Milena Olech <milena.olech@intel.com>
>>>Co-developed-by: Michal Michalik <michal.michalik@intel.com>
>>>Signed-off-by: Michal Michalik <michal.michalik@intel.com>
>>>Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>>Co-developed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>---
>>> drivers/dpll/dpll_core.c | 953 +++++++++++++++++++++++++++++++++++++++
>>> drivers/dpll/dpll_core.h | 104 +++++
>>
>>Overall, looks very good! I pinpointed couple of nits below, nothing big.
>>General question: Why do you put documentation comment to every static
>>function? Does not make any sense to me. Even for non-exported functions
>>I think it is overkill. Most of them (if not all) give the reader no
>>additional information and only make the code a bit harder to read.
>>Care to drop them?
>>
>
>I forgot to respond here.. I would rather leave it, but if the others think
>the same way, we could remove them.

Could you explain what is the benefit of leaving them? What are they
good for. From what I see, they are obvious and only add blank LOC.
