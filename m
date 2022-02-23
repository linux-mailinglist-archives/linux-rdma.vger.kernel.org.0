Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E255E4C0C43
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Feb 2022 06:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237621AbiBWFv1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 00:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbiBWFv0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 00:51:26 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F7D443D4
        for <linux-rdma@vger.kernel.org>; Tue, 22 Feb 2022 21:50:58 -0800 (PST)
Subject: Re: bug report for rxe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1645595457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NPcPPnMudUDryLuzR5hRjC+/jlWixmOsXd1LDXJQqtM=;
        b=lbP1y4ux4+1hTJShd1nz292Xit67/TNiToZS7kD5Y+6WV/+z8wwPs4GZsZRA6aZz1c3c+n
        sCPnQurkT3pmQhb1A9mnbvLFvBGOIl9w2VdDMGa/cx2tA/3CjISr132fc+JTZUPCtnvdpR
        OSRgK4S41zkqZ9Elsc0FQEESfsSLhtQ=
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jinpu Wang <jinpu.wang@ionos.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20220210073655.42281-1-guoqing.jiang@linux.dev>
 <473a53b6-9ab2-0d48-a9cf-c84b8dc4c3f3@linux.dev>
 <CAD=hENeU=cf4_AZPYBDke-kv3Lv3+AUkkEjZm4Drkc6YLJOeLQ@mail.gmail.com>
 <PH7PR84MB1488DB95EFB4F86FCDC7B8E6BC3B9@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
 <3b6ddb23-6dfa-29e2-27fd-741c1e3e576d@linux.dev>
 <3ecd3493-662c-7c08-f2f2-59c1c97f8d59@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <bc952176-05e7-bb87-aee5-f4ec1fa25f41@linux.dev>
Date:   Wed, 23 Feb 2022 13:50:50 +0800
MIME-Version: 1.0
In-Reply-To: <3ecd3493-662c-7c08-f2f2-59c1c97f8d59@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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



On 2/23/22 1:01 PM, Bob Pearson wrote:
> On 2/22/22 22:43, Guoqing Jiang wrote:
>>
>> On 2/23/22 12:58 AM, Pearson, Robert B wrote:
>>>> After investigation, seems the culprit is commit 647bf13ce944 ("RDMA/rxe:
>>>> Create duplicate mapping tables for FMRs"). The problem is
>>>> mr_check_range returns -EFAULT after find iova and length are not
>>>> valid, so connection between two VMs can't be established.
>>>>
>>>> Revert the commit manually or apply below temporary change,  rxe works
>>>> again with rnbd/rtrs though I don't think it is the right thing to do.
>>>> Could experts provide a proper solution? Thanks.
>>>>
>>> This patch fixed failures in blktests and srp which were discussed at length. See e.g.
>>>
>>> https://lore.kernel.org/linux-rdma/20210907163939.GW1200268@ziepe.ca/
>> Thanks for the link, which reminds me the always_invalidate parameter in rtrs_server.
>>
>>> and related messages. The conclusion was that two mappings were required. One owned by the
>>> driver and one by the 'hardware', i.e. bottom half in the rxe case, allowing updating a new mapping
>>> while the old one is still active and then switching them.
>>>
>>> If this case has iova and length not valid as indicated is there a problem with the test case?
>> And after disable always_invalidate (which is enabled by default), rnbd/rtrs over roce
>> works either. So I suppose there might be potential issue for always_invalidate=Y in
>> rtrs server side since invalidate works for srp IIUC, @Jinpu.
>>
>> Thanks,
>> Guoqing
> It would help to understand what you are running. My main concern is that mr_check_range
> shouldn't fail unless there is something very wrong.

Let me paste it again, I just try to map server block device to client 
side, specifically the bold
line.

1.  VM (server)

modprobe rdma_rxe
rdma link add rxe0 type rxe netdev ens3
modprobe rnbd-server

2.  VM (client)

modprobe rdma_rxe
rdma link add rxe0 type rxe netdev ens3
modprobe rnbd-client
*echo "sessname=bla path=ip:$serverip 
device_path=$block_device_in_server" > 
/sys/devices/virtual/rnbd-client/ctl/map_device*



Thanks,
Guoqing

