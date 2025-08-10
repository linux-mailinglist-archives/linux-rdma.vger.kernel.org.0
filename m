Return-Path: <linux-rdma+bounces-12649-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 693E1B1FBB3
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 20:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A94162859
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 18:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1718E2727E6;
	Sun, 10 Aug 2025 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VxZFI/yz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAC918C933;
	Sun, 10 Aug 2025 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754850477; cv=none; b=o6n1zElH1dKSIvNnwPttV8oBMzRiEqPE1Uh7gK7uuj+1bAmEttmnv9hbtq+eKerrT84UVTMTXEqHxqyBcGOtei1qzRr/qVrDIqE9hJzO4HohtGgD9KwGvbBi/9jFW99zckU7wp5qNeDEiiaXcS3UR66xO21c7ChGNbpJO0LK7lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754850477; c=relaxed/simple;
	bh=Chf5vZfJTlSUeF7Zp09INTZxoB9ozgmqN97YzZnCAgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGz2kieQqYtCbBrKqm5wQwmbv/MI2FwlOLIOsGTMBtkg8CMhKvKnEH06ETLjhnwYciPuStnjNf/x+M7mkLz+7Ovpd2IdAYLB5AwixvdEA6J32tEHVS+D7tz17mpmR6bF5wSakEoJz80Pcl5OTXT9JrNKh+hd2FUGFHIHnWDlDBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VxZFI/yz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZuOcuE0qvw2SZroUFnKL6SVWavIZnk5WBLZ9gVUuY7E=; b=VxZFI/yz8oEOwAB6G6JMXGlK05
	zNBucBAUpdK49s1/fbMGwBiYWVkNCA1J4rsyakKluxfKI2jmsXLKZvlYinAMIsDmzDNUfY6MoguuF
	acR+1fLAUBOqRVa3DmvzQPo6Zy3vHQzoafrKmt+CRMdOP8eEQ1fh/s3db1ipkKmciyrZCeA9prsxj
	OqB4ZGZBoTlXxKmhh75CnwfQkTdL///SWVSRflp9vpLkLgf47SQ18TBil+RWmw3uw6YrCYe5qxmxm
	ltXWfo43KN+HSVT4WjjcTFTBifNJ2jI1En4D/chXz9RGt5ofzIkKMuWT2hMBMOy+/rB1IjMjP5qm2
	7gfhqEQw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulAls-00000009MDE-0eE6;
	Sun, 10 Aug 2025 18:27:52 +0000
Date: Sun, 10 Aug 2025 19:27:52 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ujwal Kundur <ujwal.kundur@gmail.com>, g@zeniv.linux.org.uk
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rds: Fix endian annotations across various
 assignments
Message-ID: <20250810182752.GM222315@ZenIV>
References: <20250810171155.3263-1-ujwal.kundur@gmail.com>
 <20250810174705.GK222315@ZenIV>
 <20250810182506.GL222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810182506.GL222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Aug 10, 2025 at 07:25:06PM +0100, Al Viro wrote:
> On Sun, Aug 10, 2025 at 06:47:05PM +0100, Al Viro wrote:
> 
> > >  		switch (type) {
> > >  		case RDS_EXTHDR_NPATHS:
> > >  			conn->c_npaths = min_t(int, RDS_MPATH_WORKERS,
> > > -					       be16_to_cpu(buffer.rds_npaths));
> > > +					      (__force __u16)buffer.rds_npaths);
> > 
> > No.  It will break on little-endian.  That's over-the-wire data you are
> > dealing with; it's *NOT* going to be host-endian.  Fix the buggered
> > annotations instead.
> 
> PS: be16_to_cpu() is not the same thing as a cast.  On a big-endian box,
> a 16bit number 1000 (0x3e8) is stored as {3, 0xe8}; on a little-endian it's
> {3, 0xe8} instead; {0xe8, 3} means 59395 there (0xe8 * 256 + 3).
  ^^^^^^^^           ^^^^^^^^^
  {0xe8, 3}          {3, 0xe8}

Sorry, buggered editing.

