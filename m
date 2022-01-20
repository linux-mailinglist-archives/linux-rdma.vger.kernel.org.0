Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E383494DA0
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jan 2022 13:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiATMHm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jan 2022 07:07:42 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:29637 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232127AbiATMHl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jan 2022 07:07:41 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AWJpM36PJ6NFoTA7vrR0jlcFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQC+0D4k1jBUnWoZXTzTbP/eZ2fyfdskPNuy8BkOvJGDm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHi+0SiuFaOC79yElj/nQHNIQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/jzSbn9FzydxLnZKtS?=
 =?us-ascii?q?wY1JbCKk+MYO/VdO3gkZfMdoeeeeBBTtuTWlSUqaUDE2e1jBVstOosY4utfDmR?=
 =?us-ascii?q?H9PheIzcIBjifgOe/26D9RfNrg80vPsrqFIIZpnxkizreCJ4OUJnFQbjMo81Yw?=
 =?us-ascii?q?R80h8ZTDbDSatRxQThgYzzGfRxDO15RA5U79M+0gXzXbzRcsF+E46Ew5gD7yA1?=
 =?us-ascii?q?3zaioKtbQc/SUSshP2EWVvGTL+yL+GB5yCTA14VJp6Vr13qmWw3y9A9lUSdWFG?=
 =?us-ascii?q?jdRqAX77gQu5Nc+DDNXecWEt3M=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A7ViPQq7SxXyOpCkR7QPXwPTXdLJyesId70hD?=
 =?us-ascii?q?6qkRc20wTiX8ra2TdZsguyMc9wx6ZJhNo7G90cq7MBbhHPxOkOos1N6ZNWGIhI?=
 =?us-ascii?q?LCFvAB0WKN+V3dMhy73utc+IMlSKJmFeD3ZGIQse/KpCW+DPYsqePqzJyV?=
X-IronPort-AV: E=Sophos;i="5.88,302,1635177600"; 
   d="scan'208";a="120631011"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 20 Jan 2022 20:07:39 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 448124D15A51;
        Thu, 20 Jan 2022 20:07:37 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 20 Jan 2022 20:07:37 +0800
Received: from [192.168.122.212] (10.167.226.45) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 20 Jan 2022 20:07:37 +0800
Subject: Re: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
CC:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "tom@talpey.com" <tom@talpey.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
References: <20220113030350.2492841-1-yangx.jy@fujitsu.com>
 <20220113030350.2492841-3-yangx.jy@fujitsu.com>
 <20220117131624.GB7906@nvidia.com> <61E673EA.60900@fujitsu.com>
 <20220118123505.GF84788@nvidia.com>
 <7dfed756-42a7-b6f7-3473-1348479d30db@fujitsu.com>
 <20220119123635.GH84788@nvidia.com>
From:   "Li, Zhijian" <lizhijian@cn.fujitsu.com>
Message-ID: <022be340-a49a-1e94-5fb8-1c77f06fecc2@cn.fujitsu.com>
Date:   Thu, 20 Jan 2022 20:07:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220119123635.GH84788@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 448124D15A51.ABCCC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason


on 2022/1/19 20:36, Jason Gunthorpe wrote:
> On Wed, Jan 19, 2022 at 01:54:32AM +0000, lizhijian@fujitsu.com wrote:
>>
>> On 18/01/2022 20:35, Jason Gunthorpe wrote:
>>> On Tue, Jan 18, 2022 at 08:01:59AM +0000, yangx.jy@fujitsu.com wrote:
>>>> On 2022/1/17 21:16, Jason Gunthorpe wrote:
>>>>> On Thu, Jan 13, 2022 at 11:03:50AM +0800, Xiao Yang wrote:
>>>>>> +static enum resp_states process_atomic_write(struct rxe_qp *qp,
>>>>>> +					     struct rxe_pkt_info *pkt)
>>>>>> +{
>>>>>> +	struct rxe_mr *mr = qp->resp.mr;
>>>>>> +
>>>>>> +	u64 *src = payload_addr(pkt);
>>>>>> +
>>>>>> +	u64 *dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, sizeof(u64));
>>>>>> +	if (!dst || (uintptr_t)dst&  7)
>>>>>> +		return RESPST_ERR_MISALIGNED_ATOMIC;
>>>>> It looks to me like iova_to_vaddr is completely broken, where is the
>>>>> kmap on that flow?
>>>> Hi Jason,
>>>>
>>>> I think rxe_mr_init_user() maps the user addr space to the kernel addr
>>>> space during memory region registration, the mapping records are saved
>>>> into mr->cur_map_set->map[x].
>>> There is no way to touch user memory from the CPU in the kernel
>> That's absolutely right, but I don't think it references that user memory directly.
>>
>>> without calling one of the kmap's, so I don't know what this thinks it
>>> is doing.
>>>
>>> Jason
>> IMHO, for the rxe, rxe_mr_init_user() will call get_user_page() to pin iova first, and then
>> the page address will be recorded into mr->cur_map_set->map[x]. So that when we want
>> to reference iova's kernel address, we can call iova_to_vaddr() where it will retrieve its kernel
>> address by travel the mr->cur_map_set->map[x].
> That flow needs a kmap

IIUC, this was a existing issue in iova_to_vaddr() right ?
Alternatively, can we have below changes to fix it simply?

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c 
b/drivers/infiniband/sw/rxe/rxe_mr.c
index 0621d387ccba..978fdd23665c 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -260,7 +260,8 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, 
u64 length, u64 iova,
                                 num_buf = 0;
                         }

-                       vaddr = page_address(sg_page_iter_page(&sg_iter));
+                       // FIXME: don't forget to kunmap_local(vaddr)
+                       vaddr = 
kmap_local_page(sg_page_iter_page(&sg_iter));
                         if (!vaddr) {
                                 pr_warn("%s: Unable to get virtual 
address\n",
                                                 __func__);



>
>> Do you mean we should retrieve iova's page first, and the reference the kernel address by
>> kmap(), sorry for my stupid question ?
> Going from struct page to something the kernel can can touch requires
> kmap

Got it

Thanks

Zhijian


>
> Jason


