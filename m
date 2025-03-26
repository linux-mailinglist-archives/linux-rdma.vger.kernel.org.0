Return-Path: <linux-rdma+bounces-8974-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E58A717E9
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 14:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E056C3B2878
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 13:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E451EE03B;
	Wed, 26 Mar 2025 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="EbrryEq3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668721E5B96
	for <linux-rdma@vger.kernel.org>; Wed, 26 Mar 2025 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997316; cv=none; b=u1KKinOEX66DLscbpRMqQAt3LXnZgtKGWkvcUg7el0JmkFhuLOA6igQ9LDhAZayFfL5deOwmdKo3vn9VCvHwLQiYCcxC2ZjUY1deU9OElGxYY+bJP8opaCdm9kDXDIeh4edpkuTRB13cxWk+By/4d1rVKigHLWtc4KzNIgKbYw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997316; c=relaxed/simple;
	bh=fjvuEdiPvGnepJoecHlLa/t3Ke+3SSvKCkci7cLY6+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIRSasivVv/dPXvBE+w7kz7qYHRX62jOB0suL2v6AVTzW+GoaJcnWJc77/NUmEyuz0u8lBXugerCvkXLpkPXKGdknyz+WfZ8eVp489qj9l4n84O/BMWh5nMq13MYf1MnGuI1ZmXgnb/AsIw7Y++iSix5PqoF0AJ/AlsydrWkELM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=EbrryEq3; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5ea062471so1146283a12.2
        for <linux-rdma@vger.kernel.org>; Wed, 26 Mar 2025 06:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1742997311; x=1743602111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09g9flF/oFbPk/xe12aV0T7C1CZv1MMQKeIeigDsuyg=;
        b=EbrryEq3ufDLkyjl9bv+oOQuEMnCclkTZhiwL/RdZFrIsAYVn+0yEPxT5hFoHIlZwX
         RfzyBmO2wtv32YTuPCUAu72iKivq0q5y/i0g1Xh6I5KsQStNaAd+UbQBl1ZjadZuHqnf
         4SGqFT8WFsc46Y38wHvR8KSe0YEKdXEgc7m9tLzBzbK/b8Lssl7yODFpuPj2Sm32/Y3P
         aSfQTkv1W9XsxjGovOI+Biwysf0SVs1zC7aCEUDx9gHspVHJATpsQD4nm7vzW4gKYDVH
         fhibOCYwo0ZfQNxMl8QpPX2M71uPWNtiM3JzOV9sVzZus4Q9tkXprQara+ZVyL5dAFo+
         CkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742997311; x=1743602111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09g9flF/oFbPk/xe12aV0T7C1CZv1MMQKeIeigDsuyg=;
        b=CScnFVgeaXoimKxdjEs8tHDltwfJv1DxwegWYZ7lQ/pWTEmeeItl6dEoAJmCAenbng
         3SJrRCdakwDtCWPNa5RDHCLDI0zdqfWasVPCEoHa1O5wEY0zQo4Vaecz7FdNEhe6Pboe
         r8nPoiy/RZ7uOpoMnOkwNWmKDoasjkI6L1ZYXlHj/z4v5WjFuAPjaTST5T403bdf/l4a
         b+dYg9ISFbmkAknLh/d94c7UD4mGTq7rqSwZUeIiF+lk4IHCnTSHcLrw/buCAZDNHsma
         3rKUK0ovg0eXtS1+Ch7/19HpgvfbaOnrcl34iTQnU0esiYKDFljI1E5gipXoC35y3bvP
         9s9Q==
X-Forwarded-Encrypted: i=1; AJvYcCURF5zedffR5knDMUUYXbC9lafQFcFJSFSR49GO8rPUT1YN/XDs8tgdwRI4tS6p0UnbzXC3k0kl8cWo@vger.kernel.org
X-Gm-Message-State: AOJu0YxJwOQcukYiK/r5g1OePZfodgrMZD1VJF/EJGyyC/6ISds16lE/
	A7sj1AyexSFpxiNx8b9/meocYaPlqQ9D/dhVMVMvP7B7cTjPtc0L4zCFYDzY4mOATJ/2OcMZRZy
	kSQRArmZCPAU35jKU6z7TBr6951xz6sBS9yQ8Qg==
