Return-Path: <linux-rdma+bounces-9106-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5469A7877E
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 07:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F06D7A44D0
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 05:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3CD20B7E1;
	Wed,  2 Apr 2025 05:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="F+Rpa7js"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD2C1C84AB
	for <linux-rdma@vger.kernel.org>; Wed,  2 Apr 2025 05:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743570376; cv=none; b=WiPAeRslMUt0DaQMofaLnSqyysLoJh6teJhn3LveYMUzzPWGioohyfPZFacFGIgwLF4ifgZ7XLJbNH/o5eKvjM3pP2skOk+4O0m+5WGia0xd8ZV2s7r2e5fczan9H4TpMr12f8AO75nJidyOaMLKjfHIRowegtoPlWQkNPCr3Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743570376; c=relaxed/simple;
	bh=5dTrruqTcPPTv1qU+A27TXrcuX/Tcdriggf2MIpdGI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcDTx7rvcuO/I6rkznX6G000N2CQD/isUXFOUYtRnObYHRJxUhpTFiSjXHbHPwTN7yz7bMqYXVp2RnGpjwdV8ukmhhjtm/xygF6+COKWt3hheRLBrlLpaEuXl8l5n1bEkzzg6P4dN1JAmtBTQiP7jgqi27UX1p1Red6RE+e4a7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=F+Rpa7js; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e8484bb895so1958103a12.0
        for <linux-rdma@vger.kernel.org>; Tue, 01 Apr 2025 22:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1743570371; x=1744175171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xaTTageRrn2WM5zIXFtBnMYl4uVh+i8zkJusyEeAWU=;
        b=F+Rpa7jsqKqKmudRDhEll+OreZFQXWrYFY5gEl5OyXuGZ5Rc7/Nb5k3szjPDt8sxOM
         TvNUvTFMaw4twsFxWeYzW13d1FMsgBjhucW4GdZP/qrOyHv5JI4+PbJlpBE/nXtVtRfc
         N/L4ly4DnDwZirYEkI9DLeSvJj2vuJB8qpwZqOLDNttBlcthZNpWkpx415cPtYavUYbJ
         awaW6EcVEH224KlmGH36VsMyj5RtFh/REMrn3yXTr5aBguThJvkcz73ziGzwJNyPMcEE
         3xce5L1EOikKSztOdNpc5XI8bN7G2/a7p8vTbKHbhXLGTYO8v4ctI8FEvSzjZayzewCw
         W2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743570371; x=1744175171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xaTTageRrn2WM5zIXFtBnMYl4uVh+i8zkJusyEeAWU=;
        b=nQZOljX2tPzJHsySuyo2Iwli6KfGLSLrkwIu/xNtZpIdcAVMFOnN+Obl7W6SJBtOo8
         J5pVU5TBc8V1dtn4uM3nzdHCHKD+bc4Cp91ommzcOhpZuXpPrrruDNAgPcolLfbtapNh
         7X/2gDXhqpPDFF+wHNI320Z0T18kVBUv7qvBNxg4TjFuntCOyrcBvU2s+/+M/QcKaNpJ
         T6BbpkP+db+lTCz6a6dV/+L48raNiSYDhQMNkVEuQZt/JyXmHxOU9u7x8DB6pOhEH5qx
         VbSqKrDqY7OjI0arQVmjVtLwNILwhwTr5QNH8QvahJmbQxaz9sXMIOxUHq9HQBHrnt1a
         w/Dw==
X-Forwarded-Encrypted: i=1; AJvYcCX3sqazv7r7bMB8cGMZdLBdFhnYJJKXLSWCVrXZx4DAgIHaSOe+PLVpsEVzfsGouJIPFMaVEwBqcNO9@vger.kernel.org
X-Gm-Message-State: AOJu0YwZm6GOQoJfFeNb9bksE1AkBl8nbHLltGOqngldAVbM0RFEls/o
	Xh5dHvN/zAp8I3tAuuSW/fDlHZhakrNqTNnWIcrbkRPaxm5J8atxqr8UXgLb1kpek6yb5rxIP48
	w3MR88Ay9kR23jpai5uSAORoK+2q7BmTM7B3p6Q==
