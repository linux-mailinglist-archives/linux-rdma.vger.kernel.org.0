Return-Path: <linux-rdma+bounces-20376-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BZKHnyhAWpKgwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20376-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 11:29:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DEB50AE4F
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 11:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19D7631F49B5
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 09:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7805D3C9EF8;
	Mon, 11 May 2026 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="zjyx8z06"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670003C9EF3
	for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490042; cv=none; b=fXULE0ucoQOBXTlJa5NnwT9E2nRC7RKYywV3G8wtfJOO8uD2OiqmGVsaGPxLCpaS9/dekMe8eXGTohThJ6p2SrRo2IIxJXY8IQjXqUbvgrOZU3jT/2aHnh6iah5ED0EjNk4hGga07VKFqqTVgfksNmQlu/A+IjhZvP+NTE3SBCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490042; c=relaxed/simple;
	bh=ZYGinJLF1cDgGH/aGo4d1Hy0fwsOtdFNgDp8EWspf48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=augHO3VjqlDCRxFx5twXokRFa6l6VtEwSsYge5oFylOLbdYuK9A3DekTsx0kCa7BHmyi/Uf3SCTI3LwFJ8Vq1HyQt0jYKowChAa9cx+H2NEHu4+9/SmQX9UiKNwfem8PI7bMAEfm1E+ij2gnMMmrC1ODh0OO0LmoEsmtIiMgLU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=zjyx8z06; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45297094718so3194862f8f.3
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 02:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778490038; x=1779094838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zA2t05MaP/podHX+JpTZXPs7rW/q4RVQKoAjNccx6WY=;
        b=zjyx8z06LW5isoT8LCSsXz+IFhYHTCiWyxWpyhQnuRjuxF2yJQkHA7pCKTR9CVv4yV
         1eBHxsGm0obJ3tC+saBHhlRiU09Mm55lQIc7BnqeTKJkwIYBO0WoIpCpDplCe9cWKSYx
         Ujn3uCjpcJsuYsrJ61DoJPPw7O9Ez3liNpKPyQBDaEnlwngLqDr76c5bMk9w5zA5gaAz
         Gn5B0mW6DKzkZSqzk2ARFaS0DDNiSpAq7mbFSKS9viASh8q3Ubibs+uE3hJ2L4SVHS6s
         zErl1L54vHW4glkpYJHJyvqjGfcir95CIXol8XdcDnNJQmnqgTliRKjS46BUvT0CoWlg
         zgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490038; x=1779094838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zA2t05MaP/podHX+JpTZXPs7rW/q4RVQKoAjNccx6WY=;
        b=F+lEQxZ1dVKZNtu36MExpzK8HwmpOJ4qe+nOmAQaUu/nJ13HkCQLwIa6/wLsGzVe55
         LUWPb+agrI7Jc5giH35pVxXA1Kk5fMXa+qeE+dZdLPJWEx3Pm+Gum2lyTgJk0q/tTu5C
         3RQtWaDOJ7fJriwFAcmryjm9xKVvk4onFQGbnUHLSenq9POAxbLq1Nh+MM7s1sz26NNf
         4bjeO++/dfWXPaKoEoPROpu4rJcVY7glfyQtUthGDdhTjhOhOp/0455rW+aUr/wTdIJF
         6dReFOnJuhEMrzuSlzmWOy/Ldj9jrZslF+aImFT//onzozIoPXvV7kH8MizfSSkM4t5A
         Q+rQ==
X-Forwarded-Encrypted: i=1; AFNElJ95gdb38YjGcBBHOm3qGI1j5/+uN52oivBGXuaR7IWnyP4IRGKepsXSxWzcMQikcKbvvE99t1ceBwrQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwhFYdYrKiVdjtAwucqHnZX10/HBNyoYqeKvKf14stxVQVz8h99
	lE8BNlS1NWxzSUDZAWce54d++fEAlosncwSKnX5xaxfVlN5UiY9KefN8tNe4OTN1qQE=
X-Gm-Gg: Acq92OH7yrwnQpuk8mJCWfwCLzdUQFgE0vGJFYx5B0LV02kPFlKUDGxOjNGWfpLiTO/
	WZ5cq8O/i6q6Qht6fdu/woeG1T3/8s+yZcNlACphfBxWDXczQKiagtrOiYtG4efM/WFJVAd704W
	todGfErTirlODtf5yx81shdIswGnL+tDQUkYVtpOZWmUsfEU0igRbs7fxjcRSWBgxd1vF6y4d8K
	MI3Eeo7vQX3ELAQormOKS0Wg5zrVvggirT4X/wRK1AAz8eMmLAxIBIRN8Gv/qejj64k28mIr2rC
	+nKHuxRtNdJJ7qnCXkBucK+27IYRMQ7d/JVVjXKW6ng0vy1mJim2fYwz+l1uj+DkAbXizEWwUBO
	TGVdV6XM0Z5iPGis7hmWzqaO89uEN8bpV+4m+TiA2dn1eAhIUT2iola0kbOD/1Nbi9IlL76SBlD
	GSWrMbhRBC/GcujSon+yGqBvqBpARvrHz4a0EVJLDh+deIY0NvjWcBrQ3t0M1zb1p950WYhNofZ
	hji7Vw/g+7GYjtuqqgk1CRjOA==
