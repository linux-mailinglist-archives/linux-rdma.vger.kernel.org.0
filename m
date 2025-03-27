Return-Path: <linux-rdma+bounces-8999-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E83A72A19
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Mar 2025 07:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83A7E176DFC
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Mar 2025 06:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BA386331;
	Thu, 27 Mar 2025 06:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="JPP/KbVt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C055262BE
	for <linux-rdma@vger.kernel.org>; Thu, 27 Mar 2025 06:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743055890; cv=none; b=YiGKCV4HKRGSx1a1ssWMD4QQx2pdne9jWxDcs6lGzy5uKsgvhiY9cfUH31/RB53Z8FG9/JqjF/2C+0+eyM2KZD6ozJKjAyITZligux2qjWV76dGf3w40XYvqLpN2WDe9b4Ag6X3MxlFdJSAIYQhe00GbFNHa1kAQT8sbTvongGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743055890; c=relaxed/simple;
	bh=7oj0BjdX0O89EValJGCKa9iXR2sUVgaO9cAUb1dv864=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mLioUKCwedpb0uB1598UYrf+eDUNAZdI38xQaKef16YMmhVARqGHyKWRly3vspSgGYiIp68JlbXf+uGxBQpkQGdSHGpG7e/XoSSRdCSK0r43F2MWQOxm1znyZUMv++1sd5B9CgLUSrYbtMD4BMbykf+a2/QGNcnibuCcAUeGInI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=JPP/KbVt; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac3db77fda4so7488066b.1
        for <linux-rdma@vger.kernel.org>; Wed, 26 Mar 2025 23:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1743055885; x=1743660685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1MZf+ZSYR6fIPp4jsPiKvTkvw2gubQAjPggbDk/bBS4=;
        b=JPP/KbVt3VAveyaQYd2VHFrVMySnOgO6zn7PT2ZQT/Qat1ZufJru8CmAG0H8CLD0Rt
         dcssoMvNHd6aKp0J//vfuJKBrVZg/8k1glbuNTpef0H8lV73v1q8AxNgH0wTsuGFlfXB
         flqYfPFfYunjBEKomsUSoxXDIv2fuS4l1nusZqlXZ2c7vZ7k6IT/BYfxAcjivkaaed/d
         DH1QEpkUybz6i02/y3nOIxUI6mNTWe2DCPBWz0RYL6EZxT79YOaSJzxNpQfVbz42wXMr
         5oNVWjCntCPxQWJ06r0M26+P5nFZ9eMcz5JFnAewbP+UYFF0yHgfw35o+CXxlICvkSUV
         ZukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743055885; x=1743660685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1MZf+ZSYR6fIPp4jsPiKvTkvw2gubQAjPggbDk/bBS4=;
        b=nVQ4lA/FAmc/amHHmB/vS8ByX3Anp7TcWmLNOhbYf2QvbmBy+1lxmxcyr5qhrUHXFz
         7xR2ksWH1vSw1sJdv1b7md9zhTaJRNDHQZ2dPz+6IGWoEf+RtxRgJ8TXobKFfoseyF4E
         l2xA3uYhNpR3yo7OkIFCJbuF6ODAXYt6hSjjDiS/3DgsRgntulYM8MpYvRdrKX7/7s75
         KKxszZ1bCtOE56Gtfr8BlfD9fRRvkq1+W6ZG+98VFcpO2Kk2KMBcMxIruEs60keQ09uQ
         2arlox+H1T62HRfVY/TB85Rn4wc07uOxpnRXnZC8DHwl7zFdUnnZw93WbDHlP7Lr7eYA
         SG4g==
X-Forwarded-Encrypted: i=1; AJvYcCV9qmxTBiYqAEt/IXjjBMpc8gdZXedxi4XRocnI0IXNZ7wPSkTh6xXInGxWQrPHN2dO++avnZ9JRw+F@vger.kernel.org
X-Gm-Message-State: AOJu0YxLTfAofeGZf0rmLAp/WqlQTQ4z7wUCXSqzXzghusqWSr+h/Bya
	um2JPeui3mpewIyOfM5rcmFIWBbR9fheH5zggfVE4n+bKPIyrIvIrIdKZydkSX0=
X-Gm-Gg: ASbGnctwLpZhNA/+kc3MrQ0UQw1K2zQMaAvGxqmPn+lsHETCc8ogGXZY3oUj4D7tBna
	dqpytLpfYXxttNRiEsHP6qsWqwbzpAAR89iIVKOOFTFAtio+TRweYAVcW0DVa9WbaefEh41ylOv
	sejteLWdILSt4kpTt0bL0N40lKwCjLFbX2O5+t3zttaABIpEsAfjakmmFN3IPh/uytlJh44Q+WO
	YufrAZmlO5QJMLFUpM01BHbmYytP2qtlwcqCou1ClmVVshTJADu1XhkqWLxnPsk7aq/MXbZYbAl
	aC7QZqPYADo4s/QyvYyUfbuT2r1ChXJQmQbPGrp5m70k/36kaYB2YkI=
