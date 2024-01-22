Return-Path: <linux-rdma+bounces-694-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EF183717C
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 20:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E711F308A0
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 19:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDD65100D;
	Mon, 22 Jan 2024 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eiVtSFs+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2927651013
	for <linux-rdma@vger.kernel.org>; Mon, 22 Jan 2024 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948422; cv=none; b=K1zjcl1iYtJd1yFzpTzGew/3u2v/XkUR/4qOjTwoqoU6tF0e5MkJYoOvoWL3pLm6l+ms8NnNJZMCt3mVE9Qim/bBcV7lfLIRgsk+glwsBhWeweuInIYOeoNg+FtIUr8XTVE7qM8b3Bgdd5LAadEwFL30IWw8zey4OOG2W2oDraU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948422; c=relaxed/simple;
	bh=58Nujtjwcik/Bwe9mg3nsS5BfJyWWfhK5a7hBinO8TA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=Kn4dlqNHNuBecU+VYoUpOa90agHjriAnXV3VqxspkCfk2iIMc6hrWfxufPRpHZOn1njOI4vNjzRbEUJqloAGzpXZ+dt7631On/B0XwzKXkVjeg4S/3ExAwBJiLnHLPT3F0gNjxeXopTPGTTvG7mkuQ7XzIrShOIeT6kMHbBuL3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eiVtSFs+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3392b045e0aso1905220f8f.2
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jan 2024 10:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705948417; x=1706553217; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gGjm92VNMvI93WuJtzOQqJXQOMsD5synq7+rtmOAoJk=;
        b=eiVtSFs+R+0/T1s0k5UZrV06xnypn5CHe4v0CtNvQGsDSOf43NaJcGLA70PE/89SZd
         qA9ky+9C/PKIZy42V8vkyU6AdRRq1TtM+0p7cokDPUHJdc5DryR8K0l1uhHh/qSKlkWZ
         BPeVKtsgh00z+o8C4u2Pzr+XfqUDKLX0FuDx80nzUiqYlLZWGH7+UXAg2GI7Xut2GMtq
         3oYqyiwMWVWKe9t5obelpSGGPOTEct/7VpV7TN30IeQg25OPwk1O+ewj8O0fmZ9jo4AZ
         iLdgET2DqDzzRxGQMsqgsfwoW33e6ZTdlG+IYeC8uNjZaPwzZbwdMhfZtgAexpdkDVLh
         UZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705948417; x=1706553217;
        h=content-transfer-encoding:autocrypt:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gGjm92VNMvI93WuJtzOQqJXQOMsD5synq7+rtmOAoJk=;
        b=vJ10ceLkCl6d8ScuodTmMol11Sg6FHvFPt4IDAhyXg/3CvtdZdmZ76X7Dx2Nd2BJ3F
         LY3BVzWuMklvl6rK16joBjcAfD1lfdoSbCOM0AEoispVLQr5wavqvhVkZOLdpoFiFmuQ
         oP4QbZjtBaVQSVzWjQRG+WPVSDHfR2v2z4III/0i/8Zgb0HkYeUoiLwi6ctAkVB8nInn
         LC/jatl5Rt5snvdbYZEO7xEfs+ZBgU4oOrabuJQnjhvyMtDmsHdJGz4uFm6a5BFeMiFu
         cduvG4pjctqXUz2oyhixTEyHSvrNP34NRaXGLVmZY9yl/GEizXnNbFTnLr5K3ZJLMchn
         Rn+A==
X-Gm-Message-State: AOJu0Yw8Y3p8uvJOj+e248O5SeYAsIRGiUB3xlrPxOapSUL8Yr0Eqq1p
	yqGRPwwKmvFD9al7d9MTKykT6rjpNr6/AdYFZsAj9jjgI27/lMnRb881N0tp7vnjHmQm+WzPPzj
	e
X-Google-Smtp-Source: AGHT+IFqqGFAIVF39b/5SkTPYOeadpaHV+ApA4zIbRdelvuQZXp1WneyPiM86XHO9H5hatJCV0hpkQ==
X-Received: by 2002:a5d:4e0f:0:b0:337:c54a:1991 with SMTP id p15-20020a5d4e0f000000b00337c54a1991mr2798203wrt.77.1705948417160;
        Mon, 22 Jan 2024 10:33:37 -0800 (PST)