X-Gm-Gg: ASbGncs1WRXpsV4dGJ0xxlNUS8VQ5DcHkfZ5XqAkFxWh+PHV0l34FWwng/rNIQoazdR
	Z1LNDZ0hA7/K/e58gBOizP9/gLUCQofIjC6FayBZznQ3CY9KNtZfo3J053wDxXt4bJEsq/Git5S
	vRTG+ZSd93HvSfJhXcC6SOdHix55eNhlaiplgdjJZmeVYSy/DWf58J5uRV3us=
X-Google-Smtp-Source: AGHT+IHGkF6fvb1/M6FeFnlisGPKAnQbc197uIHSTVYOb5GBbijqCtkCK0uyMf4QuE015oYFx4JmnCWf6jdjIVcUUmU=
X-Received: by 2002:a05:6402:13c2:b0:5e5:be39:3361 with SMTP id
 4fb4d7f45d1cf-5f03bec948emr1468088a12.1.1743570371483; Tue, 01 Apr 2025
 22:06:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327061123.14453-1-jinpu.wang@ionos.com> <87cydvllso.fsf@suse.de>
In-Reply-To: <87cydvllso.fsf@suse.de>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 2 Apr 2025 07:06:00 +0200
X-Gm-Features: AQ5f1Joc9tyaXIJbEN61hqIiWxyaipytNVHSClqiaNB9_rkT4V7NANmVjdj1nc4
Message-ID: <CAMGffEmD+t4SKj3SERTHPY0GusmXjzEA-RO25wktKm-SW=uS_w@mail.gmail.com>
Subject: Re: [PATCH] migration/rdma: Remove qemu_rdma_broken_ipv6_kernel
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, 
	Li Zhijian <lizhijian@fujitsu.com>, Yu Zhang <yu.zhang@ionos.com>, linux-rdma@vger.kernel.org, 
	michael@flatgalaxy.com, Michael Galaxy <mrgalaxy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fabiano,

