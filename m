Return-Path: <linux-rdma+bounces-9137-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAEEA7A127
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 12:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727571896584
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 10:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6314724A043;
	Thu,  3 Apr 2025 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L/Zu46Ds"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990492E3385
	for <linux-rdma@vger.kernel.org>; Thu,  3 Apr 2025 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743676822; cv=none; b=kzqe2sq3rWcDcG18FclHA88h6LGT3VvsbXpk7JH4BEuDodIn1WTSjAsYks3ckuW6dAhHc9O8ylDX6O/nXuIkBB21IhN4ojw6PTa7h+szjyWmtyzXLkGD1vvTHiXeCZ4hpBT43JQcaptXOeeKy1dGalPWeEJBZk6OAObtwNR1IZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743676822; c=relaxed/simple;
	bh=B80Dptwme7lVl449g9o6dSpNycQFp9JwZHDhyX7wfJU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=P5s1IsJn+ECZMBShSvTouv7dN7dxfrPeYBfQKVXhCZ8btVZMbqmvlNaSrKmDsWQDx12605jWjAb8PgJsF78pwHghHK8PQTHbF++VIN3aqthUmzePy7mSWt/Hz0naMTJZ7t8yS2NxJ+OiExOisUb8A7ITGx3zCnVyAoLAGhami5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L/Zu46Ds; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43d4ff56136so272305e9.3
        for <linux-rdma@vger.kernel.org>; Thu, 03 Apr 2025 03:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743676817; x=1744281617; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cazXUTdhrnfDVQcRqqbZjUgLydmrNmmeW0/oZ5qw7Yc=;
        b=L/Zu46DsXOFPon8vJtDNCUguSltXAqjvFST3MP3tRoqtFTFA2wKv0CThkjsbxo80Y5
         WuNZ5tRfd2OjTHHk2hDNYSvYd0axCC2uJm+C3mOF6sCe+DNYC2osoAAIQCkY3OKGiOK1
         jixHhzkpmYTBqTU5B+WwId9D81V9DtOMgoTpebY0a/sT7TB422vkOhsFedIXzdtIHvhg
         VKgzLZWwuRMeDFhOJBudBhi4bRXXIf6ELN91glfM+nfPudRRPwBy0G9tQyvF74OhRpl1
         SX2AiwMdlHjnsDRCA0SKV5ijcIp1EFKkW5oodgXhJNvak3IPtcIbAIi/PCtxzuuAmoTG
         6OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743676817; x=1744281617;
        h=content-transfer-encoding:autocrypt:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cazXUTdhrnfDVQcRqqbZjUgLydmrNmmeW0/oZ5qw7Yc=;
        b=afWqMFJjvQM2FXGOQVQqaPci4R4MixIpmftxgq7lwqV/+rEYr8IDsXjPtK4QN3/0rV
         O0PldbeJFIRft+BtS9kTunDojvI1HqQi02AHrDi14zM5hhRxNsQPSWyW6TyZIfXph19G
         6M1cclmxCpldVbCjtg3YmrsIZrTAO0K6OuUVt58vjax7iVqOTrCQTGIDl+C2yrAY9xHY
         X4OkVFrcQbroA3XQrWLFJ1C8flYEdqm7/gyqcjFQNexDVknbGVr0xEoem+Cnd9SuOOMD
         ROGn4HBI9aMR5XRJBtP2qvfl0rWBs0ZIZMcJW4yH6RejMA3nW5dCaVIJlS0sZA6K/1Ys
         sSRQ==
X-Gm-Message-State: AOJu0YxCSZXT8XtfweGfoRmjjysIRErdc0MnPWr2itW5cp1uDv7HHuXt
	9vXl9+DqVT/c82tL1tW9us0q830x5xz4sF032qNiXuhBIJ38E9iUe7ozddRJkM5jULyOcASZ1et
	vCB1exysW
X-Gm-Gg: ASbGncsLFm2G1oXD7bWYiLdRNZ0zrf+3XUO5Q4MXV3i7LIwahLRFUCcQIU+2MXRGsB/
	AJsYQfzBZTZnMwx1tO4K4XEO+WR+ouU0mJiDTp9Y9XcGdslWX6B2vU19S8BluYCF5f5GC5zRWOY
	oloP+8tNduW1ZaLjBApaLeVsHoqU3pia4pRF8KDJumcDfMAzl66ibSD+QjPF2jOI6Y1V/8QaKSG
	R023BU7F9Z9ghgE7kczc5Khb3cPny8brwIaBVNFovikFQ9ehxOfXEVbj39TdvpvGw4kI+zCsFo3
	U8vZ8QBBuB1gCev62dtH7Nkn55mo1m5Dk6yagD+M8PNdPEtpZtyymObgaOCJrllJf9DCxrOcgde
	GtjF42Jw0
X-Google-Smtp-Source: AGHT+IE8vp6aoe+loNLk/9eiUd2loQY+BaS++rkTA4Lppf2grjQpXfckO1eVN1fg9R2heAa0y/LhNA==
X-Received: by 2002:a05:6000:2485:b0:39c:1efc:44ed with SMTP id ffacd0b85a97d-39c1efc460amr3975085f8f.7.1743676816328;
        Thu, 03 Apr 2025 03:40:16 -0700 (PDT)
