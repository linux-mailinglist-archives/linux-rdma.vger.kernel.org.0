Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5A36CCD11
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 00:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjC1WTE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Mar 2023 18:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjC1WSp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Mar 2023 18:18:45 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9107C2D44
        for <linux-rdma@vger.kernel.org>; Tue, 28 Mar 2023 15:18:13 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 32SMHUKm096379;
        Wed, 29 Mar 2023 07:17:30 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Wed, 29 Mar 2023 07:17:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 32SMHUw0096375
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 29 Mar 2023 07:17:30 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d2dfb901-50b1-8e34-8217-d29e63f421c7@I-love.SAKURA.ne.jp>
Date:   Wed, 29 Mar 2023 07:17:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] RDMA: don't ignore client->add() failures
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
References: <0e031582-aed6-58ee-3477-6d787f06560a@I-love.SAKURA.ne.jp>
 <ZCLOYznKQQKfoqzI@ziepe.ca>
 <a9960371-ef94-de6e-466f-0922a5e3acf3@I-love.SAKURA.ne.jp>
 <ZCLQ0XVSKVHV1MB2@ziepe.ca>
 <ec025592-3390-cf4f-ed03-c3c6c43d9310@I-love.SAKURA.ne.jp>
 <ZCMTZWdY7D7mxJuE@ziepe.ca>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ZCMTZWdY7D7mxJuE@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023/03/29 1:18, Jason Gunthorpe wrote:
> On Tue, Mar 28, 2023 at 11:59:48PM +0900, Tetsuo Handa wrote:
>> Without this patch, __ib_unregister_device(device) is not called because
>> enable_device_and_get() returns 0 because add_client_context() returns 0
>> because add_client_context() ignores client->add() failures. As a result,
>> device's refcount remains 7, which later prevents unregister_netdevice()
>>  from unregistering this device.
> 
> That is completely correct, the device was successfully registered
> without one of the clients.

ib_register_device() is responsible for unregistering that device (by calling
__ib_unregister_device(device)) if ib_register_device() failed to
initialize a device, isn't it?

> 
> It seems to me all this has done done is make it so the device doesn't
> register and that will hide the refcount bug because the bug is
> actually something that happens during operation - and we never get to
> operation now.

If ib_register_device() were not responsible for unregistering that device
when ib_register_device() failed to initialize a device, who is responsible
for unregistering that device?

The caller of ib_register_device() (i.e. siw_device_register() from
siw_newlink()) is assuming that somebody will call __ib_unregister_device(),
but nobody is calling __ib_unregister_device().

