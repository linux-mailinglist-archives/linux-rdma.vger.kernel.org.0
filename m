Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028EE3AA854
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jun 2021 02:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhFQBBS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 21:01:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231361AbhFQBBS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 21:01:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FC39613BF;
        Thu, 17 Jun 2021 00:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623891551;
        bh=LnI42oM+huJkD4bxD8CwkKH5CzDJoXGskz8GSzrb1rg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ksFcBsQkNvpToZyi/yTyHHpYIJxHDVOpUX9I3EVrioRxluRpXF6wlu1T1fng7kXns
         TUo+rFosOWDwyAXUzvPCGAWc5zAZ4rLM+RYo+82JzrAr9X50vKXjFzdKW2dzwlVf5b
         7u3uYPKEpW7DqSKtD9ed1t2ojqUNcGVMVJanPgSbVaYTqHcriJSGyKgpTnBn6MOxbw
         SbMuCNWzsOJvK4K+V8tc/F3gjlZAI8xSKoQJ2MDRA+d4nLtjxkuFPHtz5lgBW9ByFh
         tLdFp5BV8zfDpRtzieyyRU1z+21PKMPyqFK23NjzHQINgHHml8K1SP3zYVbXgrWdg0
         rR+oO7HVl7QIw==
Subject: Re: [PATCH rdma-next v2 00/15] Reorganize sysfs file creation for
 struct ib_devices
To:     Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        clang-built-linux@googlegroups.com,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
References: <cover.1623427137.git.leonro@nvidia.com>
 <20210617000021.GA1899410@nvidia.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <0b6de703-1071-ca39-5657-cd00862bfbfd@kernel.org>
Date:   Wed, 16 Jun 2021 17:59:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210617000021.GA1899410@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/16/2021 5:00 PM, Jason Gunthorpe wrote:
> On Fri, Jun 11, 2021 at 07:00:19PM +0300, Leon Romanovsky wrote:
> 
>> Jason Gunthorpe (15):
>>    RDMA: Split the alloc_hw_stats() ops to port and device variants
>>    RDMA/core: Replace the ib_port_data hw_stats pointers with a ib_port
>>      pointer
>>    RDMA/core: Split port and device counter sysfs attributes
>>    RDMA/core: Split gid_attrs related sysfs from add_port()
>>    RDMA/core: Simplify how the gid_attrs sysfs is created
>>    RDMA/core: Simplify how the port sysfs is created
>>    RDMA/core: Create the device hw_counters through the normal groups
>>      mechanism
>>    RDMA/core: Remove the kobject_uevent() NOP
>>    RDMA/core: Expose the ib port sysfs attribute machinery
>>    RDMA/cm: Use an attribute_group on the ib_port_attribute intead of
>>      kobj's
>>    RDMA/qib: Use attributes for the port sysfs
>>    RDMA/hfi1: Use attributes for the port sysfs
>>    RDMA: Change ops->init_port to ops->port_groups
>>    RDMA/core: Allow port_groups to be used with namespaces
>>    RDMA: Remove rdma_set_device_sysfs_group()
> 
> Applied to for-next, thanks everyone
> 
> Jason
> 

I just got done verifying that v2 still fixes the Control Flow Integrity 
violations. In case it is useful:

Tested-by: Nathan Chancellor <nathan@kernel.org>

Cheers,
Nathan
