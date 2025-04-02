Return-Path: <linux-rdma+bounces-9108-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 836E9A78785
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 07:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E01188EF8F
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 05:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDD1230264;
	Wed,  2 Apr 2025 05:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fIslwTRI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07F7C8E0
	for <linux-rdma@vger.kernel.org>; Wed,  2 Apr 2025 05:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743570792; cv=none; b=C0xC32G3wWeDfiLk4pXZ+szXHD24ky0/xESnQT5EcucHVj6dcoMGoUI/KwWd1iJBWzLVa3lPGLVNdQbO7CxiDo9YGz8HxiNWJb72dNq29PedldZSU75lHEWUR/jdZjLN4moG0VATItxFsFREKJmBy1pkX/2BjlLp5PcK4OpWfzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743570792; c=relaxed/simple;
	bh=W66exUIMNBtEFIhxp7DTcrSwqlt3v/IgPB8bZiBnb18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gaSrmRCF6KqSM+q6MasV3zn0QM9HiGI8xwOfdAAEExhLBracx/tZNrgFylF4vX+rrokEQM9unEaR5/lCey3tfHv+h8eNsTHWHLKq1NGRVE8yZ+1DCiLtnJDgUD60Szn2RV1EfD26uGgNVvKoAP+9B+heu4+PYd2VCV0GEFWFF6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fIslwTRI; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5b736b3fcso1201806a12.1
        for <linux-rdma@vger.kernel.org>; Tue, 01 Apr 2025 22:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1743570787; x=1744175587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tfdn2BU+wITp9h9wEQwWjMQLjmnHPR09C0F2fGaiGF8=;
        b=fIslwTRIo0TUuaVSPKNGfgqNnqirpAXPulAG+DEK1sLWmHtWUW7KprdqgsUd5YxZML
         SmvlAzlqslqKRlrRsPYw+rR0ZZMiTO7WG3y7P6Y1EWkzOkQcXtyUgbMLSUw8825PD69m
         uoXcebtg8HG7gpTZhTswi0fSFbRsxgeZSCuL/sfBWDzBeDQnJtMXZGAjs1MevkOijrDv
         5gg3u8kNtz0pZDDGr+6/CqY1E1MtFch5f3+w++zK1tHXA3uD/jDq59ozGGzduhLliP5z
         L4ADXpSL1vPruJmfySDTT7OCOBsWL7lXEn0bhSm1fgP0J3KiEf9D9cgXITmMKjtNr0L6
         Q2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743570787; x=1744175587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tfdn2BU+wITp9h9wEQwWjMQLjmnHPR09C0F2fGaiGF8=;
        b=upnO0jgTVTyr1szuphr7CCRAzvzuipv/WcfcLIpB8J/pnAumd/v8pWWjZtgeFeZd0R
         oYL+/tv29GU525KbxbRdOuVTPdP/Jde+0i32cq4jANycu7KLlbEyeLp1uYlVlBe9njR8
         L2kPmlqv+UTnd8D8ZwUntCjZ2+4aCL6oL+4g8PnlRcyRtlGn5ZyRZFMp6X3X969Q9o37
         NQlYqbxZ0Al0SbbkI/N2GrXmP7y7ZCBlN49tfY6GAGIKEYfkb/Pv2gggQG4GsIf1zJ6f
         IW8jCHKsM5jRlvtnhD3F5EddUQhmrDzWh/0TM1s/w8qWo/KTHmTmuGqhBm3c6fn+UMYY
         ZcNg==
X-Gm-Message-State: AOJu0YwnDvI/5M3BdzOJ6uY/ojduS1spsg7ZrZeGnBnqeaF6WHCeJtkd
	NwY3cH7F0VrchyMB59sTxYQcH1mCtzBZlGtMpOU2ZgHhg4qJlbOayPRDXRk8Ba5TKHjOUWVUSre
	G
X-Gm-Gg: ASbGncuzgqIZ1Epmtd/jY6sOOh7qehDCkt6Acbi82Fulot0cglTWLFs3EPJOnPMn7GS
	sxwcms/oK42Xd4rn+aNrL4I0we7uHmU13jJTUAWHQJLPDQ1UpwCMYOSIXO/XJ761gNgks6U5moi
	4Kv1fhaAVHtub4DruLCIYmMnrb/I0C/vgyra1D/OEHeZFzk4KX3tmgcKa5c3ngHjXkRM3psWAIM
	tbVNYToB0I2+nNdjeFWW54Ut724K7/YJS1WfMWoxcEmRgkitMPXe4+TZykipGaBFlorw1CsNh83
	CCl1sMDWkd6lQIHyNIxmLXY/my0nCGTLCLNoXbQTyKBIGVLmAeSi38Y=
