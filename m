Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E1E6777FB
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jan 2023 10:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjAWJ6v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Jan 2023 04:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjAWJ6k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Jan 2023 04:58:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570D54C25
        for <linux-rdma@vger.kernel.org>; Mon, 23 Jan 2023 01:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674467871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fp28RUK0xFhE/7bBO5cA+KdBINu5fWDxIv0BbY/vqSI=;
        b=Hp28R70xEspKtuoKndgQAa0DivOHMmZHssM5vLhsp1F45/t4mCYw9QCsmws+9QGl2i83tf
        VeRdWd0AZKgUwPw4DymB7dBZOOwJQ0h7Ulv429kxzzBBjCajLaDgbL/FvVm/ExASdgH8F9
        77VDuqstTZi82C+PTw0I6eVE/IEPa/A=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-Q3OC9urvOjWIIH_za2gcsA-1; Mon, 23 Jan 2023 04:57:50 -0500
X-MC-Unique: Q3OC9urvOjWIIH_za2gcsA-1
Received: by mail-qt1-f199.google.com with SMTP id v15-20020ac873cf000000b003b6428b16deso4254439qtp.3
        for <linux-rdma@vger.kernel.org>; Mon, 23 Jan 2023 01:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fp28RUK0xFhE/7bBO5cA+KdBINu5fWDxIv0BbY/vqSI=;
        b=vvQFZzmbQPXzR2K59R7FLwkLKyQ6RswBGj7meo1wsUZZ82xxB4spRR8WuL0fVpabtA
         5HrBaOFQtXxSys2QfzKAIKIgizvhfCW/bMmBpXyzG3r1n16JRC7cqfP6G2TVqzX1SpHQ
         XJ3zFPzQPwGd0n9V3hNSdvm3TntF/+iE3AqG6irYoUzEmyqRVhPDPKMI1z/zGhxFWIeN
         WyMmVGaqg5FfADu3g0OKZm63qikGWHpOAC17o6bBLqiuMB4s0UazXoYazAmJeknFGscI
         QCKfXgBgnxsG3kqa0jdF8KHj10Zgac1vCxy+N3h/fFlwRZbsllVwKTVERITZDdDhDZxL
         XtKQ==
X-Gm-Message-State: AFqh2kreNXnnpMSej4wn0UXxsZ9OFpZyKvprrIHsNwIx8ODSjNCYP+R/
        JMIwiVLt/AsMRxPC1F0bbZP1h9ZUp+b65GGklCgujM+cMrv4nARNkjLagrso40SqBAcqrtMPIGs
        9MSWtqHvCaLtMq+8INP/ATgOGpqykOUUIfZj9Myxrph1hB8AEGhPfxgChLwV77hBoY3B6L08W0Q
        ==
X-Received: by 2002:ac8:7312:0:b0:3ab:7bb3:4707 with SMTP id x18-20020ac87312000000b003ab7bb34707mr30347701qto.64.1674467869668;
        Mon, 23 Jan 2023 01:57:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsDz4IWmjCsAs0UGbUioIk0MXga0k2KGKS9Tagt1MmSL1NfufKTZiRd8nkPQ0lsXafcagQtmA==
X-Received: by 2002:ac8:7312:0:b0:3ab:7bb3:4707 with SMTP id x18-20020ac87312000000b003ab7bb34707mr30347657qto.64.1674467869404;
        Mon, 23 Jan 2023 01:57:49 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id bz25-20020a05622a1e9900b003a591194221sm9405436qtb.7.2023.01.23.01.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 01:57:48 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tariq Toukan <ttoukan.linux@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Barry Song <baohua@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Gal Pressman <gal@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Haniel Bristot de Oliveira <bristot@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Peter Lafreniere <peter@n8pjl.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH RESEND 0/9] sched: cpumask: improve on
 cpumask_local_spread() locality
In-Reply-To: <4dc2a367-d3b1-e73e-5f42-166e9cf84bac@gmail.com>
References: <20230121042436.2661843-1-yury.norov@gmail.com>
 <4dc2a367-d3b1-e73e-5f42-166e9cf84bac@gmail.com>
Date:   Mon, 23 Jan 2023 09:57:43 +0000
Message-ID: <xhsmhv8kxh8tk.mognet@vschneid.remote.csb>
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

On 22/01/23 14:57, Tariq Toukan wrote:
> On 21/01/2023 6:24, Yury Norov wrote:
>>
>> This series was supposed to be included in v6.2, but that didn't happen. It
>> spent enough in -next without any issues, so I hope we'll finally see it
>> in v6.3.
>>
>> I believe, the best way would be moving it with scheduler patches, but I'm
>> OK to try again with bitmap branch as well.
>
> Now that Yury dropped several controversial bitmap patches form the PR,
> the rest are mostly in sched, or new API that's used by sched.
>
> Valentin, what do you think? Can you take it to your sched branch?
>

I would if I had one :-)

Peter/Ingo, any objections to stashing this in tip/sched/core?

