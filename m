Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD34D2D2E2D
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Dec 2020 16:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgLHP02 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Dec 2020 10:26:28 -0500
Received: from p3plsmtpa12-08.prod.phx3.secureserver.net ([68.178.252.237]:42808
        "EHLO p3plsmtpa12-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729386AbgLHP02 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Dec 2020 10:26:28 -0500
X-Greylist: delayed 528 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Dec 2020 10:26:28 EST
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id mejWkztqS2w3kmejWkKW7F; Tue, 08 Dec 2020 08:16:54 -0700
X-CMAE-Analysis: v=2.4 cv=beCu7MDB c=1 sm=1 tr=0 ts=5fcf98e6
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=Ikd4Dj_1AAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=Th0kdED2Od4K6tRsu94A:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH for-rc] RDMA/siw: Fix shift-out-of-bounds when call
 roundup_pow_of_two()
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Kamal Heib <kamalheib1@gmail.com>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
References: <20201207202756.GA1798393@nvidia.com>
 <20201207093728.428679-1-kamalheib1@gmail.com>
 <OFA6B3AA67.4315DE52-ON00258638.00350498-00258638.003B2C04@notes.na.collabserv.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <3086f623-3c2a-e1f2-b6a1-d892604f7c74@talpey.com>
Date:   Tue, 8 Dec 2020 10:16:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <OFA6B3AA67.4315DE52-ON00258638.00350498-00258638.003B2C04@notes.na.collabserv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMHlrUWEE6ciNrlXR+OMV/L/RRZsA46lJmvXVi/XTJ7xLuPGD8h0Ca62qohO35Xa9rTmcz7QcFB28GklGUTduhyitfnnZJKjhaoT6PqJboMNwrj6Drne
 hgPiY6WIRWL2PzZ+LKyoVeGBnlWSWFfo1q9xINNXNPer2gAAY3iqDZ7RSR8lftwpc3JuqPAfjBHpKXzv0KScsHODbbMbhss0e249potqrZLV9/Q1l/lemkal
 raMjUrNc9QSGkl2k2lxZqImIFzYhfj0qxRnjoyB76liQE0Y0rKc7t9F9GWSRXCoyCGn3EpU8HMbSvJu0nBZjKQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/8/2020 5:46 AM, Bernard Metzler wrote:
