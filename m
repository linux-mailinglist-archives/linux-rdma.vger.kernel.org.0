Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C096CF7C3
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 01:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjC2XwL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 19:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjC2XwK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 19:52:10 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C3D1722
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 16:51:59 -0700 (PDT)
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 32TNpjZB025273;
        Thu, 30 Mar 2023 08:51:45 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Thu, 30 Mar 2023 08:51:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 32TNpjHp025270
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Mar 2023 08:51:45 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9186f5f5-2f88-1247-2d24-61d090a1da83@I-love.SAKURA.ne.jp>
Date:   Thu, 30 Mar 2023 08:51:44 +0900
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
 <d2dfb901-50b1-8e34-8217-d29e63f421c7@I-love.SAKURA.ne.jp>
 <ZCRc5S9QGZqcZhNg@ziepe.ca>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ZCRc5S9QGZqcZhNg@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023/03/30 0:44, Jason Gunthorpe wrote:
>> The caller of ib_register_device() (i.e. siw_device_register() from
>> siw_newlink()) is assuming that somebody will call __ib_unregister_device(),
>> but nobody is calling __ib_unregister_device().
> 
> On the success path this stuff happens during dellink
> 

"struct rdma_link_ops" has "newlink" callback but does not have "dellink" callback.
"struct rtnl_link_ops" has both "newlink" callback and "dellink" callback, but
only ipoib_netlink.c defines it inside drivers/infiniband/ directory.

Where is the dellink you are talking about?
I'm not familiar with rdma code. Please explain using specific function/symbol names.

