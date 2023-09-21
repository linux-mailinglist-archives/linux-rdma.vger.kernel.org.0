Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE71C7A991E
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Sep 2023 20:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjIUSLe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 14:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjIUSK7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 14:10:59 -0400
Received: from mail-vs1-xe49.google.com (mail-vs1-xe49.google.com [IPv6:2607:f8b0:4864:20::e49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF095A57C
        for <linux-rdma@vger.kernel.org>; Thu, 21 Sep 2023 10:21:20 -0700 (PDT)
Received: by mail-vs1-xe49.google.com with SMTP id ada2fe7eead31-45275d9b864so1042051137.0
        for <linux-rdma@vger.kernel.org>; Thu, 21 Sep 2023 10:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695316880; x=1695921680; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yNCF6Zt81nxj8UQ8gNIU503gdPKJ22mbn5cyKbzYsNE=;
        b=rUKZN1y6VFsVMDZRN0ruLPwSiawSmnpQy2mua2rcX38mZ2sLuJBruUdiINeSDXgWbe
         bCPjGhOl9INPkU8z8ibAU4HFX6yKBHdoi1P8cP1fQCxS8WIWi+HfhVatrQzwWOLHutq7
         h0X4F0CNGQaxSc6aYRndoTiJYoXNqD2JldGTTtzLmerIxykovHt1+v/7wP9coCkEn6va
         a6r6RSmJNcPXR5tJVkeOk5i/bkpuPYJRKC/jZJYd0J9rh51cpDP9gzJRezzVL8gUsZMo
         58WH+Io54tvv6C4/RK+KZO2SRvO1uDvTnE4LcSEGs+UhI1eRMt4ZeuzzceddUV41ccqw
         0BxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316880; x=1695921680;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yNCF6Zt81nxj8UQ8gNIU503gdPKJ22mbn5cyKbzYsNE=;
        b=cR1oCJ3YweugTW1BvWZ12tv+JhLBRIpECKZ9yIy1BECCH6mccOwkp4+zT+ptsuBuZK
         B+9Boi7b3fhdpuBuqNOSa6If2dpBnWc45v49WH/g8IVbUGetdv02VNb7hM01WRpHqIRt
         e9u2a+xAtPf3d6g67+6LMb7bFV3dcf6sD39ge+4GQ9rdltZ1iyDgo3W9mUmB1ebE81nd
         dLEoo4GI4omQB06syLHPzp2Stx2IZNRr4KgvuMVMYA/FEk0Y5aQshLuayyNLnC77Pvvy
         GuW9RKQRKpmurrIa9Jv3cfN2+ssrrP5kOV/k+z8pI6SFabH4S4b+nI14GIGyn03pZOAa
         hVZw==
X-Gm-Message-State: AOJu0Yz/+IUQ4UdwI+nb/BMXazSHayzxmKrSmlMEsp3dOmnQ+lMzzLUx
        F+SNtUVb7s2ClkqStKWFqyQ4K8tKIwGbc+nkRg==
X-Google-Smtp-Source: AGHT+IG9HZjc3JIk5MEyIpSba4YkGUvBiWvtiXnmfI90PzuqCpAGn0qssQW1hqGUZeqIx/17RfnWLbC0RMIskQMPDg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:d8f:b0:59b:5a5b:3a91 with
 SMTP id da15-20020a05690c0d8f00b0059b5a5b3a91mr235089ywb.2.1695283130297;
 Thu, 21 Sep 2023 00:58:50 -0700 (PDT)
Date:   Thu, 21 Sep 2023 07:58:48 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALf3C2UC/x2NSw7CMAwFr1J5jaXU4VO4CkJVkzjUG1McVIqq3
 p3AYhYzi/dWKGzCBS7NCsazFHlolXbXQBwHvTNKqg7kyLsztVhepnH6YDKZ2QqKZlEJgyYc3/i U8KOv4eSJMOK+S4fQ5aPzzFBXJ+Msy//xetu2Lx6W2eyBAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695283129; l=2260;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=yG7G6SjuBc3zLcpp7gnhrmEb8A3RYwBew7uUX2315CY=; b=Yl+wEYYRm8WEbB2hhRaqUxc1tVIoc6ZKIs0c9VOUvp7taB3+qAlHxPrlAMZm8qubfP1QqWv9s
 qlGem8Mov1TAxEmbCRIduUctIT2LKxA/mRraFOOFJzFPh6rM/HxWvj/
X-Mailer: b4 0.12.3
Message-ID: <20230921-strncpy-drivers-infiniband-hw-qib-qib_iba7322-c-v1-1-373727763f5b@google.com>
Subject: [PATCH] IB/qib: replace deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1]
and as such we should prefer more robust and less ambiguous string
interfaces.

We know `txselect_list` is expected to be NUL-terminated based on its
use in `param_get_string()`:
| int param_get_string(char *buffer, const struct kernel_param *kp)
| {
| 	const struct kparam_string *kps = kp->str;
| 	return scnprintf(buffer, PAGE_SIZE, "%s\n", kps->string);
| }

Note that `txselect_list` is assigned to `kp_txselect`'s string field:
| static struct kparam_string kp_txselect = {
| 	.string = txselect_list,
| 	.maxlen = MAX_ATTEN_LEN
| };

Wherein it is then assigned the set and get methods:
| module_param_call(txselect, setup_txselect, param_get_string,
| 		  &kp_txselect, S_IWUSR | S_IRUGO);

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested
---
 drivers/infiniband/hw/qib/qib_iba7322.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_iba7322.c b/drivers/infiniband/hw/qib/qib_iba7322.c
index 9d2dd135b784..f93906d8fc09 100644
--- a/drivers/infiniband/hw/qib/qib_iba7322.c
+++ b/drivers/infiniband/hw/qib/qib_iba7322.c
@@ -6127,7 +6127,7 @@ static int setup_txselect(const char *str, const struct kernel_param *kp)
 			TXDDS_TABLE_SZ + TXDDS_EXTRA_SZ + TXDDS_MFG_SZ);
 		return -EINVAL;
 	}
-	strncpy(txselect_list, str, ARRAY_SIZE(txselect_list) - 1);
+	strscpy(txselect_list, str, sizeof(txselect_list));
 
 	xa_for_each(&qib_dev_table, index, dd)
 		if (dd->deviceid == PCI_DEVICE_ID_QLOGIC_IB_7322)

---
base-commit: 2cf0f715623872823a72e451243bbf555d10d032
change-id: 20230921-strncpy-drivers-infiniband-hw-qib-qib_iba7322-c-48d5b8f603ee

Best regards,
--
Justin Stitt <justinstitt@google.com>

