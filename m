Return-Path: <linux-rdma+bounces-11401-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D07BADCCE3
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 15:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF93B7A42B3
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 13:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E149528ECE8;
	Tue, 17 Jun 2025 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CtOADqSR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11AB2E7182
	for <linux-rdma@vger.kernel.org>; Tue, 17 Jun 2025 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750166359; cv=none; b=OHNNDImCMdCzlJm5iRGb1Q9Vx4JTIuMaqQWLjroaYe+tXhJBtNI77AcokZSSr8/tvnOsMDJSUqpRzkstJYmyEEjCJeaiyHKUO/AkqgEr5TsRXjVjnzb+pwzVhDwHaB4DAmHi833URF9TiWWPpbJvvqsBaTSK4BRn2+uaI8jLrHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750166359; c=relaxed/simple;
	bh=QrwsNECPRlsCb/8lSV0yXcv266Be5RPMH/fjtJ8FgSI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=lcnxTNFx8bShETIP7D9gBW8BndqOahxPXM4lpmmR/TB2XJ/lvCKZOBqfUKOho26rvCqqO6/VwIxaZDWERXZ4jyxIklH8vn+KaCXeGfmWe5Rucq2Bubl7AhyhJEpoMcFlp93o/E0XMHHfPdsO+b9zo6TLT6Ye1McjsI9f9TJ3VuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CtOADqSR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-450828af36aso4463685e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jun 2025 06:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750166354; x=1750771154; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WJQXJpzSL7oSd17Eqbb8fCEHCHrLPrZu/I12v95sxIs=;
        b=CtOADqSRc6vXjUgBmBCw9Ido4o3+F5EsyLXdepHrVYAoqPKGIxawC+z8drJ5rgtA4i
         bt+rc1mvyV+37L24QLk3cvBIJTCKrU+kKtzV7nzUJRCAlNeAcZTtAxwdyltGfZ1Eke4+
         Ap2akR3cH0+1+os7fOQxoYX0eg+vqFmnU4c1xzGjQyf0wEvCevcVpjj/lkBiE3vsIGhf
         XueiRVq92KSsBOaPfboOtZ90+/IAJutAeeyZ/CFbBsC3Kaeo1JQvF9Orh+yRn1mXdKbW
         oaYoqH1AssStvpACQd5089In1D+f2Btm5TtEiLUnLKfmAhq9wBTsQadTQ00Hs3mUnGiT
         hwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750166354; x=1750771154;
        h=content-transfer-encoding:autocrypt:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WJQXJpzSL7oSd17Eqbb8fCEHCHrLPrZu/I12v95sxIs=;
        b=LavNmpQAfSsYdNXbGzd1vYzh0HvBvyYhHrlaU3+yJs0/Uvunk/xMn7yIPKZLxY3IeS
         IOOC+RdH+CbmGrgQ7XV61+mmzKvMBXbKNjkmasHNYvmMt5CPykPvzbHEQgupcXp9/lS/
         VdA/aAlFHwtsTDPtVYdFphDgfyhZEW29LuYaP7rqitgwRtT61rP4zg7+lQ8/ayVLaFPv
         BjYjxyFXT67D24Cfom8KoM4jmdXRVezO44TalJoXCpxtCTMNCZUlFGC5ObOI6IRPXCEB
         PVJTT+AZuCcYAiVfJPEa9Mek+HBoQegF2bDEgWPoHjfgBsMjGfoVDGsr9UIkIuqtluDL
         eqIA==
X-Gm-Message-State: AOJu0YzJ0GjpInxciB7EfsbnJbSIqLeex/Clbn0P4mbpLuknixCcEe1e
	sFqhf6hcm91AkiXvElbO2obP5W9H7zs32qASs4x3g3bsh/eTFgpAgMzoUNAFPTFhh/BGk1DYEyB
	pYbnv
X-Gm-Gg: ASbGncvpDw3EvtXmCiQZe/map0dSexnUUPvFy5BS2uxO3s6PLRVPe7gNT9tvzemVtMF
	wEwHI+DYVTAL8Ih+uxYB5K2Nw6icddUxDPR9oirP57Aed4VREE65Hn3lZp1aUmRUa0PhVbXW3+W
	TRoX4/XPM3HBpbapuVoK6f8+WVAR5WK38koX6wFTk4hYKfq9SUbm7CkDx91ysynrRi3MBLvKyTs
	E95SXl6PJIQksqcZBEYo32uFiAHfj3ru51K6/1fXsyMo+jkV5AnumNq0Y+d2lbrqDV1aPWL9a9n
	Pf3cMgJfy6tmyyZtWF0QnJxgGkMGCdG1DRHhze/6QYAzChZBTmdguaOGGCDxi3CC76gHQk4Np2U
	vRjiqNgqBhDROyOdSyLNFQlbALA==
