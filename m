Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE960620FDC
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Nov 2022 13:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbiKHMIG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Nov 2022 07:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbiKHMIG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Nov 2022 07:08:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACBD624D
        for <linux-rdma@vger.kernel.org>; Tue,  8 Nov 2022 04:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667909232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IMfMqd/NRcR1JqekXckZSgySkw+5cuSOOLne9X/Ks6Y=;
        b=fPhKLJ9xCmNu1oZCtI71ttB0lmEjf0cIyTIOOvyg37ayvb4A9CGSHshwmo8U1BNiXWhP/4
        Sf4oikFh4ygjayrTaSQpzta+0OiaVY11ulOM4rkl7uEvhi4QtL6Y6SSFz2wt2PizHK4cM1
        ysZT5qqqam+cyW1k5RxYZHd9Xrcaa7Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-59-75mH8rWuOreypkMXd8sp5A-1; Tue, 08 Nov 2022 07:07:11 -0500
X-MC-Unique: 75mH8rWuOreypkMXd8sp5A-1
Received: by mail-wm1-f71.google.com with SMTP id bi19-20020a05600c3d9300b003cf9d6c4016so5098718wmb.8
        for <linux-rdma@vger.kernel.org>; Tue, 08 Nov 2022 04:07:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMfMqd/NRcR1JqekXckZSgySkw+5cuSOOLne9X/Ks6Y=;
        b=Uue+IKPAIcVTk2YcPs9wh5BvkVXlSGdiwi7u0LcVsG0zX2nClNdwcLtTxwa44IIQoy
         qfj3+D0F6rFa3CC11v/CoSFCREm6nzwuds05ja4JKM5LTUhORjJwKjR9s5y08DiYqmgD
         2iIe3gbrEtMLGNyTbZedUGQgyI9FNMhfzhLHCKoN6L8oKXR3Iou3+s6z2gXB+eW9KcEf
         RrY5Mi9mpGWmyW3aKMu2CAx9r3FBY3eRkpZCvyK2gVDO6dozPjg9FqJNai9MSfMQjQ4E
         oOkFACfMw6Cd0wE6k52MdZ1TtCddRavvfrhC2aDoY+j2/DzRgPTU77QEr6hj/XYJZtJn
         7RRg==
X-Gm-Message-State: ACrzQf1kog3gshq2hwtYsDEiKyplLvJ3utJFd4Py3kPk78AOYNgKIjim
        t+KXOho0X3SiETtnD2H1JlemxKSEeMMIeCzyD+3NWQMgLNaCnQHkf2f2LvVfOYrPeH3xZIENn7M
        uB0s//HORxTgQk4Q2koQiMQ==
X-Received: by 2002:adf:f58e:0:b0:236:a8b2:373 with SMTP id f14-20020adff58e000000b00236a8b20373mr35753923wro.575.1667909229342;
        Tue, 08 Nov 2022 04:07:09 -0800 (PST)
X-Google-Smtp-Source: AMsMyM671SN4rKjOS4m0IXm1rydtBeGKPVnCuxp/5nq9PqKtGUO9t65vl23IJqhbdg2+p5gCuDL/pw==
X-Received: by 2002:adf:f58e:0:b0:236:a8b2:373 with SMTP id f14-20020adff58e000000b00236a8b20373mr35753898wro.575.1667909229147;
        Tue, 08 Nov 2022 04:07:09 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id m11-20020a5d4a0b000000b0022ca921dc67sm9877375wrq.88.2022.11.08.04.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 04:07:08 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tariq Toukan <ttoukan.linux@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH v6 0/3] sched, net: NUMA-aware CPU spreading interface
In-Reply-To: <ca6a5aee-19c8-e0a9-60af-00e2e5abaed0@gmail.com>
References: <20221028164959.1367250-1-vschneid@redhat.com>
 <20221102195616.6f55c894@kernel.org>
 <ca6a5aee-19c8-e0a9-60af-00e2e5abaed0@gmail.com>
Date:   Tue, 08 Nov 2022 12:07:07 +0000
Message-ID: <xhsmhleolmyz8.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 08/11/22 13:25, Tariq Toukan wrote:
> On 11/3/2022 4:56 AM, Jakub Kicinski wrote:
>> On Fri, 28 Oct 2022 17:49:56 +0100 Valentin Schneider wrote:
>>> Tariq pointed out in [1] that drivers allocating IRQ vectors would benefit
>>> from having smarter NUMA-awareness (cpumask_local_spread() doesn't quite cut
>>> it).
>>>
>>> The proposed interface involved an array of CPUs and a temporary cpumask, and
>>> being my difficult self what I'm proposing here is an interface that doesn't
>>> require any temporary storage other than some stack variables (at the cost of
>>> one wild macro).
>>>
>>> [1]: https://lore.kernel.org/all/20220728191203.4055-1-tariqt@nvidia.com/
>>
>> Not sure who's expected to take these, no preference here so:
>>
>> Acked-by: Jakub Kicinski <kuba@kernel.org>
>>
>> Thanks for ironing it out!
>
> Thanks Jakub.
>
> Valentin, what do you think?
> Shouldn't it go through the sched branch?

So yeah the topology bits should go through tip/sched/core, and given it's
the only user of the new interface, the mlx5e one should probably be
bundled with them.

