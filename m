Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6522BB2C5
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Nov 2020 19:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgKTSZW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Nov 2020 13:25:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbgKTSZW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Nov 2020 13:25:22 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFCD824124;
        Fri, 20 Nov 2020 18:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605896721;
        bh=pf6kfPHaE4HzxEiOc7dj5m5zf+4ABXtrZUmxTrBrs64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vGhM8XQ8zi1783KAgnAwvuVBBc93CvB158cTTQNqnhyjy+Q/EUYe806GD2IufmK33
         npmPDfMra03ksYPRSPi5C/+6jncNTP7GP8vmA/igOvMEKEFVHpF0yTrnb0BepJSgdA
         tqd0Bsk5AjeSaxSRN+G7YbmKxbM33CGZft9cXGBY=
Date:   Fri, 20 Nov 2020 12:25:27 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 008/141] IB/hfi1: Fix fall-through warnings for Clang
Message-ID: <13cc2fe2cf8a71a778dbb3d996b07f5e5d04fd40.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
warnings by explicitly adding multiple break statements instead of just
letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/infiniband/hw/hfi1/qp.c       | 1 +
 drivers/infiniband/hw/hfi1/tid_rdma.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/qp.c b/drivers/infiniband/hw/hfi1/qp.c
index 356518e17fa6..681bb4e918c9 100644
--- a/drivers/infiniband/hw/hfi1/qp.c
+++ b/drivers/infiniband/hw/hfi1/qp.c
@@ -339,6 +339,7 @@ int hfi1_setup_wqe(struct rvt_qp *qp, struct rvt_swqe *wqe, bool *call_send)
 			return -EINVAL;
 		if (ibp->sl_to_sc[rdma_ah_get_sl(&ah->attr)] == 0xf)
 			return -EINVAL;
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
index 73d197e21730..92aa2a9b3b5a 100644
--- a/drivers/infiniband/hw/hfi1/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
@@ -2826,6 +2826,7 @@ static bool handle_read_kdeth_eflags(struct hfi1_ctxtdata *rcd,
 		default:
 			break;
 		}
+		break;
 	default:
 		break;
 	}
@@ -3005,6 +3006,7 @@ bool hfi1_handle_kdeth_eflags(struct hfi1_ctxtdata *rcd,
 		default:
 			break;
 		}
+		break;
 	default:
 		break;
 	}
@@ -3221,6 +3223,7 @@ bool hfi1_tid_rdma_wqe_interlock(struct rvt_qp *qp, struct rvt_swqe *wqe)
 			req = wqe_to_tid_req(prev);
 			if (req->ack_seg != req->total_segs)
 				goto interlock;
+			break;
 		default:
 			break;
 		}
@@ -3239,9 +3242,11 @@ bool hfi1_tid_rdma_wqe_interlock(struct rvt_qp *qp, struct rvt_swqe *wqe)
 			req = wqe_to_tid_req(prev);
 			if (req->ack_seg != req->total_segs)
 				goto interlock;
+			break;
 		default:
 			break;
 		}
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