X-Google-Smtp-Source: AGHT+IGLmrj6TyCLz0UPUWUVeRjLcA/Qd54Iv4JLDgpeG9BkUyLqByVMUAGz4nnE/VRRMaa/FUFhqA==
X-Received: by 2002:a05:600c:840f:b0:450:d4b4:92d0 with SMTP id 5b1f17b1804b1-453523818a1mr11736255e9.3.1750166353893;
        Tue, 17 Jun 2025 06:19:13 -0700 (PDT)
Received: from [10.0.2.128] (lfbn-ann-1-288-66.w86-200.abo.wanadoo.fr. [86.200.241.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e24155bsm173923665e9.17.2025.06.17.06.19.13
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 06:19:13 -0700 (PDT)
Message-ID: <73b4fd1d-3744-4c32-a4bc-7028d2254980@suse.com>
Date: Tue, 17 Jun 2025 15:19:12 +0200
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
 * v34.17  (last stable release for v34.x)
 * v35.15  (last stable release for v35.x)
 * v36.15
 * v37.14
 * v38.13
 * v39.12
 * v40.11
 * v41.11
 * v42.11
 * v43.10
 * v44.10
 * v45.9
 * v46.8
 * v47.7
 * v48.6
 * v49.6
 * v50.5
 * v51.5
 * v52.4
 * v53.4
 * v54.3
 * v55.2
 * v56.2
 * v57.1

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v34.17
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 16:59:55 2025 +0200

rdma-core-34.17:

Updates from version 34.16
 * Backport fixes:
   * verbs: Assign ibv srq->pd when creating SRQ
   * util: Fix mmio read on ARM
   * azp: Overcome kernel.org AI protection check
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMWsQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZGfvCAC1AMIAT+mftWbk7e+dDmCoBfKpYcgmrEtJ
ScMoBS07CrO1ZomoVLZnUgMZEevcELkXiG7ucnbr1OCCkghdhzHamBaxW/kiFiAH
f/Lv/pfccSflNzEoDs5mmZX4D/bFDCeXtgh0ftXI06htxwgUkMoj/NMETcH2xgWD
+dp0GEmzdq3b+pGQDf2xwnMa0mcAajScKDFYnuB6Xsn4yGuFhCBFC6MCi22WckSV
uoZi2VdXY04ouQz1BufQkV/iBx1Pd61S2n7oNIn9bMirE1M/AZJgkXcJ0znycx31
TpNAgPddr/qysepdcLxleIrSd4Nd+UpF5UKdMQd8NM6AU+HovyO6
=7Mak
-----END PGP SIGNATURE-----

tag v35.15
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 17:00:04 2025 +0200

rdma-core-35.15:

Updates from version 35.14
 * Backport fixes:
   * verbs: Assign ibv srq->pd when creating SRQ
   * util: Fix mmio read on ARM
   * azp: Overcome kernel.org AI protection check
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMXQQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZAdiB/0dzBZ5Hm8W9VTX4QAxo9/1qOlazMKhWw1P
N8x4J/45iGqvn1CPDJfq2Mw+tpb1iNYH9k4AZy74SA2XVDPae5ZCrHgIM6E5m4Sq
frAespf6JHrnwVgl91ePxZE3IkkYnaf+Cszv7rTkx4x+ADQMC8Mf3NfLbfEJAfJO
ey17+TRHev6yY1jF4mqGHBaV1jZHtx2ZGVouiO7rZ63ULinpVgM2UBo1dJwBClXS
hYmTZXHSn1uiDUlM4RDXcMeqUgwXOppGBJ3ALCGj07eNlOUa3deOA8v14y4dvTqB
VJ1EWg/t4vPUkweY8ToRSy9KIWHJNJBWs/2gGX16t4jswMC/p6cw
=EH8F
-----END PGP SIGNATURE-----

tag v36.15
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 17:00:06 2025 +0200

rdma-core-36.15:

Updates from version 36.14
 * Backport fixes:
   * verbs: Assign ibv srq->pd when creating SRQ
   * util: Fix mmio read on ARM
   * azp: Overcome kernel.org AI protection check
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMXYQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZPCbCADC/QhyZnKP9NLKyLmw3B7LUtyFPWU+g5Wy
5VfkZX1GQ0IN2rZQmdAaGmAbZObz9HSOxRn2mLhXjK4n7lW/+nYkI6AXkKmcL8Ki
29GBnlAfVtdfJ2oOuHBJq0TBh+aOmrlcpyX/920pOVu/DhX9u8O1MMwAC/skQIZu
m6IkrisJnhcDqeEqAgfwIjKGM/dVi942RtmAcZZkezOq/uEyZ5dqDN0Zyk57EAbG
Ql2sQkKOj20/8+2S1R+OKzsdKlTS7pLIi+ekpwgyo/aQvkEa27052AeAmCEsUXab
sSb/y6pV5CWDEl8xt+qNkqFcVv5NyH1GLYhijgICVWD5RwzdD7GD
=aKKF
-----END PGP SIGNATURE-----

tag v37.14
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 17:00:07 2025 +0200

rdma-core-37.14:

Updates from version 37.13
 * Backport fixes:
   * verbs: Assign ibv srq->pd when creating SRQ
   * util: Fix mmio read on ARM
   * azp: Overcome kernel.org AI protection check
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMXcQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZKopB/9qHsEbT9g9KN9QD/9ZlZPbs2T7+QUz0mcW
aiW/8ji4UUVzND7LlqXFRD+3Btea5PYvWITkDBEhi3lKN/+xxo8NK0LVrb90oVTh
g1BKT3ngfuRNrroiqTNT28uKuXKGBjlGdcxs0B8DTY9puPX++hcGIv9REMCyA/pn
c1REtPQyvNbnHfPwLOSXCgRSa5pYAVTi8XZ3FGgFd4Q5ZRlfMzkyGEbzMLXk9cRP
xA8zkG4ONMdjABYbogQ0PC3NNCGRVhg5Gluq1+DaJlv7WmKYib0HkOCgZCb2qQ+A
r5+BIGAL0JUj41VKaoJbHy9bouClrQehHynCjL0eprI6whPFJuCi
=k2SD
-----END PGP SIGNATURE-----

tag v38.13
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 17:00:08 2025 +0200

rdma-core-38.13:

Updates from version 38.12
 * Backport fixes:
   * verbs: Assign ibv srq->pd when creating SRQ
   * util: Fix mmio read on ARM
   * azp: Overcome kernel.org AI protection check
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMXgQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZH7yB/9NpUXFKzKR6/2EI5zxOeViEodpMc/C3KNG
v/XLlvN26u+luW1ZxDQW318iZxQ3rVUKlY2CR+diuZYOEKwMOs+EyOCXRgGRNJ+p
j0/ixd0VNVt7LpLpqN98rY28vZ5dZbwD8Y5w6dNaoajTEzp8EhyzYmQgSnTR7NGP
3qmq9jYtlyXaaibTaAyUADdWrBOeGaG1nQgOfwaLXYPL5hp/yMVFy1CRLs8rT8P1
15Jibb0WjToZoSY1XRAHs+ZChhtjRlCFunERUC7bBG9h2ojABwJuKoIUguVKThMr
vY5QqU9hVc0eoi3+4lLF++RdTQDRDgbP9/hcnvIPHSN2pKZx8gSd
=U4fX
-----END PGP SIGNATURE-----

tag v39.12
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 17:00:09 2025 +0200

rdma-core-39.12:

Updates from version 39.11
 * Backport fixes:
   * verbs: Assign ibv srq->pd when creating SRQ
   * util: Fix mmio read on ARM
   * azp: Overcome kernel.org AI protection check
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMXkQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZCdhCADAAfAOmkORbitHI3VaRmBXj9zLSjCCAUBZ
se8WAMy3TAjzIiq2cx3tkQ0cZ1O5lXlPrJwP0ajL+OeowIn9Tz/4Dd6DnC0Fdjs6
Dd0AExLd1Ti6AjBnk3mCNzZioynV2yYkbLCUj011r/PXxxRuwdJSL43ynALpJSlc
8rPSjluZanzvXuQopnqbLwQlJifp8wpx3drkCzsTifzrb5sUjjbm0yNYOxgwzuly
hZRAn9er2nrseq6L8u/XXQUZ69pLxxfnAAvikYlW26WX6c6LUdZN7SkynIKRuJP9
8nygwfFlaCdHTz4wZoseWEq7Q5NSyLBbx4ntKXASloiS++Yav5nY
=mNx7
-----END PGP SIGNATURE-----

tag v40.11
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 17:00:24 2025 +0200

rdma-core-40.11:

Updates from version 40.10
 * Backport fixes:
   * verbs: Assign ibv srq->pd when creating SRQ
   * util: Fix mmio read on ARM
   * azp: Overcome kernel.org AI protection check
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMYgQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZHPNB/0TIArBJvlhzLwIiPnWXxHd5dDOWI0Dh+bD
Nwv2jibm8hJkdgweG3S6NBLVHijJ98w7J3KE+vqWxaWuKFFPwZHRCiMA3Y0TXemi
DvawVLPUfa3U6ocD32AVCExGdOGx5vk3M2SQP8d2we3UVTujFe48st5NKppr8Jri
T9ICzWAzIEKPyUmpSrvrBt4IlUZovxK91N0iCLHU+ujy/71pWty2x9qYHLd6v9q8
r7EXvPFXE9AiqKvnAR4CoSdiUX2Rhwdiiwicr4UE5gdG5e5XexKeD0Ny7jybCurL
MzpGEMEgdZAGeykbDcSYFMZy5QGCsq/Np1GiyeEBbZXlRuabgz9O
=0zKV
-----END PGP SIGNATURE-----

tag v41.11
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 17:00:25 2025 +0200

rdma-core-41.11:

Updates from version 41.10
 * Backport fixes:
   * verbs: Assign ibv srq->pd when creating SRQ
   * util: Fix mmio read on ARM
   * azp: Overcome kernel.org AI protection check
   * libhns: Fix wrong max inline data value
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMYkQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZGyoB/9FeFwBNFXyO2pXVWvqB21jYpHN8EXb3Pst
XFQVnOhqpx7zi9APyc70YxOmIzL1jZ7ZpbwfxNVc5OII1Qp26hroYLNSaJ/XwgWz
+PssYUBo3O0fyNgfiT3DzAVPx3cpqGjA8tNS9VZkmOeeKhPiWxMVacrk+FYCuAcV
d00xfbi+bmAxmtHP/inZom1kgC+54E+EAvMh1++zVKBPVtBJAYkqsbYGC+Hy52dK
4Bln2oE2s7yEzNodRQVyctYqv95Dt9KZvadD/Guci1RWIp5Zwjz3UNw8sCa3vsXD
Ek84JrRGxL+1jbsX8fgOTHpddxh81u4oVHmDd+QjUEDQv058Tsb9
=+j4T
-----END PGP SIGNATURE-----

tag v42.11
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 17:00:25 2025 +0200

rdma-core-42.11:

Updates from version 42.10
 * Backport fixes:
   * verbs: Assign ibv srq->pd when creating SRQ
   * util: Fix mmio read on ARM
   * azp: Overcome kernel.org AI protection check
   * libhns: Fix wrong max inline data value
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMYkQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZCbECACrV1+jwi9eTndNFAeTPlXsywRgAfwige5O
A7PH+TQWpafaS8jwJkuEf0fNjmGefiKKBWFn4/XXfkmQbqU/AkgXvWBKfJf+uCbI
MwrtI3loLXGz7K3ilOvITUmacQrdZUjZuPrytPKfUROCbGCMhlpcAhTGtjQEtJgF
hoJHJgDMFncxJBE7VPcefGKApnuDvb4wyy9NympLR/Ot3j4dYv6PZ6LfTYCFK6Bt
EPbmEFjh4ZbAPTVvgHduMZZP9C0QRy3X0dC4NO3da0SZcF3xNnFg6b21QjskJHx3
iYujbjay2TQdiADvSJGR73pDOdkXwp8f+1bjZGmFJZ2Vb0U7EoVT
=tqNT
-----END PGP SIGNATURE-----

tag v43.10
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 17:00:26 2025 +0200

rdma-core-43.10:

Updates from version 43.9
 * Backport fixes:
   * verbs: Assign ibv srq->pd when creating SRQ
   * util: Fix mmio read on ARM
   * azp: Overcome kernel.org AI protection check
   * libhns: Fix wrong max inline data value
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMYoQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZPo7B/wMXhMEjksPWKb3i0YMmwgmvfdnL8GUGobg
Vw52gCDOc8tjmBLjGSqu064tFdw/oMDsDFz8zClk87ApnChNixEWMuEo7CRfZtbb
pWQp0fEKbQkYfeJtzkHD7y3AXucUn65Cr0udr42KEDYAIHTxHBbQ8yKEt3hdhJk6
f978PP9vkkchQ16BjcMjdkakSByc3hYK8uy1qeFebF0oW+jFOROw01dZ+41npplV
wrICfw52TjtXH/1fxv+pE9YUFUaHtXywxpJhYyxOJadW4SVoZAUxJEjegaDzxRdU
vkD35xceVQ7PHBSC7hbKuT1hdvpZSkzymJGnfpJji3WnjYvGW/40
=HWOB
-----END PGP SIGNATURE-----

tag v44.10
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 17:00:27 2025 +0200

rdma-core-44.10:

Updates from version 44.9
 * Backport fixes:
   * verbs: Assign ibv srq->pd when creating SRQ
   * util: Fix mmio read on ARM
   * azp: Overcome kernel.org AI protection check
   * libhns: Fix wrong max inline data value
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMYsQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZPqVB/sFvCDALNG+wsIpXAd0rCpb9Hnt51omNcFu
UrQHRCfo0Ewypx3lhBansr8tJqtATxrZoTWm6DDAtd8Mf+qBeCTzpG46bRPIkXQV
udS44RH7FuPuViaSp48NNS+C/GCA0WjGHPMJ4aZ/W20/WaJOxX+m4NrkDumKfjPb
IRbxBlEdpW/VUJLx+xJ4/KqFIvXCoz/fcfvM3PuVS6/x6iHejeBrBUOoRqhUk6Dw
6n1JJoN5dUs2rSTJLeu0974AwBjYPJce3iqyr3iodxEyPS11EEl8/FWBxD7Cp2Vy
vMW4tfFc3mzch53GxPzGB+VR/ElGcWRe0YWbSNPumHVbGq2Okj2c
=mXtW
-----END PGP SIGNATURE-----

tag v45.9
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 17:00:27 2025 +0200

rdma-core-45.9:

Updates from version 45.8
 * Backport fixes:
   * verbs: Assign ibv srq->pd when creating SRQ
   * util: Fix mmio read on ARM
   * azp: Overcome kernel.org AI protection check
   * libhns: Fix wrong max inline data value
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMYsQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZHyTCAC1yfgCbcr7ZQI4YJ5let7cKrwtkM6JBWEa
9xYGxHmVY7etkaBiB5r+Wer3PhyK8Od1da30VYg8Crl0nse0wnBhkeMEMiPztIBM
LIGuK4nyqDrE3SeUNd155tbCU1EjwScEBcYeOzUGvlXrfUiSFwl4q07n6eMYflOg
dITY86uZCP765Yy1mH8I/7ujlqNuBUgaEeUy9UmSp7vPJbWsTBqYwJDlsc9NHGVV
fnjN+uuoUX/9JX8jmp6psSHm8C1LltjbY1Kk4hGBRDLQqefUiVhYUFNXNjU7Zjhh
Y8AHwvbf0DmfueD3I4H7alNz++TXvF2zRt73ocASCJC0MuY5IccV
=b7wf
-----END PGP SIGNATURE-----

tag v46.8
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 17:00:28 2025 +0200

rdma-core-46.8:

Updates from version 46.7
 * Backport fixes:
   * libhns: Fix double-free of rinl buf->wqe list
   * verbs: Assign ibv srq->pd when creating SRQ
   * util: Fix mmio read on ARM
   * azp: Overcome kernel.org AI protection check
   * libhns: Fix wrong max inline data value
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMYwQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZKMWB/9nzhpVNkZn3X5zrJkkEIO8U6MhRYcpl5PT
9wU2HVlTwv3TI1U2u40qW0lLyKwU4gF/tHBCtIuckdZzwM1MsYf3t5NtmOcApVDh
3IRkmGsAssWjjxT2WgNODKDSTfBBUX09Nhg0e8XBUHMRUpddROs41yhqTHITn3mU
+o4vV2RfkbS04MXE91PE7Kj03SuEgCHwATfx2mQegwwkV0arIVxHzsbPOHReYZBh
hgdXo2lzz/8pcpeAqI58wBQL7gX8GM0cJfKTWN+G9XqVV9FVNHeXxqPiphe7ir52
gEbiQ/Kitfv46iFHzmzliq9LnIRY7VjudDuzU4F2oIi8uRjJwhz/
=HCvG
-----END PGP SIGNATURE-----

tag v47.7
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 17:00:29 2025 +0200

rdma-core-47.7:

Updates from version 47.6
 * Backport fixes:
   * libhns: Fix double-free of rinl buf->wqe list
   * verbs: Assign ibv srq->pd when creating SRQ
   * util: Fix mmio read on ARM
   * azp: Overcome kernel.org AI protection check
   * libhns: Fix wrong max inline data value
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMY0QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZEgDB/9k4NWYQhhJq6HVSVJyCWw2dLIAMJwyl3Wd
2RwFP1Ogy7WZqpmHmxjpULXZIn0Kw8EqPySE4JSjda4VGJ0nyjVRsYNLIfVEVuX7
2hCRO1r8/7ujIDPQYnd6pag0xp4H97jfSnUshNovK4ckirgCC9aEGx0y2gDFqj7t
XVHQDAJ5fnOvDfIECypSs+U6R+TNrq+YqdgwbElLIBk8srBC8nvKPYGuFRgQ3w2F
SRNuCDmmF0bR5SyUJ4fc3Y67J2AFE5pN9QthQwEhiUGgDKvqLkW3o6nHfSeG3+Hn
VY0UrSt3nqWlCucq6yOZUMVB5DuV8DfPNK+OswTkz2yajByv15Ja
=74bk
-----END PGP SIGNATURE-----

tag v48.6
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 17:00:29 2025 +0200

rdma-core-48.6:

Updates from version 48.5
 * Backport fixes:
   * libhns: Fix double-free of rinl buf->wqe list
   * verbs: Assign ibv srq->pd when creating SRQ
   * util: Fix mmio read on ARM
   * azp: Overcome kernel.org AI protection check
   * libhns: Fix wrong max inline data value
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMY0QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZBA1CAC0vayYJgxHd3t5TW2DlDFr9k3RQe+yG84S
2oqS8dGunYtvgG1nHUGi1WcQFHe6WhNAAo/oo3G/UyWz6+bOR0HZXJku5zPp3C3L
RcK3uGmylza8VFfmrM3f4kCw1OEtvgDBL9P5KX9PXM+QRmW4YnUZF51DHuxojBLn
QLrMPW/RnxnV++bwJVkiBZNnXzOE+WlSbNOZXocAXopDBGUr8BdUC63nwrt4OCA4
4ZGXmJ857aR838VxoM0ELMPyyItGRmndMloMdWyvUTpb63As/2FqW0lGS4t1gFSJ
Yr7qoQbT0Pl6HvuisZNTcur7PK9Mvx6ekGoZpja+gp4G/ATUQtdp
=GOU9
-----END PGP SIGNATURE-----

tag v49.6
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 17:00:30 2025 +0200

rdma-core-49.6:

Updates from version 49.5
 * Backport fixes:
   * libhns: Fix double-free of rinl buf->wqe list
   * verbs: Assign ibv srq->pd when creating SRQ
   * util: Fix mmio read on ARM
   * azp: Overcome kernel.org AI protection check
   * libhns: Fix wrong max inline data value
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMY4QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZNsXB/9Ec1RTRW7kFUBqy7nzAFOb/9reikDhMXHq
D/Hbr+WBcxJ6S9yMiVk8Qdz9tqWravDCp64pQFa33Iuxke4C5ZVp6bCUAGoVpvLC
cWler6KZ2clh7vjyF3HglrbNqxoY8bGjHSQBFZ7+sJoC7HXqRgZ/LWfvCazQFT26
blEa/zVKijKNH/8JJzi4zf+YXuI8shSiZR3IxeHmd2/d0i0kGkVarhhcpYPT7qu+
hrp4BIjxfWqXGtE5CHLtDRlN3hLTvyao7uRIzJ+1NCheB/nsXfocLVDneG1dEgIK
4kyaIj19GnAxVrfxv6OWpku/yDpRlIo4Kq5TtJglaTDY/YbIidRf
=XujU
-----END PGP SIGNATURE-----

tag v50.5
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 17:00:31 2025 +0200

rdma-core-50.5:

Updates from version 50.4
 * Backport fixes:
   * libhns: Fix double-free of rinl buf->wqe list
   * verbs: Assign ibv srq->pd when creating SRQ
   * util: Fix mmio read on ARM
   * azp: Overcome kernel.org AI protection check
   * libhns: Fix wrong max inline data value
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMY8QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZJHpB/9RulCT0KmZRYaKKCOwzB4B7ae3YEAQZcYk
lYY8gsmsE6t6ejtsIRY+qSRbOnP2H+RAvm3W9iJSW0fhV6iWdupEKgdYMa6V8Umd
asVzCRFRtAjgtD6gpoJOkRMCI1gw60L5Js7aXvSuYaPoKMhyrowm99CpGWcOXzdC
8D2oZDki++LRoZ44Tj18TUrysYb5Hnun/hiIecowtkwWgQkHycC4LQJF806W1lQx
1OiyMAoS315McTWqSyU/0V85jxRZTz+aVFHO3702rgfCFcWWE2yKlV9dh61ZvGXB
NmY8W03opzrCqm2jXMRE54046ChImpqlGRZlMM1TOybaMIdYhNXz
=se3G
-----END PGP SIGNATURE-----

tag v51.5
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 17:00:31 2025 +0200

rdma-core-51.5:

Updates from version 51.4
 * Backport fixes:
   * libhns: Fix double-free of rinl buf->wqe list
   * verbs: Assign ibv srq->pd when creating SRQ
   * util: Fix mmio read on ARM
   * azp: Overcome kernel.org AI protection check
   * libhns: Fix wrong max inline data value
   * libhns: Clean up data type issues
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMY8QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZL2xB/0dMy7wW0VbR4gS1w8A768AwHRQVjskib/U
t3kAeKpNEFFcZaZeylga/VHT/DFPmvFAiBeP+tC1BrNt+lF6eldqk1H9GnoIuCea
jPP79YE7JODFYt2bwCiWeZKwPtt4bw0zzUOvBF8L4FYF3LgT8R1xwq4zHgR8b2Tu
BSA2OQR3YBBd8tZ3QJliWrQ3gjJY/CNKm2I6BXhWqBeIByDmPXnDiWQEVpPprUpZ
PHJnptu6GzQcL7PfbyRRhCqxtmSbhmCK2MP7MQssNuU0Widf/fSjTOxWRBvuu+8o
WQaaOiWc8ea4gaps2G/e6FguwsrBtohsMbGNvrS3cUkNzLz6RcOD
=Fqub
-----END PGP SIGNATURE-----

tag v52.4
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 17:00:32 2025 +0200

rdma-core-52.4:

Updates from version 52.3
 * Backport fixes:
   * efa: Fix work request index double use
   * libhns: Fix double-free of rinl buf->wqe list
   * verbs: Assign ibv srq->pd when creating SRQ
   * util: Fix mmio read on ARM
   * azp: Overcome kernel.org AI protection check
   * libhns: Fix wrong max inline data value
   * libhns: Clean up data type issues
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMZAQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZG8uCACbukK1hHPzyvWoXsO9CnCp4Kw8lcSF8xTH
iARtRlJwB0HB0sokNeWGekcQO6Gwq9+h1X1HRmaVS9C3uvTySk75hDsicLNYZpOc
qTQu9q8hmgxs4EQH/bRI83BAVXFTu99rXd5FBwBExLhZtxWfWhquazIMVSXbmbFA
JemcqmCXeBxBtDgoBjEYCakFTqWdZJWMigaxSrJQFYSy5DcpiJJ9mWKR5/xvrvFW
B+mPj0nY3+gd9+nogXkSsiO3G27DpqXgtuQILLN1cOVunZ3qg0PK/H0DUCTp155L
V3XST4vvs65rubq+PFYksNdwc19IjFbFqyQ4KpsmAenO3eo2kUzI
=SbGW
-----END PGP SIGNATURE-----

tag v53.4
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 17:00:34 2025 +0200

rdma-core-53.4:

Updates from version 53.3
 * Backport fixes:
   * efa: Fix work request index double use
   * libhns: Fix double-free of rinl buf->wqe list
   * verbs: Assign ibv srq->pd when creating SRQ
   * libhns: Fix freeing pad without checking refcnt
   * libhns: Fix pad refcnt leaking in error flow of create qp/cq/srq
   * libhns: Fix ret not assigned in create srq()
   * util: Fix mmio read on ARM
   * azp: Overcome kernel.org AI protection check
   * libhns: Fix wrong order of spin unlock in modify qp
   * libhns: Fix wrong max inline data value
   * libhns: Clean up data type issues
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMZIQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZPR6CACix8CSSBUfYPjEr65MT3wjywGK7bPN4wt1
/rRLpHT3atHGDDp7JfzmP2u1fDbxEW3/nxcqPZP+Hmwgj3+awGB1NNN9DiPmxMD8
QFommlTuwKY/KTLEzQxlP+n/LF/aYAdYFeOGT8Lyw/lMgtx8YxQXqQrYWZ278IiK
OWVqUhrDHMSMeLsrchZ46av8lUOD7T7sUPB766srp688c5ShFbCYTeGBiHYfEamC
/wVZ+WEhEfk62d+ylLyEPecdVunz7JFXk99uojbNOCWytI/IcF7NMmkj6nzNxtoP
aKKgl4MW7USYX5Pd0k78qMojeeFTTPV7Sqvx5TZZ5DLWU1uy9lkG
=p/Rt
-----END PGP SIGNATURE-----

tag v54.3
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 17:00:34 2025 +0200

rdma-core-54.3:

Updates from version 54.2
 * Backport fixes:
   * efa: Fix work request index double use
   * libhns: Fix double-free of rinl buf->wqe list
   * verbs: Assign ibv srq->pd when creating SRQ
   * libhns: Fix freeing pad without checking refcnt
   * libhns: Fix pad refcnt leaking in error flow of create qp/cq/srq
   * libhns: Fix ret not assigned in create srq()
   * util: Fix mmio read on ARM
   * azp: Overcome kernel.org AI protection check
   * libhns: Fix wrong order of spin unlock in modify qp
   * libhns: Fix wrong max inline data value
   * libhns: Clean up data type issues
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMZIQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZOKUB/0SYgoCaxnsUzUHcjp7F+Hig/gYU3lXOJKR
pTzmgrsn60pdYVDqaUiZzaipYktOon7OxDZ9CmrbwICb2V5HeUgLH++fk1mfB/gB
2+8SsAcIaoa7YC9YfRFXLDhqQGH48lAyDh7eSyD074zjwlQDFH8Q5FGM18Ez1RFS
ox9pKQWZKRB8quVSBGwRVeMGKEUlLakgmhxAazBBIvbg8UT8bZlt05JPbjn37LKV
pCb4HhekdV3QRiFtzsRA1Vqn8fa/fdhTthvn88lYgRxYgZSkGhgiY2GASeVSDkRN
90a4WSZm8A63YKQ3jbIy8f2pKFNaBf2QyfsLrfjTeJRfVL+fPPJL
=icLq
-----END PGP SIGNATURE-----

tag v55.2
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 17:00:36 2025 +0200

rdma-core-55.2:

Updates from version 55.1
 * Backport fixes:
   * efa: Fix work request index double use
   * libhns: Fix double-free of rinl buf->wqe list
   * verbs: Assign ibv srq->pd when creating SRQ
   * libhns: Fix freeing pad without checking refcnt
   * libhns: Fix pad refcnt leaking in error flow of create qp/cq/srq
   * libhns: Fix ret not assigned in create srq()
   * util: Fix mmio read on ARM
   * azp: Overcome kernel.org AI protection check
   * libhns: Fix wrong order of spin unlock in modify qp
   * libhns: Fix wrong max inline data value
   * libhns: Clean up data type issues
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMZQQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZLg9B/0QV2ru28f+QOP0vjS0Ux86wWoWL/8jf7GW
PI59SVyDxo42r37POTemL1PUGPFeY+XmoHsMcrm/OI3sc+C5phxiGYQzVdeVhMMx
oOWhp2W8L54lfnzka88JeHgI/6O7HHiu9c+QgMEhIz/CplGLjVkHFOLY5Dl2jOkS
HpnBGPUhN6el5IT8H+7hUFTUqvOuVsjVhyeYHB15X4oSBJChu5m+BFCMQRpf9hnC
9a7mtnIvsEyymeKYg+x38ETUBCRuVZHxVvCWmRheBI/wRRy3LiszXtCAvrCrD9mR
4oFooHRQWDVd1cFBVItSj84RDCKeP33UXwxfk3eVD4R7gzrXIRfw
=Fgi7
-----END PGP SIGNATURE-----

tag v56.2
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 17:00:37 2025 +0200

rdma-core-56.2:

Updates from version 56.1
 * Backport fixes:
   * efa: Fix work request index double use
   * libhns: Fix double-free of rinl buf->wqe list
   * verbs: Assign ibv srq->pd when creating SRQ
   * libhns: Fix freeing pad without checking refcnt
   * libhns: Fix pad refcnt leaking in error flow of create qp/cq/srq
   * libhns: Fix ret not assigned in create srq()
   * util: Fix mmio read on ARM
   * azp: Overcome kernel.org AI protection check
   * libhns: Fix wrong order of spin unlock in modify qp
   * libhns: Fix wrong max inline data value
   * libhns: Clean up data type issues
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMZUQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZFR5B/4/L2QuVYydKuuRuX+IhTQExooM/dzMuaOw
hAe+VaUS1BAwQ1+y2GgS7epGDLoMrwx3s8LoG5ROxG8y1FxHuYm/e0vm2x1CtDmt
YRbELaqW5El0lyHxsLPvQjlTPOHgv4MmXhKUSkRVnI3CAoaBDws8eGOwYYqZSxZR
ts/Pz3jqzdPAaoA/+lL7FXGtxa+8Gj0+j8fl+iaoO7/yx1rFGEy0MKCsrIxyBQkD
mU6TieZotZjadrdtAU9VPd7bOAZOY6RZbpv+s3SzYmbW529njxssch+GXeFC0eX5
N29XMgVV0z3ejut5DER/j77DLy0r7iLTN+GVkxM7eZF6kowhyxfT
=/2qI
-----END PGP SIGNATURE-----

tag v57.1
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jun 16 17:00:41 2025 +0200

rdma-core-57.1:

Updates from version 57.0
 * Backport fixes:
   * efa: Fix work request index double use
   * libhns: Fix double-free of rinl buf->wqe list
   * verbs: Assign ibv srq->pd when creating SRQ
   * libhns: Fix freeing pad without checking refcnt
   * libhns: Fix pad refcnt leaking in error flow of create qp/cq/srq
   * libhns: Fix ret not assigned in create srq()
   * util: Fix mmio read on ARM
   * stable branch creation
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmhQMZkQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZMxBB/9mp+iBXmk8PQgDSVHreUEffx79Zx240F//
bVzTXN7hm0fNACKo36XSEcIE7yVWKdW1izeEcfTFV+RH7yX4R3bkjHfeGsKSQ7RE
u2SjH0yq4HlXELsw5F/RN236vYZRgNHEKb4YH7NpUVGSx9zsOgWfZe5ZuqE8ZMeg
jsetWQ3PJma6Mlcihh5Sl9MadDpjo3bix9xITbq7AP1BdgZiuuPMsg6MoMQgPxTk
pXi/LanwQa7y57PjCTRLeYQfsx72/HOkZSIKeB42fwRsm0Z7HiMgTuMdTmGiJXgf
j959YpoB8NPyHil2+XmRBcmZVvpfGJmWuFOITy1SgVQAT25XbRPd
=NQli
-----END PGP SIGNATURE-----


