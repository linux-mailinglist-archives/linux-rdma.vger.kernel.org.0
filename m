Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B8828B435
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 13:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388312AbgJLL4X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 12 Oct 2020 07:56:23 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3629 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388255AbgJLL4W (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Oct 2020 07:56:22 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 27CB1BF8E31593D0B24E;
        Mon, 12 Oct 2020 19:56:18 +0800 (CST)
Received: from dggema701-chm.china.huawei.com (10.3.20.65) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 12 Oct 2020 19:56:17 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema701-chm.china.huawei.com (10.3.20.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 12 Oct 2020 19:56:17 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Mon, 12 Oct 2020 19:56:17 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Support owner mode doorbell
Thread-Topic: [PATCH v2 for-next] RDMA/hns: Support owner mode doorbell
Thread-Index: AQHWlLMb4zB6/tAMkEeu4l0wwJS1hw==
Date:   Mon, 12 Oct 2020 11:56:17 +0000
Message-ID: <1a828087e5ad4880941310afb6843958@huawei.com>
References: <1601199901-41677-1-git-send-email-liweihang@huawei.com>
 <20200929165356.GA757147@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/9/30 0:54, Jason Gunthorpe wrote:
> On Sun, Sep 27, 2020 at 05:45:01PM +0800, Weihang Li wrote:
>> @@ -517,7 +514,18 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
>>  
>>  	set_extend_sge(qp, wr, &curr_idx, valid_num_sge);
>>  
>> +	/*
>> +	 * The pipeline can sequentially post all valid WQEs into WQ buffer,
>> +	 * including new WQEs waiting for the doorbell to update the PI again.
>> +	 * Therefore, the owner bit of WQE MUST be updated after all fields
>> +	 * and extSGEs have been written into DDR instead of cache.
>> +	 */
>> +	if (qp->en_flags & HNS_ROCE_QP_CAP_OWNER_DB)
>> +		wmb();
> 
> Should this be dma_wmb() ?
> 
> Jason
> 

Yes, dma_wmb() is better, thank you.

Weihang
