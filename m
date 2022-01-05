Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AC9484BBE
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 01:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbiAEAeB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 19:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiAEAeB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jan 2022 19:34:01 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5187DC061761
        for <linux-rdma@vger.kernel.org>; Tue,  4 Jan 2022 16:34:01 -0800 (PST)
Message-ID: <898d7419-7e29-6258-a41e-2c62f251a1b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1641342839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qJsin6o1cbd+K103Z6xLqZl/0ioyt+Jb9jDcChUyjfc=;
        b=I5/7yuCDJURe1fnlEWl3rM/qmDRCDxJVic/a0wdfuWotG2W9VBcVZKYMJYUn2ssytIptlc
        vTKIu4qg1uSePkMgHVyJIL1T+B3URSWmoPUQKiMAfoI/Fg7TOMnC7h0I/awvTZ5n+MKvn3
        lDvdNzHQNwGARU1ZFmNwgkg0cEAHGh8=
Date:   Wed, 5 Jan 2022 08:33:51 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] RDMA/rxe: Use the standard method to produce udp
 source port
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "liweihang@huawei.com" <liweihang@huawei.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220105080727.2143737-1-yanjun.zhu@linux.dev>
 <20220105080727.2143737-5-yanjun.zhu@linux.dev>
 <1ba91339fb5e46ccb294f2c529fc2adb@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <1ba91339fb5e46ccb294f2c529fc2adb@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/1/5 1:17, Saleem, Shiraz 写道:
>> Subject: [PATCH 4/4] RDMA/rxe: Use the standard method to produce udp source
>> port
>>
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> Use the standard method to produce udp source port.
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_verbs.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c
>> b/drivers/infiniband/sw/rxe/rxe_verbs.c
>> index 0aa0d7e52773..f30d98ad13cd 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
>> @@ -469,6 +469,16 @@ static int rxe_modify_qp(struct ib_qp *ibqp, struct
>> ib_qp_attr *attr,
>>   	if (err)
>>   		goto err1;
>>
>> +	if (mask & IB_QP_AV) {
>> +		if (attr->ah_attr.ah_flags & IB_AH_GRH) {
>> +			u32 fl = attr->ah_attr.grh.flow_label;
>> +			u32 lqp = qp->ibqp.qp_num;
>> +			u32 rqp = qp->attr.dest_qp_num;
>> +
> Isn't the randomization for src_port done in rxe_qp_init_req redundant then?
> 
> https://elixir.bootlin.com/linux/v5.16-rc8/source/drivers/infiniband/sw/rxe/rxe_qp.c#L220
> 
> Can we remove it?

Yes. We can remove it.
Because this "randomization for src_port done in  rxe_qp_init_req" is 
replaced by rdma_get_udp_sport in rxe_modify_qp, I do not remove it.

I will remove it in the latest commits soon.

Zhu Yanjun

> 
>> +			qp->src_port = rdma_get_udp_sport(fl, lqp, rqp);
>> +		}
>> +	}
>> +
>>   	return 0;
>>
>>   err1:
>> --
>> 2.27.0
> 

