Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829B37383CB
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jun 2023 14:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjFUMaF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jun 2023 08:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjFUMaE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jun 2023 08:30:04 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524DB1A1
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jun 2023 05:30:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f640e48bc3so7831359e87.2
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jun 2023 05:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687350601; x=1689942601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R9RGfJqgepIeBvJ1OfKk1XmicseQJBOqqkZjFv/Sa90=;
        b=EkqoBWjMr87RPy89et6BGhuw9VAPZh7M+VK6jbsmEABD22QZZD6QcVmEmD0YKxTD3i
         NFifzn2AbhccQE8IS2d4oMw6SbNGIvnDgO3+FnbrVyacR7rd3gQ33x9OKxIFKXHFgQxU
         Bv7htOjEJeg2jVHoz1cAzYz1FCO+UYTGSokSdXVKZJ8oWzrEjoc6oosLLIGauk35oxeB
         fcRL7THnuGMfucqzTYbmGsnzDX2XCIVoqReAHk3Uu0S52nmlVnY90+BNjuqKXwsIKpxr
         xS6Q2JQnfzg+Hegrb/1bzxj5Tzo1AKsS3qAAnNufUJ1JsCy6SOsxkScjyFjut5bGuZF1
         Omtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687350601; x=1689942601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9RGfJqgepIeBvJ1OfKk1XmicseQJBOqqkZjFv/Sa90=;
        b=gej+atMDBWiS/Fc6zaRNwWY0uCv2OgieXU5IrEuRJXZ30mCmUMXEKmJsYa34HqI56t
         FX0fWyUBnLYsoQ+OYRJbXm3I8+4GVOKep2iOetMA/3h7ke/VQdlT1su+A/xNzHsiFpRO
         wxCWQH7aJLlF5wCGgCHC9lSHH6DR0YvHEPBy2WpvZ+h3KEhHMvL0MgJMEHtdqNjR2Mlw
         PhIPmqRZ1fF5Ud47lCwQkONrfOqPnVijODePiNA8mOB3lNaumV1W/AjYxHdzG/WKEDYu
         lkEKFbGrwZdXHKMWy3GPJzOJ/+xBqw8rhHaUDyev7kVF9xLx6VojiMGVfBhMvP/9gWZy
         d75g==
X-Gm-Message-State: AC+VfDz6SrnrC0MPropQES7cfUI+PVKZs4LoieunMeXqKPSc+1s2fupS
        EFSjmyV9/TnurOKpfDXnD+g8nw==
X-Google-Smtp-Source: ACHHUZ5n1us+Bo/SpNyVjWkH9hnrHLxyGkJ086GdwXI8vcD2bjT3FD19WznXfwbxPjwjeY65NzV9QQ==
X-Received: by 2002:a19:7715:0:b0:4f9:5a87:1028 with SMTP id s21-20020a197715000000b004f95a871028mr998668lfc.30.1687350601263;
        Wed, 21 Jun 2023 05:30:01 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id x1-20020a5d4441000000b00311d8c2561bsm4376924wrr.60.2023.06.21.05.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 05:30:00 -0700 (PDT)
Date:   Wed, 21 Jun 2023 14:29:59 +0200
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
Subject: Re: [RFC PATCH v8 08/10] ice: implement dpll interface to control cgu
Message-ID: <ZJLtR0c+tvCbUgri@nanopsycho>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
 <20230609121853.3607724-9-arkadiusz.kubalewski@intel.com>
 <ZISmmH0jqxZRB4VX@nanopsycho>
 <DM6PR11MB4657161D2871747A7B404EDD9B5FA@DM6PR11MB4657.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4657161D2871747A7B404EDD9B5FA@DM6PR11MB4657.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Mon, Jun 19, 2023 at 10:34:12PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Saturday, June 10, 2023 6:37 PM
>>
>>Fri, Jun 09, 2023 at 02:18:51PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>
>>[...]
>>
>>
>>>+static int ice_dpll_mode_get(const struct dpll_device *dpll, void *priv,
>>>+			     enum dpll_mode *mode,
>>>+			     struct netlink_ext_ack *extack)
>>>+{
>>>+	*mode = DPLL_MODE_AUTOMATIC;
>>
>>I don't understand how the automatic mode could work with SyncE. The
>>There is one pin exposed for one netdev. The SyncE daemon should select
>>exacly one pin. How do you achieve that?
>>Is is by setting DPLL_PIN_STATE_SELECTABLE on the pin-netdev you want to
>>select and DPLL_PIN_STATE_DISCONNECTED on the rest?
>>
>>
>>[...]
>
>AUTOMATIC mode autoselects highest priority valid signal.
>As you have pointed out, for SyncE selection, the user must be able to manually
>select a pin state to enable recovery of signal from particular port.
>
>In "ice" case there are 2 pins for network PHY clock signal recovery, and both
>are parent pins (MUX-type). There are also 4 pins assigned to netdevs (one per
>port). Thus passing a signal from PHY to the pin is done through the MUX-pin,
>by selecting proper state on pin-parent pair (where parent pins is highest prio
>pin on dpll).

Could you show me some examples please?


>
>Thank you!
>Arkadiusz
