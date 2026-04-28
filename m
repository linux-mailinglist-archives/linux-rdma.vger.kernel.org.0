Return-Path: <linux-rdma+bounces-19683-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MkPBivs8GmBbAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19683-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 19:19:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 668A6489CB3
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 19:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4BD0301787C
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 17:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984D23988F9;
	Tue, 28 Apr 2026 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="JFRKeDiX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B92E33372A
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396768; cv=none; b=PvWh7hWs8rowScUIH2pBDuZBol3gOLsppgVe1NZZSmZuZ2eJLtpRMZQ1YFwWT5pBXWACNWILBvZaTm8/4UhY1/jWUBoeY/k3YPVxrL7gu0ccFe5xJexWyORh16/4Valkhnqt9tvi5ulZXGVj3DR3ECtpUJETSg0lc+EaOGasArU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396768; c=relaxed/simple;
	bh=EwbblkFcDnVN3IVzEa/sMefmS+VdG8zqxs2PCD7CqHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a3RBGTzTtuTnDO+4qFG7EE9Z8DeAtEpSPMXxUMWCnE7e8cGHY8W54Ke8U/gmEuzRnVF8ifI9r0Ew5ADL/9pV3ugVjXqdLK5oFppxT7Hu8PPk4u7Eedrf8DmODLH/6C9hk7aHVx/0RpLiP8oie2u2vjPuIl5AR6mwBjPcfGxqZtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=JFRKeDiX; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43eb05b1875so6816601f8f.3
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 10:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777396758; x=1778001558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bXS4hZH4GuMjDgj0JYnpAEoYDoFOckWhSiXG9OYKrmo=;
        b=JFRKeDiX1aXTENH7HUaHmara9RriwpuT2EsVfqQ7NupkZ5E0xIRAQ3ojprBRU5EP/Y
         lXIv2WjDdC+NjIB4H+u4AOdFJZe3XDPHjbNZm1aWG7GV49QNXQlb1/KfGVKY0bG2qtqZ
         9XnbfKzeAbj4jJYg9WEvsLOBt4qx4j9CLf8GZTzy5HiMHLEIix2rQT0zL6L2iJetR7iB
         2jIniKcr+VL65mD/qCnZ1cAt54Ww4Tp90iSrmVulRIIg3MgevqsB1q79Dx3R8aFQ7ZwB
         XxrPMYa6iyyB02EYKZs4Nf7m4gkwNdUwk6cDkDtgYb20CjBzufhqHqnr49bW2Da8d+3t
         o4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777396758; x=1778001558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXS4hZH4GuMjDgj0JYnpAEoYDoFOckWhSiXG9OYKrmo=;
        b=V0s60ePFTHS6Az3ZhhbmO9X1TjIn/jgPTpOC1yFzHucJ4xup3HRZeomxR2uIE2bWJt
         YLnxwQqcZr0T/Y9/+nQiAFye2uzmly52FBrMtzObbki9dEMKd0BGTtphlbDxpjUbUj//
         omVwhlOhAimNAEpW+76vjJQ4VdyDdKcA4DI3uRdEtzbPCGuIX3Y7OkLUA2YuoIlE8m2Q
         it7azeNTHA+wXucCh+sdpgDsiml5/ptzCOOmkiZAIZ7thpp+v53BhxvMxx5cWkME4PQD
         rVSNJzFhpTCDaQzDhF/ZdpQrI5n34HzFWThpIkcY7eg5P/izam83hyJcReBGsH+ae0Xe
         GTqg==
X-Forwarded-Encrypted: i=1; AFNElJ+jmwkLsTIGhAftOvhqlNBHyvW0Cp6lp+RnTjFQz9piXw1z6tsYp90UD8MIqc0kaCkLI55u1GpAUqA9@vger.kernel.org
X-Gm-Message-State: AOJu0YyoTBBvGTPFCwIkK8XGMRuMdYE+XEVdEdXZ+IuwkxauqPGHXYzO
	ZVGoQTxC//ei279kDnP7/f/iDNywusrfueVM+6TRbW/+b75Eyd/GfehfiMVK7M6CM5g=
X-Gm-Gg: AeBDieuIwQCAOwmslaaCCwL8chOjUDI9XR3fLi77i4EA8xwEhIu1RinFNs6lia2Q5JB
	DjfRtONhIgiDFghyTVnpxJ2Uz4+jyPSF2HIPZnDjOUZeSy/TWtuTSGBsSvp86AJ/Toa/GPcC7Xe
	JKASB10oTO6eI0UhuPeMvnrSs+re/EODcgJ/eYHv0YA84ThOq2D1vg+KXb0S4/OKzfkMBnWdpFp
	uqHZHkMTOnTmZwbTVxxrd0xQyvYfnh8qh+67KQwDHwp3U9GFnkL6jJHUg1oPvbL7aowGFKvjlJm
	DuPFrSexgj0tj2J8ktPH//cM5qfVm/9BgPDTA36/FHDKaD2ldFX5ac7sqzGWy1awYa8Dh61l/wH
	0nOZcsEeldwL+jUGrd/QC5twZfh9+WhiVlKdtDQZUcrrrfKACqMdOVX9cHHUWQl9GvTnn7C9dNI
	cJI4ZtupdWH8rxSwL1Q7aLBP2MCyEqykbLanfz2wAhXwgxO47Y2Uz2t3YqsU+F5jU6mAEgDVP2J
	KOQtAm1xPWAE9wmI2QiuEHyMQ==
X-Received: by 2002:a5d:5f85:0:b0:439:c299:4d8f with SMTP id ffacd0b85a97d-44648b510c7mr7381212f8f.17.1777396756902;
        Tue, 28 Apr 2026 10:19:16 -0700 (PDT)
Received: from localhost (p200300f65f114e083adbfb3674088b9a.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:3adb:fb36:7408:8b9a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4463ff5a1acsm7715391f8f.33.2026.04.28.10.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 10:19:16 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Krzysztof Halasa <khc@pm.waw.pl>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
	Steffen Klassert <klassert@kernel.org>,
	David Dillow <dave@thedillows.org>,
	Ion Badulescu <ionut@badula.org>,
	Mark Einon <mark.einon@gmail.com>,
	Rasesh Mody <rmody@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Sudarsana Kalluru <skalluru@marvell.com>,
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
	Simon Horman <horms@kernel.org>,
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
	Thomas Gleixner <tglx@kernel.org>,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Zilin Guan <zilin@seu.edu.cn>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yeounsu Moon <yyyynoom@gmail.com>,
	Denis Benato <benato.denis96@gmail.com>,
	Peiyang Wang <wangpeiyang1@huawei.com>,
	Yonglong Liu <liuyonglong@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Yicong Hui <yiconghui@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Sai Krishna <saikrishnag@marvell.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Joe Damato <joe@dama.to>,
	Double Lo <double.lo@cypress.com>,
	Chi-hsien Lin <chi-hsien.lin@cypress.com>,
	Colin Ian King <colin.i.king@gmail.com>,
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
Subject: [PATCH net-next] net: Consistently define pci_device_ids using named initializers
Date: Tue, 28 Apr 2026 19:18:44 +0200
Message-ID: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=149272; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=EwbblkFcDnVN3IVzEa/sMefmS+VdG8zqxs2PCD7CqHo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp8Ov130Ix57yIfvYmfS47qUtsfqdX6GvPTFsVB z55gLLoyRyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafDr9QAKCRCPgPtYfRL+ TsL0CACZbnvXyA4/jfL60lb1YcLR/ChpNwHBK4KCBfHdb0y93H07zFKyiU51DJZGDv+X45m3TsV jNDxqarDV4iFjMGQ6HDhAqNBO+AD+B5/pyVWJwzktwNBzv2ZXn9a1aT7YUbFp6GkENzAPbeSJSq ewrArcjYJ1bNVvDUEHhIYbv5Rn7/pxkNNp6ByD8zQmRgjRMKRIu/l6qd5wI2xKtRepK7vYP5SaL gKuD9CGVmiuUHA0phVvg5XlHqNBgcewG/tfprD6yQhn8y15ONxg/raCHjH1Fk878ymOdBAAv9wg PjctHm/yf0V1g8gKNCg6ENFejSxq7qt2yM555VBHchLroUGC
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 668A6489CB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19683-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,thedillows.org,badula.org,gmail.com,marvell.com,chelsio.com,huawei.com,linux.dev,intel.com,nvidia.com,mucse.com,realtek.com,resnulli.us,fr.zoreil.com,brownhat.org,tux.org,trustnetic.com,net-swift.com,farsite.co.uk,broadcom.com,bootlin.com,seu.edu.cn,suse.com,google.com,infradead.org,ti.com,dama.to,cypress.com,vger.kernel.org,lists.osuosl.org,corigine.com,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	RCPT_COUNT_GT_50(0.00)[84];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,baylibre.com:mid,baylibre.com:email,baylibre-com.20251104.gappssmtp.com:dkim]

... and PCI device helpers.

The various struct pci_device_id arrays were initialized mostly by one
the PCI_DEVICE macros and then list expressions. The latter isn't easily
readable if you're not into PCI. Using named initializers is more
explicit and thus easier to parse.

Also use PCI_DEVICE* helper macros to assign .vendor, .device,
.subvendor and .subdevice where appropriate and skip explicit
assignments of 0 (which the compiler takes care of).

The secret plan is to make struct pci_device_id::driver_data an
anonymous union (similar to
https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/)
and that requires named initializers. But it's also a nice cleanup on
its own.

This change doesn't introduce changes to the compiled pci_device_id
arrays. Tested on x86 and arm64.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

the mentioned follow-up quest allows to do

			PCI_DEVICE(0x1571, 0xa203),
	+		.driver_data = (kernel_ulong_t)&card_info_10mbit,
	-		.driver_data_ptr = &card_info_10mbit,

which gets rid of a bunch of casts and so brings a little bit more type
safety. This patch is a preparation for that.

I handled all of drivers/net/ in a single patch, please tell me if I
should split by subsystem.

Best regards
Uwe
---
 drivers/net/arcnet/com20020-pci.c             | 242 +++------
 drivers/net/can/m_can/m_can_pci.c             |   6 +-
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
 drivers/net/ethernet/intel/e100.c             |   4 +-
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
 drivers/net/ethernet/netronome/nfp/nfp_main.c |  81 +--
 .../ethernet/netronome/nfp/nfp_netvf_main.c   |  41 +-
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
 69 files changed, 1308 insertions(+), 1101 deletions(-)

diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index dbadda08dce2..6474c7be2992 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -459,168 +459,88 @@ static struct com20020_pci_card_info card_info_eae_fb2 = {
 
 static const struct pci_device_id com20020pci_id_table[] = {
 	{
-		0x1571, 0xa001,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		0,
+		PCI_DEVICE(0x1571, 0xa001),
+		.driver_data = 0,
+	}, {
+		PCI_DEVICE(0x1571, 0xa002),
+		.driver_data = 0,
+	}, {
+		PCI_DEVICE(0x1571, 0xa003),
+		.driver_data = 0,
+	}, {
+		PCI_DEVICE(0x1571, 0xa004),
+		.driver_data = 0,
+	}, {
+		PCI_DEVICE(0x1571, 0xa005),
+		.driver_data = 0,
+	}, {
+		PCI_DEVICE(0x1571, 0xa006),
+		.driver_data = 0,
+	}, {
+		PCI_DEVICE(0x1571, 0xa007),
+		.driver_data = 0,
+	}, {
+		PCI_DEVICE(0x1571, 0xa008),
+		.driver_data = 0,
+	}, {
+		PCI_DEVICE(0x1571, 0xa009),
+		.driver_data = (kernel_ulong_t)&card_info_5mbit,
+	}, {
+		PCI_DEVICE(0x1571, 0xa00a),
+		.driver_data = (kernel_ulong_t)&card_info_5mbit,
+	}, {
+		PCI_DEVICE(0x1571, 0xa00b),
+		.driver_data = (kernel_ulong_t)&card_info_5mbit,
+	}, {
+		PCI_DEVICE(0x1571, 0xa00c),
+		.driver_data = (kernel_ulong_t)&card_info_5mbit,
+	}, {
+		PCI_DEVICE(0x1571, 0xa00d),
+		.driver_data = (kernel_ulong_t)&card_info_5mbit,
+	}, {
+		PCI_DEVICE(0x1571, 0xa00e),
+		.driver_data = (kernel_ulong_t)&card_info_5mbit,
+	}, {
+		PCI_DEVICE(0x1571, 0xa201),
+		.driver_data = (kernel_ulong_t)&card_info_10mbit,
+	}, {
+		PCI_DEVICE(0x1571, 0xa202),
+		.driver_data = (kernel_ulong_t)&card_info_10mbit,
+	}, {
+		PCI_DEVICE(0x1571, 0xa203),
+		.driver_data = (kernel_ulong_t)&card_info_10mbit,
+	}, {
+		PCI_DEVICE(0x1571, 0xa204),
+		.driver_data = (kernel_ulong_t)&card_info_10mbit,
+	}, {
+		PCI_DEVICE(0x1571, 0xa205),
+		.driver_data = (kernel_ulong_t)&card_info_10mbit,
+	}, {
+		PCI_DEVICE(0x1571, 0xa206),
+		.driver_data = (kernel_ulong_t)&card_info_10mbit,
+	}, {
+		PCI_DEVICE_SUB(0x10B5, 0x9030, 0x10B5, 0x2978),
+		.driver_data = (kernel_ulong_t)&card_info_sohard,
+	}, {
+		PCI_DEVICE_SUB(0x10B5, 0x9050, 0x10B5, 0x2273),
+		.driver_data = (kernel_ulong_t)&card_info_sohard,
+	}, {
+		PCI_DEVICE_SUB(0x10B5, 0x9050, 0x10B5, 0x3263),
+		.driver_data = (kernel_ulong_t)&card_info_eae_arc1,
+	}, {
+		PCI_DEVICE_SUB(0x10B5, 0x9050, 0x10B5, 0x3292),
+		.driver_data = (kernel_ulong_t)&card_info_eae_ma1,
+	}, {
+		PCI_DEVICE_SUB(0x10B5, 0x9050, 0x10B5, 0x3294),
+		.driver_data = (kernel_ulong_t)&card_info_eae_fb2,
+	}, {
+		PCI_DEVICE(0x14BA, 0x6000),
+		.driver_data = (kernel_ulong_t)&card_info_10mbit,
+	}, {
+		PCI_DEVICE(0x10B5, 0x2200),
+		.driver_data = (kernel_ulong_t)&card_info_10mbit,
 	},
-	{
-		0x1571, 0xa002,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		0,
-	},
-	{
-		0x1571, 0xa003,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		0
-	},
-	{
-		0x1571, 0xa004,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		0,
-	},
-	{
-		0x1571, 0xa005,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		0
-	},
-	{
-		0x1571, 0xa006,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		0
-	},
-	{
-		0x1571, 0xa007,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		0
-	},
-	{
-		0x1571, 0xa008,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		0
-	},
-	{
-		0x1571, 0xa009,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		(kernel_ulong_t)&card_info_5mbit
-	},
-	{
-		0x1571, 0xa00a,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		(kernel_ulong_t)&card_info_5mbit
-	},
-	{
-		0x1571, 0xa00b,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		(kernel_ulong_t)&card_info_5mbit
-	},
-	{
-		0x1571, 0xa00c,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		(kernel_ulong_t)&card_info_5mbit
-	},
-	{
-		0x1571, 0xa00d,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		(kernel_ulong_t)&card_info_5mbit
-	},
-	{
-		0x1571, 0xa00e,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		(kernel_ulong_t)&card_info_5mbit
-	},
-	{
-		0x1571, 0xa201,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		(kernel_ulong_t)&card_info_10mbit
-	},
-	{
-		0x1571, 0xa202,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		(kernel_ulong_t)&card_info_10mbit
-	},
-	{
-		0x1571, 0xa203,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		(kernel_ulong_t)&card_info_10mbit
-	},
-	{
-		0x1571, 0xa204,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		(kernel_ulong_t)&card_info_10mbit
-	},
-	{
-		0x1571, 0xa205,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		(kernel_ulong_t)&card_info_10mbit
-	},
-	{
-		0x1571, 0xa206,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		(kernel_ulong_t)&card_info_10mbit
-	},
-	{
-		0x10B5, 0x9030,
-		0x10B5, 0x2978,
-		0, 0,
-		(kernel_ulong_t)&card_info_sohard
-	},
-	{
-		0x10B5, 0x9050,
-		0x10B5, 0x2273,
-		0, 0,
-		(kernel_ulong_t)&card_info_sohard
-	},
-	{
-		0x10B5, 0x9050,
-		0x10B5, 0x3263,
-		0, 0,
-		(kernel_ulong_t)&card_info_eae_arc1
-	},
-	{
-		0x10B5, 0x9050,
-		0x10B5, 0x3292,
-		0, 0,
-		(kernel_ulong_t)&card_info_eae_ma1
-	},
-	{
-		0x10B5, 0x9050,
-		0x10B5, 0x3294,
-		0, 0,
-		(kernel_ulong_t)&card_info_eae_fb2
-	},
-	{
-		0x14BA, 0x6000,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		(kernel_ulong_t)&card_info_10mbit
-	},
-	{
-		0x10B5, 0x2200,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		(kernel_ulong_t)&card_info_10mbit
-	},
-	{ 0, }
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, com20020pci_id_table);
diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index eb31ed1f9644..cb9335c1d3ea 100644
--- a/drivers/net/can/m_can/m_can_pci.c
+++ b/drivers/net/can/m_can/m_can_pci.c
@@ -183,9 +183,9 @@ static SIMPLE_DEV_PM_OPS(m_can_pci_pm_ops,
 			 m_can_pci_suspend, m_can_pci_resume);
 
 static const struct pci_device_id m_can_pci_id_table[] = {
-	{ PCI_VDEVICE(INTEL, 0x4bc1), M_CAN_CLOCK_FREQ_EHL, },
-	{ PCI_VDEVICE(INTEL, 0x4bc2), M_CAN_CLOCK_FREQ_EHL, },
-	{  }	/* Terminating Entry */
+	{ PCI_VDEVICE(INTEL, 0x4bc1), .driver_data = M_CAN_CLOCK_FREQ_EHL, },
+	{ PCI_VDEVICE(INTEL, 0x4bc2), .driver_data = M_CAN_CLOCK_FREQ_EHL, },
+	{ }	/* terminating entry */
 };
 MODULE_DEVICE_TABLE(pci, m_can_pci_id_table);
 
diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/plx_pci.c
index 08183833c9bc..a03553b80a5d 100644
--- a/drivers/net/can/sja1000/plx_pci.c
+++ b/drivers/net/can/sja1000/plx_pci.c
@@ -272,124 +272,89 @@ static struct plx_pci_card_info plx_pci_card_info_asem_dual_can = {
 static const struct pci_device_id plx_pci_tbl[] = {
 	{
 		/* Adlink PCI-7841/cPCI-7841 */
-		ADLINK_PCI_VENDOR_ID, ADLINK_PCI_DEVICE_ID,
-		PCI_ANY_ID, PCI_ANY_ID,
-		PCI_CLASS_NETWORK_OTHER << 8, ~0,
-		(kernel_ulong_t)&plx_pci_card_info_adlink
-	},
-	{
+		PCI_DEVICE(ADLINK_PCI_VENDOR_ID, ADLINK_PCI_DEVICE_ID),
+		.class = PCI_CLASS_NETWORK_OTHER << 8,
+		.class_mask = ~0,
+		.driver_data = (kernel_ulong_t)&plx_pci_card_info_adlink,
+	}, {
 		/* Adlink PCI-7841/cPCI-7841 SE */
-		ADLINK_PCI_VENDOR_ID, ADLINK_PCI_DEVICE_ID,
-		PCI_ANY_ID, PCI_ANY_ID,
-		PCI_CLASS_COMMUNICATION_OTHER << 8, ~0,
-		(kernel_ulong_t)&plx_pci_card_info_adlink_se
-	},
-	{
+		PCI_DEVICE(ADLINK_PCI_VENDOR_ID, ADLINK_PCI_DEVICE_ID),
+		.class = PCI_CLASS_COMMUNICATION_OTHER << 8,
+		.class_mask = ~0,
+		.driver_data = (kernel_ulong_t)&plx_pci_card_info_adlink_se,
+	}, {
 		/* esd CAN-PCI/200 */
-		PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
-		PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PCI200,
-		0, 0,
-		(kernel_ulong_t)&plx_pci_card_info_esd200
-	},
-	{
+		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9050,
+				PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PCI200),
+		.driver_data = (kernel_ulong_t)&plx_pci_card_info_esd200,
+	}, {
 		/* esd CAN-CPCI/200 */
-		PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
-		PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_CPCI200,
-		0, 0,
-		(kernel_ulong_t)&plx_pci_card_info_esd200
-	},
-	{
+		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9030,
+				PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_CPCI200),
+		.driver_data = (kernel_ulong_t)&plx_pci_card_info_esd200,
+	}, {
 		/* esd CAN-PCI104/200 */
-		PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
-		PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PCI104200,
-		0, 0,
-		(kernel_ulong_t)&plx_pci_card_info_esd200
-	},
-	{
+		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9030,
+				PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PCI104200),
+		.driver_data = (kernel_ulong_t)&plx_pci_card_info_esd200,
+	}, {
 		/* esd CAN-PCI/266 */
-		PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9056,
-		PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PCI266,
-		0, 0,
-		(kernel_ulong_t)&plx_pci_card_info_esd266
-	},
-	{
+		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9056,
+				PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PCI266),
+		.driver_data = (kernel_ulong_t)&plx_pci_card_info_esd266,
+	}, {
 		/* esd CAN-PMC/266 */
-		PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9056,
-		PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PMC266,
-		0, 0,
-		(kernel_ulong_t)&plx_pci_card_info_esd266
-	},
-	{
+		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9056,
+				PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PMC266),
+		.driver_data = (kernel_ulong_t)&plx_pci_card_info_esd266,
+	}, {
 		/* esd CAN-PCIE/2000 */
-		PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9056,
-		PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PCIE2000,
-		0, 0,
-		(kernel_ulong_t)&plx_pci_card_info_esd2000
-	},
-	{
+		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9056,
+				PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PCIE2000),
+		.driver_data = (kernel_ulong_t)&plx_pci_card_info_esd2000,
+	}, {
 		/* IXXAT PC-I 04/PCI card */
-		IXXAT_PCI_VENDOR_ID, IXXAT_PCI_DEVICE_ID,
-		PCI_ANY_ID, IXXAT_PCI_SUB_SYS_ID,
-		0, 0,
-		(kernel_ulong_t)&plx_pci_card_info_ixxat
-	},
-	{
+		PCI_DEVICE_SUB(IXXAT_PCI_VENDOR_ID, IXXAT_PCI_DEVICE_ID,
+			       PCI_ANY_ID, IXXAT_PCI_SUB_SYS_ID),
+		.driver_data = (kernel_ulong_t)&plx_pci_card_info_ixxat,
+	}, {
 		/* Marathon CAN-bus-PCI card */
-		PCI_VENDOR_ID_PLX, MARATHON_PCI_DEVICE_ID,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		(kernel_ulong_t)&plx_pci_card_info_marathon_pci
-	},
-	{
+		PCI_VDEVICE(PLX, MARATHON_PCI_DEVICE_ID),
+		.driver_data = (kernel_ulong_t)&plx_pci_card_info_marathon_pci,
+	}, {
 		/* Marathon CAN-bus-PCIe card */
-		PCI_VENDOR_ID_PLX, MARATHON_PCIE_DEVICE_ID,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		(kernel_ulong_t)&plx_pci_card_info_marathon_pcie
-	},
-	{
+		PCI_VDEVICE(PLX, MARATHON_PCIE_DEVICE_ID),
+		.driver_data = (kernel_ulong_t)&plx_pci_card_info_marathon_pcie,
+	}, {
 		/* TEWS TECHNOLOGIES TPMC810 card */
-		TEWS_PCI_VENDOR_ID, TEWS_PCI_DEVICE_ID_TMPC810,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		(kernel_ulong_t)&plx_pci_card_info_tews
-	},
-	{
+		PCI_DEVICE(TEWS_PCI_VENDOR_ID, TEWS_PCI_DEVICE_ID_TMPC810),
+		.driver_data = (kernel_ulong_t)&plx_pci_card_info_tews,
+	}, {
 		/* Connect Tech Inc. CANpro/104-Plus Opto (CRG001) card */
-		PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
-		PCI_SUBVENDOR_ID_CONNECT_TECH, CTI_PCI_DEVICE_ID_CRG001,
-		0, 0,
-		(kernel_ulong_t)&plx_pci_card_info_cti
-	},
-	{
+		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9030,
+				PCI_SUBVENDOR_ID_CONNECT_TECH, CTI_PCI_DEVICE_ID_CRG001),
+		.driver_data = (kernel_ulong_t)&plx_pci_card_info_cti,
+	}, {
 		/* Elcus CAN-200-PCI */
-		CAN200PCI_VENDOR_ID, CAN200PCI_DEVICE_ID,
-		CAN200PCI_SUB_VENDOR_ID, CAN200PCI_SUB_DEVICE_ID,
-		0, 0,
-		(kernel_ulong_t)&plx_pci_card_info_elcus
-	},
-	{
+		PCI_DEVICE_SUB(CAN200PCI_VENDOR_ID, CAN200PCI_DEVICE_ID,
+			       CAN200PCI_SUB_VENDOR_ID, CAN200PCI_SUB_DEVICE_ID),
+		.driver_data = (kernel_ulong_t)&plx_pci_card_info_elcus,
+	}, {
 		/* moxa */
-		MOXA_PCI_VENDOR_ID, MOXA_PCI_DEVICE_ID,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		(kernel_ulong_t)&plx_pci_card_info_moxa
-	},
-	{
+		PCI_DEVICE(MOXA_PCI_VENDOR_ID, MOXA_PCI_DEVICE_ID),
+		.driver_data = (kernel_ulong_t)&plx_pci_card_info_moxa,
+	}, {
 		/* ASEM Dual CAN raw */
-		ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DEVICE_ID,
-		ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CAN_SUB_DEVICE_ID,
-		0, 0,
-		(kernel_ulong_t)&plx_pci_card_info_asem_dual_can
-	},
-	{
+		PCI_DEVICE_SUB(ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DEVICE_ID,
+			       ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CAN_SUB_DEVICE_ID),
+		.driver_data = (kernel_ulong_t)&plx_pci_card_info_asem_dual_can,
+	}, {
 		/* ASEM Dual CAN raw -new model */
-		ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DEVICE_ID,
-		ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CAN_SUB_DEVICE_ID_BIS,
-		0, 0,
-		(kernel_ulong_t)&plx_pci_card_info_asem_dual_can
+		PCI_DEVICE_SUB(ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DEVICE_ID,
+			       ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CAN_SUB_DEVICE_ID_BIS),
+		.driver_data = (kernel_ulong_t)&plx_pci_card_info_asem_dual_can,
 	},
