Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3364754DA27
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jun 2022 08:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358256AbiFPGEk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jun 2022 02:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356373AbiFPGEk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jun 2022 02:04:40 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAE4C2B
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 23:04:39 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id z14so382020pgh.0
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 23:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=CGqisjGdwgw/bxxSG8Svv6xYCKud8n9PbyEf/Z0d1yY=;
        b=XqSG6Rg5sEFP4fNsKu77DkP5GFeEbnfdDm/UQUyb9dinBSV2wGB+L2aG2ZbEibgJgm
         fa/CO7iJxl7kfKyeW8QJqHBXBrnSy8FBIuk6bcXi7ugDxX8iwqNLp0VMmXu4UfaiFmqD
         mFvtdarZ6eztep2heXAOLX4Uq2ijPfIhthCrAj4fCNLZ/4ZIrEtTxCYJCgxYi0uRD35H
         yuGS35NrEP0Npx2MJC6OTF02GTwnHKJXbi1EgsZwdsWVMaZmChKz6oSB3QDs4A3AzOvX
         1M97XZHCH/j4uJtN9f7THBGpNe7I11lLWtKMlIqoHUIqOehtBdVdDjcKUc1OvFuPIhlB
         460w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=CGqisjGdwgw/bxxSG8Svv6xYCKud8n9PbyEf/Z0d1yY=;
        b=GV1Tjf70tyZEytUARdoglDcbRwzH8a17lBJycuBafvoMlNVFlcN0iK9LPr5kFZyKFt
         vUF0ugfTWvW/s+pbgS8wwJ3vX2FFDjce6dRnmCP1HgKC/0gZd1RvzdT0cJ1071pgTzLE
         06XpsKNSUOmDe4J3p+7yVzJKI0yNxilBzDDUqtXppDeepOXBPZ7JILkmG0cmledDljIV
         pfr6sejkb8Tvr3UM4ICPxpWdQpoDodkz0aEiOlBRVBqmVAdWeh8JOzqFUCtpcokT371H
         0IaYHnPWYxFpYmYwut8DylJcjVT7KqChmAStdd84UWMq8lJ6fUGDNp/XdlM1FqQJfoJp
         ECXw==
X-Gm-Message-State: AJIora9fsU3qCLCL+/QKwNsMFEG1FLhSK1N88+ZdZVmUSjJbTbb9UDEG
        tgVUc0uPJCCikfYbDuGxmnc=
X-Google-Smtp-Source: AGRyM1ubdSuHumxP+KpiI5D/eR7KtrQcpONWSvCIlpnjfW9628kjVvMap4mcnE6dSQfVeD0WrBT+zQ==
X-Received: by 2002:a63:5fc3:0:b0:3fd:f15d:5df6 with SMTP id t186-20020a635fc3000000b003fdf15d5df6mr2935363pgb.573.1655359479062;
        Wed, 15 Jun 2022 23:04:39 -0700 (PDT)
Received: from [0.0.0.0] ([2604:a840:3::501d])
        by smtp.gmail.com with ESMTPSA id p1-20020a170903248100b00163c6ac211fsm699311plw.111.2022.06.15.23.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 23:04:38 -0700 (PDT)
From:   Weihang Li <li.weihang93@gmail.com>
X-Google-Original-From: Weihang Li <Li.Weihang93@gmail.com>
Message-ID: <5621b204-6aba-fa0d-c8e7-eb6bc9ea9ac4@gmail.com>
Date:   Thu, 16 Jun 2022 14:04:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH for-next v11 08/11] RDMA/erdma: Add connection management
 (CM) support
Content-Language: en-US
To:     Cheng Xu <chengyou@linux.alibaba.com>, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com,
        tonylu@linux.alibaba.com, BMT@zurich.ibm.com,
        dan.carpenter@oracle.com
References: <20220615015227.65686-1-chengyou@linux.alibaba.com>
 <20220615015227.65686-9-chengyou@linux.alibaba.com>
 <0ae9926f-fa76-82ca-c218-c16ca0601ec2@gmail.com>
 <0542ee13-35bd-cadd-a6f3-cb62e7a1040a@linux.alibaba.com>
In-Reply-To: <0542ee13-35bd-cadd-a6f3-cb62e7a1040a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2022/6/16 11:35, Cheng Xu wrote:
> 
> 
> On 6/16/22 10:59 AM, Weihang Li wrote:
>>
> 
> <...>
>>
>> Hi, Cheng Xu
>>
>> After modify qp to RTS, is that means this TCP stream is offloaded
>> to the hardware, and the inbound TCP segments related to the TCP stream
>> will not be received in the kernel stack where this driver is running.
>> If yes, the ACK of mpa reply will never been revieced by the stack?
> 
> Actually, this depends on our infrastructure. ERDMA collaborates with
> OVS module, which indeed decides the direction of packets. It makes sure
> that packet from VM will be sent to VM, and packet from RDMA will be
> sent to RDMA engine. So, the ACK from VM will always be sent to VM.
> 
> Thanks,
> Cheng Xu
> 
> 

OK, thanks for your explanation :)

Weihang
