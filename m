Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1E5DFDF0
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 09:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbfJVHAi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 03:00:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23270 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729909AbfJVHAh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Oct 2019 03:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571727635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ljwfuH7BYhMZjIUOz8BxegYF0eyiiLQaMPtxdkqwO0U=;
        b=FnrdVQdaZX+u03cJQrWGq6hOEOOjRJvZCUaTxtBw7rJbMIpS4Qha/o39PT7UCA9yMAZrC9
        uINvfy3RhnHFviXXn2bwgTmnIsNIU+lmJcDLCn61l8419aZFkfP3gLJnOfbaXaStrokOyK
        3zxtrfqZfThJ0BweGVdNMyqpsv6zrHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-4HYOeeccPpyB7sv7hvJYuw-1; Tue, 22 Oct 2019 03:00:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56A1E107AD34;
        Tue, 22 Oct 2019 07:00:33 +0000 (UTC)
Received: from localhost (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C30EC60A9F;
        Tue, 22 Oct 2019 07:00:32 +0000 (UTC)
Date:   Tue, 22 Oct 2019 15:00:25 +0800
From:   Honggang LI <honli@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH] srp_daemon: Use maximum initiator to target IU size
Message-ID: <20191022070025.GA20278@dhcp-128-227.nay.redhat.com>
References: <20191018044104.21353-1-honli@redhat.com>
 <1d811fc0-1f74-b546-b296-a4e9f8c33d86@acm.org>
 <20191018152253.GA32562@dhcp-128-227.nay.redhat.com>
 <21142610-1e01-4ce8-635c-2fe677e69cf9@acm.org>
MIME-Version: 1.0
In-Reply-To: <21142610-1e01-4ce8-635c-2fe677e69cf9@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 4HYOeeccPpyB7sv7hvJYuw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 18, 2019 at 10:10:05AM -0700, Bart Van Assche wrote:
> On 10/18/19 8:22 AM, Honggang LI wrote:
> > [ ... ]
>=20
> Hi Honggang,
>=20
> The approach of your patch seems suboptimal to me. I think it would be
> cumbersome for users to have to modify the srp_daemon_port@.service file =
to
> suppress a kernel warning or to pass the max_it_iu_size parameter during
> login.
>=20
> Had you noticed that the SRP initiator stops parsing parameters if it
> encounters an unrecognized parameter?
>=20
> From ib_srp.c, function srp_parse_options():
>=20
> =09default:
> =09=09pr_warn("unknown parameter or missing value '%s' in"
> =09=09=09" target creation request\n", p);
> =09=09=09goto out;
> =09=09}
>=20
> The "goto out" breaks out of the while loop that parses options. We canno=
t
> change this behavior in existing versions of the SRP initiator kernel
> driver. In other words, if the max_it_iu_size parameter is not specified =
at
> the very end of the login string it will cause some login parameters to b=
e
> ignored.

I see.

>=20
> I think we should use one of the following two approaches:
> * Not add a new command-line option to srp_daemon and add the
>   max_it_iu_size at the very end of the login string.

Yes, I will remove the new command-line and append max_it_iu_size at
the very end of login string.

> * Modify the ib_srp driver such that it exports the login parameters

This hints me to check the value of
/sys/module/ib_srp/parameters/use_imm_data .

The regression issue was introduced because of using immediate data.
The new patch will append max_it_iu_size only when use_imm_data enabled.

For old ib_srp client does not support immediate date, the new patch will
not use max_it_iu_size. It will not trigger the kernel warning message
of unsupported parameter.

Please see this patch.

diff --git a/srp_daemon/srp_daemon.c b/srp_daemon/srp_daemon.c
index f0bcf923..24451b87 100644
--- a/srp_daemon/srp_daemon.c
+++ b/srp_daemon/srp_daemon.c
@@ -402,6 +402,28 @@ static int is_enabled_by_rules_file(struct target_deta=
ils *target)
 }
=20
=20
+static bool use_imm_data(void)
+{
+#ifdef __linux__
+=09bool ret =3D false;
+=09char flag =3D 0;
+=09int cnt;
+=09int fd =3D open("/sys/module/ib_srp/parameters/use_imm_data", O_RDONLY)=
;
+
+=09if (fd < 0)
+=09=09return false;
+=09cnt =3D read(fd, &flag, 1);
+=09if (cnt !=3D 1)
+=09=09return false;
+
+=09if (!strncmp(&flag, "Y", 1))
+=09=09ret =3D true;
+=09close(fd);
+=09return ret;
+#else
+=09return false;
+#endif
+}
=20
 static int add_non_exist_target(struct target_details *target)
 {
@@ -581,6 +603,19 @@ static int add_non_exist_target(struct target_details =
*target)
 =09=09}
 =09}
=20
+=09if (use_imm_data()) {
+=09=09len +=3D snprintf(target_config_str+len,
+=09=09=09sizeof(target_config_str) - len,
+=09=09=09",max_it_iu_size=3D%d",
+=09=09=09be32toh(target->ioc_prof.send_size));
+
+=09=09if (len >=3D sizeof(target_config_str)) {
+=09=09=09pr_err("Target config string is too long, ignoring target\n");
+=09=09=09closedir(dir);
+=09=09=09return -1;
+=09=09}
+=09}
+
 =09target_config_str[len] =3D '\0';
=20
 =09pr_cmd(target_config_str, not_connected);
@@ -1360,6 +1395,10 @@ static void print_config(struct config_t *conf)
 =09=09printf(" Print initiator_ext\n");
 =09else
 =09=09printf(" Do not print initiator_ext\n");
+=09if (use_imm_data())
+=09=09printf(" Print maximum initiator to target IU size\n");
+=09else
+=09=09printf(" Do not print maximum initiator to target IU size\n");
 =09if (conf->recalc_time)
 =09=09printf(" Performs full target rescan every %d seconds\n", conf->reca=
lc_time);
 =09else