-	{ 0,}
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, plx_pci_tbl);
 
diff --git a/drivers/net/ethernet/3com/3c59x.c b/drivers/net/ethernet/3com/3c59x.c
index 4fe4efdb3737..79beb86437df 100644
--- a/drivers/net/ethernet/3com/3c59x.c
+++ b/drivers/net/ethernet/3com/3c59x.c
@@ -376,54 +376,54 @@ static struct vortex_chip_info {
 
 
 static const struct pci_device_id vortex_pci_tbl[] = {
-	{ 0x10B7, 0x5900, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C590 },
-	{ 0x10B7, 0x5920, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C592 },
-	{ 0x10B7, 0x5970, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C597 },
-	{ 0x10B7, 0x5950, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C595_1 },
-	{ 0x10B7, 0x5951, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C595_2 },
+	{ PCI_DEVICE(0x10B7, 0x5900), .driver_data = CH_3C590 },
+	{ PCI_DEVICE(0x10B7, 0x5920), .driver_data = CH_3C592 },
+	{ PCI_DEVICE(0x10B7, 0x5970), .driver_data = CH_3C597 },
+	{ PCI_DEVICE(0x10B7, 0x5950), .driver_data = CH_3C595_1 },
+	{ PCI_DEVICE(0x10B7, 0x5951), .driver_data = CH_3C595_2 },
 
-	{ 0x10B7, 0x5952, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C595_3 },
-	{ 0x10B7, 0x9000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C900_1 },
-	{ 0x10B7, 0x9001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C900_2 },
-	{ 0x10B7, 0x9004, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C900_3 },
-	{ 0x10B7, 0x9005, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C900_4 },
+	{ PCI_DEVICE(0x10B7, 0x5952), .driver_data = CH_3C595_3 },
+	{ PCI_DEVICE(0x10B7, 0x9000), .driver_data = CH_3C900_1 },
+	{ PCI_DEVICE(0x10B7, 0x9001), .driver_data = CH_3C900_2 },
+	{ PCI_DEVICE(0x10B7, 0x9004), .driver_data = CH_3C900_3 },
+	{ PCI_DEVICE(0x10B7, 0x9005), .driver_data = CH_3C900_4 },
 
-	{ 0x10B7, 0x9006, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C900_5 },
-	{ 0x10B7, 0x900A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C900B_FL },
-	{ 0x10B7, 0x9050, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C905_1 },
-	{ 0x10B7, 0x9051, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C905_2 },
-	{ 0x10B7, 0x9054, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C905B_TX },
-	{ 0x10B7, 0x9055, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C905B_1 },
+	{ PCI_DEVICE(0x10B7, 0x9006), .driver_data = CH_3C900_5 },
+	{ PCI_DEVICE(0x10B7, 0x900A), .driver_data = CH_3C900B_FL },
+	{ PCI_DEVICE(0x10B7, 0x9050), .driver_data = CH_3C905_1 },
+	{ PCI_DEVICE(0x10B7, 0x9051), .driver_data = CH_3C905_2 },
+	{ PCI_DEVICE(0x10B7, 0x9054), .driver_data = CH_3C905B_TX },
+	{ PCI_DEVICE(0x10B7, 0x9055), .driver_data = CH_3C905B_1 },
 
-	{ 0x10B7, 0x9058, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C905B_2 },
-	{ 0x10B7, 0x905A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C905B_FX },
-	{ 0x10B7, 0x9200, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C905C },
-	{ 0x10B7, 0x9202, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C9202 },
-	{ 0x10B7, 0x9800, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C980 },
-	{ 0x10B7, 0x9805, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C9805 },
+	{ PCI_DEVICE(0x10B7, 0x9058), .driver_data = CH_3C905B_2 },
+	{ PCI_DEVICE(0x10B7, 0x905A), .driver_data = CH_3C905B_FX },
+	{ PCI_DEVICE(0x10B7, 0x9200), .driver_data = CH_3C905C },
+	{ PCI_DEVICE(0x10B7, 0x9202), .driver_data = CH_3C9202 },
+	{ PCI_DEVICE(0x10B7, 0x9800), .driver_data = CH_3C980 },
+	{ PCI_DEVICE(0x10B7, 0x9805), .driver_data = CH_3C9805 },
 
-	{ 0x10B7, 0x7646, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3CSOHO100_TX },
-	{ 0x10B7, 0x5055, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C555 },
-	{ 0x10B7, 0x6055, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C556 },
-	{ 0x10B7, 0x6056, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C556B },
-	{ 0x10B7, 0x5b57, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C575 },
+	{ PCI_DEVICE(0x10B7, 0x7646), .driver_data = CH_3CSOHO100_TX },
+	{ PCI_DEVICE(0x10B7, 0x5055), .driver_data = CH_3C555 },
+	{ PCI_DEVICE(0x10B7, 0x6055), .driver_data = CH_3C556 },
+	{ PCI_DEVICE(0x10B7, 0x6056), .driver_data = CH_3C556B },
+	{ PCI_DEVICE(0x10B7, 0x5b57), .driver_data = CH_3C575 },
 
-	{ 0x10B7, 0x5057, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C575_1 },
-	{ 0x10B7, 0x5157, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3CCFE575 },
-	{ 0x10B7, 0x5257, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3CCFE575CT },
-	{ 0x10B7, 0x6560, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3CCFE656 },
-	{ 0x10B7, 0x6562, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3CCFEM656 },
+	{ PCI_DEVICE(0x10B7, 0x5057), .driver_data = CH_3C575_1 },
+	{ PCI_DEVICE(0x10B7, 0x5157), .driver_data = CH_3CCFE575 },
+	{ PCI_DEVICE(0x10B7, 0x5257), .driver_data = CH_3CCFE575CT },
+	{ PCI_DEVICE(0x10B7, 0x6560), .driver_data = CH_3CCFE656 },
+	{ PCI_DEVICE(0x10B7, 0x6562), .driver_data = CH_3CCFEM656 },
 
-	{ 0x10B7, 0x6564, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3CCFEM656_1 },
-	{ 0x10B7, 0x4500, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C450 },
-	{ 0x10B7, 0x9201, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C920 },
-	{ 0x10B7, 0x1201, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C982A },
-	{ 0x10B7, 0x1202, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C982B },
+	{ PCI_DEVICE(0x10B7, 0x6564), .driver_data = CH_3CCFEM656_1 },
+	{ PCI_DEVICE(0x10B7, 0x4500), .driver_data = CH_3C450 },
+	{ PCI_DEVICE(0x10B7, 0x9201), .driver_data = CH_3C920 },
+	{ PCI_DEVICE(0x10B7, 0x1201), .driver_data = CH_3C982A },
+	{ PCI_DEVICE(0x10B7, 0x1202), .driver_data = CH_3C982B },
 
-	{ 0x10B7, 0x9056, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_905BT4 },
-	{ 0x10B7, 0x9210, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_920B_EMB_WNM },
+	{ PCI_DEVICE(0x10B7, 0x9056), .driver_data = CH_905BT4 },
+	{ PCI_DEVICE(0x10B7, 0x9210), .driver_data = CH_920B_EMB_WNM },
 
-	{0,}						/* 0 terminated list. */
+	{ }						/* 0 terminated list. */
 };
 MODULE_DEVICE_TABLE(pci, vortex_pci_tbl);
 
diff --git a/drivers/net/ethernet/3com/typhoon.c b/drivers/net/ethernet/3com/typhoon.c
index aaaff3ba43ef..fadc86907ec2 100644
--- a/drivers/net/ethernet/3com/typhoon.c
+++ b/drivers/net/ethernet/3com/typhoon.c
@@ -198,33 +198,54 @@ static struct typhoon_card_info typhoon_card_info[] = {
  * bits 12-16 indicate card type: (0) client and (1) server
  */
 static const struct pci_device_id typhoon_pci_tbl[] = {
-	{ PCI_VENDOR_ID_3COM, PCI_DEVICE_ID_3COM_3CR990,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0,TYPHOON_TX },
-	{ PCI_VENDOR_ID_3COM, PCI_DEVICE_ID_3COM_3CR990_TX_95,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPHOON_TX95 },
-	{ PCI_VENDOR_ID_3COM, PCI_DEVICE_ID_3COM_3CR990_TX_97,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPHOON_TX97 },
-	{ PCI_VENDOR_ID_3COM, PCI_DEVICE_ID_3COM_3CR990B,
-	  PCI_ANY_ID, 0x1000, 0, 0, TYPHOON_TXM },
-	{ PCI_VENDOR_ID_3COM, PCI_DEVICE_ID_3COM_3CR990B,
-	  PCI_ANY_ID, 0x1102, 0, 0, TYPHOON_FXM },
-	{ PCI_VENDOR_ID_3COM, PCI_DEVICE_ID_3COM_3CR990B,
-	  PCI_ANY_ID, 0x2000, 0, 0, TYPHOON_BSVR },
-	{ PCI_VENDOR_ID_3COM, PCI_DEVICE_ID_3COM_3CR990_FX,
-	  PCI_ANY_ID, 0x1101, 0, 0, TYPHOON_FX95 },
-	{ PCI_VENDOR_ID_3COM, PCI_DEVICE_ID_3COM_3CR990_FX,
-	  PCI_ANY_ID, 0x1102, 0, 0, TYPHOON_FX97 },
-	{ PCI_VENDOR_ID_3COM, PCI_DEVICE_ID_3COM_3CR990_FX,
-	  PCI_ANY_ID, 0x2101, 0, 0, TYPHOON_FX95SVR },
-	{ PCI_VENDOR_ID_3COM, PCI_DEVICE_ID_3COM_3CR990_FX,
-	  PCI_ANY_ID, 0x2102, 0, 0, TYPHOON_FX97SVR },
-	{ PCI_VENDOR_ID_3COM, PCI_DEVICE_ID_3COM_3CR990SVR95,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPHOON_SVR95 },
-	{ PCI_VENDOR_ID_3COM, PCI_DEVICE_ID_3COM_3CR990SVR97,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPHOON_SVR97 },
-	{ PCI_VENDOR_ID_3COM, PCI_DEVICE_ID_3COM_3CR990SVR,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPHOON_SVR },
-	{ 0, }
+	{
+		PCI_VDEVICE(3COM, PCI_DEVICE_ID_3COM_3CR990),
+		.driver_data = TYPHOON_TX,
+	}, {
+		PCI_VDEVICE(3COM, PCI_DEVICE_ID_3COM_3CR990_TX_95),
+		.driver_data = TYPHOON_TX95,
+	}, {
+		PCI_VDEVICE(3COM, PCI_DEVICE_ID_3COM_3CR990_TX_97),
+		.driver_data = TYPHOON_TX97,
+	}, {
+		PCI_VDEVICE_SUB(3COM, PCI_DEVICE_ID_3COM_3CR990B,
+				PCI_ANY_ID, 0x1000),
+		.driver_data = TYPHOON_TXM,
+	}, {
+		PCI_VDEVICE_SUB(3COM, PCI_DEVICE_ID_3COM_3CR990B,
+				PCI_ANY_ID, 0x1102),
+		.driver_data = TYPHOON_FXM,
+	}, {
+		PCI_VDEVICE_SUB(3COM, PCI_DEVICE_ID_3COM_3CR990B,
+				PCI_ANY_ID, 0x2000),
+		.driver_data = TYPHOON_BSVR,
+	}, {
+		PCI_VDEVICE_SUB(3COM, PCI_DEVICE_ID_3COM_3CR990_FX,
+				PCI_ANY_ID, 0x1101),
+		.driver_data = TYPHOON_FX95,
+	}, {
+		PCI_VDEVICE_SUB(3COM, PCI_DEVICE_ID_3COM_3CR990_FX,
+				PCI_ANY_ID, 0x1102),
+		.driver_data = TYPHOON_FX97,
+	}, {
+		PCI_VDEVICE_SUB(3COM, PCI_DEVICE_ID_3COM_3CR990_FX,
+				PCI_ANY_ID, 0x2101),
+		.driver_data = TYPHOON_FX95SVR,
+	}, {
+		PCI_VDEVICE_SUB(3COM, PCI_DEVICE_ID_3COM_3CR990_FX,
+				PCI_ANY_ID, 0x2102),
+		.driver_data = TYPHOON_FX97SVR,
+	}, {
+		PCI_VDEVICE(3COM, PCI_DEVICE_ID_3COM_3CR990SVR95),
+		.driver_data = TYPHOON_SVR95,
+	}, {
+		PCI_VDEVICE(3COM, PCI_DEVICE_ID_3COM_3CR990SVR97),
+		.driver_data = TYPHOON_SVR97,
+	}, {
+		PCI_VDEVICE(3COM, PCI_DEVICE_ID_3COM_3CR990SVR),
+		.driver_data = TYPHOON_SVR,
+	},
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, typhoon_pci_tbl);
 
diff --git a/drivers/net/ethernet/8390/ne2k-pci.c b/drivers/net/ethernet/8390/ne2k-pci.c
index 1a34da07c0db..b1a94c97c0b9 100644
--- a/drivers/net/ethernet/8390/ne2k-pci.c
+++ b/drivers/net/ethernet/8390/ne2k-pci.c
@@ -143,18 +143,18 @@ static struct {
 
 
 static const struct pci_device_id ne2k_pci_tbl[] = {
-	{ 0x10ec, 0x8029, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_RealTek_RTL_8029 },
-	{ 0x1050, 0x0940, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_Winbond_89C940 },
-	{ 0x11f6, 0x1401, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_Compex_RL2000 },
-	{ 0x8e2e, 0x3000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_KTI_ET32P2 },
-	{ 0x4a14, 0x5000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_NetVin_NV5000SC },
-	{ 0x1106, 0x0926, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_Via_86C926 },
-	{ 0x10bd, 0x0e34, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_SureCom_NE34 },
-	{ 0x1050, 0x5a5a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_Winbond_W89C940F },
-	{ 0x12c3, 0x0058, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_Holtek_HT80232 },
-	{ 0x12c3, 0x5598, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_Holtek_HT80229 },
-	{ 0x8c4a, 0x1980, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_Winbond_89C940_8c4a },
-	{ 0, }
+	{ PCI_DEVICE(0x10ec, 0x8029), .driver_data = CH_RealTek_RTL_8029 },
+	{ PCI_DEVICE(0x1050, 0x0940), .driver_data = CH_Winbond_89C940 },
+	{ PCI_DEVICE(0x11f6, 0x1401), .driver_data = CH_Compex_RL2000 },
+	{ PCI_DEVICE(0x8e2e, 0x3000), .driver_data = CH_KTI_ET32P2 },
+	{ PCI_DEVICE(0x4a14, 0x5000), .driver_data = CH_NetVin_NV5000SC },
+	{ PCI_DEVICE(0x1106, 0x0926), .driver_data = CH_Via_86C926 },
+	{ PCI_DEVICE(0x10bd, 0x0e34), .driver_data = CH_SureCom_NE34 },
+	{ PCI_DEVICE(0x1050, 0x5a5a), .driver_data = CH_Winbond_W89C940F },
+	{ PCI_DEVICE(0x12c3, 0x0058), .driver_data = CH_Holtek_HT80232 },
+	{ PCI_DEVICE(0x12c3, 0x5598), .driver_data = CH_Holtek_HT80229 },
+	{ PCI_DEVICE(0x8c4a, 0x1980), .driver_data = CH_Winbond_89C940_8c4a },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, ne2k_pci_tbl);
diff --git a/drivers/net/ethernet/adaptec/starfire.c b/drivers/net/ethernet/adaptec/starfire.c
index e1b8794b14c9..f1109d90e1fc 100644
--- a/drivers/net/ethernet/adaptec/starfire.c
+++ b/drivers/net/ethernet/adaptec/starfire.c
@@ -278,8 +278,8 @@ enum chipset {
 };
 
 static const struct pci_device_id starfire_pci_tbl[] = {
-	{ PCI_VDEVICE(ADAPTEC, 0x6915), CH_6915 },
-	{ 0, }
+	{ PCI_VDEVICE(ADAPTEC, 0x6915), .driver_data = CH_6915 },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, starfire_pci_tbl);
 
diff --git a/drivers/net/ethernet/agere/et131x.c b/drivers/net/ethernet/agere/et131x.c
index 0f6e5373029a..1b465a167672 100644
--- a/drivers/net/ethernet/agere/et131x.c
+++ b/drivers/net/ethernet/agere/et131x.c
@@ -4084,9 +4084,9 @@ static int et131x_pci_setup(struct pci_dev *pdev,
 }
 
 static const struct pci_device_id et131x_pci_table[] = {
-	{ PCI_VDEVICE(ATT, ET131X_PCI_DEVICE_ID_GIG), 0UL},
-	{ PCI_VDEVICE(ATT, ET131X_PCI_DEVICE_ID_FAST), 0UL},
-	{ 0,}
+	{ PCI_VDEVICE(ATT, ET131X_PCI_DEVICE_ID_GIG) },
+	{ PCI_VDEVICE(ATT, ET131X_PCI_DEVICE_ID_FAST) },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, et131x_pci_table);
 
diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
index f5722e929833..3e2fd2939e87 100644
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -115,29 +115,45 @@ static struct {
 	};
 
 static const struct pci_device_id bnx2_pci_tbl[] = {
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_NX2_5706,
-	  PCI_VENDOR_ID_HP, 0x3101, 0, 0, NC370T },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_NX2_5706,
-	  PCI_VENDOR_ID_HP, 0x3106, 0, 0, NC370I },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_NX2_5706,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, BCM5706 },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_NX2_5708,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, BCM5708 },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_NX2_5706S,
-	  PCI_VENDOR_ID_HP, 0x3102, 0, 0, NC370F },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_NX2_5706S,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, BCM5706S },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_NX2_5708S,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, BCM5708S },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_NX2_5709,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, BCM5709 },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_NX2_5709S,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, BCM5709S },
-	{ PCI_VENDOR_ID_BROADCOM, 0x163b,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, BCM5716 },
-	{ PCI_VENDOR_ID_BROADCOM, 0x163c,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, BCM5716S },
-	{ 0, }
+	{
+		PCI_VDEVICE_SUB(BROADCOM, PCI_DEVICE_ID_NX2_5706,
+				PCI_VENDOR_ID_HP, 0x3101),
+		.driver_data = NC370T,
+	}, {
+		PCI_VDEVICE_SUB(BROADCOM, PCI_DEVICE_ID_NX2_5706,
+				PCI_VENDOR_ID_HP, 0x3106),
+		.driver_data = NC370I,
+	}, {
+		PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_5706),
+		.driver_data = BCM5706,
+	}, {
+		PCI_VDEVICE_SUB(BROADCOM, PCI_DEVICE_ID_NX2_5708,
+				PCI_ANY_ID, PCI_ANY_ID),
+		.driver_data = BCM5708,
+	}, {
+		PCI_VDEVICE_SUB(BROADCOM, PCI_DEVICE_ID_NX2_5706S,
+				PCI_VENDOR_ID_HP, 0x3102),
+		.driver_data = NC370F,
+	}, {
+		PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_5706S),
+		.driver_data = BCM5706S,
+	}, {
+		PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_5708S),
+		.driver_data = BCM5708S,
+	}, {
+		PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_5709),
+		.driver_data = BCM5709,
+	}, {
+		PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_5709S),
+		.driver_data = BCM5709S,
+	}, {
+		PCI_VDEVICE(BROADCOM, 0x163b),
+		.driver_data = BCM5716,
+	}, {
+		PCI_VDEVICE(BROADCOM, 0x163c),
+		.driver_data = BCM5716S,
+	},
+	{ }
 };
 
 static const struct flash_spec flash_table[] =
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index da0f8c353e6a..6f96645ff23f 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -259,31 +259,31 @@ static struct {
 #endif
 
 static const struct pci_device_id bnx2x_pci_tbl[] = {
-	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57710), BCM57710 },
-	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57711), BCM57711 },
-	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57711E), BCM57711E },
-	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57712), BCM57712 },
-	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57712_MF), BCM57712_MF },
-	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57712_VF), BCM57712_VF },
-	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57800), BCM57800 },
-	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57800_MF), BCM57800_MF },
-	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57800_VF), BCM57800_VF },
-	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57810), BCM57810 },
-	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57810_MF), BCM57810_MF },
-	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57840_O), BCM57840_O },
-	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57840_4_10), BCM57840_4_10 },
-	{ PCI_VDEVICE(QLOGIC,	PCI_DEVICE_ID_NX2_57840_4_10), BCM57840_4_10 },
-	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57840_2_20), BCM57840_2_20 },
-	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57810_VF), BCM57810_VF },
-	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57840_MFO), BCM57840_MFO },
-	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57840_MF), BCM57840_MF },
-	{ PCI_VDEVICE(QLOGIC,	PCI_DEVICE_ID_NX2_57840_MF), BCM57840_MF },
-	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57840_VF), BCM57840_VF },
-	{ PCI_VDEVICE(QLOGIC,	PCI_DEVICE_ID_NX2_57840_VF), BCM57840_VF },
-	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57811), BCM57811 },
-	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57811_MF), BCM57811_MF },
-	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57811_VF), BCM57811_VF },
-	{ 0 }
+	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57710), .driver_data = BCM57710 },
+	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57711), .driver_data = BCM57711 },
+	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57711E), .driver_data = BCM57711E },
+	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57712), .driver_data = BCM57712 },
+	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57712_MF), .driver_data = BCM57712_MF },
+	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57712_VF), .driver_data = BCM57712_VF },
+	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57800), .driver_data = BCM57800 },
+	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57800_MF), .driver_data = BCM57800_MF },
+	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57800_VF), .driver_data = BCM57800_VF },
+	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57810), .driver_data = BCM57810 },
+	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57810_MF), .driver_data = BCM57810_MF },
+	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57840_O), .driver_data = BCM57840_O },
+	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57840_4_10), .driver_data = BCM57840_4_10 },
+	{ PCI_VDEVICE(QLOGIC,	PCI_DEVICE_ID_NX2_57840_4_10), .driver_data = BCM57840_4_10 },
+	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57840_2_20), .driver_data = BCM57840_2_20 },
+	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57810_VF), .driver_data = BCM57810_VF },
+	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57840_MFO), .driver_data = BCM57840_MFO },
+	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57840_MF), .driver_data = BCM57840_MF },
+	{ PCI_VDEVICE(QLOGIC,	PCI_DEVICE_ID_NX2_57840_MF), .driver_data = BCM57840_MF },
+	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57840_VF), .driver_data = BCM57840_VF },
+	{ PCI_VDEVICE(QLOGIC,	PCI_DEVICE_ID_NX2_57840_VF), .driver_data = BCM57840_VF },
+	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57811), .driver_data = BCM57811 },
+	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57811_MF), .driver_data = BCM57811_MF },
+	{ PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_NX2_57811_VF), .driver_data = BCM57811_VF },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, bnx2x_pci_tbl);
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index c1a3df225254..353b2d23396e 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -404,17 +404,15 @@ static const struct pci_error_handlers liquidio_err_handler = {
 
 static const struct pci_device_id liquidio_pci_tbl[] = {
 	{       /* 68xx */
-		PCI_VENDOR_ID_CAVIUM, 0x91, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0
+		PCI_VDEVICE(CAVIUM, 0x91)
 	},
 	{       /* 66xx */
-		PCI_VENDOR_ID_CAVIUM, 0x92, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0
+		PCI_VDEVICE(CAVIUM, 0x92)
 	},
 	{       /* 23xx pf */
-		PCI_VENDOR_ID_CAVIUM, 0x9702, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0
+		PCI_VDEVICE(CAVIUM, 0x9702)
 	},
-	{
-		0, 0, 0, 0, 0, 0, 0
-	}
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, liquidio_pci_tbl);
 
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index 43c595f3b84e..36255352e7ea 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -237,12 +237,9 @@ static const struct pci_error_handlers liquidio_vf_err_handler = {
 
 static const struct pci_device_id liquidio_vf_pci_tbl[] = {
 	{
-		PCI_VENDOR_ID_CAVIUM, OCTEON_CN23XX_VF_VID,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0
+		PCI_VDEVICE(CAVIUM, OCTEON_CN23XX_VF_VID),
 	},
-	{
-		0, 0, 0, 0, 0, 0, 0
-	}
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, liquidio_vf_pci_tbl);
 
diff --git a/drivers/net/ethernet/chelsio/cxgb/common.h b/drivers/net/ethernet/chelsio/cxgb/common.h
index 304bb282ab03..292f8ec248e2 100644
--- a/drivers/net/ethernet/chelsio/cxgb/common.h
+++ b/drivers/net/ethernet/chelsio/cxgb/common.h
@@ -48,7 +48,7 @@
 #define DRV_NAME "cxgb"
 
 #define CH_DEVICE(devid, ssid, idx) \
-	{ PCI_VENDOR_ID_CHELSIO, devid, PCI_ANY_ID, ssid, 0, 0, idx }
+	{ PCI_VDEVICE_SUB(CHELSIO, devid, PCI_ANY_ID, ssid), .driver_data = idx }
 
 #define SUPPORTED_PAUSE       (1 << 13)
 #define SUPPORTED_LOOPBACK    (1 << 15)
diff --git a/drivers/net/ethernet/chelsio/cxgb/subr.c b/drivers/net/ethernet/chelsio/cxgb/subr.c
index 367a9e4581d5..d4488e400bc6 100644
--- a/drivers/net/ethernet/chelsio/cxgb/subr.c
+++ b/drivers/net/ethernet/chelsio/cxgb/subr.c
@@ -533,7 +533,7 @@ const struct pci_device_id t1_pci_tbl[] = {
 	CH_DEVICE(11, 1, CH_BRD_T210_1F),
 	CH_DEVICE(14, 1, CH_BRD_T210_1CU),
 	CH_DEVICE(16, 1, CH_BRD_N204_4CU),
-	{ 0 }
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, t1_pci_tbl);
diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
index 88b6d76817e9..3bee82bc0680 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -83,7 +83,7 @@ enum {
 #define EEPROM_MAGIC 0x38E2F10C
 
 #define CH_DEVICE(devid, idx) \
-	{ PCI_VENDOR_ID_CHELSIO, devid, PCI_ANY_ID, PCI_ANY_ID, 0, 0, idx }
+	{ PCI_VDEVICE(CHELSIO, devid), .driver_data = idx }
 
 static const struct pci_device_id cxgb3_pci_tbl[] = {
 	CH_DEVICE(0x20, 0),	/* PE9000 */
@@ -99,7 +99,7 @@ static const struct pci_device_id cxgb3_pci_tbl[] = {
 	CH_DEVICE(0x35, 6),	/* T3C20-derived T3C10 */
 	CH_DEVICE(0x36, 3),	/* S320E-CR */
 	CH_DEVICE(0x37, 7),	/* N320E-G2 */
-	{0,}
+	{ }
 };
 
 MODULE_DESCRIPTION(DRV_DESC);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 10694d5924ee..6df98fca932f 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -112,10 +112,10 @@ char cxgb4_driver_name[] = KBUILD_MODNAME;
 #define CH_PCI_DEVICE_ID_FUNCTION2 0x0
 
 #define CH_PCI_ID_TABLE_ENTRY(devid) \
-		{PCI_VDEVICE(CHELSIO, (devid)), CXGB4_UNIFIED_PF}
+		{ PCI_VDEVICE(CHELSIO, (devid)), .driver_data = CXGB4_UNIFIED_PF }
 
 #define CH_PCI_DEVICE_ID_TABLE_DEFINE_END \
-		{ 0, } \
+		{ } \
 	}
 
 #include "t4_pci_id_tbl.h"
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
index 9eaa9aadee33..b35a54982b6d 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
@@ -3388,9 +3388,9 @@ static void cxgb4vf_pci_shutdown(struct pci_dev *pdev)
 #define CH_PCI_DEVICE_ID_FUNCTION	0x8
 
 #define CH_PCI_ID_TABLE_ENTRY(devid) \
-		{ PCI_VDEVICE(CHELSIO, (devid)), 0 }
+		{ PCI_VDEVICE(CHELSIO, (devid)), .driver_data = 0 }
 
-#define CH_PCI_DEVICE_ID_TABLE_DEFINE_END { 0, } }
+#define CH_PCI_DEVICE_ID_TABLE_DEFINE_END { } }
 
 #include "../cxgb4/t4_pci_id_tbl.h"
 
diff --git a/drivers/net/ethernet/dec/tulip/de2104x.c b/drivers/net/ethernet/dec/tulip/de2104x.c
index f9504f340c4a..f38a10c79907 100644
--- a/drivers/net/ethernet/dec/tulip/de2104x.c
+++ b/drivers/net/ethernet/dec/tulip/de2104x.c
@@ -333,10 +333,8 @@ static unsigned int de_ok_to_advertise (struct de_private *de, u32 new_media);
 
 
 static const struct pci_device_id de_pci_tbl[] = {
-	{ PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_TULIP,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_TULIP_PLUS,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1 },
+	{ PCI_VDEVICE(DEC, PCI_DEVICE_ID_DEC_TULIP), .driver_data = 0 },
+	{ PCI_VDEVICE(DEC, PCI_DEVICE_ID_DEC_TULIP_PLUS), .driver_data = 1 },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, de_pci_tbl);
diff --git a/drivers/net/ethernet/dec/tulip/dmfe.c b/drivers/net/ethernet/dec/tulip/dmfe.c
index 2d3bd343b6e6..dabc091a0c66 100644
--- a/drivers/net/ethernet/dec/tulip/dmfe.c
+++ b/drivers/net/ethernet/dec/tulip/dmfe.c
@@ -2076,11 +2076,11 @@ static void dmfe_HPNA_remote_cmd_chk(struct dmfe_board_info * db)
 
 
 static const struct pci_device_id dmfe_pci_tbl[] = {
-	{ 0x1282, 0x9132, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCI_DM9132_ID },
-	{ 0x1282, 0x9102, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCI_DM9102_ID },
-	{ 0x1282, 0x9100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCI_DM9100_ID },
-	{ 0x1282, 0x9009, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCI_DM9009_ID },
-	{ 0, }
+	{ PCI_DEVICE(0x1282, 0x9132), .driver_data = PCI_DM9132_ID },
+	{ PCI_DEVICE(0x1282, 0x9102), .driver_data = PCI_DM9102_ID },
+	{ PCI_DEVICE(0x1282, 0x9100), .driver_data = PCI_DM9100_ID },
+	{ PCI_DEVICE(0x1282, 0x9009), .driver_data = PCI_DM9009_ID },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, dmfe_pci_tbl);
 
@@ -2101,7 +2101,7 @@ static int __maybe_unused dmfe_suspend(struct device *dev_d)
 	dw32(DCR7, 0);
 	dw32(DCR5, dr32(DCR5));
 
-	/* Fre RX buffers */
+	/* Free RX buffers */
 	dmfe_free_rxbuffer(db);
 
 	/* Enable WOL */
diff --git a/drivers/net/ethernet/dec/tulip/tulip_core.c b/drivers/net/ethernet/dec/tulip/tulip_core.c
index b608585f1954..a7200eb66594 100644
--- a/drivers/net/ethernet/dec/tulip/tulip_core.c
+++ b/drivers/net/ethernet/dec/tulip/tulip_core.c
@@ -196,45 +196,45 @@ const struct tulip_chip_table tulip_tbl[] = {
 
 
 static const struct pci_device_id tulip_pci_tbl[] = {
-	{ 0x1011, 0x0009, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DC21140 },
-	{ 0x1011, 0x0019, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DC21143 },
-	{ 0x11AD, 0x0002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, LC82C168 },
-	{ 0x10d9, 0x0512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MX98713 },
-	{ 0x10d9, 0x0531, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MX98715 },
-/*	{ 0x10d9, 0x0531, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MX98725 },*/
-	{ 0x125B, 0x1400, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AX88140 },
-	{ 0x11AD, 0xc115, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PNIC2 },
-	{ 0x1317, 0x0981, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
-	{ 0x1317, 0x0985, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
-	{ 0x1317, 0x1985, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
-	{ 0x1317, 0x9511, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
-	{ 0x13D1, 0xAB02, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
-	{ 0x13D1, 0xAB03, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
-	{ 0x13D1, 0xAB08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
-	{ 0x104A, 0x0981, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
-	{ 0x104A, 0x2774, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
-	{ 0x1259, 0xa120, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
-	{ 0x11F6, 0x9881, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMPEX9881 },
-	{ 0x8086, 0x0039, PCI_ANY_ID, PCI_ANY_ID, 0, 0, I21145 },
+	{ PCI_DEVICE(0x1011, 0x0009), .driver_data = DC21140 },
+	{ PCI_DEVICE(0x1011, 0x0019), .driver_data = DC21143 },
+	{ PCI_DEVICE(0x11AD, 0x0002), .driver_data = LC82C168 },
+	{ PCI_DEVICE(0x10d9, 0x0512), .driver_data = MX98713 },
+	{ PCI_DEVICE(0x10d9, 0x0531), .driver_data = MX98715 },
+/*	{ PCI_DEVICE(0x10d9, 0x0531), .driver_data = MX98725 },*/
+	{ PCI_DEVICE(0x125B, 0x1400), .driver_data = AX88140 },
+	{ PCI_DEVICE(0x11AD, 0xc115), .driver_data = PNIC2 },
+	{ PCI_DEVICE(0x1317, 0x0981), .driver_data = COMET },
+	{ PCI_DEVICE(0x1317, 0x0985), .driver_data = COMET },
+	{ PCI_DEVICE(0x1317, 0x1985), .driver_data = COMET },
+	{ PCI_DEVICE(0x1317, 0x9511), .driver_data = COMET },
+	{ PCI_DEVICE(0x13D1, 0xAB02), .driver_data = COMET },
+	{ PCI_DEVICE(0x13D1, 0xAB03), .driver_data = COMET },
+	{ PCI_DEVICE(0x13D1, 0xAB08), .driver_data = COMET },
+	{ PCI_DEVICE(0x104A, 0x0981), .driver_data = COMET },
+	{ PCI_DEVICE(0x104A, 0x2774), .driver_data = COMET },
+	{ PCI_DEVICE(0x1259, 0xa120), .driver_data = COMET },
+	{ PCI_DEVICE(0x11F6, 0x9881), .driver_data = COMPEX9881 },
+	{ PCI_DEVICE(0x8086, 0x0039), .driver_data = I21145 },
 #ifdef CONFIG_TULIP_DM910X
-	{ 0x1282, 0x9100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DM910X },
-	{ 0x1282, 0x9102, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DM910X },
+	{ PCI_DEVICE(0x1282, 0x9100), .driver_data = DM910X },
+	{ PCI_DEVICE(0x1282, 0x9102), .driver_data = DM910X },
 #endif
-	{ 0x1113, 0x1216, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
-	{ 0x1113, 0x1217, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MX98715 },
-	{ 0x1113, 0x9511, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
-	{ 0x1186, 0x1541, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
-	{ 0x1186, 0x1561, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
-	{ 0x1186, 0x1591, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
-	{ 0x14f1, 0x1803, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CONEXANT },
-	{ 0x1626, 0x8410, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
-	{ 0x1737, 0xAB09, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
-	{ 0x1737, 0xAB08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
-	{ 0x17B3, 0xAB08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
-	{ 0x10b7, 0x9300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET }, /* 3Com 3CSOHO100B-TX */
-	{ 0x14ea, 0xab08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET }, /* Planex FNW-3602-TX */
-	{ 0x1414, 0x0001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET }, /* Microsoft MN-120 */
-	{ 0x1414, 0x0002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
+	{ PCI_DEVICE(0x1113, 0x1216), .driver_data = COMET },
+	{ PCI_DEVICE(0x1113, 0x1217), .driver_data = MX98715 },
+	{ PCI_DEVICE(0x1113, 0x9511), .driver_data = COMET },
+	{ PCI_DEVICE(0x1186, 0x1541), .driver_data = COMET },
+	{ PCI_DEVICE(0x1186, 0x1561), .driver_data = COMET },
+	{ PCI_DEVICE(0x1186, 0x1591), .driver_data = COMET },
+	{ PCI_DEVICE(0x14f1, 0x1803), .driver_data = CONEXANT },
+	{ PCI_DEVICE(0x1626, 0x8410), .driver_data = COMET },
+	{ PCI_DEVICE(0x1737, 0xAB09), .driver_data = COMET },
+	{ PCI_DEVICE(0x1737, 0xAB08), .driver_data = COMET },
+	{ PCI_DEVICE(0x17B3, 0xAB08), .driver_data = COMET },
+	{ PCI_DEVICE(0x10b7, 0x9300), .driver_data = COMET }, /* 3Com 3CSOHO100B-TX */
+	{ PCI_DEVICE(0x14ea, 0xab08), .driver_data = COMET }, /* Planex FNW-3602-TX */
+	{ PCI_DEVICE(0x1414, 0x0001), .driver_data = COMET }, /* Microsoft MN-120 */
+	{ PCI_DEVICE(0x1414, 0x0002), .driver_data = COMET },
 	{ } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, tulip_pci_tbl);
@@ -1279,8 +1279,8 @@ static const struct net_device_ops tulip_netdev_ops = {
 };
 
 static const struct pci_device_id early_486_chipsets[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82424) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_496) },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82424) },
+	{ PCI_VDEVICE(SI, PCI_DEVICE_ID_SI_496) },
 	{ },
 };
 
diff --git a/drivers/net/ethernet/dec/tulip/uli526x.c b/drivers/net/ethernet/dec/tulip/uli526x.c
index 6e4d8d31aba9..34b234b6b159 100644
--- a/drivers/net/ethernet/dec/tulip/uli526x.c
+++ b/drivers/net/ethernet/dec/tulip/uli526x.c
@@ -1728,9 +1728,9 @@ static u16 phy_read_1bit(struct uli526x_board_info *db)
 
 
 static const struct pci_device_id uli526x_pci_tbl[] = {
-	{ 0x10B9, 0x5261, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCI_ULI5261_ID },
-	{ 0x10B9, 0x5263, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCI_ULI5263_ID },
-	{ 0, }
+	{ PCI_DEVICE(0x10B9, 0x5261), .driver_data = PCI_ULI5261_ID },
+	{ PCI_DEVICE(0x10B9, 0x5263), .driver_data = PCI_ULI5263_ID },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, uli526x_pci_tbl);
 
diff --git a/drivers/net/ethernet/dec/tulip/winbond-840.c b/drivers/net/ethernet/dec/tulip/winbond-840.c
index a24a25a5f73d..a5581f1d0141 100644
--- a/drivers/net/ethernet/dec/tulip/winbond-840.c
+++ b/drivers/net/ethernet/dec/tulip/winbond-840.c
@@ -210,9 +210,16 @@ enum chip_capability_flags {
 };
 
 static const struct pci_device_id w840_pci_tbl[] = {
-	{ 0x1050, 0x0840, PCI_ANY_ID, 0x8153,     0, 0, 0 },
-	{ 0x1050, 0x0840, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1 },
-	{ 0x11f6, 0x2011, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2 },
+	{
+		PCI_DEVICE_SUB(0x1050, 0x0840, PCI_ANY_ID, 0x8153),
+		.driver_data = 0,
+	}, {
+		PCI_DEVICE(0x1050, 0x0840),
+		.driver_data = 1,
+	}, {
+		PCI_DEVICE(0x11f6, 0x2011),
+		.driver_data = 2,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, w840_pci_tbl);
diff --git a/drivers/net/ethernet/dlink/dl2k.h b/drivers/net/ethernet/dlink/dl2k.h
index 9ebf7a6db93e..00ef7d03b4d6 100644
--- a/drivers/net/ethernet/dlink/dl2k.h
+++ b/drivers/net/ethernet/dlink/dl2k.h
@@ -418,12 +418,12 @@ struct netdev_private {
 #define CHIP_IP1000A	1
 
 static const struct pci_device_id rio_pci_tbl[] = {
-	{0x1186, 0x4000, PCI_ANY_ID, PCI_ANY_ID, },
-	{0x13f0, 0x1021, PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VDEVICE(SUNDANCE,	0x1023), CHIP_IP1000A },
-	{ PCI_VDEVICE(SUNDANCE,	0x2021), CHIP_IP1000A },
-	{ PCI_VDEVICE(DLINK,	0x9021), CHIP_IP1000A },
-	{ PCI_VDEVICE(DLINK,	0x4020), CHIP_IP1000A },
+	{ PCI_DEVICE(0x1186, 0x4000) },
+	{ PCI_DEVICE(0x13f0, 0x1021) },
+	{ PCI_VDEVICE(SUNDANCE,	0x1023), .driver_data = CHIP_IP1000A },
+	{ PCI_VDEVICE(SUNDANCE,	0x2021), .driver_data = CHIP_IP1000A },
+	{ PCI_VDEVICE(DLINK,	0x9021), .driver_data = CHIP_IP1000A },
+	{ PCI_VDEVICE(DLINK,	0x4020), .driver_data = CHIP_IP1000A },
 	{ }
 };
 MODULE_DEVICE_TABLE (pci, rio_pci_tbl);
diff --git a/drivers/net/ethernet/dlink/sundance.c b/drivers/net/ethernet/dlink/sundance.c
index 277c50ef773f..58873fcd3eaf 100644
--- a/drivers/net/ethernet/dlink/sundance.c
+++ b/drivers/net/ethernet/dlink/sundance.c
@@ -192,13 +192,13 @@ IVc. Errata
 #endif
 
 static const struct pci_device_id sundance_pci_tbl[] = {
-	{ 0x1186, 0x1002, 0x1186, 0x1002, 0, 0, 0 },
-	{ 0x1186, 0x1002, 0x1186, 0x1003, 0, 0, 1 },
-	{ 0x1186, 0x1002, 0x1186, 0x1012, 0, 0, 2 },
-	{ 0x1186, 0x1002, 0x1186, 0x1040, 0, 0, 3 },
-	{ 0x1186, 0x1002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
-	{ 0x13F0, 0x0201, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5 },
-	{ 0x13F0, 0x0200, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6 },
+	{ PCI_DEVICE_SUB(0x1186, 0x1002, 0x1186, 0x1002), .driver_data = 0 },
+	{ PCI_DEVICE_SUB(0x1186, 0x1002, 0x1186, 0x1003), .driver_data = 1 },
+	{ PCI_DEVICE_SUB(0x1186, 0x1002, 0x1186, 0x1012), .driver_data = 2 },
+	{ PCI_DEVICE_SUB(0x1186, 0x1002, 0x1186, 0x1040), .driver_data = 3 },
+	{ PCI_DEVICE(0x1186, 0x1002), .driver_data = 4 },
+	{ PCI_DEVICE(0x13F0, 0x0201), .driver_data = 5 },
+	{ PCI_DEVICE(0x13F0, 0x0200), .driver_data = 6 },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, sundance_pci_tbl);
diff --git a/drivers/net/ethernet/fealnx.c b/drivers/net/ethernet/fealnx.c
index 3c9961806f75..bdc38aac5850 100644
--- a/drivers/net/ethernet/fealnx.c
+++ b/drivers/net/ethernet/fealnx.c
@@ -1935,10 +1935,10 @@ static int netdev_close(struct net_device *dev)
 }
 
 static const struct pci_device_id fealnx_pci_tbl[] = {
-	{0x1516, 0x0800, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{0x1516, 0x0803, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
-	{0x1516, 0x0891, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
-	{} /* terminate list */
+	{ PCI_DEVICE(0x1516, 0x0800), .driver_data = 0 },
+	{ PCI_DEVICE(0x1516, 0x0803), .driver_data = 1 },
+	{ PCI_DEVICE(0x1516, 0x0891), .driver_data = 2 },
+	{ } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, fealnx_pci_tbl);
 
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 068da2fd1fea..b3e01b2f8319 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -489,7 +489,7 @@ static void hbg_shutdown(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id hbg_pci_tbl[] = {
-	{PCI_VDEVICE(HUAWEI, 0x3730), 0},
+	{ PCI_VDEVICE(HUAWEI, 0x3730) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, hbg_pci_tbl);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index a3206c97923e..4c34a144d21c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -86,25 +86,39 @@ module_param(page_pool_enabled, bool, 0400);
  *   Class, Class Mask, private data (not used) }
  */
 static const struct pci_device_id hns3_pci_tbl[] = {
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_GE), 0},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_25GE), 0},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_25GE_RDMA),
-	 HNAE3_DEV_SUPPORT_ROCE_DCB_BITS},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_25GE_RDMA_MACSEC),
-	 HNAE3_DEV_SUPPORT_ROCE_DCB_BITS},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_50GE_RDMA),
-	 HNAE3_DEV_SUPPORT_ROCE_DCB_BITS},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_50GE_RDMA_MACSEC),
-	 HNAE3_DEV_SUPPORT_ROCE_DCB_BITS},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_100G_RDMA_MACSEC),
-	 HNAE3_DEV_SUPPORT_ROCE_DCB_BITS},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_200G_RDMA),
-	 HNAE3_DEV_SUPPORT_ROCE_DCB_BITS},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_VF), 0},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_RDMA_DCB_PFC_VF),
-	 HNAE3_DEV_SUPPORT_ROCE_DCB_BITS},
+	{
+		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_GE),
+		.driver_data = 0,
+	}, {
+		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_25GE),
+		.driver_data = 0,
+	}, {
+		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_25GE_RDMA),
+		.driver_data = HNAE3_DEV_SUPPORT_ROCE_DCB_BITS,
+	}, {
+		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_25GE_RDMA_MACSEC),
+		.driver_data = HNAE3_DEV_SUPPORT_ROCE_DCB_BITS,
+	}, {
+		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_50GE_RDMA),
+		.driver_data = HNAE3_DEV_SUPPORT_ROCE_DCB_BITS,
+	}, {
+		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_50GE_RDMA_MACSEC),
+		.driver_data = HNAE3_DEV_SUPPORT_ROCE_DCB_BITS,
+	}, {
+		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_100G_RDMA_MACSEC),
+		.driver_data = HNAE3_DEV_SUPPORT_ROCE_DCB_BITS,
+	}, {
+		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_200G_RDMA),
+		.driver_data = HNAE3_DEV_SUPPORT_ROCE_DCB_BITS,
+	}, {
+		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_VF),
+		.driver_data = 0,
+	}, {
+		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_RDMA_DCB_PFC_VF),
+		.driver_data = HNAE3_DEV_SUPPORT_ROCE_DCB_BITS,
+	},
 	/* required last entry */
