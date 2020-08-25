Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A15251A76
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 16:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgHYOEz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 10:04:55 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:39650 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgHYOEu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 10:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598364290; x=1629900290;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=fz3WP475uVpYc7iG5ltWpRXutg8U0Jaec2cTqUhUiXU=;
  b=ONbkg53XJU/Yr9rmIxuG6TiE1EVBu9i0JboH2wSJu1bOzzQhzcXRslER
   EAWmIQq5EY2yl3ToGdDJS9wucLTwkPAIvrvsn3j2r0aFHV7SKyj8zZF0S
   Pqu1O/XKI6Y/ulR/oVrEQxJ1TL+XfVLZBsSDSS7CjTTL1MkLd/ZoAd4BU
   M=;
X-IronPort-AV: E=Sophos;i="5.76,352,1592870400"; 
   d="scan'208";a="49890417"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 25 Aug 2020 14:04:47 +0000
Received: from EX13D19EUB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id 0FBADA0722;
        Tue, 25 Aug 2020 14:04:37 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.145) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 25 Aug 2020 14:04:21 +0000
Subject: Re: [PATCH rdma-next 01/10] RDMA: Restore ability to fail on PD
 deallocate
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Lijun Ou <oulijun@huawei.com>, <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
References: <20200824103247.1088464-1-leon@kernel.org>
 <20200824103247.1088464-2-leon@kernel.org>
 <10111f1b-ea06-dce5-a8be-d18e70962547@amazon.com>
 <20200825115246.GP1152540@nvidia.com>
 <110cc351-f8f1-8f88-3912-c4dae711b393@amazon.com>
 <20200825130736.GQ1152540@nvidia.com>
 <74f893e8-694a-17f0-dc49-05061a214558@amazon.com>
 <20200825134428.GR1152540@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <5f4f67b1-ca3c-fd11-a835-db7906cad148@amazon.com>
Date:   Tue, 25 Aug 2020 17:04:14 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825134428.GR1152540@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.145]
X-ClientProxiedBy: EX13D03UWA003.ant.amazon.com (10.43.160.39) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 25/08/2020 16:44, Jason Gunthorpe wrote:
> On Tue, Aug 25, 2020 at 04:32:57PM +0300, Gal Pressman wrote:
>>> For uverbs it will go into an infinite loop in
>>> uverbs_destroy_ufile_hw() if destroy doesn't eventually succeed.
>>
>> The code breaks the loop in such cases, why infinite loop?
> 
> Oh, that is a bug, it should WARN_ON when that happens, because the
> driver has triggered a permanent memory leak.

Well, a WARN_ON won't do much good if you're stuck in an infinite loop :), the
break is definitely needed there.

>>> For kernel it will trigger WARN_ON's and then a permanent memory leak.
>>>
>>>> I agree that drivers shouldn't fail destroy commands, but you know.. bugs/errors
>>>> happen (especially when dealing with hardware), and we have a way to propagate
>>>> them, why do it for only some of the drivers?
>>>
>>> There is no way to propogate them.
>>>
>>> All destroy must eventually succeed.
>>
>> There is no way to propagate them on process cleanup, but the destroy verbs have
>> a return code all the way back to libibverbs, which we can use for error
>> propagation.
> 
> It is sort of OK for a driver to fail during RDMA_REMOVE_DESTROY.
> 
> All other reason codes must eventually succeed.
> 
>> The cleanup flow can either ignore the return value, or we can add
>> another parameter that explicitly means the call shouldn't fail and all
>> allocated memory/state should be freed.
> 
> I don't really see the value to return the error code to userspace, it
> would require churning all the drivers and all the destroy functions
> to pass the existing reason in.
> 
> Since all the details of the FW failure reason are lost to some EINVAL
> (or already logged to dmesg) I don't see much point.

Right, as always, the error code would probably not contain much information,
but there's a big difference between returning error code X/Y vs returning
success instead of an error. To me that just feels wrong, at least in cases
where we can prevent that.

Won't argue about the churn, it's a lot of work for a "small" benefit in the
rare error cases. Can't we leave it up for the individual driver to decide
whether it chooses to support that or not? i.e. default behavior would be that
failures are not allowed, and a driver can opt to respect the extra parameter
(kinda like how DEVX "supports" failing)?

>>>>> If the chip fails a destroy when it should not then it has failed and
>>>>> should be disabled at PCI and reset, continuing to free anyhow.
>>>>
>>>> How do we reset the device when there are active apps using it?
>>>
>>> The zap stuff revokes the BAR mmaping, it triggerst device fatal to
>>> userspace and that is mostly it for userspace..
>>
>> Interesting, is there a reference driver that does that today?
> 
> I think both mlx drivers and hns do? See
> uverbs_user_mmap_disassociate()

Thanks!
