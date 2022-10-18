Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96235603106
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 18:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJRQuN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 12:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiJRQuM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 12:50:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44BC5282E
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 09:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666111806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Tm5JCAIMhjvmiBFpFhEHwWPITj0JcQocFbip2mfREU=;
        b=Sc0JA5g6QvUlwQ07fZTUqp1uoCYAZkL67/VIyRarBCNTCSyuhWFixBMU3xgXpFawk0/CJZ
        Yrea/w3b5ZodMkrymzYJ+NPFuRp8H1euv1U8DI2TuIQTtvoARB7whmN7OfV3BqFQOJE/MT
        tp/KV900pytmFmoApvTtHmUsBG3ASfw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-619-sP8VfAPyMMmSV2fja2aWvg-1; Tue, 18 Oct 2022 12:50:05 -0400
X-MC-Unique: sP8VfAPyMMmSV2fja2aWvg-1
Received: by mail-qv1-f70.google.com with SMTP id 71-20020a0c804d000000b004b2fb260447so9051553qva.10
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 09:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Tm5JCAIMhjvmiBFpFhEHwWPITj0JcQocFbip2mfREU=;
        b=PN+zNsIl+M3nb1ol+nNjtHWQbV8bYgjaFkT2udGgbNhOxxcPtPtHQ2zCoTKXkZuJjb
         Ituli2mcneU+cs1An1Itt6q5AK+8kbKnj7KNc/mlCKuANuZnPaxaeSuRb7A7/3IrwPUS
         vH5jRjkyArVY+5mZc6uNbdQVfZZgxKRPbcgiXN84QgcfcaX9zgehkGArrYl8wwAF6iDJ
         OxNfZGQKzntTgsERs6v4CTENzb63qHRrsOBxCjCewDVu1kLtzYC5kumwRfXvyp7Ak8xQ
         zW96IUqUoBqcTVyWp8PBm95C6ZQBnWlCeF87j/kw2GYoPntv056nhQNXxcUn/Qeyy9h1
         gckA==
X-Gm-Message-State: ACrzQf2jB7FIbDSECdyDPpY8I7Gm8xRm2cX7jVQ1NlyhDa+5o3K9S21w
        J9TNtsHrMMIAYJ9xXLfqczjIFXJALUHmXULrvI7YxMN/8QJtHFYAe3wopL49PsAWQO/gOLVLsJD
        PUbrp+hF+afDTnwR/1YizYg==
X-Received: by 2002:a05:6214:27ec:b0:4b2:1337:a442 with SMTP id jt12-20020a05621427ec00b004b21337a442mr2965292qvb.20.1666111804502;
        Tue, 18 Oct 2022 09:50:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4U4uK6OVhT20CLjACsP21+jL2yR6/slxJzsjXi33DwcqiXKPhbECIEjn4iYNxKMsyfPadJCw==
X-Received: by 2002:a05:6214:27ec:b0:4b2:1337:a442 with SMTP id jt12-20020a05621427ec00b004b21337a442mr2965272qvb.20.1666111804336;
        Tue, 18 Oct 2022 09:50:04 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id j5-20020ac874c5000000b0039ccd7a0e10sm2171918qtr.62.2022.10.18.09.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 09:50:03 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tariq Toukan <ttoukan.linux@gmail.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
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
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH v4 0/7] sched, net: NUMA-aware CPU spreading interface
In-Reply-To: <07a034cf-507a-e4ad-d78c-e5dd5a8d98b5@gmail.com>
References: <20220923132527.1001870-1-vschneid@redhat.com>
 <07a034cf-507a-e4ad-d78c-e5dd5a8d98b5@gmail.com>
Date:   Tue, 18 Oct 2022 17:50:00 +0100
Message-ID: <xhsmhwn8xvzyf.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 18/10/22 09:36, Tariq Toukan wrote:
>
> Hi,
>
> What's the status of this?
> Do we have agreement on the changes needed for the next respin?
>

Yep, the bitmap patches are in 6.1-rc1, I need to respin the topology ones
to address Yury's comments. It's in my todolist, I'll get to it soonish.

> Regards,
> Tariq

