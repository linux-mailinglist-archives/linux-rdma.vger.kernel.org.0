Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832B47F03E7
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Nov 2023 02:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjKSBcD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 Nov 2023 20:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKSBcD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 18 Nov 2023 20:32:03 -0500
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [IPv6:2001:41d0:203:375::ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4856C194
        for <linux-rdma@vger.kernel.org>; Sat, 18 Nov 2023 17:31:59 -0800 (PST)
Message-ID: <9e56b543-4954-4d5f-8632-db2c235658e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700357517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kON12cmh++CiZoZz6VJ2REGny1JN2woXCHKTFW9ACWE=;
        b=QUYLyNIo5FPLt+JOeoV+Sl08/3StnqBBRoH0+IBavdyNWx3Xffe1cl5Yh5lEjsgaaiYioo
        1woVFu45kGTRg/YsMZqO09JCBYw5RcawX+PhXevFQnD44nxaCsNJt5lm4OZJxjKiWTIxTa
        QyTowai4TZoCihTJSUdstaRzFxjSpzw=
Date:   Sun, 19 Nov 2023 09:31:35 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-rc 1/3] RDMA/core: Fix umem iterator when PAGE_SIZE is
 greater then HCA pgsz
To:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20231115191752.266-1-shiraz.saleem@intel.com>
 <20231115191752.266-2-shiraz.saleem@intel.com>
 <093f16a6-2948-4103-8d27-ea349aa6909c@linux.dev>
 <SA1PR11MB6895E230B7CFE2D293DAFAA886B6A@SA1PR11MB6895.namprd11.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <SA1PR11MB6895E230B7CFE2D293DAFAA886B6A@SA1PR11MB6895.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/11/18 22:54, Marciniszyn, Mike 写道:
>>> From: Mike Marciniszyn <mike.marciniszyn@intel.com>
>>>
>>> 64k pages introduce the situation in this diagram when the HCA
>>
>> Only ARM64 architecture supports 64K page size?
> 
> Arm supports multiple page_sizes.   The problematic combination is when
> the HCA needs a SMALLER page size than the PAGE_SIZE.

Thanks a lot. Perhaps RXE also needs this feature "the HCA needs a 
SMALLER page size than the PAGE_SIZE". But I do not have such test 
environment at hand.
If we can setup a test environment on x86_64 architecture, it is very 
convenient for me to make tests and development.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> 
> The kernel configuration can select from
> 
>> Is it possible that x86_64 also supports 64K page size?
>>
> 
> x86_64 supports larger page_sizes for TLB optimization, but the default minimum is always 4K.
> 
> Mike

