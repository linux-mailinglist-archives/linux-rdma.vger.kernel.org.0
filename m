Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7776D2EE0
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Apr 2023 09:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjDAHaU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 1 Apr 2023 03:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjDAHaT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 1 Apr 2023 03:30:19 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBCDCA0B
        for <linux-rdma@vger.kernel.org>; Sat,  1 Apr 2023 00:30:17 -0700 (PDT)
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3317U9ZD068851;
        Sat, 1 Apr 2023 16:30:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Sat, 01 Apr 2023 16:30:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3317U8qL068832
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 1 Apr 2023 16:30:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2e7a122d-78a9-efec-9140-6d21bceb7e04@I-love.SAKURA.ne.jp>
Date:   Sat, 1 Apr 2023 16:30:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] RDMA: don't ignore client->add() failures
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Bernard Metzler <bmt@zurich.ibm.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
References: <ZCLOYznKQQKfoqzI@ziepe.ca>
 <a9960371-ef94-de6e-466f-0922a5e3acf3@I-love.SAKURA.ne.jp>
 <ZCLQ0XVSKVHV1MB2@ziepe.ca>
 <ec025592-3390-cf4f-ed03-c3c6c43d9310@I-love.SAKURA.ne.jp>
 <ZCMTZWdY7D7mxJuE@ziepe.ca>
 <d2dfb901-50b1-8e34-8217-d29e63f421c7@I-love.SAKURA.ne.jp>
 <ZCRc5S9QGZqcZhNg@ziepe.ca>
 <9186f5f5-2f88-1247-2d24-61d090a1da83@I-love.SAKURA.ne.jp>
 <ZCYdo8pcS947JOgI@ziepe.ca>
 <747eaa78-5773-c2fd-5a8f-97998a0c9883@I-love.SAKURA.ne.jp>
 <ZCcJBPbOlmx0he9Y@ziepe.ca>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ZCcJBPbOlmx0he9Y@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023/04/01 1:23, Jason Gunthorpe wrote:
> On Sat, Apr 01, 2023 at 01:19:47AM +0900, Tetsuo Handa wrote:
>> I guess that either dev_net(netdev) is not appropriately initialized or
>> dev_net(netdev) != &init_net is too restrictive to call ib_unregister_device_queued().
>> Where is dev_net(netdev) initialized?
> 
> Bernard? What is this net ns check for? It seems surprising this would
> be here
> 

Commit bdcf26bf9b3a ("rdma/siw: network and RDMA core interface") implemented
siw_netdev_event() with

	if (dev_net(netdev) != &init_net)
		return NOTIFY_OK;

check. But why this check is needed was not explained.
Maybe ib_devices_shared_netns is relevant?

Since network devices created upon/after unshare(CLONE_NEWNET) have network
namespace other than init_net, this check completely disables siw_netdev_event()
after unshare(CLONE_NEWNET). Thus, removing this check looks reasonable.

