Return-Path: <linux-rdma+bounces-9392-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7F4A87A41
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 10:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68ED016BA7B
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 08:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A6025B680;
	Mon, 14 Apr 2025 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B1wF07bv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aAvjZvWQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4265259C89;
	Mon, 14 Apr 2025 08:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744619178; cv=none; b=iCRRtrYL5KFFynBZlGbUwpaUy1dDDZQxzaiydH9vyNl8bh15Io7zUT8KKHmD0nu51wGPD4KtVcWsAOJLQQSp/TIS3myU9XqPpzbjWbET8dSaE4sbgJxrXJv9O+K9tVZ+ElA8/VqRC7SwFx2ULS9/cw82sJ0hW3pPZe3fKQt3F8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744619178; c=relaxed/simple;
	bh=N/qUK7b3kqG/PeaVXc+zcRtDAqWNiDEns1dzZwwdE6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fPSDub52zVJ0fLsEfLSxsCAEgGUBKUgTzAAWwyVATkVxLQJ4I/dLXkhWSBYf62kMHYY96tXqA20AIrdCNite/DWaEEogULZ1nO8yBlGrWYX4gKGJakmolUF1KkMH7pr1ZR8/b9WDRIkQhI9fDyRIrU3q5SibKfneAGZxZc11IL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B1wF07bv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aAvjZvWQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744619174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/D/QgtajVBVVkamPNbk0lFCxgnZU4CB8WAvmqRFNxRE=;
	b=B1wF07bv7kbY+rQHwaxtCv9duZAYF1lGOe0BOYcxtFUywblPW9rN8KbBkOu8wkj2F38mbF
	NYdqd/6KSujva7Q2qgRz2Y2bqEYVmB/bkF61FsusHnCO39HPMkZHpHr8ZrIam5uFPWscWO
	X0tD+Ogrzn2tgmviErYDbMYz9xsBid3LokDlF62bCW4gZZ4EchfaXtZom2d84C5VhIfiIN
	IjA9HHwuA/sCQlJG7YycyMB00jfxiqw3R+c9uHLJLt6eZPHsMmXAbstCJXUbQFUZ4LlSwC
	YKXtIzIBotZGT5gpYlCZQpEZBvhIugt9EO5KjnvdHgTDXU7aGdK68y7DUbE4fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744619174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/D/QgtajVBVVkamPNbk0lFCxgnZU4CB8WAvmqRFNxRE=;
	b=aAvjZvWQMt3/VyO8nGZr7r8+5MVrfRjXmEWAXWHtTQAq+evZL2Yn7YsCFDkafcgGWX6l5Z
	lUWjuhiepCKehUDA==
Date: Mon, 14 Apr 2025 10:26:02 +0200
Subject: [PATCH net-next 1/7] wifi: ath10k: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250414-restricted-pointers-net-v1-1-12af0ce46cdd@linutronix.de>
References: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
In-Reply-To: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
To: Jeff Johnson <jjohnson@kernel.org>, 
 Loic Poulain <loic.poulain@linaro.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>
Cc: ath10k@lists.infradead.org, linux-kernel@vger.kernel.org, 
 ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
 wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-rdma@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744619172; l=16555;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=N/qUK7b3kqG/PeaVXc+zcRtDAqWNiDEns1dzZwwdE6Q=;
 b=TsfaN0+Qe0EpizvgQgNWJl4+chLsIlc3b5qTBy8ezKDu2Ym1XMt02hMbw+V7uoybLriseAHJo
 nIbTmQxMyIYB769HHWPh2n/IiLNlnqKBO7squxA5BVoSs6e20S7/oKk
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping looks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.
There are still a few users of %pK left, but these use it through seq_file,
for which its usage is safe.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 drivers/net/wireless/ath/ath10k/ahb.c      |  2 +-
 drivers/net/wireless/ath/ath10k/bmi.c      |  6 +++---
 drivers/net/wireless/ath/ath10k/ce.c       |  4 ++--
 drivers/net/wireless/ath/ath10k/core.c     |  4 ++--
 drivers/net/wireless/ath/ath10k/htc.c      |  6 +++---
 drivers/net/wireless/ath/ath10k/htt_rx.c   |  2 +-
 drivers/net/wireless/ath/ath10k/mac.c      | 22 +++++++++++-----------
 drivers/net/wireless/ath/ath10k/pci.c      |  2 +-
 drivers/net/wireless/ath/ath10k/testmode.c |  4 ++--
 drivers/net/wireless/ath/ath10k/txrx.c     |  2 +-
 drivers/net/wireless/ath/ath10k/usb.c      |  4 ++--
 drivers/net/wireless/ath/ath10k/wmi.c      |  4 ++--
 12 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ahb.c b/drivers/net/wireless/ath/ath10k/ahb.c
