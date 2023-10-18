Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D357CE86B
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Oct 2023 22:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjJRUDG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Oct 2023 16:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjJRUDF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Oct 2023 16:03:05 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B1C95;
        Wed, 18 Oct 2023 13:03:03 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b2e72fe47fso751977b6e.1;
        Wed, 18 Oct 2023 13:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697659383; x=1698264183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=br9XBNhfiOhalsuvWHd5IwOMisfrKyEyT6d87UzrWR0=;
        b=QnMJ3XgqbY43u1wADx1yuRN01yrvs1ggX+gG8ovZnt26rRTZKel9w//merCCQj/51i
         6U0mBbXn045a5SEpXGetsjcniBuThl9NHL9Trr0N/XU+s+J2Qvo+C5TV3qhPnxO+gx/v
         7uDnn1AjAR6k0GHS47XIPIZXAdR6fCDEbrg3O25Evw3fom2aa2SSuxSbuMciTjXjYT3j
         BK3mWMHZVe+AWw2U6SrzDaGgLCI2ning93yDegbLT6gz8qd32ij2T8ECYREX8sTPD4cX
         5xiLwF1ThmFaTd3RaQpkzfm01IXqfDN6Ob3uylMLFutCmdEAcmXy9u/7Ex/nJs64wP1S
         v3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697659383; x=1698264183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=br9XBNhfiOhalsuvWHd5IwOMisfrKyEyT6d87UzrWR0=;
        b=LDA+SZsER9UzqctEBDfdx+lHiQo6V6Oh4MUUChmLjadRTNVg9WJce7ds2mLpVqy0tq
         G2ERSh+G3jcFLbHTrJZEI0wb409ERcc/IdqXzki8NoxH49TMsKLiwojg+mFxZoRKQ1ck
         6oOb5HEJzbD5BxccrTaezOy0n1J9t7ARn5B2RRlG6f6M0+Fq6nJrFI1oV1MMPskKfmG2
         iX3Sk9aIOO8dC8sIek3HVsFMXKSze7hTN2Vji53MEJO481fFJPMRM/ICftg0GpCl45bi
         /snKpb3L3iH/Oru+WUeZy0AzmqRxXTt981+ehEosIH2KbZ1x0UfeP5HyppgbAFltjC8U
         y6Sw==
X-Gm-Message-State: AOJu0Yy18xF/bdTZ+n3swjhtHS1JSLICGR2Jroqxg6GBpu2Ik1nLkuny
        aqNmhPi8huV6tZlNwocZmKs=
X-Google-Smtp-Source: AGHT+IEKQskGOYiICtNb9Vlmmjh9biGNLz15OmK+HsNWbjvygooO2Lp7QWEfaQULwMfZ2Ea/xEIkBA==
X-Received: by 2002:aca:1110:0:b0:3af:8ed3:d7a3 with SMTP id 16-20020aca1110000000b003af8ed3d7a3mr189086oir.54.1697659383180;
        Wed, 18 Oct 2023 13:03:03 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:65c5:47f5:fc42:655d? (2603-8081-1405-679b-65c5-47f5-fc42-655d.res6.spectrum.com. [2603:8081:1405:679b:65c5:47f5:fc42:655d])
        by smtp.gmail.com with ESMTPSA id e25-20020a056808111900b003af6eeed9b6sm775816oih.27.2023.10.18.13.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 13:03:02 -0700 (PDT)
Message-ID: <643bc60c-bb30-440a-9aa9-6e400c275bbe@gmail.com>
Date:   Wed, 18 Oct 2023 15:03:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
To:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Rain River' <rain.1986.08.12@gmail.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <20231017185139.GA691768@ziepe.ca>
 <c65f92b2-9821-4349-b1f5-7dc2a287946a@gmail.com>
 <08a8d947-25b5-434c-9ba3-282d298b5bfd@acm.org>
 <e3d91c4f-b124-4031-9f92-fcb61973a645@gmail.com>
 <02cd10fd-fd4a-4ad7-9b1d-6d37b070aacf@acm.org>
 <5c6e69b3-f83b-461d-a08a-37bfbd82f995@gmail.com>
 <cad2fee4-9359-4614-b36b-c2599dc12358@acm.org>
 <bf2705ff-716a-45b5-bcc4-8710ea0fb98e@gmail.com>
 <65b871ef-dd93-4bfb-bae9-c147a87c64d0@acm.org>
 <dbd9f019-693f-476c-aa4c-739746753d2b@gmail.com>
 <20231018191735.GC691768@ziepe.ca>
 <8e7dbd64-856d-47cc-9d2f-73aa101afa11@acm.org>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <8e7dbd64-856d-47cc-9d2f-73aa101afa11@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/18/23 14:48, Bart Van Assche wrote:
> 
> On 10/18/23 12:17, Jason Gunthorpe wrote:
>> If siw hangs as well, I definitely comfortable continuing to debug and
>> leaving the work queues in-tree for now.
> 
> Regarding the KASAN complaint that I shared about one month ago, can that complaint have any other root cause than the patch "RDMA/rxe: Add
> workqueue support for rxe tasks"? That report shows a use-after-free by
> rxe code with a pointer to memory that was owned by the rxe driver and
> that was freed by the rxe driver. That memory is an skbuff. The rxe
> driver manages skbuffs. The SRP driver doesn't even know about these
> skbuff objects. See also https://lore.kernel.org/linux-rdma/8ee2869b-3f51-4195-9883-015cd30b4241@acm.org/
> 
> Thanks,
> 
> Bart.
> 
Bart,

I agree with you that that is a rxe issue. But, I haven't been able to reproduce it. However, I am able
to generate hangs without the KASAN bug so it seems to me that they are unrelated. In addition to the
kernel debugging I have added tracing to ib_srp and ib_srpt which may help delay things.

Bob

