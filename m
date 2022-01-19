Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35094932A6
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 02:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343660AbiASB5f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 20:57:35 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:43747 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348047AbiASB5d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jan 2022 20:57:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V2EbHc1_1642557450;
Received: from 30.43.72.229(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V2EbHc1_1642557450)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 19 Jan 2022 09:57:32 +0800
Message-ID: <32ef57dc-c624-a6a8-5d54-a96efd1766fb@linux.alibaba.com>
Date:   Wed, 19 Jan 2022 09:57:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH rdma-next v2 09/11] RDMA/erdma: Add the erdma module
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
References: <20220117084828.80638-1-chengyou@linux.alibaba.com>
 <20220117084828.80638-10-chengyou@linux.alibaba.com>
 <20220117152217.GD8034@ziepe.ca>
 <adcb2e8f-4383-bc54-b4ac-1e41cbdd8a3a@linux.alibaba.com>
 <20220118141324.GF8034@ziepe.ca>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20220118141324.GF8034@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/18/22 10:13 PM, Jason Gunthorpe wrote:
> On Tue, Jan 18, 2022 at 09:03:47PM +0800, Cheng Xu wrote:
> 
>> Before calling ib_register_device(), the driver must call
>> ib_device_set_netdev(), otherwise ib_register_device() will failed
>> due to NULL netdev in ib_device structure, the call stack is:
> 
> You'll need to fix some core stuff to allow an ib_device to defer
> attaching the netdev, nothing does that today.
> 
> Jason

Sure, I will go deep into the core code, and try to fix this.

Thanks,
Cheng Xu
