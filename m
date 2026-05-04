Return-Path: <linux-rdma+bounces-19930-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aG/pDB6m+GnQxQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19930-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 15:58:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C01434BE3CF
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 15:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D908300B9CC
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 13:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876813DE420;
	Mon,  4 May 2026 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="QGZSrSe7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD643DDDDA
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903087; cv=none; b=PLXTH08PLuqGBsPdZB97DID7JVFOQpLS4Iu8CB9RRIoikRH25toVebSpGZvpIt/RBgc160VSiQkqYV4Vt6zYriVr2pdnVoGbtZ5VM5my5stUVyWHhosQBoIDWgMP58122oxbV65IqZRnxdq+iFdTKXqGPfNq6+8fa1fpZDdjsyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903087; c=relaxed/simple;
	bh=uiSCXqjUffG03o5JxWdl1Of2zodJSQCnFoc9BXsi9FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gy8qv90cGy3C4DldRbEwJO414CGlYM38Hkwvxk178VRvew5JsTsWY6yXlq2V1iCs35ZO/b5OA7vs9lp2tRl8S3cnt1ahLUV57hv2eNwYCwTZP7l3VTN/djiIWeUjhxTc0m1yc7RTZjbiJ+FUQQRBXHKGhR/QICIVdUKZzyoKk5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=QGZSrSe7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891cd41959so33162975e9.3
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 06:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777903084; x=1778507884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDh42rzLtlbt49U05JfzxjBihAMvOt2xBaAmU+fa8bQ=;
        b=QGZSrSe7aApNctDUuzHNxAKLl2GgBKvfmzBKNEF2MyLKen2xKRBa/3uYhhzJz63t/e
         HcsZ2Fmhxb8KfTnzF18ViyngWyHABEVsiooA/hel/ZEoms3XSkAOLuDTdG5xhq9qesGn
         Yz8qOqErRtuZMRAuuBFHXCvA6gPzndYlAemjGemwXUm8igrFH2ixNF8ON6dtAAzgzU3K
         fGrTwjVnb8QwkU8QQTmUpm0y7lv11hCmGVLNJkANscp6mznftgyDG0O3WygcSZyAV4rI
         SDKt1/vqMubeeSJjgxnpCNN19HjBTGSNE6/I/2EXgmm75QF27lY3uwUrQ1gOoG1d8MkF
         I3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903084; x=1778507884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NDh42rzLtlbt49U05JfzxjBihAMvOt2xBaAmU+fa8bQ=;
        b=CDevbmXgf7ivDHp2pQ/PVhTNrPZjOI9YKhPCRDyBWHS2ZthXocnvlIBQsfHhULqFYS
         AczrM14Y54PEE3R2W7kX7bIfw5/dkwGK8zVF4fMkExaE/U314BvV9qeX350KMZwULDyf
         Kp8m8ZNzSd3HhbQG0P9ev6+pNRAbq99rrit99XXNyWJ/KDioIryB57Zj2+jKlna0zb+L
         6uUS2bayC3JqyTG8/YjzMyWzO+1BdzXrrFBmBRHCoaqKPqwnOnmFFKlqFzu6bQ9UqRiF
         yE9OjYvMtX3zqyibIQ22CtGYVTUy6QppcnEsR7zCSnDXhSD8027xCiFJXeZi067PubuU
         zMEA==
X-Gm-Message-State: AOJu0YzDXAwMEBV2cLWPoqDx1McfzvlPP6T3mIfm2kNwJ+F8DKDCRgh3
	FXjsNzblxtMh7Gp8BCNgHi1vabHG3OuujFjbXHnsBhAKwVXxX6Px8wb1jhoi3m9dHiKI5d3msVN
	TfO4bIDY=
