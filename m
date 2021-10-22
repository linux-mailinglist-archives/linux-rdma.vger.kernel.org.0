Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D76437A50
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Oct 2021 17:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhJVPv6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Oct 2021 11:51:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24525 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229484AbhJVPv6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 22 Oct 2021 11:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634917779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bayYGufPvfS6PWv9C/i6dgR7rdiB+dz6DwVutOrLYY4=;
        b=M3fqzFoIl/XOBEf3zznwcMeHDP2miH8hdgQJJJcKw80vt8y/L+GikB5ye46+xGMAZicC4y
        EllLE5HgRprA9u/H+UEttfDzzTiFuC0lX4y8X9DhHfRAauq0OdfOd0odUdUy+NI9TXV8PQ
        gx2m21bgbXdZe5rXKhEXzD8ii81ej7s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-0Psa_F5KN12F4EMmHI2J5g-1; Fri, 22 Oct 2021 11:49:38 -0400
X-MC-Unique: 0Psa_F5KN12F4EMmHI2J5g-1
Received: by mail-wm1-f71.google.com with SMTP id b197-20020a1c1bce000000b0032ca040eb40so934360wmb.7
        for <linux-rdma@vger.kernel.org>; Fri, 22 Oct 2021 08:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bayYGufPvfS6PWv9C/i6dgR7rdiB+dz6DwVutOrLYY4=;
        b=DDdc5ufea98Gmg/LPO8QLFeFGzldOJYSbzMq7y3entQ5EZOFbAip41E7e6vY+iZdJ0
         G1b61IfQViYhfUQha78A95EDhKekONQx7k2b1yHQGmsiKuugKlRJ/eaepBoxtDwhrjhD
         3tXvqP7KZwHws1CmhqBe/gnyhev1UcwgKCFPSN5Un7l97hm/TsVcJoTavuU/qlKVoQ9v
         IzMleKirsZxbOlnx7PJeUsrGrK9juxdHESh9ZubsOiOSrz5lI5209JpCi3OpqiJ26Jja
         w0LFkvcglZOt09pURNV3gqhZswhgQP3Svrdb6MgNmgez4KnSytsIlRjDtTRgIQNHP1ap
         aGrQ==
X-Gm-Message-State: AOAM530r5H6hIfEkaDU3P0wKxfz3pDx5mHODlRr2yXIuVNpFSMhZhZ3Y
        OtavYzpx78i/d4VmzdJgV0DWMpXLPS8kLSOWivUa4ETB6e+T+7D5RvLAM6z1g9fXfGCRlaEELNh
        8s3tqgwpZmfDZlihd5vLOlw==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr506718wme.137.1634917777261;
        Fri, 22 Oct 2021 08:49:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZoTiH3SRODB/wRi9GyX7jX/v4B7dgU0hJfBXWkDN9ISqhVgKd0QVcnyqcjk1QlcPs6dD8SQ==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr506686wme.137.1634917776967;
        Fri, 22 Oct 2021 08:49:36 -0700 (PDT)
Received: from ?IPV6:2a10:8008:985b:0:b640:c314:eec3:dc25? ([2a10:8008:985b:0:b640:c314:eec3:dc25])
        by smtp.gmail.com with ESMTPSA id s11sm98294wrt.60.2021.10.22.08.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 08:49:36 -0700 (PDT)
Message-ID: <559f795c-c1f6-efea-fbe6-15fc02768a6e@redhat.com>
Date:   Fri, 22 Oct 2021 18:49:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [for-rc] RDMA/qedr: qedr crash while running rdma-tool.
Content-Language: en-US
To:     Alok Prasad <palok@marvell.com>
Cc:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Shai Malin <smalin@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
References: <20210821074339.16614-1-palok@marvell.com>
 <YSDpuTIsM2gL1h7e@unreal>
 <SJ0PR18MB390083F8ADF0036D6647F75DA1C59@SJ0PR18MB3900.namprd18.prod.outlook.com>
From:   Kamal Heib <kheib@redhat.com>
In-Reply-To: <SJ0PR18MB390083F8ADF0036D6647F75DA1C59@SJ0PR18MB3900.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 8/24/21 09:19, Alok Prasad wrote:
> Hi Leon,
> 
>> On Sat, Aug 21, 2021 at 07:43:39AM +0000, Alok Prasad wrote:
>>> This patch fixes crash caused by querying qp.
>>> This is due the fact that when no traffic is running,
>>> rdma_create_qp hasn't created any qp hence qed->qp is null.
>>
>> This description is not correct, all QP creation flows
>> dev->ops->rdma_create_qp() is called and if qedr_create_qp() successes,
>> we will have valid qp->qed_qp pointer.
>>
> 
> In qedr_create_qp(), first qp we create is GSI QP
> and it immediately returns after creating gsi_qp, and none of function
> either  qedr_create_user_qp() nor  qedr_create_kernel_qp() is
> called, both of them would have in turned called dev->ops->rdma_create_qp(),
> hence qp->qed_qp is null here.
> 
> Anyway will send a v2 as kernel test robot reported one
> Enum Warning.

Hi Alok,

Could you please tell when you plan to send a v2 for this patch?

We need this patch to get accepted in order to fix the distribution 
version of the qedr driver.

Thanks,
Kamal

