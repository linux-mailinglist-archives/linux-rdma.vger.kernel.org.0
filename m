Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34F3D16FFDE
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2020 14:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgBZNZG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Feb 2020 08:25:06 -0500
Received: from mga02.intel.com ([134.134.136.20]:17632 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgBZNZG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 26 Feb 2020 08:25:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 05:25:05 -0800
X-IronPort-AV: E=Sophos;i="5.70,488,1574150400"; 
   d="scan'208";a="231396416"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.202.200]) ([10.254.202.200])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Feb 2020 05:25:04 -0800
Subject: Re: [PATCH for-rc] RDMA/core: Fix additional panic in
 get_pkey_idx_qp_list()
To:     Leon Romanovsky <leon@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org
References: <20200225133150.122365.97027.stgit@awfm-01.aw.intel.com>
 <20200226130432.GB12414@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <a6c9d82e-59ca-eb27-fe53-ca6edd55fb5b@intel.com>
Date:   Wed, 26 Feb 2020 08:25:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200226130432.GB12414@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/26/2020 8:04 AM, Leon Romanovsky wrote:
> On Tue, Feb 25, 2020 at 08:31:51AM -0500, Mike Marciniszyn wrote:
>> When an hfi1 card is booted and the part is brought active
>> a panic will result when the following commands
>> are entered after ipoib has come up:
>>
>> ifdown ib0 && ifup ib0
>>
>> Here is the panic:
>>
>> [  208.521731] RIP: 0010:get_pkey_idx_qp_list+0x50/0x80 [ib_core]
>> [  208.528249] Code: c7 18 e8 13 04 30 ef 0f b6 43 06 48 69 c0 b8 00 00 00 48 03 85 a0 04 00 00 48 8b 50 20 48 8d 48 20 48 39 ca 74 1a 0f b7 73 04 <66> 39 72 10 75 08 eb 10 66 39 72 10 74 0a 48 8b 12 48 39 ca 75 f2
>> [  208.549257] RSP: 0018:ffffafb3480932f0 EFLAGS: 00010203
>> [  208.555114] RAX: ffff98059ababa10 RBX: ffff980d926e8cc0 RCX: ffff98059ababa30
>> [  208.563108] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff98059ababa28
>> [  208.571112] RBP: ffff98059b940000 R08: 00000000000310c0 R09: ffff97fe47c07480
>> [  208.579117] R10: 0000000000000036 R11: 0000000000000200 R12: 0000000000000071
>> [  208.587115] R13: ffff98059b940000 R14: ffff980d87f948a0 R15: 0000000000000000
>> [  208.595100] FS:  00007f88deb31740(0000) GS:ffff98059f600000(0000) knlGS:0000000000000000
>> [  208.604151] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  208.610575] CR2: 0000000000000010 CR3: 0000000853e26001 CR4: 00000000001606e0
>> [  208.618554] Call Trace:
>> [  208.621301]  port_pkey_list_insert+0x3d/0x1b0 [ib_core]
>> [  208.627142]  ? kmem_cache_alloc_trace+0x215/0x220
>> [  208.632994]  ib_security_modify_qp+0x226/0x3a0 [ib_core]
>> [  208.639606]  _ib_modify_qp+0xcf/0x390 [ib_core]
>> [  208.645250]  ipoib_init_qp+0x7f/0x200 [ib_ipoib]
>> [  208.650931]  ? rvt_modify_port+0xd0/0xd0 [rdmavt]
>> [  208.656755]  ? ib_find_pkey+0x99/0xf0 [ib_core]
>> [  208.662403]  ipoib_ib_dev_open_default+0x1a/0x200 [ib_ipoib]
>> [  208.669279]  ipoib_ib_dev_open+0x96/0x130 [ib_ipoib]
>> [  208.675429]  ipoib_open+0x44/0x130 [ib_ipoib]
>> [  208.680833]  __dev_open+0xd1/0x160
>> [  208.685163]  __dev_change_flags+0x1ab/0x1f0
>> [  208.690435]  dev_change_flags+0x23/0x60
>> [  208.695281]  do_setlink+0x328/0xe30
>> [  208.699733]  ? __nla_validate_parse+0x54/0x900
>> [  208.705269]  __rtnl_newlink+0x54e/0x810
>> [  208.710117]  ? __alloc_pages_nodemask+0x17d/0x320
>> [  208.715899]  ? page_fault+0x30/0x50
>> [  208.720392]  ? _cond_resched+0x15/0x30
>> [  208.725158]  ? kmem_cache_alloc_trace+0x1c8/0x220
>> [  208.730931]  rtnl_newlink+0x43/0x60
>> [  208.735444]  rtnetlink_rcv_msg+0x28f/0x350
>> [  208.740599]  ? kmem_cache_alloc+0x1fb/0x200
>> [  208.745810]  ? _cond_resched+0x15/0x30
>> [  208.750605]  ? __kmalloc_node_track_caller+0x24d/0x2d0
>> [  208.756854]  ? rtnl_calcit.isra.31+0x120/0x120
>> [  208.762425]  netlink_rcv_skb+0xcb/0x100
>> [  208.767307]  netlink_unicast+0x1e0/0x340
>> [  208.772242]  netlink_sendmsg+0x317/0x480
>> [  208.777121]  ? __check_object_size+0x48/0x1d0
>> [  208.782545]  sock_sendmsg+0x65/0x80
>> [  208.786915]  ____sys_sendmsg+0x223/0x260
>> [  208.791776]  ? copy_msghdr_from_user+0xdc/0x140
>> [  208.797378]  ___sys_sendmsg+0x7c/0xc0
>> [  208.801921]  ? skb_dequeue+0x57/0x70
>> [  208.806430]  ? __inode_wait_for_writeback+0x75/0xe0
>> [  208.812383]  ? fsnotify_grab_connector+0x45/0x80
>> [  208.817950]  ? __dentry_kill+0x12c/0x180
>> [  208.822734]  __sys_sendmsg+0x58/0xa0
>> [  208.827180]  do_syscall_64+0x5b/0x200
>> [  208.831671]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [  208.837707] RIP: 0033:0x7f88de467f10
>>
>> A bisect points to the commit noted below.
>>
>> Some prints show that when ib0 first comes up and qp_attr_mask of 0x51
>> results in a new pp with a 0 port_num:
>>
>> [ 149.207404] qp_attr_mask 51 qp_attr->port_num 1 qp->attr->pkey_index 0
>> [ 149.215522] qp_pps ffff8d745be33180 qp_pps->main.state 2 qp_pps->main.port_num 1
>> [ 149.224616] new pp ffff8d745be33120 state 0 port_num 0 pkey_index 0
>>
>> For an qp_attr_mask of 0x51, the code never copies the port from
>> qp_pps, leaving the port at 0, which eventually leads to the panic.
>> The state is also also left at 0 or IB_PORT_PKEY_NOT_VALID.
>>
>> Later when the ibdown/ifup is executed the port_num 0 shows up in qp_pps
>> at ffff8d745be33120 leading to the panic.
>>
>> [  198.223296] qp_attr_mask 71 qp_attr->port_num 1 qp->attr->pkey_index 0
>> [  198.230608] qp_pps ffff8d745be33120 qp_pps->main.state 0 qp_pps->main.port_num 0
>> [  198.238887] new pp ffff8d6c5f412d80 state 1 port_num 0 pkey_index 0
>> [  198.245900] pp ffff8d6c5f412d80 pp->port_num 0 pp->pkey_index 0
>> [  198.254005] BUG: kernel NULL pointer dereference, address: 0000000000000010
>>
>> Fix by adjusting the else clause to insure that the port_num and state
>> are copied when there is a qp_pps.
>>
>> Reviewed-by: Kaike Wan <kaike.wan@intel.com>
>> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
>> Fixes: 1dd017882e01 ("RDMA/core: Fix protection fault in get_pkey_idx_qp_list")
>> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
>> ---
>>   drivers/infiniband/core/security.c |    3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
>> index 2b4d803..f2c7fbd 100644
>> --- a/drivers/infiniband/core/security.c
>> +++ b/drivers/infiniband/core/security.c
>> @@ -347,8 +347,7 @@ static struct ib_ports_pkeys *get_new_pps(const struct ib_qp *qp,
>>   						      qp_attr->pkey_index;
>>   	if ((qp_attr_mask & IB_QP_PKEY_INDEX) && (qp_attr_mask & IB_QP_PORT))
>>   		new_pps->main.state = IB_PORT_PKEY_VALID;
>> -
>> -	if (!(qp_attr_mask & (IB_QP_PKEY_INDEX || IB_QP_PORT)) && qp_pps) {
>> +	else if (qp_pps) {
>>   		new_pps->main.port_num = qp_pps->main.port_num;
> 
> I afraid that this patch is incorrect, if IB_QP_PORT or IB_QP_PKEY_INDEX set,
> we will perform needed assignment:
> 
> 342         if (qp_attr_mask & IB_QP_PORT)
> 343                 new_pps->main.port_num =
> 344                         (qp_pps) ? qp_pps->main.port_num : qp_attr->port_num;
> 345         if (qp_attr_mask & IB_QP_PKEY_INDEX)
> 346                 new_pps->main.pkey_index = (qp_pps) ? qp_pps->main.pkey_index :
> 
> So in your code, you will or overwrite already set fields or perform
> assignment if both IB_QP_* not set, while in original code this
> "else if (qp_pps)" will be taken if both IB_QP_PORT and IB_QP_PKEY_INDEX
> are not set.
> 
> Can you please give a shot for Maor's version?

You mean this one? https://marc.info/?l=linux-rdma&m=158263596831342&w=2

-Denny

