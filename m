Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E51741235
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jun 2023 15:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjF1NWJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jun 2023 09:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjF1NWH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Jun 2023 09:22:07 -0400
Received: from out-15.mta1.migadu.com (out-15.mta1.migadu.com [IPv6:2001:41d0:203:375::f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21D48F
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jun 2023 06:22:05 -0700 (PDT)
Message-ID: <4ebfa74e-8998-a1af-e6b9-3701008900ec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687958523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9IKeJEG13+S2kDeEbfPQ0kmL8pMxMzPSNBLN+Rhu64E=;
        b=s4/5XXRAqixfYxME1snH8BsG2Z7AryY6nW2SdeK1xdJofEZ820+LsfkrcTTWs7C2wuXkom
        Y0met+OzoOxBOXg0w5XNaz3pYCVnDSfoXJXQ3lMqxfca004uCQZtnxLn4k6m6r70HOHABz
        JhGbp+SJh/7I+nZUN0UikTRtf8ZNxzU=
Date:   Wed, 28 Jun 2023 14:22:00 +0100
MIME-Version: 1.0
Subject: Re: [RFC PATCH v9 00/10] Create common DPLL configuration API
Content-Language: en-US
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "vadfed@meta.com" <vadfed@meta.com>,
        "jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
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
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
 <ZJq3a6rl6dnPMV17@nanopsycho>
 <DM6PR11MB4657084DDD7554663F86C1C19B24A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <DM6PR11MB4657A1ACB586AD9B45C7996E9B24A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <2e9ce197-2732-d061-b11d-4f4513af6abc@linux.dev>
 <ZJwxHucKMwCQMMVM@nanopsycho>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <ZJwxHucKMwCQMMVM@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 28/06/2023 14:09, Jiri Pirko wrote:
> Wed, Jun 28, 2023 at 01:11:19PM CEST, vadim.fedorenko@linux.dev wrote:
>> On 28/06/2023 10:27, Kubalewski, Arkadiusz wrote:
>>>> From: Kubalewski, Arkadiusz
>>>> Sent: Wednesday, June 28, 2023 11:15 AM
>>>>
>>>>> From: Jiri Pirko <jiri@resnulli.us>
>>>>> Sent: Tuesday, June 27, 2023 12:18 PM
>>>>>
>>>>> Fri, Jun 23, 2023 at 02:38:10PM CEST, arkadiusz.kubalewski@intel.com
>>>> wrote:
>>>>>
>>>>>> v8 -> v9:
>>>>>
>>>>> Could you please address all the unresolved issues from v8 and send v10?
>>>>> I'm not reviewing this one.
>>>>>
>>>>> Thanks!
>>>>
>>>> Sure, will do, but first missing to-do/discuss list:
>>>> 1) remove mode_set as not used by any driver
>>>> 2) remove "no-added-value" static functions descriptions in
>>>>     dpll_core/dpll_netlink
>>>> 3) merge patches [ 03/10, 04/10, 05/10 ] into patches that are compiling
>>>>     after each patch apply
>>>> 4) remove function return values descriptions/lists
>>>> 5) Fix patch [05/10]:
>>>>     - status Supported
>>>>     - additional maintainers
>>>>     - remove callback:
>>>>       int (*source_pin_idx_get)(...) from `struct dpll_device_ops`
>>>> 6) Fix patch [08/10]: rethink ice mutex locking scheme
>>>> 7) Fix patch [09/10]: multiple comments on
>>>> https://lore.kernel.org/netdev/ZIQu+%2Fo4J0ZBspVg@nanopsycho/#t
>>>> 8) add PPS DPLL phase offset to the netlink get-device API
>>>>
>>>> Thank you!
>>>> Arkadiusz
>>>
>>> If someone has any objections please state them now, I will work on
>>> all above except 5) and 7).
>>> Vadim, could you take care of those 2 points?
>>>
>> Yeah, sure, I'll update 5 and 7.
>> I'm not sure about 8) - do we really need this info, I believe every
>> supported DPLL device exports PTP device as well. But I'm Ok to add this
>> feature too.
> 
> Could you add the notification work while you are at it? I don't want
> that to be forgotten. Thanks!

Sure, Jiri, I'm working on it for ptp_ocp.

>>
>>> Thank you!
>>> Arkadiusz
>>

