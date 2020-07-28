Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D4D230B53
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jul 2020 15:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgG1NVM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jul 2020 09:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729673AbgG1NVL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jul 2020 09:21:11 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585FDC061794
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jul 2020 06:21:11 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d1so9881416plr.8
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jul 2020 06:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=i7+nl4fWWjKjMqiJ184gUY88RikC6HngQbLWNCEp4Lc=;
        b=f+ceiDShpM4OkIqBxfY0LEi6dk58BpyvDU9TmAGVC4PETjt5di6UhSsswYTxGJEENB
         gTi/zq3qe+KGHL29i+ngLCK3NZ+M7cG7TMrARkIQCcAnXZxEJHNYTy0pQPsHu/GB3zLs
         Vd/KT5STkqgdIYK3pmbs3LGw2Er29vgK1E6xkUut/u8x/zuFvXJzFi5q60NQuW33MRTV
         jgWn9ZADJvipn78c1A5b2MuWuBoRO5JClQXyAhNa5KR/riIRN/erg4rYSJfBJNHUWR8Y
         w9SuvSNTL77ucfwg/MMeXmRMxl4gt8RKoIfglOnyeP7W+9Cx2soPg8lCrBXz3FH4QsD3
         vq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=i7+nl4fWWjKjMqiJ184gUY88RikC6HngQbLWNCEp4Lc=;
        b=k+1oUY8jju/65qv1VsVoUi4SFa5dDWiUgAXnjvR852YP4SomoheICWZ//774gMArZ1
         rz7AKqfWPcbEY+5yLpNuk5LIwTa7coFgQ1A0Y/2b5MJrhy8kya/rnm5dm4mL8GIP8zmJ
         /iN+WT11CGTZJ4+9XXQE0jCAvRonnHAR2VsTewMzk2Uvr4YW+DKZ8QxL3K1qjNF9jwsh
         ivmNwKOiFklJlA5Cxc3U5QR/6vrau421P56bTKYgXhF4sU9PsqQWi28ZfKi0xThKRaQu
         nKJv1xn+wKu64BiAzCi+xBNx6+CoESwAxze5DmtTzjP5J24gPiJNihE/Hqu+grcM4wL0
         a8CQ==
X-Gm-Message-State: AOAM532Y1syaMVCwhm0O/uYW/0M2ZAmspXRUKRu98gmLapBPZReBL08y
        QO6HTwRDcjRKSqqtZaCInMppwkMb
X-Google-Smtp-Source: ABdhPJz6KFEzCjJekqBNqs70Vtc1Qi8dEUOLy4aL1+EKv1ZAfH+hvHkdHBdyGj99UJkm2lETSZPoUw==
X-Received: by 2002:a17:90a:6509:: with SMTP id i9mr4578852pjj.104.1595942470821;
        Tue, 28 Jul 2020 06:21:10 -0700 (PDT)
Received: from [10.75.201.17] ([118.201.220.138])
        by smtp.gmail.com with ESMTPSA id r191sm19380191pfr.181.2020.07.28.06.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 06:21:10 -0700 (PDT)
Subject: Re: FW: [PATCH for-next] RDMA/rxe: Remove pkey table
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Yanjun Zhu <yanjunz@mellanox.com>,
        linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
References: <20200721101618.686110-1-kamalheib1@gmail.com>
 <AM6PR05MB6263CFB337190B1740CDF4B7D8780@AM6PR05MB6263.eurprd05.prod.outlook.com>
 <CAD=hENePPVzfaC_YtCL1izsFSi+U_T=0m18MujARznsWbj=q5g@mail.gmail.com>
 <20200723055723.GA828525@kheib-workstation>
 <7a6d602f-1adc-cc36-5a11-e0beb6e31cec@gmail.com>
 <20200723072546.GA835185@kheib-workstation>
 <81816c7d-9b14-98de-c6ee-0a6b4a43a060@gmail.com>
 <20200723131549.GM25301@ziepe.ca>
 <4796e70a-ca67-2d48-fdd8-e5593474d204@gmail.com>
 <20200728083557.GA73564@kheib-workstation>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Message-ID: <9a6f21eb-a9c7-ed77-31b3-f9befa5a49b0@gmail.com>
