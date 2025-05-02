Return-Path: <linux-rdma+bounces-9952-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5535DAA777F
	for <lists+linux-rdma@lfdr.de>; Fri,  2 May 2025 18:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B352C468592
	for <lists+linux-rdma@lfdr.de>; Fri,  2 May 2025 16:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1448425DD16;
	Fri,  2 May 2025 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMrS9OD7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1531EEE6
	for <linux-rdma@vger.kernel.org>; Fri,  2 May 2025 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204129; cv=none; b=NLcr7+IoaWjKGGTlKq/tdNqPys9rOqzO/nRZrImwfpvVQEu/w9r6FJirToxmpTY5NMRJVSm3Ikno+iX6QHD+7oXGI1mZyJ1WDeAYKeSEkFlbC44NJzuiHE4r2zfJyhWXV09Y3UNwGPF/HcW0tMYEbUE/LVvQr63zDAgbkBgMfJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204129; c=relaxed/simple;
	bh=9nnEA3NydnV0mgGZg4IXn/W1XUlu3f00qPYvIHVy8qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JV6yAK90nxZZmbVpgI9H7N2+DFskMLzDkk7W05J6/c4N+GOJwmlVwjJ8DnWDdiEnZUzA4y/19BK43ynOZoN/mgugqOAoZtQIb9az2irHsMD+ogrt5wOZ+9S/7n76OCnwlTO/ksroN+u6TtXFn09p39INdzkIYK9EgMEyPZ24Wz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cMrS9OD7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746204126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nQ6LGo3EmUQNiuDdGer7Pnmf83Ixx9VZUInNoC4VPuU=;
	b=cMrS9OD7Ohm9akCbpBtX9l09M4dylP2yF/fV4dgEnaZ6ijUOQgNB749t9CXZuqIMZKXs9S
	+QgvgYTgJ2q+faMwF5vBLLmjWUpyb8YpF3sxq1fxkm1EsHn5iDokj1ZmvYjteGxXTyOTNy
	kUtx96qgmrEUWqy7VyLb3s8CFsBL1bQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-o2Cw-VNbOtm8ofxPB-f3Sg-1; Fri, 02 May 2025 12:42:05 -0400
X-MC-Unique: o2Cw-VNbOtm8ofxPB-f3Sg-1
X-Mimecast-MFC-AGG-ID: o2Cw-VNbOtm8ofxPB-f3Sg_1746204125
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-47699e92ab0so46674731cf.0
        for <linux-rdma@vger.kernel.org>; Fri, 02 May 2025 09:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746204125; x=1746808925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQ6LGo3EmUQNiuDdGer7Pnmf83Ixx9VZUInNoC4VPuU=;
        b=E/9ryNPMkoWmubU6jj1mFBH0iB9ZKJN23csQGI0oU38j7n5AnRk8e1W0YzOQyrdD64
         zgP/BTvIJK9VN7DlnVY/TJvT1g3exYtV/ssZYNvvZJbzk5sy3AUvz1Ahpw/UMbF9/lCa
         B5RUPU55od1219qLvZOMeYeYKZQ/NgcHQMYMUGIbo1ZOj5uK4fqrEwymuuAlEF6rXtk6
         tTfc0kIQNyBh4yMKNbOKi8yyqszuEMLn/Tr0V8urP/nBbs3Kf/QkSEvKpei2WLRqkDNy
         WiT4jscsEpV5s4P+UbImcKwXA1lUFCo44gZDKvIwzCNCOM/3FKTZkog6vWVyZjijoORT
         cZ8g==
X-Forwarded-Encrypted: i=1; AJvYcCXpEwMBUKhg5+oS9ng/EjAoEarTtBsnrgn2dzpoxsQuZydOae5nvl3foxUYvwj62h3lv/llyl8GVaQ6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0OtI6C0Xy3a43rBFfF2q5QwArL9P6Q5EKdzm3froWuaKedbn9
	UFPYqgXPhGqvKfgmehm1EATp82Xbc7Vc64KcEdcbVv1grclGA1rlODHKg/4dEOIB+QtN+CiFvnr
	YJsnkNmcZLVRoPWvH5WsH9SuRoYHtCtlRzDqfok6dvEmwhoFkY3JU0Nx8RSU=
X-Gm-Gg: ASbGncsa4a9YKYSv4iooXuRSkqXlUePcF6NW9k99592Uh8g2xQF2/M7PX9Bauay7LAZ
	hFp6NDlSXQDh7/HsYbKpWqgO5wj0KDBqK3e99Nm84mJQfBDkYcj1+rpDuxNCP5/1sXNFYPZcJPD
	w5xquLMFOtAzJd90RZSHgchhqKD/bILSCSSaMHhFeDAmsWmH3JJ140zeQt7CVzvDnDyNGyCBSvu
	14GsEOPkjcoO91wM9Hvp+O1NCFfLhsC4/yzoUvpw8E1sTijpbdnWBrupA9yFWnZDzX5ZI8paCu7
X-Received: by 2002:a05:622a:ed5:b0:48b:5656:bb01 with SMTP id d75a77b69052e-48c311649cfmr39084001cf.10.1746204125052;
        Fri, 02 May 2025 09:42:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYLdRbciPNTI8T2YmCs7k44odWgi3wpbc6/Iw57N6IsUYOnrdyJ+dZuiBRoWddHNXCnzQ6tw==
X-Received: by 2002:a05:622a:ed5:b0:48b:5656:bb01 with SMTP id d75a77b69052e-48c311649cfmr39083691cf.10.1746204124694;
        Fri, 02 May 2025 09:42:04 -0700 (PDT)
Received: from x1.com ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cad23d1c8dsm203108385a.60.2025.05.02.09.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 09:42:02 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	peterx@redhat.com,
	Jack Wang <jinpu.wang@ionos.com>,
	Li Zhijian <lizhijian@fujitsu.com>,
	Yu Zhang <yu.zhang@ionos.com>,
	linux-rdma@vger.kernel.org,
	michael@flatgalaxy.com,
	Michael Galaxy <mrgalaxy@nvidia.com>
Subject: [PULL 13/14] migration/rdma: Remove qemu_rdma_broken_ipv6_kernel
Date: Fri,  2 May 2025 12:41:40 -0400
Message-ID: <20250502164141.747202-14-peterx@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250502164141.747202-1-peterx@redhat.com>
References: <20250502164141.747202-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Wang <jinpu.wang@ionos.com>

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
Cc: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Cc: linux-rdma@vger.kernel.org
Cc: michael@flatgalaxy.com
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Tested-by: Li zhijian <lizhijian@fujitsu.com>
Reviewed-by: Michael Galaxy <mrgalaxy@nvidia.com>
Link: https://lore.kernel.org/r/20250402051306.6509-1-jinpu.wang@ionos.com
[peterx: some cosmetic changes]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 180 ++---------------------------------------------
 1 file changed, 4 insertions(+), 176 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 4875ca1987..2d839fce6c 100644
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
+    /* Try all addresses */
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
-            error_setg(errp, "RDMA ERROR: Error: could not rdma_bind_addr!");
-        }
+        error_setg(errp, "RDMA ERROR: Error: could not rdma_bind_addr!");
         goto err_dest_init_bind_addr;
     }
 
-- 
2.48.1


