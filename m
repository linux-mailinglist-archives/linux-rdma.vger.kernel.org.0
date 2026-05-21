Return-Path: <linux-rdma+bounces-21117-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIGNAfESD2pzEwYAu9opvQ
	(envelope-from <linux-rdma+bounces-21117-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 16:13:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EADF5A6F02
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 16:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76018314F15B
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7DE400E04;
	Thu, 21 May 2026 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLBu0VYv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDCC3DB301;
	Thu, 21 May 2026 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370412; cv=none; b=Tmycscd+XZpzu/K8APdJFMbR2FGC0WVoq5FyEmYRzJLEk2OI6U3l3qN9GKZB0gt+qrvvOW2Cg3I9ceqsGxw5JIAGRyV90abDl5DBuK8ylKINRN8/bGo9nnX/9mAnn3vSCSi6G+l+HKMjJGy6O+bDN+bysBcHMs/xY5yIzO2U3W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370412; c=relaxed/simple;
	bh=TTC1GDQfQrqWftreUSf50GOjYvxNzKR7cl5zgIVjTkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1NLJdEy1rHvJlb8EnyIff+hAN+GxO9T/VtODQp+UYIZsRaVMTNV6NE/ghsJ6cpYRTRRAcqam1XqcExO7SOB0LVNJRSptKnYgI74VQlsErmGvC31QlPt55D74/R81KaQGXMHzzdMGOuCcFulZz1kgLhnk8S5VvIJSk0rDUJNIAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLBu0VYv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0520E1F01567;
	Thu, 21 May 2026 13:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779370407;
	bh=9DxkyjgrxD9LWinSna2ujdm04pqE2VVYzct98abjlWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lLBu0VYv1DVOqqiDkn+zDGX6xIv/gVu34M1uPUGdN7rmbG/n9JKXvAO8PRNIOME0R
	 FtA0rSletCu3HRLjvhAx+RubvjrPTSmol0lPEUginf3y5FRRR8GocUJjLx27hUfLyI
	 NImEQHew3UjgMkSo9n+fGBIoBi3/9LfdXVekv3PwuKg0oTG1fvrFkXkMdUuEG1eZz+
	 ObXQX0R5oQnmOcWg3mJprkFUBUufSGrKS1dHEDLMEfV0r/TCfFKsIVxugSqX1M6Aw/
	 jeUk2cSX/+kzc1YG0egLBt3975yHP3KR9BAsWIhHsNktke684LZrzD2app3rClIjlW
	 FWpisLKv3T/Uw==
From: Kees Cook <kees@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Corey Minyard <corey@minyard.net>,
	Gabriel Somlo <somlo@cmu.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bart Van Assche <bvanassche@acm.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Baron <jbaron@akamai.com>,
	Jim Cromie <jim.cromie@gmail.com>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	kvm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	qemu-devel@nongnu.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 08/11] params: Convert generic kernel_param_ops .get helpers to seq_buf
Date: Thu, 21 May 2026 06:33:21 -0700
Message-Id: <20260521133326.2465264-8-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521133315.work.845-kees@kernel.org>
References: <20260521133315.work.845-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=25560; i=kees@kernel.org; h=from:subject; bh=TTC1GDQfQrqWftreUSf50GOjYvxNzKR7cl5zgIVjTkw=; b=owGbwMvMwCVmps19z/KJym7G02pJDFn8nIucV/i8mPOxqnfn5sfGt/4pbtvK8rDifpsIt19y0 Z5JsaH/O0pZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACZSuIORYWPyAa/PBXInPlzv vLD8gTrnpr+/SkKXGMp8mjD1o2JWRzPDPwXeTYp/JXT37Iqff3iCtU+8lPr1Rb1ZCy3vvqkQ+3p pJx8A
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iscas.ac.cn,suse.com,nod.at,cambridgegreys.com,sipsolutions.net,minyard.net,cmu.edu,redhat.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,acm.org,ziepe.ca,ideasonboard.com,google.com,suse.de,HansenPartnership.com,oracle.com,arm.com,linuxfoundation.org,rowland.harvard.edu,linux.alibaba.com,akamai.com,antgroup.com,orcam.me.uk,infradead.org,linux.ibm.com,alien8.de,zytor.com,atomlin.com,linux-foundation.org,canonical.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,googlegroups.com,kvack.org,lists.ubuntu.com,lists.infradead.org,lists.sourceforge.net,nongnu.org,lists.freedesktop.org,lists.ozlabs.org,lists.one-eyed-alien.net,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21117-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[99];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6EADF5A6F02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert the generic struct kernel_param_ops .get helpers in
kernel/params.c directly to the seq_buf signature, drop their legacy
"char *" form, and refresh prototypes in <linux/moduleparam.h>:

  param_get_byte/short/ushort/int/uint/long/ulong/ullong/hexint
  param_get_charp/bool/invbool/string
  param_array_get

