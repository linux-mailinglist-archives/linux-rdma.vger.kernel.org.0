Return-Path: <linux-rdma+bounces-2671-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBEC8D3E46
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 20:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720821C22284
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 18:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF8015CD55;
	Wed, 29 May 2024 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SkAKjdEX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF07CDDA1
	for <linux-rdma@vger.kernel.org>; Wed, 29 May 2024 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007016; cv=none; b=lfN1c9hFKXmA0sVADTE5F/qBUo4zZSnECHDWjLzHCxGUe/mXvQUtuHhqKUHeddJswCqaeLbg+aIals5x1e+4bngDAxcrP+WlozbrlJgcav3lXuPsF7gZzXBj/CinxfxtQbdChFawB+bHsggRS41WkMYaP/8Aa/6l67RDyVs4t2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007016; c=relaxed/simple;
	bh=Ik//oIrmBrZ0E9ZPuV7SgX4MJSK5JfzsnI6hNqzn4jI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=YIH8WGsTyWJ6VfYnVtIBWKypiKtiqWGOezdLUJukdKvM+6ha3E/SmLg9uZlvkg5LOHrPotllvnFNfxccoNDOsWNOPngiYCv1jehdoonaJKVDRao5Yzt+uaX0vLOC2dCKU8mSvvk87kCoGfWQNK4DT+6zNZdvmLAV95vwi8KIsS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SkAKjdEX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42121d27861so212305e9.0
        for <linux-rdma@vger.kernel.org>; Wed, 29 May 2024 11:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717007009; x=1717611809; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DWW3/JCvJRHN++m1KJRk+ucOinbMtekGN4sCSGnOVrs=;
        b=SkAKjdEXSk5ESeU8QPDC5fMbjZyaXVZMDYAw1NB4cvrYyhm3cagn319arm36ubJFNs
         VEhe5tmkYO7PMCEpXeA3koNLSuCdRC5nJ3lm8HvF6kRIuNU2gES3jkJJkzvQrzmFsvqH
         sVq/5zes/yexUCdT2xv9jL24mFlRUNTa1JxibN8YPs9PDIr/tvcoMRhaEZQ64tRhwLSf
         rJRLymbLpOmRNszywu/W2RyxJm4nIJ3MnODWinoD83L9yDudFHGSIE/z3v1UyMusJQ1H
         HtFjNbCIkFDAdDWRxU/mSG/FGkC+2f68Huh2g38FksTOYzB2dBGzS5GMYsq7u1U/4+Cg
         EgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717007009; x=1717611809;
        h=content-transfer-encoding:autocrypt:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWW3/JCvJRHN++m1KJRk+ucOinbMtekGN4sCSGnOVrs=;
        b=u5J7vPSdddhbCIEWbX2i/wkdbKUiNw0drAdgP5c6aRZ9OEiQIimRKHZV4vHbJogpi8
         6ObHZZAl1OD5OrmNt3ut32HzdSlkFRe+u3FRzT0GqCXb0T7iWt+FyGc75ymyf8VyszQH
         VG4GEgsRQIMudYVA908P6mz9El9NbLicmkWdcwbJSLGc/fNFkPhdSMbcEcVTwbUpWH2r
         sQ+XFCg070FgvRdB7rIRajWwX2DTfikofIrHIcrNw7EVVhq4Xy2mXczq+7srePELmDCe
         3td0PG8Y/TFpZ5NuBx889VrhhTv5PtpgyuceXyzKa+kr3AUBizhDUlMZYzpCCOC8VgU0
         gqPA==
X-Gm-Message-State: AOJu0Yx8G+zKhIGZLAdBZhIfjgo64MeU98SgES26l5CAkXEp0tLvsnEI
	Vb19kftWfQhCXmoqSU8Oozotv+z2yGFoP1kn8CJEMhQSXlBa30WrD8zXWncl5EiUeuWi0zuxuHB
	o
X-Google-Smtp-Source: AGHT+IEUTJXWAaFizXPjOXKwI8cGHzvJd9YzROYwm1eIwGR3V75UyEPbvb/uOoD987F8LfSgSHCqww==
X-Received: by 2002:a05:600c:3b22:b0:420:1fa6:a3ee with SMTP id 5b1f17b1804b1-42108a1fa6emr122700905e9.27.1717007008930;
        Wed, 29 May 2024 11:23:28 -0700 (PDT)
