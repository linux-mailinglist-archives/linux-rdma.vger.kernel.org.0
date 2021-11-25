Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293C845E167
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 21:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357032AbhKYUPQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 15:15:16 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:50458 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357110AbhKYUNQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Nov 2021 15:13:16 -0500
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id qL4EmblRQqYovqL4EmK9cw; Thu, 25 Nov 2021 21:10:03 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 25 Nov 2021 21:10:03 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [PATCH] RDMA/mlx4: Use bitmap_alloc() when applicable
To:     Joe Perches <joe@perches.com>, yishaih@nvidia.com,
        selvin.xavier@broadcom.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <4c93b4e02f5d784ddfd3efd4af9e673b9117d641.1637869328.git.christophe.jaillet@wanadoo.fr>
 <ddef1847b4694071ae914eab93b0d2bd45fdf050.camel@perches.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <142324ab-7696-e43d-2368-a18abebe7b09@wanadoo.fr>
Date:   Thu, 25 Nov 2021 21:10:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ddef1847b4694071ae914eab93b0d2bd45fdf050.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Le 25/11/2021 à 20:58, Joe Perches a écrit :
> On Thu, 2021-11-25 at 20:42 +0100, Christophe JAILLET wrote:
>> Use 'bitmap_alloc()' to simplify code, improve the semantic and avoid some
>> open-coded arithmetic in allocator arguments.
>>
>> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
>> consistency.
> 
> Thanks.
> 
>> diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
> []
>> @@ -2784,10 +2784,8 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
>>   		if (err)
>>   			goto err_counter;
>>   
>> -		ibdev->ib_uc_qpns_bitmap =
>> -			kmalloc_array(BITS_TO_LONGS(ibdev->steer_qpn_count),
>> -				      sizeof(long),
>> -				      GFP_KERNEL);
>> +		ibdev->ib_uc_qpns_bitmap = bitmap_alloc(ibdev->steer_qpn_count,
>> +							GFP_KERNEL);
> 
> I wonder if it'd be simpler/smaller to change this to bitmap_zalloc and
> remove the bitmap_zero in the if below.
> 

I asked myself the same question.
It is easy to see that the bitmap is either cleared or set.
So this is fine enough for me.

Let see if a maintainer has a preference on it.

CJ

