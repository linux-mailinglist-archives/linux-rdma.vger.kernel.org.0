Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8710E74ED5A
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jul 2023 13:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjGKLw4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jul 2023 07:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjGKLwz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jul 2023 07:52:55 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD0B10EF
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jul 2023 04:52:47 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51e99584a82so776288a12.1
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jul 2023 04:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689076366; x=1691668366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VMmzAbnQPb+hff08oGBX7AMmQrEjQkPWbeWYbWnEb2s=;
        b=R6I4rQhZNuJhcRNVBlXhhbzoUBbtJugUPtDeDqspmlhc0LV6PhoXCtdxQT2Fj0bM/Z
         D3kIChr40ply4orCGt+9ajW59qGsXI0q8dwmTjUCDnDH0ulp9uyX3O+SsEKbO2t7vinl
         8gTJudbGuaMlUr/F2U1aCITw8lqIDA7UGsx63ZT1ftAReQn3Gp7VbkcsmETP/cRAyQai
         lkIOqNqDJFzyv3RRj/Q+MFuMldUziVBZazHL8K6x6ggiatiMyxzswv65kZTUd+/j30i/
         ceCU0hZSdHB7C1BCm/DJGmgVIEJr/TryA/39HtCJ72a1xnXsajO8AG8nwixG6ViSclLN
         u3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689076366; x=1691668366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMmzAbnQPb+hff08oGBX7AMmQrEjQkPWbeWYbWnEb2s=;
        b=UpIkJriloXdl7u264i8kRNX3OdQ5Xjggl2adWqO34AtHHDl6xIo39mKQZME3wM2RwO
         SPyzIl24jnos7WSojuXKWb14CH3vmVEW7f5WvbfMLkXk56kKtUWlFl/YRz4thcvi4pzi
         o/NJKm7ROg5mok5UltQr0V7Yzt1BsDs+MmrDzSvKt7P6kPRDjCPGzULujzYHbrj096/1
         1JIrHR1nz+bf/h/tfoapSQia9NkZjrysDhiaN2U78D6+w90qn93ip9/YbpNDniYfAJAa
         SksNbT9lpuY7HDGrpDM3lQo4rN0+tSu8ajdRZCqWeNIt63tF28sKmUV89C1ldaDbZoQl
         R2Gg==
X-Gm-Message-State: ABy/qLbz3J8s13GJ98d9iExR3Y3EblKmAW86L7+FepFYeqs+96C6HXg0
        lnTPEQlIjS+LrT3zyo2/FY+Liw==
X-Google-Smtp-Source: APBJJlFxRCgoFvFTryd/EnnLREOPOgp5+SxcfOYu5/wDWMNeLe4NvM0dWgV+6D/1iKEYw/AVIF+zFw==
X-Received: by 2002:a05:6402:506:b0:51e:26c8:25f7 with SMTP id m6-20020a056402050600b0051e26c825f7mr14275781edv.42.1689076365929;
        Tue, 11 Jul 2023 04:52:45 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u8-20020aa7d888000000b0051e0f21c43fsm1148663edq.31.2023.07.11.04.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 04:52:45 -0700 (PDT)
Date:   Tue, 11 Jul 2023 13:52:43 +0200
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
Message-ID: <ZK1CizcqjqO1L/RQ@nanopsycho>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
 <ZJq3a6rl6dnPMV17@nanopsycho>
 <DM6PR11MB4657084DDD7554663F86C1C19B24A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZJwWXZmZe4lQ04iK@nanopsycho>
 <DM6PR11MB4657751607C36FC711271D639B30A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZKv1FRTXWLnLGRRS@nanopsycho>
 <DM6PR11MB46575D14FFE115546FDC9DEB9B31A@DM6PR11MB4657.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB46575D14FFE115546FDC9DEB9B31A@DM6PR11MB4657.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Tue, Jul 11, 2023 at 12:34:11PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Monday, July 10, 2023 2:10 PM
