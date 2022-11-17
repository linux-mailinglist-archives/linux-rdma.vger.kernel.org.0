Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D0062DA99
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Nov 2022 13:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239779AbiKQMY4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Nov 2022 07:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239694AbiKQMYy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Nov 2022 07:24:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1233911172
        for <linux-rdma@vger.kernel.org>; Thu, 17 Nov 2022 04:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668687833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5jdvVC382FTzq1UHx+dqms0RlcCWrWtt69iT+pMSrhc=;
        b=CORut+raWrAs49WAYBmgMGKxcA6W14LdKITb+5nUVCIIHv+kSFlboRnF8ef8VIxtj7KBZ7
        y+G+wjO3ZToOBdsUFrngfzUZiX2hbvXGC++8fopW9NUhghN5YxesS/VlObzVNtpvyuJMfn
        zLQGS6use0jUP7yKmj1oc1mIMN+r354=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-152-7E6Ql98EMOCsVjV3VLo9Gg-1; Thu, 17 Nov 2022 07:23:52 -0500
X-MC-Unique: 7E6Ql98EMOCsVjV3VLo9Gg-1
Received: by mail-wr1-f69.google.com with SMTP id h26-20020adfaa9a000000b002364ad63bbcso638967wrc.10
        for <linux-rdma@vger.kernel.org>; Thu, 17 Nov 2022 04:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jdvVC382FTzq1UHx+dqms0RlcCWrWtt69iT+pMSrhc=;
        b=FNmDGbpZQqqfJzyKpkmbHpl3H08kwzuolt5NOIhB1dyZe9uzyS5zdGyt9s+E+cjbvL
         QHEkNNYCpqliRwdmnRyuk8O25o3RvBxrHJNyP0SZ8cmjvEJ6GsKn0nf+wfX90Sg9hPk4
         t8Jz5QSDVka1KzT0dzdi4gcLcqKAfLStZpTO1IkDZLYmDXpu+8qXVcHUtRetcjwaqQiH
         mTgBdebTI0rVXz+i6npJNViSYShf++XB5ePOhZI3QVb61nrP1jRcbI6kAub7O3mRj7eK
         9lUnR0d7vXcKOP5FFuGld3Dc9Y5T89XEi5qLzGJ+vEBo2ZlwG3t+c7iSfx/WM84wuXy4
         FCvQ==
X-Gm-Message-State: ANoB5pk6loLBybNgZQ9RTUIcjVbqLI7NXv6dsnImldBcljl145zdjgVQ
        Kl4NqVHvQNMeWcI2AMalDCitkOjRjF7PsrMlkJnSqHY0sJVAAirl0X1muN6T+DPT5lQ5opWKnGe
        chcH/woQ4uc/Ep6ZIGoBlR8tGpuFQX+/wgAXd7NwUhzkmMZJa0JlZ9EWB9LUS6YwMYOCkkZBzqQ
        ==
X-Received: by 2002:a5d:4ace:0:b0:236:7988:b282 with SMTP id y14-20020a5d4ace000000b002367988b282mr1368755wrs.341.1668687830338;
        Thu, 17 Nov 2022 04:23:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6CQ2UnPStDreGkKJNcXcxnxWYWv26PNS2guHgtGUV1HlDKjg+B2zZNBBQjpHdL/U5XI5rkiQ==
X-Received: by 2002:a5d:4ace:0:b0:236:7988:b282 with SMTP id y14-20020a5d4ace000000b002367988b282mr1368719wrs.341.1668687830120;
        Thu, 17 Nov 2022 04:23:50 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c35c400b003c6b874a0dfsm1315337wmq.14.2022.11.17.04.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 04:23:49 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Barry Song <baohua@kernel.org>,
        Ben Segall <bsegall@google.com>,
        haniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Gal Pressman <gal@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Tariq Toukan <ttoukan.linux@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 0/4] cpumask: improve on cpumask_local_spread() locality
In-Reply-To: <Y3PXw8Hqn+RCMg2J@yury-laptop>
References: <20221112190946.728270-1-yury.norov@gmail.com>
 <xhsmh7czwyvtj.mognet@vschneid.remote.csb> <Y3PXw8Hqn+RCMg2J@yury-laptop>
Date:   Thu, 17 Nov 2022 12:23:45 +0000
Message-ID: <xhsmho7t5ydke.mognet@vschneid.remote.csb>
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

On 15/11/22 10:32, Yury Norov wrote:
> On Tue, Nov 15, 2022 at 05:24:56PM +0000, Valentin Schneider wrote:
>>
>> Is this meant as a replacement for [1]?
>
> No. Your series adds an iterator, and in my experience the code that
> uses iterators of that sort is almost always better and easier to
> understand than cpumask_nth() or cpumask_next()-like users.
>
> My series has the only advantage that it allows keep existing codebase
> untouched.
>

Right

>> I like that this is changing an existing interface so that all current
>> users directly benefit from the change. Now, about half of the users of
>> cpumask_local_spread() use it in a loop with incremental @i parameter,
>> which makes the repeated bsearch a bit of a shame, but then I'm tempted to
>> say the first point makes it worth it.
>>
>> [1]: https://lore.kernel.org/all/20221028164959.1367250-1-vschneid@redhat.com/
>
> In terms of very common case of sequential invocation of local_spread()
> for cpus from 0 to nr_cpu_ids, the complexity of my approach is n * log n,
> and your approach is amortized O(n), which is better. Not a big deal _now_,
> as you mentioned in the other email. But we never know how things will
> evolve, right?
>
> So, I would take both and maybe in comment to cpumask_local_spread()
> mention that there's a better alternative for those who call the
> function for all CPUs incrementally.
>

Ack, sounds good.

> Thanks,
> Yury

