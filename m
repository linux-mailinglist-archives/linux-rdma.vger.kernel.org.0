Return-Path: <linux-rdma+bounces-20345-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDdgC4hQAWpTUwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20345-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 05:44:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2D6507BAD
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 05:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7FA33033FB5
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 03:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D0537D101;
	Mon, 11 May 2026 03:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TDvgb5El"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D39C25393B;
	Mon, 11 May 2026 03:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778470852; cv=none; b=kTpGhsF0Xx0AcNpBNB3LnuvXIFDa6XOTih+VzKTbjCAcaaz02TRADHDnirBywGcK4fGqE7Tbxy129OCES4pMEEhm/GthDi+G0bEBhDRO2LvNa84Rp86HrijGf4Tx6wsKbTRR44/5Qq3YDSji4Y0JxgAZVyQKdcd1bHZYFSjuV+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778470852; c=relaxed/simple;
	bh=P2dWpXFVGnffa3RzCogS9zGXOCngWPSasKitV/ZCkU0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljYxmufsk6BZZGSzrRaV69tO8EsJe7hk9041TlL/mB6ydoaPMXsss1iNQeh5fMJ8pMjhhsV5sSD2rJAsA1iCw2fm36Xiz7ONgp0AfSF0HvIzugZp+LHCDAfpagXqW9HeBkiJ5x/65RR8dvWAIgE6VKPD7aFKvIEMp7NsLIVey10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TDvgb5El; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ANVfJl3044459;
	Sun, 10 May 2026 20:40:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
	NAh0jA51KnjyQlaARTdcFz61WiI/IFHNfuUP9Ox1kg=; b=TDvgb5ElFSJHa943y
	Gkvbi/0ShucNzaUoSEqU+IedFDIk8PiSZPuiSKZ7ZHdBtO1bziQfLVfEAN4tR5qG
	VSWe+jhbtwDxEaV64oFQnseQKgAvsBa9ObNzQQAkOypTfRiShZdIJBHDVLyCOI5q
	fpi+vTa4F7Q7mmdH3X//dufp477lsx8c+YlKXtcfj1s89B6ylCI3HEtTiAfZ3Jcp
	G2f4hBL1/dr+hw5fzW8yoGmLYV7qgcRcOmS419PXwn71tMXYdpaR33vOi3n33ABb
	ByweNPUVHy6YYr9jJ6X70S7rbh+UG3kSoEK01gK96ynBlk3lMCKybaXC1AzOy//L
	7Ud/A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e229jkhsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 20:40:16 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 10 May 2026 20:40:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 10 May 2026 20:40:15 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 98ADA5E6862;
	Sun, 10 May 2026 20:40:06 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <netdev@vger.kernel.org>, <oss-drivers@corigine.com>
CC: <akiyano@amazon.com>, <andrew+netdev@lunn.ch>,
        <anthony.l.nguyen@intel.com>, <arkadiusz.kubalewski@intel.com>,
        <brett.creeley@amd.com>, <darinzon@amazon.com>, <davem@davemloft.net>,
        <donald.hunter@gmail.com>, <edumazet@google.com>, <horms@kernel.org>,
        <idosch@nvidia.com>, <ivecera@redhat.com>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <leon@kernel.org>, <mbloch@nvidia.com>,
        <michael.chan@broadcom.com>, <pabeni@redhat.com>,
        <pavan.chebbi@broadcom.com>, <petrm@nvidia.com>,
        <Prathosh.Satish@microchip.com>, <przemyslaw.kitszel@intel.com>,
        <saeedm@nvidia.com>, <sgoutham@marvell.com>, <tariqt@nvidia.com>,
        <vadim.fedorenko@linux.dev>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v13 net-next 4/9] devlink: Implement devlink param multi attribute nested data values
