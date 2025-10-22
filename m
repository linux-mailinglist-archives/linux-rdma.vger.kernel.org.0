Return-Path: <linux-rdma+bounces-13977-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C68D6BFCC8A
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 17:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EACF1891735
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 15:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7051B328B6F;
	Wed, 22 Oct 2025 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkoVNX0a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF2233FE30
	for <linux-rdma@vger.kernel.org>; Wed, 22 Oct 2025 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145611; cv=none; b=AODKO5VCArTzeV1nJrScrTIEQOJs+p8oJuPz6/TPtyTZVwFJgOd2C9zv6Rmg4cLuuPNXfERHflrpyXTovwa6OkHnv+DggMH47p1kCKnyfnMeSljOhjTnE9V4uISeVE8VFpkQiwQdi8W0wr0duHQSKFjSmvNd4tfQrsxbCj8vqjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145611; c=relaxed/simple;
	bh=UbWoaHfk4K1/UvNZvMawXCARRWPO1Z9NTD7GvYO+Q2s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MIIkr6bEqFZDoJ7g6yjokTehmx2cL2uX90o8azwko//pOberd1t+NkozY91uDw51r0PMNNFhapn4eA0xLtv9PD7K9lAJZ/zyooYLzyqGHA7Eg1ZQPAQbzFv0/M/1QywkQi0lg9JvIp6d8FWj6fTYVxrIkyPbiIp47In3QrfWbO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkoVNX0a; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63c09141cabso10535540a12.0
        for <linux-rdma@vger.kernel.org>; Wed, 22 Oct 2025 08:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761145606; x=1761750406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UbWoaHfk4K1/UvNZvMawXCARRWPO1Z9NTD7GvYO+Q2s=;
        b=EkoVNX0aHokw+eBPfkooqqiwwad1AJTll+w1m6CEg3ieI/dYK8b5wrCK/f73Oiw6Cy
         xo9O41KVdf8WRJaAk19j6dJoBJeRdZ4sNW+CXSDbOKJ1+VeYL1LDiAW4lZLEldR3N525
         vNYep6LWJ2mZ6rFtbvl8QkpCIGmYlL5FX3wzHGWWqHwGFy1AMChAMWbcVUfilhge/2/3
         ToWW9uqmcoNjWtzpv85pmv6KEHTMcIODwgAVLhx5bU748Lp4qPsGR8L53nuO/u9F9An5
         fMd7LXCgXunHHQgj70F2r9z9eTkqVndN7e30chGlLcHQA1lpTEfhP+aAF8w02dmE+yTL
         +ViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761145606; x=1761750406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbWoaHfk4K1/UvNZvMawXCARRWPO1Z9NTD7GvYO+Q2s=;
        b=uVqdzEHx7ur9Q7G956td1mGqh0jFEGU6+cQJAmg2WJ1PfEVg3QpO2VWaddaOqackyy
         ApIg/gBRQFuNeHrAstkXDICCbH/2kLTxVymX1jncqpBILxlPBCh6vUmTjHrBFBKC9SFs
         id06brkdAACDsdg0g9vJwUlKpCfrTp8E2AzNomQeXf1B/Dibw2b2W8fZaN2Jlc/s2jor
         xZ5/+mPlpUmV6xwuFVUP4s2iOMP9NHxv8gtwvqPfVgnBn4Ps4bX1p+Vxygg+3tmie2zd
         xzQf1EAwZMB4ckoUYZ3dRfBIq29jBkUIENPp+tLzzlifsoZQh45+v+CaZyj45PXp1Nez
         5K2w==
X-Gm-Message-State: AOJu0Yz0z0ioU9J3u1BiXGGNdH0fleNGr+YEjNmvFNTgnwtDJr1B6sDh
	eky9Qb37sKxx/LEAIAAJkufxkTwVll4n3mRDIzvOXbHKnHOg8/AWtJw5gKmU6x+AdsezIYjg45F
	SE+vo0Vrk8C2al5vaPoGwPOuTl3/xT6mLhy+ErBQTMQ==
X-Gm-Gg: ASbGncuO3Qd8CtOqGCLDy/5e2UVQzbBSbbMqJq9+tIQmiBK3z9UIzYP818S89cpecT/
	cuZ2ziUD6fGEpENVtAiMyNfdJyf1MvE/vgA6GFivDyKzaN/NhyCSh+obZ6ZNX40U6LWWKdZyY3L
	5yTFT6+kijSb++uNtetz9zso6CE1qaobGejAvGCUuSqVFQ4B1YPtzrs9JnjtZkZ6W13tgMfWhDR
	9oKKEPJQAOLT410UAOGlWRvcbj8XR1f872gwIGDkX+FUJ8A2MG3MXLSeC3lUu+Z
