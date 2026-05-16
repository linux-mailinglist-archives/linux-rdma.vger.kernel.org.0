Return-Path: <linux-rdma+bounces-20796-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IQEKYMKCGqPWAMAu9opvQ
	(envelope-from <linux-rdma+bounces-20796-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 08:11:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D91655A723
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 08:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D45FE30058FF
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 06:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5DB35AC13;
	Sat, 16 May 2026 06:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=extrahop.com header.i=@extrahop.com header.b="hyJinF8c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300C9364022
	for <linux-rdma@vger.kernel.org>; Sat, 16 May 2026 06:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778911868; cv=none; b=r195Bg05rKi2S9ZIxoj6zLIn9xHNC/Tvvgf6W78j27HkVNSzK8AGnvw4AVV8gLn2oytRa3P1W4Z3O0okLx+9vXsSYgTgfUJvnWna67M6POe1dSOw8ySUE5lgYq5Mj9fymnzLiDSPgtIKVnC9VNvn3Kd/kbmxXE3UiMogkHlirAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778911868; c=relaxed/simple;
	bh=2Leslt9BvB34QU801/n0+rUCWtgQPEnpWkpjEuM4jNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lOzj+PmgwKP6kZoEPL5U97ZA3UcmpdBc83qba4nw/IJVt8SO8FO3mz3nCgikWhEinbMX043IuG3O2vqUXFBFhndwG0ofwYd8XDWGgPALN2Ru5vwTHfvv3Mo9Cw30UE5Vw0OXQUtVevd7rs9XKfx9fwWd5HDoGqu4FqTUfYCnfT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=extrahop.com; spf=pass smtp.mailfrom=extrahop.com; dkim=pass (2048-bit key) header.d=extrahop.com header.i=@extrahop.com header.b=hyJinF8c; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=extrahop.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=extrahop.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36643b96b99so522738a91.0
        for <linux-rdma@vger.kernel.org>; Fri, 15 May 2026 23:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=extrahop.com; s=google; t=1778911865; x=1779516665; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gJUW1fIrNG8R6/LQd80CdB1tEktS5+sLoCJwrPWafEc=;
        b=hyJinF8caPaeCe/g8PvdHPd/WchKYMUFbngZ6vbKdH62qlZpHiP/44OmYkbhKlJ+3R
         6vW4+OC0utk/pri7sP6o+kN4cKii5clqitLl1+iG3xACJFhyQZp9frMOaTRcxAWhGmAb
         Fz4DVxvVCYnPvyMx2SrLSaM6Pq+2G39XFvoZZXLiBUE8oVWcXHse4ajhxISLbqM6oUaA
         oVblE+8pyNI58/j8hIEBrwaL4eDOuqOdzZQLMpodTEwOn+Sx6UumoSssdEpKAqxDwpzU
         tpit+P4Duyq/+GpPtzoxtVwddS28Nl6JUDceuipIihLzUkYlfLYwG3ia9/BmqUGeEh6x
         zM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778911865; x=1779516665;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJUW1fIrNG8R6/LQd80CdB1tEktS5+sLoCJwrPWafEc=;
        b=KBUqHzowFA6LhllPD8vnTIouFa3ic9RyjZh9FFN1IyI/IJrjfRsGVjWoMY894IrX2I
         QLwjnk3+zdOl4Zwx9weiWWG1GkDXQ54iZi8N05SzXEtbCRHuTUGDKge0Jy/8mFiROzVk
         jRcdYTAlOfSQKqUaxzcnuQwvG7BspAuzOdBXxNtPdPHQmMpyfAD+7mK2QlzyHhn1Fr9J
         t9NmXfs1UfiOC9BJii8VgWaVEcwwwmorrPs9ygPyxw/cYManui4qRsh/Z/0zWgFMKocy
         WMXJhxs13IciDxe6gHSIzn7tGSoKn6IfwkJe0Ao16keBxo9k6P92dj2BXUdNi/3Jf8J/
         qTQA==
X-Forwarded-Encrypted: i=1; AFNElJ8A4UK9Yy422/cHh1Xqm+ouwbDqujIpcVQty22DNRvHC5zxYd2vmp8UGAtKpPDh7gvXFrbfHRbgr7Mg@vger.kernel.org
X-Gm-Message-State: AOJu0YwjTJY6D1my80gYks/QfIk/fi/apeIxmcdf0bzYbfsfuFGgEu54
	3WrJ5c2le1ouh7eVdptE3/P8ZeuPhWCe76k7ydKKaDe8895AEYDMp+l1VrBaE1Xg/49mN6XtvvU
	kiwjcuuJl9IGgLi+Zb7SHeZxj9EqDgJm5c3cX0e/PuR10a3IlOZ8m1X8+EzWwBSVkE/nk+YZN8t
	xzlwneX8bj6IBwNAEg4Ln+fS21EX1a4uX6Z0V1audb9i9w+MVzt7tl
X-Gm-Gg: Acq92OHzVNy69HSfPrbLFkOLpfCENN/Uco44wMb961qfTeREwzp/UnqxPJ8umpgfd3t
	QBZhKU6Qe1EjzIzIWFqo4AsHnbGCdkrT95LdDRdUUkq+9hq7hCMjSskYSyzBUYs5YZLrghyx5NA
	vGxgsuVxIUQ66I3XA5X0pNnAr2FR5svR5FGuGK5xPMFiO6mIiL1FsAs84NlKMFmvKimUUKmknmc
	MQXobPHqxhu07BsebkhcQKT/eVRCeVHO3/SuN7rRsRBjwkcX0wijNftAPPWKeYxram5NbqF8jtA
	nzNz4JaMq2RoV0RAR57OMNrDaW09M7IO59BAOZeU0Xlr0RIIfR2dcE69X8NfJfJ2tQkYEUOGIKN
	pezAlxzJA0y3s2+m0r0XYNFkDOjhiZcwJOR6O9GYufbPt9hVIbRSfO0s2nxasiLBpgGpikfaYQR
	o6BkGhkQVQFEEpcUsBtVKbGDkwsXer
X-Received: by 2002:a17:903:2984:b0:2ba:67f7:9326 with SMTP id d9443c01a7336-2bd7e81a6c0mr79060175ad.9.1778911865304;
        Fri, 15 May 2026 23:11:05 -0700 (PDT)
Received: from [127.0.1.1] ([208.79.144.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d23a41fsm79591625ad.83.2026.05.15.23.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 23:11:04 -0700 (PDT)
From: Will Mortensen <will@extrahop.com>
Date: Fri, 15 May 2026 23:10:36 -0700
Subject: [PATCH net v3] net/mlx5: don't printk garbage when transceiver
 overheats
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-b4-mlx5-sensor-fix-v3-1-f537ce191d6c@extrahop.com>
X-B4-Tracking: v=1; b=H4sIAFsKCGoC/22NwQ7CIBBEf6XZs2tgS6vx5H+YHmpZLImFBgipa
 fh3Sb16nDeZNztEDpYj3JodAmcbrXc1tKcGpnl0L0arawYS1ItOXPGpcHlvHUZ20Qc0dkOhWq1
 GItMrCXW4Bq74kD7AcYKhwtnG5MPnOMp0VD+npH/OTCixa6VhVkZfjL7zlsI4+/U8+QWGUsoXH
 MYM77wAAAA=
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 netdev <netdev@vger.kernel.org>
Cc: Shahar Shitrit <shshitrit@nvidia.com>, 
 Carolina Jubran <cjubran@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, linux-rdma <linux-rdma@vger.kernel.org>, 
 Jeremy Royal <jeremyr@extrahop.com>, Will Mortensen <will@extrahop.com>
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 3D91655A723
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[extrahop.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[extrahop.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20796-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[extrahop.com:+];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@extrahop.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When the mlx5 driver processes a temperature warning event, in events.c
and hwmon.c, temp_warn() calls print_sensor_names_in_bit_set(), which
calls hwmon_get_sensor_name() to get the NUL-terminated name of the
relevant sensor, and then prints it to dmesg. In particular,
print_sensor_names_in_bit_set() passes the bit index ("sensor index")
within the 128-bit vector in the warning event to
hwmon_get_sensor_name(). But hwmon_get_sensor_name() was expecting the
index of the hwmon channel, and the driver registers hwmon channels for
at most only two sensors: the ASIC sensor (sensor index 0) and the
module sensor (sensor index 64 or 65 on a 2-port NIC). So when the
warning event concerned a module, hwmon_get_sensor_name() took the 64th
or 65th element of the likely 2-element temp_channel_desc array and thus
returned a pointer to some other kernel memory past the end of it, which
was printed to dmesg up to the first NUL byte.

A further difficulty is that, at least in testing on our CX-8 C8240 with
firmware 40.47.1088, the warning event can have bits set for other
modules, e.g. if this PCI physical function is associated with
port/module 0, we might expect bit 64 to be set, but bit 65 (for port/
module 1) can also be set unexpectedly.

Fix this by clarifying that the argument to hwmon_get_sensor_name() is
the raw sensor index, and correctly converting it to the hwmon channel
index. Return NULL if the sensor index doesn't correspond to a hwmon
channel (e.g. because it's for the other function/port's module).

Fixes: 46fd50cfcc12 ("net/mlx5: Add sensor name to temperature event message")
Reviewed-by: Jeremy Royal <jeremyr@extrahop.com>
Signed-off-by: Will Mortensen <will@extrahop.com>
---
Changes in v3:
- Fix ordering of Signed-off-by
- Add target tree name
- Add CCs
- Tweak commit message
- Link to v2: https://lore.kernel.org/r/20260512-b4-mlx5-sensor-fix-v2-1-531fee4fd7fd@extrahop.com
---
 drivers/net/ethernet/mellanox/mlx5/core/events.c |  2 ++
 drivers/net/ethernet/mellanox/mlx5/core/hwmon.c  | 15 ++++++++++++++-
 drivers/net/ethernet/mellanox/mlx5/core/hwmon.h  |  2 +-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/events.c b/drivers/net/ethernet/mellanox/mlx5/core/events.c
index 4d7f35b96876..9372551c7f90 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
@@ -165,6 +165,8 @@ static void print_sensor_names_in_bit_set(struct mlx5_core_dev *dev, struct mlx5
 	for_each_set_bit(i, bit_set_ptr, num_bits) {
 		const char *sensor_name = hwmon_get_sensor_name(hwmon, i + bit_set_offset);
 
+		if (!sensor_name)
+			continue;
 		mlx5_core_warn(dev, "Sensor name[%d]: %s\n", i + bit_set_offset, sensor_name);
 	}
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
index afcdebac9c4f..747ff30362f1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
@@ -417,7 +417,20 @@ void mlx5_hwmon_dev_unregister(struct mlx5_core_dev *mdev)
 	mdev->hwmon = NULL;
 }
 
-const char *hwmon_get_sensor_name(struct mlx5_hwmon *hwmon, int channel)
+const char *hwmon_get_sensor_name(struct mlx5_hwmon *hwmon, int sensor_idx)
 {
+	int channel;
+
+	if (sensor_idx >= 64) {
+		if (hwmon->module_scount == 0)
+			return NULL;
+		channel = hwmon->asic_platform_scount;
+		if (sensor_idx != hwmon->temp_channel_desc[channel].sensor_index)
+			return NULL;
+	} else {
+		if (sensor_idx >= hwmon->asic_platform_scount)
+			return NULL;
+		channel = sensor_idx;
+	}
 	return hwmon->temp_channel_desc[channel].sensor_name;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/hwmon.h b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.h
index f38271c22c10..b2476bf54ce5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/hwmon.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.h
@@ -10,7 +10,7 @@
 
 int mlx5_hwmon_dev_register(struct mlx5_core_dev *mdev);
 void mlx5_hwmon_dev_unregister(struct mlx5_core_dev *mdev);
-const char *hwmon_get_sensor_name(struct mlx5_hwmon *hwmon, int channel);
+const char *hwmon_get_sensor_name(struct mlx5_hwmon *hwmon, int sensor_idx);
 
 #else
 static inline int mlx5_hwmon_dev_register(struct mlx5_core_dev *mdev)

---
base-commit: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
change-id: 20260508-b4-mlx5-sensor-fix-043d4a22f641

Best regards,
-- 
Will Mortensen <will@extrahop.com>