X-Gm-Gg: ASbGncsQ9ghKCBaI3L7SmicT4tOoO8S0YxRJ/FYRortL52n0yTjrgUsNcwHg7x12Tb9
	FmpHVA8fEqNRvDZOAQlz6cnXNophn/0CoSukdIT47VPOHRlcTIcXi37o8oRv1aYw/HkwvynnlGv
	hfVqRo6KJ0b1ll/3Pq8XnkvkDzFw==
X-Google-Smtp-Source: AGHT+IEiG0CeRMjBSef4h/Nzd6NaSXk29KG6VohzUbm3x01H+sT5g1bHGQ3/DS0VYich/lBJlU2lhLusNVycWnvqaOw=
X-Received: by 2002:a05:6402:524f:b0:5e0:7ffd:a6ef with SMTP id
 4fb4d7f45d1cf-5ed1440e615mr2630334a12.5.1742997311425; Wed, 26 Mar 2025
 06:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326095224.9918-1-jinpu.wang@ionos.com> <e742d858-f84f-48a0-8f8a-5ad8e4d48a61@flatgalaxy.com>
In-Reply-To: <e742d858-f84f-48a0-8f8a-5ad8e4d48a61@flatgalaxy.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 26 Mar 2025 14:54:59 +0100
X-Gm-Features: AQ5f1Jq2uxj7YWrcgjc_zerZ_6EqbySsKpYmPbTIg3Ee-Kdap0zZFt6U7rSZ74o
Message-ID: <CAMGffEn514ySdg+OEmq2dBy2gyaVaWm8Le5+YyZ=Uu6gnFd9cQ@mail.gmail.com>
Subject: Re: [RFC PATCH] migration/rdma: Remove qemu_rdma_broken_ipv6_kernel
To: michael@flatgalaxy.com
Cc: qemu-devel@nongnu.org, farosas@suse.de, peterx@redhat.com, 
	mrgalaxy@nvidia.com, Li Zhijian <lizhijian@fujitsu.com>, Yu Zhang <yu.zhang@ionos.com>, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 2:47=E2=80=AFPM Michael Galaxy <michael@flatgalaxy.=
com> wrote:
>
> Excellent find. Thank you very much for checking on the history. Hopefull=
y my comments were not too hard to read. =3D)
Yeah, it's pretty clear.
>
> FYI: I've since left Akamai last year and now work at Nvidia.
>
> Reviewed-by: Michael Galaxy <mrgalaxy@nvidia.com>
cool, thx for the review. All the best at your new job.
>
> On 3/26/25 04:52, Jack Wang wrote:
>
> I hit following error which testing migration in pure RoCE env:
> "-incoming rdma:[::]:8089: RDMA ERROR: You only have RoCE / iWARP devices=
 in your
> systems and your management software has specified '[::]', but IPv6 over =
RoCE /
> iWARP is not supported in Linux.#012'."
>
> In our setup, we use rdma bind on ipv6 on target host, while connect from=
 source
