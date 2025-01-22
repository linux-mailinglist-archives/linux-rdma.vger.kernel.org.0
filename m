Return-Path: <linux-rdma+bounces-7183-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84CCA19726
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 18:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A78160714
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 17:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A7F21519D;
	Wed, 22 Jan 2025 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YHProLX7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCA221516D
	for <linux-rdma@vger.kernel.org>; Wed, 22 Jan 2025 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737565593; cv=none; b=LnKfxY+tNtIjYa3SL/44BadgSfgsoO/tqINZCX7Av4kY3lLpHAuTUD4X0exBTohWrRfGQtFjqyBX550OdeWQfX3zYZP0KUo89gv1c5xxJfTJCoWp8V7GxiyCJNptqDLM4Ibx7xFcZ4gZ+OISqKfr4L9vh22/7pnRR2+b67mgbVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737565593; c=relaxed/simple;
	bh=qw0qxMBRKlkIRfWb/dR0tfkltaoNztA3/9jwv/jKaus=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=fmYoi0R51/L7xdlotYvNO0fG2GbBNOOlCOXb5MLRebrp7qZBT2uo7efbjSLSFT5lPwMcjEzgqlHT8go/8MsknT7FyJNHbfb+sRr37pDtsUASLu23k0VMUc/f/QhtA1y0HpbUXfmFyxHxPnCQMEwtVCNbVoQYaJ8FK7dG59fF614=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YHProLX7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43637977fa4so6567435e9.3
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jan 2025 09:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737565587; x=1738170387; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iCOlPhqxirb/PsK9rkuXKJ7Gy1kPmEfqZrsMHJkt6LE=;
        b=YHProLX7RLr5uEDUcJNJUD5eCL9wgGnqXMXhP8DQjy+tKNuSszujAPgZ1JQuMS42N3
         vs4qDT+zslqhawV279fxbWUkYGZ0qXNGEWLOUAk22P6MviqIohvWYmRQYORs4a2EsH+w
         mqCmWdZ3H89xdemfTFsm7dFWPQI7uB7kU0KYnRgaWOrrpMInJQsUJoei3NWYMJQeKju+
         GkCSNw2EsV/TCSKDaCug5pyNwgsYgX+85NfqDsIhiObutgqSYJSgIDZNaniC7FBM2kLE
         n54rxocrOEk6r8FNoCQC5AsN1fv4QaMaED/dpovHRlWR0vvkpumS9WZShTPmKmY9cmtZ
         66pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737565587; x=1738170387;
        h=content-transfer-encoding:autocrypt:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iCOlPhqxirb/PsK9rkuXKJ7Gy1kPmEfqZrsMHJkt6LE=;
        b=MN4/29ShWbge6k5P3X8WbSUaXIn4REyTOJhqNZWknv8I2TVFLDMI5rVSb9Rb5w2+xB
         5MBG+JMW3To7GE6RsNM92XHEnVJVi/VOOQWQ2eIOofD8ARP0x04V6gkPGFwm9KZRAXsz
         RiqoZHCDCwgDpJcAyzDVIn1x9Vo6Zfv8hoLNC24b7OAb9d0iUeSbtpMB6+f6zOL7O4Ch
         G5evX5PfHstaDDRSqRHgVwSs4RlQwxUkil1pu4MzdRJ+gF+/XV1fXxDbaWmR81Vncg0I
         yI3EpfSzrhlRyFcvprsdFQb+gunXFoeYuq/uf8qOHILajYBzSLYDfpTxwb1m6t9lQ0vF
         1RiQ==
X-Gm-Message-State: AOJu0YylLOQ/ytsotG8jSjS6600IPjULbmwRuqLzJGhZ/6PS0su0cn5B
	fdo7y524PsMGzAPUYHQSuJIhDdw/4zHrJt8Cy7t6667PRSBlANeQRbJAvdxgZX6+dEBuONlxYav
	I
X-Gm-Gg: ASbGncvBXfd6By606vNZ05x3+xuoYg4gvDrkL6UTc5C2K2RBvqs071EUnWTio7sw5wr
	2DpXomE/JzYRJ+dtvoeVV/7DZRbHOQeOXSOWt3DFeSRUyKTpAUT7kuuVGzNjntJrGaFYJe5YGps
	2SnBGEnvq6wcMSNS9z+8RM1JG523rFy2MzdwFJmHZBWtv4hDrWacPZo8YvB3J/d8vavtjj/h0+n
	BNlRiYx3KcAVWWq9jBGDnJPZwProE2ScoPgXdyQZ/lob79fB30dH1q1YqvQJ0O9OdFVzg5IBT6u
	kvkxCeNCjo0Hwhy5tk8PI+vAbWLTRmXGAo4=
