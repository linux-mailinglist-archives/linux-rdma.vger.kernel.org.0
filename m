Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24A28E3379
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 15:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502348AbfJXNH4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 09:07:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22992 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732588AbfJXNH4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Oct 2019 09:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571922474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/mP46+A29h+9KH4NmzTY3ov42WTkRcwR12iQgmX6l8=;
        b=TPxtWRslFwWS1IAvMMG2Ut86H/8tnPguUiHDfnJ4D1o85tplyuiuL4sZ3v8snSFmRLCf9f
        YfD9aCy5EXhnnaKDZpaLBJW5zF+PL0amszI8mzdyyXifiGjCvbvJvO6NXghjBphV4Uu+Tk
        yta6D9YtTEFn83HaHexEHklKQuHvFWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-QJNQ_4QHMa6fHM4K-7h1cQ-1; Thu, 24 Oct 2019 09:07:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C57D0800D49;
        Thu, 24 Oct 2019 13:07:49 +0000 (UTC)
Received: from localhost (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E6EFC100164D;
        Thu, 24 Oct 2019 13:07:48 +0000 (UTC)
Date:   Thu, 24 Oct 2019 21:07:46 +0800
From:   Honggang LI <honli@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/srpt: Fix TPG creation
Message-ID: <20191024130746.GA21231@dhcp-128-227.nay.redhat.com>
References: <20191023204106.23326-1-bvanassche@acm.org>
MIME-Version: 1.0
In-Reply-To: <20191023204106.23326-1-bvanassche@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: QJNQ_4QHMa6fHM4K-7h1cQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 23, 2019 at 01:41:06PM -0700, Bart Van Assche wrote:
> Unlike the iSCSI target driver, for the SRP target driver it is sufficien=
t
> if a single TPG can be associated with each RDMA port name. However, user=
s
> started associating multiple TPGs with RDMA port names. Support this by
> converting the single TPG in struct srpt_port_id into a list. This patch
> fixes the following list corruption issue:
>=20
> list_add corruption. prev->next should be next (ffffffffc0a080c0), but wa=
s ffffa08a994ce6f0. (prev=3Dffffa08a994ce6f0).
> WARNING: CPU: 2 PID: 2597 at lib/list_debug.c:28 __list_add_valid+0x6a/0x=
70
> CPU: 2 PID: 2597 Comm: targetcli Not tainted 5.4.0-rc1.3bfa3c9602a7 #1
> RIP: 0010:__list_add_valid+0x6a/0x70
> Call Trace:
>  core_tpg_register+0x116/0x200 [target_core_mod]
>  srpt_make_tpg+0x3f/0x60 [ib_srpt]
>  target_fabric_make_tpg+0x41/0x290 [target_core_mod]
>  configfs_mkdir+0x158/0x3e0
>  vfs_mkdir+0x108/0x1a0
>  do_mkdirat+0x77/0xe0
>  do_syscall_64+0x55/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>=20
> Cc: Honggang LI <honli@redhat.com>
> Reported-by: Honggang LI <honli@redhat.com>
> Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 77 ++++++++++++++++++---------
>  drivers/infiniband/ulp/srpt/ib_srpt.h | 25 +++++++--
>  2 files changed, 73 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/u=
lp/srpt/ib_srpt.c
> index daf811abf40a..a278e76b9e02 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -2131,6 +2131,7 @@ static int srpt_cm_req_recv(struct srpt_device *con=
st sdev,
>  =09char i_port_id[36];
>  =09u32 it_iu_len;
>  =09int i, tag_num, tag_size, ret;
> +=09struct srpt_tpg *stpg;
> =20
>  =09WARN_ON_ONCE(irqs_disabled());
> =20
> @@ -2288,19 +2289,33 @@ static int srpt_cm_req_recv(struct srpt_device *c=
onst sdev,
> =20
>  =09tag_num =3D ch->rq_size;
>  =09tag_size =3D 1; /* ib_srpt does not use se_sess->sess_cmd_map */
> -=09if (sport->port_guid_id.tpg.se_tpg_wwn)
> -=09=09ch->sess =3D target_setup_session(&sport->port_guid_id.tpg, tag_nu=
m,
> +
> +=09mutex_lock(&sport->port_guid_id.mutex);
> +=09list_for_each_entry(stpg, &sport->port_guid_id.tpg_list, entry) {
> +=09=09if (!IS_ERR_OR_NULL(ch->sess))
> +=09=09=09break;
> +=09=09ch->sess =3D target_setup_session(&stpg->tpg, tag_num,
>  =09=09=09=09=09=09tag_size, TARGET_PROT_NORMAL,
>  =09=09=09=09=09=09ch->sess_name, ch, NULL);
> -=09if (sport->port_gid_id.tpg.se_tpg_wwn && IS_ERR_OR_NULL(ch->sess))
> -=09=09ch->sess =3D target_setup_session(&sport->port_gid_id.tpg, tag_num=
,
> +=09}
> +=09mutex_unlock(&sport->port_guid_id.mutex);
> +
> +=09mutex_lock(&sport->port_gid_id.mutex);
> +=09list_for_each_entry(stpg, &sport->port_gid_id.tpg_list, entry) {
> +=09=09if (!IS_ERR_OR_NULL(ch->sess))
> +=09=09=09break;
> +=09=09ch->sess =3D target_setup_session(&stpg->tpg, tag_num,
>  =09=09=09=09=09tag_size, TARGET_PROT_NORMAL, i_port_id,
>  =09=09=09=09=09ch, NULL);
> -=09/* Retry without leading "0x" */
> -=09if (sport->port_gid_id.tpg.se_tpg_wwn && IS_ERR_OR_NULL(ch->sess))
> -=09=09ch->sess =3D target_setup_session(&sport->port_gid_id.tpg, tag_num=
,
> +=09=09if (!IS_ERR_OR_NULL(ch->sess))
> +=09=09=09break;
> +=09=09/* Retry without leading "0x" */
> +=09=09ch->sess =3D target_setup_session(&stpg->tpg, tag_num,
>  =09=09=09=09=09=09tag_size, TARGET_PROT_NORMAL,
>  =09=09=09=09=09=09i_port_id + 2, ch, NULL);
> +=09}
> +=09mutex_unlock(&sport->port_gid_id.mutex);
> +
>  =09if (IS_ERR_OR_NULL(ch->sess)) {
>  =09=09WARN_ON_ONCE(ch->sess =3D=3D NULL);
>  =09=09ret =3D PTR_ERR(ch->sess);
> @@ -3140,6 +3155,10 @@ static void srpt_add_one(struct ib_device *device)
>  =09=09sport->port_attrib.srp_sq_size =3D DEF_SRPT_SQ_SIZE;
>  =09=09sport->port_attrib.use_srq =3D false;
>  =09=09INIT_WORK(&sport->work, srpt_refresh_port_work);
> +=09=09mutex_init(&sport->port_guid_id.mutex);
> +=09=09INIT_LIST_HEAD(&sport->port_guid_id.tpg_list);
> +=09=09mutex_init(&sport->port_gid_id.mutex);
> +=09=09INIT_LIST_HEAD(&sport->port_gid_id.tpg_list);
> =20
>  =09=09if (srpt_refresh_port(sport)) {
>  =09=09=09pr_err("MAD registration failed for %s-%d.\n",
> @@ -3242,18 +3261,6 @@ static struct srpt_port *srpt_tpg_to_sport(struct =
se_portal_group *tpg)
>  =09return tpg->se_tpg_wwn->priv;
>  }
> =20
> -static struct srpt_port_id *srpt_tpg_to_sport_id(struct se_portal_group =
*tpg)
> -{
> -=09struct srpt_port *sport =3D srpt_tpg_to_sport(tpg);
> -
> -=09if (tpg =3D=3D &sport->port_guid_id.tpg)
> -=09=09return &sport->port_guid_id;
> -=09if (tpg =3D=3D &sport->port_gid_id.tpg)
> -=09=09return &sport->port_gid_id;
> -=09WARN_ON_ONCE(true);
> -=09return NULL;
> -}
> -
>  static struct srpt_port_id *srpt_wwn_to_sport_id(struct se_wwn *wwn)
>  {
>  =09struct srpt_port *sport =3D wwn->priv;
> @@ -3268,7 +3275,9 @@ static struct srpt_port_id *srpt_wwn_to_sport_id(st=
ruct se_wwn *wwn)
> =20
>  static char *srpt_get_fabric_wwn(struct se_portal_group *tpg)
>  {
> -=09return srpt_tpg_to_sport_id(tpg)->name;
> +=09struct srpt_tpg *stpg =3D container_of(tpg, typeof(*stpg), tpg);
> +
> +=09return stpg->sport_id->name;
>  }
> =20
>  static u16 srpt_get_tag(struct se_portal_group *tpg)
> @@ -3725,16 +3734,27 @@ static struct se_portal_group *srpt_make_tpg(stru=
ct se_wwn *wwn,
>  =09=09=09=09=09     const char *name)
>  {
>  =09struct srpt_port *sport =3D wwn->priv;
> -=09struct se_portal_group *tpg =3D &srpt_wwn_to_sport_id(wwn)->tpg;
> -=09int res;
> +=09struct srpt_port_id *sport_id =3D srpt_wwn_to_sport_id(wwn);
> +=09struct srpt_tpg *stpg;
> +=09int res =3D -ENOMEM;
> =20
> -=09res =3D core_tpg_register(wwn, tpg, SCSI_PROTOCOL_SRP);
> -=09if (res)
> +=09stpg =3D kzalloc(sizeof(*stpg), GFP_KERNEL);
> +=09if (!stpg)
> +=09=09return ERR_PTR(res);
> +=09stpg->sport_id =3D sport_id;
> +=09res =3D core_tpg_register(wwn, &stpg->tpg, SCSI_PROTOCOL_SRP);
> +=09if (res) {
> +=09=09kfree(stpg);
>  =09=09return ERR_PTR(res);
> +=09}
> +
> +=09mutex_lock(&sport_id->mutex);
> +=09list_add_tail(&stpg->entry, &sport_id->tpg_list);
> +=09mutex_unlock(&sport_id->mutex);
> =20
>  =09atomic_inc(&sport->refcount);
> =20
> -=09return tpg;
> +=09return &stpg->tpg;
>  }
> =20
>  /**
> @@ -3743,10 +3763,17 @@ static struct se_portal_group *srpt_make_tpg(stru=
ct se_wwn *wwn,
>   */
>  static void srpt_drop_tpg(struct se_portal_group *tpg)
>  {
> +=09struct srpt_tpg *stpg =3D container_of(tpg, typeof(*stpg), tpg);
> +=09struct srpt_port_id *sport_id =3D stpg->sport_id;
>  =09struct srpt_port *sport =3D srpt_tpg_to_sport(tpg);
> =20
> +=09mutex_lock(&sport_id->mutex);
> +=09list_del(&stpg->entry);
> +=09mutex_unlock(&sport_id->mutex);
> +
>  =09sport->enabled =3D false;
>  =09core_tpg_deregister(tpg);
> +=09kfree(stpg);
>  =09srpt_drop_sport_ref(sport);
>  }
> =20
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/u=
lp/srpt/ib_srpt.h
> index f8bd95302ac0..27a54f777e3b 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.h
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
> @@ -363,17 +363,34 @@ struct srpt_port_attrib {
>  =09bool=09=09=09use_srq;
>  };
> =20
> +/**
> + * struct srpt_tpg - information about a single "target portal group"
> + * @entry:=09Entry in @sport_id->tpg_list.
> + * @sport_id:=09Port name this TPG is associated with.
> + * @tpg:=09LIO TPG data structure.
> + *
> + * Zero or more target portal groups are associated with each port name
> + * (srpt_port_id). With each TPG an ACL list is associated.
> + */
> +struct srpt_tpg {
> +=09struct list_head=09entry;
> +=09struct srpt_port_id=09*sport_id;
> +=09struct se_portal_group=09tpg;
> +};
> +
>  /**
>   * struct srpt_port_id - information about an RDMA port name
> - * @tpg: TPG associated with the RDMA port.
> - * @wwn: WWN associated with the RDMA port.
> - * @name: ASCII representation of the port name.
> + * @mutex:=09Protects @tpg_list changes.
> + * @tpg_list:=09TPGs associated with the RDMA port name.
> + * @wwn:=09WWN associated with the RDMA port name.
> + * @name:=09ASCII representation of the port name.
>   *
>   * Multiple sysfs directories can be associated with a single RDMA port.=
 This
>   * data structure represents a single (port, name) pair.
>   */
>  struct srpt_port_id {
> -=09struct se_portal_group=09tpg;
> +=09struct mutex=09=09mutex;
> +=09struct list_head=09tpg_list;
>  =09struct se_wwn=09=09wwn;
>  =09char=09=09=09name[64];
>  };

Acked-by: Honggang Li <honli@redhat.com>

Thanks