The STANDARD_PARAM_DEF() macro expands to a seq_buf body for every
numeric helper. param_array_get() now writes element output directly
into the parent seq_buf when the element ops provide .get; it only
allocates the per-call PAGE_SIZE bounce buffer when the element ops
still use the legacy .get_str path. The common "rewrite the prior
element's trailing newline as a comma" step lives outside both
branches so the two paths share it.

The non-core changes in this commit (arch/x86/kvm, mm/kfence,
drivers/dma/dmatest, security/apparmor) are the small set of callers that
directly invoke one of the converted generic helpers from their own .get
callback (e.g. an apparmor wrapper that adds a capability check and then
delegates to param_get_bool()). Because the helpers' signature changes
here, these wrappers must move in lockstep. Each of them is updated
to take "struct seq_buf *" and pass it through; param_get_debug() in
apparmor also pulls aa_print_debug_params() (and its val_mask_to_str()
helper, in security/apparmor/lib.c) over to seq_buf, since that is the
only consumer. No other behavioural change is intended.

Custom .get callbacks that do not delegate to a generic helper (and
therefore still match the .get_str signature) are routed automatically
to the .get_str field by the DEFINE_KERNEL_PARAM_OPS _Generic dispatcher
and are deliberately left alone here, to be changed separately within
their respective subsystems.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/moduleparam.h     | 26 +++++------
 security/apparmor/include/lib.h |  3 +-
 mm/kfence/core.c                |  8 ++--
 arch/x86/kvm/mmu/mmu.c          | 16 ++++---
 arch/x86/kvm/svm/avic.c         |  8 ++--
 drivers/dma/dmatest.c           | 14 +++---
 kernel/params.c                 | 80 ++++++++++++++++++++-------------
 security/apparmor/lib.c         | 27 +++++------
 security/apparmor/lsm.c         | 25 ++++++-----
 9 files changed, 114 insertions(+), 93 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 795bc7c654ef..38acb5aef56b 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -500,61 +500,61 @@ void module_destroy_params(const struct kernel_param *params, unsigned int num);
 
 extern const struct kernel_param_ops param_ops_byte;
 int param_set_byte(const char *val, const struct kernel_param *kp);
-int param_get_byte(char *buffer, const struct kernel_param *kp);
+int param_get_byte(struct seq_buf *s, const struct kernel_param *kp);
 #define param_check_byte(name, p) __param_check(name, p, unsigned char)
 
 extern const struct kernel_param_ops param_ops_short;
 int param_set_short(const char *val, const struct kernel_param *kp);
-int param_get_short(char *buffer, const struct kernel_param *kp);
+int param_get_short(struct seq_buf *s, const struct kernel_param *kp);
 #define param_check_short(name, p) __param_check(name, p, short)
 
 extern const struct kernel_param_ops param_ops_ushort;
 int param_set_ushort(const char *val, const struct kernel_param *kp);
-int param_get_ushort(char *buffer, const struct kernel_param *kp);
+int param_get_ushort(struct seq_buf *s, const struct kernel_param *kp);
 #define param_check_ushort(name, p) __param_check(name, p, unsigned short)
 
 extern const struct kernel_param_ops param_ops_int;
 int param_set_int(const char *val, const struct kernel_param *kp);
