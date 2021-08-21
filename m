Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538773F39F9
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Aug 2021 11:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhHUJpb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 21 Aug 2021 05:45:31 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:33068 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233519AbhHUJpa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 21 Aug 2021 05:45:30 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AiGofZ6yCB1K1czCY0kKDKrPwyL1zdoMgy1kn?=
 =?us-ascii?q?xilNoRw8SK2lfqeV7Y0mPH7P+VAssR4b6LK90cW7LU80sKQFhrX5Xo3SODUO2l?=
 =?us-ascii?q?HYT72KhLGKq1aLdhEWtNQ86U4KScdD4bPLY2SSwfyKhTVQDexQveWvweS5g/vE?=
 =?us-ascii?q?1XdxQUVPY6Fk1Q1wDQGWCSRNNXJ7LKt8BJyB/dBGujblXXwWa/6wDn4DU/OGiM?=
 =?us-ascii?q?bMkPvdEGQ7Li9i+A+Tlimp9bK/NxCZ2y0VWzRJzaxn0UWtqX2A2pme?=
X-IronPort-AV: E=Sophos;i="5.84,340,1620662400"; 
   d="scan'208";a="113238661"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 21 Aug 2021 17:44:50 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 5FDDE4D0D49D;
        Sat, 21 Aug 2021 17:44:44 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sat, 21 Aug 2021 17:44:45 +0800
Received: from [192.168.122.212] (10.167.226.45) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sat, 21 Aug 2021 17:44:45 +0800
From:   "Li, Zhijian" <lizhijian@cn.fujitsu.com>
Subject: Re: [PATCH] RDMA/mlx5: return the EFAULT per ibv_advise_mr(3)
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Li Zhijian" <lizhijian@cn.fujitsu.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210801092050.6322-1-lizhijian@cn.fujitsu.com>
 <20210803162507.GA2892108@nvidia.com> <YQmDZpbCy3uTS5jv@unreal>
 <20210803181341.GE1721383@nvidia.com> <YQonIu3VMTlGj0TJ@unreal>
 <20210804185022.GM1721383@nvidia.com> <YQuIlUT9jZLeFPNH@unreal>
 <6b372500-ebc5-bc42-11c5-99de381b2e50@fujitsu.com>
Message-ID: <7b930773-0071-5b96-2a85-718d0ca07bfa@cn.fujitsu.com>
Date:   Sat, 21 Aug 2021 17:44:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <6b372500-ebc5-bc42-11c5-99de381b2e50@fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 5FDDE4D0D49D.A1DF4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

convert to text and send again


Hi Jason & Leon

It reminds me that ibv_advise_mr doesn't mention ENOENT any more which value the API actually returns now.
the ENOENT cases/situations returned by kernel mlx5 implementation is most likely same with EINVALL as its manpage[1].

So shall we return EINVAL instead of ENOENT in kernel side when get_prefetchable_mr returns NULL?

1781 static int mlx5_ib_prefetch_sg_list(struct ib_pd *pd,
1782                     enum ib_uverbs_advise_mr_advice advice,
1783                     u32 pf_flags, struct ib_sge *sg_list,
1784                     u32 num_sge)
1785 {
1786     u32 bytes_mapped = 0;
1787     int ret = 0;
1788     u32 i;
1789
1790     for (i = 0; i < num_sge; ++i) {
1791         struct mlx5_ib_mr *mr;
1792
1793         mr = get_prefetchable_mr(pd, advice, sg_list[i].lkey);
1794         if (!mr)
1795             return -ENOENT;
1796         ret = pagefault_mr(mr, sg_list[i].addr, sg_list[i].length,
1797                    &bytes_mapped, pf_flags);



=============
RETURN VALUE
        ibv_advise_mr() returns 0 when the call was successful, or the value of errno on failure (which indicates the failure reason).

        EOPNOTSUPP
               libibverbs or provider driver doesn’t support the ibv_advise_mr() verb (ENOSYS may sometimes be returned by old versions of libibverbs).

        ENOTSUP
               The advise operation isn’t supported.

        EFAULT In  one of the following: o When the range requested is out of the MR bounds, or when parts of it are not part of the process address space.  o One of the lkeys provided in the scatter gather
               list is invalid or with wrong write access.

        EINVAL In one of the following: o The PD is invalid.  o The flags are invalid.

[1]:https://github.com/linux-rdma/rdma-core/blob/master/libibverbs/man/ibv_advise_mr.3.md

Thanks

on 2021/8/16 10:59, Li, Zhijian wrote:
> On 05/08/2021 14:43, Leon Romanovsky wrote:
>> On Wed, Aug 04, 2021 at 03:50:22PM -0300, Jason Gunthorpe wrote:
>>> On Wed, Aug 04, 2021 at 08:35:30AM +0300, Leon Romanovsky wrote:
>>>> On Tue, Aug 03, 2021 at 03:13:41PM -0300, Jason Gunthorpe wrote:
>>>>> On Tue, Aug 03, 2021 at 08:56:54PM +0300, Leon Romanovsky wrote:
>>>>>> On Tue, Aug 03, 2021 at 01:25:07PM -0300, Jason Gunthorpe wrote:
>>>>>>> On Sun, Aug 01, 2021 at 05:20:50PM +0800, Li Zhijian wrote:
>>>>>>>> ibv_advise_mr(3) says:
>>>>>>>> EFAULT In one of the following: o When the range requested is out of the  MR  bounds,
>>>>>>>>          or  when  parts of it are not part of the process address space. o One of the
>>>>>>>>          lkeys provided in the scatter gather list is invalid or with wrong write access
>>>>>>>>
>>>>>>>> Actually get_prefetchable_mr() will return NULL if it see above conditions
>>>>>>> No, get_prefetchable_mr() returns NULL if the mkey is invalid
>>>>>> And what is this?
>>>>>>     1701 static struct mlx5_ib_mr *
>>>>>>     1702 get_prefetchable_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
>>>>>>     1703                     u32 lkey)
>>>>>>
>>>>>> ...
>>>>>>
>>>>>>     1721         /* prefetch with write-access must be supported by the MR */
>>>>>>     1722         if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
>>>>>>     1723             !mr->umem->writable) {
>>>>>>     1724                 mr = NULL;
>>>>>>     1725                 goto end;
>>>>>>     1726         }
>>>>> I would say that is an invalid mkey
>>>> I see it is as wrong write access.
>>> It just means the man page is wrong
>> ok, it can be a solution too.
> It sounds good.  I will try to update the manpage ibv_advise_mr(3) instead.
>
>
> Thanks
> Zhijian


