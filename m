Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE9D143F81
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2020 15:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgAUO2X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jan 2020 09:28:23 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33220 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbgAUO2X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jan 2020 09:28:23 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00LENE4t174817;
        Tue, 21 Jan 2020 14:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=A9Z8ZoEtP+zYKp2aOcBRoCyP/+Dbwb03siRgfamSWts=;
 b=JIltM2fmUdqpEnd35tavDhnd7ydPF3Z/bkMtc5SadooMnCsrthoNEv/0Bz+MqxFpCddS
 6WpwZ4PQzFe2anMd/wvPo7TKv1cAb/f84juDIJCXLnjyVmEJZjDcsACL1eHBrZrl15kJ
 FyT23g/wsvGS4b5uJj+2KGkKTBHyJ/1ecAk76FPmom2NQGL5aRSvYuBvtemujeDbGcc8
 NfjIN4mi6M5VqrE/i7WPQADLCyBtopcZ2iDNFrMhtB4uiQES0sTZjVnk6KZ/6XFeAQD1
 Yqe7ovdia6ePc3fPyGAactVfJ1Va1ipXFdldj7NGGUHXf2cj5UZiiKZLP8QXxRNfhMer lA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xkseuddns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 14:28:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00LEOCk8132760;
        Tue, 21 Jan 2020 14:26:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2xnpee2yxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 14:26:16 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00LEQG0H007289;
        Tue, 21 Jan 2020 14:26:16 GMT
Received: from dhcp-10-172-157-155.no.oracle.com (/10.172.157.155)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Jan 2020 06:26:16 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH for-rc] IB/mlx4: Fix leak in id_map_find_del
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20200120162751.GJ51881@unreal>
Date:   Tue, 21 Jan 2020 15:26:13 +0100
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3109D1ED-6F55-40C8-A947-5A68FF8A832D@oracle.com>
References: <20200117135622.836563-1-haakon.bugge@oracle.com>
 <20200120150635.GI51881@unreal>
 <71091F31-3206-4654-854B-B751F9A96BBC@oracle.com>
 <20200120162751.GJ51881@unreal>
To:     Leon Romanovsky <leon@kernel.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=11 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001210120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001210120
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 20 Jan 2020, at 17:27, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Mon, Jan 20, 2020 at 04:49:56PM +0100, H=C3=A5kon Bugge wrote:
>>=20
>>=20
>>> On 20 Jan 2020, at 16:06, Leon Romanovsky <leon@kernel.org> wrote:
>>>=20
>>> On Fri, Jan 17, 2020 at 02:56:22PM +0100, H=C3=A5kon Bugge wrote:
>>>> Using CX-3 virtual functions, either from a bare-metal machine or
>>>> pass-through from a VM, MAD packets are proxied through the PF =
driver.
>>>>=20
>>>> Since the VF drivers have separate name spaces for MAD Transaction =
Ids
>>>> (TIDs), the PF driver has to re-map the TIDs and keep the book =
keeping
>>>> in a cache.
>>>>=20
>>>> Following the RDMA Connection Manager (CM) protocol, it is clear =
when
>>>> an entry has to evicted from the cache. When a DREP is sent from
>>>> mlx4_ib_multiplex_cm_handler(), id_map_find_del() is called. =
Similar
>>>> when a REJ is received by the mlx4_ib_demux_cm_handler(),
>>>> id_map_find_del() is called.
>>>>=20
>>>> This function wipes out the TID in use from the IDR or XArray and
>>>> removes the id_map_entry from the table.
>>>>=20
>>>> In short, it does everything except the topping of the cake, which =
is
>>>> to remove the entry from the list and free it. In other words, for =
the
>>>> DREP and REJ cases enumerated above, both will leak one =
id_map_entry.
>>>>=20
>>>> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
>>>> ---
>>>> drivers/infiniband/hw/mlx4/cm.c | 7 ++++++-
>>>> 1 file changed, 6 insertions(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/drivers/infiniband/hw/mlx4/cm.c =
b/drivers/infiniband/hw/mlx4/cm.c
>>>> index ecd6cadd529a..1df6d3ccfc62 100644
>>>> --- a/drivers/infiniband/hw/mlx4/cm.c
>>>> +++ b/drivers/infiniband/hw/mlx4/cm.c
>>>> @@ -197,8 +197,13 @@ static void id_map_find_del(struct ib_device =
*ibdev, int pv_cm_id)
>>>> 	if (!ent)
>>>> 		goto out;
>>>> 	found_ent =3D id_map_find_by_sl_id(ibdev, ent->slave_id, =
ent->sl_cm_id);
>>>> -	if (found_ent && found_ent =3D=3D ent)
>>>> +	if (found_ent && found_ent =3D=3D ent) {
>>>> 		rb_erase(&found_ent->node, sl_id_map);
>>>> +		if (!ent->scheduled_delete) {
>>>=20
>>> Why do we need to check scheduled_delete?
>>=20
>> 1. Node receives a DREQ and mlx4_ib_demux_cm_handler() is called, =
which again calls schedule_delayed(), which sets scheduled_delete.
>>=20
>> 2. DREQ is proxied over to the VM, which replies with a DREP.
>>=20
>> 3. The DREP is proxied over to the PF driver, =
mlx4_ib_multiplex_cm_handler() is called, id_map_find_del() is called. =
If it is freed now (without checking scheduled_delete), it will be a =
double free when the delayed work kicks in.
>=20
> It will be the case if we don't cancel delayed work inside
> id_map_find_del(), but it raises other question. Why do we need two
> identical delete functions?

Almost identical. It's a question about being evolutionary vs. =
revolutionary, when fixing a leak. My preference would be to fix the =
leak as simple as possible, without changing any logic.

> Can we convert id_map_find_del() callers
> to use id_map_ent_timeout() instead?

I did the opposite, and I will send it out as a v2 after testing. But, I =
didn't like it. Fewer lines, yes, but more complexity.


Thxs, H=C3=A5kon

>=20
> Thanks
>=20
>>=20
>> But this documents that the commit message is not accurate, it is =
only the REJ case that has a leak.
>>=20
>>> Isn't this to mark call to timeout cleanup (id_map_ent_timeout), =
which
>>> can't race with id_map_find_del()? They both hold the same spinlock.
>>=20
>> No race, but it can be set as per the above.
>>=20
>> If you agree, I will send a v2 with corrected commit message.
>>=20
>>=20
>> Thxs, H=C3=A5kon
>>=20
>>=20
>>>=20
>>> Thanks
>>>=20
>>>> +			list_del(&ent->list);
>>>> +			kfree(ent);
>>>> +		}
>>>> +	}
>>>> out:
>>>> 	spin_unlock(&sriov->id_map_lock);
>>>> }
>>>> --
>>>> 2.20.1

