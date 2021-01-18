Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA7A2FAD63
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 23:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388916AbhARWlU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 17:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388639AbhARWk5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 17:40:57 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49A3C061786
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:38 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q18so17936520wrn.1
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2zCFxNxC1849c1rWm6WspmEg7y5zlYGUnMSic9ZfnKc=;
        b=LflVijOPHoSSIlKgkVZiZW3Hc8wVCelYr3w5fn3OGARaCQRsIGeckBPvOnPvrOWaIk
         M5sCZrm3fkOqPBHCZUXWk8/h77OxwK0B5zKS5/bqw3ShNpdCbShRIV8i/DwFp7I84Icx
         OFD2zMxCZNfipwxFt7sz2AzxMxP1l3uCO7yTrw1WMWyPbfUkxaFb7aMqDwwXExd+ejLj
         Ysn6xEE5Qql9qCeW8HJJRTPpJ3KL5eZA3bf49a54+twBJuk73hnQtH/srwgZ0FLp6zu1
         D9NtIN1c+/xiYVDpndXgHHjAgN6Z4sdqRW033JPL3Qm7C4U2R7agL17E8XFLWfFhNqd5
         rOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2zCFxNxC1849c1rWm6WspmEg7y5zlYGUnMSic9ZfnKc=;
        b=E0e/bjrcNQBAYjYT1sN0ddZkPTQqzKrJe4KqNhOk6+MaRhtF+XZxkPShLn0r8jYllH
         WGEGRUfz48i1WRjJ/tO8EZVWfqbBTaLCBEr1BWkm6K9rxIfKq9c52vL6DAMH3QtIm5c3
         2MWIyi/VT+/yNdkLbPL0dKf3afM73ae4CxKRtVAP/BjQnzrtKyrExvkGmQW6UwilOnvs
         3jUr4ZyNb1iyGINhQxYvD1dzssZ3GRaatIZ/T5IoBsDJ/XAeu/++lJxcaJcZCCv4G8vA
         dlQ3ZZuoSiFvxaBqy/GiGE0b6bTpGFtxA7TZmVANQ3SWEZXpqKi8Ad/C+lPz2bBHIRdn
         aiow==
X-Gm-Message-State: AOAM532Y9STgki43Orvm22c+ramma+nDmwH5lBBhwjMUDfByCzFVKDZd
        zz2Qj8h2gm18qB/nrgrUi39z0w==
X-Google-Smtp-Source: ABdhPJyBs23FfpBTJdohr+eiQsr283xaDs8nkxlG8Zkp1P6jeJLNmfjSumGo/JfYdhy/mcTAR3ilrQ==
X-Received: by 2002:adf:dc8d:: with SMTP id r13mr1422006wrj.325.1611009577630;
        Mon, 18 Jan 2021 14:39:37 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id l1sm33255902wrq.64.2021.01.18.14.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:39:37 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 04/20] RDMA/hw/i40iw/i40iw_cm: Fix a bunch of function documentation issues
