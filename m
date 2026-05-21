Return-Path: <linux-rdma+bounces-21113-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKJdIwEQD2rZEgYAu9opvQ
	(envelope-from <linux-rdma+bounces-21113-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 16:00:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 346C85A6AB9
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 16:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 075743106B63
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282A03EEAD8;
	Thu, 21 May 2026 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7Ykfcvp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27FC3D810D;
	Thu, 21 May 2026 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370409; cv=none; b=BU3OdzTjWW0q3JoodND0JimCoqqxn48IJZP1E6bPuiXi4gkaEzXl6iq3fXuJhag+CPCswz/CENLGXssbu6Rsa8xI621uKvTb0aGSk/Qzcj+w/d2Q5kcmD0UU14YtUruTeGuohHCkc8XNaxPFTjJVW+VZiz1b7fIxSt12IgR8tH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370409; c=relaxed/simple;
	bh=3qCwRbQEn6qV8q9ahXLM93O2aOukjHk7G2WsPfFNfHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dr7Hql+8moa9fULZHOvXh0jZOw4s2YIymlV0DEWt/i/A0lZ7rRRKtUL5RzpPp7RUzCUqpvFGh7voh012zxMCRQmd8SsKtUPCeMa0kAE8nNnxFmV5c4LPdR/b7YBgS5XEL3xJNrsGJv09U6tiAtRnraSCzpWaXujXXd2bJbl/eQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7Ykfcvp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9C71F0155A;
	Thu, 21 May 2026 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779370406;
	bh=xIIxiknLSHVZBHNOKlLgNSXxWTGeUxPYBjk6/bNkxVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F7Ykfcvp0h6C12Jt7BShNBYGEpfAXvBIAx55A0+93dBwBTPwWMwDWRrO5isUznkhU
	 itctVylBMPCseJ9S3+reU25bfhnxLGs81ROGkHDrSKeWpg/Rez1y63/E0p0lUE95MZ
	 f/u4MnqyDBhhEHDleXISBtEDS8S6m8ZqoBy++9FLbj+QOoOdhCrl4GIXgLtDV0fnor
	 mdHdAkA0VigFdnzXd0I0EUKIL42pTjUoBNZrx7zwWr/eWeE294mHLH60nGc7HBVsnN
	 mHi84Fj8xXC12VUh1R1/Dg14UV22HTZGInV0oKdkocpJo9YXz5btVupLw70hiUfFNW
	 gaqKIygTuUjnA==
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
Subject: [PATCH 03/11] moduleparam: Add DEFINE_KERNEL_PARAM_OPS macro family
Date: Thu, 21 May 2026 06:33:16 -0700
Message-Id: <20260521133326.2465264-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521133315.work.845-kees@kernel.org>
References: <20260521133315.work.845-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3674; i=kees@kernel.org; h=from:subject; bh=3qCwRbQEn6qV8q9ahXLM93O2aOukjHk7G2WsPfFNfHo=; b=owGbwMvMwCVmps19z/KJym7G02pJDFn8nAuull67+C5txg2e1YGCbPvcujb6Wx/JN/xsvCs3x vgezzqPjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIkYvWZkOH+4UFL72GLVDkfh BLNPz5NZzv2JWSzlWpkxwSTGt4VrNiPD9r2rxE49blEzn3CRa4uBQPBb6Zti6VkbO1blT5RSdFv EBQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iscas.ac.cn,suse.com,nod.at,cambridgegreys.com,sipsolutions.net,minyard.net,cmu.edu,redhat.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,acm.org,ziepe.ca,ideasonboard.com,google.com,suse.de,HansenPartnership.com,oracle.com,arm.com,linuxfoundation.org,rowland.harvard.edu,linux.alibaba.com,akamai.com,antgroup.com,orcam.me.uk,infradead.org,linux.ibm.com,alien8.de,zytor.com,atomlin.com,linux-foundation.org,canonical.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,googlegroups.com,kvack.org,lists.ubuntu.com,lists.infradead.org,lists.sourceforge.net,nongnu.org,lists.freedesktop.org,lists.ozlabs.org,lists.one-eyed-alien.net,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21113-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_GT_50(0.00)[99];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 346C85A6AB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add macros that define a struct kernel_param_ops initializer through a
macro so the underlying field layout can evolve without touching every
call site. Three variants cover the three cases:

 DEFINE_KERNEL_PARAM_OPS(name, set, get) // basic
 DEFINE_KERNEL_PARAM_OPS_NOARG(name, set, get) // set KERNEL_PARAM_OPS_FL_NOARG
 DEFINE_KERNEL_PARAM_OPS_FREE(name, set, get, free) // also set .free

Callers prefix their own visibility qualifiers, e.g.:

  static DEFINE_KERNEL_PARAM_OPS(my_ops, my_set, my_get);

Also update module_param_call() and STANDARD_PARAM_DEF() to use
DEFINE_KERNEL_PARAM_OPS internally so the generated ops table will go
through the same macro as everything else.

Subsequent commits convert all open-coded struct kernel_param_ops
definitions to use these macros, in preparation for migrating to a
seq_buf .get API.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/moduleparam.h | 36 ++++++++++++++++++++++++++++++++++--
 kernel/params.c             |  6 ++----
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 075f28585074..26bf45b36d02 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -68,6 +68,39 @@ struct kernel_param_ops {
 	void (*free)(void *arg);
 };
 
+/*
+ * Define a const struct kernel_param_ops initializer. Callers prefix with
+ * any required visibility qualifiers (typically "static"):
+ *
+ *   static DEFINE_KERNEL_PARAM_OPS(my_ops, my_set, my_get);
+ *
+ * Routing the @_set and @_get function pointers through the macro
+ * (rather than naming the struct fields at every call site) lets the
+ * field layout change in one place when callbacks are migrated to a
+ * new signature.
+ */
+#define DEFINE_KERNEL_PARAM_OPS(_name, _set, _get)			\
+	const struct kernel_param_ops _name = {				\
+		.set = (_set),						\
+		.get = (_get),						\
+	}
+
+/* As DEFINE_KERNEL_PARAM_OPS, with KERNEL_PARAM_OPS_FL_NOARG set. */
+#define DEFINE_KERNEL_PARAM_OPS_NOARG(_name, _set, _get)		\
+	const struct kernel_param_ops _name = {				\
+		.flags = KERNEL_PARAM_OPS_FL_NOARG,			\
+		.set = (_set),						\
+		.get = (_get),						\
+	}
+
+/* As DEFINE_KERNEL_PARAM_OPS, with an additional .free callback. */
+#define DEFINE_KERNEL_PARAM_OPS_FREE(_name, _set, _get, _free)		\
+	const struct kernel_param_ops _name = {				\
+		.set = (_set),						\
+		.get = (_get),						\
+		.free = (_free),					\
+	}
+
 /*
  * Flags available for kernel_param
  *
@@ -311,8 +344,7 @@ struct kparam_array
  * kernel_param_ops), use module_param_cb() instead.
  */
 #define module_param_call(name, _set, _get, arg, perm)			\
-	static const struct kernel_param_ops __param_ops_##name =	\
-		{ .flags = 0, .set = _set, .get = _get };		\
+	static DEFINE_KERNEL_PARAM_OPS(__param_ops_##name, _set, _get); \
 	__module_param_call(MODULE_PARAM_PREFIX,			\
 			    name, &__param_ops_##name, arg, perm, -1, 0)
 
diff --git a/kernel/params.c b/kernel/params.c
index 752721922a15..2cbad1f4dd06 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -222,10 +222,8 @@ char *parse_args(const char *doing,
 		return scnprintf(buffer, PAGE_SIZE, format "\n",	\
 				*((type *)kp->arg));			\
 	}								\
-	const struct kernel_param_ops param_ops_##name = {			\
-		.set = param_set_##name,				\
-		.get = param_get_##name,				\
-	};								\
+	DEFINE_KERNEL_PARAM_OPS(param_ops_##name,			\
+				param_set_##name, param_get_##name);	\
 	EXPORT_SYMBOL(param_set_##name);				\
 	EXPORT_SYMBOL(param_get_##name);				\
 	EXPORT_SYMBOL(param_ops_##name)
-- 
2.34.1


