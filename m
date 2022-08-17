Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B75A596C9D
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Aug 2022 12:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238851AbiHQKJn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Aug 2022 06:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238839AbiHQKJg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Aug 2022 06:09:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152F450729
        for <linux-rdma@vger.kernel.org>; Wed, 17 Aug 2022 03:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660730975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MgPLw0rtRpX874pv/TGXoEN52GWQecwFxnLCwmV/znM=;
        b=cvWglADCE9nG69KOYrHW3p/HHfREfPo7sxIvd40a01RClYMuJYVYrFCPMW6pseDu9s/wTb
        K/tt+rtU993PqDhX8zQXzx6g+0SfMdmqJHnDocVXO3TB8Ptvm23vTRa5k9f+G7lZeUx21C
        WTzMbmnxZgJWpY/ad3gZvMOX+TyxXdk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-646--pH7UwY_N6aTW_Sfxc0BDA-1; Wed, 17 Aug 2022 06:09:34 -0400
X-MC-Unique: -pH7UwY_N6aTW_Sfxc0BDA-1
Received: by mail-wr1-f70.google.com with SMTP id x6-20020adfbb46000000b00225260970a9so230029wrg.18
        for <linux-rdma@vger.kernel.org>; Wed, 17 Aug 2022 03:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=MgPLw0rtRpX874pv/TGXoEN52GWQecwFxnLCwmV/znM=;
        b=2/90W77+svzX++N97BbSecBpn2ZLBU1BQZU1Lgder6mMna9SEiQLwX96MRDc+SPnl5
         vKm7SXae+/hpFjL9cRBBwPCf/kpx+OQ1D0z6r0sL/SXR6jjA0F6rbdiZIPeqeLVohPla
         rVFBs1zAEtLz0ch3asgb7NogkQdyo+qwc4ZD+V4evIhUk61GSYViu3OhmLrp31w+aI0v
         6JsIF4D7P0Hh79drcSOT56XxXYM9KV2VYLsoM9tF2g0tNtFoH47mvnLf9sEeQnAQEuzF
         IQW7OGb2IBcQK8xUf63qWhOS4XHgHuE1fr9ZQIbEbu6ocCcYQKdN7zQ8up1soK6rNIb1
         BSgg==
X-Gm-Message-State: ACgBeo3GIxZgrdMFO9vsnd4lrfjINehMsiORjuMbvyo/JieEodds1t+j
        N+zV73gUOfngtUnGxqanug52oZcvl0I7I4rXbd5tfmcE+RYyUWzmbu23EYzcqvjkv9kp7TC9op5
        hV4EeQWDvBCxSilvTseQhvA==
X-Received: by 2002:adf:d228:0:b0:220:6f68:dd56 with SMTP id k8-20020adfd228000000b002206f68dd56mr13879257wrh.432.1660730972838;
        Wed, 17 Aug 2022 03:09:32 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7rvn/03ngpxQO5DcUzRWhDUOccD9vxbL72pGig2dUclpchCF0aJqoOCzUgeOoLUo67Am4hiQ==
X-Received: by 2002:adf:d228:0:b0:220:6f68:dd56 with SMTP id k8-20020adfd228000000b002206f68dd56mr13879245wrh.432.1660730972683;
        Wed, 17 Aug 2022 03:09:32 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id h3-20020a05600c2ca300b003a5ea1cc63csm1652237wmc.39.2022.08.17.03.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 03:09:32 -0700 (PDT)
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
        Barry Song <song.bao.hua@hisilicon.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH 1/5] bitops: Introduce find_next_andnot_bit()
In-Reply-To: <YvwWnH/8dD1rYxpq@yury-laptop>
References: <20220816180727.387807-1-vschneid@redhat.com>
 <20220816180727.387807-2-vschneid@redhat.com>
 <YvwWnH/8dD1rYxpq@yury-laptop>
Date:   Wed, 17 Aug 2022 11:09:31 +0100
Message-ID: <xhsmha683b2qs.mognet@vschneid.remote.csb>
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

On 16/08/22 15:13, Yury Norov wrote:
> On Tue, Aug 16, 2022 at 07:07:23PM +0100, Valentin Schneider wrote:
>> @@ -59,7 +63,9 @@ unsigned long _find_next_bit(const unsigned long *addr1,
>>
>>              tmp = addr1[start / BITS_PER_LONG];
>>              if (addr2)
>> -			tmp &= addr2[start / BITS_PER_LONG];
>> +			tmp &= negate ?
>> +			       ~addr2[start / BITS_PER_LONG] :
>> +				addr2[start / BITS_PER_LONG];
>>              tmp ^= invert;
>>      }
>
> So it flips addr2 bits twice - first with new 'negate', and second
> with the existing 'invert'. There is no such combination in the
> existing code, but the pattern looks ugly, particularly because we use
> different inverting approaches. Because of that, and because XOR trick
> generates better code, I'd suggest something like this:
>
>         tmp = addr1[start / BITS_PER_LONG] ^ invert1;
>         if (addr2)
>                 tmp &= addr2[start / BITS_PER_LONG] ^ invert2;

That does look much better, and also gets rid of the ternary. Thanks!