X-Google-Smtp-Source: AGHT+IHbWsSIAIW0UA1kZVQwwgRV3ZNaGr9o7plLVVIZ4ygGwbk/67YFocWuSYvzNriggXVQi0wNNg==
X-Received: by 2002:a17:906:c147:b0:abf:663b:22c5 with SMTP id a640c23a62f3a-ac701c34213mr53152666b.13.1743055884525;
        Wed, 26 Mar 2025 23:11:24 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:1460:e800:83eb:8e1c:ef0f:4d81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb64895sm1155894166b.113.2025.03.26.23.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 23:11:24 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: qemu-devel@nongnu.org,
	farosas@suse.de,
	peterx@redhat.com
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Yu Zhang <yu.zhang@ionos.com>,
	linux-rdma@vger.kernel.org,
	michael@flatgalaxy.com,
	Michael Galaxy <mrgalaxy@nvidia.com>
Subject: [PATCH] migration/rdma: Remove qemu_rdma_broken_ipv6_kernel
Date: Thu, 27 Mar 2025 07:11:23 +0100
Message-ID: <20250327061123.14453-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I hit following error which testing migration in pure RoCE env:
"-incoming rdma:[::]:8089: RDMA ERROR: You only have RoCE / iWARP devices in your
systems and your management software has specified '[::]', but IPv6 over RoCE /
iWARP is not supported in Linux.#012'."

In our setup, we use rdma bind on ipv6 on target host, while connect from source
with ipv4, remove the qemu_rdma_broken_ipv6_kernel, migration just work
fine.

Checking the git history, the function was added since introducing of
rdma migration, which is more than 10 years ago. linux-rdma has
improved support on RoCE/iWARP for ipv6 over past years. There are a few fixes
back in 2016 seems related to the issue, eg:
aeb76df46d11 ("IB/core: Set routable RoCE gid type for ipv4/ipv6 networks")

other fixes back in 2018, eg:
052eac6eeb56 RDMA/cma: Update RoCE multicast routines to use net namespace
8d20a1f0ecd5 RDMA/cma: Fix rdma_cm raw IB path setting for RoCE
9327c7afdce3 RDMA/cma: Provide a function to set RoCE path record L2 parameters
5c181bda77f4 RDMA/cma: Set default GID type as RoCE when resolving RoCE route
3c7f67d1880d IB/cma: Fix default RoCE type setting
be1d325a3358 IB/core: Set RoCEv2 MGID according to spec
63a5f483af0e IB/cma: Set default gid type to RoCEv2

So remove the outdated function and it's usage.

Cc: Peter Xu <peterx@redhat.com>
Cc: Li Zhijian <lizhijian@fujitsu.com>
Cc: Yu Zhang <yu.zhang@ionos.com>
Cc: qemu-devel@nongnu.org
Cc: linux-rdma@vger.kernel.org
Cc: michael@flatgalaxy.com
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Tested-by: Li zhijian <lizhijian@fujitsu.com>
Reviewed-by: Michael Galaxy <mrgalaxy@nvidia.com>
---
v1: drop RFC, fix build error (zhijian), collect Reviewed-by and Tested-by

 migration/rdma.c | 159 -----------------------------------------------
 1 file changed, 159 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 76fb0349238a..e228520b8e01 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -767,149 +767,6 @@ static void qemu_rdma_dump_gid(const char *who, struct rdma_cm_id *id)
     trace_qemu_rdma_dump_gid(who, sgid, dgid);
 }
 
