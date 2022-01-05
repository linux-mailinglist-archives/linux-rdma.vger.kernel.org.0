Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C2A484BD0
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 01:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbiAEAlL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 19:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbiAEAlL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jan 2022 19:41:11 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE700C061761
        for <linux-rdma@vger.kernel.org>; Tue,  4 Jan 2022 16:41:10 -0800 (PST)
Message-ID: <427d2669-8e6e-9aae-6cc5-a6a8ee5d2c8c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1641343269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ULAoXKjnqBSjeXheZDNhrhPMe50/IYdG9yw3UQzMwI=;
        b=jFHpqyuwEP24YDN1kT6w8cXvUIfjGXKjQh6sX0d2m9zX7RAR97yREuw4plZhqJZWYIvUBn
        WF9KECnYpetWeOuTTJ/H9hbh+ZnRIMmMNP96LQrdJrYpyDnuQTw2/aYIKx6pjr6/nwtyPJ
        9F56T/WaNYeu6ymk9h03chqBlsG8Yhc=
Date:   Wed, 5 Jan 2022 08:41:01 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] RDMA/irdma: Make the source udp port vary
To:     Leon Romanovsky <leon@kernel.org>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "liweihang@huawei.com" <liweihang@huawei.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220105080727.2143737-1-yanjun.zhu@linux.dev>
 <20220105080727.2143737-4-yanjun.zhu@linux.dev>
 <1f6f5d2c6c3c422caa69d65e89f30d99@intel.com> <YdSfbB0O26l/47os@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <YdSfbB0O26l/47os@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/1/5 3:26, Leon Romanovsky 写道:
> On Tue, Jan 04, 2022 at 05:18:01PM +0000, Saleem, Shiraz wrote:
>>> Subject: [PATCH 3/4] RDMA/irdma: Make the source udp port vary
>>>
>>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>
>>> Get the source udp port number for a QP based on the grh.flow_label or
>>> lqpn/rqrpn. This provides a better spread of traffic across NIC RX queues.
>>>
>>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>> ---
>>>   drivers/infiniband/hw/irdma/verbs.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
>>> index 8cd5f9261692..09dba7ed5ab9 100644
>>> --- a/drivers/infiniband/hw/irdma/verbs.c
>>> +++ b/drivers/infiniband/hw/irdma/verbs.c
>>> @@ -1167,6 +1167,11 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct
>>> ib_qp_attr *attr,
>>>
>>>   		memset(&iwqp->roce_ah, 0, sizeof(iwqp->roce_ah));
>>>   		if (attr->ah_attr.ah_flags & IB_AH_GRH) {
>>> +			u32 fl = attr->ah_attr.grh.flow_label;
>>> +			u32 lqp = ibqp->qp_num;
>>> +			u32 rqp = roce_info->dest_qp;
>>> +
>>> +	
>> Do you really need these locals?
> 
> I asked same question in previous revision.
> 
> Zhu, please remove them.

Hi, Leon Romanovsky && Saleem, Shiraz

Without these local variables, the line "udp_info->src_port = 
rdma_get_udp_sport(fl, lqp, rqp);" will exceed 80. This will cause 
warning when this commit is checked by script/checkpatch.pl.

Let me have a try to find a better way to avoid these local variables.

Zhu Yanjun

> 
> Thanks

