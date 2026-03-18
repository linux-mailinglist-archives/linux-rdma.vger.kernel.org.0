Return-Path: <linux-rdma+bounces-18335-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIW0C4nBumm6bgIAu9opvQ
	(envelope-from <linux-rdma+bounces-18335-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:15:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E37D2BDFD2
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB2BF32D81B1
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 15:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E965E3ED5DA;
	Wed, 18 Mar 2026 15:03:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C91F3EBF3F
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846211; cv=none; b=Txmv362Xz30bHWnOvDzRD01MneLU3x6s5doAKPlBBynE+dzScTJqOcdMRjqhl/CvS6SOPBH+ExZAHkitGP8nytl5gUT4ygJUDNSWcQshItPnUqirckXwNTOK2CytVtqZxC2gWhH5N44oGcgXbLD+xY5COy1dKBIso25KjbsTwFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846211; c=relaxed/simple;
	bh=sVd8LTVEHoLKFD1aY4N3BnWCDAMnZxFR8UMGpqAS4sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UvpUOchoTzR02vW98C78kw3akPOBNTypNybwMRe5Grx3bhghlrOKZFxYxd0ro/FKuwJg3UGuWpdulKRJuU/iDZCjnXxwmOdx0Rg0V2LXjG5I0gZMF/m6ckGSOF1rU+dWI9L+TNB0rvQ3iucMeSiUWWGpy0RsI3C6gLOSm6w6DQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c0bcd8f194so5425482eec.1
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 08:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773846207; x=1774451007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S2Eshwmt0Yi5gowTBPApYQhLiCclUhxDbq8BJfNjYyM=;
        b=QOtTwCKLInjePwjthmuczbPe427bCGW0zgmKiabxmSs06Wg1rAP4L1n2EASAWr4YHn
         oWWC22LG3rfs/1ysd4S5h4fO2OF3/enVIucLFmnfZ0tasAKgEriJWSYYYmU9shxDNpde
         XGRuQWEz6+tuMNKFZtr1bvO96SsRr8VXCz+Pjxd2gTeqBHe7DN9Bdir3ffj7eb+EB455
         OJRuJX+G8rb/egXF2g8Hh3dcMJ57VOVhxSJywBrvMkXN7ndr1AFtk2s9HF+5aET+IA51
         xu8SpgsjT+muQg2AQ5MmXRdDOXhwsMncMzZyj1+I/lt+ad+8dcqXKHzAC4xhPz4cLFK5
         HIDA==
X-Forwarded-Encrypted: i=1; AJvYcCXegex2tfkhW9vBmzDqxB2msRJlx5FxNPulQ8Ievq5S1iRIpKk+4Qdq/YiM2EDyMWHR263+uYL+IPX5@vger.kernel.org
X-Gm-Message-State: AOJu0YxqmHfOV38UVs6PdKC21wpiJ9KE1YbA0g9guqSkRC2y8hQ4KrMa
	zr6ZG6mNer90sWHHCUag5eAXWp7OaXcMB2vgqyZftAse6gZs4wzsiqI=
X-Gm-Gg: ATEYQzx1CwUDTf5TYzP5Pi3jT7gHN2sZpOc2+HfZQcogiWE5DkM5qtsuKt/DaU1A/fm
	NauAzp5eWh1/wvjpWxsl11tlYAMn6mWOal5O7pjdyuCbSs+ItAYBLUHz5PGhotZcPY0gKQ63ec6
	W7hK/HHcfpAUwZMdTJv/C2Ge9yQdQQNMJTuM6NGz7RYhO8auBaTJUVMkMuvcC4rT3tKTRFDIqJO
	sfppFughEbliGpzgMsrLeTuyzXYxNb0k5G8+pYc8OPVlCg4WiAztYGvOqlGz6PUpuySvwj/k9Fb
	WhBISUNjKrx5QY/1+bi8n4ftz3I61R+8326XQXETncvrw8H8UCd7YxMp9jfpx4s8rcZTHvbXQKP
	XbANz9zGMT2fVcIoZAgmAlXBBsINSG/bMggKgIqur7oBX5ofZO+nHDXWIKTAoNCHbb0vrciVSTP
	z06Rmd1q+PqsQXMMSMM/gpIZAi6wvMweI2dxXxVKjdl2vrPyzatrmfqd8Y6PBzUYRV2NnpczJ+O
	qa23VVjWWywCRb/wg==
X-Received: by 2002:a05:7300:fb97:b0:2ba:a3f2:958c with SMTP id 5a478bee46e88-2c0e4dc3156mr1648308eec.0.1773846207075;
        Wed, 18 Mar 2026 08:03:27 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e55cd9cfsm3997754eec.26.2026.03.18.08.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:03:26 -0700 (PDT)
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
Subject: [PATCH net-next v2 12/13] net: warn ops-locked drivers still using ndo_set_rx_mode
Date: Wed, 18 Mar 2026 08:03:04 -0700
Message-ID: <20260318150305.123900-13-sdf@fomichev.me>
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
	TAGGED_FROM(0.00)[bounces-18335-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,linux-rdma@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.055];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: 8E37D2BDFD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that all in-tree ops-locked drivers have been converted to
ndo_set_rx_mode_async, add a warning in register_netdevice to catch
any remaining or newly added drivers that use ndo_set_rx_mode with
ops locking. This ensures future driver authors are guided toward
the async path.

Also route ops-locked devices through dev_rx_mode_work even if they
lack rx_mode NDOs, to ensure netdev_ops_assert_locked() does not fire
on the legacy path where only RTNL is held.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/dev.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index d50d6dc6ac1f..187cd7b5074f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9778,7 +9778,8 @@ void __dev_set_rx_mode(struct net_device *dev)
 	if (!netif_up_and_present(dev))
 		return;
 
-	if (ops->ndo_set_rx_mode_async || ops->ndo_change_rx_flags) {
+	if (ops->ndo_set_rx_mode_async || ops->ndo_change_rx_flags ||
+	    netdev_need_ops_lock(dev)) {
 		queue_work(rx_mode_wq, &dev->rx_mode_work);
 		return;
 	}
@@ -11470,6 +11471,11 @@ int register_netdevice(struct net_device *dev)
 		goto err_uninit;
 	}
 
+	if (netdev_need_ops_lock(dev) &&
+	    dev->netdev_ops->ndo_set_rx_mode &&
+	    !dev->netdev_ops->ndo_set_rx_mode_async)
+		netdev_WARN(dev, "ops-locked drivers should use ndo_set_rx_mode_async\n");
+
 	ret = netdev_do_alloc_pcpu_stats(dev);
 	if (ret)
 		goto err_uninit;
-- 
2.53.0


