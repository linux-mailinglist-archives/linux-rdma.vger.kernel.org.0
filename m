Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9734B0F99
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Feb 2022 15:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241098AbiBJOEd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Feb 2022 09:04:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240156AbiBJOEc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Feb 2022 09:04:32 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733F81B3
        for <linux-rdma@vger.kernel.org>; Thu, 10 Feb 2022 06:04:33 -0800 (PST)
Message-ID: <11e71fc4-6194-9290-df0e-f062af91cc8c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644501871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5z+lqkTF72U/0bw9QC9m1+PIzuMmVNJJmeFI04X6K+U=;
        b=TBplsLEyKWW4fjJ0xCnds3IKZlSWio6vzfvvESpm9WjJjs6G3tUGmGgW90+ZkcGUFEl47e
        rYcvdhp/sgoF3v2vqmFE7zoiYgLKjR3yf/qQaTa1ePQKTvpZZ3NSKisIxY5aYDwZyq6upH
        qfGmcpXiVqngdsHahHGevcpdB1krMho=
Date:   Thu, 10 Feb 2022 22:04:22 +0800
MIME-Version: 1.0
Subject: Re: Soft-RoCE performance
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Christian Blume <chr.blume@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <CAGP7Hd6PAYcX_gMMh8jbpezeSSWQxqDrYwxEq1N-zjgT7563+g@mail.gmail.com>
 <PH7PR84MB148872A4BB08EAFECCFF6B01BC2F9@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <PH7PR84MB148872A4BB08EAFECCFF6B01BC2F9@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/2/10 13:13, Pearson, Robert B 写道:
> Christian,
> 
> There are two key differences between TCP and soft RoCE. Most importantly TCP can use a 64KiB MTU which is fragmented by TSO or GSO if your NIC doesn't support TSO while soft RoCE is limited by the protocol to a 4KiB payload. With overhead for headers you need a link MTU of about 4096+256. If your application is going between soft RoCE and hard RoCE you have to live with this limit and compute ICRC on each packet. Checking is optional since RoCE packets have a crc32 checksum from ethernet. If you are using soft RoCE to soft RoCE you can ignore both ICRC calculations and with a patch increase the MTU above 4KiB. I have measured write performance up to around 35 GB/s 

Thanks, I have also reached the big bandwidth with the same methods.
How about latency of soft roce?

Zhu Yanjun


in local loopback on a single 12 core box (AMD 3900x) using 12 IO 
threads, 16KB MTU, and ICRC disabled for 1MB messages. This is on head 
of tree with some patches not yet upstream.
> 
> Bob Pearson
> rpearsonhpe@gmail.com
> rpearson@hpe.com
> 
> 
> -----Original Message-----
> From: Christian Blume <chr.blume@gmail.com>
> Sent: Wednesday, February 9, 2022 9:34 PM
> To: RDMA mailing list <linux-rdma@vger.kernel.org>
> Subject: Soft-RoCE performance
> 
> Hello!
> 
> I am seeing that Soft-RoCE has much lower throughput than TCP. Is that expected? If not, are there typical config parameters I can fiddle with?
> 
> When running iperf I am getting around 300MB/s whereas it's only around 100MB/s using ib_write_bw from perftests.
> 
> This is between two machines running Ubuntu20.04 with the 5.11 kernel.
> 
> Cheers,
> Christian

