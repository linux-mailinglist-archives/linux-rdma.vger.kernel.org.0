Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93C70E28F1
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 05:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392923AbfJXDhZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 23:37:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59321 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392922AbfJXDhZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 23:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571888243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FEPODX2iOUfO8dj7F/1aVzbxPqaHratMkNeD2XWifIA=;
        b=KGlnknxHWmabzAUM59NbJj1Yfr140slx/lXtMHr7WcT24u+c8vbQZwdRHhvfOghjej+XJt
        ksFNTiaFkZyq/GOr1caImsrpbcXLsDESOwxQ6ySSqdBEiwPLNlKCn0W9iTkTx44vvx/gyb
        fw8JGc6GcNGpYsLxYW4TfULaLY+oI1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-YwuqIMmLNsSelbkf0uhK6A-1; Wed, 23 Oct 2019 23:37:20 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E50F31005509;
        Thu, 24 Oct 2019 03:37:18 +0000 (UTC)
Received: from localhost (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F79F4523;
        Thu, 24 Oct 2019 03:37:18 +0000 (UTC)
Date:   Thu, 24 Oct 2019 11:37:15 +0800
From:   Honggang LI <honli@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/srpt: Fix TPG creation
Message-ID: <20191024033715.GA16157@dhcp-128-227.nay.redhat.com>
References: <20191023204106.23326-1-bvanassche@acm.org>
MIME-Version: 1.0
In-Reply-To: <20191023204106.23326-1-bvanassche@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: YwuqIMmLNsSelbkf0uhK6A-1
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

First of all, this patch do fix the list corruption issue.
I can't reproduce it anymore after apply this patch.

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

> +
> +=09mutex_lock(&sport->port_gid_id.mutex);
> +=09list_for_each_entry(stpg, &sport->port_gid_id.tpg_list, entry) {
> +=09=09if (!IS_ERR_OR_NULL(ch->sess))
                ^^^^^^^
> +=09=09=09break;
> +=09=09ch->sess =3D target_setup_session(&stpg->tpg, tag_num,
                           ^^^^^^^^^^^^^^^^^^^^
>  =09=09=09=09=09tag_size, TARGET_PROT_NORMAL, i_port_id,
>  =09=09=09=09=09ch, NULL);
> -=09/* Retry without leading "0x" */
> -=09if (sport->port_gid_id.tpg.se_tpg_wwn && IS_ERR_OR_NULL(ch->sess))
> -=09=09ch->sess =3D target_setup_session(&sport->port_gid_id.tpg, tag_num=
,
> +=09=09if (!IS_ERR_OR_NULL(ch->sess))
                    ^
> +=09=09=09break;

I'm confused about this 'if' statement. In case you repeated the
validation as previous 'if' statement, it is redundance.

In case you check the return of the first target_setup_session,
it seems wrong, we only need to retry in case first target_setup_session
was failed. But you break out, and skip the second target_setup_session.

> +=09=09/* Retry without leading "0x" */
> +=09=09ch->sess =3D target_setup_session(&stpg->tpg, tag_num,
                           ^^^^^^^^^^^^^^^^^^^^
>  =09=09=09=09=09=09tag_size, TARGET_PROT_NORMAL,
>  =09=09=09=09=09=09i_port_id + 2, ch, NULL);

thanks

