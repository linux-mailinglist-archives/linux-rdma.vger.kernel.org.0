Return-Path: <linux-rdma+bounces-21409-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDOsNh6yF2p+NggAu9opvQ
	(envelope-from <linux-rdma+bounces-21409-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 05:10:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D765EC178
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 05:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 516243044137
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 03:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EE3279DCC;
	Thu, 28 May 2026 03:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SK9rot+W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDDB2C11C6
	for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 03:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937787; cv=none; b=VFJWwt37lpxpM3CDh94bI22JhwgxAAlbb74rwjU1QF+Fuex3ntjabB8qJcyt/SIhgF9hocyNLR+8RtujpN7oRST4lIVvjyPdOisNSm4+V2z1RyovksoGWcf3yVPDkeFndnVWB++s3ItECi5tMhKhQ2jKPI05au1mktaD7WKi8HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937787; c=relaxed/simple;
	bh=V9a16BbvXJarY4TZF6RaqyKPeOkW0EcHZ2wUNDYOAxw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=MUnfY/jo5/BAcXhf8NhS21KAoXV5YXg5vK0/bc6BF+tL06R7e/mqnFSil94//hwGcLcTl73FZU4eElOgZ9e6bS3QpD5L3aOviRuGb1r/uSdONSX3eUn1Epap/ESfznQBBkxEF3CqG3HjuuxhbOl1giH6a8UOR7f+w5hqumVIkBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=SK9rot+W; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1779937781; bh=sv/GIMG6xhB0X65kL7r24iAqg31ymP+0eCjcmcrAGvM=;
	h=From:To:Cc:Subject:Date;
	b=SK9rot+W70xDhkjNAdtc67Sgbtju81lxh6jKIbg7ldzZuBrBXKjbfQvGIYg61UTZP
	 b3V1QEjiJR+5TjB17tq2aWOWRKG3wlYfXAH33DfbLwwCGzElCOdy8KaIff7JYY6Bgq
	 by/6XnEOByBhuDwce6YvOAx6J6D99Aw1NYuI/vL0=
Received: from NTT-kernel-dev ([60.247.85.88])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 265A0CDE; Thu, 28 May 2026 11:09:37 +0800
X-QQ-mid: xmsmtpt1779937777t17iiwvdo
Message-ID: <tencent_2CCEB7347C9C631F1181F2C768D4B3AA6307@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XtOiblvciSp9yaWC90YPowWReMT9cVp9UJYXDtWRK2/j/rmxxst
	 zlSuY3Y4bSEjYOqPBiXubiAQBlIa+jefYh1fJuypTtk6sm2Fxev4/HTh7yYaONIbmZMtyVGjdP8L
	 IuD5AiKLOo/wgdWYL1ISrOjM8hY0wiq69nvd6JyXJP493I3N39gA7alVds9PHE7ZbLMcAzAzCIg1
	 y5Ais9Ppaeu9XrMIpzEKBFdN/FMz6Kn/ogkdFIQv7bQEs33005fU1T2HqJDaCmdvGy8cjC/AQsN8
	 L8nX7fVX8GSzDja8KQhTshD1o9oYzE4BmmmrRYKGT/y9Nqi+cpInsGiNE5t39w8eTT1iZIuo7ipG
	 bN82yVWGr9fCXftk87UbQBbatIb9hDAIqZViP+RaFjVvdQ8oX0Mv8h56adFMuWjfcpgCOgYj05Hy
	 X4Dos9ZPWYYVoYYOISxhWewMhQVfaWqNKlCnQmV7msKW0tWBifhhTIFYS3Op2rwpWCIJuOS/fGVz
	 q/qAWHmL0+y08IlyRoS5kumDZKmLo1x7Q9yKaWYCv5RbqoHQS4Fz4VjTjKVE2HNakKc7wFr93QrA
	 xkF0n3as2uyyhevQGx0j9by9NEGZNkVvzlfJCzinQm6a3R0UDdYOEHXBMeGL/FM7BNuczWpktWvn
	 /R6Q9VKIW2FjTneJKsfAPJMqlPzwGErIaY7EYEcz2n5LmpM/rQD75N/hwYfmAiHifX5LgQXTZcOC
	 Xtagcuy49a9RzNONJPXNlihAh6s+No1bvzL3leOoInBRct1bkBAq+BDQIrwJh9cKGxMRfyYykfOm
	 tyQO8G0XKw7gGcqPqSzM565lAraBFF+REPsssh+Rnj5Uy+P8QeucsKU447D3t92wONpx8h83npV1
	 MSSebsl1n8ZxZ42IISef2ykuVrVCFtGpi83oDGWEEDhcqVTYaQDErQ2Str5mYx8gG1YRwcSPq7XG
	 9rYJs8BFV4luObcOOKGF5+ifJaVMlpaphfYDIJZhWj4HqdPRh6z0PgG2G8V99T+afo+4ccnkr+P5
	 ODT6vaXg==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Fang Wang <32840572@qq.com>
To: torvalds@linux-foundation.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	dennis.dalessandro@cornelisnetworks.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	linux-rdma@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 6.6.y] x86-64: rename misleadingly named '__copy_user_nocache()' function
Date: Thu, 28 May 2026 11:09:37 +0800
X-OQ-MSGID: <20260528030937.923133-1-32840572@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,redhat.com,alien8.de,linux.intel.com,kernel.org,zytor.com,cornelisnetworks.com,ziepe.ca,kudzu.us,intel.com,gmail.com,infradead.org,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-21409-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qq.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[qq.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[32840572@qq.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qq.com:email,qq.com:mid,qq.com:dkim]
X-Rspamd-Queue-Id: D2D765EC178
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit d187a86de793f84766ea40b9ade7ac60aabbb4fe ]

