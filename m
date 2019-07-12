Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D65066BB7
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 13:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfGLLlZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 07:41:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfGLLlY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Jul 2019 07:41:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2CF27C04AC70;
        Fri, 12 Jul 2019 11:41:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-47.pek2.redhat.com [10.72.12.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A049F5C559;
        Fri, 12 Jul 2019 11:41:20 +0000 (UTC)
Subject: Re: regression: nvme rdma with bnxt_re0 broken
To:     Parav Pandit <parav@mellanox.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     Daniel Jurgens <danielj@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <1310083272.27124086.1562836112586.JavaMail.zimbra@redhat.com>
 <619411460.27128070.1562838433020.JavaMail.zimbra@redhat.com>
 <AM0PR05MB48664657022ECA8526E3C967D1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866070FBADCCABD1F84E42ED1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <66d43fd8-18e8-8b9d-90e3-ee2804d56889@redhat.com>
 <AM0PR05MB4866DEDB9DE4379F6A6EF15BD1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <CA+sbYW17PGAW57pyRmQB9KsDA9Q+7FFgSseSTTWE_h6vffa7UQ@mail.gmail.com>
 <AM0PR05MB4866CFEDCDF3CDA1D7D18AA5D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866CCD487C9D99BD9526BA8D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866665D5CACB34AE885BCA2D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <ef6a01a1-9163-ef4e-29ac-4f4130c682f1@redhat.com>
Date:   Fri, 12 Jul 2019 19:41:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <AM0PR05MB4866665D5CACB34AE885BCA2D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 12 Jul 2019 11:41:24 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Parav
The nvme connect still failed[1], I've paste all the dmesg log to[2], 
pls check it.


[1]
[root@rdma-perf-07 ~]$ nvme connect -t rdma -a 172.31.40.125 -s 4420 -n 
testnqn
Failed to write to /dev/nvme-fabrics: Connection reset by peer
[2]
https://pastebin.com/ipvak0Sp

Thanks

Yi


On 7/12/19 5:49 PM, Parav Pandit wrote:
>>> Hi Selvin,
>>>
>>>> -----Original Message-----
>>>> From: Selvin Xavier <selvin.xavier@broadcom.com>
>>>> Sent: Friday, July 12, 2019 9:16 AM
>>>> To: Parav Pandit <parav@mellanox.com>
>>>> Cc: Yi Zhang <yi.zhang@redhat.com>; linux-nvme@lists.infradead.org;
>>>> Daniel Jurgens <danielj@mellanox.com>; linux-rdma@vger.kernel.org;
>>>> Devesh Sharma <devesh.sharma@broadcom.com>
>>>> Subject: Re: regression: nvme rdma with bnxt_re0 broken
>>>>
>>>> On Fri, Jul 12, 2019 at 8:19 AM Parav Pandit <parav@mellanox.com>
>> wrote:
>>>>> GID table looks fine.
>>>>>
>>>> The GID table has  fe80:0000:0000:0000:020a:f7ff:fee3:6e32 entry
>>>> repeated 6 times. 2 for each interface bnxt_roce, bnxt_roce.43 and
>>>> bnxt_roce.45. Is this expected to have same gid entries for vlan and
>>>> base interfaces? As you mentioned earlier, driver's assumption that
>>>> only 2 GID entries identical (one for RoCE v1 and one for RoCE
>>>> v2)   is breaking here.
>>>>
>>> Yes, this is correct behavior. Each vlan netdev interface is in
>>> different L2 segment.
>>> Vlan netdev has this ipv6 link local address. Hence, it is added to the GID
>> table.
>>> A given GID table entry is identified uniquely by GID+ndev+type(v1/v2).
>>>
>>> Reviewing bnxt_qplib_add_sgid() does the comparison below.
>>> if (!memcmp(&sgid_tbl->tbl[i], gid, sizeof(*gid))) {
>>>
>>> This comparison looks incomplete which ignore netdev and type.
>>> But even with that, I would expect GID entry addition failure for
>>> vlans for ipv6 link local entries.
>>>
>>> But I am puzzled now, that , with above memcmp() check, how does both
>>> v1 and v2 entries get added in your table and for vlans too?
>>> I expect add_gid() and core/cache.c add_roce_gid () to fail for the
>>> duplicate entry.
>>> But GID table that Yi Zhang dumped has these vlan entries.
>>> I am missing something.
>>>
>> Ah, found it.
>> bnxt_re_add_gid() checks for -EALREADY and returns 0 to add_gid() callback.
>> Ok. so you just need to extend bnxt_qplib_add_sgid() for considering vlan too.
>> Let me see if I can share a patch in few minutes.
>>
>>> Yi Zhang,
>>> Instead of last 15 lines of dmesg, can you please share the whole dmsg
>>> log which should be enabled before creating vlans.
>>> using
>>> echo -n "module ib_core +p" /sys/kernel/debug/dynamic_debug/control
>>>
>>> Selvin,
>>> Additionally, driver shouldn't be looking at the duplicate entries.
>>> core already does it.
>>> You might only want to do for v1/v2 case as bnxt driver has some
>>> dependency with it.
>>> Can you please fix this part?
>>>
> How about below fix?
>
>  From f3f17008d34b5a0c38c190010281a3030a8e5771 Mon Sep 17 00:00:00 2001
> From: Parav Pandit <parav@mellanox.com>
> Date: Fri, 12 Jul 2019 04:34:52 -0500
> Subject: [PATCH] IB/bnxt_re: Honor vlan_id in GID entry comparision
>
> GID entry consist of GID, vlan, netdev and smac.
> Extend GID duplicate check comparions to consider vlan_id as well
> to support IPv6 VLAN based link local addresses.
>
> Fixes: 823b23da7113 ("IB/core: Allow vlan link local address based RoCE GIDs")
> Change-Id: I2e026ec8065c8425ba24fad8525323d112a2f4e4
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> ---
>   drivers/infiniband/hw/bnxt_re/qplib_sp.c | 4 +++-
>   drivers/infiniband/hw/bnxt_re/qplib_sp.h | 1 +
>   2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> index 48793d3512ac..8567b7367669 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> @@ -296,7 +296,8 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
>   	}
>   	free_idx = sgid_tbl->max;
>   	for (i = 0; i < sgid_tbl->max; i++) {
> -		if (!memcmp(&sgid_tbl->tbl[i], gid, sizeof(*gid))) {
> +		if (!memcmp(&sgid_tbl->tbl[i], gid, sizeof(*gid)) &&
> +		    sgid_tbl->tbl[i].vlan_id == vlan_id) {
>   			dev_dbg(&res->pdev->dev,
>   				"SGID entry already exist in entry %d!\n", i);
>   			*index = i;
> @@ -351,6 +352,7 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
>   	}
>   	/* Add GID to the sgid_tbl */
>   	memcpy(&sgid_tbl->tbl[free_idx], gid, sizeof(*gid));
> +	sgid_tbl->tbl[free_idx].vlan_id = vlan_id;
>   	sgid_tbl->active++;
>   	if (vlan_id != 0xFFFF)
>   		sgid_tbl->vlan[free_idx] = 1;
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> index 0ec3b12b0bcd..7a1957c9dc6f 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> @@ -82,6 +82,7 @@ struct bnxt_qplib_pd {
>   
>   struct bnxt_qplib_gid {
>   	u8				data[16];
> +	u16 vlan_id;
>   };
>   
>   struct bnxt_qplib_ah {
