Return-Path: <linux-rdma+bounces-6739-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5F99FC46F
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Dec 2024 10:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C17162D22
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Dec 2024 09:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA3915B0F2;
	Wed, 25 Dec 2024 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="j4TT0v9U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657731509A0;
	Wed, 25 Dec 2024 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735119525; cv=none; b=rJYiYqczBriZ3yqWm7ccvLe4Q4Mg7K6pkn067dNG6huyvX5VKkQV34xIuh5gmqyCKT+qmiahGTZuNzMEkyYTD8V27RzLCeaM17lnoQk+Y6vZaHG51hrNTGn66ZtbqGJ4cg3JuFYXD4OVDSTIoYRQgGWcWKj8QJzpMZ1Qlv3v+/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735119525; c=relaxed/simple;
	bh=B1vHeDlMhRy9ZPkz5ybWeWtwFXVG7REz2VpXSTwt0f0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=flhwUuqFCaU9TOI+sWCcvXyK7JlQ7piDn1UMySanGJG1UsSzooNjbK/2cGzoERAi9AjuxbOaPE4FgnuPZTKa4s+H3ZEd2juD1Z91FmqrGtWZj7RKNlsumDaG+Ms+dp32i0Gn+3fWWQIMMtl9mh3ZrbjMo9+/OR/lu2MepGk4GMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=j4TT0v9U; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1735119523; x=1766655523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B1vHeDlMhRy9ZPkz5ybWeWtwFXVG7REz2VpXSTwt0f0=;
  b=j4TT0v9UektWYV6AVRrNj+D0/fQsPQuhANLzdIIHUn8pc5Eh1umeaFZ5
   +AofF5zmDXgsQVAh1wFkrliCRdseH1IUWEsk49AZvEhPkmcxQSfXVvVJu
   QxztE8tb7OsWXsXI9lrarEUHwmMeg1V5+fWg40oC0O3RzaraOAMpkQIsQ
   Nyo/woFf1iHKYcpmsMahneWk+5wj/8HUY1LAcmyt1NccaPgXTNOxgGs7f
   CDOw1JLQVw92529b8obXKuM+igr1IbX+zvc0y+1GvXNIGFYV79DdWJ7Sn
   e1uyKeK48pbS3Z98BknQkepZ1ePFacj5LhGV6O9CpP/ZShvvKgE7SXFrJ
   Q==;
X-CSE-ConnectionGUID: /bOn3tHTTnuaFhGAW6xcQQ==
X-CSE-MsgGUID: Ux1b9ZxeTMapd09sd5LNyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="173280040"
X-IronPort-AV: E=Sophos;i="6.12,262,1728918000"; 
   d="scan'208";a="173280040"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2024 18:38:33 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 83B08C2260;
	Wed, 25 Dec 2024 18:38:31 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 59119D9940;
	Wed, 25 Dec 2024 18:38:31 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id DC18D6BE7E;
	Wed, 25 Dec 2024 18:38:30 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 573121A0071;
	Wed, 25 Dec 2024 17:38:30 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	linux-rdma@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH blktests v2 2/2] [NOT-FOR-MERGE] just for testing
Date: Wed, 25 Dec 2024 17:37:51 +0800
Message-Id: <20241225093751.307267-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241225093751.307267-1-lizhijian@fujitsu.com>
References: <20241225093751.307267-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28880.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28880.006
X-TMASE-Result: 10--2.998600-10.000000
X-TMASE-MatchedRID: 9pYNL+i+jEf0kswJHlL1KrPx3rO+jk2QBGvINcfHqhdXGTbsQqHbkgXX
	bOFNJH1fHuHAs1B9LGUxP/CR41z0tQH3QVwvWrgwEXjPIvKd74BMkOX0UoduudddtqaP9NTnfBk
	m9cGdpD2uTvY6XImebS//MlDRqI8mCE/m5dGLJj6JJ72DuZB0nG6/L6esqr3FmyiLZetSf8nyb6
	HMFK1qe8gz2YRMI7vTJ0RPnyOnrZLnGeKhvkZ/V64XGwCmwOjWClr7q6E3x45XPbQ0V8xFTNfit
	0vKpyM/fynCdh2Y5XmwKCYSJEfZhrz8nTVYSI+9sMgsTI6kb6HAYLx7rnbR8rDQ8m3TqgloelpC
	XnG+JjvDGBZ1G8r1Sf2D6gx/0ozp
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Hi, Shin'ichiro

All your comments has been addressed except the success ratio one. Could
you help to check this patch([NOT-FOR-MERGE] just for testing) that can tell
where it fails at in your envrionment.

I tested it today in my QEMU enviroment, It almost 100% success

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 tests/rnbd/001 | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tests/rnbd/001 b/tests/rnbd/001
index ef8dff93a94a..9c6d56e3ee98 100755
--- a/tests/rnbd/001
+++ b/tests/rnbd/001
@@ -28,13 +28,20 @@ test_start_stop()
 
 	for ((i=0;i<100;i++))
 	do
-		_start_rnbd_client "${loop_dev}" &>/dev/null &&
-		_stop_rnbd_client &>/dev/null && ((j++))
+		if _start_rnbd_client "${loop_dev}" &>/dev/null; then
+			echo 'connect ok'
+			_stop_rnbd_client &>/dev/null && echo 'disconnect ok' || echo 'disconnect not ok'
+			((j++))
+		else
+			echo 'connect not ok'
+		fi
 	done
 
 	# We expect at least 10% start/stop successfully
 	if [[ $j -lt 10 ]]; then
 		echo "Failed: $j/$i"
+	else
+		echo "Success: $j/$i"
 	fi
 
 	_cleanup_rnbd
-- 
2.47.0


