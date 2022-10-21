Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AB5607933
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 16:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiJUOHH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 10:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiJUOHG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 10:07:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E3327B080
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 07:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666361223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3QGZu1yFvyf6/rAbNjced6K1/QFYwLbCoSzwaCS4YJw=;
        b=U6tuWJrRt6A51w0ntTwiAUtl3RG706GYzrQT0FgSwqxss6mzEZ+df7AZ/ofCkZfdsVgMCy
        PklhMJDOhKhOMvRVxXm5O96Xf5ua5KnOs7WV9mod7Mq/Nu+xzevIf8o7g0uatw+dArRKt6
        EdAZO8ZBo0B59vk4SZz2jZtrwZyPmTM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-475-xMiCQvW8OpehzfClNaoHmg-1; Fri, 21 Oct 2022 10:07:02 -0400
X-MC-Unique: xMiCQvW8OpehzfClNaoHmg-1
Received: by mail-io1-f70.google.com with SMTP id 23-20020a5d9c57000000b006bbd963e8adso2789091iof.19
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 07:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3QGZu1yFvyf6/rAbNjced6K1/QFYwLbCoSzwaCS4YJw=;
        b=SJlimYAhPAbNEcMWIhPdlsCCYVxof/xtmG8gOFYcycwEQfmFUn7xMuA7y5D5FCF4Hp
         OsMv1HrscuYG4LZbGAATu6AN30dBBvrLjHpZ2mumce5l/YL8mhDtCwY6EO8UtztIBsbu
         6l/xIh/C0QuLreXSRDU3awXrnGiXGiD9fnRA6jpVWvweVaeIKfMGusBU1I++r75BNVdG
         kValkeCyLiEz9PgU74l6qBEyfcsvPS0fvn7NxreYk7u6Q87uqnwVz2Y5/Z0TD207YI7+
         EaNhUXgB5I7Tls74yFiDefqVjXEVPKfsIPDGHagXcKPdCjRUeMVSQ9rZz5rrQCInYoLt
         vB2Q==
X-Gm-Message-State: ACrzQf2FyFk5LkxtkCWJSceuQN0NVzgArwy4Kb1YoJW822oABVrpna8n
        rzw/YYEp/fw2SXq3aFS0R/XG7dMJg9p5xbIyw4TSuqiZvxqqQZ07yQ8vjCmWLPwHbnqG58a2h3F
        dwU18uDN0wxzPdujXulRsOA==
X-Received: by 2002:a05:620a:25d0:b0:6bb:f597:1a3 with SMTP id y16-20020a05620a25d000b006bbf59701a3mr13844655qko.43.1666361211254;
        Fri, 21 Oct 2022 07:06:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5PUFH3m6ZTTlU33UA2PdaYuGQE9STy2VAbagGXGo9HRDsPB0Do+jHqX5qJCpNPyjJaSVkgmg==
X-Received: by 2002:ac8:5d49:0:b0:399:c50c:7171 with SMTP id g9-20020ac85d49000000b00399c50c7171mr17149746qtx.564.1666361200452;
        Fri, 21 Oct 2022 07:06:40 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id n12-20020a05620a294c00b006ced5d3f921sm9926015qkp.52.2022.10.21.07.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 07:06:39 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
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
Subject: Re: [PATCH v5 2/3] sched/topology: Introduce for_each_numa_hop_mask()
In-Reply-To: <Y1Kf+aZPIxGCbksM@smile.fi.intel.com>
References: <20221021121927.2893692-1-vschneid@redhat.com>
 <20221021121927.2893692-3-vschneid@redhat.com>
 <Y1KboXN0f8dLjqit@smile.fi.intel.com>
 <Y1Kf+aZPIxGCbksM@smile.fi.intel.com>
Date:   Fri, 21 Oct 2022 15:06:36 +0100
Message-ID: <xhsmhilkdw9sj.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 21/10/22 16:34, Andy Shevchenko wrote:
> On Fri, Oct 21, 2022 at 04:16:17PM +0300, Andy Shevchenko wrote:
>> On Fri, Oct 21, 2022 at 01:19:26PM +0100, Valentin Schneider wrote:
>
> ...
>
>> > +#define for_each_numa_hop_mask(mask, node)				     \
>> > +	for (unsigned int __hops = 0;					     \
>> > +	     /*								     \
>> > +	      * Unsightly trickery required as we can't both initialize	     \
>> > +	      * @mask and declare __hops in for()'s first clause	     \
>> > +	      */							     \
>> > +	     mask = __hops > 0 ? mask :					     \
>> > +		    node == NUMA_NO_NODE ?				     \
>> > +		    cpu_online_mask : sched_numa_hop_mask(node, 0),	     \
>> > +	     !IS_ERR_OR_NULL(mask);					     \
>>
>> > +	     __hops++,							     \
>> > +	     mask = sched_numa_hop_mask(node, __hops))
>>
>> This can be unified with conditional, see for_each_gpio_desc_with_flag() as
>> example how.
>
> Something like
>
>       mask = (__hops || node != NUMA_NO_NODE) ? sched_numa_hop_mask(node, __hops) : cpu_online_mask
>

That does simplify things somewhat, thanks!

> --
> With Best Regards,
> Andy Shevchenko