-int param_get_int(char *buffer, const struct kernel_param *kp);
+int param_get_int(struct seq_buf *s, const struct kernel_param *kp);
 #define param_check_int(name, p) __param_check(name, p, int)
 
 extern const struct kernel_param_ops param_ops_uint;
 int param_set_uint(const char *val, const struct kernel_param *kp);
-int param_get_uint(char *buffer, const struct kernel_param *kp);
+int param_get_uint(struct seq_buf *s, const struct kernel_param *kp);
 int param_set_uint_minmax(const char *val, const struct kernel_param *kp,
 		unsigned int min, unsigned int max);
 #define param_check_uint(name, p) __param_check(name, p, unsigned int)
 
 extern const struct kernel_param_ops param_ops_long;
 int param_set_long(const char *val, const struct kernel_param *kp);
-int param_get_long(char *buffer, const struct kernel_param *kp);
+int param_get_long(struct seq_buf *s, const struct kernel_param *kp);
 #define param_check_long(name, p) __param_check(name, p, long)
 
 extern const struct kernel_param_ops param_ops_ulong;
 int param_set_ulong(const char *val, const struct kernel_param *kp);
-int param_get_ulong(char *buffer, const struct kernel_param *kp);
+int param_get_ulong(struct seq_buf *s, const struct kernel_param *kp);
 #define param_check_ulong(name, p) __param_check(name, p, unsigned long)
 
 extern const struct kernel_param_ops param_ops_ullong;
 int param_set_ullong(const char *val, const struct kernel_param *kp);
-int param_get_ullong(char *buffer, const struct kernel_param *kp);
+int param_get_ullong(struct seq_buf *s, const struct kernel_param *kp);
 #define param_check_ullong(name, p) __param_check(name, p, unsigned long long)
 
 extern const struct kernel_param_ops param_ops_hexint;
 int param_set_hexint(const char *val, const struct kernel_param *kp);
-int param_get_hexint(char *buffer, const struct kernel_param *kp);
+int param_get_hexint(struct seq_buf *s, const struct kernel_param *kp);
 #define param_check_hexint(name, p) param_check_uint(name, p)
 
 extern const struct kernel_param_ops param_ops_charp;
 int param_set_charp(const char *val, const struct kernel_param *kp);
-int param_get_charp(char *buffer, const struct kernel_param *kp);
+int param_get_charp(struct seq_buf *s, const struct kernel_param *kp);
 void param_free_charp(void *arg);
 #define param_check_charp(name, p) __param_check(name, p, char *)
 
 /* We used to allow int as well as bool.  We're taking that away! */
 extern const struct kernel_param_ops param_ops_bool;
 int param_set_bool(const char *val, const struct kernel_param *kp);
-int param_get_bool(char *buffer, const struct kernel_param *kp);
+int param_get_bool(struct seq_buf *s, const struct kernel_param *kp);
 #define param_check_bool(name, p) __param_check(name, p, bool)
 
 extern const struct kernel_param_ops param_ops_bool_enable_only;
@@ -564,7 +564,7 @@ int param_set_bool_enable_only(const char *val, const struct kernel_param *kp);
 
 extern const struct kernel_param_ops param_ops_invbool;
 int param_set_invbool(const char *val, const struct kernel_param *kp);
-int param_get_invbool(char *buffer, const struct kernel_param *kp);
+int param_get_invbool(struct seq_buf *s, const struct kernel_param *kp);
 #define param_check_invbool(name, p) __param_check(name, p, bool)
 
 /* An int, which can only be set like a bool (though it shows as an int). */
@@ -677,7 +677,7 @@ extern const struct kernel_param_ops param_array_ops;
 
 extern const struct kernel_param_ops param_ops_string;
 int param_set_copystring(const char *val, const struct kernel_param *kp);
-int param_get_string(char *buffer, const struct kernel_param *kp);
+int param_get_string(struct seq_buf *s, const struct kernel_param *kp);
 
 /* for exporting parameters in /sys/module/.../parameters */
 
diff --git a/security/apparmor/include/lib.h b/security/apparmor/include/lib.h
index 8c6ce8484552..966082075e61 100644
--- a/security/apparmor/include/lib.h
+++ b/security/apparmor/include/lib.h
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/lsm_hooks.h>
+#include <linux/seq_buf.h>
 
 #include "match.h"
 
