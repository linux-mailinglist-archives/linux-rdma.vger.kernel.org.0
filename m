Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1D2E1F65
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 17:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392476AbfJWPeI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 11:34:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54667 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390400AbfJWPeH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 11:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571844846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nrtde6rE6r+glN1bkK8a7f6By+ITTgZtHt+agfRY3Gk=;
        b=ZDbWkkkjZht8TBpL0xQ+lUU+BtVDH5p0e4iZZ+m55ZbZlyE4XAigCJVNlOv1ouopHtfMJx
        MwmfZAL3tbmyuKM0lB1Irrc49Xfor5VKo3p/nVcWgDoaA9VNXCMKJGfdSCQPc6QHKDBXon
        L7jRYAJUkoqb1Sq1t+r4StUNV6xHbAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-eNoGpBdyNK6S7LdwgYHbow-1; Wed, 23 Oct 2019 11:34:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F8B21005500;
        Wed, 23 Oct 2019 15:34:01 +0000 (UTC)
Received: from localhost (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F83A1001DD7;
        Wed, 23 Oct 2019 15:34:00 +0000 (UTC)
Date:   Wed, 23 Oct 2019 23:33:57 +0800
From:   Honggang LI <honli@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH] srp_daemon: Use maximum initiator to target IU size
Message-ID: <20191023153357.GA9650@dhcp-128-227.nay.redhat.com>
References: <20191018044104.21353-1-honli@redhat.com>
 <1d811fc0-1f74-b546-b296-a4e9f8c33d86@acm.org>
 <20191018152253.GA32562@dhcp-128-227.nay.redhat.com>
 <21142610-1e01-4ce8-635c-2fe677e69cf9@acm.org>
 <20191022070025.GA20278@dhcp-128-227.nay.redhat.com>
 <5f664232-ca58-c25c-e9b1-e441c053c818@acm.org>
 <20191023030641.GA14551@dhcp-128-227.nay.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191023030641.GA14551@dhcp-128-227.nay.redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: eNoGpBdyNK6S7LdwgYHbow-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 23, 2019 at 11:06:44AM +0800, Honggang LI wrote:
> On Tue, Oct 22, 2019 at 03:10:26PM -0700, Bart Van Assche wrote:
> > On 2019-10-22 00:00, Honggang LI wrote:
> > > +static bool use_imm_data(void)
> > > +{
> > > +#ifdef __linux__
> > > +=09bool ret =3D false;
> > > +=09char flag =3D 0;
> > > +=09int cnt;
> > > +=09int fd =3D open("/sys/module/ib_srp/parameters/use_imm_data", O_R=
DONLY);
> > > +
> > > +=09if (fd < 0)
> > > +=09=09return false;
> > > +=09cnt =3D read(fd, &flag, 1);
> > > +=09if (cnt !=3D 1)
> > > +=09=09return false;
> > > +
> > > +=09if (!strncmp(&flag, "Y", 1))
> > > +=09=09ret =3D true;
> > > +=09close(fd);
> > > +=09return ret;
> > > +#else
> > > +=09return false;
> > > +#endif
> > > +}
> >=20
> > There is already plenty of Linux-specific code in srp_daemon. The #ifde=
f
> > __linux__ / #endif guard does not seem useful to me.
>=20
> Will delete the guard.
>=20
> >=20
> > There is a file descriptor leak in the above function, namely if read()
> > returns another value than 1.
>=20
> Yes, will fix it.
>=20
> >=20
> > The use_imm_data kernel module parameter was introduced in kernel v5.0
> > (commit 882981f4a411; "RDMA/srp: Add support for immediate data"). The
> > max_it_iu_size will be introduced in kernel v5.5 (commit 547ed331bbe8;
> > "RDMA/srp: Add parse function for maximum initiator to target IU size")=
.
> >=20
> > So the above check will help for kernel versions before v5.0 but not fo=
r
> > kernel versions [v5.0..v5.5).=20
>=20
> Yes, you are right. The patch does not fix the issue for kernel
> versions [v5.0..v5.5). But it also does not do anything bad for
> kernel versions before v5.5 (commit 547ed331bbe8). It will fix
> the issue for kernel after 547ed331bbe8.

Well, for kernel versions [v5.0..v5.5), this patch will cause kernel to
emit warning message of unknown parameter. It seems we need add a flag
like this for ib_srp module:


diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/s=
rp/ib_srp.c
index b7f7a5f7bd98..96434f743a91 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -74,6 +74,7 @@ static bool allow_ext_sg;
 static bool prefer_fr =3D true;
 static bool register_always =3D true;
 static bool never_register;
+static bool has_max_it_iu_size =3D true;
 static int topspin_workarounds =3D 1;
=20
 module_param(srp_sg_tablesize, uint, 0444);
@@ -103,6 +104,10 @@ module_param(register_always, bool, 0444);
 MODULE_PARM_DESC(register_always,
 =09=09 "Use memory registration even for contiguous memory regions");
=20
+module_param(has_max_it_iu_size, bool, 0444);
+MODULE_PARM_DESC(has_max_it_iu_size,
+=09=09  "Indicate the module supports max_it_iu_size login parameter");
+
 module_param(never_register, bool, 0444);
 MODULE_PARM_DESC(never_register, "Never register memory");
=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Then, srp_daemon should check file "/sys/module/ib_srp/parameters/has_max_i=
t_iu_size"
instead of "/sys/module/ib_srp/parameters/use_imm_data".

