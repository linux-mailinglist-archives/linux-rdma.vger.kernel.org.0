Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE1737BDBE
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 15:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhELNNV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 09:13:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2569 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbhELNNV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 May 2021 09:13:21 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FgFVz4gYXzsRJs;
        Wed, 12 May 2021 21:09:31 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.72) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Wed, 12 May 2021
 21:12:09 +0800
Subject: Re: [PATCH v2 2/2] RDMA/cm: Optimise rbtree searching
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <20210512100537.6273-1-thunder.leizhen@huawei.com>
 <20210512100537.6273-3-thunder.leizhen@huawei.com>
 <20210512125006.GE1096940@ziepe.ca>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <afb85ebf-4b76-d5e7-847a-14461bcf7310@huawei.com>
Date:   Wed, 12 May 2021 21:12:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210512125006.GE1096940@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2021/5/12 20:50, Jason Gunthorpe wrote:
> On Wed, May 12, 2021 at 06:05:37PM +0800, Zhen Lei wrote:
>>  static struct cm_id_private *cm_find_listen(struct ib_device *device,
>> @@ -686,22 +687,23 @@ static struct cm_id_private *cm_find_listen(struct ib_device *device,
>>  
>>  	while (node) {
>>  		cm_id_priv = rb_entry(node, struct cm_id_private, service_node);
>> -		if ((cm_id_priv->id.service_mask & service_id) ==
>> -		     cm_id_priv->id.service_id &&
>> -		    (cm_id_priv->id.device == device)) {
>> -			refcount_inc(&cm_id_priv->refcount);
>> -			return cm_id_priv;
>> -		}
>> +
>>  		if (device < cm_id_priv->id.device)
>>  			node = node->rb_left;
>>  		else if (device > cm_id_priv->id.device)
>>  			node = node->rb_right;
>> +		else if ((cm_id_priv->id.service_mask & service_id) == cm_id_priv->id.service_id)
>> +			goto found;
>>  		else if (be64_lt(service_id, cm_id_priv->id.service_id))
>>  			node = node->rb_left;
>>  		else
>>  			node = node->rb_right;
>>  	}
> 
> This is not the pattern I showed you. Drop the first patch and rely on
> the implicit equality in the final else.

Do you mean treate the "found" process as the else branch?

But ((cm_id_priv->id.service_mask & service_id) == cm_id_priv->id.service_id) is different from
(service_id == cm_id_priv->id.service_id)，I'm just worried that it might change the original logic.

> 
> Jason
> 
> .
> 

