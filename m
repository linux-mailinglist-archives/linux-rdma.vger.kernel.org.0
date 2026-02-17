Return-Path: <linux-rdma+bounces-16967-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKcZJEzrlGnUIwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16967-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:27:24 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA716151743
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96A5B300B2AE
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 22:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CAC318B95;
	Tue, 17 Feb 2026 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8EHB+rm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DE0318ED3;
	Tue, 17 Feb 2026 22:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367235; cv=none; b=gUUA+sIsALIYWR9kuA48pLx5MK8iZWH6dG63T+viAk58T/sxvyvdFdH3g6icso2j8LggOnsbDsJ3iynFbqeaJ6bKNrRxwnA92fxmmmDUY6GTeREWU2qWs7drKHfaceLk5P0YZP3d+8kqrLjs83TuUtqE8+8bkQMdFzf2YCIJQYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367235; c=relaxed/simple;
	bh=fvAepahS8bkIxS/Fi2UU0CU7Bd5BSiZwq69sJ9cH2Ug=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=i9dMRzs3dHHtnO6IrE149UzxCdlMrF4GS+riSbWRFppz5jVFLm6dqyQhlAgorg8vWjLU0D/ZFtORVG+TxpLKBDVOuJRavnXVo7dpOpKXHgTDtBWU/TMJjUw3sKFjcQiz1VAIrAp2bLSGU8rsNKjzNWPfh+pTiSS1/QllXjSeVq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8EHB+rm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC4FC4CEF7;
	Tue, 17 Feb 2026 22:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771367235;
	bh=fvAepahS8bkIxS/Fi2UU0CU7Bd5BSiZwq69sJ9cH2Ug=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=M8EHB+rm+l6swCm5Z9NPzOAdy6A/tqjUHxQpCEENlr4xfmR68J53E4qJe2iJ+m6wK
	 8PyVAolyzIAjzJFuhtjUnPZR+X3Dpoi+rn2gyVuAoM2Pn6Jvbpq9CGPpw5mLtoGunr
	 a3KPnViDpSa59yHfoyfrE/Z+TkhCrBDr0SigI5BC7eK9cPOrtBepghnukeYwgRDLqI
	 9SrWmX5Uzmu2NpUz/kUitvqmxIkHWU8fpaE0jdAqfBVmJ7feB5MaZZBNJm891oAgmU
	 QcNM37TQ0YrMos/cOOAh7X8hRu2MFEnzrOf8148bGKC5SzFrgi78K67AmUJmUdNiQ7
	 JA2OiSnv9fhAw==
Message-ID: <1ee481dc-f4fd-4a01-9859-be95cc1095ac@kernel.org>
Date: Tue, 17 Feb 2026 23:27:11 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RFC 03/10] sysfs: constify group arrays in function arguments
From: Heiner Kallweit <hkall@kernel.org>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: driver-core@lists.linux.dev,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-rdma@vger.kernel.org, linux-rtc@vger.kernel.org
References: <5d0951ec-42c9-453f-9966-ecca593c4153@kernel.org>
Content-Language: en-US
In-Reply-To: <5d0951ec-42c9-453f-9966-ecca593c4153@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkall@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-16967-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: BA716151743
X-Rspamd-Action: no action

Constify the groups array argument where applicable. This allows to
pass constant arrays as arguments.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 fs/sysfs/group.c      | 10 +++++-----
 include/linux/sysfs.h | 16 ++++++++--------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index e1e639f515a..b3edae0578c 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -217,7 +217,7 @@ int sysfs_create_group(struct kobject *kobj,
 EXPORT_SYMBOL_GPL(sysfs_create_group);
 
 static int internal_create_groups(struct kobject *kobj, int update,
-				  const struct attribute_group **groups)
+				  const struct attribute_group *const *groups)
 {
 	int error = 0;
 	int i;
@@ -250,7 +250,7 @@ static int internal_create_groups(struct kobject *kobj, int update,
  * Returns 0 on success or error code from sysfs_create_group on failure.
  */
 int sysfs_create_groups(struct kobject *kobj,
-			const struct attribute_group **groups)
+			const struct attribute_group *const *groups)
 {
 	return internal_create_groups(kobj, 0, groups);
 }
@@ -268,7 +268,7 @@ EXPORT_SYMBOL_GPL(sysfs_create_groups);
  * Returns 0 on success or error code from sysfs_update_group on failure.
  */
 int sysfs_update_groups(struct kobject *kobj,
-			const struct attribute_group **groups)
+			const struct attribute_group *const *groups)
 {
 	return internal_create_groups(kobj, 1, groups);
 }
