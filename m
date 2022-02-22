Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFF44BF219
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Feb 2022 07:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiBVG06 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Feb 2022 01:26:58 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiBVG0z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Feb 2022 01:26:55 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32028B7C64
        for <linux-rdma@vger.kernel.org>; Mon, 21 Feb 2022 22:26:30 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K2pwk3hSmzZcw4;
        Tue, 22 Feb 2022 14:21:58 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 14:26:27 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Feb
 2022 14:26:27 +0800
Subject: Re: [PATCH for-next v3 03/12] RDMA/erdma: Add the hardware related
 definitions
To:     Cheng Xu <chengyou.xc@alibaba-inc.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>
References: <20220217030116.6324-1-chengyou.xc@alibaba-inc.com>
 <20220217030116.6324-4-chengyou.xc@alibaba-inc.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <KaiShen@linux.alibaba.com>, <chengyou@linux.alibaba.com>,
        <tonylu@linux.alibaba.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <0d2f5636-3e7b-6dad-3fb6-6fee1067b522@huawei.com>
Date:   Tue, 22 Feb 2022 14:26:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220217030116.6324-4-chengyou.xc@alibaba-inc.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/2/17 11:01, Cheng Xu wrote:
> +enum erdma_opcode {
> +	ERDMA_OP_WRITE           = 0,
> +	ERDMA_OP_READ            = 1,
> +	ERDMA_OP_SEND            = 2,
> +	ERDMA_OP_SEND_WITH_IMM   = 3,
> +
> +	ERDMA_OP_RECEIVE         = 4,
> +	ERDMA_OP_RECV_IMM        = 5,
> +	ERDMA_OP_RECV_INV        = 6,
> +
> +	ERDMA_OP_REQ_ERR         = 7,
> +	ERDNA_OP_READ_RESPONSE   = 8,

Is there a typo here?

ERDNA_xxx -> ERDMA_xxx

Thanks,
Wenpeng

> +	ERDMA_OP_WRITE_WITH_IMM  = 9,
> +
> +	ERDMA_OP_RECV_ERR        = 10,
