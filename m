Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7255A743C
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 05:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiHaDDl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Aug 2022 23:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbiHaDDe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Aug 2022 23:03:34 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7896BAEDB5;
        Tue, 30 Aug 2022 20:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1661915010; i=@fujitsu.com;
        bh=nFNoA3Xkt/aHRoPzDLem6pteL3AlAhYsHZ805T6Ourc=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=efjX4WUGyJ+zUGr92iHiZgJI+pFVUthfSKays5H3iWn8dWlRlHTBlFl9RacbONR8F
         XV/vfu281MpGEjqFYpDems9w5v0wQ22SOG0xKHFkLEbXYE3cSHm8gD7NiQLB/jB3br
         Z0hlhpNaEQ3hI3BbV1yrBXRGyei6OxGwWtWRGuGzcf2SSLKlMfYNhNwZV1OuJHFVK1
         d0exb8IiFptQZdzfVr5FNB8I77ZP/Ysk4oIRQx1l6ixgb7I1zbb8hUUqU4X17gjFEK
         RYh1ehiEtBYqJV9xoZZJJ4KYK2JWvYqIysuLHTxYmifNTY0ynq5mdZbPfmXc8VBYhY
         /hOzq90uRyQ4A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRWlGSWpSXmKPExsViZ8OxWbfxPF+
  ywbJrghbTPvxktrjybw+jxZRfS5ktLu+aw2bx7FAviwOrx+Ur3h6bVnWyefQ2v2Pz+LxJLoAl
  ijUzLym/IoE14/Ufn4Jr7BX9f5sYGxhfsnYxcnEICWxklJh5YiozhLOESeLTzrNQznZGiY57h
  9i6GDk5eAXsJLZtmcoOYrMIqEpsWn8AKi4ocXLmExYQW1QgQuLho0lgtrCAj8Sd58/A6pkFxC
  VuPZnPBDJURGALo8T+NW2MEIlaicbTH9ghti1klOjfsQism01AQ+Jey02wIk4Be4lVfSegGiw
  kFr85CDVVXqJ562xmEFtCQFHiSOdfoF4OILtS4sbjVIiwmsTVc5uYJzAKz0Jy6ywkN81CMnUW
  kqkLGFlWMdomFWWmZ5TkJmbm6BoaGOgaGpoCaWNdI0MzvcQq3US91FLdvPyikgxdQ73E8mK91
  OJiveLK3OScFL281JJNjMB4SylOv7GDcde+X3qHGCU5mJREeX+t5EsW4kvKT6nMSCzOiC8qzU
  ktPsQow8GhJMEbfAYoJ1iUmp5akZaZA4x9mLQEB4+SCG/FQaA0b3FBYm5xZjpE6hSjopQ479l
  zQAkBkERGaR5cGyzdXGKUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzLv7FNAUnsy8Erjpr4AW
  MwEtfriEG2RxSSJCSqqBSYT/zt+1czvdUiwrpby69js+LLELPGab+nWR+c0trvd3/tb0Z/7wY
  tm2ntzi3+9ttz64kPazryBmLcP9qnyB5fsuzugJCb7vcuhZajo7a9Ip2SkaN98qHI5pmsUk9n
  TmPE7G6MhjW54EaHWUnuqxCDf/trdmnpjSUdGkUg/27eF/DujNuriUmy35SWzNs7UZYXl/Di4
  qUP8rq6m3yvf2pn1Ft52l1wV5XzpxfsvR8imndGY9ar3vXKdk5RQYZrhl+073mb/79m9Vu3Zp
  z9SPPWa/A9ZKu5t9TTMq3aBUoTR9ZdYGybMdnw0veSY+feCzQz3g0rkGcXuTbcdkt1l4M7wqf
  FfsfOiE+PpH9XkZhUosxRmJhlrMRcWJALZQGbGyAwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-27.tower-745.messagelabs.com!1661915008!31372!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28432 invoked from network); 31 Aug 2022 03:03:29 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-27.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 31 Aug 2022 03:03:29 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id AFDFE142;
        Wed, 31 Aug 2022 04:03:28 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id A3B3973;
        Wed, 31 Aug 2022 04:03:28 +0100 (BST)
Received: from [10.167.226.45] (10.167.226.45) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 31 Aug 2022 04:03:25 +0100
Message-ID: <f05347d1-854c-4aa5-c937-71e7b36f234f@fujitsu.com>
Date:   Wed, 31 Aug 2022 11:02:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/srp: Set scmnd->result only when scmnd is not NULL
Content-Language: en-US
To:     =?UTF-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220831014730.17566-1-yangx.jy@fujitsu.com>
 <a66af10e-dea5-a9ec-5eeb-641b1d7ebeec@fujitsu.com>
 <e3488129-6681-55a7-3d1c-99a965a5c884@fujitsu.com>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <e3488129-6681-55a7-3d1c-99a965a5c884@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 31/08/2022 10:31, Yang, Xiao/杨 晓 wrote:
> On 2022/8/31 9:59, Li Zhijian wrote:
>> What i can see is that we have other places to de-reference scmnd and
>>
>> scmnd = srp_claim_req(ch, req, NULL, scmnd) is possible to return a NULL
>> to scmnd
> Hi,
>
> Thanks for your review.
>
> Yes, it seems better to just check scmnd before setting scmnd->result,
> like this:
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c
> b/drivers/infiniband/ulp/srp/ib_srp.c
> index 7720ea270ed8..99f5e7f852b3 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -1972,7 +1972,9 @@ static void srp_process_rsp(struct srp_rdma_ch
> *ch, struct srp_rsp *rsp)
>
>                           return;
>                   }
> -               scmnd->result = rsp->status;
> +
> +               if (scmnd)
> +                       scmnd->result = rsp->status;
Not really, i think you may need to return directly if !scmnd


>
> Best Regards,
> Xiao Yang

