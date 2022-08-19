Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C1E599A15
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Aug 2022 12:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348321AbiHSKeQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Aug 2022 06:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348212AbiHSKeO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Aug 2022 06:34:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F11D3DF39
        for <linux-rdma@vger.kernel.org>; Fri, 19 Aug 2022 03:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660905245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t9qConcsVrFeMSKZiZOZ7jvIr/WxjYXLhBQh/vLaFNc=;
        b=Sa+EqwxqY5TNC8cxtn6xkrhHOGjcuP4AiVEIHDvZLba02ddxN8YcnSwGbaZWyPyNVwpt9q
        b/SJ/CIgSMYUxkNR+CnGE20uTkm4Z+KmwstNdsdfRsyu4CnZO4T+Tp46FE4yyvGZ3Is0Tc
        i6DnsqV8T8p5VKVXoIWRdQcTjE8rFpE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-344-Ak-2E9j2OwmrUWg-PJZIfQ-1; Fri, 19 Aug 2022 06:34:04 -0400
X-MC-Unique: Ak-2E9j2OwmrUWg-PJZIfQ-1
Received: by mail-wr1-f72.google.com with SMTP id d11-20020adfc08b000000b002207555c1f6so631235wrf.7
        for <linux-rdma@vger.kernel.org>; Fri, 19 Aug 2022 03:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=t9qConcsVrFeMSKZiZOZ7jvIr/WxjYXLhBQh/vLaFNc=;
        b=hGoh9zAyl2dftOCwe0WHLp85UUHumiNVifVxvLFz+UM3s1saHiFllt7hFzJ4c4Ncrz
         9fwtmo5pjKj+Fe91nPJqFxIJXFCorGXCp4/u/XSMdYKFCBVn/AWNhSU8ZTtjFOrls3qf
         2VvQ9JLPgHnzK+cUI2NAuLOmNz0mV/wpKbeyM65z4r7lFa50JTKEjq76opmSFEWcASaS
         ZGJ18WSU/IDNJtfC0lzcot7JOWbmpYYbCBd75bJOtBu7hzZo8MLo4zWWniiQyMlH7Ll3
         2O1YmhZ54qF5VBAnkQ6K8jywAvZm139qfMl6jMwYTdcOttZ7yQ/eStkdaFr9c1c0dWwo
         q5ig==
X-Gm-Message-State: ACgBeo1jSWkj23HrHWPCvxEJO5T2/jiAY+KoZuanq2jmrB2PzyGnCzVd
        MTVtOXIeaB3ki5yKwQc312p8ycUB32vvS44FMwizLB0I6WlT91tGco5/o327yqT2B8IddDHDaW0
        PA7nvJxafTT+qGTBHy6fBMg==
X-Received: by 2002:a5d:64e9:0:b0:220:7dd7:63eb with SMTP id g9-20020a5d64e9000000b002207dd763ebmr3831666wri.590.1660905243394;
        Fri, 19 Aug 2022 03:34:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7AoX+VQs/b3XMThsgV+BYuePZtBIHhF6hh6s7w1xBiDvXh8zDLXmM78RPTeY/EF0PqfZ3SJQ==
X-Received: by 2002:a5d:64e9:0:b0:220:7dd7:63eb with SMTP id g9-20020a5d64e9000000b002207dd763ebmr3831663wri.590.1660905243244;
        Fri, 19 Aug 2022 03:34:03 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id b18-20020adff252000000b00224f605f39dsm3501436wrp.76.2022.08.19.03.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 03:34:02 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     netdev <netdev@vger.kernel.org>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
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
        Mel Gorman <mgorman@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH v2 1/5] bitops: Introduce find_next_andnot_bit()
In-Reply-To: <CAHp75VcaSwfy7kOm_d28-87QKQ5KPB69=X=Z9OYUzJJKwRCSmQ@mail.gmail.com>
References: <20220817175812.671843-1-vschneid@redhat.com>
 <20220817175812.671843-2-vschneid@redhat.com>
 <20220818100820.3b45808b@gandalf.local.home>
 <xhsmh35dtbjr0.mognet@vschneid.remote.csb>
 <20220818130041.5b7c955f@gandalf.local.home>
 <CAHp75VcaSwfy7kOm_d28-87QKQ5KPB69=X=Z9OYUzJJKwRCSmQ@mail.gmail.com>
Date:   Fri, 19 Aug 2022 11:34:01 +0100
Message-ID: <xhsmhk074a5eu.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 18/08/22 22:04, Andy Shevchenko wrote:
> On Thu, Aug 18, 2022 at 8:18 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>> On Thu, 18 Aug 2022 17:26:43 +0100
>> Valentin Schneider <vschneid@redhat.com> wrote:
>>
>> > How about:
>>
>> >
>> >   find the next set bit in (*addr1 & ~*addr2)
>>
>> I understand the above better. But to convert that into English, we could
>> say:
>>
>>
>>   Find the next bit in *addr1 excluding all the bits in *addr2.
>>
>> or
>>
>>   Find the next bit in *addr1 that is not set in *addr2.
>
> With this explanation I'm wondering how different this is to
> bitmap_bitremap(), with adjusting to using an inverted mask. If they
> have something in common, perhaps make them in the same namespace with
> similar naming convention?
>

I'm trying to wrap my head around the whole remap thing, IIUC we could have
something like remap *addr1 to ~*addr2 and stop rather than continue with a
wraparound, but that really feels like shoehorning.

> --
> With Best Regards,
> Andy Shevchenko

