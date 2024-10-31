Return-Path: <linux-rdma+bounces-5639-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B349B7123
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 01:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2ECFB21F9D
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 00:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9F51E885;
	Thu, 31 Oct 2024 00:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bqCqN9Kl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F002BAFC
	for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2024 00:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730334228; cv=none; b=dLIp7roiaUIn7nJ4JWG1buaJbfmcQBxYDslIVxcZw7GfEQLE9okhvMy6mQ6ANKLjzBmKFSUFkmnIJq+bY27UVPgrRtud5gtVVUcK64YwS1G2Z5UPzxYaZl6N8ziuFcPfuc7IevXuxDTDgHVZ6sQrXIke7/xFlQNQV9ndSuC2P04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730334228; c=relaxed/simple;
	bh=z3nAQNKQ8EPpdG3q4GCW/62oF7r6Z6P5c1Z3MZCXaUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EwbBHEBiXhOvKGqTcga7HpNH9qwAm85sPB/IWADwrpEkLclmyl1DTRzzyP/f+rkMRx+MDhI5MKDYUkN8jScV6rBxb1Ls9tT2YO2zfUG7iUxOkBDcZ2ZT+nXhR7rb9UOG1T3wN5+/CeBY8SuCvg9UcBQNth8hAWgZ7NukfLUf7QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bqCqN9Kl; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-6cbd12cfd7aso849716d6.1
        for <linux-rdma@vger.kernel.org>; Wed, 30 Oct 2024 17:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730334224; x=1730939024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tf88+MjxuRscGCJUWSV+JgU09beZteKvue7KtOwrEjg=;
        b=bqCqN9KlSIQ3gYJVsIYw8zzBPxZ4Baam5ErLZXiwyDakHYWYUMRaQOhFNWXqJEq1/3
         Lb4j3wC6VDbbe340UzvNwCHYWsJtGsTPrJvudE4Vrbr09rp66z+q1bKZ+0bgy8+tfZfw
         jYa66OGkTXosd2C7edv9I6D8AgdcbanIg01FYULfgQnWD+16DZQfhjjqfiGohNPsFpGg
         yAp29zNsaWw21TnCWPTqRfOYNCt7DCO6cZGiT2USBLpoEYWiv7lbZOOwLANXnY6eAQoS
         O6IGPWZ5upM9faK8RpPLQbbTWdkZnoZgwI7zWnJjsWzX08rqxaoCa3L3ipTl5/8S4Ri2
         1jrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730334224; x=1730939024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tf88+MjxuRscGCJUWSV+JgU09beZteKvue7KtOwrEjg=;
        b=ExTrNaAZiScliIcLxaOyOWnbi2i/zfW0f8Wxn5QF9b3hJqre8RsdlV55vf9l+Ns85g
         Pygf0Hbt/kbeFQB3+3X+iG97CAlpBZ7kDgFf9e8An4yvrTeYvvrZOWZl6aa2kudr4hT7
         Cu1Ktzs/1Yrf5fIL6sS7uKYQ0OL6ZeiSMMwbtnUT+cMFC71354GQYcFGs5eQBgadIxhz
         +ixAFTA183p7LKYN1z/AYRSzF2IW9ccC4L0SnIDIqJ4TN3BOmLjVMCqv5wsxqzh7YKbZ
         HjdpeLBfr0OfZA+WOW0WsZZM017yzN3vFB++6YTs4coIgfsjU6Hv9ltzIDLxoTbDBBvT
         B1oA==
X-Forwarded-Encrypted: i=1; AJvYcCXHHLIlRUK57PhSS+z0mmOCEzDjMJOFvxFFD3E2TLp2nkVGiZ9s83Fag3Y/LM3iq7gpqvapFuEBzf7y@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2JNmzUZjLnky91zNwwlwBPbxQbOCgruKEhcUukaQE81k9NsdU
	ub3J8dTjCqsoBmhCVqJBrERJvS9L4197G/mIWoRNVo2JphM1HGIHQW5z5Oq+ACJNUqmiNML0qHD
	+qZv9gj5xJt4HkoEgO2oLvEfQmjTya92Y
X-Google-Smtp-Source: AGHT+IFWsRmOrMEqCX2JKpYyyP20jT4EjhYF6nfkwiWrX3lyx/J6drAHCyLE8ycuPc1ryiPw8RvCWPQOnpw6
X-Received: by 2002:ad4:5c8a:0:b0:6c3:662f:8e09 with SMTP id 6a1803df08f44-6d185817c9cmr122847176d6.9.1730334223990;
        Wed, 30 Oct 2024 17:23:43 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6d353f9cd82sm197576d6.3.2024.10.30.17.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 17:23:43 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E22DE340748;
	Wed, 30 Oct 2024 18:23:42 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D5083E40A10; Wed, 30 Oct 2024 18:23:42 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	David Arinzon <darinzon@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Doug Berger <opendmb@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Felix Fietkau <nbd@nbd.name>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Geetha sowjanya <gakula@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Leon Romanovsky <leon@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Louis Peens <louis.peens@corigine.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Noam Dagan <ndagan@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Roy Pledge <Roy.Pledge@nxp.com>,
	Saeed Bishara <saeedb@amazon.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Shay Agroskin <shayagr@amazon.com>,
	Simon Horman <horms@kernel.org>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Tal Gilboa <talgi@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com,
	virtualization@lists.linux.dev
Subject: [resend PATCH 1/2] dim: make dim_calc_stats() inputs const pointers
Date: Wed, 30 Oct 2024 18:23:25 -0600
Message-ID: <20241031002326.3426181-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the start and end arguments to dim_calc_stats() const pointers
to clarify that the function does not modify their values.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/dim.h | 3 ++-
 lib/dim/dim.c       | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/dim.h b/include/linux/dim.h
index 1b581ff25a15..84579a50ae7f 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -349,11 +349,12 @@ void dim_park_tired(struct dim *dim);
  *
  * Calculate the delta between two samples (in data rates).
  * Takes into consideration counter wrap-around.
  * Returned boolean indicates whether curr_stats are reliable.
  */
-bool dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
+bool dim_calc_stats(const struct dim_sample *start,
+		    const struct dim_sample *end,
 		    struct dim_stats *curr_stats);
 
 /**
  *	dim_update_sample - set a sample's fields with given values
  *	@event_ctr: number of events to set
diff --git a/lib/dim/dim.c b/lib/dim/dim.c
index 83b65ac74d73..97c3d084ebf0 100644
--- a/lib/dim/dim.c
+++ b/lib/dim/dim.c
@@ -52,11 +52,12 @@ void dim_park_tired(struct dim *dim)
 	dim->steps_left   = 0;
 	dim->tune_state   = DIM_PARKING_TIRED;
 }
 EXPORT_SYMBOL(dim_park_tired);
 
-bool dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
+bool dim_calc_stats(const struct dim_sample *start,
+		    const struct dim_sample *end,
 		    struct dim_stats *curr_stats)
 {
 	/* u32 holds up to 71 minutes, should be enough */
 	u32 delta_us = ktime_us_delta(end->time, start->time);
 	u32 npkts = BIT_GAP(BITS_PER_TYPE(u32), end->pkt_ctr, start->pkt_ctr);
-- 
2.45.2


