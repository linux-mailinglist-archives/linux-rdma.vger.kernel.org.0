Return-Path: <linux-rdma+bounces-4095-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6044940D37
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 11:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 919202848EB
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 09:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E3A194ACA;
	Tue, 30 Jul 2024 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfLArkML"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6270C19412E
	for <linux-rdma@vger.kernel.org>; Tue, 30 Jul 2024 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331052; cv=none; b=TI4MAIU8XomP0Ss2xuZSGaw0iZsZR3spduqb6yK559ayO0PjFXPUFkhdKZSU5sjt59Geb25w5Tbbj3irKhF8RqsR/MUkg46yOy6BCwc2zNvgXE3NqmNRlvl9qgiJx7aM1olz9L+CmgO11QK21/kypz3v8ufCJPocH9OvEw+FpV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331052; c=relaxed/simple;
	bh=zlipFjWpIIWzpXxM7YXz6M+elXBIvl7jtvyJ32jvfmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y9FneOUCwD3e8iXQmSAzx1BubLa/UxHnvMmWuKTKECq3/XZtzpecUW48z5pA+WACERU/Cy7cexsGV6xANEJ6tvVwho71wXoPcm+CjUHlAxhEIdsTEsJlaTacyIB1uzvxzEPJ4S3j5YSKuZKYaDLFVN8ROUCCniAX0Xx4R4dN2jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfLArkML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0B0C32782;
	Tue, 30 Jul 2024 09:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722331052;
	bh=zlipFjWpIIWzpXxM7YXz6M+elXBIvl7jtvyJ32jvfmk=;
	h=From:To:Cc:Subject:Date:From;
	b=DfLArkMLyKUECq8CNrOeFIlEw8gcFTzGsdI/CDeWppaegHPKUvby7cxijIfAXsH5f
	 gjl2rFPfcLs+MiQszG1y9N8yEU3jHoxWkBr4M4ljCNEViPgK67qw2A6zxU+6NOZ5Zn
	 18pAm8qbjBHAgv+oguQun+o0aP5e349mnrXfUxg+KxcR+H2IQDp6uu3/7/IQxNBzeH
	 JSr+MTHifE7IIRqDajnRGBZDYibekl0okVl9kHm9/JqBx5+F+nf0YdGHOa1mrcRZWQ
	 S0cpe2g/8++K8Eh0kSqC3R1Kh5eRYwuNzv+EXDP4ykzxmVY0X4ZK+kEzXxdVAhGj/Z
	 gx6Em2qaS6i7Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next] RDMA/nldev: Enhance netlink message parsing and validation
Date: Tue, 30 Jul 2024 12:17:25 +0300
Message-ID: <f633a979a49db090d05c24a3ba83d30727bb777b.1722331020.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chiara Meiohas <cmeiohas@nvidia.com>

Use strict parsing validation for set commands, and liberal
validation for get commands. Additionally, remove all usage of
nlmsg_parse_depricate().

Strict parsing validation fails when encountering unrecognized
attributes in the Netlink message, while liberal parsing
validation ignores them.

In 57d7a8fd904c ("rdma: Add an option to display driver-specific QPs in the rdma tool")
in iproute2, the attribute RDMA_NLDEV_ATTR_DRIVER_DETAILS
was added. This cause backwards compatibility issues when using
the rdma tool with the new attribute and an older kernel which does
recognize this attribute.
In this case, the command "rdma stat show mr" would fail, because the
new rdma tool would fill the netlink message with the new attribute and
the older kernel would fail as it used strict parsing and did not
recognize the new attribute.

In general, strict validation is appropriate for set commands as they
modify the system, while liberal validation is suitable for get
commands which only query system information.

Replace all uses of nlmsg_parse_deprecated() with __nlmsg_parse(),
using the NL_VALIDATE_LIBERAL flag.
The nlmsg_parse_deprecated() function internally calls
__nlmsg_parse() with the NL_VALIDATE_LIBERAL flag, but its name
is confusing.

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/nldev.c | 56 ++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index a6b80cdc96f7..4d4a1f90e484 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1074,8 +1074,8 @@ static int nldev_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	u32 index;
 	int err;
 
-	err = nlmsg_parse_deprecated(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
-				     nldev_policy, extack);
+	err = __nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
+			    nldev_policy, NL_VALIDATE_LIBERAL, extack);
 	if (err || !tb[RDMA_NLDEV_ATTR_DEV_INDEX])
 		return -EINVAL;
 
@@ -1123,8 +1123,8 @@ static int nldev_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	u32 index;
 	int err;
 
-	err = nlmsg_parse_deprecated(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
-				     nldev_policy, extack);
+	err = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
+			    nldev_policy, extack);
 	if (err || !tb[RDMA_NLDEV_ATTR_DEV_INDEX])
 		return -EINVAL;
 
@@ -1215,8 +1215,8 @@ static int nldev_port_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	u32 port;
 	int err;
 
-	err = nlmsg_parse_deprecated(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
-				     nldev_policy, extack);
+	err = __nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
+			    nldev_policy, NL_VALIDATE_LIBERAL, extack);
 	if (err ||
 	    !tb[RDMA_NLDEV_ATTR_DEV_INDEX] ||
 	    !tb[RDMA_NLDEV_ATTR_PORT_INDEX])
