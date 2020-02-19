Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E010F16471D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 15:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgBSOgI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 09:36:08 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:6359 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgBSOgI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 09:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582122967; x=1613658967;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=U4Itg1zQSSKKkGlXvowm/SO5w3sG0Q/ehdfK+NfvOdY=;
  b=AkRPBfR4/IjTy0SAGkP4fjryISotKEudJAuHycFmlspoXQcjhsc63oSw
   EzUZvkg5iUVnd40AkyCnLS75x5jIp9pmQ5Au284Jmf5lXntogUrKGXQZ8
   n0NIzrIAZ/qpL55RYN6zOg0LcAosaP9VAyuRt851Ogsx1LcGe8cmkdptG
   s=;
IronPort-SDR: bTXKQ0aeAh7xfJHeQNjyyRZXCZf2PJdPW4aG80UqUrbQu4RBsCpiBN8NS+mHLh7MTVK1BoW4eO
 4VID/r+OYo2A==
X-IronPort-AV: E=Sophos;i="5.70,459,1574121600"; 
   d="scan'208";a="18577484"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 19 Feb 2020 14:35:54 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id 119CAA2B1E;
        Wed, 19 Feb 2020 14:35:52 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 19 Feb 2020 14:35:52 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.50) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 19 Feb 2020 14:35:45 +0000
Subject: Re: RDMA device renames and node description
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Honggang LI <honli@redhat.com>,
        Gal Pressman <galpress@amazon.com>
References: <5ae69feb-5543-b203-2f1b-df5fe3bdab2b@intel.com>
 <20200218140444.GB8816@unreal>
 <1fcc873b-3f67-2325-99cc-21d90edd2058@intel.com>
 <20200219071129.GD15239@unreal>
 <bea50739-918b-ae6f-5fac-f5642c56f1da@intel.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <67915d24-149a-e940-1f0b-a173eb4aca84@amazon.com>
Date:   Wed, 19 Feb 2020 16:35:40 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <bea50739-918b-ae6f-5fac-f5642c56f1da@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.50]
X-ClientProxiedBy: EX13D36UWA002.ant.amazon.com (10.43.160.24) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 19/02/2020 16:14, Dennis Dalessandro wrote:
> On 2/19/2020 2:11 AM, Leon Romanovsky wrote:
>> On Tue, Feb 18, 2020 at 12:11:47PM -0500, Dennis Dalessandro wrote:
>>> On 2/18/2020 9:04 AM, Leon Romanovsky wrote:
>>>> On Fri, Feb 14, 2020 at 01:13:53PM -0500, Dennis Dalessandro wrote:
>> ABI breakage is a strong word, luckily enough it is not defined at all.
>> We never considered dmesg prints, device names, device ordering as an
>> ABI. You can't rely on debug features too, they can disappear too.
> 
> Agree, it is a strong word and we can call it what you want. The point is you
> should be able to rely on the node description not being changed out from under
> you unnecessarily though. We aren't talking about a debug feature here but a
> core feature to real world deployments.
> 
> Could you envision a patch to a user space library that just changes a devices
> hostname to something that was HW specific because it makes scripting easier? I
> contend that in some cases the node description remaining constant is just as
> important.
> 
>> So the bottom line, the expectation that distro should fix all broken
>> software before enabling device renaming and their bugs are not excuse
>> to declare ABI breakage.
> 
> Again, call it what you want, but you can't deny this change to force the rename
> by default has not broken things. For the record I'm not even talking about PSM2
> here. There are other, more far reaching implications.

It's not just PSM2, it broke our libfabric provider and apparently MVAPICH as well:
http://mailman.cse.ohio-state.edu/pipermail/mvapich-discuss/2020-January/006960.html

Regarding the issue you described, why not disable the rename on the upgrade
path and only enable it for fresh installations?