> with ipv4, remove the qemu_rdma_broken_ipv6_kernel, migration just work
> fine.
>
> Checking the git history, the function was added since introducing of
> rdma migration, which is more than 10 years ago. linux-rdma has
> improved support on RoCE/iWARP for ipv6 over past years. There are a few =
fixes
> back in 2016 seems related to the issue, eg:
> aeb76df46d11 ("IB/core: Set routable RoCE gid type for ipv4/ipv6 networks=
")
>
> other fixes back in 2018, eg:
> 052eac6eeb56 RDMA/cma: Update RoCE multicast routines to use net namespac=
e
> 8d20a1f0ecd5 RDMA/cma: Fix rdma_cm raw IB path setting for RoCE
> 9327c7afdce3 RDMA/cma: Provide a function to set RoCE path record L2 para=
meters
> 5c181bda77f4 RDMA/cma: Set default GID type as RoCE when resolving RoCE r=
oute
> 3c7f67d1880d IB/cma: Fix default RoCE type setting
> be1d325a3358 IB/core: Set RoCEv2 MGID according to spec
> 63a5f483af0e IB/cma: Set default gid type to RoCEv2
>
> So remove the outdated function and it's usage.
>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Li Zhijian <lizhijian@fujitsu.com>
> Cc: Yu Zhang <yu.zhang@ionos.com>
> Cc: qemu-devel@nongnu.org
> Cc: linux-rdma@vger.kernel.org
> Cc: michael@flatgalaxy.com
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  migration/rdma.c | 157 -----------------------------------------------
>  1 file changed, 157 deletions(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 76fb0349238a..5ce628ddeef0 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -767,149 +767,6 @@ static void qemu_rdma_dump_gid(const char *who, str=
uct rdma_cm_id *id)
>      trace_qemu_rdma_dump_gid(who, sgid, dgid);
>  }
>
> -/*
> - * As of now, IPv6 over RoCE / iWARP is not supported by linux.
> - * We will try the next addrinfo struct, and fail if there are
> - * no other valid addresses to bind against.
> - *
> - * If user is listening on '[::]', then we will not have a opened a devi=
ce
> - * yet and have no way of verifying if the device is RoCE or not.
> - *
> - * In this case, the source VM will throw an error for ALL types of
> - * connections (both IPv4 and IPv6) if the destination machine does not =
have
> - * a regular infiniband network available for use.
> - *
> - * The only way to guarantee that an error is thrown for broken kernels =
is
> - * for the management software to choose a *specific* interface at bind =
time
> - * and validate what time of hardware it is.
> - *
> - * Unfortunately, this puts the user in a fix:
> - *
> - *  If the source VM connects with an IPv4 address without knowing that =
the
> - *  destination has bound to '[::]' the migration will unconditionally f=
ail
> - *  unless the management software is explicitly listening on the IPv4
> - *  address while using a RoCE-based device.
> - *
> - *  If the source VM connects with an IPv6 address, then we're OK becaus=
e we can
> - *  throw an error on the source (and similarly on the destination).
> - *
> - *  But in mixed environments, this will be broken for a while until it =
is fixed
> - *  inside linux.
> - *
> - * We do provide a *tiny* bit of help in this function: We can list all =
of the
> - * devices in the system and check to see if all the devices are RoCE or
> - * Infiniband.
> - *
> - * If we detect that we have a *pure* RoCE environment, then we can safe=
ly
> - * thrown an error even if the management software has specified '[::]' =
as the
> - * bind address.
> - *
> - * However, if there is are multiple hetergeneous devices, then we canno=
t make
> - * this assumption and the user just has to be sure they know what they =
are
> - * doing.
> - *
> - * Patches are being reviewed on linux-rdma.
> - */
> -static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error=
 **errp)
