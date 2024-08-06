Return-Path: <linux-rdma+bounces-4209-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB82D948681
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2024 02:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20421F240F5
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2024 00:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD98A47;
	Tue,  6 Aug 2024 00:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gyi6PiAf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE91C2CA6
	for <linux-rdma@vger.kernel.org>; Tue,  6 Aug 2024 00:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902829; cv=none; b=GbgpNzii7Y9g/iQkGHECk3KJWjuhDIeD0PeTUTYnFJmfWdPEYTzwO4soLp9GsL4/b8ACAZBpI8Q9JhWj+94ft5ko3Bz6jd/QzKa5On3HNGjLVBkd7wWXnP4uDvQdrcGbQtgTGjjwmNkGzaeT/TB3RHtei9YAq8WOZkmVFmjL4jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902829; c=relaxed/simple;
	bh=NAHTjQgD4+zmcG5S0XfaQDNArJDKgMYBVIZNZ/aJ1Cc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gzN6P7rQlMlyVD/bLZERN//Hq/PseflYe1p68rq36jz3E8/4bLGN+mkObFmEeNqXImJFp+hZXsUES3Z3e43GVZjYIp8Uebw4o+SjCcx+uNOiPmOZOF7ceZhALdQUvLla7K/wtF5Q3OExbaLupMjniOzSnlGLUAMOOnjnhVj8ESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gyi6PiAf; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cd5e3c27c5so10368a91.3
        for <linux-rdma@vger.kernel.org>; Mon, 05 Aug 2024 17:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1722902827; x=1723507627; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NAHTjQgD4+zmcG5S0XfaQDNArJDKgMYBVIZNZ/aJ1Cc=;
        b=gyi6PiAfpTtg5/so2yw0etJtg2QCDRm8C0zEyRpp9tdYYZlbvY45jCuW3P89Zpwopt
         +cnFDTINueWp+L/5E3/qv2aFbrYs17cCr4CqBiQ3e7cvEEIb3Wz5gTxXalBbSiCDpR/w
         xVl5q/ddOKEqwazgi/HGgdIludwMX34FoTOT1w56qRoF5wtZGPymdkRbiX0RxgTN25vZ
         B6fQ76RwoD/Qtilp3hdUl2NatvZGRZN1X+g9nr9UQBLuZHFniEp38VK4KEg5STQDVu5x
         T/6oFOUd3eNN5S09pxYbCFAQMKkwswndM1f2nQzFbdWd8WbKadK5jjnxIBMk69Z4YwZQ
         t/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722902827; x=1723507627;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAHTjQgD4+zmcG5S0XfaQDNArJDKgMYBVIZNZ/aJ1Cc=;
        b=QMDkLckws0slOQjkehu3sg1khvB861mBy/WHf3ADlYx0YRS27gJtDf0K9iZbk/9DUH
         bCY+UfpRTzNTCIrOqca8fM9tRW5nvfR5Fu5Cxe2GG15mfc+gQnEVV8lOdg9qyYhLVHfQ
         duVMcdaWKvqIdr0t6+LzHbH8PmNM7OjT7O2DW1cG0ACIZL4huctknDIRk79Mv56BNLcg
         hvxBjlnvYiLsIBBcqp+uPhPs+FjPgbAvw9Mh9PeKe+Rax/Mxt3aH3lUvOKzAMi3OSGn+
         8ogHX87LqJ7H/ds01Z7A78V6D7otnpJo1ExJS3h97ULVcnPIhH67laLnphFQxwwI6tpJ
         0rQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh8Un4pEUHHRj9DU1X2wBcXCZx93Si5wQ4r6Em2dGv4xJGYPEt8IrXf24SYxcoxGkRnRM29AZjpdYyMsmV5/Az7XBGfVbeITKalg==
X-Gm-Message-State: AOJu0YyXetlX9rGBA68PZmqhafJqG19LUhugc1lTUi4BTuTobRLcFlR8
	RNh5NNu6TruJYA58Fe3gOSQNUKYNaLrlDpKEHTCAeQrhT4m8a/VoUoInIMMQ/Jc=
X-Google-Smtp-Source: AGHT+IEQSHScRjfnGvU+Fw05tXfpsc+P5lXsv6/4ahugCBzY43bWRk3MpQCenDGZj1yYOONAG+y5yA==
X-Received: by 2002:a17:90b:1e04:b0:2c9:8b33:318f with SMTP id 98e67ed59e1d1-2cff94143damr11644050a91.11.1722902826882;
        Mon, 05 Aug 2024 17:07:06 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2cffb388ecesm7730694a91.49.2024.08.05.17.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 17:07:06 -0700 (PDT)
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
Date: Mon,  5 Aug 2024 18:06:59 -0600
Message-Id: <20240806000659.30859-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2306201040200.14084@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2306201040200.14084@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Hello again. I just realized that my first response to this thread two weeks
ago was not actually starting from the end of the discussion. I hope I found
it now... Must say sorry for this I am still figuring out how to follow these
threads.
I need to ask if we can either revert this patch or only modify the quirk to
only run on the device in mention (ASMedia ASM2824). We have now identified
it as causing devices to get stuck at Gen1 in multiple generations of our
hardware & across product lines on ports were hot-plug is common. To be a
little more specific it includes Intel root ports and Broadcomm PCIe switch
ports and also Microchip PCIe switch ports.
The most common place where we see our systems getting stuck at Gen1 is with
device power cycling. If a device is powered on and then off quickly then the
link will of course fail to train & the consequence here is that the port is
forced to Gen1 forever. Does anybody know why the patch will only remove the
forced Gen1 speed from the ASMedia device?

- Matt