@@ -72,7 +73,7 @@ do {									\
 #endif
 
 int aa_parse_debug_params(const char *str);
-int aa_print_debug_params(char *buffer);
+int aa_print_debug_params(struct seq_buf *s);
 
 #define AA_ERROR(fmt, args...)						\
 	pr_err_ratelimited("AppArmor: " fmt, ##args)
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index e14102c01520..bfa936f09978 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -84,10 +84,12 @@ static int param_set_sample_interval(const char *val, const struct kernel_param
 	return 0;
 }
 
-static int param_get_sample_interval(char *buffer, const struct kernel_param *kp)
+static int param_get_sample_interval(struct seq_buf *buffer, const struct kernel_param *kp)
 {
-	if (!READ_ONCE(kfence_enabled))
-		return sprintf(buffer, "0\n");
+	if (!READ_ONCE(kfence_enabled)) {
+		seq_buf_puts(buffer, "0\n");
+		return 0;
+	}
 
 	return param_get_ulong(buffer, kp);
 }
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 996818ee9b09..5e9a2690d335 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -70,7 +70,7 @@ static uint __read_mostly nx_huge_pages_recovery_ratio = 0;
 static uint __read_mostly nx_huge_pages_recovery_ratio = 60;
 #endif
 
-static int get_nx_huge_pages(char *buffer, const struct kernel_param *kp);
+static int get_nx_huge_pages(struct seq_buf *buffer, const struct kernel_param *kp);
 static int set_nx_huge_pages(const char *val, const struct kernel_param *kp);
 static int set_nx_huge_pages_recovery_param(const char *val, const struct kernel_param *kp);
 
@@ -7493,15 +7493,19 @@ static void kvm_wake_nx_recovery_thread(struct kvm *kvm)
 		vhost_task_wake(nx_thread);
 }
 
-static int get_nx_huge_pages(char *buffer, const struct kernel_param *kp)
+static int get_nx_huge_pages(struct seq_buf *buffer, const struct kernel_param *kp)
 {
 	int val = *(int *)kp->arg;
 
-	if (nx_hugepage_mitigation_hard_disabled)
-		return sysfs_emit(buffer, "never\n");
+	if (nx_hugepage_mitigation_hard_disabled) {
+		seq_buf_puts(buffer, "never\n");
+		return 0;
+	}
 
-	if (val == -1)
-		return sysfs_emit(buffer, "auto\n");
+	if (val == -1) {
+		seq_buf_puts(buffer, "auto\n");
+		return 0;
+	}
 
 	return param_get_bool(buffer, kp);
 }
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 7907f9addff9..6c3b4626c5c1 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -77,12 +77,14 @@ static int avic_param_set(const char *val, const struct kernel_param *kp)
 	return param_set_bint(val, kp);
 }
 
-static int avic_param_get(char *buffer, const struct kernel_param *kp)
+static int avic_param_get(struct seq_buf *buffer, const struct kernel_param *kp)
 {
 	int val = *(int *)kp->arg;
 
-	if (val == AVIC_AUTO_MODE)
-		return sysfs_emit(buffer, "N\n");
+	if (val == AVIC_AUTO_MODE) {
+		seq_buf_puts(buffer, "N\n");
+		return 0;
+	}
 
 	return param_get_bool(buffer, kp);
 }
diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index a7bddadcc52d..828298faca16 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -153,14 +153,14 @@ static struct dmatest_info {
 };
 
 static int dmatest_run_set(const char *val, const struct kernel_param *kp);
-static int dmatest_run_get(char *val, const struct kernel_param *kp);
+static int dmatest_run_get(struct seq_buf *val, const struct kernel_param *kp);
 static DEFINE_KERNEL_PARAM_OPS(run_ops, dmatest_run_set, dmatest_run_get);
 static bool dmatest_run;
 module_param_cb(run, &run_ops, &dmatest_run, 0644);
 MODULE_PARM_DESC(run, "Run the test (default: false)");
 
 static int dmatest_chan_set(const char *val, const struct kernel_param *kp);
