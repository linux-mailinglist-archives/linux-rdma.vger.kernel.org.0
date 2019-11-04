Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9FDED6D0
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2019 02:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfKDBOs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 3 Nov 2019 20:14:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52144 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfKDBOs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 3 Nov 2019 20:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572830087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UaoCTzvOTf2LP1d0FA6CBx4+HQSgFMcCJDE8asle1HE=;
        b=TpwjUXWRrNLtjT9EGBQn8VwO0vh6INFNOPT+MyO9DMQm/HWCrDGebWpOsXz/NgPJVeTNMJ
        QyTeCsmaXnrMP5nhvj7qzDkODs4O+KOVPpYuW4qBNZYUfrjwkUy1iMDBaJlN29gwtQ+7d1
        XHvrj5TxWqCXlUDHUsVKs/t3YIpHcj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-SEID7YwDPgC_JXy3cFYdCQ-1; Sun, 03 Nov 2019 20:14:45 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DB481005500;
        Mon,  4 Nov 2019 01:14:44 +0000 (UTC)
Received: from localhost (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE5E75D6C3;
        Mon,  4 Nov 2019 01:14:43 +0000 (UTC)
Date:   Mon, 4 Nov 2019 09:14:41 +0800
From:   Honggang LI <honli@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH] Revert "RDMA/srpt: Postpone HCA removal until after
 configfs directory removal"
Message-ID: <20191104011441.GB26981@dhcp-128-227.nay.redhat.com>
References: <20191101204756.182162-1-bvanassche@acm.org>
MIME-Version: 1.0
In-Reply-To: <20191101204756.182162-1-bvanassche@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: SEID7YwDPgC_JXy3cFYdCQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 01, 2019 at 01:47:56PM -0700, Bart Van Assche wrote:
> Although the mentioned patch fixes a use-after-free bug, it introduces a
> hang during shutdown. Since the latter is worse, revert this patch.
>=20
> Cc: Honggang Li <honli@redhat.com>
> Cc: Laurence Oberman <loberman@redhat.com>
> Reported-by: Honggang Li <honli@redhat.com>
> Fixes: 9b64f7d0bb0a ("RDMA/srpt: Postpone HCA removal until after configf=
s directory removal")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/u=
lp/srpt/ib_srpt.c
> index c9972b686c27..53dec7d9829c 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -2960,7 +2960,7 @@ static int srpt_release_sport(struct srpt_port *spo=
rt)
> =20
>  =09while (atomic_read(&sport->refcount) > 0 &&
>  =09       wait_for_completion_timeout(&c, 5 * HZ) <=3D 0) {
> -=09=09pr_info("%s_%d: waiting for unregistration of %d sessions and conf=
igfs directories ...\n",
> +=09=09pr_info("%s_%d: waiting for unregistration of %d sessions ...\n",
>  =09=09=09dev_name(&sport->sdev->device->dev), sport->port,
>  =09=09=09atomic_read(&sport->refcount));
>  =09=09rcu_read_lock();
> @@ -3776,8 +3776,6 @@ static struct se_portal_group *srpt_make_tpg(struct=
 se_wwn *wwn,
>  =09list_add_tail(&stpg->entry, &sport_id->tpg_list);
>  =09mutex_unlock(&sport_id->mutex);
> =20
> -=09atomic_inc(&sport->refcount);
> -
>  =09return &stpg->tpg;
>  }
> =20
> @@ -3798,7 +3796,6 @@ static void srpt_drop_tpg(struct se_portal_group *t=
pg)
>  =09sport->enabled =3D false;
>  =09core_tpg_deregister(tpg);
>  =09kfree(stpg);
> -=09srpt_drop_sport_ref(sport);
>  }
> =20

Acked-by: Honggang Li <honli@redhat.com>

>  /**
> --=20
> 2.24.0.rc1.363.gb1bccd3e3d-goog
>=20

