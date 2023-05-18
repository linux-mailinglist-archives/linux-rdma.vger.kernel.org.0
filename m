Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22F4708B64
	for <lists+linux-rdma@lfdr.de>; Fri, 19 May 2023 00:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjERWUz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 May 2023 18:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjERWUy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 May 2023 18:20:54 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A74121;
        Thu, 18 May 2023 15:20:53 -0700 (PDT)
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 34IMJxQ0031357;
        Fri, 19 May 2023 07:19:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Fri, 19 May 2023 07:19:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 34IMJxoE031353
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 19 May 2023 07:19:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ba70b229-317b-9c2d-f3bb-5450eec85694@I-love.SAKURA.ne.jp>
Date:   Fri, 19 May 2023 07:19:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in
 siw_query_port
Content-Language: en-US
To:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     syzbot <syzbot+79f283f1f4ccc6e8b624@syzkaller.appspotmail.com>,
        bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
References: <0000000000001f992805fb79ce97@google.com>
 <5eacf66d-053e-d82b-1e73-c808fb4c8aad@linux.dev>
 <20230518202116.rpx53vp7rrtuixoa@fpc>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230518202116.rpx53vp7rrtuixoa@fpc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023/05/19 5:21, Fedor Pchelkin wrote:
> On our local Syzkaller instance the bug started to be caught after
> 266e9b3475ba ("RDMA/siw: Remove namespace check from siw_netdev_event()")
> so CC'ing Tetsuo Handa if maybe he would be also interested in the bug.

UAF could not be observed until that commit because hung task was observed
until that commit because syzkaller is testing non init_net namespace.

> This fix seems to be good and perhaps it just made a bigger opportunity
> for the UAF bug to happen. Actually, the C repro was taken from there [2].
> 
> With your suggested solution the UAF is not reproduced. I don't know the
> exact reasons why dev_put() was placed before calling query_port() but the
> context implies that netdev can be freed in that period. And some of
> ->query_port() realizations may touch netdev. So it seems reasonable to
> move ref count put after performing query_port().

Since ib_device_get_netdev() calls dev_hold() on success, I think that
we need to call dev_put() after query_port(). Please send as a formal patch.