Received: from [10.0.2.128] (anantes-654-1-140-64.w83-204.abo.wanadoo.fr. [83.204.35.64])
        by smtp.gmail.com with ESMTPSA id c6-20020a5d4f06000000b0033930068ca8sm4615537wru.21.2024.01.22.10.33.36
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 10:33:36 -0800 (PST)
Message-ID: <8a4daa40-5702-402c-ae80-3f969ac823e0@suse.com>
Date: Mon, 22 Jan 2024 19:33:36 +0100
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
 * v29.12 => This will be it's last stable release
 * v30.12
 * v31.13
 * v32.12
 * v33.12
 * v34.11
 * v35.10
 * v36.10
 * v37.9
 * v38.8
 * v39.7
 * v40.6
 * v41.6
 * v42.6
 * v43.5
 * v44.5
 * v45.4
 * v46.3
 * v47.2
 * v48.1
 * v49.1

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v29.12
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jan 22 14:59:29 2024 +0100

rdma-core-29.12:

Updates from version 29.11
 * Backport fixes:
   * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
   * libhns: Fix possible overflow in cq clean
   * libhns: Fix uninitialized qp attr when flush cqe
   * ibnetdisc: Fix leak in add_to_portlid_hash
   * ibtracert: Fix memory leak
   * /sys/class/infiniband_verbs/uverbs0 is a directory
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMEQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZAHSCAC5n0oppCMuRdf+lMKeb61kPxBS/gD1xLcY
IyUI0YYSOLLQxsrjyp+2MUAPt36KvBRj5kFInZoXtYu9Gn38i4y+pBTXk08N4rri
GKGLRJxU2hkKytAmn813ocSVLrtIJiyQEl0qdq+O2PK0aKxiKy234ZOp7adMpweX
CWaC2g509QY6JUjkENaosA/+sXdSU1mwiEfY4J4xjjVaGcFinCt/pXHPAGeOE3sL
97M4Hitgk28Jqy44l08QYQ0y45hjdrGbY2GKP6iIpGgkHPwHI6jRKW0E0d877Ml/
xd38HqSAYJY+nje10Bn15qEFahNcj0D7U7rvtFaEVVIK+hLwqgtV
=s1mc
-----END PGP SIGNATURE-----

tag v30.12
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jan 22 14:59:32 2024 +0100

rdma-core-30.12:

Updates from version 30.11
 * Backport fixes:
   * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
   * libhns: Fix possible overflow in cq clean
   * libhns: Fix uninitialized qp attr when flush cqe
   * ibnetdisc: Fix leak in add_to_portlid_hash
   * ibtracert: Fix memory leak
   * /sys/class/infiniband_verbs/uverbs0 is a directory
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMQQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZIzRB/9CGxKOOIAVWpXiUVTYxEAygQs7rZpN4MYR
0h9aVswgLSZNpxb3UvmyCA6264s+6j2ZDheQ7UnPr/Zs16XLWq0CL0+qrWRYnD+u
F0VZSoz81lqadOA/9TNz3XLN6UBUkFRzauwb76WyYdOnsRHYDiUjwgqUhkMR9MTV
qYvWyZhPZro+1GItKD+FJ1g/1e/vtKzQzFEnHLv/AH2p5CgmBOFfmVgPYZZAdIjV
KVSMKaBbtNNjaV/A3996Z0G7251Zo9GIYHpKzuwk8U0cWjQzAKhdoXuC+UlQLrCN
rRh6u7p9cj2oZp/rGg5Z56/PbZCfPMLXqMXSb6AfxWwuwOd3yZtm
=GwHX
-----END PGP SIGNATURE-----

tag v31.13
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jan 22 14:59:32 2024 +0100

rdma-core-31.13:

Updates from version 31.12
 * Backport fixes:
   * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
   * libhns: Fix possible overflow in cq clean
   * libhns: Fix uninitialized qp attr when flush cqe
   * ibnetdisc: Fix leak in add_to_portlid_hash
   * ibtracert: Fix memory leak
   * /sys/class/infiniband_verbs/uverbs0 is a directory
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMQQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZBZuB/91A03upT+WfvFkV3ZDy4ei2pUJOw0EV9G0
dSRauUZgWkOb90hgFdFYOKSyq90ChyNhsDyqOVlEppBWgjr67kSjPjmR2pX8m33y
MYiU56o8c51XsRF5lGjVPuT8Qf4y8lPOizylVC9pN2A/Wtx++7sYOgs7pYuzFiQY
j0XId4u1w8XgtgDIcRKZwDpPy2o/fCoW4ps1q6nYI1BPXW+Y4B43ova0OUnGRt5Z
ehSUThcpOkRoyy3+058ylO+ZhSjEIbigy9RwVUyQebD4mmWwnhGLvmx/Cct930tl
g9oPPg2KZEplXtUgUAynY9r2Q69z1YP4phNcd80MJp+tlst6Dp9Q
=JVVd
-----END PGP SIGNATURE-----

tag v32.12
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jan 22 14:59:33 2024 +0100

rdma-core-32.12:

