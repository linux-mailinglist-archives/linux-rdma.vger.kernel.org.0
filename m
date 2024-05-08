Return-Path: <linux-rdma+bounces-2344-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CAD8BFC41
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 13:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B361F22241
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 11:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB847839FF;
	Wed,  8 May 2024 11:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PccTtZkI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D9A839E4
	for <linux-rdma@vger.kernel.org>; Wed,  8 May 2024 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168284; cv=none; b=mif6ZKvXt3voASoizrxkT7s6kzlzqddd4vMGDZzp3t+I6TdJ4GOxH1JbLHiW41IiAdKnzxVACh5nKuAfa9sjVsx/lL7GnU+jQWM5KENSy2gQLv6YtkHl0PIiLbRqkj+F+IMHzEE26iS6V3ac9QolVMd/gj8ARJ7GJFPfgPmicFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168284; c=relaxed/simple;
	bh=w8vkuvXBBVxKGRD3KwWJ2CqLpfAyTR2dUnE0JgFsrFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bI8I5f4p7GhgsTkzX6J2tj23EoXR/C08PGj9WK5hblsMWBm8bAGw+OgZV6wez4xKZ3jrZw+qnkybEO+tVe+catKcdzL/8+xNGP0XYpJdvR4w00fmhUACrEECxUQYFVlEIrQlNyuL4POmK7PtlaxddE2R2J//e4l4XNT5VeDyotA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PccTtZkI; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de6074a464aso4654310276.0
        for <linux-rdma@vger.kernel.org>; Wed, 08 May 2024 04:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715168281; x=1715773081; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2hHlvEvHl/LLzml5MmXo3tqm8HbKr6QE3ucojA1kuhg=;
        b=PccTtZkIEkNyadePV598XsWMDURqYUtLkHVd/IZFJst4I5C7aZXwL1xxeZke+wpcgr
         md/fCsl8s9s7BuK8KWqdes+0FFFO9MiKR55LnOB4MnOBvmILFTReKiocfKd7tXG0nas6
         T1Q/tvlMx4VBUzUs/BCGHHDAsuiyCKr0qveEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168281; x=1715773081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hHlvEvHl/LLzml5MmXo3tqm8HbKr6QE3ucojA1kuhg=;
        b=BC25AGRLoqmnawQvGX5QLGTPQGe1ri9e1Cl+F0xKZiY/xtXCNoJTc0vPeyTrbeJiDz
         WrLyXjgNRD0vXBaAp5pU7SPJlMYcPKBzP8L35jysiOYshmuM2hBzsutlH3ZJ2F1ndbMz
         LEgjuCn65kguaiqESYq8ILiMOYPo3qZRfVTwm3wgxZlk6mwt94NKQ2ypSz7JFyyaknxF
         51F7PwxpzNSajIXvcE3WtVzLedNLFHse8uYwtCNAiiGBAGvyABv1yVw2TZAdR5ScViHQ
         5fMIfMpO3N1XvkkIMoF+Fcnr+Vi0VguaQJvm1Opf0BE/iujrN9qIp2hZZFt9rTXqI9D2
         2M0g==
X-Forwarded-Encrypted: i=1; AJvYcCWzsbWKnpMVOY/UlgqUDCUT7hAyNeWUX9iB3beSI9DaeHPatep3i3ZPYbXv0VwQXY5uveslxnZWwSdPWNJTYJwFHvFMqqxy00wq0Q==
X-Gm-Message-State: AOJu0YzLYwnb7gyZz7nDlGZ0FUwO+I+UqZ3DKj04XsMHNfmBmWrPJnIl
	U4dJ5+fuzlF3J3BdlMQEc7F7uYDRt94545xAV9iuDE0TDKz5uXBNAXGb8uIZKwA0Y8ZpWC8PTbU
	8DndUsDh8Ed06CAbwkbQ7NL6A0WfLkTdV+Gna
X-Google-Smtp-Source: AGHT+IE7+5hD8vaHxlSHFKeB32y+Axuwv2U+Nf23vOgdXYwHps4xkJ/AU7kOHGSLvQBiRDXSGnObqGUuG2+/N8DalJA=
X-Received: by 2002:a25:9e0e:0:b0:de5:9f17:1ccc with SMTP id
 3f1490d57ef6-debb9e4d8eemr2152934276.54.1715168281161; Wed, 08 May 2024
 04:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507103929.30003-1-mschmidt@redhat.com>
