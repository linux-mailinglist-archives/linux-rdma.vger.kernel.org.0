Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C55288A54
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 16:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbgJIOJr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 10:09:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47512 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgJIOJr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 10:09:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 099E9gkO020194;
        Fri, 9 Oct 2020 14:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=8N9F8XvrWX/aOWRn7HwoV2sJCZSIV7wIV/d40LPMW5A=;
 b=mVHifqJlTrF8xCDiTZGZUxXf9+VoXfGGPgQeMm0z6bMeYy2fHDS2YAbv9+kGUcNudhgv
 QCh1AQteZddWZ9DYEbuFzh2Z1kpeUwyIJ+2ewp47ksWWI3VJ3vN+4TRCAj+svONuCxCv
 y8BDhyxWgNWKBA7UUHO0sXYfaI0Sg+wJ+o54/m+FWs25fZGPOkhufeUiKFkx4mYYRcE7
 ikqiwD//QAUYh1bwcFJ08zlafeMGA90aaQnWTod3Kky5xRKUE9nFO40f0+MJ7tK3Wq6d
 qBIEJpwjh1RimwLTUROd+xYW9vJgwsvvTvke9yhh8MgcvSFCd7bulG6+aZ40Kzy9l9mT Fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 3429jmkq0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 09 Oct 2020 14:09:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 099E9Ffu171495;
        Fri, 9 Oct 2020 14:09:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3429k15n7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Oct 2020 14:09:42 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 099E9frH005909;
        Fri, 9 Oct 2020 14:09:41 GMT
Received: from dhcp-10-175-176-72.vpn.oracle.com (/10.175.176.72)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Oct 2020 07:09:41 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH for-next] IB/mlx4: Convert rej_tmout radix-tree to XArray
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20201008185618.GK5177@ziepe.ca>
Date:   Fri, 9 Oct 2020 16:09:38 +0200
Cc:     Yishai Hadas <yishaih@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <31AA5B19-0C52-4F2F-8DAF-B5DDD4EC8706@oracle.com>
References: <1601989634-4595-1-git-send-email-haakon.bugge@oracle.com>
 <20201008185618.GK5177@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=3 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010090103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=3
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010090103
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 8 Oct 2020, at 20:56, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> On Tue, Oct 06, 2020 at 03:07:14PM +0200, H=C3=A5kon Bugge wrote:
>> Fixes: b7d8e64fa9db ("IB/mlx4: Add support for REJ due to timeout")
>>=20
>> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
>> drivers/infiniband/hw/mlx4/cm.c      | 73 =
+++++++++++++++---------------------
>> drivers/infiniband/hw/mlx4/mlx4_ib.h |  4 +-
>> 2 files changed, 32 insertions(+), 45 deletions(-)
>>=20
>> diff --git a/drivers/infiniband/hw/mlx4/cm.c =
b/drivers/infiniband/hw/mlx4/cm.c
>> index 0ce4b5a..6c7986b 100644
>> +++ b/drivers/infiniband/hw/mlx4/cm.c
>> @@ -58,9 +58,7 @@ struct rej_tmout_entry {
>> 	int slave;
>> 	u32 rem_pv_cm_id;
>> 	struct delayed_work timeout;
>> -	struct radix_tree_root *rej_tmout_root;
>> -	/* Points to the mutex protecting this radix-tree */
>> -	struct mutex *lock;
>> +	struct xarray *xa_rej_tmout;
>> };
>>=20
>> struct cm_generic_msg {
>> @@ -350,9 +348,7 @@ static void rej_tmout_timeout(struct work_struct =
*work)
>> 	struct rej_tmout_entry *item =3D container_of(delay, struct =
rej_tmout_entry, timeout);
>> 	struct rej_tmout_entry *deleted;
>>=20
>> -	mutex_lock(item->lock);
>> -	deleted =3D radix_tree_delete_item(item->rej_tmout_root, =
item->rem_pv_cm_id, NULL);
>> -	mutex_unlock(item->lock);
>> +	deleted =3D xa_cmpxchg(item->xa_rej_tmout, item->rem_pv_cm_id, =
item, NULL, 0);
>>=20
>> 	if (deleted !=3D item)
>> 		pr_debug("deleted(%p) !=3D item(%p)\n", deleted, item);
>> @@ -363,14 +359,13 @@ static void rej_tmout_timeout(struct =
work_struct *work)
>> static int alloc_rej_tmout(struct mlx4_ib_sriov *sriov, u32 =
rem_pv_cm_id, int slave)
>> {
>> 	struct rej_tmout_entry *item;
>> -	int sts;
>> +	struct rej_tmout_entry *old;
>> +
>> +	item =3D xa_load(&sriov->xa_rej_tmout, (unsigned =
long)rem_pv_cm_id);
>=20
> The locking that was here looks wrong, rej_tmout_timeout() is a work
> that could run at any time and kfree(item), so some kind of lock must
> be held across every touch to item
>=20
> Holding the xa_lock until the mod_delayed_work is done would be ok?


Good catch. I focused too much on the XArray itself. That works, but as =
you point out, dereferencing item with no locking is a no-no.

Will send a v2.


Thxs for review, H=C3=A5kon


>=20
>> static int lookup_rej_tmout_slave(struct mlx4_ib_sriov *sriov, u32 =
rem_pv_cm_id)
>> {
>> 	struct rej_tmout_entry *item;
>>=20
>> -	mutex_lock(&sriov->rej_tmout_lock);
>> -	item =3D radix_tree_lookup(&sriov->rej_tmout_root, (unsigned =
long)rem_pv_cm_id);
>> -	mutex_unlock(&sriov->rej_tmout_lock);
>> +	item =3D xa_load(&sriov->xa_rej_tmout, (unsigned =
long)rem_pv_cm_id);
>>=20
>> -	if (!item || IS_ERR(item)) {
>> +	if (!item || xa_err(item)) {
>> 		pr_debug("Could not find slave. rem_pv_cm_id 0x%x error: =
%d\n",
>> -			 rem_pv_cm_id, (int)PTR_ERR(item));
>> -		return !item ? -ENOENT : PTR_ERR(item);
>> +			 rem_pv_cm_id, xa_err(item));
>> +		return !item ? -ENOENT : xa_err(item);
>> 	}
>>=20
>> 	return item->slave;
>=20
> Here too
>=20
>> +	xa_lock(&sriov->xa_rej_tmout);
>> +	xa_for_each(&sriov->xa_rej_tmout, id, item) {
>> 		if (slave < 0 || slave =3D=3D item->slave) {
>> 			mod_delayed_work(system_wq, &item->timeout, 0);
>> 			flush_needed =3D true;
>> 			++cnt;
>> 		}
>> 	}
>> -	mutex_unlock(&sriov->rej_tmout_lock);
>> +	xa_unlock(&sriov->xa_rej_tmout);
>=20
> This is OK
>=20
> Jason

