Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E7EDF7C7
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 23:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbfJUV5W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 17:57:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34822 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730069AbfJUV5W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 17:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YU2DLOHwT7aWI8mszLImzfDMV/VLbGd6VmxnoyKfqC4=; b=SS9QwFtrpF9XAU0ol6M9R4yEU
        bglXeQO6sLZ++j/XrGOYAVi5dHWTG59zOsIqHNPGBdcbxdj42YAEET99Yj2KqTRm5T3lfyX9R1uVZ
        91VYwOPvMfYwLpeVkaid1vTlmiP4aP1dQIHCI2HpwsNh7rivAVPaYLhEA3hfY38+QN4mZIgPqGOdd
        uOt9DHh+TWqcrpv6ymxRB4SHtQVaSskEMThhXonNkDLqPYrIzh2D2cmUGg/7X6PR4jeMFbg0pxOE7
        B/KBx7kubCsKlO9fSCpXg99ekA09Bc+vWiyaz3XaLZtFk/w3yPSbbKlHOeOpVu7Wus7mjhdWsXOeA
        BwE0NzKpA==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMfg1-00060E-Ea; Mon, 21 Oct 2019 21:57:21 +0000
Subject: Re: [PATCH 12/12] infiniband: add a Documentation driver-api chapter
 for Infiniband
To:     Jason Gunthorpe <jgg@ziepe.ca>, kbuild test robot <lkp@intel.com>
Cc:     rd.dunlab@gmail.com, kbuild-all@01.org, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>, linux-doc@vger.kernel.org
References: <20191010035240.310347906@gmail.com>
 <201910102325.gH3tui1l%lkp@intel.com> <20191021170745.GF25178@ziepe.ca>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0525999e-8982-b0cf-8d98-a1f6c86fa148@infradead.org>
Date:   Mon, 21 Oct 2019 14:57:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191021170745.GF25178@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/21/19 10:07 AM, Jason Gunthorpe wrote:
> Randy,
> 
> What do you want to do with this series? Is this error below related
> needing respin, or just noise?
> 
> Thanks,
> Jason

Hi Jason,

I certainly would like to see patches 1-11 merged since they do lots of
cleanups/fixes that I prefer not to be lost.
If you don't want to merge patch 12, so be it.

My docs build has a total of 8 errors and 173 warnings, so I consider these
just more noise.  Please note that I am also working on cleaning up lots of
that noise.

Patches 3 and 7 mention new warnings that I am already aware of.

If you can tell me what the 'all_list' field [below] is/means,
I'll be glad to add a patch for that.


> On Thu, Oct 10, 2019 at 11:45:28PM +0800, kbuild test robot wrote:
>> Hi,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on rdma/for-next]
>> [cannot apply to v5.4-rc2 next-20191010]
>> [if your patch is applied to the wrong git tree, please drop us a note to help
>> improve the system. BTW, we also suggest to use '--base' option to specify the
>> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>>
>> url:    https://github.com/0day-ci/linux/commits/rd-dunlab-gmail-com/infiniband-kernel-doc-fixes-driver-api-chapter/20191010-220426
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
>> reproduce: make htmldocs
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>

[cutting non-related errors/warnings]

>>>> drivers/infiniband/ulp/iser/iscsi_iser.h:401: warning: Function parameter or member 'all_list' not described in 'iser_fr_desc'
>>>> drivers/infiniband/ulp/iser/iscsi_iser.h:415: warning: Function parameter or member 'all_list' not described in 'iser_fr_pool'
>>
>> vim +401 drivers/infiniband/ulp/iser/iscsi_iser.h
>>
>> 5587856c9659ac Sagi Grimberg       2013-07-28 @401  
>> 385ad87d4b637c Sagi Grimberg       2015-08-06  402  /**
>> e506e0f630a40d rd.dunlab@gmail.com 2019-10-09  403   * struct iser_fr_pool - connection fast registration pool
>> 385ad87d4b637c Sagi Grimberg       2015-08-06  404   *
>> 2b3bf958103899 Adir Lev            2015-08-06  405   * @list:                list of fastreg descriptors
>> 385ad87d4b637c Sagi Grimberg       2015-08-06  406   * @lock:                protects fmr/fastreg pool
>> 2b3bf958103899 Adir Lev            2015-08-06  407   * @size:                size of the pool
>> 385ad87d4b637c Sagi Grimberg       2015-08-06  408   */
>> 385ad87d4b637c Sagi Grimberg       2015-08-06  409  struct iser_fr_pool {
>> 2b3bf958103899 Adir Lev            2015-08-06  410  	struct list_head        list;
>> 385ad87d4b637c Sagi Grimberg       2015-08-06  411  	spinlock_t              lock;
>> 2b3bf958103899 Adir Lev            2015-08-06  412  	int                     size;
>> ea174c9573b0e0 Sagi Grimberg       2017-02-27  413  	struct list_head        all_list;
>> 385ad87d4b637c Sagi Grimberg       2015-08-06  414  };
>> 385ad87d4b637c Sagi Grimberg       2015-08-06 @415  
>>
>> :::::: The code at line 401 was first introduced by commit
>> :::::: 5587856c9659ac2d6ab201141aa8a5c2ff3be4cd IB/iser: Introduce fast memory registration model (FRWR)

thanks,
-- 
~Randy

