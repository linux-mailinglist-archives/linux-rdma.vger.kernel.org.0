Return-Path: <linux-rdma+bounces-19139-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEMgGjcV12k1KwgAu9opvQ
	(envelope-from <linux-rdma+bounces-19139-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 04:55:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D143C5C83
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 04:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 816B83085A95
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 02:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1186F36F42D;
	Thu,  9 Apr 2026 02:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="N5zQ4pFt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662726DCE1;
	Thu,  9 Apr 2026 02:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703100; cv=none; b=T7wdc6zqNskk8/AN01kUANbi2rqFN0kDVDhSfYfVAkeU6yHJkmy6NrA3qjwtHNAPCXdaeZxbV0rM8Wcvz5VgLRL71HU/966CgX1elr8XzIxfe7x7hT0U7wdzKq0TmBIBlSXuD07AmU8t1UFxClLkTs/qS1Gg51I602++yvuLEnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703100; c=relaxed/simple;
	bh=Yu9SsY9pmAvdlxtBAhJQqMnYKJOzU9puwn7jcxQWM4o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OiS7UgPs0XJne2BaRN2JhSPaecdctTM/wHYe0QlHK9N+bbsL4uRAaEIOh5N+XAnZm+PNRGapta+XQRjtLwjwIxZQvKhDj1dFOKrRJ3r5rmxF50x3znL1f9NoDaVxglFGZZBwJbQ/qUpTvnuI5BfTLA/RbQwfdtY3Nnxn4dNPM/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=N5zQ4pFt; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638Gn2a33663028;
	Wed, 8 Apr 2026 19:51:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=0
	zi8H7z64cgTIRRMkdLDsAd3ydIpvA4SzX11aa0y1q8=; b=N5zQ4pFtMiv9xKAMU
	Fn9CkZIJMOLvzyi5M09vNaeUVxCRnL2+oKmr6XS8Jg/rDZKhnjKIDbGT4rfmT6kZ
	0JG3z6mIo/o6/GCeWwtF5rNT0OOe9GG/4DowHEWf8TZXyu97Z5cyUqTfuyV1o3H+
	nkGysDhYC8goFvLHEkIFpViubT52kPS+q043fsoNkXV/P0KBZ/qbEDuhyFDo+2na
	G+OhLr2oPbbX42oF8tKcqD4MxeW6nT1SocsAk01fSTYhjClR2EJavARrD95kqjws
	lPvkMaNiS1jCNHDVE6219ECgScuJwzZmdOi8kCyB2+MS4WrNHjiex9L2P9m9EMbY
	wV7QQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ddtb31e30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 19:51:28 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 8 Apr 2026 19:51:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 8 Apr 2026 19:51:26 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id D60703F7055;
	Wed,  8 Apr 2026 19:51:20 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>
CC: <sgoutham@marvell.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <donald.hunter@gmail.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <chuck.lever@oracle.com>, <matttbe@kernel.org>, <cjubran@nvidia.com>,
        <saeedm@nvidia.com>, <leon@kernel.org>, <tariqt@nvidia.com>,
        <mbloch@nvidia.com>, <dtatulea@nvidia.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v11 net-next 3/7] devlink: Change function syntax.
Date: Thu, 9 Apr 2026 08:20:51 +0530
Message-ID: <20260409025055.1664053-4-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409025055.1664053-1-rkannoth@marvell.com>
References: <20260409025055.1664053-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=K7wS2SWI c=1 sm=1 tr=0 ts=69d71430 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=b0mWSK_FeWKv_NHZ6KIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDAyNCBTYWx0ZWRfX7pAP/nEqTwNl
 kDe5OepUEtbjnIhmdToW8v8zOMEmQvj0y7aBy4EZGN26ONVM8Wz6J/iy3nwQpSuUz634VL/gAHe
 ckPyAoYOi9x6X4sZFekZD4Ml9NXtYDmjBtBzVhQcdV7tixxwx6oN7cyRp73Iq0ZUydTZN4AZOcN
 GJXU9rORxt0bE/yUFOPP7Y0LjrocyoHtWUqtIgt0dhj8VU9qJNtjeGPKr3olePLgbXBqE6TIBvX
 9mIYu/AwQxv5hwrEsCWKEzlRojajz5Di+VkVkKzWppHWrjUaeeK7nNl5apSuKF21YH7OfBwKfVR
 5QiQQyYkDbViFfVJZzxR1jVZuQHwUmSYtNO5220vp7t8//S80u8+31/CsFkIzuE0wxWKg2ErJAH
 oBNKe2aL6u5pYCBENOYx0ld09mBBPbbMbxHBvysoko+0WttOOouMAjGcdG5RnIRNQ/kgGav+jdS
 fkrMY0zxkEN/nDH+Buw==
