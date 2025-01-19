Return-Path: <linux-rdma+bounces-7094-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D65A161DA
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 13:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3663C164E79
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 12:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DDA1DED78;
	Sun, 19 Jan 2025 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpnoTR6Z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B721D2F53
	for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737291440; cv=none; b=b354ZMT2LDUwpwnehD5VcAekDqKPsetm7CDvVAkH0GOijXtHQ4lukjmuvA9r/DLY68+79aoDlcen0KJJXV+3HiOJjENdYy/EDGIILEkT+Mk5ZoePuI2HjbRN2322XKAeEkp9+UD9yVtSOhU8IYROFRSjWvwxWu0eeksD+cICXmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737291440; c=relaxed/simple;
	bh=SHHOG8TbCVBkqQl8T25GgArBSGkklDnIfGX71N31ceE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b06VV1qWXKFIAKtrSnkT8xjsdL51RLwfZk/NzvrUAotWtYTVySvCC01X8Qlgedk9iSWvhpjyZXrQlFgh/fhh68X2bOXIOOwVGxkfjYg5WN3qnq19wsj54X12RGkYekddSKYwzYMp4fjWnB6LS6/7m1mkS/T/gdZ+l9Wwu4g7Dyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpnoTR6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078B2C4CED6;
	Sun, 19 Jan 2025 12:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737291440;
	bh=SHHOG8TbCVBkqQl8T25GgArBSGkklDnIfGX71N31ceE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RpnoTR6ZNPw0YvVOAWU5T3XdahItHq6HpYXeesQu1cGRAoqINByZe+2v9XSxvOMiW
	 GeKFXl4uL3/BCMtmgSpmk7hVrrZi5KBOrMkdm6wt82ve/62jWb/WJJ3rdgiPPryqc5
	 I/XuIKwP/x5T7Eqwtcl8EXtQg1gNiORFkyo4bnPIp4efAs/QnO2shK498ggoWFyVIr
	 2dj+qnVIvoZ/uvE+SNgvs7j6Id2yqwIFEd0n/f2WtOh/EbXoAmjygobvGb5Q7SlqS4
	 jffLmms/2cdR+bzI+glRBbABxaF4se/NkjDwrwI40Hdo0Phcism0ir9+ZkHPldvIwv
	 92I0XVzuv6jRQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Maher Sanalla <msanalla@nvidia.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 3/3] IB/hfi1: Remove state transition log message and opa_lstate_name()
Date: Sun, 19 Jan 2025 14:57:02 +0200
Message-ID: <e766b87d0278ab198bb72fd7a8d88f234d52d605.1737290406.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1737290406.git.leon@kernel.org>
References: <cover.1737290406.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maher Sanalla <msanalla@nvidia.com>

Remove the state transition log message from the hfi1 driver, as
the IB core now logs the same information when handling a cache
update event.

While at it, replace the hfi1-specific opa_lstate_name() function with
the ib_verbs equivalent function, ib_port_state_to_str(), for converting
IB port state to a string.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/hfi1/chip.c   | 18 ------------------
 drivers/infiniband/hw/hfi1/chip.h   |  1 -
 drivers/infiniband/hw/hfi1/driver.c |  2 +-
 drivers/infiniband/hw/hfi1/mad.c    |  4 ++--
 4 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index a442eca498b8..368b6be3226f 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -12882,22 +12882,6 @@ u32 chip_to_opa_pstate(struct hfi1_devdata *dd, u32 chip_pstate)
 	}
 }
 
-/* return the OPA port logical state name */
-const char *opa_lstate_name(u32 lstate)
-{
-	static const char * const port_logical_names[] = {
-		"PORT_NOP",
-		"PORT_DOWN",
-		"PORT_INIT",
-		"PORT_ARMED",
-		"PORT_ACTIVE",
-		"PORT_ACTIVE_DEFER",
-	};
-	if (lstate < ARRAY_SIZE(port_logical_names))
-		return port_logical_names[lstate];
-	return "unknown";
-}
-
 /* return the OPA port physical state name */
 const char *opa_pstate_name(u32 pstate)
 {
@@ -12956,8 +12940,6 @@ static void update_statusp(struct hfi1_pportdata *ppd, u32 state)
 			break;
 		}
 	}
-	dd_dev_info(ppd->dd, "logical state changed to %s (0x%x)\n",
-		    opa_lstate_name(state), state);
 }
 
 /**
diff --git a/drivers/infiniband/hw/hfi1/chip.h b/drivers/infiniband/hw/hfi1/chip.h
index 8841db16bde7..6992f6d40255 100644
--- a/drivers/infiniband/hw/hfi1/chip.h
+++ b/drivers/infiniband/hw/hfi1/chip.h
@@ -771,7 +771,6 @@ int is_bx(struct hfi1_devdata *dd);
 bool is_urg_masked(struct hfi1_ctxtdata *rcd);
 u32 read_physical_state(struct hfi1_devdata *dd);
 u32 chip_to_opa_pstate(struct hfi1_devdata *dd, u32 chip_pstate);
-const char *opa_lstate_name(u32 lstate);
 const char *opa_pstate_name(u32 pstate);
 u32 driver_pstate(struct hfi1_pportdata *ppd);
 u32 driver_lstate(struct hfi1_pportdata *ppd);
diff --git a/drivers/infiniband/hw/hfi1/driver.c b/drivers/infiniband/hw/hfi1/driver.c
index 37a6794885d3..50826e7cdb7e 100644
--- a/drivers/infiniband/hw/hfi1/driver.c
+++ b/drivers/infiniband/hw/hfi1/driver.c
@@ -968,7 +968,7 @@ static bool __set_armed_to_active(struct hfi1_packet *packet)
 		if (hwstate != IB_PORT_ACTIVE) {
 			dd_dev_info(packet->rcd->dd,
 				    "Unexpected link state %s\n",
-				    opa_lstate_name(hwstate));
+				    ib_port_state_to_str(hwstate));
 			return false;
 		}
 
diff --git a/drivers/infiniband/hw/hfi1/mad.c b/drivers/infiniband/hw/hfi1/mad.c
index a9883295f4af..b39f63ce6dfc 100644
--- a/drivers/infiniband/hw/hfi1/mad.c
+++ b/drivers/infiniband/hw/hfi1/mad.c
@@ -1160,8 +1160,8 @@ static int port_states_transition_allowed(struct hfi1_pportdata *ppd,
 	if (ret == HFI_TRANSITION_DISALLOWED ||
 	    ret == HFI_TRANSITION_UNDEFINED) {
 		pr_warn("invalid logical state transition %s -> %s\n",
-			opa_lstate_name(logical_old),
-			opa_lstate_name(logical_new));
+			ib_port_state_to_str(logical_old),
+			ib_port_state_to_str(logical_new));
 		return ret;
 	}
 
-- 
2.47.1


