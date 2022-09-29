Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20E25EED47
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Sep 2022 07:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbiI2FhB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Sep 2022 01:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbiI2Fgz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Sep 2022 01:36:55 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3914912B48B
        for <linux-rdma@vger.kernel.org>; Wed, 28 Sep 2022 22:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1664429812; i=@fujitsu.com;
        bh=cYVZk4fG4Kv8V41nOhysAqwI6yRlGfiyobuxNvkdkbk=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=bGH3euLlGWE8rzIy9i4Rfgtq7FR4S3SpM6keUJ1JbNC3o+2mAhwFXHEll7a2L6oVj
         eqiZabVPD9w3u7JNpnY2DKZGXVf6Ld6aGFD8dgAfQM8VwfHRmIYKMWYa0H3/CI/dwc
         Mbabf+JErMsjNWRpPIzJzd8xC+sRf1tYHmJB2ukTJd4G4CAr4atYYDq9lBZYN96oEK
         zRRbQGB7CQkjQeP7lIxIDKrg+Xm+I9RVV4SWBpHTRJAjaGEMZVyeTRY1OunkhSlige
         1KqWBjKA2mheUGC5Qtox3g1UhcstHyYVrhOpFDhuiGjOj8BDom28iVnZ/ABMuTBcTE
         yTP0I0jAK6YxQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleJIrShJLcpLzFFi42Kxs+FI1P2sZ5p
  scL9FxWLmjBOMFlN+LWW2eHaol8Xiy9RpzBbnj/WzO7B67Jx1l91j06pONo/Pm+Q8tn6+zRLA
  EsWamZeUX5HAmnFwZRtbwUP2iqtXXjI2MG5n62Lk4hAS2MIoMfPVLVYIZzmTxLpzk5ghnG2ME
  svu7mTqYuTk4BWwk3gz/zsbiM0ioCqxZ+ouZoi4oMTJmU9YQGxRgSSJqxvusoLYwgKBEtdmzQ
  Cz2QQcJebN2gjWKyLgJtF1q4sRZAGzwBFGiem9vYwQ214zSsz99B5sG6eAvcSRx0vBNjALWEg
  sfnOQHcKWl2jeOhssLiGgKNG25B87hF0hMWtWGxOErSZx9dwm5gmMQrOQHDgLyahZSEYtYGRe
  xWiTVJSZnlGSm5iZo2toYKBraGiqa2mha2RsrJdYpZuol1qqm5dfVJKha6iXWF6sl1pcrFdcm
  Zuck6KXl1qyiREYQynFSS93MJ7f90vvEKMkB5OSKO8qBdNkIb6k/JTKjMTijPii0pzU4kOMMh
  wcShK8NzWBcoJFqempFWmZOcB4hklLcPAoifCeVANK8xYXJOYWZ6ZDpE4xKkqJ80ZoAyUEQBI
  ZpXlwbbAUcolRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMK8zyHaezLwSuOmvgBYzAS3+yGQM
  srgkESEl1cC0+ybXYQe97BsxX+25SxweaYff6pDetn/ruevL1nxueax597DzRabTAgnuMb/uF
  r7b77K//bxGxKU7B65d75ve+4xxctK1da43f2x8rd79l5tVpL/1R4tH8/91uz28duYmJ6mlMt
  7eJxAQGCp34N9M8a4ZvTmTuKf3SAXMWFkSOF972/tn6c4lXPN0PDanP1zvmLrx2Yp27bKvtx0
  lj2utulm9pdn85ULN+qkvdv7yLPV12el8K8vTf817A+Xs5qubJfY0MQvIMn4//qXs+zfZB8rZ
  vZ8uTMhfmhA7dX6R/mK7DV3x9550MDZdlmsp1P7uF/zs7MUjyfzTqk0fRpzZ58nlpaynzfqT1
  39+x5SHSizFGYmGWsxFxYkAjfd1cpwDAAA=
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-12.tower-732.messagelabs.com!1664429811!146989!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16630 invoked from network); 29 Sep 2022 05:36:51 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-12.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 29 Sep 2022 05:36:51 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 023A3100043;
        Thu, 29 Sep 2022 06:36:51 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id EA38810019A;
        Thu, 29 Sep 2022 06:36:50 +0100 (BST)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 29 Sep 2022 06:36:48 +0100
Message-ID: <54971511-321b-65a6-a0d1-bb99bb719663@fujitsu.com>
Date:   Thu, 29 Sep 2022 13:36:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH v5 1/2] RDMA/rxe: Support RDMA Atomic Write
 operation
From:   =?UTF-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Li Zhijian <lizhijian@fujitsu.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
References: <20220708040228.6703-1-yangx.jy@fujitsu.com>
 <20220708040228.6703-2-yangx.jy@fujitsu.com>
 <fb02de6c-a32b-654a-62b9-55f44ffaec30@fujitsu.com>
 <YzL3zOS3YxRvyYDF@ziepe.ca>
 <24380d05-1540-7420-dd64-d4b2b363ede0@fujitsu.com>
In-Reply-To: <24380d05-1540-7420-dd64-d4b2b363ede0@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2022/9/29 11:58, Yang, Xiao/杨 晓 wrote:
> On 2022/9/27 21:17, Jason Gunthorpe wrote:
>> On Tue, Sep 27, 2022 at 04:18:52PM +0800, Li Zhijian wrote:
>>> Hi Yang
>>>
>>> I wonder if you need to do something if a user register MR with
>>> ATOMIC_WRITE to non-rxe device, something like in my flush:
>>
>> This makes sense..
> 
> Hi Zhijian, Jason
> 
> Agreed. I will add the check in ib_check_mr_access().

Hi Zhijian, Jason,

Sorry for the rough reply.

After reading the IBTA Spec A19.4.5.3 again, it seems not suitable for 
Atomic Write to do the similar check in ib_check_mr_access().

Atomic Write uses the original IB_ACCESS_REMOTE_WRITE flag during memory 
registration. (In other words, it doesn't introduce a new 
IB_ACCESS_REMOTE_ATOMIC_WRITE flag)

In this case, we should not return -EINVAL when IB_ACCESS_REMOTE_WRITE 
is specified and ib_dev->attrs.device_cap_flags doesn't support 
IB_DEVICE_ATOMIC_WRITE.

Best Regards,
Xiao Yang

> 
> Best Regards,
> Xiao Yang
>>
>> Jason
