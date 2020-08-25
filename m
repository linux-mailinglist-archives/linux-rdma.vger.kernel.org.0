Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD49250E2B
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 03:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgHYBXu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 21:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgHYBXt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 21:23:49 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D21C061795
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 18:23:49 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id e6so10196121oii.4
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 18:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AbX53iOAXRp1EA7Cz0J7lly5NFY2B6E3mpb1o2oXt3Q=;
        b=JKgPofuBNH/m5PDDiXj3ztAYDbsb1NoUJpiHpz86avSZ9YNPn+kC8qbUNeHAfcqHTW
         2/mXf2qDNDwMXduUFL8Gis+JX9edAG9fSremD3EVC9jXCJygo8ulDKQS5zDgSEu9ivJ/
         xOdOmDK9GTm5imh8noi1MBUNUTu6TknV1UkyOd1R29p2B+1DNIM5e+VcJS9kJb2l5AnN
         I4HEaZi5U8gRDqVl/8h70ksnjYWQ5B8HNdfh2mlp1xfM7pYmI5uuV97KK6ZfvCV7N+kP
         R8V1w9TBLttaG6h/Nh5/zKUmr9MLnFqgoML4fmJ/prberTrK3LjjYDXOjhUTnwXTkBGL
         fU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AbX53iOAXRp1EA7Cz0J7lly5NFY2B6E3mpb1o2oXt3Q=;
        b=IvL6uWlgakaQOlMODReDKFUkgySuTrzTxcyXlKPzegHqbpc31D17eIq6c5ldbVpu6l
         G+Lxqyx/rgHGsDUervxtRLQfjc1fJWsvkqzYR7kOC5eGeZ5vA/8wLs2S3aIls1YeVneW
         WU3TLjfC/W1/4jdKlQsEq10urTSslMxyBig8evgOS7x24aUpGkSnIpIlxtSTnSiJF0cr
         KFxA+TFySKw8wpdC0y+pRN4hmKTmOnthMrRqTVCcW2NkwtzJuRsEqNLUGWuZyNf2w7uM
         pHquEg14oMR7SbeWQe0karqr5TFptWOwUoUnMg2bSaZUZ5wDBTYdhSHC/BmstjAn+xnP
         6Evw==
X-Gm-Message-State: AOAM532LWiRfxGir2JvcXq5SlfvnideMfLNDM8KM0xCWRoD0giK8ZcFr
        Jhw0dUogbC/SV9MdbfbBREQ=
X-Google-Smtp-Source: ABdhPJzXW6Ivh9fjWCuElkJ8wlb7gfCB4Eakr0HrpvC+XpXKC15AB6mjelf/kV2hnIM7siIaEb0E9A==
X-Received: by 2002:aca:a9c9:: with SMTP id s192mr1284627oie.152.1598318628665;
        Mon, 24 Aug 2020 18:23:48 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:ab9d:b15a:fdb:5727])
        by smtp.gmail.com with ESMTPSA id s6sm2385040otq.75.2020.08.24.18.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 18:23:48 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     leon@kernel.org, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH] Fix tests/test_device.py
Date:   Mon, 24 Aug 2020 20:23:44 -0500
Message-Id: <20200825012344.5696-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Removed a test case which requires vendor_part_id to be non zero.
Per IBTA A3.3.1 VENDOR INFORMATION it is not required that the
vendor part ID field be set to a non-zero value:

	The following components are vendor specific: VendorID, DeviceID, De-
	vice Version, Subsystem VendorID, SubsystemID, ID String.

	The vendor places its IEEE assigned Organization Unique Identifier
	(OUI) in the VendorId field and *MAY PLACE ANY VALUE IN THE DEVICEID* and
	Device Version fields. The vendor may also provide an ASCII string of its
	choice in the ID String field.

	The Subsystem VendorID and SubsystemID provide additional informa-
	tion when a subsystem vendor uses components provided by other ven-
	dors. In this case the subsystem vendor provides its OUI in the Subsystem
	VendorID field and may specify any value in the SubsystemD field.
	A vendor that produces a generic controller (i.e., one that supports a stan-
	dard I/O protocol such as SRP), which does not have vendor specific de-
	vice drivers, may use the value of 0xFFFFFF in the VendorID field.
	However, such a value prevents the vendor from ever providing vendor
	specific drivers for the product.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 tests/test_device.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/test_device.py b/tests/test_device.py
index c23caae1..d552f402 100644
--- a/tests/test_device.py
+++ b/tests/test_device.py
@@ -86,7 +86,6 @@ class DeviceTest(PyverbsAPITestCase):
         assert attr.max_mr_size > PAGE_SIZE
         assert attr.page_size_cap >= PAGE_SIZE
         assert attr.vendor_id != 0
-        assert attr.vendor_part_id != 0
         assert attr.max_qp > 0
         assert attr.max_qp_wr > 0
         assert attr.max_sge > 0
-- 
2.25.1

