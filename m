Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310334E7C3E
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Mar 2022 01:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbiCYWpz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Mar 2022 18:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbiCYWpL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Mar 2022 18:45:11 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2AB20D82C
        for <linux-rdma@vger.kernel.org>; Fri, 25 Mar 2022 15:43:35 -0700 (PDT)
Message-ID: <840723ae-59d5-8f2d-b586-3c6263585eb9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648248210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKaOMBspdlxyQQG+a4X4cRMuaf19zmwb9/DvTH2xdII=;
        b=pgyWveLFkewtN6XLqT1aBbBNPKbivTM6U0RolWEGWmIibBl9WeRUI+JJOmAcH9/QoHsNhf
        b1QtmGE8EQYsO3/pVRqWlaGDlO8pQRegSIdeEaHBO1oK0soNCjd9aqZM1oXsB58Cpyj15y
        i5qec6UDS9L5F559n+zE0gV3HWQuoQ4=
Date:   Sat, 26 Mar 2022 06:43:22 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] MAINTAINERS: Add Leon Romanovsky to RDMA maintainers
To:     Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
References: <0-v1-64175bea3d24+13436-leon_maint_jgg@nvidia.com>
 <YjzL1CthgBQaXfCb@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <YjzL1CthgBQaXfCb@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/3/25 3:51, Leon Romanovsky 写道:
> On Thu, Mar 24, 2022 at 02:53:19PM -0300, Jason Gunthorpe wrote:
>> Welcome Leon to the maintainer list so we continue to have two people on a
>> medium sized subsystem.
>>
>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
> 
> Thanks a lot.

Congratulations.

Zhu Yanjun
> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ea3e6c91438481..8f05457f9be176 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9408,6 +9408,7 @@ F:	drivers/iio/pressure/dps310.c
>>   
>>   INFINIBAND SUBSYSTEM
>>   M:	Jason Gunthorpe <jgg@nvidia.com>
>> +M:	Leon Romanovsky <leonro@nvidia.com>
>>   L:	linux-rdma@vger.kernel.org
>>   S:	Supported
>>   W:	https://github.com/linux-rdma/rdma-core
>>
>> base-commit: 87e0eacb176f9500c2063d140c0a1d7fa51ab8a5
>> -- 
>> 2.35.1
>>

