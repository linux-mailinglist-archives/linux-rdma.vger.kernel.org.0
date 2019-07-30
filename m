Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52DC77AA20
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 15:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfG3NuK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 09:50:10 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:46509 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfG3NuK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Jul 2019 09:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564494610; x=1596030610;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=YR3VQdc0bl5NMD9dJwC9XTYKQL6oNnRiFIBOXkTIVAA=;
  b=DinUXmNOv2ka/MC0e30Wvas3CEAlHS92YG4xi7xp3TMIsxV02K838JBe
   5uItmESdi/BVBc/AQe8xwhjDQLCQ/nQSnOnSMNXAQDlkntyIDuxRPl1/Q
   vW53sjTviAsCqsGfYX3u6RoqLHecDKeH7ZW8gNpioYYSda/zZLwYeQf+0
   s=;
X-IronPort-AV: E=Sophos;i="5.64,326,1559520000"; 
   d="scan'208";a="814935609"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 30 Jul 2019 13:50:02 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id 3F31DA26D9;
        Tue, 30 Jul 2019 13:50:02 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Jul 2019 13:50:01 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.245) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Jul 2019 13:49:57 +0000
Subject: Re: [PATCH for-rc] RDMA/restrack: Track driver QP types in resource
 tracker
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>
References: <20190730110137.37826-1-galpress@amazon.com>
 <20190730133817.GC4878@mtr-leonro.mtl.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <24f4f7e3-dada-5185-3988-2e821b321bc1@amazon.com>
Date:   Tue, 30 Jul 2019 16:49:52 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730133817.GC4878@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.245]
X-ClientProxiedBy: EX13D23UWA003.ant.amazon.com (10.43.160.194) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 30/07/2019 16:38, Leon Romanovsky wrote:
> On Tue, Jul 30, 2019 at 02:01:37PM +0300, Gal Pressman wrote:
>> The check for QP type different than XRC has wrongly excluded driver QP
>> types from the resource tracker.
>>
>> Fixes: 78a0cd648a80 ("RDMA/core: Add resource tracking for create and destroy QPs")
> 
> It is a little bit over to say "wrongly". At that time, we did it on purpose
> because it was unclear how to represent such QP types to users and we didn't
> have vendor specific hooks introduced by Steve later on.

It's very confusing to see a test running and zero QPs in "rdma res".
I'm fine with removing the "wrongly" :), but I still think this should be
targeted to for-rc as a bug fix.

> 
> I would like to see the output or "rdma res" and "rdma res show qp" with
> running driver QP after your change.

gal@server [~] $ rdma res
0: efa_0: pd 2 cq 4 qp 2 cm_id 0 mr 2 ctx 2
gal@server [~] $ rdma res show qp
link efa_0/1 lqpn 0 type UNKNOWN state RTS sq-psn 13400680 pdn 0 pid 17847 comm ib_send_bw
link efa_0/1 lqpn 1 type UNKNOWN state RTR sq-psn 0 pdn 1 pid 17820 comm ib_send_bw

We can change the UNKNOWN to DRIVER/something else in userspace code.