X-Received: by 2002:a5d:64e3:0:b0:449:cfea:ca91 with SMTP id ffacd0b85a97d-4515da96254mr34460937f8f.37.1778490037223;
        Mon, 11 May 2026 02:00:37 -0700 (PDT)
Received: from localhost (p200300f65f114e0841c796eda31a14b3.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:41c7:96ed:a31a:14b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4548e6a5b65sm25209225f8f.8.2026.05.11.02.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:00:36 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Michael Grzeschik <mgr@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Steffen Klassert <klassert@kernel.org>,
	David Dillow <dave@thedillows.org>,
	Ion Badulescu <ionut@badula.org>,
	Mark Einon <mark.einon@gmail.com>,
	Rasesh Mody <rmody@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Manish Chopra <manishc@marvell.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Denis Kirjanov <kirjanov@gmail.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Jian Shen <shenjian15@huawei.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Fan Gong <gongfan1@huawei.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Yibo Dong <dong100@mucse.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com,
	Jiri Pirko <jiri@resnulli.us>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Daniele Venzano <venza@brownhat.org>,
	Samuel Chessman <chessman@tux.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Kevin Curtis <kevin.curtis@farsite.co.uk>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Stanislav Yakovlev <stas.yakovlev@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Zilin Guan <zilin@seu.edu.cn>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Arinzon <darinzon@amazon.com>,
	Yeounsu Moon <yyyynoom@gmail.com>,
	Denis Benato <benato.denis96@gmail.com>,
	Yonglong Liu <liuyonglong@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yicong Hui <yiconghui@gmail.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Ian Lin <ian.lin@infineon.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Double Lo <double.lo@cypress.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	oss-drivers@corigine.com,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH net-next v3 0/2] Rework pci_device_id initialisation
Date: Mon, 11 May 2026 11:00:22 +0200
Message-ID: <20260511090023.1634387-4-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4853; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=ZYGinJLF1cDgGH/aGo4d1Hy0fwsOtdFNgDp8EWspf48=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqAZqnnelkHiCtzmBC4y0fb7vJdPOE1eZ7YhPdE 2SrLv8jYlGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagGapwAKCRCPgPtYfRL+ TjAaB/4oo4PlfsIbeG6MCk6KG/Z4+gxMxrSewie9L+e4GgVdrB4TOBKkquVHmIZGwKjcVZ4TTHb NefjSqaVMX4GAGFyvubu+IYDalSlSnAzan/1cuw698pTu8HJAZcUiXsULIZGAzyccgEjFzFRtOG 9zcX6kiJPNLHyc4KCm8r2nVxLqV6bD0Ra/lsh4CIqsXdKbNgT8R/zlx5qsBD4jv6XuZojWf/47T BGjl0kKv9jdWqI2IyZT+iFIbeMxYEcWSMZLzC6lnFeTSGLW7f1AVp8qVTep3xLTu5Qrh0AUeJ60 G6q8VibpIILN8q4yuUlgLX0vBjjeLn9Q8sKtPvNkz+TLgLBC
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C5DEB50AE4F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20376-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,thedillows.org,badula.org,gmail.com,marvell.com,chelsio.com,huawei.com,linux.dev,intel.com,nvidia.com,mucse.com,realtek.com,resnulli.us,fr.zoreil.com,brownhat.org,tux.org,trustnetic.com,net-swift.com,farsite.co.uk,broadcom.com,bootlin.com,seu.edu.cn,suse.com,google.com,amazon.com,infradead.org,ti.com,infineon.com,cypress.com,baylibre.com,vger.kernel.org,lists.osuosl.org,corigine.com,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	RCPT_COUNT_GT_50(0.00)[80];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre.com:mid,baylibre-com.20251104.gappssmtp.com:dkim,pm.waw.pl:email]
X-Rspamd-Action: no action

Hello,

the previous iteration of this series (v2) is available at
https://lore.kernel.org/netdev/cover.1778149923.git.u.kleine-koenig@baylibre.com

