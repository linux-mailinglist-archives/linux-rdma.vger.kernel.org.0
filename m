Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC8C142DAB
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2020 15:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgATOgP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jan 2020 09:36:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49438 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgATOgP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jan 2020 09:36:15 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00KEYu21097967;
        Mon, 20 Jan 2020 14:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=chQHy13sJAVJpm9Og3eC0nZapv1bim8jex7PkwzlGPY=;
 b=FK9EfmsU+7XiaqLRSVUcrDoaxbexP8EuO98MM3Yde8UnM1ull8ZAWIfoZUX7YjzhWThq
 LDW7FUUacY56ih49sOT2wULQCPSZztmF/kDEzL6U5xz2lXXcPc4sw4h6tueRacNZKHFw
 pmRVJRx/3aaTKvZpuM9ktAo3i5h/FJW0GoZmFZw/AKVqX8/Gtttub+Qa+CvEDk8voTQh
 cJmpiMHCPEJIqQsLXBi6iEL1vZysNhOyEosodY76Iy/f1SIqRBOJxMVsFESWkpJSsnM8
 PTf/u85M99FjAzibznlfYtW8z5CPxXHO6FC+CNVJjmqD8ANmKGZEFevCVn/Oj3XLxoip Pw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xkseu7xkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jan 2020 14:36:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00KEYrsB001858;
        Mon, 20 Jan 2020 14:36:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2xmbj273u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jan 2020 14:36:09 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00KEa8Es021597;
        Mon, 20 Jan 2020 14:36:08 GMT
Received: from dhcp-10-172-157-155.no.oracle.com (/10.172.157.155)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jan 2020 06:36:08 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH for-rc] IB/mlx4: Fix leak in id_map_find_del
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20200117135622.836563-1-haakon.bugge@oracle.com>
Date:   Mon, 20 Jan 2020 15:36:06 +0100
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <471E808E-D97E-4224-A4DE-EDA61463FC28@oracle.com>
References: <20200117135622.836563-1-haakon.bugge@oracle.com>
To:     Yishai Hadas <yishaih@mellanox.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9505 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=11 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001200124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9505 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001200124
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 17 Jan 2020, at 14:56, H=C3=A5kon Bugge <haakon.bugge@oracle.com> =
wrote:
>=20
> Using CX-3 virtual functions, either from a bare-metal machine or
> pass-through from a VM, MAD packets are proxied through the PF driver.
>=20
> Since the VF drivers have separate name spaces for MAD Transaction Ids
> (TIDs), the PF driver has to re-map the TIDs and keep the book keeping
> in a cache.
>=20
> Following the RDMA Connection Manager (CM) protocol, it is clear when
> an entry has to evicted from the cache. When a DREP is sent from
> mlx4_ib_multiplex_cm_handler(), id_map_find_del() is called. Similar
> when a REJ is received by the mlx4_ib_demux_cm_handler(),
> id_map_find_del() is called.
>=20
> This function wipes out the TID in use from the IDR or XArray and
> removes the id_map_entry from the table.
>=20
> In short, it does everything except the topping of the cake, which is
> to remove the entry from the list and free it. In other words, for the
> DREP and REJ cases enumerated above, both will leak one id_map_entry.
>=20
> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>

When/if this gets merged, please add:

Cc: stable@vger.kernel.org

Thxs, H=C3=A5kon

> ---
> drivers/infiniband/hw/mlx4/cm.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/mlx4/cm.c =
b/drivers/infiniband/hw/mlx4/cm.c
> index ecd6cadd529a..1df6d3ccfc62 100644
> --- a/drivers/infiniband/hw/mlx4/cm.c
> +++ b/drivers/infiniband/hw/mlx4/cm.c
> @@ -197,8 +197,13 @@ static void id_map_find_del(struct ib_device =
*ibdev, int pv_cm_id)
> 	if (!ent)
> 		goto out;
> 	found_ent =3D id_map_find_by_sl_id(ibdev, ent->slave_id, =
ent->sl_cm_id);
> -	if (found_ent && found_ent =3D=3D ent)
> +	if (found_ent && found_ent =3D=3D ent) {
> 		rb_erase(&found_ent->node, sl_id_map);
> +		if (!ent->scheduled_delete) {
> +			list_del(&ent->list);
> +			kfree(ent);
> +		}
> +	}
> out:
> 	spin_unlock(&sriov->id_map_lock);
> }
> --=20
> 2.20.1
>=20

