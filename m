Return-Path: <linux-rdma+bounces-14575-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE75FC66A4D
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 01:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 2B7DD29AEC
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 00:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4063026F2A1;
	Tue, 18 Nov 2025 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOfBpEf7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD6026B973
	for <linux-rdma@vger.kernel.org>; Tue, 18 Nov 2025 00:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763425485; cv=none; b=NF2G1vGlswLREx16pT6DS/9qpJZ6eqJSNcn/uVRnrDtyS+hv62h7gXu+8jlqm2y6TV5xzVFvxBZcsHNrp4eeG7OKeDOVcf1gAPW+x9lrtaGE1KzILBJ3Udt3NU7IuaPVs0EVZ0YNW64n0/GxWGOSSOKZLbx/vybuFMGXDVhBVDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763425485; c=relaxed/simple;
	bh=0T8UVJx47R1toXxTH5zXlqCaQiDCFi6Awm0Ozd2R4M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/cAqhaK9FIcXH+9/iFNBUPA1eYCCFzQYpVY9HyK632wLDBTIn6i6T7QoZdC8WOjmMWwPlTC4C+Ny6UEx21Knina+Y5cNuIlmew4deQApMjwW/U2ywYHbZVRvF4qmuLELGnchhAjIHicUFpmSE7Bw4ekE8xftJz82Ps/n7RGtps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOfBpEf7; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-789524e6719so23606747b3.1
        for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 16:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763425482; x=1764030282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Q+D4xi4pZMCXKvcb+ARJAFJMgk4uxgy92qNv9ZisJo=;
        b=TOfBpEf77quYJkrsyoiQeNRnAf6LUS0QBqQAFNaJQnFfnehpODZJqwR2ueAM5DDUVZ
         zGhDgxFephVUSQH4t+ZKKh6TNrCv5A8eC5OwFP+aNEGimidvvy1wAkbzbwvYYBaNgl1l
         x2icW9lpTWZMt2UJTJwREvs3Z2GnrawKf74RQCjh8MMsOO+kSiaQe7i3e1vYDPIYDUo6
         vhLcpdnb3+5XqUG8TDw1C45s2w6qfVUAhYeDjxCt+WoyUgIcqRZdv+zv4/0njMqHT10T
         f/+lzju5LNeZ6EqE1jWHG57Fqyq1o49jzsCFuvBxsCY49Jl06mflqlCM7xv89C8j5O5N
         SrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763425482; x=1764030282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Q+D4xi4pZMCXKvcb+ARJAFJMgk4uxgy92qNv9ZisJo=;
        b=o6Ir4GB4QvrPinpy8h/N52Ee8djIIZZYVUA5q9CXYZuVQFcSMvDa+kQNtpTqWHKpdK
         fNuBD1C+vMoV51UVQ3RjLg+GDqD/iuQVI6sHgOqej9AVbU6wrR4pLJbSU8Jg9To4578W
         ppvX7/fc/leXBYDNUm23TSjCRUABKn1Hlh0w+Csc0DjDUVhiJU6cMRpPP8p540YxXBNW
         eOwqbABhicQPHyvrD1g198PxwWAyTfeH8RyeRLcJTh8ayicipb0y3E+9tcH0VCYl5d9a
         naaxOAZLgqd5hqOlYDipaYRAgSfLZNGoYJmb71033whXk+sAHXAp7szgs2lasVjLHeoI
         l/sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs8doTruoeBHeNXsm+Q5iE0y3HvYjNVJFIK6Kp5wzD7gujguteh23eAnIkSSA1RLt1RFiYZULVPdxU@vger.kernel.org
X-Gm-Message-State: AOJu0YzH0Lr3ubprO6EoZu1a5NOTjeREiSeQs8B5HGJuFj4RfX5pcUEf
	fuo8LWaXs62v95xoKV/muoUIyXLZlF5NC6Hys6CMn+R9W8wUFS0xY1wq
X-Gm-Gg: ASbGnctyUlZw53eDWlcWplgWrE9ssSgEI1++qXwr+6yWJef9YISnoWw7W5gHFD0VWM4
	+v7Rg2H2oAmY/XcBBO1v445lsPJriiFWXwqCpwoppBOMqqkMnavGgIb3BQYZURCcbWg+BbLZmUo
	rHnFH/GrbaB5dt9C98aJs5QZi9lu0Sbif6rhcm9sh+jwPWzhtrlFS3GE5huTlOc0KtnUF+aAW7w
	JMS1eNh02oTfpQGUyV0EHh1uQMxRMxanwGXEFzdYixD5W2x0EWzP14/h+g/TIqjRoseV2JULeOo
	wZDPzhJjr72MpFijZjoTn2qi9DfO4ZUXz/ZOKOp364tqS/R9Q6nTrEOlpUXcbGWJtNQyTf/upIr
	3PfJjJIa1kOmQ+zISkVChOwi8kG7vOFST3+BnIfwBgkcv7QxRFHynogZYmTIO5bMAmkRZWGwMye
	rro+SefJhMjXN6Wb/IFyL0GquMWXfl8g==