-/*
- * As of now, IPv6 over RoCE / iWARP is not supported by linux.
- * We will try the next addrinfo struct, and fail if there are
- * no other valid addresses to bind against.
- *
- * If user is listening on '[::]', then we will not have a opened a device
- * yet and have no way of verifying if the device is RoCE or not.
- *
- * In this case, the source VM will throw an error for ALL types of
- * connections (both IPv4 and IPv6) if the destination machine does not have
- * a regular infiniband network available for use.
- *
- * The only way to guarantee that an error is thrown for broken kernels is
- * for the management software to choose a *specific* interface at bind time
- * and validate what time of hardware it is.
- *
- * Unfortunately, this puts the user in a fix:
- *
- *  If the source VM connects with an IPv4 address without knowing that the
- *  destination has bound to '[::]' the migration will unconditionally fail
- *  unless the management software is explicitly listening on the IPv4
- *  address while using a RoCE-based device.
- *
- *  If the source VM connects with an IPv6 address, then we're OK because we can
- *  throw an error on the source (and similarly on the destination).
- *
- *  But in mixed environments, this will be broken for a while until it is fixed
- *  inside linux.
- *
- * We do provide a *tiny* bit of help in this function: We can list all of the
- * devices in the system and check to see if all the devices are RoCE or
- * Infiniband.
- *
- * If we detect that we have a *pure* RoCE environment, then we can safely
- * thrown an error even if the management software has specified '[::]' as the
- * bind address.
- *
- * However, if there is are multiple hetergeneous devices, then we cannot make
- * this assumption and the user just has to be sure they know what they are
- * doing.
- *
- * Patches are being reviewed on linux-rdma.
- */
-static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
-{
-    /* This bug only exists in linux, to our knowledge. */
-#ifdef CONFIG_LINUX
-    struct ibv_port_attr port_attr;
-
-    /*
-     * Verbs are only NULL if management has bound to '[::]'.
-     *
-     * Let's iterate through all the devices and see if there any pure IB
-     * devices (non-ethernet).
-     *
-     * If not, then we can safely proceed with the migration.
-     * Otherwise, there are no guarantees until the bug is fixed in linux.
-     */
-    if (!verbs) {
-        int num_devices;
-        struct ibv_device **dev_list = ibv_get_device_list(&num_devices);
-        bool roce_found = false;
-        bool ib_found = false;
-
-        for (int x = 0; x < num_devices; x++) {
-            verbs = ibv_open_device(dev_list[x]);
-            /*
-             * ibv_open_device() is not documented to set errno.  If
-             * it does, it's somebody else's doc bug.  If it doesn't,
-             * the use of errno below is wrong.
-             * TODO Find out whether ibv_open_device() sets errno.
-             */
-            if (!verbs) {
-                if (errno == EPERM) {
-                    continue;
-                } else {
-                    error_setg_errno(errp, errno,
-                                     "could not open RDMA device context");
-                    return -1;
-                }
-            }
-
-            if (ibv_query_port(verbs, 1, &port_attr)) {
-                ibv_close_device(verbs);
-                error_setg(errp,
-                           "RDMA ERROR: Could not query initial IB port");
-                return -1;
-            }
-
-            if (port_attr.link_layer == IBV_LINK_LAYER_INFINIBAND) {
-                ib_found = true;
-            } else if (port_attr.link_layer == IBV_LINK_LAYER_ETHERNET) {
-                roce_found = true;
-            }
-
-            ibv_close_device(verbs);
-
-        }
-
-        if (roce_found) {
-            if (ib_found) {
-                warn_report("migrations may fail:"
-                            " IPv6 over RoCE / iWARP in linux"
-                            " is broken. But since you appear to have a"
-                            " mixed RoCE / IB environment, be sure to only"
-                            " migrate over the IB fabric until the kernel "
-                            " fixes the bug.");
-            } else {
-                error_setg(errp, "RDMA ERROR: "
-                           "You only have RoCE / iWARP devices in your systems"
-                           " and your management software has specified '[::]'"
-                           ", but IPv6 over RoCE / iWARP is not supported in Linux.");
-                return -1;
-            }
-        }
-
-        return 0;
-    }
-
-    /*
-     * If we have a verbs context, that means that some other than '[::]' was
-     * used by the management software for binding. In which case we can
-     * actually warn the user about a potentially broken kernel.
-     */
-
-    /* IB ports start with 1, not 0 */
-    if (ibv_query_port(verbs, 1, &port_attr)) {
-        error_setg(errp, "RDMA ERROR: Could not query initial IB port");
-        return -1;
-    }
-
-    if (port_attr.link_layer == IBV_LINK_LAYER_ETHERNET) {
-        error_setg(errp, "RDMA ERROR: "
-                   "Linux kernel's RoCE / iWARP does not support IPv6 "
-                   "(but patches on linux-rdma in progress)");
-        return -1;
-    }
-
-#endif
-
-    return 0;
-}
-
 /*
  * Figure out which RDMA device corresponds to the requested IP hostname
  * Also create the initial connection manager identifiers for opening
@@ -955,7 +812,6 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
 
     /* Try all addresses, saving the first error in @err */
     for (struct rdma_addrinfo *e = res; e != NULL; e = e->ai_next) {
-        Error **local_errp = err ? NULL : &err;
 
         inet_ntop(e->ai_family,
             &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, sizeof ip);
@@ -964,13 +820,6 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
         ret = rdma_resolve_addr(rdma->cm_id, NULL, e->ai_dst_addr,
                 RDMA_RESOLVE_TIMEOUT_MS);
         if (ret >= 0) {
-            if (e->ai_family == AF_INET6) {
-                ret = qemu_rdma_broken_ipv6_kernel(rdma->cm_id->verbs,
-                                                   local_errp);
-                if (ret < 0) {
-                    continue;
-                }
-            }
             error_free(err);
             goto route;
         }
@@ -2663,7 +2512,6 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
 
     /* Try all addresses, saving the first error in @err */
     for (e = res; e != NULL; e = e->ai_next) {
-        Error **local_errp = err ? NULL : &err;
 
         inet_ntop(e->ai_family,
             &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, sizeof ip);
@@ -2672,13 +2520,6 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
         if (ret < 0) {
             continue;
         }
-        if (e->ai_family == AF_INET6) {
-            ret = qemu_rdma_broken_ipv6_kernel(listen_id->verbs,
-                                               local_errp);
-            if (ret < 0) {
-                continue;
-            }
-        }
         error_free(err);
         break;
     }
-- 
2.43.0


