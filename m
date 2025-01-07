Return-Path: <linux-rdma+bounces-6866-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D596EA037CE
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 07:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1475F3A4C72
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 06:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186D71991BB;
	Tue,  7 Jan 2025 06:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="tn2eIAl/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79213186E40;
	Tue,  7 Jan 2025 06:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230775; cv=none; b=tWSotqAL6sEN8oupN8xrPcEQHm4XRIdv2017jhKFi5L4bTo+lBQA+3lv0LCuDIVwOJ5qfDmtzY05MswRTRHp114TC1IJU+jXTMmjNWhGcfdQs1Ey6ExpEDz4rIk9EXREn7r3zNO8a2KpAUABvvFfx6st/+Gg7eXqopFIYsMqhmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230775; c=relaxed/simple;
	bh=I1APVWtTjKQJ8fkvveWJE7WhKutYXPH1fpvfh1MPryE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jAzQaMOCNhVL1+h2QIfDhM37/5Gb37hLLyrYdq/zlOikUU9ZQoqQvg1j8X5pvnheg7ifX4r3LCrhlB5C+YmggVK8tZQHZ60czwall/ReVpOwJKCkQijKp16CGiDnHtVusCdF8YTaQZ2l5lIhg8vzw/g1exl5OsynVle8qhrmrm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=tn2eIAl/; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1736230772; x=1767766772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I1APVWtTjKQJ8fkvveWJE7WhKutYXPH1fpvfh1MPryE=;
  b=tn2eIAl/rKvvq4OO5BQcyi8EqhzX4MVgIsBs081KLmdARAxCOo1UecON
   LBi1pWZmqzMilPHx5OwVsxDspI1BkhB/gYVyg7iETpS1wQWATD6r+CKw+
   Xi9whDZytBgwf0IbGjCxC6xUN4hOTx2zgtkj2+Gw8ubvyfH49bcDh6E63
   8twKVPsycZJ1geqhAwbYX7ZHzlM55mPXAyO00S+Iy6hdZjJWetcKSlg6i
   RdPFdeFEojBbuzGn48pIxHbW4NJxii0gbdfUG9u747FGG13hOkQ4T1WEG
   IFINEc7c9TQIoEgm00VwLb6V9mZ660LNkN4NrIHTQ1RyG2qFpsrqZfXMl
   Q==;
X-CSE-ConnectionGUID: +z+iyNoRQCiFZkXSY9R/KQ==
X-CSE-MsgGUID: jozPsXgzQJCD8RFNgAPmQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="173787438"
X-IronPort-AV: E=Sophos;i="6.12,294,1728918000"; 
   d="scan'208";a="173787438"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 15:19:23 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id B6AA5DBB81;
	Tue,  7 Jan 2025 15:19:21 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8C521D4BCD;
	Tue,  7 Jan 2025 15:19:21 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 309C9200930D0;
	Tue,  7 Jan 2025 15:19:21 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id A87381A0071;
	Tue,  7 Jan 2025 14:19:20 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	linux-rdma@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH blktests 1/4] common/rc: test have_driver before check its driver parameter
Date: Tue,  7 Jan 2025 14:19:02 +0800
Message-Id: <20250107061905.91316-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250107061905.91316-1-lizhijian@fujitsu.com>
References: <20250107061905.91316-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28908.002
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28908.002
X-TMASE-Result: 10--5.293100-10.000000
X-TMASE-MatchedRID: JJf+xfeHh42lBA8TvXlsKoqCtN91iZAp7G01sD+Ygcw7TItwyO7eH1UV
	Lgjd3EiYOxmmd++ze7DWvPxiCkmZqKZY4PxfRMWEEVuC0eNRYvIBwaT6rjQidMwHSQ+yXjTDm3P
	fEX0yKHEi+t+0AiFaYvL3NxFKQpq1hGI7PKfQLviVF2HD8EHNp30tCKdnhB58I/9UW5M5dRNp7q
	EhmmPgy/cUt5lc1lLgOMB0shqXhHojxLihx43ziKaEze5aQJsciPszC5ncNk+pZmZzTVBCdfcsE
	I/m2fBH
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Similar to previous _have_module_param_value() and to improve efficiency
and avoid unnecessary error messages, _have_module_param() should first
verify the presence of the driver using _have_driver(). This change
prevents redundant checks if the driver is not available.

Previously, an unintended error message 'modinfo: ERROR: Module scsi_debug not found'
was displayed before the test execution. For example:

 # ./check scsi/005
 modinfo: ERROR: Module scsi_debug not found.
 scsi/005 (test SCSI device blacklisting)                     [not run]
    driver scsi_debug is not available
    module scsi_debug does not have parameter inq_vendor

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 common/rc | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index 0c8b51f64291..7fd178b01989 100644
--- a/common/rc
+++ b/common/rc
@@ -77,6 +77,8 @@ _have_module() {
 }
 
 _have_module_param() {
+	 _have_driver "$1" || return
+
 	if [ -d "/sys/module/$1" ]; then
 		if [ -e "/sys/module/$1/parameters/$2" ]; then
 			return 0
@@ -96,10 +98,6 @@ _have_module_param_value() {
 	local expected_value="$3"
 	local value
 
-	if ! _have_driver "$modname"; then
-		return 1;
-	fi
-
 	if ! _have_module_param "$modname" "$param"; then
 		return 1
 	fi
-- 
2.47.0