-static int dmatest_chan_get(char *val, const struct kernel_param *kp);
+static int dmatest_chan_get(struct seq_buf *val, const struct kernel_param *kp);
 static DEFINE_KERNEL_PARAM_OPS(multi_chan_ops, dmatest_chan_set,
 			       dmatest_chan_get);
 
@@ -172,7 +172,7 @@ static struct kparam_string newchan_kps = {
 module_param_cb(channel, &multi_chan_ops, &newchan_kps, 0644);
 MODULE_PARM_DESC(channel, "Bus ID of the channel to test (default: any)");
 
-static int dmatest_test_list_get(char *val, const struct kernel_param *kp);
+static int dmatest_test_list_get(struct seq_buf *val, const struct kernel_param *kp);
 static DEFINE_KERNEL_PARAM_OPS(test_list_ops, NULL, dmatest_test_list_get);
 module_param_cb(test_list, &test_list_ops, NULL, 0444);
 MODULE_PARM_DESC(test_list, "Print current test list");
@@ -274,7 +274,7 @@ static bool is_threaded_test_pending(struct dmatest_info *info)
 	return false;
 }
 
-static int dmatest_wait_get(char *val, const struct kernel_param *kp)
+static int dmatest_wait_get(struct seq_buf *val, const struct kernel_param *kp)
 {
 	struct dmatest_info *info = &test_info;
 	struct dmatest_params *params = &info->params;
@@ -1164,7 +1164,7 @@ static void start_threaded_tests(struct dmatest_info *info)
 	run_pending_tests(info);
 }
 
-static int dmatest_run_get(char *val, const struct kernel_param *kp)
+static int dmatest_run_get(struct seq_buf *val, const struct kernel_param *kp)
 {
 	struct dmatest_info *info = &test_info;
 
@@ -1292,7 +1292,7 @@ static int dmatest_chan_set(const char *val, const struct kernel_param *kp)
 	return ret;
 }
 
-static int dmatest_chan_get(char *val, const struct kernel_param *kp)
+static int dmatest_chan_get(struct seq_buf *val, const struct kernel_param *kp)
 {
 	struct dmatest_info *info = &test_info;
 
@@ -1306,7 +1306,7 @@ static int dmatest_chan_get(char *val, const struct kernel_param *kp)
 	return param_get_string(val, kp);
 }
 
-static int dmatest_test_list_get(char *val, const struct kernel_param *kp)
+static int dmatest_test_list_get(struct seq_buf *val, const struct kernel_param *kp)
 {
 	struct dmatest_info *info = &test_info;
 	struct dmatest_chan *dtc;
diff --git a/kernel/params.c b/kernel/params.c
index 4eda2d23ddf2..25f0c8d5d19f 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -212,15 +212,16 @@ char *parse_args(const char *doing,
 }
 
 /* Lazy bastard, eh? */
-#define STANDARD_PARAM_DEF(name, type, format, strtolfn)      		\
+#define STANDARD_PARAM_DEF(name, type, format, strtolfn)		\
 	int param_set_##name(const char *val, const struct kernel_param *kp) \
 	{								\
 		return strtolfn(val, 0, (type *)kp->arg);		\
 	}								\
-	int param_get_##name(char *buffer, const struct kernel_param *kp) \
+	int param_get_##name(struct seq_buf *s,				\
+			     const struct kernel_param *kp)		\
 	{								\
-		return scnprintf(buffer, PAGE_SIZE, format "\n",	\
-				*((type *)kp->arg));			\
+		seq_buf_printf(s, format "\n", *((type *)kp->arg));	\
+		return 0;						\
 	}								\
 	DEFINE_KERNEL_PARAM_OPS(param_ops_##name,			\
 				param_set_##name, param_get_##name);	\
@@ -285,9 +286,10 @@ int param_set_charp(const char *val, const struct kernel_param *kp)
 }
 EXPORT_SYMBOL(param_set_charp);
 
