Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E6B4CCEF9
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Mar 2022 08:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbiCDHVd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Mar 2022 02:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiCDHVd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Mar 2022 02:21:33 -0500
Received: from sender2-op-o12.zoho.com.cn (sender2-op-o12.zoho.com.cn [163.53.93.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0060218C7A6
        for <linux-rdma@vger.kernel.org>; Thu,  3 Mar 2022 23:20:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1646378430; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=MmT403Y43qlT2owLwhd43szCBE01ndTYES5zBqGSLCVMNsWxaMH6t0HhKrAS4ENhtz7VsFP3szIjBcnAOv/kbZd9oVy4oYXUVZhd6lKp4BsAB6Xqq9CNstf1RPhko6/yUGm4ts/onn1PUGYpc1lhWyJc7HIx1ZdF6ZVlzZsvQB4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1646378430; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=AcwcKaigy3E+LHRgsbKJGXwtyJVe78mBqVG+LJSzo7A=; 
        b=E3se2owlYlXnLQk+9UrcA0FjrqNb5mx35t7aetVf3Htguf32fvcP8KuZjix3QC+olrgu5T2EfTFPwGYvbEtnozJu4AaVw1K+xBo2vUlikO0PBZo7WgwPTiesqvMZMgynMu7RJQMshUngYU9o/KYGLZqatejFXrJKmnZFhRP8t+E=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1646378430;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:MIME-Version:Subject:To:Cc:References:From:Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=AcwcKaigy3E+LHRgsbKJGXwtyJVe78mBqVG+LJSzo7A=;
        b=gqCoMqGQ1ccOXa3Xn5xexHi/R5Su7f4AAfqWQfF0pCot5TIryMdq1PpN788Aq/YN
        MgagGTvvMp42aIviA1ylvKWx2SsdAzi8x4ivG392JmV+IdGI5kz03ZIl4vWC37zBy9f
        sUPLi5omMFd3GjF6Z9ERn/UMXNzzGwHdgOQMhtWs=
Received: from [192.168.255.10] (113.87.89.75 [113.87.89.75]) by mx.zoho.com.cn
        with SMTPS id 164637842869774.84944367049093; Fri, 4 Mar 2022 15:20:28 +0800 (CST)
Date:   Fri, 4 Mar 2022 15:20:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] RDMA/rxe: change payload type to u32 from int
To:     Leon Romanovsky <leon@kernel.org>
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20220302141054.2078616-1-cgxu519@mykernel.net>
 <YiEDNPT/T69Y0Vmu@unreal> <fbb14096-c8fa-80f2-3692-ee4f828e452f@mykernel.net>
 <YiG7f16SZolUhks3@unreal>
From:   Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <6c0f0b0b-33f9-2aea-525e-1dc73b3e4ad5@mykernel.net>
In-Reply-To: <YiG7f16SZolUhks3@unreal>
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

=E5=9C=A8 2022/3/4 15:10, Leon Romanovsky =E5=86=99=E9=81=93:
> On Fri, Mar 04, 2022 at 10:08:29AM +0800, Chengguang Xu wrote:
>> =E5=9C=A8 2022/3/4 2:04, Leon Romanovsky =E5=86=99=E9=81=93:
>>> On Wed, Mar 02, 2022 at 10:10:54PM +0800, Chengguang Xu wrote:
>>>> The type of wqe length is u32 so change variable payload
>>>> to type u32 to avoid overflow on large wqe length.
>>>>
>>>> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>>>> ---
>>>>    drivers/infiniband/sw/rxe/rxe_req.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/=
sw/rxe/rxe_req.c
>>>> index 5eb89052dd66..e989ee3a2033 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_req.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
>>>> @@ -612,7 +612,7 @@ int rxe_requester(void *arg)
>>>>    =09struct sk_buff *skb;
>>>>    =09struct rxe_send_wqe *wqe;
>>>>    =09enum rxe_hdr_mask mask;
>>>> -=09int payload;
>>>> +=09u32 payload;
>>> This change is not complete, functions in rxe_requester() that receive
>>> payload as an input should be changed too.
>> IIUC, when calling those functions payload has been cut off to mtu size
>> and I think mtu will be much smaller than 2GB, so there is no rish of
>> overflow.
> It is not because of overflow, but desire to have proper types for whole
> call stack without shadow casting and ambiguity.

Okay, that makes sense, let me fold into v2 version.


Thanks,
Chengguang





