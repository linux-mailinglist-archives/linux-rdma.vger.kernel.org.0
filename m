Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A9759892B
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Aug 2022 18:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344265AbiHRQoA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Aug 2022 12:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbiHRQn7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Aug 2022 12:43:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6C27286E
        for <linux-rdma@vger.kernel.org>; Thu, 18 Aug 2022 09:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660841037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eqToihXW7UPc5fyH33OBT/OedZIImlp+Kc9bZc6ly0A=;
        b=VB0JeSuqVWSjoRAFSG89e/vlPzbLsmuh0/kSzlRpEjYpKA8OA/APqsMpItIooyt1FQrRf7
        a9gE+qnWOeN6rdO51IkddXFf+JbaJhB+qFXTmi/8MHtjzLHY4rwPzq/KdUhdn3PfEJFOoG
        6ZqTzmmXWskvUWkYg3w4+3krTc8MOjU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-621-_1Eu9H3UNaywn09n9sBaEw-1; Thu, 18 Aug 2022 12:43:56 -0400
X-MC-Unique: _1Eu9H3UNaywn09n9sBaEw-1
Received: by mail-wm1-f69.google.com with SMTP id b16-20020a05600c4e1000b003a5a47762c3so1177767wmq.9
        for <linux-rdma@vger.kernel.org>; Thu, 18 Aug 2022 09:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=eqToihXW7UPc5fyH33OBT/OedZIImlp+Kc9bZc6ly0A=;
        b=1eU9ldQGkXXg1reM84A4IuI9vNbPhpGnTXm4zsDl1TWs21dRA1296V/UBAbNqWH7c1
         JzW5in8g/KfzhP7p4YrTI9dFfTimwMxlcrVXkw0frcXVEZtTdWtwNCcz0LNSlQqLAdDq
         dNjnp23XyIJB0yypx71GeUJHyoJmjJSHnM7XQbwDukD+8jIMVL/fgEtk8JZnhT4lgMk+
         dCNKhLVGFKlGwEI3RBB5+xxwxaHzJl1E2kKUWI3JVsK5m+2OsKpek9eWOjqG2Zt1+ga2
         gJkkvLbVrwrd0yEXIh/RbvtWSFUYwfD5IIT00FZbzEp4Qy2ZBjgTrD4PSxBlmC/1BmTL
         Rh0g==
X-Gm-Message-State: ACgBeo1M820t5EEYsRIPSz64Ffc/kDbisInIasXDGFw9SICfTTuyMKj+
        Mcb/S53f2yAYCk72z8hz2103mKqxALMVca+A1NQMMpnOwNHUcx7Hsluy0sTl+/a3tTw4BFsLh6C
        1irMQLTHQe2yYBEWfsIAX0A==
X-Received: by 2002:a05:600c:34c5:b0:3a5:f6e5:1cb4 with SMTP id d5-20020a05600c34c500b003a5f6e51cb4mr2462936wmq.71.1660841035505;
        Thu, 18 Aug 2022 09:43:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6zVAvV4ZDxfM+xoVbsQJM08MqXGQTOR77bBLXVroW/ZlJy6DF/9cr8lI/MZsemart2GDI+Og==
X-Received: by 2002:a05:600c:34c5:b0:3a5:f6e5:1cb4 with SMTP id d5-20020a05600c34c500b003a5f6e51cb4mr2462928wmq.71.1660841035373;
        Thu, 18 Aug 2022 09:43:55 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id l17-20020a05600c4f1100b003a1980d55c4sm6660692wmq.47.2022.08.18.09.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 09:43:54 -0700 (PDT)
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
In-Reply-To: <9b062b28-e6dd-3af1-da02-1bc511ed6939@intel.com>
References: <20220817175812.671843-1-vschneid@redhat.com>
 <9b062b28-e6dd-3af1-da02-1bc511ed6939@intel.com>
Date:   Thu, 18 Aug 2022 17:43:53 +0100
Message-ID: <xhsmhzgg1a4dy.mognet@vschneid.remote.csb>
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

On 18/08/22 09:28, Jesse Brandeburg wrote:
> On 8/17/2022 10:58 AM, Valentin Schneider wrote:
>> Hi folks,
>>
>> Tariq pointed out in [1] that drivers allocating IRQ vectors would benefit
>> from having smarter NUMA-awareness (cpumask_local_spread() doesn't quite cut
>> it).
>>
>> The proposed interface involved an array of CPUs and a temporary cpumask, and
>> being my difficult self what I'm proposing here is an interface that doesn't
>> require any temporary storage other than some stack variables (at the cost of
>> one wild macro).
>>
>> Patch 5/5 is just there to showcase how the thing would be used. If this doesn't
>> get hated on, I'll let Tariq pick this up and push it with his networking driver
>> changes (with actual changelogs).
>
> I am interested in this work, but it seems that at least on lore and in
> my inbox, patch 3,4,5 didn't show up.

I used exactly the same git send-email command for this than for v1 (which
shows up in its entirety on lore), but I can't see these either. I'm going
to assume they got lost and will resend them.