-int param_get_charp(char *buffer, const struct kernel_param *kp)
+int param_get_charp(struct seq_buf *s, const struct kernel_param *kp)
 {
-	return scnprintf(buffer, PAGE_SIZE, "%s\n", *((char **)kp->arg));
+	seq_buf_printf(s, "%s\n", *((char **)kp->arg));
+	return 0;
 }
 EXPORT_SYMBOL(param_get_charp);
 
@@ -312,10 +314,11 @@ int param_set_bool(const char *val, const struct kernel_param *kp)
 }
 EXPORT_SYMBOL(param_set_bool);
 
-int param_get_bool(char *buffer, const struct kernel_param *kp)
+int param_get_bool(struct seq_buf *s, const struct kernel_param *kp)
 {
 	/* Y and N chosen as being relatively non-coder friendly */
-	return sprintf(buffer, "%c\n", *(bool *)kp->arg ? 'Y' : 'N');
+	seq_buf_printf(s, "%c\n", *(bool *)kp->arg ? 'Y' : 'N');
+	return 0;
 }
 EXPORT_SYMBOL(param_get_bool);
 
@@ -365,9 +368,10 @@ int param_set_invbool(const char *val, const struct kernel_param *kp)
 }
 EXPORT_SYMBOL(param_set_invbool);
 
-int param_get_invbool(char *buffer, const struct kernel_param *kp)
+int param_get_invbool(struct seq_buf *s, const struct kernel_param *kp)
 {
-	return sprintf(buffer, "%c\n", (*(bool *)kp->arg) ? 'N' : 'Y');
+	seq_buf_printf(s, "%c\n", (*(bool *)kp->arg) ? 'N' : 'Y');
+	return 0;
 }
 EXPORT_SYMBOL(param_get_invbool);
 
@@ -453,36 +457,46 @@ static int param_array_set(const char *val, const struct kernel_param *kp)
 			   arr->num ?: &temp_num);
 }
 
-static int param_array_get(char *buffer, const struct kernel_param *kp)
+static int param_array_get(struct seq_buf *s, const struct kernel_param *kp)
 {
-	int i, off, ret;
-	char *elem_buf;
 	const struct kparam_array *arr = kp->arr;
 	struct kernel_param p = *kp;
+	char *elem_buf = NULL;
+	int i, ret = 0;
 
-	elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!elem_buf)
-		return -ENOMEM;
+	for (i = 0; i < (arr->num ? *arr->num : arr->max); i++) {
+		size_t before = s->len;
 
-	for (i = off = 0; i < (arr->num ? *arr->num : arr->max); i++) {
 		p.arg = arr->elem + arr->elemsize * i;
 		check_kparam_locked(p.mod);
-		ret = arr->ops->get_str(elem_buf, &p);
-		if (ret < 0)
-			goto out;
-		ret = min(ret, (int)(PAGE_SIZE - 1 - off));
-		if (!ret)
+
+		if (arr->ops->get) {
+			ret = arr->ops->get(s, &p);
+			if (ret < 0)
+				goto out;
+		} else {
+			if (!elem_buf) {
+				elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+				if (!elem_buf) {
+					ret = -ENOMEM;
+					goto out;
+				}
+			}
+			ret = arr->ops->get_str(elem_buf, &p);
+			if (ret < 0)
+				goto out;
+			seq_buf_putmem(s, elem_buf, ret);
+		}
+
+		/* Nothing got written (e.g. overflow) — stop. */
+		if (s->len == before)
 			break;
+
 		/* Replace the previous element's trailing newline with a comma. */
-		if (i)
-			buffer[off - 1] = ',';
-		memcpy(buffer + off, elem_buf, ret);
-		off += ret;
-		if (off == PAGE_SIZE - 1)
-			break;
+		if (i && s->buffer[before - 1] == '\n')
+			s->buffer[before - 1] = ',';
 	}
-	buffer[off] = '\0';
-	ret = off;
+	ret = 0;
 out:
 	kfree(elem_buf);
 	return ret;
@@ -517,10 +531,12 @@ int param_set_copystring(const char *val, const struct kernel_param *kp)
 }
 EXPORT_SYMBOL(param_set_copystring);
 
