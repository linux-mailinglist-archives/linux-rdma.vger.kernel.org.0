Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA85022B29D
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jul 2020 17:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgGWPeZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Jul 2020 11:34:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52510 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgGWPeZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Jul 2020 11:34:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06NFNgki049458;
        Thu, 23 Jul 2020 15:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=3fDGz39i1YJH4jyfDnhNbtLt6w+FON4KfqlQ4mHJc5w=;
 b=KiPm260Eeg8K8ovUGA2PaBUtM/ySPu0bawV/ZmyRTrHVJo/dIArhQOyL98Xfwb9QgL+/
 gXbIPxibSrJsFbBam73KRvQudk91iR22Z1JOepHbrnSrlV8DiYOTFHSj6lyHyEDj+bbg
 nri0b3fDhnzlSjxpQgY2RePQ8FiZ8nHFSC5B8L9tjjWuCoIBji9+wiYOJDCG5aHjeoLy
 NoU0NNvRUHn1bRL4fxlZqYes3UVIUpmiyGpDFB4iEaTwZrfv2kiqb0AfGhtl6LdFjNdd
 jpk9UCtonTdvBRE1ZQWGrH5rv4cNSxtNsHwPDday4/ayyp05UiBaCXmpKWlMM5IYbVBX 1A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 32bs1mt40g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jul 2020 15:34:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06NFOKm5124957;
        Thu, 23 Jul 2020 15:32:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 32fc4qku5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 15:32:17 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06NFWGlp030483;
        Thu, 23 Jul 2020 15:32:16 GMT
