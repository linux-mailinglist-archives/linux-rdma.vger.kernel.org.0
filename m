Return-Path: <linux-rdma+bounces-11125-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C85EAD2E37
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 09:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA87170A0F
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 07:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034C027A934;
	Tue, 10 Jun 2025 07:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dtGcd7wR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52552215F72
	for <linux-rdma@vger.kernel.org>; Tue, 10 Jun 2025 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749538851; cv=none; b=PBRrn3W6z9lz46fqBJw6vVtd9/Lxskyg3a3Y6sAT7vjgoElxZ7EON405GxWWD0PuUeCydBapl7mkY7dqPYhu+4cHqdMMciZDqJCOEkKD550GQ8gC5CBUBDBI2FZd+p0CyufBdf679EeWrDTX/IxmTw/Xds3k1/q1O0kHAZs63Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749538851; c=relaxed/simple;
	bh=nxzPfqmfptUSQtLazHsiK0dcb5LFkkFm+nAYN/C+p7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tKaOG0vS/9lh6UF5HhXg06IMNjLb9/Qm8D7HA/RD0BVGrutx+lSl9Dzh2fwb+2tach9o0PTOq5px740fuHY/MW4dtpD8+lJNyifSp9LoBrR1jniM9Q32dLKXCWP/VlOF7Qoa+TssGQBpStChIzBhZam5xQMgWvKu27QG/NoP8/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dtGcd7wR; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742caef5896so4183732b3a.3
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jun 2025 00:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1749538849; x=1750143649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUJitp02dLbwyW6XXbPMt7kAqtrb2lpqnpotbucX9CA=;
        b=dtGcd7wRQWbYXVW4cPdjrFKOIBrbFi3WDWaK7NW2K73TdOc4KAlxMd2EVnHR22IX3H
         nkJUmm2LohJQzU8ZT9d3DqS0+HPANe0dMuy5WDAIgVlRLtu7JHS/LPOisEIF1s+vKMh6
         +MAxwRlMf1HO6mSCZJffHi+1YqBjSrNnoeMxkykBPZvZvBxtjkcLq36m1RsaQfUpcc3i
         H+Znmjj8POkJWaKy4KoEokiYSrC3su5AWljkfHoC/axQ0xVjyvOPDGMxTF44XvKlcgE8
         iud94qfA9k7FXCKOXvZBDlO0mtHnP3DhcXLNFAOe/w65cCnm6JJvMipnjdKK49steX5s
         KRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749538849; x=1750143649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUJitp02dLbwyW6XXbPMt7kAqtrb2lpqnpotbucX9CA=;
        b=lRI4RMUbIXWzU/FVVjWZFphP6BKP4FujBWD8CSvsxxkmyxtaQS0bTq2OC8XumIEwl/
         TQRyzEB8u6u43My5BCU7FKOT+4IuNjGrjgUj52qQoZif5Qt3qTJivWZO73Kw7cMuBUkj
         bHhNTCFWhmBb1G6XM4k4wllZbfjsS5EQR1kcLdVtc14ni44XEmY/IwTNTnee0S74GOHB
         IE5BskxDJ+B1fKor6U+AuTTpxW09C6vGKVtFMAB+oJUZMgwQDr/RnolDBxhQYXVWvrlc
         S1cli8dvrzzsxG6L38SIdNqV0sGO4F472SbrGRsdDGjSUZTV+rkMxEFNxK3699HK0Phx
         806Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3AejfNvkzScSXRDGAXl0/XHSTpkxG4vK5DVMTQeAH/wrySckogPsvbrwzCPdLbU+9yHYDioT/zLaD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0gtDEVJm5ZSWL+PmY4Lm2S3ILudWkBmI3fdKQlXoGys16b06C
	IeLHC6IcMR0MZaWH1nwVDgN5Xo4laLP018F/NY3+6s5enjTqouyAVybCyHIQyUF8EN8=