@@ -1275,8 +1275,8 @@ static int nldev_port_get_dumpit(struct sk_buff *skb,
 	int err;
 	unsigned int p;
 
-	err = nlmsg_parse_deprecated(cb->nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
-				     nldev_policy, NULL);
+	err = __nlmsg_parse(cb->nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
+			    nldev_policy, NL_VALIDATE_LIBERAL, NULL);
 	if (err || !tb[RDMA_NLDEV_ATTR_DEV_INDEX])
 		return -EINVAL;
 
@@ -1331,8 +1331,8 @@ static int nldev_res_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	u32 index;
 	int ret;
 
-	ret = nlmsg_parse_deprecated(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
-				     nldev_policy, extack);
+	ret = __nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
+			    nldev_policy, NL_VALIDATE_LIBERAL, extack);
 	if (ret || !tb[RDMA_NLDEV_ATTR_DEV_INDEX])
 		return -EINVAL;
 
@@ -1481,8 +1481,8 @@ static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct sk_buff *msg;
 	int ret;
 
-	ret = nlmsg_parse_deprecated(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
-				     nldev_policy, extack);
+	ret = __nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
+			    nldev_policy, NL_VALIDATE_LIBERAL, extack);
 	if (ret || !tb[RDMA_NLDEV_ATTR_DEV_INDEX] || !fe->id || !tb[fe->id])
 		return -EINVAL;
 
@@ -1569,8 +1569,8 @@ static int res_get_common_dumpit(struct sk_buff *skb,
 	u32 index, port = 0;
 	bool filled = false;
 
-	err = nlmsg_parse_deprecated(cb->nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
-				     nldev_policy, NULL);
+	err = __nlmsg_parse(cb->nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
+			    nldev_policy, NL_VALIDATE_LIBERAL, NULL);
 	/*
 	 * Right now, we are expecting the device index to get res information,
 	 * but it is possible to extend this code to return all devices in
@@ -1762,8 +1762,8 @@ static int nldev_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	char type[IFNAMSIZ];
 	int err;
 
-	err = nlmsg_parse_deprecated(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
-				     nldev_policy, extack);
+	err = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
+			    nldev_policy, extack);
 	if (err || !tb[RDMA_NLDEV_ATTR_DEV_NAME] ||
 	    !tb[RDMA_NLDEV_ATTR_LINK_TYPE] || !tb[RDMA_NLDEV_ATTR_NDEV_NAME])
 		return -EINVAL;
@@ -1806,8 +1806,8 @@ static int nldev_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	u32 index;
 	int err;
 
-	err = nlmsg_parse_deprecated(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
-				     nldev_policy, extack);
+	err = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
+			    nldev_policy, extack);
 	if (err || !tb[RDMA_NLDEV_ATTR_DEV_INDEX])
 		return -EINVAL;
 
@@ -1836,8 +1836,8 @@ static int nldev_get_chardev(struct sk_buff *skb, struct nlmsghdr *nlh,
 	u32 index;
 	int err;
 
-	err = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1, nldev_policy,
-			  extack);
+	err = __nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1, nldev_policy,
+			    NL_VALIDATE_LIBERAL, extack);
 	if (err || !tb[RDMA_NLDEV_ATTR_CHARDEV_TYPE])
 		return -EINVAL;
 
@@ -1920,8 +1920,8 @@ static int nldev_sys_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct sk_buff *msg;
 	int err;
 
-	err = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
-			  nldev_policy, extack);
+	err = __nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
+			    nldev_policy, NL_VALIDATE_LIBERAL, extack);
 	if (err)
 		return err;
 
@@ -2420,8 +2420,8 @@ static int nldev_stat_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
 	int ret;
 
-	ret = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
-			  nldev_policy, extack);
+	ret = __nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
+			    nldev_policy, NL_VALIDATE_LIBERAL, extack);
 	if (ret)
 		return -EINVAL;
 
@@ -2450,8 +2450,8 @@ static int nldev_stat_get_dumpit(struct sk_buff *skb,
 	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
 	int ret;
 
-	ret = nlmsg_parse(cb->nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
-			  nldev_policy, NULL);
+	ret = __nlmsg_parse(cb->nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
+			    nldev_policy, NL_VALIDATE_LIBERAL, NULL);
 	if (ret || !tb[RDMA_NLDEV_ATTR_STAT_RES])
 		return -EINVAL;
 
@@ -2482,8 +2482,8 @@ static int nldev_stat_get_counter_status_doit(struct sk_buff *skb,
 	u32 devid, port;
 	int ret, i;
 
-	ret = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
-			  nldev_policy, extack);
+	ret = __nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
+			    nldev_policy, NL_VALIDATE_LIBERAL, extack);
 	if (ret || !tb[RDMA_NLDEV_ATTR_DEV_INDEX] ||
 	    !tb[RDMA_NLDEV_ATTR_PORT_INDEX])
 		return -EINVAL;
-- 
2.45.2