Updates from version 32.11
 * Backport fixes:
   * mlx5: DR, Use the right GVMI number for drop action
   * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
   * libhns: Fix possible overflow in cq clean
   * libhns: Fix uninitialized qp attr when flush cqe
   * ibnetdisc: Fix leak in add_to_portlid_hash
   * ibtracert: Fix memory leak
   * /sys/class/infiniband_verbs/uverbs0 is a directory
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMUQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZMXiCAC2dVGWr3MIZVJzCQyv2DU2cPzxnyKYyWcE
EhyIWMJ9vfpJxTHpSW25769c+6U0r3OBnx+ynGrzsqZSWweeASx1iVjFJ0RJ2wFP
eYsPEU9kTpb4fn1jjccl7VlBFaE7se99Thdc22yhOJ860JHOQGKFMY8rKFa0sTYZ
Vs4DBnj2A1g2AFwkNhaaJvY2F2mKT0khyTA2RnfuxVE33epcbwObU9XHT/f8tV5B
7uPSZCzaBUSgoKz2dHy+5wT0AXPK+73WsIpWK4KxhE2hEjC48v9GCQwcuHNSrgpz
y3UHWyotg6sh02qjjGc4NZMfXQxGEjE0GU/dTHUg6haCqYJWXDIv
=vxio
-----END PGP SIGNATURE-----

tag v33.12
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jan 22 14:59:33 2024 +0100

rdma-core-33.12:

Updates from version 33.11
 * Backport fixes:
   * mlx5: DR, Use the right GVMI number for drop action
   * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
   * libhns: Fix possible overflow in cq clean
   * libhns: Fix uninitialized qp attr when flush cqe
   * ibnetdisc: Fix leak in add_to_portlid_hash
   * ibtracert: Fix memory leak
   * /sys/class/infiniband_verbs/uverbs0 is a directory
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMUQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZDVHCACU5Mr8AQanuwreHd4+fBUhK30NVUlKcQbJ
eJ2CK28ZBrmZbIhPAzQBNqHL0TlIiDB5jshtYgYXXXc7qwIJNUSIEqTjnr7ijdTi
zTTW0lWrfOEh1pcqjDe9gPhGamjsCUzGNkTmGtiJpS7UY4ubgWeXgWVtUK5ttkn0
7TUvmZvpvhF9H0t5fNwpbyhtwCjRAidS3Q7bbDW609DrbF816/vT9CbpIHZ4q58e
WTBKuJhRt4+nG2XXqulqDilf1RmH0i+xNcaFwemKS17LY6wPn/e4zDXW9MrDaPkX
6Vz7h/8+kQdHmCcRdQ30vhI/utBJOH/zcopY1Od3Kp1lgW1P2TnR
=sIHH
-----END PGP SIGNATURE-----

tag v34.11
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jan 22 14:59:33 2024 +0100

rdma-core-34.11:

Updates from version 34.10
 * Backport fixes:
   * mlx5: DR, Use the right GVMI number for drop action
   * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
   * libhns: Fix possible overflow in cq clean
   * libhns: Fix uninitialized qp attr when flush cqe
   * ibnetdisc: Fix leak in add_to_portlid_hash
   * ibtracert: Fix memory leak
   * /sys/class/infiniband_verbs/uverbs0 is a directory
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMUQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZNugB/9G9bKbd7FJfbwTFvvi2mO/sioNJTHI88Id
hm5P7LriVQHLCjzO5PSCxBuK/quU40B4xS02yCUmvD6i0jIfwf7EUX1GiqC/JWj8
UXPhTOlKc3EngzOw7xYMHWq/mslGkN8CGwEjtNFVT7nec8XwC2Ux3ljetu7VIZB6
O1NeDHKkxSOeBljxA5GmLFqsehGjt54TcpT0cQhQuIOYfEMHiR7soR1NzJMNJ8/S
jTdEVrStatI6aXBXcEhgTky2mBeh8v2xZxOwqRyYTYzRxFKEHGNW7+t2UHTk3h/g
QJC9hFdh7ZwYC3oZOgXMFtwe785cesRuApcKa87OIayyT9TP+UUi
=qJA3
-----END PGP SIGNATURE-----

tag v35.10
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jan 22 14:59:34 2024 +0100

rdma-core-35.10:

