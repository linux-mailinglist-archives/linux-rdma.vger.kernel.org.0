Return-Path: <linux-rdma+bounces-4564-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C53EB95E7B2
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2024 06:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 161C5B20ED3
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2024 04:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1B827701;
	Mon, 26 Aug 2024 04:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ROCbsTlC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399B62C95
	for <linux-rdma@vger.kernel.org>; Mon, 26 Aug 2024 04:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724647107; cv=none; b=WMiZF8nPEt/BcGzC8a1EGM/Ugx7uuXiOF4NUbit449+zSWZPkYSbKh1/zhPScHcaBAhYwF6eIJK3h7uR/IUPb2LGxtAIoSMmdte9Z2FXS/M1l4FDbmipGjurWYVmLFM1G7nFjV8eaG4AOCvbmO230pz2S2k1Gj/IrNu2Ik9ipBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724647107; c=relaxed/simple;
	bh=hDbfNryrrDcCc6r8rNs/AYZjt6kGyQjqGO6nrPNLcbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBUSYBL/4leBoM2uSPwDIVQGIjyr242K730wZ9obByINKXgDMwfsNBjZGgY7lj4a4nCbDAslcRYzXd09rausPWCrRkJ5DSUDaT5n0AV1HrY50CyiKu4OUVSOWTLG7aSC6cLCOd774OOj6QIxyCTVSttrwRokasyygutopn6HlH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ROCbsTlC; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e165ab430e7so3935271276.2
        for <linux-rdma@vger.kernel.org>; Sun, 25 Aug 2024 21:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724647105; x=1725251905; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a6GEGydyfh4ER7o2uUogIY9d2ihZNAK7+qqbnXNp3Oc=;
        b=ROCbsTlCHEuUqH+pOhjKoSNHH2gjrW+U9GKkkxbGplfHmvB+Q2bBSnR8JfBBk3uBSD
         RmT+Igle5DHeV45o+gJz/tFUOFjKHeN7GNzyiEKO2isHKupzVjdvG5zkPNZ9b844h0Gp
         zRUqFlQWlDVsmicnQ/2NR03uQcEedXT0/QdzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724647105; x=1725251905;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6GEGydyfh4ER7o2uUogIY9d2ihZNAK7+qqbnXNp3Oc=;
        b=g5vIDn0KB5BzRdq+bw/XsTKAp0AwGjKUS0IooPT+UBfHeS4ZL1wHi2FZS/c4zy1bLB
         CtWXu0QBnhKqHpqhGV2IHcCCBEZTz3twOpwPCjpgiD6EBHALUyzAwgh9Fi0WkUDaF1Co
         Y5gHDrEHE+sz5/FIr5ET64+Y1jy830BB1YGo8wQJoKIq5mzfN6oeIv4acQduCF1WPn/O
         R3ULBMjQiY9Foz4jYt1Pe6kIDn2QC8jjrBGPERnWqz4LabNsAcV71zBOZ5xaPEqFBeIW
         B85EgRiHecNq4i7TJIt8pbyKHmtQA0s7HKCQsKy9UgrZuS73nxVcnyP+at8Jmm627gPt
         F7sA==
X-Gm-Message-State: AOJu0YwSc4MQUFs83AZq/QvjYtXHLqlpXrRr10A9vJ1Zp0zCbeaqsfQB
	Spr9RZrWhTA7S406mkbMJm5TeHgmQoHfvNw6lfOxcQhZGNsYucj6c2z1duZTrb8T22KkYeuMy4d
	x2Jsuteh1soR8qjau3wx3/XWU8VbRJH62CEZG
X-Google-Smtp-Source: AGHT+IHnAl+W+QHFBmWikpVIMHGbF/LMkTKhTtcOrZYQOb5vSFTBwxSw10Na/SDZHDd00UMU3lLEHJ0zIsnDh/W/hEo=
X-Received: by 2002:a05:6902:2709:b0:e16:19f7:96df with SMTP id
 3f1490d57ef6-e17a83d45a6mr10106379276.10.1724647105062; Sun, 25 Aug 2024
 21:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1724042847-1481-1-git-send-email-selvin.xavier@broadcom.com>