Changes since v2:

 - swap patch order as Jakub Kicinski reported a build failure (that I
   couldn't reproduce though)
 - drop the change to drivers/net/can/m_can/m_can_pci.c on Markus
   Schneider-Pargmann's (non-public) request as this patch conflicts
   with a cleanup he has in his queue that will prepare this driver
   for my quest to add a union to pci_device_id in a differnt way.
 - drop a recipent from Cc: that bounced before (khc@pm.waw.pl).

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (2):
  net: nfp: Drop PCI class entries with .class_mask = 0
  net: Consistently define pci_device_ids using named initializers

 drivers/net/arcnet/com20020-pci.c             | 242 +++------
 drivers/net/can/sja1000/plx_pci.c             | 167 +++----
 drivers/net/ethernet/3com/3c59x.c             |  80 +--
 drivers/net/ethernet/3com/typhoon.c           |  75 ++-
 drivers/net/ethernet/8390/ne2k-pci.c          |  24 +-
 drivers/net/ethernet/adaptec/starfire.c       |   4 +-
 drivers/net/ethernet/agere/et131x.c           |   6 +-
 drivers/net/ethernet/broadcom/bnx2.c          |  62 ++-
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  50 +-
 .../net/ethernet/cavium/liquidio/lio_main.c   |  10 +-
 .../ethernet/cavium/liquidio/lio_vf_main.c    |   7 +-
 drivers/net/ethernet/chelsio/cxgb/common.h    |   2 +-
 drivers/net/ethernet/chelsio/cxgb/subr.c      |   2 +-
 .../net/ethernet/chelsio/cxgb3/cxgb3_main.c   |   4 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |   4 +-
 .../ethernet/chelsio/cxgb4vf/cxgb4vf_main.c   |   4 +-
 drivers/net/ethernet/dec/tulip/de2104x.c      |   6 +-
 drivers/net/ethernet/dec/tulip/dmfe.c         |  12 +-
 drivers/net/ethernet/dec/tulip/tulip_core.c   |  78 +--
 drivers/net/ethernet/dec/tulip/uli526x.c      |   6 +-
 drivers/net/ethernet/dec/tulip/winbond-840.c  |  13 +-
 drivers/net/ethernet/dlink/dl2k.h             |  12 +-
 drivers/net/ethernet/dlink/sundance.c         |  14 +-
 drivers/net/ethernet/fealnx.c                 |   8 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |   2 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  50 +-
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  18 +-
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  12 +-
 .../net/ethernet/huawei/hinic/hinic_main.c    |  12 +-
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   |   7 +-
 drivers/net/ethernet/intel/e100.c             |   9 +-
 drivers/net/ethernet/intel/e1000e/netdev.c    | 471 +++++++++++++-----
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c  |  10 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  59 +--
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  10 +-
 drivers/net/ethernet/intel/igb/igb_main.c     |  66 +--
 drivers/net/ethernet/intel/igbvf/netdev.c     |   4 +-
 drivers/net/ethernet/intel/igc/igc_main.c     |  34 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 106 ++--
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  49 +-
 drivers/net/ethernet/mellanox/mlx4/main.c     |   6 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  26 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  16 +-
 drivers/net/ethernet/micrel/ksz884x.c         |   8 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  10 +-
 drivers/net/ethernet/natsemi/natsemi.c        |   4 +-
 drivers/net/ethernet/netronome/nfp/nfp_main.c |  65 +--
 .../ethernet/netronome/nfp/nfp_netvf_main.c   |  33 +-
 drivers/net/ethernet/qlogic/qede/qede_main.c  |  20 +-
 drivers/net/ethernet/realtek/8139too.c        |  52 +-
 drivers/net/ethernet/realtek/r8169_main.c     |   8 +-
 drivers/net/ethernet/rocker/rocker_main.c     |   4 +-
 drivers/net/ethernet/sis/sis190.c             |   6 +-
 drivers/net/ethernet/sis/sis900.c             |  10 +-
 drivers/net/ethernet/smsc/epic100.c           |  18 +-
 drivers/net/ethernet/sun/cassini.c            |   8 +-
 drivers/net/ethernet/sun/sungem.c             |  26 +-
 drivers/net/ethernet/ti/tlan.c                |  41 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  26 +-
 .../net/ethernet/wangxun/ngbevf/ngbevf_main.c |  26 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  18 +-
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   |  18 +-
 drivers/net/wan/farsync.c                     |  24 +-
 drivers/net/wan/pc300too.c                    |  14 +-
 drivers/net/wan/pci200syn.c                   |   6 +-
 drivers/net/wan/wanxl.c                       |  11 +-
 .../broadcom/brcm80211/brcmfmac/pcie.c        |  17 +-
 drivers/net/wireless/intel/ipw2x00/ipw2200.c  |  52 +-
 68 files changed, 1285 insertions(+), 1099 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3