-int param_get_string(char *buffer, const struct kernel_param *kp)
+int param_get_string(struct seq_buf *s, const struct kernel_param *kp)
 {
 	const struct kparam_string *kps = kp->str;
-	return scnprintf(buffer, PAGE_SIZE, "%s\n", kps->string);
+
+	seq_buf_printf(s, "%s\n", kps->string);
+	return 0;
 }
 EXPORT_SYMBOL(param_get_string);
 
diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
index e41ff57798b2..eef136add5b4 100644
--- a/security/apparmor/lib.c
+++ b/security/apparmor/lib.c
@@ -85,37 +85,32 @@ int aa_parse_debug_params(const char *str)
 
 /**
  * val_mask_to_str - convert a perm mask to its short string
- * @str: character buffer to store string in (at least 10 characters)
- * @size: size of the @str buffer
+ * @s: seq_buf to store string in
  * @table: NUL-terminated character buffer of permission characters (NOT NULL)
  * @mask: permission mask to convert
  */
-static int val_mask_to_str(char *str, size_t size,
-			   const struct val_table_ent *table, u32 mask)
+static void val_mask_to_str(struct seq_buf *s,
+			    const struct val_table_ent *table, u32 mask)
 {
 	const struct val_table_ent *ent;
-	int total = 0;
+	bool first = true;
 
 	for (ent = table; ent->str; ent++) {
 		if (ent->value && (ent->value & mask) == ent->value) {
-			int len = scnprintf(str, size, "%s%s", total ? "," : "",
-					    ent->str);
-			size -= len;
-			str += len;
-			total += len;
+			seq_buf_printf(s, "%s%s", first ? "" : ",", ent->str);
+			first = false;
 			mask &= ~ent->value;
 		}
 	}
-
-	return total;
 }
 
-int aa_print_debug_params(char *buffer)
+int aa_print_debug_params(struct seq_buf *s)
 {
 	if (!aa_g_debug)
-		return sprintf(buffer, "N");
-	return val_mask_to_str(buffer, PAGE_SIZE, debug_values_table,
-			       aa_g_debug);
+		seq_buf_puts(s, "N");
+	else
+		val_mask_to_str(s, debug_values_table, aa_g_debug);
+	return 0;
 }
 
 bool aa_resize_str_table(struct aa_str_table *t, int newsize, gfp_t gfp)
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 8a253c743363..a6815b4bd0da 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -16,6 +16,7 @@
 #include <linux/namei.h>
 #include <linux/ptrace.h>
 #include <linux/ctype.h>
+#include <linux/seq_buf.h>
 #include <linux/sysctl.h>
 #include <linux/sysfs.h>
 #include <linux/audit.h>
@@ -1765,20 +1766,20 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
  */
 
 static int param_set_aabool(const char *val, const struct kernel_param *kp);
-static int param_get_aabool(char *buffer, const struct kernel_param *kp);
+static int param_get_aabool(struct seq_buf *buffer, const struct kernel_param *kp);
 #define param_check_aabool param_check_bool
 static DEFINE_KERNEL_PARAM_OPS_NOARG(param_ops_aabool, param_set_aabool,
 				     param_get_aabool);
 
 static int param_set_aauint(const char *val, const struct kernel_param *kp);
-static int param_get_aauint(char *buffer, const struct kernel_param *kp);
+static int param_get_aauint(struct seq_buf *buffer, const struct kernel_param *kp);
 #define param_check_aauint param_check_uint
 static DEFINE_KERNEL_PARAM_OPS(param_ops_aauint, param_set_aauint,
 			       param_get_aauint);
 
 static int param_set_aacompressionlevel(const char *val,
 					const struct kernel_param *kp);
