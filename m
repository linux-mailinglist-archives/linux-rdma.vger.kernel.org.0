Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A248231665
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jul 2020 01:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbgG1Xpn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jul 2020 19:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgG1Xpm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jul 2020 19:45:42 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33B9C061794
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jul 2020 16:45:42 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p1so10923011pls.4
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jul 2020 16:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CHg+IVUKDNW3CLIFXb//B9BkeH9q3dTsPPvSD6yPD5w=;
        b=TUblmaaOZ2yc0KQMex2AGt5EUvurl8Gyqaj/jHX5CRprAAKP2n5LR1A0GVPa3PLQRc
         yAKEAfhAoaQa9DCIyAWoC/O2XTO5CA9htnZOrsf6q2P2HimU1IuDkAPrMCjlGyjZU8St
         8G1EZN+ubUqEjXtvYBEAjerZ8VW22Xjji+aeJidvScJtojMzJyjX4fcYiCzZQe/Icygi
         SCF9lvOfBtMT1Zj9UnFVt8NRKiPWjYOy1CkMGw/bN6Gd+yXqAC9Dg/oCVE405+R+AAsk
         1v4G17O2ko8ZkBaaFEQS2LpU1ss4UvYfR2KYwTFrqMN6nz5SMwb3tUnsH8kbRG4zpiq/
         En4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CHg+IVUKDNW3CLIFXb//B9BkeH9q3dTsPPvSD6yPD5w=;
        b=t6yPrjaYcpDQBhXgzuHNO82HMT82iblRbEbtX0kBsRMtivxrIe6QuMpA4gpB3ZEtkY
         3bL8QszujPhWkSi+DzDxw+FSrdWmqFRU7xyHH+OCt8Kf3Ol94rPNZk0Ja1aW9gNpYHTL
         LmUTdt4BRwc+lpVoa8eatNtVsUmayNSKR9rq79sMV0KknLXi3lrM2/94xF1cz9Tl4Hta
         Dqjyx/W2LD7SWv05jNCz3nkhMCbD8a6d6UYA7cvZKuomFJB3i1UlQR7M2mVY3kqbV9il
         QuVuwa/KIdt3eGG7GuJ0dmRR1uJAJBOvCv/JQ7QV8F02LE+ZT8UaOZc3LGOKtKWe6HQw
         wdIA==
X-Gm-Message-State: AOAM531edocSfYoKDDvqVcgc4PMhI1BNx2x5tBqOKd3NftZEzB0ceKsL
        t9HCaVQfyAw5JwTItSlKKUc=
X-Google-Smtp-Source: ABdhPJwAGW/GjI/DhhaQdT1CUbehE5ybGkhnpCTEght/4vORR8NVzxx/7a5ImXui7Tiux5XvRLlBfg==
X-Received: by 2002:a17:902:ed01:: with SMTP id b1mr3281778pld.335.1595979942401;
        Tue, 28 Jul 2020 16:45:42 -0700 (PDT)
Received: from [10.75.201.17] ([118.201.220.138])
        by smtp.gmail.com with ESMTPSA id 129sm150397pfv.161.2020.07.28.16.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 16:45:41 -0700 (PDT)
Subject: Re: FW: [PATCH for-next] RDMA/rxe: Remove pkey table
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Yanjun Zhu <yanjunz@mellanox.com>,
        linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
References: <20200723055723.GA828525@kheib-workstation>
 <7a6d602f-1adc-cc36-5a11-e0beb6e31cec@gmail.com>
 <20200723072546.GA835185@kheib-workstation>
 <81816c7d-9b14-98de-c6ee-0a6b4a43a060@gmail.com>
 <20200723131549.GM25301@ziepe.ca>
 <4796e70a-ca67-2d48-fdd8-e5593474d204@gmail.com>
 <20200728083557.GA73564@kheib-workstation>
 <9a6f21eb-a9c7-ed77-31b3-f9befa5a49b0@gmail.com>
 <20200728134442.GA29573@kheib-workstation>
 <93160a8d-fca7-defc-b39e-e6e5a97ddb87@gmail.com>
 <20200728174225.GA52282@kheib-workstation>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Message-ID: <b12cf75a-1459-bee9-8d38-19a73d048a62@gmail.com>
