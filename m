Return-Path: <linux-rdma+bounces-13346-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88031B56EF6
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 05:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB7F189BF4E
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 03:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751BC26D4EF;
	Mon, 15 Sep 2025 03:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz2bhghd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A3526CE23
	for <linux-rdma@vger.kernel.org>; Mon, 15 Sep 2025 03:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757907846; cv=none; b=CwQ+DuDZ91eOMPs55assk5eV4+BDumDGWg6B3BSPpc4oj7wLHWgahmy7AoaaPAMxfhe4CeiRNV18QEFzlyfewIsFDTClcDft43wI+n1cbBHCpxH1ZLUpP4FaMosRCyuyd/cnEXjqnD70Yf8z44GA5/wr9+TeIcY3CQ9qOiT/dms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757907846; c=relaxed/simple;
	bh=MTSGtFHLzoI+Dmogi30ONMBxSrNw8BY5Bvpi+oZm38U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=J0u9SR8QIIXv4LX0glLfV5bt1ys1Ou3ISX8LW6Do5qA0GSSN9FZ7iTNxyDKAfy2gS97qBpGTPtXKkH6U++Uvveu6vH3FygALK4RuZU+RltUgLRzWZsCnfbrZmCL8rO3X+pOuuiTuiTLzIrDHwDYNuc6vFVJ8yG1ZgC8/wTjEV6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gz2bhghd; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62f125e5303so1914113a12.0
        for <linux-rdma@vger.kernel.org>; Sun, 14 Sep 2025 20:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757907841; x=1758512641; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vUss3o5tIHvc8to1vdDQ8jI6CZPXrJ0+gNOL6gRc5Gw=;
        b=gz2bhghdP3UI3JId7tewtksZOrzIP1hX4+VVLdcycQvGVRkVxUohDBUC+QyNiGrfuO
         FavDvW2IBA8vVrfWkIHOavXCxbMhINbCTA3vfEhlaw/QgOb+cNs/ldw1LhlX3WlJm0Ov
         p6gtVZ/3RJgE3ucuZlq255DP2LrC/ce3dKeeHOO0J3tY4yhJlztzDG2Ti7fQXz92+GY4
         JdGWqckYjymO1GfSjt1ol0KRBEpf+GUnOI6S/aznjkCl3aijPMW65VJsvNglUMfs7oj0
         QSdOUxml2UBeeiXY3F8o99/wgUv5Ei//LoAQtrCMtSpoj3xbFt3ZwkC6qGAe2jRAyqlr
         +i4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757907841; x=1758512641;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vUss3o5tIHvc8to1vdDQ8jI6CZPXrJ0+gNOL6gRc5Gw=;
        b=uJhG2elf5AWja0YbxTNZP42DD5OpS8C7LiKegtBJf1O7llTKHsHszrPZyixpfDQE7O
         C/DVxavY/xR+SGhAxp/lrrV+UtFgZugCjtqdIwsdtnelIhH5n82ovtuX1cQabrMeb+oC
         l7LxH8y47wuPpE1avhs//cJpF6PjSa3WxAXK0Q9bftMYKKFu/VjxE/X6VapqgJdrj6RY
         JUc8idyctjQ+2K/sxCNnvvhnDT7sxA7oub1Ye7XsJYixQjHqsoPRhg8tQT/axQO+ThM7
         HxuFrniB3Z6bI8Y604eY+8LHDDAfS5zVa2fpHkB8xhWc0HB1eBCLLBO5Vlem8Gmi/Zyv
         YwpQ==
X-Gm-Message-State: AOJu0YzMkinOc8xJwDRJbruJ1C5bO0q35yBekTk+BTlq4zJ6mBleQjMd
	X29hZwydaK2sLDmL8023Ry0rI7SgIGWIK1Vc11GUM2tRqfa29JLbYIgRHo7bWiqfYsFpJ5ozGbw
	3TJFMHCpRsH9TV5mfn9X02hvdPQo2t6T6PA6AaMXfx6t5