-	{0,}
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, hns3_pci_tbl);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index dd4045c773d4..e17b92a411a2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -72,16 +72,16 @@ static struct hnae3_ae_algo ae_algo;
 static struct workqueue_struct *hclge_wq;
 
 static const struct pci_device_id ae_algo_pci_tbl[] = {
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_GE), 0},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_25GE), 0},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_25GE_RDMA), 0},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_25GE_RDMA_MACSEC), 0},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_50GE_RDMA), 0},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_50GE_RDMA_MACSEC), 0},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_100G_RDMA_MACSEC), 0},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_200G_RDMA), 0},
+	{ PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_GE) },
+	{ PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_25GE) },
+	{ PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_25GE_RDMA) },
+	{ PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_25GE_RDMA_MACSEC) },
+	{ PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_50GE_RDMA) },
+	{ PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_50GE_RDMA_MACSEC) },
+	{ PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_100G_RDMA_MACSEC) },
+	{ PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_200G_RDMA) },
 	/* required last entry */
-	{0, }
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, ae_algo_pci_tbl);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 0cc911e6c732..063a692c2b41 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -26,11 +26,15 @@ static struct hnae3_ae_algo ae_algovf;
 static struct workqueue_struct *hclgevf_wq;
 
 static const struct pci_device_id ae_algovf_pci_tbl[] = {
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_VF), 0},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_RDMA_DCB_PFC_VF),
-	 HNAE3_DEV_SUPPORT_ROCE_DCB_BITS},
+	{
+		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_VF),
+		.driver_data = 0,
+	}, {
+		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_RDMA_DCB_PFC_VF),
+		.driver_data = HNAE3_DEV_SUPPORT_ROCE_DCB_BITS,
+	},
 	/* required last entry */