X-Google-Smtp-Source: AGHT+IEy8Fru46mNBO6y2JoMSZDboL0OB49ysj0n1ak/ZKsw22ALeYlSI6u98B3kaZXDUZae98VDZi2iZgt+C7qDkxM=
X-Received: by 2002:a17:906:c10e:b0:b54:68b4:6d30 with SMTP id
 a640c23a62f3a-b6471f3c5d0mr2735894666b.25.1761145605563; Wed, 22 Oct 2025
 08:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Liu <asatsuyu.liu@gmail.com>
Date: Wed, 22 Oct 2025 23:06:34 +0800
X-Gm-Features: AS18NWBFBYvrOrx_dzMhvSn9GySIubMn0yyzbXvXcNfAVhTBrBRJmWLLAHTgZek
Message-ID: <CANQ=Xi0DHDe7qgatORgDrJ72x_=ZWXPZzZchF3wcrQ2zjpDOXA@mail.gmail.com>
Subject: [BUG] RDMA/rxe: System-wide crashes after running ODP async prefetch
 test on v6.18-rc1/rc2
To: linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, Daisuke Matsuda <dskmtsd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi RDMA maintainers,

I have encountered a severe issue when running the following rdma-core
test on Linux kernels v6.18-rc1 and v6.18-rc2 (Debian 12.5) with an
RXE device:

./run_tests.py --dev rxe_0 -v
test_odp.OdpTestCase.test_odp_async_prefetch_rc_traffic

After repeating this test a few times (sometimes just once, sometimes
more), many unrelated user-space processes (e.g., apt, ip, python3,
ldd, sshd, etc.) start crashing with general protection faults, and
the system becomes unstable until reboot.
After reboot, all programs work normally again, so I believe no
libraries or binaries were damaged =E2=80=94 instead, some memory regions w=
ere
likely corrupted at runtime.

I have done some primary investigation. This issue does not occur on
kernels v6.1.6 (self-compiled) or v6.1.0-40 (Debian official) under
the same rdma-core build and configuration.

Sample dmesg excerpts:

[Oct 22 10:43:04 2025] traps: apt-helper[1431] general protection
fault ip:7f29107a8417 sp:7ffc96671e58 error:0 in
libapt-pkg.so.6.0.0[19d417,7f291064d000+15f000]
[Oct 22 10:43:05 2025] traps: apt-config[1442] general protection
fault ip:7fbaf5d97417 sp:7ffebd2dd728 error:0 in
libapt-pkg.so.6.0.0[19d417,7fbaf5c3c000+15f000]
[Oct 22 10:43:06 2025] traps: apt-config[1454] general protection
fault ip:7fa641107417 sp:7fff6a1bf858 error:0 in
libapt-pkg.so.6.0.0[19d417,7fa640fac000+15f000]
[Oct 22 10:43:07 2025] traps: apt-config[1460] general protection
fault ip:7ffa83932417 sp:7ffd72a1d878 error:0 in
libapt-pkg.so.6.0.0[19d417,7ffa837d7000+15f000]
[Oct 22 10:43:07 2025] traps: apt-get[1476] general protection fault
ip:7f26880e6417 sp:7ffddb09b158 error:0 in
libapt-pkg.so.6.0.0[19d417,7f2687f8b000+15f000]
[Oct 22 10:43:35 2025] traps: python3[1496] general protection fault
ip:7fdb6efa2dd9 sp:7ffe8f1097e0 error:0 in
libc.so.6[90dd9,7fdb6ef38000+156000]
[Oct 22 10:44:47 2025] traps: ip[1515] general protection fault
ip:5603ead781df sp:7fffd1198790 error:0 in
ip[6e1df,5603ead18000+6d000]
[Oct 22 10:44:49 2025] traps: ldd[1529] general protection fault
ip:55999936b21b sp:7ffcc3547050 error:0 in
bash[7b21b,55999931f000+c1000]
[Oct 22 10:44:52 2025] traps: ip[1543] general protection fault
ip:55ebbcb171df sp:7ffc981d6220 error:0 in
ip[6e1df,55ebbcab7000+6d000]

I can provide the following information if needed:
- full dmesg logs,
- rdma-core commit hash,
- kernel .config and debug options used.

At this point, I am not entirely sure whether the problem originates
specifically from RXE or a more general RDMA subsystem path, but I am
happy to assist in investigating and testing any proposed fixes.

Best regards,
Yi Liu

