Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE9055A7E7
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jun 2022 09:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiFYHsD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Jun 2022 03:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiFYHsC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 25 Jun 2022 03:48:02 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 497D4766B;
        Sat, 25 Jun 2022 00:48:01 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AOqzWBawl0SE/16uGJqt6t+ejxCrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApDJ202QEm2obDWDTa6uDZmCmctl/a4Xi8h5QsJbWytZlHQtv/xmBbVoQ9?=
 =?us-ascii?q?5OdWo7xwmQcns+qBpSaChohtq3yU/GYRCwPZiKa9kfF3oTJ9yEmj/nSHuOkUYY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWGULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIti?=
 =?us-ascii?q?j1LjmcEwWWaOUNg+L4pZUc/H6xEEc+WppieBmXBYfQR4/ZzGhm9FjyNRPtJW2Y?=
 =?us-ascii?q?Qk0PKzQg/lbWB5de817FfQcpe6dcSnh7KR/yGWDKRMA2c5GB0E7O4IJ/ftfBWB?=
 =?us-ascii?q?I6OxeITQMZBmJjqS9x7fTYvhlgMY+Ko/5PJ43vnBm0CGfAfs4KbjDSqzJ4tke1?=
 =?us-ascii?q?io/ic1mGuzXbM4ULzFoaXzoZxxJJ0dSC58kmuqsrmfwficeq1+Po6czpW/Jw2R?=
 =?us-ascii?q?Z1LnrLcqQYNCPTO1LkUuC4GHL5WL0BlcdLtP34TiK/Vq+h+LXkGXwUeov+BeQn?=
 =?us-ascii?q?hJxqATLgDVNV1tNDh3mycRVQ3WWA7p3Q3H4MAJ3xUTqyHGWcw=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AORbPwaC00HxatujlHemQ55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBLSC9F/b0qynAppomPGDP4gr5NEtApTniAtjkfZq/z+8X3WB5B97LMzUO01?=
 =?us-ascii?q?HYTr2Kg7GD/xTQXwX69sN4kZxrarVCDrTLZmRSvILX5xaZHr8brOW6zA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="125928965"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Jun 2022 15:47:59 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 2E1234D17168;
        Sat, 25 Jun 2022 15:47:58 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sat, 25 Jun 2022 15:47:58 +0800
Received: from [192.168.122.212] (10.167.226.45) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sat, 25 Jun 2022 15:47:58 +0800
Subject: Re: [PATCH v3 0/2] RDMA/rxe: Fix no completion event issue
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        Cheng Xu <chengyou@linux.alibaba.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220516015329.445474-1-lizhijian@fujitsu.com>
 <fa9863f0-d42e-f114-5321-108dda270e27@fujitsu.com>
 <20220624233953.GG23621@ziepe.ca>
From:   "Li, Zhijian" <lizhijian@fujitsu.com>
Message-ID: <9929cea8-df14-77f8-2686-94f851233782@fujitsu.com>
Date:   Sat, 25 Jun 2022 15:47:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20220624233953.GG23621@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-yoursite-MailScanner-ID: 2E1234D17168.AC392
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


on 6/25/2022 7:39 AM, Jason Gunthorpe wrote:
> On Tue, Jun 07, 2022 at 08:32:40AM +0000, lizhijian@fujitsu.com wrote:
>> Hi Json & Yanjun
>>
>>
>> I know there are still a few regressions on RXE, but i do wish you
>> could take some time to review these *simple and bugfix* patches
>> They are not related to the regressions.
> I would like someone familiar with rxe to ack the datapath changes

Thanks for your feedback

Haakon Bugge  had reviewed the datapath changes except the commit log in 
the V1 patches privately for some reasons weeks ago.

Hey Haakon, could you help to review these patches.


>   - I have a very limited knowledge about rxe.
>
> If that is not forthcoming from others in the rxe community then I
> will accept confirmation directly from you that the pyverbs tests and
> the blktests scenarios have been run and pass for your changes.

it's confirmed that pyverbs tests and nvme group with RXE of blktests 
have no regression after these changes

Thanks

Zhijian

>
> Jason


