Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B65B5EEC9D
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Sep 2022 05:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbiI2D6m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Sep 2022 23:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiI2D6l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Sep 2022 23:58:41 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F7BF161D
        for <linux-rdma@vger.kernel.org>; Wed, 28 Sep 2022 20:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1664423918; i=@fujitsu.com;
        bh=+28GmcJVGbkXm+Tio5MAZPTGif4bYVOcRvM2yuEgHxY=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=gxfZNwzWq/XtUI1ePnNyczFGM5guQE21W/wBaCfDHJvjXsDOHz1tQY4JW3iSBIvkG
         WaoZTsbGfzw0AEJ8i949qUBOSEp9Hy1zouvB6YnoeLf1Jqq71ChhVCssYH8c/Dnftj
         09RjfSXM93T7eqkipgyx75Dhpvpd+6m9LlR88uK2AlNRP9ZlSDEwq2zv4PU5RIjn9i
         KjClwvRRAHOJzTEzyRO1vLd3a4652NW30NhJ4bZFpn1i1L80QTpLJTfwSIr+lxBNHZ
         KxxenyFPq1eX2yEgRix0D6KWhM3k0k+5ZSwV+dvlBo56l7FEjwc+7tSrxdIVX1Crxz
         kfaPb4HpAWURg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleJIrShJLcpLzFFi42Kxs+FI0n0rbpp
  ssP6EssXMGScYLab8Wsps8exQL4vFl6nTmC3OH+tnd2D12DnrLrvHplWdbB6fN8l5bP18myWA
  JYo1My8pvyKBNePeyy7Ggv9MFed7rrE3MG5h6mLk5BAS2MgoseuPZhcjF5C9hEli84GFbBDON
  kaJJx+2s4BU8QrYSTxuPcsOYrMIqEqsmdPGDBEXlDg58wlYjahAksTVDXdZQWxhgUCJa7NmgN
  kiAm4SXbe6GEGGMgscYZSY3tvLCLFhO6NEw5y1bCBVbAKOEvNmbQSzOQU0JJbP2gp2H7OAhcT
  iNwfZIWx5ie1v54BtlhBQlGhb8o8dwq6QmDWrjQnCVpO4em4T8wRGoVlIDpyFZNQsJKMWMDKv
  YrRJKspMzyjJTczM0TU0MNA1NDTVtbQEUpZ6iVW6iXqppbp5+UUlGbqGeonlxXqpxcV6xZW5y
  TkpenmpJZsYgRGUUpxcvoNx+75feocYJTmYlER5WyaaJAvxJeWnVGYkFmfEF5XmpBYfYpTh4F
  CS4J3NZZosJFiUmp5akZaZA4xmmLQEB4+SCG+GKFCat7ggMbc4Mx0idYpRUUqc9xVIQgAkkVG
  aB9cGSyCXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnztoBM4cnMK4Gb/gpoMRPQ4o9MxiCL
  SxIRUlINTLNjwyNEH3UV/+u84n91YYLA7R/GV7eeEvpxXtd11kH5vGdzjn1ik1Xrk61gKLfVV
  3Bdd8No+3Rh1nbbA0/nCF+b++G/L0cAW/ldt0rHd09WrRJk9XXNXTbX93OG/0rbAxYzlBIma/
  qdme7waQuTEn8G44/9fi0aKmyMp5/cmq49d4aFi/vaozuLj/c16h/OXaLOz+/E0Jk82zw89dq
  zDvfLa6fxmjedKXup8U9C9FBeTZW4WPy15x77/v5tXbLNOPenmGzw9hImxgOG9wNXLYrgXzlh
  aUFazvkV7//JLOee+tb6s93WOynbI256rTWZ7TlJaO+h260Vr8Msw4T468Ij1jnd3a5uueWF9
  pFmSyWW4oxEQy3mouJEAA1hFVabAwAA
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-8.tower-732.messagelabs.com!1664423917!140663!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17317 invoked from network); 29 Sep 2022 03:58:37 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-8.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 29 Sep 2022 03:58:37 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id F3F761B0;
        Thu, 29 Sep 2022 04:58:36 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id E7D411AD;
        Thu, 29 Sep 2022 04:58:36 +0100 (BST)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 29 Sep 2022 04:58:33 +0100
Message-ID: <24380d05-1540-7420-dd64-d4b2b363ede0@fujitsu.com>
Date:   Thu, 29 Sep 2022 11:58:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH v5 1/2] RDMA/rxe: Support RDMA Atomic Write
 operation
To:     Jason Gunthorpe <jgg@ziepe.ca>, Li Zhijian <lizhijian@fujitsu.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
References: <20220708040228.6703-1-yangx.jy@fujitsu.com>
 <20220708040228.6703-2-yangx.jy@fujitsu.com>
 <fb02de6c-a32b-654a-62b9-55f44ffaec30@fujitsu.com>
 <YzL3zOS3YxRvyYDF@ziepe.ca>
From:   =?UTF-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
In-Reply-To: <YzL3zOS3YxRvyYDF@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/9/27 21:17, Jason Gunthorpe wrote:
> On Tue, Sep 27, 2022 at 04:18:52PM +0800, Li Zhijian wrote:
>> Hi Yang
>>
>> I wonder if you need to do something if a user register MR with
>> ATOMIC_WRITE to non-rxe device, something like in my flush:
> 
> This makes sense..

Hi Zhijian, Jason

Agreed. I will add the check in ib_check_mr_access().

Best Regards,
Xiao Yang
> 
> Jason
