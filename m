Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6E9415ED8
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Sep 2021 14:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbhIWMxV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Sep 2021 08:53:21 -0400
Received: from smtp179.sjtu.edu.cn ([202.120.2.179]:56256 "EHLO
        smtp179.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240787AbhIWMxL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Sep 2021 08:53:11 -0400
Received: from mta04.sjtu.edu.cn (mta04.sjtu.edu.cn [202.121.179.8])
        by smtp179.sjtu.edu.cn (Postfix) with ESMTPS id 6AACD100B0956;
        Thu, 23 Sep 2021 20:51:37 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mta04.sjtu.edu.cn (Postfix) with ESMTP id 5032F185F5217;
        Thu, 23 Sep 2021 20:51:37 +0800 (CST)
X-Virus-Scanned: amavisd-new at mta04.sjtu.edu.cn
Received: from mta04.sjtu.edu.cn ([127.0.0.1])
        by localhost (mta04.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vJ3hqoUkK9xP; Thu, 23 Sep 2021 20:51:37 +0800 (CST)
Received: from mstore105.sjtu.edu.cn (unknown [10.118.0.105])
        by mta04.sjtu.edu.cn (Postfix) with ESMTP id 25B611804EE54;
        Thu, 23 Sep 2021 20:51:37 +0800 (CST)
Date:   Thu, 23 Sep 2021 20:51:37 +0800 (CST)
From:   =?gb2312?B?ufnWvg==?= <qtxuning1999@sjtu.edu.cn>
To:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        dledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2038588983.392567.1632401497054.JavaMail.zimbra@sjtu.edu.cn>
In-Reply-To: <CH0PR01MB71536ECA05AA44C4FAD83502F2A29@CH0PR01MB7153.prod.exchangelabs.com>
References: <20210922134857.619602-1-qtxuning1999@sjtu.edu.cn> <CH0PR01MB71536ECA05AA44C4FAD83502F2A29@CH0PR01MB7153.prod.exchangelabs.com>
Subject: Re: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.120.40.82]
X-Mailer: Zimbra 8.8.15_GA_4125 (ZimbraWebClient - GC92 (Linux)/8.8.15_GA_3928)
Thread-Topic: infiniband hfi1: fix misuse of %x in ipoib_tx.c
Thread-Index: AQHXr7imk55risfKAUmS2+aCDTMROauwTzmgxEEN6dM=
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I have tried using %px rather than %p. However when checking the new patch through scripts/checkpatch.pl, there is a warning: Using vsprintf specifier '%px' potentially exposes the kernel memory layout. 

Maybe %pK is the right one?

Thanks.

Guo

----- Original Message -----
From: "Mike Marciniszyn" <mike.marciniszyn@cornelisnetworks.com>
To: "Guo Zhi" <qtxuning1999@sjtu.edu.cn>, "Dennis Dalessandro" <dennis.dalessandro@cornelisnetworks.com>, "dledford" <dledford@redhat.com>
Cc: "linux-rdma" <linux-rdma@vger.kernel.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
Sent: Thursday, September 23, 2021 1:51:08 AM
Subject: RE: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c

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
