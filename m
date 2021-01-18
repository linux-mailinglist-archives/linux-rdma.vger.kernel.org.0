Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F2E2FAD69
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 23:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389289AbhARWlg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 17:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389261AbhARWle (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 17:41:34 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238E6C0617BF
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:56 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id e15so8652344wme.0
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o2Ps4NdwSah0TpS5Hl9/iU2xXHhQ0Nh1Ujaqty12+uY=;
        b=m6chYw8W2yxmf8PKgJIUyE44dr27PL7aC2GJfBIhFlTCld/tHDlW5wwsWshXjL+loP
         B0SVc5DRjHfBTXD3JNF7vT4jfE9FHtRTkTRwB+ff+kyCAYHTF6wWPyWcL8+KW8QH54SS
         LTvEyAappDHL0SoIdO3eKlRwn1nkuMVbGDq4mTlZv9+oS9/Lhjzh1xvMyPS8++dOgVmA
         Svi4NV3gzkerjb25v//Pt6AkJysS4CgI0ER2Vi3ReMM0egLOKzHCMAXX9E0+hGpWHIcK
         61CzEByScPqu5eZQRRjflCRJaqfDNFJY/nZ4H/X+NLr5TtviDxVgvaLMSkXVCQRitX9T
         GUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o2Ps4NdwSah0TpS5Hl9/iU2xXHhQ0Nh1Ujaqty12+uY=;
        b=CdoYUKSzzuJ4XRhGYVFtMSIxcZumyETlwzEuYF7ECS3QqCnXBuw6PKqeOls7EA0f+g
         WBshbS/Nvf2rFEiJyCGR4xoaXw6T/x7MtbGAdhW599U/RTAaYvGZ/MSLl9ts9n9GSPE9
         W62FeFeHDOR+FHcgsktQhn4DsO0Bwv+L+xwKE0KHEb95sWdfyd4hNQSqEAyuKKk/xpH/
         BwaGoqtY5/01avGLQkBVGHpu6R92A7V54+HoDGogVCTtqjwuk/hV1xRw5r1v3bcEK6cA
         rKEoTeumBhd7kcZSevcW3bITwCO1jS5sEzg4rhaEKatgW8D3mSZmqYd6kYtUj0MiRtFv
         Mkew==
X-Gm-Message-State: AOAM531+BDCfhVZQu9cNeUexRP2KwTYYc6a6Gz3QX0OCVUEnebotNVxs
        Dg5BhrtKQ4MfZIVzWV8ObY/4bg==
X-Google-Smtp-Source: ABdhPJxW5uRN4NeDNBwkU6uVLJdshMT+VBEfC7iD9uFNzSF3xvGEs6kqcKqlrRzUWfdGXVx2TJrhqg==
X-Received: by 2002:a1c:20cb:: with SMTP id g194mr1281480wmg.51.1611009594926;
        Mon, 18 Jan 2021 14:39:54 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id l1sm33255902wrq.64.2021.01.18.14.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:39:54 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 20/20] RDMA/core/iwpm_msg: Add proper descriptions for 'skb' param
