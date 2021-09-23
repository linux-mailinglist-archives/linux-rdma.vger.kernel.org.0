Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6702A41555A
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Sep 2021 04:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbhIWCF2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 22 Sep 2021 22:05:28 -0400
Received: from smtp179.sjtu.edu.cn ([202.120.2.179]:37220 "EHLO
        smtp179.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238884AbhIWCFX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Sep 2021 22:05:23 -0400
Received: from mta03.sjtu.edu.cn (mta03.sjtu.edu.cn [202.121.179.7])
        by smtp179.sjtu.edu.cn (Postfix) with ESMTPS id 8B372100B0959;
        Thu, 23 Sep 2021 10:03:49 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mta03.sjtu.edu.cn (Postfix) with ESMTP id 70848D6EFD;
        Thu, 23 Sep 2021 10:03:49 +0800 (CST)
X-Virus-Scanned: amavisd-new at mta03.sjtu.edu.cn
Received: from mta03.sjtu.edu.cn ([127.0.0.1])
        by localhost (mta03.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4C6s5MCwP_CS; Thu, 23 Sep 2021 10:03:49 +0800 (CST)
Received: from mstore105.sjtu.edu.cn (unknown [10.118.0.105])
        by mta03.sjtu.edu.cn (Postfix) with ESMTP id 529AAD6EF7;
        Thu, 23 Sep 2021 10:03:49 +0800 (CST)
Date:   Thu, 23 Sep 2021 10:03:49 +0800 (CST)
From:   =?gb2312?B?ufnWvg==?= <qtxuning1999@sjtu.edu.cn>
To:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <469291264.232666.1632362629275.JavaMail.zimbra@sjtu.edu.cn>
In-Reply-To: <CH0PR01MB71536ECA05AA44C4FAD83502F2A29@CH0PR01MB7153.prod.exchangelabs.com>
References: <20210922134857.619602-1-qtxuning1999@sjtu.edu.cn> <CH0PR01MB71536ECA05AA44C4FAD83502F2A29@CH0PR01MB7153.prod.exchangelabs.com>
Subject: Re: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [202.120.40.82]
X-Mailer: Zimbra 8.8.15_GA_4125 (ZimbraWebClient - GC92 (Linux)/8.8.15_GA_3928)
Thread-Topic: infiniband hfi1: fix misuse of %x in ipoib_tx.c
Thread-Index: AQHXr7imk55risfKAUmS2+aCDTMROauwTzmgJgnZbt8=
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I will change %p to %px and submit a new patch.

Thanks.

Guo

----- 原始邮件 -----
发件人: "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
收件人: "Guo Zhi" <qtxuning1999@sjtu.edu.cn>, "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>, dledford@redhat.com
抄送: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
发送时间: 星期四, 2021年 9 月 23日 上午 1:51:08
主题: RE: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c

> Subject: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
> 
> Pointers should be printed with %p or %px rather than cast to (unsigned long
> long) and printed with %llx.
> Change %llx to %p to print the pointer.
> 
> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>

The unsigned long long was originally used to insure the entire accurate pointer as emitted.

This is to ensure the pointers in prints and event traces match values in stacks and register dumps.

I think the %p will obfuscate the pointer so %px is correct for our use case.

Mike
