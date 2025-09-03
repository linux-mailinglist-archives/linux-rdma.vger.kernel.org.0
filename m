Return-Path: <linux-rdma+bounces-13070-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B0DB42763
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 18:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D491F17F2D8
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 16:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725173126BF;
	Wed,  3 Sep 2025 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Um53eHRv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70DE5C96;
	Wed,  3 Sep 2025 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918619; cv=none; b=uGicHhvfFQjBJthFrcFIPDM0FyqO/6NYcjCuhpkV4628WQwhTnU35Q8JulQs/9tiz0cWu8TO9dQGcS/t0JqhbB1eYV+RwzZvJab1cHyjsOwRORWSjY5Wc6XgYsQpZmkWQ6LSXiqL4IxOLw0wnwDGoi0dBDC+P+XNHBf5D1ONQR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918619; c=relaxed/simple;
	bh=QiYajCeX5zYm3JFjT/360LOEa9NzPD+APMFmmBjZjag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkrzFqpLxbE2MAPXS9TlvdO+H3x+vbnUoGhTk8Jar6YqyZkSYCqT5GZuzzhIFkOIvcM2ca1b718ibDQrpiPOJyPDshGmjJ+H3uyUnkrw4ViSwvP9N8Tstio9H9H4bhxMWvm4u2EfVCzEIe0lDdceCj8kjgeTx5g6vmga6llLZaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Um53eHRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088A2C4CEE7;
	Wed,  3 Sep 2025 16:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756918618;
	bh=QiYajCeX5zYm3JFjT/360LOEa9NzPD+APMFmmBjZjag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Um53eHRv3gZM/O/7UM/zQjLeFHCJyboqUqS/V/0hHLLPaoLDmy5BAEBsvMPNxCU/J
	 YioJmEVtF+NsXOS+PLwAUmCq/QYeGJjMFRdVqj7uknqHEjdbiGRGkM4l064VBebIsX
	 n0pT/fhFTvqsmB5Kv7UQKmHouPr4dWFO538IzQXg=
Date: Wed, 3 Sep 2025 18:56:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Allison Henderson <allison.henderson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	OFED mailing list <linux-rdma@vger.kernel.org>,
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] rds: ib: Remove unused extern definition
Message-ID: <2025090314-corporate-yanking-e1b1@gregkh>
References: <20250903163140.3864215-1-haakon.bugge@oracle.com>
 <20250903163140.3864215-2-haakon.bugge@oracle.com>
 <2025090340-rejoicing-kleenex-c29d@gregkh>
 <1D680271-B2DF-4CAB-A91D-4577CA6861E8@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1D680271-B2DF-4CAB-A91D-4577CA6861E8@oracle.com>

On Wed, Sep 03, 2025 at 04:51:01PM +0000, Haakon Bugge wrote:
> 
> 
> > On 3 Sep 2025, at 18:38, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > On Wed, Sep 03, 2025 at 06:31:37PM +0200, Håkon Bugge wrote:
> >> Fixes: 2cb2912d6563 ("RDS: IB: add Fastreg MR (FRMR) detection support")
> >> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> >> ---
> >> net/rds/ib_mr.h | 1 -
> >> 1 file changed, 1 deletion(-)
> > 
> > I know I can't take patches without any changelog text, but maybe other
> > maintainer are more lax :)
> 
> You mean the empty commit message? Did pass checkpatch.pl --strict though.

checkpatch is a hint.  What would you want to see if you were a reviewer?