> -{
> -    /* This bug only exists in linux, to our knowledge. */
> -#ifdef CONFIG_LINUX
> -    struct ibv_port_attr port_attr;
> -
> -    /*
> -     * Verbs are only NULL if management has bound to '[::]'.
> -     *
> -     * Let's iterate through all the devices and see if there any pure I=
B
> -     * devices (non-ethernet).
> -     *
> -     * If not, then we can safely proceed with the migration.
> -     * Otherwise, there are no guarantees until the bug is fixed in linu=
x.
> -     */
> -    if (!verbs) {
> -        int num_devices;
> -        struct ibv_device **dev_list =3D ibv_get_device_list(&num_device=
s);
> -        bool roce_found =3D false;
> -        bool ib_found =3D false;
> -
> -        for (int x =3D 0; x < num_devices; x++) {
> -            verbs =3D ibv_open_device(dev_list[x]);
> -            /*
> -             * ibv_open_device() is not documented to set errno.  If
> -             * it does, it's somebody else's doc bug.  If it doesn't,
> -             * the use of errno below is wrong.
> -             * TODO Find out whether ibv_open_device() sets errno.
> -             */
> -            if (!verbs) {
> -                if (errno =3D=3D EPERM) {
> -                    continue;
> -                } else {
> -                    error_setg_errno(errp, errno,
> -                                     "could not open RDMA device context=
");
> -                    return -1;
> -                }
> -            }
> -
> -            if (ibv_query_port(verbs, 1, &port_attr)) {
> -                ibv_close_device(verbs);
> -                error_setg(errp,
> -                           "RDMA ERROR: Could not query initial IB port"=
);
> -                return -1;
> -            }
> -
> -            if (port_attr.link_layer =3D=3D IBV_LINK_LAYER_INFINIBAND) {
> -                ib_found =3D true;
> -            } else if (port_attr.link_layer =3D=3D IBV_LINK_LAYER_ETHERN=
ET) {
> -                roce_found =3D true;
> -            }
> -
> -            ibv_close_device(verbs);
> -
> -        }
> -
> -        if (roce_found) {
> -            if (ib_found) {
> -                warn_report("migrations may fail:"
> -                            " IPv6 over RoCE / iWARP in linux"
> -                            " is broken. But since you appear to have a"
> -                            " mixed RoCE / IB environment, be sure to on=
ly"
> -                            " migrate over the IB fabric until the kerne=
l "
> -                            " fixes the bug.");
> -            } else {
> -                error_setg(errp, "RDMA ERROR: "
> -                           "You only have RoCE / iWARP devices in your s=
ystems"
> -                           " and your management software has specified =
'[::]'"
> -                           ", but IPv6 over RoCE / iWARP is not supporte=
d in Linux.");
> -                return -1;
> -            }
> -        }
> -
> -        return 0;
> -    }
> -
> -    /*
> -     * If we have a verbs context, that means that some other than '[::]=
' was
> -     * used by the management software for binding. In which case we can
> -     * actually warn the user about a potentially broken kernel.
> -     */
> -
> -    /* IB ports start with 1, not 0 */
> -    if (ibv_query_port(verbs, 1, &port_attr)) {
> -        error_setg(errp, "RDMA ERROR: Could not query initial IB port");
> -        return -1;
> -    }
> -
> -    if (port_attr.link_layer =3D=3D IBV_LINK_LAYER_ETHERNET) {
> -        error_setg(errp, "RDMA ERROR: "
> -                   "Linux kernel's RoCE / iWARP does not support IPv6 "
> -                   "(but patches on linux-rdma in progress)");
> -        return -1;
> -    }
> -
> -#endif
> -
> -    return 0;
> -}
> -
>  /*
>   * Figure out which RDMA device corresponds to the requested IP hostname
>   * Also create the initial connection manager identifiers for opening
> @@ -964,13 +821,6 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma,=
 Error **errp)
>          ret =3D rdma_resolve_addr(rdma->cm_id, NULL, e->ai_dst_addr,
>                  RDMA_RESOLVE_TIMEOUT_MS);
>          if (ret >=3D 0) {
> -            if (e->ai_family =3D=3D AF_INET6) {
> -                ret =3D qemu_rdma_broken_ipv6_kernel(rdma->cm_id->verbs,
> -                                                   local_errp);
> -                if (ret < 0) {
> -                    continue;
> -                }
> -            }
>              error_free(err);
>              goto route;
>          }
> @@ -2672,13 +2522,6 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, =
Error **errp)
>          if (ret < 0) {
>              continue;
>          }
> -        if (e->ai_family =3D=3D AF_INET6) {
> -            ret =3D qemu_rdma_broken_ipv6_kernel(listen_id->verbs,
> -                                               local_errp);
> -            if (ret < 0) {
> -                continue;
> -            }
> -        }
>          error_free(err);
>          break;
>      }

