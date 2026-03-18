Return-Path: <linux-rdma+bounces-18332-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BtvMEbBumkGbgIAu9opvQ
	(envelope-from <linux-rdma+bounces-18332-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:14:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 310252BDF86
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CC923288A36
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 15:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2833EC2E9;
	Wed, 18 Mar 2026 15:03:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C813E714F
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846207; cv=none; b=I3dz7IWwtcMUtC6exswiOAzz14Acs0QNarSJDp+Ptoayv/0I9o+Hr9Wgvu/L/rzpi37PO9ABWg41RePuoqni12n3lPsDrJ+S4K7pNQ5Qr9WjvrEV2HPEAx5UCfP79XkmMH+EOGiC54DtD9fkUkYJKVUb6FJhPI2bOs7ID1MIpbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846207; c=relaxed/simple;
	bh=tpq4CPEg4PF7xY4vX/qaHiEsjc2ICDqk3bHyi4H6/ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8l3a3AuSIjDsx8bRKGrhoMNbTB0e+XcMPlx9PdfE5ldJGF2HaD49xuT19wJ/QxNqZ9tCNvCVwJOiSON2kjha7IaHZTiBEIqQ1wyNNQMBmoWmghBGR9m4bw3k2yUXV9ipraosUt93xJf9DDOdhcW2x34bjERY+TKtnhnOVxQQkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c0bdf1988cso41614eec.1
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 08:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773846204; x=1774451004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZI1/cLnyDnVOs4qvF1/y00bhWF98dmH7Q3P7jVrTCz8=;
        b=kvFQ3pXWdGOR/1YEUMD4bISspNa7WHeFgpT0rDbeenr5HrHzY2dU3+vmiDMiewwviU
         J0tPnpltIL5rRZ2cGNa5/PYLn0JZlklfFyDEqEMJ1Ce/v42YOkQF5QInVvDhsojz1ofz
         Su1zgEotR7mSwwX9f3k0kZMXQBqWErzEiL+7tt9ZWdmMopiibSjviFbtwbibxs35az59
         1BJodEpTmuc3fRqgdOc85ZGancwzItYLD6DdH/wUvP/3pZKdAjFPWEISGIQf1VbMe6pR
         sxx+IBrSkMzzCdKntUlYJxdILgvsmixiPehDIwrNFT6ERFGVVQo9BGgkjhl5n8BdAX1s
         Zkig==
X-Forwarded-Encrypted: i=1; AJvYcCUXaUNCKFVw1jNhPGuwxxdyYb0aLl+Dfd0qaeAFO6D9pkBoPHI3AzmE4nISGtAuEQq5byqdpISwjdPk@vger.kernel.org
X-Gm-Message-State: AOJu0YxQOnEByhyy3QDwTERVoxTFpKsU2bfY/Y8daRhkUFx+aF0V5s4B
	qiMQOUmFTlS/8D6lPoVB4TcGbqbwBYs1F2f8Lm+5WhkzsljodKQ3SGk=
X-Gm-Gg: ATEYQzwVD/94AITnKg2fc578lvitnxeJ1amfwXMC+QpDKeJlJfmRLqDqIjcwSsXlnz3
	xWTXktM25FSP8oUeGt7FWqNGsgHadAeyELKo3x516kZ/pGPRtpvXMPFkw8fNMj+NV+sNGb1hgZI
	zTapF3YODoMWJb2zI75NwryN3SDkThK1sFbj7n/NcPMNcypVRa6v4ZYMfaI1kmaUTbPyiNQ/uf1
	LdApM4wbX6eg5Z2QjC6itho3/HH30qPgeyxoU04G/1I2hmE6tUrlKSPvEbFCgxxciIMKlhhZdh9
	oAkw8vLDPAVnvyCA8XfpH2McQpFZBVSxZzDCPO2bCppu+yHnU3WQOp/SwTk+lbdXX/ZbyxSc4Ly
	8BjGSmKv0njBUiCwuwR7IIm4loMEGJyh98g4FcT38t4oCm648qzrVyNz+cn5/9JTgSr93YT3fJt
	8DY730p7vT1EjZpmCzfOqPgubdwmjBNdO+Kp3xanqsTOuZttn8DhAK/N4AyiyIzTFQOLQw9F498
	9ymLIy8Xxhnv+oO3g==
X-Received: by 2002:a05:7300:3724:b0:2be:126c:e335 with SMTP id 5a478bee46e88-2c0e5011ac8mr1873924eec.10.1773846202672;
        Wed, 18 Mar 2026 08:03:22 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e56062e4sm4123423eec.30.2026.03.18.08.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:03:22 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	johannes@sipsolutions.net,
	sd@queasysnail.net,
	jianbol@nvidia.com,
	dtatulea@nvidia.com,
	sdf@fomichev.me,
	mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com,
	willemb@google.com,
	skhawaja@google.com,
	bestswngs@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v2 09/13] iavf: convert to ndo_set_rx_mode_async
Date: Wed, 18 Mar 2026 08:03:01 -0700
Message-ID: <20260318150305.123900-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318150305.123900-1-sdf@fomichev.me>
References: <20260318150305.123900-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18332-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,linux-rdma@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.044];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: 310252BDF86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert iavf from ndo_set_rx_mode to ndo_set_rx_mode_async.
iavf_set_rx_mode now takes explicit uc/mc list parameters and
uses __hw_addr_sync_dev on the snapshots instead of __dev_uc_sync
and __dev_mc_sync.

The iavf_configure internal caller passes the real lists directly.

Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 7925ee152c76..6632d35ad0fe 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1147,14 +1147,18 @@ bool iavf_promiscuous_mode_changed(struct iavf_adapter *adapter)
 /**
  * iavf_set_rx_mode - NDO callback to set the netdev filters
  * @netdev: network interface device structure
+ * @uc: snapshot of uc address list
+ * @mc: snapshot of mc address list
  **/
-static void iavf_set_rx_mode(struct net_device *netdev)
+static void iavf_set_rx_mode(struct net_device *netdev,
+			     struct netdev_hw_addr_list *uc,
+			     struct netdev_hw_addr_list *mc)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
-	__dev_uc_sync(netdev, iavf_addr_sync, iavf_addr_unsync);
-	__dev_mc_sync(netdev, iavf_addr_sync, iavf_addr_unsync);
+	__hw_addr_sync_dev(uc, netdev, iavf_addr_sync, iavf_addr_unsync);
+	__hw_addr_sync_dev(mc, netdev, iavf_addr_sync, iavf_addr_unsync);
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
 	spin_lock_bh(&adapter->current_netdev_promisc_flags_lock);
@@ -1207,7 +1211,7 @@ static void iavf_configure(struct iavf_adapter *adapter)
 	struct net_device *netdev = adapter->netdev;
 	int i;
 
-	iavf_set_rx_mode(netdev);
+	iavf_set_rx_mode(netdev, &netdev->uc, &netdev->mc);
 
 	iavf_configure_tx(adapter);
 	iavf_configure_rx(adapter);
@@ -5150,7 +5154,7 @@ static const struct net_device_ops iavf_netdev_ops = {
 	.ndo_open		= iavf_open,
 	.ndo_stop		= iavf_close,
 	.ndo_start_xmit		= iavf_xmit_frame,
-	.ndo_set_rx_mode	= iavf_set_rx_mode,
+	.ndo_set_rx_mode_async	= iavf_set_rx_mode,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address	= iavf_set_mac,
 	.ndo_change_mtu		= iavf_change_mtu,
-- 
2.53.0