-	{0, }
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, ae_algovf_pci_tbl);
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
index ae1f523d6841..42f4792d255b 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -1467,12 +1467,12 @@ static void hinic_shutdown(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id hinic_pci_table[] = {
-	{ PCI_VDEVICE(HUAWEI, HINIC_DEV_ID_QUAD_PORT_25GE), 0},
-	{ PCI_VDEVICE(HUAWEI, HINIC_DEV_ID_DUAL_PORT_100GE), 0},
-	{ PCI_VDEVICE(HUAWEI, HINIC_DEV_ID_DUAL_PORT_100GE_MEZZ), 0},
-	{ PCI_VDEVICE(HUAWEI, HINIC_DEV_ID_QUAD_PORT_25GE_MEZZ), 0},
-	{ PCI_VDEVICE(HUAWEI, HINIC_DEV_ID_VF), 0},
-	{ 0, 0}
+	{ PCI_VDEVICE(HUAWEI, HINIC_DEV_ID_QUAD_PORT_25GE) },
+	{ PCI_VDEVICE(HUAWEI, HINIC_DEV_ID_DUAL_PORT_100GE) },
+	{ PCI_VDEVICE(HUAWEI, HINIC_DEV_ID_DUAL_PORT_100GE_MEZZ) },
+	{ PCI_VDEVICE(HUAWEI, HINIC_DEV_ID_QUAD_PORT_25GE_MEZZ) },
+	{ PCI_VDEVICE(HUAWEI, HINIC_DEV_ID_VF) },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, hinic_pci_table);
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
index f83d5bd1041e..36df807cbe09 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
@@ -426,10 +426,9 @@ static void hinic3_remove(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id hinic3_pci_table[] = {
-	{PCI_VDEVICE(HUAWEI, PCI_DEV_ID_HINIC3_PF), 0},
-	{PCI_VDEVICE(HUAWEI, PCI_DEV_ID_HINIC3_VF), 0},
-	{0, 0}
-
+	{ PCI_VDEVICE(HUAWEI, PCI_DEV_ID_HINIC3_PF) },
+	{ PCI_VDEVICE(HUAWEI, PCI_DEV_ID_HINIC3_VF) },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, hinic3_pci_table);
diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 9074b558de35..5ef82a4e6184 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -177,8 +177,8 @@ MODULE_PARM_DESC(eeprom_bad_csum_allow, "Allow bad eeprom checksums");
 MODULE_PARM_DESC(use_io, "Force use of i/o access mode");
 
 #define INTEL_8255X_ETHERNET_DEVICE(device_id, ich) {\
-	PCI_VENDOR_ID_INTEL, device_id, PCI_ANY_ID, PCI_ANY_ID, \
-	PCI_CLASS_NETWORK_ETHERNET << 8, 0xFFFF00, ich }
+	PCI_VDEVICE(INTEL, device_id), \
+	.class = PCI_CLASS_NETWORK_ETHERNET << 8, .class_mask = 0xFFFF00, .driver_data = ich }
 static const struct pci_device_id e100_id_table[] = {
 	INTEL_8255X_ETHERNET_DEVICE(0x1029, 0),
 	INTEL_8255X_ETHERNET_DEVICE(0x1030, 0),
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 7ce0cc8ab8f4..5b7ba1594f0d 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7799,137 +7799,370 @@ static const struct pci_error_handlers e1000_err_handler = {
 };
 
 static const struct pci_device_id e1000_pci_tbl[] = {
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_COPPER), board_82571 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_FIBER), board_82571 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_QUAD_COPPER), board_82571 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_QUAD_COPPER_LP),
-	  board_82571 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_QUAD_FIBER), board_82571 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_SERDES), board_82571 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_SERDES_DUAL), board_82571 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_SERDES_QUAD), board_82571 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82571PT_QUAD_COPPER), board_82571 },
+	{
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_COPPER),
+		.driver_data = board_82571,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_FIBER),
+		.driver_data = board_82571,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_QUAD_COPPER),
+		.driver_data = board_82571,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_QUAD_COPPER_LP),
+		.driver_data = board_82571,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_QUAD_FIBER),
+		.driver_data = board_82571,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_SERDES),
+		.driver_data = board_82571,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_SERDES_DUAL),
+		.driver_data = board_82571,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_SERDES_QUAD),
+		.driver_data = board_82571,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_82571PT_QUAD_COPPER),
+		.driver_data = board_82571,
+	},
 
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82572EI), board_82572 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82572EI_COPPER), board_82572 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82572EI_FIBER), board_82572 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82572EI_SERDES), board_82572 },
+	{
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_82572EI),
+		.driver_data = board_82572,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_82572EI_COPPER),
+		.driver_data = board_82572,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_82572EI_FIBER),
+		.driver_data = board_82572,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_82572EI_SERDES),
+		.driver_data = board_82572,
+	},
 
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82573E), board_82573 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82573E_IAMT), board_82573 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82573L), board_82573 },
+	{
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_82573E),
+		.driver_data = board_82573,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_82573E_IAMT),
+		.driver_data = board_82573,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_82573L),
+		.driver_data = board_82573,
+	},
 
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82574L), board_82574 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82574LA), board_82574 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82583V), board_82583 },
+	{
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_82574L),
+		.driver_data = board_82574,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_82574LA),
+		.driver_data = board_82574,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_82583V),
+		.driver_data = board_82583,
+	},
 
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_80003ES2LAN_COPPER_DPT),
-	  board_80003es2lan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_80003ES2LAN_COPPER_SPT),
-	  board_80003es2lan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_80003ES2LAN_SERDES_DPT),
-	  board_80003es2lan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_80003ES2LAN_SERDES_SPT),
-	  board_80003es2lan },
+	{
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_80003ES2LAN_COPPER_DPT),
+		.driver_data = board_80003es2lan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_80003ES2LAN_COPPER_SPT),
+		.driver_data = board_80003es2lan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_80003ES2LAN_SERDES_DPT),
+		.driver_data = board_80003es2lan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_80003ES2LAN_SERDES_SPT),
+		.driver_data = board_80003es2lan,
+	},
 
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_IFE), board_ich8lan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_IFE_G), board_ich8lan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_IFE_GT), board_ich8lan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_IGP_AMT), board_ich8lan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_IGP_C), board_ich8lan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_IGP_M), board_ich8lan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_IGP_M_AMT), board_ich8lan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_82567V_3), board_ich8lan },
+	{
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_IFE),
+		.driver_data = board_ich8lan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_IFE_G),
+		.driver_data = board_ich8lan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_IFE_GT),
+		.driver_data = board_ich8lan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_IGP_AMT),
+		.driver_data = board_ich8lan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_IGP_C),
+		.driver_data = board_ich8lan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_IGP_M),
+		.driver_data = board_ich8lan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_IGP_M_AMT),
+		.driver_data = board_ich8lan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_82567V_3),
+		.driver_data = board_ich8lan,
+	},
 
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IFE), board_ich9lan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IFE_G), board_ich9lan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IFE_GT), board_ich9lan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IGP_AMT), board_ich9lan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IGP_C), board_ich9lan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_BM), board_ich9lan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IGP_M), board_ich9lan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IGP_M_AMT), board_ich9lan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IGP_M_V), board_ich9lan },
+	{
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IFE),
+		.driver_data = board_ich9lan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IFE_G),
+		.driver_data = board_ich9lan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IFE_GT),
+		.driver_data = board_ich9lan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IGP_AMT),
+		.driver_data = board_ich9lan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IGP_C),
+		.driver_data = board_ich9lan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_BM),
+		.driver_data = board_ich9lan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IGP_M),
+		.driver_data = board_ich9lan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IGP_M_AMT),
+		.driver_data = board_ich9lan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IGP_M_V),
+		.driver_data = board_ich9lan
+	},
 
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH10_R_BM_LM), board_ich9lan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH10_R_BM_LF), board_ich9lan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH10_R_BM_V), board_ich9lan },
+	{
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH10_R_BM_LM),
+		.driver_data = board_ich9lan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH10_R_BM_LF),
+		.driver_data = board_ich9lan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH10_R_BM_V),
+		.driver_data = board_ich9lan,
+	},
 
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH10_D_BM_LM), board_ich10lan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH10_D_BM_LF), board_ich10lan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH10_D_BM_V), board_ich10lan },
+	{
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH10_D_BM_LM),
+		.driver_data = board_ich10lan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH10_D_BM_LF),
+		.driver_data = board_ich10lan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH10_D_BM_V),
+		.driver_data = board_ich10lan,
+	},
 
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_M_HV_LM), board_pchlan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_M_HV_LC), board_pchlan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_D_HV_DM), board_pchlan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_D_HV_DC), board_pchlan },
+	{
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_M_HV_LM),
+		.driver_data = board_pchlan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_M_HV_LC),
+		.driver_data = board_pchlan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_D_HV_DM),
+		.driver_data = board_pchlan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_D_HV_DC),
+		.driver_data = board_pchlan
+	},
 
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH2_LV_LM), board_pch2lan },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH2_LV_V), board_pch2lan },
+	{
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH2_LV_LM),
+		.driver_data = board_pch2lan,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH2_LV_V),
+		.driver_data = board_pch2lan
+	},
 
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LPT_I217_LM), board_pch_lpt },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LPT_I217_V), board_pch_lpt },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LPTLP_I218_LM), board_pch_lpt },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LPTLP_I218_V), board_pch_lpt },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_I218_LM2), board_pch_lpt },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_I218_V2), board_pch_lpt },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_I218_LM3), board_pch_lpt },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_I218_V3), board_pch_lpt },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_LM), board_pch_spt },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_V), board_pch_spt },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_LM2), board_pch_spt },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_V2), board_pch_spt },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LBG_I219_LM3), board_pch_spt },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_LM4), board_pch_spt },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_V4), board_pch_spt },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_LM5), board_pch_spt },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_V5), board_pch_spt },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CNP_I219_LM6), board_pch_cnp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CNP_I219_V6), board_pch_cnp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CNP_I219_LM7), board_pch_cnp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CNP_I219_V7), board_pch_cnp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ICP_I219_LM8), board_pch_cnp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ICP_I219_V8), board_pch_cnp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ICP_I219_LM9), board_pch_cnp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ICP_I219_V9), board_pch_cnp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CMP_I219_LM10), board_pch_cnp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CMP_I219_V10), board_pch_cnp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CMP_I219_LM11), board_pch_cnp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CMP_I219_V11), board_pch_cnp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CMP_I219_LM12), board_pch_spt },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CMP_I219_V12), board_pch_spt },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_LM13), board_pch_tgp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V13), board_pch_tgp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_LM14), board_pch_tgp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V14), board_pch_tgp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_LM15), board_pch_tgp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V15), board_pch_tgp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_RPL_I219_LM23), board_pch_adp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_RPL_I219_V23), board_pch_adp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_LM16), board_pch_adp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_V16), board_pch_adp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_LM17), board_pch_adp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_V17), board_pch_adp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_RPL_I219_LM22), board_pch_adp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_RPL_I219_V22), board_pch_adp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_LM19), board_pch_adp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_V19), board_pch_adp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_MTP_I219_LM18), board_pch_mtp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_MTP_I219_V18), board_pch_mtp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_LM20), board_pch_mtp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_V20), board_pch_mtp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_LM21), board_pch_mtp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_V21), board_pch_mtp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ARL_I219_LM24), board_pch_mtp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ARL_I219_V24), board_pch_mtp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_LM25), board_pch_ptp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_V25), board_pch_ptp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_LM27), board_pch_ptp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_V27), board_pch_ptp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_NVL_I219_LM29), board_pch_ptp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_NVL_I219_V29), board_pch_ptp },
+	{
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LPT_I217_LM),
+		.driver_data = board_pch_lpt,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LPT_I217_V),
+		.driver_data = board_pch_lpt,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LPTLP_I218_LM),
+		.driver_data = board_pch_lpt,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LPTLP_I218_V),
+		.driver_data = board_pch_lpt,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_I218_LM2),
+		.driver_data = board_pch_lpt,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_I218_V2),
+		.driver_data = board_pch_lpt,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_I218_LM3),
+		.driver_data = board_pch_lpt,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_I218_V3),
+		.driver_data = board_pch_lpt,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_LM),
+		.driver_data = board_pch_spt,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_V),
+		.driver_data = board_pch_spt,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_LM2),
+		.driver_data = board_pch_spt,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_V2),
+		.driver_data = board_pch_spt,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LBG_I219_LM3),
+		.driver_data = board_pch_spt,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_LM4),
+		.driver_data = board_pch_spt,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_V4),
+		.driver_data = board_pch_spt,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_LM5),
+		.driver_data = board_pch_spt,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_V5),
+		.driver_data = board_pch_spt,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CNP_I219_LM6),
+		.driver_data = board_pch_cnp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CNP_I219_V6),
+		.driver_data = board_pch_cnp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CNP_I219_LM7),
+		.driver_data = board_pch_cnp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CNP_I219_V7),
+		.driver_data = board_pch_cnp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ICP_I219_LM8),
+		.driver_data = board_pch_cnp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ICP_I219_V8),
+		.driver_data = board_pch_cnp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ICP_I219_LM9),
+		.driver_data = board_pch_cnp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ICP_I219_V9),
+		.driver_data = board_pch_cnp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CMP_I219_LM10),
+		.driver_data = board_pch_cnp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CMP_I219_V10),
+		.driver_data = board_pch_cnp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CMP_I219_LM11),
+		.driver_data = board_pch_cnp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CMP_I219_V11),
+		.driver_data = board_pch_cnp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CMP_I219_LM12),
+		.driver_data = board_pch_spt,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CMP_I219_V12),
+		.driver_data = board_pch_spt,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_LM13),
+		.driver_data = board_pch_tgp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V13),
+		.driver_data = board_pch_tgp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_LM14),
+		.driver_data = board_pch_tgp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V14),
+		.driver_data = board_pch_tgp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_LM15),
+		.driver_data = board_pch_tgp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V15),
+		.driver_data = board_pch_tgp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_RPL_I219_LM23),
+		.driver_data = board_pch_adp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_RPL_I219_V23),
+		.driver_data = board_pch_adp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_LM16),
+		.driver_data = board_pch_adp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_V16),
+		.driver_data = board_pch_adp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_LM17),
+		.driver_data = board_pch_adp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_V17),
+		.driver_data = board_pch_adp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_RPL_I219_LM22),
+		.driver_data = board_pch_adp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_RPL_I219_V22),
+		.driver_data = board_pch_adp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_LM19),
+		.driver_data = board_pch_adp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_V19),
+		.driver_data = board_pch_adp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_MTP_I219_LM18),
+		.driver_data = board_pch_mtp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_MTP_I219_V18),
+		.driver_data = board_pch_mtp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_LM20),
+		.driver_data = board_pch_mtp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_V20),
+		.driver_data = board_pch_mtp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_LM21),
+		.driver_data = board_pch_mtp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_V21),
+		.driver_data = board_pch_mtp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ARL_I219_LM24),
+		.driver_data = board_pch_mtp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ARL_I219_V24),
+		.driver_data = board_pch_mtp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_LM25),
+		.driver_data = board_pch_ptp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_V25),
+		.driver_data = board_pch_ptp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_LM27),
+		.driver_data = board_pch_ptp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_V27),
+		.driver_data = board_pch_ptp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_NVL_I219_LM29),
+		.driver_data = board_pch_ptp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_NVL_I219_V29),
+		.driver_data = board_pch_ptp
+	},
 
