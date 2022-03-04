Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C824CCB8D
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Mar 2022 03:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbiCDCJs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Mar 2022 21:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiCDCJs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Mar 2022 21:09:48 -0500
Received: from sender2-op-o12.zoho.com.cn (sender2-op-o12.zoho.com.cn [163.53.93.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBEA14ACB5
        for <linux-rdma@vger.kernel.org>; Thu,  3 Mar 2022 18:08:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1646359715; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=cTZ64zlZj5KJZymqUXzZg9CvVC9el6FxGHLCnaUro8LPsoSxuERGqOyOnYgDu5PGXH/scWNcDGyJZfL6hDVz+rV1rnhXhbiSuXhiFuLEdYTBnkvcV1IpwnX6oHsN6cDjqhuExcg0jlgASAXJFv/KWbs+sWKholFpl73WEr5mnhs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1646359715; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=F3hTtdd5uuIDGKm5XVoNESqf+9+cc1eHh6IJCZrMEaU=; 
        b=LL+tTkOJ0N/Bo0Vczg3SWFpmX7boG1REcEjsphkD0JR0MZIiILGpD2227cl0C8jf3g72Hwx+E8inK6t7qZGiaF9tmFERZE4IEKjuit+EBUC0+J0FUilYSJs8QSk+K8OHc4xBaF7kWGXfn7AsBBvNLguhsdPcuvi7a06i1jYlyyQ=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1646359715;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:MIME-Version:Subject:To:Cc:References:From:Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=F3hTtdd5uuIDGKm5XVoNESqf+9+cc1eHh6IJCZrMEaU=;
        b=PEJezW+bH3xaY//uOTa9b0SoHGSbsAXheTM+LfwXehhiMryW4T5ZY1CfH2VkrpOE
        8eY4RvJKk3QtiHlvivQGceljoae2RFmIGdlZyL7PJPuLN5pl9dmoIW0uRROaUyyEBdS
        MzB144bKiO2dQqgIsp4pyzOhCg52kSwlPyMwtPV4=
Received: from [192.168.255.10] (113.87.89.75 [113.87.89.75]) by mx.zoho.com.cn
        with SMTPS id 1646359712544984.4256622090078; Fri, 4 Mar 2022 10:08:32 +0800 (CST)
Date:   Fri, 4 Mar 2022 10:08:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] RDMA/rxe: change payload type to u32 from int
To:     Leon Romanovsky <leon@kernel.org>
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20220302141054.2078616-1-cgxu519@mykernel.net>
 <YiEDNPT/T69Y0Vmu@unreal>
From:   Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <fbb14096-c8fa-80f2-3692-ee4f828e452f@mykernel.net>
In-Reply-To: <YiEDNPT/T69Y0Vmu@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

=E5=9C=A8 2022/3/4 2:04, Leon Romanovsky =E5=86=99=E9=81=93:
> On Wed, Mar 02, 2022 at 10:10:54PM +0800, Chengguang Xu wrote:
>> The type of wqe length is u32 so change variable payload
>> to type u32 to avoid overflow on large wqe length.
>>
>> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_req.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw=
/rxe/rxe_req.c
>> index 5eb89052dd66..e989ee3a2033 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_req.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
>> @@ -612,7 +612,7 @@ int rxe_requester(void *arg)
>>   =09struct sk_buff *skb;
>>   =09struct rxe_send_wqe *wqe;
>>   =09enum rxe_hdr_mask mask;
>> -=09int payload;
>> +=09u32 payload;
> This change is not complete, functions in rxe_requester() that receive
> payload as an input should be changed too.

IIUC, when calling those functions payload has been cut off to mtu size
and I think mtu will be much smaller than 2GB, so there is no rish of=20
overflow.

Thanks,
Chengguang

>
>>   =09int mtu;
>>   =09int opcode;
>>   =09int ret;
>> --=20
>> 2.27.0
>>
>>