X-Gm-Gg: ASbGnctxpPs463nOtLmkAVydHV12wvl4xTo4mqRFy/PL1uUUfOeIy7kakCw4u2SsguY
	jCtVm/MzG9mA8HVwjxnk6Io3H+pQpBfmQbM6fplUwBiprkZzNQU0Rvq86J97jsw/47PlXK2ZCvB
	9QaMc2Pm51NLF4eblZSnljqd7bHzouSl7jWR/TGJYmf++mIqiGaqKj+hledkb9SaTSK3R7Z0IPx
	1fs22M/sLfhhzNCcYOPPD458NQ28eEu+WtEIJi0SzovfD4D4l2MnB/NEnz1wYACMhaap//Wxx66
	3oAC7p+ajzb3PuNd+lzg/ZKdmQKUnngo0arQFWcy+9HnYcg3Ve/atCCZq5P1QAlu/6wel7cx4Iz
	sEHaU+UkrR7zq8J0XJwCQVYI=
X-Google-Smtp-Source: AGHT+IF8uzdNqEI314pocfYYQWBeowDkb4F+LwQ50ySlNHswx1qiGOLWHPFnpEwYjMluBjhKg3WXFg==
X-Received: by 2002:aa7:88c1:0:b0:748:1bac:aff9 with SMTP id d2e1a72fcca58-74861888babmr2307166b3a.18.1749538849387;
        Tue, 10 Jun 2025 00:00:49 -0700 (PDT)
Received: from mattc--Mac15.purestorage.com ([165.225.242.245])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7482af7af0csm7038483b3a.62.2025.06.10.00.00.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Jun 2025 00:00:48 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: macro@orcam.me.uk
Cc: alex.williamson@redhat.com,
	bhelgaas@google.com,
	davem@davemloft.net,
	david.abdurachmanov@gmail.com,
	edumazet@google.com,
	helgaas@kernel.org,
	kuba@kernel.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de,
	mahesh@linux.ibm.com,
	mattc@purestorage.com,
	mika.westerberg@linux.intel.com,
	netdev@vger.kernel.org,
	npiggin@gmail.com,
	oohall@gmail.com,
	pabeni@redhat.com,
	pali@kernel.org,
	saeedm@nvidia.com,
	sr@denx.de,
	wilson@tuliptree.org
Subject: PCI: Work around PCIe link training failures
Date: Tue, 10 Jun 2025 00:00:44 -0700
Message-Id: <20250610070044.92057-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <alpine.DEB.2.21.2410031135250.45128@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2410031135250.45128@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello again.. It looks like there are specific system configurations that are
extremely likely to have issues with this patch & result in undesirable
system behavior..

  Specifically hot-plug systems with side-band presence detection & without
Power Controls (i.e PwrCtrl-) given to config space. It may also be related
to presence on U.2 connectors being first-to-mate/last-to-break, but
I don't have much experience with the different connectors. The main
issue is that the quirk is invoked in at least two common cases when
it is not expected that the link would train. 
  For example, if I power off the slot via an out-of-band vendor specific
mechanism we see the kernel decide that the link should be training,
presumable because it will see PresDet+ in Slot Status. In this case it
decides the link failed to train, writes the Gen1 speed value into TLS
(target link speed) & returns after waiting for the link one more time.
The next time the slot is powered on the link will train to Gen1 due to TLS.
  Another problematic case is when we physically insert a device. In my case
I am using nvme drives with U.2 connectors from several different vendors.
The presence event is often generated before the device is fully powered on
due to U.2 assigning presence as a first-to-mate & power being last-to-mate.
I believe in this case that the kernel is expecting the link to train too
soon & therefore we find that the quirk often applies the Gen1 TLS speed.
Later, when the link comes up it is frequently observed at Gen1. I tried
to unset bit 3 in Slot Control (Presence Detect Changed Enable), but we
still hit the first case I described with powering off slots.
  I should be clear and say that we are able to see devices forced to Gen1
extremely often in the side-band presence configuration. We would really like
to see this "quirk" removed or put behind an opt-in config since it causes
significant regression in common configurations of pcie-hotplug. I have tried
to come up with ideas to modify/improve the quirk, but I am not very
confident that there is a good solution if the kernel cannot know for certain
whether the link is expected to train.

Thanks,
-Matt

