Return-Path: <linux-rdma+bounces-21628-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HY1LNkD6Hmq0bQAAu9opvQ
	(envelope-from <linux-rdma+bounces-21628-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 17:44:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FDF62FEA1
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 17:44:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lpKHtcHq;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21628-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21628-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAF6930A5B03
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 15:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF183E9C37;
	Tue,  2 Jun 2026 15:09:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABADC3E5ED8;
	Tue,  2 Jun 2026 15:09:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412962; cv=none; b=fAnrCDb8amFAQ1LKGFIQnSWXlyBwARadxE9vU8Ddj73Ma+hFTDaoaq9ehnxRxfG0zKCYyybHB14cRxHHANwVRxhW5Cbkzg8Tx0qqUAYvtz3j/xiV2BRNbf0BZD3rJEIX7oSTaYi9gM2dmRmHquMiFuoDq+RUKWXMxsvIHAUGGF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412962; c=relaxed/simple;
	bh=YIlUUETkVH8UUy8ze1s+f9+Gh3RwlJ+rmwgeOqySVoI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NePclvEhw+imxrkonxSasUg7rftht5nqjGPLLIWm+GxwCm+UAQjj3euU+soKCffiH8f0epbzW/ux5pAb9m3lvA2l39sEnLn9t48QiWaii2RRpo7pxK2qlcdRCaT6Lk77P9haCVvI78qtLHY7qs22F5flHN3HIvaBWwtWysx6qWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpKHtcHq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F9E1F00893;
	Tue,  2 Jun 2026 15:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780412961;
	bh=8T6KiMQPfhmF9wCBshWFSoHQT/tPdPFdSJ7O7GH+wSY=;
	h=From:To:Cc:Subject:Date;
	b=lpKHtcHqH9r/PmNgUgVacJ83f7c/6/ITxcP9dd71/VNhiPXfAXC5oNtZiZiaGe2UR
	 CLZSzAHZIQJzm0A1Bym3tkt2+mjbch0FeT1MD81rBE6GVKtXV5Or7hAkFGverXzYqc
	 pDnpppHboNt5DJaZmE1S+PaFyxhFVASkvZ7ddKbRndtARP5NXyb0VJx0aWluhumKwP
	 sNjIQM+5t8XgSsoNAmL1Qke3CMhJcGyxX0EfhZ+tbdNklhUudjJQSoaXqhlHhn2Gxq
	 N6iuY2Z1FqnyyLofGTnMrbDBXGbNrrqrEiYDex0npmavhnRBFW6udDdHrrRNgjS8WS
	 DQ2Gnh3jm2FQA==
From: Arnd Bergmann <arnd@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 1/2] tracing: work around -Wmissing-format-attribute warning
Date: Tue,  2 Jun 2026 17:07:05 +0200
Message-Id: <20260602150904.2258624-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21628-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[arnd@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_RECIPIENTS(0.00)[m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:akpm@linux-foundation.org,m:pmladek@suse.com,m:nathan@kernel.org,m:arnd@arndb.de,m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:arend.vanspriel@broadcom.com,m:miriam.rachel.korenblit@intel.com,m:mathieu.desnoyers@efficios.com,m:andriy.shevchenko@linux.intel.com,m:linux@rasmusvillemoes.dk,m:senozhatsky@chromium.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:vbabka@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-trace-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[arndb.de,cornelisnetworks.com,ziepe.ca,kernel.org,broadcom.com,intel.com,efficios.com,linux.intel.com,rasmusvillemoes.dk,chromium.org,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,lkml];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25FDF62FEA1

From: Arnd Bergmann <arnd@arndb.de>

A number of tracing headers turn off -Wsuggest-attribute=format for
gcc, but they don't turn it off for clang, so the same warning still
happens on new versions of clang that support the format attribute.

To avoid duplicating the same thing in each tracing header, as well
as changing all of them to also turn it off for clang, add a new
__vsnprintf() helper that is not annotated this way in linux/sprintf.h
but is defined to work the same way as the regular vsprintf.

Aside from tracing, the same thing can be used in va_format(),
which is part of lib/vsprintf.c itself.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This version is a fairly simplistic way to work around the warning
reliably. I have resent two more patches to address actually
missing annotations in device drivers, but with all of these
out of the way, we can move the warning from the 'make W=1'
into the default set.

I have also prototyped a variant of this patch that passes down
a 'struct va_format' throughout the tracing code. That patch is
a little more invasive and I have no idea if that actually works,
but the result looks simpler.
---
 drivers/infiniband/hw/hfi1/trace_dbg.h               |  7 -------
 .../broadcom/brcm80211/brcmfmac/tracepoint.h         |  7 -------
 .../brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h    |  7 -------
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c    |  3 ---
 include/linux/sprintf.h                              |  1 +
 include/linux/trace_events.h                         |  2 +-
 include/trace/events/qla.h                           |  7 -------
 include/trace/stages/stage6_event_callback.h         |  2 +-
 lib/vsprintf.c                                       | 12 +++++++-----
 samples/trace_events/trace-events-sample.c           |  2 --
 10 files changed, 10 insertions(+), 40 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/trace_dbg.h b/drivers/infiniband/hw/hfi1/trace_dbg.h
index 58304b91380f..05c4f1354269 100644
--- a/drivers/infiniband/hw/hfi1/trace_dbg.h
+++ b/drivers/infiniband/hw/hfi1/trace_dbg.h
@@ -22,11 +22,6 @@
 
 #define MAX_MSG_LEN 512
 
-#pragma GCC diagnostic push
-#ifndef __clang__
-#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
-#endif
-
 DECLARE_EVENT_CLASS(hfi1_trace_template,
 		    TP_PROTO(const char *function, struct va_format *vaf),
 		    TP_ARGS(function, vaf),
@@ -41,8 +36,6 @@ DECLARE_EVENT_CLASS(hfi1_trace_template,
 			      __get_str(msg))
 );
 
-#pragma GCC diagnostic pop
-
 /*
  * It may be nice to macroize the __hfi1_trace but the va_* stuff requires an
  * actual function to work and can not be in a macro.
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/tracepoint.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/tracepoint.h
index 96032322b165..6c4e00e9ccd1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/tracepoint.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/tracepoint.h
@@ -28,11 +28,6 @@ static inline void trace_ ## name(proto) {}
 
 #define MAX_MSG_LEN		100
 
-#pragma GCC diagnostic push
-#ifndef __clang__
-#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
-#endif
-
 TRACE_EVENT(brcmf_err,
 	TP_PROTO(const char *func, struct va_format *vaf),
 	TP_ARGS(func, vaf),
@@ -128,8 +123,6 @@ TRACE_EVENT(brcmf_sdpcm_hdr,
 		  __entry->len, ((u8 *)__get_dynamic_array(hdr))[4])
 );
 
-#pragma GCC diagnostic pop
-
 #ifdef CONFIG_BRCM_TRACING
 
 #undef TRACE_INCLUDE_PATH
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h
index 908ce3c864fe..dc296d8bf775 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h
@@ -24,11 +24,6 @@
 
 #define MAX_MSG_LEN	100
 
-#pragma GCC diagnostic push
-#ifndef __clang__
-#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
-#endif
-
 DECLARE_EVENT_CLASS(brcms_msg_event,
 	TP_PROTO(struct va_format *vaf),
 	TP_ARGS(vaf),
@@ -77,8 +72,6 @@ TRACE_EVENT(brcms_dbg,
 	TP_printk("%s: %s", __get_str(func), __get_str(msg))
 );
 
-#pragma GCC diagnostic pop
-
 #endif /* __TRACE_BRCMSMAC_MSG_H */
 
 #ifdef CONFIG_BRCM_TRACING
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c
index 7e686297963d..49a8196430a7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c
@@ -12,9 +12,6 @@
 #include "iwl-trans.h"
 
 #define CREATE_TRACE_POINTS
-#ifdef CONFIG_CC_IS_GCC
-#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
-#endif
 #include "iwl-devtrace.h"
 
 EXPORT_TRACEPOINT_SYMBOL(iwlwifi_dev_ucode_event);
diff --git a/include/linux/sprintf.h b/include/linux/sprintf.h
index f06f7b785091..036a247b7c1e 100644
--- a/include/linux/sprintf.h
+++ b/include/linux/sprintf.h
@@ -12,6 +12,7 @@ __printf(2, 3) int sprintf(char *buf, const char * fmt, ...);
 __printf(2, 0) int vsprintf(char *buf, const char *, va_list);
 __printf(3, 4) int snprintf(char *buf, size_t size, const char *fmt, ...);
 __printf(3, 0) int vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
+int __vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
 __printf(3, 4) int scnprintf(char *buf, size_t size, const char *fmt, ...);
 __printf(3, 0) int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
 __printf(2, 3) __malloc char *kasprintf(gfp_t gfp, const char *fmt, ...);
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index d49338c44014..4715330c7b6b 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -962,7 +962,7 @@ perf_trace_buf_submit(void *raw_data, int size, int rctx, u16 type,
 	int __ret;					\
 							\
 	va_copy(__ap, *(va));				\
-	__ret = vsnprintf(NULL, 0, fmt, __ap) + 1;	\
+	__ret = __vsnprintf(NULL, 0, fmt, __ap) + 1;	\
 	va_end(__ap);					\
 							\
 	min(__ret, TRACE_EVENT_STR_MAX);		\
diff --git a/include/trace/events/qla.h b/include/trace/events/qla.h
index 8800c35525a1..74a7534b99b6 100644
--- a/include/trace/events/qla.h
+++ b/include/trace/events/qla.h
@@ -9,11 +9,6 @@
 
 #define QLA_MSG_MAX 256
 
-#pragma GCC diagnostic push
-#ifndef __clang__
-#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
-#endif
-
 DECLARE_EVENT_CLASS(qla_log_event,
 	TP_PROTO(const char *buf,
 		struct va_format *vaf),
@@ -32,8 +27,6 @@ DECLARE_EVENT_CLASS(qla_log_event,
 	TP_printk("%s %s", __get_str(buf), __get_str(msg))
 );
 
-#pragma GCC diagnostic pop
-
 DEFINE_EVENT(qla_log_event, ql_dbg_log,
 	TP_PROTO(const char *buf, struct va_format *vaf),
 	TP_ARGS(buf, vaf)
diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index 1691676fd858..7d6a6ca6e779 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -45,7 +45,7 @@
 	do {								\
 		va_list __cp_va;					\
 		va_copy(__cp_va, *(va));				\
-		vsnprintf(__get_str(dst), TRACE_EVENT_STR_MAX, fmt, __cp_va); \
+		__vsnprintf(__get_str(dst), TRACE_EVENT_STR_MAX, fmt, __cp_va); \
 		va_end(__cp_va);					\
 	} while (0)
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index a3017bc58986..3caf0796f54d 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1702,9 +1702,6 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 	return buf;
 }
 
-__diag_push();
-__diag_ignore(GCC, all, "-Wsuggest-attribute=format",
-	      "Not a valid __printf() conversion candidate.");
 static char *va_format(char *buf, char *end, struct va_format *va_fmt,
 		       struct printf_spec spec)
 {
@@ -1714,12 +1711,11 @@ static char *va_format(char *buf, char *end, struct va_format *va_fmt,
 		return buf;
 
 	va_copy(va, *va_fmt->va);
-	buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
+	buf += __vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
 	va_end(va);
 
 	return buf;
 }
-__diag_pop();
 
 static noinline_for_stack
 char *uuid_string(char *buf, char *end, const u8 *addr,
@@ -2979,6 +2975,12 @@ int vsnprintf(char *buf, size_t size, const char *fmt_str, va_list args)
 }
 EXPORT_SYMBOL(vsnprintf);
 
+int __printf(3, 0) __vsnprintf(char *buf, size_t size, const char *fmt_str, va_list args)
+{
+	return vsnprintf(buf, size, fmt_str, args);
+}
+EXPORT_SYMBOL(__vsnprintf);
+
 /**
  * vscnprintf - Format a string and place it in a buffer
  * @buf: The buffer to place the result into
diff --git a/samples/trace_events/trace-events-sample.c b/samples/trace_events/trace-events-sample.c
index 9993fb5d5f98..ecc7db237f2e 100644
--- a/samples/trace_events/trace-events-sample.c
+++ b/samples/trace_events/trace-events-sample.c
@@ -9,8 +9,6 @@
  * creates the handles for the trace points.
  */
 #define CREATE_TRACE_POINTS
-__diag_ignore(GCC, all, "-Wsuggest-attribute=format",
-             "trace_event_get_offsets_foo_bar can't easily be annotated as __printf");
 #include "trace-events-sample.h"
 
 static const char *random_strings[] = {
-- 
2.39.5