On Tue, Apr 1, 2025 at 9:32=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wrot=
e:
>
> Jack Wang <jinpu.wang@ionos.com> writes:
>
> > I hit following error which testing migration in pure RoCE env:
> > "-incoming rdma:[::]:8089: RDMA ERROR: You only have RoCE / iWARP devic=
es in your
> > systems and your management software has specified '[::]', but IPv6 ove=
r RoCE /
> > iWARP is not supported in Linux.#012'."
> >
> > In our setup, we use rdma bind on ipv6 on target host, while connect fr=
om source
> > with ipv4, remove the qemu_rdma_broken_ipv6_kernel, migration just work
> > fine.
> >
> > Checking the git history, the function was added since introducing of
> > rdma migration, which is more than 10 years ago. linux-rdma has
> > improved support on RoCE/iWARP for ipv6 over past years. There are a fe=
w fixes
> > back in 2016 seems related to the issue, eg:
> > aeb76df46d11 ("IB/core: Set routable RoCE gid type for ipv4/ipv6 networ=
ks")
> >
> > other fixes back in 2018, eg:
> > 052eac6eeb56 RDMA/cma: Update RoCE multicast routines to use net namesp=
ace
> > 8d20a1f0ecd5 RDMA/cma: Fix rdma_cm raw IB path setting for RoCE
> > 9327c7afdce3 RDMA/cma: Provide a function to set RoCE path record L2 pa=
rameters
> > 5c181bda77f4 RDMA/cma: Set default GID type as RoCE when resolving RoCE=
 route
> > 3c7f67d1880d IB/cma: Fix default RoCE type setting
> > be1d325a3358 IB/core: Set RoCEv2 MGID according to spec
> > 63a5f483af0e IB/cma: Set default gid type to RoCEv2
> >
> > So remove the outdated function and it's usage.
> >
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Li Zhijian <lizhijian@fujitsu.com>
> > Cc: Yu Zhang <yu.zhang@ionos.com>
> > Cc: qemu-devel@nongnu.org
> > Cc: linux-rdma@vger.kernel.org
> > Cc: michael@flatgalaxy.com
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > Tested-by: Li zhijian <lizhijian@fujitsu.com>
> > Reviewed-by: Michael Galaxy <mrgalaxy@nvidia.com>
> > ---
> > v1: drop RFC, fix build error (zhijian), collect Reviewed-by and Tested=
-by
> >
> >  migration/rdma.c | 159 -----------------------------------------------
> >  1 file changed, 159 deletions(-)
> >
> > diff --git a/migration/rdma.c b/migration/rdma.c
> > index 76fb0349238a..e228520b8e01 100644
> > --- a/migration/rdma.c
> > +++ b/migration/rdma.c
> > @@ -767,149 +767,6 @@ static void qemu_rdma_dump_gid(const char *who, s=
truct rdma_cm_id *id)
> >      trace_qemu_rdma_dump_gid(who, sgid, dgid);
> >  }
> >
> > -/*
> > - * As of now, IPv6 over RoCE / iWARP is not supported by linux.
> > - * We will try the next addrinfo struct, and fail if there are
> > - * no other valid addresses to bind against.
> > - *
> > - * If user is listening on '[::]', then we will not have a opened a de=
vice
> > - * yet and have no way of verifying if the device is RoCE or not.
> > - *
> > - * In this case, the source VM will throw an error for ALL types of
> > - * connections (both IPv4 and IPv6) if the destination machine does no=
t have
> > - * a regular infiniband network available for use.
> > - *
> > - * The only way to guarantee that an error is thrown for broken kernel=
s is
> > - * for the management software to choose a *specific* interface at bin=
d time
> > - * and validate what time of hardware it is.
> > - *
> > - * Unfortunately, this puts the user in a fix:
> > - *
> > - *  If the source VM connects with an IPv4 address without knowing tha=
t the
> > - *  destination has bound to '[::]' the migration will unconditionally=
 fail
> > - *  unless the management software is explicitly listening on the IPv4
> > - *  address while using a RoCE-based device.
> > - *
> > - *  If the source VM connects with an IPv6 address, then we're OK beca=
use we can
> > - *  throw an error on the source (and similarly on the destination).
> > - *
> > - *  But in mixed environments, this will be broken for a while until i=
t is fixed
> > - *  inside linux.
> > - *
> > - * We do provide a *tiny* bit of help in this function: We can list al=
l of the
> > - * devices in the system and check to see if all the devices are RoCE =
or
> > - * Infiniband.
> > - *
> > - * If we detect that we have a *pure* RoCE environment, then we can sa=
fely
> > - * thrown an error even if the management software has specified '[::]=
' as the
> > - * bind address.
> > - *
> > - * However, if there is are multiple hetergeneous devices, then we can=
not make
> > - * this assumption and the user just has to be sure they know what the=
y are
> > - * doing.
> > - *
> > - * Patches are being reviewed on linux-rdma.
> > - */
> > -static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Err=
or **errp)
> > -{
> > -    /* This bug only exists in linux, to our knowledge. */
> > -#ifdef CONFIG_LINUX
> > -    struct ibv_port_attr port_attr;
> > -
> > -    /*
> > -     * Verbs are only NULL if management has bound to '[::]'.
> > -     *
> > -     * Let's iterate through all the devices and see if there any pure=
 IB
> > -     * devices (non-ethernet).
> > -     *
> > -     * If not, then we can safely proceed with the migration.
> > -     * Otherwise, there are no guarantees until the bug is fixed in li=
nux.
> > -     */
> > -    if (!verbs) {
> > -        int num_devices;
> > -        struct ibv_device **dev_list =3D ibv_get_device_list(&num_devi=
ces);
> > -        bool roce_found =3D false;
> > -        bool ib_found =3D false;
> > -
> > -        for (int x =3D 0; x < num_devices; x++) {
> > -            verbs =3D ibv_open_device(dev_list[x]);
> > -            /*
> > -             * ibv_open_device() is not documented to set errno.  If
> > -             * it does, it's somebody else's doc bug.  If it doesn't,
> > -             * the use of errno below is wrong.
> > -             * TODO Find out whether ibv_open_device() sets errno.
> > -             */
> > -            if (!verbs) {
> > -                if (errno =3D=3D EPERM) {
> > -                    continue;
> > -                } else {
> > -                    error_setg_errno(errp, errno,
> > -                                     "could not open RDMA device conte=
xt");
> > -                    return -1;
> > -                }
> > -            }
> > -
> > -            if (ibv_query_port(verbs, 1, &port_attr)) {
> > -                ibv_close_device(verbs);
> > -                error_setg(errp,
> > -                           "RDMA ERROR: Could not query initial IB por=
t");
> > -                return -1;
> > -            }
> > -
> > -            if (port_attr.link_layer =3D=3D IBV_LINK_LAYER_INFINIBAND)=
 {
> > -                ib_found =3D true;
> > -            } else if (port_attr.link_layer =3D=3D IBV_LINK_LAYER_ETHE=
RNET) {
> > -                roce_found =3D true;
> > -            }
> > -
> > -            ibv_close_device(verbs);
> > -
> > -        }
> > -
> > -        if (roce_found) {
> > -            if (ib_found) {
> > -                warn_report("migrations may fail:"
> > -                            " IPv6 over RoCE / iWARP in linux"
> > -                            " is broken. But since you appear to have =
a"
> > -                            " mixed RoCE / IB environment, be sure to =
only"
> > -                            " migrate over the IB fabric until the ker=
nel "
> > -                            " fixes the bug.");
> > -            } else {
> > -                error_setg(errp, "RDMA ERROR: "
> > -                           "You only have RoCE / iWARP devices in your=
 systems"
> > -                           " and your management software has specifie=
d '[::]'"
> > -                           ", but IPv6 over RoCE / iWARP is not suppor=
ted in Linux.");
> > -                return -1;
> > -            }
> > -        }
> > -
> > -        return 0;
> > -    }
> > -
> > -    /*
> > -     * If we have a verbs context, that means that some other than '[:=
:]' was
> > -     * used by the management software for binding. In which case we c=
an
> > -     * actually warn the user about a potentially broken kernel.
> > -     */
> > -
> > -    /* IB ports start with 1, not 0 */
> > -    if (ibv_query_port(verbs, 1, &port_attr)) {
> > -        error_setg(errp, "RDMA ERROR: Could not query initial IB port"=
);
> > -        return -1;
> > -    }
> > -
> > -    if (port_attr.link_layer =3D=3D IBV_LINK_LAYER_ETHERNET) {
> > -        error_setg(errp, "RDMA ERROR: "
> > -                   "Linux kernel's RoCE / iWARP does not support IPv6 =
"
> > -                   "(but patches on linux-rdma in progress)");
> > -        return -1;
> > -    }
> > -
> > -#endif
> > -
> > -    return 0;
> > -}
> > -
> >  /*
> >   * Figure out which RDMA device corresponds to the requested IP hostna=
me
> >   * Also create the initial connection manager identifiers for opening
> > @@ -955,7 +812,6 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma=
, Error **errp)
> >
> >      /* Try all addresses, saving the first error in @err */
> >      for (struct rdma_addrinfo *e =3D res; e !=3D NULL; e =3D e->ai_nex=
t) {
> > -        Error **local_errp =3D err ? NULL : &err;
> >
> >          inet_ntop(e->ai_family,
> >              &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, si=
zeof ip);
> > @@ -964,13 +820,6 @@ static int qemu_rdma_resolve_host(RDMAContext *rdm=
a, Error **errp)
> >          ret =3D rdma_resolve_addr(rdma->cm_id, NULL, e->ai_dst_addr,
> >                  RDMA_RESOLVE_TIMEOUT_MS);
> >          if (ret >=3D 0) {
> > -            if (e->ai_family =3D=3D AF_INET6) {
> > -                ret =3D qemu_rdma_broken_ipv6_kernel(rdma->cm_id->verb=
s,
> > -                                                   local_errp);
> > -                if (ret < 0) {
> > -                    continue;
> > -                }
> > -            }
> >              error_free(err);
>
> err is now unused and should be removed entirely. The comment before the
> loop needs touching up as well.

Good catch, will fix both in v2.
>
> >              goto route;
> >          }
> > @@ -2663,7 +2512,6 @@ static int qemu_rdma_dest_init(RDMAContext *rdma,=
 Error **errp)
> >
> >      /* Try all addresses, saving the first error in @err */
> >      for (e =3D res; e !=3D NULL; e =3D e->ai_next) {
> > -        Error **local_errp =3D err ? NULL : &err;
> >
> >          inet_ntop(e->ai_family,
> >              &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, si=
zeof ip);
> > @@ -2672,13 +2520,6 @@ static int qemu_rdma_dest_init(RDMAContext *rdma=
, Error **errp)
> >          if (ret < 0) {
> >              continue;
> >          }
> > -        if (e->ai_family =3D=3D AF_INET6) {
> > -            ret =3D qemu_rdma_broken_ipv6_kernel(listen_id->verbs,
> > -                                               local_errp);
> > -            if (ret < 0) {
> > -                continue;
> > -            }
> > -        }
> >          error_free(err);
>
> Same here.
>
> >          break;
> >      }