Updates from version 35.9
 * Backport fixes:
   * mlx5: DR, Use the right GVMI number for drop action
   * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
   * libhns: Fix possible overflow in cq clean
   * libhns: Fix uninitialized qp attr when flush cqe
   * ibnetdisc: Fix leak in add_to_portlid_hash
   * ibtracert: Fix memory leak
   * /sys/class/infiniband_verbs/uverbs0 is a directory
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMYQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZAwjB/9ntUqmIEGnzNjPXr8izK9A6cYIqMFr8HAR
krfZiUDdvbMf/qSfmfYiHZMn6ymFl6tV8nJzLB9pxqNcfcdP5+4oF3B/XpKeMSmr
VRf0hmpXGEEk4c+DNhIfAI/xT9GJDoUt2oIRHiggBMab2Cg8YIkK/mru1J0J4XYr
HOaf7usRrcCMxvN8+aeffOPDFAVqEyNYMBEzxiukO7kVwg+fIXL8o4z8JgFN6USm
txxidSRaCdd9B6bTKT/Z08V0w3CVfp5x9NQlXnVKOf7aplye2q9FK3Ecq4Q7hCKn
Tf6LsgT3pO8vT749Iu1hm/cfecIvCHVoCyNVUBtIh6nbAJvUm4CT
=F8k8
-----END PGP SIGNATURE-----

tag v36.10
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jan 22 14:59:34 2024 +0100

rdma-core-36.10:

Updates from version 36.9
 * Backport fixes:
   * mlx5: DR, Use the right GVMI number for drop action
   * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
   * libhns: Fix possible overflow in cq clean
   * libhns: Fix uninitialized qp attr when flush cqe
   * ibnetdisc: Fix leak in add_to_portlid_hash
   * ibtracert: Fix memory leak
   * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
   * /sys/class/infiniband_verbs/uverbs0 is a directory
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMYQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZFk2B/9eyrpri4YlUMYjNZ8CWgdVGMbykmYDvNou
AlJDZqwu9vycAtwisO8kKG7N8OE+xD8QU5QZDrHdxMK5xMXt6Q1yw9utfF3n0vZ3
AbmfGiqWFWF/+WLD/HNIrgcfvp7Syq+zpYSNv/phR2VNUkvuy6zBzZYN/5Nw1rUZ
Q+LghjKKL5J87BiNVCPnbrCdSE8YpRleDFHUiwyvXY8LNoi+cAtO9nZUufn27hFp
BJL8V7J+26rJ9FFEcy/jbDoOKs6t0cAFMYNPJAyYS8ItJ19X8gaxOcwHt2bgztXT
1PWwz5YR1a8oTAeA9Gw3CW4R3u0MmnJC5/OKzM/0Dlw+KXnCV53F
=tJch
-----END PGP SIGNATURE-----

tag v37.9
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jan 22 14:59:34 2024 +0100

rdma-core-37.9:

Updates from version 37.8
 * Backport fixes:
   * mlx5: DR, Fix the default miss vport
   * mlx5: DR, Use the right GVMI number for drop action
   * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
   * libhns: Fix possible overflow in cq clean
   * libhns: Fix uninitialized qp attr when flush cqe
   * ibnetdisc: Fix leak in add_to_portlid_hash
   * ibtracert: Fix memory leak
   * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
   * /sys/class/infiniband_verbs/uverbs0 is a directory
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMYQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZFJRB/90dUmtu0S4ChgTdbEXU7ef6Xzng/TW8vW1
FEnwGwyCnIcEJtjPpsDj4D0WGiaZsJY5MTCYAAhx2n6ClCPgZMrMLL9UnMpCFBe3
Y52IDvxyuUwqVVzu7yHWrkC3I5g/HJWuaMm8KX8pRGpnfib12sYN4qR6kE0q7Gps
akLycBKI8WoPkM1oJCgZPFALiuOX1crscF27h931fDCwpzeDk96nRE7ERR2arCy2
LCgxIQ+jBrUW6uH3oq2qgHtxodz5DUYDzqBy8W7QEbBU1Hq9sC0wuDGW0pc+Cvg5
fp3XJkKmdm/Re7mG2c4gaMGmDbvFa7q+Le5cgYqtZw5m59u/PINv
=D/4m
-----END PGP SIGNATURE-----

tag v38.8
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jan 22 14:59:35 2024 +0100

rdma-core-38.8:

Updates from version 38.7
 * Backport fixes:
   * mlx5: DR, Fix ASO CT action applying in cross domain
   * mlx5: DR, Fix the default miss vport
   * mlx5: DR, Use the right GVMI number for drop action
   * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
   * libhns: Fix possible overflow in cq clean
   * libhns: Fix uninitialized qp attr when flush cqe
   * ibnetdisc: Fix leak in add_to_portlid_hash
   * ibtracert: Fix memory leak
   * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
   * /sys/class/infiniband_verbs/uverbs0 is a directory
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMcQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZDgyB/kBfCaDaTcL5z3yJB+yGfMo5AeJJTJlZFiv
35v06RV6vIsbkIZpOCVsK72FF1VprabhMuvK2g1/gsSpzEtIG834hH3CKvZbTVnd
/ONEQcERVGedHxqHenfma4shcrnUlWL7Us95RrpbRP/sptztq7P6zAHRQHAq6EGY
jFclCuuSIO2jDdEBkbZANvcCFUXl6JzpucLEDE0C+D5tQXB20Nhr0dwUUofb8zSv
JyqbLONxcHFHzbzt4bXm+2s7CtwMDfBszjpXoeCkHEIADjElY6mhUfcyV4QH6d57
U+YCEXwwlJa63wtCjUUmLcDPT3sXVTFrMeaHGZrQhCSLbomaa2GN
=H/zh
-----END PGP SIGNATURE-----