Date:   Mon, 18 Jan 2021 22:39:13 +0000
Message-Id: <20210118223929.512175-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118223929.512175-1-lee.jones@linaro.org>
References: <20210118223929.512175-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/i40iw/i40iw_cm.c:76: warning: Function parameter or member 'bufp' not described in 'i40iw_free_sqbuf'
 drivers/infiniband/hw/i40iw/i40iw_cm.c:76: warning: Excess function parameter 'buf' description in 'i40iw_free_sqbuf'
 drivers/infiniband/hw/i40iw/i40iw_cm.c:737: warning: Function parameter or member 'start_addr' not described in 'i40iw_build_mpa_v1'
 drivers/infiniband/hw/i40iw/i40iw_cm.c:1059: warning: Function parameter or member 'cm_node' not described in 'i40iw_schedule_cm_timer'
 drivers/infiniband/hw/i40iw/i40iw_cm.c:1211: warning: Function parameter or member 't' not described in 'i40iw_cm_timer_tick'
 drivers/infiniband/hw/i40iw/i40iw_cm.c:1211: warning: Excess function parameter 'pass' description in 'i40iw_cm_timer_tick'
 drivers/infiniband/hw/i40iw/i40iw_cm.c:1475: warning: Function parameter or member 'vlan_id' not described in 'i40iw_find_listener'
 drivers/infiniband/hw/i40iw/i40iw_cm.c:1527: warning: Function parameter or member 'port' not described in 'i40iw_find_port'
 drivers/infiniband/hw/i40iw/i40iw_cm.c:1527: warning: Excess function parameter 'accelerated_list' description in 'i40iw_find_port'
 drivers/infiniband/hw/i40iw/i40iw_cm.c:1843: warning: Function parameter or member 'listener' not described in 'i40iw_dec_refcnt_listen'
 drivers/infiniband/hw/i40iw/i40iw_cm.c:2037: warning: Function parameter or member 'src_addr' not described in 'i40iw_get_dst_ipv6'
 drivers/infiniband/hw/i40iw/i40iw_cm.c:2037: warning: Function parameter or member 'dst_addr' not described in 'i40iw_get_dst_ipv6'
 drivers/infiniband/hw/i40iw/i40iw_cm.c:2061: warning: Function parameter or member 'src' not described in 'i40iw_addr_resolve_neigh_ipv6'
 drivers/infiniband/hw/i40iw/i40iw_cm.c:2061: warning: Function parameter or member 'dest' not described in 'i40iw_addr_resolve_neigh_ipv6'
 drivers/infiniband/hw/i40iw/i40iw_cm.c:2061: warning: Excess function parameter 'dst_ip' description in 'i40iw_addr_resolve_neigh_ipv6'
 drivers/infiniband/hw/i40iw/i40iw_cm.c:3011: warning: Function parameter or member 'pdata' not described in 'i40iw_cm_reject'
 drivers/infiniband/hw/i40iw/i40iw_cm.c:3011: warning: Excess function parameter 'pdate' description in 'i40iw_cm_reject'
 drivers/infiniband/hw/i40iw/i40iw_cm.c:4312: warning: Function parameter or member 'nfo' not described in 'i40iw_cm_teardown_connections'
 drivers/infiniband/hw/i40iw/i40iw_cm.c:4312: warning: Excess function parameter 'ipv4' description in 'i40iw_cm_teardown_connections'
 drivers/infiniband/hw/i40iw/i40iw_cm.c:4367: warning: Function parameter or member 'netdev' not described in 'i40iw_if_notify'

