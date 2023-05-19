Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB057098EC
	for <lists+linux-rdma@lfdr.de>; Fri, 19 May 2023 16:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjESODb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 May 2023 10:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjESODb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 May 2023 10:03:31 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B0013A
        for <linux-rdma@vger.kernel.org>; Fri, 19 May 2023 07:03:30 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-61b79b93ac5so13351826d6.0
        for <linux-rdma@vger.kernel.org>; Fri, 19 May 2023 07:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1684505009; x=1687097009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UYaQcjAX6hEMJzPoH5oWXefv8MMWPJGP3WqUHe0xeGA=;
        b=lD9hWaN46HATaKxfp3AfY5SN0/+pbJWzIiij5V40K0E78+At/uhCsKtSD//h7V2efE
         5qigiiKT8kXNGTs9mexE1VWJmppfJ1MqeRJWHeUUVHwqdvYT5b2Jf36d+7RACAlVvNHQ
         40V2hQJrl5q1BZ6JUYdIi1sgqgDZPCUD9HheysU6nBJ8CLlmDvQiNq97UFGjD8IR2SVu
         rXiNueXuT+Fs1yd3YqQ11rjEjgORDR2zSqTfAj6z5EN6dsBaSLIP8iBVSoSJeX122tNk
         t4lm5o0C9JMjLxQfDnGsEtIa2JMegRM6TZzt5ghq5RqMNDUxP3RqByAYb5Xb9p8KKc7q
         U58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684505009; x=1687097009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYaQcjAX6hEMJzPoH5oWXefv8MMWPJGP3WqUHe0xeGA=;
        b=gb5XYDQwGobiKQ+4OaH11WQT0bEna1TSm4x924fENruBAtLCtkS1aYl7Mi86rwyx0Z
         rRZv4PjJV89tVqF9410SKo8R3gOmjPc50hPRtri+a3B1fSQQWSXVaR8PyISVrTEah+qs
         X96H1U79F6K8AJWOXhCdrrqykSImXEzte8asK0RKNpzTSl6fWO4aIatUXiUL6VQ69Ave
         R3oE1hTCWhHBq/gQoiotHVavSJJzpCBBCGkwpla1Fq5TyuObtXBJsO97ULMTXzB3/acg
         fUymtdcWuAhojWdI5UB1zw6eMn1/DspX3N0TzR08wFAIyOxX/TnGEkwCz7bNEY1WX9jW
         8h3w==
X-Gm-Message-State: AC+VfDxSdhxx+wDTp2KEBPBDOOtSiiP21mdL28axzHa8/Gaot1nx10Ja
        ln4ttyr8rV1UpcruwZ8aoJNkhtodbnNUiufgKgg=
X-Google-Smtp-Source: ACHHUZ7Ap/Dqsj9lIVrI/XoPQJe66CYPDagzUQaAbsZD3rq30W/rJt8C17XGRqFZGab03LsprTI8Fw==
X-Received: by 2002:a05:6214:492:b0:623:42c5:6125 with SMTP id pt18-20020a056214049200b0062342c56125mr5734126qvb.7.1684505009137;
        Fri, 19 May 2023 07:03:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id ek19-20020ad45993000000b00621253d19f9sm1314834qvb.98.2023.05.19.07.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:03:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q00ha-005YXU-HD;
        Fri, 19 May 2023 11:03:26 -0300
Date:   Fri, 19 May 2023 11:03:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     leon@kernel.org, pchelkin@ispras.ru,
        penguin-kernel@i-love.sakura.ne.jp, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] RDMA/core: Call dev_put after query_port in
 iw_query_port
Message-ID: <ZGeBrhW2S5ukL6PS@ziepe.ca>
References: <20230519031119.30103-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519031119.30103-1-guoqing.jiang@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 19, 2023 at 11:11:19AM +0800, Guoqing Jiang wrote:
> There is a UAF report by syzbot.
> 
> BUG: KASAN: slab-use-after-free in siw_query_port+0x37b/0x3e0 drivers/infiniband/sw/siw/siw_verbs.c:177
> Read of size 4 at addr ffff888034efa0e8 by task kworker/1:4/24211
> 
> CPU: 1 PID: 24211 Comm: kworker/1:4 Not tainted 6.4.0-rc1-syzkaller-00012-g16a8829130ca #0
> Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
> Workqueue: infiniband ib_cache_event_task
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>  print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
>  print_report mm/kasan/report.c:462 [inline]
>  kasan_report+0x11c/0x130 mm/kasan/report.c:572
>  siw_query_port+0x37b/0x3e0 drivers/infiniband/sw/siw/siw_verbs.c:177
>  iw_query_port drivers/infiniband/core/device.c:2049 [inline]
>  ib_query_port drivers/infiniband/core/device.c:2090 [inline]
>  ib_query_port+0x3c4/0x8f0 drivers/infiniband/core/device.c:2082
>  ib_cache_update.part.0+0xcf/0x920 drivers/infiniband/core/cache.c:1487
>  ib_cache_update drivers/infiniband/core/cache.c:1561 [inline]
>  ib_cache_event_task+0x1b1/0x270 drivers/infiniband/core/cache.c:1561
>  process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
>  worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
>  kthread+0x344/0x440 kernel/kthread.c:379
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>  </TASK>
> 
> It happened because netdev could be freed if the last reference
> is released, but drivers still dereference netdev in query_port.
> So let's guard query_port with dev_hold and dev_put.
> 
> Reported-by: syzbot+79f283f1f4ccc6e8b624@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/0000000000001f992805fb79ce97@google.com/
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
> I guess another option could be call ib_device_get_netdev to get
> netdev in siw_query_port instead of dereference netdev directly. 
> If so, then other drivers (irdma_query_port and ocrdma_query_port)
> may need to make relevant change as well.

Something is wrong in siw if it is UAF'ing it's own memory:

	attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);

It needs to protect sedv->netdev somehow on its own.

Jason
