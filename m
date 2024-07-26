Return-Path: <linux-rdma+bounces-4016-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E154E93D518
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 16:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D4C3B2321C
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 14:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE75E168C7;
	Fri, 26 Jul 2024 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fL6vwMll"
X-Original-To: linux-rdma@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497C410A1C;
	Fri, 26 Jul 2024 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004073; cv=none; b=YfOJROrldIj2wB0eTkMWhppDYVZ7WrFw6YgpS04xfZ3MNx5QOg4E/6ATKCCK0d70JR0kyt0XaE+AtdCQZ/6ytlnbMpYDDciZGkXGxwZvN2f3rqnLoMM2DkNJ6zHwVrRWK4pC9F2h5WDh08LCwOpgn9h8T3FEvRR49nq6TsXf7LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004073; c=relaxed/simple;
	bh=3K+N/WHbXjjnH8pnbfRV/+Az398N9drgCA+VrJy1wpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S749mHJ6ZIMVSrAyUkirP7D55UCAsUs7F5s3/g5DNqOyFRrRaBMp/oG7lovkcBQGdusq3MTus+gMFq5c9bJoiRbZzAVNrD0iMSBytdKuiwcMKNSyDjKJGB8ThGgEBMa4tBY0La/+zlaqK7/DTzApVaf3zB0wMqMRz1Duv5zg2ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=fL6vwMll; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6AC858CC;
	Fri, 26 Jul 2024 16:27:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1722004026;
	bh=3K+N/WHbXjjnH8pnbfRV/+Az398N9drgCA+VrJy1wpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fL6vwMllu5ElFtSMQ64fANuvmD2nXXEOCP1rDmMo+bjnq8592hefrpPNFjEOUPIeU
	 Vk/aqvkCp8wwBv7N2I68LR0yl4x6ipQVgCxJiAogaWThv0t0leAdMtNgVfpr7ABYDj
	 X3eO/lDMH88pQkCEJfJ2kdaqEFmN9zit8Q99rGX8=
Date: Fri, 26 Jul 2024 17:27:31 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240726142731.GG28621@pendragon.ideasonboard.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>

I know this is a topic proposed for the maintainers summit, but given
the number of people who seem to have an opinion and be interested in
dicussing it, would a session at LPC be a better candidate ? I don't
expect the maintainer summit to invite all relevant experts from all
subsystems, that would likely overflow the room.

The downside of an LPC session is that it could easily turn into a
heated stage fight, and there are probably also quite a few arguments
that can't really be made in the open :-S

-- 
Regards,

Laurent Pinchart

