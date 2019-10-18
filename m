Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCD3CDD519
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Oct 2019 00:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389936AbfJRWu0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Oct 2019 18:50:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729622AbfJRWu0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Oct 2019 18:50:26 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 14166308A9E0;
        Fri, 18 Oct 2019 22:50:26 +0000 (UTC)
Received: from [10.3.117.75] (ovpn-117-75.phx2.redhat.com [10.3.117.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CBCC79AD;
        Fri, 18 Oct 2019 22:50:25 +0000 (UTC)
Subject: Re: [PATCH for-next] iw_cxgb3: remove iw_cxgb3 module from kernel.
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        linux-rdma@vger.kernel.org, nirranjan@chelsio.com
References: <20190930074252.20133-1-bharat@chelsio.com>
 <411c4ea1-4320-fa04-b014-7e5fe91869a8@redhat.com>
 <20191018204647.GA6087@ziepe.ca>
 <3b6fbc551c3a1c53e9365f6af5889ca38e141d3d.camel@redhat.com>
From:   Don Dutile <ddutile@redhat.com>
Message-ID: <aea0cf04-bcac-0422-f24a-0158aaac2537@redhat.com>
Date:   Fri, 18 Oct 2019 18:50:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3b6fbc551c3a1c53e9365f6af5889ca38e141d3d.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 18 Oct 2019 22:50:26 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/18/2019 04:51 PM, Doug Ledford wrote:
> On Fri, 2019-10-18 at 17:46 -0300, Jason Gunthorpe wrote:
>> On Wed, Oct 16, 2019 at 01:47:29PM -0400, Don Dutile wrote:
>>
>>> Isn't there a better way to mark a driver deprecated?
>>>
>>> This kind of removal makes long-term maintenance of such drivers
>>> painful in downstream distros, as API changes that are rippled from
>>> core through all the drivers, don't update these drivers, and when
>>> backporting such API changes to downstream distros, we have to +1
>>> removed drivers.
>>
>> You still have cxg3 as an enabled & supported driver? In RH8? Why?
>>   
>>> It's much easier if upstream continues to update the drivers for
>>> such across-the-driver-patch-changes.  heck, add a separate patch
>>> that punches out a printk stating DEPRECATED (dropping a patch to
>>> backport is easy! :) ).
>>
>> The whole point of doing this is to avoid this work!
> 
> People don't quit *using* hardware just because a company has quit
> selling it.  When we can quit supporting it is more about whether
> customers ask for support (or our records indicate lots of systems use
> the hardware) than about whether the vendors still care.
> 
> That said, we probably could have dropped cxgb3 from 8.0, but I'm not
> positive about that.  Just a guess.
> 

cxgb3 is dropped from rhel-8;
yeah, we pruned the tree very closely on RHEL8, and many on this list know that all too well --
b/c ... oh yeah, the vendors EOL'd their devices ... but they are in labs' (well-established) OEM servers everywhere, and now they can't run RHEL8. :(

cxgb3 still quite alive in rhel-7 --> 10yr life cycle ! 7.0 shipped June 2014... so in 2024...
RHEL7 has exited Phase I, where we update the RDMA base to upstream en-masse every RHEL-X.Y release,
so the concern is less now, but some bug-fixes require a refactoring that breaks un-sourced drivers.

Hey, this nut case named Doug Ledford wanted me to keep mthca enabled in RHEL8 for his private lab!
hahahahahaha ....

On the flip-side, I wish we could EOL & remove a whole lot of other code in the kernel (/me looking at old x86 compat code as a prime example...).  other old hw on arch's ... would make a lot of mm cleanup possible without the long, protracted effort that Mike Rappaport goes through!

ok, I made my point.  Do as you wish.



