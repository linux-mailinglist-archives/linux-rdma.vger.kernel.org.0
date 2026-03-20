Return-Path: <linux-rdma+bounces-18422-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ei0N+qivGkI1wIAu9opvQ
	(envelope-from <linux-rdma+bounces-18422-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 02:29:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFC82D4C29
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 02:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 241B7306EC8A
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 01:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E127E31E821;
	Fri, 20 Mar 2026 01:25:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8B03101A6
	for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 01:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773969921; cv=none; b=Uaru7RVaoHiRHcLrs1tqZQPHC74qn0ZyygSz3WEJWPtV6Vciv8fHGEVb8KiKjniEjkaU4zgaQ7d5CvsNhgmEx9j/Iwt7VqTYQyQDlMrdteX22XdDPf9Zfnlrm1zGI+Rz3Na27jiNA6fvohwIdDTJAJ/7vgDbg8zmP3zcDaEHnjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773969921; c=relaxed/simple;
	bh=VK90M3+EGSzjVfsemFKOmNIILll+ZAdpTFJtqe6Y2Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xu33Xj9xTvy/nD32dVfSNDwrDM1jnKeJmYNvikgldCbbW8paBDxf5MbhBTb7FTZq7wiUQKHU1UMXEwJtHoyOYY5D6K/CJebIVGFsZHfmlT50RGzSk8IYwzrOxT+Zl8ihfWu8tS/P0DHEIQSx03VuDuAddy5gswEJlpLm+EddQQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-128b9b7e3edso2688609c88.0
        for <linux-rdma@vger.kernel.org>; Thu, 19 Mar 2026 18:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773969918; x=1774574718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LWBQoO52uK1jdWWUCzjHOfQ7E5wdgkDdRoNSlPpZPUc=;
        b=HeW15ZyYRcmXwmBYYyOj+Y+sUQ0ZWMYLtQALGbMwbQG5ezKwgHpzKI9bc4IIdEzO/G
         B6+Mfb/8rLWocIIWoBZh2ZsOxskNrIhvUzG9QZ1pSOZ0heIv3y178o3SXHF6oDiq7xKL
         bCEaqaZIBIdbc83bDPcX+Taf2daLK7xendV7ODBRfi6r1aSeWQtUcbFxm6pP20jlzOt+
         aDm6J19Tf7WNgdcd+x42vsq9JaATfUMti5sr81KYa+xyHm6+WauEFSNMMk/OybqVgLxA
         xOfaiiPBEpG+By6qJxnFDW7wa9L+0rvaX5YxqCgQDzIJlRzV23h6GfqouFIazct9nHLg
         Mj+A==
X-Forwarded-Encrypted: i=1; AJvYcCW7os4CzgR2sKhAD/6njlgyAlEX74LA6rdphggN7MlQq5S2P5H6VuoO+OKzAREcYReYKboI9JX1WBje@vger.kernel.org
X-Gm-Message-State: AOJu0YyiEAgIRgSkLR8mBR9k7ONUp//BOy2/6u/qxATzeYn6DMC7Rbrh
	6+B2Clx0z3CNM2Jqkor2ocAW/CHQ5Ck+sH36sEqzKkN1qkQaT8Opes4=
X-Gm-Gg: ATEYQzxvxEqfdU1sW1SlFAFDy+sWBTeoeAV1Q6YpYHoTFyHYWBNDY93KuOm1FH0kfxY
	awC9bl48O+pqOLyO8dtnPgSNjtweeLsz8RA1BV2NSiQagWNbnH2DixmnIykGUU9kPR7O0PZykBL
	JPBJDqbD3y8D0VpIskK3O+EVBFHsfRkxE5xi9O/Jsh30kjMRnBEKTW/QIkv2nCJZS+Bux3t7DWG
	+NmoCikEjTgjeis0e+Ts0V7sjEzr/WMGt99yn6v825aVXSHzrLT0R5rylAODhjGS6rER1zySrCY
	J1uxh5WO+7G8UBKVi1gJTwXebYCSvfi4t6oJbpkV94Cr4vcd4d+kKbTiqVxAvpgn+dru8qo1l09
	GDy/jycHG7SJLvTnZMInhEFUURbCq868iDOmAHcMQKKsh+GqaNoAdWS2seP2TbWBM+tGH9CABgd
	M9vKWL/6C2+p4lruO5WQ/qxSOHABd3HqaJiHktZaXpyW7Zy3dikBXiMYFDext/wA2mUcftt7LsU
	WFivuvre9pD5jOcNQ==
X-Received: by 2002:a05:7022:e08:b0:128:d737:d7a6 with SMTP id a92af1059eb24-12a7266cdddmr651698c88.3.1773969917836;
        Thu, 19 Mar 2026 18:25:17 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a734bbbc5sm747251c88.11.2026.03.19.18.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 18:25:17 -0700 (PDT)
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
	aleksandr.loktionov@intel.com,
	kees@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v3 12/13] net: warn ops-locked drivers still using ndo_set_rx_mode
Date: Thu, 19 Mar 2026 18:25:00 -0700
Message-ID: <20260320012501.2033548-13-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320012501.2033548-1-sdf@fomichev.me>
References: <20260320012501.2033548-1-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18422-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,linux-rdma@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.067];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: 7DFC82D4C29
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
index fc5c9b14faa0..f38ab254708b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9779,7 +9779,8 @@ void __dev_set_rx_mode(struct net_device *dev)
 	if (!netif_up_and_present(dev))
 		return;
 
-	if (ops->ndo_set_rx_mode_async || ops->ndo_change_rx_flags) {
+	if (ops->ndo_set_rx_mode_async || ops->ndo_change_rx_flags ||
+	    netdev_need_ops_lock(dev)) {
 		queue_work(rx_mode_wq, &dev->rx_mode_work);
 		return;
 	}
@@ -11471,6 +11472,11 @@ int register_netdevice(struct net_device *dev)
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


