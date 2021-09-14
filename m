Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A4840B36F
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 17:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhINPtS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 11:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbhINPtR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Sep 2021 11:49:17 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF1EC061574
        for <linux-rdma@vger.kernel.org>; Tue, 14 Sep 2021 08:48:00 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id s20so19619171oiw.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 Sep 2021 08:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=e2onn/tI/TR+yIVPcU2S9Pqa5ufy5oRLq26S0HPjjYk=;
        b=Z+HiFSVWvP7qIEiQd/BryIfZQyKL2fN+5dCmXMsXFY7xgaOzA2dtMubIl/v9bRlrSy
         vaTxAsFPFOsdwsvu6t4iv4dNCIpRqUPnpttj0TYfzm7TgOSBmgZyvz8TnXxxgVLcKVp4
         eYWUvR/Wj2jmK3hEmISSnsDEKPmwjPgsiAFdQ3q3z8tN4jtcbmQrxdAONUZwTEPZWJ2E
         ocyefBsIHbSX+3qyZoCwOuC+/FNhJPpkg+s5hSn4P2PxGSr9WTU6ZwS3LMYX1pAgMIya
         xRVtrikTdBjQsRpo99tKiT+x3EVgPGF8AFygIL9V/58Zt4TN8o6WRWD4L3feQ5sNLl9x
         4JaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e2onn/tI/TR+yIVPcU2S9Pqa5ufy5oRLq26S0HPjjYk=;
        b=EXzdM4uz37F078NM+Vis1CcQ0pmeHr7Pnp3pCE0n1sJfrh8GDMHsE0uR5tlB3Bqfko
         iY5lMvL9MWL54Elmynyemoav47jscoG8/JHU1FGb7Kb8nQz5R2+11qbFBquBwO/cbzHq
         gBFHVtPj9AtbH1a4oA1ZtPjTQv8XhelmXYOwu/4UEp3OvyCq5E+InluCjn9GMiIfhoNt
         rT0ffDmFZkzzpwB1rceU0IBRmt47C6gKrrb3trE/hoXBek5w0WWjEPhD//oW6boFG2rL
         uILGtMgZ3XXcgFA/GEIabEHwcJ/Voc9MkkBdeAVBXF2+59+DOGDsQ3l8agZmOB2RsBL9
         f/rw==
X-Gm-Message-State: AOAM533PtPAGajI/sRuxudETPMMwa0XyzXW0PgKDY0W685UK/fC2EAv0
        Aq0TxJnB8N6t6Se1eSPPk5Y=
X-Google-Smtp-Source: ABdhPJzfjpr+L9mY7z6lki7M2oX9sMrUrLe/aPFxDFFBiZHpKgHcqOSrAIUdxthsVH3MG95J7XMkkg==
X-Received: by 2002:a05:6808:2084:: with SMTP id s4mr1968010oiw.31.1631634479716;
        Tue, 14 Sep 2021 08:47:59 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:d9f3:4e7a:72f1:83fe? (2603-8081-140c-1a00-d9f3-4e7a-72f1-83fe.res6.spectrum.com. [2603:8081:140c:1a00:d9f3:4e7a:72f1:83fe])
        by smtp.gmail.com with ESMTPSA id m62sm2730767otm.11.2021.09.14.08.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 08:47:59 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIGZvci1yYyB2MyAxLzZdIFJETUEvcnhl?=
 =?UTF-8?Q?=3a_Add_memory_barriers_to_kernel_queues?=
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "mie@igel.co.jp" <mie@igel.co.jp>,
        "bvanassche@acm.org" <bvanassche@acm.org>
References: <20210909204456.7476-1-rpearsonhpe@gmail.com>
 <20210909204456.7476-2-rpearsonhpe@gmail.com>
 <OS0PR01MB637135BAE66CD2DF3BDF6AE783DA9@OS0PR01MB6371.jpnprd01.prod.outlook.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <33765191-3b89-269e-c11c-08609f9c3e10@gmail.com>
Date:   Tue, 14 Sep 2021 10:47:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <OS0PR01MB637135BAE66CD2DF3BDF6AE783DA9@OS0PR01MB6371.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/14/21 1:04 AM, yangx.jy@fujitsu.com wrote:
> Hi Bob,
> 
> Why do you want to use FROM_CLIENT and TO_CLIENT suffix?
> It seems readable to use FROM_USER and TO_USER suffix (i.e. between user space and kernel space).
> 
> Best Regards,
> Xiao Yang
> 

The whole purpose of this patch is to extend the memory barriers to support
user <-> kernel *and* kernel <-> kernel. Changing the name made it clearer
that it's not just user space. It also made it easier to make sure I had
gotten all of them changed/looked at. Now that is done, if everyone wants it
back to USER I could be talked into it.

Bob
