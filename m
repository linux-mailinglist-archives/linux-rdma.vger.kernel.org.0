Return-Path: <linux-rdma+bounces-8965-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC4CA71426
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 10:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4683A4107
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 09:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A8C1A7262;
	Wed, 26 Mar 2025 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="JirwgTZI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62A0189919
	for <linux-rdma@vger.kernel.org>; Wed, 26 Mar 2025 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742982751; cv=none; b=VBk4gyjkopDpeGGtQ+AX+UwcHXCryvGTstz7DPkLl9caArE79fo0otQpR7DCbA2SGT27rqKcKmSvbp8njI/bdg9JRXy7JUidLfrWSC3uzvO+MlS89zqL0WCRipbg2udWGeJkjidCo/AzdXcenBDEE1pIWSLFuXcBuByqBVDRrsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742982751; c=relaxed/simple;
	bh=SC/vrtkqzSyMjB8AlFFgkPi6AWrx818ItMyZtkrEEb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQSE9js6dKnvCXMjX5eUFvDwL4Fp0IbYioJkz4Ps7pqwehO5dqO8Ka7rgI3M6/byEFub3ltud3v7JuKygR/tSvWpMRnerAsWbJA4ZR063CK37tmZg2Lp9b3tUZj21i5C05frs8ESupcnahR8zXRvy7iSHH6+IgVT9njLVUzns4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=JirwgTZI; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3978ef9a778so328697f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 26 Mar 2025 02:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1742982746; x=1743587546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fYv/+j/ZIsFHETZr3Kpyp7xertxIvS+ljCMnTlxQff4=;
        b=JirwgTZIoxh2Y4INusB6Mo1fu05p289LAltZQdVCXp/r0Dw3FVJMy9TV9x5OPW9cTa
         bxfqoaYvJwWg9/tdIWmftmYL80KG09LivoldEJ/8iC+2wcdhWoYUho4JqURIl2RDqlpx
         JpEjsd7N2jqdLj4dn1WH9zeUyGw6TunQJGXw5jF+bamYC8Frb5y/8j9anNYM0/pHMrbn
         bXvTdHQxlyM3tI4ZOhk97qOoHpGUHzC/dCrBVym3IrjMovL+3v8tAHawYzOzj5u39nWW
         3xfIbYc6Yn98LpembmCP97r4wMLIlE/7qTAqoPtK071LLsIOTwJcBplb1juSC4byFs8Q
         0piA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742982746; x=1743587546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYv/+j/ZIsFHETZr3Kpyp7xertxIvS+ljCMnTlxQff4=;
        b=Cyp8IooYiJSOxwG2GFWk8rJIF1Xf4csAS1AyF7UVEKLNvFmdIlRzkuVu60fgg+i4+4
         kooPwPte1SX26uNh5OmWq0h2hXSkwHzo5u8Z8pbH0tlTpnNFkR/5+abHuwHW43KyMyDG
         OjvlkucA6fNc7lXqA8cYkk5/thYFTDOIQF3MEeZYyTiexdhGH5tmDV1D1i5x5BTzJPXn
         AqOYJDL6F5Kjyk/yO2kMYTv8KlIt/UqRVOk9rG7IhP8GwqN7795lpE4+ByL4mKNIiCOa
         1HpgZmnRNvfZSWbG7IhkLy769PU7QZSZ2hPX3em82sjnlIkvidjDtCWKYsl2xeJs8lUS
         RdZg==
X-Forwarded-Encrypted: i=1; AJvYcCXxjgpsDaZ0qna9LOtGH27UYyWUzmMZIlvX8SEYKZkBy2oQUJkEvOtcYRerJCvouDt/si2DaWEFUwDz@vger.kernel.org
X-Gm-Message-State: AOJu0YwHM+u+mOs7z9v4ygAjvHV2UE5m+eI6dqkFhusLM2PJTyyqjwvS
	RM+aWYgR5slob7fbD24svxO+ad7zoRRPTqz0dgLOIOqZ2EjIOGyhuJPgw8Jo4RI=
X-Gm-Gg: ASbGnctZv57/EFUCQ4Ri9xOvyzM3L6WD/xqakzQMkaYoam4aPB+Tf4yn6+nmEytIcV2
	HCslLlYsL4rGxIMqElArhb1a5VQkn8h2wTrikRVK5VP+7X/x93JMa77akOM4qnWyPhZN8Ystgm6
	8INRndly4kH60/F/KsWl3+uC0XDgHsQG8Y748aLnVGXc8+4fPukVuAPXCeuvJ3wmJk0AvHAPitG
	/zzfuLZnevzlxzf1NVHecRvUdx+uAxyS8fcHxtfXuX1Jfg47z8WIr3lf28leou2NmULg7toBDKB
	hcmAbqIEtmfrK7dozmaVkkfHuBVllvxbK86gYjMIS69vAuF3zbhNnz5xxOoPCWsgxvU=
X-Google-Smtp-Source: AGHT+IEuAjg/Mj2CyfTUYpQWtNBNkvgahfQSjNDPUoeXO5J7ktV2jMV4YG52AkzJvkT+dyPIn9JSoQ==
X-Received: by 2002:a5d:64c6:0:b0:390:dba1:9589 with SMTP id ffacd0b85a97d-3997f936773mr7288811f8f.8.1742982745943;
        Wed, 26 Mar 2025 02:52:25 -0700 (PDT)
Received: from lb02065.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b409fsm16576812f8f.50.2025.03.26.02.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 02:52:25 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: qemu-devel@nongnu.org,
	farosas@suse.de,
	peterx@redhat.com
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Yu Zhang <yu.zhang@ionos.com>,
	linux-rdma@vger.kernel.org,
	michael@flatgalaxy.com
Subject: [RFC PATCH] migration/rdma: Remove qemu_rdma_broken_ipv6_kernel
Date: Wed, 26 Mar 2025 10:52:24 +0100
Message-ID: <20250326095224.9918-1-jinpu.wang@ionos.com>
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
---
 migration/rdma.c | 157 -----------------------------------------------
 1 file changed, 157 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 76fb0349238a..5ce628ddeef0 100644
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
@@ -964,13 +821,6 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
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
@@ -2672,13 +2522,6 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
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