This function was a masterclass in bad naming, for various historical
reasons.

It claimed to be a non-cached user copy.  It is literally _neither_ of
those things.  It's a specialty memory copy routine that uses
non-temporal stores for the destination (but not the source), and that
does exception handling for both source and destination accesses.

Also note that while it works for unaligned targets, any unaligned parts
(whether at beginning or end) will not use non-temporal stores, since
only words and quadwords can be non-temporal on x86.

The exception handling means that it _can_ be used for user space
accesses, but not on its own - it needs all the normal "start user space
access" logic around it.

But typically the user space access would be the source, not the
non-temporal destination.  That was the original intention of this,
where the destination was some fragile persistent memory target that
needed non-temporal stores in order to catch machine check exceptions
synchronously and deal with them gracefully.

Thus that non-descriptive name: one use case was to copy from user space
into a non-cached kernel buffer.  However, the existing users are a mix
of that intended use-case, and a couple of random drivers that just did
this as a performance tweak.

Some of those random drivers then actively misused the user copying
version (with STAC/CLAC and all) to do kernel copies without ever even
caring about the exception handling, _just_ for the non-temporal
destination.

Rename it as a first small step to actually make it halfway sane, and
change the prototype to be more normal: it doesn't take a user pointer
unless the caller has done the proper conversion, and the argument size
is the full size_t (it still won't actually copy more than 4GB in one
go, but there's also no reason to silently truncate the size argument in
the caller).

Finally, use this now sanely named function in the NTB code, which
mis-used a user copy version (with STAC/CLAC and all) of this interface
despite it not actually being a user copy at all.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Fang Wang <32840572@qq.com>
---
 arch/x86/include/asm/uaccess_64.h    | 5 +++--
 arch/x86/lib/copy_user_uncached_64.S | 6 +++---
 arch/x86/lib/usercopy_64.c           | 4 ++--
 drivers/infiniband/sw/rdmavt/qp.c    | 8 +++-----
 drivers/ntb/ntb_transport.c          | 7 ++++---
 tools/objtool/check.c                | 2 +-
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index f2c02e4469cc..68417f5db5dc 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -133,7 +133,8 @@ raw_copy_to_user(void __user *dst, const void *src, unsigned long size)
 	return copy_user_generic((__force void *)dst, src, size);
 }
 
-extern long __copy_user_nocache(void *dst, const void __user *src, unsigned size);
+#define copy_to_nontemporal copy_to_nontemporal
+extern size_t copy_to_nontemporal(void *dst, const void *src, size_t size);
 extern long __copy_user_flushcache(void *dst, const void __user *src, unsigned size);
 
 static inline int
