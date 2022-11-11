Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180C4625443
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 08:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiKKHIa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Nov 2022 02:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiKKHI2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Nov 2022 02:08:28 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEAC79D05;
        Thu, 10 Nov 2022 23:08:21 -0800 (PST)
Message-ID: <e839bdca-c758-ddba-b57c-a601ba0b584e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668150499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MPSyUqp5ytgKHlemveNGiW8HoPFp7nZVSiPOafehCx8=;
        b=A76NC/eWNNX4InK+ZKR3E0UaPtWhUIq5iLxuEtY1VRc2mqzrJoPb4oonyEHtCTfwjg43Ad
        jNIYVmt8Z88b6XgerlIqs6mSngEQYF/7/ra3M4ebpXjA1nUoeDNb5jm9O9A4NEvPk9fkCE
        whksE9ID/RrQa5CNROu44ACiIBxdNNk=
Date:   Fri, 11 Nov 2022 15:08:11 +0800
MIME-Version: 1.0
Subject: Re: [for-next PATCH v5 00/11] RDMA/rxe: Add RDMA FLUSH operation
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
 <Y1wX8n9R7dkLo0KU@nvidia.com>
 <a37814f9-ed8a-d70a-3024-466700276864@linux.dev>
 <00a3797c-9759-d4ec-6d6f-8f157cd2a220@fujitsu.com>
 <b9f3550a-6fbc-b279-22a3-50285da82e5d@linux.dev>
 <9fa30c8b-cb8d-efec-5896-b96177929d08@fujitsu.com>
 <7ee2c646-0be0-5a37-83bd-110d8a8717d7@linux.dev>
 <84353223-4286-10d2-c358-599ada6550f1@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <84353223-4286-10d2-c358-599ada6550f1@fujitsu.com>
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


在 2022/11/11 14:38, lizhijian@fujitsu.com 写道:
>
> On 11/11/2022 14:30, Yanjun Zhu wrote:
>>> After these patches, only RXE device can register *FLUSHABLE* MRs
>>> successfully. If mlx try that, EOPNOSUPP will be returned.
>>>
>>> Similarly, Since other hardwares(MLX for example) have not supported
>>> FLUSH operation, EOPNOSUPP will be returned if users try to to that.
>>>
>>> In short, for RXE requester, MLX responder will return error for the
>>> request. MLX requester is not able to request a FLUSH operation.
>> Thanks. Do you mean that FLUSH operation is only supported in RXE? ^_^
>>
>> And MLX does not support FLUSH operation currently?
> IMO, FLUSH and Atomic Write are newly introduced by IBA spec 1.5
> published in 2021. So hardware/drivers(MLX) should do something to
> support it.

Thanks.

If I got you correctly, FLUSH and Atomic Write is a new feature. And 
from the test result, it is not supported by MLX driver currently.

Wait for MLX Engineer for updates about FLUSH and Atomic Write.

IMO, it had better make rxe successfully connect to one physical ib 
device with FLUSH and Atomic Write, such as MLX or others.

Zhu Yanjun

