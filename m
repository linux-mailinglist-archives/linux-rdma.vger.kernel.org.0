Return-Path: <linux-rdma+bounces-549-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F9A8263B2
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jan 2024 11:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7A71C2145E
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jan 2024 10:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAB212B7F;
	Sun,  7 Jan 2024 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIC9q2Cl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C020012B7A
	for <linux-rdma@vger.kernel.org>; Sun,  7 Jan 2024 10:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9977C433C8;
	Sun,  7 Jan 2024 10:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704621781;
	bh=AA9QV1dHNbBXCkDwzYyQJOJfFrdJKxRC9iQhuT44JnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UIC9q2ClXD8NOIMnlodae+lirSUphwnkHaRlUqp/NRFTvWh8fXOIYiXe2SlGL+Ign
	 qmMUffGAjl9rcOKkHwvZ50Ppm5mQItvPKZrh6j9aTxGcftF+VQBMz1sdCg6yDDMVg0
	 gqHZ+jtkZrSiB6HsiRETaC//legQ3ebKy5cPlJsMEHhYgVR3ns2cgw/1+NmMUDSrHL
	 IXy9N1uJMO1J7O/is8yY802Zd7ToSW+38PrjKh1g9LQvfyzFX2PlD/xFN6HTWPObM6
	 tzxK+oqqwMgOOiSiiWY7qSx6w3rPoP/cL7bP/HIc1i043FJdPIXvToSutQgr3QZ6lp
	 zROTvT88C6Vmw==
Date: Sun, 7 Jan 2024 12:02:56 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Michael Margolin <mrgolin@amazon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	Anas Mousa <anasmous@amazon.com>, Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH for-next v4] RDMA/efa: Add EFA query MR support
Message-ID: <20240107100256.GA12803@unreal>
References: <20240104095155.10676-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104095155.10676-1-mrgolin@amazon.com>

On Thu, Jan 04, 2024 at 09:51:55AM +0000, Michael Margolin wrote:
> Add EFA driver uapi definitions and register a new query MR method that
> currently returns the physical interconnects the device is using to
> reach the MR. Update admin definitions and efa-abi accordingly.
> 
> Reviewed-by: Anas Mousa <anasmous@amazon.com>
> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa.h               | 12 +++-
>  .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 33 ++++++++-
>  drivers/infiniband/hw/efa/efa_com_cmd.c       | 11 ++-
>  drivers/infiniband/hw/efa/efa_com_cmd.h       | 12 +++-
>  drivers/infiniband/hw/efa/efa_main.c          |  7 +-
>  drivers/infiniband/hw/efa/efa_verbs.c         | 71 ++++++++++++++++++-
>  include/uapi/rdma/efa-abi.h                   | 21 +++++-
>  7 files changed, 160 insertions(+), 7 deletions(-)

It is already fourth version of this patch and not a single word about
the changes. Please add changelog in your next submissions.

Applied this patch with the following change.

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 8f4435706e4d..2f412db2edcd 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1748,7 +1748,7 @@ static int UVERBS_HANDLER(EFA_IB_METHOD_MR_QUERY)(struct uverbs_attr_bundle *att
 {
        struct ib_mr *ibmr = uverbs_attr_get_obj(attrs, EFA_IB_ATTR_QUERY_MR_HANDLE);
        struct efa_mr *mr = to_emr(ibmr);
-       u16 ic_id_validity;
+       u16 ic_id_validity = 0;
        int ret;

        ret = uverbs_copy_to(attrs, EFA_IB_ATTR_QUERY_MR_RESP_RECV_IC_ID,
@@ -1766,12 +1766,12 @@ static int UVERBS_HANDLER(EFA_IB_METHOD_MR_QUERY)(struct uverbs_attr_bundle *att
        if (ret)
                return ret;

-       ic_id_validity = (mr->ic_info.recv_ic_id_valid ?
-                         EFA_QUERY_MR_VALIDITY_RECV_IC_ID : 0) |
-                        (mr->ic_info.rdma_read_ic_id_valid ?
-                         EFA_QUERY_MR_VALIDITY_RDMA_READ_IC_ID : 0) |
-                        (mr->ic_info.rdma_recv_ic_id_valid ?
-                         EFA_QUERY_MR_VALIDITY_RDMA_RECV_IC_ID : 0);
+       if (mr->ic_info.recv_ic_id_valid)
+               ic_id_validity |= EFA_QUERY_MR_VALIDITY_RECV_IC_ID;
+       if (mr->ic_info.rdma_read_ic_id_valid)
+               ic_id_validity |= EFA_QUERY_MR_VALIDITY_RDMA_READ_IC_ID;
+       if (mr->ic_info.rdma_recv_ic_id_valid)
+               ic_id_validity |= EFA_QUERY_MR_VALIDITY_RDMA_RECV_IC_ID;

        return uverbs_copy_to(attrs, EFA_IB_ATTR_QUERY_MR_RESP_IC_ID_VALIDITY,
                              &ic_id_validity, sizeof(ic_id_validity));