Date:   Mon, 18 Jan 2021 22:39:29 +0000
Message-Id: <20210118223929.512175-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118223929.512175-1-lee.jones@linaro.org>
References: <20210118223929.512175-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/core/iwpm_msg.c:402: warning: Function parameter or member 'skb' not described in 'iwpm_register_pid_cb'
 drivers/infiniband/core/iwpm_msg.c:475: warning: Function parameter or member 'skb' not described in 'iwpm_add_mapping_cb'
 drivers/infiniband/core/iwpm_msg.c:553: warning: Function parameter or member 'skb' not described in 'iwpm_add_and_query_mapping_cb'
 drivers/infiniband/core/iwpm_msg.c:636: warning: Function parameter or member 'skb' not described in 'iwpm_remote_info_cb'
 drivers/infiniband/core/iwpm_msg.c:716: warning: Function parameter or member 'skb' not described in 'iwpm_mapping_info_cb'
 drivers/infiniband/core/iwpm_msg.c:773: warning: Function parameter or member 'skb' not described in 'iwpm_ack_mapping_info_cb'
 drivers/infiniband/core/iwpm_msg.c:803: warning: Function parameter or member 'skb' not described in 'iwpm_mapping_error_cb'
 drivers/infiniband/core/iwpm_msg.c:851: warning: Function parameter or member 'skb' not described in 'iwpm_hello_cb'

Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/core/iwpm_msg.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/iwpm_msg.c b/drivers/infiniband/core/iwpm_msg.c
index 46686990a8271..30a0ff76b3327 100644
--- a/drivers/infiniband/core/iwpm_msg.c
+++ b/drivers/infiniband/core/iwpm_msg.c
@@ -392,7 +392,7 @@ static const struct nla_policy resp_reg_policy[IWPM_NLA_RREG_PID_MAX] = {
 /**
  * iwpm_register_pid_cb - Process the port mapper response to
  *                        iwpm_register_pid query
- * @skb:
+ * @skb: The socket buffer
  * @cb: Contains the received message (payload and netlink header)
  *
  * If successful, the function receives the userspace port mapper pid
@@ -468,7 +468,7 @@ static const struct nla_policy resp_add_policy[IWPM_NLA_RMANAGE_MAPPING_MAX] = {
 /**
  * iwpm_add_mapping_cb - Process the port mapper response to
  *                       iwpm_add_mapping request
- * @skb:
+ * @skb: The socket buffer
  * @cb: Contains the received message (payload and netlink header)
  */
 int iwpm_add_mapping_cb(struct sk_buff *skb, struct netlink_callback *cb)
@@ -545,7 +545,7 @@ static const struct nla_policy resp_query_policy[IWPM_NLA_RQUERY_MAPPING_MAX] =
 /**
  * iwpm_add_and_query_mapping_cb - Process the port mapper response to
  *                                 iwpm_add_and_query_mapping request
- * @skb:
+ * @skb: The socket buffer
  * @cb: Contains the received message (payload and netlink header)
  */
 int iwpm_add_and_query_mapping_cb(struct sk_buff *skb,
@@ -627,7 +627,7 @@ int iwpm_add_and_query_mapping_cb(struct sk_buff *skb,
 /**
  * iwpm_remote_info_cb - Process remote connecting peer address info, which
  *                       the port mapper has received from the connecting peer
- * @skb:
+ * @skb: The socket buffer
  * @cb: Contains the received message (payload and netlink header)
  *
  * Stores the IPv4/IPv6 address info in a hash table
@@ -706,7 +706,7 @@ static const struct nla_policy resp_mapinfo_policy[IWPM_NLA_MAPINFO_REQ_MAX] = {
 /**
  * iwpm_mapping_info_cb - Process a notification that the userspace
  *                        port mapper daemon is started
- * @skb:
+ * @skb: The socket buffer
  * @cb: Contains the received message (payload and netlink header)
  *
  * Using the received port mapper pid, send all the local mapping
@@ -766,7 +766,7 @@ static const struct nla_policy ack_mapinfo_policy[IWPM_NLA_MAPINFO_NUM_MAX] = {
 /**
  * iwpm_ack_mapping_info_cb - Process the port mapper ack for
  *                            the provided local mapping info records
- * @skb:
+ * @skb: The socket buffer
  * @cb: Contains the received message (payload and netlink header)
  */
 int iwpm_ack_mapping_info_cb(struct sk_buff *skb, struct netlink_callback *cb)
@@ -796,7 +796,7 @@ static const struct nla_policy map_error_policy[IWPM_NLA_ERR_MAX] = {
 /**
  * iwpm_mapping_error_cb - Process port mapper notification for error
  *
- * @skb:
+ * @skb: The socket buffer
  * @cb: Contains the received message (payload and netlink header)
  */
 int iwpm_mapping_error_cb(struct sk_buff *skb, struct netlink_callback *cb)
@@ -841,7 +841,7 @@ static const struct nla_policy hello_policy[IWPM_NLA_HELLO_MAX] = {
 /**
  * iwpm_hello_cb - Process a hello message from iwpmd
  *
- * @skb:
+ * @skb: The socket buffer
  * @cb: Contains the received message (payload and netlink header)
  *
  * Using the received port mapper pid, send the kernel's abi_version
-- 
2.25.1

