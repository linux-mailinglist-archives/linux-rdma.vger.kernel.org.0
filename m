Return-Path: <linux-rdma+bounces-5006-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6410997CB18
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 16:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0FB1C21E69
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 14:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6A919E82C;
	Thu, 19 Sep 2024 14:40:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6031E517;
	Thu, 19 Sep 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726756834; cv=none; b=RtPqCGnMPOqY+l9bBf/3ON4DeyS0O77+9sTJUNVE7OHnAsCCJ9FhC3BhPbumvDl4/3qxw7Fv82tcpaTKIa+Zaq0qK8gnvu718/c4T2tP5VEeAEQX2ACn2gq6Le8hrNGbuppXGv6pPoT3j3mHOaRcoeCP7z1BCvyOZ+rPZI9nI1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726756834; c=relaxed/simple;
	bh=Ah31ROm2SeMIok5Nb3SoHt/vsBHCWwdadjwrzpUsRTo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cqjJyQYUxqKnJ1gjJpNvIrwKOLxgHoiQTwg+Orgm1IsqYKfnYwideVBsytG7LPX5/yBVtZmDjaX8Cgft3cccKzNwCTKcBer9HuLyCYvB8hmOiZ9c0Z2BORA8KM3mTqSEbwJ2dqD3Nu5Wdimkw9M76Y61XcNrAtmYYDhhKB2icHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 19 Sep
 2024 17:40:29 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 19 Sep
 2024 17:40:29 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Steve Wise
	<swise@chelsio.com>, Doug Ledford <dledford@redhat.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-patches@linuxtesting.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2 4.19/5.4/5.10 0/1] RDMA/cxgb4: Fix potential null-ptr-deref in pass_establish()
Date: Thu, 19 Sep 2024 07:40:21 -0700
Message-ID: <20240919144022.14291-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

The following patch aims to fix a possible NULL-ptr-dereference that
occurs if a call to get_ep_from_tid() fails to assign nonzero
value.

Upstream commit 283861a4c52c1ea4df3dd1b6fc75a50796ce3524 has been
backported up to version 5.15. For some reason, older stable branches
have been ignored.

This backport can be cleanly applied to 4.19, 5.4 and 5.10 versions.

v2: Add stable maintainers as patch recepients.