@@ -143,7 +144,7 @@ __copy_from_user_inatomic_nocache(void *dst, const void __user *src,
 	long ret;
 	kasan_check_write(dst, size);
 	stac();
-	ret = __copy_user_nocache(dst, src, size);
+	ret = copy_to_nontemporal(dst, (__force const void *)src, size);
 	clac();
 	return ret;
 }
diff --git a/arch/x86/lib/copy_user_uncached_64.S b/arch/x86/lib/copy_user_uncached_64.S
index 5c5f38d32672..b37a6f084c4c 100644
--- a/arch/x86/lib/copy_user_uncached_64.S
+++ b/arch/x86/lib/copy_user_uncached_64.S
@@ -26,7 +26,7 @@
  * Output:
  * rax uncopied bytes or 0 if successful.
  */
-SYM_FUNC_START(__copy_user_nocache)
+SYM_FUNC_START(copy_to_nontemporal)
 	/* If destination is not 7-byte aligned, we'll have to align it */
 	testb $7,%dil
 	jne .Lalign
@@ -238,5 +238,5 @@ _ASM_EXTABLE_UA(95b, .Ldone)
 _ASM_EXTABLE_UA(52b, .Ldone0)
 _ASM_EXTABLE_UA(53b, .Ldone0)
 
-SYM_FUNC_END(__copy_user_nocache)
-EXPORT_SYMBOL(__copy_user_nocache)
+SYM_FUNC_END(copy_to_nontemporal)
+EXPORT_SYMBOL(copy_to_nontemporal)
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index e9251b89a9e9..1f1fb2ab1496 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -49,11 +49,11 @@ long __copy_user_flushcache(void *dst, const void __user *src, unsigned size)
 	long rc;
 
 	stac();
-	rc = __copy_user_nocache(dst, src, size);
+	rc = copy_to_nontemporal(dst, (__force const void *)src, size);
 	clac();
 
 	/*
-	 * __copy_user_nocache() uses non-temporal stores for the bulk
+	 * copy_to_nontemporal() uses non-temporal stores for the bulk
 	 * of the transfer, but we need to manually flush if the
 	 * transfer is unaligned. A cached memory copy is used when
 	 * destination or size is not naturally aligned. That is:
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index dc83d0ac6a38..d77ada17e9db 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -92,12 +92,10 @@ static int rvt_wss_llc_size(void)
 static void cacheless_memcpy(void *dst, void *src, size_t n)
 {
 	/*
-	 * Use the only available X64 cacheless copy.  Add a __user cast
-	 * to quiet sparse.  The src agument is already in the kernel so
-	 * there are no security issues.  The extra fault recovery machinery
-	 * is not invoked.
+	 * Use the only available X64 cacheless copy.
+	 * The extra fault recovery machinery is not invoked.
 	 */
-	__copy_user_nocache(dst, (void __user *)src, n);
+	copy_to_nontemporal(dst, src, n);
 }
 
 void rvt_wss_exit(struct rvt_dev_info *rdi)
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 0087c23655c7..03631c702c0c 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1800,12 +1800,13 @@ static void ntb_tx_copy_callback(void *data,
 
 static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
 {
-#ifdef ARCH_HAS_NOCACHE_UACCESS
+#ifdef copy_to_nontemporal
 	/*
 	 * Using non-temporal mov to improve performance on non-cached
-	 * writes, even though we aren't actually copying from user space.
+	 * writes. This only works if __iomem is strictly memory-like,
+	 * but that is the case on x86-64
 	 */
-	__copy_from_user_inatomic_nocache(offset, entry->buf, entry->len);
+	copy_to_nontemporal(offset, entry->buf, entry->len);
 #else
 	memcpy_toio(offset, entry->buf, entry->len);
 #endif
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2c7b09c8415f..c54d531f73d9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1236,7 +1236,7 @@ static const char *uaccess_safe_builtin[] = {
 	"copy_mc_enhanced_fast_string",
 	"rep_stos_alternative",
 	"rep_movs_alternative",
-	"__copy_user_nocache",
+	"copy_to_nontemporal",
 	NULL
 };
 
-- 
2.34.1