X-Proofpoint-GUID: 538wvBDSw6LoZnwgl00AD9eiY_H1rxpf
X-Proofpoint-ORIG-GUID: 538wvBDSw6LoZnwgl00AD9eiY_H1rxpf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_07,2026-04-08_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19139-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 24D143C5C83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

union devlink_param_value grows when U64 array params
are added to devlink. This increase the size of union
devlink_param_value from 32 bytes to over 264 bytes.
devlink_nl_param_value_fill_one(), devlink_nl_param_value_put()
take multiple copies of this union by value. Passing two of
these unions by value consumes over 528 bytes of
stack space, and combined in a call chain this pushes nearly 800 bytes
of arguments onto the stack. There is higher chance of hitting
CONFIG_FRAME_WARN limits deep in deep functions. Change signatures
of the internal functions and exported APIs be updated to pass the
unions by pointer instead.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 net/devlink/param.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/devlink/param.c b/net/devlink/param.c
index cf95268da5b0..4595fffbd825 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -216,39 +216,39 @@ static int devlink_param_reset_default(struct devlink *devlink,
 
 static int
 devlink_nl_param_value_put(struct sk_buff *msg, enum devlink_param_type type,
-			   int nla_type, union devlink_param_value val,
+			   int nla_type, union devlink_param_value *val,
 			   bool flag_as_u8)
 {
 	switch (type) {
 	case DEVLINK_PARAM_TYPE_U8:
-		if (nla_put_u8(msg, nla_type, val.vu8))
+		if (nla_put_u8(msg, nla_type, val->vu8))
 			return -EMSGSIZE;
 		break;
 	case DEVLINK_PARAM_TYPE_U16:
-		if (nla_put_u16(msg, nla_type, val.vu16))
+		if (nla_put_u16(msg, nla_type, val->vu16))
 			return -EMSGSIZE;
 		break;
 	case DEVLINK_PARAM_TYPE_U32:
-		if (nla_put_u32(msg, nla_type, val.vu32))
+		if (nla_put_u32(msg, nla_type, val->vu32))
 			return -EMSGSIZE;
 		break;
 	case DEVLINK_PARAM_TYPE_U64:
-		if (devlink_nl_put_u64(msg, nla_type, val.vu64))
+		if (devlink_nl_put_u64(msg, nla_type, val->vu64))
 			return -EMSGSIZE;
 		break;
 	case DEVLINK_PARAM_TYPE_STRING:
-		if (nla_put_string(msg, nla_type, val.vstr))
+		if (nla_put_string(msg, nla_type, val->vstr))
 			return -EMSGSIZE;
 		break;
 	case DEVLINK_PARAM_TYPE_BOOL:
-		/* default values of type bool are encoded with u8, so that
+		/* default val->es of type bool are encoded with u8, so that
 		 * false can be distinguished from not present
 		 */
 		if (flag_as_u8) {
-			if (nla_put_u8(msg, nla_type, val.vbool))
+			if (nla_put_u8(msg, nla_type, val->vbool))
 				return -EMSGSIZE;
 		} else {
-			if (val.vbool && nla_put_flag(msg, nla_type))
+			if (val->vbool && nla_put_flag(msg, nla_type))
 				return -EMSGSIZE;
 		}
 		break;
@@ -260,8 +260,8 @@ static int
 devlink_nl_param_value_fill_one(struct sk_buff *msg,
 				enum devlink_param_type type,
 				enum devlink_param_cmode cmode,
-				union devlink_param_value val,
-				union devlink_param_value default_val,
+				union devlink_param_value *val,
+				union devlink_param_value *default_val,
 				bool has_default)
 {
 	struct nlattr *param_value_attr;
@@ -383,8 +383,8 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 		if (!param_value_set[i])
 			continue;
 		err = devlink_nl_param_value_fill_one(msg, param->type,
-						      i, param_value[i],
-						      default_value[i],
+						      i, &param_value[i],
+						      &default_value[i],
 						      default_value_set[i]);
 		if (err)
 			goto values_list_nest_cancel;
-- 
2.43.0


