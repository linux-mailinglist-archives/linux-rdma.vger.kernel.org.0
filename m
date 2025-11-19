Return-Path: <linux-rdma+bounces-14611-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AE402C6C71C
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 03:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9648834E133
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 02:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2C22D480E;
	Wed, 19 Nov 2025 02:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD8ot6IH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDFB2D12ED
	for <linux-rdma@vger.kernel.org>; Wed, 19 Nov 2025 02:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520644; cv=none; b=owAJhJcpY9hvOj61Pd+vB4GOH2xvPtGxbQ3/2eaovsUdN9okzDnAC/1pffHsL5nKB5P5aLFChsrlSMzoCBE3z/GrB+aoQyBcb2qTPfbyR2jXHFJLP+xZqEki72y5Q2b4LDLSjzyqqLwt7Wk/6m7CK07lO0z4us6D5O2/Cur6Sg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520644; c=relaxed/simple;
	bh=0T8UVJx47R1toXxTH5zXlqCaQiDCFi6Awm0Ozd2R4M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nb83H88D7jUXbcasvsz0equzm5iASl5tq6fbXixP2b1rRUqL/6W8+vVoKe/DBinqtlW6ieMU6qOQyqFt0Pr6UNn36ujKdA/1BnQjDKJ4KBtXVetqYDrxaaanSkk4DblXCqt2+Er45ODxOCqKSBf+VcXDs6lDOAzNbeqxGchPAmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iD8ot6IH; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-787be077127so62050437b3.2
        for <linux-rdma@vger.kernel.org>; Tue, 18 Nov 2025 18:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763520642; x=1764125442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Q+D4xi4pZMCXKvcb+ARJAFJMgk4uxgy92qNv9ZisJo=;
        b=iD8ot6IHTvZ56ci3S0MVEhPKyMwaGLYIusImHswxGmeVG6+qXC7upu50223Z9hSWSB
         VPqqt9gm/pYO279dEEreNADH9tSM4HGJ6YD5PvOKqF/sfs+GGKiJKWyUrR3JQ/7GmZfr
         bWdJPksiD7corkrfT9D76VQhrQTpmiAijIsp8Az7MVt5ggopkImrCiTGgMrM2q+4fFjS
         Jzwu7y90wtWB7jJQ2LryLW7CtKm1e+X9iiBJlsSVBt4gIjotV4ldwdRrXGWD9kg1MLSQ
         45kA1SkMQfWIhQ7aeJTH9IlRa8hqRRSqQ/1tbQy+UdQBD/Hb4ULKSljW47DqFe6cxLMf
         eNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763520642; x=1764125442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Q+D4xi4pZMCXKvcb+ARJAFJMgk4uxgy92qNv9ZisJo=;
        b=e/nGn+8OyT494GPWb2p7kyLUOjVa3HzEwPVbfFKL4p6pIiT6jkFdMb0zwi4qK4aJOJ
         975jrXoa/CpgUG1woEwxogTQnIEttpPT/+zJeyGpR7g6Z23pBazV7F5qcJN+YSXYPSSg
         eb9vh36HTnYtVqjfW0CMSckhqsZXxUpuxTm+GvvGwFTQAO9YZC5v0hZdUloXjCt3fohO
         OGMh+b5NWUy2WaiOvIFFtq6+MjSDxMCxZkCj3Qugfa5PZms7dLxTRw33KZOKJxgbEj/W
         b0uPVvcJK089zKCjmSYvYcHCieKg35qso+dUiHcPxTZ//Ec4r+JGodooOQynJxNoKJaT
         CplA==
X-Forwarded-Encrypted: i=1; AJvYcCXt9ysk5WWRWfhNb+moiO2FDYoDy3EnmGy1JGA35cjlrmOvXXclVMrFeA9ZRau2xD8osYxCHw6C6OJ0@vger.kernel.org
X-Gm-Message-State: AOJu0YylDj99ovrtWFstKiyc1lNcFW2GAOcvIJuV0NzPbPZ9YGVizBLR
	QO43DQ3V0MZE4sgKAZDFjP8PuGcCHI9v7dSH4BneHl2vTvrq7FNdzuZa
X-Gm-Gg: ASbGncusfaqYnumbY0MssazVBs7zLR202iqqlgY2DfRiWyrWPxa3MRkUfWd++R/MedE
	s5WH0P1lk/YBLkMkctheEVoeetuJQ1oT2qCnDykrBqWJRnXeg6oXzCD3VS5J1dZpZgtM1jOHUQa
	RdVCsxTllRfoYi3IRzDK/F7A1eXHLI0gvvmKoPRjjkoeZ1SoU2L4PPGPLCF10/Fkez1wFz14MVQ
	+BUymq5LIc15j4QftFSgfv5hbkXg2WK8uSBt0kxkOhSmg6Ka44/4W8iItpah5AxpE2aaR3S2olw
	CtSgJ3EKh6tjfPxVjfLatcmSCSUXSBP6iPKKNn7w6QnqeiGjE6oUXlHnPF+JcH843HbWiNw5FEI
	iqzgxBUOHdFhKN26q9RYLp1IBqiWGQWK2MKQFjXIzK96e36adYPAt7pyyaPeQs7mvpeiy5CauiD
	kp0sYcWdkmkionlyVXP6sLKGAqnI7UUQ==
X-Google-Smtp-Source: AGHT+IEuqWYlgnJx+1p1oS9BwNgqcAGRAad/SBsLawrFhVZgJirmmQxmRnDIWr1P6RUTLWy17BUZPA==
X-Received: by 2002:a05:690c:a003:b0:788:4d:3422 with SMTP id 00721157ae682-78929ee3e23mr140127257b3.38.1763520641784;
        Tue, 18 Nov 2025 18:50:41 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78822179d40sm58964867b3.54.2025.11.18.18.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 18:50:41 -0800 (PST)
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
Subject: [PATCH net-next v5 2/6] devlink: refactor devlink_nl_param_value_fill_one()
Date: Tue, 18 Nov 2025 18:50:32 -0800
Message-ID: <20251119025038.651131-3-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119025038.651131-1-daniel.zahka@gmail.com>
References: <20251119025038.651131-1-daniel.zahka@gmail.com>
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


