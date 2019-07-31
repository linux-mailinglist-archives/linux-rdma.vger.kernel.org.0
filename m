Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4054E7BAF7
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 09:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfGaHx2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 03:53:28 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:44458 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfGaHx2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Jul 2019 03:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564559606; x=1596095606;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ja8qVM3npeWIpy5UiFFQuTHWBDjtQkKMOyscd2p3Q1E=;
  b=Oh6y4LvO5pkHSvchIJRMxo3mWsYK2BUw6py2ARYdb5ZvAG6eTYO1paea
   duk412IqawpBvq+QwbCztYaFIdpopomfq/qHjf36t23eOaQTaIJIpwuE5
   x8AJGi6Wa+4jKz9kkIX+ZPQqFlUxk0ySBMX+OhRGgpogGHad3PTc6SZrE
   U=;
X-IronPort-AV: E=Sophos;i="5.64,329,1559520000"; 
   d="scan'208";a="815218506"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 31 Jul 2019 07:53:20 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id 7DAB5A2711;
        Wed, 31 Jul 2019 07:53:19 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 31 Jul 2019 07:53:18 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.8) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 31 Jul 2019 07:53:15 +0000
Subject: Re: [PATCH for-rc] RDMA/restrack: Track driver QP types in resource
 tracker
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>
References: <20190730110137.37826-1-galpress@amazon.com>
 <20190730133817.GC4878@mtr-leonro.mtl.com>
 <24f4f7e3-dada-5185-3988-2e821b321bc1@amazon.com>
 <20190730151936.GE4878@mtr-leonro.mtl.com>
 <1a7f11e2-ae90-3173-b24a-aae11731cad1@amazon.com>
 <20190731074612.GM4878@mtr-leonro.mtl.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <ad37c9f9-2645-426c-32e1-bd63f462924c@amazon.com>
Date:   Wed, 31 Jul 2019 10:53:10 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731074612.GM4878@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.8]
X-ClientProxiedBy: EX13D06UWC004.ant.amazon.com (10.43.162.97) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 31/07/2019 10:46, Leon Romanovsky wrote:
> On Wed, Jul 31, 2019 at 10:05:31AM +0300, Gal Pressman wrote:
>> On 30/07/2019 18:19, Leon Romanovsky wrote:
>>> On Tue, Jul 30, 2019 at 04:49:52PM +0300, Gal Pressman wrote:
>>>> On 30/07/2019 16:38, Leon Romanovsky wrote:
>>>>> On Tue, Jul 30, 2019 at 02:01:37PM +0300, Gal Pressman wrote:
>>>>>> The check for QP type different than XRC has wrongly excluded driver QP
>>>>>> types from the resource tracker.
>>>>>>
>>>>>> Fixes: 78a0cd648a80 ("RDMA/core: Add resource tracking for create and destroy QPs")
>>>>>
>>>>> It is a little bit over to say "wrongly". At that time, we did it on purpose
>>>>> because it was unclear how to represent such QP types to users and we didn't
>>>>> have vendor specific hooks introduced by Steve later on.
>>>>
>>>> It's very confusing to see a test running and zero QPs in "rdma res".
>>>> I'm fine with removing the "wrongly" :), but I still think this should be
>>>> targeted to for-rc as a bug fix.
>>>
>>> Yes, please remove "wrongly" and change Fixes line to be
>>> "Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")",
>>> because before addition of EFA driver all other drivers had QPs.
>>
>> How are DC QPs being counted?
> 
> They were not counted on purpose. We didn't imagine acceptance of
> non-RDMA driver which doesn't support any standard QPs and doesn't
> work with kernel verbs.

Running dcping/perftest over DC shows zero QPs? On purpose?
Sounds like a bug to me..
