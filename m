Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2E06CBDD1
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Mar 2023 13:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjC1Ldb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Mar 2023 07:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjC1Lda (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Mar 2023 07:33:30 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDA859E9
        for <linux-rdma@vger.kernel.org>; Tue, 28 Mar 2023 04:33:29 -0700 (PDT)
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 32SBXKh5068622;
        Tue, 28 Mar 2023 20:33:20 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Tue, 28 Mar 2023 20:33:20 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 32SBXK5h068619
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 28 Mar 2023 20:33:20 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a9960371-ef94-de6e-466f-0922a5e3acf3@I-love.SAKURA.ne.jp>
Date:   Tue, 28 Mar 2023 20:33:21 +0900
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
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ZCLOYznKQQKfoqzI@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023/03/28 20:24, Jason Gunthorpe wrote:
> On Tue, Mar 28, 2023 at 07:52:32PM +0900, Tetsuo Handa wrote:
>> syzbot is reporting refcount leak when client->add() from
>> add_client_context() fails, for commit 11a0ae4c4bff ("RDMA: Allow
>> ib_client's to fail when add() is called") for unknown reason ignores
>> error from client->add(). We need to return an error in order to indicate
>> that client could not be added, otherwise the caller will get confused.
>>
>> Reported-by: syzbot <syzbot+5e70d01ee8985ae62a3b@syzkaller.appspotmail.com>
>> Link: https://syzkaller.appspot.com/bug?extid=5e70d01ee8985ae62a3b
>> Fixes: 11a0ae4c4bff ("RDMA: Allow ib_client's to fail when add() is called")
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> ---
>>  drivers/infiniband/core/device.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> This doesn't make any sense, you need to explain what "caller will get
> confused" actually means

The caller cannot perform cleanup upon error, which in turn manifests as
"unregister_netdevice: waiting for DEV to become free" message.
Please check https://lkml.kernel.org/r/710ef3ef-cd0a-5630-a68f-628d123180bf@I-love.SAKURA.ne.jp .

