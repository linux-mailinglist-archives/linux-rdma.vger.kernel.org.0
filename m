Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B952874C436
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jul 2023 14:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjGIMy1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Jul 2023 08:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGIMy0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Jul 2023 08:54:26 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CC5FA;
        Sun,  9 Jul 2023 05:54:25 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 41be03b00d2f7-55ba5fae2e6so2731888a12.0;
        Sun, 09 Jul 2023 05:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688907265; x=1691499265;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGZmmOl1FsGK0XVrg4lrILRSKoiMtyDf5QqOBufcTk8=;
        b=pa78NO19VJU0hfjXLm/WOppyi7wF2HN3q/P1z4MR4y1MPBiQoEGNhIoKmg5Y26v2Lk
         tzXzHe0bVi/p7qFPogf1m/98ZRABv3phT3idqtP+YTLNGr3eIAFtHKarr/vabWeA6ZaC
         L2SLxBJzf1D6EhmdWfqSXZckPZRpQE+sXH3P8YFSnFqbqGKJemsNUmKVsYNdwjNDjpRp
         kF/oSf836+VLzPEsMXonI069aKf+3oxZak0E2X2gXbV/Ko93A/5z8C6+N4GD0lOpr9jK
         VHgwDtSWRZBq5vWwRiDXV0Ko/G9sD4uS933X4DqUa1p+8CQW0XZjbJqs7VHKi2MHOWhn
         qLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688907265; x=1691499265;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGZmmOl1FsGK0XVrg4lrILRSKoiMtyDf5QqOBufcTk8=;
        b=XDNuRkpeKIf3eTogHojd99I114ZGR+MD1HcNLgBuwBnMIvOwas+789qFG+E2U0YgaS
         3EGg/G15yTCghG6hVPmQzrZ7Djki0HuamsFjntxG6KYmCbXK7zitWUhQiSX0p1sf85Jp
         zWKbFnw9gkj08SsFVnyaEB7M5DJUZIyMyH/MYMQoxrpDUe3kj5fbHFMU8h7dDhcM1A1p
         OIE51P+jgOXN1sADJwWqNfUoieKzJOCH7ZZo8JXM5bqAbaa7oHK7Zb99Fw8AbCfarHeS
         fHs41baTIznEuRkeZEaIR8v7TjwEBBm9s5jIH58h5jYVCSY/sN9tAFeyBwMiPuajEu7d
         /UoA==
X-Gm-Message-State: ABy/qLba94X6b9uYha/IaayG0k4doPijO6e9ikDN1v1HWFzIozgwA2Ip
        Lm8YSMyn/dM5w0CY+JP8kTDJXql83YM5JAd8
X-Google-Smtp-Source: APBJJlGgQXbWmNuZ1ajt8RaldUOhJZFcYMSp/AYTxaC8PhacE1gg0fwXoTZZ+5VOAEDxdqvIn/7ExA==
X-Received: by 2002:a17:902:f809:b0:1b8:b29e:b47b with SMTP id ix9-20020a170902f80900b001b8b29eb47bmr9541521plb.44.1688907264943;
        Sun, 09 Jul 2023 05:54:24 -0700 (PDT)
Received: from ?IPv6:2409:8a55:301b:e120:1523:3ecb:e154:8f22? ([2409:8a55:301b:e120:1523:3ecb:e154:8f22])
        by smtp.gmail.com with ESMTPSA id iz2-20020a170902ef8200b001b523714ed5sm6251273plb.252.2023.07.09.05.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 05:54:24 -0700 (PDT)
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
To:     Jakub Kicinski <kuba@kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-rdma@vger.kernel.org
References: <20230629120226.14854-1-linyunsheng@huawei.com>
 <20230629120226.14854-2-linyunsheng@huawei.com>
 <20230707170157.12727e44@kernel.org>
From:   Yunsheng Lin <yunshenglin0825@gmail.com>
Message-ID: <3d973088-4881-0863-0207-36d61b4505ec@gmail.com>
Date:   Sun, 9 Jul 2023 20:54:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20230707170157.12727e44@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023/7/8 8:01, Jakub Kicinski wrote:
> On Thu, 29 Jun 2023 20:02:21 +0800 Yunsheng Lin wrote:
>> -#include <linux/dma-direction.h>
>> +#include <linux/dma-mapping.h>
> 
> And the include is still here, too, eh..

In V4, it has:

--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -33,6 +33,7 @@ 
 #include <linux/mm.h> /* Needed by ptr_ring */
 #include <linux/ptr_ring.h>
 #include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>

As dma_get_cache_alignment() defined in dma-mapping.h is used
here, so we need to include dma-mapping.h.

I though the agreement is that this patch only remove the
"#include <linux/dma-direction.h>" as we dma-mapping.h has included
dma-direction.h.

And Alexander will work on excluding page_pool.h from skbuff.h
https://lore.kernel.org/all/09842498-b3ba-320d-be8d-348b85e8d525@intel.com/

Did I miss something obvious here？ Or there is better way to do it
than the method discussed in the above thread?

> 
