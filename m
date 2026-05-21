Return-Path: <linux-rdma+bounces-21116-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOeBH38ND2p7EgYAu9opvQ
	(envelope-from <linux-rdma+bounces-21116-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 15:49:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A9F5A6449
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 15:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4041E30E776E
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DC13FE65F;
	Thu, 21 May 2026 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpoUzNBk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BFF3DA5B7;
	Thu, 21 May 2026 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370411; cv=none; b=JF2rbpsvW2JPz1gjOYVw3/DzdTvu2KClu1AoSt2ZXQMR6IAhDhxnmncjN2uYtX0zfGf5neSB7Ddtlt7oK/UHhHqKfG8Zu6HNo1tZ7r4iSOT/HDNds0HHfP8x9Vbmm+SNVEFII9AdcMjf52TMggkzkrvH34SZ8j6O2CvYtRlvTLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370411; c=relaxed/simple;
	bh=2lh9CsqKOjpmr9LD0n2okA9BehPWair2DlPnlZ1PFPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sfOk0UaMuTsLRncK85UI6eUlby48UwdhPwQCAHXM4liQxvnXyV0U3rzMr3xGK/xnth+LaVSm4flEsjT+Q6lJVCL/h7h3R4krayLbEBYw9Rgfk2bL+QT/7E7JQvhd+pZapO/jEuc6HMV87fPC/nI4FKkSDs5QXAMr7KruPelE3o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpoUzNBk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58EF1F00A3D;
	Thu, 21 May 2026 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779370407;
	bh=Z+Ub2Rsd9ANQzKOVawxbbCdlC+pecLG/P/kzOLcGitU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZpoUzNBkBmEW2LjaiIoOOC4s+n979icMv2wlmoYSc25V3dGNAjG0gbL9a5wg2u47P
	 VMxYDF0mYXlyeJyFUXl8jiRf3bxPYJJCLvPOeZSAS7DGYujM6mps9FRxfnjPXWQxhX
	 xRaSPhmPxfOjP6QLUe/QgXf9nn4rloFvMFaamf2Q86gUDNKjRzgCW+SsEmbE7ZNswt
	 y17z+o7t1YKntzAEH8VfbQJr1zSboc8FGZbuD7YpeFtpKlorEPTAdUvz75ERJ5b83/
	 QUEgdBC7DVG7whLHuJRPnbclLcdfN+VSV+tx+pv1gVT/04XqXEZRewE4Hdv/XUfpxv
	 A6xTQa8PPiphg==
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
Subject: [PATCH 07/11] moduleparam: Route DEFINE_KERNEL_PARAM_OPS get pointer via _Generic
Date: Thu, 21 May 2026 06:33:20 -0700
Message-Id: <20260521133326.2465264-7-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521133315.work.845-kees@kernel.org>
References: <20260521133315.work.845-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3477; i=kees@kernel.org; h=from:subject; bh=2lh9CsqKOjpmr9LD0n2okA9BehPWair2DlPnlZ1PFPc=; b=owGbwMvMwCVmps19z/KJym7G02pJDFn8nIvObEzOv8f9Ny7fU3+K4MU31w3MLlQyBTD1ZzTfl utOmiLfUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJH4IkaGFVpms4oL+z/8iFoh P+POhcufipWWltm+L/CUOcml8euoBcP/rN0OUi7qm2bpPqgPYTsts70rWLI43Obl45kHtE0r/7Q yAAA=
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
	TAGGED_FROM(0.00)[bounces-21116-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 36A9F5A6449
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make the DEFINE_KERNEL_PARAM_OPS family route their _get argument to
either .get (struct seq_buf *) or .get_str (char *) at compile time
based on the pointer's actual function signature. Two helper macros
do the routing:

  _KERNEL_PARAM_OPS_GET     - return the pointer if it has the seq_buf
                              signature, otherwise NULL of that type
  _KERNEL_PARAM_OPS_GET_STR - mirror image for the char * signature

Both use _Generic; only the two valid function-pointer types are
listed, so any third-party type is a compile error rather than
silently falling through.

Now a callback whose body has been migrated from char * to struct
seq_buf * needs no change at its kernel_param_ops initialization site,
because the macro picks up the new type automatically and assigns to
the correct field.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/moduleparam.h | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index c52120f6ac28..795bc7c654ef 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -85,15 +85,32 @@ struct kernel_param_ops {
  *
  *   static DEFINE_KERNEL_PARAM_OPS(my_ops, my_set, my_get);
  *
- * Routing the @_set and @_get function pointers through the macro
- * (rather than naming the struct fields at every call site) lets the
- * field layout change in one place when callbacks are migrated to a
- * new signature.
+ * @_get may be either of:
+ *   int (*)(struct seq_buf *, const struct kernel_param *) (seq_buf)
+ *   int (*)(char *, const struct kernel_param *)           (legacy)
+ *
+ * The macro uses _Generic to route the function pointer to the
+ * matching field (.get or .get_str) at compile time, leaving the
+ * other field NULL. Each helper matches the wrong prototype signature
+ * and returns NULL, falling through to the default branch otherwise;
+ * if @_get has neither expected signature the assignment to the
+ * fields gets a normal compile-time type-mismatch error.
  */
+#define _KERNEL_PARAM_OPS_GET(_get)					\
+	_Generic((_get),						\
+	    int (*)(char *, const struct kernel_param *): NULL,		\
+	    default: (_get))
+
+#define _KERNEL_PARAM_OPS_GET_STR(_get)					\
+	_Generic((_get),						\
+	    int (*)(struct seq_buf *, const struct kernel_param *): NULL, \
+	    default: (_get))
+
 #define DEFINE_KERNEL_PARAM_OPS(_name, _set, _get)			\
 	const struct kernel_param_ops _name = {				\
 		.set = (_set),						\
-		.get_str = (_get),					\
+		.get = _KERNEL_PARAM_OPS_GET(_get),			\
+		.get_str = _KERNEL_PARAM_OPS_GET_STR(_get),		\
 	}
 
 /* As DEFINE_KERNEL_PARAM_OPS, with KERNEL_PARAM_OPS_FL_NOARG set. */
@@ -101,14 +118,16 @@ struct kernel_param_ops {
 	const struct kernel_param_ops _name = {				\
 		.flags = KERNEL_PARAM_OPS_FL_NOARG,			\
 		.set = (_set),						\
-		.get_str = (_get),					\
+		.get = _KERNEL_PARAM_OPS_GET(_get),			\
+		.get_str = _KERNEL_PARAM_OPS_GET_STR(_get),		\
 	}
 
 /* As DEFINE_KERNEL_PARAM_OPS, with an additional .free callback. */
 #define DEFINE_KERNEL_PARAM_OPS_FREE(_name, _set, _get, _free)		\
 	const struct kernel_param_ops _name = {				\
 		.set = (_set),						\
-		.get_str = (_get),					\
+		.get = _KERNEL_PARAM_OPS_GET(_get),			\
+		.get_str = _KERNEL_PARAM_OPS_GET_STR(_get),		\
 		.free = (_free),					\
 	}
 
-- 
2.34.1


