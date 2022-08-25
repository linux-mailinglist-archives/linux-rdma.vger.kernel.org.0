Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B095A1D08
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Aug 2022 01:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243968AbiHYXUc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Aug 2022 19:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244177AbiHYXU3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Aug 2022 19:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A8D33A25
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 16:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661469627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NsyNVP005GqHR+ZDAjrOhFy3KuxEEcYrhlufP12Pz6w=;
        b=Ka71iW/OGe9qsE30ph3lvV43ZakvZmaGXuiWLDyXW0/PIpdB1r96q7BZ1EJ9OcV5ju1uhK
        LLpvaLtrzZkW1rTzsTm85DeE8S+K3fa7LlWr8M/FUjnM11UXeba30LidOpTHBlxBD4NSOL
        T+dzodC6t/EK9UVkLmLEJdu3rmovjaA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-343-dNTg7cNoOHq2TWEjOq_nGg-1; Thu, 25 Aug 2022 19:20:25 -0400
X-MC-Unique: dNTg7cNoOHq2TWEjOq_nGg-1
Received: by mail-wm1-f71.google.com with SMTP id c64-20020a1c3543000000b003a61987ffb3so23689wma.6
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 16:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=NsyNVP005GqHR+ZDAjrOhFy3KuxEEcYrhlufP12Pz6w=;
        b=FywzcLYU7i33wrbzYjSjeFnhrg+fvQHPcivRwxRirj4xir+pMeyjsslJdIcXYfaIHK
         n2W6kpjjRxSVW2x0M1GXhT6szjCnudAK/fstCgCidOYK0aI/Um0uoRHL0MS14KNQLF4r
         sRBFXsitUf9nB8MLFU7E2ZXunFEhWaxq6h270g3U24bz9E6hWN4o/78+SRNlSJCzlU4G
         uDEJfaWGPTRNVyNYY4e23MvAWYGShxiTFTZ9l7cZaVA4828QZyZw15fhcv+YOdFkqhSj
         sgz8LDjbAVXjIVwTUV2qrYbOn2pFPcTxVAnNen3K71Drxecr0lMK2FF+kqzkI03MZfUE
         U8Pw==
X-Gm-Message-State: ACgBeo3S0ECKRCSNlRo59x9vlzhvp/UTVVUN5PwsZbiAiQ+vs9iRHZvR
        iu1sJ4SrEKduhu/oG6808Xap46AsEiflW/qJA5CJVZSJ0CyEquyo5kiJqMV5c1yLAW2wjtemlWt
        fcLFgFYwOIeAcf0HUEuQaPw==
X-Received: by 2002:a05:600c:1405:b0:3a6:1ac5:3952 with SMTP id g5-20020a05600c140500b003a61ac53952mr9087527wmi.99.1661469624699;
        Thu, 25 Aug 2022 16:20:24 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5AytvKf7xbC2sZlQpqwvcTIQgNvxwTgOAfWrmpDj0dTzVZcxhtvVKkkE9gF29ELMvMSP5Yyg==
X-Received: by 2002:a05:600c:1405:b0:3a6:1ac5:3952 with SMTP id g5-20020a05600c140500b003a61ac53952mr9087508wmi.99.1661469624509;
        Thu, 25 Aug 2022 16:20:24 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id by6-20020a056000098600b0021f15514e7fsm604309wrb.0.2022.08.25.16.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 16:20:24 -0700 (PDT)
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
Subject: Re: [PATCH v3 6/9] sched/core: Merge
 cpumask_andnot()+for_each_cpu() into for_each_cpu_andnot()
In-Reply-To: <YwfmqT70LsZmCiiG@yury-laptop>
References: <20220825181210.284283-1-vschneid@redhat.com>
 <20220825181210.284283-7-vschneid@redhat.com>
 <YwfmqT70LsZmCiiG@yury-laptop>
Date:   Fri, 26 Aug 2022 00:20:22 +0100
Message-ID: <xhsmhmtbrgbbd.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 25/08/22 14:16, Yury Norov wrote:
> On Thu, Aug 25, 2022 at 07:12:07PM +0100, Valentin Schneider wrote:
>> This removes the second use of the sched_core_mask temporary mask.
>>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>
> Suggested-by: Yury Norov <yury.norov@gmail.com>
>

Indeed, forgot that one, sorry!