Received: from [10.0.2.128] (lfbn-ann-1-288-66.w86-200.abo.wanadoo.fr. [86.200.241.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a7225sm1431458f8f.26.2025.04.03.03.40.15
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 03:40:15 -0700 (PDT)
Message-ID: <96d9706d-6317-47a3-85e8-bbfc4bd16a67@suse.com>
Date: Thu, 3 Apr 2025 12:40:14 +0200
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
Content-Language: en-GB
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

There were a lot of patches this time around.
It seems to have quiet down a bit so it feels like a good moment for bunch new stable releases :)

These version were tagged/released:
 * v34.16
 * v35.14
 * v36.14
 * v37.13
 * v38.12
 * v39.11
 * v40.10
 * v41.10
 * v42.10
 * v43.9
 * v44.9
 * v45.8
 * v46.7
 * v47.6
 * v48.5
 * v49.5
 * v50.4
 * v51.4
 * v52.3
 * v53.3
 * v54.2
 * v55.1
 * v56.1

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v34.16
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Apr 3 08:44:23 2025 +0200

rdma-core-34.16:

Updates from version 34.15
 * Backport fixes:
   * Revert "mlx4: Fix overrun-buffer-arg"
   * ocrdma: Fix uninit_use issues
   * libibverbs: Fix cast-align warning in verbs_get_ctx()
   * mlx4: Fix overrun-buffer-arg
   * mlx4: Fix uninit_use issues
   * vmw_pvrdma: Fix uninit_use issue
   * cxgb4: Fix uninit_use issues
   * qedr: Fix uninit_use issue
   * iwpmd: Fix uninitialized value
   * efa: Fix receive SGE length overflow
   * rping: wait for acknowledgement before processing subsequent CONNECT_REQUESTs
   * librdmacm: prevent NULL pointer access during device initialization
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmfuLkcQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZIlBCACkcDUSPKYQrS6QpxAfq2sftrtPNi3eXPJe
YXKg+wqaoDTBUcxLIa+sDTxgvFdaadf88LpX+VNZDB2+JMlmWpz4ok6PvMN/uN8r
mNlAIdkBse6K6RyKqFNxrAx9Xc7byckaP6cnSml1dxzcOrVxzQVewUiUM+e10scB
jd3pZ/ywfhzLHGPs2bVIxVTsKFpUlHCD0v9r2MZKENkYhzLBh7tdZhkVFTBYKrPh
V+BklZzVh2Tfj6G3izhuhF1td2QiXyR+GZY4J9s+iKAPf8DFpPlqplTC6sHxvpOT
qzzI+TbIrgNq5DWuI5woakN31G20ZrTyD2ICzThXI632oMvPAcUf
=oir/
-----END PGP SIGNATURE-----

tag v35.14
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Apr 3 08:44:27 2025 +0200

rdma-core-35.14:

Updates from version 35.13
 * Backport fixes:
   * Revert "mlx4: Fix overrun-buffer-arg"
   * ocrdma: Fix uninit_use issues
   * libibverbs: Fix cast-align warning in verbs_get_ctx()
   * mlx4: Fix overrun-buffer-arg
   * mlx4: Fix uninit_use issues
   * vmw_pvrdma: Fix uninit_use issue
   * cxgb4: Fix uninit_use issues
   * qedr: Fix uninit_use issue
   * iwpmd: Fix uninitialized value
   * efa: Fix receive SGE length overflow
   * rping: wait for acknowledgement before processing subsequent CONNECT_REQUESTs
   * librdmacm: prevent NULL pointer access during device initialization
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmfuLksQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZGYtB/9m+UCNa2RKi34Ew9yuFRxxNcT7WnoeWxWn
oao44By6TjtcpMnT2Gz5Z3MwtmLqgmNzomRceyPIOG2KdVUysbBfs+GcEbnCIKHu
ct9tyKAVloEzXU/6hJ+LF2mQ2hAbW3odBgbblpIV3SJEaH6ygfqYapq8xbTzqam+
fiMzyrVZ9GGCqeQ2j3MBI/8pIiDSi+XiawmD8+bkoz0ymwnrTuZigH3GHh9tMTH+
Z9liIPACFLX7/fAsj5+KISx0dCRpgqXLzR0OFAkP9piWn3D/uhl0yLQpKzorIi3c
zbmt+q1u1qjGe2jP75XDPNbkIRF616DKr4oOsbioNp6bNAtZyjly
=trfD
-----END PGP SIGNATURE-----

tag v36.14
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Apr 3 08:44:27 2025 +0200

rdma-core-36.14:

Updates from version 36.13
 * Backport fixes:
   * Revert "mlx4: Fix overrun-buffer-arg"
   * ocrdma: Fix uninit_use issues
   * libibverbs: Fix cast-align warning in verbs_get_ctx()
   * mlx4: Fix overrun-buffer-arg
   * mlx4: Fix uninit_use issues
   * vmw_pvrdma: Fix uninit_use issue
   * cxgb4: Fix uninit_use issues
   * qedr: Fix uninit_use issue
   * iwpmd: Fix uninitialized value
   * efa: Fix receive SGE length overflow
   * rping: wait for acknowledgement before processing subsequent CONNECT_REQUESTs
   * librdmacm: prevent NULL pointer access during device initialization
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmfuLksQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZBpxB/96qscybFtd4RR0Hp0VJiRgqy1ArvA53lMn
uwOirFj6IItWUs+fJU5uObxCkZoJl5JFCPSNzFkx+N95vYNt6vRPv2aQZQG7WkpT
LDP0fCX1qmO4UJ2n11JCoE+KdB1tUGEEtmcDNrlYOoQCS/jAFXmkejHfNiYacRza
TjKYQ7cmVXXxywJRunIRMCGGX+YwseR9RIjTDFn9MasfMg5O+n/6F3GRLh/fYszO
cxkA2NWk/BbN5x5RmhznxKh14bKrv124P/SYLqpjVrQydt15KPHgJoAWFAXLpz5s
HL/d0JaDx7fsUg5B7NEs8f+0JYDfi/C+zFcs8+/cb9d24E+2eOyO
=aR25
-----END PGP SIGNATURE-----

tag v37.13
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Apr 3 08:44:27 2025 +0200

rdma-core-37.13:

Updates from version 37.12
 * Backport fixes:
   * Revert "mlx4: Fix overrun-buffer-arg"
   * ocrdma: Fix uninit_use issues
   * libibverbs: Fix cast-align warning in verbs_get_ctx()
   * mlx4: Fix overrun-buffer-arg
   * mlx4: Fix uninit_use issues
   * vmw_pvrdma: Fix uninit_use issue
   * mlx5: vfio: fix memory leak in mlx5_vfio_get_iommu_info
   * cxgb4: Fix uninit_use issues
   * qedr: Fix uninit_use issue
   * iwpmd: Fix uninitialized value
   * efa: Fix receive SGE length overflow
   * rping: wait for acknowledgement before processing subsequent CONNECT_REQUESTs
   * librdmacm: prevent NULL pointer access during device initialization
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmfuLksQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZCRIB/0WQm0Vk88gGd89CzDbzeIs9guyp6RXDD6s
jxEYCygOYkuEeJV1a0OIOMA3SsfRUEIhMan8FH6vtI02DgP0mQmhgUK3fZUv5IcR
C6vppKWe11moEkSvo7vWqvDM2R/NXc/eeExMkRfElVdpqI9aCFbbzUWEw/nqkDaA
o4GNk+MA9WYaAeGHkn1Gf4KXlzW3WAEHCdKxnoUpi1iAAvCoPhESKDSCoJghi70U
AAJ3bC4UMXDbw3xjp9j5CepC4NOBsuomd+d7+iuKeNRMPnxMpjYev9xHp/RUkqPo
WTH0PalssXHG003k4jO1z8LcuCbW/0g7kSrnMF18eqL+cbEY6s1p
=pTn4
-----END PGP SIGNATURE-----

tag v38.12
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Apr 3 08:44:27 2025 +0200

rdma-core-38.12:

Updates from version 38.11
 * Backport fixes:
   * Revert "mlx4: Fix overrun-buffer-arg"
   * ocrdma: Fix uninit_use issues
   * libibverbs: Fix cast-align warning in verbs_get_ctx()
   * mlx4: Fix overrun-buffer-arg
   * mlx4: Fix uninit_use issues
   * vmw_pvrdma: Fix uninit_use issue
   * mlx5: vfio: fix memory leak in mlx5_vfio_get_iommu_info
   * cxgb4: Fix uninit_use issues
   * qedr: Fix uninit_use issue
   * iwpmd: Fix uninitialized value
   * efa: Fix receive SGE length overflow
   * rping: wait for acknowledgement before processing subsequent CONNECT_REQUESTs
   * librdmacm: prevent NULL pointer access during device initialization
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmfuLksQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZEXYB/9jUu6C3GgYMAYrQmEGd1ydSOwP4y/TlE5m
797cbnSfoIFeCJZqICcLrJV7e6YFv8LwCKKI5qfIS+nMuDNRyVTb061LU+FW94dz
qGtNdTkO3jktqZkjQwB7KCTstZkSfeoDsdXMAsRLitNtT+WnXXzXFB8jmHSDniIg
+Uwne4tkx/gA2Y0+ZYqUyv5q37EAn9jzO0y6lyZZDk/znRx7AN0p6OyzZm+oOUlk
U+rkkvAIEp+qsNkImrju9MhCPGs96wUIyPmx+Mw6IJD5PU097KaL3NKwKco9PIIC
gF4IWTUYuVXUZPF2/O5LI9QFaMXKMCgzg3rq7fDt1HGUvFe0Upqv
=zShz
-----END PGP SIGNATURE-----

tag v39.11
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Apr 3 08:44:28 2025 +0200

rdma-core-39.11:

Updates from version 39.10
 * Backport fixes:
   * Revert "mlx4: Fix overrun-buffer-arg"
   * ocrdma: Fix uninit_use issues
   * libibverbs: Fix cast-align warning in verbs_get_ctx()
   * mlx4: Fix overrun-buffer-arg
   * mlx4: Fix uninit_use issues
   * vmw_pvrdma: Fix uninit_use issue
   * mlx5: vfio: fix memory leak in mlx5_vfio_get_iommu_info
   * cxgb4: Fix uninit_use issues
   * qedr: Fix uninit_use issue
   * iwpmd: Fix uninitialized value
   * efa: Fix receive SGE length overflow
   * rping: wait for acknowledgement before processing subsequent CONNECT_REQUESTs
   * librdmacm: prevent NULL pointer access during device initialization
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmfuLkwQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZCMQCACsfhF0C3Xhyrd1ULWrDNbtaRoLZj6r73V5
uy4rnO6vwyDAdhFCvaDnNaRbpvLt2Avgnn8v67OQbpDWbzhz/y6kySRQ2QX2teIG
/GZGKo/F0L9psDtSg465zeCIA5phowYFM+KJ+1lAed8NWuzVz2zATcwgv+PG2BfB
A50+nlSSfUSKvGRj/QIJXr7or3cVnmzbrx1wit0QRKBKR9gHQ4O/OAzHYKwXjC3B
hsV7yXodkNtVv/seNgkcCF77yGWtaTBrfqjjHlueF/RSeANCQ1R+DfXqsB3Wh+aw
6QuknQMjQT4+S+i7NCLBakH/ClW6ZsBnb4X01cyvHzn+SLo//J7y
=8GlS
-----END PGP SIGNATURE-----

tag v40.10
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Apr 3 08:44:28 2025 +0200

rdma-core-40.10:

Updates from version 40.9
 * Backport fixes:
   * Revert "mlx4: Fix overrun-buffer-arg"
   * ocrdma: Fix uninit_use issues
   * libibverbs: Fix cast-align warning in verbs_get_ctx()
   * mlx4: Fix overrun-buffer-arg
   * mlx4: Fix uninit_use issues
   * vmw_pvrdma: Fix uninit_use issue
   * mlx5: vfio: fix memory leak in mlx5_vfio_get_iommu_info
   * cxgb4: Fix uninit_use issues
   * qedr: Fix uninit_use issue
   * iwpmd: Fix uninitialized value
   * efa: Fix receive SGE length overflow
   * rping: wait for acknowledgement before processing subsequent CONNECT_REQUESTs
   * librdmacm: prevent NULL pointer access during device initialization
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmfuLkwQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZG9ECAC4VvNpPPYPRA5+KutTRKsr+PsM2oAUxCqw
fFQE7NqFyetxEU8jBIYqKxy8V6GoXGODGzM4zgn3q8EusKdmfOZi1cbRrYbTJFbA
UW1pnf1XTHWHkzOfMHPwFLw5AG2ssm4mX5eWTRbZjiZViBCQZLie5pbsnS/KYNiJ
Zg1DLLLb2Ay5l3IeRJG4uDQgLoIPikzDwYeTuhKTQSm+22oeTh3TDD2v/Q/UOpo6
XBPpaT2zxY+PV7GEx/as346PejZBi2hn0aKU4sLwiQzzYfhnNLLcn82xduoEh7qh
T1y7zLmJK+FuyOf0Mhv+QMllas0dxnyXkoOVxmGiKSDF4TFJASJl
=PuPU
-----END PGP SIGNATURE-----

tag v41.10
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Apr 3 08:44:28 2025 +0200

rdma-core-41.10:

Updates from version 41.9
 * Backport fixes:
   * Revert "mlx4: Fix overrun-buffer-arg"
   * ocrdma: Fix uninit_use issues
   * libibverbs: Fix cast-align warning in verbs_get_ctx()
   * mlx4: Fix overrun-buffer-arg
   * mlx4: Fix uninit_use issues
   * vmw_pvrdma: Fix uninit_use issue
   * mlx5: vfio: fix memory leak in mlx5_vfio_get_iommu_info
   * cxgb4: Fix uninit_use issues
   * qedr: Fix uninit_use issue
   * iwpmd: Fix uninitialized value
   * efa: Fix receive SGE length overflow
   * rping: wait for acknowledgement before processing subsequent CONNECT_REQUESTs
   * librdmacm: prevent NULL pointer access during device initialization
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmfuLkwQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZI69CACfHgsjWFAJrxuwOtWyrdIXSx4kCWTY3FVT
J881CohfAUMhLFMPZ1/fhKWutl6J/FvwVV2v9Ng9zwLNzRBhKxTMWTulreqL8AIX
f8aT47TMWGWbhjeTROFBaOi9ICB1qpvEQCQ+qH1xBxdFYaWVY5j5nG0VmgdxLSBK
BFEvYvktyPNGmQT0HxjCMDWWPBq5fEaxtab2L2LKsNTkd5LCP2H1ceRSOUWQHKL+
yISPEOTwltjbGUExqGJu+YqkWcD3DBqR7ZU8RaNGlPAGtIpjjfzhIcBp2602uC62
HiKtAmMSEPGoxqTAWX5npDFOayyFL7/OOrkIyG3XB/1NYn9sLNn+
=twXx
-----END PGP SIGNATURE-----

tag v42.10
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Apr 3 08:44:28 2025 +0200

rdma-core-42.10:

Updates from version 42.9
 * Backport fixes:
   * Revert "mlx4: Fix overrun-buffer-arg"
   * ocrdma: Fix uninit_use issues
   * libibverbs: Fix cast-align warning in verbs_get_ctx()
   * mlx4: Fix overrun-buffer-arg
   * mlx4: Fix uninit_use issues
   * vmw_pvrdma: Fix uninit_use issue
   * mlx5: vfio: fix memory leak in mlx5_vfio_get_iommu_info
   * mlx5: fix bad alloc type in dr_arg_pool_alloc_objs
   * cxgb4: Fix uninit_use issues
   * qedr: Fix uninit_use issue
   * iwpmd: Fix uninitialized value
   * efa: Fix receive SGE length overflow
   * rping: wait for acknowledgement before processing subsequent CONNECT_REQUESTs
   * librdmacm: prevent NULL pointer access during device initialization
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmfuLkwQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZD2fB/9nAzlBrf2X6Sdo8yu0O7KtoZMwmxnecuei
w1O7OE1NQ1CiaUn1cMl8mu8tQ6qG8eL6lssrpKmoCrJMItXOsaM16rDlLHH5/xvB
UKtvvzZyMSUklEyJHNUTJdBdeae/OiLq852Cbn0dGPrTh8kVrmwDp7B3GCF7QCza
43TfBfjyxO1RBGYNBNk35PwE7VdihtAuy2bXcu6vC5EEjJym5F0AOuT9InAkm4DT
WqBEx97DtFXvmRRbT57ugo+m1ZjqNbYYSZ16wGDXFVtH7iH718z0VefjuRF3/AxL
AMCzeae7UDAyNCSPRg0TnsseVRFDhrg1s1ZgYz/ORyZBvwMeu0KT
=i1SD
-----END PGP SIGNATURE-----

tag v43.9
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Apr 3 08:44:28 2025 +0200

rdma-core-43.9:

Updates from version 43.8
 * Backport fixes:
   * Revert "mlx4: Fix overrun-buffer-arg"
   * ocrdma: Fix uninit_use issues
   * libibverbs: Fix cast-align warning in verbs_get_ctx()
   * mlx4: Fix overrun-buffer-arg
   * mlx4: Fix uninit_use issues
   * vmw_pvrdma: Fix uninit_use issue
   * mlx5: vfio: fix memory leak in mlx5_vfio_get_iommu_info
   * mlx5: fix bad alloc type in dr_arg_pool_alloc_objs
   * cxgb4: Fix uninit_use issues
   * qedr: Fix uninit_use issue
   * iwpmd: Fix uninitialized value
   * efa: Fix receive SGE length overflow
   * rping: wait for acknowledgement before processing subsequent CONNECT_REQUESTs
   * librdmacm: prevent NULL pointer access during device initialization
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmfuLkwQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZJ6kB/4lc0Ij0hRR5ECQhzmIc4ryX+/IWy96mLKw
63ZNNz7vOd7PBlYZdiBbHWObL+PhyUEgm7tOyP+nb0srPlkS3J4tEUqeoKYg/HIc
ESIoUo/E/hIAP0aCLuiwvDPinAR7MCYvmRgfY7MHi8lKx5pYPM2h33DZ0fsRAfF0
AXYMs3jpB5eLNCY8IeeX7MeSNCwKD+JVPvwWjmx0tnEkRJInUdCNM6NvlJWTa6gU
YS0ek4YpCOVF/KwJdY9K2tL2cbVC7ihpH9nlvHWXnuHCmOWeSV3/ioVyWSqhMit/
AWVbnbPIj9JkYHsly8cT+LLydu2NqSMzTKrqVQwmEhLaF+KTNCWV
=P1J1
-----END PGP SIGNATURE-----

tag v44.9
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Apr 3 08:44:28 2025 +0200

rdma-core-44.9:

Updates from version 44.8
 * Backport fixes:
   * Revert "mlx4: Fix overrun-buffer-arg"
   * ocrdma: Fix uninit_use issues
   * rxe: Fix uninit_use_in_call issues
   * libibverbs: Fix cast-align warning in verbs_get_ctx()
   * mlx4: Fix overrun-buffer-arg
   * mlx4: Fix uninit_use issues
   * vmw_pvrdma: Fix uninit_use issue
   * mlx5: vfio: fix memory leak in mlx5_vfio_get_iommu_info
   * mlx5: fix bad alloc type in dr_arg_pool_alloc_objs
   * cxgb4: Fix uninit_use issues
   * qedr: Fix uninit_use issue
   * iwpmd: Fix uninitialized value
   * efa: Fix receive SGE length overflow
   * rping: wait for acknowledgement before processing subsequent CONNECT_REQUESTs
   * providers/mana: Fix return values on unsupported parent domain flags
   * providers/mana: Fix return value on unsupported QP type
   * librdmacm: prevent NULL pointer access during device initialization
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmfuLkwQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZC/NCACoh7ZEFv9bnpJ+l2hLDkeFj29yFnluS3Ek
Y4BU3PfqCSSlHBYhSK2kQy4rv69AZlsBGPJ3qfmqKyrHxcB1isQfEtMGvPKBQdGl
aCJXK3O+UiOc3OhkXkCKeq7Ec+yqMdypqCPnmvzRruOoss+bEuf6j5ctuToc+No1
e/rjEhifKFQDT6XeHFjsU+b9M0Gf/I7VZ8sjXIUNXjtDyvDbEgsBJUdUKjPgeKpL
PIw+SwdZtCUeVyDZuzlFIGdi4WhisX7oxYDucFjvrV5hmKhZIu01A14x+LEskwgH
UGslE+O6Hd7PoRjFOmcftgL6kttUV1v1FDcBw88CXPYdS435TGzA
=YXY/
-----END PGP SIGNATURE-----

tag v45.8
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Apr 3 08:44:28 2025 +0200

rdma-core-45.8:

Updates from version 45.7
 * Backport fixes:
   * Revert "mlx4: Fix overrun-buffer-arg"
   * ocrdma: Fix uninit_use issues
   * rxe: Fix uninit_use_in_call issues
   * libibverbs: Fix cast-align warning in verbs_get_ctx()
   * mlx4: Fix overrun-buffer-arg
   * mlx4: Fix uninit_use issues
   * vmw_pvrdma: Fix uninit_use issue
   * mlx5: vfio: fix memory leak in mlx5_vfio_get_iommu_info
   * mlx5: fix bad alloc type in dr_arg_pool_alloc_objs
   * cxgb4: Fix uninit_use issues
   * qedr: Fix uninit_use issue
   * iwpmd: Fix uninitialized value
   * efa: Fix receive SGE length overflow
   * rping: wait for acknowledgement before processing subsequent CONNECT_REQUESTs
   * providers/mana: Fix return values on unsupported parent domain flags
   * providers/mana: Fix return value on unsupported QP type
   * librdmacm: prevent NULL pointer access during device initialization
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmfuLkwQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZAAdCACv0p0XKg/e6Qt1uOz/uJwhzZc5O+K1k/J8
7LJD6rxk/N56enn7oKvJwhgV1tYIYbBZuDo0QBAGG7ooiXSM3+vM93FDvfeIxchR
zfbpbSVIgNZMtHOoFS6BMeahL3ibFUrhpMOTA8HH+VM6qY7frUoTme0q2FDnR9D+
EncCJAh+2cZTB7Da6F8ySSYnGv0F2gKNO8hqA+YeCbegId6mQlFJ2NuJ1xKjh7Dq
LuukzT8pvn9p9hkW4rhWMhzPCq5v2MuIUvs3Q9TVSFVXSuxMcMvGcHJ0QmtgrBzy
gQUcjNjA5HkzAUwl6cmXvRJ8VJW8dYK70o0jKDL8oTzsvIwvHXPB
=nE3j
-----END PGP SIGNATURE-----

tag v46.7
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Apr 3 08:44:29 2025 +0200

rdma-core-46.7:

Updates from version 46.6
 * Backport fixes:
   * Revert "mlx4: Fix overrun-buffer-arg"
   * ocrdma: Fix uninit_use issues
   * rxe: Fix uninit_use_in_call issues
   * libibverbs: Fix cast-align warning in verbs_get_ctx()
   * mlx4: Fix overrun-buffer-arg
   * mlx4: Fix uninit_use issues
   * vmw_pvrdma: Fix uninit_use issue
   * mlx5: vfio: fix memory leak in mlx5_vfio_get_iommu_info
   * mlx5: fix bad alloc type in dr_arg_pool_alloc_objs
   * cxgb4: Fix uninit_use issues
   * qedr: Fix uninit_use issue
   * iwpmd: Fix uninitialized value
   * efa: Fix receive SGE length overflow
   * rping: wait for acknowledgement before processing subsequent CONNECT_REQUESTs
   * providers/mana: Fix return values on unsupported parent domain flags
   * providers/mana: Fix return value on unsupported QP type
   * librdmacm: prevent NULL pointer access during device initialization
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmfuLk0QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZLjeB/0cDxSqWt9EjrsMHeY2k+no3LIEetujFk3R
C8lFt7jc6KVDmdycDKxcqEsAyoFSBX1UvNNcbMD4Fo0egS0WGLFA+uz56ZIQ2hSO
P1sNbwmgyx0x6A9NnPWq3EtjgFjmRVwgCTTEqv2lJCcTPAEDZ6qYn3irEgpfJ0aN
uocGIFuw3kpVRT/NdYyPdeoXPAHja1GdXHMEMtMzILUAuGnlEyQYUm6B28hT4SEk
DvHo++Ds585aOFJ6fuIlhu4Pyu5UmTO0B9YnNQZDCTVX1S1rRzTs9UYQ22MqfkpL
5t5yv9vZmag9ud7byCygKKKbWDiM45hZWVhwtexf9FSQTUpT17mS
=bkJ6
-----END PGP SIGNATURE-----

tag v47.6
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Apr 3 08:44:29 2025 +0200

rdma-core-47.6:

Updates from version 47.5
 * Backport fixes:
   * Revert "mlx4: Fix overrun-buffer-arg"
   * ocrdma: Fix uninit_use issues
   * rxe: Fix uninit_use_in_call issues
   * libibverbs: Fix cast-align warning in verbs_get_ctx()
   * bnxt_re/lib: Fix the data copy during the low latency push path
   * mlx4: Fix overrun-buffer-arg
   * mlx4: Fix uninit_use issues
   * vmw_pvrdma: Fix uninit_use issue
   * mlx5: vfio: fix memory leak in mlx5_vfio_get_iommu_info
   * mlx5: fix bad alloc type in dr_arg_pool_alloc_objs
   * cxgb4: Fix uninit_use issues
   * qedr: Fix uninit_use issue
   * iwpmd: Fix uninitialized value
   * efa: Fix receive SGE length overflow
   * rping: wait for acknowledgement before processing subsequent CONNECT_REQUESTs
   * providers/mana: Fix return values on unsupported parent domain flags
   * providers/mana: Fix return value on unsupported QP type
   * librdmacm: prevent NULL pointer access during device initialization
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmfuLk0QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZM+rCACOhzrjB+ajrt4fgie3n3UrAL9Vlp1vGasv
VhbhUkooJLrLBTLUdY12JMuEPRqDcid+6htjwUXrFgds3CACz+CE6ZGy74konkI7
jakEMSwlzbkf+gaeDxkBXFt4IqqKBc9Fccd4v7XRKVLInDGDmln8ECbSj5uiltXd
BuWqxvTEav/MriRFI+mOmHrSCKYunttvj/pYD8DK4v4LSc+EfDQWpR6bKs7QGCv8
8uK/YPm5ofmWD5wgVodV2Qai7CbPieOsE3XEJz4UyQmFB96wWFK2b5W8CAp5EPlm
kKp7zo0CXNFKkxr6FZI+J0Bv+GGOv5spU7tbvVC9Z6eZylwBHsG5
=DPEx
-----END PGP SIGNATURE-----

tag v48.5
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Apr 3 08:44:29 2025 +0200

rdma-core-48.5:

Updates from version 48.4
 * Backport fixes:
   * Revert "mlx4: Fix overrun-buffer-arg"
   * ocrdma: Fix uninit_use issues
   * rxe: Fix uninit_use_in_call issues
   * libibverbs: Fix cast-align warning in verbs_get_ctx()
   * bnxt_re/lib: Fix the data copy during the low latency push path
   * mlx4: Fix overrun-buffer-arg
   * mlx4: Fix uninit_use issues
   * vmw_pvrdma: Fix uninit_use issue
   * mlx5: vfio: fix memory leak in mlx5_vfio_get_iommu_info
   * mlx5: fix bad alloc type in dr_arg_pool_alloc_objs
   * cxgb4: Fix uninit_use issues
   * qedr: Fix uninit_use issue
   * iwpmd: Fix uninitialized value
   * efa: Fix receive SGE length overflow
   * rping: wait for acknowledgement before processing subsequent CONNECT_REQUESTs
   * providers/mana: Fix return values on unsupported parent domain flags
   * providers/mana: Fix return value on unsupported QP type
   * librdmacm: prevent NULL pointer access during device initialization
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmfuLk0QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZKBjB/0dDhH2rSJbU+gQfHJbEewgOWiix4UH9wmZ
Stz4n3Jf15tmFWsQwFvYEyvbYIe11FTv0yU1BHP6g3i9u2mRAe6NLykjRYMWExe2
G/9/YfX8YQTrl3Q0VCH+N/qg3LWJ6xNdYDJ2wt1XNR05IgeN4RqAgeWGf4IviJwk
YhghQHICZ1BEHa3kRK8B4A3mnInyDTFUKWxgo5GuX2VkA0SfPReOjpBNkj98KmPU
1KYsunbpCD9zv3PxF0u7g4SbxekODNzOH+Rvf8lE+MUMdao8eZkAGjfnqqSR4Dp9
R4BvilUkK7cPBpMsbJsXVb6OZY+tzRkKc5EsVZwRoHdFHhluXq7N
=mi4F
-----END PGP SIGNATURE-----

tag v49.5
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Apr 3 08:44:29 2025 +0200

rdma-core-49.5:

Updates from version 49.4
 * Backport fixes:
   * Revert "mlx4: Fix overrun-buffer-arg"
   * ocrdma: Fix uninit_use issues
   * rxe: Fix uninit_use_in_call issues
   * libibverbs: Fix cast-align warning in verbs_get_ctx()
   * bnxt_re/lib: Fix the data copy during the low latency push path
   * mlx4: Fix overrun-buffer-arg
   * mlx4: Fix uninit_use issues
   * vmw_pvrdma: Fix uninit_use issue
   * mlx5: vfio: fix memory leak in mlx5_vfio_get_iommu_info
   * mlx5: fix bad alloc type in dr_arg_pool_alloc_objs
   * cxgb4: Fix uninit_use issues
   * qedr: Fix uninit_use issue
   * iwpmd: Fix uninitialized value
   * efa: Fix receive SGE length overflow
   * rping: wait for acknowledgement before processing subsequent CONNECT_REQUESTs
   * providers/mana: Fix return values on unsupported parent domain flags
   * providers/mana: Fix return value on unsupported QP type
   * infiniband-diags: Use correct port info to get correct cap_mask
   * librdmacm: prevent NULL pointer access during device initialization
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmfuLk0QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZPJrB/0UEWMnPCmHg4/Lxvt6orMbAjWRXIWnkgww
9v+RaFxHdr/WFqe2bbROGa6pLy5e61FMFQrTJKZrzT+v5o73noCWiOx59UmnvLZN
O4/AJCkbcne0vlpkImxJlvp7xs/NNVAtMI7qQ8hFxQKzwKsliuRHCxB/l/x5eWk8
WdLMZeHLLHyyzHFlZmNgk79J/I932S1AUI3u4Pim64tKdOgXmdF9NTLke0BtK39v
JQ91+e0K5OXykKuLPmpFhjPew7JOz8H2/N7Fwv65B9nq3KB/x+LHskLeQXMdDy5w
EZlAF+5jambr9KPf0EKoBo8yUJIaj/U00kWb5oTFUcm9HyFyiuPL
=bdtU
-----END PGP SIGNATURE-----

tag v50.4
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Apr 3 08:44:29 2025 +0200

rdma-core-50.4:

Updates from version 50.3
 * Backport fixes:
   * Revert "mlx4: Fix overrun-buffer-arg"
   * ocrdma: Fix uninit_use issues
   * rxe: Fix uninit_use_in_call issues
   * libibverbs: Fix cast-align warning in verbs_get_ctx()
   * bnxt_re/lib: Fix the data copy during the low latency push path
   * mlx4: Fix overrun-buffer-arg
   * mlx4: Fix uninit_use issues
   * vmw_pvrdma: Fix uninit_use issue
   * mlx5: vfio: fix memory leak in mlx5_vfio_get_iommu_info
   * mlx5: fix bad alloc type in dr_arg_pool_alloc_objs
   * cxgb4: Fix uninit_use issues
   * qedr: Fix uninit_use issue
   * iwpmd: Fix uninitialized value
   * efa: Fix receive SGE length overflow
   * rping: wait for acknowledgement before processing subsequent CONNECT_REQUESTs
   * providers/mana: Fix return values on unsupported parent domain flags
   * providers/mana: Fix return value on unsupported QP type
   * infiniband-diags: Use correct port info to get correct cap_mask
   * librdmacm: prevent NULL pointer access during device initialization
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmfuLk0QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZPfjB/911yNTGQyAWhdeby4yyxzHFb7qQMgq0utX
3q6F4mBjGAdoSBAqzBO1qXveGRdV87oTcHejIxNvLhosmVbhX/t9t4CbBqssnJdx
0MOQ/JclcCYTo4A/38CYBY1hO+ChsQOvn84Z0Fadr4XTBQvKnD6DfjAE4imVOdnP
EgvHbbBIoTyLNwjsch/QH1X54SOSAbfbT/YrXDINY1K/54iA5x3LO9Xvm+Db19LJ
7QuycOq90evaVKGuBw3gq/xL63/5NIcdAZbQ0aJBv5RFDA97PIxA93YDLIsDPt22
Luckz0HB3mwx87gPWQcmPq8TSL6n4czJdpw9DCwD27lcfvC8cZee
=1tUL
-----END PGP SIGNATURE-----

tag v51.4
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Apr 3 08:44:29 2025 +0200

rdma-core-51.4:

Updates from version 51.3
 * Backport fixes:
   * Revert "mlx4: Fix overrun-buffer-arg"
   * ocrdma: Fix uninit_use issues
   * rxe: Fix uninit_use_in_call issues
   * libibverbs: Fix cast-align warning in verbs_get_ctx()
   * bnxt_re/lib: Fix the data copy during the low latency push path
   * mlx4: Fix overrun-buffer-arg
   * mlx4: Fix uninit_use issues
   * vmw_pvrdma: Fix uninit_use issue
   * mlx5: vfio: fix memory leak in mlx5_vfio_get_iommu_info
   * mlx5: fix bad alloc type in dr_arg_pool_alloc_objs
   * cxgb4: Fix uninit_use issues
   * qedr: Fix uninit_use issue
   * iwpmd: Fix uninitialized value
   * efa: Fix receive SGE length overflow
   * rping: wait for acknowledgement before processing subsequent CONNECT_REQUESTs
   * providers/mana: Fix return values on unsupported parent domain flags
   * providers/mana: Fix return value on unsupported QP type
   * infiniband-diags: Use correct port info to get correct cap_mask
   * librdmacm: prevent NULL pointer access during device initialization
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmfuLk0QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZDTCB/4ojg/xUgAnSlloa29j6X0/gWiT0dbzedjY
4+w6ZEqDGOuZzzSlCOfXpCMiX64PBRg/sSKMS4Y3R6p2vItvR8S9AbOjoSKX7wzj
ejJeFuWTBlEgsfHDRkILpxS1Lbw2drbJebgMjEHT1B/8wp31XgriuZmPPaqqkvBO
K4vZoxIzhorwTpdeBK1teOX82O0zcbvTIZyko0ALIvVBQvJZ3CTwVfk2Zk070Ngn
AxG6U8g6WHRt9ZC3klZcYzIMRtpNsV45nmTUqQgiuyCbkOkR7LZ/70TrGXeHWtU0
sFnF2Z7EM8rVnVUjberc7r2dEJNO1JEf6CNsD6CORPIP1bYHwcXm
=G2+6
-----END PGP SIGNATURE-----

tag v52.3
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Apr 3 08:44:29 2025 +0200

rdma-core-52.3:

Updates from version 52.2
 * Backport fixes:
   * Revert "mlx4: Fix overrun-buffer-arg"
   * ocrdma: Fix uninit_use issues
   * rxe: Fix uninit_use_in_call issues
   * libibverbs: Fix cast-align warning in verbs_get_ctx()
   * bnxt_re/lib: Fix the data copy during the low latency push path
   * mlx4: Fix overrun-buffer-arg
   * mlx4: Fix uninit_use issues
   * vmw_pvrdma: Fix uninit_use issue
   * mlx5: vfio: fix memory leak in mlx5_vfio_get_iommu_info
   * mlx5: fix bad alloc type in dr_arg_pool_alloc_objs
   * cxgb4: Fix uninit_use issues
   * qedr: Fix uninit_use issue
   * iwpmd: Fix uninitialized value
   * efa: Fix receive SGE length overflow
   * rping: wait for acknowledgement before processing subsequent CONNECT_REQUESTs
   * providers/mana: Fix return values on unsupported parent domain flags
   * providers/mana: Fix return value on unsupported QP type
   * infiniband-diags: Use correct port info to get correct cap_mask
   * librdmacm: prevent NULL pointer access during device initialization
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmfuLk0QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZPiNB/9i8YWvJ3eFfma0YLdW9FqiS/b4zJxcbN/3
BxOq/aIuAGvif7Yow2IgPHThkmo/bh11cR4xOlnyNNlMC0S9ejnmTwi/T76Tjlmz
kocB6IYVV+5qoomK+vAWLwbTrdy6eLN//V20MXjPNgshSTiTIUsyxFeO7ggak/Bn
SIjYZA1M4CooLlecoyiVDHntooQOtMI0jNy0cFouHHlQbr8YbRr2WOn7TyXHeCZB
NzEjDTwWQgr5IMIYlrbc2+XxiKFidK1cw63u73qsdQOhWux+ZMFqJFfH1BYYi/vn
2Bgoi55Yqcf4XvANNAAj5J3yNmbjxK3onyr9+hpfGkvTftSvY/+k
=Fg7b
-----END PGP SIGNATURE-----

tag v53.3
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Apr 3 08:44:30 2025 +0200

rdma-core-53.3:

Updates from version 53.2
 * Backport fixes:
   * Revert "mlx4: Fix overrun-buffer-arg"
   * ocrdma: Fix uninit_use issues
   * rxe: Fix uninit_use_in_call issues
   * libibverbs: Fix cast-align warning in verbs_get_ctx()
   * bnxt_re/lib: Fix the data copy during the low latency push path
   * mlx4: Fix overrun-buffer-arg
   * mlx4: Fix uninit_use issues
   * vmw_pvrdma: Fix uninit_use issue
   * mlx5: vfio: fix memory leak in mlx5_vfio_get_iommu_info
   * mlx5: fix bad alloc type in dr_arg_pool_alloc_objs
   * cxgb4: Fix uninit_use issues
   * qedr: Fix uninit_use issue
   * iwpmd: Fix uninitialized value
   * efa: Fix receive SGE length overflow
   * rping: wait for acknowledgement before processing subsequent CONNECT_REQUESTs
   * providers/mana: Fix modify RC QPs for RTS and INIT states
   * providers/mana: Fix return values on unsupported parent domain flags
   * providers/mana: fix WRs with zero sges
   * providers/mana: Fix return value on unsupported QP type
   * infiniband-diags: Use correct port info to get correct cap_mask
   * librdmacm: prevent NULL pointer access during device initialization
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmfuLk4QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZKN3CACilBcbypLezwjjrYLP/6u3Bcmn0a4rx80g
eg5/EXzkPoMsKCnBLHPmlZNNawu93ySKsZ1l7wOA9VUNMFglS7ELMggIiwi8oZOE
YPmIL1pOfjmj/gecMkoVPZ3vGVGb3hLa7WpSoFTAGi/DGRfYbGdOfIbsIi+DJ1af
evCg7LZViVWj6yzsWwFXgfuYYD/E0kkP4u8VBsoU4Oe8cfIANRC7TtSybXQ83Alq
7jIy6BRmbCA7OGmkaXWZ4hZC7IBOKhSfUcc0d+zbXi5dCjabHhtTNivzNggBKKhy
NrRnqRo3vP8f1I+WuRSUhKDw4MiKRrLALGqPHLp5QT5sEybFbNE4
=h7FD
-----END PGP SIGNATURE-----

tag v54.2
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Apr 3 08:44:30 2025 +0200

rdma-core-54.2:

Updates from version 54.1
 * Backport fixes:
   * Revert "mlx4: Fix overrun-buffer-arg"
   * ocrdma: Fix uninit_use issues
   * rxe: Fix uninit_use_in_call issues
   * libibverbs: Fix cast-align warning in verbs_get_ctx()
   * bnxt_re/lib: Fix the data copy during the low latency push path
   * mlx4: Fix overrun-buffer-arg
   * mlx4: Fix uninit_use issues
   * vmw_pvrdma: Fix uninit_use issue
   * mlx5: vfio: fix memory leak in mlx5_vfio_get_iommu_info
   * mlx5: fix bad alloc type in dr_arg_pool_alloc_objs
   * cxgb4: Fix uninit_use issues
   * qedr: Fix uninit_use issue
   * iwpmd: Fix uninitialized value
   * efa: Fix receive SGE length overflow
   * rping: wait for acknowledgement before processing subsequent CONNECT_REQUESTs
   * providers/mana: Fix modify RC QPs for RTS and INIT states
   * providers/mana: Fix return values on unsupported parent domain flags
   * providers/mana: fix WRs with zero sges
   * providers/mana: Fix return value on unsupported QP type
   * infiniband-diags: Use correct port info to get correct cap_mask
   * librdmacm: prevent NULL pointer access during device initialization
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmfuLk4QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZNNeCACfX+Kb7wBhgsHZ4IzsJqfjbbUt8h29hGhU
vDxToh/tt/sIr0GfxUvByZ86GcO9BAtpkMeoPedu65rFVdscsa0T8KkdnuwlA/Nm
R8p4kUe+tkcHpWI1S9usB6ehKYMyDG13bYLRlA1V8iUtT7LXRvWzowSmVHGwhTLL
RNJSKRujnoTom6J50Mo0T94/9PU+YeBPRnXcFifQTV73mY1pnuAFSlXWMXi1uSqp
C5uV342IsL7fF9jvf/PNIWmgJEnwy8BB7ttbwDQ8X06g1yKKItjHv8Bme+eWnSXH
+2tv99lG4v999wopz1Ud3sCgK/AxKfhFGih2NGUz49O1S7xd4Tw8
=bDJ+
-----END PGP SIGNATURE-----

tag v55.1
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Apr 3 08:44:30 2025 +0200

rdma-core-55.1:

Updates from version 55.0
 * Backport fixes:
   * Revert "mlx4: Fix overrun-buffer-arg"
   * ocrdma: Fix uninit_use issues
   * rxe: Fix uninit_use_in_call issues
   * libibverbs: Fix cast-align warning in verbs_get_ctx()
   * bnxt_re/lib: Fix the data copy during the low latency push path
   * mlx4: Fix overrun-buffer-arg
   * mlx4: Fix uninit_use issues
   * vmw_pvrdma: Fix uninit_use issue
   * mlx5: vfio: fix memory leak in mlx5_vfio_get_iommu_info
   * mlx5: fix bad alloc type in dr_arg_pool_alloc_objs
   * cxgb4: Fix uninit_use issues
   * qedr: Fix uninit_use issue
   * iwpmd: Fix uninitialized value
   * efa: Fix receive SGE length overflow
   * rping: wait for acknowledgement before processing subsequent CONNECT_REQUESTs
   * providers/mana: Fix modify RC QPs for RTS and INIT states
   * providers/mana: Fix return values on unsupported parent domain flags
   * providers/mana: fix WRs with zero sges
   * providers/mana: Fix return value on unsupported QP type
   * infiniband-diags: Use correct port info to get correct cap_mask
   * librdmacm: prevent NULL pointer access during device initialization
   * debian: add IBMAD_1.4@IBMAD_1.4 symbol
   * providers/bnxt_re: Fix memory leak
   * libhns: Fix missing fields for SRQ WC
   * efa: Fix CQ doorbell unmap on CQ destroy
   * bnxt_re/lib: Fix the inline size check
   * stable branch creation
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmfuLk4QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZHboCAC6LsgwR0onTfx57+NxEEYu2kjdFSnGWhu0
9NiTwUqjinzCZj525Ld7ZJzsijDDOkeggIawCLcvx+rdF1xppmyNBqplVdzC/UzU
4Kk8/QpEQy5BPmEl1BX7crtO0f6i5WqU4oDjGwTx0YCRo/kx0nuDYqXsCQ01u0P/
F5C2EJwpGqteauDX6thphvgU5PPxUThhY1wzV2Ct5kER9Kq3Vsboumz/QNPrsoVe
OV2wWSKf7F1EbJwUyPY+YoC3yg2uhxjcZNXJ3Ag6iNQM1D2nXP7T2SNMTNbuFe6o
reYRXpdUXoaZOi5uRIl72rG2TWmPr2gghlKf1ieucQsYx32y4fn0
=21WP
-----END PGP SIGNATURE-----

tag v56.1
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Apr 3 08:44:30 2025 +0200

rdma-core-56.1:

Updates from version 56.0
 * Backport fixes:
   * Revert "mlx4: Fix overrun-buffer-arg"
   * libibumad: Fix iteration index for switches
   * ocrdma: Fix uninit_use issues
   * rxe: Fix uninit_use_in_call issues
   * libibverbs: Fix cast-align warning in verbs_get_ctx()
   * bnxt_re/lib: Fix the data copy during the low latency push path
   * mlx4: Fix overrun-buffer-arg
   * mlx4: Fix uninit_use issues
   * vmw_pvrdma: Fix uninit_use issue
   * mlx5: vfio: fix memory leak in mlx5_vfio_get_iommu_info
   * mlx5: fix bad alloc type in dr_arg_pool_alloc_objs
   * libibmad: fix memory leak in mad_rpc_open_port2
   * cxgb4: Fix uninit_use issues
   * qedr: Fix uninit_use issue
   * iwpmd: Fix uninitialized value
   * efa: Fix receive SGE length overflow
   * rping: wait for acknowledgement before processing subsequent CONNECT_REQUESTs
   * providers/mana: Fix modify RC QPs for RTS and INIT states
   * providers/mana: Fix return values on unsupported parent domain flags
   * providers/mana: fix WRs with zero sges
   * providers/mana: Fix return value on unsupported QP type
   * stable branch creation
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmfuLk4QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZDOKCACe638vIBhBm7y9uBKTupMcenn0xB0JzhjS
TgJVBt83oR0EzKuaBIIJf91leGg+B4HJU+BkRONGkYC7ODPHTRHCWP5E0l1TTpR/
Vr9nQDOx7ukFZE50JTwGqqLDJcDPz8a8dhCiz/bNEWaVP16QP/6nYpMONAOZtCdo
tCRtkbXH7KVbj6ahEm6MhpC+fGf7b8bVga/VeN43dIWuRSYosQd2NblJponK1Ns/
+ahDa3uxE6ItlH7sv67jI8kNwAEc9kpFg9FRVGiFLXWyVazAwY9bx4aMZpEdNtYf
hnOunZKSwjY2i8KlQIUoWwUi9VSR8bySwKp4SskEHi55RST6Hjoc
=LSFB
-----END PGP SIGNATURE-----