-static int param_get_aacompressionlevel(char *buffer,
+static int param_get_aacompressionlevel(struct seq_buf *buffer,
 					const struct kernel_param *kp);
 #define param_check_aacompressionlevel param_check_int
 static DEFINE_KERNEL_PARAM_OPS(param_ops_aacompressionlevel,
@@ -1786,14 +1787,14 @@ static DEFINE_KERNEL_PARAM_OPS(param_ops_aacompressionlevel,
 			       param_get_aacompressionlevel);
 
 static int param_set_aalockpolicy(const char *val, const struct kernel_param *kp);
-static int param_get_aalockpolicy(char *buffer, const struct kernel_param *kp);
+static int param_get_aalockpolicy(struct seq_buf *buffer, const struct kernel_param *kp);
 #define param_check_aalockpolicy param_check_bool
 static DEFINE_KERNEL_PARAM_OPS_NOARG(param_ops_aalockpolicy,
 				     param_set_aalockpolicy,
 				     param_get_aalockpolicy);
 
 static int param_set_debug(const char *val, const struct kernel_param *kp);
-static int param_get_debug(char *buffer, const struct kernel_param *kp);
+static int param_get_debug(struct seq_buf *buffer, const struct kernel_param *kp);
 
 static int param_set_audit(const char *val, const struct kernel_param *kp);
 static int param_get_audit(char *buffer, const struct kernel_param *kp);
@@ -1868,7 +1869,7 @@ module_param_named(path_max, aa_g_path_max, aauint, S_IRUSR);
 bool aa_g_paranoid_load = IS_ENABLED(CONFIG_SECURITY_APPARMOR_PARANOID_LOAD);
 module_param_named(paranoid_load, aa_g_paranoid_load, aabool, S_IRUGO);
 
-static int param_get_aaintbool(char *buffer, const struct kernel_param *kp);
+static int param_get_aaintbool(struct seq_buf *buffer, const struct kernel_param *kp);
 static int param_set_aaintbool(const char *val, const struct kernel_param *kp);
 #define param_check_aaintbool param_check_int
 static DEFINE_KERNEL_PARAM_OPS(param_ops_aaintbool, param_set_aaintbool,
@@ -1898,7 +1899,7 @@ static int param_set_aalockpolicy(const char *val, const struct kernel_param *kp
 	return param_set_bool(val, kp);
 }
 
-static int param_get_aalockpolicy(char *buffer, const struct kernel_param *kp)
+static int param_get_aalockpolicy(struct seq_buf *buffer, const struct kernel_param *kp)
 {
 	if (!apparmor_enabled)
 		return -EINVAL;
@@ -1916,7 +1917,7 @@ static int param_set_aabool(const char *val, const struct kernel_param *kp)
 	return param_set_bool(val, kp);
 }
 
-static int param_get_aabool(char *buffer, const struct kernel_param *kp)
+static int param_get_aabool(struct seq_buf *buffer, const struct kernel_param *kp)
 {
 	if (!apparmor_enabled)
 		return -EINVAL;
@@ -1942,7 +1943,7 @@ static int param_set_aauint(const char *val, const struct kernel_param *kp)
 	return error;
 }
 
-static int param_get_aauint(char *buffer, const struct kernel_param *kp)
+static int param_get_aauint(struct seq_buf *buffer, const struct kernel_param *kp)
 {
 	if (!apparmor_enabled)
 		return -EINVAL;
@@ -1978,7 +1979,7 @@ static int param_set_aaintbool(const char *val, const struct kernel_param *kp)
  * display in the /sys filesystem, while keeping it "int" for the LSM
  * infrastructure.
  */
-static int param_get_aaintbool(char *buffer, const struct kernel_param *kp)
+static int param_get_aaintbool(struct seq_buf *buffer, const struct kernel_param *kp)
 {
 	struct kernel_param kp_local;
 	bool value;
@@ -2011,7 +2012,7 @@ static int param_set_aacompressionlevel(const char *val,
 	return error;
 }
 
-static int param_get_aacompressionlevel(char *buffer,
+static int param_get_aacompressionlevel(struct seq_buf *buffer,
 					const struct kernel_param *kp)
 {
 	if (!apparmor_enabled)
@@ -2021,7 +2022,7 @@ static int param_get_aacompressionlevel(char *buffer,
 	return param_get_int(buffer, kp);
 }
 
-static int param_get_debug(char *buffer, const struct kernel_param *kp)
+static int param_get_debug(struct seq_buf *buffer, const struct kernel_param *kp)
 {
 	if (!apparmor_enabled)
 		return -EINVAL;
-- 
2.34.1


