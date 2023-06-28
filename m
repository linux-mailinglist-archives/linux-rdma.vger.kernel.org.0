Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888F974136A
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jun 2023 16:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjF1OFh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jun 2023 10:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjF1OEO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Jun 2023 10:04:14 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658573A99
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jun 2023 07:02:27 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso5602533e87.1
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jun 2023 07:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687960945; x=1690552945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NeJJDtPNApCUCSNLbnRFD2Juhjv5XOx3haoMLR3t3E0=;
        b=ZK23Wz5Z8GgdygT07do/GeGr7NCgPtbZJrbEsqK+sYNbzD9dq931xi8plPBr2KO/YC
         c2ElDHPq2AXJLH8RWwZpB9knsmuQiwkA75793nzLpisqpqvUa59/U20kPPeRdhQAkFFo
         EcsePNHr4CjPy3GTkqp1HQZS4o+ge1jZitdNMcjjH282ksos55LbhmkEg5xKNUQUAHkW
         6elrjwozhdUiF5BEcoPrNlp7uOlNgyP51atS4qs5XQofDSmEJm98Sjm1IBUOaK7EQWtK
         w84yxmQahBhA3t//6ifI1+JN4mdssr5CTku4Y6hA7S2ImLAYmYaBhDJ+IlVLNrGKFrhO
         3CqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687960945; x=1690552945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeJJDtPNApCUCSNLbnRFD2Juhjv5XOx3haoMLR3t3E0=;
        b=ZXW3yJ95QtcLBfEy3e7rVbl7i3WI0/nbRchntAhAoeiNlvWZ5izGqKXTnYv57HOnWo
         R7q21SGuyPdTUwcQFFU7hcaxr7VhR96kmJYViemD5sqFKITF5BX7Onptcx8kX8ZIu2pi
         15KCvpgvl2O0befMvBb57aXFnbzkb3z+1aMXGaBlLx+7WkEOGRjGgm6gs7YAzuAg1lZ3
         jVI0tQlXk0bPjGJzPHdm5iYa4ZVONz1o22mTq2jzIIL+XPrrdpOZbz+PO+rshxocKOC8
         WtoyzrvLpK9DB5mx0IZdw2hRn+Ewpqz4qMPsXjPnUtJrxyMRRh5mEjKryneERUN32xdr
         +EZg==
X-Gm-Message-State: AC+VfDysa29kqH6d/7zE0zdx3Ekltvf5psGuwoC3NPKSQIWbP1o/SPD+
        FM483hRsYqJ0eRkNMBqWHQJBwg==
X-Google-Smtp-Source: ACHHUZ5ZxgNTxIxoQXOSx9k7rDEhnxIvqJQLYYOVQL1GcheSfi0K/9HAYhI29JpjcdxZaZ1hTbJv2w==
X-Received: by 2002:a05:6512:3412:b0:4fb:242:6e00 with SMTP id i18-20020a056512341200b004fb02426e00mr7754216lfr.41.1687960945439;
        Wed, 28 Jun 2023 07:02:25 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k8-20020a7bc408000000b003fba87298cesm4354984wmi.45.2023.06.28.07.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 07:02:24 -0700 (PDT)
Date:   Wed, 28 Jun 2023 16:02:23 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Vadim Fedorenko <vadim.fedorenko@linux.dev>
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
Subject: Re: [RFC PATCH v9 00/10] Create common DPLL configuration API
Message-ID: <ZJw9b9RQamu0cLN+@nanopsycho>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
 <ZJq3a6rl6dnPMV17@nanopsycho>
 <DM6PR11MB4657084DDD7554663F86C1C19B24A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <DM6PR11MB4657A1ACB586AD9B45C7996E9B24A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <2e9ce197-2732-d061-b11d-4f4513af6abc@linux.dev>
 <ZJwxHucKMwCQMMVM@nanopsycho>
 <4ebfa74e-8998-a1af-e6b9-3701008900ec@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ebfa74e-8998-a1af-e6b9-3701008900ec@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Wed, Jun 28, 2023 at 03:22:00PM CEST, vadim.fedorenko@linux.dev wrote:
>On 28/06/2023 14:09, Jiri Pirko wrote:
>> Wed, Jun 28, 2023 at 01:11:19PM CEST, vadim.fedorenko@linux.dev wrote:
>> > On 28/06/2023 10:27, Kubalewski, Arkadiusz wrote:
>> > > > From: Kubalewski, Arkadiusz
>> > > > Sent: Wednesday, June 28, 2023 11:15 AM
>> > > > 
>> > > > > From: Jiri Pirko <jiri@resnulli.us>
>> > > > > Sent: Tuesday, June 27, 2023 12:18 PM
>> > > > > 
>> > > > > Fri, Jun 23, 2023 at 02:38:10PM CEST, arkadiusz.kubalewski@intel.com
>> > > > wrote:
>> > > > > 
>> > > > > > v8 -> v9:
>> > > > > 
>> > > > > Could you please address all the unresolved issues from v8 and send v10?
>> > > > > I'm not reviewing this one.
>> > > > > 
>> > > > > Thanks!
>> > > > 
>> > > > Sure, will do, but first missing to-do/discuss list:
>> > > > 1) remove mode_set as not used by any driver
>> > > > 2) remove "no-added-value" static functions descriptions in
>> > > >     dpll_core/dpll_netlink
>> > > > 3) merge patches [ 03/10, 04/10, 05/10 ] into patches that are compiling
>> > > >     after each patch apply
>> > > > 4) remove function return values descriptions/lists
>> > > > 5) Fix patch [05/10]:
>> > > >     - status Supported
>> > > >     - additional maintainers
>> > > >     - remove callback:
>> > > >       int (*source_pin_idx_get)(...) from `struct dpll_device_ops`
>> > > > 6) Fix patch [08/10]: rethink ice mutex locking scheme
>> > > > 7) Fix patch [09/10]: multiple comments on
>> > > > https://lore.kernel.org/netdev/ZIQu+%2Fo4J0ZBspVg@nanopsycho/#t
>> > > > 8) add PPS DPLL phase offset to the netlink get-device API
>> > > > 
>> > > > Thank you!
>> > > > Arkadiusz
>> > > 
>> > > If someone has any objections please state them now, I will work on
>> > > all above except 5) and 7).
>> > > Vadim, could you take care of those 2 points?
>> > > 
>> > Yeah, sure, I'll update 5 and 7.
>> > I'm not sure about 8) - do we really need this info, I believe every
>> > supported DPLL device exports PTP device as well. But I'm Ok to add this
>> > feature too.
>> 
>> Could you add the notification work while you are at it? I don't want
>> that to be forgotten. Thanks!
>
>Sure, Jiri, I'm working on it for ptp_ocp.

Yep, cool!

>
>> > 
>> > > Thank you!
>> > > Arkadiusz
>> > 
>