tag v39.7
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jan 22 14:59:35 2024 +0100

rdma-core-39.7:

Updates from version 39.6
 * Backport fixes:
   * mlx5: DR, Fix ASO CT action applying in cross domain
   * mlx5: DR, Fix the default miss vport
   * mlx5: DR, Use the right GVMI number for drop action
   * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
   * libhns: Fix possible overflow in cq clean
   * libhns: Fix uninitialized qp attr when flush cqe
   * ibnetdisc: Fix leak in add_to_portlid_hash
   * ibtracert: Fix memory leak
   * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
   * /sys/class/infiniband_verbs/uverbs0 is a directory
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMcQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZMjnCAC0oXB/dSOx3bpM2hl99C7hsrIfyUxprK7k
qgCgOPGNZOOm3jZ8jpijPwGLgwM/CA9TeZmbFuttP1KU+0TOJgrEJehM4hbpAvTD
1wbkk62AkA8GYVUpKEDmSVyCX3cIuvj2w3oxQvqi9FFt68FmLG7Hc5tHQU1IAA08
Qx1otLc7dVbmmotKdVyTOhp8eumSc5a564t5kdmE1lVIQqCMw+8kvF0fXT2fr290
fhaJY8FwrXkK4nDiK08z7vYGFlRednDBMyxny6Kkxi4n+wS/g6mwq+HOeSFmLBuz
4wPm6WFht2ITMY5btVRTxSu7lDBLgKDyH3dquUwSSqlEI2GaBEXX
=eQy6
-----END PGP SIGNATURE-----

tag v40.6
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jan 22 14:59:35 2024 +0100

rdma-core-40.6:

Updates from version 40.5
 * Backport fixes:
   * mlx5: DR, Fix ASO CT action applying in cross domain
   * mlx5: DR, Fix the default miss vport
   * mlx5: DR, Can't go to uplink vport on RX rule
   * mlx5: DR, Use the right GVMI number for drop action
   * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
   * libhns: Fix possible overflow in cq clean
   * libhns: Fix uninitialized qp attr when flush cqe
   * ibnetdisc: Fix leak in add_to_portlid_hash
   * suse: fix issue on non dma-coherent system
   * ibtracert: Fix memory leak
   * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
   * /sys/class/infiniband_verbs/uverbs0 is a directory
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMcQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZJ7jB/0bBeQbsw7cIwcRmf27IqdORqtf8kvoUFiw
dFep16JjJTZ1PDDgDl04aUeeDEhG9VTk5PmuvrbSRC/p/h+9adv8AZGmzJLZfmsz
BBGAgQ3gcjaUKh3GZYMSb5056FSjsAWGIa9+0SBV/bExVkZCtIs55hKW1wY951cl
dsiQJT7RGftBwrIwKOVq1zWQJnVkDlLg9Ef82pVKv8M5zJKAMs+cVDwLHnpPjE2o
RM5nmSSr2vioVy0PQuP9+ck2mnIKT60GryDMuUMSgjyZuvVEId5ISF7UtlC0MNJ2
lTg4lJGks389XVDbojWrDfEYzfvNWyEDPI7srMWaNYioZQz+YQPG
=z5S1
-----END PGP SIGNATURE-----

tag v41.6
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jan 22 14:59:35 2024 +0100

rdma-core-41.6:

Updates from version 41.5
 * Backport fixes:
   * mlx5: DR, Fix ASO CT action applying in cross domain
   * mlx5: DR, Fix the default miss vport
   * mlx5: DR, Can't go to uplink vport on RX rule
   * mlx5: DR, Use the right GVMI number for drop action
   * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
   * libhns: Fix possible overflow in cq clean
   * libhns: Fix uninitialized qp attr when flush cqe
   * ibnetdisc: Fix leak in add_to_portlid_hash
   * suse: fix issue on non dma-coherent system
   * ibtracert: Fix memory leak
   * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
   * /sys/class/infiniband_verbs/uverbs0 is a directory
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMcQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZK04B/0Wz8Y8EquLTpfBO91d/lLa4EFMHI3ev8km
mBNSIYQnJpcUSgFNJq2IvCHf2x2qX4FOvVknnBqpmgiBwsOwe8K42IVorYcVSOpt
ORdhRqPqorRnxEI/c1uOHK+RiKTOIQl2tc1CLeDD1X7PGl6efBAjh7zEaMmj9nhC
EXV6eq8jLBvB9svVVrczggWdtTJzaVUViZwpjeOHe44eSTNEdOMuSTB23jBI4NY2
A8t+DkcyxVKPs7anlvoLa3AWPtKp/xrs2YZbZcUW/dNgmzojsVgs2KpB7cjXzlUf
AXdjspNF0pRON/gqO24ypwNMXCSNBvXz88VZvWqJw2+gzjBfDd+5
=tzAg
-----END PGP SIGNATURE-----

