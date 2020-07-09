Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEBF219854
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2020 08:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgGIGN5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jul 2020 02:13:57 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:41289 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGIGN5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jul 2020 02:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594275237; x=1625811237;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=XkDz503EvFCJjh7DMoAIoISDQE5CFtb97yEJuPxltEQ=;
  b=kr3KNjb1HXz5ckJdrL4/OzNwWCrKA31tW/v/lq3UMMHXHBQDbSCCCny0
   B8iiLv3sY5McZ1LGN7E22LbFZ7qOLRm1ikfUwqxxqZZph5RdiMpBKnKt7
   jBe8zJaw/2VJX3uSoLuTvVPcxT7cso1MTZrrlm6eVwQb+gFP11ZMkaAFm
   0=;
IronPort-SDR: CATE0xV2K17G7oYy4bVOu1vhCQEsEX1UqAizJggC/8hHo7QTQ7XhBJJxZwDNFyi1F0fISTwQhN
 YjDSjyxp5GVg==
X-IronPort-AV: E=Sophos;i="5.75,330,1589241600"; 
   d="scan'208";a="41010494"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 09 Jul 2020 06:13:56 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id A319B287D6B;
        Thu,  9 Jul 2020 06:13:54 +0000 (UTC)
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 9 Jul 2020 06:13:53 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.156) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 9 Jul 2020 06:13:50 +0000
Subject: Re: Question about IB_QP_CUR_STATE
To:     Leon Romanovsky <leon@kernel.org>
CC:     liweihang <liweihang@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <876ca1eb8667461a9d2e0effb8ee3934@huawei.com>
 <881488e6-03d8-1e01-076c-5c901d84a44a@amazon.com>
 <20200708154434.GA1276673@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <a738e3f3-e2bc-a670-7292-8025c78e210d@amazon.com>
Date:   Thu, 9 Jul 2020 09:13:45 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708154434.GA1276673@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.156]
X-ClientProxiedBy: EX13D34UWA002.ant.amazon.com (10.43.160.245) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 08/07/2020 18:44, Leon Romanovsky wrote:
> On Wed, Jul 08, 2020 at 03:42:34PM +0300, Gal Pressman wrote:
>> On 08/07/2020 12:41, liweihang wrote:
>>> Hi all,
>>>
>>> I'm a little confused about the role of IB_QP_CUR_STATE in the enumeration
>>> ib_qp_attr_mask.
>>>
>>> In manual page of ibv_modify_qp(), comments of cur_qp_state is "Assume this
>>> is the current QP state". Why we need to get current qp state from users
>>> instead of drivers?
>>>
>>> For example, why the users are allowed to modify qp from RTR to RTS again
>>> even if the qp's state in driver and hardware has already been RTS.
>>>
>>> I would be appretiate it if someone can help with this.
>>>
>>> Weihang
>>>
>>
>> Talking about IB_QP_CUR_STATE, I see many drivers filling it in their query QP
>> callback although it should only be used in modify operations.. Is there a
>> reason not to remove it?
> 
> IBTA section "11.2.5.3 QUERY QUEUE PAIR" has line about IB_QP_CUR_STATE.
> It is one of output modifiers.
> 
> Thanks
> 

It says the current QP state should be returned, that's what qp_state field is used for.
According to the man pages:

libibverbs/man/ibv_query_qp.3:
               enum ibv_qp_state       qp_state;            /* Current QP state */
               enum ibv_qp_state       cur_qp_state;        /* Current QP state - irrelevant for ibv_query_qp */
