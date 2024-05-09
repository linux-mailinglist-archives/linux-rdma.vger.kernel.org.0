Return-Path: <linux-rdma+bounces-2366-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6C88C0D00
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 11:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09141C21119
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 09:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04C714A4DA;
	Thu,  9 May 2024 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhDWojYD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2A114A4DB;
	Thu,  9 May 2024 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245198; cv=none; b=Z8HhEvE+tsjWJg0GGxxth4dEgz+ve0/R5wvDGguUfGM2Th05McypEoWH+JdIx7GoGGSRkmYdTajFRyANe3G12R+sPaSvvTZvexRocerv7ybdjXUBJO3VA+LGAUyD/I0fLF+nYzLcnaUrphXOLk8WQYzQV3fEsNX9O5skRDfsUJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245198; c=relaxed/simple;
	bh=wId5LydJpHj2o6d7NLq6k8n7cZ+wGMXnhD2+b9FaBCw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N6Q+QwSbg655PWJFeltVTeX2MUMCqD6Qv6JvIvAQaW53M8vhi/2o3TpTpXv5Xm8lhFJKaIirVJIwpmjB56QJi9FRkFbZxnS9JZg34dIaZqybmbMfnHDSu326Vmi/84PWjCI897vPeLZkKwkvcgzP8/rqT/eLRsQWBGuRIIbjCYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhDWojYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78ED4C2BBFC;
	Thu,  9 May 2024 08:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715245198;
	bh=wId5LydJpHj2o6d7NLq6k8n7cZ+wGMXnhD2+b9FaBCw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nhDWojYDHF54U5CgJ7GgTazjJEMiX5BEtL3ttbR0w+YpAaGcFLZpmlk3M/8L7hTJL
	 c+4bYmIpdL6xQUicsykAL0aYbjGK0V/q0L3cxl3Du8q89kRTU3m+fQjyjceEDiWYUP
	 nIST64C2d3aG3pQo1y/ch/VyfwEXNbgK6gMVEAP+o0SdW0/XmVPOr6IE6VBW2NKrXu
	 Y42A3eoD/dNbz/Gr0nzGHE9YgPyEJebhBTYamPZGRI0UNZPTD0HyaPtfO9gfDtczxp
	 h6j9Y95nGLXUjUhk6kZztWI0TNgO2MrHiv7IF0kl061sit00AIxK7ZHCmK8A3N+D0C
	 Bw/0mjPuzNcjA==
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Devesh Sharma <devesh.sharma@broadcom.com>, 
 Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>, 
 Michal Schmidt <mschmidt@redhat.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240507103929.30003-1-mschmidt@redhat.com>
References: <20240507103929.30003-1-mschmidt@redhat.com>
Subject: Re: [PATCH] bnxt_re: avoid shift undefined behavior in
 bnxt_qplib_alloc_init_hwq
Message-Id: <171524519355.889134.12469325518934159365.b4-ty@kernel.org>
Date: Thu, 09 May 2024 11:59:53 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Tue, 07 May 2024 12:39:28 +0200, Michal Schmidt wrote:
> Undefined behavior is triggered when bnxt_qplib_alloc_init_hwq is called
> with hwq_attr->aux_depth != 0 and hwq_attr->aux_stride == 0.
> In that case, "roundup_pow_of_two(hwq_attr->aux_stride)" gets called.
> roundup_pow_of_two is documented as undefined for 0.
> 
> Fix it in the one caller that had this combination.
> 
> [...]

Applied, thanks!

[1/1] bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
      https://git.kernel.org/rdma/rdma/c/78cfd17142ef70

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


