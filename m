Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B7E62511A
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 03:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiKKCu3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Nov 2022 21:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiKKCuO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Nov 2022 21:50:14 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE4912E;
        Thu, 10 Nov 2022 18:49:16 -0800 (PST)
Message-ID: <a37814f9-ed8a-d70a-3024-466700276864@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668134955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vhaTPSkrdP42Cy7UEGp+EqsBBT2BRFaWnPTLbkiuH9s=;
        b=pTm3XQzqD4gGvFpGJWqOzyYUkFgo2B9Am9Y3TQ9jlHG4M2UkCL3UjDztsZIKG3o98c2Shj
        6q+Mr92E2+L+FjFyp+PGV0s4daQ8TnnfJrMafEZbYBSnX9h8cn2QoCl2VKFneV4HQ3393O
        MCTdQxZbKnrGsGaJTloonTMSLeXyjS0=
Date:   Fri, 11 Nov 2022 10:49:10 +0800
MIME-Version: 1.0
Subject: Re: [for-next PATCH v5 00/11] RDMA/rxe: Add RDMA FLUSH operation
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Li Zhijian <lizhijian@fujitsu.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, liangwenpeng@huawei.com,
        tom@talpey.com, tomasz.gromadzki@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
 <Y1wX8n9R7dkLo0KU@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <Y1wX8n9R7dkLo0KU@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/10/29 1:57, Jason Gunthorpe 写道:
> On Tue, Sep 27, 2022 at 01:53:26PM +0800, Li Zhijian wrote:
>> Hey folks,
>>
>> Firstly i want to say thank you to all you guys, especially Bob, who in the
>> past 1+ month, gave me a lots of idea and inspiration.
> 
> I would like it if someone familiar with rxe could reviewed-by the
> protocol parts.

Hi, Jason

I reviewed these patches. I am fine with these patches.

Hi, Zhijian

I noticed the followings:
"
$ ./rdma_flush_server -s [server_address] -p [port_number]
client:
$ ./rdma_flush_client -s [server_address] -p [port_number]
"
Can you merge the server and the client to rdma-core?

Thanks,
Zhu Yanjun

> 
> Jason