index db9f9ebcb62d20e5cdcf9e7b08f5ea23e0dc3d22..eb8b35b6224dbf2540013a4a066646ecc9a3db75 100644
--- a/drivers/net/wireless/ath/ath10k/ahb.c
+++ b/drivers/net/wireless/ath/ath10k/ahb.c
@@ -497,7 +497,7 @@ static int ath10k_ahb_resource_init(struct ath10k *ar)
 
 	ath10k_dbg(ar, ATH10K_DBG_BOOT, "irq: %d\n", ar_ahb->irq);
 
-	ath10k_dbg(ar, ATH10K_DBG_BOOT, "mem: 0x%pK mem_len: %lu gcc mem: 0x%pK tcsr_mem: 0x%pK\n",
+	ath10k_dbg(ar, ATH10K_DBG_BOOT, "mem: 0x%p mem_len: %lu gcc mem: 0x%p tcsr_mem: 0x%p\n",
 		   ar_ahb->mem, ar_ahb->mem_len,
 		   ar_ahb->gcc_mem, ar_ahb->tcsr_mem);
 	return 0;
diff --git a/drivers/net/wireless/ath/ath10k/bmi.c b/drivers/net/wireless/ath/ath10k/bmi.c
index 9a4f8e815412cba207f3a788013d362a36a02ac3..48efdc71d54dc699e1d43d01507a7a30c9c495b4 100644
--- a/drivers/net/wireless/ath/ath10k/bmi.c
+++ b/drivers/net/wireless/ath/ath10k/bmi.c
@@ -349,7 +349,7 @@ static int ath10k_bmi_lz_data_large(struct ath10k *ar, const void *buffer, u32 l
 	int ret;
 	size_t buf_len;
 
-	ath10k_dbg(ar, ATH10K_DBG_BMI, "large bmi lz data buffer 0x%pK length %d\n",
+	ath10k_dbg(ar, ATH10K_DBG_BMI, "large bmi lz data buffer 0x%p length %d\n",
 		   buffer, length);
 
 	if (ar->bmi.done_sent) {
@@ -395,7 +395,7 @@ int ath10k_bmi_lz_data(struct ath10k *ar, const void *buffer, u32 length)
 	u32 txlen;
 	int ret;
 
-	ath10k_dbg(ar, ATH10K_DBG_BMI, "bmi lz data buffer 0x%pK length %d\n",
+	ath10k_dbg(ar, ATH10K_DBG_BMI, "bmi lz data buffer 0x%p length %d\n",
 		   buffer, length);
 
 	if (ar->bmi.done_sent) {
@@ -461,7 +461,7 @@ int ath10k_bmi_fast_download(struct ath10k *ar,
 	int ret;
 
 	ath10k_dbg(ar, ATH10K_DBG_BMI,
-		   "bmi fast download address 0x%x buffer 0x%pK length %d\n",
+		   "bmi fast download address 0x%x buffer 0x%p length %d\n",
 		   address, buffer, length);
 
 	ret = ath10k_bmi_lz_stream_start(ar, address);
diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
index afae4a8027f8338ad9fed64880fa16fed09f32e4..4fc81ae17a8af4816919400cd77061c5aa7f6c3a 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -1388,7 +1388,7 @@ static int ath10k_ce_init_src_ring(struct ath10k *ar,
 	ath10k_ce_src_ring_highmark_set(ar, ctrl_addr, nentries);
 
 	ath10k_dbg(ar, ATH10K_DBG_BOOT,
-		   "boot init ce src ring id %d entries %d base_addr %pK\n",
+		   "boot init ce src ring id %d entries %d base_addr %p\n",
 		   ce_id, nentries, src_ring->base_addr_owner_space);
 
 	return 0;
@@ -1426,7 +1426,7 @@ static int ath10k_ce_init_dest_ring(struct ath10k *ar,
 	ath10k_ce_dest_ring_highmark_set(ar, ctrl_addr, nentries);
 
 	ath10k_dbg(ar, ATH10K_DBG_BOOT,
-		   "boot ce dest ring id %d entries %d base_addr %pK\n",
+		   "boot ce dest ring id %d entries %d base_addr %p\n",
 		   ce_id, nentries, dest_ring->base_addr_owner_space);
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 6d336e39d6738bbe7973a25e073d03a07b9ae733..fe3a8f4a1cc1b774ce27112ef7dfe6adb0b4dc2f 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -1200,7 +1200,7 @@ static int ath10k_download_fw(struct ath10k *ar)
 	}
 
 	ath10k_dbg(ar, ATH10K_DBG_BOOT,
-		   "boot uploading firmware image %pK len %d\n",
+		   "boot uploading firmware image %p len %d\n",
 		   data, data_len);
 
 	/* Check if device supports to download firmware via
@@ -1826,7 +1826,7 @@ static int ath10k_download_and_run_otp(struct ath10k *ar)
 
 	if (!ar->running_fw->fw_file.otp_data ||
 	    !ar->running_fw->fw_file.otp_len) {
-		ath10k_warn(ar, "Not running otp, calibration will be incorrect (otp-data %pK otp_len %zd)!\n",
+		ath10k_warn(ar, "Not running otp, calibration will be incorrect (otp-data %p otp_len %zd)!\n",
 			    ar->running_fw->fw_file.otp_data,
 			    ar->running_fw->fw_file.otp_len);
 		return 0;
diff --git a/drivers/net/wireless/ath/ath10k/htc.c b/drivers/net/wireless/ath/ath10k/htc.c
index a6e21ce90bad64d91afee2b4f46bfbf136547cba..2da08dfebd3e7b56b149a09b5372aa0bfb8538d1 100644
--- a/drivers/net/wireless/ath/ath10k/htc.c
+++ b/drivers/net/wireless/ath/ath10k/htc.c
@@ -34,7 +34,7 @@ static struct sk_buff *ath10k_htc_build_tx_ctrl_skb(void *ar)
 	skb_cb = ATH10K_SKB_CB(skb);
 	memset(skb_cb, 0, sizeof(*skb_cb));
 
-	ath10k_dbg(ar, ATH10K_DBG_HTC, "%s: skb %pK\n", __func__, skb);
+	ath10k_dbg(ar, ATH10K_DBG_HTC, "%s: skb %p\n", __func__, skb);
 	return skb;
 }
 
@@ -54,7 +54,7 @@ void ath10k_htc_notify_tx_completion(struct ath10k_htc_ep *ep,
 	struct ath10k *ar = ep->htc->ar;
 	struct ath10k_htc_hdr *hdr;
 
-	ath10k_dbg(ar, ATH10K_DBG_HTC, "%s: ep %d skb %pK\n", __func__,
+	ath10k_dbg(ar, ATH10K_DBG_HTC, "%s: ep %d skb %p\n", __func__,
 		   ep->eid, skb);
 
 	/* A corner case where the copy completion is reaching to host but still
@@ -515,7 +515,7 @@ void ath10k_htc_rx_completion_handler(struct ath10k *ar, struct sk_buff *skb)
 		/* zero length packet with trailer data, just drop these */
 		goto out;
 
-	ath10k_dbg(ar, ATH10K_DBG_HTC, "htc rx completion ep %d skb %pK\n",
+	ath10k_dbg(ar, ATH10K_DBG_HTC, "htc rx completion ep %d skb %p\n",
 		   eid, skb);
 	ep->ep_ops.ep_rx_complete(ar, skb);
 
diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 83eab7479f0699513c2a08297f7dec2f00599340..52981052e211a0e23271779f8589618e0b9c8de4 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -1373,7 +1373,7 @@ static void ath10k_process_rx(struct ath10k *ar, struct sk_buff *skb)
 	}
 
 	ath10k_dbg(ar, ATH10K_DBG_DATA,
-		   "rx skb %pK len %u peer %pM %s %s sn %u %s%s%s%s%s%s %srate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
+		   "rx skb %p len %u peer %pM %s %s sn %u %s%s%s%s%s%s %srate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
 		   skb,
 		   skb->len,
 		   ieee80211_get_SA(hdr),
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index c61b95a928dac12fb9e11164fb45a53831f8de11..8c7ffea0fa44b5d3c03f2fd7191fb757a4966ad6 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -875,7 +875,7 @@ static void ath10k_peer_map_cleanup(struct ath10k *ar, struct ath10k_peer *peer)
 	 */
 	for (i = 0; i < ARRAY_SIZE(ar->peer_map); i++) {
 		if (ar->peer_map[i] == peer) {
-			ath10k_warn(ar, "removing stale peer_map entry for %pM (ptr %pK idx %d)\n",
+			ath10k_warn(ar, "removing stale peer_map entry for %pM (ptr %p idx %d)\n",
 				    peer->addr, peer, i);
 			ar->peer_map[i] = NULL;
 		}
@@ -4063,7 +4063,7 @@ static int ath10k_mac_tx(struct ath10k *ar,
 
 	if (!noque_offchan && info->flags & IEEE80211_TX_CTL_TX_OFFCHAN) {
 		if (!ath10k_mac_tx_frm_has_freq(ar)) {
-			ath10k_dbg(ar, ATH10K_DBG_MAC, "mac queued offchannel skb %pK len %d\n",
+			ath10k_dbg(ar, ATH10K_DBG_MAC, "mac queued offchannel skb %p len %d\n",
 				   skb, skb->len);
 
 			skb_queue_tail(&ar->offchan_tx_queue, skb);
@@ -4126,7 +4126,7 @@ void ath10k_offchan_tx_work(struct work_struct *work)
 
 		mutex_lock(&ar->conf_mutex);
 
-		ath10k_dbg(ar, ATH10K_DBG_MAC, "mac offchannel skb %pK len %d\n",
+		ath10k_dbg(ar, ATH10K_DBG_MAC, "mac offchannel skb %p len %d\n",
 			   skb, skb->len);
 
 		hdr = (struct ieee80211_hdr *)skb->data;
@@ -4181,7 +4181,7 @@ void ath10k_offchan_tx_work(struct work_struct *work)
 		time_left =
 		wait_for_completion_timeout(&ar->offchan_tx_completed, 3 * HZ);
 		if (time_left == 0)
-			ath10k_warn(ar, "timed out waiting for offchannel skb %pK, len: %d\n",
+			ath10k_warn(ar, "timed out waiting for offchannel skb %p, len: %d\n",
 				    skb, skb->len);
 
 		if (!peer && tmp_peer_created) {
@@ -7604,7 +7604,7 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 		 * Existing station deletion.
 		 */
 		ath10k_dbg(ar, ATH10K_DBG_STA,
-			   "mac vdev %d peer delete %pM sta %pK (sta gone)\n",
+			   "mac vdev %d peer delete %pM sta %p (sta gone)\n",
 			   arvif->vdev_id, sta->addr, sta);
 
 		if (sta->tdls) {
@@ -7631,7 +7631,7 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 				continue;
 
 			if (peer->sta == sta) {
-				ath10k_warn(ar, "found sta peer %pM (ptr %pK id %d) entry on vdev %i after it was supposedly removed\n",
+				ath10k_warn(ar, "found sta peer %pM (ptr %p id %d) entry on vdev %i after it was supposedly removed\n",
 					    sta->addr, peer, i, arvif->vdev_id);
 				peer->sta = NULL;
 
@@ -8811,7 +8811,7 @@ ath10k_mac_op_add_chanctx(struct ieee80211_hw *hw,
 	struct ath10k *ar = hw->priv;
 
 	ath10k_dbg(ar, ATH10K_DBG_MAC,
-		   "mac chanctx add freq %u width %d ptr %pK\n",
+		   "mac chanctx add freq %u width %d ptr %p\n",
 		   ctx->def.chan->center_freq, ctx->def.width, ctx);
 
 	mutex_lock(&ar->conf_mutex);
@@ -8835,7 +8835,7 @@ ath10k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
 	struct ath10k *ar = hw->priv;
 
 	ath10k_dbg(ar, ATH10K_DBG_MAC,
-		   "mac chanctx remove freq %u width %d ptr %pK\n",
+		   "mac chanctx remove freq %u width %d ptr %p\n",
 		   ctx->def.chan->center_freq, ctx->def.width, ctx);
 
 	mutex_lock(&ar->conf_mutex);
@@ -8900,7 +8900,7 @@ ath10k_mac_op_change_chanctx(struct ieee80211_hw *hw,
 	mutex_lock(&ar->conf_mutex);
 
 	ath10k_dbg(ar, ATH10K_DBG_MAC,
-		   "mac chanctx change freq %u width %d ptr %pK changed %x\n",
+		   "mac chanctx change freq %u width %d ptr %p changed %x\n",
 		   ctx->def.chan->center_freq, ctx->def.width, ctx, changed);
 
 	/* This shouldn't really happen because channel switching should use
@@ -8959,7 +8959,7 @@ ath10k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	mutex_lock(&ar->conf_mutex);
 
 	ath10k_dbg(ar, ATH10K_DBG_MAC,
-		   "mac chanctx assign ptr %pK vdev_id %i\n",
+		   "mac chanctx assign ptr %p vdev_id %i\n",
 		   ctx, arvif->vdev_id);
 
 	if (WARN_ON(arvif->is_started)) {
@@ -9039,7 +9039,7 @@ ath10k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	mutex_lock(&ar->conf_mutex);
 
 	ath10k_dbg(ar, ATH10K_DBG_MAC,
-		   "mac chanctx unassign ptr %pK vdev_id %i\n",
+		   "mac chanctx unassign ptr %p vdev_id %i\n",
 		   ctx, arvif->vdev_id);
 
 	WARN_ON(!arvif->is_started);
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index fb2c60ee433c3fc15dc7e1adf9e6d4e67862e901..20ec0a6d0f71c4fee3bf1a3d48b512ebcdfba856 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -3411,7 +3411,7 @@ static int ath10k_pci_claim(struct ath10k *ar)
 		goto err_region;
 	}
 
-	ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot pci_mem 0x%pK\n", ar_pci->mem);
+	ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot pci_mem 0x%p\n", ar_pci->mem);
 	return 0;
 
 err_region:
diff --git a/drivers/net/wireless/ath/ath10k/testmode.c b/drivers/net/wireless/ath/ath10k/testmode.c
index 7a9b9bbcdbfc5a290128ec55d3d3ce158a7b58c7..3fcefc55b74f2995be53f5d077e3a6a06aed900b 100644
--- a/drivers/net/wireless/ath/ath10k/testmode.c
+++ b/drivers/net/wireless/ath/ath10k/testmode.c
@@ -35,7 +35,7 @@ bool ath10k_tm_event_wmi(struct ath10k *ar, u32 cmd_id, struct sk_buff *skb)
 	int ret;
 
 	ath10k_dbg(ar, ATH10K_DBG_TESTMODE,
-		   "testmode event wmi cmd_id %d skb %pK skb->len %d\n",
+		   "testmode event wmi cmd_id %d skb %p skb->len %d\n",
 		   cmd_id, skb, skb->len);
 
 	ath10k_dbg_dump(ar, ATH10K_DBG_TESTMODE, NULL, "", skb->data, skb->len);
@@ -397,7 +397,7 @@ static int ath10k_tm_cmd_wmi(struct ath10k *ar, struct nlattr *tb[])
 	cmd_id = nla_get_u32(tb[ATH10K_TM_ATTR_WMI_CMDID]);
 
 	ath10k_dbg(ar, ATH10K_DBG_TESTMODE,
-		   "testmode cmd wmi cmd_id %d buf %pK buf_len %d\n",
+		   "testmode cmd wmi cmd_id %d buf %p buf_len %d\n",
 		   cmd_id, buf, buf_len);
 
 	ath10k_dbg_dump(ar, ATH10K_DBG_TESTMODE, NULL, "", buf, buf_len);
diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
index da3bc35e41aa08da9c325a34d4ab82b64d6f80cc..493bfb410aff3d842c217dab3f43c5c921a4ac0e 100644
--- a/drivers/net/wireless/ath/ath10k/txrx.c
+++ b/drivers/net/wireless/ath/ath10k/txrx.c
@@ -35,7 +35,7 @@ static void ath10k_report_offchan_tx(struct ath10k *ar, struct sk_buff *skb)
 	complete(&ar->offchan_tx_completed);
 	ar->offchan_tx_skb = NULL; /* just for sanity */
 
-	ath10k_dbg(ar, ATH10K_DBG_HTT, "completed offchannel skb %pK\n", skb);
+	ath10k_dbg(ar, ATH10K_DBG_HTT, "completed offchannel skb %p\n", skb);
 out:
 	spin_unlock_bh(&ar->data_lock);
 }
diff --git a/drivers/net/wireless/ath/ath10k/usb.c b/drivers/net/wireless/ath/ath10k/usb.c
index 3b51b7f52130ee3d94c9b2791dccf47a46e52e95..1732a4f98418df948759535dd979eceec00c06eb 100644
--- a/drivers/net/wireless/ath/ath10k/usb.c
+++ b/drivers/net/wireless/ath/ath10k/usb.c
@@ -131,7 +131,7 @@ static void ath10k_usb_recv_complete(struct urb *urb)
 	int status = 0;
 
 	ath10k_dbg(ar, ATH10K_DBG_USB_BULK,
-		   "usb recv pipe %d stat %d len %d urb 0x%pK\n",
+		   "usb recv pipe %d stat %d len %d urb 0x%p\n",
 		   pipe->logical_pipe_num, urb->status, urb->actual_length,
 		   urb);
 
@@ -230,7 +230,7 @@ static void ath10k_usb_post_recv_transfers(struct ath10k *ar,
 				  ath10k_usb_recv_complete, urb_context);
 
 		ath10k_dbg(ar, ATH10K_DBG_USB_BULK,
-			   "usb bulk recv submit %d 0x%x ep 0x%2.2x len %d buf 0x%pK\n",
+			   "usb bulk recv submit %d 0x%x ep 0x%2.2x len %d buf 0x%p\n",
 			   recv_pipe->logical_pipe_num,
 			   recv_pipe->usb_pipe_handle, recv_pipe->ep_address,
 			   ATH10K_USB_RX_BUFFER_SIZE, urb_context->skb);
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 5e061f7525a6bdec402e3571810fd86774ec8588..df6a24f8f8d5b5a61957b44d705f811b2ff88a44 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -2029,7 +2029,7 @@ ath10k_wmi_op_gen_mgmt_tx(struct ath10k *ar, struct sk_buff *msdu)
 	ether_addr_copy(cmd->hdr.peer_macaddr.addr, ieee80211_get_DA(hdr));
 	memcpy(cmd->buf, msdu->data, msdu->len);
 
-	ath10k_dbg(ar, ATH10K_DBG_WMI, "wmi mgmt tx skb %pK len %d ftype %02x stype %02x\n",
+	ath10k_dbg(ar, ATH10K_DBG_WMI, "wmi mgmt tx skb %p len %d ftype %02x stype %02x\n",
 		   msdu, skb->len, fc & IEEE80211_FCTL_FTYPE,
 		   fc & IEEE80211_FCTL_STYPE);
 	trace_ath10k_tx_hdr(ar, skb->data, skb->len);
@@ -2637,7 +2637,7 @@ int ath10k_wmi_event_mgmt_rx(struct ath10k *ar, struct sk_buff *skb)
 		status->boottime_ns = ktime_get_boottime_ns();
 
 	ath10k_dbg(ar, ATH10K_DBG_MGMT,
-		   "event mgmt rx skb %pK len %d ftype %02x stype %02x\n",
+		   "event mgmt rx skb %p len %d ftype %02x stype %02x\n",
 		   skb, skb->len,
 		   fc & IEEE80211_FCTL_FTYPE, fc & IEEE80211_FCTL_STYPE);
 

-- 
2.49.0