tag v42.6
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jan 22 14:59:36 2024 +0100

rdma-core-42.6:

Updates from version 42.5
 * Backport fixes:
   * mlx5: DR, Fix ASO CT action applying in cross domain
   * mlx5: DR, Fix the default miss vport
   * mlx5: DR, Can't go to uplink vport on RX rule
   * mlx5: DR, Use the right GVMI number for drop action
   * mlx5: DR, Fix pattern compare
   * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
   * libhns: Fix possible overflow in cq clean
   * libhns: Fix uninitialized qp attr when flush cqe
   * ibnetdisc: Fix leak in add_to_portlid_hash
   * suse: fix issue on non dma-coherent system
   * ibtracert: Fix memory leak
   * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
   * /sys/class/infiniband_verbs/uverbs0 is a directory
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMgQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZL5FB/9NE1Rk+EQoRCKTEc5TxR99fDPPb7+Jhcvb
D5d+PtrggZbGb5qDLLm7Wt07cdYwsmWOzGhmbOQJXvJUW36R+qPPV0atIX8gd0QO
8GBe8ybBLrJrZyeQ9agh8Hh9FRvryrpInruH+LUuFm2Wu5cOiKiroJ2ZkBhtdVOq
TWt//ByVG0FdkkOF3dQFTpiXtJj0dNCCSfyycja0ufKZ8Wn6FC+OWhRVvxJ7w+zk
RxygZisVHEGveywKFejWMQZ8Gk2XjaJwUIllNszw9meGuGC7QEbXjC0WmSLbAaOe
gO2zTKh9rLBZstsa05gfaHpP2/8cDbmhysXv9OrFE2NUuu3oYl5E
=aaoI
-----END PGP SIGNATURE-----

tag v43.5
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jan 22 14:59:36 2024 +0100

rdma-core-43.5:

Updates from version 43.4
 * Backport fixes:
   * mlx5: DR, Fix ASO CT action applying in cross domain
   * mlx5: DR, Fix the default miss vport
   * mlx5: DR, Can't go to uplink vport on RX rule
   * mlx5: DR, Use the right GVMI number for drop action
   * mlx5: DR, Fix pattern compare
   * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
   * libhns: Fix possible overflow in cq clean
   * libhns: Fix uninitialized qp attr when flush cqe
   * ibnetdisc: Fix leak in add_to_portlid_hash
   * suse: fix issue on non dma-coherent system
   * ibtracert: Fix memory leak
   * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
   * /sys/class/infiniband_verbs/uverbs0 is a directory
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMgQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZDnRCACeYWyurhRjdQObfVwRe9D4jyRlD5kelgei
uA8dkC5iRC5Pj0099+lSkLQp7howArzql5/NZwf2KStifcUfms+6DfTf1iz2KVrP
rFaLA52IUi+e9P0i4rT4etS7QjnGq+lJjdT451aP6iI0i3Zt8Od7LMgGDzkSRgAu
Y+IQPhYT9bB8NdhaQcvF4zJFTg9wWUqXrDsr/v+YbMiZrkl//NehlTsNYeUEdQKY
ZrKd51nwnVfFQ4Yq+k7SiNHgf6+Xg4/aXZBuUHfa87UMPrUFY/NAx4wKSGO3GYbk
/E0etODeBx/Zmuv17Sj1lvGuXoataVC6x+rr6HrhTmw9TVGFjczG
=3Dac
-----END PGP SIGNATURE-----

tag v44.5
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jan 22 14:59:36 2024 +0100

rdma-core-44.5:

