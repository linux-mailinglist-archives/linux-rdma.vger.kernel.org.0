Return-Path: <linux-rdma+bounces-12630-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 461BCB1EE12
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Aug 2025 19:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4111D1C2759F
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Aug 2025 17:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2931F63CD;
	Fri,  8 Aug 2025 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Runls5qk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CC5199385;
	Fri,  8 Aug 2025 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754675763; cv=none; b=sEnGNu/EvCI9xNzwta2jqybwToD85UtxbQn1giDX5hmE02vu/RC7o8wSpxY26PbHASuxa2VOnZ6n4BCCN+neLIQ3DuM/8Eb1IWtyObDcTUuMGZ89iWseU4EqXLQlfbZIpU6j6ATUPAsVZcGY6IIRWY0N11frmDPsRWAwrglk0BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754675763; c=relaxed/simple;
	bh=iN+YoE1bEbQcPyDomXc1G20kXSx/6CPo3b6DBfTTkJs=;
	h=Subject:To:Cc:From:Date:Message-Id; b=KHFAG0OAK3Roc7PFFyipJAO/P8ylS0YHGELIerT0aSRk5fC2a3iG+fCaVt8Xih174iP92TF3S5swDz5Gk545gTKhMxe03QrdXc1hliQs7fXJr1V7GlDIz2VH5KhCLMVlSfXsv+Jr8AV/QqY27dPUw2RbbvfZjOdiKIK+TsBpCII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Runls5qk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754675762; x=1786211762;
  h=subject:to:cc:from:date:message-id;
  bh=iN+YoE1bEbQcPyDomXc1G20kXSx/6CPo3b6DBfTTkJs=;
  b=Runls5qkQdXpaB7V3xnUbL6wFmkrwmjAZyu/ZD4aqjw6JanpX67thY2H
   Q2KcSmJlKYZlXzhI0ljr/u36WXrYDPmD3UNqA0dS7qiENxnFzLGSvycra
   m0Z2ZB7FEdc7L91r6sGfNw1Dl5qyyFur11T/moPiuMHFnvF6QQm9WSMzm
   b8vuh0gpslLvQtDSloPlCeX6gyevn5TP/P0U+GN39s5jyx9hkYtynRsA8
   qS+RNiyD78MrZBP+JdmKHwjh/HvtePmTBSyz7NmOnU/BTLOZC9YnLzw9H
   U4CUI3z5D9LQ4Y7K+CaNbNK8yMyh6PX34scpdIW/+kSb3A/xGuxSva+m1
   w==;
X-CSE-ConnectionGUID: la02I+W7TyO+x9Exa7JvxA==
X-CSE-MsgGUID: Fnyy1lwsRhC6FCBTsuwN6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="57158182"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="57158182"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 10:56:01 -0700
X-CSE-ConnectionGUID: MaE//Ts/StucasKqQV+EMQ==
X-CSE-MsgGUID: +a3tf5ozT+el1aZdaeLFxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="169588935"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa003.jf.intel.com with ESMTP; 08 Aug 2025 10:56:01 -0700
Subject: [PATCH] MAINTAINERS: Remove bouncing irdma maintainer
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-rdma@vger.kernel.org, Tatyana Nikolova <tatyana.e.nikolova@intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 08 Aug 2025 10:56:01 -0700
Message-Id: <20250808175601.EF0AF767@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

This maintainer's email no longer works. Remove it from MAINTAINERS.

This still leaves one maintainer for the driver.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: linux-rdma@vger.kernel.org
---

 b/MAINTAINERS |    1 -
 1 file changed, 1 deletion(-)

diff -puN MAINTAINERS~MAINTAINERS-20250707-9 MAINTAINERS
--- a/MAINTAINERS~MAINTAINERS-20250707-9	2025-08-08 10:53:33.324188022 -0700
+++ b/MAINTAINERS	2025-08-08 10:53:33.340189367 -0700
@@ -12279,7 +12279,6 @@ F:	include/linux/avf/virtchnl.h
 F:	include/linux/net/intel/*/
 
 INTEL ETHERNET PROTOCOL DRIVER FOR RDMA
-M:	Mustafa Ismail <mustafa.ismail@intel.com>
 M:	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
_

