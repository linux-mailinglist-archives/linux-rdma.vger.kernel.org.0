Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486815A1CFE
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Aug 2022 01:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241960AbiHYXR0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Aug 2022 19:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiHYXRZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Aug 2022 19:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CBDAED8C
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 16:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661469443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K6IqYdtlgkGTFXh/CrtZFmNhEM6cVjYadyTzynsMreE=;
        b=fSrTb/H4Z6Isco9K8Qfq7Ve/8y2mDI5tPaY6DsYPadBumJzzDAh33xJP8XjZVg/8iewOtH
        EJl9mxrw6tl8Nu15+iSlzCGoyRhKIyFxpLJwAnrMLmOelU1g+6jkH0sCEYfloQxes3oc0H
        W7WnzJCYXmUIXrvhnm2bo6Zm7TlqF/Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-468-UB3cTLT3My-1pekAL3XA0g-1; Thu, 25 Aug 2022 19:17:22 -0400
X-MC-Unique: UB3cTLT3My-1pekAL3XA0g-1
Received: by mail-wr1-f70.google.com with SMTP id t12-20020adfa2cc000000b00224f577fad1so3671937wra.4
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 16:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=K6IqYdtlgkGTFXh/CrtZFmNhEM6cVjYadyTzynsMreE=;
        b=OsozEaY/SxN3jbOxNQgj4/DpRfeLfc8iQndAOlk5vV1JYDbXUM5raPcmMWs4uyiODS
         lCTosQ3oouSCgVFatOLDgplDYhwKxZfQuR6QWliruY3Ux3tJhFSdKQANxKM0dCdbYQDi
         xA+EGEKaXuArAQhiZteb+T/6RCoehrKr9h/BAOG/QtcRZIeu3Bv51FmF5X+7zrUnF1Qx
         FeJXtgCVQeANZ7fh5wuA+B201Hsb8Ejd+pZCOgcWczylif+feB8sldiiaVLocC6aCjOk
         LfS5PblD1qCQMt5cEFBoCHfJBCuVXkj1QUeyninKoE7CMqyKJwgTjHTz/9YRcMHSKZe2
         0ycQ==
X-Gm-Message-State: ACgBeo3P+M2PIRLcMaA0yJrkPSnC+4RaordGfwTuLXGUFh+8F7lKrjCb
        HM7YdtcSrTzSVS6vasIm87SArLSNyW3erSY4+jjz1hNj/WrpJ7Exmpi4FWDyo2VrdB/Gy0Eg3Wz
        DuW9WGLmyHdF+lZj8JpyNxQ==
X-Received: by 2002:a5d:5985:0:b0:222:c5dd:b7c8 with SMTP id n5-20020a5d5985000000b00222c5ddb7c8mr3504010wri.511.1661469441411;
        Thu, 25 Aug 2022 16:17:21 -0700 (PDT)
X-Google-Smtp-Source: AA6agR69aRJWSvroO1rYxs4Q8ah8RPjKum/nyjTtNH7rEv6bS/g//UO1WyhZxD9GFFORywOnXyXxYw==
X-Received: by 2002:a5d:5985:0:b0:222:c5dd:b7c8 with SMTP id n5-20020a5d5985000000b00222c5ddb7c8mr3503998wri.511.1661469441183;
        Thu, 25 Aug 2022 16:17:21 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b003a64f684704sm7526156wmq.40.2022.08.25.16.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 16:17:20 -0700 (PDT)
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
Subject: Re: [PATCH v3 3/9] bitops: Introduce find_next_andnot_bit()
In-Reply-To: <YwfkDBl6DD+9Zjmk@yury-laptop>
References: <20220825181210.284283-1-vschneid@redhat.com>
 <20220825181210.284283-4-vschneid@redhat.com>
 <YwfkDBl6DD+9Zjmk@yury-laptop>
Date:   Fri, 26 Aug 2022 00:17:19 +0100
Message-ID: <xhsmhpmgngbgg.mognet@vschneid.remote.csb>
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

On 25/08/22 14:05, Yury Norov wrote:
> On Thu, Aug 25, 2022 at 07:12:04PM +0100, Valentin Schneider wrote:
>> In preparation of introducing for_each_cpu_andnot(), add a variant of
>> find_next_bit() that negate the bits in @addr2 when ANDing them with the
>> bits in @addr1.
>>
>> Note that the _find_next_bit() @invert argument now gets split into two:
>> @invert1 for words in @addr1, @invert2 for words in @addr2. The only
>> current users of _find_next_bit() with @invert set are:
>>   o find_next_zero_bit()
>>   o find_next_zero_bit_le()
>> and neither of these pass an @addr2, so the conversion is straightforward.
>>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>
> Have you seen this series?
> https://lore.kernel.org/lkml/YwaXvphVpy5A7fSs@yury-laptop/t/
>
> It will significantly simplify your work for adding the
> find_next_andnot_bit(). If you wait a week or so, you'll most likely
> find it in -next.
>

I hadn't seen it, it does look promising. I'm about to disappear for a
week, so I'll have a look once I'm back.

> Thanks,
> Yury

