Return-Path: <linux-rdma+bounces-9094-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ADDA78181
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 19:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B9F16C72B
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 17:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED1320E70D;
	Tue,  1 Apr 2025 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzMyRL2w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B6E207662;
	Tue,  1 Apr 2025 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743528549; cv=none; b=f/yH//Gua8rRrvaWyWn+jFA6Fz9he12/wf4UwBsv3i2xhudWymewouIxhLxJUgyTKhHIj6U0a7U0hZ7B5tCL3YGXTwHBVrEGT1KL4RumRqJ7WziEQ7JAD/0nTHw+SlrhVqMOAlYdCM2pxwmn5Jna4PXcyY5hkaLgjMMdbvUL4TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743528549; c=relaxed/simple;
	bh=Om+WYEmu6WcHC36VRjgW4d5CoIyf2PB5RdKLVp5lA2g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aC4EJL6uo0mMMp0fP72pfNoXZVAs99kwArmZdWrcO0W6DwDDKqWJ8RJTc6jpApPexJj+Y5jgYf0IqMrLh3qVY7c7S8HjyLKB3gzcNyHtGs2w4mOz75kZnMlQasBZd5+RIB/+wgSC2CKyLfQ+YAJKW9Ek/wCBDN4H+8U+f7j4X88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzMyRL2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D5AC4CEE4;
	Tue,  1 Apr 2025 17:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743528549;
	bh=Om+WYEmu6WcHC36VRjgW4d5CoIyf2PB5RdKLVp5lA2g=;
	h=Date:From:To:Cc:Subject:From;
	b=hzMyRL2wf38evAdS2iFcXDD4o9myJw+GivAmGtFEMc2sfOfsQLr+SR5SuplsScayL
	 xFLrWQMOM+lWhnkXbPhMoThJ/y1ouvKpX42nPaNNzUvDNlK90TzeCi9GIW3BG/Lb9p
	 rhlm3daBQmBZlVTfjhC8KtlcicCmx4mnSBH1wU+YSHxnoSDvLQeMA32PZ8lkugSO/6
	 xlMCox3N3puCFRDnWI1o8VOU9F365NUDC23azKy6g1a9Bp/K1h0KQ/UWEquG3bAdjT
	 +PdkMAld2yK2IYl/ADs96Qaa8r6ahWUOaBNse8yJLXhL1j1tSEktKQAMW8hQWFTmOj
	 oDhVNs0fn3LbQ==
Date: Tue, 1 Apr 2025 11:29:06 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] IB/hfi1: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <Z-wiYkll8Vo3ME3P@kspp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Remove unused flex-array member `class_data` from
`struct opa_mad_notice_attr`.

Fix the following warning:

drivers/infiniband/hw/hfi1/mad.c:23:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Remove unused flexible array. (Jason)

v1:
 - Link: https://lore.kernel.org/linux-hardening/Z-WgwsCYIXaBxnvs@kspp/

 drivers/infiniband/hw/hfi1/mad.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/mad.h b/drivers/infiniband/hw/hfi1/mad.h
index b6e3141253c4..d6dde762921a 100644
--- a/drivers/infiniband/hw/hfi1/mad.h
+++ b/drivers/infiniband/hw/hfi1/mad.h
@@ -124,7 +124,6 @@ struct opa_mad_notice_attr {
 		} __packed ntc_2048;
 
 	};
-	u8	class_data[];
 };
 
 #define IB_VLARB_LOWPRI_0_31    1
-- 
2.43.0


