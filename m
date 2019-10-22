Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 158A1E0B1E
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 19:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfJVR53 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 13:57:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37375 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727154AbfJVR52 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 13:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571767047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RsHzVavgqXXlbIxcecOB0fgRNdTdZShlUDJWOp6UjYI=;
        b=J4QAIdvpb6TpSsBA5agFa77cxePm+xr6bfzzOrYweWPSwxcgAZx/WN5a4B9LfUwSXgK8dq
        d9VzA7z1HM27O11Y60wQdyvYlNyq3hhatMtZAeu7iZvPm+751wC8FE1bQ5iStUGCyh++yX
        eB49fKQPcaCCmZqhtZXEctE45aAYYCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-73vAyDfqN3W8j5BvF0VIjQ-1; Tue, 22 Oct 2019 13:57:24 -0400
X-MC-Unique: 73vAyDfqN3W8j5BvF0VIjQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E486480183D;
        Tue, 22 Oct 2019 17:57:21 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-37.rdu2.redhat.com [10.10.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1037460126;
        Tue, 22 Oct 2019 17:57:20 +0000 (UTC)
Message-ID: <ba91bb6c42e18e72cd6eaa705067a9cb30a02853.camel@redhat.com>
Subject: Re: [PATCH] iw_cxgb3: Remove the iw_cxgb3 provider code
From:   Doug Ledford <dledford@redhat.com>
To:     Yuval Shaia <yuval.shaia@oracle.com>, bharat@chelsio.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org
Date:   Tue, 22 Oct 2019 13:57:18 -0400
In-Reply-To: <20191022174710.12758-1-yuval.shaia@oracle.com>
References: <20191022174710.12758-1-yuval.shaia@oracle.com>
Organization: Red Hat, Inc.
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-xO8QNUR9XifEwUVL7dLT"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--=-xO8QNUR9XifEwUVL7dLT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-22 at 20:47 +0300, Yuval Shaia wrote:
> diff --git a/kernel-headers/rdma/rdma_user_ioctl_cmds.h b/kernel-
> headers/rdma/rdma_user_ioctl_cmds.h
> index b8bb285f..b2680051 100644
> --- a/kernel-headers/rdma/rdma_user_ioctl_cmds.h
> +++ b/kernel-headers/rdma/rdma_user_ioctl_cmds.h
> @@ -88,7 +88,6 @@ enum rdma_driver_id {
>         RDMA_DRIVER_UNKNOWN,
>         RDMA_DRIVER_MLX5,
>         RDMA_DRIVER_MLX4,
> -       RDMA_DRIVER_CXGB3,
>         RDMA_DRIVER_CXGB4,
>         RDMA_DRIVER_MTHCA,
>         RDMA_DRIVER_BNXT_RE,

This is the same bug the kernel patch had.  We can't change that enum.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-xO8QNUR9XifEwUVL7dLT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl2vQv4ACgkQuCajMw5X
L91JLg/+JZPVMCSvvFhjQliuPLar0XI+YYWpypnRWyoCpd7BCt08OYlkOzOZDdIO
O6Mfw2S17zP59UHbQxmcr4q9FDOsBFHEzxkhFBf9sFgzR8g1vPWUdo8qmbajr1Ac
Ofa2D2vsj3UrbTHwa6S1OZH6ZfjigdqBtY840P02GJrFifNPPUjUNaKB2cYh2fb0
PQGdyYtJu64DMVcFpNB0bRxoxVSWM24cbqDvR7XNC08zA8Rq9Qqo5m/d5UGcBJkF
dRUsVhvqGjvGqU3NsipT1rJ5oaPOa5gJrxgYx3qBC2PH3ryKJAcn9yYA0CZVg5S6
b7FCCYdyVww6tvLh1i7XwmAvbVqPSHrGTkM1A2+nxtWRZ3UA+q4P8is+iSqr739U
7R7WmffK5kM6cLN+JxBmNhI3Caqj5l4wadbfaBIdmEd0zSXw8eIBCEU/9Fn0xWZ4
gMuPpi18hojS0Ei6orADtT5wnfXMkXqs+UlnwKEMkersGm1YUTQXTvc5N0wjJlZQ
5NkEQ4J1P2O4tufmWOfDL/XyY1gmHUwFo5zpgiOzUiWhNS2S8POuBLm/gaodndlk
7FXtdAjl2cLJFXhuWFl5zEM6Zp+qf2fgCqgFJ0xHWeVnQ6K2S3fvPmxLvoxuAlnB
GgftEpIqVt4blboo6uXJnk1GHxaLcdUckYPtFFXd3IwoyfEM0sY=
=Lr95
-----END PGP SIGNATURE-----

--=-xO8QNUR9XifEwUVL7dLT--

