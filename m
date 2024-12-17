Return-Path: <linux-rdma+bounces-6566-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1819F4893
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 11:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B90188A22B
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 10:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA5D1E00BE;
	Tue, 17 Dec 2024 10:09:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail02.habana.ai (habanamailrelay02.habana.ai [62.90.112.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9CC1DF969;
	Tue, 17 Dec 2024 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.90.112.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734430144; cv=none; b=s2hfxyZBzhcGRieKAQs7H4xtMl+m26w5vPtHgqFuBaWrGX3movxrOqRwjb/q0B16nfIWATW+2o7OFUQ3QzPf7+GbZuNXytT+nOxHzpAY9N0KZfNu+hrB/foeNH8+ltRU1AMbm7y6lRqrIT/kVPvJL16KIIHm6N0G4ajAyXScv8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734430144; c=relaxed/simple;
	bh=b+SdJsw1Kx+SpPIE+HezTEp3sHjhhafBOiQvUjWXR0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=giMRH4PJyPBF3X0YtNSSXgGkv4lni/uWeRhGaxgslz82+LPZ2p4W0RxWB0JwbB4DCsZp/uQbjHOCKzERojtkPUqc+h5uGEKVhOOUmxJzws+VRs9khNOY/z5KsHqzamQxAd9SZ++tygA/x6/jYhZgtnvB72NUUMXi2tOwN37ZcC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=habana.ai; arc=none smtp.client-ip=62.90.112.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
Received: from akehat-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by akehat-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPS id 4BHA0eds079158
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 12:00:40 +0200
Received: (from akehat@localhost)
	by akehat-vm-u22.habana-labs.com (8.15.2/8.15.2/Submit) id 4BHA0d6i079143;
	Tue, 17 Dec 2024 12:00:39 +0200
From: Avri Kehat <avri.kehat@intel.com>
To: andrew@lunn.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org, ogabbay@kernel.org,
        oshpigelman@habana.ai, sgoutham@marvell.com, zyehudai@habana.ai
Subject: Re: [PATCH 06/15] net: hbl_cn: debugfs support
Date: Tue, 17 Dec 2024 12:00:39 +0200
Message-Id: <20241217100039.79132-1-avri.kehat@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b40391d5-66d2-44be-bc83-4ac3b7bcfe08@lunn.ch>
References: <b40391d5-66d2-44be-bc83-4ac3b7bcfe08@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revisiting the comments regarding our use of debugfs as an interface for device configurations -
A big part of the non-statistics debugfs parameters are HW related debug-only capabilities, and not configurations required by the user.
Should these sort of parameters be part of devlink as well?
Is there another location where debug related configurations for development can reside in?

Avri


