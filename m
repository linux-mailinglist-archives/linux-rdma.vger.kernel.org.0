Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6305EE1066
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 05:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbfJWDGu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 23:06:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41183 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727831AbfJWDGu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Oct 2019 23:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571800008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k4pDUbJL5SVqm0FRARnmM0PghrVjCXV2gWquMokKN4M=;
        b=brI8CY3goEb7jnW9IkmJEp7BNdW+feGZY4z/7JWhs7nmTQ6MijIBwMROu5u05jHe+7ZJHj
        iFy45OyfEcQ4h4APzL/hh0in41DbfwjzZuZmqMYvNORlj3H4t0qiyFThjkqaC6lHpRKWkC
        6ItuchF+JpPKokXDuYX2Mc0I1fdut6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-yRk375OLMvexFMzurFWSIw-1; Tue, 22 Oct 2019 23:06:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DC9F476;
        Wed, 23 Oct 2019 03:06:44 +0000 (UTC)
Received: from localhost (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BCE475D6D0;
        Wed, 23 Oct 2019 03:06:43 +0000 (UTC)
Date:   Wed, 23 Oct 2019 11:06:41 +0800
From:   Honggang LI <honli@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH] srp_daemon: Use maximum initiator to target IU size
Message-ID: <20191023030641.GA14551@dhcp-128-227.nay.redhat.com>
References: <20191018044104.21353-1-honli@redhat.com>
 <1d811fc0-1f74-b546-b296-a4e9f8c33d86@acm.org>
 <20191018152253.GA32562@dhcp-128-227.nay.redhat.com>
 <21142610-1e01-4ce8-635c-2fe677e69cf9@acm.org>
 <20191022070025.GA20278@dhcp-128-227.nay.redhat.com>
 <5f664232-ca58-c25c-e9b1-e441c053c818@acm.org>
MIME-Version: 1.0
In-Reply-To: <5f664232-ca58-c25c-e9b1-e441c053c818@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: yRk375OLMvexFMzurFWSIw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 22, 2019 at 03:10:26PM -0700, Bart Van Assche wrote:
> On 2019-10-22 00:00, Honggang LI wrote:
> > +static bool use_imm_data(void)
> > +{
> > +#ifdef __linux__
> > +=09bool ret =3D false;
> > +=09char flag =3D 0;
> > +=09int cnt;
> > +=09int fd =3D open("/sys/module/ib_srp/parameters/use_imm_data", O_RDO=
NLY);
> > +
> > +=09if (fd < 0)
> > +=09=09return false;
> > +=09cnt =3D read(fd, &flag, 1);
> > +=09if (cnt !=3D 1)
> > +=09=09return false;
> > +
> > +=09if (!strncmp(&flag, "Y", 1))
> > +=09=09ret =3D true;
> > +=09close(fd);
> > +=09return ret;
> > +#else
> > +=09return false;
> > +#endif
> > +}
>=20
> There is already plenty of Linux-specific code in srp_daemon. The #ifdef
> __linux__ / #endif guard does not seem useful to me.

Will delete the guard.

>=20
> There is a file descriptor leak in the above function, namely if read()
> returns another value than 1.

Yes, will fix it.

>=20
> The use_imm_data kernel module parameter was introduced in kernel v5.0
> (commit 882981f4a411; "RDMA/srp: Add support for immediate data"). The
> max_it_iu_size will be introduced in kernel v5.5 (commit 547ed331bbe8;
> "RDMA/srp: Add parse function for maximum initiator to target IU size").
>=20
> So the above check will help for kernel versions before v5.0 but not for
> kernel versions [v5.0..v5.5).=20

Yes, you are right. The patch does not fix the issue for kernel
versions [v5.0..v5.5). But it also does not do anything bad for
kernel versions before v5.5 (commit 547ed331bbe8). It will fix
the issue for kernel after 547ed331bbe8.

> If that is really what you want, please
> explain this in a comment above the use_imm_data() function.

Yes, will add a comment for it.

thanks

