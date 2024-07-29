Return-Path: <linux-rdma+bounces-4084-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1300D93FC12
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 19:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83F4281CE6
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 17:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3211F15EFB8;
	Mon, 29 Jul 2024 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=princeton.edu header.i=@princeton.edu header.b="E/sAJ8Sv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5432B1DA24
	for <linux-rdma@vger.kernel.org>; Mon, 29 Jul 2024 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273043; cv=none; b=USVCud6AjiR9aVYqr1rVJZWS1+v3xFgDsY9x9i5s+yy1GNt+lRBlqMGVkB+OBuYAs/CNQ5fUrrUXhtSAgDETl1U1iO2qr6aMV5p6y7qdQDQeHOU1OjsDeyT0ODnN8vn9AgTuovbM99cN7JrCMWGEM2G2RTeGbFdAf+0BzURm56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273043; c=relaxed/simple;
	bh=x1myNBA3dv35MuMtB1yOTWdDpUAOShdhmzHfqxLOtGg=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=kRSnG7bggnMu82DmLqNqbgltmpPo8HVBjcjslrMdcjWGcE3SLCm7SKBfDOh+Iwcd8OqVulDDyC2oTdZ1TStNsaWcN2FqSkte+j+/WOF7BWjRPlra1VWvLRX8O7UT0hFb1sAm0TQ89+KzAptBv7Iy119j3UqsGauss7sn/9FOpwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=princeton.edu; spf=pass smtp.mailfrom=princeton.edu; dkim=pass (2048-bit key) header.d=princeton.edu header.i=@princeton.edu header.b=E/sAJ8Sv; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=princeton.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=princeton.edu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44ff7cc5432so23768981cf.3
        for <linux-rdma@vger.kernel.org>; Mon, 29 Jul 2024 10:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=princeton.edu; s=google; t=1722273040; x=1722877840; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0G8VZmm1SQc+J3i8rxdgJ/vsEcM6Kk72Ulh4ErPWy1E=;
        b=E/sAJ8SvmVAGh6tacdlae6JSdbmSpHvhwgnJdP8b3XdhS4+3cKsy6SLGjF5ahXPHur
         ElyXR87jXuPf1SKgjQhs83Gd6LqbFkuEr5hJujsTYz2qM/XCoPUVsrSuYY/sl7bmaGn3
         j/NPn+nA8uBeCN1dzAPIcwX1y7hlHjYtERAdN0+8cPRgIwG6fbAhSmvj7NWz2gn6IvoH
         bfM6/elE6rzvrHF7z3tkGYf8zkbdKZYifGHq6FuSx6Y8jFoa+yx/z3r3/0TZpBhrFjvg
         +R5ck8MGfohdLM0qhzsSRIjk63fnf6BRHw0jMie7w3+1iZL4COE7PymBZxgv1aGaymsl
         vk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722273040; x=1722877840;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0G8VZmm1SQc+J3i8rxdgJ/vsEcM6Kk72Ulh4ErPWy1E=;
        b=ZkPZ7VjKqOyNLpcMiLVsQw2+6stiN5gj5NvB5c8ONMdR3amDpMcc5MG3h0s3R/bb/p
         4uSxv4IpV9nGM9jxW5HMy78IRzSBy+pRtT3bj/PdI/18T6FVeE3AQqZqpIflw/TkxQHr
         BuqZwyozcI3/3KMuiUsUZ4i8k+Lh4mtHt49Z7etQqtMnX6lYkNB0sl6oDttVQg0QO7ZJ
         H+f+NGz0HTiQjaD7sn78SDz6HczEeJqqGSMtj3xh577kFXFyrx+9JJg/tOVJkBeL8ZCV
         Udj7j5MivUTeXBSryIELM1N9NWH0HdWM0ub+bfAt9yOTip8lInSEJ/f3IRCECywvIedQ
         J1cw==
X-Gm-Message-State: AOJu0YybRHmj6LAlA2WrkfN5AjEQv9h34V17YwOe52VnYouOP3dV+D6z
	KYIgvHA9qtxpMxVMjjH3t/RSrXbbh/Hxmpm06zPBwfiHGMClc5GbcAwMLVMG324xJwjPghm5Ybw
	/j4YtSNDW/ycOLzjGQyL0c+q73HFDckmC9AbLb9Ie5WTNQFpphLta7l7jYeUbjDu8o20QzkSeML
	QDCrYBVgQ/o6N7dNdIRShGQJ3t0CeUUCo0iS4hLzOKDQ==
X-Google-Smtp-Source: AGHT+IELRMokYJjmI7rd6SMK9CiPlDZwawEX5f5L6u0UfCJN2fM4ZYnt7NKKqNXyARt7IBsoiaGLbg==
X-Received: by 2002:ac8:7d10:0:b0:444:9085:58f1 with SMTP id d75a77b69052e-45004d70372mr109925341cf.2.1722273040003;
        Mon, 29 Jul 2024 10:10:40 -0700 (PDT)
Received: from smtpclient.apple (nat-140-180-240-251.princeton.edu. [140.180.240.251])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe812589csm43146101cf.13.2024.07.29.10.10.39
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2024 10:10:39 -0700 (PDT)
From: Andrew Sheinberg <as1669@princeton.edu>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Seeking Guidance: Creating an IBV Multicast Group?
Message-Id: <1FF42574-65B2-493A-A779-D27F853063A7@princeton.edu>
Date: Mon, 29 Jul 2024 13:10:29 -0400
To: linux-rdma@vger.kernel.org
X-Mailer: Apple Mail (2.3774.600.62)

Hello all,

I=E2=80=99m not sure if this the right place to ask, but I will give it =
a try.

I have a system with many initialized UD queue pairs (info for address =
handle creations and qp numbers exchanged out-of-band). I am only using =
libibverbs for establishment (purposefully not using librdmacm, to allow =
for more flexible environment configuration) =E2=80=94 everything is =
working smoothly for unicast.  Now I would like to create a multicast =
group and attach some of these queue pairs (ibv_mcast_attach); however I =
am struggling to find any details on how to create such a group (and =
obtain a proper MGID and MLID).=20

I found a few examples online but am left with questions:
	- There is code within perftest's "multicast_resources.c", but =
this seems a bit hacky and oddly verbose
	- There is code within Nvidia Docs=E2=80=99  "Programming =
Examples using IBV=E2=80=9D showcasing joining an already created =
multicast group at a given IP address using rdma_cm, but It is unclear =
how to create the group in the first place


Questions (please correct me if these do not make sense):

1. What is the role of the OpenSM =E2=80=94 is there a C API?
	- Are there any examples using opensm programmatically and not =
with CLI?
	- Does the API differ on InfiniBand vs. RoCEv2 fabric?

2. Is there any high-level documentation to describe the role of =
libibumad? (Looking at the man pages on a per-function basis is a bit =
too fine-grained for my understanding as of now).
	- I also see libibmad =E2=80=94 what is the responsibility =
breakdown between these two?
	- How do they relate to OpenSM?

Any guidance is greatly appreciated.

Thanks,
Andrew Sheinberg=

