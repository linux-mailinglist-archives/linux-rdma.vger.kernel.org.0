Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2443122B23D
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jul 2020 17:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgGWPPF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Jul 2020 11:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgGWPPE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Jul 2020 11:15:04 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B24C0619DC
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jul 2020 08:15:04 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z3so3138024pfn.12
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jul 2020 08:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=m/xUKoMMzoI2WxKiDLTy5BlQHx454hHYAmDrgSdszz4=;
        b=kVxTcAFJvmYQgg79OlSJhrKxfT9NHBRJjTzkiedbvbcJYVCWOht8IONuSbdEzne2dn
         BRp62hJYQeKv+xStRHSwIEfrXiKw+Ha03IyRLdDvxhCrut+2uA4xvrHFw4kEffCu3mv9
         sLnGe+mT509GPIr6YEtGAAgIiwFrFWBjso/Y7QrfWYEFJlGyJR9NoQz7IgJe/DgBIAxD
         p24DYLwFuTC8J3VvCGXp4PD8HTDjO5wMoSMWYAvbO4Yj8lX1QdqEsXAQo+FcjcgyF9d8
         mrUziOLdmJLHEQ7U7nWbaFNaZ/wzFsBMtgEyZHr7gjPww7ukqp3dQpQf8wCQDRIsehVr
         /uxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=m/xUKoMMzoI2WxKiDLTy5BlQHx454hHYAmDrgSdszz4=;
        b=cljRGoHqSAK4rqqHJCubkW06dWBOSN3iinE6/IiDHLQPPRePxIzvZXNyzbCwaVXluE
         XxPZw67KkVupIzYDoHCUDR7q/Imfffkfa7EvPNnZkL1slvHKa62w2aidW2O9gP8YZP+C
         WhXA4VhqKfpY9FbX4mmXa6NgjZROH2xN4bq4kGz08ck1CRaIT0T8Nu2nodeaaaUGSY7z
         2Tp9lZYv6YP0FBk9MiKUg/DaFRO68vtCzwHP7Z1PmbiBIc0zrMahR1eW5PU9OD6pvdGm
         vupr1fzjwfDraKVyNbnX/IhpnPi5zHNOpiNhxjSNEjyBlYQUOUk2Fl+2x/uenDmWs6xh
         BBag==
X-Gm-Message-State: AOAM531xtnD1LIvR0RxRve1HxWCsdEkg5Rt/bqaLYJu9aBv4aE+d+QNr
        nariFMO2PAaqVb/fKuwjVfQvqGwHgDg=
X-Google-Smtp-Source: ABdhPJxkDnhhg+b2l8X0Gm+dG9hSq7qQakd7FrPeDJCClQv9uvLD8DFtlikQV7UFfMAs7WYIvybLZg==
X-Received: by 2002:a62:3814:: with SMTP id f20mr4596763pfa.278.1595517304219;
        Thu, 23 Jul 2020 08:15:04 -0700 (PDT)
Received: from [10.75.201.17] ([118.201.220.138])
        by smtp.gmail.com with ESMTPSA id c134sm3393016pfc.115.2020.07.23.08.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 08:15:03 -0700 (PDT)
Subject: Re: FW: [PATCH for-next] RDMA/rxe: Remove pkey table
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kamal Heib <kamalheib1@gmail.com>,
        Yanjun Zhu <yanjunz@mellanox.com>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
References: <20200721101618.686110-1-kamalheib1@gmail.com>
 <AM6PR05MB6263CFB337190B1740CDF4B7D8780@AM6PR05MB6263.eurprd05.prod.outlook.com>
 <CAD=hENePPVzfaC_YtCL1izsFSi+U_T=0m18MujARznsWbj=q5g@mail.gmail.com>
 <20200723055723.GA828525@kheib-workstation>
 <7a6d602f-1adc-cc36-5a11-e0beb6e31cec@gmail.com>
 <20200723072546.GA835185@kheib-workstation>
 <81816c7d-9b14-98de-c6ee-0a6b4a43a060@gmail.com>
 <20200723131549.GM25301@ziepe.ca>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Message-ID: <4796e70a-ca67-2d48-fdd8-e5593474d204@gmail.com>
Date:   Thu, 23 Jul 2020 23:15:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20200723131549.GM25301@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/23/2020 9:15 PM, Jason Gunthorpe wrote:
> On Thu, Jul 23, 2020 at 09:08:39PM +0800, Zhu Yanjun wrote:
>> On 7/23/2020 3:25 PM, Kamal Heib wrote:
>>> On Thu, Jul 23, 2020 at 02:58:41PM +0800, Zhu Yanjun wrote:
>>>> On 7/23/2020 1:57 PM, Kamal Heib wrote:
>>>>> On Wed, Jul 22, 2020 at 10:09:04AM +0800, Zhu Yanjun wrote:
>>>>>> On Tue, Jul 21, 2020 at 7:28 PM Yanjun Zhu <yanjunz@mellanox.com> wrote:
>>>>>>> From: Kamal Heib <kamalheib1@gmail.com>
>>>>>>> Sent: Tuesday, July 21, 2020 6:16 PM
>>>>>>> To: linux-rdma@vger.kernel.org
>>>>>>> Cc: Yanjun Zhu <yanjunz@mellanox.com>; Doug Ledford <dledford@redhat.com>; Jason Gunthorpe <jgg@ziepe.ca>; Kamal Heib <kamalheib1@gmail.com>
>>>>>>> Subject: [PATCH for-next] RDMA/rxe: Remove pkey table
>>>>>>>
>>>>>>> The RoCE spec require from RoCE devices to support only the defualt pkey, While the rxe driver maintain a 64 enties pkey table and use only the first entry. With that said remove the maintaing of the pkey table and used the default pkey when needed.
>>>>>>>
>>>>>> Hi Kamal
>>>>>>
>>>>>> After this patch is applied, do you make tests with SoftRoCE and mlx hardware?
>>>>>>
>>>>>> The SoftRoCE should work well with the mlx hardware.
>>>>>>
>>>>>> Zhu Yanjun
>>>>>>
>>>>> Hi Zhu,
>>>>>
>>>>> Yes, please see below:
>>>>>
>>>>> $ ibv_rc_pingpong -d mlx5_0 -g 11
>>>>>      local address:  LID 0x0000, QPN 0x0000e3, PSN 0x728a4f, GID ::ffff:172.31.40.121
>>>> Can you make tests with GSI QP?
>>>>
>>>> Zhu Yanjun
>>>>
>> Is this the GSI ?
>>
>> Please check GSI in "InfiniBandTM Architecture Specification Volume 1
>> Release 1.3"
>>
>> Then make tests with GSI again.

The followings are also removed by this commit. Not sure if it is good.

"

C9-42: If the destination QP is QP1, the BTH:P_Key shall be compared to 
the set of P_Keys associated with the port on which the packet arrived. 
If the P_Key matches any of the keys associated with the port, it shall 
be considered valid.

"

> rping uses RDMA CM which goes over the GSI
>
> Jason