-	{ 0, 0, 0, 0, 0, 0, 0 }	/* terminate list */
+	{ }	/* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, e1000_pci_tbl);
 
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index d75b8a50413d..f5b4d062709a 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -21,12 +21,12 @@ static const struct fm10k_info *fm10k_info_tbl[] = {
  *   Class, Class Mask, private data (not used) }
  */
 static const struct pci_device_id fm10k_pci_tbl[] = {
-	{ PCI_VDEVICE(INTEL, FM10K_DEV_ID_PF), fm10k_device_pf },
-	{ PCI_VDEVICE(INTEL, FM10K_DEV_ID_SDI_FM10420_QDA2), fm10k_device_pf },
-	{ PCI_VDEVICE(INTEL, FM10K_DEV_ID_SDI_FM10420_DA2), fm10k_device_pf },
-	{ PCI_VDEVICE(INTEL, FM10K_DEV_ID_VF), fm10k_device_vf },
+	{ PCI_VDEVICE(INTEL, FM10K_DEV_ID_PF), .driver_data = fm10k_device_pf },
+	{ PCI_VDEVICE(INTEL, FM10K_DEV_ID_SDI_FM10420_QDA2), .driver_data = fm10k_device_pf },
+	{ PCI_VDEVICE(INTEL, FM10K_DEV_ID_SDI_FM10420_DA2), .driver_data = fm10k_device_pf },
+	{ PCI_VDEVICE(INTEL, FM10K_DEV_ID_VF), .driver_data = fm10k_device_vf },
 	/* required last entry */
-	{ 0, }
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, fm10k_pci_tbl);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 028bd500603a..93faada2d328 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -63,40 +63,43 @@ static bool i40e_is_total_port_shutdown_enabled(struct i40e_pf *pf);
  *   Class, Class Mask, private data (not used) }
  */
 static const struct pci_device_id i40e_pci_tbl[] = {
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_SFP_XL710), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_QEMU), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_KX_B), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_KX_C), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_QSFP_A), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_QSFP_B), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_QSFP_C), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_1G_BASE_T_BC), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T4), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T_BC), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_SFP), 0},
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_SFP_XL710) },
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_QEMU) },
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_KX_B) },
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_KX_C) },
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_QSFP_A) },
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_QSFP_B) },
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_QSFP_C) },
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_1G_BASE_T_BC) },
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T) },
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T4) },
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T_BC) },
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_SFP) },
 	/*
 	 * This ID conflicts with ipw2200, but the devices can be differentiated
 	 * because i40e devices use PCI_CLASS_NETWORK_ETHERNET and ipw2200
 	 * devices use PCI_CLASS_NETWORK_OTHER.
 	 */
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, I40E_DEV_ID_10G_B),
-		PCI_CLASS_NETWORK_ETHERNET << 8, 0xffff00, 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_KX_X722), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_QSFP_X722), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_SFP_X722), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_1G_BASE_T_X722), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T_X722), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_SFP_I_X722), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_SFP_X722_A), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_20G_KR2), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_20G_KR2_A), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_X710_N3000), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_XXV710_N3000), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_25G_B), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_25G_SFP28), 0},
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, I40E_DEV_ID_10G_B),
+		.class = PCI_CLASS_NETWORK_ETHERNET << 8,
+		.class_mask = 0xffff00,
+	},
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_KX_X722) },
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_QSFP_X722) },
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_SFP_X722) },
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_1G_BASE_T_X722) },
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T_X722) },
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_SFP_I_X722) },
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_SFP_X722_A) },
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_20G_KR2) },
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_20G_KR2_A) },
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_X710_N3000) },
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_XXV710_N3000) },
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_25G_B) },
+	{ PCI_VDEVICE(INTEL, I40E_DEV_ID_25G_SFP28) },
 	/* required last entry */
-	{0, }
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, i40e_pci_tbl);
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 3c1465cf0515..f00692f1e459 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -36,12 +36,12 @@ static const char iavf_copyright[] =
  *   Class, Class Mask, private data (not used) }
  */
 static const struct pci_device_id iavf_pci_tbl[] = {
-	{PCI_VDEVICE(INTEL, IAVF_DEV_ID_VF), 0},
-	{PCI_VDEVICE(INTEL, IAVF_DEV_ID_VF_HV), 0},
-	{PCI_VDEVICE(INTEL, IAVF_DEV_ID_X722_VF), 0},
-	{PCI_VDEVICE(INTEL, IAVF_DEV_ID_ADAPTIVE_VF), 0},
+	{ PCI_VDEVICE(INTEL, IAVF_DEV_ID_VF) },
+	{ PCI_VDEVICE(INTEL, IAVF_DEV_ID_VF_HV) },
+	{ PCI_VDEVICE(INTEL, IAVF_DEV_ID_X722_VF) },
+	{ PCI_VDEVICE(INTEL, IAVF_DEV_ID_ADAPTIVE_VF) },
 	/* required last entry */
-	{0, }
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, iavf_pci_tbl);
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index ce91dda00ec0..49d46670695f 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -63,40 +63,40 @@ static const struct pci_device_id igb_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I354_BACKPLANE_1GBPS) },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I354_SGMII) },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I354_BACKPLANE_2_5GBPS) },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I211_COPPER), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I210_COPPER), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I210_FIBER), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I210_SERDES), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I210_SGMII), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I210_COPPER_FLASHLESS), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I210_SERDES_FLASHLESS), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I350_COPPER), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I350_FIBER), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I350_SERDES), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I350_SGMII), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82580_COPPER), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82580_FIBER), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82580_QUAD_FIBER), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82580_SERDES), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82580_SGMII), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82580_COPPER_DUAL), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_DH89XXCC_SGMII), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_DH89XXCC_SERDES), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_DH89XXCC_BACKPLANE), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_DH89XXCC_SFP), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82576), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82576_NS), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82576_NS_SERDES), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82576_FIBER), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82576_SERDES), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82576_SERDES_QUAD), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82576_QUAD_COPPER_ET2), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82576_QUAD_COPPER), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82575EB_COPPER), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82575EB_FIBER_SERDES), board_82575 },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82575GB_QUAD_COPPER), board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I211_COPPER), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I210_COPPER), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I210_FIBER), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I210_SERDES), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I210_SGMII), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I210_COPPER_FLASHLESS), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I210_SERDES_FLASHLESS), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I350_COPPER), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I350_FIBER), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I350_SERDES), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I350_SGMII), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82580_COPPER), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82580_FIBER), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82580_QUAD_FIBER), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82580_SERDES), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82580_SGMII), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82580_COPPER_DUAL), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_DH89XXCC_SGMII), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_DH89XXCC_SERDES), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_DH89XXCC_BACKPLANE), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_DH89XXCC_SFP), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82576), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82576_NS), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82576_NS_SERDES), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82576_FIBER), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82576_SERDES), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82576_SERDES_QUAD), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82576_QUAD_COPPER_ET2), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82576_QUAD_COPPER), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82575EB_COPPER), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82575EB_FIBER_SERDES), .driver_data = board_82575 },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82575GB_QUAD_COPPER), .driver_data = board_82575 },
 	/* required last entry */
-	{0, }
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, igb_pci_tbl);
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 5d04541072b3..0a3d0a1cba43 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -2937,8 +2937,8 @@ static const struct pci_error_handlers igbvf_err_handler = {
 };
 
 static const struct pci_device_id igbvf_pci_tbl[] = {
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82576_VF), board_vf },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I350_VF), board_i350_vf },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82576_VF), .driver_data = board_vf },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I350_VF), .driver_data = board_i350_vf },
 	{ } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, igbvf_pci_tbl);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 8ac16808023c..89b9e1d00fc7 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -47,24 +47,24 @@ static const struct igc_info *igc_info_tbl[] = {
 };
 
 static const struct pci_device_id igc_pci_tbl[] = {
-	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_LM), board_base },
-	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_V), board_base },
-	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_I), board_base },
-	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I220_V), board_base },
-	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_K), board_base },
-	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_K2), board_base },
-	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_K), board_base },
-	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_LMVP), board_base },
-	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_LMVP), board_base },
-	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_IT), board_base },
-	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_LM), board_base },
-	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_V), board_base },
-	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_IT), board_base },
-	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I221_V), board_base },
-	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_BLANK_NVM), board_base },
-	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_BLANK_NVM), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_LM), .driver_data = board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_V), .driver_data = board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_I), .driver_data = board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I220_V), .driver_data = board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_K), .driver_data = board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_K2), .driver_data = board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_K), .driver_data = board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_LMVP), .driver_data = board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_LMVP), .driver_data = board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_IT), .driver_data = board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_LM), .driver_data = board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_V), .driver_data = board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_IT), .driver_data = board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I221_V), .driver_data = board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_BLANK_NVM), .driver_data = board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_BLANK_NVM), .driver_data = board_base },
 	/* required last entry */
