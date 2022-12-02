Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26E463FFDA
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Dec 2022 06:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbiLBFiO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Dec 2022 00:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiLBFiN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Dec 2022 00:38:13 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291C974CEE
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 21:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669959490; i=@fujitsu.com;
        bh=OtLPIWZEHRkfHfiAtAoWSGvT6ZWK0GjffQGqV6GTAw8=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=eBdluM8orbUwS1iCBiiJs5gCDG+1KbexvKWBVJyZ9t8UEYFP4iJWXBOWvBcRyGtp4
         uBTyk5IL95UTWfECCBSzy+naGXNifvrLpQWcGos8pLGkpLgcGSBHjy1VWHwiyRLaeH
         WZoBuuQ1tYMdWCqWNnZx6uDMOZplLSyGQl5tSPL24KBABcSANyPyAWIboZYj5S3lXw
         hf7oR63weJ4hWBSlfdeUfo6nZ9OR/B/CdgZ+ge7PJCSBaEtFR5Qj9G0fep0yWTu0Oj
         0ArxsM7Nj+8eP6pXCg5LChBSLSJ1ILjYnWUuvC79nmxT/YvP2NJAwAi7mkTBVNrhHg
         vKgj2JtBITHww==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleJIrShJLcpLzFFi42Kxs+FI1HXs70w
  26N6nYXHl3x5Giym/ljJbPDvUy2LxZeo0Zovzx/rZHVg9ds66y+6xaVUnm0dv8zs2j8+b5AJY
  olgz85LyKxJYM55+OcFWcJGtouXzccYGxhWsXYxcHEICWxglfjZvZOxi5ARyljNJzG6wg7C3M
  ko0feEAsXkF7CS6Zz1lB7FZBFQklh88wAgRF5Q4OfMJC4gtKpAkcXXDXVYQW1jAQeLJj2tgNS
  JA9SdOnGEHWcYsMIVRYl/TLmaIBQkSd09PALPZBNQkdk5/CTaIU0BL4s6cE2A2s4CFxOI3B9k
  hbHmJ7W/ngNVLCChKtC35xw5hV0jMmtXGBGGrSVw9t4l5AqPQLCT3zUIyahaSUQsYmVcxmhWn
  FpWlFukamuslFWWmZ5TkJmbm6CVW6SbqpZbqlqcWl+ga6SWWF+ulFhfrFVfmJuek6OWllmxiB
  EZMSrFiwg7GQ8v+6B1ilORgUhLlTe/uTBbiS8pPqcxILM6ILyrNSS0+xCjDwaEkwXu2BygnWJ
  SanlqRlpkDjF6YtAQHj5IIrxFIK29xQWJucWY6ROoUo6KUOO/iXqCEAEgiozQPrg2WMC4xyko
  J8zIyMDAI8RSkFuVmlqDKv2IU52BUEuaNBpnCk5lXAjf9FdBiJqDFkWJtIItLEhFSUg1M9S1F
  W+bMj+i5Pit9isNK9b1GX8P/PvtxnVV3rr589Z5LAvZawjMeKYn3TgzQOONzsfWh8i9p9Q0B1
  xTao3PibQ4n6ivPnS+XUHSRYfWEsgR1s+5srf/aLlsOfLSZpbHxif6Xf55/Jhp7sB/yFLko3P
  gvUrmdc9U8J26Xxd4Fzg3h1fv3ra95W8bfde1t1e4p7Pz/b3Q161oYO2SKV+y/llX/aOfWYsZ
  A97gol0qLqx+W28jXtv8uXdhpfPzXSY+byWp86jbvW4LfsGQo6IX6GAic1vi4WXsff8WaBfon
  v/zdeeBH3R3Z/p2/RPcHHn/A/WA3e28gy8NzSxdX59oFzjzmuIW399QdHW2VCj0lluKMREMt5
  qLiRAB4WOnKkwMAAA==
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-4.tower-548.messagelabs.com!1669959489!121758!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20731 invoked from network); 2 Dec 2022 05:38:09 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-4.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 Dec 2022 05:38:09 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 56F62100192;
        Fri,  2 Dec 2022 05:38:09 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 4A3C210018D;
        Fri,  2 Dec 2022 05:38:09 +0000 (GMT)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 2 Dec 2022 05:38:06 +0000
Message-ID: <949b84bf-b865-a407-b572-d9433082bec4@fujitsu.com>
Date:   Fri, 2 Dec 2022 13:37:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 0/8] RDMA/rxe: Add atomic write operation
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <rpearsonhpe@gmail.com>,
        <leon@kernel.org>, <lizhijian@fujitsu.com>, <y-goto@fujitsu.com>,
        <zyjzyj2000@gmail.com>
References: <1669905432-14-1-git-send-email-yangx.jy@fujitsu.com>
 <Y4k/DKgScOz9vpVc@nvidia.com>
From:   Xiao Yang <yangx.jy@fujitsu.com>
In-Reply-To: <Y4k/DKgScOz9vpVc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/12/2 7:55, Jason Gunthorpe wrote:
> On Thu, Dec 01, 2022 at 02:37:04PM +0000, Xiao Yang wrote:
> 
>> Xiao Yang (8):
>>    RDMA: Extend RDMA user ABI to support atomic write
>>    RDMA: Extend RDMA kernel ABI to support atomic write
>>    RDMA/rxe: Extend rxe user ABI to support atomic write
>>    RDMA/rxe: Extend rxe packet format to support atomic write
>>    RDMA/rxe: Make requester support atomic write on RC service
>>    RDMA/rxe: Make responder support atomic write on RC service
>>    RDMA/rxe: Implement atomic write completion
>>    RDMA/rxe: Enable atomic write capability for rxe device
> 
> Applied to for-next, thanks
> 
> Jason

Hi Jason,

Cool, Thank you very much for reviewing and applying the patch set.
Besides, I have removed the rdma_atomic_write example as you suggested 
on rdma-core repo.

Best Regards,
Xiao Yang
