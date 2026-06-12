Return-Path: <linux-rdma+bounces-22153-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E23DH6W8K2ovEAQAu9opvQ
	(envelope-from <linux-rdma+bounces-22153-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 10:00:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F127267793F
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 10:00:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=HnxcstSQ;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=A8hXz6rK;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22153-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22153-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=mailbox.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4766A30215BF
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 08:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230B63546E6;
	Fri, 12 Jun 2026 08:00:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69DB34252C;
	Fri, 12 Jun 2026 08:00:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781251233; cv=none; b=pb/JQixxkWFDaKdaHY+RLwtvmETjdn/SWyjkKI1SwM6Eh0uIOWtUgmhfPbPrkboIq1tGiHIpafUEk6+BU8nudycL1BHH1Ns1xKHhpLQL5Ei6uGq5LNR4Zuq4BLjhdkaqJK/Bd81XYMl6JrLaB1RVs9GZyj6HWD3+SSRPv0UlnTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781251233; c=relaxed/simple;
	bh=eOfAUxxd0vwvLdWPmp6cSZfaXxJluAzVRJ5WSChiCJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kLH4Z1HvV3Y9/6FHX6eSMyRtagY+7JHqwa6Z9SJFCImrJTYeHS2SdYXH34+XWCdkMATgVDGOduplvVBzf6nhJwhmz3738N8XEXBsvmyY6jGszIFqqIqve1eecaKBm8mBS13CzDAlY+UXZxDFmLS6YNoCKN5x8lHSkVODKyxqalI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=HnxcstSQ; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=A8hXz6rK; arc=none smtp.client-ip=80.241.56.152
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gcBlJ4Zmjz9sfB;
	Fri, 12 Jun 2026 10:00:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781251228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zd/2XDt2d2T1aPB/6R7gW+LW/fbzlRJAGN7Vftc84uY=;
	b=HnxcstSQGahrPu6/38rPtq+pxbaZIJXWxygZnNR3P/B6xGZfCFfDQYnv68J04qRkG/GknB
	00FbreLTxPk6H3IpucWVa0LKzqXp2IULBae4W9ZeHOdlaiSvuiY6Cx1Kmd5GCGXFTymhVy
	Giar8rAXDlgeLpMQmOdlxsygZYCe1r0HLe7HjL3PzQIr6/y+/rnSuUn8XeW2w+040yhfRY
	Tb6WJTTaJeLAxfnAm8pY/MtMO3YULOwR0ojrM1Vg+rt89u00vVucWD3x02Lhcdc7Mg0PpL
	fAGic9m5ZORNHbmz0WY3PjWJ7sG++pNFZfDXmAoKwVnxr4SIFLogHmbsDv2v0w==
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781251227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zd/2XDt2d2T1aPB/6R7gW+LW/fbzlRJAGN7Vftc84uY=;
	b=A8hXz6rKAZz4uLXDhOE/3bQ3ZjrCt+RK2quKj5LkyxedCqZG1U5Ozwwpxxani2IaMvpgpQ
	o6KYsABVPDS3RIDp/iWD75aJEEaO+yt33HcIYDZFxECrGd16cWxefOZ0/7FetoG7l+6Mgb
	9rPp6HTaJUIqBpaF1yxYMWpOsUPG6fCiGdO3Ybhy9bv4s2azlvBzCXuZ6rF+8VB05ZZ+FX
	lEoYZmH87oiWw8ksws1poKPhN6/P7fV2dQV5XBnUO7JBX7k2ZAndVRNlPBBYRdrVXAQ5ew
	bjfWQh7POVFSOioa3M8w/4XzmP6ctcgOQOX469OGiAGb1LRnDHONrjyDz8eePg==
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	chrome-platform@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org (open list),
	linux-iio@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Manuel Ebner <manuelebner@mailbox.org>
Subject: [PATCH v2] Documentation: ABI: fix brackets and bracelets
Date: Fri, 12 Jun 2026 09:49:18 +0200
Message-ID: <20260612074916.169195-3-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kijqz7wworgbase6brz36s98ebuhqia5
X-MBO-RS-ID: cbc2a1a76c0e45f6b7f
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22153-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:jic23@kernel.org,m:dlechner@baylibre.com,m:nuno.sa@analog.com,m:andy@kernel.org,m:jgg@nvidia.com,m:leonro@nvidia.com,m:linux-rdma@vger.kernel.org,m:jdelvare@suse.com,m:tzungbi@kernel.org,m:briannorris@chromium.org,m:jwerner@chromium.org,m:chrome-platform@lists.linux.dev,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-iio@vger.kernel.org,m:rdunlap@infradead.org,m:manuelebner@mailbox.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[manuelebner@mailbox.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manuelebner@mailbox.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F127267793F

Fix missing and needless brackets and bracelets.
Fix minor grammar issues.

Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
---
[v1] -> [v2]
change from removing single bracket to adding missing bracket
add recipients
 Thanks Jonathan for researching the e-mail addresses.
use proper english punctuation in changelog
"is 64 bit counter" -> "is a 64-bit counter"

---
 Documentation/ABI/stable/sysfs-class-infiniband      |  8 ++++----
 Documentation/ABI/testing/sysfs-bus-iio              | 10 +++++-----
 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192   |  2 +-
 Documentation/ABI/testing/sysfs-firmware-dmi-entries |  2 +-
 Documentation/ABI/testing/sysfs-firmware-gsmi        |  2 +-
 Documentation/ABI/testing/sysfs-uevent               |  2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-class-infiniband b/Documentation/ABI/stable/sysfs-class-infiniband
index 694f23a03a28..7ba116103429 100644
--- a/Documentation/ABI/stable/sysfs-class-infiniband
+++ b/Documentation/ABI/stable/sysfs-class-infiniband
@@ -148,17 +148,17 @@ Description:
 		**Data info**:
 
 		port_xmit_data: (RO) Total number of data octets, divided by 4
-		(lanes), transmitted on all VLs. This is 64 bit counter
+		(lanes), transmitted on all VLs. This is a 64-bit counter
 
 		port_rcv_data: (RO) Total number of data octets, divided by 4
-		(lanes), received on all VLs. This is 64 bit counter.
+		(lanes), received on all VLs. This is a 64-bit counter.
 
 		port_xmit_packets: (RO) Total number of packets transmitted on
 		all VLs from this port. This may include packets with errors.
-		This is 64 bit counter.
+		This is a 64-bit counter.
 
 		port_rcv_packets: (RO) Total number of packets (this may include
-		packets containing Errors. This is 64 bit counter.
+		packets containing Errors). This is a 64-bit counter.
 
 		link_downed: (RO) Total number of times the Port Training state
 		machine has failed the link error recovery process and downed
diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d8d6d85235b0..4ea5598e7cd2 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -917,7 +917,7 @@ Description:
 
 		Note the driver will assume the last p events requested are
 		to be enabled where p is how many it supports (which may vary
-		depending on the exact set requested. So if you want to be
+		depending on the exact set requested). So if you want to be
 		sure you have set what you think you have, check the contents of
 		these attributes after everything is configured. Drivers may
 		have to buffer any parameters so that they are consistent when
@@ -973,7 +973,7 @@ Description:
 
 		Note the driver will assume the last p events requested are
 		to be enabled where p is however many it supports (which may
-		vary depending on the exact set requested. So if you want to be
+		vary depending on the exact set requested). So if you want to be
 		sure you have set what you think you have, check the contents of
 		these attributes after everything is configured. Drivers may
 		have to buffer any parameters so that they are consistent when
@@ -1528,9 +1528,9 @@ Description:
 		the unused bits, so to get a clean value the bits value must be
 		used to mask the buffer output value appropriately. The storagebits
 		value also specifies the data alignment. So s48/64>>2 will be a
-		signed 48 bit integer stored in a 64 bit location aligned to a 64
-		bit boundary. To obtain the clean value, shift right 2 and apply a
-		mask to zero the top 16 bits of the result.
+		signed 48-bit integer stored in a 64-bit location aligned to a
+		64-bit boundary. To obtain the clean value, shift right 2 and apply
+		a mask to zero the top 16 bits of the result.
 		For other storage combinations this attribute will be extended
 		appropriately.
 
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
index 28be1cabf112..d44eb5f8728b 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
@@ -16,7 +16,7 @@ Description:
 		In bridge applications, such as strain gauges and load cells,
 		the bridge itself consumes the majority of the current in the
 		system. To minimize the current consumption of the system,
-		the bridge can be disconnected (when it is not being used
+		the bridge can be disconnected (when it is not being used)
 		using the bridge_switch_en attribute.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltage2-voltage2_shorted_raw
diff --git a/Documentation/ABI/testing/sysfs-firmware-dmi-entries b/Documentation/ABI/testing/sysfs-firmware-dmi-entries
index b6c23807b804..ed7d9d06a9ff 100644
--- a/Documentation/ABI/testing/sysfs-firmware-dmi-entries
+++ b/Documentation/ABI/testing/sysfs-firmware-dmi-entries
@@ -93,7 +93,7 @@ Description:
 		  /sys/firmware/dmi/entries/15-0/system_event_log
 
 		and has the following attributes (documented in the
-		SMBIOS / DMI specification under "System Event Log (Type 15)":
+		SMBIOS / DMI specification under "System Event Log (Type 15)"):
 
 		- area_length
 		- header_start_offset
diff --git a/Documentation/ABI/testing/sysfs-firmware-gsmi b/Documentation/ABI/testing/sysfs-firmware-gsmi
index 7a558354c1ee..3b3c3ae6f458 100644
--- a/Documentation/ABI/testing/sysfs-firmware-gsmi
+++ b/Documentation/ABI/testing/sysfs-firmware-gsmi
@@ -19,7 +19,7 @@ Description:
 		/sys/firmware/gsmi/vars:
 
 			This directory has the same layout (and
-			underlying implementation as /sys/firmware/efi/vars.
+			underlying implementation) as /sys/firmware/efi/vars.
 			See `Documentation/ABI/*/sysfs-firmware-efi-vars`
 			for more information on how to interact with
 			this structure.
diff --git a/Documentation/ABI/testing/sysfs-uevent b/Documentation/ABI/testing/sysfs-uevent
index 0b6227706b35..c15e18c47a0e 100644
--- a/Documentation/ABI/testing/sysfs-uevent
+++ b/Documentation/ABI/testing/sysfs-uevent
@@ -8,7 +8,7 @@ Description:
 
                 Recognized extended format is::
 
-			ACTION [UUID [KEY=VALUE ...]
+			ACTION [UUID [KEY=VALUE ...]]
 
                 The ACTION is compulsory - it is the name of the uevent
                 action (``add``, ``change``, ``remove``). There is no change
-- 
2.54.0