Date: Mon, 11 May 2026 09:09:18 +0530
Message-ID: <20260511033923.1301976-5-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511033923.1301976-1-rkannoth@marvell.com>
References: <20260511033923.1301976-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAzNyBTYWx0ZWRfXw8waePldkQV9
 nzy+oqpTUPxeWtz5aWkqMO7T7WWqzrzPYD4RwmWEvLVKlTDi2AsMD8woKbXK5uaGuWtjTb70ZeF
 4Y18ZbsvmRLG6JInNDkrQFlmKfB8VV9Z7iR2VK8uuKgdcY2lIKURqoTSjhtOeZpiG9bKGRKhOUa
 wwmNJ2TZypxwg3VszlD5HzEbKA81gXv14PQL4TOde8THDA24RbMngQvXdjUlPq3QtSdHs9Z+c+O
 8vsCtJQX3rNTMFsQUIcp4dEWU69vPCskYwwj72Cb/5sjldM+4JWFezzVPukKtAzmrAfFi+7l8qu
 5l8glxGkAzuKYCy8Tj01ocSywPSs21sKqGhNjDAD7phcFA0nvxCl2dSFAduY12oEiEU8+VnQnX/
 +NzEqyvOhJvTrMvkPL45ZYc5iu0+7Qpvp7OFmmrwK2wojlx4ln1wKVNq4c1NEtxNtv81JIA59UB
 OuaeS3uIGcRbAcT6VKA==
X-Proofpoint-GUID: BLvm5VkTvLt5QsX-pIag6nrjJqlKZsBW
X-Proofpoint-ORIG-GUID: BLvm5VkTvLt5QsX-pIag6nrjJqlKZsBW
X-Authority-Analysis: v=2.4 cv=LdAMLDfi c=1 sm=1 tr=0 ts=6a014fa0 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=Ikd4Dj_1AAAA:8 a=M5GUcnROAAAA:8
 a=fjkij7JY_VKj8B3xdwgA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Rspamd-Queue-Id: 6E2D6507BAD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20345-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:mid,marvell.com:dkim,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

From: Saeed Mahameed <saeedm@nvidia.com>

Devlink param value attribute is not defined since devlink is handling
the value validating and parsing internally, this allows us to implement
multi attribute values without breaking any policies.

Devlink param multi-attribute values are considered to be dynamically
sized arrays of u64 values, by introducing a new devlink param type
DEVLINK_PARAM_TYPE_U64_ARRAY, driver and user space can set a variable
count of u64 values into the DEVLINK_ATTR_PARAM_VALUE_DATA attribute.

Implement get/set parsing and add to the internal value structure passed
to drivers.

This is useful for devices that need to configure a list of values for
a specific configuration.

example:
$ devlink dev param show pci/... name multi-value-param
name multi-value-param type driver-specific
values:
cmode permanent value: 0,1,2,3,4,5,6,7

$ devlink dev param set pci/... name multi-value-param \
		value 4,5,6,7,0,1,2,3 cmode permanent

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 Documentation/netlink/specs/devlink.yaml |  4 ++
 include/net/devlink.h                    |  8 +++
 include/uapi/linux/devlink.h             |  1 +
 net/devlink/netlink_gen.c                |  2 +
 net/devlink/param.c                      | 88 +++++++++++++++++++-----
 5 files changed, 86 insertions(+), 17 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 247b147d689f..52ad1e7805d1 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -234,6 +234,10 @@ definitions:
         value: 10
       -
         name: binary