Received: from [10.0.2.128] (anantes-654-1-140-64.w83-204.abo.wanadoo.fr. [83.204.35.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212705530bsm2293945e9.5.2024.05.29.11.23.28
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 11:23:28 -0700 (PDT)
Message-ID: <d2f96892-57a5-4bea-9d26-a0020b81d04d@suse.com>
Date: Wed, 29 May 2024 20:23:27 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nicolas Morey <nmorey@suse.com>
Subject: [ANNOUNCE] rdma-core: new stable releases
To: linux-rdma@vger.kernel.org
Content-Language: en-US
Autocrypt: addr=nmorey@suse.com; keydata=
 xsBNBFjZETwBCADEkoe7QWAXzd9xpSiPbQK6P2F4wKdxyTp6r0aN4I0O+4fc8xWXvmwOrCjF
 UsuoGZ3CxJaHgdB/3ueW/IhMO5Ldz7pylhKVlG/moUh4CBK2eRUdaG7mHID01GyJMtR3VQqu
 22hJhHPYy0erpYViyr+I4MzQA9QZLoQhSxn4imjZOZPcj20JE+lRfXppNv9g7vQiRLMcXjTi
 KcnrqG5owOi6Cn1sZ201YfdeztGxKA+jvjWO+6absTTlorIlZNGUf85s2+caGDsqa31u2DPs
 hVv5UUTy1g/5aP2wacSWI3Qm4n2MWl1aCnHN2h737PCXXfBk5iGJsgBUnSQULgdgEAt1ABEB
 AAHNH05pY29sYXMgTW9yZXkgPG5tb3JleUBzdXNlLmNvbT7CwI4EEwEIADgWIQRC0lOFwaHA
 K4sbHG+AG924JZiPZAUCY5G8SAIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRCAG924
 JZiPZMZiB/9QkcGfH248qvFUWZig3jssK5IgijfOFDKB0YK4e844M5C8LVSuWpu7Z+lM+cql
 3mbrikW6mlZjPEusrQ/KGvT6TdfOM9VCQWjlshMzt7uiRDdzufHGtE5hhk/67UnkEVjmplpD
 k8cb1O0VsBfGym7e0nySHTlDWqr++9EcwgV3uo4psYYEqm6Aon1yKqjbmj+vfl/C5iW3V4lq
 DhBk8w21AvNS+tdEqJzhruxuXkEDZZ07wYFS7m8OxLNb4sMzn/Nz9x/NXeweBWx2ujIERtAq
 1e/hh0ZAcoPVR3CfO2QTmfTfrzVdpZrZ8F54337ze3+BUNnrFGObQhlNe26NqNYWzsBNBFjZ
 ETwBCAC9zAzCRlTgzyO9siVLQYwbRUhcL1TUJU/FiOQWQTmL3uDdBc6MgVBs+hp82RwPbbXT
 v4W4rghBYPKdmFXvRN+jvGDLq1f2hsuCSiE1ckTMzFV+sKoWRIEC12tEpw5ncEFGm+1k/rJR
 Lk9eHxuqn+yRjPryN8CK6tK4+b4tZ2urKlP29XG+T3l/mbUSoqfjqvyeKaW6xw7ku89EX2Xo
 QWP/pm92RxUd6VDU9vpVW/T7qPZRl0wtUnDnO2wePoZmvUfEr5Osh3MNvm1myG+v4EV2Hgva
 NT6pa27IptrUq06cA6dDsIKwPtMuThJQp8/xumgl5Q9A/ErQoJTrB9rclIm7ABEBAAHCwF8E
 GAECAAkFAljZETwCGwwACgkQgBvduCWYj2QwNwf/eOIpFB67cKoUJvcm3JWcvnagZOuyasCw
 xwH9a0o9jORcq+nsJoynS/DpjUKGyZagy7+F7sBrF7Xx0cXF2f5Bo42XNNiQDE5P/VLwvgn9
 62AJ3q0dp4O7oQI8UgNmdsocQhNaBHHCoOabLGrgNobDTaLBeb9zaOZqz8CBuAiZ0bVABEpg
 50hDEYTHp4jCgWpadhAsp/eCgm93Tc+Y+e1fqtE3FmoOLxyhFa6evhn0Q1iX0kCasMZwlzse
 zqLZjTM1Koqn6+UIHXE3QaULyFKD1GDhisXxyolOB6P2TXsyfvitYdIZ3CCtI7PVDxzmX2Xk
 kvEz9bMtStoMpse9qAsmHQ==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These version were tagged/released:
 * v30.13
 * v31.14
 * v32.13
 * v33.13
 * v34.12
 * v35.11
 * v36.11
 * v37.10
 * v38.9
 * v39.8
 * v40.7
 * v41.7
 * v42.7
 * v43.6
 * v44.6
 * v45.5
 * v46.4
 * v47.3
 * v48.2
 * v49.2
 * v50.1
 * v51.1

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v30.13
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed May 29 17:11:20 2024 +0200

rdma-core-30.13:

Updates from version 30.12
 * Backport fixes:
   * libhns: Fix several context locks issue
   * librdmacm: Fix an overflow bug in qsort comparison function
   * librdmacm: Ack the pending event in sync UD connection
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmZXRZgQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZKTvCACjVJt11dNzoHTa5+KswudEbAwgCgFA+aHA
N4m55YalZgxFSuV7eHcPd+wmcJSEbMJNztjTP7H/mMszLDO9EkQiJ4vl+rNqNgl4
1EbqahECUuDVklptTI2T8KeRkM7Q9oiZfhAYEC7WDfEwblioPORa9D/9lNUSCMf3
rA3aSB7p6oUpMnwJc2ViisQi2pGJ7K9VkcXE1IrhwebERaxBUWmRWZtuYZn/Cpyi
OLxQig/b8qZBsTWfw2ULxHdSiOM2eG9G64et78THLT+gsOeSwjKCFnoWfmlm8/jQ
endGHeqWQ6yNNKdxpp9K/mjqr161yvjbJ5VWpteJ1E9dq4NlTu81
=MMI6
-----END PGP SIGNATURE-----

tag v31.14
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed May 29 17:11:24 2024 +0200

rdma-core-31.14:

Updates from version 31.13
 * Backport fixes:
   * libhns: Fix several context locks issue
   * librdmacm: Fix an overflow bug in qsort comparison function
   * librdmacm: Ack the pending event in sync UD connection
   * librdmacm: adjust ECE function name in man page
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmZXRZwQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZK2hCACWIFjExAgZIpGkmfpQdvlzMDeXgKES14JC
W/cI/kX7JcrZsVdiDSTla4fuJcMG3Iz6Ey6RAaEGShEYniM080O2pEHRx0fSzV4j
0NqnDkWprJla2G0VCR12tp8uUJ0NbNWC+0LZ5lysHpcOJmPkxIpCGywxdY+Goyzu
FT0E0fD5kVo97z1aZ1ys2no0Mks8ngUDMPuY0flYPaDg7hawQ+Zf61+8UT1ntBxk
r0KYbeosU1AbGvzowFgQRcKrVhcRq5XrKC14JpRFjcl1fW5uni2A71MjHmGrTOtV
nDpNu/6d7uKfFUK7uPMXPCBqzz78IDlg9dgYSyX+lreF9sF9Mn0U
=CfET
-----END PGP SIGNATURE-----

tag v32.13
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed May 29 17:11:24 2024 +0200

rdma-core-32.13:

Updates from version 32.12
 * Backport fixes:
   * libhns: Fix several context locks issue
   * librdmacm: Fix an overflow bug in qsort comparison function
   * librdmacm: Ack the pending event in sync UD connection
   * librdmacm: adjust ECE function name in man page
   * providers/qedr: Fix qelr_alloc_context error flow
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmZXRZwQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZFMvCADCS92RGw2IS8QI1zmj/lGYOD4mSVnQ4ehx
1WpKxtDxljH9Yv3o5xORR47x3FscPbd3ScN7JGFmQkxuTnf9zTvUquMlHSkicNed
zzp+kQ6iuwc/rOEKlPwkXsi/FRtSGE1ijOAzvCB1zJIOPno7330Z54zhdGsgq0E/
V6QNCcLaf4LKpF7VM620UnzdYVNd+L5tmj+zocJdleoZHToFjVqGX0nKpBOOiQuN
7qwNzMsxxWcBer20WB70zSw15GbLtZj7Y7kAWcX3owZ81VxuesgMvTUK3jKE3FzJ
7qCaZUeHlS1UKOhovp7oU9RK4x2XNGiO3XN1p6cL6LQwhknWCl7+
=uXWU
-----END PGP SIGNATURE-----

tag v33.13
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed May 29 17:11:24 2024 +0200

rdma-core-33.13:

Updates from version 33.12
 * Backport fixes:
   * libhns: Fix several context locks issue
   * librdmacm: Fix an overflow bug in qsort comparison function
   * librdmacm: Ack the pending event in sync UD connection
   * librdmacm: adjust ECE function name in man page
   * providers/qedr: Fix qelr_alloc_context error flow
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmZXRZwQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZK1WCACD+Zc2WG8ZqXPJN0aSG/P851c5kjwxsbGw
c72ontLbH4hpRb9NHKERnkos6fCq6xG0lX31NtWhPe6lH0Ugr9o2GXPjIRsktupt
w6pEtqjAG+PqBp/nxFNDb1qN9Cdgt8o1YZEG1H3Zobp96tQdTb70zSH+zfDtujba
cOq7KQ9ET9M4LsBs090Z3OiUogrwjLKa3Ma6x+8R3pdBXNz0fRvK+xd3kKpfaPLQ
LCDDK+9HMDQR67XBiZlwJvC3p+7bFbaj92Ni4ErwHITS+b1pI11baAKZSDylx6H6
FvU3F7dLXdPlHBCzFTOQMuDfmQ/XC8/UkXW2/KLR9glOkXltKDSV
=pk65
-----END PGP SIGNATURE-----

tag v34.12
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed May 29 17:11:25 2024 +0200

rdma-core-34.12:

Updates from version 34.11
 * Backport fixes:
   * libhns: Fix several context locks issue
   * librdmacm: Fix an overflow bug in qsort comparison function
   * librdmacm: Ack the pending event in sync UD connection
   * librdmacm: adjust ECE function name in man page
   * providers/qedr: Fix qelr_alloc_context error flow
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmZXRZ0QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZFVyB/sG7f5ROZSjCSv1RwiOwG/Zhsh+Arh01d60
IXDgfeY63b1YAiiORsLAkR87QjKJ+dRjA0y6kvhXgo/XzHYwN9365SGs21KzbaFR
pKj5Cf6hdTVFXqDnjpIHBQI3hrsSKwggnac2zxfvUzYSPl1N/Q5ypwUdX4ALmndD
ti5NjE8qdGHLotsU8y8Lh62aY8lygB1qx2JFMioVOYYm16pAPNNUdzpPhvvPzISz
CxLgIyutQAdWgrmkj63VZITKqUGH8n55UBuwL65wV0inVwmwLRjTtd4et1hTC1ru
ZEeFREQqGTHc6obFsm/ntGVTSMpNGtn1htxIBQYHvaFZ51/SY0jX
=7XZ/
-----END PGP SIGNATURE-----

tag v35.11
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed May 29 17:11:25 2024 +0200

rdma-core-35.11:

Updates from version 35.10
 * Backport fixes:
   * libhns: Fix several context locks issue
   * librdmacm: Fix an overflow bug in qsort comparison function
   * librdmacm: Ack the pending event in sync UD connection
   * mlx5: DR, Using sq ts format when RoCE is disabled
   * librdmacm: adjust ECE function name in man page
   * providers/qedr: Fix qelr_alloc_context error flow
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmZXRZ0QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZOX3B/0R9ah1RdAPwTNhHW+m9ASAJE5QHMqI9++Z
iBG8xPWnAmecO/IPgUZdXOsXo5nRlKJBKd8rknBfbwLfQIrWYeWK2WRwsaAC4enn
YE3L7wNhvGq6/RfWYL9PimH7MPfW0W/TbczbROzfQDLW9svwpgcqDCqdkKWM0CS7
0EwEk3oz4WyRFtWtjxEYUlzyWlWx63WIQbli9lGP/eW/TAxEoZ91O9JN7pnFCHl5
WxInPDsnbt0WbvXqLEV9YgG8VfdGu3TCscm1JaysGbeoPD5JDHt76llkwYfN7xq2
ugqEVUnySgvoMPRajFa0H4dfnKYSROe9h/Y18DwSDKDHcziCyabk
=Re7f
-----END PGP SIGNATURE-----

tag v36.11
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed May 29 17:11:25 2024 +0200

rdma-core-36.11:

Updates from version 36.10
 * Backport fixes:
   * libhns: Fix several context locks issue
   * librdmacm: Fix an overflow bug in qsort comparison function
   * librdmacm: Ack the pending event in sync UD connection
   * mlx5: DR, Using sq ts format when RoCE is disabled
   * librdmacm: adjust ECE function name in man page
   * providers/qedr: Fix qelr_alloc_context error flow
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmZXRZ0QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZL0DB/94tFSQYSIMBt5HtPGHacL4DywgB5ElBpbq
/+eJUK+Gf7l08vjZn9wrffLO40wDDIqk53MxwzI1BMrcJRLWtU5r6VZYlflMXuqQ
G0u/EIP6FBs5hhHxuaLwv2NpyRxadjfDU06r35MpMcCBgYn+2//Orq4OaRfSahF7
qVE6U7q/SyE1hb3HUw31BOGwmJYa9HOd6qeLjB+sFI3OxgD7E/fxLeiMs0ESUX+Y
Ac/Ue2t4Oj671WQ4gxtL30ChxNewhFb003O6dPkc7dZjrZ4/U4w31OK3AKz/YXHA
oCYLs/dq76ja9CN9aViCjzU11pknBzU4WctusE2/3C+QfCE4qyZ0
=xIVA
-----END PGP SIGNATURE-----

tag v37.10
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed May 29 17:11:25 2024 +0200

rdma-core-37.10:

Updates from version 37.9
 * Backport fixes:
   * libhns: Fix several context locks issue
   * librdmacm: Fix an overflow bug in qsort comparison function
   * librdmacm: Ack the pending event in sync UD connection
   * mlx5: DR, Using sq ts format when RoCE is disabled
   * librdmacm: adjust ECE function name in man page
   * providers/qedr: Fix qelr_alloc_context error flow
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmZXRZ0QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZPF2CADBFBjStzHMRxHbA1AqYbfH4IN8W8YY/fV0
J8Ab87HpHCcdznDJsOeqYTdreRZnYIUiDYQHe28D4SrzU5FpuJiuf7CDhP3LgqLY
tqdA1iwXMj4LpBhlWh5gKiz8CSntXTJqftFbgRqD4w/Luu+RYN6fBZHpgXkkqGzM
oncWa+kzFMy58mr167kJTru9OyuZLncp3ZTwY4OvaMICbA3mP8tZ+HpFopnZBTa+
xiBDfUEbzhP9FeELFZyoNMBoDgsm+uqtzpNalIexEY037UWnxax7GAr1SFpoc+Jy
/GXzU1clY7BTujLvMldpY28KvcRskRR78HicrGaK8UwpTuRPWq2m
=FxG7
-----END PGP SIGNATURE-----

tag v38.9
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed May 29 17:11:26 2024 +0200

rdma-core-38.9:

Updates from version 38.8
 * Backport fixes:
   * libhns: Fix several context locks issue
   * librdmacm: Fix an overflow bug in qsort comparison function
   * librdmacm: Ack the pending event in sync UD connection
   * mlx5: DR, Using sq ts format when RoCE is disabled
   * librdmacm: adjust ECE function name in man page
   * providers/qedr: Fix qelr_alloc_context error flow
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmZXRZ4QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZF1TB/47rx7kFIr0vLcCVZ7MMWOSbxwEeMUGoPBw
FiwApm7XyoIwRpx0viMlFLDbpBCXZpj2zVlejnjxijQfVEgwiLTFhk3gdId5llg1
voli34WkXCsNrvUnlMU68T8qWVyS8p1q/j5E2nG+0UnPkWh8uiWnZoYLCm9C3rDp
EPC4AdwKggqZ+CbVrfXn6B3EZzLr0/1yQ5NeqQ5GebupwO6L2AnzddgCQmUO0jb8
dhC6XLxtLP+jSvqO25sAZfPnasD4l+louJ1d39dnXW3o5aM89e38HaSZezS+eJpY
BFrT8auBgUAdgMHyVQqoEOQvsZsMUAhWfp3xOXLIMhaSCv1QRaOj
=eWQ5
-----END PGP SIGNATURE-----

tag v39.8
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed May 29 17:11:26 2024 +0200

rdma-core-39.8:

Updates from version 39.7
 * Backport fixes:
   * libhns: Fix several context locks issue
   * librdmacm: Fix an overflow bug in qsort comparison function
   * librdmacm: Ack the pending event in sync UD connection
   * mlx5: DR, Using sq ts format when RoCE is disabled
   * librdmacm: adjust ECE function name in man page
   * providers/qedr: Fix qelr_alloc_context error flow
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmZXRZ4QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZAAMB/4tPKbyapV8Gl9U/X7NkCJlwUPsl1xMmtqn
QZPw1kuNrJbHxhs3ISV3g0faGaiXhrFsM5OE5e0nMW7UKQLgE4TDXzXdEsNPfgaU
WByI1DQ7CRw9cg6Wz0KNoTuPaNkSwqBQvee/pwyRXaISHkt3HkI1fdspeIbU5/Bb
0zUjxEigJl8QmXeApf1byz94Om13ZTrVVUHxNTrTRnYYm2qH1SlWspR8IZf1qK/M
dn9ewi7WkHiB2eXS3LC/BrcioYMQ8V99v2rJFVjS3kr4G4U2Z+6xmU2FkXqsAq7+
LUHosrSpHlPKp9RgcjK47y/u9MsiDez+Dp22lfg5k/hqaeEuqtuY
=zdTi
-----END PGP SIGNATURE-----

tag v40.7
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed May 29 17:11:26 2024 +0200

rdma-core-40.7:

Updates from version 40.6
 * Backport fixes:
   * libhns: Fix several context locks issue
   * librdmacm: Fix an overflow bug in qsort comparison function
   * librdmacm: Ack the pending event in sync UD connection
   * libhns: Clean up signed-unsigned mix with relational issue
   * libhns: Fix owner bit when SQ wraps around in new IO
   * mlx5: DR, Using sq ts format when RoCE is disabled
   * librdmacm: adjust ECE function name in man page
   * providers/qedr: Fix qelr_alloc_context error flow
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmZXRZ4QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZKQWCACwxyaJ+q6PsLXqJ4GI3sv5Q8Ys5dGzQLee
2MTQsJdL24nVpNkrM3eoMcMYf18QpFlmnnFe/OeYVf/c9rA7vcWvDJhntUWX/0WO
td5sil2s5ZrKKP60X/zqv58EuM4bPEVjoFeB6urS1MyF4UVPXf2W1+zVAE3aTd3S
xHnLQpl98q5g42JhqiPlwhv2RwBu1ATkzFRzwcJPOnAPpNNp5liqoCAGKU7g94Cx
6ec2XlpABbQx7Vt631KDp/BmMIMPsFP3PKHi+5Xzl5uCNdGAKLH3AdUo1hDeauCY
u7tNY8nCjVi7BukNeSUCXJuzl9iU+QpDuB+bRcYfqq3U/GQV6fL5
=Afu5
-----END PGP SIGNATURE-----

tag v41.7
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed May 29 17:11:27 2024 +0200

rdma-core-41.7:

Updates from version 41.6
 * Backport fixes:
   * libhns: Fix several context locks issue
   * librdmacm: Fix an overflow bug in qsort comparison function
   * librdmacm: Ack the pending event in sync UD connection
   * libhns: Clean up signed-unsigned mix with relational issue
   * libhns: Fix owner bit when SQ wraps around in new IO
   * mlx5: DR, Using sq ts format when RoCE is disabled
   * librdmacm: adjust ECE function name in man page
   * providers/qedr: Fix qelr_alloc_context error flow
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmZXRZ8QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZGn6B/sGyS9SO3UeH8NyCJ9d9OqP/AUDyeyYDEUs
zie6+zp04ovC0J7vb36SBc/+uSDV7yDyEICJ9TbbeX3Ml8XI3yAjbE6v4tQoDL1l
Bx2IXYyv1RTROKJUAhU1KA7Vc7y1L9FPbolVEKIZ9+8pFx2aHtN3Cg44KrInV5y4
ljxoTOiNCoKzNTPiBRX7zYy5ob+WKxuo9xiqBjKqKgkUl7cqq6tyXBlH2fV0rZJO
UnoH2TxCGkQQfcGRCkNUbN+xSNYnnOiu4kX2jmBSXZkQPFCnWDDDoDBxqI2q/nht
GV1cfcMVI8rdbEg9Nx0c/dsTJc6bQA6S03C9ez3zYB/DhtbtE0PK
=hvfj
-----END PGP SIGNATURE-----

tag v42.7
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed May 29 17:11:27 2024 +0200

rdma-core-42.7:

Updates from version 42.6
 * Backport fixes:
   * libhns: Fix several context locks issue
   * librdmacm: Fix an overflow bug in qsort comparison function
   * librdmacm: Ack the pending event in sync UD connection
   * libhns: Clean up signed-unsigned mix with relational issue
   * libhns: Fix owner bit when SQ wraps around in new IO
   * mlx5: DR, Using sq ts format when RoCE is disabled
   * librdmacm: adjust ECE function name in man page
   * providers/qedr: Fix qelr_alloc_context error flow
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmZXRZ8QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZGcFB/9w6ExVZa/s3Wrbuy2+EcgGFbjqXxsjvnGl
j+LT0rGUgOUXZcIgFz+pbzlTYJ2JYlBcacSzwVvQVSchf3VuaZUVr2p1Bj2SijHn
szilh0xHm9meU4XBBalezxzohUs3EJ9qzdmjmLpaOKKYA4/DDlv9HwCsk16BTOK9
X3/qdkDvMhypqFHziP/22l40oxqC5yCmrvN4S5GGox57n7kYAR5VhVl0q8SZXFVJ
KwpffOswC9gM5BqyMJJs/uyb/I37KZOlBoD/A3oyq7+6VAWKbK5BfdN4GfejCJ6A
MgcS0DgmlGcHvVs+fs1R+MfyPYCqHtvxAFjEFR9fULkNPr1BKLHy
=EVuo
-----END PGP SIGNATURE-----

tag v43.6
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed May 29 17:11:27 2024 +0200

rdma-core-43.6:

Updates from version 43.5
 * Backport fixes:
   * libhns: Fix several context locks issue
   * librdmacm: Fix an overflow bug in qsort comparison function
   * librdmacm: Ack the pending event in sync UD connection
   * libhns: Clean up signed-unsigned mix with relational issue
   * libhns: Fix owner bit when SQ wraps around in new IO
   * mlx5: DR, Using sq ts format when RoCE is disabled
   * librdmacm: adjust ECE function name in man page
   * providers/qedr: Fix qelr_alloc_context error flow
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmZXRZ8QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZDLxB/9ly/jj2vhAh8cPtvAlREMmXMMzLZyWXBaH
AHLYA5aD2HMqg6cBhA7JfGK8i1+R+UxBttzaNaamn9V73b/fQpeVTQ9s7iYVHTjf
tN6fWEzGv+2J3RPZYmp1y+fIueGJYo5o5D4OyFnwFSN9Td6aGrlZrnZ1QliUayEN
CA7FUXE9dahfWECPsVV4h4MS+WktvJxFdgnBVLJkjUQqIxVYuctXBuuwBJJqQDwB
fpwf652p823TNjP35ResWoL3BvkEZDuQfFJxm/SA7lsgZchaWiOXsSy0Yd7Ip0/5
yYdkZGeEKqbxYUXeaOGZ2fKwl2M0scGZgtpnATtKGEWaHH1viZDW
=p4QM
-----END PGP SIGNATURE-----

tag v44.6
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed May 29 17:11:27 2024 +0200

rdma-core-44.6:

Updates from version 44.5
 * Backport fixes:
   * libhns: Fix several context locks issue
   * librdmacm: Fix an overflow bug in qsort comparison function
   * librdmacm: Ack the pending event in sync UD connection
   * libhns: Clean up signed-unsigned mix with relational issue
   * libhns: Fix owner bit when SQ wraps around in new IO
   * mlx5: DR, Using sq ts format when RoCE is disabled
   * librdmacm: adjust ECE function name in man page
   * providers/qedr: Fix qelr_alloc_context error flow
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmZXRZ8QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZGCSB/sHRR0pGtBMVM9mzD1WnmpquSMdpze8w+9+
3xkwS88F/HVViiw6Hg5o/0Z2aoO4fGg8VLbCmd/30HVZCS8IVlMfhERiMvGISbby
KTs/rygrIrCSMadbfqQB6wDishyUO2W1NgfrCVpj1gkzc0vF5IF6YpcJAG98+h4M
F+K/GiF3Zg6Zt03Y8w1t6MMbT8p3+4zisTnKA1J5Yr0QJp4sD9IAnm/JEn4mn404
RXEhphUyPjAhYmQGdLIdcEZbTjV113g5o/utogtO8iTO9Hl6dNtoFMRKbe8LZ5RA
ZRaHeqzqUwgy1FppjMtG93/T8IYMW+RkfaBgoW0DpYmkMCDPsjbO
=lTFT
-----END PGP SIGNATURE-----

tag v45.5
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed May 29 17:11:28 2024 +0200

rdma-core-45.5:

Updates from version 45.4
 * Backport fixes:
   * libhns: Fix several context locks issue
   * librdmacm: Fix an overflow bug in qsort comparison function
   * librdmacm: Ack the pending event in sync UD connection
   * libhns: Clean up signed-unsigned mix with relational issue
   * libhns: Fix owner bit when SQ wraps around in new IO
   * mlx5: DR, Using sq ts format when RoCE is disabled
   * librdmacm: adjust ECE function name in man page
   * providers/qedr: Fix qelr_alloc_context error flow
   * tests: Remove FW reformat check for SW tables
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmZXRaAQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZKrGCACiJCHuo7gas4LoJT5wbk/5mCiXqNX4Jf8J
BY39T6qjcq3gQbM4jwxOwcRocMm7gZAEX91O1Z8WjoDxOAbCKu3xYcslY8gsX+b9
6p4UuYe3bkCNJGnJwIlAkxaPs+kf1GiOsLvAAGcq4+NCHMCWSB6S/FFa9etqwkMm
DnRC9ZnmdyP5YUMYF5oe7Mf+8v3FhVGcqOC3mLUALmZB2eXGe/aPebGPUcnv/MgM
cyO5/gGjQYLXdTSIPnVEL4PCvP5MHo3TYBNg/tws5ILmgQnxYtEEx6uooslsIsdY
3IxRT0uFDYca4ubIGlUOEc3uu3P38UlUGgqFamV9OEiTHii7glds
=0iy5
-----END PGP SIGNATURE-----

tag v46.4
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed May 29 17:11:28 2024 +0200

rdma-core-46.4:

Updates from version 46.3
 * Backport fixes:
   * libhns: Fix several context locks issue
   * librdmacm: Fix an overflow bug in qsort comparison function
   * librdmacm: Ack the pending event in sync UD connection
   * libhns: Clean up signed-unsigned mix with relational issue
   * libhns: Fix owner bit when SQ wraps around in new IO
   * libhns: Remove unused return value
   * mlx5: DR, Using sq ts format when RoCE is disabled
   * librdmacm: adjust ECE function name in man page
   * providers/qedr: Fix qelr_alloc_context error flow
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmZXRaAQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZLSKCACg+CoeKB6IA1F0rA/b4kYDLsS4eSRz9XZz
a7jKgFluQ+qGOGsOQnJQ2cb1gkYUK+SghsukiHnN5GJXFQW4je8PuS53/wrUGs6z
3sPgHM7GIDEc3sAShxs2Nv/coGGtlEDMBLzz5E3x95ZmUy8LR40Z1j8LpAXF8cGd
t7lXGr47oO0P0wggKdPi9rjntxWKh2b6PTIeg5KfxreHgAl2lf+RAieLe9TmFpPW
KM2MYVRGfu+TkOL1Hh6HAjMyb9CBjskI5ib451//PK3U8EXffmFyZndvIZ2x8GPV
oGxR+JnwuBXONP1rlRUrYxggG5/VQ5mps2u2p3yhWK+UzTKrGHZv
=YHCh
-----END PGP SIGNATURE-----

tag v47.3
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed May 29 17:11:28 2024 +0200

rdma-core-47.3:

Updates from version 47.2
 * Backport fixes:
   * libhns: Fix several context locks issue
   * librdmacm: Fix an overflow bug in qsort comparison function
   * librdmacm: Ack the pending event in sync UD connection
   * libhns: Clean up signed-unsigned mix with relational issue
   * libhns: Fix owner bit when SQ wraps around in new IO
   * libhns: Remove unused return value
   * mlx5: DR, Using sq ts format when RoCE is disabled
   * librdmacm: adjust ECE function name in man page
   * providers/qedr: Fix qelr_alloc_context error flow
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmZXRaAQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZKyfB/0ccmImRbGkX2GjK+rx+KjZuUUx2cWhiWHh
PY/QaePMU2wfoxtGMBgtcNSq+AV+pG0UXP+0oj3FdhnmnCs/3o0M/NzSeGkYg5dp
EnCcFwJXeysHq+k2UfTAbro0hFY9KhE2UA2zfeJojFy7kiSzGVvQ2Zwvx08erIVq
FuHRsB6SDPT3XvEiCLmh90OxiarRa2LwzMNbVY4wvS7mmdIpQMoeBzzvA+wtEFv8
6J1JC5Yu0pWbjy+zNH2kJJa3PL7QwUyUX3YaF1fm9cegfWEJLsV3ilxYpLysOwqX
Ld3kYvaroiv6QzeyqCUjQz08fDtuohbg/g54CLNBCo88OFhX68MN
=uGLE
-----END PGP SIGNATURE-----

tag v48.2
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed May 29 17:11:29 2024 +0200

rdma-core-48.2:

Updates from version 48.1
 * Backport fixes:
   * libhns: Fix several context locks issue
   * librdmacm: Fix an overflow bug in qsort comparison function
   * librdmacm: Ack the pending event in sync UD connection
   * libhns: Clean up signed-unsigned mix with relational issue
   * libhns: Fix owner bit when SQ wraps around in new IO
   * libhns: Remove unused return value
   * mlx5: DR, Using sq ts format when RoCE is disabled
   * librdmacm: adjust ECE function name in man page
   * providers/qedr: Fix qelr_alloc_context error flow
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmZXRaEQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZJVOB/9sn2oOc/5TOr+0tp328pnaAqFZudYPsEQl
RUu0yF6OU7mx2W2YL7Kpk98ZKpZcz6nFDxfi+udKdVmUiBQQmFNha0XHmBws6dEZ
Q+iikVJdIYzInjNISS+rX95pFt4sbsbiPXWthWdFgLBNxyF3vC58hoo5f0wGZvTx
Z0+EASnGW/7wqChYuWpIh7XMqNv9+c26zjzcKib7FjBu5kY1u7DLOAWH9AXCwzke
nB8jHrr4morlfCLftJuKEu5wPCogpKjD0SA5fbGjhjXbHHTGITomSg+N3AZi+Oi5
aquEjCzLgVxf5oAfMYqkBbXoiDGnvjJaFUuulYyWexkeC442pITu
=KznE
-----END PGP SIGNATURE-----

tag v49.2
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed May 29 17:11:29 2024 +0200

rdma-core-49.2:

Updates from version 49.1
 * Backport fixes:
   * libhns: Fix several context locks issue
   * librdmacm: Fix an overflow bug in qsort comparison function
   * librdmacm: Ack the pending event in sync UD connection
   * libhns: Clean up signed-unsigned mix with relational issue
   * libhns: Fix owner bit when SQ wraps around in new IO
   * libhns: Remove unused return value
   * mlx5: DR, Using sq ts format when RoCE is disabled
   * librdmacm: adjust ECE function name in man page
   * providers/qedr: Fix qelr_alloc_context error flow
   * debian: fix minimum version for new libibnetdisc symbols
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmZXRaEQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZCgJCACCIZyX/wQdr5TnLnXsM/87jbFZiQBWtFiT
ejkarKB/PqzAgGD1g3u7qneC7ogpd/r/4d+6BHLMAd2ALs/+ZrYKX8TCjPLA8pPR
UNXFBtK6FbLSkJQM4+wo6PjG/DzSy/qqTwVGumNuoGxeybEw8Ic2SxLzvlwBMp+2
sv6xcobm7I7KGpUzCkmTW/gdnmsOSayURLeCXyIfshgDtzXCWedYJFMy5blAK842
W9I2KG/KaTjQO8B+AHsqtqUpr94og3Vs1Dm+Ui68t5ws1DhPzlc5e+oXsaMEszkt
Z+YO/WtJaRht8yZkHzBcH0AeUqaFl8UwYQ/hO3+x9okBAe5oOYjL
=A/98
-----END PGP SIGNATURE-----

tag v50.1
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed May 29 17:11:29 2024 +0200

rdma-core-50.1:

Updates from version 50.0
 * Backport fixes:
   * bnxt_re/lib: Fix the stride calculation for MSN/PSN area
   * libhns: Fix several context locks issue
   * librdmacm: Fix an overflow bug in qsort comparison function
   * librdmacm: Ack the pending event in sync UD connection
   * libhns: Clean up signed-unsigned mix with relational issue
   * libhns: Fix owner bit when SQ wraps around in new IO
   * libhns: Remove unused return value
   * mlx5: DR, Using sq ts format when RoCE is disabled
   * librdmacm: adjust ECE function name in man page
   * providers/qedr: Fix qelr_alloc_context error flow
   * debian: fix minimum version for new libibnetdisc symbols
   * bnxt_re/lib: Fix the toggle bit changes in resize cq path
   * buildlib: fix azure regexp to trigger builds for v5*
   * stable branch creation
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmZXRaEQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZPt2B/9TQCe9kdK2zSd4WrRl8QIol8XvwoJ+HLu/
4aghZ9VqfMsDDXEodeQcH45WjYqSLeEBsBT/bhYhwcFgHqNysVuAMCJ+T8o9IqXc
S5LRsxCwcVlHvnyWlNYBodHycesKsnWg3V9QVCGJKfNX7fNoEMZENRrMOt18g8tv
g65pUR03XJOBUqr37BS7qkf+iSHUdMJcL63JrPqJai6nbxlbX2Cr1sc6xwqn7CrU
shWqIm6N+0DOBPCLg6deXydcujpj7I/y35ltlRRJ8iA664o5aP4g20HIgXshi81b
YWBdYxxX7c6FQMlL0p1VB1HmeXQAPgwa2ovIsTv41QtWqQJ97e5f
=ec3F
-----END PGP SIGNATURE-----

tag v51.1
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed May 29 17:11:29 2024 +0200

rdma-core-51.1:

Updates from version 51.0
 * Backport fixes:
   * librdmacm: Fix an overflow bug in qsort comparison function
   * librdmacm: Ack the pending event in sync UD connection
   * bnxt_re/lib: Fix the stride calculation for MSN/PSN area
   * libhns: Clean up signed-unsigned mix with relational issue
   * libhns: Fix owner bit when SQ wraps around in new IO
   * libhns: Fix several context locks issue
   * libhns: Remove unused return value
   * stable branch creation
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmZXRaEQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZLH8CACUzwUMCbtSNYaioTn5/VUJS1qkkAF5qOPW
81oWNxtISVYJpMa+ccgz4fWtFc3R1M0UdxrtqieXXvrFFPsvwYrQJVmiuYLcCRWW
5qlplQlClIOSciWEVPoQ3zr/Sa6NAPz9rRmwZISgW0YYAW6FT5vm2pKkOYAQ3gNn
+wyWLHdnIiwWWSSIRnihcItqagBDjCeOrOgX66KsyG/rD0J0gX3GF5Fikl59Su2p
7XPeWEydy8NJdX+iuz+fswcZuxE3olgcIrClDzpF9Ehd3F1CR9P6YrHmRvePEux2
fuPC8vsIzfqYHN1QNQ6mGsPAVUoo3N0GwDB09i22uQKzwZgNau7f
=FQfV
-----END PGP SIGNATURE-----


