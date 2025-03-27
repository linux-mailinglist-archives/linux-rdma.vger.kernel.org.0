Return-Path: <linux-rdma+bounces-9014-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C20AA73E4E
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Mar 2025 20:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF53317A97E
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Mar 2025 19:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730951C1F05;
	Thu, 27 Mar 2025 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ads8pB1e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2A82914;
	Thu, 27 Mar 2025 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743102149; cv=none; b=ThKyXR2hBs1+U5QXLV5tCMbQLS4wcetYRqXoXzGmMBpCLkYdgbr32e8qaDD9ZUnzR2HxXkw8XKPTbPEQAglKYMhBFxVeJQ534LT/EVj/lMebzdO3iJh/x3ScXxZF/GHrhozmJYY8CZ5x5xwxXohXxeUuI68Ht/KONyVLREak1sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743102149; c=relaxed/simple;
	bh=NcEipiXRDPNIQvSQYCxxP64XpMs62RHs2rr65kOqoro=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I6XzrTvlaBkp3VzAAHOiia9pvX8mW4l7aKMXpk6MI4maXF6ZKIfINpcTa4IjvPhJlzPrKs+zCupTo3r75Y/1VVAP2wN6dGYhNpOqCm8wnzc3K4EGEP70j40Sa+xma1Hyv68jeIlKJ09zRXeoB81gF7yB4ywW6Ajm7iq4t37jYJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ads8pB1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCB0C4CEDD;
	Thu, 27 Mar 2025 19:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743102148;
	bh=NcEipiXRDPNIQvSQYCxxP64XpMs62RHs2rr65kOqoro=;
	h=Date:From:To:Cc:Subject:From;
	b=ads8pB1eJeByNThL5P+xLR0hPgwdnmWxmo5EOyVP6BTo9EsaBZL5LfHbeWhuITbnw
	 l6uD5x3z0KmQ3sKFOm7Odb3EQX+Ss6STAgoDOlFV95pL6e1PG5UFRw5eY+C1lMhtFH
	 53zr9jgJUgFUvq9hdircKNmW1iddE9fplRCI8OHBDxUD8ZUPXRiCopO8f5FzpQUYKU
	 ishY5+nqaGF/dk1Ae4g+r3NNZZhk2IM809N1ymclwudg1Vob+IXUSZfgKE+PSoDffM
	 QT/bI9XU78KqJszXKPfFBtanW5+FtdzVC2kSxol/izfArXvE0KDEIj7kXiAJS8iyoQ
	 c/F81Az6kEAlg==
Date: Thu, 27 Mar 2025 13:02:26 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] IB/hfi1: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <Z-WgwsCYIXaBxnvs@kspp>
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

Move the conflicting declaration to the end of the structure. Notice
that `struct opa_mad_notice_attr` is a flexible structure --a structure
that contains a flexible-array member.

Fix the following warning:

drivers/infiniband/hw/hfi1/mad.c:23:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/infiniband/hw/hfi1/mad.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/mad.c b/drivers/infiniband/hw/hfi1/mad.c
index b39f63ce6dfc..3f11a90819d1 100644
--- a/drivers/infiniband/hw/hfi1/mad.c
+++ b/drivers/infiniband/hw/hfi1/mad.c
@@ -20,12 +20,14 @@
 
 struct trap_node {
 	struct list_head list;
-	struct opa_mad_notice_attr data;
 	__be64 tid;
 	int len;
 	u32 retry;
 	u8 in_use;
 	u8 repress;
+
+	/* Must be last --ends in a flexible-array member. */
+	struct opa_mad_notice_attr data;
 };
 
 static int smp_length_check(u32 data_size, u32 request_len)
-- 
2.43.0