X-Google-Smtp-Source: AGHT+IE+zcErq9MWbbf0M70pFZbbp0JTE0wUeccCQwKXcFCblTofzXrpYsofONUSQ6CQTM+pgLByPg==
X-Received: by 2002:a05:600c:5486:b0:434:f335:aa0d with SMTP id 5b1f17b1804b1-438913c7b31mr83672925e9.2.1737565587218;
        Wed, 22 Jan 2025 09:06:27 -0800 (PST)
Received: from [10.0.2.128] (anantes-658-1-22-71.w83-204.abo.wanadoo.fr. [83.204.15.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31adbccsm32935925e9.19.2025.01.22.09.06.26
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 09:06:26 -0800 (PST)
Message-ID: <2944de63-7b14-4886-9474-fa6a42c3eecb@suse.com>
Date: Wed, 22 Jan 2025 18:06:26 +0100
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
 * v33.15 (this will be its last stable release)
 * v34.15
 * v35.13
 * v36.13
 * v37.12
 * v38.11
 * v39.10
 * v40.9
 * v41.9
 * v42.9
 * v43.8
 * v44.8
 * v45.7
 * v46.6
 * v47.5
 * v48.4
 * v49.4
 * v50.3
 * v51.3
 * v52.2
 * v53.2
 * v54.1

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v33.15
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed Jan 22 12:15:49 2025 +0100

rdma-core-33.15:

Updates from version 33.14
 * Backport fixes:
   * buildlib: set a proper name when creating a github release
   * libhns: Fix reference to uninitialized cq pointer
   * libhns: Fix out-of-order issue of requester when setting FENCE
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmeQ02UQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZKO/B/9uILthSAWw7Y2Vp0m+faytauSQwmJLKHDW
DeCsw2PEa2SVE0R52w76xk3t6StgG76TAVD686dhwvNWlMad+KjRpGpAoZT/xUNH
uQ2tYB+1l4Qfsq/wkY07cT/Pw/vbPMuou/VgnI554jgMIcIWLZ6ptz7vXq/Wln3F
TH9ikPbPeKos+S3T2yF4JPJHyIK26An4PHMGpYzI8tY84Id4XlakeYECLM/auFcN
OSqpiXbCytY8pzAdep6cdIPHtI3VsrjqoQZJQYepNgYrdChQoWiBl8uZmy6YNhS3
b7wFNZs/R8IAxjGAsrpk3g4JZPRHza/wwOfGLgOvBjOILklBAfGS
=G0Uz
-----END PGP SIGNATURE-----

tag v34.15
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed Jan 22 14:36:14 2025 +0100

rdma-core-34.15:

Updates from version 34.14
 * Backport fixes:
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmeQ9E4QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZG7QB/4yJGB4HUORMj7ec1XzaP7HDeAnvock+nwX
qC7oVVNZ4GTV4Pk4DWZ35rFfvS2PYn9+E0Pv/z61TJL3k1swvP6FPqe4fGulWH1+
OLo50dNkbqS6muGXSlWejy+s1tWvEqMwdZ8riZopXGC6ECoXRnj/WerJP6WIZPVG
eQMP4fcRtTsS/Xg3AXolgUWqmMl1mN1tqw9FaO3B9jhkvlOEH/rAyVhx+fEwkbgb
L7egskpsUtmaqavTzPyCV7V/dDPvXDHDnV0Dz4pF/umpTYYDLS5KVRlyphvc+v7Q
bbRHqE+iyDtXLm9WlDJGO4ZQ03wAGca/3dsS0AHJC6q6SVnOK7uu
=A/Ug
-----END PGP SIGNATURE-----

tag v35.13
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed Jan 22 14:36:19 2025 +0100

rdma-core-35.13:

Updates from version 35.12
 * Backport fixes:
   * buildlib: set a proper name when creating a github release
   * libhns: Fix reference to uninitialized cq pointer
   * libhns: Fix out-of-order issue of requester when setting FENCE
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmeQ9FMQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZAlRB/9ln227Bg37ypIR26qoESF2e1PFEYUfEB+u
tfLCcjE/pnfjxoszG75MpZassEOTd+Z5lRT+Cqn3qlcQjJy1ysZVjMgv1G6BJKj0
IPGUshcH/9y2/LokTg7UmoIspDt+j5pycW1c7mJC6+gyZS5hD4u1logY/c8pd518
Ndi/rteJWnl8TanFPipb1fIFG3VK0Ong88ul5bMPm4yUjOzevmo3jiJ73oV8Zq8M
00ZurnvMO8Xn8CJx+IBpQeKnczrVr89tg1Ta32rDb5U8GdDlCVuPRJKYBSgIUhV1
v6wh77RCemWBeDVWg2/UkU11OktAkkpqGMOeo01AqDrHY7eUSOpt
=QZkV
-----END PGP SIGNATURE-----

tag v36.13
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed Jan 22 14:36:19 2025 +0100

rdma-core-36.13:

Updates from version 36.12
 * Backport fixes:
   * buildlib: set a proper name when creating a github release
   * libhns: Fix reference to uninitialized cq pointer
   * libhns: Fix out-of-order issue of requester when setting FENCE
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmeQ9FMQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZOylB/95ZJLpZWIAG3wSctuhOaV+vxltF8Zl/Ow5
+Zlfe1yHBOtB8Ug18iDXI9zMurDcdq1rPIYr+1apV7WMRkwdhnOazJvmr0yONs2L
J7y9eKQ8LYoI4y7R4SdDK4ugujT0FiHW4iFnn2Yar/0xzKx0U3bUjvoQXbbZrol7
cNB/T/1llDfxrHvNcEiU/DlDyqoGmjoqAZxoe6TuOTXKOEm8ECJSnVRQX4a44ZVH
NEDSalRry4sy+4lsLukvA1HKmvFROQGww+TaL6spyq1vzt0NzhSFgjVIMHoJSV9U
oiHHP4AOnjh6Z3ck8v0TGC11yOQipRVA6RVS0VvjisFp1raBbSQ2
=laOr
-----END PGP SIGNATURE-----

tag v37.12
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed Jan 22 14:36:20 2025 +0100

rdma-core-37.12:

Updates from version 37.11
 * Backport fixes:
   * buildlib: set a proper name when creating a github release
   * efa: Change resource deallocation order in QP and CQ
   * mlx5: Fix the license disclaimer of mlx5_vfio.c/h
   * libhns: Fix reference to uninitialized cq pointer
   * libhns: Fix out-of-order issue of requester when setting FENCE
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmeQ9FQQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZCgaCACUwrQ8BNKmBOCUs6NIF4UzQOPuhm7VJcC1
yBki29wnZZYvywquu4LlOVdzbni1KtY9vDsv4nmLVWGIxPRbN+Ckj6Ia1QZbQwn5
S+vX4Ye90FmVXhBVuxQlrPBI3Rz6zybaoadIaYk3Bl96YonZs3diuseJ2zdGr8BH
HEHmQq1AIsWQoC8rDONnzC0C5ehPHwv8wfneTUlsXryjOFn4oSZoqA2hbLehhqNL
IDUeKXHuABGjclmRu5gWBfAk+8Gvtc8+i3Ym2HiVwvmeLQaVvS3sTZDaR0I+KO1I
8JZRndhtjuld9HGh8DOjTp07/PG/FfHLV71xVAARWbl5ip4CSkbY
=PxjZ
-----END PGP SIGNATURE-----

tag v38.11
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed Jan 22 14:36:20 2025 +0100

rdma-core-38.11:

Updates from version 38.10
 * Backport fixes:
   * buildlib: set a proper name when creating a github release
   * efa: Fix CQ doorbell unmap on CQ destroy
   * efa: Change resource deallocation order in QP and CQ
   * mlx5: Fix the license disclaimer of mlx5_vfio.c/h
   * libhns: Fix reference to uninitialized cq pointer
   * libhns: Fix out-of-order issue of requester when setting FENCE
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmeQ9FQQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZGniB/47TjiAjAYrawC6+iO766OGjvo0RAIUPSKs
96eDwWhHC05T8uDoqUNJ7pa3E5SHTyRFCZWLiv0A9hG47nVZPBkiNwd/5b0beAT2
nONJKZdjehRCtZ3x6PvRNlKmxubAZ8ubJCSavT9dY7QPU6Wps2Q7hd3h3seJyPqR
sE6QHXWtcyoAy6yeZu0AbUON+4dJUv9kqSFC8Cppq2+nBMdO2A2/qUNBso87IxrP
Yac+9EMYVFvk0r+ycj810L4h4BYdzYC6hioRZPSsth+U0f7mNZU1KguFxJTb8oVJ
S95y2pT2t6AF8qBCiTVvOxCxmvfQWikWHlOrxn8zsJ//cWimg7Nz
=MkBQ
-----END PGP SIGNATURE-----

tag v39.10
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed Jan 22 14:36:21 2025 +0100

rdma-core-39.10:

Updates from version 39.9
 * Backport fixes:
   * buildlib: set a proper name when creating a github release
   * libhns: Fix missing fields for SRQ WC
   * efa: Fix CQ doorbell unmap on CQ destroy
   * efa: Change resource deallocation order in QP and CQ
   * mlx5: Fix the license disclaimer of mlx5_vfio.c/h
   * libhns: Fix reference to uninitialized cq pointer
   * libhns: Fix out-of-order issue of requester when setting FENCE
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmeQ9FUQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZHbnB/9ceOV0KjMVgQ6PtqDzNxVM8Wz8KXZrGfoC
+8LhPFeYc0m4m7JvCr+ZsZyGBMMXxLnAUKYzUATjSUdeASFd3merNDfdBP5iRiMz
OA6IsdhpTpE9IZXLRYhsZaM0E6l2MCG/8NACsoELsg86Wb35ECDO2GmpM8OICQS1
pFITS3ykrCDwWltC7Bmq/xiuFu2psJhqNgSbNEb1UHHn86K6bBpA7mYEbHTuiV2r
iaHqFwUiaXBrRjEG90Ywyh5SG+DtWv7RpnOCGCWZ1tcR+Cs4Q17tCylxkOq0PEsr
+/Xnjybvl8QnjbIPMQV8doSKh2pwJx0dsbsNS0uAUgG6MyP/gjzH
=XDEj
-----END PGP SIGNATURE-----

tag v40.9
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed Jan 22 14:36:22 2025 +0100

rdma-core-40.9:

Updates from version 40.8
 * Backport fixes:
   * buildlib: set a proper name when creating a github release
   * libhns: Fix missing fields for SRQ WC
   * efa: Fix CQ doorbell unmap on CQ destroy
   * efa: Change resource deallocation order in QP and CQ
   * mlx5: Fix the license disclaimer of mlx5_vfio.c/h
   * libhns: Fix reference to uninitialized cq pointer
   * libhns: Fix out-of-order issue of requester when setting FENCE
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmeQ9FYQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZDApB/4vQpqeEQMXYAe6GqmY0Px+4eIKFPRPiIsJ
Mp0ne6gWty/5XLmYcOh8ldWEULOM/TAtylfvgFAPUImRvwIn+YMMuacH4rlNMRXn
nQQgwO3228xCthH5ioNS8q9tr8Z09L3jG/1zoAf5H1E+mIni5GX/iIm41ASMHgX+
tCUl2Lb80Ck9oFZmaFotaa75L43qioNy9lBcvX+g6lPszOenX67v/oza1UMxH0jp
tPqDXZMaoDZUPYYtL9XheYkTcqvjS5xoPcEhPE5gCYOjBCWLGwO4B0v4kpl+XFZ4
OQFZGli9KTkPiJnUOXSZMjl/QKeBcVOHYIXT4HeFb6gCu1Y4z2j+
=mNLs
-----END PGP SIGNATURE-----

tag v41.9
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed Jan 22 14:36:22 2025 +0100

rdma-core-41.9:

Updates from version 41.8
 * Backport fixes:
   * buildlib: set a proper name when creating a github release
   * libhns: Fix missing fields for SRQ WC
   * efa: Fix CQ doorbell unmap on CQ destroy
   * efa: Change resource deallocation order in QP and CQ
   * mlx5: Fix the license disclaimer of mlx5_vfio.c/h
   * libhns: Fix reference to uninitialized cq pointer
   * libhns: Fix out-of-order issue of requester when setting FENCE
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmeQ9FYQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZJlxB/9dSbquRuKqyS092GKS5IGbb67ZGxok14un
8dHwxeRtHom5AJB7UzHliMDgoImPSyVMSP2yIiPqMqPnic0zR5zCUrEG0QfWNjKj
zxnufnb91TOxWacx4L9KfIuO82AhTripxcLTfSM8wW41wmooi3PjmRNwTWCdGMX5
gTlB95wl1N89okAp/g66/KS+p82Mx1042zjPqYNZM5pi53/Uclbzoti61/s0G/KS
EiOUmOCtWgC+vPEIOjHq+9ZqL/YHbH8BAOHBnF3tEqyTEFCw0kfI+RG7BY5WQvf5
8jULcC6DOnpWibBsa36ytTAZscbMv9bZoZ51KUNpzokO0UFVhdcX
=sOPQ
-----END PGP SIGNATURE-----

tag v42.9
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed Jan 22 14:36:23 2025 +0100

rdma-core-42.9:

Updates from version 42.8
 * Backport fixes:
   * buildlib: set a proper name when creating a github release
   * libhns: Fix missing fields for SRQ WC
   * efa: Fix CQ doorbell unmap on CQ destroy
   * efa: Change resource deallocation order in QP and CQ
   * mlx5: Fix the license disclaimer of mlx5_vfio.c/h
   * libhns: Fix reference to uninitialized cq pointer
   * libhns: Fix out-of-order issue of requester when setting FENCE
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmeQ9FcQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZEH6B/9b3z5IGS1HFpJW7hYq+NY3gusvHQur29l/
Ofr3EMm5kXj+1BPOeb71cgdi20Mp3LkqkHHyUDQXqxvDTYRLaOeIR0B0kIJ5yVYI
MiNBDvp/49J+DiSZE7bqHNvFMzfjYR3tAaMknPYT3Mdy21lacgEdhZKO4A9C0FKG
PpaU5RQnh0U6r1/qu5AiRtY55VhA4Hm3Sqt6ErPRGuGm3Tid4FSLhHbWDoaNoLY6
JAX8RtjYq36Cralukp9UZ3hSBtT+erq3Z7gjKK6y3OHjx7XEYf1ZO2Q8DGZKRuHX
gjV0rvyOpLRWspeXy73yVxxYkBTnJTNN+o7grOqi4ImnMnB8byiL
=4TD0
-----END PGP SIGNATURE-----

tag v43.8
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed Jan 22 14:36:23 2025 +0100

rdma-core-43.8:

Updates from version 43.7
 * Backport fixes:
   * buildlib: set a proper name when creating a github release
   * libhns: Fix missing fields for SRQ WC
   * efa: Fix CQ doorbell unmap on CQ destroy
   * efa: Change resource deallocation order in QP and CQ
   * mlx5: Fix the license disclaimer of mlx5_vfio.c/h
   * libhns: Fix reference to uninitialized cq pointer
   * libhns: Fix out-of-order issue of requester when setting FENCE
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmeQ9FcQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZGeRCACfXdag3Bt5xAX3mz/qopXtWwdoQATyx95M
n2NNonXrSiNo7AJrJcNO2MED5lguuApwcxQTopQ662WyXhhCDjXOtbEhNrXL8Fet
Vu9R5oRooS+JErZvMnY0EsdIhRYxAl8ubSpxXiKVG99uN5tQgk6pvvOEKiiz7LQJ
1C2QPKmbdOoohlpmDSOFKUovhbtc3cBPYXubRc8WU7zgGMn2bDqcfYsmVTvpQySz
lS9zFbDH1hJMXPjLvDkOa94cWCEmCY17tsI4fHJn2JC/b+uFvqdoKqIxSRXYoGVj
1JA8aYuvBswy3pLruw8cRCki0UooKdYAwMdEJgHdaA002L2p5fMD
=usYI
-----END PGP SIGNATURE-----

tag v44.8
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed Jan 22 14:36:24 2025 +0100

rdma-core-44.8:

Updates from version 44.7
 * Backport fixes:
   * buildlib: set a proper name when creating a github release
   * libhns: Fix missing fields for SRQ WC
   * efa: Fix CQ doorbell unmap on CQ destroy
   * efa: Change resource deallocation order in QP and CQ
   * mlx5: Fix the license disclaimer of mlx5_vfio.c/h
   * libhns: Fix reference to uninitialized cq pointer
   * libhns: Fix out-of-order issue of requester when setting FENCE
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmeQ9FgQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZICUB/0cVIW0GXwTZgpozqVJ3q34icK4Y7twlYrP
c11X8wdNJGt8aFkhmS/JtZHzLuYVY9JvrOykI1nqIsOS4fE8Lt8mkw9J5WQl44tN
ZpNea7cDKyM21FK7XKRlAdVgqIwJSe2q6zOpMwbojsx/HgWgMMjBRIbCoegFX3FG
yxmgA0aqIn9IU9ycb7a0+5C9rMWNnRhltaHHbbK38yrseSjHrtBMbuNA4HscS/GG
bwhYCHrn+1jZZ1tqfp3Y+ZVOpQ5j84r6WdcSTiwvE2CvPm37790JM3RBYJa2UT3U
nu+X582z/NtrJMeUSFraMSNrztTaniaUKWY+NBtVEbw5Id6eiZdG
=B8+P
-----END PGP SIGNATURE-----

tag v45.7
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed Jan 22 14:36:24 2025 +0100

rdma-core-45.7:

Updates from version 45.6
 * Backport fixes:
   * buildlib: set a proper name when creating a github release
   * libhns: Fix missing fields for SRQ WC
   * efa: Fix CQ doorbell unmap on CQ destroy
   * efa: Change resource deallocation order in QP and CQ
   * mlx5: Fix the license disclaimer of mlx5_vfio.c/h
   * libhns: Fix reference to uninitialized cq pointer
   * libhns: Fix out-of-order issue of requester when setting FENCE
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmeQ9FgQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZKedCACRLj7DZ52Y6QFVTzbzLbbd9ZrRMqn7lHH5
+rweKdlT6whtgt4H4U2f+k8nHpPW7Q2aPKj3x3DXai3fbg5z2wV7Hgm/PbvZdKt8
tSIfZTMLfMgRQ07Ge8XB2hi7VkIxQCEldorzKE8zkO2WS+uAYCeIA7Ld+3i7994q
sVLvprljD/L38jXpxbG757rPxtAS+N+GHnYGEDTFl6fRPIm5i7V3Lf/q1/zGlbco
Knbf2MkgzKHwtBD5CRIosC9fvikF0NzqCB/ekyEv4QWjWbAaPJC/0mvOqd+aDS0W
8jFEwiG0OcWQiIJDUL5LqyyNIb5cXgICYHuH5/vHFO03CnG9xVDu
=TUzd
-----END PGP SIGNATURE-----

tag v46.6
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed Jan 22 14:36:25 2025 +0100

rdma-core-46.6:

Updates from version 46.5
 * Backport fixes:
   * buildlib: set a proper name when creating a github release
   * libhns: Fix missing fields for SRQ WC
   * efa: Fix CQ doorbell unmap on CQ destroy
   * efa: Change resource deallocation order in QP and CQ
   * mlx5: Fix the license disclaimer of mlx5_vfio.c/h
   * libhns: Fix reference to uninitialized cq pointer
   * libhns: Fix out-of-order issue of requester when setting FENCE
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmeQ9FkQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZAfHB/9OngJpAUnOQOe+RZthspkb2Oo2Ida7c/dM
lWZJ15UeMshEF0+tk9LNCrkWHvvPOT8XkQA730gq02gYzymAlStPLxxq+H33Ur8/
fKGGLKUQNcnZ3V/WBPLewXZGO1wdjCndLabdEXhPEfxCUtU3IIZMga0bHnkFqEA0
9YobuJur/H9DLPCYRidbZNokoT+oJXXsMgIAwIkedTPmRVmUO8wONvQH7LMkMdau
87sGWojCbauOTGuSLqhNxz09lD4RDW69wWigR+W1ClD8KlH69KZ5aOMihW2vzPz5
+kYYyBIgVg8H/iBLpOX2qiwKxeTlJpaoPh0L8LMrzIDgQCypDFs9
=crsF
-----END PGP SIGNATURE-----

tag v47.5
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed Jan 22 14:36:25 2025 +0100

rdma-core-47.5:

Updates from version 47.4
 * Backport fixes:
   * buildlib: set a proper name when creating a github release
   * libhns: Fix missing fields for SRQ WC
   * efa: Fix CQ doorbell unmap on CQ destroy
   * efa: Change resource deallocation order in QP and CQ
   * bnxt_re/lib: Fix the inline size check
   * bnxt_re/lib: Adapt align and roundup_pow_of_two helpers
   * mlx5: Fix the license disclaimer of mlx5_vfio.c/h
   * libhns: Fix reference to uninitialized cq pointer
   * libhns: Fix out-of-order issue of requester when setting FENCE
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmeQ9FkQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZBelB/wL7TyRKjSwt0jp9CMzrGNKwtf5eU+eJSTY
M/xv8vJARplenQy4Lw92n8EvZZo4JMxSyXESTtA7K2rotoQ9Eg9ARkIn95Q3B6TU
Gv+sZ1HaRJ9b3kVr+E+cKAbUQvnLe74fnkV6HzJeNGMhe2/L2X+GAb6sPGwjBrcL
zJQu5xGksPoz9DCF/mhDiLDwQ92QVI2iaysTjHTsfmlRM6K2sVs9c5jFl6l7Gg3U
uCkCq1BqHTB3IxKL/UsLnv1o+sJ6VrM5SBGcGJgbnfdiS35z6080OuA+ySNYehJA
P1HobqNdiXL/9rI5kGTfjWc4avw9BEUjDw6leNYCTOijIWO0UmSM
=USZm
-----END PGP SIGNATURE-----

tag v48.4
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed Jan 22 14:36:31 2025 +0100

rdma-core-48.4:

Updates from version 48.3
 * Backport fixes:
   * buildlib: set a proper name when creating a github release
   * libhns: Fix missing fields for SRQ WC
   * efa: Fix CQ doorbell unmap on CQ destroy
   * bnxt_re/lib: Fix the inline size check
   * mlx5: Fix the license disclaimer of mlx5_vfio.c/h
   * libhns: Fix reference to uninitialized cq pointer
   * libhns: Fix out-of-order issue of requester when setting FENCE
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmeQ9F8QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZNn+B/9+tTum/7nuy2lSzYIqdFh42FeV5FK050+5
+aLno7+s3QWZP4v8AfsIuVZ/SMcY8skbPv5uBzDwTW4N5WwOsXbG4ntS3Upv8RM3
hlnnPiE49RE+DnCXAwB8FCY7WAX3wHI931XIMw8gCOhgoMEc+ebfzmT/yj/1QvTi
b6rKk75XBocQKGNx7RumpNzdz5a3krqTjz1tJk4iEcoqtD9BjXCPrXTzLiWHMTWf
wahMgrkmx49yRshgEqCtXD8iKrnZc/LM9ujSkEiMuoJEhO3fpEd8+MD1Y0uu/Vx2
cfsreChr4OItWfXhI6rdOb5/hX8ESHEBsxX5GEXoxtrOM0pB/cDr
=XsTx
-----END PGP SIGNATURE-----

tag v49.4
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed Jan 22 14:36:32 2025 +0100

rdma-core-49.4:

Updates from version 49.3
 * Backport fixes:
   * buildlib: set a proper name when creating a github release
   * libhns: Fix missing fields for SRQ WC
   * efa: Fix CQ doorbell unmap on CQ destroy
   * bnxt_re/lib: Fix the inline size check
   * mlx5: Fix the license disclaimer of mlx5_vfio.c/h
   * libhns: Fix reference to uninitialized cq pointer
   * libhns: Fix out-of-order issue of requester when setting FENCE
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmeQ9GAQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZC8UB/48dJDl9gt1nsi0gvkUpAI9JgNFQmEtGDU4
/oi23q+UAw+9N4BUpFAqKRnIkiRNdtp3yz8T1kAbWlotYynavV0UYR+t1nRFY72j
qVRD2YQQn/uREH3uByp9poy5npAieZkKceU5jozJ1dd09JDuJ9lxzDBNPOzh5Zde
hDs+crup8iagrXubMEVmULBD7OkvVoAJ5OZxfnFoSkOsDKvixS3BuGy5vy6hlyng
eWW/xOHfWct38k/SmyctnzhQnSFRvDhJCaeVAx6Nd7d2RQ1rppaAmYa1ZKPOm6zg
zReBMJFoedPCRpkABWNuQgiRwakyO4hTP92jyp74vkusE0rm7JUp
=UBa7
-----END PGP SIGNATURE-----

tag v50.3
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed Jan 22 14:36:32 2025 +0100

rdma-core-50.3:

Updates from version 50.2
 * Backport fixes:
   * buildlib: set a proper name when creating a github release
   * libhns: Fix missing fields for SRQ WC
   * efa: Fix CQ doorbell unmap on CQ destroy
   * bnxt_re/lib: Fix the inline size check
   * mlx5: Fix the license disclaimer of mlx5_vfio.c/h
   * libhns: Fix reference to uninitialized cq pointer
   * libhns: Fix out-of-order issue of requester when setting FENCE
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmeQ9GAQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZIedCACnw1JNKvuya7HP7lhreekYT59bnQBfLP2k
6Vudg/BnorDxM+fNiDxMA6YibshyxKGTItWn3W4J3Dbm/ZzzO3qq5pU5Y8i2MP8x
p9mcB3NfxW/ef6E7CzU6qSAVnP6ANnbLyAd7U++ClVw1fm9K+hai29mblb+v/vjQ
XbGnpeK+SBp57L8uNCra/9Jnfzmon4iYeCnnif54UaCu/S943t+8R1FLCLpX1aCM
tJonGVaLt/DX9nz1TtIZuTknkfMaBktIJpmqwM0XpqOIfwvYZtkDydjoBlBqBc3K
XGxM4imtcKxOEBK19RsIEwgSctG/0nq+fdEvRf8uMzim46vJslL8
=js/s
-----END PGP SIGNATURE-----

tag v51.3
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed Jan 22 14:36:33 2025 +0100

rdma-core-51.3:

Updates from version 51.2
 * Backport fixes:
   * buildlib: set a proper name when creating a github release
   * providers/bnxt_re: Fix memory leak
   * libhns: Fix missing fields for SRQ WC
   * efa: Fix CQ doorbell unmap on CQ destroy
   * bnxt_re/lib: Fix the inline size check
   * mlx5: Fix the license disclaimer of mlx5_vfio.c/h
   * libhns: Fix reference to uninitialized cq pointer
   * libhns: Fix out-of-order issue of requester when setting FENCE
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmeQ9GEQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZBo+B/0VrtWYk5mOm5rxC3AF+dKOn7HlsynZUHXC
P5cAu/j9yc1d3W/b9ozPmK4Tr1CLMjLd2Y0otg/xB1VsG4JaqSRf9Mcu0FD+oeZT
NIO7NWREGsqKrEyV8Nk6Puewvs25kq93pfD0QhLO6k4inJFL0p+ZbiCZWcem7h2n
XHW8EX64rFBm5QzB8/XM+h30g4R8iyh/cF/baQ1SaBhdWKYnnSwB7jT9Rvswe+aa
EnAZ661JxsMqpc1F888niR6O94SHEpLB3JRSJi60z0AKAlfNPmF7dj/EgwkmnOfS
27D4hpwEmJDU6CAguZPzp54LoHrahCKhmqPV4nmITyT2ir8LEGkX
=bW3f
-----END PGP SIGNATURE-----

tag v52.2
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed Jan 22 14:36:33 2025 +0100

rdma-core-52.2:

Updates from version 52.1
 * Backport fixes:
   * buildlib: set a proper name when creating a github release
   * providers/bnxt_re: Fix memory leak
   * libhns: Fix missing fields for SRQ WC
   * efa: Fix CQ doorbell unmap on CQ destroy
   * bnxt_re/lib: Fix the inline size check
   * mlx5: Fix the license disclaimer of mlx5_vfio.c/h
   * libhns: Fix reference to uninitialized cq pointer
   * libhns: Fix out-of-order issue of requester when setting FENCE
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmeQ9GEQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZP15B/9pU2T8GEW7s1GNBou8qqOasGEDSk+uhMyb
g4l1BDiT3WZC9g+PKBqH8jaN/HxwQ0PYZr7mgzXKS0/nugRcQgsyTrM3KutqzXob
R1iMRd6jgNHJ7XPPf7tMZj8kr3KME8ay9DbcXqRkyumnDcczSvR4hV3R2mCqaKHx
DPP7MKV0+Fw9jnI+3mA/NxnV5P54qB7kVfvenQDjR9hQJa+GZQe+b/N9LdjyHHvd
nIOGfj8tabT28B2WW92RGqg7elH5EOG4RilSbPa7LWBlBLdhgnPCtCxAlv5RPVe/
DudbFauu2f7tAXr8dFNFPFvJG256zQWlVFNWWYzRV3tAg29B5la3
=WHDH
-----END PGP SIGNATURE-----

tag v53.2
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed Jan 22 14:36:33 2025 +0100

rdma-core-53.2:

Updates from version 53.1
 * Backport fixes:
   * buildlib: set a proper name when creating a github release
   * providers/bnxt_re: Fix memory leak
   * libhns: Fix missing fields for SRQ WC
   * efa: Fix CQ doorbell unmap on CQ destroy
   * bnxt_re/lib: Fix the inline size check
   * mlx5: Fix the license disclaimer of mlx5_vfio.c/h
   * libhns: Fix reference to uninitialized cq pointer
   * libhns: Fix out-of-order issue of requester when setting FENCE
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmeQ9GEQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZPC+B/9AZTyWCgdRQ8vUp0iLOZcUwGpk/pE4bYfK
SHWFrKUP+yOTHHlyjxCOCRkuJWqNJ4rrrkHBuNpMk2njkZlasAJkhA6Crn4OcAjs
LO3Z9qHmpG3tjWyRDYWdAKM8e+RtSildnh8IenYgpyp7wc9EchpAEZVv2aIA4VOo
QgIEeeoXyafCLfzrR260UKhzOmBSuQDkfko692RDCc2shB0svgYcv5n7UAPTAEba
LlhoKp4IFMXeQgkzy3T1X3feicYzASSs5UjaGOcqJO9EGNNNl9u7k+BkxxoL2leM
q53TlvjKZ9hpXzn+wymMe1V33Cyjc41+N0OTd45S0N5UZsFn1Ah4
=jAZy
-----END PGP SIGNATURE-----

tag v54.1
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Wed Jan 22 14:36:34 2025 +0100

rdma-core-54.1:

Updates from version 54.0
 * Backport fixes:
   * buildlib: set a proper name when creating a github release
   * debian: add IBMAD_1.4@IBMAD_1.4 symbol
   * providers/bnxt_re: Fix memory leak
   * libhns: Fix missing fields for SRQ WC
   * efa: Fix CQ doorbell unmap on CQ destroy
   * bnxt_re/lib: Fix the inline size check
   * mlx5: Fix the license disclaimer of mlx5_vfio.c/h
   * libhns: Fix reference to uninitialized cq pointer
   * libhns: Fix out-of-order issue of requester when setting FENCE
   * stable branch creation
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmeQ9GIQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZBAeCACM+vQqA60VJpAeFGzVDb6gCZaopngG8h74
b9u/UDRWlEuLI1VwLeZKyIgxcoB2pu5vFYFJAUmenTFZhlnt1SMc9MCva3ky/hC5
dJo4Tlfetdl1su1ayvehY3wbCMgnnL20PdzXeYF6fH1VpQafE/m+O+9ILpSXFgwL
ukGBwUiDIysxxxD0gYlGEHFRY+G3LLafIsJaR8gdP6f9HYWac8y/a+HjgbVMAiuc
eKuRmz1wVM++ytydhlUrZHn9bcQs/HI5JZZlS0pnFXsadiUeXsaQbQAvQf6rdB6d
Y4Yc/tIxwBzAF8q50wdkocIOqrJe5T3RLZvAB9m+SE951Xoiq5Kp
=Z5lX
-----END PGP SIGNATURE-----


