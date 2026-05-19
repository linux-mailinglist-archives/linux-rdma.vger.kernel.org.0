Return-Path: <linux-rdma+bounces-20991-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBNxMJqrDGrukgUAu9opvQ
	(envelope-from <linux-rdma+bounces-20991-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 20:27:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C85C583A77
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 20:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B050300917E
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 18:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CDE343884;
	Tue, 19 May 2026 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTUODB/s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACE6367B92;
	Tue, 19 May 2026 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779215082; cv=none; b=GhVg517XC4SE5KQXWrhpvaMvNyqF7DS622ue+Ok46hYfGecrDrNRm+S4lxu6tCp4CXdhuhCTEiBpYurspeThQ9AFmB9XHs9130dzvlCuciQ3bA0pL+Go+03IMrE5zs/eW2d3nI5QStXivCYNqVmMMDdCLyiXJscixlACvsLGuKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779215082; c=relaxed/simple;
	bh=cQ+6uBWM5dRHRoMlG9V/IKRjhsGCzxPRH1cApIvtjS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uax3tBuF9l6dqxLABfoXNdeizhTzsQ2Vvpr4XtDQIiNLfWAUzcCb7aZOf84wFl1jypxwr9QsOrxmrX4qPlIzNV5r2i38ncQftHqQD7AkfaICc/wiQoR+ZlYjqU9MgXSQ53AHTDt4fAu3VGz4n8IUfb+Dl2LWst1ssrjXuTmGWBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTUODB/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CCDC2BCB3;
	Tue, 19 May 2026 18:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779215082;
	bh=cQ+6uBWM5dRHRoMlG9V/IKRjhsGCzxPRH1cApIvtjS8=;
	h=From:Date:Subject:To:Cc:From;
	b=iTUODB/shaF1qGLE3AQZnTjxMrsStfRbNfzlqnQi8fxFz2eHUQ29BuDH4hOy5/U8k
	 Pg2vZmpb9ORaTpI+PmZTUW5aor6cIyh185srrrPhIkoDByIMzGBXB7Zp0kjU4CGpsf
	 iEdelA9qNR6MFhlsK7JouJ3c8g/WP80Ca1A5yka2WGlcse6NvRFyTvssm03WRgR9m+
	 xcJF6RFxL5crL+gYNW/GVpUnz0UTPGSoF8FCMbsZgQI74DQGdaY6oGp9jW9NUZB/fv
	 Ws/7A43Gv0QVyHxoZH0EjI3MZLt5i7ojNhpMaES6cNhlGGN2Zqg7tm9yvT0nE5qOGq
	 dTQihp3UFRPzA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 19 May 2026 11:24:36 -0700
Subject: [PATCH] RDMA/core: Remove _ib_copy_validate_udata_in() and
 _ib_respond_udata() stubs
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-rdma-core-fix-ib_udata-redef-errors-v1-1-671bf2697fa5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXN7QqCQBCF4VuR+d3AKirYrUTEfpytCXJjRiMQ7
 72tfj5weM9GBhUYHZuNFC8xKXNFe2go3vx8BUuqps51oxvaiTU9PMei4CxvlnBZk188KxIyQ7W
 ocYiYkov9kMeeaumpqOPfy+n8t63hjrh807TvH+kyCX6HAAAA
X-Change-ID: 20260519-rdma-core-fix-ib_udata-redef-errors-bce9d0c45f64
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3873; i=nathan@kernel.org;
 h=from:subject:message-id; bh=cQ+6uBWM5dRHRoMlG9V/IKRjhsGCzxPRH1cApIvtjS8=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFk8q15wyz/Z9XH7RA+DbKtiPqdH2+2teGKqM6/NC1izr
 7k54GNGRykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZhIqxTDXwnZlvQ1bfVRSWIV
 Du9X5BlsnVck/Cr65YF9t/o/Mpafu8/wP7G7OHNVXd3skiTer2ve+9V6bCrVsT0548wxtmnPlxy
 TYQcA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20991-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2C85C583A77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After commit 65b044cee9fb ("RDMA/core: Move the _ib_copy_validate_udata*
functions to ib_core_uverbs"), builds without INFINIBAND_USER_ACCESS
enabled fail with:

  drivers/infiniband/core/ib_core_uverbs.c:433:5: error: redefinition of '_ib_copy_validate_udata_in'
    433 | int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
  In file included from include/rdma/uverbs_std_types.h:10,
                   from drivers/infiniband/core/uverbs.h:49,
                   from drivers/infiniband/core/ib_core_uverbs.c:10:
  include/rdma/uverbs_ioctl.h:961:19: note: previous definition of '_ib_copy_validate_udata_in' with type 'int(struct ib_udata *, void *, size_t,  size_t)' {aka 'int(struct ib_udata *, void *, long unsigned int,  long unsigned int)'}
    961 | static inline int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
        |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/infiniband/core/ib_core_uverbs.c:483:5: error: redefinition of '_ib_respond_udata'
    483 | int _ib_respond_udata(struct ib_udata *udata, const void *src, size_t len)
        |     ^~~~~~~~~~~~~~~~~
  include/rdma/uverbs_ioctl.h:968:19: note: previous definition of '_ib_respond_udata' with type 'int(struct ib_udata *, const void *, size_t)' {aka 'int(struct ib_udata *, const void *, long unsigned int)'}
    968 | static inline int _ib_respond_udata(struct ib_udata *udata, const void *src,
        |                   ^~~~~~~~~~~~~~~~~

Remove the stubs and adjust the prototypes for _ib_respond_udata() and
_ib_copy_validate_udata_in(), as they will always be available when
INFINIBAND is enabled.

Fixes: 65b044cee9fb ("RDMA/core: Move the _ib_copy_validate_udata* functions to ib_core_uverbs")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 include/rdma/uverbs_ioctl.h | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index e2af17da3e32..7cbdfc259738 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -856,6 +856,10 @@ ib_uverbs_get_ucontext(const struct uverbs_attr_bundle *attrs)
 	return ib_uverbs_get_ucontext_file(attrs->ufile);
 }
 
+int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
+			       size_t kernel_size, size_t minimum_size);
+int _ib_respond_udata(struct ib_udata *udata, const void *src, size_t len);
+
 #if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 int uverbs_get_flags64(u64 *to, const struct uverbs_attr_bundle *attrs_bundle,
 		       size_t idx, u64 allowed_bits);