>   
>>>
>>> Below call trace is generated while using iproute2 utility
>>> "rdma res show -dd qp" on rdma interface.
>>>
>>> ==========================================================================
>>> [  302.569794] BUG: kernel NULL pointer dereference, address: 0000000000000034
>>> ..
>>> [  302.570378] Hardware name: Dell Inc. PowerEdge R720/0M1GCR, BIOS 1.2.6 05/10/2012
>>> [  302.570500] RIP: 0010:qed_rdma_query_qp+0x33/0x1a0 [qed]
>>> [  302.570861] RSP: 0018:ffffba560a08f580 EFLAGS: 00010206
>>> [  302.570979] RAX: 0000000200000000 RBX: ffffba560a08f5b8 RCX: 0000000000000000
>>> [  302.571100] RDX: ffffba560a08f5b8 RSI: 0000000000000000 RDI: ffff9807ee458090
>>> [  302.571221] RBP: ffffba560a08f5a0 R08: 0000000000000000 R09: ffff9807890e7048
>>> [  302.571342] R10: ffffba560a08f658 R11: 0000000000000000 R12: 0000000000000000
>>> [  302.571462] R13: ffff9807ee458090 R14: ffff9807f0afb000 R15: ffffba560a08f7ec
>>> [  302.571583] FS:  00007fbbf8bfe740(0000) GS:ffff980aafa00000(0000)
>> knlGS:0000000000000000
>>> [  302.571729] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  302.571847] CR2: 0000000000000034 CR3: 00000001720ba001 CR4: 00000000000606f0
>>> [  302.571968] Call Trace:
>>> [  302.572083]  qedr_query_qp+0x82/0x360 [qedr]
>>> [  302.572211]  ib_query_qp+0x34/0x40 [ib_core]
>>> [  302.572361]  ? ib_query_qp+0x34/0x40 [ib_core]
>>> [  302.572503]  fill_res_qp_entry_query.isra.26+0x47/0x1d0 [ib_core]
>>> [  302.572670]  ? __nla_put+0x20/0x30
>>> [  302.572788]  ? nla_put+0x33/0x40
>>> [  302.572901]  fill_res_qp_entry+0xe3/0x120 [ib_core]
>>> [  302.573058]  res_get_common_dumpit+0x3f8/0x5d0 [ib_core]
>>> [  302.573213]  ? fill_res_cm_id_entry+0x1f0/0x1f0 [ib_core]
>>> [  302.573377]  nldev_res_get_qp_dumpit+0x1a/0x20 [ib_core]
>>> [  302.573529]  netlink_dump+0x156/0x2f0
>>> [  302.573648]  __netlink_dump_start+0x1ab/0x260
>>> [  302.573765]  rdma_nl_rcv+0x1de/0x330 [ib_core]
>>> [  302.573918]  ? nldev_res_get_cm_id_dumpit+0x20/0x20 [ib_core]
>>> [  302.574074]  netlink_unicast+0x1b8/0x270
>>> [  302.574191]  netlink_sendmsg+0x33e/0x470
>>> [  302.574307]  sock_sendmsg+0x63/0x70
>>> [  302.574421]  __sys_sendto+0x13f/0x180
>>> [  302.574536]  ? setup_sgl.isra.12+0x70/0xc0
>>> [  302.574655]  __x64_sys_sendto+0x28/0x30
>>> [  302.574769]  do_syscall_64+0x3a/0xb0
>>> [  302.574884]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>> ==========================================================================
>>>
>>> Signed-off-by: Ariel Elior <aelior@marvell.com>
>>> Signed-off-by: Shai Malin <smalin@marvell.com>
>>> Signed-off-by: Alok Prasad <palok@marvell.com>
>>> ---
>>>   drivers/infiniband/hw/qedr/verbs.c | 17 +++++++++--------
>>>   1 file changed, 9 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
>>> index fdc47ef7d861..79603e3fe2db 100644
>>> --- a/drivers/infiniband/hw/qedr/verbs.c
>>> +++ b/drivers/infiniband/hw/qedr/verbs.c
>>> @@ -2758,15 +2758,18 @@ int qedr_query_qp(struct ib_qp *ibqp,
>>>   	int rc = 0;
>>>
>>>   	memset(&params, 0, sizeof(params));
>>> -
>>> -	rc = dev->ops->rdma_query_qp(dev->rdma_ctx, qp->qed_qp, &params);
>>> -	if (rc)
>>> -		goto err;
>>> -
>>
>> At that point, QP should be valid.
>>
>>>   	memset(qp_attr, 0, sizeof(*qp_attr));
>>>   	memset(qp_init_attr, 0, sizeof(*qp_init_attr));
>>>
>>> -	qp_attr->qp_state = qedr_get_ibqp_state(params.state);
>>> +	if (qp->qed_qp)
>>> +		rc = dev->ops->rdma_query_qp(dev->rdma_ctx,
>>> +					     qp->qed_qp, &params);
>>> +
>>> +	if (qp->qp_type == IB_QPT_GSI)
>>> +		qp_attr->qp_state = QED_ROCE_QP_STATE_RTS;
>>> +	else
>>> +		qp_attr->qp_state = qedr_get_ibqp_state(params.state);
>>> +
>>>   	qp_attr->cur_qp_state = qedr_get_ibqp_state(params.state);
>>>   	qp_attr->path_mtu = ib_mtu_int_to_enum(params.mtu);
>>>   	qp_attr->path_mig_state = IB_MIG_MIGRATED;
>>> @@ -2810,8 +2813,6 @@ int qedr_query_qp(struct ib_qp *ibqp,
>>>
>>>   	DP_DEBUG(dev, QEDR_MSG_QP, "QEDR_QUERY_QP: max_inline_data=%d\n",
>>>   		 qp_attr->cap.max_inline_data);
>>> -
>>> -err:
>>>   	return rc;
>>>   }
>>>
>>> --
>>> 2.17.1
>>>
> 