X-Google-Smtp-Source: AGHT+IEWrYQ0g0qi/5xwpjGu9W7qvhXZpmv1KOoNU9mCPzMHy61Lr1L8uLsi/JJJj5Hq8ZPBAmpvgQ==
X-Received: by 2002:a05:690c:708c:b0:786:56ad:f29f with SMTP id 00721157ae682-78964fb9499mr13473197b3.2.1763425482280;
        Mon, 17 Nov 2025 16:24:42 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7882212561fsm47026437b3.31.2025.11.17.16.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:24:40 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Manish Chopra <manishc@marvell.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Vladimir Oltean <olteanv@gmail.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v4 2/6] devlink: refactor devlink_nl_param_value_fill_one()
Date: Mon, 17 Nov 2025 16:24:28 -0800
Message-ID: <20251118002433.332272-3-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118002433.332272-1-daniel.zahka@gmail.com>
References: <20251118002433.332272-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lift the param type demux and value attr placement into a separate
function. This new function, devlink_nl_param_put(), can be used to
place additional types values in the value array, e.g., default,
current, next values. This commit has no functional change.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 net/devlink/param.c | 70 +++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/net/devlink/param.c b/net/devlink/param.c
index 3dbd023e4c36..3aa14ef345f0 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -193,58 +193,66 @@ static int devlink_param_set(struct devlink *devlink,
 }
 
 static int
-devlink_nl_param_value_fill_one(struct sk_buff *msg,
-				enum devlink_param_type type,
-				enum devlink_param_cmode cmode,
-				union devlink_param_value val)
+devlink_nl_param_value_put(struct sk_buff *msg, enum devlink_param_type type,
+			   int nla_type, union devlink_param_value val)
 {
-	struct nlattr *param_value_attr;
-
-	param_value_attr = nla_nest_start_noflag(msg,
-						 DEVLINK_ATTR_PARAM_VALUE);
-	if (!param_value_attr)
-		goto nla_put_failure;
-
-	if (nla_put_u8(msg, DEVLINK_ATTR_PARAM_VALUE_CMODE, cmode))
-		goto value_nest_cancel;
-
 	switch (type) {
 	case DEVLINK_PARAM_TYPE_U8:
-		if (nla_put_u8(msg, DEVLINK_ATTR_PARAM_VALUE_DATA, val.vu8))
-			goto value_nest_cancel;
+		if (nla_put_u8(msg, nla_type, val.vu8))
+			return -EMSGSIZE;
 		break;
 	case DEVLINK_PARAM_TYPE_U16:
-		if (nla_put_u16(msg, DEVLINK_ATTR_PARAM_VALUE_DATA, val.vu16))
-			goto value_nest_cancel;
+		if (nla_put_u16(msg, nla_type, val.vu16))
+			return -EMSGSIZE;
 		break;
 	case DEVLINK_PARAM_TYPE_U32:
-		if (nla_put_u32(msg, DEVLINK_ATTR_PARAM_VALUE_DATA, val.vu32))
-			goto value_nest_cancel;
+		if (nla_put_u32(msg, nla_type, val.vu32))
+			return -EMSGSIZE;
 		break;
 	case DEVLINK_PARAM_TYPE_U64:
-		if (devlink_nl_put_u64(msg, DEVLINK_ATTR_PARAM_VALUE_DATA,
-				       val.vu64))
-			goto value_nest_cancel;
+		if (devlink_nl_put_u64(msg, nla_type, val.vu64))
+			return -EMSGSIZE;
 		break;
 	case DEVLINK_PARAM_TYPE_STRING:
-		if (nla_put_string(msg, DEVLINK_ATTR_PARAM_VALUE_DATA,
-				   val.vstr))
-			goto value_nest_cancel;
+		if (nla_put_string(msg, nla_type, val.vstr))
+			return -EMSGSIZE;
 		break;
 	case DEVLINK_PARAM_TYPE_BOOL:
-		if (val.vbool &&
-		    nla_put_flag(msg, DEVLINK_ATTR_PARAM_VALUE_DATA))
-			goto value_nest_cancel;
+		if (val.vbool && nla_put_flag(msg, nla_type))
+			return -EMSGSIZE;
 		break;
 	}
+	return 0;
+}
+
+static int
+devlink_nl_param_value_fill_one(struct sk_buff *msg,
+				enum devlink_param_type type,
+				enum devlink_param_cmode cmode,
+				union devlink_param_value val)
+{
+	struct nlattr *param_value_attr;
+	int err = -EMSGSIZE;
+
+	param_value_attr = nla_nest_start_noflag(msg,
+						 DEVLINK_ATTR_PARAM_VALUE);
+	if (!param_value_attr)
+		return -EMSGSIZE;
+
+	if (nla_put_u8(msg, DEVLINK_ATTR_PARAM_VALUE_CMODE, cmode))
+		goto value_nest_cancel;
+
+	err = devlink_nl_param_value_put(msg, type,
+					 DEVLINK_ATTR_PARAM_VALUE_DATA, val);
+	if (err)
+		goto value_nest_cancel;
 
 	nla_nest_end(msg, param_value_attr);
 	return 0;
 
 value_nest_cancel:
 	nla_nest_cancel(msg, param_value_attr);
-nla_put_failure:
-	return -EMSGSIZE;
+	return err;
 }
 
 static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
-- 
2.47.3