Updates from version 44.4
 * Backport fixes:
   * mlx5: DR, Fix ASO CT action applying in cross domain
   * mlx5: DR, Fix the default miss vport
   * mlx5: DR, Can't go to uplink vport on RX rule
   * mlx5: DR, Use the right GVMI number for drop action
   * mlx5: DR, Fix pattern compare
   * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
   * libhns: Fix possible overflow in cq clean
   * libhns: Fix uninitialized qp attr when flush cqe
   * ibnetdisc: Fix leak in add_to_portlid_hash
   * suse: fix issue on non dma-coherent system
   * ibtracert: Fix memory leak
   * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
   * /sys/class/infiniband_verbs/uverbs0 is a directory
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMgQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZKiWCACjEgkdV5atcQe8AqUMvEhrG5KGU7q824+E
8oRF20yh+5aHOrkotiq40qf6EypY/H0bBe7nhpLG31iqgyoZuSz97Rm7aSc7qi+h
CntG+MEoX8Ah0ZMJBll/Wfrg4Ps6W/+3dlRwtoEjbXcYR8g5yqFCQzZ+A21Bn1E8
jDrVSWsJgI7CKND8p+3UcW32zjWKGip25g+bvTBI1LFwNbFHZcHrIt6gNfRkV7GH
PBLJBvqzkKKcrvQH9CL420dBlP4yVu6vmdnDDD8wasGbRi/GuBFm4Ip67Utwf+Y7
2c/UqXrjuESnVYJRlnetqdJZO02WzqugEG1MAFZDdVp75bcqoET/
=Ja8k
-----END PGP SIGNATURE-----

tag v45.4
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jan 22 14:59:37 2024 +0100

rdma-core-45.4:

Updates from version 45.3
 * Backport fixes:
   * mlx5: DR, Fix ASO CT action applying in cross domain
   * mlx5: DR, Fix the default miss vport
   * mlx5: DR, Can't go to uplink vport on RX rule
   * mlx5: DR, Use the right GVMI number for drop action
   * mlx5: DR, Fix pattern compare
   * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
   * libhns: Fix possible overflow in cq clean
   * libhns: Fix uninitialized qp attr when flush cqe
   * ibnetdisc: Fix leak in add_to_portlid_hash
   * suse: fix issue on non dma-coherent system
   * ibtracert: Fix memory leak
   * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
   * /sys/class/infiniband_verbs/uverbs0 is a directory
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMkQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZC2mB/wP07duyCgE7/4n5txuVsREO/Ld1OlbOzsZ
/NI28jLRneJCzZDWy041eyMkskPkHTdDrsU2DMO1xQhwzyOhhxsSR0zAa+M4b6FM
tav0pjItquQar2/CoBfnJw11+w/0fWgvYiFjRzzjGN9vjKnZBFKTUNrpbRu+wT44
9PHyuDCjx/XKZYCGmA057VQXAYE2KKXvwFmaihfYctJ9IxsKEvR1TO+9QazU35ys
sR9r26fuCOt4kGnEV+/+MBK2fHyY30cJm/kfyNK4yvMNSPTRFUv0/f/wkvII6siC
cij2a+kFKsbCK5WkiuaxLeUlWIP7vqfhaVEKIX+lJPyEdazNPrl8
=mT8B
-----END PGP SIGNATURE-----

tag v46.3
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jan 22 14:59:37 2024 +0100

rdma-core-46.3:

Updates from version 46.2
 * Backport fixes:
   * mlx5: DR, Fix ASO CT action applying in cross domain
   * mlx5: DR, Fix the default miss vport
   * mlx5: DR, Can't go to uplink vport on RX rule
   * mlx5: DR, Use the right GVMI number for drop action
   * mlx5: DR, Fix pattern compare
   * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
   * libhns: Fix possible overflow in cq clean
   * libhns: Fix uninitialized qp attr when flush cqe
   * ibnetdisc: Fix leak in add_to_portlid_hash
   * tests: Remove FW reformat check for SW tables
   * suse: fix issue on non dma-coherent system
   * ibtracert: Fix memory leak
   * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
   * /sys/class/infiniband_verbs/uverbs0 is a directory
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMkQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZNCLCAC3QKML7EHfX9202F2CSYhaTN/1AsuYIKpo
UQf9s3rKmu4Fah4G0Cf1sG0jgUL/V0UC6yYCLA4hqY38yoZskC3jRdOGko1wblbK
y8AJmong9gIbQUWjDsFw24TLjgcV+DoFb3p719FjfhbuB+wF4oufEnDmkxg0b4Je
numgMI6kVwhyf9MPcIKAly1nA69OxLj59KOUwIUIOogJVWvdyLpeFemvEcLyMNi3
6aUvsX3FszboKjE2Ybsp3YOOa8A4rzkoZd7MH1lP8xggBya9+68ZcI68thep+jAB
UK3gdE9yKyMq+511gRNgvrJs/5rkVizCXy/WHK3CgZK8pJJQlBds
=4lp/
-----END PGP SIGNATURE-----

tag v47.2
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jan 22 14:59:37 2024 +0100

rdma-core-47.2:

