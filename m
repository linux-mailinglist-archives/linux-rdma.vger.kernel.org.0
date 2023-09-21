Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B3E7A95D5
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Sep 2023 18:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjIUQ4W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 12:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIUQ4W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 12:56:22 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0ECAC
        for <linux-rdma@vger.kernel.org>; Thu, 21 Sep 2023 09:56:10 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-570428954b9so960455a12.3
        for <linux-rdma@vger.kernel.org>; Thu, 21 Sep 2023 09:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695315367; x=1695920167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Sd4hbhBemt6+PvRvK/BENUnRBVZPSiTQthHgyMmLUc=;
        b=yrpdKOydHjaf4s7hxwWiE9yV0gYNqYhKNDy2jUFeXVDq39ciMESpeOi8BF+vRkicaj
         qwk5RDn6blfcTauKBFarUwAKHGmFLQrkvv2YzRgbsGVAKdjJT8JkezG83LFG7eVIH/u6
         +qh3BreoTp0aJN+3o+2drLTK/CPvfKrI0aqRH20C3xXe3odiVYE5Z0dKvUepWU0LR9on
         vURIUuz0BW8zVBfrJl4bEISmwAyBt2gRyqXVWAxkLlQUv3YDsvkhGvO+IggB8w5fIUbu
         lhs5HhflQjRKBF4QiV3o+DVYEkWiup9MDe+Nlnk/oFB4Fg2Ir99B8fu2ZwJXs5Fen4Kv
         QRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315367; x=1695920167;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Sd4hbhBemt6+PvRvK/BENUnRBVZPSiTQthHgyMmLUc=;
        b=VRQh3EVmAu8FWE3YaVFYVqlSus18FmKKN4DXVktljFSvytkkxa9jNY983Yuq4xpWLn
         ATazdPl+UrSQsNZf5B4xwYFvJyllhLy0tIMapl4y6nztIAkWAzQZM20K2MmaJourZMSv
         HIGUN5Rmm8C5TBzhUyq1R6/Fdc7OB2beTJr7lG9bgONXY7WfeHOEP+DQeJ/n4eiRE7wd
         ViLTp8w+ij3EQ4dl/UX+99bdRBC5CsxxHRNZvt/iBvYt0LGEMNLK1YNaw+9MLg34lEGc
         DTe9VoaE3/IyQkH+dNUw1Amtnx8CWBFBi/mw8OO3Cm891wdzIZo96xb9FJ2RDW4P1HVj
         2UCA==
X-Gm-Message-State: AOJu0YwT7aHmlQ5m6LNoYaZt+NDdUSIB71Ez3yBez9mdc5EGqWb/pa1j
        OVu/gbgcy570YRZiNZTlQwlLkm8eHsch+rExzg==
X-Google-Smtp-Source: AGHT+IFWNDtLo6T7hYyWkvIRT0T2ceJhA1446eNRT+1I3X5gzOavUskQ6j/Bys+UNNJrmi11oEd2CYMw2JNr7ecfxQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:b149:0:b0:59b:ebe0:9fd6 with SMTP
 id p70-20020a81b149000000b0059bebe09fd6mr74612ywh.6.1695281787226; Thu, 21
 Sep 2023 00:36:27 -0700 (PDT)
Date:   Thu, 21 Sep 2023 07:36:26 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHnyC2UC/x3NywrCMBBG4VcpWTswbbygryIiuUzsv3AsE2mV0
 nc3uPw256yuikGqu3SrM5lR8dKGfte5NAZ9CCE3u4EHz+ehp/o2TdOXsmEWqwQtUMSgmcaFYPk ZCHvGckehREfvuUQ+8ClH16KTScHnP7zetu0HJ/831YAAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695281786; l=1647;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=azwE+ZmdRI6O/nQsHa387F2VcNjnWz4bpJZWNz8mYqI=; b=4HCFbh7ZqzydD1p5IcPfSFx7e/laNJU8kusftwlxw5oJi2KxF9BHvAMRI3p7BtcLKVqzigrTX
 NHT8RDtFa++CJFD7cM80Ms7NYhx6XCn7cRz+AXha7ug2OLfrzDgoGS5
X-Mailer: b4 0.12.3
Message-ID: <20230921-strncpy-drivers-infiniband-hw-irdma-i40iw_if-c-v1-1-22d87aef7186@google.com>
Subject: [PATCH] RDMA/irdma: replace deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-6.6 required=5.0 tests=DATE_IN_PAST_06_12,
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

A suitable replacement is `strscpy_pad` due to the fact that it
guarantees NUL-termination on the destination buffer.

It is unclear to me whether `i40iw_client.name` requires NUL-padding but
have opted to keep the NUL-padding behavior that strncpy provides to
ensure no functional change.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested
---
 drivers/infiniband/hw/irdma/i40iw_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/i40iw_if.c b/drivers/infiniband/hw/irdma/i40iw_if.c
index 4053ead32416..adbea33bf5b7 100644
--- a/drivers/infiniband/hw/irdma/i40iw_if.c
+++ b/drivers/infiniband/hw/irdma/i40iw_if.c
@@ -186,7 +186,7 @@ static int i40iw_probe(struct auxiliary_device *aux_dev, const struct auxiliary_
 							       aux_dev);
 	struct i40e_info *cdev_info = i40e_adev->ldev;
 
-	strncpy(i40iw_client.name, "irdma", I40E_CLIENT_STR_LENGTH);
+	strscpy_pad(i40iw_client.name, "irdma", I40E_CLIENT_STR_LENGTH);
 	i40e_client_device_register(cdev_info, &i40iw_client);
 
 	return 0;

---
base-commit: 2cf0f715623872823a72e451243bbf555d10d032
change-id: 20230921-strncpy-drivers-infiniband-hw-irdma-i40iw_if-c-6330fb0507db

Best regards,
--
Justin Stitt <justinstitt@google.com>

