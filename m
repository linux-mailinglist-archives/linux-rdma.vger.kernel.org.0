Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB575AD7C0
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Sep 2022 18:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiIEQoM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Sep 2022 12:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiIEQoK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Sep 2022 12:44:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C422161B0C
        for <linux-rdma@vger.kernel.org>; Mon,  5 Sep 2022 09:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662396249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rFN8kU4pPUwKGAD0Wxcp7MwYS+FD1wiqpVVQEqbcbG4=;
        b=fF3DXUzYx4eFEBYdRplycS7CGVFDFoI93+ghfm67c00j2TkWi+7cSKmXh5ylphwCM8DeUQ
        xzN9Sm98MUMO/LVLzzkSEBUf4hHIukCQTuAp6Xft74qhBZ8svX5dG2wQjTnktcbWRN5PLE
        PZM8DDM7Is13VzkHZnL/B0GlGY0ebkw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-541-Ky4PKPN3PByosH0BPb0JWA-1; Mon, 05 Sep 2022 12:44:08 -0400
X-MC-Unique: Ky4PKPN3PByosH0BPb0JWA-1
Received: by mail-wr1-f72.google.com with SMTP id d11-20020adfc08b000000b002207555c1f6so1411041wrf.7
        for <linux-rdma@vger.kernel.org>; Mon, 05 Sep 2022 09:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=rFN8kU4pPUwKGAD0Wxcp7MwYS+FD1wiqpVVQEqbcbG4=;
        b=OF9MEtvJ9ewHdWqjnrBwxP3mJLtXfRxh/Wb5FKlwFE3a+b/ddfejwIi1UGCr6Zet4e
         P6DHeqPZvryznQ3ohSBFu9e2ZYia8BPtOPtjHPRYiQQt2srBHHQ5YDou0GiVz8i76aU+
         V5bqqa2f8aSxymTUJnsGwsit8zcdTU/eO6M/B/hpXrrGDHV6vPDIypw8gzvd2RfJ6Bp0
         aBpGi8mmaaqla/A3ZYX+K7wK7lvbhusmIuOy89UtL4rLQpXz1zlOaXgHb9iHk5i+rF2G
         03jR9aF3KdlcXQHb2LNJrrTIWGY1+tEUmbk5w/3UYwXtXN1rigXsKt55hF8Wrw9svxyO
         24tA==
X-Gm-Message-State: ACgBeo1ZCm3L30olILogpJyAK1Nh+j4QvjVaAh59ghoXsqgBFq1K2cOP
        hIlpacFr5SVudPJjSzqgPYbcBvQ8jK0n4bemHWVFmb8X0jl4pCuRLdIwpIq1NU8nMSJ54MPaUai
        Uu99eM2S3TuW1O35qtCtIUg==
X-Received: by 2002:adf:f54a:0:b0:228:951a:2949 with SMTP id j10-20020adff54a000000b00228951a2949mr2874153wrp.240.1662396246969;
        Mon, 05 Sep 2022 09:44:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5IxX+rZOV0sxAdwQEggf0zCPW4siPm15jli7Tzs7+LElEdo/Qe1BbBn5i3TVU8J39X2eN/yg==
X-Received: by 2002:adf:f54a:0:b0:228:951a:2949 with SMTP id j10-20020adff54a000000b00228951a2949mr2874125wrp.240.1662396246798;
        Mon, 05 Sep 2022 09:44:06 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id k27-20020a05600c1c9b00b003a845fa1edfsm29552176wms.3.2022.09.05.09.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 09:44:06 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
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
Subject: Re: [PATCH v3 4/9] cpumask: Introduce for_each_cpu_andnot()
In-Reply-To: <YwfmIDEbRT4JfsZp@yury-laptop>
References: <20220825181210.284283-1-vschneid@redhat.com>
 <20220825181210.284283-5-vschneid@redhat.com>
 <YwfmIDEbRT4JfsZp@yury-laptop>
Date:   Mon, 05 Sep 2022 17:44:05 +0100
Message-ID: <xhsmh5yi1db56.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 25/08/22 14:14, Yury Norov wrote:
> On Thu, Aug 25, 2022 at 07:12:05PM +0100, Valentin Schneider wrote:
>> +#define for_each_cpu_andnot(cpu, mask1, mask2)				\
>> +	for ((cpu) = -1;						\
>> +		(cpu) = cpumask_next_andnot((cpu), (mask1), (mask2)),	\
>> +		(cpu) < nr_cpu_ids;)
>
> The standard doesn't guarantee the order of execution of last 2 lines,
> so you might end up with unreliable code. Can you do it in a more
> conventional style:
>    #define for_each_cpu_andnot(cpu, mask1, mask2)			\
>       for ((cpu) = cpumask_next_andnot(-1, (mask1), (mask2));         \
>               (cpu) < nr_cpu_ids;                                     \
>               (cpu) = cpumask_next_andnot((cpu), (mask1), (mask2)))
>

IIUC the order of execution *is* guaranteed as this is a comma operator,
not argument passing:

  6.5.17 Comma operator

  The left operand of a comma operator is evaluated as a void expression;
  there is a sequence point after its evaluation. Then the right operand is
  evaluated; the result has its type and value.

for_each_cpu{_and}() uses the same pattern (which I simply copied here).

Still, I'd be up for making this a bit more readable. I did a bit of
digging to figure out how we ended up with that pattern, and found

  7baac8b91f98 ("cpumask: make for_each_cpu_mask a bit smaller")

so this appears to have been done to save up on generated instructions.
*if* it is actually OK standard-wise, I'd vote to leave it as-is.

>> +
>>  /**
>>   * cpumask_any_but - return a "random" in a cpumask, but not this one.
>>   * @mask: the cpumask to search
>> --
>> 2.31.1

