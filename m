Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2373EDD82
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2019 12:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfKDLKd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Nov 2019 06:10:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54513 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726633AbfKDLKd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Nov 2019 06:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572865832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eekEAbvgZJ4K+GEbgi8W9Ct9vYfmt6qtQ9I8Gi27Qf4=;
        b=SROwVgBYZXcu5QXNg8zkk4m0ZJtbuicMx63svjDY/QE4MzXePHriqiv/EzNAsyRh653FLq
        m1eZi3IUxQYmpFtCZcrm9w5oZs+2zgTXgymjudTXxiABFJQhooGRD6FP5ba6P2XYfUT01B
        g1FDiDQuAJZQcJDtHBSs1BJXodKo5AI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-Ng0FBulTPUSwQxzP7RYx3A-1; Mon, 04 Nov 2019 06:10:29 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCBF31800DFB;
        Mon,  4 Nov 2019 11:10:27 +0000 (UTC)
Received: from localhost (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 27641600C4;
        Mon,  4 Nov 2019 11:10:26 +0000 (UTC)
Date:   Mon, 4 Nov 2019 19:10:24 +0800
From:   Honggang LI <honli@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH] RDMA/srpt: Report the SCSI residual to the initiator
Message-ID: <20191104111024.GA31820@dhcp-128-227.nay.redhat.com>
References: <20191029230257.210897-1-bvanassche@acm.org>
MIME-Version: 1.0
In-Reply-To: <20191029230257.210897-1-bvanassche@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Ng0FBulTPUSwQxzP7RYx3A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 29, 2019 at 04:02:57PM -0700, Bart Van Assche wrote:
> The code added by this patch is similar to the code that already exists
> in ibmvscsis_determine_resid(). This patch has been tested by running
> the following command:
>=20
> strace -f sg_raw -r 1k /dev/sdb 12 00 00 00 60 00 -o inquiry.bin |&
>     grep resid=3D
>=20
> Cc: Honggang LI <honli@redhat.com>
> Cc: Laurence Oberman <loberman@redhat.com>
> Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/u=
lp/srpt/ib_srpt.c
> index a278e76b9e02..c9972b686c27 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -1362,9 +1362,11 @@ static int srpt_build_cmd_rsp(struct srpt_rdma_ch =
*ch,
>  =09=09=09      struct srpt_send_ioctx *ioctx, u64 tag,
>  =09=09=09      int status)
>  {
> +=09struct se_cmd *cmd =3D &ioctx->cmd;
>  =09struct srp_rsp *srp_rsp;
>  =09const u8 *sense_data;
>  =09int sense_data_len, max_sense_len;
> +=09int resid =3D cmd->residual_count;
        ^^^
Should be u32?=09

