Return-Path: <linux-rdma+bounces-563-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A228276F9
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 19:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047F2281712
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 18:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4426D54F9E;
	Mon,  8 Jan 2024 18:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkrEO222"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B7556B7A
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jan 2024 18:01:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D376C433C8;
	Mon,  8 Jan 2024 18:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704736904;
	bh=/L1x+M+J+j0AKHYSkoHluTlykWWn77UqjSSvP0ARDT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GkrEO222XVswnGi5gniQ9s07UKFaXDvfgMnraK/yHJ5uujuwS/Qdip0qjQCvR6npt
	 zFpOv712/3dDoUyDnhCSsqtBAHiJVlCw1m8IiGhhpgLah+NzSieuo/i2DrEelZTb5m
	 D9MD0LP/Qt11IN7/01Y3Dv2oam3T8fGebmv+xQKveGGFZzq5xA+ffs+jwpppTWinuI
	 huuWndz1Puvc2bYfYnTRj3GJDq2HoXJP4Ko6yQScNRdypMkwbKSFFsHEJnkJNtmdhO
	 pNauyAV/rCf8VP0Aa6cPDankc1nMNL26FOOyOdIVRVNgSFOZu0qHMH5iHrVxavq3GQ
	 pNTJ6p4jWzBNg==
Date: Mon, 8 Jan 2024 20:01:40 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Margolin <mrgolin@amazon.com>, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Anas Mousa <anasmous@amazon.com>, Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH for-next v4] RDMA/efa: Add EFA query MR support
Message-ID: <20240108180140.GB12803@unreal>
References: <20240104095155.10676-1-mrgolin@amazon.com>
 <20240107100256.GA12803@unreal>
 <20240108130554.GF50406@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108130554.GF50406@nvidia.com>