-	{0, }
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, igc_pci_tbl);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2646ee6f295f..730a35658c76 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -88,60 +88,60 @@ static const struct ixgbe_info *ixgbe_info_tbl[] = {
  *   Class, Class Mask, private data (not used) }
  */
 static const struct pci_device_id ixgbe_pci_tbl[] = {
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598), board_82598 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598AF_DUAL_PORT), board_82598 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598AF_SINGLE_PORT), board_82598 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598AT), board_82598 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598AT2), board_82598 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598EB_CX4), board_82598 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598_CX4_DUAL_PORT), board_82598 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598_DA_DUAL_PORT), board_82598 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598_SR_DUAL_PORT_EM), board_82598 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598EB_XF_LR), board_82598 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598EB_SFP_LOM), board_82598 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598_BX), board_82598 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_KX4), board_82599 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_XAUI_LOM), board_82599 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_KR), board_82599 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_SFP), board_82599 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_SFP_EM), board_82599 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_KX4_MEZZ), board_82599 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_CX4), board_82599 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_BACKPLANE_FCOE), board_82599 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_SFP_FCOE), board_82599 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_T3_LOM), board_82599 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_COMBO_BACKPLANE), board_82599 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X540T), board_X540 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_SFP_SF2), board_82599 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_LS), board_82599 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_QSFP_SF_QP), board_82599 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599EN_SFP), board_82599 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_SFP_SF_QP), board_82599 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X540T1), board_X540 },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550T), board_X550},
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550T1), board_X550},
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_KX4), board_X550EM_x},
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_XFI), board_X550EM_x},
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_KR), board_X550EM_x},
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_10G_T), board_X550EM_x},
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_SFP), board_X550EM_x},
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_1G_T), board_x550em_x_fw},
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_KR), board_x550em_a },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_KR_L), board_x550em_a },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_SFP_N), board_x550em_a },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_SGMII), board_x550em_a },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_SGMII_L), board_x550em_a },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_10G_T), board_x550em_a},
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_SFP), board_x550em_a },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_1G_T), board_x550em_a_fw },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_1G_T_L), board_x550em_a_fw },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_E610_BACKPLANE), board_e610},
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_E610_SFP), board_e610},
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_E610_10G_T), board_e610},
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_E610_2_5G_T), board_e610},
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_E610_SGMII), board_e610},
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598), .driver_data = board_82598 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598AF_DUAL_PORT), .driver_data = board_82598 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598AF_SINGLE_PORT), .driver_data = board_82598 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598AT), .driver_data = board_82598 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598AT2), .driver_data = board_82598 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598EB_CX4), .driver_data = board_82598 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598_CX4_DUAL_PORT), .driver_data = board_82598 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598_DA_DUAL_PORT), .driver_data = board_82598 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598_SR_DUAL_PORT_EM), .driver_data = board_82598 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598EB_XF_LR), .driver_data = board_82598 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598EB_SFP_LOM), .driver_data = board_82598 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82598_BX), .driver_data = board_82598 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_KX4), .driver_data = board_82599 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_XAUI_LOM), .driver_data = board_82599 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_KR), .driver_data = board_82599 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_SFP), .driver_data = board_82599 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_SFP_EM), .driver_data = board_82599 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_KX4_MEZZ), .driver_data = board_82599 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_CX4), .driver_data = board_82599 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_BACKPLANE_FCOE), .driver_data = board_82599 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_SFP_FCOE), .driver_data = board_82599 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_T3_LOM), .driver_data = board_82599 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_COMBO_BACKPLANE), .driver_data = board_82599 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X540T), .driver_data = board_X540 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_SFP_SF2), .driver_data = board_82599 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_LS), .driver_data = board_82599 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_QSFP_SF_QP), .driver_data = board_82599 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599EN_SFP), .driver_data = board_82599 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_SFP_SF_QP), .driver_data = board_82599 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X540T1), .driver_data = board_X540 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550T), .driver_data = board_X550 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550T1), .driver_data = board_X550 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_KX4), .driver_data = board_X550EM_x },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_XFI), .driver_data = board_X550EM_x },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_KR), .driver_data = board_X550EM_x },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_10G_T), .driver_data = board_X550EM_x },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_SFP), .driver_data = board_X550EM_x },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_1G_T), .driver_data = board_x550em_x_fw },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_KR), .driver_data = board_x550em_a },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_KR_L), .driver_data = board_x550em_a },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_SFP_N), .driver_data = board_x550em_a },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_SGMII), .driver_data = board_x550em_a },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_SGMII_L), .driver_data = board_x550em_a },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_10G_T), .driver_data = board_x550em_a },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_SFP), .driver_data = board_x550em_a },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_1G_T), .driver_data = board_x550em_a_fw },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_1G_T_L), .driver_data = board_x550em_a_fw },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_E610_BACKPLANE), .driver_data = board_e610 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_E610_SFP), .driver_data = board_e610 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_E610_10G_T), .driver_data = board_e610 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_E610_2_5G_T), .driver_data = board_e610 },
+	{ PCI_VDEVICE(INTEL, IXGBE_DEV_ID_E610_SGMII), .driver_data = board_e610 },
 	/* required last entry */
-	{0, }
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, ixgbe_pci_tbl);
 
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 42f89a179a3f..b5d15c1f0d4f 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -64,20 +64,43 @@ static const struct ixgbevf_info *ixgbevf_info_tbl[] = {
  *   Class, Class Mask, private data (not used) }
  */
 static const struct pci_device_id ixgbevf_pci_tbl[] = {
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_VF), board_82599_vf },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_VF_HV), board_82599_vf_hv },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X540_VF), board_X540_vf },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X540_VF_HV), board_X540_vf_hv },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550_VF), board_X550_vf },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550_VF_HV), board_X550_vf_hv },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_VF), board_X550EM_x_vf },
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_VF_HV), board_X550EM_x_vf_hv},
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_VF), board_x550em_a_vf },
-	{PCI_VDEVICE_SUB(INTEL, IXGBE_DEV_ID_E610_VF, PCI_ANY_ID,
-			 IXGBE_SUBDEV_ID_E610_VF_HV), board_e610_vf_hv},
-	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_E610_VF), board_e610_vf},
+	{
+		PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_VF),
+		.driver_data = board_82599_vf,
+	}, {
+		PCI_VDEVICE(INTEL, IXGBE_DEV_ID_82599_VF_HV),
+		.driver_data = board_82599_vf_hv,
+	}, {
+		PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X540_VF),
+		.driver_data = board_X540_vf,
+	}, {
+		PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X540_VF_HV),
+		.driver_data = board_X540_vf_hv,
+	}, {
+		PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550_VF),
+		.driver_data = board_X550_vf,
+	}, {
+		PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550_VF_HV),
+		.driver_data = board_X550_vf_hv,
+	}, {
+		PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_VF),
+		.driver_data = board_X550EM_x_vf,
+	}, {
+		PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_VF_HV),
+		.driver_data = board_X550EM_x_vf_hv
+	}, {
+		PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_VF),
+		.driver_data = board_x550em_a_vf,
+	}, {
+		PCI_VDEVICE_SUB(INTEL, IXGBE_DEV_ID_E610_VF,
+				PCI_ANY_ID, IXGBE_SUBDEV_ID_E610_VF_HV),
+		.driver_data = board_e610_vf_hv,
+	}, {
+		PCI_VDEVICE(INTEL, IXGBE_DEV_ID_E610_VF),
+		.driver_data = board_e610_vf,
+	},
 	/* required last entry */
-	{0, }
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, ixgbevf_pci_tbl);
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index e6b7e75894ff..4fe6dbf0942f 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -4274,9 +4274,9 @@ int mlx4_restart_one(struct pci_dev *pdev)
 	return mlx4_restart_one_up(pdev, false, NULL);
 }
 
-#define MLX_SP(id) { PCI_VDEVICE(MELLANOX, id), MLX4_PCI_DEV_FORCE_SENSE_PORT }
-#define MLX_VF(id) { PCI_VDEVICE(MELLANOX, id), MLX4_PCI_DEV_IS_VF }
-#define MLX_GN(id) { PCI_VDEVICE(MELLANOX, id), 0 }
+#define MLX_SP(id) { PCI_VDEVICE(MELLANOX, id), .driver_data = MLX4_PCI_DEV_FORCE_SENSE_PORT }
+#define MLX_VF(id) { PCI_VDEVICE(MELLANOX, id), .driver_data = MLX4_PCI_DEV_IS_VF }
+#define MLX_GN(id) { PCI_VDEVICE(MELLANOX, id), .driver_data = 0 }
 
 static const struct pci_device_id mlx4_pci_table[] = {
 #ifdef CONFIG_MLX4_CORE_GEN2
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 74827e8ca125..ff450269ce37 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -2203,19 +2203,26 @@ static int mlx5_resume(struct pci_dev *pdev)
 
 static const struct pci_device_id mlx5_core_pci_table[] = {
 	{ PCI_VDEVICE(MELLANOX, PCI_DEVICE_ID_MELLANOX_CONNECTIB) },
-	{ PCI_VDEVICE(MELLANOX, 0x1012), MLX5_PCI_DEV_IS_VF},	/* Connect-IB VF */
+	{ PCI_VDEVICE(MELLANOX, 0x1012),
+	  .driver_data = MLX5_PCI_DEV_IS_VF },			/* Connect-IB VF */
 	{ PCI_VDEVICE(MELLANOX, PCI_DEVICE_ID_MELLANOX_CONNECTX4) },
-	{ PCI_VDEVICE(MELLANOX, 0x1014), MLX5_PCI_DEV_IS_VF},	/* ConnectX-4 VF */
+	{ PCI_VDEVICE(MELLANOX, 0x1014),
+	  .driver_data = MLX5_PCI_DEV_IS_VF },			/* ConnectX-4 VF */
 	{ PCI_VDEVICE(MELLANOX, PCI_DEVICE_ID_MELLANOX_CONNECTX4_LX) },
-	{ PCI_VDEVICE(MELLANOX, 0x1016), MLX5_PCI_DEV_IS_VF},	/* ConnectX-4LX VF */
+	{ PCI_VDEVICE(MELLANOX, 0x1016),
+	  .driver_data = MLX5_PCI_DEV_IS_VF },			/* ConnectX-4LX VF */
 	{ PCI_VDEVICE(MELLANOX, 0x1017) },			/* ConnectX-5, PCIe 3.0 */
-	{ PCI_VDEVICE(MELLANOX, 0x1018), MLX5_PCI_DEV_IS_VF},	/* ConnectX-5 VF */
+	{ PCI_VDEVICE(MELLANOX, 0x1018),
+	  .driver_data = MLX5_PCI_DEV_IS_VF },			/* ConnectX-5 VF */
 	{ PCI_VDEVICE(MELLANOX, 0x1019) },			/* ConnectX-5 Ex */
-	{ PCI_VDEVICE(MELLANOX, 0x101a), MLX5_PCI_DEV_IS_VF},	/* ConnectX-5 Ex VF */
+	{ PCI_VDEVICE(MELLANOX, 0x101a),
+	  .driver_data = MLX5_PCI_DEV_IS_VF },			/* ConnectX-5 Ex VF */
 	{ PCI_VDEVICE(MELLANOX, 0x101b) },			/* ConnectX-6 */
-	{ PCI_VDEVICE(MELLANOX, 0x101c), MLX5_PCI_DEV_IS_VF},	/* ConnectX-6 VF */
+	{ PCI_VDEVICE(MELLANOX, 0x101c),
+	  .driver_data = MLX5_PCI_DEV_IS_VF },			/* ConnectX-6 VF */
 	{ PCI_VDEVICE(MELLANOX, 0x101d) },			/* ConnectX-6 Dx */
-	{ PCI_VDEVICE(MELLANOX, 0x101e), MLX5_PCI_DEV_IS_VF},	/* ConnectX Family mlx5Gen Virtual Function */
+	{ PCI_VDEVICE(MELLANOX, 0x101e),
+	  .driver_data = MLX5_PCI_DEV_IS_VF },			/* ConnectX Family mlx5Gen Virtual Function */
 	{ PCI_VDEVICE(MELLANOX, 0x101f) },			/* ConnectX-6 LX */
 	{ PCI_VDEVICE(MELLANOX, 0x1021) },			/* ConnectX-7 */
 	{ PCI_VDEVICE(MELLANOX, 0x1023) },			/* ConnectX-8 */
@@ -2223,11 +2230,12 @@ static const struct pci_device_id mlx5_core_pci_table[] = {
 	{ PCI_VDEVICE(MELLANOX, 0x1027) },			/* ConnectX-10 */
 	{ PCI_VDEVICE(MELLANOX, 0x2101) },			/* ConnectX-10 NVLink-C2C */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d2) },			/* BlueField integrated ConnectX-5 network controller */
-	{ PCI_VDEVICE(MELLANOX, 0xa2d3), MLX5_PCI_DEV_IS_VF},	/* BlueField integrated ConnectX-5 network controller VF */
+	{ PCI_VDEVICE(MELLANOX, 0xa2d3),
+	  .driver_data = MLX5_PCI_DEV_IS_VF },			/* BlueField integrated ConnectX-5 network controller VF */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d6) },			/* BlueField-2 integrated ConnectX-6 Dx network controller */
 	{ PCI_VDEVICE(MELLANOX, 0xa2dc) },			/* BlueField-3 integrated ConnectX-7 network controller */
 	{ PCI_VDEVICE(MELLANOX, 0xa2df) },			/* BlueField-4 integrated ConnectX-8 network controller */
