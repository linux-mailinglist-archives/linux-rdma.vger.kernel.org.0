Return-Path: <linux-rdma+bounces-15336-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB403CFCC4F
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 10:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0E343001FCE
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 09:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CCA2F745E;
	Wed,  7 Jan 2026 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CS0DHb3y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF29221FBD
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767777248; cv=none; b=DO/zLaqQ1qwDbDqIn279ImsccT7Yhc6fP2dt5tVWnlZvif27+uf1a3NqK2JIhPR7xJ5f+C6UQvQjWu9DNFJWcTBiIzUslvD7Xd5J/9eVkUxgdRKvvBpe/C2+jh3AaPfe4OB3hzRXlxnoKYMwZlOXQQjG7cb1ljNhZakGUmxrEG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767777248; c=relaxed/simple;
	bh=pxpYpALWunPTSSL3NCjN/qngxeYYCEQZ3C69lUEuSyc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=Dj45zW8nvIOAv5mEX0oTihg7FVuGyZTX+TrPP4av5qnPsUEObdPSHpMBLrQQAI++3OP+BxX+HeDwNqO7blNRMkl7CWaOuw8swogTZNRur9uQZgUXhb7thNnb0wtTMJ5D3G6UWOW/B61TBAwcMEv4Vd66KrZvCHZxm+ao41ZMYrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CS0DHb3y; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47798089d30so1466095e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 07 Jan 2026 01:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767777242; x=1768382042; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LRwusM16Uca031NvEfi2nmQIDHZfReVydry1kybT/+E=;
        b=CS0DHb3yIEaRRZQORTDA5zFiPQTcK9sqgIAp96KP9j5LDhr5ohXdO1pK9N1ZpUu8Vi
         txgQg1Cd+U0eTkKFqAgrXd+a8HKMbnjeRY7rqE+bCtadaFN1CRkCG015HIns81/3Neqf
         RlgRQ3K6B5o6EwvvnsjgtlY5kwXaSc9zHbuaRMmZTzwONrG8WNHjpd8M63kZ3Uq+cD3u
         exlk4d2BSgNYzRgIKvCnowMTCIZH5dKlXqyF+kVNEJxFWqo5DLMY1AdhKYi2MPbpTTyr
         CUH4yQZM2+o+AjBU3L63KujT8gVd6DoVQLbfwiUrogflLHEzAulVbi73LMloNH+aS6cO
         TEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767777242; x=1768382042;
        h=content-transfer-encoding:autocrypt:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LRwusM16Uca031NvEfi2nmQIDHZfReVydry1kybT/+E=;
        b=kVhGUg7Q3c58ctcxUhd/whmumgV+XlRkpxAxqv7JbV5Mmft1lESsKCPFelEs2cHaX6
         Qtls4RXwT8Qlhl4eBhfN/D7M7S4lIK3owEoLs5vqQ8+5b96l5/9AOIIdjlmz+6Eh1Lkw
         TbyQZVL75rn3oGz9ygm2suevFJYcn4DYpX0vixgygO7dJZ+8BQulyGJIC2xgqEyGTaYz
         L3iuWnbtLkkQxbZg+mUd4olCKjcURsL8nRhBnMw/O4xGz0PMnlMMviiEBI+AuzqarcQi
         3WCUin1pm9KqrLiAAQ2TKi4TsgAq8kk8tR0vdq+oW5aXwTfoljshyM0xOan2xZsWGuOr
         keZQ==
X-Gm-Message-State: AOJu0YyPWpfLHiip+idVsTWzp785p7nRdu6fCMum3qDAz3G4UyeoTAZD
	GdPNpdNp/NhPUzQBw/rSFClLssyIFIM+Qu6/pwOpEX/S/i0sTLiZZtTu7eXUBJ12fFj+nuPfz8S
	hAT4r
X-Gm-Gg: AY/fxX7+HvgYvKICvy9HfD9OXUO5+OyBM1pEC97dgdNZJfydNDxmacIfR3866EqRch1
	V6a8uoCZ47Y90lDzEo6hc60LQtISl55EG7RoLAP9ZDPWhHPiaWaBsOoy58yy0estREyeftAwNVp
	ZMfQA5fUseoEYYnvrmTMrDOBihPha4AjHTnRCowFkobmUTu2LwP85W0sLZy+6JxzhohyTmTfmZT
	roMLiemHVA84iKvnWMZ6Kn5Q9tihPjvqmcK+ir+bqcTLnjG2rVh3f+zzAw2EG/HWNNN78tdrS5J
	frb5JLzmzNB8xxcMmU4M9r/8p/lOM/VYkeUW1JGMBLROzUyWiNJp53h7t97wPOJ8vtepnJ6gZ1I
	XuoqzzmN82eVsSfgbfztzSghdO5s9DdliUoAPc8xQ0onN/wE81U1UckPlUxrNXVexGAXTwmcYYn
	M/eRe2ulxLREuVq95FP8uTj7/QGU17Be1fz3r0P6pjfrcfA6jsFEE=
X-Google-Smtp-Source: AGHT+IGaKrfyAfhw7DTHg/P1IK/CNQdnefS5wj5gwjadvqq+AZnI8p41FMfbHlVAUCyCHOdEvNLkRQ==
X-Received: by 2002:a05:600c:4e86:b0:47d:6f12:de57 with SMTP id 5b1f17b1804b1-47d84b33963mr9596825e9.4.1767777242223;
        Wed, 07 Jan 2026 01:14:02 -0800 (PST)
