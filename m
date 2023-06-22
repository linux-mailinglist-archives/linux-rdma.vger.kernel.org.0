Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DDD7397D4
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jun 2023 09:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjFVHKA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jun 2023 03:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjFVHJ7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Jun 2023 03:09:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0482B1BD3
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jun 2023 00:09:58 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f9c532f9e3so14288545e9.1
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jun 2023 00:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687417796; x=1690009796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mPyXOzxLtxEjY9cBPcsaRIns0EAEb4Nt/6W8EsU3ga8=;
        b=3iouDSVugUMNcys+i697SLnTvuKCQCDU18RQuMxLJV54x1bnilfa2bLr1aadMiQh1g
         UItDYY8rMfETP4FeqIVWSeabeT9AuFOTAO2aUWdKuLg84/CdT7qzIiwweS4Gx3GVX1P8
         4bBATic4ICWKlQpgqYwOyZIg4yeumq7IFyMtmwFoUFt4NXiXBCo3DNhJZkMc01ZTBRaW
         ek+bbOOoFMHEBQqk1J0jBtWot+LCXVC45zM6x5Dl0Kk8ybD9Cafa8DoJ6GiSDoMY3ro7
         6A1iZr2yMlshPSuQUwe9k+ophGjpUKdwBA35Aey0t6Ccp+bFNAOoqgp2gLV3leZxIgP/
         d1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687417796; x=1690009796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPyXOzxLtxEjY9cBPcsaRIns0EAEb4Nt/6W8EsU3ga8=;
        b=IH9a+vE6UtMkTWuog5mjhYdnFQpy5Ho++9HLb27MQBZ68gfJmfxOW9MQCwMPNjg4s/
         gVa1gzmPEZN3YhJJ9tS6ovWMAdsGPPkXlf9LT7towGkPS0xUumbRXYMYYrYb4jczenuO
         T8+beIqS7SsZSgkFf9Z56fOfyTR7d+AGDUKH/TbIdwiHgmQTD+i+YZwP8V4AdSjEbrCG
         EO5lY2kiW16Q3rQHdDIchyHq2YQ6ZOHSygfYzapQpaKr5oK/8xfE9s95hKL+t9270eC3
         KCi5LTBuurMhLOkE+vtlLIolKyKsQLDMGY+VtCERPLwwGpQjyVX1LHIe2AcK0cLghCC6
         y57w==
X-Gm-Message-State: AC+VfDwpobWboOu2h9OCWLNyHYH4i85riwSMt3Clp43HGMoAYW63kaeY
        V6FfAl8W/llrVSgWsgtayg2mUA==
X-Google-Smtp-Source: ACHHUZ7BfDfYg8tVKSO/1MGIhgM7knp4bxE9BjLvWPQmvpgYpkpg9XkXMIy4VKk2fcxV+HKp1ykuJA==
X-Received: by 2002:a5d:468d:0:b0:30a:f2a0:64fa with SMTP id u13-20020a5d468d000000b0030af2a064famr15527240wrq.10.1687417796496;
        Thu, 22 Jun 2023 00:09:56 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d58ec000000b00309382eb047sm6207885wrd.112.2023.06.22.00.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 00:09:55 -0700 (PDT)
Date:   Thu, 22 Jun 2023 09:09:54 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <ZJPzwj1odaC8fFzO@nanopsycho>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
 <20230609121853.3607724-4-arkadiusz.kubalewski@intel.com>
 <20230612164515.6eacefb1@kernel.org>
 <DM6PR11MB4657FED589F5922BBAC5D9059B5DA@DM6PR11MB4657.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4657FED589F5922BBAC5D9059B5DA@DM6PR11MB4657.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Wed, Jun 21, 2023 at 11:17:26PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Jakub Kicinski <kuba@kernel.org>
>>Sent: Tuesday, June 13, 2023 1:45 AM
>>
>>On Fri,  9 Jun 2023 14:18:46 +0200 Arkadiusz Kubalewski wrote:
>>> +	xa_for_each(xa_pins, i, ref) {
>>> +		if (ref->pin != pin)
>>> +			continue;
>>> +		reg = dpll_pin_registration_find(ref, ops, priv);
>>> +		if (reg) {
>>> +			refcount_inc(&ref->refcount);
>>> +			return 0;
>>> +		}
>>> +		ref_exists = true;
>>> +		break;
>>> +	}
>>> +
>>> +	if (!ref_exists) {
>>> +		ref = kzalloc(sizeof(*ref), GFP_KERNEL);
>>> +		if (!ref)
>>> +			return -ENOMEM;
>>> +		ref->pin = pin;
>>> +		INIT_LIST_HEAD(&ref->registration_list);
>>> +		ret = xa_insert(xa_pins, pin->pin_idx, ref, GFP_KERNEL);
>>> +		if (ret) {
>>> +			kfree(ref);
>>> +			return ret;
>>> +		}
>>> +		refcount_set(&ref->refcount, 1);
>>> +	}
>>> +
>>> +	reg = kzalloc(sizeof(*reg), GFP_KERNEL);
>>
>>Why do we have two structures - ref and reg?
>>
>
>Thank to Jiri and reg struct we solved a pin/dpll association
>with multiple device drivers..

Multiple instances of the same driver.


>I.e. for pin:
>
>struct dpll_pin_registration {
>	struct list_head list;
>	const struct dpll_pin_ops *ops;
>	void *priv;
>};
>
>struct dpll_pin_ref {
>	union {
>		struct dpll_device *dpll;
>		struct dpll_pin *pin;
>	};
>	struct list_head registration_list;
>	refcount_t refcount;
>};
>
>struct dpll_pin {
>	u32 id;
>	u32 pin_idx;
>	u64 clock_id;
>	struct module *module;
>	struct xarray dpll_refs;
>	struct xarray parent_refs;
>	const struct dpll_pin_properties *prop;
>	char *rclk_dev_name;
>	refcount_t refcount;
>};
>
>Basically, a pin or a device can be registered from multiple drivers,

Again, multiple instances of the same driver.


>where each driver has own priv and ops.

Each instance/device.


>A single dpll_pin has references to dplls or pins (dpll_refs/parent_refs)
>it is connected with, and thanks to registration list single reference can
>have multiple drivers being attached with a particular dpll/pin.

Multiple instances/devices.


In case of mlx5, the same dpll device and same dpll pin could be shared
among two PFs but also among multiple VFs and SFs. They all share the
same clock, same dpll device.


>
>The same scheme is for a dpll_device struct and associated pins.
>
>
>>> +	if (!reg) {
>>> +		if (!ref_exists)
>>> +			kfree(ref);
>>
>>ref has already been inserted into xa_pins
>>
>
>True, seems like a bug, will fix it.
>
>Thank you,
>Arkadiusz
>
>>> +		return -ENOMEM;