> -----"Jason Gunthorpe" <jgg@nvidia.com> wrote: -----
> 
>> To: "Kamal Heib" <kamalheib1@gmail.com>
>> From: "Jason Gunthorpe" <jgg@nvidia.com>
>> Date: 12/07/2020 09:29PM
>> Cc: <linux-rdma@vger.kernel.org>, "Bernard Metzler"
>> <bmt@zurich.ibm.com>, "Doug Ledford" <dledford@redhat.com>
>> Subject: [EXTERNAL] Re: [PATCH for-rc] RDMA/siw: Fix
>> shift-out-of-bounds when call roundup_pow_of_two()
>>
>> On Mon, Dec 07, 2020 at 11:37:28AM +0200, Kamal Heib wrote:
>>> When running the blktests over siw the following
>> shift-out-of-bounds is
>>> reported, this is happening because the passed IRD or ORD from the
>> ulp
>>> could be zero which will lead to unexpected behavior when calling
>>> roundup_pow_of_two(), fix that by blocking zero values of ORD or
>> IRD.
>>>
>>> UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
>>> shift exponent 64 is too large for 64-bit type 'long unsigned int'
>>> CPU: 20 PID: 3957 Comm: kworker/u64:13 Tainted: G S     5.10.0-rc6
>> #2
>>> Hardware name: Dell Inc. PowerEdge R630/02C2CP, BIOS 2.1.5
>> 04/11/2016
>>> Workqueue: iw_cm_wq cm_work_handler [iw_cm]
>>> Call Trace:
>>>   dump_stack+0x99/0xcb
>>>   ubsan_epilogue+0x5/0x40
>>>   __ubsan_handle_shift_out_of_bounds.cold.11+0xb4/0xf3
>>>   ? down_write+0x183/0x3d0
>>>   siw_qp_modify.cold.8+0x2d/0x32 [siw]
>>>   ? __local_bh_enable_ip+0xa5/0xf0
>>>   siw_accept+0x906/0x1b60 [siw]
>>>   ? xa_load+0x147/0x1f0
>>>   ? siw_connect+0x17a0/0x17a0 [siw]
>>>   ? lock_downgrade+0x700/0x700
>>>   ? siw_get_base_qp+0x1c2/0x340 [siw]
>>>   ? _raw_spin_unlock_irqrestore+0x39/0x40
>>>   iw_cm_accept+0x1f4/0x430 [iw_cm]
>>>   rdma_accept+0x3fa/0xb10 [rdma_cm]
>>>   ? check_flush_dependency+0x410/0x410
>>>   ? cma_rep_recv+0x570/0x570 [rdma_cm]
>>>   nvmet_rdma_queue_connect+0x1a62/0x2680 [nvmet_rdma]
>>>   ? nvmet_rdma_alloc_cmds+0xce0/0xce0 [nvmet_rdma]
>>>   ? lock_release+0x56e/0xcc0
>>>   ? lock_downgrade+0x700/0x700
>>>   ? lock_downgrade+0x700/0x700
>>>   ? __xa_alloc_cyclic+0xef/0x350
>>>   ? __xa_alloc+0x2d0/0x2d0
>>>   ? rdma_restrack_add+0xbe/0x2c0 [ib_core]
>>>   ? __ww_mutex_die+0x190/0x190
>>>   cma_cm_event_handler+0xf2/0x500 [rdma_cm]
>>>   iw_conn_req_handler+0x910/0xcb0 [rdma_cm]
>>>   ? _raw_spin_unlock_irqrestore+0x39/0x40
>>>   ? trace_hardirqs_on+0x1c/0x150
>>>   ? cma_ib_handler+0x8a0/0x8a0 [rdma_cm]
>>>   ? __kasan_kmalloc.constprop.7+0xc1/0xd0
>>>   cm_work_handler+0x121c/0x17a0 [iw_cm]
>>>   ? iw_cm_reject+0x190/0x190 [iw_cm]
>>>   ? trace_hardirqs_on+0x1c/0x150
>>>   process_one_work+0x8fb/0x16c0
>>>   ? pwq_dec_nr_in_flight+0x320/0x320
>>>   worker_thread+0x87/0xb40
>>>   ? __kthread_parkme+0xd1/0x1a0
>>>   ? process_one_work+0x16c0/0x16c0
>>>   kthread+0x35f/0x430
>>>   ? kthread_mod_delayed_work+0x180/0x180
>>>   ret_from_fork+0x22/0x30
>>>
>>> Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>>> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>>>   drivers/infiniband/sw/siw/siw_cm.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>> b/drivers/infiniband/sw/siw/siw_cm.c
>>> index 66764f7ef072..dff0b00cc55d 100644
>>> +++ b/drivers/infiniband/sw/siw/siw_cm.c
>>> @@ -1571,7 +1571,8 @@ int siw_accept(struct iw_cm_id *id, struct
>> iw_cm_conn_param *params)
>>>   		qp->tx_ctx.gso_seg_limit = 0;
>>>   	}
>>>   	if (params->ord > sdev->attrs.max_ord ||
>>> -	    params->ird > sdev->attrs.max_ird) {
>>> +	    params->ird > sdev->attrs.max_ird ||
>>> +	    !params->ord || !params->ird) {
>>>   		siw_dbg_cep(
>>
>> Are you sure this is the right place for this? Why not higher up? It
>> looks like the other iwarp drivers have the same problem
>>
>> Jason
>>
> 1) Good question. Do we want to allow applications to zero-size
> rdma READ capabilities? Maybe we want, if it is recognized as a
> security feature?

Do you mean zero-size RDMA Read, as in, an RDMA Read of zero bytes?
This is a valid operation specifically mentioned in the protocols.

Although it transfers no data, it does require a region protection
check at the responder, and it's something that requesting applications
may issue.

OTOH, if you mean is a zero IRD or ORD valid, yes, that too is true.

The NFS/RDMA client actually did this, because the rpcrdma protocol
permits only the server to issue RDMA operations. Therefore to reduce
resources, the client would set IRD to zero, and ORD to some small
number. The server would do the opposite (IRD=n and ORD=0)

> 2) In any case, siw currently does not correctly handle the case
> of zero sized ORD/IRD. If we want to go with 1), some fixes to siw
> are to be done. If we do not want 1), Kamal's patch is half of the
> story. It handles the response side only. Initiator would have to
> be fixed as well.
> 
> I'd propose allowing 1). I'd fix siw accordingly. Opinions?

Definitely allow both aspects of #1, and fix #2.

Tom.