Received: from [10.0.2.128] (lfbn-ann-1-288-66.w86-200.abo.wanadoo.fr. [86.200.241.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f68f686sm86724465e9.3.2026.01.07.01.14.01
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 01:14:01 -0800 (PST)
Message-ID: <4a0dfc2e-0fa7-4ad7-97ad-a4e6de010ce6@suse.com>
Date: Wed, 7 Jan 2026 10:14:01 +0100
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
Content-Language: fr
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
 * v36.16 (last stable release for this branch)
 * v37.15 (last stable release for this branch)
 * v38.14 (last stable release for this branch)
 * v39.13 (last stable release for this branch)
 * v40.12
 * v41.12
 * v42.12
 * v43.11
 * v44.11
 * v45.10
 * v46.9
 * v47.8
 * v48.7
 * v49.7
 * v50.6
 * v51.6
 * v52.5
 * v53.5
 * v54.4
 * v55.3
 * v56.3
 * v57.2
 * v58.1
 * v59.1
 * v60.1
 * stable-v61 branch has been created

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v36.16
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed Jan 7 10:05:58 2026 +0100

rdma-core-36.16:

Updates from version 36.15
 * Backport fixes:
   * bnxt_re/lib: Fix the inline size check
   * rping: terminate CM event thread before exiting
   * pyverbs: Fix Ipv6Spec class
   * rxe: Fix double unlock in cq_ex polling
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmleIfYbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2QT
FAf8DOmG208Awo8zSIe8RsWyefZNbTB0R/2XSGX1KML9uDqS8hvBRmktGmh37Rnw
b8beZJO06A0K51LBHedMQAAMBE0EHf6zsLeVFw+1y0FkVnTm+/tf1D+2nY3RkUHb
w4n2GfSN4rcZgay2XeeFyvX/yGyvP5pnS76et5tBg3eR1+x3q4i4eecAfu7sx4gG
dDtgmZfzxUs6B9aNwaDP39FIeZQqfUlZ8qJDvyXzp0/s5bdEQGYtaV9TS4Fgw65s
1dpwDV7S5ub3H4ifqZ52wSlXUiAuRMIBJNT+33JVOeLDbZ7oZBWdeBpkUyKYh6WQ
8s4G5mtkF9LaKAl53fh+yOohug==
=bXTf
-----END PGP SIGNATURE-----


tag v37.15
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:15 2026 +0100

rdma-core-37.15:

Updates from version 37.14
 * Backport fixes:
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * bnxt_re/lib: Fix the inline size check
   * rping: terminate CM event thread before exiting
   * pyverbs: Fix Ipv6Spec class
   * rxe: Fix double unlock in cq_ex polling
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPq8bFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2T3
BQf+L6wXN9tdByJLNqe3C0tIBtR3NuqNlFbdwxOgQO5iyKeNgChO9NPgOl17TRN7
n5l8Bx1BvvSuh5NrbMODXnmOYh0AT9c2mcmUKZweRJ3li03FIV+ARtNbKvSmWol6
bMnhLD4f1C9CkQGnhMQFSx1V2JpKHuPkFIRla7LtevoZk/kfdGEArW6hdLEzv1HJ
HD1qiw8ZBbJJe/Cx0/9MBLosUumJ006nJZhbUfDD0mNJbDZUsK7PRzr+EDSAzTaC
h+8LaMNlr/BUhofozVBVcXw9DDjCp3II2aIgxms5s/rBzrQZ0YeffnZsDUI4/6wn
pTBZqDzFqd5aZqTJH1liyqeD3w==
=3DzB
-----END PGP SIGNATURE-----

tag v38.14
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:15 2026 +0100

rdma-core-38.14:

Updates from version 38.13
 * Backport fixes:
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * bnxt_re/lib: Fix the inline size check
   * rping: terminate CM event thread before exiting
   * pyverbs: Fix Ipv6Spec class
   * rxe: Fix double unlock in cq_ex polling
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPq8bFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2TF
lAf+MgrBB40T1iw0CQ7MemshrCPWs0e9+JxrVLFGs6wS6EE0NnWWV8XDVTBh7Kf2
pobyraEo7ClsC1xGwIeN6as5tWJZ4nAm1bAG9MBCupOuTCdIfLq218nhMiG3Ig8s
ZlRiDQP7wnDZvL5rz9xSkmx9kF40SDYVCoA+W5lGpeH7rWNha6ran9OScJ/G0kxO
67GRDenZX9n5X20f5Ushu/4RLgXZ9TjhGyr2ENnuxspX394tvmGF0Kw0/9CKsJ+b
FU+5O/b2efU9eXNdMsI9snQr8PTsxVmMUEUGYsMaYrc80wrCbFt4loKsk57fr3r2
sGKl4rYUBWq9faq7XsMtyeByyw==
=ILpm
-----END PGP SIGNATURE-----

tag v39.13
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:15 2026 +0100

rdma-core-39.13:

Updates from version 39.12
 * Backport fixes:
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * bnxt_re/lib: Fix the inline size check
   * libhns: Fix wrong WQE data when QP wraps around
   * rping: terminate CM event thread before exiting
   * pyverbs: Fix Ipv6Spec class
   * rxe: Fix double unlock in cq_ex polling
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPq8bFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2R7
qgf+MtaofHTIp3yLKKtJuFbdMrkiTaf1b9z4d/Zyx/Z5HdZiAH4F2pFb56pE1s+G
VViI0pfhXKxITKI8BwPTFB1JpsBavgTQ6FcXND8BT1YAYwGrwkBB7sT7VKup6REb
F+0d0ijKH73vLkYlwg6tB80vJXaycajeAelERE7UtBb8NYa3NNumc4T2Kc0CFdSG
eL1bF6B/OxeE2Ex7K5pQ00zinoNIdGrDyWA2qLHsB0A/stuhYkRgTg4DbSGvKTYG
APVjWDOuX4V+Mo/ZuhT+4NjblnWetW0/k5RuLRSlCZHMN2XctfOX+qtmKg6JcmjF
sCI1+mZOG5uDF8bCQbNFiKxlRQ==
=NLkl
-----END PGP SIGNATURE-----

tag v40.12
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:15 2026 +0100

rdma-core-40.12:

Updates from version 40.11
 * Backport fixes:
   * libhns: Fix CQ clean when CQ record doorbell enabled
   * libhns: Fix wrong WQE data in new post send API when QP wraps around
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * bnxt_re/lib: Fix the inline size check
   * libhns: Clean up an extra blank line
   * libhns: Fix wrong WQE data when QP wraps around
   * rping: terminate CM event thread before exiting
   * pyverbs: Fix Ipv6Spec class
   * rxe: Fix double unlock in cq_ex polling
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPq8bFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2Qp
XwgApANubDEilszN4OQl7GBr8p6Vo7+oY/GxUUDKxPsHVRTOKo3d/komL0o4xgLj
zAI1heqZtcwh3EyaLpCVczcHrBKWlSq6mfir3EgIya5HKxRQEs8hnoY2BZIcgBPk
ud8RwYRrCHzGJ+j/HDgYQ3gWNriw3xc5rE57f5NTN5u3tdv/V7KLM3l2z21rN/9x
96ZrTFK61wPqdi+LMmsgXQaxVIaV1rvJ6lfXo9mBzIumr/qv8Ga6DVJ0HV+iL5LT
y0QbKUxhjlnLoyhiv9UCXLIhJbXKb4dXwZpPB9KGz6hpzybOH5YKmikwlDbW2noS
97Ygk/3rHUpfoJ12eWnMKRRaSw==
=1AMd
-----END PGP SIGNATURE-----

tag v41.12
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:15 2026 +0100

rdma-core-41.12:

Updates from version 41.11
 * Backport fixes:
   * libhns: Fix CQ clean when CQ record doorbell enabled
   * libhns: Fix wrong WQE data in new post send API when QP wraps around
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * bnxt_re/lib: Fix the inline size check
   * libhns: Clean up an extra blank line
   * libhns: Fix wrong WQE data when QP wraps around
   * rping: terminate CM event thread before exiting
   * pyverbs: Fix Ipv6Spec class
   * rxe: Fix double unlock in cq_ex polling
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPq8bFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2Td
zQf/bNorXeCkC/XWsa70Auj21zPw+sGKx6l2aJN9o8eFOG4ed0t1netYi3qAGRx/
XKycD5y/Yi7JttCjJo0nq2wb5xzaBGHPvvv4rWs/S40/T/a51mYTR3KVFEZNxWkQ
siumq+l5xdvltFAB1gAvLOvJjFyd06ViPVfBjbdN+SmDWNJANEg7pxSK8BagUfER
N6WnORXYR0YuT8XM1d7S8FdZKRx9LWfca9Z8yLrzDMHQdia5/YNVjxu27tvAZ3I4
7HJvuEl+J6atbmpTSAcpR68lsDzYRmqEZ45noH7EAhMi4Z8HiaNGH0nph+tlk66L
vI9FB0GAu/evUVdlNwWNhdQkyA==
=GWQ/
-----END PGP SIGNATURE-----

tag v42.12
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:15 2026 +0100

rdma-core-42.12:

Updates from version 42.11
 * Backport fixes:
   * libhns: Fix CQ clean when CQ record doorbell enabled
   * libhns: Fix wrong WQE data in new post send API when QP wraps around
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * bnxt_re/lib: Fix the inline size check
   * libhns: Clean up an extra blank line
   * libhns: Fix wrong WQE data when QP wraps around
   * rping: terminate CM event thread before exiting
   * pyverbs: Fix Ipv6Spec class
   * rxe: Fix double unlock in cq_ex polling
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPrAbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2Qj
Ugf/fBre+Kr7HMHZO7QkHypyFsVOGVsVntxA3TtzrBGDqENcbDQv07j2myFULVKZ
ArwO3ciMvPxTtFJvGwIwzhYYp1xWzd6V5o/90TAH1T8Q6PImjrbxiIMPFZI/C/dZ
kN0XwP0C2JHmFBEKHm3Jpc7VPaOmeKauVGTFUJ7QwSWeEKmgz7e7eTM8JXYOVaY8
KPIxoSZGnv/damdbQnDmHByMNozTunQeF6ijXnu8bULXO3cyflmfFY6qT/u1hS2V
frm4eKEuZI9PbzVnztzvy3VEoukga/BJ5f7dXQIMSP492wUR6N7IXmkfxq0YyEpz
MSD+IpaaFQqQiL1vRskAhdDaTw==
=jzLr
-----END PGP SIGNATURE-----

tag v43.11
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:16 2026 +0100

rdma-core-43.11:

Updates from version 43.10
 * Backport fixes:
   * libhns: Fix CQ clean when CQ record doorbell enabled
   * libhns: Fix wrong WQE data in new post send API when QP wraps around
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * bnxt_re/lib: Fix the inline size check
   * providers/efa: Fix the size check in efadv_create_cq
   * libhns: Clean up an extra blank line
   * libhns: Fix wrong WQE data when QP wraps around
   * rping: terminate CM event thread before exiting
   * pyverbs: Fix Ipv6Spec class
   * rxe: Fix double unlock in cq_ex polling
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPrAbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2Q1
fwf/T+EjK5nnPoY8xWMI6q6OpTWdeOHFkkYOi4Mn95m6JJzZtKVNHHe28zGubdCg
XsTvAxAdQUKN9WYjVY+GXapS1b5NIIbOAF/p6h83m2zgfVbGuTUa/iYqkebmYra2
V5UvfchpfvBEq0/7ObIA0X5K+vVRYlzn5ulsDnidUsDaQ+VbcxT+x3EYgwLc2wQZ
uDfJMu0yk3Xqj2IWR0QR9wLSr6vz8PqoJWTzIjnmPUfnz6mG7nDouroCkiCwuOrj
2V/F9Ko3XwuwgPtCvVqgjLe4QmSUINiBFvqoOy1JWIN0P0dpUCn4AtbI2jSecbbC
RxHDekmzZALMGDuKMqb7v6zzew==
=Qljs
-----END PGP SIGNATURE-----

tag v44.11
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:16 2026 +0100

rdma-core-44.11:

Updates from version 44.10
 * Backport fixes:
   * libhns: Fix CQ clean when CQ record doorbell enabled
   * libhns: Fix wrong WQE data in new post send API when QP wraps around
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * bnxt_re/lib: Fix the inline size check
   * providers/efa: Fix the size check in efadv_create_cq
   * libhns: Clean up an extra blank line
   * libhns: Fix wrong WQE data when QP wraps around
   * rping: terminate CM event thread before exiting
   * pyverbs: Fix Ipv6Spec class
   * rxe: Fix double unlock in cq_ex polling
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPrAbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2Qh
vgf5AVJ4jIxyCBkZUmb8Fcg+iI0Lkmnkhr1xCh3fr6+QU+rUINkCL/UQXlmN9dkv
0vjo7rRpngluJzsLRejhn0tAKy0fwx6fSQ2gny7yXbVyW11ob9E+VChj6iKvQFSs
R8kZwqq1+oAP1bxH/cgCegEY6H/2Vfamd0DSdgsvJNz8XbB5Uz+kDJqN/iH2DzTI
DHITzriLLRPA7S97LRt78QBidLp6l72sQ4r5uCxZ0e15dBzKy8jSLlBf+5fqZ4ps
WN8adyrgn0kuPlL+ereUEZAFmBLXetTiKJD+RJpn2UgTKtXzk0BZ0GICCXW+09ix
cMbPh2VBXsgukoFFAZO+/sumyg==
=IIgH
-----END PGP SIGNATURE-----

tag v45.10
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:16 2026 +0100

rdma-core-45.10:

Updates from version 45.9
 * Backport fixes:
   * libhns: Fix CQ clean when CQ record doorbell enabled
   * libhns: Fix wrong WQE data in new post send API when QP wraps around
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * bnxt_re/lib: Fix the inline size check
   * providers/efa: Fix the size check in efadv_create_cq
   * libhns: Clean up an extra blank line
   * libhns: Fix wrong WQE data when QP wraps around
   * rping: terminate CM event thread before exiting
   * pyverbs: Fix Ipv6Spec class
   * rxe: Fix double unlock in cq_ex polling
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPrAbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2RS
uwf8CDgv4VZunPF0fAMk5KFIO6H38Ld17YMn3UP/djesl9Q2W+Qm9Ir2RlSDGc2D
zBr3TqTV1bG/091XgqPyDH0yrO1LOnMI+479Dvz5u5qTK6b+zSTmyvUYOwqj1wun
mVt1BGsjQb7B4Zsj7AQPJY0RYEIeaGTz3x7/TSY8VjlCwajIKtfnAvYNYnj6rmXN
RnxVLHvaxR2oKmiekR9rfk83yzvcNFxZZfoagQR3Y8DlpKY/oOhFSh5TaaIHek3G
MdtfKZvoaIz/5qLDbicn1EI+n7KhZ4kSvlRDCPsesVBJT+hTpyJFoH2vmFrf2bNH
h6avxFCzJ38/FzBAs2L9SGWF0g==
=B/SU
-----END PGP SIGNATURE-----

tag v46.9
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:16 2026 +0100

rdma-core-46.9:

Updates from version 46.8
 * Backport fixes:
   * libhns: Fix CQ clean when CQ record doorbell enabled
   * libhns: Fix wrong WQE data in new post send API when QP wraps around
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * bnxt_re/lib: Fix the inline size check
   * providers/efa: Fix the size check in efadv_create_cq
   * libhns: Clean up an extra blank line
   * libhns: Fix wrong WQE data when QP wraps around
   * rping: terminate CM event thread before exiting
   * pyverbs: Fix Ipv6Spec class
   * rxe: Fix double unlock in cq_ex polling
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPrAbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2R4
+wgAsLUdegqtGRT0EAyn6wFlHriRatKfhqyv7U6V5n3pFIv2oL73Wl1U5ykHKpXk
I7C3OsAQvQpL/S97KC/V6RK1Ip48HySVsOFzgD3VXeymJNycSQi7B9MEm1PHrFv3
zW6MQ95HlmxmMkJQHNN8H3JTnipYXHP09KeXIhqUdBVt0V8Blq10u6a+4EzdwxCz
G8WpUraGKY8X6/xv7koLjJf6Uanzygm8CtHSu5Gq+D8kiazrOHXhx0T4MmXHozoF
SU9t7StucPlFqOFjqin1emVcAkJBws+oWKJvYH2IyIV7dvZCOBBUetSusE7ig8QN
pqVUOLUTw8vOS45AUhz+287EHg==
=n3xw
-----END PGP SIGNATURE-----

tag v47.8
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:16 2026 +0100

rdma-core-47.8:

Updates from version 47.7
 * Backport fixes:
   * libhns: Fix CQ clean when CQ record doorbell enabled
   * libhns: Fix wrong WQE data in new post send API when QP wraps around
   * bnxt_re: fix assertion in bnxt_re_alloc_page
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * providers/efa: Fix the size check in efadv_create_cq
   * libhns: Clean up an extra blank line
   * libhns: Fix wrong WQE data when QP wraps around
   * rping: terminate CM event thread before exiting
   * pyverbs: Fix Ipv6Spec class
   * rxe: Fix double unlock in cq_ex polling
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPrAbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2S1
jggAn91Ij/BtkwxLaG16apkL5MmAIE6lGceD/8AHFynJF3G+f5uD1fyAHxHEOlTQ
CdgGk4JNoI61w023BBJP7c+vpkmreCrhRN78ovxNu02rIFtQER5zlvAHwCA56+G3
8TjJRe1JUh8Sp77OBsfdMFr3D7eGl6VMFBc+j9dWhtgrpym7Ha6F0cTihPINS1b+
5hPMHO5VLiTZN+V6AreEgtT8YJm8VOCH8saaC6A/FQHManTu0LO0YoEws3FkreEm
TZbvkKSlm7dq49Idj4fXZnga1I7ZTdCbquakZ067kUs6DNqu684qBdlFre48zNpo
cNHlWqmpu29hwLgPDO0aHfzL2Q==
=u2ov
-----END PGP SIGNATURE-----

tag v48.7
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:16 2026 +0100

rdma-core-48.7:

Updates from version 48.6
 * Backport fixes:
   * libhns: Fix CQ clean when CQ record doorbell enabled
   * libhns: Fix wrong WQE data in new post send API when QP wraps around
   * bnxt_re: fix assertion in bnxt_re_alloc_page
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * providers/efa: Fix the size check in efadv_create_cq
   * libhns: Clean up an extra blank line
   * libhns: Fix wrong WQE data when QP wraps around
   * rping: terminate CM event thread before exiting
   * pyverbs: Fix Ipv6Spec class
   * rxe: Fix double unlock in cq_ex polling
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPrAbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2RV
CggAvhZnEkpFXeVZ3oPArrdD0qUW1eDE4xZPn2rgb8p8P3dHv++Kg8ytnwV0A2QH
/d7FLkTRZorshPneD1cmf/Qy2kFxXyMxFA75X66COBiZGnt+Y0PTjFI0o/spE+6a
D0fGR9N/g4WUsku+g2EIrwbL4uVdGmUhMfklY5vFC0hil4uUK5HBJuxYYXpcgOlp
rgL2R/QnZrzqiIoaOiUCK2s0jv/z4UVzlsJq8VyWTtEG+UNLbxxvfWnzI+xJFZuq
A+wzbkFJ1e7VfYXXt9IseHm9r7TTnmfOGblJ61M7MMCxyowN26pFyEknJxbi+Jcl
NwJ7c53bW/S9Ku6pQ7p5XR6rcA==
=vVb4
-----END PGP SIGNATURE-----

tag v49.7
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:16 2026 +0100

rdma-core-49.7:

Updates from version 49.6
 * Backport fixes:
   * libhns: Fix CQ clean when CQ record doorbell enabled
   * libhns: Fix wrong WQE data in new post send API when QP wraps around
   * bnxt_re: fix assertion in bnxt_re_alloc_page
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * providers/efa: Fix the size check in efadv_create_cq
   * libhns: Clean up an extra blank line
   * libhns: Fix wrong WQE data when QP wraps around
   * rping: terminate CM event thread before exiting
   * pyverbs: Fix Ipv6Spec class
   * rxe: Fix double unlock in cq_ex polling
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPrAbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2Th
IQf+Jrmjusd7v+TXwCCX89Ys7ou+h/U7lofH8r9Pi7I5JBLVW2I3d8nhBlsGfxHh
eKNqWC8pz1RpuIIJRtx5gnNrulaUBU+yPojInHjM4nk3RHFNm392xOoOXat/1S1g
BAHscFnEwsM/VX8SyMiMFZZcp9WZFKt1wAeEH44IsNgHalhuClzAfjomG9HwEh1m
hbRxCuoH3NpZOzYQwC5LuCMCuZhzN9eO974vQHiHNLtKxNEfo4XkWCBpPVnf89Gb
wSL7CFo1wPS9CzdV2/9F5hW0FlsPYvtnPHcN47aPS9Z07b9C8trp9Q4eBdCnD003
UWAMKUuBmx+pHSmj8BZXAtQaOg==
=13CV
-----END PGP SIGNATURE-----

tag v50.6
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:16 2026 +0100

rdma-core-50.6:

Updates from version 50.5
 * Backport fixes:
   * libhns: Fix CQ clean when CQ record doorbell enabled
   * libhns: Fix wrong WQE data in new post send API when QP wraps around
   * bnxt_re: fix assertion in bnxt_re_alloc_page
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * providers/efa: Fix the size check in efadv_create_cq
   * libhns: Clean up an extra blank line
   * libhns: Fix wrong WQE data when QP wraps around
   * rping: terminate CM event thread before exiting
   * pyverbs: Fix Ipv6Spec class
   * rxe: Fix double unlock in cq_ex polling
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPrAbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2RV
rAf+PwD+SyGXRS9ltIvU7VR/r/1msm592vQZ2T5lPSv4t2N2YVib4CWlVbUt/ffk
RE172p24FQmLem82Db2azzIN6rydgzZl9fQbr2Pqif6RgGvJ+G/BZCwGlV/Y+Osw
w3f4976aTT4Wcb0teVtv+MXdMDxGoSjt+JtvdzRl2F6PRQU5ZuH/9gEO5btFyFSh
PUy6Zuf5uI35AKT/t2WjeEeiCqNU2Bajwn8LOdjtHdUjAjdH1Dw1Orh4/drj5mOa
+uY4xr+3g33VsEFmHrqrQNWjzIcxaHnd4EKoElYVkVGm6GUSyjdiRPSIIb5nBjaw
UgbWaewvda3bI9+d8AUbXfSDdg==
=ek1E
-----END PGP SIGNATURE-----

tag v51.6
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:17 2026 +0100

rdma-core-51.6:

Updates from version 51.5
 * Backport fixes:
   * libhns: Fix CQ clean when CQ record doorbell enabled
   * libhns: Fix wrong WQE data in new post send API when QP wraps around
   * bnxt_re: fix assertion in bnxt_re_alloc_page
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * providers/efa: Fix the size check in efadv_create_cq
   * libhns: Clean up an extra blank line
   * libhns: Fix wrong WQE data when QP wraps around
   * rping: terminate CM event thread before exiting
   * pyverbs: Fix Ipv6Spec class
   * rxe: Fix double unlock in cq_ex polling
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPrEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2Qj
DQf9ElnDizJjcGSrp72EmGYRTGeiXPBJQkdWSkLcuDZthaqPWQSMPLkyXOcg3/K9
HieNwzYhPvuy0T0yQJ3sxEukeXuGBQts67mis9YpVkq9iBT/sUerdNX1K99ZOMOk
JJxHNlU/kyal2siGnKr13GYApYmmzOGOK9DyoYkT80htQbr+fpToenteFXHQ95qr
WjkzrzFssTqwAyaJujG7PPJVrDI9fSPXgVhmu5MDZxYodNFEosxClD+6Sh+Lsvcn
rixLIBXRbZVezYeRPhqLuQsOmkuXd5CwR/v5cJVgNYsI/ZDcTOplbMtajUj+8i6B
+e2D83EJKhr8EBoyZkYorwFwHA==
=HPPr
-----END PGP SIGNATURE-----

tag v52.5
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:17 2026 +0100

rdma-core-52.5:

Updates from version 52.4
 * Backport fixes:
   * libhns: Fix CQ clean when CQ record doorbell enabled
   * libhns: Fix wrong WQE data in new post send API when QP wraps around
   * bnxt_re: fix assertion in bnxt_re_alloc_page
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * providers/efa: Fix the size check in efadv_create_cq
   * libhns: Clean up an extra blank line
   * libhns: Fix wrong WQE data when QP wraps around
   * rping: terminate CM event thread before exiting
   * pyverbs: Fix Ipv6Spec class
   * librdmacm/cmtime: Prevent time stats u32 overflow
   * rxe: Fix double unlock in cq_ex polling
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPrEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2Tf
2wgAgdJJB9P0xV+R7z+6qUnKJAMgzgoD5dZBSiEtUbZnhsb53CXxICjWFXWq2Shc
iRNr08mGDuJDN6FeV44GtLYHhWJP1a0bEHD343naBqqPX6Ov4fcgmJ0LAIJqMRvT
P/qaKoeD9HUiG/71VbKzoRr7mVGTfocvXH9XQKopO5Xq3YyHmR0vw3QqmXrZwCrZ
tb50C+T6fV5NyNKGN8vXQJ8Nc/E4MuL6lW1B+Ot5x8C0zItjlRlBmhKrZhkHu30L
fejQG/4KrcniWCZcCrE4gEXAgF9z1C6v1317bFKPdfucuHDutaEBGUdOSmR+NvMR
iwNLVmdLHdSUXrpnlUzgJiTrcA==
=/azf
-----END PGP SIGNATURE-----

tag v53.5
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:17 2026 +0100

rdma-core-53.5:

Updates from version 53.4
 * Backport fixes:
   * libhns: Fix CQ clean when CQ record doorbell enabled
   * libhns: Fix wrong WQE data in new post send API when QP wraps around
   * providers/mana: fix multi sge send
   * bnxt_re: fix assertion in bnxt_re_alloc_page
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * providers/efa: Fix the size check in efadv_create_cq
   * libhns: Clean up an extra blank line
   * libhns: Fix wrong WQE data when QP wraps around
   * rping: terminate CM event thread before exiting
   * pyverbs: Fix Ipv6Spec class
   * librdmacm/cmtime: Prevent time stats u32 overflow
   * rxe: Fix double unlock in cq_ex polling
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPrEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2Qt
fQf/YVUUnPe4jlyYVpRWpnxYFea0E98PaHDdP4SoY1HtyU0T2OjJg0QRyqZL59N6
oLlvtxpCwMnQpPW5fmxcffoNbu6RozpvKPd9+6NDRoUic+wRkK2UdKcJUTTC27gF
88Vx0XS0UCMvVJqTMEBBs2S6PqmRfT+Lg5ElbB/BTcaEkF6jEkGCs40wZ3pxsom4
juDVccuFToTa8MyOeCNGvLbvQXd/78LHivsjgX+eFfg/Or6BqDdbVmRrW5fJ38/M
CZkhBtyp/u/Zu4rF9yT14v6xX4a5jddymKu1pqgwMUP788JGgbFRZR6Itby7UIR/
7VsjxFx8tgRSV/HJU5IyGYVK4g==
=fR+C
-----END PGP SIGNATURE-----

tag v54.4
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:17 2026 +0100

rdma-core-54.4:

Updates from version 54.3
 * Backport fixes:
   * libhns: Fix CQ clean when CQ record doorbell enabled
   * libhns: Fix wrong WQE data in new post send API when QP wraps around
   * providers/mana: fix multi sge send
   * bnxt_re: fix assertion in bnxt_re_alloc_page
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * providers/efa: Fix the size check in efadv_create_cq
   * libhns: Clean up an extra blank line
   * libhns: Fix wrong WQE data when QP wraps around
   * rping: terminate CM event thread before exiting
   * pyverbs: Fix Ipv6Spec class
   * librdmacm/cmtime: Prevent time stats u32 overflow
   * rxe: Fix double unlock in cq_ex polling
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPrEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2Rg
8wgAgjAmEmSAbgBkJ+l53in6sJGk7j6uPU8RVmOPuk8O17xZQ5fDgaj6VGZZHR3C
x6m0mKFVjo2Up5XOeniS0enPVKNTlSqhxibwMktb9++q3I9aMQki+fNDBjnCPE5U
rSZTD36HMJpIv4XIgqjlESeOOEL9qqNyBohRrHqRFxwoTWtQYb8PO7ZibtRN3rnz
HSMP9KLGCF428Yv58x/tb/JE3bIeYPkljfyelfWE71D/WpWXMzLYW2kqSJELRkRf
2+d+LGiw8JSMDpsMkHpZOth3UrjX6ucx/pF6Wd0fazH64PewK02P5T916KJv+njg
BWrZ5wWLFymyikKcUy/EXfYCoA==
=DcMu
-----END PGP SIGNATURE-----

tag v55.3
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:17 2026 +0100

rdma-core-55.3:

Updates from version 55.2
 * Backport fixes:
   * libhns: Fix CQ clean when CQ record doorbell enabled
   * libhns: Fix wrong WQE data in new post send API when QP wraps around
   * providers/mana: fix multi sge send
   * bnxt_re: fix assertion in bnxt_re_alloc_page
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * providers/efa: Fix the size check in efadv_create_cq
   * libhns: Clean up an extra blank line
   * libhns: Fix wrong WQE data when QP wraps around
   * rping: terminate CM event thread before exiting
   * pyverbs: Fix Ipv6Spec class
   * librdmacm/cmtime: Prevent time stats u32 overflow
   * rxe: Fix double unlock in cq_ex polling
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPrEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2RW
8Qf/WUjiRYUrD33aUdxkK1YwTIjbylg1EYM3WgMHdK3MUOL8KDIUaKv/CscMCIbP
Q+K38atjhnpl5rDT/ifwu6pmrrKI7HQ34je7l7RyrfjP47El0/ZGMTQQC4CWqsR4
oHkxVxPApIR+L5nSbLbM++Wi6UmzOyYZSII+CEjTJIR1dGs1Wu/mmnMU+l5uiSgR
EYe5/ByKvEQ8qMK9D++nP2F6MLYSScCsfmZhukm9rGtPQasGOx6bNWEBKYIxznM1
u3PpDR/33mpslXBZCSXsgW5BNv1I4iZxH+hTlRSNLBPhYqF+9rM3D3bOzh26rl+b
zsryknOQloUMZuRWDzQRElC26A==
=E9CK
-----END PGP SIGNATURE-----

tag v56.3
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:17 2026 +0100

rdma-core-56.3:

Updates from version 56.2
 * Backport fixes:
   * libhns: Fix CQ clean when CQ record doorbell enabled
   * libhns: Fix wrong WQE data in new post send API when QP wraps around
   * providers/mana: fix multi sge send
   * libibumad: Increase max device supported to 128
   * bnxt_re: fix assertion in bnxt_re_alloc_page
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * bnxt_re/lib: Fix the inline size check
   * libibumad: allow choose port with state DOWN in case of explicit user port
   * providers/efa: Fix the size check in efadv_create_cq
   * libhns: Clean up an extra blank line
   * libhns: Fix wrong WQE data when QP wraps around
   * ibqueryerrors: Fix SMP call to use correct port
   * infiniband-diags: Fix sa_get_handle to use smi/gsi API
   * rping: terminate CM event thread before exiting
   * pyverbs: Fix Ipv6Spec class
   * librdmacm/cmtime: Prevent time stats u32 overflow
   * rxe: Fix double unlock in cq_ex polling
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPrEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2Qz
wAgAo1CMdJWiNkDH4iD+8vlUOnPsj6Md8QrwxdyFuqxBjYyCfEYqLkVNoOhXDj2Y
gNcvTik2sQR9Nn11pJdObo5GVL5aQV8Ba5TZn91F3M2Z0CxA7Y1sibmbmt13Y+Ml
zs/1uIWfmaORmPbhAmwvBaZMnCv4HFoF7/WSsSgMgyGhZvNlG6ME5Q+HzoCTdbfO
KYPHTCkQe/6CfGnqXoHJ/qhWq+JszCzrNBTCTb1wg84SjPaZMaFfUjjO0k/IQIl/
dCft3PV7R9zY4W9ukuMKfccjl88rePeS1/7uPL0Ckg2w7vL8Ji2H+ZeyRrA4NQs0
jQ+CEntTloMrWvjm8RLoe7yp+g==
=OEFD
-----END PGP SIGNATURE-----

tag v57.2
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:17 2026 +0100

rdma-core-57.2:

Updates from version 57.1
 * Backport fixes:
   * libhns: Fix CQ clean when CQ record doorbell enabled
   * libhns: Fix wrong WQE data in new post send API when QP wraps around
   * providers/mana: fix multi sge send
   * libibumad: Increase max device supported to 128
   * bnxt_re: fix assertion in bnxt_re_alloc_page
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * bnxt_re/lib: Fix the inline size check
   * libibumad: allow choose port with state DOWN in case of explicit user port
   * providers/efa: Fix the size check in efadv_create_cq
   * providers/mana: Fix mapping of mana vendor errors to ibv errors
   * libhns: Clean up an extra blank line
   * libhns: Fix wrong WQE data when QP wraps around
   * ibqueryerrors: Fix SMP call to use correct port
   * infiniband-diags: Fix sa_get_handle to use smi/gsi API
   * tests: Fix RDMA transport domain test capability validation
   * rping: terminate CM event thread before exiting
   * tests: Fix requires_no_sriov decorator
   * pyverbs: Fix Ipv6Spec class
   * librdmacm/cmtime: Prevent time stats u32 overflow
   * rxe: Fix double unlock in cq_ex polling
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPrEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2T4
MAf+PFDbjqHWROnUtHmcImpLsbqNeqN//qKueOftMC5HW4YrM9XhvLP+CoXXvCN3
C4HjLyg9ju8fYmAQEnoguMaYjNAzfgnsb/u5EK/V9aAZsmr35lEEyz9Zvl/4v41N
0fasgQ2vjboudT+vIdJm9S1pEbp7d37MQlWwVPp5vgOIV7bQLBlHa8AcdsyIzhGJ
d5sTBnVglFyx/VaPiC79AKR4mTX4u8YwtYvY8GbIG5jswXaakowmddtE+sNizihQ
7HvGnecj/qsThQVIddzEph618fubhZETMgcPqnlPV70jAKIZ8kDfRaTryzDjeNwO
IkirUoywkekbqgPd/1ONl9nKXg==
=3Cr6
-----END PGP SIGNATURE-----

tag v58.1
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:17 2026 +0100

rdma-core-58.1:

Updates from version 58.0
 * Backport fixes:
   * libhns: Fix CQ clean when CQ record doorbell enabled
   * libhns: Fix wrong WQE data in new post send API when QP wraps around
   * providers/mana: fix multi sge send
   * libibumad: Increase max device supported to 128
   * bnxt_re: fix assertion in bnxt_re_alloc_page
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * bnxt_re/lib: Fix the inline size check
   * libibumad: allow choose port with state DOWN in case of explicit user port
   * providers/efa: Fix the size check in efadv_create_cq
   * providers/mana: Fix mapping of mana vendor errors to ibv errors
   * libhns: Clean up an extra blank line
   * libhns: Fix wrong WQE data when QP wraps around
   * ibqueryerrors: Fix SMP call to use correct port
   * infiniband-diags: Fix sa_get_handle to use smi/gsi API
   * tests: Fix RDMA transport domain test capability validation
   * rping: terminate CM event thread before exiting
   * tests: Fix requires_no_sriov decorator
   * pyverbs: Fix Ipv6Spec class
   * librdmacm/cmtime: Prevent time stats u32 overflow
   * rxe: Fix double unlock in cq_ex polling
   * stable branch creation
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPrEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2T8
IggAugNroVq+a3OFfrIsv9PzIZwut5Q0lwn9Xleksbsux6Tk1bLyZM56m1NKz/qa
3zqwykVO23VhBUTt2d/FQ18epFIiIEo7Pd+T9WcWbqGpIO9eT2wSvdfLbN7u+MjT
FUCGTX/Q9+1utdandv52MdUIt2TBfNs6EdeC8g3tGpA0Bhkc4p63cRED4Mn8qwtd
omuhuXolLSlKyfhJiYPeHt2QOictQ7CUeNP7oZur30PHTYe1Jb4JVwXQhZ4cqvsr
FHIzG+Gd/YVPIsssrROH+gjuNkIea9t9V28w61J7m263DSj0dKe5Rp5G+Q9WCZKw
a0JF8FcdWVb6m+MGT7fPFu9mhQ==
=k8WY
-----END PGP SIGNATURE-----

tag v59.1
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:17 2026 +0100

rdma-core-59.1:

Updates from version 59.0
 * Backport fixes:
   * debian: correct symbol version of new ibverbs 1.15 functions
   * libhns: Fix CQ clean when CQ record doorbell enabled
   * libhns: Fix wrong WQE data in new post send API when QP wraps around
   * providers/mana: fix multi sge send
   * libibumad: Increase max device supported to 128
   * bnxt_re: fix assertion in bnxt_re_alloc_page
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * bnxt_re/lib: Fix the inline size check
   * libibumad: allow choose port with state DOWN in case of explicit user port
   * providers/efa: Fix the size check in efadv_create_cq
   * providers/mana: Fix mapping of mana vendor errors to ibv errors
   * libhns: Clean up an extra blank line
   * libhns: Fix wrong WQE data when QP wraps around
   * ibqueryerrors: Fix SMP call to use correct port
   * infiniband-diags: Fix sa_get_handle to use smi/gsi API
   * librdmacm/cmtime: Update man page
   * librdmacm/cmtime: Drop unused 's' option
   * tests: Fix RDMA transport domain test capability validation
   * stable branch creation
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPrEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2R/
2Qf+J5DKnSjPmB5OlIgzPCQ5K6kbid1mBxoOGciImfuRjwJi25yEcKIR3xXxL3MY
OLcBuekDqlP3xfcSSfJk7+VCbYFrliaZnCyWGQgsiA6oz3P+xO2/vWl9uuUgzttq
ZsTH+cbM+jHijhcuyGNKmdzhVm5yht6HyFcrDj9P0q/MEBZzzCELqGApMjPVr6uD
QMqARbgyhmszbe9fSHctS0yBK2Hb9qe1RN0CNTvh1orgCb3udiD0FjmzGr1cD87l
1lbQA4LGrNelgod4v484/ObFlIrGXeWSVqEy41cX0gJFelxdJ+ku9qxhIGMufKox
ZpdH9B6EtA66XubXBG0xYxlbHA==
=ZsA0
-----END PGP SIGNATURE-----

tag v60.1
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jan 6 17:56:18 2026 +0100

rdma-core-60.1:

Updates from version 60.0
 * Backport fixes:
   * debian: correct symbol version of new ibverbs 1.15 functions
   * libhns: Fix CQ clean when CQ record doorbell enabled
   * libhns: Fix wrong WQE data in new post send API when QP wraps around
   * providers/mana: fix multi sge send
   * libibumad: Increase max device supported to 128
   * bnxt_re: fix assertion in bnxt_re_alloc_page
   * bnxt_re/lib: Remove the unused function
   * bnxt_re/lib: Fix the WQE size alignment
   * bnxt_re/lib: Fix the inline size check
   * efa: Fix missing mmio flush writes on WQ lock skip
   * libibumad: allow choose port with state DOWN in case of explicit user port
   * librdmacm: Fix rdma_resolve_addrinfo() deadlock in sync mode
   * providers/efa: Fix the size check in efadv_create_cq
   * providers/mana: Fix mapping of mana vendor errors to ibv errors
   * libhns: Clean up an extra blank line
   * libhns: Fix wrong WQE data when QP wraps around
   * stable branch creation
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmldPrIbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2Tf
BAf/R4X2uW5rEFsujQbByZtRREy8Qhfo86OQwoGSON/oTn5LAkBqeructaNp4n71
p6hlMPvUfHQ/vv63xC6aFFeWYaeW15dcuCrb7Z+ZdBprXIEXQRzVX/r4w4Rd9zUQ
PBWy5Yy/tL4DIpihQgnP71pgSwTa3EeKtQyFwMuKdIYkfWoOaSQzmCChbi43V8ZV
VIsvx1B/4rvqMhvr+KSZBriQMpnCZcH/spk5ru+rxK1sJJ5qLBbI4hiAyKAelxff
dWaA8DvWmmGaRbykO6y2YmaKJwfWUqjIetNsNZzMYc6QaF3iOFiQqVVzCuXt/cGd
/SWsHaNiVS9InqElvNqhqCWP5w==
=NwR9
-----END PGP SIGNATURE-----


