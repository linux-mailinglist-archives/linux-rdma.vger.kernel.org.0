Return-Path: <linux-rdma+bounces-3934-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B9C93944B
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 21:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74607B20EF8
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 19:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69215171085;
	Mon, 22 Jul 2024 19:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WU3WfH89"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD571BF54
	for <linux-rdma@vger.kernel.org>; Mon, 22 Jul 2024 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676862; cv=none; b=Hf+1QDJfblB+gG6t6xwHggxDYnA9p1tlRslK6mY1BMvErPmAB6olwEEqsjbECy+9oAxlOF3EgzUYUg4IC4Um5hXZdv+jmjW27ujB2uRbYi7T357JpqfeE9CAWI8nzzkcn5izT1N9ZvZf+aewBtq/YqUjdH5yJSIbuLOOQGXtsBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676862; c=relaxed/simple;
	bh=fi4bLVnPbCJMOh1UmYIW4CBHtEc9QZE9R0H9ArF/eWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Vs7vQXaBEIiXLDCyubpVkAqvDhQXT0vhNBEVUxIfGq2AnlffF/qss15MCSZbAmA0P5XHWhyK3RnYkG159ILw3RqBd0y8tZP+q0J0R80b6aWfulh+h2wl0u+kKB8z1hRM+JAkMsLNLhewDH8IZLeKbYFcRln1/lWvmcvJBtVUowA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WU3WfH89; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-59f9f59b827so4317801a12.1
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jul 2024 12:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1721676859; x=1722281659; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fi4bLVnPbCJMOh1UmYIW4CBHtEc9QZE9R0H9ArF/eWU=;
        b=WU3WfH89sgF0RW8kWhEzLYn0WAXdE2WNRm+2dltiQG/PQqDwsUy27OVxseF/Q7namS
         UbUWJNJJ4c8R0WHIRP4VcKzsd0evWELEHTTjC1qsm9Q+x3QR/G08CRl6S3Jutpa4VDhG
         Bd/NmosyunCIEX78iKXIzB7zbmXA1iQjm719MsrGBgUmsiVcsje05YSh/+y4gfiBArSE
         /I+z9608lZiPUl+1vdzZefT/LpaLkOR496BAeefJdzva50DByqKenJVAk/R9BsOmITcY
         MEO1lBOZuJUCo8JmugJ7QFaBW+oC1/Eh0yKTp3QEwSe0V69vTS26S+c7K//bLVWezvwD
         9PjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721676859; x=1722281659;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fi4bLVnPbCJMOh1UmYIW4CBHtEc9QZE9R0H9ArF/eWU=;
        b=Wj1UTxeB7Lzo+kF74hSEROYSF+v+RP+rmolRv+pltDJc3fnJh2flfmS2GIhAcWdluD
         Wx0nWtYueby5OApLaGMsKO7lrIRl1C5vEEm3S/7wg7biVDSjeKL+mDZyAFyh20ddzT/G
         CGdNMerJzxa8V3iG+NL5Mn0Frq7A7DLxtsMiG7rto5aOFto967JQ7N7MgvpxR+T1hqyI
         q/+SGim0jHFf8ebLX/iPSA5muX9230QCf5PgU01LDjg4mDFXwlH46Q0uFCIfIdMXG9kk
         ajuZaUCGnfNPrGxRtn+PtPT+4atqdMaTu5mYlKsarNuTilItEEPuN9VkRo1Q9qJUKXFy
         QB4Q==
X-Forwarded-Encrypted: i=1; AJvYcCURtVEp7rh7tfxRaQX48lfKdcvj+De3Ar/GrFvP9q7j0NK9K1PTqavsNr/0I9OEVhLgAnQa2eW0ttVZIaHuRl52/uaWNaxBQ23N+w==
X-Gm-Message-State: AOJu0Yz/CJVtpZ+at0DIqQ3zOMX1ytbgOhoK5Cujf1uDjxvtrzaXRE2B
	lh8w9rreFOZxs6ittP//b8yo+RG7h1oV39D48NoqZB49x0t4CUlQuhuLKTbOHf4=
X-Google-Smtp-Source: AGHT+IH0MH/+8seIiuBJ3Gs3Am9JxoYK2yWY1TdfrT/Nm8KdeQf+5AlcM7dCujXTS86xp1i01YFyGw==
X-Received: by 2002:a17:907:3faa:b0:a72:7d5c:ace0 with SMTP id a640c23a62f3a-a7a4bfa341emr556636166b.11.1721676858606;
        Mon, 22 Jul 2024 12:34:18 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a7a3c7b66ecsm456836466b.51.2024.07.22.12.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 12:34:18 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: macro@orcam.me.uk
Cc: alex.williamson@redhat.com,
	bhelgaas@google.com,
	christophe.leroy@csgroup.eu,
	davem@davemloft.net,
	david.abdurachmanov@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de,
	mahesh@linux.ibm.com,
	mika.westerberg@linux.intel.com,
	mpe@ellerman.id.au,
	netdev@vger.kernel.org,
	npiggin@gmail.com,
	oohall@gmail.com,
	pabeni@redhat.com,
	pali@kernel.org,
	saeedm@nvidia.com,
	sr@denx.de,
	wilson@tuliptree.org
Subject: PCI: Work around PCIe link training failures
Date: Mon, 22 Jul 2024 13:34:07 -0600
Message-Id: <20240722193407.23255-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2306111619570.64925@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2306111619570.64925@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Sorry to resurrect this one, but I was wondering why the
PCI device ID in drivers/pci/quirks.c for the ASMedia ASM2824
isn't checked before forcing the link down to Gen1... We have
had to revert this patch during our kernel migration due to it
interacting poorly with at least one older Gen3 PLX PCIe switch
vendor/generation while using DPC. In another context we have
found similar issues during system bringup without DPC while
using a more legacy hot-plug model (BIOS defaults for us..).
In both contexts our devices are stuck at Gen1 after physical
hot-plug/insert, power-cycle.

Tried reading through the patch history/review but it was still
a little bit unclear to me. Can we add the device ID check as a
precondition to forcing link to Gen1?

