Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB974C0B40
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Feb 2022 05:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbiBWEno (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Feb 2022 23:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237886AbiBWEno (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Feb 2022 23:43:44 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F35A66AE9
        for <linux-rdma@vger.kernel.org>; Tue, 22 Feb 2022 20:43:17 -0800 (PST)
Subject: Re: bug report for rxe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1645591395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AHdUSkvRI3WVyveWp4jskJTj3UvHdvFbD3jmOkG2lzA=;
        b=O+EQVBxRN71UT+T4WTV920UjO4DthNNS5N0Bmm6m5bixX6pn2hO/fcN30jBMaLl9pSXU5i
        WiLqrYSKCJ72+HlTdH62w2WilXIvI+odKqsG4hSS+S4lf6iD7arJvn5m0SJy8mzkksAwt8
        maNXVWw1QsGxPdoBl/ALvmrVydv21Yc=
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jinpu Wang <jinpu.wang@ionos.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20220210073655.42281-1-guoqing.jiang@linux.dev>
 <473a53b6-9ab2-0d48-a9cf-c84b8dc4c3f3@linux.dev>
 <CAD=hENeU=cf4_AZPYBDke-kv3Lv3+AUkkEjZm4Drkc6YLJOeLQ@mail.gmail.com>
 <PH7PR84MB1488DB95EFB4F86FCDC7B8E6BC3B9@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <3b6ddb23-6dfa-29e2-27fd-741c1e3e576d@linux.dev>
Date:   Wed, 23 Feb 2022 12:43:08 +0800
MIME-Version: 1.0
In-Reply-To: <PH7PR84MB1488DB95EFB4F86FCDC7B8E6BC3B9@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/23/22 12:58 AM, Pearson, Robert B wrote:
>> After investigation, seems the culprit is commit 647bf13ce944 ("RDMA/rxe:
>> Create duplicate mapping tables for FMRs"). The problem is
>> mr_check_range returns -EFAULT after find iova and length are not
>> valid, so connection between two VMs can't be established.
>>
>> Revert the commit manually or apply below temporary change,  rxe works
>> again with rnbd/rtrs though I don't think it is the right thing to do.
>> Could experts provide a proper solution? Thanks.
>>
> This patch fixed failures in blktests and srp which were discussed at length. See e.g.
>
> https://lore.kernel.org/linux-rdma/20210907163939.GW1200268@ziepe.ca/

Thanks for the link, which reminds me the always_invalidate parameter in 
rtrs_server.

> and related messages. The conclusion was that two mappings were required. One owned by the
> driver and one by the 'hardware', i.e. bottom half in the rxe case, allowing updating a new mapping
> while the old one is still active and then switching them.
>
> If this case has iova and length not valid as indicated is there a problem with the test case?

And after disable always_invalidate (which is enabled by default), 
rnbd/rtrs over roce
works either. So I suppose there might be potential issue for 
always_invalidate=Y in
rtrs server side since invalidate works for srp IIUC, @Jinpu.

Thanks,
Guoqing
