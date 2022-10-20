Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341CD606198
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Oct 2022 15:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiJTN0f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Oct 2022 09:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiJTN0Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Oct 2022 09:26:24 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4485147D2A
        for <linux-rdma@vger.kernel.org>; Thu, 20 Oct 2022 06:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1666272358; i=@fujitsu.com;
        bh=AihSczzb2cz6quFpq7zcAAd1UwgKnREU/NNA/HyB5S4=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=pflol9zzskUngDp6/EXi5v7PflozJ7xIy3xLt0Z+x+1U8I8tXrfOYsr0/HMIXeDD3
         3faZ7XR6wM6PPN4cM/8voRGqazxG4KVjJbTRC2x0VUPL2BH9eOn7FEXgqcYZhVo3S/
         OauQ+8bPJm9CZKONlHq/ACu9o1iKIza3HHNfw2fxDTEwshTajOfuPYLANKV1Sswe5y
         SH8Da2n4yTGPClqKT9troB+3ZH/+1+LqxXgW+9lO/n62AEv8Hq6cW4XnNY2nQFPztV
         oAckeBgN0WxB8Nh61Os/WwVROdPee9tMqnVX4NlV/lyh9zjRmj8HALyfNK0Eduvf7L
         +093vFqv+zsLA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileJIrShJLcpLzFFi42Kxs+HYrJviE5h
  ssOqduMWVf3sYLab8Wsps8exQL4vFl6nTmC3OH+tnd2D12DnrLrvHplWdbB69ze/YPD5vkgtg
  iWLNzEvKr0hgzVj1/x5bwQ7miln3OlgaGO8wdTFycQgJbGCUWP7iLAuEs5hJ4u2GN2wQzjZGi
  TsvzwI5nBy8AnYSP5ZvYwWxWQRUJdb/bGOGiAtKnJz5hAXEFhVIkri64S5YjbBAoMS1WTPAbB
  EBFYkTJ86wgwxlFvjGKDH9/nR2iA3XGSUOT+wHm8Qm4Cgxb9ZGsG2cAloS/d+vgtnMAhYSi98
  cZIew5SW2v50DVi8hoCjRtuQfO4RdITFrVhsThK0mcfXcJuYJjEKzkBw4C8moWUhGLWBkXsVo
  WpxaVJZapGuol1SUmZ5RkpuYmaOXWKWbqJdaqlueWlwClEksL9ZLLS7WK67MTc5J0ctLLdnEC
  IyalGJ21h2ML5b80TvEKMnBpCTKK6wamCzEl5SfUpmRWJwRX1Sak1p8iFGGg0NJgveFB1BOsC
  g1PbUiLTMHGMEwaQkOHiURXmZnoDRvcUFibnFmOkTqFKOilDivpjtQQgAkkVGaB9cGSxqXGGW
  lhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnzzvAEmsKTmVcCN/0V0GImoMWmW/xAFpckIqSkGpi8
  FJ92S4nlmUw/aljQv/6oRlRhucinv7M0NlUt27O65UT7seKU17EJ2xmrZvz6yux20GG7mpZ8E
  K9nmpm17bq1J5/+e/thp6HS+bZ1ecsPv3sfl2a48Rg3w7ZdIcdMss9qxhdn6NwpqvZ5KPmsyZ
  GZ+Xhe43O2b6mSH0QfPpD9Gd4kwPD9676/704mFMvdFk17dPSx5cnd02+lOIt+Wv1wyTI1c+E
  2Rkc3jZLHUpP6JO54ebx1unNh8yJFc/9Tqg9XtZ1k8Hpx2fz6sVXp5x4t2K2cyTph/aZdzxtF
  RO+yKVjOmRw7oblIikPia4fVqa+PpdfYM0zb8PK700/3KaaLmFheHhbYf27LEV4Wq1n7lFiKM
  xINtZiLihMBBqFI3JUDAAA=
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-19.tower-591.messagelabs.com!1666272356!74864!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15095 invoked from network); 20 Oct 2022 13:25:56 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-19.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 20 Oct 2022 13:25:56 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id ECB8F7B;
        Thu, 20 Oct 2022 14:25:55 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id E007A73;
        Thu, 20 Oct 2022 14:25:55 +0100 (BST)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 20 Oct 2022 14:25:53 +0100
Message-ID: <ae0ec888-a509-5e79-2449-69a379d6dc16@fujitsu.com>
Date:   Thu, 20 Oct 2022 21:25:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH v5 1/2] RDMA/rxe: Support RDMA Atomic Write
 operation
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
References: <20220708040228.6703-1-yangx.jy@fujitsu.com>
 <20220708040228.6703-2-yangx.jy@fujitsu.com> <Yy4xrlC2lt156nsV@nvidia.com>
 <6a04efb6-84e5-c7b7-25f1-843fa8122875@fujitsu.com>
 <Y0mHslo8ytQNnJ87@nvidia.com>
From:   =?UTF-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
In-Reply-To: <Y0mHslo8ytQNnJ87@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/10/15 0:00, Jason Gunthorpe wrote:
> People have been thinking of new uses for kmap, rxe still should be
> calling it.

Hi Jason,

Thanks a lot for your reply.
Could you tell me what is the new usage about kmap()?

> 
> The above just explains why it doesn't fail today, it doesn't excuse
> the wrong usage.

I wonder why we need to use kmap() in this case?
I'm sorry to ask the stupid question.

Best Regards,
Xiao Yang
> 
> Jason