Cc: Faisal Latif <faisal.latif@intel.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/i40iw/i40iw_cm.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
index 9acc0ecc9a43e..ac65c8237b2ed 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -70,7 +70,7 @@ static void i40iw_disconnect_worker(struct work_struct *work);
 /**
  * i40iw_free_sqbuf - put back puda buffer if refcount = 0
  * @vsi: pointer to vsi structure
- * @buf: puda buffer to free
+ * @bufp: puda buffer to free
  */
 void i40iw_free_sqbuf(struct i40iw_sc_vsi *vsi, void *bufp)
 {
@@ -729,6 +729,7 @@ static int i40iw_handle_tcp_options(struct i40iw_cm_node *cm_node,
 /**
  * i40iw_build_mpa_v1 - build a MPA V1 frame
  * @cm_node: connection's node
+ * @start_addr: MPA frame start address
  * @mpa_key: to do read0 or write0
  */
 static void i40iw_build_mpa_v1(struct i40iw_cm_node *cm_node,
@@ -1040,7 +1041,7 @@ static int i40iw_parse_mpa(struct i40iw_cm_node *cm_node, u8 *buffer, u32 *type,
 
 /**
  * i40iw_schedule_cm_timer
- * @@cm_node: connection's node
+ * @cm_node: connection's node
  * @sqbuf: buffer to send
  * @type: if it is send or close
  * @send_retrans: if rexmits to be done
@@ -1205,7 +1206,7 @@ static void i40iw_build_timer_list(struct list_head *timer_list,
 
 /**
  * i40iw_cm_timer_tick - system's timer expired callback
- * @pass: Pointing to cm_core
+ * @t: Timer instance to fetch the cm_core pointer from
  */
 static void i40iw_cm_timer_tick(struct timer_list *t)
 {
@@ -1463,6 +1464,7 @@ struct i40iw_cm_node *i40iw_find_node(struct i40iw_cm_core *cm_core,
  * @cm_core: cm's core
  * @dst_port: listener tcp port num
  * @dst_addr: listener ip addr
+ * @vlan_id: vlan id for the given address
  * @listener_state: state to match with listen node's
  */
 static struct i40iw_cm_listener *i40iw_find_listener(
@@ -1521,7 +1523,7 @@ static void i40iw_add_hte_node(struct i40iw_cm_core *cm_core,
 /**
  * i40iw_find_port - find port that matches reference port
  * @hte: ptr to accelerated or non-accelerated list
- * @accelerated_list: flag for accelerated vs non-accelerated list
+ * @port: port number to locate
  */
 static bool i40iw_find_port(struct list_head *hte, u16 port)
 {
@@ -1834,6 +1836,7 @@ static enum i40iw_status_code i40iw_add_mqh_4(
 /**
  * i40iw_dec_refcnt_listen - delete listener and associated cm nodes
  * @cm_core: cm's core
+ * @listener: passive connection's listener
  * @free_hanging_nodes: to free associated cm_nodes
  * @apbvt_del: flag to delete the apbvt
  */
@@ -2029,7 +2032,7 @@ static int i40iw_addr_resolve_neigh(struct i40iw_device *iwdev,
 	return rc;
 }
 
-/**
+/*
  * i40iw_get_dst_ipv6
  */
 static struct dst_entry *i40iw_get_dst_ipv6(struct sockaddr_in6 *src_addr,
@@ -2051,7 +2054,8 @@ static struct dst_entry *i40iw_get_dst_ipv6(struct sockaddr_in6 *src_addr,
 /**
  * i40iw_addr_resolve_neigh_ipv6 - resolve neighbor ipv6 address
  * @iwdev: iwarp device structure
- * @dst_ip: remote ip address
+ * @src: source ip address
+ * @dest: remote ip address
  * @arpindex: if there is an arp entry
  */
 static int i40iw_addr_resolve_neigh_ipv6(struct i40iw_device *iwdev,
@@ -3004,7 +3008,7 @@ static struct i40iw_cm_node *i40iw_create_cm_node(
 /**
  * i40iw_cm_reject - reject and teardown a connection
  * @cm_node: connection's node
- * @pdate: ptr to private data for reject
+ * @pdata: ptr to private data for reject
  * @plen: size of private data
  */
 static int i40iw_cm_reject(struct i40iw_cm_node *cm_node, const void *pdata, u8 plen)
@@ -4302,7 +4306,7 @@ static void i40iw_qhash_ctrl(struct i40iw_device *iwdev,
  * i40iw_cm_teardown_connections - teardown QPs
  * @iwdev: device pointer
  * @ipaddr: Pointer to IPv4 or IPv6 address
- * @ipv4: flag indicating IPv4 when true
+ * @nfo: cm info node
  * @disconnect_all: flag indicating disconnect all QPs
  * teardown QPs where source or destination addr matches ip addr
  */
@@ -4358,6 +4362,7 @@ void i40iw_cm_teardown_connections(struct i40iw_device *iwdev, u32 *ipaddr,
 /**
  * i40iw_ifdown_notify - process an ifdown on an interface
  * @iwdev: device pointer
+ * @netdev: network interface device structure
  * @ipaddr: Pointer to IPv4 or IPv6 address
  * @ipv4: flag indicating IPv4 when true
  * @ifup: flag indicating interface up when true
-- 
2.25.1

