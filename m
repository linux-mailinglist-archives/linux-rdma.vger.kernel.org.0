Return-Path: <linux-rdma+bounces-13585-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A68DB948A2
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 08:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBBDA3A5625
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 06:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AF930F546;
	Tue, 23 Sep 2025 06:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iJUT2WJy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B12224BCF5
	for <linux-rdma@vger.kernel.org>; Tue, 23 Sep 2025 06:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608537; cv=none; b=E4MCzRndRpWNgTHW2oW0zUlpVsu4E9X9LFY/1RZLX8hLcXnMIO6cpHnlnksetpJHX8PhOjzwaarf/TSfNgQ7rTAQW25gRvwtPUHw53sI1pFcboYPmhc5x3bAPMaIUhF+8vqIHFNUv1M+Kalxpo3sbQ4Ap3OZBNGgy5XISdEAV08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608537; c=relaxed/simple;
	bh=o4JmdKuLcQfTUsTj3MD9PemUAYgxTdWyIbbaNCPabgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eElLN80aLTEAWuRP91B6eZlxusDWFY1eS29IrqwtKl713ZE40zWZul4D7mqJ7OaHS6mJVVM2TPUBWP6UYT7VDhGMCp8pE0xjPu9Nm0NNlFhwJIPL4IYYXwAHGCjYFu44ZQNg1YbwTV7GZ5UeR0kjbnvSs9T08mfwKruPFAg8xOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iJUT2WJy; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-b553412a19bso1722715a12.1
        for <linux-rdma@vger.kernel.org>; Mon, 22 Sep 2025 23:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758608535; x=1759213335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlhAIGyCbD0W994mehaU6IN17cEBI7olLdc+pSVw5Us=;
        b=Ky4YCAIZWWZibrb9ot31zKSKazbaoePfa+X9ewUuyc6iLlZeRZfvarZTwr/8Hv7hBg
         ekWuUGagTKAWlkRHHV7Aqdp+1eEjNsmZIej4velr/eu1tPA3U/24VhD22AxDbg4c0m0g
         0QeBwgtlQt356WQekjLSV2aNfmko1b5dmnk/0x0kNKibvXt+qKVpCnotYGCABKmWuXO+
         Y16Bm3OaZy/pLUc4mucc+731/IFWJf2vL5uTwhGQsgEe9huYS8hJ0n19eZCbBtpM/fHo
         xA80Frq5j9BMFvNyRw8xSlubBtzIIpnXacgj5CnlHfmWD2e/dtLD/LLxX+hpvYLH1/Ce
         c81Q==
X-Gm-Message-State: AOJu0YzS8gtXDrvhig03++/ukgN77ivdLCvct6zYfH9iB4lUoh385aCC
	xEDASRuQqTbmJW0tWXCzDWEuAr1M8QXki7zpLKLSFe2sTYu8oq6LqcZv+AdIbex21IIuQVyLDwj
	q1Kzu9UzKhw40r9jj21C9F3opePmo7SDwTDCygRZwXVd3XVPkh7M+KsTFLeY2+0zRUy3pbNedCQ
	olMnbPp9y/RVNhxIIi/nLlExDdjEPx+h+g0tCDjaQFZMvwXTP+SQOIxw/vAM4SPku7LHjERYzgw
	R9CVM9i0BIQzCl9t2KDoUUCCKEQ/Q==
X-Gm-Gg: ASbGncuFJOYqdlRkHzqb/appZC5xXEQBVI3/ARD14BcGlS7Gq39ZD5i6u6cRLCJbq2c
	qCqyzkFOACpVztGlR2FJu3FM1hJIHWkzoBH+JxB7whJC88sTyjlHPxnML2Ds2UFRKKxQ5j48yiH
	A7H1KVgC6B3x+nYbsYF2EW6Sd9Vfs6ClgfsTGUvUVA4ZQxRVOmwHaYUag/Yw8LgBp5HdtIjI48f
	zVkWub8mi90guIKsDoA3USlZPWXS9ZYdPF5EsYhR24q5KM0r3wCPJOU9WeJ8taJdk4NwMw1kFjR
	wYxr0ArmNWKn3tCd/IO2NALm9+crSVll+6RB8VWryCRH14EEAMVCdw7XaFIIgazpiAlXGlxWSHa
	vltkY4LIMhd9DAAOOd25YVutP9t3etneoLLPy/5+AeSIXR086lhDTYyppeHE6XwyGnqmADYI0RG
	4euK0P0MeMt+2un10=
X-Google-Smtp-Source: AGHT+IHzju6rJheA/n+9eRIXhogZ3kXcv1Piz0kMURjvTezweDfoP4pklc9ZJQKRTY9gw/kSdxfdUUeaJTIb
X-Received: by 2002:a17:903:11c3:b0:24b:25f:5f81 with SMTP id d9443c01a7336-27cc1e1f429mr22705195ad.17.1758608535481;
        Mon, 22 Sep 2025 23:22:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-269802c23fcsm9656315ad.72.2025.09.22.23.22.15
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 23:22:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2699ed6d43dso50859005ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 22 Sep 2025 23:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758608534; x=1759213334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JlhAIGyCbD0W994mehaU6IN17cEBI7olLdc+pSVw5Us=;
        b=iJUT2WJyX3A2Ufzv9aW6v2NPINLX6rddNiyqC0S9JCtghxnvNyukfwT4EZ5jm5N9Pl
         FPkN8nFxkR24ADS1dTGpcFhamPn1T+BK5cxjLsVZ5F/4gpjFu+A93niNdzw6cfFgMLDP
         hiS3AGnb3jRRtD+YNe+Hso3D94xRuttfrd7Sc=
X-Received: by 2002:a17:902:e84d:b0:263:ac60:fc41 with SMTP id d9443c01a7336-27cc76e2007mr17098915ad.48.1758608533585;
        Mon, 22 Sep 2025 23:22:13 -0700 (PDT)
X-Received: by 2002:a17:902:e84d:b0:263:ac60:fc41 with SMTP id d9443c01a7336-27cc76e2007mr17098725ad.48.1758608533234;
        Mon, 22 Sep 2025 23:22:13 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053db2sm152582285ad.2.2025.09.22.23.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 23:22:12 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next 0/2] RDMA/bnxt_re: Update RDMA hw_counters sysfs interface
Date: Tue, 23 Sep 2025 11:56:55 +0530
Message-ID: <20250923062657.981487-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Driver currently exposes many non-hw counters through the RDMA hw_counters
sysfs interface. This patchset cleans it up by removing the non-statistics
counters from the RDMA hw_counters.

This change ensures that the hw_counters sysfs interface contains only the
true performance and error statistics counters.

Added a debugfs info entry to expose driver specific counters.

Anantha Prabhu (2):
  RDMA/bnxt_re: Add debugfs info entry for device and resource
    information
  RDMA/bnxt_re: Remove non-statistics counters from hw_counters

 drivers/infiniband/hw/bnxt_re/debugfs.c     | 37 +++++++++++++
 drivers/infiniband/hw/bnxt_re/hw_counters.c | 58 ---------------------
 drivers/infiniband/hw/bnxt_re/hw_counters.h | 23 --------
 3 files changed, 37 insertions(+), 81 deletions(-)

-- 
2.43.5