Date:   Wed, 29 Jul 2020 07:45:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20200728174225.GA52282@kheib-workstation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/29/2020 1:42 AM, Kamal Heib wrote:
> On Tue, Jul 28, 2020 at 11:46:36PM +0800, Zhu Yanjun wrote:
>> On 7/28/2020 9:44 PM, Kamal Heib wrote:
>>> On Tue, Jul 28, 2020 at 09:21:06PM +0800, Zhu Yanjun wrote:
>>>> On 7/28/2020 4:35 PM, Kamal Heib wrote:
>>>>> On Thu, Jul 23, 2020 at 11:15:00PM +0800, Zhu Yanjun wrote:
>>>>>> On 7/23/2020 9:15 PM, Jason Gunthorpe wrote:
>>>>>>> On Thu, Jul 23, 2020 at 09:08:39PM +0800, Zhu Yanjun wrote:
>>>>>>>> On 7/23/2020 3:25 PM, Kamal Heib wrote:
>>>>>>>>> On Thu, Jul 23, 2020 at 02:58:41PM +0800, Zhu Yanjun wrote:
>>>>>>>>>> On 7/23/2020 1:57 PM, Kamal Heib wrote:
>>>>>>>>>>> On Wed, Jul 22, 2020 at 10:09:04AM +0800, Zhu Yanjun wrote:
>>>>>>>>>>>> On Tue, Jul 21, 2020 at 7:28 PM Yanjun Zhu <yanjunz@mellanox.com> wrote:
>>>>>>>>>>>>> From: Kamal Heib <kamalheib1@gmail.com>
>>>>>>>>>>>>> Sent: Tuesday, July 21, 2020 6:16 PM
>>>>>>>>>>>>> To: linux-rdma@vger.kernel.org
>>>>>>>>>>>>> Cc: Yanjun Zhu <yanjunz@mellanox.com>; Doug Ledford <dledford@redhat.com>; Jason Gunthorpe <jgg@ziepe.ca>; Kamal Heib <kamalheib1@gmail.com>
>>>>>>>>>>>>> Subject: [PATCH for-next] RDMA/rxe: Remove pkey table
>>>>>>>>>>>>>
>>>>>>>>>>>>> The RoCE spec require from RoCE devices to support only the defualt pkey, While the rxe driver maintain a 64 enties pkey table and use only the first entry. With that said remove the maintaing of the pkey table and used the default pkey when needed.
>>>>>>>>>>>>>
>>>>>>>>>>>> Hi Kamal
>>>>>>>>>>>>
>>>>>>>>>>>> After this patch is applied, do you make tests with SoftRoCE and mlx hardware?
>>>>>>>>>>>>
>>>>>>>>>>>> The SoftRoCE should work well with the mlx hardware.
>>>>>>>>>>>>
>>>>>>>>>>>> Zhu Yanjun
>>>>>>>>>>>>
>>>>>>>>>>> Hi Zhu,
>>>>>>>>>>>
>>>>>>>>>>> Yes, please see below:
>>>>>>>>>>>
>>>>>>>>>>> $ ibv_rc_pingpong -d mlx5_0 -g 11
>>>>>>>>>>>         local address:  LID 0x0000, QPN 0x0000e3, PSN 0x728a4f, GID ::ffff:172.31.40.121
>>>>>>>>>> Can you make tests with GSI QP?
>>>>>>>>>>
>>>>>>>>>> Zhu Yanjun
>>>>>>>>>>
>>>>>>>> Is this the GSI ?
>>>>>>>>
>>>>>>>> Please check GSI in "InfiniBandTM Architecture Specification Volume 1
>>>>>>>> Release 1.3"
>>>>>>>>
>>>>>>>> Then make tests with GSI again.
>>>>>> The followings are also removed by this commit. Not sure if it is good.
>>>>>>
>>>>>> "
>>>>>>
>>>>>> C9-42: If the destination QP is QP1, the BTH:P_Key shall be compared to the
>>>>>> set of P_Keys associated with the port on which the packet arrived. If the
>>>>>> P_Key matches any of the keys associated with the port, it shall be
>>>>>> considered valid.
>>>>>>
>>>>>> "
>>>>>>
>>>>> The above is correct for ports that configured to work in InfiniBand
>>>>> mode, while in RoCEv2 mode only the default P_Key should be associated
>>>>> with the port (Please see below from "ANNEX A17:   ROCEV2 (IP ROUTABLE
>>>>> ROCE)):
>>>>>
>>>>> """
>>>>> 17.7.1 LOADING THE P_KEY TABLE
>>>>>
>>>>> Compliance statement C17-7: on page 1193 describes requirements for
>>>>> setting the P_Key table based on an assumption that the P_Key table is
>>>>> set directly by a Subnet Manager. However, RoCEv2 ports do not support
>>>>> InfiniBand Subnet Management. Therefore, compliance statement C17-7:
>>>>> on page 1193 does not apply to RoCEv2 ports.
>>>> "
>>>>
>>>> C17-7: An HCA shall require no OS involvement to set the P_Key table;
>>>>
>>>> the P_Key table shall be set directly by Subnet Manager MADs.
>>>>
>>>> "
>>>>
>>>> In SoftRoCE, what set the P_Key table?
>>>>
>>> No one is setting the P_Key table in SoftRoCE, and no subnet manager in
>>> the RoCE fabric.
>>>
>>> Could you please tell me what is wrong with this patch?
>> Please read the mail thread again.
>>
>> GSI QP number is 1. In your commits, the handle of qpn == 1 is removed.
>>
>> It seems that it conflicts with IB specification.
>>
>> Not sure if it is good.
>>
> Could you please read my patch again and point to what do you think is
> wrong?

What I said is very clear. Good luck

Zhu Yanjun

>
> What I did in this patch is to verify that the pkey value in the
> received packet is the default P_Key regardless of the qpn, because RoCE
> devices should maintain only the default P_Key.
>
> Thanks,
> Kamal
>
>>> Thanks,
>>> Kamal
>>>
>>>>> Methods for setting the P_Key table associated with a RoCEv2 port are
>>>>> not defined in this specification, except for the requirements for a
>>>>> default P_Key described elsewhere in this annex.
>>>>> """
>>>>>
>>>>> Thanks,
>>>>> Kamal
>>>>>
>>>>>
>>>>>>> rping uses RDMA CM which goes over the GSI
>>>>>>>
>>>>>>> Jason
>>

