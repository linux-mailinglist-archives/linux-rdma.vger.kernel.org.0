Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F5362D7B4
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Nov 2022 11:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiKQKGm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Nov 2022 05:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiKQKGl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Nov 2022 05:06:41 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31643231
        for <linux-rdma@vger.kernel.org>; Thu, 17 Nov 2022 02:06:40 -0800 (PST)
Subject: Re: [PATCH RFC 00/12] Misc changes for rtrs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668679598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6IsIXy3slyofN5C7v9kWwuBC72LlM3ZMGQ0H9OFTDHc=;
        b=c3apde+3utFm7n50Oc9z1E8vH2TUUss4JF3D+JyR+aXCphYwaml7DE5YWtMUcmOfu3oyud
        YQRYEIi+Y6Fwn+VLl/jRXt7W65TkJssKWSzay4qWzzV9Zw3x9UsbiP7T4a77yHoQCi0/EK
        LsGYe+Qwknk7NkWmfilog+OYM0Xb+JI=
To:     Leon Romanovsky <leon@kernel.org>
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
 <Y3YEZK8BQjQ2DBSr@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <b0ec12c5-7fd5-d614-39f8-a53fff537438@linux.dev>
Date:   Thu, 17 Nov 2022 18:06:38 +0800
MIME-Version: 1.0
In-Reply-To: <Y3YEZK8BQjQ2DBSr@unreal>
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



On 11/17/22 5:52 PM, Leon Romanovsky wrote:
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
> Can you please resend already reviewed and non-controversial patches as a
> standalone series, so we will be able to apply them?

Sure, will send a new v2 series soon.

Thanks,
Guoqing
