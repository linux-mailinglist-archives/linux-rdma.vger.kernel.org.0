Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C676711765B
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2019 20:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfLITyi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Dec 2019 14:54:38 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19955 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLITyi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Dec 2019 14:54:38 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5deea6770001>; Mon, 09 Dec 2019 11:54:31 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 09 Dec 2019 11:54:37 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 09 Dec 2019 11:54:37 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Dec
 2019 19:54:37 +0000
Received: from [10.110.48.28] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Dec 2019
 19:54:37 +0000
Subject: Re: [PATCH v2 1/2] mm/gup: allow FOLL_FORCE for get_user_pages_fast()
To:     Leon Romanovsky <leon@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20191204213603.464373-1-jhubbard@nvidia.com>
 <20191204213603.464373-2-jhubbard@nvidia.com> <20191209182536.GC67461@unreal>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <7ceb9a54-6e2f-6d1f-70ba-f6ad5ba0b37f@nvidia.com>
Date:   Mon, 9 Dec 2019 11:54:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191209182536.GC67461@unreal>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575921271; bh=aYYf+3MgNx882/6bWA0YHWVT6GLALSpA6F24y/9AlO0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=SnYpIJZa36DGx3o90G2KZqfxdnVww5TQO7kjIc3RDrtpF/iyFp2WoOL6Yz2JLgp37
         Vhjgo48MYabYW7yhYCN/bPjnZAs/EZJgAH2u5TtH+05tdTxM/H3tAFtmYZETQ8PYuB
         qAB1nLeSN+ROLL4dEdqKgJkiuriINbvQyu0gCzeaFRrQJrAlrlBBYxhnFkMMLU3mMJ
         h1epTVMihjJIV9dv9Fa+7Z2z33mn71vAU1s0XcMnB6brv+gco7gWPN2vInCq+e4xs+
         1GvK0+aUaComW80KYf6KZcqAa5BBR2jqqE1Lpx4nUm091EZ2LH9C7IaGxgIrAMXbuH
         Xy83MRJlaAAPg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/9/19 10:25 AM, Leon Romanovsky wrote:
> On Wed, Dec 04, 2019 at 01:36:02PM -0800, John Hubbard wrote:
>> Commit 817be129e6f2 ("mm: validate get_user_pages_fast flags") allowed
>> only FOLL_WRITE and FOLL_LONGTERM to be passed to get_user_pages_fast().
>> This, combined with the fact that get_user_pages_fast() falls back to
>> "slow gup", which *does* accept FOLL_FORCE, leads to an odd situation:
>> if you need FOLL_FORCE, you cannot call get_user_pages_fast().
>>
>> There does not appear to be any reason for filtering out FOLL_FORCE.
>> There is nothing in the _fast() implementation that requires that we
>> avoid writing to the pages. So it appears to have been an oversight.
>>
>> Fix by allowing FOLL_FORCE to be set for get_user_pages_fast().
>>
>> Fixes: 817be129e6f2 ("mm: validate get_user_pages_fast flags")
>> Cc: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>  mm/gup.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
> 
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> 

Hi Leon, thanks for the reviews, great timing! I'll add the tags to
the commits, which I'm just about to post as part of the larger 
"pin user pages" patchset.


thanks,
-- 
John Hubbard
NVIDIA