@@ -342,7 +342,7 @@ EXPORT_SYMBOL_GPL(sysfs_remove_group);
  * If groups is not NULL, remove the specified groups from the kobject.
  */
 void sysfs_remove_groups(struct kobject *kobj,
-			 const struct attribute_group **groups)
+			 const struct attribute_group *const *groups)
 {
 	int i;
 
@@ -613,7 +613,7 @@ EXPORT_SYMBOL_GPL(sysfs_group_change_owner);
  * Returns 0 on success or error code on failure.
  */
 int sysfs_groups_change_owner(struct kobject *kobj,
-			      const struct attribute_group **groups,
+			      const struct attribute_group *const *groups,
 			      kuid_t kuid, kgid_t kgid)
 {
 	int error = 0, i;
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index c33a96b7391..445869ce0f4 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -445,15 +445,15 @@ void sysfs_delete_link(struct kobject *dir, struct kobject *targ,
 int __must_check sysfs_create_group(struct kobject *kobj,
 				    const struct attribute_group *grp);
 int __must_check sysfs_create_groups(struct kobject *kobj,
-				     const struct attribute_group **groups);
+				     const struct attribute_group *const *groups);
 int __must_check sysfs_update_groups(struct kobject *kobj,
-				     const struct attribute_group **groups);
+				     const struct attribute_group *const *groups);
 int sysfs_update_group(struct kobject *kobj,
 		       const struct attribute_group *grp);
 void sysfs_remove_group(struct kobject *kobj,
 			const struct attribute_group *grp);
 void sysfs_remove_groups(struct kobject *kobj,
-			 const struct attribute_group **groups);
+			 const struct attribute_group *const *groups);
 int sysfs_add_file_to_group(struct kobject *kobj,
 			const struct attribute *attr, const char *group);
 void sysfs_remove_file_from_group(struct kobject *kobj,
@@ -486,7 +486,7 @@ int sysfs_change_owner(struct kobject *kobj, kuid_t kuid, kgid_t kgid);
 int sysfs_link_change_owner(struct kobject *kobj, struct kobject *targ,
 			    const char *name, kuid_t kuid, kgid_t kgid);
 int sysfs_groups_change_owner(struct kobject *kobj,
-			      const struct attribute_group **groups,
+			      const struct attribute_group *const *groups,
 			      kuid_t kuid, kgid_t kgid);
 int sysfs_group_change_owner(struct kobject *kobj,
 			     const struct attribute_group *groups, kuid_t kuid,
@@ -629,13 +629,13 @@ static inline int sysfs_create_group(struct kobject *kobj,
 }
 
 static inline int sysfs_create_groups(struct kobject *kobj,
-				      const struct attribute_group **groups)
+				      const struct attribute_group *const *groups)
 {
 	return 0;
 }
 
 static inline int sysfs_update_groups(struct kobject *kobj,
-				      const struct attribute_group **groups)
+				      const struct attribute_group *const *groups)
 {
 	return 0;
 }
@@ -652,7 +652,7 @@ static inline void sysfs_remove_group(struct kobject *kobj,
 }
 
 static inline void sysfs_remove_groups(struct kobject *kobj,
-				       const struct attribute_group **groups)
+				       const struct attribute_group *const *groups)
 {
 }
 
@@ -733,7 +733,7 @@ static inline int sysfs_change_owner(struct kobject *kobj, kuid_t kuid, kgid_t k
 }
 
 static inline int sysfs_groups_change_owner(struct kobject *kobj,
-			  const struct attribute_group **groups,
+			  const struct attribute_group *const *groups,
 			  kuid_t kuid, kgid_t kgid)
 {
 	return 0;
-- 
2.53.0



