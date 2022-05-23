Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C01F5313E8
	for <lists+linux-rdma@lfdr.de>; Mon, 23 May 2022 18:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbiEWODE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 May 2022 10:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236813AbiEWODC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 May 2022 10:03:02 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D315E2A705;
        Mon, 23 May 2022 07:03:00 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AQOWf2qJUhBm7WJCwFE+RIZclxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHCw3Dor0DYEm2ofCm3XaPrZYzChethzOoS+/ExU7ZLXzINqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+MzvuRGuK59yMkj/nRHuOU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatTozGIjdBwytREs7S+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZ/EapOGdcCbXXcu7iheun2HX6+92AUgsJooe+v56KW5?=
 =?us-ascii?q?L/P0cbjsKa3irlfO00qO5ELE03uwsKcDqOMUUvXQI5TPWAt4gX5HPQqyM7thdt?=
 =?us-ascii?q?B80h8ZTDbPdatAfZD5HchvNeVtMN00RBZZ4m/2n7lH7cjtFuBePqa8+y3bcwRY?=
 =?us-ascii?q?307X3NtfRPNuQSq1ocuywzo7d1z2hREhEa5rEknzYmk9AT9TnxUvTML/+3pXhn?=
 =?us-ascii?q?hKyvGCu+w=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AwWEBaKDK0HjbsdTlHemQ55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBLSC9F/b0qynAppomPGDP4gr5NEtApTniAtjkfZq/z+8X3WB5B97LMzUO01?=
 =?us-ascii?q?HYTr2Kg7GD/xTQXwX69sN4kZxrarVCDrTLZmRSvILX5xaZHr8brOW6zA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124446296"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 May 2022 22:02:59 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 93DE04D68A22;
        Mon, 23 May 2022 22:02:56 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 23 May 2022 22:02:58 +0800
Received: from [192.168.122.212] (10.167.226.45) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 23 May 2022 22:02:57 +0800
Subject: Re: [PATCH] RDMA/rxe: Use kzalloc() to alloc map_set
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Zhu Yanjun <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <20220518043725.771549-1-lizhijian@fujitsu.com>
 <20220520144511.GA2302907@nvidia.com>
From:   "Li, Zhijian" <lizhijian@fujitsu.com>
Message-ID: <d956bac8-36a6-0148-6f9c-fa43c8c272a7@fujitsu.com>
Date:   Mon, 23 May 2022 22:02:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220520144511.GA2302907@nvidia.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-yoursite-MailScanner-ID: 93DE04D68A22.ADC4F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


on 2022/5/20 22:45, Jason Gunthorpe wrote:
> On Wed, May 18, 2022 at 12:37:25PM +0800, Li Zhijian wrote:
>> Below call chains will alloc map_set without fully initializing map_set.
>> rxe_mr_init_fast()
>>   -> rxe_mr_alloc()
>>      -> rxe_mr_alloc_map_set()
>>
>> Uninitialized values inside struct rxe_map_set are possible to cause
>> kernel panic.
> If the value is uninitialized then why is 0 an OK value?
>
> Would be happier to know the exact value that is not initialized

Well, good question. After re-think of this issue, it seems this patch 
wasn't the root cause though it made the crash disappear in some extent.

I'm still working on the root cause :)

Thanks

Zhijian


>
> Jason