@@ -897,10 +901,6 @@ int _uverbs_get_const_unsigned(u64 *to,
 			       size_t idx, u64 upper_bound, u64 *def_val);
 int uverbs_copy_to_struct_or_zero(const struct uverbs_attr_bundle *bundle,
 				  size_t idx, const void *from, size_t size);
-
-int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
-			       size_t kernel_size, size_t minimum_size);
-int _ib_respond_udata(struct ib_udata *udata, const void *src, size_t len);
 #else
 static inline int
 uverbs_get_flags64(u64 *to, const struct uverbs_attr_bundle *attrs_bundle,
@@ -957,19 +957,6 @@ _uverbs_get_const_unsigned(u64 *to,
 {
 	return -EINVAL;
 }
-
-static inline int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
-					     size_t kernel_size,
-					     size_t minimum_size)
-{
-	return -EINVAL;
-}
-
-static inline int _ib_respond_udata(struct ib_udata *udata, const void *src,
-				    size_t len)
-{
-	return -EINVAL;
-}
 #endif
 
 #define uverbs_get_const_signed(_to, _attrs_bundle, _idx)                      \

---
base-commit: 65b044cee9fb117144f11ab68a318d0055cfbc1b
change-id: 20260519-rdma-core-fix-ib_udata-redef-errors-bce9d0c45f64

Best regards,
--  
Cheers,
Nathan