+      -
+        name: u64-array
+        value: 129
+
   -
     name: rate-tc-index-max
     type: const
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 5f4083dc4345..dd546dbd57cf 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -433,6 +433,13 @@ enum devlink_param_type {
 	DEVLINK_PARAM_TYPE_U64 = DEVLINK_VAR_ATTR_TYPE_U64,
 	DEVLINK_PARAM_TYPE_STRING = DEVLINK_VAR_ATTR_TYPE_STRING,
 	DEVLINK_PARAM_TYPE_BOOL = DEVLINK_VAR_ATTR_TYPE_FLAG,
+	DEVLINK_PARAM_TYPE_U64_ARRAY = DEVLINK_VAR_ATTR_TYPE_U64_ARRAY,
+};
+
+#define __DEVLINK_PARAM_MAX_ARRAY_SIZE 32
+struct devlink_param_u64_array {
+	u64 size;
+	u64 val[__DEVLINK_PARAM_MAX_ARRAY_SIZE];
 };
 
 union devlink_param_value {
@@ -442,6 +449,7 @@ union devlink_param_value {
 	u64 vu64;
 	char vstr[__DEVLINK_PARAM_MAX_STRING_VALUE];
 	bool vbool;
+	struct devlink_param_u64_array u64arr;
 };
 
 struct devlink_param_gset_ctx {
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 0b165eac7619..ca713bcc47b9 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -406,6 +406,7 @@ enum devlink_var_attr_type {
 	DEVLINK_VAR_ATTR_TYPE_BINARY,
 	__DEVLINK_VAR_ATTR_TYPE_CUSTOM_BASE = 0x80,
 	/* Any possible custom types, unrelated to NLA_* values go below */
+	DEVLINK_VAR_ATTR_TYPE_U64_ARRAY,
 };
 
 enum devlink_attr {
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 81899786fd98..f52b0c2b19ed 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -37,6 +37,8 @@ devlink_attr_param_type_validate(const struct nlattr *attr,
 	case DEVLINK_VAR_ATTR_TYPE_NUL_STRING:
 		fallthrough;
 	case DEVLINK_VAR_ATTR_TYPE_BINARY:
+		fallthrough;
+	case DEVLINK_VAR_ATTR_TYPE_U64_ARRAY:
 		return 0;
 	}
 	NL_SET_ERR_MSG_ATTR(extack, attr, "invalid enum value");
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 1a196d3a843d..4cc479bd019f 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -252,6 +252,11 @@ devlink_nl_param_value_put(struct sk_buff *msg, enum devlink_param_type type,
 				return -EMSGSIZE;
 		}
 		break;
+	case DEVLINK_PARAM_TYPE_U64_ARRAY:
+		for (int i = 0; i < val->u64arr.size; i++)
+			if (nla_put_uint(msg, nla_type, val->u64arr.val[i]))
+				return -EMSGSIZE;
+		break;
 	}
 	return 0;
 }
@@ -304,56 +309,78 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 				 u32 portid, u32 seq, int flags,
 				 struct netlink_ext_ack *extack)
 {
-	union devlink_param_value default_value[DEVLINK_PARAM_CMODE_MAX + 1];
-	union devlink_param_value param_value[DEVLINK_PARAM_CMODE_MAX + 1];
 	bool default_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
 	bool param_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
 	const struct devlink_param *param = param_item->param;
-	struct devlink_param_gset_ctx ctx;
+	union devlink_param_value *default_value;
+	union devlink_param_value *param_value;
+	struct devlink_param_gset_ctx *ctx;
 	struct nlattr *param_values_list;
 	struct nlattr *param_attr;
 	void *hdr;
 	int err;
 	int i;
 
+	default_value = kcalloc(DEVLINK_PARAM_CMODE_MAX + 1,
+				sizeof(*default_value), GFP_KERNEL);
+	if (!default_value)
+		return -ENOMEM;
+
+	param_value = kcalloc(DEVLINK_PARAM_CMODE_MAX + 1,
+			      sizeof(*param_value), GFP_KERNEL);
+	if (!param_value) {
+		kfree(default_value);
+		return -ENOMEM;
+	}
+
+	ctx = kmalloc_obj(*ctx);
+	if (!ctx) {
+		kfree(param_value);
+		kfree(default_value);
+		return -ENOMEM;
+	}
+
 	/* Get value from driver part to driverinit configuration mode */
 	for (i = 0; i <= DEVLINK_PARAM_CMODE_MAX; i++) {
 		if (!devlink_param_cmode_is_supported(param, i))
 			continue;
 		if (i == DEVLINK_PARAM_CMODE_DRIVERINIT) {
-			if (param_item->driverinit_value_new_valid)
+			if (param_item->driverinit_value_new_valid) {
 				param_value[i] = param_item->driverinit_value_new;
-			else if (param_item->driverinit_value_valid)
+			} else if (param_item->driverinit_value_valid) {
 				param_value[i] = param_item->driverinit_value;
-			else
-				return -EOPNOTSUPP;
+			} else {
+				err = -EOPNOTSUPP;
+				goto get_put_fail;
+			}
 
 			if (param_item->driverinit_value_valid) {
 				default_value[i] = param_item->driverinit_default;
 				default_value_set[i] = true;
 			}
 		} else {
-			ctx.cmode = i;
-			err = devlink_param_get(devlink, param, &ctx, extack);
+			ctx->cmode = i;
+			err = devlink_param_get(devlink, param, ctx, extack);
 			if (err)
-				return err;
-			param_value[i] = ctx.val;
+				goto get_put_fail;
+			param_value[i] = ctx->val;
 
-			err = devlink_param_get_default(devlink, param, &ctx,
+			err = devlink_param_get_default(devlink, param, ctx,
 							extack);
 			if (!err) {
-				default_value[i] = ctx.val;
+				default_value[i] = ctx->val;
 				default_value_set[i] = true;
 			} else if (err != -EOPNOTSUPP) {
-				return err;
+				goto get_put_fail;
 			}
 		}
 		param_value_set[i] = true;
 	}
 
+	err = -EMSGSIZE;
 	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
 	if (!hdr)
-		return -EMSGSIZE;
+		goto get_put_fail;
 
 	if (devlink_nl_put_handle(msg, devlink))
 		goto genlmsg_cancel;
@@ -393,6 +420,9 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 	nla_nest_end(msg, param_values_list);
 	nla_nest_end(msg, param_attr);
 	genlmsg_end(msg, hdr);
+	kfree(default_value);
+	kfree(param_value);
+	kfree(ctx);
 	return 0;
 
 values_list_nest_cancel:
@@ -401,7 +431,11 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 	nla_nest_cancel(msg, param_attr);
 genlmsg_cancel:
 	genlmsg_cancel(msg, hdr);
-	return -EMSGSIZE;
+get_put_fail:
+	kfree(default_value);
+	kfree(param_value);
+	kfree(ctx);
+	return err;
 }
 
 static void devlink_param_notify(struct devlink *devlink,
@@ -507,7 +541,7 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
 				  union devlink_param_value *value)
 {
 	struct nlattr *param_data;
-	int len;
+	int len, cnt, rem;
 
 	param_data = info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA];
 
@@ -547,6 +581,26 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
 			return -EINVAL;
 		value->vbool = nla_get_flag(param_data);
 		break;
+
+	case DEVLINK_PARAM_TYPE_U64_ARRAY:
+		cnt = 0;
+		nla_for_each_attr_type(param_data,
+				       DEVLINK_ATTR_PARAM_VALUE_DATA,
+				       genlmsg_data(info->genlhdr),
+				       genlmsg_len(info->genlhdr), rem) {
+			if (cnt >= __DEVLINK_PARAM_MAX_ARRAY_SIZE)
+				return -EMSGSIZE;
+
+			if ((nla_len(param_data) != sizeof(u64)) &&
+			    (nla_len(param_data) != sizeof(u32)))
+				return -EINVAL;
+
+			value->u64arr.val[cnt] = (u64)nla_get_uint(param_data);
+			cnt++;
+		}
+
+		value->u64arr.size = cnt;
+		break;
 	}
 	return 0;
 }
-- 
2.43.0