Updates from version 47.1
 * Backport fixes:
   * mlx5: DR, Fix ASO CT action applying in cross domain
   * mlx5: DR, Fix the default miss vport
   * mlx5: DR, Can't go to uplink vport on RX rule
   * mlx5: DR, Use the right GVMI number for drop action
   * mlx5: DR, Fix pattern compare
   * mlx5: Add atomic/rdma read for DC comp mask to man page
   * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
   * libhns: Fix possible overflow in cq clean
   * libhns: Fix uninitialized qp attr when flush cqe
   * ibnetdisc: Fix leak in add_to_portlid_hash
   * tests: Remove FW reformat check for SW tables
   * suse: fix issue on non dma-coherent system
   * ibtracert: Fix memory leak
   * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
   * /sys/class/infiniband_verbs/uverbs0 is a directory
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMkQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZNFrCACljv8ZorgaLfpszpmEoIxVDwOpZCLE+FPo
fjmTtcegBjOVHXXqQsU6wIHdJJQhu0jfR+4+NEF3CD5k6QBPWgyiEtH+rHaLxwCm
Ftm7bC7tuDICUv74b/gvxM/O6P0aGzqS88bTQR8v1m/kT5JZBdrbXxBxIzGGOmBR
qicJbHRMF4aeil1z6tfK9T5gB+c23ZAMMcFHBzVpT7zY0OAJ7TcAZqExzk5ATAjx
nBDi+A+lN+D+c2nmtzq71CKfY8jG0c5SAl7/lOY4KAt28B8+mBsCbVu/yRoHlD1b
Ccl4no/p4OpF3hacfoycAyrueO9ZqZhnXymBqGRb91NPD7buWbpX
=t6Qo
-----END PGP SIGNATURE-----

tag v48.1
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jan 22 14:59:37 2024 +0100

rdma-core-48.1:

Updates from version 48.0
 * Backport fixes:
   * mlx5: DR, Fix ASO CT action applying in cross domain
   * mlx5: DR, Fix the default miss vport
   * mlx5: DR, Can't go to uplink vport on RX rule
   * mlx5: DR, Use the right GVMI number for drop action
   * mlx5: DR, Fix pattern compare
   * mlx5: Add atomic/rdma read for DC comp mask to man page
   * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
   * libhns: Fix possible overflow in cq clean
   * libhns: Fix uninitialized qp attr when flush cqe
   * ibnetdisc: Fix leak in add_to_portlid_hash
   * tests: Remove FW reformat check for SW tables
   * suse: fix issue on non dma-coherent system
   * ibtracert: Fix memory leak
   * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
   * /sys/class/infiniband_verbs/uverbs0 is a directory
   * stable branch creation
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMkQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZDIbB/9ZtEOh3EXYUZHN+X9FkcuQ7QKWIINO3XOz
/DeWHHht79OKhfP1pTlcu5Opnd9uMYmQdVJVPsvSj6wb/6Z+FQAOL/deVPgpsm53
9bljctQ8tWwvxq2ppEco1l4QBHdxWuUcP492D0gmFYc/epzScxho8HqwpA8YoR3H
Z84CVurNHYYYCfLuUHLjWzCFyoU3c2rbnzoq+HhhzxBMCa3sJDP4Qo7237IcxNec
JG0ddVI4LsWP+AubhOmcaYhImpUJgRzhlkD2S8kKCRGO2qXZfVK057h3vb8u9w9r
1un5djWq3swBqA6yjyiJQrDAaF52xEoRhb26J7Q6bCKqXGztqjcp
=YBdm
-----END PGP SIGNATURE-----

tag v49.1
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jan 22 14:59:38 2024 +0100

rdma-core-49.1:

Updates from version 49.0
 * Backport fixes:
   * mlx5: DR, Fix ASO CT action applying in cross domain
   * mlx5: DR, Fix the default miss vport
   * mlx5: DR, Can't go to uplink vport on RX rule
   * mlx5: DR, Use the right GVMI number for drop action
   * mlx5: DR, Fix pattern compare
   * mlx5: Add atomic/rdma read for DC comp mask to man page
   * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
   * libhns: Fix possible overflow in cq clean
   * libhns: Fix uninitialized qp attr when flush cqe
   * ibnetdisc: Fix leak in add_to_portlid_hash
   * stable branch creation
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMoQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZGmEB/9wYunI9Bw9ecBepSTyPheEY1hu/4H4gGDZ
uUAmOLQpgJMeBcAlj/joSbngEbdPEgnTLRk92Vzdno6/456Aoe64mdhS5h1orcrb
CLzwpUBqxAzt5++2l2TRSZrywWkci9jQoqBfA4wuF+z6acvpsfyTKq7vblhxJOf0
7uIlzO51hOenEwpGiPeGBJTD/yQD4Q4VRs6LVcPi4ewupAyKYRw1ofL5phPD278P
dhmci/Ral7+X4aFkdFCP4z9OQkiksnT/54wFUxUWf55GKIdZ0hXNK345UNU8qxFX
2wvWOr5B+gNxG1NO98PZbWGNR5ty46OovcTJjs/sffPi6JEA5HFW
=i2gO
-----END PGP SIGNATURE-----


