Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7826C7E50
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Mar 2023 13:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjCXM4Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Mar 2023 08:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCXM4X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Mar 2023 08:56:23 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447FAAF11
        for <linux-rdma@vger.kernel.org>; Fri, 24 Mar 2023 05:56:22 -0700 (PDT)
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 32OCuHmH009552;
        Fri, 24 Mar 2023 21:56:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Fri, 24 Mar 2023 21:56:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 32OCuGF8009547
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 24 Mar 2023 21:56:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <88ad7ca2-4b65-444a-0c91-a3c0ad835825@I-love.SAKURA.ne.jp>
Date:   Fri, 24 Mar 2023 21:56:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] RDMA/siw: fix a refcount leak in siw_newlink()
Content-Language: en-US
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>
References: <0ae07b18-e384-5d5d-54e8-8fe508af4f6a@I-love.SAKURA.ne.jp>
 <SA0PR15MB391911C8375361CCE0D67C8B99849@SA0PR15MB3919.namprd15.prod.outlook.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <SA0PR15MB391911C8375361CCE0D67C8B99849@SA0PR15MB3919.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023/03/24 21:20, Bernard Metzler wrote:
>> @@ -522,6 +522,8 @@ static int siw_newlink(const char *basedev_name, struct
>> net_device *netdev)
>>  		rv = siw_device_register(sdev, basedev_name);
>>  		if (rv)
>>  			ib_dealloc_device(&sdev->base_dev);
>> +	} else {
>> +		ib_device_put(base_dev);
> 
> base_dev is always NULL here, so nothing to put,
> right?

Oops, indeed. Then, there is a leak somewhere else.

> 
> 
>>  	}
>>  	return rv;
>>  }
>> --
>> 2.18.4