In-Reply-To: <20240507103929.30003-1-mschmidt@redhat.com>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Wed, 8 May 2024 17:07:47 +0530
Message-ID: <CA+sbYW0adh=c_TxeYmtTxnQosZnRdpncGT0=zDROudBreuHwhw@mail.gmail.com>
Subject: Re: [PATCH] bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
To: Michal Schmidt <mschmidt@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Devesh Sharma <devesh.sharma@broadcom.com>, 
	Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002a0f420617efbc1a"

--0000000000002a0f420617efbc1a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 4:10=E2=80=AFPM Michal Schmidt <mschmidt@redhat.com>=
 wrote:
>
> Undefined behavior is triggered when bnxt_qplib_alloc_init_hwq is called
> with hwq_attr->aux_depth !=3D 0 and hwq_attr->aux_stride =3D=3D 0.
> In that case, "roundup_pow_of_two(hwq_attr->aux_stride)" gets called.
> roundup_pow_of_two is documented as undefined for 0.
>
> Fix it in the one caller that had this combination.
>
> The undefined behavior was detected by UBSAN:
>   UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
>   shift exponent 64 is too large for 64-bit type 'long unsigned int'
>   CPU: 24 PID: 1075 Comm: (udev-worker) Not tainted 6.9.0-rc6+ #4
>   Hardware name: Abacus electric, s.r.o. - servis@abacus.cz Super Server/=
H12SSW-iN, BIOS 2.7 10/25/2023
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x5d/0x80
>    ubsan_epilogue+0x5/0x30
>    __ubsan_handle_shift_out_of_bounds.cold+0x61/0xec
>    __roundup_pow_of_two+0x25/0x35 [bnxt_re]
>    bnxt_qplib_alloc_init_hwq+0xa1/0x470 [bnxt_re]
>    bnxt_qplib_create_qp+0x19e/0x840 [bnxt_re]
>    bnxt_re_create_qp+0x9b1/0xcd0 [bnxt_re]
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? __kmalloc+0x1b6/0x4f0
>    ? create_qp.part.0+0x128/0x1c0 [ib_core]
>    ? __pfx_bnxt_re_create_qp+0x10/0x10 [bnxt_re]
>    create_qp.part.0+0x128/0x1c0 [ib_core]
>    ib_create_qp_kernel+0x50/0xd0 [ib_core]
>    create_mad_qp+0x8e/0xe0 [ib_core]
>    ? __pfx_qp_event_handler+0x10/0x10 [ib_core]
>    ib_mad_init_device+0x2be/0x680 [ib_core]
>    add_client_context+0x10d/0x1a0 [ib_core]
>    enable_device_and_get+0xe0/0x1d0 [ib_core]
>    ib_register_device+0x53c/0x630 [ib_core]
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    bnxt_re_probe+0xbd8/0xe50 [bnxt_re]
>    ? __pfx_bnxt_re_probe+0x10/0x10 [bnxt_re]
>    auxiliary_bus_probe+0x49/0x80
>    ? driver_sysfs_add+0x57/0xc0
>    really_probe+0xde/0x340
>    ? pm_runtime_barrier+0x54/0x90
>    ? __pfx___driver_attach+0x10/0x10
>    __driver_probe_device+0x78/0x110
>    driver_probe_device+0x1f/0xa0
>    __driver_attach+0xba/0x1c0
>    bus_for_each_dev+0x8f/0xe0
>    bus_add_driver+0x146/0x220
>    driver_register+0x72/0xd0
>    __auxiliary_driver_register+0x6e/0xd0
>    ? __pfx_bnxt_re_mod_init+0x10/0x10 [bnxt_re]
>    bnxt_re_mod_init+0x3e/0xff0 [bnxt_re]
>    ? __pfx_bnxt_re_mod_init+0x10/0x10 [bnxt_re]
>    do_one_initcall+0x5b/0x310
>    do_init_module+0x90/0x250
>    init_module_from_file+0x86/0xc0
>    idempotent_init_module+0x121/0x2b0
>    __x64_sys_finit_module+0x5e/0xb0
>    do_syscall_64+0x82/0x160
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? syscall_exit_to_user_mode_prepare+0x149/0x170
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? syscall_exit_to_user_mode+0x75/0x230
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? do_syscall_64+0x8e/0x160
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? __count_memcg_events+0x69/0x100
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? count_memcg_events.constprop.0+0x1a/0x30
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? handle_mm_fault+0x1f0/0x300
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? do_user_addr_fault+0x34e/0x640
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   RIP: 0033:0x7f4e5132821d
>   Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 8b 0d e3 db 0c 00 f7 d8 64 89 01 48
>   RSP: 002b:00007ffca9c906a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
>   RAX: ffffffffffffffda RBX: 0000563ec8a8f130 RCX: 00007f4e5132821d
>   RDX: 0000000000000000 RSI: 00007f4e518fa07d RDI: 000000000000003b
>   RBP: 00007ffca9c90760 R08: 00007f4e513f6b20 R09: 00007ffca9c906f0
>   R10: 0000563ec8a8faa0 R11: 0000000000000246 R12: 00007f4e518fa07d
>   R13: 0000000000020000 R14: 0000563ec8409e90 R15: 0000563ec8a8fa60
>    </TASK>
>   ---[ end trace ]---
>
> Fixes: 0c4dcd602817 ("RDMA/bnxt_re: Refactor hardware queue memory alloca=
tion")
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>

Thanks,
Selvin
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniban=
d/hw/bnxt_re/qplib_fp.c
> index 439d0c7c5d0c..04258676d072 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> @@ -1013,7 +1013,8 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res=
, struct bnxt_qplib_qp *qp)
>         hwq_attr.stride =3D sizeof(struct sq_sge);
>         hwq_attr.depth =3D bnxt_qplib_get_depth(sq);
>         hwq_attr.aux_stride =3D psn_sz;
> -       hwq_attr.aux_depth =3D bnxt_qplib_set_sq_size(sq, qp->wqe_mode);
> +       hwq_attr.aux_depth =3D psn_sz ? bnxt_qplib_set_sq_size(sq, qp->wq=
e_mode)
> +                                   : 0;
>         /* Update msn tbl size */
>         if (BNXT_RE_HW_RETX(qp->dev_cap_flags) && psn_sz) {
>                 hwq_attr.aux_depth =3D roundup_pow_of_two(bnxt_qplib_set_=
sq_size(sq, qp->wqe_mode));
> --
> 2.44.0
>

--0000000000002a0f420617efbc1a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
FYMZp2DojLAq9f4Oi2OBetbnWxo0WGycXpmq/jC4PUx2u9mazQ79i80VLagGRshWniESXuf+SYG8
+zBimjld9ZZnwm7itHAZdtme4YYFxx+EHa4PUxPV8t+hPHhsiIjirPa1pVXPbQIDAQABo4IB2zCC
AdcwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU3TaH
dsgUhTW3LwObmZ20fj+8Xj8wDQYJKoZIhvcNAQELBQADggEBAAbt6Sptp6ZlTnhM2FDhkVXks68/
iqvfL/e8wSPVdBxOuiP+8EXGLV3E72KfTTJXMbkcmFpK2K11poBDQJhz0xyOGTESjXNnN6Eqq+iX
hQtF8xG2lzPq8MijKI4qXk5Vy5DYfwsVfcF0qJw5AhC32nU9uuIPJq8/mQbZfqmoanV/yadootGr
j1Ze9ndr+YDXPpCymOsynmmw0ErHZGGW1OmMpAEt0A+613glWCURLDlP8HONi1wnINV6aDiEf0ad
9NMGxDsp+YWiRXD3txfo2OMQbpIxM90QfhKKacX8t1J1oAAWxDrLVTJBXBNvz5tr+D1sYwuye93r
hImmkM1unboxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICpS/U0ZqW2m
hjhqTKKsGzswafTMCTNCNALUTnKMCffXMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MDUwODExMzgwMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB33rIwmajxgSV+OuxLWgm63rhaliyu
D7v+f/CQhMHoT48Snia7Pa1mSiT0Nhadqmh2wffawKYCQg1gq9RZDbsQR/QdhC7QHSYr7iUjqgIf
+ptnsMs3glTtOFGQ5Jo1X+qKBrYSWshWzEEP89dc/37BrS1E5IKXDalVHaLWO6CE6CM0p3Dto4oh
NTlod5EAEksdHJJE9AZD7LNQvT9KzjtbPxXeL/8GfueOFWjnq8v0BrkEUT9g4WJpVJSazP7RJ1Cl
7QzgzDetcbLNJU6TJZImxqVYmmIaCEGwj4ncadicaOimaGd7vJhrQlnE6xg8jE17gtRFWGdmiES4
TMTvB0p0
--0000000000002a0f420617efbc1a--