In-Reply-To: <1724042847-1481-1-git-send-email-selvin.xavier@broadcom.com>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Mon, 26 Aug 2024 10:08:12 +0530
Message-ID: <CA+sbYW22H6FjgSLdUJtz_Pm+kqo+QXTP2iDade=foZZjU31ZRA@mail.gmail.com>
Subject: Re: [PATCH for-next v3 0/5] RDMA/bnxt_re: Use variable size Work
 Queue entry for Gen P7 adapters
To: leon@kernel.org, jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001406b706208eb24e"

--0000000000001406b706208eb24e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leon/Jason,
 Can you please review and merge these changes if you dont have any comment=
s?

Thanks,
Selvin

On Mon, Aug 19, 2024 at 10:38=E2=80=AFAM Selvin Xavier
<selvin.xavier@broadcom.com> wrote:
>
> Enable the Variable size Work Queue entry support for Gen P7 adapters. Th=
is would
> help in the better utilization of the queue memory and pci bandwidth due =
to the
> smaller send queue Work entries.
>
> Please review and apply.
>
> Thanks,
> Selvin Xavier
>
> v2 -> v3:
>   Fix a sparse error
>         - Reported-by: kernel test robot <lkp@intel.com>
>         - Closes: https://lore.kernel.org/oe-kbuild-all/202408181809.Sed4=
EJbs-lkp@intel.com/
>
>   Split the patch 3 from v2 series  into two - a bug fix and functional c=
hange
>
> v1 -> v2:
>   Fixing the mail id of the signed-off in the commit message.
>   No other functional changes
>
>
>
> Selvin Xavier (5):
>   RDMA/bnxt_re: Add support for Variable WQE in Genp7 adapters
>   RDMA/bnxt_re: Get the WQE index from slot index while completing the
>     WQEs
>   RDMA/bnxt_re: Fix the table size for PSN/MSN entries
>   RDMA/bnxt_re: Handle variable WQE support for user applications
>   RDMA/bnxt_re: Enable variable size WQEs for user space applications
>
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 119 +++++++++++++++++++------=
------
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h |  16 ++++-
>  drivers/infiniband/hw/bnxt_re/main.c     |  21 +++---
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c |  61 +++++++++++++---
>  drivers/infiniband/hw/bnxt_re/qplib_fp.h |  24 ++++++-
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c |   7 +-
>  drivers/infiniband/hw/bnxt_re/qplib_sp.h |   6 ++
>  include/uapi/rdma/bnxt_re-abi.h          |   7 ++
>  8 files changed, 188 insertions(+), 73 deletions(-)
>
> --
> 2.5.5
>

--0000000000001406b706208eb24e
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEwk8AoEvmhg
kxLQ3PhqB9vt6uLLGpTBByqY44pqxcHKMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MDgyNjA0MzgyNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBXM1OM1EfjcT8AuVvIgZS4FInp49eA
drjb+Xd6OkyYIbeoD2TDjK0esB5mG7ZXxvRAaE/vyawi7ZILpa91radg73MBjdvyyB6MBWpup2lj
kk8vOc+JYflrwc4cB3DiuoitdsyqyhDyOUh1UkmqyoKEJfolgWWeaUQMAupi6x6kZCjoG5zHFKWd
RQkb+5i5fvnxT8W1fbrSpbrYoJgi0LdhUFVrJTSz1Bkm474qZovhAoztOiMZNuUoLynllURiYPlE
CXDHNkXmYWhr/oTKchEjTtUBqwV5odDnvQ6ibccUh9V/Si2mGhMj5MJkX6TNEc7zRwt5FSsxkXiI
lrXekzyX
--0000000000001406b706208eb24e--