On Mon, Jan 08, 2024 at 09:05:54AM -0400, Jason Gunthorpe wrote:
> On Sun, Jan 07, 2024 at 12:02:56PM +0200, Leon Romanovsky wrote:
> > On Thu, Jan 04, 2024 at 09:51:55AM +0000, Michael Margolin wrote:
> > > Add EFA driver uapi definitions and register a new query MR method that
> > > currently returns the physical interconnects the device is using to
> > > reach the MR. Update admin definitions and efa-abi accordingly.
> > > 
> > > Reviewed-by: Anas Mousa <anasmous@amazon.com>
> > > Reviewed-by: Firas Jahjah <firasj@amazon.com>
> > > Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> > > ---
> > >  drivers/infiniband/hw/efa/efa.h               | 12 +++-
> > >  .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 33 ++++++++-
> > >  drivers/infiniband/hw/efa/efa_com_cmd.c       | 11 ++-
> > >  drivers/infiniband/hw/efa/efa_com_cmd.h       | 12 +++-
> > >  drivers/infiniband/hw/efa/efa_main.c          |  7 +-
> > >  drivers/infiniband/hw/efa/efa_verbs.c         | 71 ++++++++++++++++++-
> > >  include/uapi/rdma/efa-abi.h                   | 21 +++++-
> > >  7 files changed, 160 insertions(+), 7 deletions(-)
> > 
> > It is already fourth version of this patch and not a single word about
> > the changes. Please add changelog in your next submissions.
> > 
> > Applied this patch with the following change.
> > 
> > diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> > index 8f4435706e4d..2f412db2edcd 100644
> > --- a/drivers/infiniband/hw/efa/efa_verbs.c
> > +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> > @@ -1748,7 +1748,7 @@ static int UVERBS_HANDLER(EFA_IB_METHOD_MR_QUERY)(struct uverbs_attr_bundle *att
> >  {
> >         struct ib_mr *ibmr = uverbs_attr_get_obj(attrs, EFA_IB_ATTR_QUERY_MR_HANDLE);
> >         struct efa_mr *mr = to_emr(ibmr);
> > -       u16 ic_id_validity;
> > +       u16 ic_id_validity = 0;
> >         int ret;
> > 
> >         ret = uverbs_copy_to(attrs, EFA_IB_ATTR_QUERY_MR_RESP_RECV_IC_ID,
> > @@ -1766,12 +1766,12 @@ static int UVERBS_HANDLER(EFA_IB_METHOD_MR_QUERY)(struct uverbs_attr_bundle *att
> >         if (ret)
> >                 return ret;
> > 
> > -       ic_id_validity = (mr->ic_info.recv_ic_id_valid ?
> > -                         EFA_QUERY_MR_VALIDITY_RECV_IC_ID : 0) |
> > -                        (mr->ic_info.rdma_read_ic_id_valid ?
> > -                         EFA_QUERY_MR_VALIDITY_RDMA_READ_IC_ID : 0) |
> > -                        (mr->ic_info.rdma_recv_ic_id_valid ?
> > -                         EFA_QUERY_MR_VALIDITY_RDMA_RECV_IC_ID : 0);
> > +       if (mr->ic_info.recv_ic_id_valid)
> > +               ic_id_validity |= EFA_QUERY_MR_VALIDITY_RECV_IC_ID;
> > +       if (mr->ic_info.rdma_read_ic_id_valid)
> > +               ic_id_validity |= EFA_QUERY_MR_VALIDITY_RDMA_READ_IC_ID;
> > +       if (mr->ic_info.rdma_recv_ic_id_valid)
> > +               ic_id_validity |= EFA_QUERY_MR_VALIDITY_RDMA_RECV_IC_ID;
> 
> I was saying in the rdma-core PR that this field shouldn't even
> exist..

Something like that?

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 2f412db2edcd..97619b29afe0 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1748,33 +1748,29 @@ static int UVERBS_HANDLER(EFA_IB_METHOD_MR_QUERY)(struct uverbs_attr_bundle *att
 {
 	struct ib_mr *ibmr = uverbs_attr_get_obj(attrs, EFA_IB_ATTR_QUERY_MR_HANDLE);
 	struct efa_mr *mr = to_emr(ibmr);
-	u16 ic_id_validity = 0;
 	int ret;
 
-	ret = uverbs_copy_to(attrs, EFA_IB_ATTR_QUERY_MR_RESP_RECV_IC_ID,
-			     &mr->ic_info.recv_ic_id, sizeof(mr->ic_info.recv_ic_id));
-	if (ret)
-		return ret;
-
-	ret = uverbs_copy_to(attrs, EFA_IB_ATTR_QUERY_MR_RESP_RDMA_READ_IC_ID,
-			     &mr->ic_info.rdma_read_ic_id, sizeof(mr->ic_info.rdma_read_ic_id));
-	if (ret)
-		return ret;
-
-	ret = uverbs_copy_to(attrs, EFA_IB_ATTR_QUERY_MR_RESP_RDMA_RECV_IC_ID,
-			     &mr->ic_info.rdma_recv_ic_id, sizeof(mr->ic_info.rdma_recv_ic_id));
-	if (ret)
-		return ret;
+	if (mr->ic_info.recv_ic_id_valid) {
+		ret = uverbs_copy_to(attrs, EFA_IB_ATTR_QUERY_MR_RESP_RECV_IC_ID,
+				     &mr->ic_info.recv_ic_id, sizeof(mr->ic_info.recv_ic_id));
+		if (ret)
+			return ret;
+	}
 
-	if (mr->ic_info.recv_ic_id_valid)
-		ic_id_validity |= EFA_QUERY_MR_VALIDITY_RECV_IC_ID;
-	if (mr->ic_info.rdma_read_ic_id_valid)
-		ic_id_validity |= EFA_QUERY_MR_VALIDITY_RDMA_READ_IC_ID;
-	if (mr->ic_info.rdma_recv_ic_id_valid)
-		ic_id_validity |= EFA_QUERY_MR_VALIDITY_RDMA_RECV_IC_ID;
+	if (mr->ic_info.rdma_read_ic_id_valid) {
+		ret = uverbs_copy_to(attrs, EFA_IB_ATTR_QUERY_MR_RESP_RDMA_READ_IC_ID,
+				     &mr->ic_info.rdma_read_ic_id, sizeof(mr->ic_info.rdma_read_ic_id));
+		if (ret)
+			return ret;
+	}
 
-	return uverbs_copy_to(attrs, EFA_IB_ATTR_QUERY_MR_RESP_IC_ID_VALIDITY,
-			      &ic_id_validity, sizeof(ic_id_validity));
+	if (mr->ic_info.rdma_recv_ic_id_valid) {
+		ret = uverbs_copy_to(attrs, EFA_IB_ATTR_QUERY_MR_RESP_RDMA_RECV_IC_ID,
+				     &mr->ic_info.rdma_recv_ic_id, sizeof(mr->ic_info.rdma_recv_ic_id));
+		if (ret)
+			return ret;
+	}
+	return 0;
 }
 
 int efa_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
@@ -2204,18 +2200,15 @@ DECLARE_UVERBS_NAMED_METHOD(EFA_IB_METHOD_MR_QUERY,
 					    UVERBS_OBJECT_MR,
 					    UVERBS_ACCESS_READ,
 					    UA_MANDATORY),
-			    UVERBS_ATTR_PTR_OUT(EFA_IB_ATTR_QUERY_MR_RESP_IC_ID_VALIDITY,
-						UVERBS_ATTR_TYPE(u16),
-						UA_MANDATORY),
 			    UVERBS_ATTR_PTR_OUT(EFA_IB_ATTR_QUERY_MR_RESP_RECV_IC_ID,
 						UVERBS_ATTR_TYPE(u16),
-						UA_MANDATORY),
+						UA_OPTIONAL),
 			    UVERBS_ATTR_PTR_OUT(EFA_IB_ATTR_QUERY_MR_RESP_RDMA_READ_IC_ID,
 						UVERBS_ATTR_TYPE(u16),
-						UA_MANDATORY),
+						UA_OPTIONAL),
 			    UVERBS_ATTR_PTR_OUT(EFA_IB_ATTR_QUERY_MR_RESP_RDMA_RECV_IC_ID,
 						UVERBS_ATTR_TYPE(u16),
-						UA_MANDATORY));
+						UA_OPTIONAL));
 
 ADD_UVERBS_METHODS(efa_mr,
 		   UVERBS_OBJECT_MR,
diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
index 701e2d567e41..fbe5936e22cd 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -143,7 +143,6 @@ enum {
 
 enum efa_query_mr_attrs {
 	EFA_IB_ATTR_QUERY_MR_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
-	EFA_IB_ATTR_QUERY_MR_RESP_IC_ID_VALIDITY,
 	EFA_IB_ATTR_QUERY_MR_RESP_RECV_IC_ID,
 	EFA_IB_ATTR_QUERY_MR_RESP_RDMA_READ_IC_ID,
 	EFA_IB_ATTR_QUERY_MR_RESP_RDMA_RECV_IC_ID,

