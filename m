Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04D862780E
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Nov 2022 09:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbiKNIqi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Nov 2022 03:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbiKNIqd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Nov 2022 03:46:33 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375C51CB3E
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 00:46:32 -0800 (PST)
Subject: Re: [PATCH RFC 00/12] Misc changes for rtrs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668415590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uVUDNpuOPTl1Ugbb7shl45KqL56zndjj3imKWutMI8o=;
        b=q5WT7toGNVlNKjbaKDQzIqpc7JPiiW6NoHcVLgWVzXXQxnBpiTL53rFc6O2IwQcKua8JM8
        8id0mH3oBvyX7vLIuyOEX4i1JlrkovOPgsAnDgeOZJVLTerh6S5UYABgdzIiA/4tB9TRjd
        bJSF/S/cAxx7D9HWxa47vpF4DZXl6C8=
To:     Leon Romanovsky <leon@kernel.org>
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
 <Y3H9FrmwdEe/q8wu@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <1933d6eb-65f6-6376-f83c-b51383718c19@linux.dev>
Date:   Mon, 14 Nov 2022 16:46:26 +0800
MIME-Version: 1.0
In-Reply-To: <Y3H9FrmwdEe/q8wu@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11/14/22 4:32 PM, Leon Romanovsky wrote:
> On Sun, Nov 13, 2022 at 09:08:11AM +0800, Guoqing Jiang wrote:
>> Hi,
>>
>> Here are some changes for rtrs, please review them.
>>
>> Thanks,
>> Guoqing
>>
>> Guoqing Jiang (12):
>>    RDMA/rtrs-srv: Remove ib_dev_count from rtrs_srv_ib_ctx
>>    RDMA/rtrs-srv: Refactor rtrs_srv_rdma_cm_handler
>>    RDMA/rtrs-srv: Only close srv_path if it is just allocated
>>    RDMA/rtrs-srv: refactor the handling of failure case in map_cont_bufs
>>    RDMA/rtrs-srv: Correct the checking of ib_map_mr_sg
>>    RDMA/rtrs-clt: Correct the checking of ib_map_mr_sg
>>    RDMA/rtrs-srv: Remove outdated comments from create_con
>>    RDMA/rtrs: Kill recon_cnt from several structs
>>    RDMA/rtrs: Clean up rtrs_rdma_dev_pd_ops
>>    RDMA/rtrs-srv: Remove paths_num
>>    RDMA/rtrs-srv: fix several issues in rtrs_srv_destroy_path_files
>>    RDMA/rtrs-srv: Remove kobject_del from
>>      rtrs_srv_destroy_once_sysfs_root_folders
>>
>>   drivers/infiniband/ulp/rtrs/rtrs-clt.c       |  12 +-
>>   drivers/infiniband/ulp/rtrs/rtrs-pri.h       |   6 -
>>   drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  13 ++-
>>   drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 110 ++++++-------------
>>   drivers/infiniband/ulp/rtrs/rtrs-srv.h       |   2 -
>>   drivers/infiniband/ulp/rtrs/rtrs.c           |  22 +---
>>   6 files changed, 47 insertions(+), 118 deletions(-)
> Why is this series marked as RFC?

Because I am not quite sure about some of them, and there is no rush for
the series.

Thanks,
Guoqing