X-Google-Smtp-Source: AGHT+IGZQklArU44+6jqyQBLkNUPkS8PGaCrdODkUXOFf7PFIkWqoyaG4U1TJTTIelPExgY1dlbhxA==
X-Received: by 2002:a05:6402:34c9:b0:5e8:eaa9:23c3 with SMTP id 4fb4d7f45d1cf-5f03d952b74mr1320773a12.10.1743570787353;
        Tue, 01 Apr 2025 22:13:07 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:1475:3300:fdc6:d1d1:b89d:5668])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc17b2ea0sm7897118a12.53.2025.04.01.22.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 22:13:07 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: Peter Xu <peterx@redhat.com>,
	Li Zhijian <lizhijian@fujitsu.com>,
	Yu Zhang <yu.zhang@ionos.com>,
	qemu-devel@nongnu.org,
	michael@flatgalaxy.com,
	Michael Galaxy <mrgalaxy@nvidia.com>
Subject: [PATCHv2] migration/rdma: Remove qemu_rdma_broken_ipv6_kernel
Date: Wed,  2 Apr 2025 07:13:06 +0200
Message-ID: <20250402051306.6509-1-jinpu.wang@ionos.com>
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
Cc: Fabiano Rosas <farosas@suse.de
Cc: qemu-devel@nongnu.org
Cc: linux-rdma@vger.kernel.org
Cc: michael@flatgalaxy.com
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Tested-by: Li zhijian <lizhijian@fujitsu.com>
Reviewed-by: Michael Galaxy <mrgalaxy@nvidia.com>
---
v2: cleanup unused err, update comment (Fabiano)
v1: drop RFC, fix build error (zhijian), collect Reviewed-by and Tested-by

 migration/rdma.c | 178 +----------------------------------------------
 1 file changed, 3 insertions(+), 175 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 143008a28a20..35cd3e1a2976 100644
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
@@ -917,7 +774,6 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
  */
 static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
 {
-    Error *err = NULL;
     int ret;
     struct rdma_addrinfo *res;
     char port_str[16];
@@ -953,9 +809,8 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
         goto err_resolve_get_addr;
     }
 
-    /* Try all addresses, saving the first error in @err */
+    /* Try all addresses, exit loop on first success of resolving address */
     for (struct rdma_addrinfo *e = res; e != NULL; e = e->ai_next) {
-        Error **local_errp = err ? NULL : &err;
 
         inet_ntop(e->ai_family,
             &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, sizeof ip);
@@ -964,25 +819,12 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
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
-            error_free(err);
             goto route;
         }
     }
 
     rdma_freeaddrinfo(res);
-    if (err) {
-        error_propagate(errp, err);
-    } else {
-        error_setg(errp, "RDMA ERROR: could not resolve address %s",
-                   rdma->host);
-    }
+    error_setg(errp, "RDMA ERROR: could not resolve address %s", rdma->host);
     goto err_resolve_get_addr;
 
 route:
@@ -2611,7 +2453,6 @@ err_rdma_source_connect:
 
 static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
 {
-    Error *err = NULL;
     int ret;
     struct rdma_cm_id *listen_id;
     char ip[40] = "unknown";
@@ -2661,9 +2502,8 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
         goto err_dest_init_bind_addr;
     }
 
-    /* Try all addresses, saving the first error in @err */
+    /* Try all addresses*/
     for (e = res; e != NULL; e = e->ai_next) {
-        Error **local_errp = err ? NULL : &err;
 
         inet_ntop(e->ai_family,
             &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, sizeof ip);
@@ -2672,24 +2512,12 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
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
-        error_free(err);
         break;
     }
 
     rdma_freeaddrinfo(res);
     if (!e) {
-        if (err) {
-            error_propagate(errp, err);
-        } else {
             error_setg(errp, "RDMA ERROR: Error: could not rdma_bind_addr!");
-        }
         goto err_dest_init_bind_addr;
     }
 
-- 
2.43.0


