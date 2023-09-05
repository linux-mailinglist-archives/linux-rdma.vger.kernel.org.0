Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED8379260B
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Sep 2023 18:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjIEQAz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Sep 2023 12:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345406AbjIEEHd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Sep 2023 00:07:33 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9CFCCB
        for <linux-rdma@vger.kernel.org>; Mon,  4 Sep 2023 21:07:29 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RfsMD6JFqzMl6D;
        Tue,  5 Sep 2023 12:04:08 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 5 Sep 2023 12:07:27 +0800
Message-ID: <9a9ee4b7-b378-4aeb-6e23-02d2f6dbaa9a@huawei.com>
Date:   Tue, 5 Sep 2023 12:07:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH for-rc] RDMA/irdma: Prevent zero-length STAG registration
To:     Shiraz Saleem <shiraz.saleem@intel.com>, <jgg@nvidia.com>,
        <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <ivan.d.barrera@intel.com>,
        Christopher Bednarz <christopher.n.bednarz@intel.com>
References: <20230818144838.1758-1-shiraz.saleem@intel.com>
From:   "liujian (CE)" <liujian56@huawei.com>
In-Reply-To: <20230818144838.1758-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.93]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2023/8/18 22:48, Shiraz Saleem wrote:
> From: Christopher Bednarz <christopher.n.bednarz@intel.com>
> 
> Currently irdma allows zero-length STAGs to be programmed in HW during
> the kernel mode fast register flow. Zero-length MR or STAG registration
> disable HW memory length checks.
> 
> Improve gaps in bounds checking in irdma by preventing zero-length STAG or
> MR registrations except if the IB_PD_UNSAFE_GLOBAL_RKEY is set.
> 
> This addresses the disclosure CVE-2023-25775.
> 
> Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")

Hello,I would like to consult the CVE. The driver corresponding to the 
kernel of an earlier version (< 5.14) is i40iw and has similar code 
logic. Is this CVE also involved?

> Signed-off-by: Christopher Bednarz <christopher.n.bednarz@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>   drivers/infiniband/hw/irdma/ctrl.c  |  6 ++++++
>   drivers/infiniband/hw/irdma/type.h  |  2 ++
>   drivers/infiniband/hw/irdma/verbs.c | 10 ++++++++--
>   3 files changed, 16 insertions(+), 2 deletions(-)
> 
[...]