Date:   Tue, 28 Jul 2020 21:21:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20200728083557.GA73564@kheib-workstation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/28/2020 4:35 PM, Kamal Heib wrote:
> On Thu, Jul 23, 2020 at 11:15:00PM +0800, Zhu Yanjun wrote:
>> On 7/23/2020 9:15 PM, Jason Gunthorpe wrote:
>>> On Thu, Jul 23, 2020 at 09:08:39PM +0800, Zhu Yanjun wrote:
>>>> On 7/23/2020 3:25 PM, Kamal Heib wrote:
>>>>> On Thu, Jul 23, 2020 at 02:58:41PM +0800, Zhu Yanjun wrote:
>>>>>> On 7/23/2020 1:57 PM, Kamal Heib wrote:
>>>>>>> On Wed, Jul 22, 2020 at 10:09:04AM +0800, Zhu Yanjun wrote:
>>>>>>>> On Tue, Jul 21, 2020 at 7:28 PM Yanjun Zhu <yanjunz@mellanox.com> wrote:
>>>>>>>>> From: Kamal Heib <kamalheib1@gmail.com>
>>>>>>>>> Sent: Tuesday, July 21, 2020 6:16 PM
>>>>>>>>> To: linux-rdma@vger.kernel.org
>>>>>>>>> Cc: Yanjun Zhu <yanjunz@mellanox.com>; Doug Ledford <dledford@redhat.com>; Jason Gunthorpe <jgg@ziepe.ca>; Kamal Heib <kamalheib1@gmail.com>
>>>>>>>>> Subject: [PATCH for-next] RDMA/rxe: Remove pkey table
>>>>>>>>>
>>>>>>>>> The RoCE spec require from RoCE devices to support only the defualt pkey, While the rxe driver maintain a 64 enties pkey table and use only the first entry. With that said remove the maintaing of the pkey table and used the default pkey when needed.
>>>>>>>>>
>>>>>>>> Hi Kamal
>>>>>>>>
>>>>>>>> After this patch is applied, do you make tests with SoftRoCE and mlx hardware?
>>>>>>>>
>>>>>>>> The SoftRoCE should work well with the mlx hardware.
>>>>>>>>
>>>>>>>> Zhu Yanjun
>>>>>>>>
>>>>>>> Hi Zhu,
>>>>>>>
>>>>>>> Yes, please see below:
>>>>>>>
>>>>>>> $ ibv_rc_pingpong -d mlx5_0 -g 11
>>>>>>>       local address:  LID 0x0000, QPN 0x0000e3, PSN 0x728a4f, GID ::ffff:172.31.40.121
>>>>>> Can you make tests with GSI QP?
>>>>>>
>>>>>> Zhu Yanjun
>>>>>>
>>>> Is this the GSI ?
>>>>
>>>> Please check GSI in "InfiniBandTM Architecture Specification Volume 1
>>>> Release 1.3"
>>>>
>>>> Then make tests with GSI again.
>> The followings are also removed by this commit. Not sure if it is good.
>>
>> "
>>
>> C9-42: If the destination QP is QP1, the BTH:P_Key shall be compared to the
>> set of P_Keys associated with the port on which the packet arrived. If the
>> P_Key matches any of the keys associated with the port, it shall be
>> considered valid.
>>
>> "
>>
> The above is correct for ports that configured to work in InfiniBand
> mode, while in RoCEv2 mode only the default P_Key should be associated
> with the port (Please see below from "ANNEX A17:   ROCEV2 (IP ROUTABLE
> ROCE)):
>
> """
> 17.7.1 LOADING THE P_KEY TABLE
>
> Compliance statement C17-7: on page 1193 describes requirements for
> setting the P_Key table based on an assumption that the P_Key table is
> set directly by a Subnet Manager. However, RoCEv2 ports do not support
> InfiniBand Subnet Management. Therefore, compliance statement C17-7:
> on page 1193 does not apply to RoCEv2 ports.

"

C17-7: An HCA shall require no OS involvement to set the P_Key table;

the P_Key table shall be set directly by Subnet Manager MADs.

"

In SoftRoCE, what set the P_Key table?

>
> Methods for setting the P_Key table associated with a RoCEv2 port are
> not defined in this specification, except for the requirements for a
> default P_Key described elsewhere in this annex.
> """
>
> Thanks,
> Kamal
>
>
>>> rping uses RDMA CM which goes over the GSI
>>>
>>> Jason
>>