X-Gm-Gg: AeBDietanSsk5E7vfEIBRzjFGk7VeCuKBJyj/mtKA8MQLPs3NkSV+e8GYIEvDrGx0Xi
	ILhTsnv1eUdAmuDdrd6m2ZCvofGAvFtcX9MJ5KaOg2MFZpPZapWyFx3l7cPi92e2TcACMPaq5yK
	PBFBpsH/T5jxyYFJ3wDpqH306bKB6PcSxDHCRVCgD0o6ohbOph0C3mhlbemizEIozcIfa+ZOJSn
	lpFrTAuSUXHH0YcltUpuLKKtp4aJYUR6JYCKhHPRC5osTetYcuTBOpLJ+fJRysc91yrMQjoCjTQ
	Ea4R4Im8LjX4MS38qerp6goWgwg0trYj6xx0RVrDfAWVT1kVKtvG3AVRIQ9vWBhfPrEBDCQf7BL
	0IhchJN7/mtWqItxLkyDujdEtw6RUrK9Dc615o+ijnTVr5ceBA2ZjCwrPhBSiEbyeZyV2N2b7NZ
	0WuxS7OUz6fbpQZ8V9L694S2XF
X-Received: by 2002:a05:600c:530e:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48a9865ad96mr172113375e9.17.1777903083730;
        Mon, 04 May 2026 06:58:03 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee4f79sm77808735e9.20.2026.05.04.06.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:58:03 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com,
	gal.pressman@linux.dev,
	sleybo@amazon.com,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yanjun.zhu@linux.dev,
	marco.crivellari@suse.com,
	roman.gushchin@linux.dev,
	phaddad@nvidia.com,
	lirongqing@baidu.com,
	ynachum@amazon.com,
	huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com,
	michaelgur@nvidia.com,
	shayd@nvidia.com,
	edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: [PATCH rdma-next v3 17/17] RDMA/uverbs: Track attr consumption and warn on unused attrs
Date: Mon,  4 May 2026 15:57:31 +0200
Message-ID: <20260504135731.2345383-18-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504135731.2345383-1-jiri@resnulli.us>
References: <20260504135731.2345383-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C01434BE3CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19930-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim]

From: Jiri Pirko <jiri@nvidia.com>

Catch userspace passing attributes that nothing in the kernel
reads which would be a sign that the driver doesn't support
a feature, an attr was forgotten in a refactor, or userspace is buggy.
UHW and PTR_OUT attrs are exempt; destroy attrs are marked consumed by
the framework. Gate on CONFIG_DEBUG_KERNEL to avoid overhead on
production kernels.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 drivers/infiniband/core/rdma_core.h    |  2 +-
 drivers/infiniband/core/uverbs_ioctl.c | 55 +++++++++++++++++++++++---
 include/rdma/uverbs_ioctl.h            | 54 ++++++++++++++-----------
 3 files changed, 82 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/rdma_core.h
index 269b393799ab..06b735f6b3ac 100644
--- a/drivers/infiniband/core/rdma_core.h
+++ b/drivers/infiniband/core/rdma_core.h
@@ -67,7 +67,7 @@ void uverbs_finalize_object(struct ib_uobject *uobj,
 			    enum uverbs_obj_access access, bool hw_obj_valid,
 			    bool commit, struct uverbs_attr_bundle *attrs);
 
-int uverbs_output_written(const struct uverbs_attr_bundle *bundle, size_t idx);
+int uverbs_output_written(struct uverbs_attr_bundle *bundle, size_t idx);
 
 void setup_ufile_idr_uobject(struct ib_uverbs_file *ufile);
 void release_ufile_idr_uobject(struct ib_uverbs_file *ufile);
diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
index a2182d3401da..e626b7f4e6eb 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -438,6 +438,40 @@ static int uverbs_set_attr(struct bundle_priv *pbundle,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_DEBUG_KERNEL)
+static void uverbs_check_attr_consumption(struct bundle_priv *pbundle)
+{
+	const struct uverbs_api_ioctl_method *method = pbundle->method_elm;
+	struct uverbs_attr_bundle *bundle =
+		container_of(&pbundle->bundle, struct uverbs_attr_bundle, hdr);
+	unsigned int bkey;
+
+	for_each_set_bit(bkey, bundle->attr_present, method->key_bitmap_len) {
+		const struct uverbs_api_attr *attr_uapi;
+		const struct uverbs_attr_spec *spec;
+		void __rcu **slot;
+
+		if (test_bit(bkey, bundle->attr_consumed))
+			continue;
+
+		slot = uapi_get_attr_for_method(pbundle,
+						uapi_bkey_to_key_attr(bkey));
+		if (!slot)
+			continue;
+		attr_uapi = rcu_dereference_protected(*slot, true);
+		spec = &attr_uapi->spec;
+
+		if (spec->is_udata)
+			continue;
+		if (spec->type == UVERBS_ATTR_TYPE_PTR_OUT)
+			continue;
+
+		pr_warn_ratelimited("uverbs: method_key=0x%x bkey=%u attr provided by user but not consumed\n",
+				    pbundle->method_key, bkey);
+	}
+}
+#endif
+
 static int ib_uverbs_run_method(struct bundle_priv *pbundle,
 				unsigned int num_attrs)
 {
@@ -487,6 +521,9 @@ static int ib_uverbs_run_method(struct bundle_priv *pbundle,
 		if (ret)
 			return ret;
 		__clear_bit(destroy_bkey, pbundle->uobj_finalize);
+#if IS_ENABLED(CONFIG_DEBUG_KERNEL)
+		__set_bit(destroy_bkey, bundle->attr_consumed);
+#endif
 
 		ret = handler(bundle);
 		uobj_put_destroy(destroy_attr->uobject);
@@ -515,6 +552,10 @@ static int ib_uverbs_run_method(struct bundle_priv *pbundle,
 	if (WARN_ON_ONCE(ret == -EPROTONOSUPPORT))
 		return -EINVAL;
 
+#if IS_ENABLED(CONFIG_DEBUG_KERNEL)
+	if (!ret)
+		uverbs_check_attr_consumption(pbundle);
+#endif
 	return ret;
 }
 
@@ -623,6 +664,10 @@ static int ib_uverbs_cmd_verbs(struct ib_uverbs_file *ufile,
 					       sizeof(*pbundle->internal_buffer));
 	memset(pbundle->bundle.attr_present, 0,
 	       sizeof(pbundle->bundle.attr_present));
+#if IS_ENABLED(CONFIG_DEBUG_KERNEL)
+	memset(pbundle->bundle.attr_consumed, 0,
+	       sizeof(pbundle->bundle.attr_consumed));
+#endif
 	memset(pbundle->uobj_finalize, 0, sizeof(pbundle->uobj_finalize));
 	memset(pbundle->spec_finalize, 0, sizeof(pbundle->spec_finalize));
 	memset(pbundle->uobj_hw_obj_valid, 0,
@@ -662,7 +707,7 @@ long ib_uverbs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	return err;
 }
 
-int uverbs_get_flags64(u64 *to, const struct uverbs_attr_bundle *attrs_bundle,
+int uverbs_get_flags64(u64 *to, struct uverbs_attr_bundle *attrs_bundle,
 		       size_t idx, u64 allowed_bits)
 {
 	const struct uverbs_attr *attr;
@@ -695,7 +740,7 @@ int uverbs_get_flags64(u64 *to, const struct uverbs_attr_bundle *attrs_bundle,
 }
 EXPORT_SYMBOL(uverbs_get_flags64);
 
-int uverbs_get_flags32(u32 *to, const struct uverbs_attr_bundle *attrs_bundle,
+int uverbs_get_flags32(u32 *to, struct uverbs_attr_bundle *attrs_bundle,
 		       size_t idx, u64 allowed_bits)
 {
 	u64 flags;
@@ -753,7 +798,7 @@ void uverbs_fill_udata(struct uverbs_attr_bundle *bundle,
 	}
 }
 
-int uverbs_copy_to(const struct uverbs_attr_bundle *bundle, size_t idx,
+int uverbs_copy_to(struct uverbs_attr_bundle *bundle, size_t idx,
 		   const void *from, size_t size)
 {
 	const struct uverbs_attr *attr = uverbs_attr_get(bundle, idx);
@@ -775,7 +820,7 @@ EXPORT_SYMBOL(uverbs_copy_to);
  * This is only used if the caller has directly used copy_to_use to write the
  * data.  It signals to user space that the buffer is filled in.
  */
-int uverbs_output_written(const struct uverbs_attr_bundle *bundle, size_t idx)
+int uverbs_output_written(struct uverbs_attr_bundle *bundle, size_t idx)
 {
 	const struct uverbs_attr *attr = uverbs_attr_get(bundle, idx);
 
@@ -785,7 +830,7 @@ int uverbs_output_written(const struct uverbs_attr_bundle *bundle, size_t idx)
 	return uverbs_set_output(bundle, attr);
 }
 
-int uverbs_copy_to_struct_or_zero(const struct uverbs_attr_bundle *bundle,
+int uverbs_copy_to_struct_or_zero(struct uverbs_attr_bundle *bundle,
 				  size_t idx, const void *from, size_t size)
 {
 	const struct uverbs_attr *attr = uverbs_attr_get(bundle, idx);
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index 70caa7299dbf..386732094978 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -648,6 +648,9 @@ struct uverbs_attr_bundle {
 		struct ib_ucontext *context;
 		struct ib_uobject *uobject;
 		DECLARE_BITMAP(attr_present, UVERBS_API_ATTR_BKEY_LEN);
+#if IS_ENABLED(CONFIG_DEBUG_KERNEL)
+		DECLARE_BITMAP(attr_consumed, UVERBS_API_ATTR_BKEY_LEN);
+#endif
 	);
 	struct uverbs_attr attrs[];
 };
@@ -683,16 +686,20 @@ struct ib_device *rdma_udata_to_dev(struct ib_udata *udata);
 
 #define IS_UVERBS_COPY_ERR(_ret)		((_ret) && (_ret) != -ENOENT)
 
-static inline const struct uverbs_attr *uverbs_attr_get(const struct uverbs_attr_bundle *attrs_bundle,
+static inline const struct uverbs_attr *uverbs_attr_get(struct uverbs_attr_bundle *attrs_bundle,
 							u16 idx)
 {
 	if (!uverbs_attr_is_valid(attrs_bundle, idx))
 		return ERR_PTR(-ENOENT);
 
+#if IS_ENABLED(CONFIG_DEBUG_KERNEL)
+	__set_bit(uapi_bkey_attr(uapi_key_attr(idx)),
+		  attrs_bundle->attr_consumed);
+#endif
 	return &attrs_bundle->attrs[uapi_bkey_attr(uapi_key_attr(idx))];
 }
 
-static inline int uverbs_attr_get_enum_id(const struct uverbs_attr_bundle *attrs_bundle,
+static inline int uverbs_attr_get_enum_id(struct uverbs_attr_bundle *attrs_bundle,
 					  u16 idx)
 {
 	const struct uverbs_attr *attr = uverbs_attr_get(attrs_bundle, idx);
@@ -703,7 +710,7 @@ static inline int uverbs_attr_get_enum_id(const struct uverbs_attr_bundle *attrs
 	return attr->ptr_attr.enum_id;
 }
 
-static inline void *uverbs_attr_get_obj(const struct uverbs_attr_bundle *attrs_bundle,
+static inline void *uverbs_attr_get_obj(struct uverbs_attr_bundle *attrs_bundle,
 					u16 idx)
 {
 	const struct uverbs_attr *attr;
@@ -715,7 +722,7 @@ static inline void *uverbs_attr_get_obj(const struct uverbs_attr_bundle *attrs_b
 	return attr->obj_attr.uobject->object;
 }
 
-static inline struct ib_uobject *uverbs_attr_get_uobject(const struct uverbs_attr_bundle *attrs_bundle,
+static inline struct ib_uobject *uverbs_attr_get_uobject(struct uverbs_attr_bundle *attrs_bundle,
 							 u16 idx)
 {
 	const struct uverbs_attr *attr = uverbs_attr_get(attrs_bundle, idx);
@@ -727,7 +734,7 @@ static inline struct ib_uobject *uverbs_attr_get_uobject(const struct uverbs_att
 }
 
 static inline int
-uverbs_attr_get_len(const struct uverbs_attr_bundle *attrs_bundle, u16 idx)
+uverbs_attr_get_len(struct uverbs_attr_bundle *attrs_bundle, u16 idx)
 {
 	const struct uverbs_attr *attr = uverbs_attr_get(attrs_bundle, idx);
 
@@ -771,7 +778,7 @@ uverbs_attr_ptr_get_array_size(struct uverbs_attr_bundle *attrs, u16 idx,
  * Return: The array length or 0 if no attribute was provided.
  */
 static inline int uverbs_attr_get_uobjs_arr(
-	const struct uverbs_attr_bundle *attrs_bundle, u16 attr_idx,
+	struct uverbs_attr_bundle *attrs_bundle, u16 attr_idx,
 	struct ib_uobject ***arr)
 {
 	const struct uverbs_attr *attr =
@@ -793,7 +800,7 @@ static inline bool uverbs_attr_ptr_is_inline(const struct uverbs_attr *attr)
 }
 
 static inline void *uverbs_attr_get_alloced_ptr(
-	const struct uverbs_attr_bundle *attrs_bundle, u16 idx)
+	struct uverbs_attr_bundle *attrs_bundle, u16 idx)
 {
 	const struct uverbs_attr *attr = uverbs_attr_get(attrs_bundle, idx);
 
@@ -805,7 +812,7 @@ static inline void *uverbs_attr_get_alloced_ptr(
 }
 
 static inline int _uverbs_copy_from(void *to,
-				    const struct uverbs_attr_bundle *attrs_bundle,
+				    struct uverbs_attr_bundle *attrs_bundle,
 				    size_t idx,
 				    size_t size)
 {
@@ -832,7 +839,7 @@ static inline int _uverbs_copy_from(void *to,
 }
 
 static inline int _uverbs_copy_from_or_zero(void *to,
-					    const struct uverbs_attr_bundle *attrs_bundle,
+					    struct uverbs_attr_bundle *attrs_bundle,
 					    size_t idx,
 					    size_t size)
 {
@@ -869,11 +876,11 @@ ib_uverbs_get_ucontext(const struct uverbs_attr_bundle *attrs)
 }
 
 #if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
-int uverbs_get_flags64(u64 *to, const struct uverbs_attr_bundle *attrs_bundle,
+int uverbs_get_flags64(u64 *to, struct uverbs_attr_bundle *attrs_bundle,
 		       size_t idx, u64 allowed_bits);
-int uverbs_get_flags32(u32 *to, const struct uverbs_attr_bundle *attrs_bundle,
+int uverbs_get_flags32(u32 *to, struct uverbs_attr_bundle *attrs_bundle,
 		       size_t idx, u64 allowed_bits);
-int uverbs_copy_to(const struct uverbs_attr_bundle *attrs_bundle, size_t idx,
+int uverbs_copy_to(struct uverbs_attr_bundle *attrs_bundle, size_t idx,
 		   const void *from, size_t size);
 __malloc void *_uverbs_alloc(struct uverbs_attr_bundle *bundle, size_t size,
 			     gfp_t flags);
@@ -902,7 +909,7 @@ static inline __malloc void *uverbs_kcalloc(struct uverbs_attr_bundle *bundle,
 
 static inline int
 _uverbs_get_const_signed(s64 *to,
-			 const struct uverbs_attr_bundle *attrs_bundle,
+			 struct uverbs_attr_bundle *attrs_bundle,
 			 size_t idx, s64 lower_bound, u64 upper_bound,
 			 s64 *def_val)
 {
@@ -925,7 +932,7 @@ _uverbs_get_const_signed(s64 *to,
 
 static inline int
 _uverbs_get_const_unsigned(u64 *to,
-			   const struct uverbs_attr_bundle *attrs_bundle,
+			   struct uverbs_attr_bundle *attrs_bundle,
 			   size_t idx, u64 upper_bound, u64 *def_val)
 {
 	const struct uverbs_attr *attr;
@@ -944,7 +951,8 @@ _uverbs_get_const_unsigned(u64 *to,
 
 	return 0;
 }
-int uverbs_copy_to_struct_or_zero(const struct uverbs_attr_bundle *bundle,
+
+int uverbs_copy_to_struct_or_zero(struct uverbs_attr_bundle *bundle,
 				  size_t idx, const void *from, size_t size);
 
 int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
@@ -952,18 +960,18 @@ int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
 int _ib_respond_udata(struct ib_udata *udata, const void *src, size_t len);
 #else
 static inline int
-uverbs_get_flags64(u64 *to, const struct uverbs_attr_bundle *attrs_bundle,
+uverbs_get_flags64(u64 *to, struct uverbs_attr_bundle *attrs_bundle,
 		   size_t idx, u64 allowed_bits)
 {
 	return -EINVAL;
 }
 static inline int
-uverbs_get_flags32(u32 *to, const struct uverbs_attr_bundle *attrs_bundle,
+uverbs_get_flags32(u32 *to, struct uverbs_attr_bundle *attrs_bundle,
 		   size_t idx, u64 allowed_bits)
 {
 	return -EINVAL;
 }
-static inline int uverbs_copy_to(const struct uverbs_attr_bundle *attrs_bundle,
+static inline int uverbs_copy_to(struct uverbs_attr_bundle *attrs_bundle,
 				 size_t idx, const void *from, size_t size)
 {
 	return -EINVAL;
@@ -979,21 +987,21 @@ static inline __malloc void *uverbs_zalloc(struct uverbs_attr_bundle *bundle,
 	return ERR_PTR(-EINVAL);
 }
 static inline int
-_uverbs_get_const(s64 *to, const struct uverbs_attr_bundle *attrs_bundle,
+_uverbs_get_const(s64 *to, struct uverbs_attr_bundle *attrs_bundle,
 		  size_t idx, s64 lower_bound, u64 upper_bound,
 		  s64 *def_val)
 {
 	return -EINVAL;
 }
 static inline int
-uverbs_copy_to_struct_or_zero(const struct uverbs_attr_bundle *bundle,
+uverbs_copy_to_struct_or_zero(struct uverbs_attr_bundle *bundle,
 			      size_t idx, const void *from, size_t size)
 {
 	return -EINVAL;
 }
 static inline int
 _uverbs_get_const_signed(s64 *to,
-			 const struct uverbs_attr_bundle *attrs_bundle,
+			 struct uverbs_attr_bundle *attrs_bundle,
 			 size_t idx, s64 lower_bound, u64 upper_bound,
 			 s64 *def_val)
 {
@@ -1001,7 +1009,7 @@ _uverbs_get_const_signed(s64 *to,
 }
 static inline int
 _uverbs_get_const_unsigned(u64 *to,
-			   const struct uverbs_attr_bundle *attrs_bundle,
+			   struct uverbs_attr_bundle *attrs_bundle,
 			   size_t idx, u64 upper_bound, u64 *def_val)
 {
 	return -EINVAL;
@@ -1078,7 +1086,7 @@ static inline int _ib_respond_udata(struct ib_udata *udata, const void *src,
 						    _default))
 
 static inline int
-uverbs_get_raw_fd(int *to, const struct uverbs_attr_bundle *attrs_bundle,
+uverbs_get_raw_fd(int *to, struct uverbs_attr_bundle *attrs_bundle,
 		  size_t idx)
 {
 	return uverbs_get_const_signed(to, attrs_bundle, idx);
-- 
2.53.0


