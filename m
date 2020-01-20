Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 002F8142F07
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2020 16:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgATPwG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jan 2020 10:52:06 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53012 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgATPwG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jan 2020 10:52:06 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00KFmQiY160693;
        Mon, 20 Jan 2020 15:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=N5/Lj6NC1BWUJSC9wysIlSBHVT/pVS8ljpWTszBj3Fs=;
 b=E1+hbXFjPOO1SQNix3aZ0Sgvwn30GSmbhvfeLYRxJKoqzC3x/nOWcPVPgDfzeDguj7mg
 awXEyJXM+Y9Y8qxUyFWMRrxnqWI4Atj151exCi0Qlyof+LGoOhrPts2DY+YQP3TiGHIS
 ZQpxSxIbJuKtT3b+PbqUGCUVtAybSeZLmdZorC8fBI25w0tADse+Wngq1lro7NZ/eRjZ
 /q8wDz/dWP7A7gRaj+Bgfc9mNt+uKJI1rb32vSb1n2RMdKSwrgfS1fsZNETrhTayMIrE
 KDHCM9yNhfVVe9PYFdkGLZ+cLwRpg4QmOdKYp4zl2WAyz43Za2b6HKuvdNuZMfjZwBdo 5A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xkseu8buj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jan 2020 15:52:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00KFnA3L026115;
        Mon, 20 Jan 2020 15:50:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2xmc5ku6jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jan 2020 15:50:00 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00KFnweD020376;
        Mon, 20 Jan 2020 15:49:59 GMT
Received: from dhcp-10-172-157-155.no.oracle.com (/10.172.157.155)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jan 2020 07:49:58 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH for-rc] IB/mlx4: Fix leak in id_map_find_del
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20200120150635.GI51881@unreal>
Date:   Mon, 20 Jan 2020 16:49:56 +0100
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <71091F31-3206-4654-854B-B751F9A96BBC@oracle.com>
References: <20200117135622.836563-1-haakon.bugge@oracle.com>
 <20200120150635.GI51881@unreal>
To:     Leon Romanovsky <leon@kernel.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=11 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001200132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001200132
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 20 Jan 2020, at 16:06, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Fri, Jan 17, 2020 at 02:56:22PM +0100, H=C3=A5kon Bugge wrote:
>> Using CX-3 virtual functions, either from a bare-metal machine or
>> pass-through from a VM, MAD packets are proxied through the PF =
driver.
>>=20
>> Since the VF drivers have separate name spaces for MAD Transaction =
Ids
>> (TIDs), the PF driver has to re-map the TIDs and keep the book =
keeping
>> in a cache.
>>=20
>> Following the RDMA Connection Manager (CM) protocol, it is clear when
>> an entry has to evicted from the cache. When a DREP is sent from
>> mlx4_ib_multiplex_cm_handler(), id_map_find_del() is called. Similar
>> when a REJ is received by the mlx4_ib_demux_cm_handler(),
>> id_map_find_del() is called.
>>=20
>> This function wipes out the TID in use from the IDR or XArray and
>> removes the id_map_entry from the table.
>>=20
>> In short, it does everything except the topping of the cake, which is
>> to remove the entry from the list and free it. In other words, for =
the
>> DREP and REJ cases enumerated above, both will leak one id_map_entry.
>>=20
>> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
>> ---
>> drivers/infiniband/hw/mlx4/cm.c | 7 ++++++-
>> 1 file changed, 6 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/infiniband/hw/mlx4/cm.c =
b/drivers/infiniband/hw/mlx4/cm.c
>> index ecd6cadd529a..1df6d3ccfc62 100644
>> --- a/drivers/infiniband/hw/mlx4/cm.c
>> +++ b/drivers/infiniband/hw/mlx4/cm.c
>> @@ -197,8 +197,13 @@ static void id_map_find_del(struct ib_device =
*ibdev, int pv_cm_id)
>> 	if (!ent)
>> 		goto out;
>> 	found_ent =3D id_map_find_by_sl_id(ibdev, ent->slave_id, =
ent->sl_cm_id);
>> -	if (found_ent && found_ent =3D=3D ent)
>> +	if (found_ent && found_ent =3D=3D ent) {
>> 		rb_erase(&found_ent->node, sl_id_map);
>> +		if (!ent->scheduled_delete) {
>=20
> Why do we need to check scheduled_delete?

1. Node receives a DREQ and mlx4_ib_demux_cm_handler() is called, which =
again calls schedule_delayed(), which sets scheduled_delete.

2. DREQ is proxied over to the VM, which replies with a DREP.

3. The DREP is proxied over to the PF driver, =
mlx4_ib_multiplex_cm_handler() is called, id_map_find_del() is called. =
If it is freed now (without checking scheduled_delete), it will be a =
double free when the delayed work kicks in.

But this documents that the commit message is not accurate, it is only =
the REJ case that has a leak.

> Isn't this to mark call to timeout cleanup (id_map_ent_timeout), which
> can't race with id_map_find_del()? They both hold the same spinlock.

No race, but it can be set as per the above.

If you agree, I will send a v2 with corrected commit message.


Thxs, H=C3=A5kon


>=20
> Thanks
>=20
>> +			list_del(&ent->list);
>> +			kfree(ent);
>> +		}
>> +	}
>> out:
>> 	spin_unlock(&sriov->id_map_lock);
>> }
>> --
>> 2.20.1
>>=20

