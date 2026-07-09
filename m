Return-Path: <linux-rdma+bounces-22955-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YWU4HoxwT2oCgwIAu9opvQ
	(envelope-from <linux-rdma+bounces-22955-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 11:57:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F42172F367
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 11:57:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=JZ5i9Tay;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22955-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22955-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AAF85304B41E
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 09:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3278403AE1;
	Thu,  9 Jul 2026 09:56:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA84403EA1
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2026 09:56:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590975; cv=none; b=FxgOIZ9mI2vardToo7CY6hivM/c+CcNG9WeG3ifuv4z+b5I6nleMjcDO/yrTcfFC0m5Bcz4G6sqOIMQhXy4C0Z+/oDru45ydufC8y7XloBNbjLvieg6vo70HpQlpdQM/uVWuQFoszEcsl1tQcBrQEN3QjidIPuojr2uv0s4G26s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590975; c=relaxed/simple;
	bh=y0ueD2HhhO9sYx46zBe6GC0lC01oe7J7EHAcGkoIfh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOLhmLipwIQfI8zzUPayN5kzAqzhnEebTNK9kX0WBWb0fC4nBIPrbelh2Dnhygw6b0YdpJp3f/G6kJEAyaxSJ7v/dxeCHfPzliAhrDzhBqbOMGCpsQZFzo9M/meThYp9REXOMx9vGRVi1TMrxvANVwvN/zgoYZi9uVoofSJA7C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=JZ5i9Tay; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493e8d4f4dcso8764905e9.0
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jul 2026 02:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590972; x=1784195772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MQWstozVIG97I2bGchwtRWDPF++c2QX2x/LEEkoUKs4=;
        b=JZ5i9TayqfK9QDaV483kelEywHyKCmkriCfBpd7K8DN5YpPk2aQi7z28+jFnMObuRe
         esNGGiSrcNJAVK+8Ex1ueSgOitMpe+rkRHCH3fGfW4eXakRl+fJt8nmMlykYDVFJ95KQ
         faF2515egiE7jA1eALwi3ILuJxd5dWxMHgZPZEPIRbWDFBquVPj5+H9X3EqEHRHboSKu
         9vgq1b78NAK2tHHZimh3SidH+QD0lkaj9iNIDSEEMqOhtX5W/eKM4WHc/6615I7tTbFw
         R1DlBquI+M9bEpkOxLZqqsW71vUrODGTXFejcVORq19VsrehURVcJT1jq7OMgkFuh7+1
         r1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590972; x=1784195772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MQWstozVIG97I2bGchwtRWDPF++c2QX2x/LEEkoUKs4=;
        b=IAVZildbukeu8D0ZXlXmQDhEhrk8TpywDikhitJWujoTmt0V3MpYtbCLNNPauJz9f0
         loE3/wAFHD9hZybE1xZzBVbtdP9rHbYvD+pXCRQtOwh7BGq33tGXqVznNS8xPm4HAx6s
         YRgrngQq4b/CMdDXfeXPlM66vUIU3pqMswdfklanuKUS8w5Hd7dHUXoESiyvJ5Fh4+5x
         1wxIKaH0houxkq/uZ3YxxoiliY+N9+LOU6rjro9ldrEg2Iavs5qC16pLsIDrSs2F8HOL
         AwqQIKf+UTkv0uB/Ap9U06XJjKPEQAVmEUta5rHJQM05Cnd4ChizaLTv22437r/gj39l
         3eTw==
X-Gm-Message-State: AOJu0Yy4Ur3XdUy5ibG2qWVGQO+cSFqs7HLi6gZYiQ4nujZ+NvQG6swP
	Mbld3bWOTsrRg0nYM/gH56Y9Tc9z0AB7o0mUvpdaD+1z/ujR05ZBEoi+HhIWM2P4FPe0csXFyTv
	IU2r2
X-Gm-Gg: AfdE7cmSiCHgBnby94e+AntMaAl2lAil86oyZXjyBzNiOqDA9QaplCFd44PKVui/EtR
	O6WmR8l7kR/E876QPU/Fv23/EaLpktwJy3j1I7VJg8pIhrF8QMTeDuCfvmn35sdZzNipDHXtbIt
	IhPcuI4AtyfxivkOIxW2Q1mg9RIVwSPkUDnVZTWonOaE8SQWQGK497HUIncdzrKW4+x8I7GdIJW
	F52hcgi8u0TPOP1nLAJyAp4+tufuI6dF22tKBk53VKpi+CGPt4R0qaoPiCjzn72xK7AT1gcJyWS
	wHLcJxFIqrpjUKnnGZjDlYcwPU3IjlQz6NanpnOaIYWA5zjdEjB4PTNedeDk6LqHoWEHTu9tSom
	VAM7+YOFX3kDEt8W9dMkuSVpkZjgLIjaPoKFKtP75WYqV82euYKWUNR1MpmeauVMNhtlA2qFLA7
	n6GtfORKRXB37YNu3S3XDm1A==
X-Received: by 2002:a05:600d:844f:20b0:493:c77c:108a with SMTP id 5b1f17b1804b1-493e68a1dc1mr47714715e9.36.1783590972300;
        Thu, 09 Jul 2026 02:56:12 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a572c3sm142014615e9.1.2026.07.09.02.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:56:11 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	cmeiohas@nvidia.com,
	roman.gushchin@linux.dev,
	bvanassche@acm.org,
	zyjzyj2000@gmail.com,
	shuah@kernel.org,
	tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Subject: [PATCH rdma-next 11/13] RDMA/core: Make device names unique per net namespace
Date: Thu,  9 Jul 2026 11:55:30 +0200
Message-ID: <20260709095532.855647-12-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709095532.855647-1-jiri@resnulli.us>
References: <20260709095532.855647-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22955-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,nvidia.com,linux.dev,acm.org,gmail.com,suse.com,cmpxchg.org,linux.alibaba.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:cgroups@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:parav@nvidia.com,m:mbloch@nvidia.com,m:cmeiohas@nvidia.com,m:roman.gushchin@linux.dev,m:bvanassche@acm.org,m:zyjzyj2000@gmail.com,m:shuah@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:hannes@cmpxchg.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid,resnulli.us:from_mime,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F42172F367

From: Jiri Pirko <jiri@nvidia.com>

Use rdma_dev_access_netns() to scope RDMA device name lookup and "%d" name
allocation to the relevant net namespace. Keep shared mode and
CONFIG_NET_NS=n behaviour system-wide.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/device.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 3ccf4731154a..cffb0de1c001 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -129,7 +129,7 @@ static DECLARE_RWSEM(rdma_nets_rwsem);
 bool ib_devices_shared_netns = true;
 module_param_named(netns_mode, ib_devices_shared_netns, bool, 0444);
 MODULE_PARM_DESC(netns_mode,
-		 "Share device among net namespaces; default=1 (shared)");
+		 "Share device among net namespaces; default=1 (shared). In exclusive mode device names are unique per net namespace");
 /**
  * rdma_dev_access_netns() - Return whether an rdma device can be accessed
  *			     from a specified net namespace or not.
@@ -359,7 +359,8 @@ static struct ib_device *__ib_device_get_by_name(const char *name,
 	unsigned long index;
 
 	xa_for_each (&devices, index, device)
-		if (!strcmp(name, dev_name(&device->dev)))
+		if (rdma_dev_access_netns(device, net) &&
+		    !strcmp(name, dev_name(&device->dev)))
 			return device;
 
 	return NULL;
@@ -437,7 +438,11 @@ int ib_device_set_dim(struct ib_device *ibdev, u8 use_dim)
 	return 0;
 }
 
-/* Pick a free index for the '%d' style @name pattern. */
+/*
+ * Pick a free index for the '%d' style @name pattern within net namespace
+ * @net. Returns the index on success or a negative errno. The caller builds
+ * the final unique device name from the returned index.
+ */
 static int __alloc_name_id(struct net *net, const char *name,
 			   const struct ib_device *skip)
 {
@@ -452,7 +457,7 @@ static int __alloc_name_id(struct net *net, const char *name,
 	xa_for_each (&devices, index, device) {
 		char buf[IB_DEVICE_NAME_MAX];
 
-		if (device == skip)
+		if (device == skip || !rdma_dev_access_netns(device, net))
 			continue;
 		if (sscanf(dev_name(&device->dev), name, &i) != 1)
 			continue;
@@ -1240,7 +1245,8 @@ static __net_init int rdma_dev_init_net(struct net *net)
 }
 
 /*
- * Assign the unique string device name and the unique device index. This is
+ * Assign the unique string device name and the unique device index. The device
+ * name is unique within the net namespace the device is assigned to. This is
  * undone by ib_dealloc_device.
  */
 static int assign_name(struct ib_device *device, const char *name)
@@ -1424,8 +1430,9 @@ static void ib_device_notify_register(struct ib_device *device)
 /**
  * ib_register_device - Register an IB device with IB core
  * @device: Device to register
- * @name: unique string device name. This may include a '%' which will
- * 	  cause a unique index to be added to the passed device name.
+ * @name: device name, unique within the device's net namespace. This may
+ *	  include a '%' which will cause a unique index to be added to the
+ *	  passed device name.
  * @dma_device: pointer to a DMA-capable device. If %NULL, then the IB
  *	        device will be used. In this case the caller should fully
  *		setup the ibdev for DMA. This usually means using dma_virt_ops.
@@ -1716,6 +1723,7 @@ static bool rdma_dev_name_in_netns(struct ib_device *skip, struct net *net,
 
 	xa_for_each(&devices, index, device)
 		if (device != skip &&
+		    rdma_dev_access_netns(device, net) &&
 		    !strcmp(name, dev_name(&device->dev)))
 			return true;
 
-- 
2.54.0