-	{ 0, }
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, mlx5_core_pci_table);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 3a65420fa1ad..1aaa75b47fe3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -5277,8 +5277,8 @@ static int mlxsw_sp_netdevice_event(struct notifier_block *nb,
 }
 
 static const struct pci_device_id mlxsw_sp1_pci_id_table[] = {
-	{PCI_VDEVICE(MELLANOX, PCI_DEVICE_ID_MELLANOX_SPECTRUM), 0},
-	{0, },
+	{PCI_VDEVICE(MELLANOX, PCI_DEVICE_ID_MELLANOX_SPECTRUM) },
+	{ },
 };
 
 static struct pci_driver mlxsw_sp1_pci_driver = {
@@ -5287,8 +5287,8 @@ static struct pci_driver mlxsw_sp1_pci_driver = {
 };
 
 static const struct pci_device_id mlxsw_sp2_pci_id_table[] = {
-	{PCI_VDEVICE(MELLANOX, PCI_DEVICE_ID_MELLANOX_SPECTRUM2), 0},
-	{0, },
+	{PCI_VDEVICE(MELLANOX, PCI_DEVICE_ID_MELLANOX_SPECTRUM2) },
+	{ },
 };
 
 static struct pci_driver mlxsw_sp2_pci_driver = {
@@ -5297,8 +5297,8 @@ static struct pci_driver mlxsw_sp2_pci_driver = {
 };
 
 static const struct pci_device_id mlxsw_sp3_pci_id_table[] = {
-	{PCI_VDEVICE(MELLANOX, PCI_DEVICE_ID_MELLANOX_SPECTRUM3), 0},
-	{0, },
+	{PCI_VDEVICE(MELLANOX, PCI_DEVICE_ID_MELLANOX_SPECTRUM3) },
+	{ },
 };
 
 static struct pci_driver mlxsw_sp3_pci_driver = {
@@ -5307,8 +5307,8 @@ static struct pci_driver mlxsw_sp3_pci_driver = {
 };
 
 static const struct pci_device_id mlxsw_sp4_pci_id_table[] = {
-	{PCI_VDEVICE(MELLANOX, PCI_DEVICE_ID_MELLANOX_SPECTRUM4), 0},
-	{0, },
+	{PCI_VDEVICE(MELLANOX, PCI_DEVICE_ID_MELLANOX_SPECTRUM4) },
+	{ },
 };
 
 static struct pci_driver mlxsw_sp4_pci_driver = {
diff --git a/drivers/net/ethernet/micrel/ksz884x.c b/drivers/net/ethernet/micrel/ksz884x.c
index 26557cd32008..773fdd215a15 100644
--- a/drivers/net/ethernet/micrel/ksz884x.c
+++ b/drivers/net/ethernet/micrel/ksz884x.c
@@ -6839,11 +6839,9 @@ static int __maybe_unused pcidev_suspend(struct device *dev_d)
 static char pcidev_name[] = "ksz884xp";
 
 static const struct pci_device_id pcidev_table[] = {
-	{ PCI_VENDOR_ID_MICREL_KS, 0x8841,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_MICREL_KS, 0x8842,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ 0 }
+	{ PCI_VDEVICE(MICREL_KS, 0x8841) },
+	{ PCI_VDEVICE(MICREL_KS, 0x8842) },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, pcidev_table);
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 316f941629d4..70a2b0082ba8 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -17,12 +17,12 @@ static const char rnpgbe_driver_name[] = "rnpgbe";
  *   private_data (used for different hw chip) }
  */
 static struct pci_device_id rnpgbe_pci_tbl[] = {
-	{ PCI_VDEVICE(MUCSE, RNPGBE_DEVICE_ID_N210), board_n210 },
-	{ PCI_VDEVICE(MUCSE, RNPGBE_DEVICE_ID_N210L), board_n210 },
-	{ PCI_VDEVICE(MUCSE, RNPGBE_DEVICE_ID_N500_DUAL_PORT), board_n500 },
-	{ PCI_VDEVICE(MUCSE, RNPGBE_DEVICE_ID_N500_QUAD_PORT), board_n500 },
+	{ PCI_VDEVICE(MUCSE, RNPGBE_DEVICE_ID_N210), .driver_data = board_n210 },
+	{ PCI_VDEVICE(MUCSE, RNPGBE_DEVICE_ID_N210L), .driver_data = board_n210 },
+	{ PCI_VDEVICE(MUCSE, RNPGBE_DEVICE_ID_N500_DUAL_PORT), .driver_data = board_n500 },
+	{ PCI_VDEVICE(MUCSE, RNPGBE_DEVICE_ID_N500_QUAD_PORT), .driver_data = board_n500 },
 	/* required last entry */
-	{0, },
+	{ },
 };
 
 /**
diff --git a/drivers/net/ethernet/natsemi/natsemi.c b/drivers/net/ethernet/natsemi/natsemi.c
index b253734dbc80..35a63b78880b 100644
--- a/drivers/net/ethernet/natsemi/natsemi.c
+++ b/drivers/net/ethernet/natsemi/natsemi.c
@@ -248,8 +248,8 @@ static struct {
 };
 
 static const struct pci_device_id natsemi_pci_tbl[] = {
-	{ PCI_VENDOR_ID_NS, 0x0020, 0x12d9,     0x000c,     0, 0, 0 },
-	{ PCI_VENDOR_ID_NS, 0x0020, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1 },
+	{ PCI_VDEVICE_SUB(NS, 0x0020, 0x12d9, 0x000c), .driver_data = 0 },
+	{ PCI_VDEVICE(NS, 0x0020), .driver_data = 1 },
 	{ }	/* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, natsemi_pci_tbl);
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/ethernet/netronome/nfp/nfp_main.c
index 48390b2fd44d..e8e4b84d505a 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -33,39 +33,56 @@
 static const char nfp_driver_name[] = "nfp";
 
 static const struct pci_device_id nfp_pci_device_ids[] = {
-	{ PCI_VENDOR_ID_NETRONOME, PCI_DEVICE_ID_NFP3800,
-	  PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP3800,
+	{
+		PCI_VDEVICE_SUB(NETRONOME, PCI_DEVICE_ID_NFP3800,
+				PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID),
+		.class = PCI_ANY_ID,
+		.class_mask = 0,
+		.driver_data = NFP_DEV_NFP3800,
+	}, {
+		PCI_VDEVICE_SUB(NETRONOME, PCI_DEVICE_ID_NFP4000,
+				PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID),
+		.class = PCI_ANY_ID,
+		.class_mask = 0,
+		.driver_data = NFP_DEV_NFP6000,
+	}, {
+		PCI_VDEVICE_SUB(NETRONOME, PCI_DEVICE_ID_NFP5000,
+				PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID),
+		.class = PCI_ANY_ID,
+		.class_mask = 0,
+		.driver_data = NFP_DEV_NFP6000,
+	}, {
+		PCI_VDEVICE_SUB(NETRONOME, PCI_DEVICE_ID_NFP6000,
+				PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID),
+		.class = PCI_ANY_ID,
+		.class_mask = 0,
+		.driver_data = NFP_DEV_NFP6000,
+	}, {
+		PCI_VDEVICE_SUB(CORIGINE, PCI_DEVICE_ID_NFP3800,
+				PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID),
+		.class = PCI_ANY_ID,
+		.class_mask = 0,
+		.driver_data = NFP_DEV_NFP3800,
+	}, {
+		PCI_VDEVICE_SUB(CORIGINE, PCI_DEVICE_ID_NFP4000,
+				PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID),
+		.class = PCI_ANY_ID,
+		.class_mask = 0,
+		.driver_data = NFP_DEV_NFP6000,
+	}, {
+		PCI_VDEVICE_SUB(CORIGINE, PCI_DEVICE_ID_NFP5000,
+				PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID),
+		.class = PCI_ANY_ID,
+		.class_mask = 0,
+		.driver_data = NFP_DEV_NFP6000,
+	}, {
+		PCI_VDEVICE_SUB(CORIGINE, PCI_DEVICE_ID_NFP6000,
+				PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID),
+		.class = PCI_ANY_ID,
+		.class_mask = 0,
+		.driver_data = NFP_DEV_NFP6000,
 	},
-	{ PCI_VENDOR_ID_NETRONOME, PCI_DEVICE_ID_NFP4000,
-	  PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP6000,
-	},
-	{ PCI_VENDOR_ID_NETRONOME, PCI_DEVICE_ID_NFP5000,
-	  PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP6000,
-	},
-	{ PCI_VENDOR_ID_NETRONOME, PCI_DEVICE_ID_NFP6000,
-	  PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP6000,
-	},
-	{ PCI_VENDOR_ID_CORIGINE, PCI_DEVICE_ID_NFP3800,
-	  PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP3800,
-	},
-	{ PCI_VENDOR_ID_CORIGINE, PCI_DEVICE_ID_NFP4000,
-	  PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP6000,
-	},
-	{ PCI_VENDOR_ID_CORIGINE, PCI_DEVICE_ID_NFP5000,
-	  PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP6000,
-	},
-	{ PCI_VENDOR_ID_CORIGINE, PCI_DEVICE_ID_NFP6000,
-	  PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP6000,
-	},
-	{ 0, } /* Required last entry. */
+	{ } /* Required last entry. */
 };
 MODULE_DEVICE_TABLE(pci, nfp_pci_device_ids);
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c b/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
index b5646c884371..cf557e0ce011 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
@@ -38,23 +38,32 @@ struct nfp_net_vf {
 static const char nfp_net_driver_name[] = "nfp_netvf";
 
 static const struct pci_device_id nfp_netvf_pci_device_ids[] = {
-	{ PCI_VENDOR_ID_NETRONOME, PCI_DEVICE_ID_NFP3800_VF,
-	  PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP3800_VF,
+	{
+		PCI_VDEVICE_SUB(NETRONOME, PCI_DEVICE_ID_NFP3800_VF,
+				PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID),
+		.class = PCI_ANY_ID,
+		.class_mask = 0,
+		.driver_data = NFP_DEV_NFP3800_VF,
+	}, {
+		PCI_VDEVICE_SUB(NETRONOME, PCI_DEVICE_ID_NFP6000_VF,
+				PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID),
+		.class = PCI_ANY_ID,
+		.class_mask = 0,
+		.driver_data = NFP_DEV_NFP6000_VF,
+	}, {
+		PCI_VDEVICE_SUB(CORIGINE, PCI_DEVICE_ID_NFP3800_VF,
+				PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID),
+		.class = PCI_ANY_ID,
+		.class_mask = 0,
+		.driver_data = NFP_DEV_NFP3800_VF,
+	}, {
+		PCI_VDEVICE_SUB(CORIGINE, PCI_DEVICE_ID_NFP6000_VF,
+				PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID),
+		.class = PCI_ANY_ID,
+		.class_mask = 0,
+		.driver_data = NFP_DEV_NFP6000_VF,
 	},
-	{ PCI_VENDOR_ID_NETRONOME, PCI_DEVICE_ID_NFP6000_VF,
-	  PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP6000_VF,
-	},
-	{ PCI_VENDOR_ID_CORIGINE, PCI_DEVICE_ID_NFP3800_VF,
-	  PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP3800_VF,
-	},
-	{ PCI_VENDOR_ID_CORIGINE, PCI_DEVICE_ID_NFP6000_VF,
-	  PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP6000_VF,
-	},
-	{ 0, } /* Required last entry. */
+	{ } /* Required last entry. */
 };
 MODULE_DEVICE_TABLE(pci, nfp_netvf_pci_device_ids);
 
diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 39842eb73bc3..cb0ae0650905 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -76,20 +76,20 @@ enum qede_pci_private {
 };
 
 static const struct pci_device_id qede_pci_tbl[] = {
-	{PCI_VDEVICE(QLOGIC, PCI_DEVICE_ID_57980S_40), QEDE_PRIVATE_PF},
-	{PCI_VDEVICE(QLOGIC, PCI_DEVICE_ID_57980S_10), QEDE_PRIVATE_PF},
-	{PCI_VDEVICE(QLOGIC, PCI_DEVICE_ID_57980S_MF), QEDE_PRIVATE_PF},
-	{PCI_VDEVICE(QLOGIC, PCI_DEVICE_ID_57980S_100), QEDE_PRIVATE_PF},
-	{PCI_VDEVICE(QLOGIC, PCI_DEVICE_ID_57980S_50), QEDE_PRIVATE_PF},
-	{PCI_VDEVICE(QLOGIC, PCI_DEVICE_ID_57980S_25), QEDE_PRIVATE_PF},
+	{ PCI_VDEVICE(QLOGIC, PCI_DEVICE_ID_57980S_40), .driver_data = QEDE_PRIVATE_PF },
+	{ PCI_VDEVICE(QLOGIC, PCI_DEVICE_ID_57980S_10), .driver_data = QEDE_PRIVATE_PF },
+	{ PCI_VDEVICE(QLOGIC, PCI_DEVICE_ID_57980S_MF), .driver_data = QEDE_PRIVATE_PF },
+	{ PCI_VDEVICE(QLOGIC, PCI_DEVICE_ID_57980S_100), .driver_data = QEDE_PRIVATE_PF },
+	{ PCI_VDEVICE(QLOGIC, PCI_DEVICE_ID_57980S_50), .driver_data = QEDE_PRIVATE_PF },
+	{ PCI_VDEVICE(QLOGIC, PCI_DEVICE_ID_57980S_25), .driver_data = QEDE_PRIVATE_PF },
 #ifdef CONFIG_QED_SRIOV
-	{PCI_VDEVICE(QLOGIC, PCI_DEVICE_ID_57980S_IOV), QEDE_PRIVATE_VF},
+	{ PCI_VDEVICE(QLOGIC, PCI_DEVICE_ID_57980S_IOV), .driver_data = QEDE_PRIVATE_VF },
 #endif
-	{PCI_VDEVICE(QLOGIC, PCI_DEVICE_ID_AH), QEDE_PRIVATE_PF},
+	{ PCI_VDEVICE(QLOGIC, PCI_DEVICE_ID_AH), .driver_data = QEDE_PRIVATE_PF },
 #ifdef CONFIG_QED_SRIOV
-	{PCI_VDEVICE(QLOGIC, PCI_DEVICE_ID_AH_IOV), QEDE_PRIVATE_VF},
+	{ PCI_VDEVICE(QLOGIC, PCI_DEVICE_ID_AH_IOV), .driver_data = QEDE_PRIVATE_VF },
 #endif
-	{ 0 }
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, qede_pci_tbl);
diff --git a/drivers/net/ethernet/realtek/8139too.c b/drivers/net/ethernet/realtek/8139too.c
index a8532ebd42ec..8241bcf76664 100644
--- a/drivers/net/ethernet/realtek/8139too.c
+++ b/drivers/net/ethernet/realtek/8139too.c
@@ -235,44 +235,44 @@ static const struct {
 
 
 static const struct pci_device_id rtl8139_pci_tbl[] = {
-	{0x10ec, 0x8139, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
-	{0x10ec, 0x8138, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
-	{0x1113, 0x1211, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
-	{0x1500, 0x1360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
-	{0x4033, 0x1360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
-	{0x1186, 0x1300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
-	{0x1186, 0x1340, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
-	{0x13d1, 0xab06, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
-	{0x1259, 0xa117, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
-	{0x1259, 0xa11e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
-	{0x14ea, 0xab06, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
-	{0x14ea, 0xab07, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
-	{0x11db, 0x1234, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
-	{0x1432, 0x9130, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
-	{0x02ac, 0x1012, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
-	{0x018a, 0x0106, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
-	{0x126c, 0x1211, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
-	{0x1743, 0x8139, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
-	{0x021b, 0x8139, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
-	{0x16ec, 0xab06, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
+	{ PCI_DEVICE(0x10ec, 0x8139), .driver_data = RTL8139 },
+	{ PCI_DEVICE(0x10ec, 0x8138), .driver_data = RTL8139 },
+	{ PCI_DEVICE(0x1113, 0x1211), .driver_data = RTL8139 },
+	{ PCI_DEVICE(0x1500, 0x1360), .driver_data = RTL8139 },
+	{ PCI_DEVICE(0x4033, 0x1360), .driver_data = RTL8139 },
+	{ PCI_DEVICE(0x1186, 0x1300), .driver_data = RTL8139 },
+	{ PCI_DEVICE(0x1186, 0x1340), .driver_data = RTL8139 },
+	{ PCI_DEVICE(0x13d1, 0xab06), .driver_data = RTL8139 },
+	{ PCI_DEVICE(0x1259, 0xa117), .driver_data = RTL8139 },
+	{ PCI_DEVICE(0x1259, 0xa11e), .driver_data = RTL8139 },
+	{ PCI_DEVICE(0x14ea, 0xab06), .driver_data = RTL8139 },
+	{ PCI_DEVICE(0x14ea, 0xab07), .driver_data = RTL8139 },
+	{ PCI_DEVICE(0x11db, 0x1234), .driver_data = RTL8139 },
+	{ PCI_DEVICE(0x1432, 0x9130), .driver_data = RTL8139 },
+	{ PCI_DEVICE(0x02ac, 0x1012), .driver_data = RTL8139 },
+	{ PCI_DEVICE(0x018a, 0x0106), .driver_data = RTL8139 },
+	{ PCI_DEVICE(0x126c, 0x1211), .driver_data = RTL8139 },
+	{ PCI_DEVICE(0x1743, 0x8139), .driver_data = RTL8139 },
+	{ PCI_DEVICE(0x021b, 0x8139), .driver_data = RTL8139 },
+	{ PCI_DEVICE(0x16ec, 0xab06), .driver_data = RTL8139 },
 
 #ifdef CONFIG_SH_SECUREEDGE5410
 	/* Bogus 8139 silicon reports 8129 without external PROM :-( */
-	{0x10ec, 0x8129, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
+	{ PCI_DEVICE(0x10ec, 0x8129), .driver_data = RTL8139 },
 #endif
 #ifdef CONFIG_8139TOO_8129
-	{0x10ec, 0x8129, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8129 },
+	{ PCI_DEVICE(0x10ec, 0x8129), .driver_data = RTL8129 },
 #endif
 
 	/* some crazy cards report invalid vendor ids like
 	 * 0x0001 here.  The other ids are valid and constant,
 	 * so we simply don't match on the main vendor id.
 	 */
-	{PCI_ANY_ID, 0x8139, 0x10ec, 0x8139, 0, 0, RTL8139 },
-	{PCI_ANY_ID, 0x8139, 0x1186, 0x1300, 0, 0, RTL8139 },
-	{PCI_ANY_ID, 0x8139, 0x13d1, 0xab06, 0, 0, RTL8139 },
+	{ PCI_DEVICE_SUB(PCI_ANY_ID, 0x8139, 0x10ec, 0x8139), .driver_data = RTL8139 },
+	{ PCI_DEVICE_SUB(PCI_ANY_ID, 0x8139, 0x1186, 0x1300), .driver_data = RTL8139 },
+	{ PCI_DEVICE_SUB(PCI_ANY_ID, 0x8139, 0x13d1, 0xab06), .driver_data = RTL8139 },
 
-	{0,}
+	{ }
 };
 MODULE_DEVICE_TABLE (pci, rtl8139_pci_tbl);
 
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 791277e750ba..ec4fc21fa21f 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -229,7 +229,7 @@ static const struct pci_device_id rtl8169_pci_tbl[] = {
 	{ PCI_VDEVICE(REALTEK,	0x2502) },
 	{ PCI_VDEVICE(REALTEK,	0x2600) },
 	{ PCI_VDEVICE(REALTEK,	0x8129) },
-	{ PCI_VDEVICE(REALTEK,	0x8136), RTL_CFG_NO_GBIT },
+	{ PCI_VDEVICE(REALTEK,	0x8136), .driver_data = RTL_CFG_NO_GBIT },
 	{ PCI_VDEVICE(REALTEK,	0x8161) },
 	{ PCI_VDEVICE(REALTEK,	0x8162) },
 	{ PCI_VDEVICE(REALTEK,	0x8167) },
@@ -240,15 +240,15 @@ static const struct pci_device_id rtl8169_pci_tbl[] = {
 	{ PCI_VDEVICE(DLINK,	0x4302) },
 	{ PCI_VDEVICE(AT,	0xc107) },
 	{ PCI_VDEVICE(USR,	0x0116) },
-	{ PCI_VENDOR_ID_LINKSYS, 0x1032, PCI_ANY_ID, 0x0024 },
-	{ 0x0001, 0x8168, PCI_ANY_ID, 0x2410 },
+	{ PCI_VDEVICE_SUB(LINKSYS, 0x1032, PCI_ANY_ID, 0x0024) },
+	{ PCI_DEVICE_SUB(0x0001, 0x8168, PCI_ANY_ID, 0x2410) },
 	{ PCI_VDEVICE(REALTEK,	0x8125) },
 	{ PCI_VDEVICE(REALTEK,	0x8126) },
 	{ PCI_VDEVICE(REALTEK,	0x8127) },
 	{ PCI_VDEVICE(REALTEK,	0x3000) },
 	{ PCI_VDEVICE(REALTEK,	0x5000) },
 	{ PCI_VDEVICE(REALTEK,	0x0e10) },
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, rtl8169_pci_tbl);
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index ff6ca7b2cd4f..84a55f2b48ff 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -40,8 +40,8 @@
 static const char rocker_driver_name[] = "rocker";
 
 static const struct pci_device_id rocker_pci_id_table[] = {
-	{PCI_VDEVICE(REDHAT, PCI_DEVICE_ID_REDHAT_ROCKER), 0},
-	{0, }
+	{ PCI_VDEVICE(REDHAT, PCI_DEVICE_ID_REDHAT_ROCKER) },
+	{ }
 };
 
 struct rocker_wait {
diff --git a/drivers/net/ethernet/sis/sis190.c b/drivers/net/ethernet/sis/sis190.c
index 12ddea514910..ed5276d492b9 100644
--- a/drivers/net/ethernet/sis/sis190.c
+++ b/drivers/net/ethernet/sis/sis190.c
@@ -331,9 +331,9 @@ static const struct {
 };
 
 static const struct pci_device_id sis190_pci_tbl[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_SI, 0x0190), 0, 0, 0 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_SI, 0x0191), 0, 0, 1 },
-	{ 0, },
+	{ PCI_VDEVICE(SI, 0x0190), .driver_data = 0 },
+	{ PCI_VDEVICE(SI, 0x0191), .driver_data = 1 },
+	{ },
 };
 
 MODULE_DEVICE_TABLE(pci, sis190_pci_tbl);
diff --git a/drivers/net/ethernet/sis/sis900.c b/drivers/net/ethernet/sis/sis900.c
index 1349ef50cd26..6e9afd9042f7 100644
--- a/drivers/net/ethernet/sis/sis900.c
+++ b/drivers/net/ethernet/sis/sis900.c
@@ -104,11 +104,11 @@ static const char * card_names[] = {
 };
 
 static const struct pci_device_id sis900_pci_tbl[] = {
-	{PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_900,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, SIS_900},
-	{PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_7016,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, SIS_7016},
-	{0,}
+	{ PCI_VDEVICE(SI, PCI_DEVICE_ID_SI_900),
+	  .driver_data = SIS_900 },
+	{ PCI_VDEVICE(SI, PCI_DEVICE_ID_SI_7016),
+	  .driver_data = SIS_7016 },
+	{ }
 };
 MODULE_DEVICE_TABLE (pci, sis900_pci_tbl);
 
diff --git a/drivers/net/ethernet/smsc/epic100.c b/drivers/net/ethernet/smsc/epic100.c
index 389659db06a8..60538b7fe684 100644
--- a/drivers/net/ethernet/smsc/epic100.c
+++ b/drivers/net/ethernet/smsc/epic100.c
@@ -166,11 +166,19 @@ static const struct epic_chip_info pci_id_tbl[] = {
 
 
 static const struct pci_device_id epic_pci_tbl[] = {
-	{ 0x10B8, 0x0005, 0x1092, 0x0AB4, 0, 0, SMSC_83C170_0 },
-	{ 0x10B8, 0x0005, PCI_ANY_ID, PCI_ANY_ID, 0, 0, SMSC_83C170 },
-	{ 0x10B8, 0x0006, PCI_ANY_ID, PCI_ANY_ID,
-	  PCI_CLASS_NETWORK_ETHERNET << 8, 0xffff00, SMSC_83C175 },
-	{ 0,}
+	{
+		PCI_DEVICE_SUB(0x10B8, 0x0005, 0x1092, 0x0AB4),
+		.driver_data = SMSC_83C170_0,
+	}, {
+		PCI_DEVICE(0x10B8, 0x0005),
+		.driver_data = SMSC_83C170,
+	}, {
+		PCI_DEVICE(0x10B8, 0x0006),
+		.class = PCI_CLASS_NETWORK_ETHERNET << 8,
+		.class_mask = 0xffff00,
+		.driver_data = SMSC_83C175,
+	},
+	{ }
 };
 MODULE_DEVICE_TABLE (pci, epic_pci_tbl);
 
diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index fe00e7dd3fe4..823870c999bf 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -218,11 +218,9 @@ static u16 link_modes[] = {
 };
 
 static const struct pci_device_id cas_pci_tbl[] = {
-	{ PCI_VENDOR_ID_SUN, PCI_DEVICE_ID_SUN_CASSINI,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SATURN,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ 0, }
+	{ PCI_VDEVICE(SUN, PCI_DEVICE_ID_SUN_CASSINI) },
+	{ PCI_VDEVICE(NS, PCI_DEVICE_ID_NS_SATURN) },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, cas_pci_tbl);
diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index 8e69d917d827..234ffc3c6a61 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -85,8 +85,7 @@ MODULE_LICENSE("GPL");
 #define GEM_MODULE_NAME	"gem"
 
 static const struct pci_device_id gem_pci_tbl[] = {
-	{ PCI_VENDOR_ID_SUN, PCI_DEVICE_ID_SUN_GEM,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
+	{ PCI_VDEVICE(SUN, PCI_DEVICE_ID_SUN_GEM) },
 
 	/* These models only differ from the original GEM in
 	 * that their tx/rx fifos are of a different size and
@@ -95,21 +94,14 @@ static const struct pci_device_id gem_pci_tbl[] = {
 	 * Apple's GMAC does support gigabit on machines with
 	 * the BCM54xx PHYs. -BenH
 	 */
-	{ PCI_VENDOR_ID_SUN, PCI_DEVICE_ID_SUN_RIO_GEM,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_UNI_N_GMAC,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_UNI_N_GMACP,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_UNI_N_GMAC2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_K2_GMAC,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_SH_SUNGEM,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_IPID2_GMAC,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{0, }
+	{ PCI_VDEVICE(SUN, PCI_DEVICE_ID_SUN_RIO_GEM) },
+	{ PCI_VDEVICE(APPLE, PCI_DEVICE_ID_APPLE_UNI_N_GMAC) },
+	{ PCI_VDEVICE(APPLE, PCI_DEVICE_ID_APPLE_UNI_N_GMACP) },
+	{ PCI_VDEVICE(APPLE, PCI_DEVICE_ID_APPLE_UNI_N_GMAC2) },
+	{ PCI_VDEVICE(APPLE, PCI_DEVICE_ID_APPLE_K2_GMAC) },
+	{ PCI_VDEVICE(APPLE, PCI_DEVICE_ID_APPLE_SH_SUNGEM) },
+	{ PCI_VDEVICE(APPLE, PCI_DEVICE_ID_APPLE_IPID2_GMAC) },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, gem_pci_tbl);
diff --git a/drivers/net/ethernet/ti/tlan.c b/drivers/net/ethernet/ti/tlan.c
index a55b0f951181..274a1837025c 100644
--- a/drivers/net/ethernet/ti/tlan.c
+++ b/drivers/net/ethernet/ti/tlan.c
@@ -119,33 +119,20 @@ static struct board {
 };
 
 static const struct pci_device_id tlan_pci_tbl[] = {
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_NETEL10,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_NETEL100,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1 },
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_NETFLEX3I,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2 },
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_THUNDER,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3 },
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_NETFLEX3B,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_NETEL100PI,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5 },
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_NETEL100D,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6 },
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_NETEL100I,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 7 },
-	{ PCI_VENDOR_ID_OLICOM, PCI_DEVICE_ID_OLICOM_OC2183,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
-	{ PCI_VENDOR_ID_OLICOM, PCI_DEVICE_ID_OLICOM_OC2325,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 9 },
-	{ PCI_VENDOR_ID_OLICOM, PCI_DEVICE_ID_OLICOM_OC2326,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10 },
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_NETELLIGENT_10_100_WS_5100,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11 },
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_NETELLIGENT_10_T2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12 },
-	{ 0,}
+	{ PCI_VDEVICE(COMPAQ, PCI_DEVICE_ID_COMPAQ_NETEL10), .driver_data = 0 },
+	{ PCI_VDEVICE(COMPAQ, PCI_DEVICE_ID_COMPAQ_NETEL100), .driver_data = 1 },
+	{ PCI_VDEVICE(COMPAQ, PCI_DEVICE_ID_COMPAQ_NETFLEX3I), .driver_data = 2 },
+	{ PCI_VDEVICE(COMPAQ, PCI_DEVICE_ID_COMPAQ_THUNDER), .driver_data = 3 },
+	{ PCI_VDEVICE(COMPAQ, PCI_DEVICE_ID_COMPAQ_NETFLEX3B), .driver_data = 4 },
+	{ PCI_VDEVICE(COMPAQ, PCI_DEVICE_ID_COMPAQ_NETEL100PI), .driver_data = 5 },
+	{ PCI_VDEVICE(COMPAQ, PCI_DEVICE_ID_COMPAQ_NETEL100D), .driver_data = 6 },
+	{ PCI_VDEVICE(COMPAQ, PCI_DEVICE_ID_COMPAQ_NETEL100I), .driver_data = 7 },
+	{ PCI_VDEVICE(OLICOM, PCI_DEVICE_ID_OLICOM_OC2183), .driver_data = 8 },
+	{ PCI_VDEVICE(OLICOM, PCI_DEVICE_ID_OLICOM_OC2325), .driver_data = 9 },
+	{ PCI_VDEVICE(OLICOM, PCI_DEVICE_ID_OLICOM_OC2326), .driver_data = 10 },
+	{ PCI_VDEVICE(COMPAQ, PCI_DEVICE_ID_NETELLIGENT_10_100_WS_5100), .driver_data = 11 },
+	{ PCI_VDEVICE(COMPAQ, PCI_DEVICE_ID_NETELLIGENT_10_T2), .driver_data = 12 },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, tlan_pci_tbl);
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index d8e3827a8b1f..d51d8db95a76 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -30,20 +30,20 @@ char ngbe_driver_name[] = "ngbe";
  *   Class, Class Mask, private data (not used) }
  */
 static const struct pci_device_id ngbe_pci_tbl[] = {
-	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860AL_W), 0},
-	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860A2), 0},
-	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860A2S), 0},
-	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860A4), 0},
-	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860A4S), 0},
-	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860AL2), 0},
-	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860AL2S), 0},
-	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860AL4), 0},
-	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860AL4S), 0},
-	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860LC), 0},
-	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860A1), 0},
-	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860A1L), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860AL_W) },
+	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860A2) },
+	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860A2S) },
+	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860A4) },
+	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860A4S) },
+	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860AL2) },
+	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860AL2S) },
+	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860AL4) },
+	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860AL4S) },
+	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860LC) },
+	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860A1) },
+	{ PCI_VDEVICE(WANGXUN, NGBE_DEV_ID_EM_WX1860A1L) },
 	/* required last entry */