X-Gm-Gg: ASbGncufaU0Y6KYvX7uMu7wdvONIzYzM7VngKXzDgf953s+el2JZAYfzMkks0Mvefjm
	sRbTr1uLTGaiGJiboy2i+iX2sgZrnTvfWAmIc3PEXzH10G7KGECCxtvsK94DOVCrELn29vzWvkt
	cPSJqzGl5s5OMWbQm+/S7I+ZysFw75sLpGKIXCvoVajpj0JWNHR3nGwhD1vRAbjU7l8JC5qeDwi
	pCszho=
X-Google-Smtp-Source: AGHT+IFW6QOJb80753w6XaB2OvUIsR9qSGSrvAddG+pPtnn3JXvdJ3bHQ1yjdujy8hx7vBIjTz3bD26ZroC5led7uis=
X-Received: by 2002:a17:907:741:b0:b04:80c5:685c with SMTP id
 a640c23a62f3a-b07c37ddcbdmr1093896666b.35.1757907841093; Sun, 14 Sep 2025
 20:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Liu <asatsuyu.liu@gmail.com>
Date: Mon, 15 Sep 2025 11:44:07 +0800
X-Gm-Features: Ac12FXxG0UU1e26EyrB-dL0bFfybk9nzwcRzrM-OPdUL9ClZ5S60540LO1zQMzI
Message-ID: <CANQ=Xi0iVdA=KR89vEfJQjVzkyRoMhmNm4er8iSwNum8oVuGhA@mail.gmail.com>
Subject: [BUG] libibverbs: ibv_create_qp crashes when recv_cq=NULL (expected EINVAL)
To: linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi RDMA maintainers,

I would like to report a robustness issue in libibverbs (rdma-core).

**Environment:**
- Distro: Ubuntu 22.04 (kernel 6.8.0-65-generic)
- rdma-core version: 39.0-1
- libibverbs version: 39.0-1 (package: libibverbs1:amd64)
- Provider: rxe
- Reproduced with both gdb and ASan

**Problem description:**
When calling `ibv_create_qp()` with `attr.recv_cq = NULL` (while
qp_type=IBV_QPT_RC),
the process crashes inside `ibv_icmd_create_qp()` due to an unconditional
dereference of `attr_ex->recv_cq->handle`.
Instead of returning `-1` with `errno = EINVAL`, libibverbs causes a
segmentation fault.

**Minimal reproducer:**
```c
#include <infiniband/verbs.h>
#include <stdio.h>
#include <stdlib.h>

int main() {
    int num;
    struct ibv_device **list = ibv_get_device_list(&num);
    struct ibv_context *ctx = ibv_open_device(list[0]);
    struct ibv_pd *pd = ibv_alloc_pd(ctx);

    struct ibv_cq *send_cq = ibv_create_cq(ctx, 16, NULL, NULL, 0);

    struct ibv_qp_init_attr attr = {0};
    attr.qp_type = IBV_QPT_RC;
    attr.cap.max_send_wr = 1;
    attr.cap.max_recv_wr = 1;
    attr.cap.max_send_sge = 1;
    attr.cap.max_recv_sge = 1;
    attr.send_cq = send_cq;
    attr.recv_cq = NULL; // intentionally left NULL

    struct ibv_qp *qp = ibv_create_qp(pd, &attr);
    if (!qp) { perror("ibv_create_qp"); return 0; }
    return 0;
}
```

**Compilation and run with ASan**:
```bash
gcc -O1 -g -fsanitize=address -fno-omit-frame-pointer \
    poc.c -o poc -libverbs

export ASAN_OPTIONS='abort_on_error=1,fast_unwind_on_malloc=0,detect_leaks=1'
export ASAN_SYMBOLIZER_PATH=$(command -v llvm-symbolizer || true)

./poc
```