Received: from dhcp-10-175-162-184.vpn.oracle.com (/10.175.162.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Jul 2020 08:32:15 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH for-rc 5/5] IB/mlx4: Add support for REJ due to timeout
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20200720122249.487086-6-haakon.bugge@oracle.com>
Date:   Thu, 23 Jul 2020 17:32:12 +0200
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FFDF535E-0B33-46BB-9B14-606C16F7B335@oracle.com>
References: <20200720122249.487086-1-haakon.bugge@oracle.com>
 <20200720122249.487086-6-haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9691 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=11 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9691 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=11 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230115
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 20 Jul 2020, at 14:22, H=C3=A5kon Bugge <haakon.bugge@oracle.com> =
wrote:
>=20
> A CM REJ packet with its reason equal to timeout is a special beast in
> the sense that it doesn't have a Remote Communication ID nor does it
> have a Remote Port GID.
>=20
> Using CX-3 virtual functions, either from a bare-metal machine or
> pass-through from a VM, MAD packets are proxied through the PF driver.
>=20
> Since the VF drivers have separate name spaces for MAD Transaction Ids
> (TIDs), the PF driver has to re-map the TIDs and keep the book keeping
> in a cache.
>=20
> This proxying doesn't not handle said REJ packets.
>=20
> If the active side abandons its connection attempt after having sent a
> REQ, it will send a REJ with the reason being timeout. This example
> can be provoked by a simple user-verbs program, which ends up doing:
>=20
>    rdma_connect(cm_id, &conn_param);
>    rdma_destroy_id(cm_id);
>=20
> using the async librdmacm API.
>=20
> Having dynamic debug prints enabled in the mlx4_ib driver, we will
> then see:
>=20
> mlx4_ib_demux_cm_handler: Couldn't find an entry for pv_cm_id 0x0, =
attr_id 0x12
>=20
> The solution is to introduce a radix-tree. When a REQ packet is
> received and handled in mlx4_ib_demux_cm_handler(), we know the
> connecting peer's para-virtual cm_id and the destination slave. We
> then insert an entry into the tree with said information. We also
> schedule work to remove this entry from the tree and free it, in order
> to avoid memory leak.
>=20
> When a REJ packet with reason timeout is received, we can look up the
> slave in the tree, and deliver the packet to the correct slave.
>=20
> When cleaning up, we simply traverse the tree and modify any delayed
> work to use a zero delay. A subsequent flush of the system_wq will
> ensure all entries being wiped out.
>=20
> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
> ---
> drivers/infiniband/hw/mlx4/cm.c      | 133 ++++++++++++++++++++++++++-
> drivers/infiniband/hw/mlx4/mlx4_ib.h |   3 +
> 2 files changed, 135 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/mlx4/cm.c =
b/drivers/infiniband/hw/mlx4/cm.c
> index 6f0ffd0906e6..883436548901 100644
> --- a/drivers/infiniband/hw/mlx4/cm.c
> +++ b/drivers/infiniband/hw/mlx4/cm.c
> @@ -54,11 +54,22 @@ struct id_map_entry {
> 	struct delayed_work timeout;
> };
>=20
> +struct rej_tmout_entry {
> +	int slave;
> +	u32 rem_pv_cm_id;
> +	struct delayed_work timeout;
> +	struct radix_tree_root *rej_tmout_root;
> +	/* Points to the mutex protecting this radix-tree */
> +	struct mutex *lock;
> +};
> +
> struct cm_generic_msg {
> 	struct ib_mad_hdr hdr;
>=20
> 	__be32 local_comm_id;
> 	__be32 remote_comm_id;
> +	unsigned char unused[2];
> +	__be16 rej_reason;
> };
>=20
> struct cm_sidr_generic_msg {
> @@ -285,6 +296,7 @@ static void schedule_delayed(struct ib_device =
*ibdev, struct id_map_entry *id)
> 	spin_unlock(&sriov->id_map_lock);
> }
>=20
> +#define REJ_REASON(m) be16_to_cpu(((struct cm_generic_msg =
*)(m))->rej_reason)
> int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, =
int slave_id,
> 		struct ib_mad *mad)
> {
> @@ -295,7 +307,8 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device =
*ibdev, int port, int slave_id
> 	if (mad->mad_hdr.attr_id =3D=3D CM_REQ_ATTR_ID ||
> 	    mad->mad_hdr.attr_id =3D=3D CM_REP_ATTR_ID ||
> 	    mad->mad_hdr.attr_id =3D=3D CM_MRA_ATTR_ID ||
> -	    mad->mad_hdr.attr_id =3D=3D CM_SIDR_REQ_ATTR_ID) {
> +	    mad->mad_hdr.attr_id =3D=3D CM_SIDR_REQ_ATTR_ID ||
> +	    (mad->mad_hdr.attr_id =3D=3D CM_REJ_ATTR_ID && =
REJ_REASON(mad) =3D=3D IB_CM_REJ_TIMEOUT)) {
> 		sl_cm_id =3D get_local_comm_id(mad);
> 		id =3D id_map_get(ibdev, &pv_cm_id, slave_id, sl_cm_id);
> 		if (id)
> @@ -328,11 +341,87 @@ int mlx4_ib_multiplex_cm_handler(struct =
ib_device *ibdev, int port, int slave_id
> 	return 0;
> }
>=20
> +static void rej_tmout_timeout(struct work_struct *work)
> +{
> +	struct delayed_work *delay =3D to_delayed_work(work);
> +	struct rej_tmout_entry *item =3D container_of(delay, struct =
rej_tmout_entry, timeout);
> +	struct rej_tmout_entry *deleted;
> +
> +	mutex_lock(item->lock);
> +	deleted =3D radix_tree_delete_item(item->rej_tmout_root, =
item->rem_pv_cm_id, NULL);
> +	mutex_unlock(item->lock);
> +
> +	if (deleted !=3D item)
> +		pr_debug("deleted(%p) !=3D item(%p)\n", deleted, item);
> +
> +	pr_debug("rej_tmout entry, rem_pv_cm_id 0x%x, slave %d =
deleted\n",
> +		 item->rem_pv_cm_id, item->slave);
> +	kfree(item);
> +}
> +
> +static int alloc_rej_tmout(struct mlx4_ib_sriov *sriov, u32 =
rem_pv_cm_id, int slave)
> +{
> +	struct rej_tmout_entry *item;
> +	int sts;
> +
> +	mutex_lock(&sriov->rej_tmout_lock);
> +	item =3D radix_tree_lookup(&sriov->rej_tmout_root, (unsigned =
long)rem_pv_cm_id);
> +	mutex_unlock(&sriov->rej_tmout_lock);
> +	if (item)
> +		return PTR_ERR(item);

Hmm, this shall read:
		return IS_ERR(item) ? PTR_ERR(item) : 0;

I'll also remove the noisy pr_debug()s in this commit.

Will wait before sending out a v2.


Thxs, H=C3=A5kon


> +
> +	item =3D kmalloc(sizeof(*item), GFP_KERNEL);
> +	if (!item)
> +		return -ENOMEM;
> +
> +	INIT_DELAYED_WORK(&item->timeout, rej_tmout_timeout);
> +	item->slave =3D slave;
> +	item->rem_pv_cm_id =3D rem_pv_cm_id;
> +	item->rej_tmout_root =3D &sriov->rej_tmout_root;
> +	item->lock =3D &sriov->rej_tmout_lock;
> +
> +	mutex_lock(&sriov->rej_tmout_lock);
> +	sts =3D radix_tree_insert(&sriov->rej_tmout_root, (unsigned =
long)rem_pv_cm_id, item);
> +	mutex_unlock(&sriov->rej_tmout_lock);
> +	if (sts)
> +		goto err_insert;
> +
> +	pr_debug("Inserted rem_pv_cm_id 0x%x slave %d\n", rem_pv_cm_id, =
slave);
> +	schedule_delayed_work(&item->timeout, CM_CLEANUP_CACHE_TIMEOUT);
> +
> +	return 0;
> +
> +err_insert:
> +	kfree(item);
> +	return sts;
> +}
> +
> +static int lookup_rej_tmout_slave(struct mlx4_ib_sriov *sriov, u32 =
rem_pv_cm_id)
> +{
> +	struct rej_tmout_entry *item;
> +
> +	mutex_lock(&sriov->rej_tmout_lock);
> +	item =3D radix_tree_lookup(&sriov->rej_tmout_root, (unsigned =
long)rem_pv_cm_id);
> +	mutex_unlock(&sriov->rej_tmout_lock);
> +
> +	if (!item || IS_ERR(item)) {
> +		pr_debug("Could not find rem_pv_cm_id 0x%x error: %d\n",
> +			 rem_pv_cm_id, (int)PTR_ERR(item));
> +		return !item ? -ENOENT : PTR_ERR(item);
> +	}
> +	pr_debug("Found rem_pv_cm_id 0x%x slave: %d\n", rem_pv_cm_id, =
item->slave);
> +
> +	return item->slave;
> +}
> +
> int mlx4_ib_demux_cm_handler(struct ib_device *ibdev, int port, int =
*slave,
> 			     struct ib_mad *mad)
> {
> +	struct mlx4_ib_sriov *sriov =3D &to_mdev(ibdev)->sriov;
> +	u32 rem_pv_cm_id =3D get_local_comm_id(mad);
> 	u32 pv_cm_id;
> 	struct id_map_entry *id;
> +	int sts;
>=20
> 	if (mad->mad_hdr.attr_id =3D=3D CM_REQ_ATTR_ID ||
> 	    mad->mad_hdr.attr_id =3D=3D CM_SIDR_REQ_ATTR_ID) {
> @@ -348,7 +437,18 @@ int mlx4_ib_demux_cm_handler(struct ib_device =
*ibdev, int port, int *slave,
> 				     =
be64_to_cpu(gid.global.interface_id));
> 			return -ENOENT;
> 		}
> +
> +		sts =3D alloc_rej_tmout(sriov, rem_pv_cm_id, *slave);
> +		if (sts)
> +			/* Even if this fails, we pass on the REQ to the =
slave */
> +			pr_debug("Could not allocate rej_tmout entry. =
rem_pv_cm_id 0x%x slave %d status %d\n",
> +				 rem_pv_cm_id, *slave, sts);
> +
> 		return 0;
> +	} else if (mad->mad_hdr.attr_id =3D=3D CM_REJ_ATTR_ID && =
REJ_REASON(mad) =3D=3D IB_CM_REJ_TIMEOUT) {
> +		*slave =3D lookup_rej_tmout_slave(sriov, rem_pv_cm_id);
> +
> +		return *slave < 0 ? *slave : 0;
> 	}
>=20
> 	pv_cm_id =3D get_remote_comm_id(mad);
> @@ -377,6 +477,35 @@ void mlx4_ib_cm_paravirt_init(struct mlx4_ib_dev =
*dev)
> 	INIT_LIST_HEAD(&dev->sriov.cm_list);
> 	dev->sriov.sl_id_map =3D RB_ROOT;
> 	xa_init_flags(&dev->sriov.pv_id_table, XA_FLAGS_ALLOC);
> +	mutex_init(&dev->sriov.rej_tmout_lock);
> +	INIT_RADIX_TREE(&dev->sriov.rej_tmout_root, GFP_KERNEL);
> +}
> +
> +static void rej_tmout_tree_cleanup(struct mlx4_ib_sriov *sriov, int =
slave)
> +{
> +	struct radix_tree_iter iter;
> +	bool flush_needed =3D false;
> +	void **slot;
> +	int cnt =3D 0;
> +
> +	mutex_lock(&sriov->rej_tmout_lock);
> +	radix_tree_for_each_slot(slot, &sriov->rej_tmout_root, &iter, 0) =
{
> +		struct rej_tmout_entry *item =3D *slot;
> +
> +		if (slave < 0 || slave =3D=3D item->slave) {
> +			mod_delayed_work(system_wq, &item->timeout, 0);
> +			flush_needed =3D true;
> +			++cnt;
> +		}
> +	}
> +	mutex_unlock(&sriov->rej_tmout_lock);
> +
> +	if (flush_needed) {
> +		flush_scheduled_work();
> +
> +		pr_debug("%d entries in radix_tree for slave %d during =
cleanup\n",
> +			 slave, cnt);
> +	}
> }
>=20
> /* slave =3D -1 =3D=3D> all slaves */
> @@ -446,4 +575,6 @@ void mlx4_ib_cm_paravirt_clean(struct mlx4_ib_dev =
*dev, int slave)
> 		list_del(&map->list);
> 		kfree(map);
> 	}
> +
> +	rej_tmout_tree_cleanup(sriov, slave);
> }
> diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h =
b/drivers/infiniband/hw/mlx4/mlx4_ib.h
> index 20cfa69d0aed..92cb686bdc49 100644
> --- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
> +++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
> @@ -495,6 +495,9 @@ struct mlx4_ib_sriov {
> 	spinlock_t id_map_lock;
> 	struct rb_root sl_id_map;
> 	struct list_head cm_list;
> +	/* Protects the radix-tree */
> +	struct mutex rej_tmout_lock;
> +	struct radix_tree_root rej_tmout_root;
> };
>=20
> struct gid_cache_context {
> --=20
> 2.20.1
>=20

