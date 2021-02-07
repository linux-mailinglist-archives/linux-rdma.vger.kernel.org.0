Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A397C31212D
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Feb 2021 04:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhBGDdo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 6 Feb 2021 22:33:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48121 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229506AbhBGDdm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 6 Feb 2021 22:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612668735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S3YHuqau/As2BMONsOCJthOx9TqWTUqohW8ZVPiEfJU=;
        b=ctslhNtEmACRX4QoNmJhN2mXPiAO4uERXU7W/sbdEImj6VrDXTFFuGd2ea87Qb5ipktzIx
        OVBnqWQBXykQFGQUqRgGxFHtu5v+D9/EZqY1ZRb38lad6QHiZ6OldfPABP8u7vea1bZTR1
        HicOjJwDwZQ5RjMpDvTYs4B1hdOQx9M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-eTAOY97hMgG_-Hb7I8l2cA-1; Sat, 06 Feb 2021 22:32:13 -0500
X-MC-Unique: eTAOY97hMgG_-Hb7I8l2cA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BF8C803648;
        Sun,  7 Feb 2021 03:32:12 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-23.pek2.redhat.com [10.72.12.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 452256F977;
        Sun,  7 Feb 2021 03:32:08 +0000 (UTC)
Subject: Re: [PATCH for-rc] RDMA/siw: Fix calculation of tx_valid_cpus size
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20210201112922.141085-1-kamalheib1@gmail.com>
 <OF20B9AA82.73348CC3-ON0025866F.0049DCAB-0025866F.0049DCB6@notes.na.collabserv.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <c7c3c724-2423-cf23-36c2-d4eb23e28aa7@redhat.com>
Date:   Sun, 7 Feb 2021 11:32:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <OF20B9AA82.73348CC3-ON0025866F.0049DCAB-0025866F.0049DCB6@notes.na.collabserv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/1/21 9:26 PM, Bernard Metzler wrote:
> -----"Kamal Heib" <kamalheib1@gmail.com> wrote: -----
>
>> To: linux-rdma@vger.kernel.org
>> From: "Kamal Heib" <kamalheib1@gmail.com>
>> Date: 02/01/2021 12:30PM
>> Cc: "Bernard Metzler" <bmt@zurich.ibm.com>, "Doug Ledford"
>> <dledford@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Kamal Heib"
>> <kamalheib1@gmail.com>
>> Subject: [EXTERNAL] [PATCH for-rc] RDMA/siw: Fix calculation of
>> tx_valid_cpus size
>>
>> The size of tx_valid_cpus was calculated under the assumption that
>> the
>> numa nodes identifiers are continuous, which is not the case in all
>> archs as this could lead to the following panic when trying to access
>> an
>> invalid tx_valid_cpus index, avoid the following panic by using
>> nr_node_ids instead of num_online_nodes() to allocate the
>> tx_valid_cpus
>> size.
>>
> Uuups! Thanks for fixing this. nr_node_ids is indeed the right
> resource here, since it's set reflecting the highest bit + 1
> from node_possible_map.bits.
>
> Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
Thanks Kamal, just verified this patch on my power server, feel free to add
Tested-by: Yi Zhang <yi.zhang@redhat.com>

>
>> Kernel attempted to read user page (8) - exploit attempt? (uid: 0)
>> BUG: Kernel NULL pointer dereference on read at 0x00000008
>> Faulting instruction address: 0xc0080000081b4a90
>> Oops: Kernel access of bad area, sig: 11 [#1]
>> LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
>> Modules linked in: siw(+) rfkill rpcrdma ib_isert iscsi_target_mod
>> ib_iser libiscsi scsi_transport_iscsi ib_srpt target_core_mod ib_srp
>> scsi_transport_srp ib_ipoib rdma_ucm sunrpc ib_umad rdma_cm ib_cm
>> iw_cm i40iw ib_uverbs ib_core i40e ses enclosure scsi_transport_sas
>> ipmi_powernv ibmpowernv at24 ofpart ipmi_devintf regmap_i2c
>> ipmi_msghandler powernv_flash uio_pdrv_genirq uio mtd opal_prd zram
>> ip_tables xfs libcrc32c sd_mod t10_pi ast i2c_algo_bit
>> drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt
>> fb_sys_fops cec drm_ttm_helper ttm drm vmx_crypto aacraid
>> drm_panel_orientation_quirks dm_mod
>> CPU: 40 PID: 3279 Comm: modprobe Tainted: G        W      X ---------
>> ---  5.11.0-0.rc4.129.eln108.ppc64le #2
>> NIP:  c0080000081b4a90 LR: c0080000081b4a2c CTR: c0000000007ce1c0
>> REGS: c000000027fa77b0 TRAP: 0300   Tainted: G        W      X
>> --------- ---   (5.11.0-0.rc4.129.eln108.ppc64le)
>> MSR:  9000000002009033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 44224882
>> XER: 00000000
>> CFAR: c0000000007ce200 DAR: 0000000000000008 DSISR: 40000000 IRQMASK:
>> 0
>> GPR00: c0080000081b4a2c c000000027fa7a50 c0080000081c3900
>> 0000000000000040
>> GPR04: c000000002023080 c000000012e1c300 000020072ad70000
>> 0000000000000001
>> GPR08: c000000001726068 0000000000000008 0000000000000008
>> c0080000081b5758
>> GPR12: c0000000007ce1c0 c0000007fffc3000 00000001590b1e40
>> 0000000000000000
>> GPR16: 0000000000000000 0000000000000001 000000011ad68fc8
>> 00007fffcc09c5c8
>> GPR20: 0000000000000008 0000000000000000 00000001590b2850
>> 00000001590b1d30
>> GPR24: 0000000000043d68 000000011ad67a80 000000011ad67a80
>> 0000000000100000
>> GPR28: c000000012e1c300 c0000000020271c8 0000000000000001
>> c0080000081bf608
>> NIP [c0080000081b4a90] siw_init_cpulist+0x194/0x214 [siw]
>> LR [c0080000081b4a2c] siw_init_cpulist+0x130/0x214 [siw]
>> Call Trace:
>> [c000000027fa7a50] [c0080000081b4a2c] siw_init_cpulist+0x130/0x214
>> [siw] (unreliable)
>> [c000000027fa7a90] [c0080000081b4e68] siw_init_module+0x40/0x2a0
>> [siw]
>> [c000000027fa7b30] [c0000000000124f4] do_one_initcall+0x84/0x2e0
>> [c000000027fa7c00] [c000000000267ffc] do_init_module+0x7c/0x350
>> [c000000027fa7c90] [c00000000026a180]
>> __do_sys_init_module+0x210/0x250
>> [c000000027fa7db0] [c0000000000387e4]
>> system_call_exception+0x134/0x230
>> [c000000027fa7e10] [c00000000000d660] system_call_common+0xf0/0x27c
>> Instruction dump:
>> 40810044 3d420000 e8bf0000 e88a82d0 3d420000 e90a82c8 792a1f24
>> 7cc4302a
>> 7d2642aa 79291f24 7d25482a 7d295214 <7d4048a8> 7d4a3b78 7d4049ad
>> 40c2fff4
>> ---[ end trace 813d4c362755dcfc ]---
>>
>> Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
>> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>> ---
>> drivers/infiniband/sw/siw/siw_main.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_main.c
>> b/drivers/infiniband/sw/siw/siw_main.c
>> index ee95cf29179d..41c46dfaebf6 100644
>> --- a/drivers/infiniband/sw/siw/siw_main.c
>> +++ b/drivers/infiniband/sw/siw/siw_main.c
>> @@ -135,7 +135,7 @@ static struct {
>>
>> static int siw_init_cpulist(void)
>> {
>> -	int i, num_nodes = num_possible_nodes();
>> +	int i, num_nodes = nr_node_ids;
>>
>> 	memset(siw_tx_thread, 0, sizeof(siw_tx_thread));
>>
>> -- 
>> 2.26.2
>>
>>

