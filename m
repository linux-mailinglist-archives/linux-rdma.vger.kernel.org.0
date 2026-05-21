Return-Path: <linux-rdma+bounces-21119-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAVyJxgWD2otFAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21119-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 16:26:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 347AD5A73BF
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 16:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C3203357649
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAD13D3D00;
	Thu, 21 May 2026 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faqBkEGM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB0C3E9299;
	Thu, 21 May 2026 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370412; cv=none; b=ZQqw0O0Qhekez2lfzJrddNsBMiJZHjcHJ8QiHMi1hl+8aNxD1g27BBsbY4Ttbo1/lNvQxUdCgqPl9JwCNsgAhJrBWsXrQUnWAyHeWQBAr0Pg4gRfsocr5jnOHLfANn4QqlIqOt3vdxNsA9znq65vqDEKXaEoha4KS508Chq5l08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370412; c=relaxed/simple;
	bh=cZc+JELjQTK8ycLqZtLTkP9aHNuVqrWgrD/YlzSeCsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4dV8Pgo7JmVbJ/omKSam9fMN9KFzg+AEuQj2J8pVEuo5r3K+wAPtGUMl6fOzEobqBKfp0nLO/Y55LwMIHztvgZ3/Rm7nFHTmkvF7BpcuTheBOn7KTvvtovAZyV1nYPhQ9ukfR7L+H0VynC7VpKgDXhIWYj9riX7Avk6K66lVzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faqBkEGM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC0C1F01579;
	Thu, 21 May 2026 13:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779370407;
	bh=xwIDnz4Pf2a/0Wouv4cV1Bk8/fwt1/yHjZ8WyMRsm0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=faqBkEGM4aU15rBNkXIkUKRG5AsCe1S2Aewj2Tv1k/O0IFENHWQB9BDl0qYlYUXx1
	 yoSYnXrOdkYgaAvt93OzOSpjQt1HbLSZILUsO+WwAhtrliX5J0FzgX8CuujFmAl5jz
	 X8uTF9W4laMnV0lw73DuAepv0e1Z18zWI5AlF6sh7C8rwcqpQzvp1cimaV2in+YUgi
	 OE4BwyWmDWxhcTmmdjqIRpFm9oVrWPKzXOPW22NTkxkdTVTWD9EOmYqsfX8zmiSFqR
	 Z0nWrODWYXeXSYKufMtwTaK1WxYbFWleRdtaUyw1XtWk0UguQM98XV3sxBpbdWcKqK
	 7ltRkG3vLauMQ==
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
Subject: [PATCH 11/11] moduleparam: Drop legacy kernel_param_ops .get_str field and dispatch logic
Date: Thu, 21 May 2026 06:33:24 -0700
Message-Id: <20260521133326.2465264-11-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521133315.work.845-kees@kernel.org>
References: <20260521133315.work.845-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6078; i=kees@kernel.org; h=from:subject; bh=cZc+JELjQTK8ycLqZtLTkP9aHNuVqrWgrD/YlzSeCsM=; b=owGbwMvMwCVmps19z/KJym7G02pJDFn8nEvufDYVreO77zyVZ9nKv/dmtn67mvlTQuv4kafPq puKFFykO0pZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACZyUpThn+GuD2261nV35Y9v WCSkdjztcECEh/yOmilbnsu+Me2RqGb4X3Y7PuFYwqXlesy7khtcFv4xWB144Q33rOMlXKUF6Yq CDAA=
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
	TAGGED_FROM(0.00)[bounces-21119-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 347AD5A73BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

All struct kernel_param_ops .get callbacks have been migrated to using
struct seq_buf. Drop the migration scaffolding.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/moduleparam.h | 37 ++--------------------
 kernel/params.c             | 62 ++++++++++---------------------------
 2 files changed, 20 insertions(+), 79 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 38acb5aef56b..e6af6f051c93 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -66,15 +66,8 @@ struct kernel_param_ops {
 	/*
 	 * Format the parameter's value into @s.  Return 0 on success
 	 * (length derived from seq_buf_used()) or -errno on error.
-	 * Exactly one of .get and .get_str should be set; the dispatcher
-	 * WARNs and prefers .get if both are.
 	 */
 	int (*get)(struct seq_buf *s, const struct kernel_param *kp);
-	/*
-	 * Returns length written or -errno.  Buffer is 4k (ie. be short!).
-	 * Deprecated: callbacks should implement .get instead.
-	 */
-	int (*get_str)(char *buffer, const struct kernel_param *kp);
 	/* Optional function to free kp->arg when module unloaded. */
 	void (*free)(void *arg);
 };
@@ -84,33 +77,11 @@ struct kernel_param_ops {
  * any required visibility qualifiers (typically "static"):
  *
  *   static DEFINE_KERNEL_PARAM_OPS(my_ops, my_set, my_get);
- *
- * @_get may be either of:
- *   int (*)(struct seq_buf *, const struct kernel_param *) (seq_buf)
- *   int (*)(char *, const struct kernel_param *)           (legacy)
- *
- * The macro uses _Generic to route the function pointer to the
- * matching field (.get or .get_str) at compile time, leaving the
- * other field NULL. Each helper matches the wrong prototype signature
- * and returns NULL, falling through to the default branch otherwise;
- * if @_get has neither expected signature the assignment to the
- * fields gets a normal compile-time type-mismatch error.
  */
-#define _KERNEL_PARAM_OPS_GET(_get)					\
-	_Generic((_get),						\
-	    int (*)(char *, const struct kernel_param *): NULL,		\
-	    default: (_get))
-
-#define _KERNEL_PARAM_OPS_GET_STR(_get)					\
-	_Generic((_get),						\
-	    int (*)(struct seq_buf *, const struct kernel_param *): NULL, \
-	    default: (_get))
-
 #define DEFINE_KERNEL_PARAM_OPS(_name, _set, _get)			\
 	const struct kernel_param_ops _name = {				\
 		.set = (_set),						\
-		.get = _KERNEL_PARAM_OPS_GET(_get),			\
-		.get_str = _KERNEL_PARAM_OPS_GET_STR(_get),		\
+		.get = (_get),						\
 	}
 
 /* As DEFINE_KERNEL_PARAM_OPS, with KERNEL_PARAM_OPS_FL_NOARG set. */
@@ -118,16 +89,14 @@ struct kernel_param_ops {
 	const struct kernel_param_ops _name = {				\
 		.flags = KERNEL_PARAM_OPS_FL_NOARG,			\
 		.set = (_set),						\
-		.get = _KERNEL_PARAM_OPS_GET(_get),			\
-		.get_str = _KERNEL_PARAM_OPS_GET_STR(_get),		\
+		.get = (_get),						\
 	}
 
 /* As DEFINE_KERNEL_PARAM_OPS, with an additional .free callback. */
 #define DEFINE_KERNEL_PARAM_OPS_FREE(_name, _set, _get, _free)		\
 	const struct kernel_param_ops _name = {				\
 		.set = (_set),						\
-		.get = _KERNEL_PARAM_OPS_GET(_get),			\
-		.get_str = _KERNEL_PARAM_OPS_GET_STR(_get),		\
+		.get = (_get),						\
 		.free = (_free),					\
 	}
 
diff --git a/kernel/params.c b/kernel/params.c
index 25f0c8d5d19f..6b410189297b 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -461,8 +461,7 @@ static int param_array_get(struct seq_buf *s, const struct kernel_param *kp)
 {
 	const struct kparam_array *arr = kp->arr;
 	struct kernel_param p = *kp;
-	char *elem_buf = NULL;
-	int i, ret = 0;
+	int i, ret;
 
 	for (i = 0; i < (arr->num ? *arr->num : arr->max); i++) {
 		size_t before = s->len;
@@ -470,23 +469,9 @@ static int param_array_get(struct seq_buf *s, const struct kernel_param *kp)
 		p.arg = arr->elem + arr->elemsize * i;
 		check_kparam_locked(p.mod);
 
-		if (arr->ops->get) {
-			ret = arr->ops->get(s, &p);
-			if (ret < 0)
-				goto out;
-		} else {
-			if (!elem_buf) {
-				elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-				if (!elem_buf) {
-					ret = -ENOMEM;
-					goto out;
-				}
-			}
-			ret = arr->ops->get_str(elem_buf, &p);
-			if (ret < 0)
-				goto out;
-			seq_buf_putmem(s, elem_buf, ret);
-		}
+		ret = arr->ops->get(s, &p);
+		if (ret < 0)
+			return ret;
 
 		/* Nothing got written (e.g. overflow) — stop. */
 		if (s->len == before)
@@ -496,10 +481,7 @@ static int param_array_get(struct seq_buf *s, const struct kernel_param *kp)
 		if (i && s->buffer[before - 1] == '\n')
 			s->buffer[before - 1] = ',';
 	}
-	ret = 0;
-out:
-	kfree(elem_buf);
-	return ret;
+	return 0;
 }
 
 static void param_array_free(void *arg)
@@ -570,32 +552,22 @@ static ssize_t param_attr_show(const struct module_attribute *mattr,
 	int count;
 	const struct param_attribute *attribute = to_param_attr(mattr);
 	const struct kernel_param_ops *ops = attribute->param->ops;
+	struct seq_buf s;
 
-	if (!ops->get && !ops->get_str)
+	if (!ops->get)
 		return -EPERM;
 
-	WARN_ON_ONCE(ops->get && ops->get_str);
-
 	kernel_param_lock(mk->mod);
-	if (ops->get) {
-		struct seq_buf s;
-
-		seq_buf_init(&s, buf, PAGE_SIZE);
-		count = ops->get(&s, attribute->param);
-		if (count >= 0) {
-			WARN_ON_ONCE(count > 0);
-			count = seq_buf_used(&s);
-			/* Make sure string is terminated. */
-			seq_buf_str(&s);
-			/*
-			 * If overflowed, reduce count by 1 for trailing
-			 * NUL byte.
-			 */
-			if (seq_buf_has_overflowed(&s))
-				count--;
-		}
-	} else {
-		count = ops->get_str(buf, attribute->param);
+	seq_buf_init(&s, buf, PAGE_SIZE);
+	count = ops->get(&s, attribute->param);
+	if (count >= 0) {
+		WARN_ON_ONCE(count > 0);
+		count = seq_buf_used(&s);
+		/* Make sure string is terminated. */
+		seq_buf_str(&s);
+		/* If overflowed, reduce count by 1 for trailing NUL byte. */
+		if (seq_buf_has_overflowed(&s))
+			count--;
 	}
 	kernel_param_unlock(mk->mod);
 	return count;
-- 
2.34.1


