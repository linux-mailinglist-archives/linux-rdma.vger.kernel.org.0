Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E928721C8A0
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2020 12:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgGLKyD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Jul 2020 06:54:03 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:23950 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbgGLKyC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 12 Jul 2020 06:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594551242; x=1626087242;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=kN2CP8TCpAkb63kfM3YriCo8L8ZQV6trkVSDtiTBZec=;
  b=DFc/lh+FgbtbIEkM7pscDIAc/ipfgEtwN7Uk5S35n277EUAqxJ72FIm5
   ZA/u8JdFktNd2lYpZQPnIXgFrUNzyK81XZZL9WcyYmKtWjtLl2VH6/IQj
   kOP5NqQw2jN0ewUypDT8wo5wU9heZcDZu2Byy7sa61M2rSCaW3twVLvz0
   E=;
IronPort-SDR: Ph4M0s071T9Uqu2f8GJ8ye/SdxD2bXKiYfQAB5eU2LBRd+PRGgozi8qzAiog+jANG/2WPl7ph+
 ojGUNx5y/e4A==
X-IronPort-AV: E=Sophos;i="5.75,343,1589241600"; 
   d="scan'208";a="59088259"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 12 Jul 2020 10:53:24 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (Postfix) with ESMTPS id EE5DAA1B77;
        Sun, 12 Jul 2020 10:53:21 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 12 Jul 2020 10:53:21 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.146) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 12 Jul 2020 10:53:17 +0000
Subject: Re: Question about IB_QP_CUR_STATE
To:     Leon Romanovsky <leon@kernel.org>
CC:     liweihang <liweihang@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <876ca1eb8667461a9d2e0effb8ee3934@huawei.com>
 <881488e6-03d8-1e01-076c-5c901d84a44a@amazon.com>
 <20200708154434.GA1276673@unreal>
 <a738e3f3-e2bc-a670-7292-8025c78e210d@amazon.com>
 <20200712104419.GA7287@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <ca040bc1-e5dc-e514-ace4-8145b7946664@amazon.com>
Date:   Sun, 12 Jul 2020 13:53:13 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200712104419.GA7287@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.146]
X-ClientProxiedBy: EX13D14UWB003.ant.amazon.com (10.43.161.162) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/07/2020 13:44, Leon Romanovsky wrote:
> On Thu, Jul 09, 2020 at 09:13:45AM +0300, Gal Pressman wrote:
>> On 08/07/2020 18:44, Leon Romanovsky wrote:
>>> On Wed, Jul 08, 2020 at 03:42:34PM +0300, Gal Pressman wrote:
>>>> On 08/07/2020 12:41, liweihang wrote:
>>>>> Hi all,
>>>>>
>>>>> I'm a little confused about the role of IB_QP_CUR_STATE in the enumeration
>>>>> ib_qp_attr_mask.
>>>>>
>>>>> In manual page of ibv_modify_qp(), comments of cur_qp_state is "Assume this
>>>>> is the current QP state". Why we need to get current qp state from users
>>>>> instead of drivers?
>>>>>
>>>>> For example, why the users are allowed to modify qp from RTR to RTS again
>>>>> even if the qp's state in driver and hardware has already been RTS.
>>>>>
>>>>> I would be appretiate it if someone can help with this.
>>>>>
>>>>> Weihang
>>>>>
>>>>
>>>> Talking about IB_QP_CUR_STATE, I see many drivers filling it in their query QP
>>>> callback although it should only be used in modify operations.. Is there a
>>>> reason not to remove it?
>>>
>>> IBTA section "11.2.5.3 QUERY QUEUE PAIR" has line about IB_QP_CUR_STATE.
>>> It is one of output modifiers.
>>>
>>> Thanks
>>>
>>
>> It says the current QP state should be returned, that's what qp_state field is used for.
>> According to the man pages:
>>
>> libibverbs/man/ibv_query_qp.3:
>>                enum ibv_qp_state       qp_state;            /* Current QP state */
>>                enum ibv_qp_state       cur_qp_state;        /* Current QP state - irrelevant for ibv_query_qp */
> 
> I don't think that users read it, because ibv_cmd_query_qp() filled
> qp_state to be equal to cur_qp_state from day one.

Where do you see that?

I see:
ibv_cmd_query_qp():
	attr->qp_state                      = resp.qp_state;
	attr->cur_qp_state                  = resp.cur_qp_state;
