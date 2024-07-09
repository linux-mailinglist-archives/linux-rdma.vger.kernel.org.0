Return-Path: <linux-rdma+bounces-3757-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD16092AFD1
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 08:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DCF9B21BD1
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 06:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E9513211C;
	Tue,  9 Jul 2024 06:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aWeNn4Sv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E0D12C52F;
	Tue,  9 Jul 2024 06:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720505383; cv=none; b=jQHj1H1NgDnjY1KZu0w6tLekzUSAEUiRQ4P2H9HmLsh0gHmRfFresdjBkYBr8EEjTITIjAnZ4R1bykvaplN4+wCjeQuCfVdeia6yUGvAstAQWWXZjDLyZzX/ouTuMOAesaiwqLvkUnv+bHuFOVtsrQ9GXUUc83L62ckBI7zy9So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720505383; c=relaxed/simple;
	bh=FO/e6sfjH8/QAUa41deJXp8jfrL365o1V/w4bikvz/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTyEwcGa6r8H3VtIbnXZEjr9q4lxklc8lY4rq1NNoUYntZXobHdUCbAmBZEHo8wIWy86XxVY1ST7cHK9pXZwYkIRQRgGKBJYxYePr1nRO//geAyUyMac5G0ReNAF/J9+2Oq9Zyq9+yos6p6fEesxHKBhtxq1aCSaUdE+KNFnyVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aWeNn4Sv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sl47jH5hsCNX2lI/FbDxlZ/pLUml99/KsZPpS5ibLgA=; b=aWeNn4SvV3oPmk3OO0U3RCNuQy
	KdKA+6lBgs/YY6hKVbZdnWawkd1n2WLes9tJL2ZJd8AniZgEo7tt3Yjto211xN9H8UXAGMayeGBf9
	lW+PHVRBlw9Vxt01G90QqxpmJWklB4cG9lN7SDubWUy1YG9nvVit/jhyNHANCjzSEeRoHmS0maV5Y
	OpGrBlD2uxYX9QmRqem8PNPruAUFMFEghYPjI/uJPVJn1vwibSPkbvZYdmwhXt1w/SJD4zEa+Vb5H
	kmxfOJ0xajHBfnzJSG50nMakl/FGRP/jAV5MbgpTyUoUpalj0KGXoahx08mcqtaMqWcSFmZDd40wF
	6aCD+o5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR42n-000000061O2-2QHu;
	Tue, 09 Jul 2024 06:09:41 +0000
Date: Mon, 8 Jul 2024 23:09:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <ZozUJepl9_gnKnlv@infradead.org>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Passthrough in general is useful, but the problem is that protocols
aren't designed with it in mind.  Look at the list of command that
affect too much state and we have to block in SCSI and NVMe.  And
in NVMe I'm fighting a constant fight in the technical working group
to not add new command that instantly disable the access control we've
built into NVMe passthrough.   So IMHO passthrough can be good idea,
but only if the protocol is designed for it, and protocol designer
generally have a hard time how software works at all, never mind
the futuristic concepts of layering, abstraction and access control.