-	{ .device = 0 }
+	{ }
 };
 
 /**
diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
index 6ef43adcc425..d79cf8d8484f 100644
--- a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
+++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
@@ -26,20 +26,20 @@
  *   Class, Class Mask, private data (not used) }
  */
 static const struct pci_device_id ngbevf_pci_tbl[] = {
-	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL_W), 0},
-	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860A2), 0},
-	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860A2S), 0},
-	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860A4), 0},
-	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860A4S), 0},
-	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL2), 0},
-	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL2S), 0},
-	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL4), 0},
-	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL4S), 0},
-	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860NCSI), 0},
-	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860A1), 0},
-	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL1), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL_W) },
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860A2) },
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860A2S) },
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860A4) },
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860A4S) },
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL2) },
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL2S) },
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL4) },
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL4S) },
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860NCSI) },
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860A1) },
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL1) },
 	/* required last entry */
-	{ .device = 0 }
+	{ }
 };
 
 static const struct net_device_ops ngbevf_netdev_ops = {
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 8b7c3753bb6a..4c549c2644ab 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -37,16 +37,16 @@ char txgbe_driver_name[] = "txgbe";
  *   Class, Class Mask, private data (not used) }
  */
 static const struct pci_device_id txgbe_pci_tbl[] = {
-	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_SP1000), 0},
-	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_WX1820), 0},
-	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_AML5010), 0},
-	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_AML5110), 0},
-	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_AML5025), 0},
-	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_AML5125), 0},
-	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_AML5040), 0},
-	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_AML5140), 0},
+	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_SP1000) },
+	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_WX1820) },
+	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_AML5010) },
+	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_AML5110) },
+	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_AML5025) },
+	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_AML5125) },
+	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_AML5040) },
+	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_AML5140) },
 	/* required last entry */
-	{ .device = 0 }
+	{ }
 };
 
 #define DEFAULT_DEBUG_LEVEL_SHIFT 3
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
index 37e4ec487afd..8b16b900820a 100644
--- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
@@ -26,16 +26,16 @@
  *   Class, Class Mask, private data (not used) }
  */
 static const struct pci_device_id txgbevf_pci_tbl[] = {
-	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_SP1000), 0},
-	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_WX1820), 0},
-	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML500F), 0},
-	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML510F), 0},
-	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML5024), 0},
-	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML5124), 0},
-	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML503F), 0},
-	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML513F), 0},
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_SP1000) },
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_WX1820) },
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML500F) },
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML510F) },
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML5024) },
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML5124) },
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML503F) },
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML513F) },
 	/* required last entry */
-	{ .device = 0 }
+	{ }
 };
 
 static const struct net_device_ops txgbevf_netdev_ops = {
diff --git a/drivers/net/wan/farsync.c b/drivers/net/wan/farsync.c
index 73f393900710..6508c53bdc24 100644
--- a/drivers/net/wan/farsync.c
+++ b/drivers/net/wan/farsync.c
@@ -524,27 +524,21 @@ do {								\
 /*      PCI ID lookup table
  */
 static const struct pci_device_id fst_pci_dev_id[] = {
-	{PCI_VENDOR_ID_FARSITE, PCI_DEVICE_ID_FARSITE_T2P, PCI_ANY_ID,
-	 PCI_ANY_ID, 0, 0, FST_TYPE_T2P},
+	{ PCI_VDEVICE(FARSITE, PCI_DEVICE_ID_FARSITE_T2P), .driver_data = FST_TYPE_T2P },
 
-	{PCI_VENDOR_ID_FARSITE, PCI_DEVICE_ID_FARSITE_T4P, PCI_ANY_ID,
-	 PCI_ANY_ID, 0, 0, FST_TYPE_T4P},
+	{ PCI_VDEVICE(FARSITE, PCI_DEVICE_ID_FARSITE_T4P), .driver_data = FST_TYPE_T4P },
 
-	{PCI_VENDOR_ID_FARSITE, PCI_DEVICE_ID_FARSITE_T1U, PCI_ANY_ID,
-	 PCI_ANY_ID, 0, 0, FST_TYPE_T1U},
+	{ PCI_VDEVICE(FARSITE, PCI_DEVICE_ID_FARSITE_T1U), .driver_data = FST_TYPE_T1U },
 
-	{PCI_VENDOR_ID_FARSITE, PCI_DEVICE_ID_FARSITE_T2U, PCI_ANY_ID,
-	 PCI_ANY_ID, 0, 0, FST_TYPE_T2U},
+	{ PCI_VDEVICE(FARSITE, PCI_DEVICE_ID_FARSITE_T2U), .driver_data = FST_TYPE_T2U },
 
-	{PCI_VENDOR_ID_FARSITE, PCI_DEVICE_ID_FARSITE_T4U, PCI_ANY_ID,
-	 PCI_ANY_ID, 0, 0, FST_TYPE_T4U},
+	{ PCI_VDEVICE(FARSITE, PCI_DEVICE_ID_FARSITE_T4U), .driver_data = FST_TYPE_T4U },
 
-	{PCI_VENDOR_ID_FARSITE, PCI_DEVICE_ID_FARSITE_TE1, PCI_ANY_ID,
-	 PCI_ANY_ID, 0, 0, FST_TYPE_TE1},
+	{ PCI_VDEVICE(FARSITE, PCI_DEVICE_ID_FARSITE_TE1), .driver_data = FST_TYPE_TE1 },
 
-	{PCI_VENDOR_ID_FARSITE, PCI_DEVICE_ID_FARSITE_TE1C, PCI_ANY_ID,
-	 PCI_ANY_ID, 0, 0, FST_TYPE_TE1},
-	{0,}			/* End */
+	{ PCI_VDEVICE(FARSITE, PCI_DEVICE_ID_FARSITE_TE1C), .driver_data = FST_TYPE_TE1 },
+
+	{ }			/* End */
 };
 
 MODULE_DEVICE_TABLE(pci, fst_pci_dev_id);
diff --git a/drivers/net/wan/pc300too.c b/drivers/net/wan/pc300too.c
index 7e57d289b62c..a91564e53caa 100644
--- a/drivers/net/wan/pc300too.c
+++ b/drivers/net/wan/pc300too.c
@@ -461,15 +461,11 @@ static int pc300_pci_init_one(struct pci_dev *pdev,
 }
 
 static const struct pci_device_id pc300_pci_tbl[] = {
-	{ PCI_VENDOR_ID_CYCLADES, PCI_DEVICE_ID_PC300_RX_1, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_CYCLADES, PCI_DEVICE_ID_PC300_RX_2, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_CYCLADES, PCI_DEVICE_ID_PC300_TE_1, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_CYCLADES, PCI_DEVICE_ID_PC300_TE_2, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, 0, 0 },
-	{ 0, }
+	{ PCI_VDEVICE(CYCLADES, PCI_DEVICE_ID_PC300_RX_1) },
+	{ PCI_VDEVICE(CYCLADES, PCI_DEVICE_ID_PC300_RX_2) },
+	{ PCI_VDEVICE(CYCLADES, PCI_DEVICE_ID_PC300_TE_1) },
+	{ PCI_VDEVICE(CYCLADES, PCI_DEVICE_ID_PC300_TE_2) },
+	{ }
 };
 
 static struct pci_driver pc300_pci_driver = {
diff --git a/drivers/net/wan/pci200syn.c b/drivers/net/wan/pci200syn.c
index 89f4b4584a33..9503130fd9a8 100644
--- a/drivers/net/wan/pci200syn.c
+++ b/drivers/net/wan/pci200syn.c
@@ -397,9 +397,9 @@ static int pci200_pci_init_one(struct pci_dev *pdev,
 }
 
 static const struct pci_device_id pci200_pci_tbl[] = {
-	{ PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050, PCI_VENDOR_ID_PLX,
-	  PCI_DEVICE_ID_PLX_PCI200SYN, 0, 0, 0 },
-	{ 0, }
+	{ PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9050,
+			  PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_PCI200SYN) },
+	{ }
 };
 
 static struct pci_driver pci200_pci_driver = {
diff --git a/drivers/net/wan/wanxl.c b/drivers/net/wan/wanxl.c
index 3f7707118450..d4da88c77112 100644
--- a/drivers/net/wan/wanxl.c
+++ b/drivers/net/wan/wanxl.c
@@ -806,13 +806,10 @@ static int wanxl_pci_init_one(struct pci_dev *pdev,
 }
 
 static const struct pci_device_id wanxl_pci_tbl[] = {
-	{ PCI_VENDOR_ID_SBE, PCI_DEVICE_ID_SBE_WANXL100, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_SBE, PCI_DEVICE_ID_SBE_WANXL200, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_SBE, PCI_DEVICE_ID_SBE_WANXL400, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, 0, 0 },
-	{ 0, }
+	{ PCI_VDEVICE(SBE, PCI_DEVICE_ID_SBE_WANXL100) },
+	{ PCI_VDEVICE(SBE, PCI_DEVICE_ID_SBE_WANXL200) },
+	{ PCI_VDEVICE(SBE, PCI_DEVICE_ID_SBE_WANXL400) },
+	{ }
 };
 
 static struct pci_driver wanxl_pci_driver = {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 45b342ea0637..13662aa4b4ea 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -2708,17 +2708,18 @@ static const struct dev_pm_ops brcmf_pciedrvr_pm = {
 
 #define BRCMF_PCIE_DEVICE(dev_id, fw_vend) \
 	{ \
-		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
-		PCI_ANY_ID, PCI_ANY_ID, \
-		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
-		BRCMF_DRVDATA_ ## fw_vend \
+		PCI_DEVICE(BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id)), \
+		.class = PCI_CLASS_NETWORK_OTHER << 8, \
+		.class_mask = 0xffff00, \
+		.driver_data = BRCMF_DRVDATA_ ## fw_vend, \
 	}
 #define BRCMF_PCIE_DEVICE_SUB(dev_id, subvend, subdev, fw_vend) \
 	{ \
-		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
-		(subvend), (subdev), \
-		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
-		BRCMF_DRVDATA_ ## fw_vend \
+		PCI_DEVICE_SUB(BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
+			       (subvend), (subdev)), \
+		.class = PCI_CLASS_NETWORK_OTHER << 8, \
+		.class_mask = 0xffff00, \
+		.driver_data = BRCMF_DRVDATA_ ## fw_vend, \
 	}
 
 static const struct pci_device_id brcmf_pcie_devid_table[] = {
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index dd64d21174e3..4bc9bb406e8e 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -11366,37 +11366,41 @@ static int ipw_wdev_init(struct net_device *dev)
 
 /* PCI driver stuff */
 static const struct pci_device_id card_ids[] = {
-	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2701, 0, 0, 0},
-	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2702, 0, 0, 0},
-	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2711, 0, 0, 0},
-	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2712, 0, 0, 0},
-	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2721, 0, 0, 0},
-	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2722, 0, 0, 0},
-	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2731, 0, 0, 0},
-	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2732, 0, 0, 0},
-	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2741, 0, 0, 0},
-	{PCI_VENDOR_ID_INTEL, 0x1043, 0x103c, 0x2741, 0, 0, 0},
-	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2742, 0, 0, 0},
-	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2751, 0, 0, 0},
-	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2752, 0, 0, 0},
-	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2753, 0, 0, 0},
-	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2754, 0, 0, 0},
-	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2761, 0, 0, 0},
-	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2762, 0, 0, 0},
+	{ PCI_VDEVICE_SUB(INTEL, 0x1043, 0x8086, 0x2701) },
+	{ PCI_VDEVICE_SUB(INTEL, 0x1043, 0x8086, 0x2702) },
+	{ PCI_VDEVICE_SUB(INTEL, 0x1043, 0x8086, 0x2711) },
+	{ PCI_VDEVICE_SUB(INTEL, 0x1043, 0x8086, 0x2712) },
+	{ PCI_VDEVICE_SUB(INTEL, 0x1043, 0x8086, 0x2721) },
+	{ PCI_VDEVICE_SUB(INTEL, 0x1043, 0x8086, 0x2722) },
+	{ PCI_VDEVICE_SUB(INTEL, 0x1043, 0x8086, 0x2731) },
+	{ PCI_VDEVICE_SUB(INTEL, 0x1043, 0x8086, 0x2732) },
+	{ PCI_VDEVICE_SUB(INTEL, 0x1043, 0x8086, 0x2741) },
+	{ PCI_VDEVICE_SUB(INTEL, 0x1043, 0x103c, 0x2741) },
+	{ PCI_VDEVICE_SUB(INTEL, 0x1043, 0x8086, 0x2742) },
+	{ PCI_VDEVICE_SUB(INTEL, 0x1043, 0x8086, 0x2751) },
+	{ PCI_VDEVICE_SUB(INTEL, 0x1043, 0x8086, 0x2752) },
+	{ PCI_VDEVICE_SUB(INTEL, 0x1043, 0x8086, 0x2753) },
+	{ PCI_VDEVICE_SUB(INTEL, 0x1043, 0x8086, 0x2754) },
+	{ PCI_VDEVICE_SUB(INTEL, 0x1043, 0x8086, 0x2761) },
+	{ PCI_VDEVICE_SUB(INTEL, 0x1043, 0x8086, 0x2762) },
+
 	/*
 	 * This ID conflicts with i40e, but the devices can be differentiated
 	 * because i40e devices use PCI_CLASS_NETWORK_ETHERNET and ipw2200
 	 * devices use PCI_CLASS_NETWORK_OTHER.
 	 */
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x104f),
-		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, 0},
-	{PCI_VDEVICE(INTEL, 0x4220), 0},	/* BG */
-	{PCI_VDEVICE(INTEL, 0x4221), 0},	/* BG */
-	{PCI_VDEVICE(INTEL, 0x4223), 0},	/* ABG */
-	{PCI_VDEVICE(INTEL, 0x4224), 0},	/* ABG */
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x104f),
+		.class = PCI_CLASS_NETWORK_OTHER << 8,
+		.class_mask = 0xffff00,
+	},
+	{ PCI_VDEVICE(INTEL, 0x4220) },	/* BG */
+	{ PCI_VDEVICE(INTEL, 0x4221) },	/* BG */
+	{ PCI_VDEVICE(INTEL, 0x4223) },	/* ABG */
+	{ PCI_VDEVICE(INTEL, 0x4224) },	/* ABG */
 
 	/* required last entry */
-	{0,}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, card_ids);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3


