Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42CC74D4ED
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jul 2023 14:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjGJMKG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jul 2023 08:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjGJMKF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jul 2023 08:10:05 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9076DFE
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jul 2023 05:10:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fc03aa6e04so23038795e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jul 2023 05:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1688991000; x=1691583000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H+JMKDNGrwhDe4HBcYBuaXlqFjTwAt1vMreVme3OFY8=;
        b=MD2tvasVfOO4Nxy8SwUpBNEofYhK1a76YN7YTyJ6XCk4qvq1spePWJ5U2HolrrDdOT
         pzotR5LDEF25B41YlghYLyVcJkdw7vYJckcNJXxzoVzx8DbQ+6hEFFhdUj6XuU5/JwTS
         de7OJ/wZbyomxDR6RlVAoOvpDOADSoZgTnFR2HGAnnoWaFFoubJOc/2oATJfKeVSTYBJ
         xp2eDZ1l4OxeIVU/voQMubWmuIrIVwG/CaH7gXvloqVZatO1QXMFsWy7LlP8TddCh4qu
         5Do8+o8pothhSJMw+0Mm75HDNlA3gJgbKA3Vb5t+JO+ihvcYFSzAincJ4KCt7QFMv+p/
         CNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688991000; x=1691583000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+JMKDNGrwhDe4HBcYBuaXlqFjTwAt1vMreVme3OFY8=;
        b=lzDRK6rCys9UPUsllM5uEAO0gU1sonqzI4+LXYQgOI52d5ur024TB1X3fsJF0Qt0eh
         yx30wXjF2TISlRgX4XRsGlCQsRInMG/SNgmuVhptWatL37f5XRJDruLLOD6Od9XX8UWf
         Q/Mk+foluxsAfY+RZBzMML5OwY/aMuh7koo6cam9fGZtV4eegTee74cdYcOHw9OjXgcY
         z1uC139ZzFvLEWIwQrjdM9r4IkpLSmQdv2UIjCk4pGlOoT/+xLkEg+dZzMiuiXtrqSGH
         4Q+X47zpCKWI+e8csYf8EUrTNG+GQy2j5ZNQMb6gu8NRKYTCyTT5vh0dCpQYUJIWQo//
         TriQ==
X-Gm-Message-State: ABy/qLY8QA5GvcBLC+2TPFvEIbypKU5LPvXRj0QiEoD69+iLLoKxrAtH
        AR75wItox35605n4g5SgzsilhQ==
X-Google-Smtp-Source: APBJJlG6iRHARThiiqxbJc+oH1dUx5jylRNEM8Djmjy4H8sNg1Su/SyUt7SEHMg58iXBXU/0NBUMLA==
X-Received: by 2002:a05:600c:2209:b0:3fc:b86:d3fa with SMTP id z9-20020a05600c220900b003fc0b86d3famr4756381wml.1.1688990999804;
        Mon, 10 Jul 2023 05:09:59 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id z13-20020a7bc7cd000000b003fc0062f0f8sm9128556wmk.9.2023.07.10.05.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 05:09:59 -0700 (PDT)
Date:   Mon, 10 Jul 2023 14:09:57 +0200
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
Message-ID: <ZKv1FRTXWLnLGRRS@nanopsycho>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
 <ZJq3a6rl6dnPMV17@nanopsycho>
 <DM6PR11MB4657084DDD7554663F86C1C19B24A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZJwWXZmZe4lQ04iK@nanopsycho>
 <DM6PR11MB4657751607C36FC711271D639B30A@DM6PR11MB4657.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4657751607C36FC711271D639B30A@DM6PR11MB4657.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Mon, Jul 10, 2023 at 12:07:30PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Wednesday, June 28, 2023 1:16 PM
>>Wed, Jun 28, 2023 at 11:15:11AM CEST, arkadiusz.kubalewski@intel.com wrote:
>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>Sent: Tuesday, June 27, 2023 12:18 PM
>>>>
>>>>Fri, Jun 23, 2023 at 02:38:10PM CEST, arkadiusz.kubalewski@intel.com
>>>>wrote:
>>>>
>>>>>v8 -> v9:
>>>>
>>>>Could you please address all the unresolved issues from v8 and send v10?
>>>>I'm not reviewing this one.
>>>>
>>>>Thanks!
>>>
>>>Sure, will do, but first missing to-do/discuss list:
>>>1) remove mode_set as not used by any driver
>
>I have implemented in ice (also added back the DPLL_MODE_FREERUN).

Uh :/ Why exactly is it needed in this initial submission?


>
>>>2) remove "no-added-value" static functions descriptions in
>>>   dpll_core/dpll_netlink
>
>Removed.
>
>>>3) merge patches [ 03/10, 04/10, 05/10 ] into patches that are compiling
>>>   after each patch apply
>
>Hope Vadim will decide on this, the thing is merging in two patches
>doesn't make much sense as there won't be any linking until both patches
>are there, so most sense it would be if 3 are merged into one, but
>then we will be back to one big blob patch issue.
>
>>>4) remove function return values descriptions/lists
>
>Fixed.
>
>>>5) Fix patch [05/10]:
>>>   - status Supported
>>>   - additional maintainers
>>>   - remove callback:
>>>     int (*source_pin_idx_get)(...) from `struct dpll_device_ops`
>>>6) Fix patch [08/10]: rethink ice mutex locking scheme
>
>Fixed.
>
>>>7) Fix patch [09/10]: multiple comments on
>>>https://lore.kernel.org/netdev/ZIQu+%2Fo4J0ZBspVg@nanopsycho/#t
>>>8) add PPS DPLL phase offset to the netlink get-device API
>>>
>
>Added few things on this matter
>- 1 dpll level attribute:
>  - phase-shift - measuring the phase difference between dpll input
>    and it's output
>- 1 dpll-pin tuple level attribute:
>  - pin-phase-adjust - set/get phase adjust of a pin on a dpll
>- 2 pin level attributes:
>  - pin-phase-adjust-min - provide user with min value that can be set
>  - pin-phase-adjust-max - provide user with max value that can be set
>- a constant:
>  - DPLL_PHASE_SHIFT_DIVIDER similar to DPLL_TEMP_DIVIDER for producing
>    fraction value of measured DPLL_A_PHASE_SHIFT

Again, why do we need this in this initial submission? Why it can't be a
follow-up patchset to extend this? This way we never converge :/
Please focus on what we have now and bring it in. Let the extensions to
be addressed later on, please.



>- implemented in dpll netlink and in ice
>
>>
>>You are missing removal of pin->prop.package_label = dev_name(dev); in
>>ice.
>>
>
>I didn't touch it, as we still need to discuss it, Jakub didn't respond
>on v8 thread.
>I don't see why we shall not name it the way. This is most meaningful
>label for those pins for the user right now.

This is not meaningful, at all. dev_name() changes upon which pci slot
you plug the card into. package_label should be an actual label on a
silicon package. Why you think this two are related in aby way, makes me
really wonder. Could you elaborate the meaningfulness of this?


>
>Thank you!
>Arkadiusz
>
>>
>>>Thank you!
>>>Arkadiusz