>>
>>Mon, Jul 10, 2023 at 12:07:30PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>Sent: Wednesday, June 28, 2023 1:16 PM
>>>>Wed, Jun 28, 2023 at 11:15:11AM CEST, arkadiusz.kubalewski@intel.com
>>wrote:
>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>Sent: Tuesday, June 27, 2023 12:18 PM
>>>>>>
>>>>>>Fri, Jun 23, 2023 at 02:38:10PM CEST, arkadiusz.kubalewski@intel.com
>>>>>>wrote:
>>>>>>
>>>>>>>v8 -> v9:
>>>>>>
>>>>>>Could you please address all the unresolved issues from v8 and send v10?
>>>>>>I'm not reviewing this one.
>>>>>>
>>>>>>Thanks!
>>>>>
>>>>>Sure, will do, but first missing to-do/discuss list:
>>>>>1) remove mode_set as not used by any driver
>>>
>>>I have implemented in ice (also added back the DPLL_MODE_FREERUN).
>>
>>Uh :/ Why exactly is it needed in this initial submission?
>>
>
>Without mode-set there is no need for device-set at all, right?
>So it is better to implement at least one set command, so we don't
>need remove device-set command entirely.

The enum cmd valu could stay as a placeholder, the rest can go.


>
>>
>>>
>>>>>2) remove "no-added-value" static functions descriptions in
>>>>>   dpll_core/dpll_netlink
>>>
>>>Removed.
>>>
>>>>>3) merge patches [ 03/10, 04/10, 05/10 ] into patches that are compiling
>>>>>   after each patch apply
>>>
>>>Hope Vadim will decide on this, the thing is merging in two patches
>>>doesn't make much sense as there won't be any linking until both patches
>>>are there, so most sense it would be if 3 are merged into one, but
>>>then we will be back to one big blob patch issue.
>>>
>>>>>4) remove function return values descriptions/lists
>>>
>>>Fixed.
>>>
>>>>>5) Fix patch [05/10]:
>>>>>   - status Supported
>>>>>   - additional maintainers
>>>>>   - remove callback:
>>>>>     int (*source_pin_idx_get)(...) from `struct dpll_device_ops`
>>>>>6) Fix patch [08/10]: rethink ice mutex locking scheme
>>>
>>>Fixed.
>>>
>>>>>7) Fix patch [09/10]: multiple comments on
>>>>>https://lore.kernel.org/netdev/ZIQu+%2Fo4J0ZBspVg@nanopsycho/#t
>>>>>8) add PPS DPLL phase offset to the netlink get-device API
>>>>>
>>>
>>>Added few things on this matter
>>>- 1 dpll level attribute:
>>>  - phase-shift - measuring the phase difference between dpll input
>>>    and it's output
>>>- 1 dpll-pin tuple level attribute:
>>>  - pin-phase-adjust - set/get phase adjust of a pin on a dpll
>>>- 2 pin level attributes:
>>>  - pin-phase-adjust-min - provide user with min value that can be set
>>>  - pin-phase-adjust-max - provide user with max value that can be set
>>>- a constant:
>>>  - DPLL_PHASE_SHIFT_DIVIDER similar to DPLL_TEMP_DIVIDER for producing
>>>    fraction value of measured DPLL_A_PHASE_SHIFT
>>
>>Again, why do we need this in this initial submission? Why it can't be a
>>follow-up patchset to extend this? This way we never converge :/
>>Please focus on what we have now and bring it in. Let the extensions to
>>be addressed later on, please.
>>
>
>Well AFAIK, RHEL is doing some monitoring software, so the end-users need this.

They need it for the initial submission? Why? Why can't they wait 1 week
for follow-up patchset?


>
>>
>>
>>>- implemented in dpll netlink and in ice
>>>
>>>>
>>>>You are missing removal of pin->prop.package_label = dev_name(dev); in
>>>>ice.
>>>>
>>>
>>>I didn't touch it, as we still need to discuss it, Jakub didn't respond
>>>on v8 thread.
>>>I don't see why we shall not name it the way. This is most meaningful
>>>label for those pins for the user right now.
>>
>>This is not meaningful, at all. dev_name() changes upon which pci slot
>>you plug the card into. package_label should be an actual label on a
>>silicon package. Why you think this two are related in aby way, makes me
>>really wonder. Could you elaborate the meaningfulness of this?
>>
>
>Without this, from end-user perspective, it would be very confusing.
>As in ice without any label there would 4 pins which differs only with id.

There you go, it does not have any label, yet you are trying hard to
make up some. Does not make sense.


>What names would you suggest?

That is the point I made previously. For synce usecase, the label does
not make sense. There should be no label. You reference the pin by ID
from netdev, that is enough.

I think better to add the check to pin-register so future synce pin
users don't have similar weird ideas. Could you please add this check?

Thanks!



>
>Thank you!
>Arkadiusz
>
>>
>>>
>>>Thank you!
>>>Arkadiusz
>>>
>>>>
>>>>>Thank you!
>>>>>Arkadiusz
