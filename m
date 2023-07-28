Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59EF76611C
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jul 2023 03:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjG1BQ2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 21:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjG1BQY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 21:16:24 -0400
Received: from out-115.mta0.migadu.com (out-115.mta0.migadu.com [91.218.175.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358AF30F4
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 18:16:23 -0700 (PDT)
Message-ID: <35286616-a53d-7aa5-b3b0-09ae44edf510@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690506981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=56y4sv65mg1BkaEyf6HwH/9xJxue7VDlxYm5Fps8r2o=;
        b=hhnRgNZ9Domr1H13byLUX7lTj1mbAtM0Ylus72QqsaCvBf0QbVXDMUu19Us6PImq9jzUtN
        evf90xlXILl/148uO58t9O+hdDHS5Sl3YT1lGs7qXG0XcfJge1O6btRY3ces1pU29isfy3
        IHvDPZY+kFN5uO+C/TrADn4mn1xSWFY=
Date:   Fri, 28 Jul 2023 09:16:19 +0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH 0/5] Fix potential issues for siw
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Bernard Metzler <BMT@zurich.ibm.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20230727140349.25369-1-guoqing.jiang@linux.dev>
 <SN7PR15MB575506FAF5423F726708AF8F9901A@SN7PR15MB5755.namprd15.prod.outlook.com>
 <ZMKpcQsJ3FBvxYHo@ziepe.ca>
Content-Language: en-US
In-Reply-To: <ZMKpcQsJ3FBvxYHo@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 7/28/23 01:29, Jason Gunthorpe wrote:
> On Thu, Jul 27, 2023 at 05:17:40PM +0000, Bernard Metzler wrote:
>>
>>> -----Original Message-----
>>> From: Guoqing Jiang <guoqing.jiang@linux.dev>
>>> Sent: Thursday, 27 July 2023 16:04
>>> To: Bernard Metzler <BMT@zurich.ibm.com>; jgg@ziepe.ca; leon@kernel.org
>>> Cc: linux-rdma@vger.kernel.org
>>> Subject: [EXTERNAL] [PATCH 0/5] Fix potential issues for siw
>>>
>>> Hi,
>>>
>>> Several issues appeared if we rmmod siw module after failed to insert
>>> the module (with manual change like below).
>>>
>>> --- a/drivers/infiniband/sw/siw/siw_main.c
>>> +++ b/drivers/infiniband/sw/siw/siw_main.c
>>> @@ -577,6 +577,7 @@ static __init int siw_init_module(void)
>>>          if (rv)
>>>                  goto out_error;
>>>
>>> +       goto out_error;
>>>          rdma_link_register(&siw_link_ops);
>>>
>>> Basically, these issues are double free, use before initalization or
>>> null pointer dereference. For more details, pls review the individual
>>> patch.
>>>
>>> Thanks,
>>> Guoqing
>> Hi Guoqing,
>>
>> very good catch, thank you. I was under the wrong assumption a
>> module is not loaded if the init_module() returns a value.
> I think that is actually true, isn't it? I'm confused?

Yes, you are right. Since rv is still 0, so the module appears in the 
kernel. Not sure if some tool could inject err like this. Feel free to 
ignore this.

Thanks,
Guoqing
