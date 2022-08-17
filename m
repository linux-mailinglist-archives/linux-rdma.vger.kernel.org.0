Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3273859751A
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Aug 2022 19:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241158AbiHQR3W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Aug 2022 13:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241253AbiHQR3G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Aug 2022 13:29:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A754A3D72
        for <linux-rdma@vger.kernel.org>; Wed, 17 Aug 2022 10:28:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7516B61299
        for <linux-rdma@vger.kernel.org>; Wed, 17 Aug 2022 17:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A78C433B5;
        Wed, 17 Aug 2022 17:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660757324;
        bh=EWcjWeaX6n6rWkDmw44DbEpUWKLO+vA/iRnpuzgoz3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RUDcBF74gDLhxpDHWtwpUeq975OEvNJgXaCrM54T+hO8o17P0rIJJL9HLkpJOj1Eh
         o2k96l2uRBpzYTUHyVVAna0vG9+F3YqXyebKfazSVbdtVCge3RgVu1Njqp2QbNRKL4
         EfHLQ8F4LLMqJaR0UQBGpP8y5MN/u/0oz1NDfnk2Zr/QgvG+uOJKKV5A/JHtRGcnTM
         yD9eo/NR5cuiL7yImZHSUuOmUQxsU6XjTn+QstGfRvfhpVDWudyYvhGDDc3RTssJui
         fLT02CmPQkIlauhRw1UHbc3ID+BEsAVGrlA6eyLYsVG1E+qZ68bx7hBbT+9Lisc0va
         tWEGeWVL2KN2Q==
Date:   Wed, 17 Aug 2022 20:28:40 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/hfi1: Suppress compiler warnings
Message-ID: <Yv0lSAlIsClbOpHm@unreal>
References: <20220817142215.17251-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220817142215.17251-1-guoqing.jiang@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 17, 2022 at 10:22:15PM +0800, Guoqing Jiang wrote:
> With W=1, the following compiler warnings appears.
> 
> In file included from ./include/trace/define_trace.h:102:0,
>                  from drivers/infiniband/hw/hfi1/trace_dbg.h:111,
>                  from drivers/infiniband/hw/hfi1/trace.h:15,
>                  from drivers/infiniband/hw/hfi1/trace.c:6:
> drivers/infiniband/hw/hfi1/./trace_dbg.h: In function ‘trace_event_get_offsets_hfi1_trace_template’:
> ./include/trace/trace_events.h:261:9: warning: function ‘trace_event_get_offsets_hfi1_trace_template’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
>   struct trace_event_raw_##call __maybe_unused *entry;  \
>          ^
> drivers/infiniband/hw/hfi1/./trace_dbg.h:25:1: note: in expansion of macro ‘DECLARE_EVENT_CLASS’
>  DECLARE_EVENT_CLASS(hfi1_trace_template,
>  ^~~~~~~~~~~~~~~~~~~
> In file included from ./include/trace/define_trace.h:102:0,
>                  from drivers/infiniband/hw/hfi1/trace_dbg.h:111,
>                  from drivers/infiniband/hw/hfi1/trace.h:15,
>                  from drivers/infiniband/hw/hfi1/trace.c:6:
> drivers/infiniband/hw/hfi1/./trace_dbg.h: In function ‘trace_event_raw_event_hfi1_trace_template’:
> ./include/trace/trace_events.h:386:9: warning: function ‘trace_event_raw_event_hfi1_trace_template’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
>   struct trace_event_raw_##call *entry;    \
>          ^
> drivers/infiniband/hw/hfi1/./trace_dbg.h:25:1: note: in expansion of macro ‘DECLARE_EVENT_CLASS’
>  DECLARE_EVENT_CLASS(hfi1_trace_template,
>  ^~~~~~~~~~~~~~~~~~~
> In file included from ./include/trace/define_trace.h:103:0,
>                  from drivers/infiniband/hw/hfi1/trace_dbg.h:111,
>                  from drivers/infiniband/hw/hfi1/trace.h:15,
>                  from drivers/infiniband/hw/hfi1/trace.c:6:
> drivers/infiniband/hw/hfi1/./trace_dbg.h: In function ‘perf_trace_hfi1_trace_template’:
> ./include/trace/perf.h:64:9: warning: function ‘perf_trace_hfi1_trace_template’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
>   struct hlist_head *head;     \
>          ^
> drivers/infiniband/hw/hfi1/./trace_dbg.h:25:1: note: in expansion of macro ‘DECLARE_EVENT_CLASS’
>  DECLARE_EVENT_CLASS(hfi1_trace_template,
>  ^~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>  drivers/infiniband/hw/hfi1/trace_dbg.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/hfi1/trace_dbg.h b/drivers/infiniband/hw/hfi1/trace_dbg.h
> index 582b6f68df3d..489395bfb5b3 100644
> --- a/drivers/infiniband/hw/hfi1/trace_dbg.h
> +++ b/drivers/infiniband/hw/hfi1/trace_dbg.h
> @@ -22,6 +22,11 @@
>  
>  #define MAX_MSG_LEN 512
>  
> +#pragma GCC diagnostic push
> +#ifndef __clang__
> +#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
> +#endif

I don't like it.

Or let's fix the code (don't know how) or disable this warning for whole
kernel.

Thanks
