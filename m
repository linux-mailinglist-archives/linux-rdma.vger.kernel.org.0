Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD97914A710
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2020 16:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgA0PVa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jan 2020 10:21:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56242 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729335AbgA0PVa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jan 2020 10:21:30 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00RFDqo9004521;
        Mon, 27 Jan 2020 15:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=G6nOtZz7z/SXI+uoy2CCaKVB3Gg3OdmTXwRzme60H8c=;
 b=jqGBlUShPWh9Y925tMSGUm882V20wmzfAV9+Is18SrnHLRsyM4GGdP3Is6zSpIt5oYuZ
 ThNyyUlHs35qbVUIOeyiM2rxhaJd+FBrsX8YV7rEZTzLw++iXH+cCVTIntCJ0IRIRfXd
 VRQoFl99AsxRB1bPJusHArPCTGGpsyVIp6SCPOhsEU83BYsjZKg9FJY22V0wFVS5iHYz
 5HReFXoq3j01avAJSMX+ySqF9BELBPVALunqftKJ1mQSWNrmoj4SaDsHFI5s2PMFTaci
 uADmwcAAmGy2C3x75psbTsQ1SnsnheVmhZgtFbvT3KvNbO+Q2gokzkTJyxcebEP2G313 pA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xrd3u00pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 15:21:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00RFF2oT138732;
        Mon, 27 Jan 2020 15:21:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2xrytq7t3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 15:21:25 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00RFLONn010513;
        Mon, 27 Jan 2020 15:21:24 GMT
Received: from dhcp-10-175-170-252.vpn.oracle.com (/10.175.170.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jan 2020 07:21:23 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH for-rc v2] IB/mlx4: Fix leak in id_map_find_del
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20200125200349.GA12627@jggl>
Date:   Mon, 27 Jan 2020 16:21:19 +0100
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        rama nichanamatlu <rama.nichanamatlu@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <632562A0-1A5E-4A83-AD57-109743A90280@oracle.com>
References: <20200123155521.1212288-1-haakon.bugge@oracle.com>
 <20200125200349.GA12627@jggl>
To:     Jason <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=11 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001270128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001270128
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 25 Jan 2020, at 21:03, Jason <jgg@ziepe.ca> wrote:
>=20
> On Thu, Jan 23, 2020 at 04:55:21PM +0100, H=C3=A5kon Bugge wrote:
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
>> REJ case enumerated above, one id_map_entry will be leaked.
>>=20
>> For the other case above, a DREQ has been received first. The
>> reception of the DREQ will trigger queuing of a delayed work to =
delete
>> the id_map_entry, for the case where the VM doesn't send back a DREP.
>>=20
>> In the normal case, the VM _will_ send back a DREP, and
>> id_map_find_del() will be called.
>>=20
>> But this scenario introduces a secondary leak. First, when the DREQ =
is
>> received, a delayed work is queued. The VM will then return a DREP,
>> which will call id_map_find_del(). As stated above, this will free =
the
>> TID used from the XArray or IDR. Now, there is window where that
>> particular TID can be re-allocated, lets say by an outgoing REQ. This
>> TID will later be wiped out by the delayed work, when the function
>> id_map_ent_timeout() is called. But the id_map_entry allocated by the
>> outgoing REQ will not be de-allocated, and we have a leak.
>>=20
>> Both leaks are fixed by removing the id_map_find_del() function and
>> only using schedule_delayed(). Of course, a check in
>> schedule_delayed() to see if the work already has been queued, has
>> been added.
>>=20
>> Another benefit of always using the delayed version for deleting
>> entries, is that we do get a TimeWait effect; a TID no longer in use,
>> will occupy the XArray or IDR for CM_CLEANUP_CACHE_TIMEOUT time,
>> without any ability of being re-used for that time period.
>>=20
>> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
>> ---
>=20
> Applied to for-next, I think we are probably done with -rc right now, =
and it
> doesn't have a fixes line or stable cc anyhow.
>=20
> I added
>=20
> Fixes: 3cf69cc8dbeb ("IB/mlx4: Add CM paravirtualization")
>=20
> Though

Indeed ;-) Internal orcl review revealed two use-after-free cases in the =
commit.

When sending (or receiving) a DREQ, we queue delayed work to clean up =
and free the id_map_entry. Now, if the delay in the delayed work =
queueing is in close proximity with the DREP coming back from the =
network (or received from the VM to be sent out on the wire), there is a =
tiny window where the DREP may find its id_map_entry, but before =
schedule_deleayed() is called, the delayed work kicks in and deletes the =
id_map_entry. The now freed id_map_entry will be dereferenced in =
schedule_delayed().

The fix is quite simple, do not call schedule_delayed() for DREPs, since =
work already have been queued when the DREQs were handled.

Expect a fix shortly.


Thxs, H=C3=A5kon


=20
>=20
> Jason

