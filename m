Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C86C598960
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Aug 2022 18:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345078AbiHRQvh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Aug 2022 12:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345012AbiHRQvf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Aug 2022 12:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9C57969F
        for <linux-rdma@vger.kernel.org>; Thu, 18 Aug 2022 09:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660841490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4hys+dHsvGKwimvP9q8wpRWR1CV0ec7am4TJ1PyleZM=;
        b=UZdcwIYSg9oxF0TD2DsgTciVuB4VtrDFJftdHV2I7K37/HQ6bQzS/f+fGxFfB1Sbpqn9oS
        MVnJG7PbFds+OscvUmfQqVWXZ/dGGNXGTQ6WdOMtP64idHvRANtQ2LgTKzvjk3kz04QEgk
        e7E+lqpSpM2mFV35JWHXyavB0jWBSZs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-266-wN1vYBMkNwCoQ3QrLRSzOA-1; Thu, 18 Aug 2022 12:51:29 -0400
X-MC-Unique: wN1vYBMkNwCoQ3QrLRSzOA-1
Received: by mail-wr1-f71.google.com with SMTP id v27-20020adfa1db000000b002252854ec99so303978wrv.2
        for <linux-rdma@vger.kernel.org>; Thu, 18 Aug 2022 09:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=4hys+dHsvGKwimvP9q8wpRWR1CV0ec7am4TJ1PyleZM=;
        b=JLJmKBajoO9h7KnRhhRkn7swECME0rySQxZk0qAIiw1Z9Aa9CbYvdg+joPQroUwsZc
         7yS/0ZlpfwZk5eXmsTBKj3/DtV6PCKH3SqilGxP5xGGuI+z9yySCvfglzIlL4GMXYeMF
         NchIJ/L4l4Qz5DAxf4NPr/8GaHBBT2lC+/a6f4FumUovTqxqO2mQFr5QlLSeY7p2vRwv
         WsrfhTuYmPP/n9DRA/xa0Ys6K+ecbH9kaSYYOlHArB5sqL+o/HxIy/Yh83StOtxMaQak
         uUqfc+6ID+e/I/vr71WxOJnuSgP0WfLHUFp8SABjJD7pjkT3Sjg/GRr62WRFJV32epiG
         u9qg==
X-Gm-Message-State: ACgBeo31q/2XN/qJz3n97tJu0MBMaGeEWHXLAvadv+X8AWZg3Kq17jrW
        daJ6Aatt/uc76JCdG5i+ovGxd89Ykj9/glU7UiWk0h0G84lOooU1oLIUzMJjMEq7ne9eUsVX0ZE
        4Un8TVeDVaL1qheu1KBgFqQ==
X-Received: by 2002:a7b:cbd0:0:b0:3a6:9f6:a3e8 with SMTP id n16-20020a7bcbd0000000b003a609f6a3e8mr2416308wmi.13.1660841488562;
        Thu, 18 Aug 2022 09:51:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR42KLtH2wgObwY2XF2QCwFA4YZsXhbXH3Krxozkk5s4ActjOWw0Iol/UCx419LGdNcY8BX3xA==
X-Received: by 2002:a7b:cbd0:0:b0:3a6:9f6:a3e8 with SMTP id n16-20020a7bcbd0000000b003a609f6a3e8mr2416291wmi.13.1660841488411;
        Thu, 18 Aug 2022 09:51:28 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b003a5fa79007fsm3034679wmq.7.2022.08.18.09.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 09:51:27 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
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
        Barry Song <song.bao.hua@hisilicon.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH v2 0/5] sched, net: NUMA-aware CPU spreading interface
In-Reply-To: <xhsmhzgg1a4dy.mognet@vschneid.remote.csb>
References: <20220817175812.671843-1-vschneid@redhat.com>
 <9b062b28-e6dd-3af1-da02-1bc511ed6939@intel.com>
 <xhsmhzgg1a4dy.mognet@vschneid.remote.csb>
Date:   Thu, 18 Aug 2022 17:51:26 +0100
Message-ID: <xhsmhwnb5a41d.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 18/08/22 17:43, Valentin Schneider wrote:
> On 18/08/22 09:28, Jesse Brandeburg wrote:
>> On 8/17/2022 10:58 AM, Valentin Schneider wrote:
>>> Hi folks,
>>>
>>> Tariq pointed out in [1] that drivers allocating IRQ vectors would benefit
>>> from having smarter NUMA-awareness (cpumask_local_spread() doesn't quite cut
>>> it).
>>>
>>> The proposed interface involved an array of CPUs and a temporary cpumask, and
>>> being my difficult self what I'm proposing here is an interface that doesn't
>>> require any temporary storage other than some stack variables (at the cost of
>>> one wild macro).
>>>
>>> Patch 5/5 is just there to showcase how the thing would be used. If this doesn't
>>> get hated on, I'll let Tariq pick this up and push it with his networking driver
>>> changes (with actual changelogs).
>>
>> I am interested in this work, but it seems that at least on lore and in
>> my inbox, patch 3,4,5 didn't show up.
>
> I used exactly the same git send-email command for this than for v1 (which
> shows up in its entirety on lore), but I can't see these either. I'm going
> to assume they got lost and will resend them.

Welp, it's there now, but clearly should've used --no-thread when resending
them :/

