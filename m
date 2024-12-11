Return-Path: <linux-rdma+bounces-6413-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633CF9EC3D8
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 05:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29511614C6
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 04:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9361A0731;
	Wed, 11 Dec 2024 04:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hGn/kX2f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6A72451C0
	for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 04:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733889993; cv=none; b=b1FiGUdhfToGlIjo2CND4Bw6ZGy0cp0zFDSSOW8IRsNB5CHgIMjpydNyF5+lG6CO9mHt64mMSiCNjn7USC1W791PdCLnJcROGU03k7Z9mdht9hvCgf7WxloRbNKyasqmzSIPNByJenYP2B2fM6nsteDbHe03hHreHwvpSdvPrWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733889993; c=relaxed/simple;
	bh=6BWEqYAxtfALLed56Px1O+zkst8WO3c9U5YWjWrAIxw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=VyJTfzIft9EyMy2ho1nGfisfN+an6NG7DULWa6D5x3+0V5PCIvgUjBQUXU17AnVU2FbgqCkF4Nzb5XQB71MPF9Fe0oitJa8lxI6DE0z2mTvyq9AyYm3W1kHtWQXY13pn1k8VjUIezT6Pnx6TbphNbTfuQSYy0fFa2xVky6XIoTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hGn/kX2f; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so5604343a91.2
        for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2024 20:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733889991; x=1734494791; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STIi1El/hgZv8iTcxtfBoBwVj8bvtZD/5zuA3xW+mgo=;
        b=hGn/kX2fUuw82vCpZqzQHO+thgYUBQUqxok6D0rHytGhGNnnSvUu6o99GGwJ5B2GRQ
         MGrL1AikTHD8iIwJffCRIkV17MCX9g+LtI8uzq8k1zIxQv4Xj7HqFYmw2t6OVujmxFWx
         +KgwyMDkd21hoDRRJD6QrqI/m6TFsJT5w9Bj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733889991; x=1734494791;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STIi1El/hgZv8iTcxtfBoBwVj8bvtZD/5zuA3xW+mgo=;
        b=uZLaHyHxQik/hDFGNnyaA3yqHiiKNPe0CaTkVIkVZgrtK4NnYNv3KS11y9ZuQcS4Vz
         +74yaB1r39UkW7nUbYN3FCc9L3T3OL18tXJK9PZ9q1yOznsaH3kRaHZNiM9gEoNKZ6ml
         UvmEpUo4SD02n8itmjkAJa1EeFk3SFPR7jgSEjxWoUk/zglqfijDjG0iWwYRD0w0vKLj
         bleTdQFrjzHfd69ELSf+BQEDQNh09noU/vhpX2mxq8VE8r+PKrspM0PPkNSXR3A0JXzU
         CEUVR4GfzUJgY/ZV+cA43Bxaz80a+fwcWdFlpRF3LqUvISnk4VAXKZLhjtubvyg1VM8Q
         negw==
X-Gm-Message-State: AOJu0YzH1/LUWqv+Yy+XHPeEghQWYP4mDzcifHHGDOIXFOqE5+EBioKN
	Y1HbQ7cL9dUziwQN4lWhAgW/H9/UDDKG0U1QBUuLp9JIs3BZBJ0y6UgBJyMN3A==
X-Gm-Gg: ASbGncs5BAOZreuZ530oYmz0gOAN5LorRyH6PCBkJHTF8RS8tuHTC+1qS0z5XcdjokQ
	ADMWlnRwII88t++k0+ijA9f+ncLSGjDogKaCveH3hL2bEmYxSqcF5TZBvEBr2RbKkqwwyMlHhLU
	pXY14d6c8UOcnS72rMMiAO4XRwZ2K5C+zkMiiGfJ+K6PNNS/fRydWAhVeUlq4Jzc4ZWynvHsz+R
	e1f/h9bV4ajLxfOeU3FkHH/EVM4SXn9sw7pammKb3zmWFfbCE3GAQrFvLoRCQoRudtB4aOCQSqx
	8dTIud13vN0l05DWHvz8BQG/aW6WWnMIqcvm
X-Google-Smtp-Source: AGHT+IGmrjLd7Ywzfm76oRKS8WmKvNB1ag4zrPNdgPig/y8CPYPZa0KemK/UZNtO9L90PdP/1Vk1rA==
X-Received: by 2002:a17:90b:2d86:b0:2ee:d958:1b18 with SMTP id 98e67ed59e1d1-2f1280dc309mr2200511a91.36.1733889991554;
        Tue, 10 Dec 2024 20:06:31 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef26ffc948sm12477773a91.3.2024.12.10.20.06.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2024 20:06:30 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next 0/5] RDMA/bnxt_re: Minor code cleanups
Date: Tue, 10 Dec 2024 19:45:40 -0800
Message-Id: <1733888745-30939-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Some minor code cleanup for bnxt_re. 

Please review and apply.

Thanks,
Selvin Xavier

Kalesh AP (5):
  RDMA/bnxt_re: Remove extra new line in bnxt_re_netdev_event
  RDMA/bnxt_re: Remove unnecessary goto in bnxt_re_netdev_event
  RDMA/bnxt_re: Optimize error handling in bnxt_re_probe
  RDMA/bnxt_re: Eliminate need for some forward declarations
  RDMA/bnxt_re: Remove unnecessary header file inclusion

 drivers/infiniband/hw/bnxt_re/hw_counters.c |  9 ----
 drivers/infiniband/hw/bnxt_re/ib_verbs.c    |  2 -
 drivers/infiniband/hw/bnxt_re/main.c        | 84 +++++++++++++----------------
 3 files changed, 37 insertions(+), 58 deletions(-)

-- 
2.5.5