**ASan report (excerpt)**:
```
AddressSanitizer:DEADLYSIGNAL
=================================================================
==1199856==ERROR: AddressSanitizer: SEGV on unknown address
0x000000000018 (pc 0x7e56fecf0a17 bp 0x7fffebdebd50 sp 0x7fffebdebad0
T0)
==1199856==The signal is caused by a READ memory access.
==1199856==Hint: address points to the zero page.
    #0 0x7e56fecf0a17 in ibv_icmd_create_qp libibverbs/cmd_qp.c:140
    #1 0x7e56fecf2b7d in ibv_cmd_create_qp libibverbs/cmd_qp.c:394
    #2 0x7e56fe0ce6fa
(/usr/lib/x86_64-linux-gnu/libibverbs/librxe-rdmav34.so+0x46fa)
    #3 0x57435dc2559a in main /home/user/rdma/poc.c:23
    #4 0x7e56fde29d8f in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58
    #5 0x7e56fde29e3f in __libc_start_main_impl ../csu/libc-start.c:392
    #6 0x57435dc25264 in _start (/home/user/rdma/poc+0x1264)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV libibverbs/cmd_qp.c:140 in ibv_icmd_create_qp
==1199856==ABORTING
[1]    1199856 IOT instruction (core dumped)  ./poc
```

**Analysis:**
- In `ibv_icmd_create_qp()` (`libibverbs/cmd_qp.c`), the `non-IND_TABLE`
branch unconditionally dereferences `attr_ex->recv_cq->handle`.
- In contrast, the `IND_TABLE` branch explicitly checks for illegal combinations
of `recv_cq/srq/max_recv_wr/max_recv_sge`.
- This asymmetry means that a NULL `recv_cq` leads to SIGSEGV instead of a
controlled error.
- The issue still exists in current `rdma-core` (see
https://github.com/linux-rdma/rdma-core, 5df6832)

**Proposed fix**:
Add `NULL` checks for both `send_cq` and `recv_cq` in the
`non-IND_TABLE` branch,
returning `EINVAL` if they are not set.

```diff
From a39bea23c9472e87060680e2384960434ec86808 Mon Sep 17 00:00:00 2001
From: Liuyi <asatsuyu.liu@gmail.com>
Date: Mon, 15 Sep 2025 11:23:15 +0800
Subject: [PATCH] libibverbs: validate send_cq/recv_cq in non-IND_TABLE path

---
 libibverbs/cmd_qp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/libibverbs/cmd_qp.c b/libibverbs/cmd_qp.c
index 499b241e5..c40553782 100644
--- a/libibverbs/cmd_qp.c
+++ b/libibverbs/cmd_qp.c
@@ -132,11 +132,20 @@ static int ibv_icmd_create_qp(struct ibv_context *context,
                send_cq_handle = attr_ex->send_cq->handle;
            }
        } else {
+           if (!attr_ex->send_cq) {
+               errno = EINVAL;
+               return errno;
+           }
+
            fill_attr_in_obj(cmdb, UVERBS_ATTR_CREATE_QP_SEND_CQ_HANDLE,
                 attr_ex->send_cq->handle);
            send_cq_handle = attr_ex->send_cq->handle;

            if (attr_ex->qp_type != IBV_QPT_XRC_SEND) {
+               if (!attr_ex->recv_cq) {
+                   errno = EINVAL;
+                   return errno;
+               }
                fill_attr_in_obj(cmdb, UVERBS_ATTR_CREATE_QP_RECV_CQ_HANDLE,
                         attr_ex->recv_cq->handle);
                recv_cq_handle = attr_ex->recv_cq->handle;
-- 
2.34.1

```

**Security consideration**:
This is primarily a robustness bug. In environments where applications may be
driven by untrusted inputs (e.g. fuzzing frameworks, multi-tenant clusters),
it could be considered a denial-of-service vulnerability.
Please advise whether this should be treated as CVE-worthy or just a
robustness fix.

Thanks for your attention!

Best regards,

Yi Liu

